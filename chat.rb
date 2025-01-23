# Write your solution here!

require "openai" 
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPEN_AI"))

#set the message up with a system 
message_list = [
  {
  "role" => "system", 
  "content" => "You're a helpful assistant" 
  }
]

#start the conversation loop 
user_input = "" 

#loop until user inputs bye! 
while user_input != "bye"
  puts "Hello, how can I help you today?" 
  puts "" * 50  

#get user input 
  user_input = gets.chomp 

#add user's message to message list 
  if user_input != "bye" 
    message_list = [
      {
        "role" => "system", 
        "content" => user_input
      }
    ]

    #send message list to API 
    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo", 
        messages: message_list
      }
    )

    #dig through JSON response to get content 
    choices = api_response.fetch("choices")
    first_choice = choices.at(0) 
    message = first_choice.fetch("message") 
    assistant_response = message["content"] 

    #print assistant's response 
    puts assistant_response 
    puts "-" * 50 

    #add assistant's response to message list 
    message_list.push({"role" => "assistant", "content" => assistant_response})
    end 
  end 
  
  puts "Goodbye! Have a great day!" 

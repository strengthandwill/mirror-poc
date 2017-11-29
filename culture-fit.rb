require 'rubygems'
require 'json'
require 'rest-client'
require 'byebug'

hiring = [
  'dog',
  'eating',
  'sausage',
  'culture',
  'company',
  'open',
  'fast',
  'pace',
  'direct',
  'driven',
  'performance',
  'Finance',
  'team',
  'company',
  'Asia',
  'Pacific',
  'China',
  'India',
  'Japan',
  'micro',
  'manager',
  'detailed',
  'oriented',
  'team',
  'goals',
  'pride',
  'business',
  'FP&A',
  'operational',
  'part',
  'Finance',
  'Ledger',
  'AR',
  'AP',
  'role',
  'team',
  'business',
  'partnering',
  'team',
  'finance',
  'operations',
  'Asia',
  'Pacific',
  'time',
  'team',
  'lean',
  'right',
  'model',
  'business',
  'someone',
  'able',
  'strategy',
  'stakeholders',
  'team'
]

candidate1 = [
  'many',
  'years',
  'audit',
  'big',
  'Fresh',
  'Grad',
  'years',
  'managerial',
  'position',
  'team',
  'auditing',
  'companies',
  'Asia',
  'Pacific',
  'time',
  'driven',
  'success',
  'goal',
  'front',
  'next',
  'role',
  'keen',
  'FP&A',
  'role',
  'big',
  'MNC',
  'finance',
  'knowledge',
  'audit'
]

candidate2 = [
  'detailed',
  'oriented',
  'career',
  'Finance',
  'operations',
  'books',
  'AR',
  'AP',
  'payments',
  'team',
  'next',
  'role',
  'opportunity',
  'finance',
  'operations',
  'Singapore',
  'scope',
  'regional',
  'remit',
  'open',
  'single',
  'mobile'
]

def write_file(filename, words)
  hash = Hash.new
  words.each do |w|
    word = w.downcase
    puts "Checking #{word}.."
    begin
      response = RestClient.get "http://words.bighugelabs.com/api/2/6d11e7c71f3704ec19fdb4a1acc3ce57/#{word}/json"
      json = JSON.parse(response.body)
      hash[word] = json
    rescue Exception => e
      hash[word] = {}
    end
  end
  File.open("#{filename}.json", 'w') { |file| file.write(hash.to_json) }
end

def read_hash(filename)
  hash = Hash.new
  json = read_file(filename)
  json.each do |element|
    hash[element[0]] = [ element[0] ]
    if element[1]['adjective'].nil?
      unless element[1]['noun'].nil?
        hash[element[0]] += element[1]['noun']['syn']
      end
    else
      unless element[1]['adjective']['syn'].nil?
        hash[element[0]] += element[1]['adjective']['syn']
      end
    end
  end
  hash
end

def read_file(filename)
  JSON.parse(File.read("#{filename}.json"))
end

# puts "[#{Time.now.to_s}][hiring]"
# write_file('hiring', hiring)
# puts "[#{Time.now.to_s}][candidate1]"
# write_file('candidate1', candidate1)
# puts "[#{Time.now.to_s}][candidate2]"
# write_file('candidate2', candidate2)
# puts "[#{Time.now.to_s}][terminated]"

byebug
byebug
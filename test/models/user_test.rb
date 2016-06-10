require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User",
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
  
  test "name should be 50 chars or fewer" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "email should be 255 chars or fewer" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "validation should accept valid emails" do
    valid_emails = %w[foo@bar.com USER@web1.jp A_US-ER@foo.bar.org z.o.o@buzz.io alice+BOB@m.reddit.ORG]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end
  
  test "validation should reject invalid emails" do
    invalid_email = "webcat@nope..com"
    @user.email = invalid_email
    assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
  end
  
  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should be 6 chars or more" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  
end

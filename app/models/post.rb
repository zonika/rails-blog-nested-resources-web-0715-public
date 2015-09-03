class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_tags
  has_many :tags, :through => :post_tags
  accepts_nested_attributes_for :tags, reject_if: lambda {|attributes| attributes['name'].blank?}
  validates_presence_of :name, :content
  has_many :comments

  after_destroy :delete_comments

  private
  def delete_comments
    comments.each do |comment|
      comment.destroy
    end
  end
end

class ListsController < ApplicationController

  def new
    @list = List.new
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    # local var bcuz view dnt use it, update action then redirect
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  # 以下を追加
  def create
    # # １.&2. データを受け取り新規登録するためのインスタンス作成
    # list = List.new(list_params)
    # # 3. データをデータベースに保存するためのsaveメソッド実行
    # list.save
    # # 4. トップ画面へリダイレクト
    # redirect_to list_path(list.id)
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list.id) # if true -> list id
    else
      render :new # if false -> same form and need to do again
    end
  end

  def destroy
    list = List.find(params[:id]) #find data from id
    list.destroy        #delete record
    redirect_to '/lists' #return to list
  end

  private
  # ストロングパラメータ permit(:allow only these colum ONLY) 
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end

end
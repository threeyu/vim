" =============================================================================
"        << �жϲ���ϵͳ�� Windows ���� Linux ���ж����ն˻��� Gvim >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < �жϲ���ϵͳ�Ƿ��� Windows ���� Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif
 
" -----------------------------------------------------------------------------
"  < �ж����ն˻��� Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
 
 
" =============================================================================
"                          << ����Ϊ���Ĭ������ >>
" =============================================================================
 
" -----------------------------------------------------------------------------
"  < Windows Gvim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()
 
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif
 
" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if g:islinux
    set hlsearch        "��������
    set incsearch       "������Ҫ����������ʱ��ʵʱƥ��
 
    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
 
    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim
 
        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif
 
        set mouse=a                    " ���κ�ģʽ���������
        set t_Co=256                   " ���ն�����256ɫ
        set backspace=2                " �����˸������
 
        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif

" =============================================================================
"                          << ����Ϊ�û��Զ������� >>
" =============================================================================

let mapleader=";"				      "�����ݼ���ǰ׺����<Leader>

" -----------------------------------------------------------------------------
"  < Vundle ������������� >
" -----------------------------------------------------------------------------
" ���ڸ�����Ĺ���vim����������÷��ο� :h vundle ����
" Vundle���߰�װ����Ϊ���ն�������������
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" ������� windows ��װ�ͱ����Ȱ�װ "git for window"���ɲ�����������

set nocompatible                                      "���� Vi ����ģʽ
filetype off                                          "�����ļ��������

if g:islinux
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif
 
" ʹ��Vundle�����������������Ҫ�С�
Bundle 'gmarik/vundle'

" ����ΪҪ��װ����µĲ������ͬ�ֿⶼ�У�������д�淶��ο�������
"my Bundle here:
"
" original repos on github
Bundle 'Lokaltog/vim-powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Yggdroot/indentLine'
Bundle 'a.vim'
Bundle 'majutsushi/tagbar'
Bundle 'jiangmiao/auto-pairs'
Bundle 'cSyntaxAfter'
Bundle 'Mark--Karkat'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'bufexplorer.zip'



"..................................
" vim-scripts repos



"..................................
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'



"......................................

" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
" ע��ʹ��utf-8��ʽ����������Դ�롢�ļ�·�����������ģ����򱨴�
set encoding=utf-8                                    "����gvim�ڲ����룬Ĭ�ϲ�����
set fileencoding=utf-8                                "���õ�ǰ�ļ����룬���Ը��ģ��磺gbk��ͬcp936��
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "����֧�ִ򿪵��ļ��ı���
 
" �ļ���ʽ��Ĭ�� ffs=dos,unix
set fileformat=unix                                   "�����£���ǰ���ļ���<EOL>��ʽ�����Ը��ģ��磺dos��windowsϵͳ���ã�
set fileformats=unix,dos,mac                          "�����ļ���<EOL>��ʽ����
 
if (g:iswindows && g:isGUI)
    "����˵�����
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
 
    "���consle�������
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
"  < ��д�ļ�ʱ������ >
" -----------------------------------------------------------------------------
filetype on                                           "�����ļ��������
filetype plugin on                                    "��Բ�ͬ���ļ����ͼ��ض�Ӧ�Ĳ��
filetype plugin indent on                             "��������
set smartindent                                       "�������ܶ��뷽ʽ
set expandtab                                         "��Tab��ת��Ϊ�ո�
set tabstop=4                                         "����Tab���Ŀ�ȣ����Ը��ģ��磺���Ϊ2
set shiftwidth=4                                      "����ʱ�Զ�������ȣ��ɸ��ģ����ͬtabstop��
set smarttab                                          "ָ����һ��backspace��ɾ��shiftwidth���
set nofoldenable                                      "���� vim ʱ�ر��۵�����
set foldmethod=indent                                 "indent �۵���ʽ
" set foldmethod=syntax                                "syntax �۵���ʽ

" ����ģʽ���ÿո�������ع���������۵���ע��zR չ�������۵���zM �ر������۵���
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" ���ļ����ⲿ���޸ģ��Զ����¸��ļ�
set autoread
" ����ģʽ������ cS �����β�ո�
nmap cS :%s/\s\+$//g<CR>:noh<CR>
" ����ģʽ������ cM �����β ^M ����
nmap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase                                        "����ģʽ����Դ�Сд
set smartcase                                         "�������ģʽ������д�ַ�����ʹ�� 'ignorecase' ѡ�ֻ������������ģʽ���Ҵ� 'ignorecase' ѡ��ʱ�Ż�ʹ��
" set noincsearch                                       "������Ҫ����������ʱ��ȡ��ʵʱƥ��

" Ctrl + K ����ģʽ�¹�������ƶ�
imap <c-k> <Up>
" Ctrl + J ����ģʽ�¹�������ƶ�
imap <c-j> <Down>
" Ctrl + H ����ģʽ�¹�������ƶ�
imap <c-h> <Left>
" Ctrl + L ����ģʽ�¹�������ƶ�
imap <c-l> <Right>
 
" ����ÿ�г���80�е��ַ���ʾ��������������»��ߣ��������þ�ע�͵�
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set background=dark				      "���ñ�����/��
set number                                            "��ʾ�к�
set gcr=a:block-blinkon0			      "��ֹ�����˸
set cmdheight=2                                       "���������еĸ߶�Ϊ2��Ĭ��Ϊ1
set cursorline                                        "������ʾ��ǰ��
set cursorcolumn				      "������ʾ��ǰ��
" set guifont=YaHei_Consolas_Hybrid:h10                 "��������:�ֺţ��������ƿո����»��ߴ��棩
set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
set nowrap                                            "���ò��Զ�����
" set shortmess=atI                                     "ȥ����ӭ����
 
" ���� gVim ���ڳ�ʼλ�ü���С
if g:isGUI
    " au GUIEnter * simalt ~x                           "��������ʱ�Զ����
    winpos 100 10                                     "ָ�����ڳ��ֵ�λ�ã�����ԭ������Ļ���Ͻ�
    set lines=33 columns=130                          "ָ�����ڴ�С��linesΪ�߶ȣ�columnsΪ���
endif
 
" ���ô�����ɫ����
if g:isGUI
    colorscheme solarized               "Gvim��ɫ����
else
    colorscheme solarized               "�ն���ɫ����
endif
 
" ��ʾ/���ز˵������������������������� Ctrl + F11 �л�
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

" -----------------------------------------------------------------------------
"  < ���롢���ӡ��������� (Ŀǰֻ������C��C++��Java����)>
" -----------------------------------------------------------------------------
" F9 һ�����桢���롢���Ӵ沢����
nmap <F9> :call Run()<CR>
imap <F9> <ESC>:call Run()<CR>
 
" Ctrl + F9 һ�����沢����
nmap <c-F9> :call Compile()<CR>
imap <c-F9> <ESC>:call Compile()<CR>
 
" Ctrl + F10 һ�����沢����
nmap <c-F10> :call Link()<CR>
imap <c-F10> <ESC>:call Link()<CR>
 
let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Class_Extension = '.class'
let s:Sou_Error = 0
 
let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
 
let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
 
let s:JavaFlags = 'javac\ %'
 
func! Compile()
    exe ":ccl"
    exe ":update"
    let s:Sou_Error = 0
    let s:LastShellReturn_C = 0
    let Sou = expand("%:p")
    let v:statusmsg = ''
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        let class_Name = expand("%:p:t:r").s:Class_Extension
        if !filereadable(class) || (filereadable(class) && (getftime(class) < getftime(Sou)))
            redraw!
            exe ":setlocal makeprg=".s:JavaFlags
            echohl WarningMsg | echo " compiling..."
            silent make
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""class_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc
 
func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:LastShellReturn_L = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
            let Exe_Name = expand("%:p:t:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
            let Exe_Name = expand("%:p:t:r")
        endif
        let v:statusmsg = ''
        if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
            redraw!
            if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
                if expand("%:e") == "c"
                    setlocal makeprg=gcc\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    setlocal makeprg=g++\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_L = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_L != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " linking failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " linking successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " linking successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Exe_Name"is up to date"
            endif
        endif
        setlocal makeprg=make
    elseif expand("%:e") == "java"
        return
    endif
endfunc
 
func! Run()
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!%<.exe"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c './%<; echo; echo �밴 Enter ������; read'"
                else
                    exe ":!clear; ./%<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        if getftime(class) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!java %<"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c 'java %<; echo; echo �밴 Enter ������; read'"
                else
                    exe ":!clear; java %<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endif
endfunc


" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set writebackup                             "�����ļ�ǰ�������ݣ�����ɹ���ɾ���ñ���
set nobackup                                "�����ޱ����ļ�
" set noswapfile                              "��������ʱ�ļ�
" set vb t_vb=                                "�ر���ʾ��


" =============================================================================
"                          << ����Ϊ���ò������ >>
" =============================================================================
" -----------------------------------------------------------------------------
"  < powerline ������� >
" -----------------------------------------------------------------------------
" ״̬����������õ�״̬��Ч��
set laststatus=2                                      "����״̬����Ϣ
let g:Powerline_colorscheme='solarized256'	      "����״̬��������
" -----------------------------------------------------------------------------
"  < indentLine ������� >
" -----------------------------------------------------------------------------
" ������ʾ�����ߣ��� indent_guides ����ʾ��ʽ�ϲ�ͬ�������Լ�ϲ��ѡ����
" ���ն��ϻ�����Ļˢ�µ����⣬��������ܽ���и�����
" ����/�رն�����
nmap <leader>il :IndentLinesToggle<CR>
" -----------------------------------------------------------------------------
"  < a.vim ������� >
" -----------------------------------------------------------------------------
" �����л�C/C++ͷ�ļ�
" :A     ---�л�ͷ�ļ�����ռ��������
" :AV    ---�л�ͷ�ļ�����ֱ�ָ��
" :AS    ---�л�ͷ�ļ���ˮƽ�ָ��
" -----------------------------------------------------------------------------
"  < Tagbar ������� >
" -----------------------------------------------------------------------------
" ���� tagbar �Ӵ��ڵ�λ�ó��������༭������� 
" let tagbar_left=1 
" ������ʾ�����ر�ǩ�б��Ӵ��ڵĿ�ݼ����ټǣ�tagbar
nnoremap <Leader>tb :TagbarToggle<CR> 
" ���ñ�ǩ�Ӵ��ڵĿ�� 
let tagbar_width=30
" tagbar �Ӵ����в���ʾ���������Ϣ 
let g:tagbar_compact=1
" ���� ctags ����Щ����Ԫ�����ɱ�ǩ
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

" -----------------------------------------------------------------------------
"  < auto-pairs ������� >
" -----------------------------------------------------------------------------
" ���������������Զ���ȫ���������뺯��ԭ����ʾ���echofunc��ͻ
" �����Ҿ�û�м���echofunc���

" -----------------------------------------------------------------------------
"  < cSyntaxAfter ������� >
" -----------------------------------------------------------------------------
" �����������������
au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,java,javascript} call CSyntaxAfter()

" -----------------------------------------------------------------------------
"  < Mark--Karkat��Ҳ���� Mark�� ������� >
" -----------------------------------------------------------------------------
" ����ͬ�ĵ��ʸ�����������ͬ�ı���ʱ�����ã���ϸ������ :h mark.txt

" -----------------------------------------------------------------------------
"  < nerdcommenter ������� >
" -----------------------------------------------------------------------------
" ����Ҫ����C/C++����ע��(������Ҳ��)
" ����Ϊ���Ĭ�Ͽ�ݼ������е�˵������C/C++Ϊ���ģ�������������
" <Leader>ci ��ÿ��һ�� /* */ ע��ѡ����(ѡ������������)����������ȡ��ע��
" <Leader>cm ��һ�� /* */ ע��ѡ����(ѡ������������)������������ظ�ע��
" <Leader>cc ��ÿ��һ�� /* */ ע��ѡ���л���������������ظ�ע��
" <Leader>cu ȡ��ѡ������(��)��ע�ͣ�ѡ������(��)��������һ�� /* */
" <Leader>ca ��/*...*/��//������ע�ͷ�ʽ���л����������Կ��ܲ�һ���ˣ�
" <Leader>cA ��βע��
let NERDSpaceDelims = 1                     "����ע�ͷ�֮����ע�ͷ�֮ǰ���пո�

" -----------------------------------------------------------------------------
"  < nerdtree ������� >
" -----------------------------------------------------------------------------
" ��Ŀ¼��ṹ���ļ�������
 
" ����ģʽ������ F2 ���ò��
nmap <F2> :NERDTreeToggle<CR>

" -----------------------------------------------------------------------------
"  < neocomplcache ������� >
" -----------------------------------------------------------------------------
" �ؼ��ֲ�ȫ���ļ�·����ȫ��tag��ȫ�ȵȣ����֣��ǳ����ã��ٶȳ��졣
let g:neocomplcache_enable_at_startup = 1     "vim ����ʱ���ò��
" let g:neocomplcache_disable_auto_complete = 1 "���Զ�������ȫ�б�
" �ڵ�����ȫ�б���� <c-p> �� <c-n> ��������ѡ��Ч���ȽϺ�

" -----------------------------------------------------------------------------
"  < BufExplorer ������� >
" -----------------------------------------------------------------------------
" �������ɵ��ڻ������л����൱����һ�ֶ���ļ�����л���ʽ��
" <Leader>be �ڵ�ǰ������ʾ�����б���ѡ���ļ�
" <Leader>bs ˮƽ�ָ����ʾ�����б����ڻ����б����д�ѡ���ļ�
" <Leader>bv ��ֱ�ָ����ʾ�����б����ڻ����б����д�ѡ���ļ�


" =============================================================================
"                          << ����Ϊ���ù������� >>
" =============================================================================
" -----------------------------------------------------------------------------
"  < cscope �������� >
" -----------------------------------------------------------------------------
" ��Cscope�Լ��Ļ�˵ - "����԰��������ǳ���Ƶ��ctags"
if has("cscope")
    "�趨����ʹ�� quickfix �������鿴 cscope ���
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    "ʹ֧���� Ctrl+]  �� Ctrl+t ��ݼ��ڴ������ת
    set cscopetag
    "������뷴������˳������Ϊ1
    set csto=0
    " ʹ��|:cstag|(:cs find g)��������ȱʡ��:tag
    set cst
    " ��ʾ����Ƿ�ɹ�
    set csverb
    "�ڵ�ǰĿ¼������κ����ݿ�
    if filereadable("cscope.out")
        cs add cscope.out
    "����������ݿ⻷������ָ����
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    "��ݼ�����
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" -----------------------------------------------------------------------------
"  < ctags �������� >
" -----------------------------------------------------------------------------
" �������ͬ����ǩ
nmap <Leader>tn :tnext<CR>
" �������ͬ����ǩ
nmap <Leader>tp :tprevious<CR>

" make tags by ctags
nmap <silent> <F6> <Esc>:!ctags -R *<CR>
imap <silent> <F6> <Esc>:w<CR>:!ctags -R *<CR>
" tags
set tags=~/work/tags/commlib_tags,~/work/tags/glibc_tags,tags;

" =============================================================================
"                          << ����Ϊ�����Զ��������� >>
" =============================================================================
" �Զ��л�Ŀ¼Ϊ��ǰ�༭�ļ�����Ŀ¼
au BufRead,BufNewFile,BufEnter * cd %:p:h

" =============================================================================
"                     << windows �½�� Quickfix �������� >>
" =============================================================================
" windows Ĭ�ϱ���Ϊ cp936���� Gvim(Vim) �ڲ�����Ϊ utf-8�����Գ������Ϊ����
" ���´�����Խ�����Ϊ cp936 �������Ϣת��Ϊ utf-8 ���룬�Խ�������������
" ������ֻ�������Ϣȫ��Ϊ���Ĳ��������Ч������������Ϣ����Ӣ��ϵģ��ǿ���
" ���ɹ������������һ���������룬�����Ϣȫ��ΪӢ�ĵĺ��񲻻�����
" ��������ϢΪ����Ŀ�����һ������Ĵ��룬������оͻ��Ǹ���ע�͵�
 
if g:iswindows
    function QfMakeConv()
        let qflist = getqflist()
        for i in qflist
           let i.text = iconv(i.text, "cp936", "utf-8")
        endfor
        call setqflist(qflist)
     endfunction
     au QuickfixCmdPost make call QfMakeConv()
endif

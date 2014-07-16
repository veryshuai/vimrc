" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible
set nocompatible 

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Highlight search results
set hlsearch

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" kill error bells entirely
set noerrorbells
set novisualbell
set t_vb=

set history=1000
set undolevels=1000
set ruler

" Ctrl-N and Ctrl-P go to next/prev tabs in normal mode
nmap <silent> <C-N> :tabnext<Enter>
nmap <silent> <C-P> :tabprev<Enter>

" up/down move between visual lines instead of actual lines when wrapped
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" PATHOGEN STUFF
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
" call pathogen#helptags()
" call pathogen#runtime_append_all_bundles()

" VUNDLE STUFF
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'terryma/vim-expand-region.git'
Bundle 'jcf/vim-latex'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-fugitive.git'
Bundle 'tpope/vim-surround.git'
Bundle 'tpope/vim-rails.git'
Bundle 'bling/vim-airline.git'
Bundle 'godlygeek/tabular.git'
Bundle 'vim-scripts/taglist.vim'
Bundle 'greyblake/vim-preview.git'
Bundle 'Lokaltog/vim-easymotion.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'

" NOTE THIS BREAKS SPELLCHECK!
" " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
" let g:tex_flavor='latex'

" change the mapleader from \ to ,
" let mapleader=","
let mapleader="\<space>"
 
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
 
" Set Color Scheme 
if &t_Co >= 256 || has("gui_running")
    colorscheme inkpot
    "colorscheme mustang 
    " Remove Toolbar
    set guioptions-=T
    "Terminus is AWESOME
    set guifont=Terminus\ 9
else
    colorscheme metacosm
endif

" This let's me paste text without that damned autoindent
set pastetoggle=<F2>

" Make F12 toggle vim mouse vs terminal mouse
fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse is for terminal"
    endif
endfunction

" Don't have to hit shift for ;->:
nnoremap ; :

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap
 
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Clear search buffer (to get rid of highlighting)
nmap <silent> ,/ :nohlsearch<CR>

" Show line numbers
set nu

" Needed to ensure proper spelling functioning
syn spell toplevel

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Set region to American English
set spelllang=en_us

"-from Konstantin:
"---- INDENTATION ----
" Always set autoindenting on
set autoindent
" Copy the previous indentation on autoindenting
set copyindent
" Set indentation size:
set shiftwidth=4
" Use multiple of shiftwidth when indenting with '<' and '>'
set shiftround
" Set to turn tabs to spaces:
set expandtab
" Set size of tab:
set tabstop=4
" Insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab
" Turn on Vim's file type detection logic:
filetype plugin indent on
" Perform 'set cindent' if file type detected is C or C++ (this includes header files):
autocmd FileType c,cpp :set cindent
" Some fine-tuning:
" Place C++ scope declarations ('public:', 'protected:', 'private:') zero characters from
" the indent of the block they are in:
set cino=g0

" Make Vim set out tab characters, trailing whitespace and invisible spaces visually,
" and additionally use the # sign at the end of lines to mark lines that extend
" off-screen.
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
" Disable showing white spaces in html and xml files:
autocmd filetype html,xml set listchars-=tab:>.
autocmd BufEnter *.md set filetype=.tex

"Autosave from here:
"http://www.reddit.com/r/vim/comments/1cvjed/advantages_and_disadvantages_of_have_a_swap_swp/
" Periodical auto-save
" Write to disk after 1 second of inactivity, once every 15 seconds.
au BufRead,BufNewFile * let b:last_autosave=localtime()
au CursorHold * call UpdateFile()
au BufWritePre * let b:last_autosave=localtime()
set updatetime=1000
function! UpdateFile()
    if exists("b:last_autosave") && ((localtime() - b:last_autosave) >= 15)
        update
        let b:last_autosave=localtime()
    endif
endfunction

"Fix air-line
set laststatus=2

"I believe this will let me yank into the clipboard!
let g:clipbrdDefaultReg = '+'

"This is supposed to let me view all functions in a document
" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
" Various Taglist diplay config:
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1

"Enable smart tabs for airline
let g:airline#extensions#tabline#enabled = 1

"Set persistent undo!"
set undodir=/home/veryshuai/.vim/undo/
set undofile
set undolevels=1000
set undoreload=10000

"Frequently used leader macros
nnoremap <Leader>w :w<CR>
nmap <Leader><Leader> V
nmap <Leader>d i<tab>import pdb; pdb.set_trace()<esc>

"Maps for expand
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"Other Adam Stankiewicz suggestions
"http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()


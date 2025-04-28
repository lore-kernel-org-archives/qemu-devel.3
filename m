Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71452C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ICZ-0005vE-PV; Mon, 28 Apr 2025 02:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBr-0004vp-W3; Mon, 28 Apr 2025 02:42:08 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBp-0007Im-3w; Mon, 28 Apr 2025 02:42:06 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-af9a6b3da82so2766187a12.0; 
 Sun, 27 Apr 2025 23:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822522; x=1746427322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USb/0rtkWR/VNf4TYcjMJuPMpxbofqqsc6ztVaeb2OQ=;
 b=LTpSWXuf9xgqb40t+jDNgGEXt5eTAqkLooqERDRcr0lesOTZjBvKtgpN17RLn14K90
 tZJUmClorvW/09qGWhtgRo69Edg5y3EHUuHnkMEPLspBRixGLMXnroZBER0LeS2JH+QV
 3jisQAyrzBWUAzZJtOu3H/szs/LGumdaMgaLcMx3jq63h8rH9anRlZCfV78SrqIFkSq8
 uePB+XETbEHO6dx8yAO9QFsDb4+EgTzEfWKsLxmsferIYwDwx4RHIGrI3u9mC5VoO5lP
 ZXLry4ImBEQ4vRcHk8mqEX3mRiQcUs94w4bbO4LLiaerATH+cGNTWTvw/WeEqsZXOYGe
 t3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822522; x=1746427322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USb/0rtkWR/VNf4TYcjMJuPMpxbofqqsc6ztVaeb2OQ=;
 b=qshMEi+B5vHhYAtHDA3y65ft7FI14DxjlUY1RDf4cT/66Nbfok+t1zItx+q2G1Mi2S
 aeH0Y3RQT5z0b4ezZMYOkiuNsRwQKxQVENz4e9x1gn85620oixjeMyCHbD1QozR4dXoX
 vuP8Mo6HFAPHJgMjuzxlIJAptkL7SnDVe4EtAncl626bbE9WudkZGtjirIc/fh6pckAQ
 gLq7RtXX7QpCZ2SBDugVYDJxf9eS1EzkGu+KOyJ2qQjHAcD5isncQT5yNVPghisPadIa
 i8mCi69Y2EK4tax7pSLaa/D1iTOWMbrbm/XLxdbMwIt97a9ugNT13x8zVdH49JJ4/9bi
 j92g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwPgwqrcwwwTaeEw2Zu1tfLvCOgJ1a8opwHUvMZUZZOHo/SvR/Bp3CNaOxi2lySmmDngo3qps/PyKThg==@nongnu.org,
 AJvYcCVd2G1SX4TObvZHl3y1EpaIOrvRMKz/6Ex3T+UU0NXtWqS75Ra/6biHTr9nfwNqd/UrNoQFMolhVcs=@nongnu.org,
 AJvYcCWGXGx+g2oSu5PP3B9+NQErFpu+XLHOa3Gws438p/JEw2fHGY1N7Kk4WX9EifiDbYKh5fJQEqDd8v1WqA==@nongnu.org,
 AJvYcCWockxOG4DmjhMLpnMiJUlgofib76U3gxcp9xhTSf6xI3z6jkKIizVkqpYlDRtZ1UnfxBxm2cfPEg==@nongnu.org
X-Gm-Message-State: AOJu0YyM2+HPsGo8lWMVThRUBGe8FntirkTm5gdkYKtzu+Fcs2+XAewT
 v6ACt6GT9lDUbVYj2t2YFGyzBdf9Gn30CNiVX24/sPwrHgQQoYJ7/U7yP2tm
X-Gm-Gg: ASbGncuxxLIkJGyUPhyaAE1MqpTsLaSyzYLc0CFYFXUimpqyPZHQbksY+WjM5mDTzBH
 ddHv0tjVBi6qqj+gaXUU3op3n6RAytmALqv1BUevhHgPGBrVvjGaX7qHHMvgvii9r4GsAfVlP0T
 et5VG7t7LMPw6dfRQlNDvzDL+3NiAMicPZBkGGJbhImtBCwB+NA5/k/8MMXFHUB4iDdBgTg0PCA
 F5InBLtwg5cxMmVoj3Zo4xngi6GPmLyMr6VvxypztZm5hXRnFNUMrnzS0i1HylqQL+hKmxGfXVl
 qQTbZXT9AhU6+jZjJurKZnXmjgWD8RF4uPnHTg==
X-Google-Smtp-Source: AGHT+IGs82alOJyqw/R0MDNRSsdHpo1AL/wVENeH0XecRcGHGHg3g5++dzGdl1co7KKMCDtqIoUxog==
X-Received: by 2002:a17:902:db0f:b0:224:1d1c:8837 with SMTP id
 d9443c01a7336-22dbf5ea85amr162001735ad.19.1745822522442; 
 Sun, 27 Apr 2025 23:42:02 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:42:01 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 18/20] meson: Add wasm build in build scripts
Date: Mon, 28 Apr 2025 15:39:07 +0900
Message-ID: <ad03b3b180335f59e785e930968077bf15c46260.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

has_int128_type is set to false on emscripten as of now to avoid errors by
libffi. Tests are disabled on emscripten because they rely on host
features that aren't supported by emscripten (e.g. fork and unix
socket).

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS                   |  1 +
 configs/meson/emscripten.txt  |  8 ++++++++
 configure                     |  7 +++++++
 meson.build                   | 29 ++++++++++++++++++++++++-----
 meson_options.txt             |  2 +-
 scripts/meson-buildoptions.sh |  2 +-
 6 files changed, 42 insertions(+), 7 deletions(-)
 create mode 100644 configs/meson/emscripten.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 750afd44c5..dd5a97ac36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -634,6 +634,7 @@ S: Maintained
 F: include/system/os-wasm.h
 F: os-wasm.c
 F: util/coroutine-wasm.c
+F: configs/meson/emscripten.txt
 
 Alpha Machines
 --------------
diff --git a/configs/meson/emscripten.txt b/configs/meson/emscripten.txt
new file mode 100644
index 0000000000..4230e88005
--- /dev/null
+++ b/configs/meson/emscripten.txt
@@ -0,0 +1,8 @@
+[built-in options]
+c_args = ['-pthread']
+cpp_args = ['-pthread']
+objc_args = ['-pthread']
+# -sPROXY_TO_PTHREAD link time flag always requires -pthread even during
+# configuration so explicitly add the flag here.
+c_link_args = ['-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
+cpp_link_args = ['-pthread','-sASYNCIFY=1','-sPROXY_TO_PTHREAD=1','-sFORCE_FILESYSTEM','-sALLOW_TABLE_GROWTH','-sTOTAL_MEMORY=2GB','-sWASM_BIGINT','-sEXPORT_ES6=1','-sASYNCIFY_IMPORTS=ffi_call_js','-sEXPORTED_RUNTIME_METHODS=addFunction,removeFunction,TTY,FS']
diff --git a/configure b/configure
index 000309cf61..de12241c62 100755
--- a/configure
+++ b/configure
@@ -360,6 +360,10 @@ elif check_define __NetBSD__; then
   host_os=netbsd
 elif check_define __APPLE__; then
   host_os=darwin
+elif check_define EMSCRIPTEN ; then
+  host_os=emscripten
+  cpu=wasm32
+  cross_compile="yes"
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
@@ -526,6 +530,9 @@ case "$cpu" in
     linux_arch=x86
     CPU_CFLAGS="-m64"
     ;;
+  wasm32)
+    CPU_CFLAGS="-m32"
+    ;;
 esac
 
 if test -n "$host_arch" && {
diff --git a/meson.build b/meson.build
index bcb9d39a38..fc38b02cee 100644
--- a/meson.build
+++ b/meson.build
@@ -50,9 +50,9 @@ genh = []
 qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
-supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
+supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64']
+  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'wasm32']
 
 cpu = host_machine.cpu_family()
 
@@ -353,6 +353,8 @@ foreach lang : all_languages
       # endif
       #endif''')
     # ok
+  elif compiler.get_id() == 'emscripten'
+    # ok
   else
     error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
   endif
@@ -470,7 +472,10 @@ endif
 # instead, we can't add -no-pie because it overrides -shared: the linker then
 # tries to build an executable instead of a shared library and fails.  So
 # don't add -no-pie anywhere and cross fingers. :(
-if not get_option('b_pie')
+#
+# Emscripten doesn't support -no-pie but meson can't catch the compiler
+# warning. So explicitly omit the flag for Emscripten.
+if not get_option('b_pie') and host_os != 'emscripten'
   qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
 endif
 
@@ -514,6 +519,8 @@ ucontext_probe = '''
 supported_backends = []
 if host_os == 'windows'
   supported_backends += ['windows']
+elif host_os == 'emscripten'
+  supported_backends += ['wasm']
 else
   if host_os != 'darwin' and cc.links(ucontext_probe)
     supported_backends += ['ucontext']
@@ -902,6 +909,10 @@ if get_option('tcg').allowed()
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
+  elif host_arch == 'wasm32'
+    if not get_option('tcg_interpreter')
+      error('WebAssembly host requires --enable-tcg-interpreter')
+    endif
   elif get_option('tcg_interpreter')
     warning('Use of the TCG interpreter is not recommended on this host')
     warning('architecture. There is a native TCG execution backend available')
@@ -2962,7 +2973,9 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
     return 0;
   }''', args: qemu_isa_flags))
 
-has_int128_type = cc.compiles('''
+# has_int128_type is set to false on Emscripten to avoid errors by libffi
+# during runtime.
+has_int128_type = host_os != 'emscripten' and cc.compiles('''
   __int128_t a;
   __uint128_t b;
   int main(void) { b = a; }''')
@@ -3777,6 +3790,8 @@ if have_block
   # os-win32.c does not
   if host_os == 'windows'
     system_ss.add(files('os-win32.c'))
+  elif host_os == 'emscripten'
+    blockdev_ss.add(files('os-wasm.c'))
   else
     blockdev_ss.add(files('os-posix.c'))
   endif
@@ -4515,7 +4530,11 @@ subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
 subdir('docs')
-subdir('tests')
+# Tests are disabled on emscripten because they rely on host features that aren't
+# supported by emscripten (e.g. fork and unix socket).
+if host_os != 'emscripten'
+  subdir('tests')
+endif
 if gtk.found()
   subdir('po')
 endif
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca0..45772484cc 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -34,7 +34,7 @@ option('fuzzing_engine', type : 'string', value : '',
 option('trace_file', type: 'string', value: 'trace',
        description: 'Trace file prefix for simple backend')
 option('coroutine_backend', type: 'combo',
-       choices: ['ucontext', 'sigaltstack', 'windows', 'auto'],
+       choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
        value: 'auto', description: 'coroutine backend to use')
 
 # Everything else can be set via --enable/--disable-* option
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3e8e00852b..0568385f00 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -80,7 +80,7 @@ meson_options_help() {
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
   printf "%s\n" '                           [NORMAL]'
   printf "%s\n" '  --with-coroutine=CHOICE  coroutine backend to use (choices:'
-  printf "%s\n" '                           auto/sigaltstack/ucontext/windows)'
+  printf "%s\n" '                           auto/sigaltstack/ucontext/windows/wasm)'
   printf "%s\n" '  --with-pkgversion=VALUE  use specified string as sub-version of the'
   printf "%s\n" '                           package'
   printf "%s\n" '  --with-suffix=VALUE      Suffix for QEMU data/modules/config directories'
-- 
2.43.0



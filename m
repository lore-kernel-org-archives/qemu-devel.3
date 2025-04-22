Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A78BC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76GZ-000108-W8; Tue, 22 Apr 2025 01:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76DE-0003JK-FV; Tue, 22 Apr 2025 01:30:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76DB-0008CC-Ea; Tue, 22 Apr 2025 01:30:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2241053582dso66090925ad.1; 
 Mon, 21 Apr 2025 22:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299822; x=1745904622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bR9tjJsEvQbCR1Whb3KG+MPH3ySGS1KrwXPV7+RU2DI=;
 b=aMMP/nZUq7oEdHGxxZ5FYdNTyZHs7nVtQjISEwU2DUGvT3UQhWbvTnMdYRpe1Xbb01
 1+I+qANBKPXMXHlbFD2vNuZSOkFt8wiQxtlGbwu8lZqeYxiya6ngO349YqUyVCQhFH0H
 xP0eKanVHAWR5NY8+vh5fAiKSGWQElJfkDV2hYZfAER2im8Y8xxbZZ9l49yaZw0S1yVZ
 V2XEvABhJO5R30amGG9QNpYpHH8r/Eoiata30HoElVtIrcgQXGMWySNShD7ivFwvvTJB
 JqQJ9EoVEToz6P1dOsbumP2DT3HAmTzslq8fH7CaT4HtgfwcPkV+Lv85xfyYOrQ18EJI
 Fk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299822; x=1745904622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bR9tjJsEvQbCR1Whb3KG+MPH3ySGS1KrwXPV7+RU2DI=;
 b=YrnL4j0Ma331Ggb+hx+IgCLVjh+f8PADfTW6xFvFmirOFSpOVnLjw6rD7o0xCwNj/i
 AcVXUmoel710RK7yCMNriY/Hguu3KWzTtJT7vij+MyH8cjJJpNfSaNB4OkSbV6cXYKBQ
 eLp4Sru8QFcKT5+gHRHsFxMsg9mzbu4WJJR0I1rJ8DqfRGP+MQsfMmll+IAvA9MOUgAY
 EnyaZi1rcFofAZYS/J0UUrt4dgJpiuhXzOpF0Fg1UX3Yik1kZTgUszqjJFNbJ2UlZC/h
 8N+1Um2zY107nUWodhof45ENoFGwoHkGh5O+QDTcp267v9NJv1VonKKr73OqOOi1d6cl
 v2kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD0EbEHf/RV/r0JYTzBdqiWY/H41bV01ikHxC7LmbIib9Kg0aW1Ktgud7BS2O0a0VB9RX7bFo9kAg=@nongnu.org,
 AJvYcCUsgcVzbam7moiFAh/G8Swu43snEGsHUI+4qw129sbOH2LZSE4eEXP4kAKIO7IvRA8N4ij2PhqeCJ7wlg==@nongnu.org,
 AJvYcCX4CkbB51ZTelRaQdbOphKMFI9JrbFK+eNb+BVNiiJUa78cJVzhKXxYjMHbf0A2jTvUG8Lgwu4v9g==@nongnu.org,
 AJvYcCXDpInUBtXZEAVaDuZjIxzemi/mQ8u8tm+AxtYbtI6cRH5DHDSNVSMtxWR3yOE+Eah30SSYvZxGBSqZ5g==@nongnu.org
X-Gm-Message-State: AOJu0YxhdQ3ckFwkWPTQHfKc5xMqaG6smkaCmzfX1k3luzi+hj5TZpBh
 bzib7ARhwQ2dLFxys+p3wrVowf4avyqVYPXmeIHSNLCLd57YRfwZjAj9YyNR
X-Gm-Gg: ASbGncuuL3txenVa22Xut0cReDXO2ZZVRVRU52GDVWYYU+bEosvlaOJj6vO5e3tJR1E
 eD9uiogPRsEpDy+VqDQTZT3f5fArLar5ZdzHbJCEweWup59oHWY0FfU8VBGX386uB1V+GeAcj/h
 2H1KHe+1+GXBlAzfmXW991OYdqc7SO0GxWvrBhjnYiC8nxgwKJNAFRZIFgKOSP+0t8spguxKEAo
 H5Qo8WODkja/SG+FD1127Gctwe0FstpU4UdnzLu8Eqil7ahCJLh4MnvJL4w+QL3kBRIiCoky0J+
 p9VHZ+36oJGdMvK8kWbJxsmTRypj4/HM92fhszl61QjwEBBl2sZj8esQppdCGvuTXqh8qQ==
X-Google-Smtp-Source: AGHT+IHWjB+vgR42QzHXmmAa0NzXDyG4fgHjHTbVtmEiLwNlQYswMdR3+qkU+j/iMWiwq0zWpii8HA==
X-Received: by 2002:a17:902:f64c:b0:223:5379:5e4e with SMTP id
 d9443c01a7336-22c53285b05mr227915295ad.10.1745299821428; 
 Mon, 21 Apr 2025 22:30:21 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:30:20 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
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
Subject: [PATCH v2 18/20] meson: Add wasm build in build scripts
Date: Tue, 22 Apr 2025 14:27:22 +0900
Message-Id: <de1f868d4b3b036c2d6373b707157e364609b2b8.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62f.google.com
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

V2:
- In meson.build, added a check to ensure TCI is enabled for the wasm build.
- Split the MAINTAINERS file change that adds emscripten.txt from the
  previous 19th patch into this commit.

diff --git a/MAINTAINERS b/MAINTAINERS
index 72319f804e..0fb7fd79b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -625,6 +625,7 @@ S: Maintained
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
index 02f1dd2311..a1fe6e11cd 100755
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
index 41f68d3806..a7bffd76d0 100644
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
@@ -3774,6 +3787,8 @@ if have_block
   # os-win32.c does not
   if host_os == 'windows'
     system_ss.add(files('os-win32.c'))
+  elif host_os == 'emscripten'
+    blockdev_ss.add(files('os-wasm.c'))
   else
     blockdev_ss.add(files('os-posix.c'))
   endif
@@ -4456,7 +4471,11 @@ subdir('scripts')
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
2.25.1



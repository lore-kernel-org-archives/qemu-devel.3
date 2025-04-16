Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8DFC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xzV-0005ig-1W; Wed, 16 Apr 2025 04:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xxQ-0002YT-UD; Wed, 16 Apr 2025 04:17:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xxO-0005zq-Oy; Wed, 16 Apr 2025 04:17:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so5089468b3a.2; 
 Wed, 16 Apr 2025 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791435; x=1745396235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZIwhkm1gYZydgV34GIP0NP1/+QooaD1oJOOb4q2f3I=;
 b=LGx1aSBhL4X0HmMih4ACwsngW5cwGaMylsAYjrfPuy0Ji+ThQi6TmgazEGy0yqI460
 /V1YbPuL/VrWTyaENOXIc04SsiLOBbXNOduMuaHRYg+yHjcx6wYXjY7zQPQfnVeC08Ji
 ki5AXl5YBov0wK5gJ0KS3OltZFD7LDu40D2Jxb95p01kCTsd6KLq+NXymZHmWXXCS6F0
 zz/iXMN7Nybmc1C476PO4inp2LWXbC+hNIu/lS0xha/SSVpsNgqFK6YSP8t6zl51IGL/
 fRlunFzvTLz+5hTAV0QYhZgJditiEocAUcAnHqDy/uBrxaCisT9sVAfTl1Mpu2864jip
 ZamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791435; x=1745396235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZIwhkm1gYZydgV34GIP0NP1/+QooaD1oJOOb4q2f3I=;
 b=g5JXMkq/773MAxg+hofKJZPWHZzclYPm1yivN2THarvmciXGCO7aW023ptGA/PNKaT
 tJ2SxJkRdmK4rXOzCAyWQa668tJb0e5GSQwB6DrhWwui9TLfXuPClLBVEzBSQUE5V1CQ
 zuFRtPIJtPUtgbBF3XgkrcinusyfuxqQzs+3DP3KQXgaE1gmC6SRlek24sUugNvG60L9
 OF/AzmeOse2b47H7ggza51NvEocmPbaqAcXg3KT2N04pMR31SvjzE3kienlRUSYLTxIm
 iCoDVkF2PCSwCLIPxUd3iJMliivPEbgazqoQAIHYgOh3RBNv1pO72Pgz2zbQ3LnnHyeo
 zigQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1zM6FS+HXnxRbCzjuwdZ608/1HD0rVR2fLVAfn6Z5fIfuXPTZ2k0jaQqp+6z9sQP2V3ZSOluSZz0=@nongnu.org,
 AJvYcCUzk1/+Derk2OuIRHOe75zhXspyX+uQIiP7OGmQX2tY4vBZKdQKpcPIogdMCE+FHLhLrYwSWOvQjlWBXw==@nongnu.org,
 AJvYcCWizXA/Dq5vhv5rgrXFzGm3aB6nGWpgsO4wYk7cLIwKDbGckHriPeVvW2VHFf5qp0Q3Pts/JB8Xlw==@nongnu.org,
 AJvYcCXWhHliy8qIFkJbODXA3wC7pG2ami9fhkKcLvSNj/reGY6x9K9oOVLej5/gGf0OeZY/jTmcAONGWs05pw==@nongnu.org
X-Gm-Message-State: AOJu0YwTGYgNOYffpuTy5h+fXdjteZ1XlU7K9Zz7xNo7w0jVZyr/vfXl
 Kfry1YKzqbS07sxKRFCfBL8f3TyeX9wOZfvlM//lGrLSS+NF63ErjKBWsKIY
X-Gm-Gg: ASbGncvBeAkWMmSSa5b0KmPrxtGfCYCqTAANQE/h4dVGqJHx0npJxLqTmZ5SfAkyqH7
 9etbIj3A68W+ZsMt8Q4Emw5B2pELYAnlorF0aWINZN7veEMVpZu1w2ryx6Ks3QKPYrNeiSuR19L
 LihTdAwNrbBVCiz1z4BIzoxsGteX/yOP/Bq2Yaiz+B5GEkWrYnURBCxmkfH0M+PupMK/HOdfyyu
 No08CvYilBz90Ykhcd29j7sObXqxn7L0emLBmVu8Lqw3hli3n4IEH4XfDJeltd0aA8rXWjukK2c
 0Le5gon0o1N9/x8KVcgC7vgpxTot1ECqHWDvTHMZHADZF0rXlTJLGb9e7g==
X-Google-Smtp-Source: AGHT+IGgzIJ5eER9yj0z1vC7FNinP2KD441XkBQRF9R/Tll92nVYI2cqMr8iiCC2EUQts7Tm457VMw==
X-Received: by 2002:a05:6a21:3a8c:b0:1f5:852a:dd8a with SMTP id
 adf61e73a8af0-203b3fc053bmr1269534637.28.1744791434901; 
 Wed, 16 Apr 2025 01:17:14 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:17:14 -0700 (PDT)
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
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 17/19] meson: Add wasm build in build scripts
Date: Wed, 16 Apr 2025 17:14:22 +0900
Message-Id: <835dfef61307a941cdb58331607c308238d37e00.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42c.google.com
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
 configs/meson/emscripten.txt  |  8 ++++++++
 configure                     |  7 +++++++
 meson.build                   | 25 ++++++++++++++++++++-----
 meson_options.txt             |  2 +-
 scripts/meson-buildoptions.sh |  2 +-
 stubs/meson.build             |  4 ++++
 6 files changed, 41 insertions(+), 7 deletions(-)
 create mode 100644 configs/meson/emscripten.txt

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
index 41f68d3806..c9aa5016d6 100644
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
@@ -2962,7 +2969,9 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
     return 0;
   }''', args: qemu_isa_flags))
 
-has_int128_type = cc.compiles('''
+# has_int128_type is set to false on Emscripten to avoid errors by libffi
+# during runtime.
+has_int128_type = host_os != 'emscripten' and cc.compiles('''
   __int128_t a;
   __uint128_t b;
   int main(void) { b = a; }''')
@@ -3774,6 +3783,8 @@ if have_block
   # os-win32.c does not
   if host_os == 'windows'
     system_ss.add(files('os-win32.c'))
+  elif host_os == 'emscripten'
+    blockdev_ss.add(files('os-wasm.c'))
   else
     blockdev_ss.add(files('os-posix.c'))
   endif
@@ -4456,7 +4467,11 @@ subdir('scripts')
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
diff --git a/stubs/meson.build b/stubs/meson.build
index 63392f5e78..4fd4d362f9 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -89,3 +89,7 @@ if have_system or have_user
   stub_ss.add(files('hotplug-stubs.c'))
   stub_ss.add(files('sysbus.c'))
 endif
+
+if host_os == 'emscripten'
+  stub_ss.add(files('emscripten.c'))
+endif
\ No newline at end of file
-- 
2.25.1



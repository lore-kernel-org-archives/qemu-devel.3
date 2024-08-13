Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF7DC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdoCd-00059c-G7; Tue, 13 Aug 2024 05:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdoCc-00055V-6r
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:52:30 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdoCZ-0001yh-Sd
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:52:29 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ab09739287so3179407a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723542746; x=1724147546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t3GHj8EPvor+Hu1Z8PFA3Hw+wfUvycfDcgvw4x5Z+6E=;
 b=IvDHGUELaT5EevBLKAdcymN9GXF4G6lepGcSNyHOJgnKAQthizxBPLTsv1MEfGfUEL
 bHwajQGdb06LNuVlwWLbKcOjOS8aW/pvC5WMlPHMGBEpV908l/kQ9HsKRUTryN8Cbz52
 ldz1GWHMIs2AAIWzNVPUQf+dTElBAX7o+05QCzYhifenAEiumBpMexllkSqYs/DsquMP
 yym0HL5sV2f/Lt4FVJ+VlGZQjc5dnSmdT/3lVZZlyfHN4EepJoBzLKLd+F3JaO6uSbWP
 QPFvU6sEthJ6xoD5s8zWlZfhoEQf0TCmhZIRvl1yGkC8e8LXIdtaNhk9mIZGrOd7tg/B
 enow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723542746; x=1724147546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3GHj8EPvor+Hu1Z8PFA3Hw+wfUvycfDcgvw4x5Z+6E=;
 b=Oxs5sGoW8IyawluNcHIEGGpBYwDODzF1PJjvDGzqc0vk6bzzKW6dPSF2f6gyEYk54D
 3OMAOIMgWikyI7Dsu1n+UC97gLjWSk8M1tPAHeU7kIspyiybHmh9xMwg9vCNNK8Qk8z5
 9d4318mJ14bOQNX7rLpfgg7C0J+ldbWh02i1S4FVThluynt8NuLV+JCTPZX4oSTNpF4l
 YmeHLOwZrPPSNkYWho1iUnJ7z657DvHFmUNf/UPVPVR+sGNN+2FII78Fa/D5nR/PHXzQ
 xsCI7Sce/6y5re6b4Lbd2KJ4J3Q7jhXIUK9hKR/A8cO/LCcrcM6bdrEkJ3cdQPqwEigx
 j+Uw==
X-Gm-Message-State: AOJu0Yy68F3B+JTNRDRwZPG6Ojfi2IcUYxodlue7iPktAq4TmN/O4vcI
 hhyHp2NK1eCYAFuMtnkJiRT5sIlqpnsiXrWYPJeuNMQ4OCmqVm4cUJM2N+9IexIoqVVvRqRy1mw
 Mpvk=
X-Google-Smtp-Source: AGHT+IHlOMIylfQSmzc6+4c2fPryiqoAMCLADASktQxAtxU9QbLicx8Qck5AXFfBNMQMtHfay+KuMQ==
X-Received: by 2002:a05:6a21:1191:b0:1c0:e9f7:29da with SMTP id
 adf61e73a8af0-1c8d74fbdd7mr4030874637.24.1723542746124; 
 Tue, 13 Aug 2024 02:52:26 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9ca796fsm10851876a91.30.2024.08.13.02.52.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 02:52:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] meson: Split --enable-sanitizers to --enable-{asan, ubsan}
Date: Tue, 13 Aug 2024 19:52:15 +1000
Message-ID: <20240813095216.306555-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813095216.306555-1-richard.henderson@linaro.org>
References: <20240813095216.306555-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We do not always want both address and undefined behavior
sanitizers running at the same time.

For the gitlab custom-runners, drop to only --enable-ubsan.
These jobs are not run by default, but as will be obvious in the
next patch, we don't run ASan on x86 either, and it seems wrong
to hold aarch64 and s390x to a different standard.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qtest/fdc-test.c                            |  2 +-
 .../custom-runners/ubuntu-22.04-aarch64.yml       |  2 +-
 .../custom-runners/ubuntu-22.04-s390x.yml         |  2 +-
 docs/devel/fuzzing.rst                            |  4 ++--
 meson.build                                       | 15 +++++++++++----
 meson_options.txt                                 |  6 ++++--
 scripts/meson-buildoptions.sh                     |  9 ++++++---
 tests/docker/test-debug                           |  4 ++--
 8 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index 5e8fbda9df..8645b080f7 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -552,7 +552,7 @@ static bool qtest_check_clang_sanitizer(void)
 #ifdef QEMU_SANITIZE_ADDRESS
     return true;
 #else
-    g_test_skip("QEMU not configured using --enable-sanitizers");
+    g_test_skip("QEMU not configured using --enable-asan");
     return false;
 #endif
 }
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
index 263a3c2140..ca2f140471 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml
@@ -103,7 +103,7 @@ ubuntu-22.04-aarch64-clang:
  script:
  - mkdir build
  - cd build
- - ../configure --disable-libssh --cc=clang --cxx=clang++ --enable-sanitizers
+ - ../configure --disable-libssh --cc=clang --cxx=clang++ --enable-ubsan
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc --ignore=40`
  - make --output-sync -j`nproc --ignore=40` check
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index 69ddd3e7d5..ca374acb8c 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -80,7 +80,7 @@ ubuntu-22.04-s390x-clang:
  script:
  - mkdir build
  - cd build
- - ../configure --cc=clang --cxx=clang++ --enable-sanitizers
+ - ../configure --cc=clang --cxx=clang++ --enable-ubsan
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
  - make --output-sync -j`nproc`
  - make --output-sync -j`nproc` check
diff --git a/docs/devel/fuzzing.rst b/docs/devel/fuzzing.rst
index 3bfcb33fc4..dfe1973cf8 100644
--- a/docs/devel/fuzzing.rst
+++ b/docs/devel/fuzzing.rst
@@ -24,8 +24,8 @@ Configure with (substitute the clang binaries with the version you installed).
 Here, enable-sanitizers, is optional but it allows us to reliably detect bugs
 such as out-of-bounds accesses, use-after-frees, double-frees etc.::
 
-    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing \
-                                                --enable-sanitizers
+    CC=clang-8 CXX=clang++-8 /path/to/configure \
+        --enable-fuzzing --enable-asan --enable-ubsan
 
 Fuzz targets are built similarly to system targets::
 
diff --git a/meson.build b/meson.build
index 81ecd4bae7..19b18b4a8a 100644
--- a/meson.build
+++ b/meson.build
@@ -474,24 +474,31 @@ if get_option('safe_stack') and coroutine_backend != 'ucontext'
   error('SafeStack is only supported with the ucontext coroutine backend')
 endif
 
-if get_option('sanitizers')
+if get_option('asan')
   if cc.has_argument('-fsanitize=address')
     qemu_cflags = ['-fsanitize=address'] + qemu_cflags
     qemu_ldflags = ['-fsanitize=address'] + qemu_ldflags
+  else
+    error('Your compiler does not support -fsanitize=address')
   endif
+endif
 
-  # Detect static linking issue with ubsan - https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
+if get_option('ubsan')
+  # Detect static linking issue with ubsan:
+  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
   if cc.links('int main(int argc, char **argv) { return argc + 1; }',
               args: [qemu_ldflags, '-fsanitize=undefined'])
     qemu_cflags = ['-fsanitize=undefined'] + qemu_cflags
     qemu_ldflags = ['-fsanitize=undefined'] + qemu_ldflags
+  else
+    error('Your compiler does not support -fsanitize=undefined')
   endif
 endif
 
 # Thread sanitizer is, for now, much noisier than the other sanitizers;
 # keep it separate until that is not the case.
 if get_option('tsan')
-  if get_option('sanitizers')
+  if get_option('asan') or get_option('ubsan')
     error('TSAN is not supported with other sanitizers')
   endif
   if not cc.has_function('__tsan_create_fiber',
@@ -2511,7 +2518,7 @@ if rdma.found()
 endif
 
 have_asan_fiber = false
-if get_option('sanitizers') and \
+if get_option('asan') and \
    not cc.has_function('__sanitizer_start_switch_fiber',
                          args: '-fsanitize=address',
                          prefix: '#include <sanitizer/asan_interface.h>')
diff --git a/meson_options.txt b/meson_options.txt
index 0269fa0f16..98615c3c4e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -91,8 +91,10 @@ option('tcg_interpreter', type: 'boolean', value: false,
        description: 'TCG with bytecode interpreter (slow)')
 option('safe_stack', type: 'boolean', value: false,
        description: 'SafeStack Stack Smash Protection (requires clang/llvm and coroutine backend ucontext)')
-option('sanitizers', type: 'boolean', value: false,
-       description: 'enable default sanitizers')
+option('asan', type: 'boolean', value: false,
+       description: 'enable address sanitizer')
+option('ubsan', type: 'boolean', value: false,
+       description: 'enable undefined behaviour sanitizer')
 option('tsan', type: 'boolean', value: false,
        description: 'enable thread sanitizer')
 option('stack_protector', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c97079a38c..a6ee2d9c01 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -21,6 +21,7 @@ meson_options_help() {
   printf "%s\n" '  --disable-relocatable    toggle relocatable install'
   printf "%s\n" '  --docdir=VALUE           Base directory for documentation installation'
   printf "%s\n" '                           (can be empty) [share/doc]'
+  printf "%s\n" '  --enable-asan            enable address sanitizer'
   printf "%s\n" '  --enable-block-drv-whitelist-in-tools'
   printf "%s\n" '                           use block whitelist also in tools instead of only'
   printf "%s\n" '                           QEMU'
@@ -46,13 +47,13 @@ meson_options_help() {
   printf "%s\n" '                           getrandom()'
   printf "%s\n" '  --enable-safe-stack      SafeStack Stack Smash Protection (requires'
   printf "%s\n" '                           clang/llvm and coroutine backend ucontext)'
-  printf "%s\n" '  --enable-sanitizers      enable default sanitizers'
   printf "%s\n" '  --enable-strip           Strip targets on install'
   printf "%s\n" '  --enable-tcg-interpreter TCG with bytecode interpreter (slow)'
   printf "%s\n" '  --enable-trace-backends=CHOICES'
   printf "%s\n" '                           Set available tracing backends [log] (choices:'
   printf "%s\n" '                           dtrace/ftrace/log/nop/simple/syslog/ust)'
   printf "%s\n" '  --enable-tsan            enable thread sanitizer'
+  printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
   printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
@@ -230,6 +231,8 @@ _meson_option_parse() {
     --disable-af-xdp) printf "%s" -Daf_xdp=disabled ;;
     --enable-alsa) printf "%s" -Dalsa=enabled ;;
     --disable-alsa) printf "%s" -Dalsa=disabled ;;
+    --enable-asan) printf "%s" -Dasan=true ;;
+    --disable-asan) printf "%s" -Dasan=false ;;
     --enable-attr) printf "%s" -Dattr=enabled ;;
     --disable-attr) printf "%s" -Dattr=disabled ;;
     --audio-drv-list=*) quote_sh "-Daudio_drv_list=$2" ;;
@@ -456,8 +459,6 @@ _meson_option_parse() {
     --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
     --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;
     --disable-safe-stack) printf "%s" -Dsafe_stack=false ;;
-    --enable-sanitizers) printf "%s" -Dsanitizers=true ;;
-    --disable-sanitizers) printf "%s" -Dsanitizers=false ;;
     --enable-sdl) printf "%s" -Dsdl=enabled ;;
     --disable-sdl) printf "%s" -Dsdl=disabled ;;
     --enable-sdl-image) printf "%s" -Dsdl_image=enabled ;;
@@ -505,6 +506,8 @@ _meson_option_parse() {
     --disable-u2f) printf "%s" -Du2f=disabled ;;
     --enable-uadk) printf "%s" -Duadk=enabled ;;
     --disable-uadk) printf "%s" -Duadk=disabled ;;
+    --enable-ubsan) printf "%s" -Dubsan=true ;;
+    --disable-ubsan) printf "%s" -Dubsan=false ;;
     --enable-usb-redir) printf "%s" -Dusb_redir=enabled ;;
     --disable-usb-redir) printf "%s" -Dusb_redir=disabled ;;
     --enable-vde) printf "%s" -Dvde=enabled ;;
diff --git a/tests/docker/test-debug b/tests/docker/test-debug
index f52f16328c..678ceccc27 100755
--- a/tests/docker/test-debug
+++ b/tests/docker/test-debug
@@ -1,6 +1,6 @@
 #!/bin/bash -e
 #
-# Compile and check with clang & --enable-debug --enable-sanitizers.
+# Compile and check with clang & debug & sanitizers
 #
 # Copyright (c) 2016-2018 Red Hat Inc.
 #
@@ -19,7 +19,7 @@ requires_binary clang
 cd "$BUILD_DIR"
 
 OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
-OPTS="--enable-debug --enable-sanitizers $OPTS"
+OPTS="--enable-debug --enable-asan --enable-ubsan $OPTS"
 
 export ASAN_OPTIONS=detect_leaks=0
 build_qemu $OPTS
-- 
2.43.0



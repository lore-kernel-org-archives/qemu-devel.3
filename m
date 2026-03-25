Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2957109C032
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Q01-0005aL-Rr; Wed, 25 Mar 2026 11:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Pzv-0005Cx-Mx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:18:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Pzt-0000Uy-Lp
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:18:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso27726625e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451896; x=1775056696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHp+isFeJ+Vwq620YK3TTBZ1M5KgDnZyZo3PdDfV4Bw=;
 b=mFjLHo9jYg43yirpOTJqhwgWbHEJYkPLWr956jdWuSTeBTBt9OIA2aBueU2+fBcwWo
 +tKCkqTVeiX7/fpF21veSlIlbgXCtvqVnKOv+bWFal0Of+OQwfGXicHDv7oVwUXpy/S3
 8ujPuTDTPgBsbbt7XZmp2DRNRATOAY7d7qx8HoPyr1QWsPxpCN6CBRCtS6V01P+jWd0G
 VAquij1iRRPZHq9u8WTWYlxHkZh0wWqiKo4DwlDU0F4rzaYxXXm1iufHMyvkwukjfRpe
 5munUnd4Z4MpIctWb/NL8jtjP6pjRbwGU9Mah7gkTaRBPNtn45xE/ZEOSBri1cXiXjNE
 IUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451896; x=1775056696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cHp+isFeJ+Vwq620YK3TTBZ1M5KgDnZyZo3PdDfV4Bw=;
 b=WBMSvTwsj2u9gIFp2ZqnQI/GRPVkPRsaWKBzFHyl+NPdct6SNvYsSOzr1RzsR7EWRi
 6QSqGw5hIMIGZdv6Kwc7W3rwziCwU+bhRb9XDQuubii4s1W8hdeYH1Irrq65SrtK+c9U
 FwntwQj6NEPKqI9BLZvTrli7dAmubi17mMZCnU3Fi4x/8vk3oaTdKe5L7PDJGL6uKBNY
 gsu7RS/ckl5iFqj3r7xJrrNcWkibk7lIv/PmFn5tv2r00cA4mTK4MjuYKWcxnd9z1KyQ
 P34o1yS3vc0EkVnciL9Cp40sipzH9+KJPdZAU0FgVTYgaQLJJuJeuYnCHRkMPcr/bf+f
 ME3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhKVoOmeEWDKFtT5ZwUFEHOiTqKFrOZEBtkXEJQL77zet51u64psBRiTeEPE1ZSDXB9kizIhHnHJHe@nongnu.org
X-Gm-Message-State: AOJu0YyjdiJkN47jrpn9/8ZMvMk8bVVPpq9XylyLbjFfOQHonnKmlhMU
 qN9Bqc/WE7tV1aWCbkUuFfQfCr/N/dOH8/Cf1KNXN2WEZyA5sVTzL2/2TR0yJj3NM1TrZ09u0o1
 Iy+g7+r8=
X-Gm-Gg: ATEYQzxufFDgRrY2e+iMhUhexbMSDdSR+QgOwUZz0qHOnY8+9A5NsPom+6CKSILo7h1
 CWTRpC/2NHQe29PRCE4cSyf2HUgb0SEgx7qGr3bB68GFjv/8n2lieyrbQikow4wksW1PhznHpVe
 CW4cMCjxXnQSrFGC2CYG7PDDcLltXLGRx+umKr8U7nNG5BLcA4uLA49bGMonhJ4gzSDXeER3RLK
 fvA1Itk91Jgpt3glhf6hD77vkspPgqrukkxSFa2OZgd0FLN8e+rEDsGmw7f0RYqx9Lo1fJfetWQ
 9M7xbHZQV5X+kAF10W0IxKpQnPSlsnqHLyCXGVXEtFAeMZR1zMgcF4rrRQpUqPd32Jfsa4xpfJ/
 /T+qpzuxVHdR0Z7OHyKX1epjcU/fhd+V1cGgKG5aFhDRiqbNGX4ow6sarnzNxoLngkdn52HPdqk
 E5W08m8aQXBaxSNJZmt1SOn+aq4zJbE6b2VDFJSgz2FiiJKY+vjmeem/QF/14qWT7V/H7l7RZ83
 w4oUSMZxKU=
X-Received: by 2002:a05:600c:a408:b0:485:3f58:d9f with SMTP id
 5b1f17b1804b1-487160a24e2mr43858395e9.30.1774451895998; 
 Wed, 25 Mar 2026 08:18:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871e60322asm1408455e9.7.2026.03.25.08.18.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 08:18:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org
Subject: [NOTFORMERGE PATCH 6/6] buildsys: Allow building guest-agent on
 32-bit hosts
Date: Wed, 25 Mar 2026 16:17:28 +0100
Message-ID: <20260325151728.45378-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Partially revert commit range 5053e0a65db...90e2e8ada7c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure   | 64 +++++++++++++++++++++++++++++++++++++++++++----------
 meson.build |  2 +-
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index eea90306728..e984ec2bd3c 100755
--- a/configure
+++ b/configure
@@ -381,6 +381,8 @@ fi
 if test ! -z "$cpu" ; then
   # command line argument
   :
+elif check_define __i386__ ; then
+  cpu="i386"
 elif check_define __x86_64__ ; then
   if check_define __ILP32__ ; then
     cpu="x32"
@@ -399,22 +401,30 @@ elif check_define _ARCH_PPC64 ; then
   else
     cpu="ppc64"
   fi
-elif check_define __mips64 ; then
-  cpu="mips64"
+elif check_define __mips__ ; then
+  if check_define __mips64 ; then
+    cpu="mips64"
+  fi
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
   else
     cpu="s390"
   fi
-elif check_define __riscv && check_define _LP64 ; then
-  cpu="riscv64"
+elif check_define __riscv ; then
+  if check_define _LP64 ; then
+    cpu="riscv64"
+  else
+    cpu="riscv32"
+  fi
+elif check_define __arm__ ; then
+  cpu="arm"
 elif check_define __aarch64__ ; then
   cpu="aarch64"
 elif check_define __loongarch64 ; then
   cpu="loongarch64"
 elif check_define EMSCRIPTEN ; then
-  error_exit "wasm64 must be specified to the cpu flag"
+  error_exit "wasm32 or wasm64 must be specified to the cpu flag"
 else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
@@ -440,6 +450,18 @@ case "$cpu" in
     linux_arch=arm64
     ;;
 
+  armv*b|armv*l|arm)
+    cpu=arm
+    host_arch=arm
+    ;;
+
+  i386|i486|i586|i686)
+    cpu="i386"
+    host_arch=i386
+    linux_arch=x86
+    CPU_CFLAGS="-m32"
+    ;;
+
   loongarch*)
     cpu=loongarch64
     host_arch=loongarch64
@@ -448,7 +470,7 @@ case "$cpu" in
 
   mips64*|mipsisa64*)
     cpu=mips64
-    host_arch=mips64
+    host_arch=mips
     linux_arch=mips
     ;;
 
@@ -464,8 +486,8 @@ case "$cpu" in
     CPU_CFLAGS="-m64 -mlittle-endian"
     ;;
 
-  riscv64)
-    host_arch=riscv64
+  riscv32 | riscv64)
+    host_arch=riscv
     linux_arch=riscv
     ;;
 
@@ -500,6 +522,9 @@ case "$cpu" in
     linux_arch=x86
     CPU_CFLAGS="-m64"
     ;;
+  wasm32)
+    CPU_CFLAGS="-m32"
+    ;;
   wasm64)
     CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
@@ -1287,7 +1312,7 @@ EOF
     test "$bigendian" = no && rust_arch=${rust_arch}el
     ;;
 
-  riscv64)
+  riscv32|riscv64)
     # e.g. riscv64gc-unknown-linux-gnu, but riscv64-linux-android
     test "$android" = no && rust_arch=${rust_arch}gc
     ;;
@@ -1449,18 +1474,26 @@ probe_target_compiler() {
         container_image=debian-all-test-cross
         container_cross_prefix=aarch64-linux-gnu-
         ;;
-      alpha|hppa|m68k|mips|riscv64|sh4|sparc64)
+      hppa|m68k|mips|riscv64|sparc64)
         container_image=debian-all-test-cross
         ;;
       mips64)
         container_image=debian-all-test-cross
         container_cross_prefix=mips64-linux-gnuabi64-
         ;;
-      ppc|ppc64|ppc64le)
+      ppc64|ppc64le)
         container_image=debian-all-test-cross
         container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
         ;;
 
+      # debian-legacy-test-cross architectures (need Debian 11)
+      # - libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
+      # - sh4-linux-user: binaries don't run with bookworm compiler
+
+      alpha|sh4)
+        container_image=debian-legacy-test-cross
+        ;;
+
       # architectures with individual containers
 
       aarch64)
@@ -1930,7 +1963,14 @@ if test "$skip_meson" = no; then
   if test "$cross_compile" = "yes"; then
     echo "[host_machine]" >> $cross
     echo "system = '$host_os'" >> $cross
-    echo "cpu_family = '$cpu'" >> $cross
+    case "$cpu" in
+        i386)
+            echo "cpu_family = 'x86'" >> $cross
+            ;;
+        *)
+            echo "cpu_family = '$cpu'" >> $cross
+            ;;
+    esac
     echo "cpu = '$cpu'" >> $cross
     if test "$bigendian" = "yes" ; then
         echo "endian = 'big'" >> $cross
diff --git a/meson.build b/meson.build
index d7c4095b395..ae412263ec7 100644
--- a/meson.build
+++ b/meson.build
@@ -323,7 +323,7 @@ endif
 # Compiler flags #
 ##################
 
-if cc.sizeof('void *') < 8
+if not have_ga and cc.sizeof('void *') < 8
   error('QEMU requires a 64-bit CPU host architecture')
 endif
 
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72305CDDE70
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ZdG-0007N0-JP; Wed, 23 Oct 2024 07:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3ZdB-0007KS-P6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zd7-0003Al-IA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:25 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so612788a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683260; x=1730288060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pLXAr/OU0jkbK3hvA7jKCluJF6NjbiqDXh6Q2a0Cto=;
 b=xNqooZ8H09y9F7nP7yXiphk78kIYgcBQ5c34aqCW7e7AeIiUZcPzBDi7pHGPAuDRET
 Wgo/w4+lmY0xkEfUTy/VPGhlVx0huA2AfiXwBjQ7GDmsCO8kcGkznxxDLxPBN3G2IQJz
 xBZYrxvqSoBzYcpKyGSAhj1ioHuwlWlZxtafn7a9jLfXQ+hv3eM59P6+62T/1sgcQ8jL
 JHMKWPVAooOkGnf/8ORs/exaZ3KeM0Oh2TKppOL+TZm8NWh1rxs1a2UktW3TFnrZZcha
 M24slX4MUUNinpha4N9TOOxROXYkVZ/4GxZgCiNBG3DvcQ82yz2PnL/0LE4/Q1J7O1Yr
 wwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683260; x=1730288060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pLXAr/OU0jkbK3hvA7jKCluJF6NjbiqDXh6Q2a0Cto=;
 b=N8Y4VIzhqlhysGG3arOqshA+L55oKFypbNpjbItK/PAHFKdQkxI0J78qZXAVfA6pgq
 SELURETs48/fXWZYdsSDpgQydt+d16HS+tXyGOWZV2xQ3SjxzarvDJx+dMcNZXjpQVb6
 V9IU5aI/xTT8EcPzTMSGgzak6OTg/IN9xq7atjcdTv/RuRiuTmDZMADLUvYQCKDxCwZG
 f98R9tcqtkazPBx0CFS7BBFwAPcVX7DUK2ylG563SNhwAOGMiFbS+0clohhusmmkl9QZ
 4NtxR+k9M5O3EtB093ENi8zKRagGZO6vKhVjokJyW6WE6TlQDpm2yQD73D1PuUB3ZRHR
 LXcQ==
X-Gm-Message-State: AOJu0YzoUeVXLTdaoW40362C0NJk14+sNL+6lo9T0Deso0eFIuI/DzFa
 Ym94mONBt7JksJPi2Do45007E82pp4YATuk2JDArVRB4n4TqaUJDhaXCLGXYcO4=
X-Google-Smtp-Source: AGHT+IHYuCpsrlKmDqqGYIBBNa+vFGcIlA5SXBodkYMC+HhiJM5pz5ipdH/LGWzv9nLWvjwuCPYAbQ==
X-Received: by 2002:a05:6402:42d2:b0:5c9:60a:5025 with SMTP id
 4fb4d7f45d1cf-5cb8b53d00dmr2462019a12.9.1729683259827; 
 Wed, 23 Oct 2024 04:34:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c6b18csm4250181a12.62.2024.10.23.04.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:34:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 397B25FABE;
 Wed, 23 Oct 2024 12:34:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 13/18] tests/tcg: enable basic testing for
 aarch64_be-linux-user
Date: Wed, 23 Oct 2024 12:34:01 +0100
Message-Id: <20241023113406.1284676-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023113406.1284676-1-alex.bennee@linaro.org>
References: <20241023113406.1284676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We didn't notice breakage of aarch64_be because we don't have any TCG
tests for it. However while the existing aarch64 compiler can target
big-endian builds no one packages a BE libc. Instead we bang some
rocks together to do the most basic of hello world with a nostdlib
syscall test.

Message-Id: <20241022105614.839199-14-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix checkpatch complaints
v3
  - fix libc typo
---
 configure                            |  5 ++++
 tests/tcg/aarch64_be/hello.c         | 35 ++++++++++++++++++++++++++++
 tests/tcg/Makefile.target            |  7 +++++-
 tests/tcg/aarch64_be/Makefile.target | 17 ++++++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64_be/hello.c
 create mode 100644 tests/tcg/aarch64_be/Makefile.target

diff --git a/configure b/configure
index 72d1a94225..7dd3400ccb 100755
--- a/configure
+++ b/configure
@@ -1418,6 +1418,7 @@ probe_target_compiler() {
   target_arch=${1%%-*}
   case $target_arch in
     aarch64) container_hosts="x86_64 aarch64" ;;
+    aarch64_be) container_hosts="x86_64 aarch64" ;;
     alpha) container_hosts=x86_64 ;;
     arm) container_hosts="x86_64 aarch64" ;;
     hexagon) container_hosts=x86_64 ;;
@@ -1447,6 +1448,10 @@ probe_target_compiler() {
     case $target_arch in
       # debian-all-test-cross architectures
 
+      aarch64_be)
+        container_image=debian-all-test-cross
+        container_cross_prefix=aarch64-linux-gnu-
+        ;;
       hppa|m68k|mips|riscv64|sparc64)
         container_image=debian-all-test-cross
         ;;
diff --git a/tests/tcg/aarch64_be/hello.c b/tests/tcg/aarch64_be/hello.c
new file mode 100644
index 0000000000..a9b2ab45de
--- /dev/null
+++ b/tests/tcg/aarch64_be/hello.c
@@ -0,0 +1,35 @@
+/*
+ * Non-libc syscall hello world for Aarch64 BE
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define __NR_write 64
+#define __NR_exit 93
+
+int write(int fd, char *buf, int len)
+{
+    register int x0 __asm__("x0") = fd;
+    register char *x1 __asm__("x1") = buf;
+    register int x2 __asm__("x2") = len;
+    register int x8 __asm__("x8") = __NR_write;
+
+    asm volatile("svc #0" : : "r"(x0), "r"(x1), "r"(x2), "r"(x8));
+
+    return len;
+}
+
+void exit(int ret)
+{
+    register int x0 __asm__("x0") = ret;
+    register int x8 __asm__("x8") = __NR_exit;
+
+    asm volatile("svc #0" : : "r"(x0), "r"(x8));
+    __builtin_unreachable();
+}
+
+void _start(void)
+{
+    write(1, "Hello World\n", 12);
+    exit(0);
+}
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 2da70b2fcf..9722145b97 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -103,9 +103,14 @@ ifeq ($(filter %-softmmu, $(TARGET)),)
 # then the target. If there are common tests shared between
 # sub-targets (e.g. ARM & AArch64) then it is up to
 # $(TARGET_NAME)/Makefile.target to include the common parent
-# architecture in its VPATH.
+# architecture in its VPATH. However some targets are so minimal we
+# can't even build the multiarch tests.
+ifneq ($(filter $(TARGET_NAME),aarch64_be),)
+-include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
+else
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
+endif
 
 # Add the common build options
 CFLAGS+=-Wall -Werror -O0 -g -fno-strict-aliasing
diff --git a/tests/tcg/aarch64_be/Makefile.target b/tests/tcg/aarch64_be/Makefile.target
new file mode 100644
index 0000000000..cbe5fa0b2d
--- /dev/null
+++ b/tests/tcg/aarch64_be/Makefile.target
@@ -0,0 +1,17 @@
+# -*- Mode: makefile -*-
+#
+# A super basic AArch64 BE makefile. As we don't have any big-endian
+# libc available the best we can do is a basic Hello World.
+
+AARCH64BE_SRC=$(SRC_PATH)/tests/tcg/aarch64_be
+VPATH += $(AARCH64BE_SRC)
+
+AARCH64BE_TEST_SRCS=$(notdir $(wildcard $(AARCH64BE_SRC)/*.c))
+AARCH64BE_TESTS=$(AARCH64BE_TEST_SRCS:.c=)
+#MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
+
+# We need to specify big-endian cflags
+CFLAGS +=-mbig-endian -ffreestanding
+LDFLAGS +=-nostdlib
+
+TESTS += $(AARCH64BE_TESTS)
-- 
2.39.5



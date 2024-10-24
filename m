Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE79ACDDE6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uZv-0001Ax-CV; Thu, 24 Oct 2024 05:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZn-0001A4-Rh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:20 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZm-0003pX-3R
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:19 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so316251066b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763776; x=1730368576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A03x4ApYrzG4JVI099lHX3Os6mDX4d3dhyCYN2Nj2wk=;
 b=gkTR9a7GRw4twuIas8dysy9i8btH5tardylC+YKdFeI40vczg1qCYkeIVCqxnZUGXd
 RlKSvTYuV42r1yWEyqeKIyse0CWLyLF1WSg3lud7HlEqYvi8Ld6Ac8VKa6zeVkV4fm6T
 uNjBLVweQxPVvHnVH35AgLLpj3aiyZ3JLMsmKzL97D3al3SkwUTbRPofvogoR6cbB+Pw
 2UwsZ7Zkw3B7Br6v6DqlH4cnVNiCneS6cto374vDTDg1NNbnFKByCEa7pmMWdqIGxBBg
 BmOnmR+kckPloU8HzABfwDme+ZHQFKiorLOC/1hOqFfRxwZjwHhAYBcRiAS3FEgYnQCM
 TG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763776; x=1730368576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A03x4ApYrzG4JVI099lHX3Os6mDX4d3dhyCYN2Nj2wk=;
 b=r4O5hWazNKLnOaAFICOcNU8bjVAKyCDLJ0hr4UTeVPYFB3CxW7RhmHoEWvC3evovBb
 xjlHM87/zXlePSwZls+LR7oLG4kfPjtFQfdHdkJjK+iV3ZhPD8Kc8sV24mpepNIi8x4a
 Gey+iaV5uma1t8wN9gNQ1n5Lm6zZ+U2t0bBF6JcPxHcMgnI9mLjyLRjkKhFjXw9cbgd8
 FxKVmdJZt5F7b+3vR5ojZYEVkp6yB3gNotzskQRykxwEragy1MUlHBtIP5c9EXayW0UP
 Sxh0fSvUrozfaNzE5k45wUGu8yOPODso2ZE36oaihaAYPZgskSeel8vhYH/qhqytIT4M
 Of9Q==
X-Gm-Message-State: AOJu0Yx1oVyOomFNCrO4Cw0pEhsf0WRX5zU2tfQooiI8zljgSt9VtocM
 fpkzV5uGpzVSaz66/FBwyDW+9MEan/hOrmSirtT+L7UMhh2nairWf7HBtiZrL0A=
X-Google-Smtp-Source: AGHT+IEpJhA5Mu9CDgeirkDU9E6i0Xb3uDgefNA6HWIxoC9psgD/Je2YL/R2WCL04ADplp39J9gvRA==
X-Received: by 2002:a17:907:1c9c:b0:a9a:1af0:ee1a with SMTP id
 a640c23a62f3a-a9ad199c38bmr149257766b.6.1729763776440; 
 Thu, 24 Oct 2024 02:56:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912edb6asm592120866b.49.2024.10.24.02.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2BB5B5FABE;
 Thu, 24 Oct 2024 10:56:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 13/17] tests/tcg: enable basic testing for aarch64_be-linux-user
Date: Thu, 24 Oct 2024 10:55:59 +0100
Message-Id: <20241024095603.1813285-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-14-alex.bennee@linaro.org>

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



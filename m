Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82038CCF9E8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVYs-0001vP-9w; Wed, 25 Sep 2024 13:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYR-0000Kx-Hb
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYM-0000cF-QL
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cba8340beso7769395e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284308; x=1727889108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaJivYDlItR4YIDqMIuLxegmAwwZvWWIxpxaaVqdrBQ=;
 b=IR84kaqn5iCqReAzD2i03JC82nHAz+os3aeXOEOw13yGB0wbCh+dKtFIAdpi7mEZS5
 pqP29+QdceDMkzpAgAG+KeIbd4jdKelW67iixrLZRc34r6MQ2AF+pcJbXhG06Qkozu1E
 uvLV1YTw3AkzpJsmJ+7JaMsG9nPK2ERpeRCASG2FWCENKTpAwNNvtDiBCzchHV0HL/F3
 lLpwg/QnKwr7txSrjYmemRRmhPQoXDH1TaXDj37gDoPsBIYzwHcsH0D5gtu1SUo6XJi1
 jGXQS0+JobGJr/53mX44xUyslDSsTfYUvA4XYksocuZ+mmigX2hggZYrVSppAW1ooGuh
 YwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284308; x=1727889108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaJivYDlItR4YIDqMIuLxegmAwwZvWWIxpxaaVqdrBQ=;
 b=K6a8Q6ZUq6EBgaSSXx1NscTcMgKcJ/I0lHmZ/0r807Z4pOkM9tqyMz609NjKzEGsc6
 cW1MsNGu+rMXGb/EKRQ378BQo517fLiVl+PC0BmDFPRuiDIQo717uks/7zJ+G81g8mtc
 BWxZiI9LP5+lSSfUY/9HJeLfXcRyX2YhhoM4SRCjIAljZSwl5b5R9+NGK55b9kJZhuSN
 NAYz7nzT4IU+ksEpGSwmekN02qID1E+zKMmYaX3lvEeumQJ7lPwfuCqPDNoQzH745SBe
 po0iZlbJGeSk7gkY8FBmulp33kwRaaD9mc3tvFpnqXYnKHhCFqSL/Plxtm8OFnISt4HU
 tvkQ==
X-Gm-Message-State: AOJu0YxBL8PX7R0SQeEes8RluF98mCOysBqmd1Hs0JRElQ/tmUQ0th6o
 W6jTKDBq5wGq8JJD1pXsDxaPF1O0aJ2bZdNEJSHt+kJDfqzP3Z9IdvqGYrMk6hU=
X-Google-Smtp-Source: AGHT+IGEUdwdXmmXxyj5s5u8wIU8mWo+iyIURbnXAseiU9n2QlRwwUQiN93/e4JQ8cQ12tQq4BVfKQ==
X-Received: by 2002:a05:600c:3542:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-42f521cb7b9mr2431035e9.4.1727284308140; 
 Wed, 25 Sep 2024 10:11:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969f1fe4sm24113855e9.14.2024.09.25.10.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:11:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4FA755FAAF;
 Wed, 25 Sep 2024 18:11:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, kvm@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 10/10] tests/tcg: enable basic testing for
 aarch64_be-linux-user
Date: Wed, 25 Sep 2024 18:11:40 +0100
Message-Id: <20240925171140.1307033-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925171140.1307033-1-alex.bennee@linaro.org>
References: <20240925171140.1307033-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                            |  5 ++++
 tests/tcg/aarch64_be/hello.c         | 35 ++++++++++++++++++++++++++++
 tests/tcg/Makefile.target            |  7 +++++-
 tests/tcg/aarch64_be/Makefile.target | 17 ++++++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64_be/hello.c
 create mode 100644 tests/tcg/aarch64_be/Makefile.target

diff --git a/configure b/configure
index aa7aae70fa..1aebf8ece0 100755
--- a/configure
+++ b/configure
@@ -1274,6 +1274,7 @@ probe_target_compiler() {
   target_arch=${1%%-*}
   case $target_arch in
     aarch64) container_hosts="x86_64 aarch64" ;;
+    aarch64_be) container_hosts="x86_64 aarch64" ;;
     alpha) container_hosts=x86_64 ;;
     arm) container_hosts="x86_64 aarch64" ;;
     hexagon) container_hosts=x86_64 ;;
@@ -1303,6 +1304,10 @@ probe_target_compiler() {
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
index 0000000000..93c6074db1
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
+int write(int fd, char * buf, int len)
+{
+    register int x0 __asm__("x0") = fd;
+    register char * x1 __asm__("x1") = buf;
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
index 0000000000..297d2cf71c
--- /dev/null
+++ b/tests/tcg/aarch64_be/Makefile.target
@@ -0,0 +1,17 @@
+# -*- Mode: makefile -*-
+#
+# A super basic AArch64 BE makefile. As we don't have any big-endian
+#l ibc available the best we can do is a basic Hello World.
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



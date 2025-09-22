Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF555CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d0m-0004TG-IZ; Mon, 22 Sep 2025 05:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czQ-0002F9-3d
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cz5-0000ea-Pt
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45f2acb5f42so31194875e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533841; x=1759138641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSjEVFuFYZn/BZ8ABzOt09gLvPSy+iL1wdNE+B6ErNg=;
 b=JgCidCzgdXmVUdaQuWvNEcmtRszb8B8VS+54uis+3QYTcfYWZQcy51wt32xAGHKdqj
 SKKZc0aBJJuceIgB/5CToRrpWVVl2kHxv0h80tOdpbTbTcG6V5dZKJnjzivLjyhbbWb3
 LbCmR55NrUv4kzIjRLaQxDE0aPf+1BK95bbt5vv6LeTvjKRoBfNrsG4YxFstSm4CZcH+
 MXnmT0d9WJ6oEDvgAOlXlTHNLdlDir9fjx+UsyjdOAyF1hRZpzgTnBbaNqD3O63CyXqz
 AqLTZjASadKrsIwwK8DFQimrKJaVY5bob6GO4phE481AMMCesD2DvNXXdy0K6hnBY1Cm
 pCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533841; x=1759138641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSjEVFuFYZn/BZ8ABzOt09gLvPSy+iL1wdNE+B6ErNg=;
 b=MUwDBBbH1f3z24rQ2kbt5mM8YrQBNja7/eZSUyckTadIx/6Vps+CYXWi9Lh0N96Vft
 YrC+RvjKGep97PV+AstOXqt26Lh6A7C6/AkhbXPkk9cc1LNFa46MS90j2yT/IyjbvwDZ
 f+EDcWScUVjs+OLRGjmvX1ZXGUa05GcL8l4yFK1Z5xbyJYRyKJSCCjiv83NCr1/gt/UZ
 Oa5YAAzeiCA3e7eO/LmzNHUjJOKQtHmjXBpaLfCiIPj6hL4dB5Ne08iEpvIe/06uKoBc
 IMDJ4lxpAXOjjZ1qY/A0zm0owbKy85uUGMV3ouXiiqIPp6agHyuQAUzkrpHLvcLVnwbV
 dwKA==
X-Gm-Message-State: AOJu0Yyh3M73+ElxSdd40Ip+6EhBx4/r7IFEKFszxvM4BX5j4sLx9MVv
 fcepf1KquxHHHVmI+aQ3vwCrU60cXOoMtoJrWrwnHS303TsMaz7DKuYEx1aEyNBRbS8=
X-Gm-Gg: ASbGncs367UbV8KF2B+RZrEffBhNv3p4PTHuCU7vMY74RRHyJSPLRfR5XGOQKwguW+B
 z2Rx2u4hRlTjaUCdHPuHuOx+DvNSQjBYPjwD02nXagG2XyCZfBuMZnhacicn960BxeW1x1E/vYD
 NGyQyPxHHTJ9Z7iQFpQ9IHHgWonehuHophzYS/x2+7XRir8SILkyKzRswoSpy6ThCv/WrFWyYnm
 O+pC8gtx4M/ms/QAeXuI8/MxMq13BPIv7AvmXtca6hEcU84L5jghpwsVDGF3XdWePPU6wK711pm
 XqSUgfxet69UCRb4CzP2yfEwsQjw4r1MQSvs9NiEDarycX9b+t8gCOYYnSHEm0lE1yiCoe9w369
 iUKJno4wXAEeGuBt08Un7fpQ=
X-Google-Smtp-Source: AGHT+IHdc+761hu/BrQJYWwM4R1nbzRtw7bblEZsdThCt7pG6nhnQJr5UG8J581AlrZgKbb36QCFzw==
X-Received: by 2002:a05:600c:b99:b0:45d:d79c:7503 with SMTP id
 5b1f17b1804b1-467aaefd912mr119068195e9.12.1758533840883; 
 Mon, 22 Sep 2025 02:37:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46dd9a69466sm16427455e9.1.2025.09.22.02.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1F7A85F9ED;
 Mon, 22 Sep 2025 10:37:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 06/25] semihosting/guestfd: compile once for system/user
Date: Mon, 22 Sep 2025 10:36:51 +0100
Message-ID: <20250922093711.2768983-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We move relevant code to semihosting/arm-compat-semi.c, and add
functions to query CONFIG_ARM_COMPATIBLE_SEMIHOSTING at runtime.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/semihosting/guestfd.h      |  7 -------
 include/semihosting/semihost.h     |  2 ++
 semihosting/arm-compat-semi-stub.c | 19 +++++++++++++++++++
 semihosting/arm-compat-semi.c      | 26 ++++++++++++++++++++++++++
 semihosting/guestfd.c              | 26 +++++---------------------
 semihosting/meson.build            | 11 ++++++-----
 6 files changed, 58 insertions(+), 33 deletions(-)
 create mode 100644 semihosting/arm-compat-semi-stub.c

diff --git a/include/semihosting/guestfd.h b/include/semihosting/guestfd.h
index 3d426fedab3..a7ea1041ea0 100644
--- a/include/semihosting/guestfd.h
+++ b/include/semihosting/guestfd.h
@@ -35,13 +35,6 @@ typedef struct GuestFD {
     };
 } GuestFD;
 
-/*
- * For ARM semihosting, we have a separate structure for routing
- * data for the console which is outside the guest fd address space.
- */
-extern GuestFD console_in_gf;
-extern GuestFD console_out_gf;
-
 /**
  * alloc_guestfd:
  *
diff --git a/include/semihosting/semihost.h b/include/semihosting/semihost.h
index b03e6375787..231dc890395 100644
--- a/include/semihosting/semihost.h
+++ b/include/semihosting/semihost.h
@@ -33,6 +33,8 @@ typedef enum SemihostingTarget {
  * Return true if guest code is allowed to make semihosting calls.
  */
 bool semihosting_enabled(bool is_user);
+bool semihosting_arm_compatible(void);
+void semihosting_arm_compatible_init(void);
 
 SemihostingTarget semihosting_get_target(void);
 const char *semihosting_get_arg(int i);
diff --git a/semihosting/arm-compat-semi-stub.c b/semihosting/arm-compat-semi-stub.c
new file mode 100644
index 00000000000..bfa3681e267
--- /dev/null
+++ b/semihosting/arm-compat-semi-stub.c
@@ -0,0 +1,19 @@
+/*
+ * Stubs for platforms different from ARM
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "semihosting/semihost.h"
+#include <glib.h>
+
+bool semihosting_arm_compatible(void)
+{
+    return false;
+}
+
+void semihosting_arm_compatible_init(void)
+{
+    g_assert_not_reached();
+}
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 64ddc749bf8..a239cfc5a9d 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -101,6 +101,13 @@ static int gdb_open_modeflags[12] = {
     GDB_O_RDWR | GDB_O_CREAT | GDB_O_APPEND,
 };
 
+/*
+ * For ARM semihosting, we have a separate structure for routing
+ * data for the console which is outside the guest fd address space.
+ */
+static GuestFD console_in_gf;
+static GuestFD console_out_gf;
+
 #ifndef CONFIG_USER_ONLY
 
 /**
@@ -353,6 +360,25 @@ static const uint8_t featurefile_data[] = {
     SH_EXT_EXIT_EXTENDED | SH_EXT_STDOUT_STDERR, /* Feature byte 0 */
 };
 
+bool semihosting_arm_compatible(void)
+{
+    return true;
+}
+
+void semihosting_arm_compatible_init(void)
+{
+    /* For ARM-compat, the console is in a separate namespace. */
+    if (use_gdb_syscalls()) {
+        console_in_gf.type = GuestFDGDB;
+        console_in_gf.hostfd = 0;
+        console_out_gf.type = GuestFDGDB;
+        console_out_gf.hostfd = 2;
+    } else {
+        console_in_gf.type = GuestFDConsole;
+        console_out_gf.type = GuestFDConsole;
+    }
+}
+
 /*
  * Do a semihosting call.
  *
diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
index d3241434c51..e8f236c690c 100644
--- a/semihosting/guestfd.c
+++ b/semihosting/guestfd.c
@@ -12,35 +12,20 @@
 #include "gdbstub/syscalls.h"
 #include "semihosting/semihost.h"
 #include "semihosting/guestfd.h"
-#ifndef CONFIG_USER_ONLY
-#include CONFIG_DEVICES
-#endif
 
 static GArray *guestfd_array;
 
-#ifdef CONFIG_ARM_COMPATIBLE_SEMIHOSTING
-GuestFD console_in_gf;
-GuestFD console_out_gf;
-#endif
-
 void qemu_semihosting_guestfd_init(void)
 {
     /* New entries zero-initialized, i.e. type GuestFDUnused */
     guestfd_array = g_array_new(FALSE, TRUE, sizeof(GuestFD));
 
-#ifdef CONFIG_ARM_COMPATIBLE_SEMIHOSTING
-    /* For ARM-compat, the console is in a separate namespace. */
-    if (use_gdb_syscalls()) {
-        console_in_gf.type = GuestFDGDB;
-        console_in_gf.hostfd = 0;
-        console_out_gf.type = GuestFDGDB;
-        console_out_gf.hostfd = 2;
-    } else {
-        console_in_gf.type = GuestFDConsole;
-        console_out_gf.type = GuestFDConsole;
+    if (semihosting_arm_compatible()) {
+        semihosting_arm_compatible_init();
+        return;
     }
-#else
-    /* Otherwise, the stdio file descriptors apply. */
+
+    /* Out of ARM, the stdio file descriptors apply. */
     guestfd_array = g_array_set_size(guestfd_array, 3);
 #ifndef CONFIG_USER_ONLY
     if (!use_gdb_syscalls()) {
@@ -54,7 +39,6 @@ void qemu_semihosting_guestfd_init(void)
     associate_guestfd(0, 0);
     associate_guestfd(1, 1);
     associate_guestfd(2, 2);
-#endif
 }
 
 /*
diff --git a/semihosting/meson.build b/semihosting/meson.build
index 77200a7f27b..bb0db323937 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -1,17 +1,18 @@
-specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
-  'guestfd.c',
-))
-
 common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
-user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
+user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
+  'user.c',
+  'guestfd.c'))
 system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
+  'guestfd.c',
   'uaccess.c',
   'syscalls.c',
 ), if_false: files(
   'stubs-system.c',
 ))
+system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+  if_false: files('arm-compat-semi-stub.c'))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
                 if_true: files('syscalls.c'))
-- 
2.47.3



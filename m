Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0EAC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTbT-0004H9-OZ; Thu, 04 Jul 2024 17:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTbO-0003Ts-3a; Thu, 04 Jul 2024 17:02:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTbK-0004T2-6Q; Thu, 04 Jul 2024 17:02:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D509E77574;
 Fri,  5 Jul 2024 00:00:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EBC76FECAD;
 Fri,  5 Jul 2024 00:00:56 +0300 (MSK)
Received: (nullmailer pid 1507781 invoked by uid 1000);
 Thu, 04 Jul 2024 21:00:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 22/22] tcg/optimize: Fix TCG_COND_TST* simplification
 of setcond2
Date: Fri,  5 Jul 2024 00:00:52 +0300
Message-Id: <20240704210055.1507652-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
References: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Argument ordering for setcond2 is:

  output, a_low, a_high, b_low, b_high, cond

The test is supposed to be against b_low, not a_high.

Cc: qemu-stable@nongnu.org
Fixes: ceb9ee06b71 ("tcg/optimize: Handle TCG_COND_TST{EQ,NE}")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2413
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240701024623.1265028-1-richard.henderson@linaro.org>
(cherry picked from commit a71d9dfbf63db42d6e6ae87fc112d1f5502183bd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2e9e5725a9..8c49229d6f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2274,7 +2274,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 
     case TCG_COND_TSTEQ:
     case TCG_COND_TSTNE:
-        if (arg_is_const_val(op->args[2], 0)) {
+        if (arg_is_const_val(op->args[3], 0)) {
             goto do_setcond_high;
         }
         if (arg_is_const_val(op->args[4], 0)) {
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index e64aab1b81..1d427cdc2c 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -8,6 +8,8 @@
 
 include $(SRC_PATH)/tests/tcg/i386/Makefile.target
 
+X86_64_TESTS += test-2413
+
 ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
 X86_64_TESTS += vsyscall
 X86_64_TESTS += noexec
diff --git a/tests/tcg/x86_64/test-2413.c b/tests/tcg/x86_64/test-2413.c
new file mode 100644
index 0000000000..456e5332fc
--- /dev/null
+++ b/tests/tcg/x86_64/test-2413.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2024 Linaro, Ltd. */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2413 */
+
+#include <assert.h>
+
+void test(unsigned long *a, unsigned long *d, unsigned long c)
+{
+    asm("xorl %%eax, %%eax\n\t"
+        "xorl %%edx, %%edx\n\t"
+        "testb $0x20, %%cl\n\t"
+        "sete %%al\n\t"
+        "setne %%dl\n\t"
+        "shll %%cl, %%eax\n\t"
+        "shll %%cl, %%edx\n\t"
+        : "=a"(*a), "=d"(*d)
+        : "c"(c));
+}
+
+int main(void)
+{
+    unsigned long a, c, d;
+
+    for (c = 0; c < 64; c++) {
+        test(&a, &d, c);
+        assert(a == (c & 0x20 ? 0 : 1u << (c & 0x1f)));
+        assert(d == (c & 0x20 ? 1u << (c & 0x1f) : 0));
+    }
+    return 0;
+}
-- 
2.39.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B610C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GQS-00052h-GM; Tue, 07 May 2024 04:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GQE-0004VG-Jp; Tue, 07 May 2024 04:43:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GQB-0003Lb-8f; Tue, 07 May 2024 04:43:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8CF2B64BD4;
 Tue,  7 May 2024 11:42:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7A946C85BD;
 Tue,  7 May 2024 11:42:30 +0300 (MSK)
Received: (nullmailer pid 1026561 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 16/16] target/sh4: Fix SUBV opcode
Date: Tue,  7 May 2024 11:42:15 +0300
Message-Id: <20240507084226.1026455-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
References: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The documentation says:

  SUBV Rm, Rn        Rn - Rm -> Rn, underflow -> T

The overflow / underflow can be calculated as:

  T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31

However we were using the incorrect:

  T = ((Rn ^ Rm) & (Result ^ Rm)) >> 31

Fix by using the Rn register instead of Rm.

Add tests provided by Paul Cercueil.

Cc: qemu-stable@nongnu.org
Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Suggested-by: Paul Cercueil <paul@crapouillou.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2318
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20240430163125.77430-3-philmd@linaro.org>
(cherry picked from commit e88a856efd1d3c3ffa8e53da4831eff8da290808)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index d8dcfc3a20..5c0a4cce7a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -934,7 +934,7 @@ static void _decode_opc(DisasContext * ctx)
             t0 = tcg_temp_new();
             tcg_gen_sub_i32(t0, REG(B11_8), REG(B7_4));
             t1 = tcg_temp_new();
-            tcg_gen_xor_i32(t1, t0, REG(B7_4));
+            tcg_gen_xor_i32(t1, t0, REG(B11_8));
             t2 = tcg_temp_new();
             tcg_gen_xor_i32(t2, REG(B11_8), REG(B7_4));
             tcg_gen_and_i32(t1, t1, t2);
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 39751c41b2..a523a0d2c8 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -23,3 +23,6 @@ TESTS += test-macw
 
 test-addv: CFLAGS += -O -g
 TESTS += test-addv
+
+test-subv: CFLAGS += -O -g
+TESTS += test-subv
diff --git a/tests/tcg/sh4/test-subv.c b/tests/tcg/sh4/test-subv.c
new file mode 100644
index 0000000000..a3c2db96e4
--- /dev/null
+++ b/tests/tcg/sh4/test-subv.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static void subv(const int a, const int b, const int res, const int carry)
+{
+    int o = a, c;
+
+    asm volatile("subv %2,%0\n"
+                 "movt %1\n"
+                 : "+r"(o), "=r"(c) : "r"(b) : );
+
+    if (c != carry || o != res) {
+        printf("SUBV %d, %d = %d/%d [T = %d/%d]\n", a, b, o, res, c, carry);
+        abort();
+    }
+}
+
+int main(void)
+{
+    subv(INT_MIN, 1, INT_MAX, 1);
+    subv(INT_MAX, -1, INT_MIN, 1);
+    subv(INT_MAX, 1, INT_MAX - 1, 0);
+    subv(0, 1, -1, 0);
+    subv(-1, -1, 0, 0);
+
+    return 0;
+}
-- 
2.39.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47BBC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GQO-0004fI-Cw; Tue, 07 May 2024 04:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GQ9-0004SM-At; Tue, 07 May 2024 04:43:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GQ7-0003LI-Cv; Tue, 07 May 2024 04:43:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7B71264BD3;
 Tue,  7 May 2024 11:42:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 68D82C85BC;
 Tue,  7 May 2024 11:42:30 +0300 (MSK)
Received: (nullmailer pid 1026558 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 15/16] target/sh4: Fix ADDV opcode
Date: Tue,  7 May 2024 11:42:14 +0300
Message-Id: <20240507084226.1026455-15-mjt@tls.msk.ru>
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

  ADDV Rm, Rn        Rn + Rm -> Rn, overflow -> T

But QEMU implementation was:

  ADDV Rm, Rn        Rn + Rm -> Rm, overflow -> T

Fix by filling the correct Rm register.

Add tests provided by Paul Cercueil.

Cc: qemu-stable@nongnu.org
Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2317
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20240430163125.77430-2-philmd@linaro.org>
(cherry picked from commit c365e6b0705788866a65e7b8206bd4c5332595cd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5aa10d3946..d8dcfc3a20 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -715,7 +715,7 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_xor_i32(t2, REG(B7_4), REG(B11_8));
             tcg_gen_andc_i32(cpu_sr_t, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, cpu_sr_t, 31);
-            tcg_gen_mov_i32(REG(B7_4), t0);
+            tcg_gen_mov_i32(REG(B11_8), t0);
         }
         return;
     case 0x2009: /* and Rm,Rn */
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index c3d7fa86e3..39751c41b2 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -20,3 +20,6 @@ TESTS += test-macl
 
 test-macw: CFLAGS += -O -g
 TESTS += test-macw
+
+test-addv: CFLAGS += -O -g
+TESTS += test-addv
diff --git a/tests/tcg/sh4/test-addv.c b/tests/tcg/sh4/test-addv.c
new file mode 100644
index 0000000000..ca87fe746a
--- /dev/null
+++ b/tests/tcg/sh4/test-addv.c
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static void addv(const int a, const int b, const int res, const int carry)
+{
+    int o = a, c;
+
+    asm volatile("addv %2,%0\n"
+                 "movt %1\n"
+                 : "+r"(o), "=r"(c) : "r"(b) : );
+
+    if (c != carry || o != res) {
+        printf("ADDV %d, %d = %d/%d [T = %d/%d]\n", a, b, o, res, c, carry);
+        abort();
+    }
+}
+
+int main(void)
+{
+    addv(INT_MAX, 1, INT_MIN, 1);
+    addv(INT_MAX - 1, 1, INT_MAX, 0);
+
+    return 0;
+}
-- 
2.39.2



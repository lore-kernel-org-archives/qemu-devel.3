Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0FDC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXxu-0001VL-Vd; Thu, 18 Apr 2024 16:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXxn-0001UN-GW; Thu, 18 Apr 2024 16:02:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXxl-0005Fp-FZ; Thu, 18 Apr 2024 16:02:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 346515FE09;
 Thu, 18 Apr 2024 23:02:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9647BB93EF;
 Thu, 18 Apr 2024 23:02:24 +0300 (MSK)
Received: (nullmailer pid 952842 invoked by uid 1000);
 Thu, 18 Apr 2024 20:02:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 42/59] tcg/optimize: Do not attempt to constant fold
 neg_vec
Date: Thu, 18 Apr 2024 23:02:02 +0300
Message-Id: <20240418200224.952785-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
MIME-Version: 1.0
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

Split out the tail of fold_neg to fold_neg_no_const so that we
can avoid attempting to constant fold vector negate.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2150
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit e25fe886b89a396bae5847520b70c148587d490a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fixup in tests/tcg/aarch64/Makefile.target)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b6f6436c74..100b75efd8 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1634,16 +1634,10 @@ static bool fold_nand(OptContext *ctx, TCGOp *op)
     return false;
 }
 
-static bool fold_neg(OptContext *ctx, TCGOp *op)
+static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask;
-
-    if (fold_const1(ctx, op)) {
-        return true;
-    }
-
     /* Set to 1 all bits to the left of the rightmost.  */
-    z_mask = arg_info(op->args[1])->z_mask;
+    uint64_t z_mask = arg_info(op->args[1])->z_mask;
     ctx->z_mask = -(z_mask & -z_mask);
 
     /*
@@ -1654,6 +1648,11 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_neg(OptContext *ctx, TCGOp *op)
+{
+    return fold_const1(ctx, op) || fold_neg_no_const(ctx, op);
+}
+
 static bool fold_nor(OptContext *ctx, TCGOp *op)
 {
     if (fold_const2_commutative(ctx, op) ||
@@ -1949,7 +1948,7 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
     if (have_neg) {
         op->opc = neg_op;
         op->args[1] = op->args[2];
-        return fold_neg(ctx, op);
+        return fold_neg_no_const(ctx, op);
     }
     return false;
 }
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 474f61bc30..bd29446835 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -10,7 +10,7 @@ VPATH 		+= $(AARCH64_SRC)
 
 # Base architecture tests
 AARCH64_TESTS=fcvt pcalign-a64
-AARCH64_TESTS += test-2248
+AARCH64_TESTS += test-2248 test-2150
 
 fcvt: LDFLAGS+=-lm
 
diff --git a/tests/tcg/aarch64/test-2150.c b/tests/tcg/aarch64/test-2150.c
new file mode 100644
index 0000000000..fb86c11958
--- /dev/null
+++ b/tests/tcg/aarch64/test-2150.c
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2150 */
+
+int main()
+{
+    asm volatile(
+        "movi     v6.4s, #1\n"
+        "movi     v7.4s, #0\n"
+        "sub      v6.2d, v7.2d, v6.2d\n"
+        : : : "v6", "v7");
+    return 0;
+}
-- 
2.39.2



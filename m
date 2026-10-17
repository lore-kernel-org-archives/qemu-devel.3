Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E90CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB8R-0003uw-Ps; Sat, 17 Oct 2026 16:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB5c-0005ze-W3; Sat, 17 Oct 2026 16:33:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB5b-0004fw-4u; Sat, 17 Oct 2026 16:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268898; bh=BKue2WHSpcivGWnAhTOmzx/HoMPTLxX3emKeYFdciXw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aRkJryH+pJQ9paaFeE8+e1p0QXN7TxZZRPc2u6xGRf5ufsxUBCqehSbPp1/2FTHSH
 hK0aBuR4WliIeUaMo4cWyQ+fakLk9KKh4Xwl7ct0Nz1iUxXK/NJkhatSgF1/QOTUln
 STisihbhuxCiTY3+kN0r7EUdZ7rFEgpSxY37jJiJ55AjUlH520ccW13GivxktRMsV3
 wT4b9CjEVGeEjvGwIvzAU7NeR6FpujmmSHmdYONhpNkLswnIVRtTuZ6W1auHc0zS/t
 D73SkUSdv/cnnNwa4HAym7zbBsDIwP/VQuHroiI6W7n52bwG+mf95Nf5tfwR1/BJjQ
 gk8JVvt8VS3hw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 50E4A1DE782;
 Sat, 17 Oct 2026 23:28:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 47ACD443454;
 Sat, 17 Oct 2026 23:28:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Christian S. Lima" <christianslima@proton.me>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 66/73] targetriscv: svinval instructions raise virtual
 instruction exception
Date: Sat, 17 Oct 2026 23:26:24 +0300
Message-ID: <20261017202638.728621-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Christian S. Lima" <christianslima@proton.me>

The risc v privileged specification requires hinval.vvma, hinval.gvma,
sfence.w.inval and sfence.inval.ir should raise a virtual instruction
exception when executed in the vu-mode. This patch add the check to
raise the virtual instruction exception when is in the vu-mode.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3621
Signed-off-by: Christian S. Lima <christianslima@proton.me>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260911201323.37757-1-christianslima@proton.me>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 55a3524a892603a84f26a7d889ac19be98016dd2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/tcg/insn_trans/trans_svinval.c.inc b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
index 4614c1489c..1341beba2f 100644
--- a/target/riscv/tcg/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
@@ -25,6 +25,9 @@
 /* Test if priv level is M or S. */
 #define REQUIRE_PRIV_MS(ctx) do {          \
     if (ctx->priv == PRV_U) {              \
+        if (ctx->virt_enabled) {           \
+            ctx->virt_inst_excp = true;    \
+        }                                  \
         return false;                      \
     }                                      \
 } while (0)
diff --git a/target/riscv/tcg/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
index f4e3051000..ea4b169422 100644
--- a/target/riscv/tcg/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
@@ -267,11 +267,13 @@ static bool trans_th_tst(DisasContext *ctx, arg_th_tst *a)
 #define REQUIRE_PRIV_MSU(ctx)
 
 /* Test if priv level is M or S. */
-#define REQUIRE_PRIV_MS(ctx)                                    \
-do {                                                            \
-    if (ctx->priv == PRV_U) {                                   \
-        return false;                                           \
-    }                                                           \
+#define REQUIRE_PRIV_MS(ctx) do {          \
+    if (ctx->priv == PRV_U) {              \
+        if (ctx->virt_enabled) {           \
+            ctx->virt_inst_excp = true;    \
+        }                                  \
+        return false;                      \
+    }                                      \
 } while (0)
 
 #define NOP_PRIVCHECK(insn, extcheck, privcheck)                \
-- 
2.47.3



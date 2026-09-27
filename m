Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92AAC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkrx-0004qV-1V; Sun, 27 Sep 2026 05:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqI-0001SW-5N; Sun, 27 Sep 2026 05:06:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqF-0008AF-M2; Sun, 27 Sep 2026 05:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499960; bh=I3mm9gl4xbbP4KwmV+SH3oiRYZ/hpGc79EQTfXy/kpk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DNylhmSK42lzc4Ttx+Pn+is6oQovgjVdSIr6hKpgEYPSxDRN3ND7OCoAMq/I0sXSi
 TLqrhds5Sfj3mCP15VmJEeVItw03wFJnbJHwPh+ZyuuLe4PV0RaNGLjEDaPY4Iq+6+
 qkdH6IdmniMSFIBCg2Q4qsiP/jkKEnt6oYd2ev/FpAuFJau7EkSuUBscqW1bubgeSa
 C7/KZ0ebGoVtUx6YW1DXXJiqn8UkU2EshLDI/tX6YX6NcUliBIPAxM293QjZ/fm35D
 UOrlSZSPiw9LEF8/1EB/pVt8Czyg8f8F/PYKS0z7IMxuaHJSCagBV9HGF5GN7ELGRO
 yARiIak7NQErA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB5B11D8B18;
 Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E89254320D1;
 Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C7EFF5E661; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 71/86] tcg/optimize: Fix expansion/simplification
 of deposit
Date: Sun, 27 Sep 2026 12:05:18 +0300
Message-ID: <20260927090540.102811-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

When we computed z_mask/o_mask for the deposit, we may accidentally
prove that the result is a constant.

If we let the rest of the code expand as-is, when can we get to the
end we'll see the constant, note that it's the same as the current
value, remove what we think is "the opcode" that computes this same
value.  But in this case we've been expanding deposit to multiple
opcodes and the removal of only the last opcode breaks the expansion.

Fix this by noting the constant result early, before expanding,
allowing the entire operation to be removed.

Cc: qemu-stable@nongnu.org
Fixes: 5f747705a4 ("tcg/optimize: Lower unsupported deposit during optimize")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4449
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 0bc331d1c7d5cedc1dbe0bf21dc5f6be13c58fa4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c266cfe99c9..891612e3126 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1674,6 +1674,23 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     type_mask = MAKE_64BIT_MASK(0, width);
     len_mask = MAKE_64BIT_MASK(0, len);
 
+    /*
+     * Compute result masks before calling other fold_* subroutines
+     * which could modify the masks of our inputs.
+     */
+    z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
+    o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
+    if (ofs + len < width) {
+        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    } else {
+        s_mask = t2->s_mask << ofs;
+    }
+
+    /* Sometimes we prove a constant from non-constants. */
+    if (z_mask == o_mask) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0], z_mask);
+    }
+
     /* Inserting all-zero into a value. */
     if ((t2->z_mask & len_mask) == 0) {
         op->opc = INDEX_op_and;
@@ -1706,18 +1723,6 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         return fold_or(ctx, op);
     }
 
-    /*
-     * Compute result masks before calling other fold_* subroutines
-     * which could modify the masks of our inputs.
-     */
-    z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
-    o_mask = deposit64(t1->o_mask, ofs, len, t2->o_mask);
-    if (ofs + len < width) {
-        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
-    } else {
-        s_mask = t2->s_mask << ofs;
-    }
-
     /* Inserting a value into zero. */
     if (ti_is_const_val(t1, 0)) {
         uint64_t need_mask;
-- 
2.47.3



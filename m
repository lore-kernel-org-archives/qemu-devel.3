Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8787CCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB6P-0007ph-T8; Sat, 17 Oct 2026 16:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB4Y-00046q-8o; Sat, 17 Oct 2026 16:32:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB4V-0004Xh-SK; Sat, 17 Oct 2026 16:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268881; bh=UrXTE5BaIuAnGRluAn2NzCAIcxhE3i68oCLLihba3nU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=usSsokeizNHfHS9/lBYa157NUjUgfxv8FPcvwdLP6IqkVyDoUP7yTEpLJGwmNfBdU
 evsKml+ii1LCumV93Vf4iRlw3DPbNnIktN7d633dEerKPXZQOQq9yczYqkg1DMhPcD
 CKlEbx5j4u+WzvWw/P6TWwREMQibfmGthKDHUKDjUwPZQwpf6xCotHpXrtZO6ct6JB
 TQdgwSmZz2ohz9TFzmMiMIoYn68rjJiVSQVtDyOzevQUFEkXcNmcdE+WLXA59Gervx
 Egpjq3A3CwSEPyqONQLzGqszLIVO9J9BBz8Dh/nyNtGLRyYchpIm6wA9yj4+FQi3Cg
 628zQut6ub9EA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 65D471DE773;
 Sat, 17 Oct 2026 23:28:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8C5EE443447;
 Sat, 17 Oct 2026 23:28:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dominic P <gcc@gcc.dp11.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 53/73] tcg/optimize: Do not derive s_mask from rotated
 s_mask
Date: Sat, 17 Oct 2026 23:26:11 +0300
Message-ID: <20261017202638.728621-53-mjt@tls.msk.ru>
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

From: Dominic P <gcc@gcc.dp11.uk>

fold_shift computes s_mask for a rotate by a constant by rotating the
input s_mask.  The result is not a sign mask.  For TCG_TYPE_I32,
fold_masks_zosa_int then ORs in INT32_MIN, which can make it look like
one: after sextract_i32 x,0,8 (s_mask ...ffffff80), rotr_i32 by 1 gives
0x7fffffc0, which becomes ...ffffffc0.  A following sextract_i32 0,8
is then folded to a mov.  rotl_i32 by 31 fails the same way.

ARM, qemu-arm exits 255 instead of 7 (correct with -one-insn-per-tb):

    ldr   r1, [r2]        @ *r2 == 3
    sxtb  r1, r1
    ror   r1, r1, #1
    sxtb  r1, r1          @ dropped
    cmp   r1, #0
    movle r0, #255
    movgt r0, #7

i386, the same with rotl_i32:

    movsbl %al, %eax
    roll   $31, %eax
    movsbl %al, %eax      # dropped

Handle rotates like the logical right shift and let fold_masks_zo
recompute s_mask from z_mask and o_mask.

Cc: qemu-stable@nongnu.org
Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930185124.3036980-2-gcc@gcc.dp11.uk>
(cherry picked from commit d228536a5142cdd4b28e4feda74fa4859290787f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2dc6e32b53..cc5488ae85 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2659,17 +2659,26 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
         z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
         o_mask = do_constant_folding(op->opc, ctx->type, o_mask, sh);
 
-        if (op->opc == INDEX_op_shr) {
+        switch (op->opc) {
+        case INDEX_op_shr:
+        case INDEX_op_rotl:
+        case INDEX_op_rotr:
             /*
-             * Logical right shift will force the sign bit zero.
+             * Logical right shift will force the sign bit zero, and
+             * a rotate may move bits unrelated to the sign into it.
              * Don't bother computing s_mask and let fold_masks
              * recompute from z_mask.
              */
             return fold_masks_zo(ctx, op, z_mask, o_mask);
-        }
 
-        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
-        return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
+        case INDEX_op_sar:
+        case INDEX_op_shl:
+            s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
+            return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
+
+        default:
+            g_assert_not_reached();
+        }
     }
 
     switch (op->opc) {
-- 
2.47.3



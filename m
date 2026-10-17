Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2167CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9ec-00082c-Uh; Sat, 17 Oct 2026 15:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dY-0005gL-JJ; Sat, 17 Oct 2026 15:00:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dW-00043J-GU; Sat, 17 Oct 2026 15:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263417; bh=L7lJBFASxJrLnWb8tTLuV3iuCk4R8ObHLAU5dp8ASMs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HOAIT0o3/fHFcsI4yHF73/A7IfvQLB8Q96D4Ar33XjgT70DaeVRNMuFIFfNWQQlxU
 fmZYS3Sbm6Hs83cS/CIiRMyqMNEeOTv9I6HibIg/mmwMsqYo2+PlEM5+YRm/oGRnEr
 r2cUTleZB+uxE1Y8hbSRuujHGsqDQURr9CXzptnri/e8jUKZucqY/JTXA3hqLveBN4
 py7geV2pUwrcWI9EFw7y+NnU6yER8StHDsDITRv/MQXQYc7930QKXF7UXH1N+kJ01e
 aUNl1FaQ7lDStYEUXhlAH28WPG8Wx4uTB7Yd1Z6ZhOARajJ9zDawdu34LHaqQranCy
 XoLGa5WItmK2Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C9DBA1DE6D3;
 Sat, 17 Oct 2026 21:56:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 79BAB44339B;
 Sat, 17 Oct 2026 21:56:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dominic P <gcc@gcc.dp11.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 48/63] tcg/optimize: Do not derive s_mask from
 rotated s_mask
Date: Sat, 17 Oct 2026 21:55:04 +0300
Message-ID: <20261017185528.722197-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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
(Mjt: back-port to 10.0 across:
 v10.0.0-1791-g03329e3ce460 "tcg/optimize: Build and use o_bits in fold_shift",
 v10.0.0-430-g005a87e148dc "tcg: Merge INDEX_op_rot{l,r}_{i32,i64}",
 v10.0.0-427-g3949f365eb6e "tcg: Merge INDEX_op_sar_{i32,i64}"
 v10.0.0-425-g74dbd36f1f87 "tcg: Merge INDEX_op_shr_{i32,i64}")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c7c16518f0..217c9187a6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2603,17 +2603,26 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
 
         z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
 
-        if (op->opc == INDEX_op_shr_i32 || op->opc == INDEX_op_shr_i64) {
+        switch (op->opc) {
+        CASE_OP_32_64(shr):
+        CASE_OP_32_64(rotl):
+        CASE_OP_32_64(rotr):
             /*
-             * Logical right shift will force the sign bit zero.
+             * Logical right shift will force the sign bit zero, and
+             * a rotate may move bits unrelated to the sign into it.
              * Don't bother computing s_mask and let fold_masks
              * recompute from z_mask.
              */
             return fold_masks_z(ctx, op, z_mask);
-        }
 
-        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
-        return fold_masks_zs(ctx, op, z_mask, s_mask);
+        CASE_OP_32_64(sar):
+        CASE_OP_32_64(shl):
+            s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
+            return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+        default:
+            g_assert_not_reached();
+        }
     }
 
     switch (op->opc) {
-- 
2.47.3



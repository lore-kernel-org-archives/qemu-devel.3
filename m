Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2527C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrF0a-000598-R1; Tue, 04 Aug 2026 09:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jacobly@ziglang.org>)
 id 1wr8eV-00016b-SF
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:29:27 -0400
Received: from mail.ziglang.org ([108.61.23.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jacobly@ziglang.org>)
 id 1wr8eU-0004bY-GQ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 02:29:27 -0400
From: Jacob Young <jacobly@ziglang.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziglang.org; s=mail;
 t=1785824965; bh=gc84vgb2W4xTObRjAYWW1Xv+TZyjLcRjlC87tPKM4Pg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WNGXwkWhKlZmA8AQ3b3l/6goj/0HGetckY+S2RbB9q06O0LjHSU+ja1q3Ax34LROg
 9qyyqsCmQ0/M0n6U4M/61njE+mJlLlnOLvlUEdgFxt5KSZe8nUE/S8LrbA/TRQYKR2
 aLGxaKwmmrPmAkPKL1PMkhFvlPWYebW/7m+M+ax8=
Date: Tue, 04 Aug 2026 02:27:23 -0400
Subject: [PATCH] tcg/optimize: Fix s_mask computation for shifts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-fix-shift-smask-v1-1-8ce16b4000d1@ziglang.org>
References: <20260804-fix-shift-smask-v1-0-8ce16b4000d1@ziglang.org>
In-Reply-To: <20260804-fix-shift-smask-v1-0-8ce16b4000d1@ziglang.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Jacob Young <jacobly@ziglang.org>
Received-SPF: pass client-ip=108.61.23.47; envelope-from=jacobly@ziglang.org;
 helo=mail.ziglang.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Aug 2026 09:15:48 -0400
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

Previously, we would produce an incorrect smask in this case:

    t1.smask = 0xffffffff80000000
    shr_i32 t0,t1,$0x1
    t0.smask = 0xffffffffc0000000

because `do_constant_folding` would produce `smask = 0x40000000` which
was passed unchanged to `fold_masks_zos` which would then update with
`s_mask |= INT32_MIN;`, producing the incorrect result above.

Reproducer (i386 assembly):

        .text
        .globl  _start
    _start:
        movw    $0x4000, %ax
        addw    %ax, %ax
        cwtl
        shrl    %eax
        xorl    %ebx, %ebx
        cmpw    $-0x3fff, %ax
        setnl   %bl
        movl    $1, %eax
        int     $0x80

Signed-off-by: Jacob Young <jacobly@ziglang.org>
---
 tcg/optimize.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index fcdef25bee..96f7841afa 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2658,6 +2658,14 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
         o_mask = do_constant_folding(op->opc, ctx->type, o_mask, sh);
         s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
 
+        /*
+         * If the bit shifted into the result sign was not in the
+         * input s_mask, then no bits are known to match it.
+         */
+        if ((int64_t)s_mask >= 0) {
+            s_mask = 0;
+        }
+
         return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
     }
 

-- 
2.55.0



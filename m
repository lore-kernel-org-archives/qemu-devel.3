Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A194CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 17:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGhJ5-0007y6-0Z; Wed, 05 Nov 2025 12:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vGhJ3-0007xy-FU
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:28:25 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vGhJ1-0005bX-8a
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=QnvmPcWojGb4C4TQUu55wOAOrEeYkbAkJGG6umnMfZs=; b=WJDMoqUmuODCe18
 JBlCyJQCY9kUZvKIruIiJwz3ltwixNUaoEme6uil6lrGpjvdpABA98Drt2DqX5zh2p3JrPRtqkEdN
 7CCH5jiqKQy9iJnzvVJeF5U7CagVd4nVxuUUmOF9oO3HrC0b6MSB01EW23vINrB79cWaKAc9H77GH
 6Y=;
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Anton Johansson <anjo@rev.ng>
Subject: [PATCH] target/arm: Fix accidental write to TCG constant
Date: Wed,  5 Nov 2025 18:30:24 +0100
Message-ID: <20251105173025.10906-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently an unpredictable movw such as

  movw pc, 0x123

results in the tinycode

   and_i32 $0x123,$0x123,$0xfffffffc
   mov_i32 pc,$0x123
   exit_tb $0x0

which is clearly a bug, writing to a constant is incorrect and discards
the result of the mask.  Fix this by adding a temporary in store_reg().

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/arm/tcg/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 5f64fed220..aeac27bbe4 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -303,20 +303,23 @@ TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs)
    marked as dead.  */
 void store_reg(DisasContext *s, int reg, TCGv_i32 var)
 {
+    TCGv_i32 masked_var = tcg_temp_new_i32();
+    tcg_gen_mov_i32(masked_var, var);
     if (reg == 15) {
         /* In Thumb mode, we must ignore bit 0.
          * In ARM mode, for ARMv4 and ARMv5, it is UNPREDICTABLE if bits [1:0]
          * are not 0b00, but for ARMv6 and above, we must ignore bits [1:0].
          * We choose to ignore [1:0] in ARM mode for all architecture versions.
          */
-        tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
+        tcg_gen_andi_i32(masked_var, masked_var, s->thumb ? ~1 : ~3);
         s->base.is_jmp = DISAS_JUMP;
         s->pc_save = -1;
     } else if (reg == 13 && arm_dc_feature(s, ARM_FEATURE_M)) {
         /* For M-profile SP bits [1:0] are always zero */
-        tcg_gen_andi_i32(var, var, ~3);
+        tcg_gen_andi_i32(masked_var, masked_var, ~3);
     }
-    tcg_gen_mov_i32(cpu_R[reg], var);
+    tcg_gen_mov_i32(cpu_R[reg], masked_var);
+    tcg_gen_discard_i32(masked_var);
 }
 
 /*
-- 
2.51.0



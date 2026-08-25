Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27821C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylGr-0000op-4S; Tue, 25 Aug 2026 03:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGp-0000mc-KB; Tue, 25 Aug 2026 03:08:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGn-00067n-S7; Tue, 25 Aug 2026 03:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=Rf3H+hMVv47NzCvcvTqYkKEdZwtNocl9XdKmol8uuVI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DnzGp9NdK2lc7UDE+inbAVTZbwy9YN1QUh9R+1Ej/m6n3p0ZNaWabv1Z1rqpu3G4k
 Z/DamA5sOU7LAkJn8EQWNyd+5yutsNZi7mfvcEWwFfUM7ed2GuN5+LXZG+PaMm9Cru
 Gzdr92buhXOtpuv7E4hZf0KxpNbE7eUrAMjhtDrrMOQMHYKkVMn5nhKRt/2ImXgh6i
 ZGcNg33JGsHYFZ/Kk8nPV6OwX+WaBAHf1Xqa9QuQYtMy+px1elt9ZbXDB/1q23/F/W
 i6/YYEod6RZr96FlRlC95ldsHzy1JCKRL8kpy2mB2OmpkY/xI+0Y+HMIkKOIQQZKzQ
 KN2hy+bvvr9wg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 40F711CE221;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 04DAD415F9C;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 979EF32422; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 YanjunYang <yang.yanjun1@sanechips.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 60/91] target/arm: Fix SVE2 WHILEWR/WHILERW zero
 diff boundary case
Date: Tue, 25 Aug 2026 10:05:32 +0300
Message-ID: <20260825070619.174584-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
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

The trans_WHILE_ptr function incorrectly handles the case where the
address difference divided by ESIZE results in zero. This happens when
the address difference is less than ESIZE but greater than zero.

Fix by dropping direct comparisons of op0 vs op1, and instead
testing the scaled diff vs 0.  Merge with the bounding to the
maximum vector length via wrapping arithmetic.

Cc: qemu-stable@nongnu.org
Fixes: 14f6dad168e ("target/arm: Implement SVE2 WHILERW, WHILEWR")
Reported-by: YanjunYang <yang.yanjun1@sanechips.com.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260811191540.79882-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit bab972a2b0e34b889fbe8deb1e41cbea47e797f2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index fc4cc8c479f..0becef16a94 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3697,7 +3697,7 @@ TRANS_FEAT(WHILE_gt_cnt4, aa64_sme2_or_sve2p1, do_WHILE,
 
 static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
 {
-    TCGv_i64 op0, op1, diff, t1, tmax;
+    TCGv_i64 op0, op1, diff, t1;
     TCGv_i32 t2;
     TCGv_ptr ptr;
     unsigned vsz = vec_full_reg_size(s);
@@ -3713,7 +3713,6 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
     op0 = read_cpu_reg(s, a->rn, 1);
     op1 = read_cpu_reg(s, a->rm, 1);
 
-    tmax = tcg_constant_i64(vsz >> a->esz);
     diff = tcg_temp_new_i64();
 
     if (a->rw) {
@@ -3723,25 +3722,36 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
         tcg_gen_sub_i64(diff, op0, op1);
         tcg_gen_sub_i64(t1, op1, op0);
         tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, diff, t1);
-        /* Divide, rounding down, by ESIZE.  */
-        tcg_gen_shri_i64(diff, diff, a->esz);
-        /* If op1 == op0, diff == 0, and the condition is always true. */
-        tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
     } else {
         /* WHILEWR */
-        tcg_gen_sub_i64(diff, op1, op0);
-        /* Divide, rounding down, by ESIZE.  */
-        tcg_gen_shri_i64(diff, diff, a->esz);
-        /* If op0 >= op1, diff <= 0, the condition is always true. */
-        tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
+        /* Saturating subtraction maps diff <= 0 to diff == 0. */
+        tcg_gen_ussub_i64(diff, op1, op0);
     }
 
-    /* Bound to the maximum.  */
-    tcg_gen_umin_i64(diff, diff, tmax);
+    /* Divide, rounding down, by ESIZE.  */
+    tcg_gen_shri_i64(diff, diff, a->esz);
 
-    /* Since we're bounded, pass as a 32-bit type.  */
+    /*
+     * If diff == 0, the condition is always true.  Also, bound to max.
+     * Simplify
+     *    diff = diff ? diff : max;
+     *    diff = umin(diff, max);
+     * via
+     *    diff -= 1;
+     *    diff = umin(diff, max - 1);
+     *    diff += 1;
+     * via 0 - 1 == UINT64_MAX.
+     */
+    tcg_gen_addi_i64(diff, diff, -1);
+    tcg_gen_umin_i64(diff, diff, tcg_constant_i64((vsz >> a->esz) - 1));
+
+    /*
+     * Since we're bounded, pass as a 32-bit type.
+     * Sink the diff += 1 from above into the 32-bit type.
+     */
     t2 = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t2, diff);
+    tcg_gen_addi_i32(t2, t2, 1);
 
     desc = FIELD_DP32(desc, PREDDESC, OPRSZ, vsz / 8);
     desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
-- 
2.47.3



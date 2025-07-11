Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AA8C83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua96y-0003To-AB; Fri, 11 Jul 2025 04:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua90D-0001fs-3q; Fri, 11 Jul 2025 04:21:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua908-0004hn-V2; Fri, 11 Jul 2025 04:21:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ABC1C1356EF;
 Fri, 11 Jul 2025 11:17:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A3CF223FA64;
 Fri, 11 Jul 2025 11:17:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 36/39] target/arm: Fix 128-bit element ZIP, UZP, TRN
Date: Fri, 11 Jul 2025 11:16:32 +0300
Message-ID: <20250711081745.1785806-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We missed the instructions UDEF when the vector size is too small.
We missed marking the instructions non-streaming with SME.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e6ffd009c7710a8cc98094897fa0af609c114683)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d23be477b4..40d3a032d6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2352,6 +2352,23 @@ TRANS_FEAT(PUNPKHI, aa64_sve, do_perm_pred2, a, 1, gen_helper_sve_punpk_p)
  *** SVE Permute - Interleaving Group
  */
 
+static bool do_interleave_q(DisasContext *s, gen_helper_gvec_3 *fn,
+                            arg_rrr_esz *a, int data)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        if (vsz < 32) {
+            unallocated_encoding(s);
+        } else {
+            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                               vec_full_reg_offset(s, a->rn),
+                               vec_full_reg_offset(s, a->rm),
+                               vsz, vsz, data, fn);
+        }
+    }
+    return true;
+}
+
 static gen_helper_gvec_3 * const zip_fns[4] = {
     gen_helper_sve_zip_b, gen_helper_sve_zip_h,
     gen_helper_sve_zip_s, gen_helper_sve_zip_d,
@@ -2361,11 +2378,11 @@ TRANS_FEAT(ZIP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(ZIP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            zip_fns[a->esz], a, vec_full_reg_size(s) / 2)
 
-TRANS_FEAT(ZIP1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_zip_q, a, 0)
-TRANS_FEAT(ZIP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_zip_q, a,
-           QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
+TRANS_FEAT_NONSTREAMING(ZIP1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_zip_q, a, 0)
+TRANS_FEAT_NONSTREAMING(ZIP2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_zip_q, a,
+                        QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
 
 static gen_helper_gvec_3 * const uzp_fns[4] = {
     gen_helper_sve_uzp_b, gen_helper_sve_uzp_h,
@@ -2377,10 +2394,10 @@ TRANS_FEAT(UZP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(UZP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            uzp_fns[a->esz], a, 1 << a->esz)
 
-TRANS_FEAT(UZP1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_uzp_q, a, 0)
-TRANS_FEAT(UZP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_uzp_q, a, 16)
+TRANS_FEAT_NONSTREAMING(UZP1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_uzp_q, a, 0)
+TRANS_FEAT_NONSTREAMING(UZP2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_uzp_q, a, 16)
 
 static gen_helper_gvec_3 * const trn_fns[4] = {
     gen_helper_sve_trn_b, gen_helper_sve_trn_h,
@@ -2392,10 +2409,10 @@ TRANS_FEAT(TRN1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(TRN2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            trn_fns[a->esz], a, 1 << a->esz)
 
-TRANS_FEAT(TRN1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_trn_q, a, 0)
-TRANS_FEAT(TRN2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_trn_q, a, 16)
+TRANS_FEAT_NONSTREAMING(TRN1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_trn_q, a, 0)
+TRANS_FEAT_NONSTREAMING(TRN2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_trn_q, a, 16)
 
 /*
  *** SVE Permute Vector - Predicated Group
-- 
2.47.2



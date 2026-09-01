Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9558C624D6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONR-0001AQ-Hf; Tue, 01 Sep 2026 09:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONQ-00019t-1b
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:12 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONO-0007FU-0M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:11 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c25b661d37dso130235766b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268688; x=1788873488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Pq/lXObsND0I6ZGmnncbJGtepRu3UH3ZUCTMeXXBjbY=;
 b=vqPBzu/HtaAzr4OwhxLq3fnS3X6SxnSASjvLqr+V6O+4kQST6fUt3NXl52yQSOs923
 80ce0Dou8Rdy+uH6UmXsE0U+uHdluuTN+6AqGbsADY7t6kL9B1Mde89IVMaV0fqUFwYC
 lkKyC3r6N1/5BCQ8d/hep7wxnzSDzwzRLxvhyjzN//elOHUxS59atLU3649Z3skR/gXG
 5jRvNHCJ0nrPbSmGuqZB9lAp3o3eBH/tSpXZGel6SJG6KrUNOMz8WoJFCrAB75OwmM8L
 LdOZDx4svz3FM2Fx9m9nU4sBqkLIBD5PDkuVGeWqpCWSdPCSXxNcr3eu84rEHeyyzAQo
 lsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268688; x=1788873488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Pq/lXObsND0I6ZGmnncbJGtepRu3UH3ZUCTMeXXBjbY=;
 b=N82C3zNZxJ7jOgRSm5tqbRKMed3fEME0PsfUTGdNPQxJ9FQTuORLqjJdY3OwNWTpN9
 XBnLQXJeBeLlvB4sDdXBQHqM9gwGmBxgS/Lc/2Gwv9VZbexnhCUzhwu2nkZKKj6lWf1W
 urJnWnyZS9hYi6cxOghcTZcvVXXRW2XV8FpMb94nc2Rz/u1GO/gwqWEBuJKJKhb904mx
 4+tcile2f/TcWGinZ0YKywTlz/Yb8Gp0c5fvNGt12Ka600Vbet/QugYGgjtrthtsx3PT
 dfqN5rLDQH5hRlM2xSNlkHthfIbOqeW/7gw6erloDAAfwH6jTMipCuDlC2LCLmbdMIlX
 Fpkw==
X-Gm-Message-State: AFuF++m6boB4Ov+ozOk60qu/TrH2CI8aOyNYX1hLUbiPFIEBz5AtWO5c
 8TzAFAfofhxxpgdYTwAr7FGJx7ZLYdBmNg7V/CBJoviKr4LZ/tnMaRMxuJVD49py4e0MM7nPB1h
 EnJQavw0=
X-Gm-Gg: AR+sD11wV3s6W4FC7hsGU5t7dzhThtuYZQZJfzNzJ/+X22F28ABUA0to3boZ/hnKRPU
 JtXAxopUEVFjB3I7H/NQ3vZxFYvVRgHsUaE/1KQZaAcl0NkgtomBrbJ/EbT1qmiIwX4sP4QuAqa
 0QvFFSwGyquIsUz7Ypn+c2f7rlWCfVpdbb00jYAX2dRzCkZ5nsQK/V4aS9brjYPg4J6caueZHTO
 65FZKAPxm/QSQpP8P8RIn/F0BRDRfpweDB9U8CTb4uV5TLKt1QAMoqtVr5/jXarUFyeQnVja2fX
 LxDTwgFuN0GOWT2PyiOk+5xOks66mGSOjTrgIo2U52VzjF3YuKtx7yT5sNqWUFGoVqgkrROmWL7
 TmJnDoIA0zuBQH4AZHn3RNp7k/hW34X9XxRgyLBJBKQ0bT/MNKJ46CSSYJD94KvCZL3N3/MOihY
 OH/jy0sDrwfYXLEWMiAERgWNyhCjyZL+axNGbClOG3QalZnNbgc8F/AOREA5AGWw2otruPUf0Nq
 zw75jxcqX4WKRNVZbQhR/FdEEigJ5n4dhD11xU33Y0q6EVbViA08TfAPaOPl+qTtXd+Vw==
X-Received: by 2002:a17:906:99c9:b0:c19:473b:dc8f with SMTP id
 a640c23a62f3a-c2556fb8fc7mr1780488766b.3.1788268688326; 
 Tue, 01 Sep 2026 06:18:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/58] target/arm: Split zdn in do_z2z_n1 and do_z2z_n1_fpst
Date: Tue,  1 Sep 2026 14:17:08 +0100
Message-ID: <20260901131732.2263947-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Rename from z2z to zzz to indicate zd and zn may not overlap.
During decode, retain z2z name and duplicate the same field
into zd and zn.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      |  8 ++--
 target/arm/tcg/translate-sme.c | 71 +++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e8176fffdbf..30946330ffe 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -220,11 +220,13 @@ UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
 %zd_ax2         1:4 !function=times_2
 %zd_ax4         2:3 !function=times_4
 
+&zzz_en         zd zn zm esz n
 &z2z_en         zdn zm esz n
+
 @z2z_2x1        ....... . esz:2 .. zm:4 ....0. ..... .... . \
-                &z2z_en n=2 zdn=%zd_ax2
+                &zzz_en n=2 zd=%zd_ax2 zn=%zd_ax2
 @z2z_4x1        ....... . esz:2 .. zm:4 ....1. ..... ...0 . \
-                &z2z_en n=4 zdn=%zd_ax4
+                &zzz_en n=4 zd=%zd_ax4 zn=%zd_ax4
 
 SMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 0    @z2z_2x1
 SMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 0    @z2z_4x1
@@ -990,8 +992,6 @@ UZP_2           11000001 esz:2 1 zm:5 110100 zn:5 .... 1    \
 UZP_2           11000001 00    1 zm:5 110101 zn:5 .... 1    \
                 &zzz_e zd=%zd_ax2 esz=4
 
-&zzz_en         zd zn zm esz n
-
 FCLAMP          11000001 esz:2 1 zm:5 110000 zn:5 .... 0    \
                 &zzz_en zd=%zd_ax2 n=2
 FCLAMP          11000001 esz:2 1 zm:5 110010 zn:5 ...0 0    \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 768b76f01ec..e3b96914dad 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -659,31 +659,30 @@ TRANS_FEAT(BMOPA, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_bmopa_s)
 TRANS_FEAT(SMOPA2_s, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_smopa2_s)
 TRANS_FEAT(UMOPA2_s, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_umopa2_s)
 
-static bool do_z2z_n1(DisasContext *s, arg_z2z_en *a, GVecGen3Fn *fn)
+static bool do_zzz_n1(DisasContext *s, arg_zzz_en *a, GVecGen3Fn *fn)
 {
-    int esz, dn, vsz, mofs, n;
-    bool overlap = false;
+    int esz = a->esz, vsz, mofs;
+    int overlap = -1;
 
     if (!sme_sm_enabled_check(s)) {
         return true;
     }
 
-    esz = a->esz;
-    n = a->n;
-    dn = a->zdn;
     mofs = vec_full_reg_offset(s, a->zm);
     vsz = streaming_vec_reg_size(s);
 
-    for (int i = 0; i < n; i++) {
-        int dofs = vec_full_reg_offset(s, dn + i);
+    for (int i = 0, n = a->n; i < n; i++) {
+        int dofs = vec_full_reg_offset(s, a->zd + i);
+        int nofs = vec_full_reg_offset(s, a->zn + i);
         if (dofs == mofs) {
-            overlap = true;
+            overlap = i;
         } else {
-            fn(esz, dofs, dofs, mofs, vsz, vsz);
+            fn(esz, dofs, nofs, mofs, vsz, vsz);
         }
     }
-    if (overlap) {
-        fn(esz, mofs, mofs, mofs, vsz, vsz);
+    if (overlap >= 0) {
+        int nofs = vec_full_reg_offset(s, a->zn + overlap);
+        fn(esz, mofs, nofs, mofs, vsz, vsz);
     }
     return true;
 }
@@ -710,14 +709,14 @@ static void gen_sme2_urshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
 }
 
-TRANS_FEAT(ADD_n1, aa64_sme2, do_z2z_n1, a, tcg_gen_gvec_add)
-TRANS_FEAT(SMAX_n1, aa64_sme2, do_z2z_n1, a, tcg_gen_gvec_smax)
-TRANS_FEAT(SMIN_n1, aa64_sme2, do_z2z_n1, a, tcg_gen_gvec_smin)
-TRANS_FEAT(UMAX_n1, aa64_sme2, do_z2z_n1, a, tcg_gen_gvec_umax)
-TRANS_FEAT(UMIN_n1, aa64_sme2, do_z2z_n1, a, tcg_gen_gvec_umin)
-TRANS_FEAT(SRSHL_n1, aa64_sme2, do_z2z_n1, a, gen_sme2_srshl)
-TRANS_FEAT(URSHL_n1, aa64_sme2, do_z2z_n1, a, gen_sme2_urshl)
-TRANS_FEAT(SQDMULH_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_sve2_sqdmulh)
+TRANS_FEAT(ADD_n1, aa64_sme2, do_zzz_n1, a, tcg_gen_gvec_add)
+TRANS_FEAT(SMAX_n1, aa64_sme2, do_zzz_n1, a, tcg_gen_gvec_smax)
+TRANS_FEAT(SMIN_n1, aa64_sme2, do_zzz_n1, a, tcg_gen_gvec_smin)
+TRANS_FEAT(UMAX_n1, aa64_sme2, do_zzz_n1, a, tcg_gen_gvec_umax)
+TRANS_FEAT(UMIN_n1, aa64_sme2, do_zzz_n1, a, tcg_gen_gvec_umin)
+TRANS_FEAT(SRSHL_n1, aa64_sme2, do_zzz_n1, a, gen_sme2_srshl)
+TRANS_FEAT(URSHL_n1, aa64_sme2, do_zzz_n1, a, gen_sme2_urshl)
+TRANS_FEAT(SQDMULH_n1, aa64_sme2, do_zzz_n1, a, gen_gvec_sve2_sqdmulh)
 
 static bool do_z2z_nn(DisasContext *s, arg_z2z_en *a, GVecGen3Fn *fn)
 {
@@ -750,11 +749,11 @@ TRANS_FEAT(SRSHL_nn, aa64_sme2, do_z2z_nn, a, gen_sme2_srshl)
 TRANS_FEAT(URSHL_nn, aa64_sme2, do_z2z_nn, a, gen_sme2_urshl)
 TRANS_FEAT(SQDMULH_nn, aa64_sme2, do_z2z_nn, a, gen_gvec_sve2_sqdmulh)
 
-static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
+static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
 {
-    int esz = a->esz, n, dn, vsz, mofs;
-    bool overlap = false;
+    int esz = a->esz, vsz, mofs;
+    int overlap = -1;
     gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
@@ -770,21 +769,21 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    n = a->n;
-    dn = a->zdn;
     mofs = vec_full_reg_offset(s, a->zm);
     vsz = streaming_vec_reg_size(s);
 
-    for (int i = 0; i < n; i++) {
-        int dofs = vec_full_reg_offset(s, dn + i);
+    for (int i = 0, n = a->n; i < n; i++) {
+        int dofs = vec_full_reg_offset(s, a->zd + i);
+        int nofs = vec_full_reg_offset(s, a->zn + i);
         if (dofs == mofs) {
-            overlap = true;
+            overlap = i;
         } else {
-            tcg_gen_gvec_3_ptr(dofs, dofs, mofs, fpst, vsz, vsz, 0, fn);
+            tcg_gen_gvec_3_ptr(dofs, nofs, mofs, fpst, vsz, vsz, 0, fn);
         }
     }
-    if (overlap) {
-        tcg_gen_gvec_3_ptr(mofs, mofs, mofs, fpst, vsz, vsz, 0, fn);
+    if (overlap >= 0) {
+        int nofs = vec_full_reg_offset(s, a->zn + overlap);
+        tcg_gen_gvec_3_ptr(mofs, nofs, mofs, fpst, vsz, vsz, 0, fn);
     }
     return true;
 }
@@ -831,7 +830,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
       gen_helper_gvec_ah_fmax_s,
       gen_helper_gvec_ah_fmax_d },
 };
-TRANS_FEAT(FMAX_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmax[s->fpcr_ah])
+TRANS_FEAT(FMAX_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmax[s->fpcr_ah])
 TRANS_FEAT(FMAX_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmax[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
@@ -844,7 +843,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
       gen_helper_gvec_ah_fmin_s,
       gen_helper_gvec_ah_fmin_d },
 };
-TRANS_FEAT(FMIN_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmin[s->fpcr_ah])
+TRANS_FEAT(FMIN_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmin[s->fpcr_ah])
 TRANS_FEAT(FMIN_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmin[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
@@ -853,7 +852,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
     gen_helper_gvec_fmaxnum_s,
     gen_helper_gvec_fmaxnum_d,
 };
-TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmaxnm)
+TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmaxnm)
 TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmaxnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
@@ -862,7 +861,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
     gen_helper_gvec_fminnum_s,
     gen_helper_gvec_fminnum_d,
 };
-TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
+TRANS_FEAT(FMINNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
@@ -887,7 +886,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
     gen_helper_gvec_fscale_s,
     gen_helper_gvec_fscale_d,
 };
-TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_z2z_n1_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale)
 TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_z2z_nn_fpst, a, f_vector_fscale)
 
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
-- 
2.43.0



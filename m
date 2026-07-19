Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62830C4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 17:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlVdf-0000ef-Um; Sun, 19 Jul 2026 13:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVdb-0000dX-Et
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:15 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVdZ-0003Bh-K7
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ccf2360620so53536715ad.3
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784483352; x=1785088152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LdFQn/wRhipZIaSYzoAsurGex/nWNiOc/pNKvI17GKE=;
 b=tBeM4+IBGy1KtCdt2wOYdPCVwEBe0D5kJmp0txAByPz6pPY5pBcxdAMhUc6Nle3oUL
 Io3V1zhXpnyeceBGsv6d7LtbGVN/qPmgV0nc5qEWQoldpWzRQfm8ylKIzkaoJDkN0TCJ
 rSM29/TUeMHBs21fYtM2+mSiaaeFareNYyLk/7UQ0bQEDH73kibIFN/D29MbAJVh5O65
 reAh0QNaP1oZfZc+5IFMIf5vB46Uil1WvEi5RCMo3RQk8Vl3fY+eeCfkqnDS44FAzbiv
 2Qn3s4vrIQ8ucKB0znx8bxRuD7HtfvbcrY+Niuje0D8gfRMQ7W7m9RC7rT5aBuohR32L
 hkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784483352; x=1785088152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LdFQn/wRhipZIaSYzoAsurGex/nWNiOc/pNKvI17GKE=;
 b=PvbOZBA6SWaXOLTDnKQwwMcwOQ8SjhewqW+++xGfQkfi4r51V5Ov1JTbxfcG25scRt
 IdE196B50P1dtxmVUEXiidRzBhmr2JLmdFMkHtivBN9zgM1C5CBrz9DFFcEYLllD63pO
 Uu809AVKjqYVOrBEjx31DiCMkYXB/wAMcT7bCOX5eQmhDmggNSIVh3AvyycMW4cvPTAm
 ejfu79wijMGYWmAqtvov1mFNoaGotPlABYVmh+mm7uuLW1L8Xxh2/lNSeZDxpboV3FHe
 soSoRHRLPRknnbu2nblLRm0XbD9TB5b8E2JhGgwUWINFDrjLcyK4vwIKmG763sdyN0Kr
 iGrQ==
X-Gm-Message-State: AOJu0YxepDWRHvm5tSJzttXEwuMFuoYkxHFs9bk7w/fX7SLO8T1lkNII
 BUg38uSQgmFdXi+WdaNt3v1VOas5zOvqHCnI/bVqOlEZ9L/hw5XCfBw6Rg7ilEOBDUqS9tBC3Yo
 agxgo
X-Gm-Gg: AfdE7cnypgxZDv8UE8coPiLY82YYDEClB35iQFv5qx+11Tp353vsdsb2wAG8hqnjw1w
 QUP4NqQtVmfLs7suBZ3w0Su/A5mouv+cBVaQmxuzlVxAg7uy98w1BGdrsi8KW7jnMf0bIM+/rrd
 3c1gRnPCdjyD1MHpXPh1hEk4m6TuDQCFfYyEqz14OUTOFX9vM95TIv8NQXpzpQsm5MIyhdp4aqz
 bXUPMZxHyqdi5xuaG86D6O3QcZRfpNnyBM+M+lRc1krh/HbCnuGUsb83JMQwSjoEzJeh4qPYLUY
 b08lOOOOSNc86c/FrYjKCBMyJoqOsPr0x0OlPrg4HVAWxrKyUrvzsDExLRx0vz5EL9ochAIgx8x
 KbLAfmmy77iKx7iiGW+BtpkaQoqZO6pgxdSwh0G61GnW+mYCKrikngfWlf1x/3mFvwkmiFJH63e
 azOf9YUlTSl7PA3yOwBV3ZiuhOwW86
X-Received: by 2002:a05:6a20:734b:b0:3bf:6c08:2b2d with SMTP id
 adf61e73a8af0-3c3ada90558mr10857540637.53.1784483351447; 
 Sun, 19 Jul 2026 10:49:11 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20c158sm30471881eec.29.2026.07.19.10.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 10:49:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 1/6] target/arm: Split zdn in do_z2z_n1 and do_z2z_n1_fpst
Date: Sun, 19 Jul 2026 10:49:00 -0700
Message-ID: <20260719174905.420725-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719174905.420725-1-richard.henderson@linaro.org>
References: <20260719174905.420725-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename from z2z to zzz to indicate zd and zn may not overlap.
During decode, retain z2z name and duplicate the same field
into zd and zn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 71 +++++++++++++++++-----------------
 target/arm/tcg/sme.decode      |  8 ++--
 2 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index fb296ae02f..cee609cc07 100644
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
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e8176fffdb..30946330ff 100644
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
-- 
2.43.0



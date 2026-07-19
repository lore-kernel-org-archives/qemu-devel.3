Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9899AC44512
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 17:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlVdn-0000hd-Vp; Sun, 19 Jul 2026 13:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVdd-0000eJ-1p
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:17 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVda-0003By-PY
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:16 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cb5a6aa8760so862618a12.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784483353; x=1785088153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sGlXj1O3kPVSdzD1psVMFLlRXXlssVVKH+b4+oDeL/E=;
 b=fkHlDoxeqjMgd0wye31mrBItV5dT1jir2X93EhFCYzoS0CHXYjujk7xbq1Td567Lr5
 SiZwMZpHdECmPKhq+evIFIEnhc1LZyGnH57ZOW9fFK8y5QhgZ7EkagO1OocJV1fft5ZA
 7Zs9dQT0Q7hmPcXD88+bxBU5Z2s7YzNXQxKKx6WdHteXKrhm2Q2pE91Ogb/CFsa4/StH
 yw99GobbLw2hsqt5noWlLGk221nK492wCNXZCXaEBjQ7oLUwcT/evD1vZAOB82eyVo83
 7T1d3dTMG0mnyqHWGEhiiOV6wwdpw2fjTGSnSqMBjgAPiOSsjf/2RQzs9Uxzy0Wxl6h1
 u69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784483353; x=1785088153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sGlXj1O3kPVSdzD1psVMFLlRXXlssVVKH+b4+oDeL/E=;
 b=fidO/dsH86tZ4TTHWorGWCg5la+GQ3BJHf2HFnKxES0t8dAPcZNQq0ST+XGTtbvnzg
 ISg66axLD/ErZayDhTKXU1/rW9iTtWmA2J8RnW7rj5YLITjtCDDS/72bFr9Gg5xbzy02
 VF9YBMR0bk/G/jl3K98DeEgN8iVjztlBQt+bHCLOTrYuyAq3XXzld+JDDDKQHrfMx/yF
 lNstDd7ff184j8l/MdEvsvtldofwn5O/1yfJDJCGdtiEKmFE/1CvVyeirLJfVV+c03ea
 0qM4vedYpxV8awXKUyytaSCB1d9+RpgzNIVlzQmJ7dXYF7J77RYPxd4FaUoysLnWrnLZ
 HyPg==
X-Gm-Message-State: AOJu0YwVSV3FHQPkoKIiujWW6sYKR0pXufVgdULcs0ccx4k3iwkzYcH0
 BH9Y1BscoYf3AG34UCJiwnoslTu6onqEjOrwRcE2xP/W7maH3sEDMwpNrcc3eDvcncQHoxg08VK
 7H0Bd
X-Gm-Gg: AfdE7ck3zKtLUDbo8d1t4y5ugtHUsqeRcjF5E0IcbpzNt0ovizXRTIlwDr5+Z5AbPf2
 8NC2D3sflpfk3YgSWFwJgSecLNDcA1WzGdLMP3UsSIcfC3bcIU8SBKfoXWRzGXDJPzwf0ejTpBm
 //5Eoc3BsbiF1M+dFtjXzlBhJLnW/A3IMaA5vLt2P2YOmVXsu+T9Y/CXiWmU7xb06ZYCWVfgWXp
 wp/TLORE8nIrJQshbxVkNs3DZfJXUXs1mLB0Jooqdj9phpAItEQBcj0B7hfO9GJAVlWMxhqvmFd
 I0VoVP7qp9MW3kb3eWFK4LyJCaymsLX+EFLm4GR9K3St0ypb1D9dyz9M75ROh8pbsdAROWpZrUO
 PSTn3hLJn4NH+Q+pB1fe8jW48sPAP//RW6B5Cp9TNhDyix2anOPieuD+l+ZY5qAiQHpc0yNRg1h
 k7ZRsld1c=
X-Received: by 2002:a05:6a20:4310:b0:3bf:bde7:d679 with SMTP id
 adf61e73a8af0-3c3ada190aemr11584602637.40.1784483352955; 
 Sun, 19 Jul 2026 10:49:12 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20c158sm30471881eec.29.2026.07.19.10.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 10:49:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/6] target/arm: Split zdn in do_z2z_nn and do_z2z_nn_fpst
Date: Sun, 19 Jul 2026 10:49:01 -0700
Message-ID: <20260719174905.420725-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719174905.420725-1-richard.henderson@linaro.org>
References: <20260719174905.420725-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 target/arm/tcg/translate-sme.c | 61 ++++++++++++++++------------------
 target/arm/tcg/sme.decode      |  5 ++-
 2 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index cee609cc07..5f02d462d3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -718,36 +718,33 @@ TRANS_FEAT(SRSHL_n1, aa64_sme2, do_zzz_n1, a, gen_sme2_srshl)
 TRANS_FEAT(URSHL_n1, aa64_sme2, do_zzz_n1, a, gen_sme2_urshl)
 TRANS_FEAT(SQDMULH_n1, aa64_sme2, do_zzz_n1, a, gen_gvec_sve2_sqdmulh)
 
-static bool do_z2z_nn(DisasContext *s, arg_z2z_en *a, GVecGen3Fn *fn)
+static bool do_zzz_nn(DisasContext *s, arg_zzz_en *a, GVecGen3Fn *fn)
 {
-    int esz, dn, dm, vsz, n;
+    int esz = a->esz, vsz;
 
     if (!sme_sm_enabled_check(s)) {
         return true;
     }
 
-    esz = a->esz;
-    n = a->n;
-    dn = a->zdn;
-    dm = a->zm;
     vsz = streaming_vec_reg_size(s);
 
-    for (int i = 0; i < n; i++) {
-        int dofs = vec_full_reg_offset(s, dn + i);
-        int mofs = vec_full_reg_offset(s, dm + i);
+    for (int i = 0, n = a->n; i < n; i++) {
+        int dofs = vec_full_reg_offset(s, a->zd + i);
+        int nofs = vec_full_reg_offset(s, a->zn + i);
+        int mofs = vec_full_reg_offset(s, a->zm + i);
 
-        fn(esz, dofs, dofs, mofs, vsz, vsz);
+        fn(esz, dofs, nofs, mofs, vsz, vsz);
     }
     return true;
 }
 
-TRANS_FEAT(SMAX_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_smax)
-TRANS_FEAT(SMIN_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_smin)
-TRANS_FEAT(UMAX_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_umax)
-TRANS_FEAT(UMIN_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_umin)
-TRANS_FEAT(SRSHL_nn, aa64_sme2, do_z2z_nn, a, gen_sme2_srshl)
-TRANS_FEAT(URSHL_nn, aa64_sme2, do_z2z_nn, a, gen_sme2_urshl)
-TRANS_FEAT(SQDMULH_nn, aa64_sme2, do_z2z_nn, a, gen_gvec_sve2_sqdmulh)
+TRANS_FEAT(SMAX_nn, aa64_sme2, do_zzz_nn, a, tcg_gen_gvec_smax)
+TRANS_FEAT(SMIN_nn, aa64_sme2, do_zzz_nn, a, tcg_gen_gvec_smin)
+TRANS_FEAT(UMAX_nn, aa64_sme2, do_zzz_nn, a, tcg_gen_gvec_umax)
+TRANS_FEAT(UMIN_nn, aa64_sme2, do_zzz_nn, a, tcg_gen_gvec_umin)
+TRANS_FEAT(SRSHL_nn, aa64_sme2, do_zzz_nn, a, gen_sme2_srshl)
+TRANS_FEAT(URSHL_nn, aa64_sme2, do_zzz_nn, a, gen_sme2_urshl)
+TRANS_FEAT(SQDMULH_nn, aa64_sme2, do_zzz_nn, a, gen_gvec_sve2_sqdmulh)
 
 static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
@@ -788,10 +785,10 @@ static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
     return true;
 }
 
-static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
+static bool do_zzz_nn_fpst(DisasContext *s, arg_zzz_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
 {
-    int esz = a->esz, n, dn, dm, vsz;
+    int esz = a->esz, vsz;
     gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
@@ -806,16 +803,14 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    n = a->n;
-    dn = a->zdn;
-    dm = a->zm;
     vsz = streaming_vec_reg_size(s);
 
-    for (int i = 0; i < n; i++) {
-        int dofs = vec_full_reg_offset(s, dn + i);
-        int mofs = vec_full_reg_offset(s, dm + i);
+    for (int i = 0, n = a->n; i < n; i++) {
+        int dofs = vec_full_reg_offset(s, a->zd + i);
+        int nofs = vec_full_reg_offset(s, a->zn + i);
+        int mofs = vec_full_reg_offset(s, a->zm + i);
 
-        tcg_gen_gvec_3_ptr(dofs, dofs, mofs, fpst, vsz, vsz, 0, fn);
+        tcg_gen_gvec_3_ptr(dofs, nofs, mofs, fpst, vsz, vsz, 0, fn);
     }
     return true;
 }
@@ -831,7 +826,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
       gen_helper_gvec_ah_fmax_d },
 };
 TRANS_FEAT(FMAX_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmax[s->fpcr_ah])
-TRANS_FEAT(FMAX_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmax[s->fpcr_ah])
+TRANS_FEAT(FMAX_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmax[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
     { gen_helper_gvec_fmin_b16,
@@ -844,7 +839,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
       gen_helper_gvec_ah_fmin_d },
 };
 TRANS_FEAT(FMIN_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmin[s->fpcr_ah])
-TRANS_FEAT(FMIN_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmin[s->fpcr_ah])
+TRANS_FEAT(FMIN_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmin[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
     gen_helper_gvec_fmaxnum_b16,
@@ -853,7 +848,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
     gen_helper_gvec_fmaxnum_d,
 };
 TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmaxnm)
-TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmaxnm)
+TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmaxnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
     gen_helper_gvec_fminnum_b16,
@@ -862,7 +857,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
     gen_helper_gvec_fminnum_d,
 };
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fminnm)
-TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
+TRANS_FEAT(FMINNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fminnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
     NULL,
@@ -870,7 +865,7 @@ static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
     gen_helper_gvec_famax_s,
     gen_helper_gvec_famax_d,
 };
-TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famax)
+TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famax)
 
 static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
     NULL,
@@ -878,7 +873,7 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
     gen_helper_gvec_famin_s,
     gen_helper_gvec_famin_d,
 };
-TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
+TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famin)
 
 static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
     NULL,
@@ -887,7 +882,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
     gen_helper_gvec_fscale_d,
 };
 TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale)
-TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_z2z_nn_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale)
 
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 30946330ff..36fbe24faf 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -221,7 +221,6 @@ UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
 %zd_ax4         2:3 !function=times_4
 
 &zzz_en         zd zn zm esz n
-&z2z_en         zdn zm esz n
 
 @z2z_2x1        ....... . esz:2 .. zm:4 ....0. ..... .... . \
                 &zzz_en n=2 zd=%zd_ax2 zn=%zd_ax2
@@ -266,9 +265,9 @@ FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
 %zm_ax4         18:3 !function=times_4
 
 @z2z_2x2        ....... . esz:2 . ....0 ....0. ..... .... . \
-                &z2z_en n=2 zdn=%zd_ax2 zm=%zm_ax2
+                &zzz_en n=2 zd=%zd_ax2 zn=%zd_ax2 zm=%zm_ax2
 @z2z_4x4        ....... . esz:2 . ...00 ....1. ..... ...0 . \
-                &z2z_en n=4 zdn=%zd_ax4 zm=%zm_ax4
+                &zzz_en n=4 zd=%zd_ax4 zn=%zd_ax4 zm=%zm_ax4
 
 SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_2x2
 SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_4x4
-- 
2.43.0



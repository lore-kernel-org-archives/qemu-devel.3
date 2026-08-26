Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D06AC61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHdp-0008QO-5E; Wed, 26 Aug 2026 13:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdm-0008P4-M7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:22 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdk-0004k0-En
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:22 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cbee846deecso1340437a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766139; x=1788370939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ce50MzaaeJVF6eZoCG1bV62bWtsmXMu9fKW7mi6pTYs=;
 b=nekkhBq28evFAxoguk09ARk6n4S+u91zjJmtJmPV/qXquiOTsp/j0Y/sVa6rrllr30
 aPKsbwa70kemTQ9TG5//1Ii8xM9IyihMg/Xb61Iu0VqLZBhAYl6eztc7rHvBNvYymSWW
 cU5of9WYquF+sX2AjA5RfDqlqaL/aNBoQ5MVzwECwK39HKxxSqDOEjH/va7lLpqNeLMb
 wCj4Z5O7FbhgGr1BxiKmh6DABnTq0xOOsqMtOYbaflYEY1JiD3uIkgO7dNMnJDxMD2Ax
 p/2vxlRKrrmCVrZBnj3kIE6NyU8y9ldWEC33Cju+hpCOaEtY7wjws1+ajVD3CJHfOB5u
 xtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766139; x=1788370939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ce50MzaaeJVF6eZoCG1bV62bWtsmXMu9fKW7mi6pTYs=;
 b=dgFrMNhnpE5Tzs6u5OtXz9TYopLnKfTFQ9j6vfnwCm2lYdJo6YGZBRyVnklVqZRzve
 WLToUPvjOY0i/cqRroY1iPoJqQl1WGSrqUQIK3jgjEBczq9afEc9AS/oWsaYhF8qK3+S
 frXa3DSWm/0XRGuOixdYPqkAOqsTu7zNLD7cZK0dBso8nfvZljQVhv2MDhu9ZPngs2J5
 1mgW9i9CEMYcvSGvEjOCo4qL65+A5+z94kH/ERqTB6f8qdFoISeUWBFx6x3bh6S5QFRc
 TqCCCNJS+3xejNQ4AHwFOU5r0lla+flan3gBe+oTW28Q7WGJGFc+SA6cBgjdcUfVFDwh
 zoCw==
X-Gm-Message-State: AFuF++mfJbC7qHQTNM6WyaqBz1lbE0DCllzSpb8VCBdB6mbmFUz+rD0l
 q4n7Hy0V5+lm1ufUvDdFiQX+apukm5Jc0Kx9iqrFbLKxuBv8Jm/EvLhkMP4UCaLPnca4gj3e82b
 4DUyfirI=
X-Gm-Gg: AR+sD10fVrfWwyRaKaNbFbwVsTdx9VtfHUH0SuUh53jb+ZBAfha4mnf17gvXwT5p0ao
 QKtDRY4iaz/rBrwOJ+jniE+eZE239EEjj+d+bFkiunFIg0siaqj87+rY+9E85q01a02q9xcgQu3
 HS2oJB2XNO0YJ9nG9OJc6APH7rvzT8CxMkux1g9N7NKhhx32y+3Z33DX4Q1OOewgfdlO12twECD
 Ld3A/pYGlUoAvGb2ot5QzncFEE6anU+kV8SfiI3789rD6G24u/SvMAMJGRigfF2f2X/jSoOQrpB
 Myc416EbibQUGJGFqZNWUEEAUYJbJdD+9qEeBXMcI4OMo3+qXilZrCeOMUinzjWelU7ckj1R416
 2k1t5gccPILKJncqfKikUyYSXKlKbaT5Vd0hYgOKH2SmQ3TSsFXYfem8vQpXn+2G0jqfi6/U6oM
 B6E37hSnyyQ4J5F4p/9/Xiky8hpoE8zrnnr7jv1O9e6Fk0get1QkfErQTA8yQizkBgjThmQ8Q0r
 u3Gy7/5q1FQdbGHjA==
X-Received: by 2002:a05:6a20:43ac:b0:3cd:3e77:1dcd with SMTP id
 adf61e73a8af0-3cf757726ccmr18373505637.1.1787766138815; 
 Wed, 26 Aug 2026 10:42:18 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 02/25] target/arm: Split zdn in do_z2z_nn and do_z2z_nn_fpst
Date: Wed, 26 Aug 2026 10:41:49 -0700
Message-ID: <20260826174213.614571-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Rename from z2z to zzz to indicate zd and zn may not overlap.
During decode, retain z2z name and duplicate the same field
into zd and zn.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 61 ++++++++++++++++------------------
 target/arm/tcg/sme.decode      |  5 ++-
 2 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e3b96914dad..ca88b3cdcc7 100644
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
index 30946330ffe..36fbe24faf8 100644
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
2.53.0



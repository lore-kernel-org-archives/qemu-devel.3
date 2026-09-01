Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B81C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONS-0001Ag-Fd; Tue, 01 Sep 2026 09:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONQ-0001AI-Sh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:12 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONO-0007Fk-U2
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:12 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c250c6a6a9aso749393066b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268689; x=1788873489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PicPLeizDI1jP31VBAPI5vTI7S7bcW5rrnWJ8qVpRbQ=;
 b=hAOhkic24NjHo+ji3QAP+5qcTMmZsj46c6+17f1mBYEzOS0LLaKgDRJ/oQINqvi8NV
 VcFwEp8OWG/XG/dC/XNBoghbQF8hAud4s9b7btFr9GozuzPYTdH+560WoG9+kl1EDDT1
 RjuC4VtDMPWj8jOTcaHNeE83Zpx0Skj5H/BlsZh5653mSr4AFAzEBTKlku3QGDXEDSWb
 hwlQ3rjASoWwgNPEBk/L35jLZCBPvx6wiJ5WggIztrT8Pi30QwWEJUmllj6W9cUBQg1h
 4ziY0TzORI8kiTedN0x9spay2mc/ouQidYy2VcqfF6JUQULvOfzckXTzARhfJREqbe4S
 c/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268689; x=1788873489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PicPLeizDI1jP31VBAPI5vTI7S7bcW5rrnWJ8qVpRbQ=;
 b=SsWwtoNRr3DlbvwhdfGWxHzxrpPGNBGnIOmxi37xCdYQXDWEq8876IZrl3Dk2Pq265
 q0yGnToSvR5SGTozOLKr2B2VeeMuWQuun6xP6XmP6ZkmQg99NZaQBOXKd89zwMtIyE2p
 M6Sn9MJM/fY2rKA99XUkuWrCDJCU/oR523k+JRHBXY5DonDvvPKHmYtNOhhGIB4ffBfL
 Pvb0pnGhcVSivQ//0nwwKNe5h7jQPGLBjWyVsChLBPQjiuqG1IVr2qbtD9KSA4pnADzG
 d5USRFRlDuCtq4MzRWLSxlzAXQWwPHdNqgV6Z/Aago+Di1oRz9FnXxIO6J4aLbUT24LA
 CbcQ==
X-Gm-Message-State: AFuF++lTQBShdC9zStWOMHY+JEZ/hCucP+hlm3fK23Vm+EmOeJ9KVPal
 slU5QPox3SMGzH5Q3d44A3Gbq4c2c/RKhbHtWcvB4RYy43g/UwE0Xz1miIn+iEVarcn4k9hsuy+
 Py0qw49o=
X-Gm-Gg: AR+sD12KDGHyk3xdp8YW9hj161O6MVwc5lXsG24gYCg2PRx5ORYvs1jWAYDuDZosdYt
 U6Q3xZA4An+MWMYozlv164Oz15Y91PKczqrwdO++EtdH1iLcvz3axWUhnFYan5b2FtDFrck687Y
 IeHLhEXakmJpy4Tg8xhrSUwPCybxVwBod+M20GL+IXcDi4KY3EZljGzg47MfKdlaTEst/kKaE04
 y+sTXd36+njoXYIgZCQzA1AjesQNQFdoXS/8VUdwPpV03N7HYh9R8fibw3Yg87C1q8tkDPq0Cyr
 vcOUdns4NZmB+oipSGL0fdRmdRV3joN3LgqVzuTXZg8pahSR47/CYA46C05CRS2X/aSECrE27vo
 eZUxtgLUfGKbZXpOmSD1st6VUm97ZSjACoUKv5LMoKQ+gvHW3XYEonyPxE6jhzh+Hwz+DXJDzhb
 4P8JrRZ4IVCFcz2pj2PubK/LRZXEMbtmTmbkmEsYVcVPNUg/g3+88e0ICpPpbYNEut0BYLL7BE0
 S1uGuxKw7HrdEbv5xAvV4YSHmrQv8FlGdhBnP8rc8qsoAYi1VO8PlOzHidcJTHGBXuLRw==
X-Received: by 2002:a17:906:170b:b0:c24:d6f0:1223 with SMTP id
 a640c23a62f3a-c25b3cba78bmr439041966b.12.1788268689327; 
 Tue, 01 Sep 2026 06:18:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/58] target/arm: Split zdn in do_z2z_nn and do_z2z_nn_fpst
Date: Tue,  1 Sep 2026 14:17:09 +0100
Message-ID: <20260901131732.2263947-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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
Message-id: 20260826174213.614571-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      |  5 ++-
 target/arm/tcg/translate-sme.c | 61 ++++++++++++++++------------------
 2 files changed, 30 insertions(+), 36 deletions(-)

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
-- 
2.43.0



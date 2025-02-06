Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFADDC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80q-000802-KD; Thu, 06 Feb 2025 14:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80P-0007Ie-9V
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:45 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80J-0000Zc-Ao
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:44 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f40deb941so17975005ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871857; x=1739476657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j52lcJgHijYZrJniogMy1lp2HVAxWSxkL0c7K+oR8Wg=;
 b=aKE1p1QYCFgYKUhsXKhrV4hlSfUwOPs6HgZa10k8QC+4xFAIz6GY9pSuW7HU6w4rbj
 /7zyHPD/p+0yqa9iR7e8nUzfk/4T1jjCfuRtLmLFuQFcfVwL93prbVP9mSnqB6ViCDW4
 JXJhsn3fCfnhJVQrdb/w1Caz/uhBImN0IX/TkF80uRSBilApr6r8bgr8ac3QcePbZMrD
 zugLPdoyMB1xChVLDiKB3VC/QiS0zeco0F6x775A/5eJToG2WmONIsg2nRBrDAlHyRZM
 7OaAxFu8MOsifGfSMQhO0NGz4Z3WtTKz65MwnNTkQf23X0JBnZZLP4dSV0SC2OuZ5XIC
 KKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871857; x=1739476657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j52lcJgHijYZrJniogMy1lp2HVAxWSxkL0c7K+oR8Wg=;
 b=fjA7eOztZA59xfCgiiC50ZBPei+fRXP4wP5lMeQn1A2cX3L2BtQo/wkp8MefTGvb9n
 u/0y0rYyEHkwWhpyqbhLN4udDN7hDbtmYYKlPixoslY8GOJfCIKJ382Wwbm0+nfT+TNp
 iPL8dP55GIwTq4DbTxoJjIqhkEZY0YhRSybWlnzqNnAv2BmLpcsPIT3JMQPMnhLsMJ8+
 Tw/oS5i2bqMjZglRNUx1az9qGXBxQI0Hw+zgH7307vsqfDsT10/FSrUk0WGmXoy8Ac+8
 XPMczF8YKLXfRAVyeZwCqgSNy7El6OwVkzUQATa15+TQQ1tn7z3PgAPM4/I0YyzZgSh5
 VGmw==
X-Gm-Message-State: AOJu0Yx72R9183VE242+vP68sntAnF9preibvnwYeZzwEZ3ZvbPtytpC
 fAl044LEJ0DGPZAI3/Au+1gYO/CCfXw1ebUGUQQTkx49y/yb08t6Gr4afMSeGN3Ix1+aqtj7BEY
 c
X-Gm-Gg: ASbGnctXlMnIt3iCogZtrbk/RubNCLm07SJKCfDavnoR5CL4Ih90j79P5gdq6NmjxPq
 s6ILlWhoTiFaAtdBlqFW13Vsx8ursunpdBlXCLAgGWPw/S3GcAoGBluqZPbTzMraNRQCwZvu/g/
 QLsLzWv+4/mMUk85mzD3AaC8jyFpRcb8DnAV7Yvi0OKiOL8et7yynukwFJZTDRwdGmpV3MFI6tQ
 ztXBidR5vxia5uFlsyHEyT2Rte3ttwYYQ+TzGAvCMVXHs3yhjX24CzWJjuRVkgPXkGjXfo8yBig
 S/PdMin9PYZMMVcx6L7QA+BT6gNXbkx2Nmt9MO+Ux8bSaXg=
X-Google-Smtp-Source: AGHT+IEO5Vw7usYNn2E6nxBOSXe+Oydv1gMIXuW5HKW3Ea7nQzJKQ2aF0f8qb0VLH0/YJyOjQq21jA==
X-Received: by 2002:a05:6a00:882:b0:71e:6b8:2f4a with SMTP id
 d2e1a72fcca58-7305d47c9d1mr891553b3a.12.1738871857030; 
 Thu, 06 Feb 2025 11:57:37 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 27/61] target/arm: Implement SME2 Multiple Vectors SVE
 Destructive
Date: Thu,  6 Feb 2025 11:56:41 -0800
Message-ID: <20250206195715.2150758-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 65 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 36 +++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 0e05153924..617621d663 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -550,6 +550,37 @@ TRANS_FEAT(SRSHL_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_srshl)
 TRANS_FEAT(URSHL_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_urshl)
 TRANS_FEAT(SQDMULH_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_sve2_sqdmulh)
 
+static bool do_z2z_nn(DisasContext *s, arg_z2z_en *a, GVecGen3Fn *fn)
+{
+    int esz, dn, dm, vsz, n;
+
+    if (!sme_sm_enabled_check(s)) {
+        return true;
+    }
+
+    esz = a->esz;
+    n = a->n;
+    dn = a->zdn;
+    dm = a->zm;
+    vsz = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; i++) {
+        int dofs = vec_full_reg_offset(s, dn + i);
+        int mofs = vec_full_reg_offset(s, dm + i);
+
+        fn(esz, dofs, dofs, mofs, vsz, vsz);
+    }
+    return true;
+}
+
+TRANS_FEAT(SMAX_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_smax)
+TRANS_FEAT(SMIN_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_smin)
+TRANS_FEAT(UMAX_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_umax)
+TRANS_FEAT(UMIN_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_umin)
+TRANS_FEAT(SRSHL_nn, aa64_sme2, do_z2z_nn, a, gen_gvec_srshl)
+TRANS_FEAT(URSHL_nn, aa64_sme2, do_z2z_nn, a, gen_gvec_urshl)
+TRANS_FEAT(SQDMULH_nn, aa64_sme2, do_z2z_nn, a, gen_gvec_sve2_sqdmulh)
+
 static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
 {
@@ -587,6 +618,36 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     return true;
 }
 
+static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
+                           gen_helper_gvec_3_ptr * const fns[4])
+{
+    int esz = a->esz, n, dn, dm, vsz;
+    gen_helper_gvec_3_ptr *fn;
+    TCGv_ptr fpst;
+
+    if (esz == MO_8 && !dc_isar_feature(aa64_sme2_b16b16, s)) {
+        return false;
+    }
+    if (!sme_sm_enabled_check(s)) {
+        return true;
+    }
+
+    fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+    fn = fns[esz];
+    n = a->n;
+    dn = a->zdn;
+    dm = a->zm;
+    vsz = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; i++) {
+        int dofs = vec_full_reg_offset(s, dn + i);
+        int mofs = vec_full_reg_offset(s, dm + i);
+
+        tcg_gen_gvec_3_ptr(dofs, dofs, mofs, fpst, vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
 static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
     { gen_helper_gvec_fmax_b16,
       gen_helper_gvec_fmax_h,
@@ -598,6 +659,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
       gen_helper_gvec_ah_fmax_d },
 };
 TRANS_FEAT(FMAX_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmax[s->fpcr_ah])
+TRANS_FEAT(FMAX_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmax[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
     { gen_helper_gvec_fmin_b16,
@@ -610,6 +672,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
       gen_helper_gvec_ah_fmin_d },
 };
 TRANS_FEAT(FMIN_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmin[s->fpcr_ah])
+TRANS_FEAT(FMIN_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmin[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
     gen_helper_gvec_fmaxnum_b16,
@@ -618,6 +681,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
     gen_helper_gvec_fmaxnum_d,
 };
 TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmaxnm)
+TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmaxnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
     gen_helper_gvec_fminnum_b16,
@@ -626,3 +690,4 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
     gen_helper_gvec_fminnum_d,
 };
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
+TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 005f87777b..470592f4c0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -209,3 +209,39 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
+
+### SME2 Multi-vector Multiple Vectors SVE Destructive
+
+%zm_ax2         17:4 !function=times_2
+%zm_ax4         18:3 !function=times_4
+
+@z2z_2x2        ....... . esz:2 . ....0 ....0. ..... .... . \
+                &z2z_en n=2 zdn=%zd_ax2 zm=%zm_ax2
+@z2z_4x4        ....... . esz:2 . ...00 ....1. ..... ...0 . \
+                &z2z_en n=4 zdn=%zd_ax4 zm=%zm_ax4
+
+SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_2x2
+SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_4x4
+UMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 1    @z2z_2x2
+UMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 1    @z2z_4x4
+SMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 0    @z2z_2x2
+SMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 0    @z2z_4x4
+UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_2x2
+UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_4x4
+
+FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_2x2
+FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_4x4
+FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_2x2
+FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_4x4
+FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_2x2
+FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_4x4
+FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_2x2
+FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_4x4
+
+SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_2x2
+SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_4x4
+URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_2x2
+URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
+
+SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
+SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
-- 
2.43.0



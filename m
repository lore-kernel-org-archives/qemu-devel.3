Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352DBC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhLY-0003Qq-HF; Fri, 04 Jul 2025 10:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIT-0005Q0-O7
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:51 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIR-00067C-S6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:49 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so1150164fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638906; x=1752243706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRxfJ1u+s+aVTjZ7uskUJBG4OLnsoZb3/qDCUdd3CFw=;
 b=b0wbtZd03toccHrcv/+7r0XFjkBBEr37JafrP4TazDqf2+QvaNNrgrdoko/Aa7JMpm
 qp4/t83quZ+nZHsd5qm1xo6OkKcWJ6EghSv4aCsYPixUslWn+Z6Fwlb/+muWAVKzOjeU
 NW5pWuuhheC15Z8PUTxbSP1Df/WMMHIoepBJfrEYyfamB3XV1AN37hAKoyfWzgFZvHMs
 d+AUUbXH25X1DNmmyEVCpS3++oA4+KPH6u8UjdMuJJnSoFc2QPeAcQPebgcLq1pIikKO
 O/s36J3OC/UiY5lY4itb8WcNqNtQMFpTGGSJvfN8xKNNzeloKR0Q9RDfXC3KRFJ4lUqy
 SSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638906; x=1752243706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRxfJ1u+s+aVTjZ7uskUJBG4OLnsoZb3/qDCUdd3CFw=;
 b=NLPIfFjPTDPTxOhrJ6AVxTUWfdVFw6KXwvsMsE/OrI/CHEANFHvltSJeN3/gWBViup
 lEW9WVvg04BUSwQrMttTDFVn6k29F5sh9g4wpQPTsml7z71cRLyfQGxriWQ22YoYzWUu
 yU+zkrEgBqMW3hGN7HAdOoyX6/Lf8q5QMknDv5eHvtlKgh3xldUBoI/lghXKGaZGL1HC
 JRMPznSbu1z1ZOW+4VdlwjlYLSDZOsphGRxTKq1v8pDFQPC9xRAnK0gg7krrmF5au/16
 erj4Fgv2Z8jbfmWwX3K6iJQFRjXIS240tty2VaKCuAZ6Cftl7XT9541tdghiyI3NQRV6
 3l3A==
X-Gm-Message-State: AOJu0YwfN10QBspjdNzQMCUgUSZbFkXPfHzr2nyhzfF91RLRL6//XWWU
 IknKRXZUVipNrdaZDT1bqw3Tbdid6XkjeseHU4kCbwfjf48hIRJFqWIOITyaTtD7dsvaGdRcX6G
 0ma+5q0k=
X-Gm-Gg: ASbGncs2bZVqwg3H9KX/ZxfkMouNKMJdupntvdKg4fLhsQVQhrOUQZo1rn0CGScPVM7
 FNf3/yKylwK/rUI2cHcNRiQYuwgEZHIaE4gKYvkHj5tW960payL4wLJOlwzTUQV7/w+FzOVZOsK
 Ci2ZVRLjJ3mud3nNPmyknL+TpWTW9bY56ap0MhW8ztm+/mbs1qptG0tiDNDfVJwxXHEemxNRmjt
 BOR3mJEujF/1iH/4nHUX9+Q6kpwFwkDNvuVEB5KcB7Fi7cAJnP8JyajFanEFlGQz7jJDfuHeaKJ
 A2yCKoIQg1/f2w+xPFmmqsLHqlqwnn7lmGNwDKfccgmS0jmt4dV8wcMqmCa6U96bdxNPGzheKeb
 YOrLMYq27UY1Lpi70NdwaV/XlHIgtikBzQIsg1O6afPJBToCn
X-Google-Smtp-Source: AGHT+IHEuH3oVfsdoVYppSvo4WgXEP1kE4vmiaef+8hDGngF0eimq4npMPkPkH6zq6a44L8D8YZtLg==
X-Received: by 2002:a05:6870:85cd:b0:2ea:7101:7dc1 with SMTP id
 586e51a60fabf-2f796d387ddmr1703502fac.33.1751638906557; 
 Fri, 04 Jul 2025 07:21:46 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 031/108] target/arm: Implement SME2 Multiple Vectors SVE
 Destructive
Date: Fri,  4 Jul 2025 08:19:54 -0600
Message-ID: <20250704142112.1018902-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 65 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 36 +++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 954da18ff0..0a6a10b63d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -604,6 +604,37 @@ TRANS_FEAT(SRSHL_n1, aa64_sme2, do_z2z_n1, a, gen_sme2_srshl)
 TRANS_FEAT(URSHL_n1, aa64_sme2, do_z2z_n1, a, gen_sme2_urshl)
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
+TRANS_FEAT(SRSHL_nn, aa64_sme2, do_z2z_nn, a, gen_sme2_srshl)
+TRANS_FEAT(URSHL_nn, aa64_sme2, do_z2z_nn, a, gen_sme2_urshl)
+TRANS_FEAT(SQDMULH_nn, aa64_sme2, do_z2z_nn, a, gen_gvec_sve2_sqdmulh)
+
 static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
 {
@@ -641,6 +672,36 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     return true;
 }
 
+static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
+                           gen_helper_gvec_3_ptr * const fns[4])
+{
+    int esz = a->esz, n, dn, dm, vsz;
+    gen_helper_gvec_3_ptr *fn;
+    TCGv_ptr fpst;
+
+    if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
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
@@ -652,6 +713,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
       gen_helper_gvec_ah_fmax_d },
 };
 TRANS_FEAT(FMAX_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmax[s->fpcr_ah])
+TRANS_FEAT(FMAX_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmax[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
     { gen_helper_gvec_fmin_b16,
@@ -664,6 +726,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
       gen_helper_gvec_ah_fmin_d },
 };
 TRANS_FEAT(FMIN_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmin[s->fpcr_ah])
+TRANS_FEAT(FMIN_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmin[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
     gen_helper_gvec_fmaxnum_b16,
@@ -672,6 +735,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
     gen_helper_gvec_fmaxnum_d,
 };
 TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmaxnm)
+TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmaxnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
     gen_helper_gvec_fminnum_b16,
@@ -680,3 +744,4 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
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



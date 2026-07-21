Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8B2C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFW8-0001UG-Oo; Tue, 21 Jul 2026 14:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUl-00010x-R0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:15 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUh-0006bc-QQ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:10 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so6603016a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659624; x=1785264424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2irtkmCXeSBot/ksE+dJpMF9mnBmRYCPessI916HB3E=;
 b=JgoILgMeUddhX82PCyDCa7KKxBZICUgtl56sjnB3V5caZQ2NAaWyo/z6/sL0jM0bpX
 Z59pZbdR+rMfgEl+SitCbqTFRMqU2Dv3wlqNN65vCr3fAyY2zbFOUJw0+7aMOHBUOtpF
 Jn94KloLN00eu5TB4GA1Lw+X+ks6RC+vfrySS7aWvHLLfRCf/igdh3xsGZqMPMRu6oAa
 Gss91O6qgRDwbqx8YSYRH7loz5xIvIGZoCJd09ZbuZlCv6hUBzJjc0krBaehdYf3VCoa
 9kJi2CWTKVcTYrceHlsX0/fYCYDW8sSBJMk8rCOQ+kz7QgRmnkNCxzNIwJo+4RoRKhll
 gVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659624; x=1785264424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2irtkmCXeSBot/ksE+dJpMF9mnBmRYCPessI916HB3E=;
 b=IlKh4tUrKxNwA3Ph4ARD+eYJIrRktKUISL8pEeTZf2Q8VWnS37zvZEijD1iqIgEbn/
 mZwqX5/hXhWexcS/TFenLAtz3s0eGNzeyb3fw+wthOmaVhmGTKEZsHeGizct7NAOO+I1
 ITkUVkHqt/jJSTe8Rt0t9/w+bsh0UdDU56Pyon4IthfF8Kbry3/BObSn+nWt6NKQJhHU
 GqcVNInEl0d/0XGEYKSXYr8PYVnumcD4+ZUwrj4wVqAzR8ef2gRIUh2NRFxv4FI+/+ij
 plHv48L3PVvglILOGwwgA45i+ux/MVthquK3KF9hn7y4W5Vr4VAXB85vdlcPqhsaLvKc
 oxJg==
X-Gm-Message-State: AOJu0YwJunM51kuSaUjaOpO0HXForeYfk08E1B89NO0QkJlw0N5SznlW
 5nOEOfRPOLYRqmHjucZIQJM1U/WYrKDAlAxoqUvgcGsq7c1unhbyqov3hSBuZ+ROOR/2tZjEq0G
 z3VOi
X-Gm-Gg: AR+sD12S5U85I1NsTcPySCbs/NU2OXmlfc25eRk8/KX+wmuNNwJZwZCQ8A6vX02zcNL
 IbuIb1Kd6b2At4eUcHY1WCIVangaAh+fLb6cGJ7OkUAr9Li3TRbdxDiLg/79FLRIQ/uIrbpO8ee
 3E5Kc9qcXcKp0bfY+96EPh+IRHPKhssjkvkODLhph0LhXr5xS3NBgeT0CTDlASU12ZvaXtkHwFR
 d/LOuIz9JH8T2IwQE4B8SfrdnA/E/KhTiFznaTbFMRxfdzFp8Qfy/D9MK8aXQLB6X360Skdsyq4
 34c2Xh0lJLwCeug9CUMdPCURKlh1mt/2ZoRCaeq5hsYrMXu8pBKp7AcRW4CNtKoVaohchy/1TWr
 /hmAAY41otWYn10sG12kc54FLzLCIWYwxEriPLAlVeq2O8Cj1wb0v6+yj61rOOROA6PsSGT0Y4F
 Lx9Ignp0c=
X-Received: by 2002:a17:90b:3c46:b0:38e:5ab7:ce9b with SMTP id
 98e67ed59e1d1-38e5ab7d242mr17297489a91.21.1784659623515; 
 Tue, 21 Jul 2026 11:47:03 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/20] target/arm: Remove DO_ZPZZ_AH_FP from translate-sme.c
Date: Tue, 21 Jul 2026 11:46:39 -0700
Message-ID: <20260721184656.530230-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Expand the macro at each use site.
Merge the two arrays and index by fpcr_ah.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 41 +++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e77d017656..59a4f9a59b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4415,19 +4415,6 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
  *** SVE Floating Point Arithmetic - Predicated Group
  */
 
-#define DO_ZPZZ_AH_FP(NAME, FEAT, name, ah_name)                        \
-    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
-        NULL,                  gen_helper_##name##_h,                   \
-        gen_helper_##name##_s, gen_helper_##name##_d                    \
-    };                                                                  \
-    static gen_helper_gvec_4_ptr * const name##_ah_zpzz_fns[4] = {      \
-        NULL,                  gen_helper_##ah_name##_h,                \
-        gen_helper_##ah_name##_s, gen_helper_##ah_name##_d              \
-    };                                                                  \
-    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz,                      \
-               s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
-               name##_zpzz_fns[a->esz], a)
-
 #define DO_ZPZZ_AH_FP_B16(NAME, FEAT, name, ah_name)                    \
     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
         gen_helper_##name##_b16, gen_helper_##name##_h,                 \
@@ -4489,7 +4476,14 @@ static gen_helper_gvec_4_ptr * const sve_fminnum_fns[4] = {
 TRANS_FEAT(FMINNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fminnum_fns[a->esz], a)
 
-DO_ZPZZ_AH_FP(FABD, aa64_sme_or_sve, sve_fabd, sve_ah_fabd)
+static gen_helper_gvec_4_ptr * const sve_fabd_zpzz_fns[4][2] = {
+    { NULL, NULL },
+    { gen_helper_sve_fabd_h, gen_helper_sve_ah_fabd_h },
+    { gen_helper_sve_fabd_s, gen_helper_sve_ah_fabd_s },
+    { gen_helper_sve_fabd_d, gen_helper_sve_ah_fabd_d },
+};
+TRANS_FEAT(FABD, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fabd_zpzz_fns[a->esz][s->fpcr_ah], a)
 
 static gen_helper_gvec_4_ptr * const sve_fscalbn_zpzz_fns[4] = {
     NULL,
@@ -8134,8 +8128,23 @@ static gen_helper_gvec_4_ptr * const sve_fminnmp_zpzz_fns[4] = {
 TRANS_FEAT(FMINNMP, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpzz,
            sve_fminnmp_zpzz_fns[a->esz], a)
 
-DO_ZPZZ_AH_FP(FMAXP, aa64_sme_or_sve2, sve2_fmaxp_zpzz, sve2_ah_fmaxp_zpzz)
-DO_ZPZZ_AH_FP(FMINP, aa64_sme_or_sve2, sve2_fminp_zpzz, sve2_ah_fminp_zpzz)
+static gen_helper_gvec_4_ptr * const sve_fmaxp_zpzz_fns[4][2] = {
+    { NULL, NULL },
+    { gen_helper_sve2_fmaxp_zpzz_h, gen_helper_sve2_ah_fmaxp_zpzz_h },
+    { gen_helper_sve2_fmaxp_zpzz_s, gen_helper_sve2_ah_fmaxp_zpzz_s },
+    { gen_helper_sve2_fmaxp_zpzz_d, gen_helper_sve2_ah_fmaxp_zpzz_d },
+};
+TRANS_FEAT(FMAXP, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmaxp_zpzz_fns[a->esz][s->fpcr_ah], a)
+
+static gen_helper_gvec_4_ptr * const sve_fminp_zpzz_fns[4][2] = {
+    { NULL, NULL },
+    { gen_helper_sve2_fminp_zpzz_h, gen_helper_sve2_ah_fminp_zpzz_h },
+    { gen_helper_sve2_fminp_zpzz_s, gen_helper_sve2_ah_fminp_zpzz_s },
+    { gen_helper_sve2_fminp_zpzz_d, gen_helper_sve2_ah_fminp_zpzz_d },
+};
+TRANS_FEAT(FMINP, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fminp_zpzz_fns[a->esz][s->fpcr_ah], a)
 
 static bool do_fmmla(DisasContext *s, arg_rrrr_esz *a,
                      gen_helper_gvec_4_ptr *fn)
-- 
2.43.0



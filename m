Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B541C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMax-0000Qw-K9; Fri, 24 Jan 2025 11:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYf-0004Hj-0a
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYc-0005b6-5b
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:24 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso15731815e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736161; x=1738340961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TAgJkg+zZafmqGOr1+zR48fm7oDoeLOlWLNiEgXtZlc=;
 b=CzYdFop9o4W33OuexZDPqeNpYBlYBDcnK1SbFq1MHRtVeoQScxk0cLDIESYuXCkLR8
 CZbvPdnorTKCH7jVkeYWVL1t+Hf5lgsAOmK9udxgmx/YADKMG1Xlb1IvDOHqdlkNCXRv
 HYmAZJ3dsoc+mwi1GKxyWKzyzvuHHRgO2WbF3vXVRc3tedzECblb+YLy8FDSDFsUHsIJ
 a1nW4P2S7EdTtUGj0qfcmXxVUrIhtC2RgT0Ang2F6DrYh7cs5SqcK71z3UI+9F++xNtL
 Ub7BxWQOC2rG+jb9Q5AbHfpfshRg5DGiqmetPJhLF0U/DnfRF8rmwty5QF21431L/K2e
 W/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736161; x=1738340961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAgJkg+zZafmqGOr1+zR48fm7oDoeLOlWLNiEgXtZlc=;
 b=ti50kGtODcmU7EON6c2s2ibyuNx0KH1NDO0AKDNIoUFgX3o9Cpc3Q+MUptVxWlQpC9
 5YDear1hasGdCznRobWlWtLGRqEHWj2irdeqnK2/4N323cyU3P+beCo4Ps74TxNXhQsl
 X3K3JgR5o8x05epVnEajnIFIjKHHPflW1xVJkf18rvRWQ8CUUy2r5J9ab0vvieDRqeM5
 pMp4Gu7l3y1A+40/I9Ig0fRNTHgsaZFkPDu0J9htpmxYpEpm7IKSD88/+e35vI71MzD6
 dMQTK0rpbHPBvJNl9Biz4JG2MftWXeVgV+yfatyLbcS/hF5wIZ2eDOXe6WB2RG7rJvI/
 6iWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOcRnowUDmw96vLJh5h1gF2GVBu2aE5YqyPwLbTiIPoTS2PSz/CTNtHogppDhJl/IOATs5KIDCl7H9@nongnu.org
X-Gm-Message-State: AOJu0YzzpvSOQXftCWhyxSN48A7tuf8zOBNdNe7181O1iRdCXzBiflHn
 l6fi4Zn0cxK1MEn0ZuWu+7ZSnVxiJczBz95mMeAXUEn4xtuVgW3uzMnJb1HJadA=
X-Gm-Gg: ASbGncv6xRaLKqTp8XqF7JYXforgc7ZrW7SiVCq9RHwdkJwB2SE1Uw69SKjxKgUkUZP
 pZ6qNX3BXhYoYMiIFj+TyXkuBT/rFqHfGBVGs6i48z+xcrMZXg7NVDgYPE2MxvnveoMjoM0Df4m
 fM1iF50owSYda0IWLxpoTUlb3AL1mhhAFxBHOePPHitbS7wgWoNGkYClIf85nHG7OF3y19X/2Zg
 zC8iivA1XwDC68Gh8J84nLghpoxH32T+8YAo9YXDwLyUV5hjassceu3xbhr57XvzoWMT9hLDnpw
 as5WytdozXM=
X-Google-Smtp-Source: AGHT+IGCfSBlw/JAjoj5IIg3QmFxJINLCS1QdH6trh6eIWtKPb9r1OZ13WfpMoNUbnmM+Bsl6C8Gdw==
X-Received: by 2002:a05:600c:348f:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-438913d693bmr339733895e9.11.1737736160692; 
 Fri, 24 Jan 2025 08:29:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 34/76] target/arm: Use FPST_FPCR_AH for BFCVT* insns
Date: Fri, 24 Jan 2025 16:27:54 +0000
Message-Id: <20250124162836.2332150-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When FPCR.AH is 1, use FPST_FPCR_AH for:
 * AdvSIMD BFCVT, BFCVTN, BFCVTN2
 * SVE BFCVT, BFCVTNT

so that they get the required behaviour changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 27 +++++++++++++++++++++------
 target/arm/tcg/translate-sve.c |  6 ++++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2a0c5e23e74..d53864ad794 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8514,7 +8514,7 @@ TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 static const FPScalar1 f_scalar_bfcvt = {
     .gen_s = gen_helper_bfcvt,
 };
-TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar, a, &f_scalar_bfcvt, -1)
+TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar_ah, a, &f_scalar_bfcvt, -1)
 
 static const FPScalar1 f_scalar_frint32 = {
     NULL,
@@ -9290,12 +9290,27 @@ static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
-static ArithOneOp * const f_vector_bfcvtn[] = {
-    NULL,
-    gen_bfcvtn_hs,
-    NULL,
+static void gen_bfcvtn_ah_hs(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_AH);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_bfcvt_pair(tmp, n, fpst);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_vector_bfcvtn[2][3] = {
+    {
+        NULL,
+        gen_bfcvtn_hs,
+        NULL,
+    }, {
+        NULL,
+        gen_bfcvtn_ah_hs,
+        NULL,
+    }
 };
-TRANS_FEAT(BFCVTN_v, aa64_bf16, do_2misc_narrow_vector, a, f_vector_bfcvtn)
+TRANS_FEAT(BFCVTN_v, aa64_bf16, do_2misc_narrow_vector, a,
+           f_vector_bfcvtn[s->fpcr_ah])
 
 static bool trans_SHLL_v(DisasContext *s, arg_qrr_e *a)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8ed8677baa8..4d77b55d545 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3904,7 +3904,8 @@ TRANS_FEAT(FCVT_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_FPCR_F16_A64)
 
 TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_bfcvt, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_bfcvt, a, 0,
+           s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64)
 
 TRANS_FEAT(FCVT_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_FPCR_A64)
@@ -7054,7 +7055,8 @@ TRANS_FEAT(FCVTNT_ds, aa64_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_FPCR_A64)
 
 TRANS_FEAT(BFCVTNT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_bfcvtnt, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_bfcvtnt, a, 0,
+           s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64)
 
 TRANS_FEAT(FCVTLT_hs, aa64_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_hs, a, 0, FPST_FPCR_A64)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC13FC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6Y-0007n8-2o; Tue, 11 Feb 2025 11:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5p-0006dv-4c
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:40 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5m-0003Dj-TV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:36 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso38713045e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291193; x=1739895993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ryV1Ue0br35R/rD6LQ3aXcrygp6/qiCCF2NgOcEO2tA=;
 b=NCZFYuNat52hwAP4tL93ubHJqa5anIhgy+oRAl7efz8JVOPcFKxw3pTW5DZN2KsPxG
 0KUN9JQBLLuK8c7uezrd03uRoZnieeQIrhX+l7R5jMsmx2Mq9dF4vzOF4fmJef1ON606
 S9ZEqWl/B75luqNfsosv95d6ev+18ga7aO5mPerVw8swKitSAGT1nOiWvEHiAarO6ibU
 QZKwSKuRzbQMm3Ofr86Xr0i+Xrv4HbujfvqqFoQA7Lcg1ohMN4csBn29klJRqQagci0E
 oXYCBeY8So5+h77ZGfzQ8/Q50R6l0zGx66gyRspZSG8/4GHTvH3bH/gdyRIqkd7/pNGO
 Dkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291193; x=1739895993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ryV1Ue0br35R/rD6LQ3aXcrygp6/qiCCF2NgOcEO2tA=;
 b=IjALiJEaSa6/Tl2+J9X6oVILLMq3bB1iW4siD5IKPxA9OIdeLyjx5O3UlDepaMuoxG
 bvZT+ZvQywxFFjleZZQBovDM3q68JMBF9AUawxn1Gt5krnIjQRae2PyvXxyq1ybC4ciQ
 V+qDd4IkC9XWE6ktYERwRHiDwWCti2sWk8mXd14s/j7JxhvfzCRpoN1TfWnr5txOYVUt
 pS9MY0jEwSTMJTEh3H/GDEUBWLJ/er7zsi32wawa4iY6VPxbXBP0tNDoQ7ljTz+oVYB5
 gWpXZgfDKSNnvSI5PipqAyCRD7tjobUGHPPGU6zwibY1A9OK3o9dF2oaSMmFEBpz7zFL
 0OKQ==
X-Gm-Message-State: AOJu0YwwgbHvAP6I3HJnSqvTDhTUg1ZG8m0/JrcrtAok+lGW9kau22bo
 U7/dCNaiWCStwoAi5/m8A32fyXMEBMaYdGFa0/w/UpTS1OVZ4UWmML/9xotkH2uLoiqzz2WUqGm
 N
X-Gm-Gg: ASbGncuIaFm4cOxavSwi1UkDlX4VAcbSeW5NqpZFt4zwl/zWDakvluhUPoK6hArR8QH
 UP7WPdVo5eUs3t26uRu+vaEFdxo0tiLrQRo4+KUrx+chc5XW4nhJBZbO4YQBlatR+8tZJDrZHnF
 U3Aar+HAUza2gFgDlHMvEj9MyHTmRzvub0Y4cnvfhk6V5aETLUMHvGEFHW53t1yysDCnRS60xl5
 tIyvryIlw+KzQZWTp/g3UV5cXNQqNHSSAqLtp/OQnvjwOq0W+y1tNyzdYXLCXvwFhm//Wfn51Vw
 Cir80pUmSjUtL508WUv5
X-Google-Smtp-Source: AGHT+IHshWt7fRLdWAWHRE9mtfdXxEAQSemofZubPessONzl3yIm3jkYFPDDh8jQLSWJbHd/ewML/A==
X-Received: by 2002:a05:600c:4e4c:b0:439:495d:33f3 with SMTP id
 5b1f17b1804b1-439495d3590mr53972715e9.1.1739291192889; 
 Tue, 11 Feb 2025 08:26:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/68] target/arm: Handle FPCR.AH in SVE FABD
Date: Tue, 11 Feb 2025 16:25:21 +0000
Message-Id: <20250211162554.4135349-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Make the SVE FABD insn honour the FPCR.AH "don't negate the sign
of a NaN" semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  7 +++++++
 target/arm/tcg/sve_helper.c    | 22 ++++++++++++++++++++++
 target/arm/tcg/translate-sve.c |  2 +-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index ff12f650c87..29c70f054af 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1183,6 +1183,13 @@ DEF_HELPER_FLAGS_6(sve_fabd_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fabd_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_ah_fabd_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fabd_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fabd_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_6(sve_fscalbn_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fscalbn_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 5ce7d736475..8527a7495a6 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4394,9 +4394,31 @@ static inline float64 abd_d(float64 a, float64 b, float_status *s)
     return float64_abs(float64_sub(a, b, s));
 }
 
+/* ABD when FPCR.AH = 1: avoid flipping sign bit of a NaN result */
+static float16 ah_abd_h(float16 op1, float16 op2, float_status *stat)
+{
+    float16 r = float16_sub(op1, op2, stat);
+    return float16_is_any_nan(r) ? r : float16_abs(r);
+}
+
+static float32 ah_abd_s(float32 op1, float32 op2, float_status *stat)
+{
+    float32 r = float32_sub(op1, op2, stat);
+    return float32_is_any_nan(r) ? r : float32_abs(r);
+}
+
+static float64 ah_abd_d(float64 op1, float64 op2, float_status *stat)
+{
+    float64 r = float64_sub(op1, op2, stat);
+    return float64_is_any_nan(r) ? r : float64_abs(r);
+}
+
 DO_ZPZZ_FP(sve_fabd_h, uint16_t, H1_2, abd_h)
 DO_ZPZZ_FP(sve_fabd_s, uint32_t, H1_4, abd_s)
 DO_ZPZZ_FP(sve_fabd_d, uint64_t, H1_8, abd_d)
+DO_ZPZZ_FP(sve_ah_fabd_h, uint16_t, H1_2, ah_abd_h)
+DO_ZPZZ_FP(sve_ah_fabd_s, uint32_t, H1_4, ah_abd_s)
+DO_ZPZZ_FP(sve_ah_fabd_d, uint64_t, H1_8, ah_abd_d)
 
 static inline float64 scalbn_d(float64 a, int64_t b, float_status *s)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 646d0171d99..0d8bd1a49c4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3789,7 +3789,7 @@ DO_ZPZZ_AH_FP(FMIN_zpzz, aa64_sve, sve_fmin, sve_ah_fmin)
 DO_ZPZZ_AH_FP(FMAX_zpzz, aa64_sve, sve_fmax, sve_ah_fmax)
 DO_ZPZZ_FP(FMINNM_zpzz, aa64_sve, sve_fminnum)
 DO_ZPZZ_FP(FMAXNM_zpzz, aa64_sve, sve_fmaxnum)
-DO_ZPZZ_FP(FABD, aa64_sve, sve_fabd)
+DO_ZPZZ_AH_FP(FABD, aa64_sve, sve_fabd, sve_ah_fabd)
 DO_ZPZZ_FP(FSCALE, aa64_sve, sve_fscalbn)
 DO_ZPZZ_FP(FDIV, aa64_sve, sve_fdiv)
 DO_ZPZZ_FP(FMULX, aa64_sve, sve_fmulx)
-- 
2.34.1



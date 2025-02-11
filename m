Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F34EC0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5W-0006TA-Hb; Tue, 11 Feb 2025 11:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5R-0006Qk-GL
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:14 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5P-000357-PZ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:13 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso19847435e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291170; x=1739895970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x3CA5n1naveT+MpaOpPgyq3UeqdhR8QZVcMIkbtZ6ic=;
 b=mPGj/Z2UzNmV5yLBmPLJW7jclhmIUpUN6Qxl1hBixZi4MOeudBtUsFO95v1vD3ZnJs
 R3gEHyhkx32XRqnHkfMWqLd2/5wGQ8ytrxaz8KYEyyFg+Te+0yaU0q571iasVjWXiiZx
 NFb12LgvsYp6F+7uHZVfe8KpZGCovtqBOfsPAAtaPwAJeWcfDSMj0xFDgYtAzgoLDku+
 cAwLiO5iFPpoTFLjZdUZWNSyN1gghLjRoGlevXXcw7yyettEQTtLbeWTJ8/7F2VcjS0F
 W431KochSFbnYtL0oUoYrOR9u6/l6hGjhwuKwpS4tgHmlsRHVbdKq6NMsxMTG23XqHou
 doBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291170; x=1739895970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3CA5n1naveT+MpaOpPgyq3UeqdhR8QZVcMIkbtZ6ic=;
 b=lsSsPNbBLrl9sSJRqivQusdOeerAJv+3ZK9LKZJ00Zb22Bafm3i7okytCr8dhwWoWf
 qrxh0QRne2uC3sVqYhQyskYzPT2XL0/e5Wp4y9tpnoBFc63LSotAZ6GqHJT/tRNE2qfs
 PZ9kvbzDA1gtUza6NKObY9ddPVYF35Ta3c9af9c1qC8QUM0mTzYxbVURmOpG0+gXHFn9
 nEGPCdi1MA6YUtN02vMTtI0ynjgdMIKj60nmls26+l7ldK6kUDxi9zI0yUbLsLQQ8Upr
 myYAgmmCR9KXnFDZ/888K+t7eNpsXDxQV7A1Rdc3Ho05RgQ4tOBATFnHzq44edjKUGUk
 cqHg==
X-Gm-Message-State: AOJu0Yyv4ozIYhuiRp482qsptNUY5P4IA+8WFR552jK176B1EKZmPvsj
 z/LpAHBX40BQxOtG61AQHbOwasxeARJKpuOTXncKRrtkod1jLv7GrezAV1kcjJv8c3qXxAuWi2N
 z
X-Gm-Gg: ASbGncs11JIk3Z19wltep/tC3ExEWsHyMtriVxB4//SL66h3xzC0DEir/WNanI1wnNn
 /69LRBDV7j9BulpCdd0OPDbqReyUMuXrU6WdX9+A4sNkO+IwF7gpqZOm7M3Wba7RnUV+rue58jV
 cxM5D/QjdqO9bd1k/yzkhgt6LwA+BVyYNduRKyCLXNUtYUYgaK3jQv1xXrW7moD/VplL1tE9lRn
 S7FYQ2qXsQGqk+KE7kFLfd9A/ojCA5fwcFCnLhDZlaa8TeS0LZ7e9XakNg0TWR28QNi4mTqhqos
 48QcDH6vdQ8wW3r1ajrd
X-Google-Smtp-Source: AGHT+IFjHLG8v8G30+Rb1cwoMukwcZbPs9ZGO5dEE0czkGcXHBvs/MNxjzehrXv7Xm1GbcPZrYby9Q==
X-Received: by 2002:a05:600c:3d8b:b0:438:a313:cda9 with SMTP id
 5b1f17b1804b1-4394cf0112dmr34715245e9.10.1739291170121; 
 Tue, 11 Feb 2025 08:26:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/68] target/arm: Use FPST_FPCR_AH for BFCVT* insns
Date: Tue, 11 Feb 2025 16:24:58 +0000
Message-Id: <20250211162554.4135349-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

When FPCR.AH is 1, use FPST_FPCR_AH for:
 * AdvSIMD BFCVT, BFCVTN, BFCVTN2
 * SVE BFCVT, BFCVTNT

so that they get the required behaviour changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 27 +++++++++++++++++++++------
 target/arm/tcg/translate-sve.c |  6 ++++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1556980c761..f3028463e36 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8503,7 +8503,7 @@ TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 static const FPScalar1 f_scalar_bfcvt = {
     .gen_s = gen_helper_bfcvt,
 };
-TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar, a, &f_scalar_bfcvt, -1)
+TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar_ah, a, &f_scalar_bfcvt, -1)
 
 static const FPScalar1 f_scalar_frint32 = {
     NULL,
@@ -9279,12 +9279,27 @@ static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
-static ArithOneOp * const f_vector_bfcvtn[] = {
-    NULL,
-    gen_bfcvtn_hs,
-    NULL,
+static void gen_bfcvtn_ah_hs(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_ptr fpst = fpstatus_ptr(FPST_AH);
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
index c084bb58e7e..be2b5528ba0 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3904,7 +3904,8 @@ TRANS_FEAT(FCVT_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_bfcvt, a, 0, FPST_A64)
+           gen_helper_sve_bfcvt, a, 0,
+           s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVT_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
@@ -7054,7 +7055,8 @@ TRANS_FEAT(FCVTNT_ds, aa64_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
 
 TRANS_FEAT(BFCVTNT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_bfcvtnt, a, 0, FPST_A64)
+           gen_helper_sve_bfcvtnt, a, 0,
+           s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs, aa64_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
-- 
2.34.1



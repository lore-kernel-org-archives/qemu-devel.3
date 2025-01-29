Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E749CC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2y-0000se-Bf; Tue, 28 Jan 2025 20:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2u-0000qF-SP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:12 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2t-0003Wl-0L
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:12 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso112724915ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114749; x=1738719549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7xWXB+eng8DnKFn3D01/tYMXRHmURU0wtcrE+/Ypck=;
 b=exHhm0dQ+7JlR5Y4LKxDHH7LlpNGKc26s5rImlens5AlA24KprtEKb0NmbdpcWwCO7
 QWymafJPIvdB/cbr6ZioTVXW+C21xG0S0EeUwTAuSiu+okUgL0SulyllUyNteUc4MUOX
 GIvjUg5RuqVCLmkyzGXbEW93wVr+60zCLhleCO5/NwubWr/92+IDmG4cLUzwNJsM6xcU
 bSShK5tP5RmZnM3HkCmXid0ELZ/OBsCKeS5j3+NyzZoHtI24q2Zf+GbmF/COZTCtEWOL
 AKOspeMWbzSMblJO0JEzMNJTQPhIrPrJm1tl3edJgaHAQaVEcScu/rF9YuuT/AkPGXGI
 mfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114749; x=1738719549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7xWXB+eng8DnKFn3D01/tYMXRHmURU0wtcrE+/Ypck=;
 b=nQQ2ZtQ6DYkfoXSesoAXLx5RCVxyWrmGAkyRUAc8a7iygV6Fb11fMLB7HlFq0PtZ/6
 oae1F5u7jAmJ1ncK/J85azGeso4aPg8Qu63etc+OjaQl1XiNRG8siLcABJnvc+liMKKE
 YJFaDjYBa+h8fjLXnnToTZgjY0WaCJWp4N8zC9bsTV+6ussptLU/sW/UbJ1G9aAvKNPg
 7A7kO8Z8WaFFAVVfq42IIcSF8OvhdPjS9LtV8kZeWJvuJ1tB+KVAgPbIcJgP1iJ6lktI
 ix9oUWzbN7tt9QZo5lGc7cOh4f3JU9pkQDiNA8ZpZg+gKuvemnzxr9SBPbIj+CmxyV8Q
 imXQ==
X-Gm-Message-State: AOJu0YxKemxtLISLrs5ASriIg8vrNQj/YMYdqR1XjtFvBn1CxU93wRtl
 nzvBGtGf7kVhSBL3GKoJSjuHaPtwaAmkVVq1AUDWUJ0VeP244AN7R9zohCd51sPBFUjEnDrtaTe
 o
X-Gm-Gg: ASbGnct3uugCUh8oHRHOua4UyeYEJxuY/+Gayq/rQMUPAfU4Gp3EysOWjTK2BD3xneE
 kmGqK62uuR+3JzmqlCjzRFSsaO0sYF+cw7F9FvTNObjAd/6Mm/IguJCFndSCiZfmrDfOhilfBlE
 PqAH65Y2VKzifNTbo2bH0WZKiZMorVCcEbOalWf/YaIEHlgWr8B4K6jWFH76M7RKjsEZFoF1Sjv
 UiRv/7toX+p6DD24yDny/ZDSqHic+g9Qv8l0dOxdrZx8tTAozyLNBUQIxPVbbGVtmy3yHrWtBkb
 cIvj2M/BUxjFXVecCcaP8uxyWCT83IkVLSs6xwztsyuIbDXzgw==
X-Google-Smtp-Source: AGHT+IEtvZsQGLQk65zo70iMHbiicWo73xcxZPx4n40Rr/VqEl8nhxFTQNl3hNLYzhph/qXf48Rwiw==
X-Received: by 2002:a17:902:ea12:b0:215:9a73:6c45 with SMTP id
 d9443c01a7336-21dd7d6e17bmr19880255ad.22.1738114749226; 
 Tue, 28 Jan 2025 17:39:09 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 15/34] target/arm: Simplify fp_status indexing in
 mve_helper.c
Date: Tue, 28 Jan 2025 17:38:38 -0800
Message-ID: <20250129013857.135256-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Select on index instead of pointer.
No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 40 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 3763d71e20..274003e2e5 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2814,8 +2814,7 @@ DO_VMAXMINA(vminaw, 4, int32_t, uint32_t, DO_MIN)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2888,8 +2887,7 @@ DO_2OP_FP_ALL(vminnma, minnuma)
                 r[e] = 0;                                               \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(tm & 1)) {                                            \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2926,8 +2924,7 @@ DO_VCADD_FP(vfcadd270s, 4, float32, float32_add, float32_sub)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -2964,8 +2961,7 @@ DO_VFMA(vfmss, 4, float32, true)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE * 2)) == 0) {          \
                 continue;                                               \
             }                                                           \
-            fpst0 = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :  \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst0 = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             fpst1 = fpst0;                                              \
             if (!(mask & 1)) {                                          \
                 scratch_fpst = *fpst0;                                  \
@@ -3049,8 +3045,7 @@ DO_VCMLA(vcmla270s, 4, float32, 3, DO_VCMLAS)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3084,8 +3079,7 @@ DO_2OP_FP_SCALAR_ALL(vfmul_scalar, mul)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3116,9 +3110,8 @@ DO_2OP_FP_ACC_SCALAR(vfmas_scalars, 4, float32, DO_VFMAS_SCALARS)
         unsigned e;                                             \
         TYPE *m = vm;                                           \
         TYPE ra = (TYPE)ra_in;                                  \
-        float_status *fpst = (ESIZE == 2) ?                     \
-            &env->vfp.fp_status[FPST_STD_F16] :                 \
-            &env->vfp.fp_status[FPST_STD];                       \
+        float_status *fpst =                                    \
+            &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {      \
             if (mask & 1) {                                     \
                 TYPE v = m[H##ESIZE(e)];                        \
@@ -3168,8 +3161,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3202,8 +3194,7 @@ DO_FP_VMAXMINV(vminnmavs, 4, float32, true, float32_minnum)
             if ((mask & emask) == 0) {                                  \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & (1 << (e * ESIZE)))) {                         \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3267,8 +3258,7 @@ DO_VCMP_FP_BOTH(vfcmples, vfcmple_scalars, 4, float32, !DO_GT32)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
@@ -3300,9 +3290,8 @@ DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, helper_vfp_touls_round_to_zero)
         unsigned e;                                                     \
         float_status *fpst;                                             \
         float_status scratch_fpst;                                      \
-        float_status *base_fpst = (ESIZE == 2) ?                        \
-            &env->vfp.fp_status[FPST_STD_F16] :                         \
-            &env->vfp.fp_status[FPST_STD];                               \
+        float_status *base_fpst =                                       \
+            &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD];  \
         uint32_t prev_rmode = get_float_rounding_mode(base_fpst);       \
         set_float_rounding_mode(rmode, base_fpst);                      \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
@@ -3427,8 +3416,7 @@ void HELPER(mve_vcvtt_hs)(CPUARMState *env, void *vd, void *vm)
             if ((mask & MAKE_64BIT_MASK(0, ESIZE)) == 0) {              \
                 continue;                                               \
             }                                                           \
-            fpst = (ESIZE == 2) ? &env->vfp.fp_status[FPST_STD_F16] :   \
-                &env->vfp.fp_status[FPST_STD];                           \
+            fpst = &env->vfp.fp_status[ESIZE == 2 ? FPST_STD_F16 : FPST_STD]; \
             if (!(mask & 1)) {                                          \
                 /* We need the result but without updating flags */     \
                 scratch_fpst = *fpst;                                   \
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8CCC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht78-0001HO-TH; Tue, 11 Feb 2025 11:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5x-0006j7-0G
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5s-0003Gt-T1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:44 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394829ef0fso12782545e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291196; x=1739895996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TAfFrKI2WwXhxpUXkpaZcgi/VYzxx9SsJeJ6mL3/bRg=;
 b=PHyhlo2AvzrTghxN1fQtYLMV/VNu1RWlQyZcM5a/Hbtmuy38VXQgsB3aIusVAdNiNQ
 J6459K5PxZSKFGABUmaHFIDYvxoT9xV9KNFoXDJxzqyYPnHgGezZhyWxamnJi7uU6WfS
 Lj6Oo+oOJg04RgSfBzZUmoMPEb5WTAh+VcNqR8zgTgOkxIwx9TAn2Ic187/TrFqG5mW7
 QsSyQ+v5/mugcqg+M4U6KUugGKqXTUeIg0z3KZU7oiUjkwnfKZ1Vq6SV/iYfl/oKIfvh
 9+iqbqBhlbhYOqNhiDVPVv90dGxZAcne9C1vJLSOA5Ia57boYaHe/GFIpwA8I1qL3NMy
 QUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291196; x=1739895996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TAfFrKI2WwXhxpUXkpaZcgi/VYzxx9SsJeJ6mL3/bRg=;
 b=FAMxurHSwLkoZRDvAfqpMHwAyQjPuF9mNdPD8M9RzqD5PHMuNppJM7yDuYUM1pDAU9
 TOzpcNKSrDqblfGW4VmpMbTQIzx2goR8Sg43qm4/aHhNC8D8y2YC0SQnCOZB0FAxrJp2
 zvINdn2+fPI0EYrx1tMB2dVgRcT28JzPqbK3p9LFBS6uZM4U0ABT0FdCwZs8aPNPrOSB
 AfZRFArwsunX2J9auZrSGAvko/Pm4/hefGu3BUGH6omfDUWO+o0qI+xjjSqyIlpEACfT
 fw6i0rBz2H3ohFEjKSaLbn9j7s8yTUYmPQcpMTsPUI5Q4ehS5qWkNDJhZPLSqcmtdfrD
 Rlhw==
X-Gm-Message-State: AOJu0YzoLi06BH93kWKUrZjg4zcAdws4B8c9zbvWrRZzrtAJABQCm/GX
 cosqCj6UYiiILo7B3YVSTudyNC39AzjjRdmCgDvFuTJxMrhzEzJ6OGQJvFK2TwLJPUttG1Nm4dh
 p
X-Gm-Gg: ASbGncve3BF51WJ2C67DKjWfsc74JuUxL3zeHQySsFXUsAQQQth11ODjv4FE22LmTJB
 qvShy3VOKjTT7G8YPVWl3fDYaP9qzaO3gQZwJM2XqOFpoIFXGs071Fx+nVLNsGNCVeZtBvJYunX
 LPM4yPWs5CxtbpFcvjB/HcP96YvaxoKbdeAWDpQehglVYv+L+z+gw4LdYvjHsxanaPDZIE3rSGj
 oORv2p6KMeF6689OvZF/c97dzOiyfAqz0OTJvfxBxAet38IrpaaXRaLhlxXwbxtxGHZ+QQffqDE
 4IjGHowFBx6apFbt2ODI
X-Google-Smtp-Source: AGHT+IFy6yNJO5vRo4AZD4r/Ffn5G3Jn93u0o4UAAFWoe+8t4P3TGNWjOuhNA0M39F+c7zYB3YumBQ==
X-Received: by 2002:a05:600c:d3:b0:439:4a4a:7863 with SMTP id
 5b1f17b1804b1-4394cee5fd4mr38120755e9.15.1739291196280; 
 Tue, 11 Feb 2025 08:26:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/68] target/arm: Handle FPCR.AH in FRECPS and FRSQRTS scalar
 insns
Date: Tue, 11 Feb 2025 16:25:24 +0000
Message-Id: <20250211162554.4135349-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Handle the FPCR.AH semantics that we do not change the sign of an
input NaN in the FRECPS and FRSQRTS scalar insns, by providing
new helper functions that do the CHS part of the operation
differently.

Since the extra helper functions would be very repetitive if written
out longhand, we condense them and the existing non-AH helpers into
being emitted via macros.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    |   6 ++
 target/arm/tcg/vec_internal.h  |  18 ++++++
 target/arm/tcg/helper-a64.c    | 115 ++++++++++++---------------------
 target/arm/tcg/translate-a64.c |  25 +++++--
 4 files changed, 83 insertions(+), 81 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index ae0424f6de9..85023465b76 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -38,9 +38,15 @@ DEF_HELPER_FLAGS_3(neon_cgt_f64, TCG_CALL_NO_RWG, i64, i64, i64, fpst)
 DEF_HELPER_FLAGS_3(recpsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
 DEF_HELPER_FLAGS_3(recpsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, fpst)
 DEF_HELPER_FLAGS_3(recpsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
+DEF_HELPER_FLAGS_3(recpsf_ah_f16, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
+DEF_HELPER_FLAGS_3(recpsf_ah_f32, TCG_CALL_NO_RWG, f32, f32, f32, fpst)
+DEF_HELPER_FLAGS_3(recpsf_ah_f64, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
 DEF_HELPER_FLAGS_3(rsqrtsf_f16, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
 DEF_HELPER_FLAGS_3(rsqrtsf_f32, TCG_CALL_NO_RWG, f32, f32, f32, fpst)
 DEF_HELPER_FLAGS_3(rsqrtsf_f64, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
+DEF_HELPER_FLAGS_3(rsqrtsf_ah_f16, TCG_CALL_NO_RWG, f16, f16, f16, fpst)
+DEF_HELPER_FLAGS_3(rsqrtsf_ah_f32, TCG_CALL_NO_RWG, f32, f32, f32, fpst)
+DEF_HELPER_FLAGS_3(rsqrtsf_ah_f64, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
 DEF_HELPER_FLAGS_2(frecpx_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
 DEF_HELPER_FLAGS_2(frecpx_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
 DEF_HELPER_FLAGS_2(frecpx_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 826791523a6..6b93b5aeb94 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -267,6 +267,24 @@ float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
  */
 bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp);
 
+/*
+ * Negate as for FPCR.AH=1 -- do not negate NaNs.
+ */
+static inline float16 float16_ah_chs(float16 a)
+{
+    return float16_is_any_nan(a) ? a : float16_chs(a);
+}
+
+static inline float32 float32_ah_chs(float32 a)
+{
+    return float32_is_any_nan(a) ? a : float32_chs(a);
+}
+
+static inline float64 float64_ah_chs(float64 a)
+{
+    return float64_is_any_nan(a) ? a : float64_chs(a);
+}
+
 static inline float16 float16_maybe_ah_chs(float16 a, bool fpcr_ah)
 {
     return fpcr_ah && float16_is_any_nan(a) ? a : float16_chs(a);
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ed5e4a45997..32f0647ca4f 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -38,6 +38,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
+#include "vec_internal.h"
 
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
@@ -208,88 +209,52 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, float_status *fpst)
     return -float64_lt(b, a, fpst);
 }
 
-/* Reciprocal step and sqrt step. Note that unlike the A32/T32
+/*
+ * Reciprocal step and sqrt step. Note that unlike the A32/T32
  * versions, these do a fully fused multiply-add or
  * multiply-add-and-halve.
+ * The FPCR.AH == 1 versions need to avoid flipping the sign of NaN.
  */
-
-uint32_t HELPER(recpsf_f16)(uint32_t a, uint32_t b, float_status *fpst)
-{
-    a = float16_squash_input_denormal(a, fpst);
-    b = float16_squash_input_denormal(b, fpst);
-
-    a = float16_chs(a);
-    if ((float16_is_infinity(a) && float16_is_zero(b)) ||
-        (float16_is_infinity(b) && float16_is_zero(a))) {
-        return float16_two;
+#define DO_RECPS(NAME, CTYPE, FLOATTYPE, CHSFN)                         \
+    CTYPE HELPER(NAME)(CTYPE a, CTYPE b, float_status *fpst)            \
+    {                                                                   \
+        a = FLOATTYPE ## _squash_input_denormal(a, fpst);               \
+        b = FLOATTYPE ## _squash_input_denormal(b, fpst);               \
+        a = FLOATTYPE ## _ ## CHSFN(a);                                 \
+        if ((FLOATTYPE ## _is_infinity(a) && FLOATTYPE ## _is_zero(b)) || \
+            (FLOATTYPE ## _is_infinity(b) && FLOATTYPE ## _is_zero(a))) { \
+            return FLOATTYPE ## _two;                                   \
+        }                                                               \
+        return FLOATTYPE ## _muladd(a, b, FLOATTYPE ## _two, 0, fpst);  \
     }
-    return float16_muladd(a, b, float16_two, 0, fpst);
-}
 
-float32 HELPER(recpsf_f32)(float32 a, float32 b, float_status *fpst)
-{
-    a = float32_squash_input_denormal(a, fpst);
-    b = float32_squash_input_denormal(b, fpst);
+DO_RECPS(recpsf_f16, uint32_t, float16, chs)
+DO_RECPS(recpsf_f32, float32, float32, chs)
+DO_RECPS(recpsf_f64, float64, float64, chs)
+DO_RECPS(recpsf_ah_f16, uint32_t, float16, ah_chs)
+DO_RECPS(recpsf_ah_f32, float32, float32, ah_chs)
+DO_RECPS(recpsf_ah_f64, float64, float64, ah_chs)
 
-    a = float32_chs(a);
-    if ((float32_is_infinity(a) && float32_is_zero(b)) ||
-        (float32_is_infinity(b) && float32_is_zero(a))) {
-        return float32_two;
-    }
-    return float32_muladd(a, b, float32_two, 0, fpst);
-}
+#define DO_RSQRTSF(NAME, CTYPE, FLOATTYPE, CHSFN)                       \
+    CTYPE HELPER(NAME)(CTYPE a, CTYPE b, float_status *fpst)            \
+    {                                                                   \
+        a = FLOATTYPE ## _squash_input_denormal(a, fpst);               \
+        b = FLOATTYPE ## _squash_input_denormal(b, fpst);               \
+        a = FLOATTYPE ## _ ## CHSFN(a);                                 \
+        if ((FLOATTYPE ## _is_infinity(a) && FLOATTYPE ## _is_zero(b)) || \
+            (FLOATTYPE ## _is_infinity(b) && FLOATTYPE ## _is_zero(a))) { \
+            return FLOATTYPE ## _one_point_five;                        \
+        }                                                               \
+        return FLOATTYPE ## _muladd_scalbn(a, b, FLOATTYPE ## _three,   \
+                                           -1, 0, fpst);                \
+    }                                                                   \
 
-float64 HELPER(recpsf_f64)(float64 a, float64 b, float_status *fpst)
-{
-    a = float64_squash_input_denormal(a, fpst);
-    b = float64_squash_input_denormal(b, fpst);
-
-    a = float64_chs(a);
-    if ((float64_is_infinity(a) && float64_is_zero(b)) ||
-        (float64_is_infinity(b) && float64_is_zero(a))) {
-        return float64_two;
-    }
-    return float64_muladd(a, b, float64_two, 0, fpst);
-}
-
-uint32_t HELPER(rsqrtsf_f16)(uint32_t a, uint32_t b, float_status *fpst)
-{
-    a = float16_squash_input_denormal(a, fpst);
-    b = float16_squash_input_denormal(b, fpst);
-
-    a = float16_chs(a);
-    if ((float16_is_infinity(a) && float16_is_zero(b)) ||
-        (float16_is_infinity(b) && float16_is_zero(a))) {
-        return float16_one_point_five;
-    }
-    return float16_muladd_scalbn(a, b, float16_three, -1, 0, fpst);
-}
-
-float32 HELPER(rsqrtsf_f32)(float32 a, float32 b, float_status *fpst)
-{
-    a = float32_squash_input_denormal(a, fpst);
-    b = float32_squash_input_denormal(b, fpst);
-
-    a = float32_chs(a);
-    if ((float32_is_infinity(a) && float32_is_zero(b)) ||
-        (float32_is_infinity(b) && float32_is_zero(a))) {
-        return float32_one_point_five;
-    }
-    return float32_muladd_scalbn(a, b, float32_three, -1, 0, fpst);
-}
-
-float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, float_status *fpst)
-{
-    a = float64_squash_input_denormal(a, fpst);
-    b = float64_squash_input_denormal(b, fpst);
-
-    a = float64_chs(a);
-    if ((float64_is_infinity(a) && float64_is_zero(b)) ||
-        (float64_is_infinity(b) && float64_is_zero(a))) {
-        return float64_one_point_five;
-    }
-    return float64_muladd_scalbn(a, b, float64_three, -1, 0, fpst);
-}
+DO_RSQRTSF(rsqrtsf_f16, uint32_t, float16, chs)
+DO_RSQRTSF(rsqrtsf_f32, float32, float32, chs)
+DO_RSQRTSF(rsqrtsf_f64, float64, float64, chs)
+DO_RSQRTSF(rsqrtsf_ah_f16, uint32_t, float16, ah_chs)
+DO_RSQRTSF(rsqrtsf_ah_f32, float32, float32, ah_chs)
+DO_RSQRTSF(rsqrtsf_ah_f64, float64, float64, ah_chs)
 
 /* Floating-point reciprocal exponent - see FPRecpX in ARM ARM */
 uint32_t HELPER(frecpx_f16)(uint32_t a, float_status *fpst)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e8db9f39b16..1b6d8598b8e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5239,11 +5239,12 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f,
                                        FPST_A64_F16 : FPST_A64);
 }
 
-static bool do_fp3_scalar_ah(DisasContext *s, arg_rrr_e *a, const FPScalar *f,
-                             int mergereg)
+static bool do_fp3_scalar_ah_2fn(DisasContext *s, arg_rrr_e *a,
+                                 const FPScalar *fnormal, const FPScalar *fah,
+                                 int mergereg)
 {
-    return do_fp3_scalar_with_fpsttype(s, a, f, mergereg,
-                                       select_ah_fpst(s, a->esz));
+    return do_fp3_scalar_with_fpsttype(s, a, s->fpcr_ah ? fah : fnormal,
+                                       mergereg, select_ah_fpst(s, a->esz));
 }
 
 /* Some insns need to call different helpers when FPCR.AH == 1 */
@@ -5464,14 +5465,26 @@ static const FPScalar f_scalar_frecps = {
     gen_helper_recpsf_f32,
     gen_helper_recpsf_f64,
 };
-TRANS(FRECPS_s, do_fp3_scalar_ah, a, &f_scalar_frecps, a->rn)
+static const FPScalar f_scalar_ah_frecps = {
+    gen_helper_recpsf_ah_f16,
+    gen_helper_recpsf_ah_f32,
+    gen_helper_recpsf_ah_f64,
+};
+TRANS(FRECPS_s, do_fp3_scalar_ah_2fn, a,
+      &f_scalar_frecps, &f_scalar_ah_frecps, a->rn)
 
 static const FPScalar f_scalar_frsqrts = {
     gen_helper_rsqrtsf_f16,
     gen_helper_rsqrtsf_f32,
     gen_helper_rsqrtsf_f64,
 };
-TRANS(FRSQRTS_s, do_fp3_scalar_ah, a, &f_scalar_frsqrts, a->rn)
+static const FPScalar f_scalar_ah_frsqrts = {
+    gen_helper_rsqrtsf_ah_f16,
+    gen_helper_rsqrtsf_ah_f32,
+    gen_helper_rsqrtsf_ah_f64,
+};
+TRANS(FRSQRTS_s, do_fp3_scalar_ah_2fn, a,
+      &f_scalar_frsqrts, &f_scalar_ah_frsqrts, a->rn)
 
 static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
                        const FPScalar *f, bool swap)
-- 
2.34.1



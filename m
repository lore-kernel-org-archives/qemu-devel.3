Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05BAC0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5K-0006OI-Lq; Tue, 11 Feb 2025 11:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5I-0006NZ-Cz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:04 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5F-00031X-B6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:03 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dd14c9a66so1608090f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291159; x=1739895959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W2lBHnU/MU2TyjktOcUF41UyX08vQR6GV7D0L3jAq2Q=;
 b=KwuMwBjFh+tf5mt/in5dFlsa2ixZjiUfHt6ckieKLZsVeRJyzfG64kdQGdb6o+QibE
 +pQQ+EmSQcha3Vkr4SiR9UICLGctqmwbNPzler2UWa+ZIX4aWLLoYhL3IXrekqxkmget
 QsShSbsMeeWSR3H++sRhu4kxeDYAqptN3Q4Wbpd9E5BtdEWaU/Ew3Mxpp/k/A8zaP5j5
 HKCkRNLkjgwuK6osDSRB2gI6RP1My4BGROipX5x000U54JqPkc271PwCBmUEaKQUUO6m
 YwIqTegAL3o2fViyHHLJc9hweSLW7wVqPBLiixKZsJKgr/N+ARt1VoWHgv3G5YCrEQSz
 FCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291159; x=1739895959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2lBHnU/MU2TyjktOcUF41UyX08vQR6GV7D0L3jAq2Q=;
 b=dbRnBuc2OTAudC5fPyLxz6411SCxLpMlKoCWtBLfEXsWQLrwvALOe4kuKliW0Qe4KF
 vzrCj9Qui+0YvhbM1XuqdKEpLaeNNUPsvzEdbS1SD0lQgFg7d0E1i7wfBnMV5yOdDoFX
 LDraCkxMFdBI7fOqslMuEHtEPfKHB0ofaqYEOmUXFY7m171wq6YgV70S1SRxMUxzYh7L
 j9xDddm3aC3uWQQ6wUVXVR3qt34n2nFF5Gdwafz/uQuyF0jQCPfwZssNeDgzQz1I9zsk
 15Pt93BUAqDMJNfOk49BM7sGUBj5VCfdMStHtVV6OyHKOa0uMSAElfr50uifaOItVmJt
 A0TQ==
X-Gm-Message-State: AOJu0YwmBqKzp5p1EjY8UbKnXIV7snDJhHomxminYyvTpE5sjyfK5RdT
 FqQ5u5hkYI9/Uu57SyjLXy+KL+50pfJX5/8mNvNFJPjpyGRMdS/+h2R5/FImv5qTJ6N8oeXGjYv
 k
X-Gm-Gg: ASbGncsBO84wJirhm3B75PGXw/85IK3/kMTQCnNxaQEPnN71ZmWklY0kd4kFgUdkz2v
 /eolE8G1lMG9xlvnFfrv988lv4vHDV+CJ6w8NSgjlNpMsay8hf5yM6B8qDRMkaIyQcFZnTUGqOZ
 PgrwwEB6v83gZHslJx8J5ZY7mYKCSTOKh/JhsU263EtnnPd/jYrSjkg7PaaQ03N9QlvXgDypRSR
 jiUpbgDLiqoeJKg8HzVTQ5JbTPEe739V7dcJ4fXiIZ/cSleJ3MpYdaTNQPU8d2qyZBgAKGJvOrW
 w40J5tS1/MrXTYkil7tP
X-Google-Smtp-Source: AGHT+IFHxaFfMUVj8U00dZrYinF0EsB3f7tZmsJpi9NBsdnvBoNhstKylBLaDpJQUeLMCnDO7PrI5g==
X-Received: by 2002:a05:6000:400f:b0:38c:5bfa:a961 with SMTP id
 ffacd0b85a97d-38dc8d9840fmr12852523f8f.4.1739291159225; 
 Tue, 11 Feb 2025 08:25:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.25.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:25:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/68] fpu: Add float_class_denormal
Date: Tue, 11 Feb 2025 16:24:48 +0000
Message-Id: <20250211162554.4135349-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Currently in softfloat we canonicalize input denormals and so the
code that implements floating point operations does not need to care
whether the input value was originally normal or denormal.  However,
both x86 and Arm FEAT_AFP require that an exception flag is set if:
 * an input is denormal
 * that input is not squashed to zero
 * that input is actually used in the calculation (e.g. we
   did not find the other input was a NaN)

So we need to track that the input was a non-squashed denormal.  To
do this we add a new value to the FloatClass enum.  In this commit we
add the value and adjust the code everywhere that looks at FloatClass
values so that the new float_class_denormal behaves identically to
float_class_normal.  We will add the code that does the "raise a new
float exception flag if an input was an unsquashed denormal and we
used it" in a subsequent commit.

There should be no behavioural change in this commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 32 ++++++++++++++++++++++++++++---
 fpu/softfloat-parts.c.inc | 40 ++++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 26f3a8dc87e..03a604c38ec 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -404,12 +404,16 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
 /*
  * Classify a floating point number. Everything above float_class_qnan
  * is a NaN so cls >= float_class_qnan is any NaN.
+ *
+ * Note that we canonicalize denormals, so most code should treat
+ * class_normal and class_denormal identically.
  */
 
 typedef enum __attribute__ ((__packed__)) {
     float_class_unclassified,
     float_class_zero,
     float_class_normal,
+    float_class_denormal, /* input was a non-squashed denormal */
     float_class_inf,
     float_class_qnan,  /* all NaNs from here */
     float_class_snan,
@@ -420,12 +424,14 @@ typedef enum __attribute__ ((__packed__)) {
 enum {
     float_cmask_zero    = float_cmask(float_class_zero),
     float_cmask_normal  = float_cmask(float_class_normal),
+    float_cmask_denormal = float_cmask(float_class_denormal),
     float_cmask_inf     = float_cmask(float_class_inf),
     float_cmask_qnan    = float_cmask(float_class_qnan),
     float_cmask_snan    = float_cmask(float_class_snan),
 
     float_cmask_infzero = float_cmask_zero | float_cmask_inf,
     float_cmask_anynan  = float_cmask_qnan | float_cmask_snan,
+    float_cmask_anynorm = float_cmask_normal | float_cmask_denormal,
 };
 
 /* Flags for parts_minmax. */
@@ -459,6 +465,20 @@ static inline __attribute__((unused)) bool is_qnan(FloatClass c)
     return c == float_class_qnan;
 }
 
+/*
+ * Return true if the float_cmask has only normals in it
+ * (including input denormals that were canonicalized)
+ */
+static inline bool cmask_is_only_normals(int cmask)
+{
+    return !(cmask & ~float_cmask_anynorm);
+}
+
+static inline bool is_anynorm(FloatClass c)
+{
+    return float_cmask(c) & float_cmask_anynorm;
+}
+
 /*
  * Structure holding all of the decomposed parts of a float.
  * The exponent is unbiased and the fraction is normalized.
@@ -1729,6 +1749,7 @@ static float64 float64r32_round_pack_canonical(FloatParts64 *p,
      */
     switch (p->cls) {
     case float_class_normal:
+    case float_class_denormal:
         if (unlikely(p->exp == 0)) {
             /*
              * The result is denormal for float32, but can be represented
@@ -1817,6 +1838,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
 
     switch (p->cls) {
     case float_class_normal:
+    case float_class_denormal:
         if (s->floatx80_rounding_precision == floatx80_precision_x) {
             parts_uncanon_normal(p, s, fmt);
             frac = p->frac_hi;
@@ -2697,6 +2719,7 @@ static void parts_float_to_ahp(FloatParts64 *a, float_status *s)
         break;
 
     case float_class_normal:
+    case float_class_denormal:
     case float_class_zero:
         break;
 
@@ -2729,7 +2752,7 @@ static void parts_float_to_float_narrow(FloatParts64 *a, FloatParts128 *b,
     a->sign = b->sign;
     a->exp = b->exp;
 
-    if (a->cls == float_class_normal) {
+    if (is_anynorm(a->cls)) {
         frac_truncjam(a, b);
     } else if (is_nan(a->cls)) {
         /* Discard the low bits of the NaN. */
@@ -3218,6 +3241,7 @@ static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
         return int128_zero();
 
     case float_class_normal:
+    case float_class_denormal:
         if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
             flags = float_flag_inexact;
         }
@@ -3645,6 +3669,7 @@ static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
         return int128_zero();
 
     case float_class_normal:
+    case float_class_denormal:
         if (parts_round_to_int_normal(&p, rmode, scale, 128 - 2)) {
             flags = float_flag_inexact;
             if (p.cls == float_class_zero) {
@@ -5231,6 +5256,8 @@ float32 float32_exp2(float32 a, float_status *status)
     float32_unpack_canonical(&xp, a, status);
     if (unlikely(xp.cls != float_class_normal)) {
         switch (xp.cls) {
+        case float_class_denormal:
+            break;
         case float_class_snan:
         case float_class_qnan:
             parts_return_nan(&xp, status);
@@ -5240,9 +5267,8 @@ float32 float32_exp2(float32 a, float_status *status)
         case float_class_zero:
             return float32_one;
         default:
-            break;
+            g_assert_not_reached();
         }
-        g_assert_not_reached();
     }
 
     float_raise(float_flag_inexact, status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 73621f4a970..8621cb87185 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -204,7 +204,7 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
             frac_clear(p);
         } else {
             int shift = frac_normalize(p);
-            p->cls = float_class_normal;
+            p->cls = float_class_denormal;
             p->exp = fmt->frac_shift - fmt->exp_bias
                    - shift + !fmt->m68k_denormal;
         }
@@ -395,7 +395,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
 static void partsN(uncanon)(FloatPartsN *p, float_status *s,
                             const FloatFmt *fmt)
 {
-    if (likely(p->cls == float_class_normal)) {
+    if (likely(is_anynorm(p->cls))) {
         parts_uncanon_normal(p, s, fmt);
     } else {
         switch (p->cls) {
@@ -435,7 +435,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
 
     if (a->sign != b_sign) {
         /* Subtraction */
-        if (likely(ab_mask == float_cmask_normal)) {
+        if (likely(cmask_is_only_normals(ab_mask))) {
             if (parts_sub_normal(a, b)) {
                 return a;
             }
@@ -468,7 +468,7 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
         }
     } else {
         /* Addition */
-        if (likely(ab_mask == float_cmask_normal)) {
+        if (likely(cmask_is_only_normals(ab_mask))) {
             parts_add_normal(a, b);
             return a;
         }
@@ -488,12 +488,12 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (b->cls == float_class_zero) {
-        g_assert(a->cls == float_class_normal);
+        g_assert(is_anynorm(a->cls));
         return a;
     }
 
     g_assert(a->cls == float_class_zero);
-    g_assert(b->cls == float_class_normal);
+    g_assert(is_anynorm(b->cls));
  return_b:
     b->sign = b_sign;
     return b;
@@ -513,7 +513,7 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
     bool sign = a->sign ^ b->sign;
 
-    if (likely(ab_mask == float_cmask_normal)) {
+    if (likely(cmask_is_only_normals(ab_mask))) {
         FloatPartsW tmp;
 
         frac_mulw(&tmp, a, b);
@@ -596,7 +596,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
         a->sign ^= 1;
     }
 
-    if (unlikely(ab_mask != float_cmask_normal)) {
+    if (unlikely(!cmask_is_only_normals(ab_mask))) {
         if (unlikely(ab_mask == float_cmask_infzero)) {
             float_raise(float_flag_invalid | float_flag_invalid_imz, s);
             goto d_nan;
@@ -611,7 +611,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
         }
 
         g_assert(ab_mask & float_cmask_zero);
-        if (c->cls == float_class_normal) {
+        if (is_anynorm(c->cls)) {
             *a = *c;
             goto return_normal;
         }
@@ -692,7 +692,7 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
     bool sign = a->sign ^ b->sign;
 
-    if (likely(ab_mask == float_cmask_normal)) {
+    if (likely(cmask_is_only_normals(ab_mask))) {
         a->sign = sign;
         a->exp -= b->exp + frac_div(a, b);
         return a;
@@ -750,7 +750,7 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
-    if (likely(ab_mask == float_cmask_normal)) {
+    if (likely(cmask_is_only_normals(ab_mask))) {
         frac_modrem(a, b, mod_quot);
         return a;
     }
@@ -800,6 +800,8 @@ static void partsN(sqrt)(FloatPartsN *a, float_status *status,
 
     if (unlikely(a->cls != float_class_normal)) {
         switch (a->cls) {
+        case float_class_denormal:
+            break;
         case float_class_snan:
         case float_class_qnan:
             parts_return_nan(a, status);
@@ -1130,6 +1132,7 @@ static void partsN(round_to_int)(FloatPartsN *a, FloatRoundMode rmode,
     case float_class_inf:
         break;
     case float_class_normal:
+    case float_class_denormal:
         if (parts_round_to_int_normal(a, rmode, scale, fmt->frac_size)) {
             float_raise(float_flag_inexact, s);
         }
@@ -1174,6 +1177,7 @@ static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
         return 0;
 
     case float_class_normal:
+    case float_class_denormal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
         if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
             flags = float_flag_inexact;
@@ -1241,6 +1245,7 @@ static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
         return 0;
 
     case float_class_normal:
+    case float_class_denormal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
         if (parts_round_to_int_normal(p, rmode, scale, N - 2)) {
             flags = float_flag_inexact;
@@ -1304,6 +1309,7 @@ static int64_t partsN(float_to_sint_modulo)(FloatPartsN *p,
         return 0;
 
     case float_class_normal:
+    case float_class_denormal:
         /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
         if (parts_round_to_int_normal(p, rmode, 0, N - 2)) {
             flags = float_flag_inexact;
@@ -1452,9 +1458,10 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
     a_exp = a->exp;
     b_exp = b->exp;
 
-    if (unlikely(ab_mask != float_cmask_normal)) {
+    if (unlikely(!cmask_is_only_normals(ab_mask))) {
         switch (a->cls) {
         case float_class_normal:
+        case float_class_denormal:
             break;
         case float_class_inf:
             a_exp = INT16_MAX;
@@ -1467,6 +1474,7 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
         }
         switch (b->cls) {
         case float_class_normal:
+        case float_class_denormal:
             break;
         case float_class_inf:
             b_exp = INT16_MAX;
@@ -1513,7 +1521,7 @@ static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
-    if (likely(ab_mask == float_cmask_normal)) {
+    if (likely(cmask_is_only_normals(ab_mask))) {
         FloatRelation cmp;
 
         if (a->sign != b->sign) {
@@ -1581,6 +1589,7 @@ static void partsN(scalbn)(FloatPartsN *a, int n, float_status *s)
     case float_class_inf:
         break;
     case float_class_normal:
+    case float_class_denormal:
         a->exp += MIN(MAX(n, -0x10000), 0x10000);
         break;
     default:
@@ -1599,6 +1608,8 @@ static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
 
     if (unlikely(a->cls != float_class_normal)) {
         switch (a->cls) {
+        case float_class_denormal:
+            break;
         case float_class_snan:
         case float_class_qnan:
             parts_return_nan(a, s);
@@ -1615,9 +1626,8 @@ static void partsN(log2)(FloatPartsN *a, float_status *s, const FloatFmt *fmt)
             }
             return;
         default:
-            break;
+            g_assert_not_reached();
         }
-        g_assert_not_reached();
     }
     if (unlikely(a->sign)) {
         goto d_nan;
-- 
2.34.1



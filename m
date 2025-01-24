Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99858C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYj-0004b1-FJ; Fri, 24 Jan 2025 11:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYQ-0003w2-P3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:12 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYN-0005VW-WA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:10 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so15088935e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736146; x=1738340946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ek2FKZlEFWiY6rarba+/bALZAZmBGmoLbiL6TynZjl8=;
 b=gwzSe0O4b3zSQTpCmISgn2EOrtpi+IRknAG4hxKVG7g4n3QiJM/wyStV3wSWDSt66G
 uq5HBu5GsTC0JGSJODxyR4UPBAGiSMgiLu4Nvg2iXjEGJ7IHT00+V3u/arS9VKeZzfly
 4LkL63Vc/y7vqIXpEnZV08lyWF5auBgkpmPcb/koX78goQo2F5onj6olaxgIK350UGF2
 ycIm8S3F6YpDM08VpUJfrcwNIup/x1TR3h9eXrw0+tWTB6HtkEu0kr9Sz9XDZgA1QmfM
 unMIywwfSj398Remknk5a3CMsMmsEPXijp2JJcM1HN+LzJgw6ypLHJ8VBYDBGD1sexzF
 o10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736146; x=1738340946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ek2FKZlEFWiY6rarba+/bALZAZmBGmoLbiL6TynZjl8=;
 b=ZbwwD/HaOR1A6ySe5zzVq19+qXMZfyQePkISksn1XMXh4GcJ0lCme3bYt2Cqmkyowd
 5l6drdBnHi4QHKlPHo2R4ro1O1SAGHufQh9S1BLuKhhiX4M+ev/RZLGRm2xaZF63scU2
 ePGtAr/veQMT+jazrKKzc7atsx2yitTq2KCBRUa3FL71CE0fxIBN69SHkOYNIAJELV30
 0AE34F/GaOLIE1/JpOJXYb1bfkyuwODUv3xq/aTNDfGzqVjkihL64ALqpb8Z/v8cYw+i
 nGIFZftCKUQWTYjQai7LKh6ghu0g905rwNKu5kAE+GNAaQBGGY3HnXl3pQec3Ieva92+
 x2dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx7BUmBcE1GQJRry1Z6dZo0ghxKLT7FLMFCUBaKgIX2OmEU8j/UXLftIs6dVsx3YrEPS9+GgxZHiig@nongnu.org
X-Gm-Message-State: AOJu0Yx+ugE6r/tcMS5LOlZ/Q8+4R8RQwQ8C+5864bhAwu09XeeB5qmZ
 fY998WirDjpaOdBk/PyO2b/QcctCmssbptfCiOaPpWmenKaU9FfEPdMb3WGEzIfqXNIZZvv+ZVC
 V
X-Gm-Gg: ASbGnctUuaUtVEvGBnw4PwbSztGM0Uyiosq+NyO/aAax1p6LloUHjrN6IeMWImAFrML
 cbmjOLPtD7iokvXwJXDmBxAvwQE0AXIx2qmqXY/TpVtYNAROEf+apJN7Etjk6fEpNg1EPJyPjVJ
 H3YCItJMT4AXTLDGouWnWP+XCVONny3lDgx03axCzVcHMT4mQAxl0UJRjyJMXN7V+oN4u9ZaHSb
 lFwvparCF337pvzru977DfgXnHqSlGXXiSt2bAP0z/ryHnehDAqoGEBOKMY9f46TCsnIIhfs8cc
 iUWZZSRjRMo=
X-Google-Smtp-Source: AGHT+IFZY2lqsmP8zidfqDfr1wHn0maRoNEb2a90gAFky4IkoPFSJk1hL6+V8ldx7ERuoGicOODZEw==
X-Received: by 2002:a05:600c:218b:b0:436:51bb:7a43 with SMTP id
 5b1f17b1804b1-438919191f6mr309720065e9.5.1737736146017; 
 Fri, 24 Jan 2025 08:29:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 22/76] fpu: Add float_class_denormal
Date: Fri, 24 Jan 2025 16:27:42 +0000
Message-Id: <20250124162836.2332150-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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



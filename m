Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC023FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEvu-0000HN-Ew; Wed, 29 Apr 2026 20:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvU-0008AR-DV
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:52 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvR-0001wG-Fy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:43 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c795eacbeb0so104427a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507599; x=1778112399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IYaIvETmYwmLvRx29bF5UAT5U0QKjITqX87Oyko4Qyo=;
 b=weF3mYOLO3hsNQEknqhdtswWEr+cMkbz8Ffbu0BBGdFmZwQRN89MjnS1dQQY97LxTi
 rJVR75iYhZlAIg8prsEhZdDu815GXB1NA+gBQyX+lLsZR48ojg+mQqD97kCr9nOQLT54
 239F7gPWCHOc8tPIpnU52JxxISnzGBbnVq5dAUF7c/9zWWd/7tDVW/6hBW2WJ4AaIaa8
 +ygSfb8Xxzix5QiAn05elmZ1ZuL7kIaeLhmgL9Jmd4bnIqqjox47S6r3bpB98GNZbI5j
 UPPHfsvbzE4OTE8I0iQjY7twlKdbDmr/HTjxn5bLB5xrKdXqD6YxBGLr8OpLKcvktIoG
 KPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507599; x=1778112399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IYaIvETmYwmLvRx29bF5UAT5U0QKjITqX87Oyko4Qyo=;
 b=hT4dnzJcPcuIUnk2ibP6KexwDXwFHcdCvFr7HuireBmOIvVnAdVAPhr5r4WW8xh/2R
 qyJtGPKPT4GCCobVQKQ892xcm3rMcZILaAKpFzV822gduusisqbksmvBTixVw8cZiXLa
 0T0m5IUIJl5FlIq5BYLuiM6YFoCqn1+JWsDH1L8X7ivFVRDZVRPsYm3EFDdbyduIKsxX
 ldC6a4BfLoYTD6bnGesKTT6OCs954HKZ3R++cSDndIe3i1NNOuCyUYqse0fOsrlBfT2+
 +Ib0Tew6M4P+81ULFRCjpepdE1xlSRCVKu7Gy4Un2iy5/N0GEfrJ/lCbGjIcdQgPQlqI
 TSxw==
X-Gm-Message-State: AOJu0Yzs6LggSgNOEoE0iUswar7DkIrTFcUBaO54feg7cxgdPh0FfNEM
 1GGd/q7BFPrnHWQTplMvpBM5fjrsOHAtADGshJDKJnMFrdGCqMT6LVQRJTL701Mx1Gy57LlYtKm
 vJ3k9p9E=
X-Gm-Gg: AeBDiesgFT5R+Wxw2dqzqAgBRA8bosycemwoCI4QulHMVIjrGc/dw803VGdW0K2h6nb
 zR2/sL2JuPF3Z7EBR89L22m3ElpRERHD+Dt11SVPgXTNy5Mm/0tLSm6oyHn3zqdy1QDrEasTo/c
 JN2MzEKWFNKEaPRwWu9B4jHJL1jM9rzUkGZA9dixlUsvEchQtAjoaLgzzgRORyw22S/TX84kRZm
 cG98U36EhVSaU3JEARaEIZPzQJ6fIllyle51JiHdUfZIWC+3tIDzqRhxqYqZ+WSBgreFQP1gxg9
 Y80RYNCwRVdwU+zlNgw9TcD2hu/UetyiL1a2PyNsOdDsOpu7xV17WyT+nqhpvw5SyQZVQ80E4c6
 ycIo3gFUnwKC0ECk4c0InMMSUCWFLpk5ahwdi8PpO3uwj7yxV0nnFeRSC14Z7OtJwaQxPbv8PJ7
 g0FMZ5BSfgwvVM5BpOCoL1Rh13RLFxDchqq0cQftgG
X-Received: by 2002:a05:6a00:2282:b0:82c:dc9c:e770 with SMTP id
 d2e1a72fcca58-834fdc57b67mr793882b3a.40.1777507598957; 
 Wed, 29 Apr 2026 17:06:38 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 31/40] fpu: Return struct from parts{64,128}_addsub
Date: Thu, 30 Apr 2026 10:05:14 +1000
Message-ID: <20260430000524.56046-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

At the same time, export.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  5 ++++
 fpu/softfloat.c               | 30 +++++++++++------------
 fpu/softfloat-parts.c.inc     | 45 ++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 68884e8047..a24678ea2b 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -182,6 +182,11 @@ FloatParts128 parts128_return_nan(const FloatParts128 *a, float_status *s);
  * Operations
  */
 
+FloatParts64 parts64_addsub(const FloatParts64 *a, const FloatParts64 *b,
+                            float_status *s, bool subtract);
+FloatParts128 parts128_addsub(const FloatParts128 *a, const FloatParts128 *b,
+                              float_status *s, bool subtract);
+
 FloatRelation parts64_compare(const FloatParts64 *a, const FloatParts64 *b,
                               float_status *s, bool quiet);
 FloatRelation parts128_compare(const FloatParts128 *a, const FloatParts128 *b,
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 34ef590856..cd03ace323 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1582,9 +1582,9 @@ float16_addsub(float16 a, float16 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float16_round_pack_canonical(pr, status);
+    return float16_round_pack_canonical(&pr, status);
 }
 
 float16 float16_add(float16 a, float16 b, float_status *status)
@@ -1602,9 +1602,9 @@ soft_f32_addsub(float32 a, float32 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float32_round_pack_canonical(pr, status);
+    return float32_round_pack_canonical(&pr, status);
 }
 
 static float32 soft_f32_add(float32 a, float32 b, float_status *status)
@@ -1622,9 +1622,9 @@ soft_f64_addsub(float64 a, float64 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float64_round_pack_canonical(pr, status);
+    return float64_round_pack_canonical(&pr, status);
 }
 
 static float64 soft_f64_add(float64 a, float64 b, float_status *status)
@@ -1717,9 +1717,9 @@ static float64 float64r32_addsub(float64 a, float64 b, float_status *status,
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return float64r32_round_pack_canonical(pr, status);
+    return float64r32_round_pack_canonical(&pr, status);
 }
 
 float64 float64r32_add(float64 a, float64 b, float_status *status)
@@ -1737,9 +1737,9 @@ bfloat16_addsub(bfloat16 a, bfloat16 b, float_status *status, bool subtract)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pr = parts64_addsub(&pa, &pb, status, subtract);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    return bfloat16_round_pack_canonical(&pr, status);
 }
 
 bfloat16 bfloat16_add(bfloat16 a, bfloat16 b, float_status *status)
@@ -1757,9 +1757,9 @@ float128_addsub(float128 a, float128 b, float_status *status, bool subtract)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-    FloatParts128 *pr = parts128_addsub(&pa, &pb, status, subtract);
+    FloatParts128 pr = parts128_addsub(&pa, &pb, status, subtract);
 
-    return float128_round_pack_canonical(pr, status);
+    return float128_round_pack_canonical(&pr, status);
 }
 
 float128 float128_add(float128 a, float128 b, float_status *status)
@@ -1775,15 +1775,15 @@ float128 float128_sub(float128 a, float128 b, float_status *status)
 static floatx80 QEMU_FLATTEN
 floatx80_addsub(floatx80 a, floatx80 b, float_status *status, bool subtract)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_addsub(&pa, &pb, status, subtract);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_addsub(&pa, &pb, status, subtract);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 floatx80 floatx80_add(floatx80 a, floatx80 b, float_status *status)
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 0a0f3a4f0b..6aba0e6b18 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -524,15 +524,14 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
  * according to the IEC/IEEE Standard for Binary Floating-Point
  * Arithmetic.
  */
-static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
-                                   float_status *s, bool subtract)
+FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
+                           const FloatPartsN *b_orig,
+                           float_status *s, bool subtract)
 {
-    bool b_sign = b->sign ^ subtract;
-    int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
+    int ab_mask = float_cmask(a_orig->cls) | float_cmask(b_orig->cls);
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan)(a, b, s);
-        return a;
+        return partsN(pick_nan)(a_orig, b_orig, s);
     }
 
     /*
@@ -541,10 +540,15 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
      */
     record_denormals_used(ab_mask, s);
 
-    if (a->sign != b_sign) {
+    FloatPartsN a = *a_orig;
+    FloatPartsN b = *b_orig;
+
+    b.sign ^= subtract;
+
+    if (a.sign != b.sign) {
         /* Subtraction */
         if (likely(cmask_is_only_normals(ab_mask))) {
-            if (partsN(sub_normal)(a, b)) {
+            if (partsN(sub_normal)(&a, &b)) {
                 return a;
             }
             /* Subtract was exact, fall through to set sign. */
@@ -552,28 +556,27 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
         }
 
         if (ab_mask == float_cmask_zero) {
-            a->sign = s->float_rounding_mode == float_round_down;
+            a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
 
         if (ab_mask & float_cmask_inf) {
-            if (a->cls != float_class_inf) {
+            if (a.cls != float_class_inf) {
                 /* N - Inf */
-                goto return_b;
+                return b;
             }
-            if (b->cls != float_class_inf) {
+            if (b.cls != float_class_inf) {
                 /* Inf - N */
                 return a;
             }
             /* Inf - Inf */
             float_raise(float_flag_invalid | float_flag_invalid_isi, s);
-            *a = partsN(default_nan)(s);
-            return a;
+            return partsN(default_nan)(s);
         }
     } else {
         /* Addition */
         if (likely(cmask_is_only_normals(ab_mask))) {
-            partsN(add_normal)(a, b);
+            partsN(add_normal)(&a, &b);
             return a;
         }
 
@@ -582,20 +585,18 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
         }
 
         if (ab_mask & float_cmask_inf) {
-            a->cls = float_class_inf;
+            a.cls = float_class_inf;
             return a;
         }
     }
 
-    if (b->cls == float_class_zero) {
-        g_assert(is_anynorm(a->cls));
+    if (b.cls == float_class_zero) {
+        g_assert(is_anynorm(a.cls));
         return a;
     }
 
-    g_assert(a->cls == float_class_zero);
-    g_assert(is_anynorm(b->cls));
- return_b:
-    b->sign = b_sign;
+    g_assert(a.cls == float_class_zero);
+    g_assert(is_anynorm(b.cls));
     return b;
 }
 
-- 
2.43.0



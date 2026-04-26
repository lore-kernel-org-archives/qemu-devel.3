Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EF2FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpi-0000Xl-DN; Sun, 26 Apr 2026 09:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzof-0006IO-SY
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzod-0001lZ-FI
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:33 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b7d3ecc10dso14946895ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211190; x=1777815990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qi2pCl7ZHfYdZTkVL3nvBP0b2n/j7SskgSjhFZXGku4=;
 b=isfU3Vvvxl7MCb5Qt8akEoxdnD9eJPkR2O/EgQvvWMvp0jWiTM2cqZqIyicfLQnMd+
 ZzrijjIWkxElsiesRHrJSh/P5H8iq/Ct1zVqS8TBInE+nb0cnFa2KWAVIEmoaZz2Ol0A
 lWQegu+KZLqn3P5kjQD6OmORcqe36trJO+dSUAec80AYMb6MSP0clrsg7TquITophji8
 6fWkHQCnnbyBM/7RuCRFjgbekijK44G3nMdDsP8fBz9KXG4kRSk5d/2L2l8A+ySBNn84
 TbQMljrbzpDtfWc8a92forcK6aQDuR4DIYizxqmFw/5HTxlnZ6V7LcxC4gWPpeFyFpj/
 Wvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211190; x=1777815990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qi2pCl7ZHfYdZTkVL3nvBP0b2n/j7SskgSjhFZXGku4=;
 b=YDvzidsDQapwEvwq9xZBe9vF7BB/pQsse1UExm/S93lmbb/OvTwLkNmERGRxCp/lJW
 um+X+Tfx2/QbCxq8SQgRwLz66vMBtactcE21qaOFTJBnMUf19PbbTXlBjIkshzgi1Lnm
 2YJn60LAImOdvUmTbotqVaWosmCSQTdfuFpB8JmaMRTKu2JsZOWAXtUoIgZX9i8/H6eJ
 sSJWQEYjzZ229+5vnPEbKvgGfMgDyb1lGijtlcl/j6P+MmbQuvB/WBvGoIymnIYjyBRc
 MtnBn4/6aPhxn6rdd0KaLVIPDh8w/LFkjuPwjMAjB77qWQQo5j8dM3JupeVNIe9FeB3z
 6+iA==
X-Gm-Message-State: AOJu0YyGj2oS1AhobbJbb4EwGO1QHZ1TeyRtuw4guK6Er9YMC8LFsVVn
 Mlb48lRq3z1owyg5hCzijUMi/xacBIK5/3e3ZCv2hX7hZDwgScWxlDCkjRJ5jLhZ+EndYxM80jJ
 Ie68n5PI=
X-Gm-Gg: AeBDievVaW9KKHnhXD9WaNkI1LMkIO1adak+ATmLGysndHaQYhlNczF6phFWdYxrtBW
 pw4/du6LdawcCQxfVtlvNZXp5hUHp6G62++MrFNbUF/NuncbUM0FyOro+xuQ3SlKaVSqu2Jg4Q9
 bY1oqSGkR5viPJMgaRtxCNv2r1TsqnBKtGXgM6Aquxq3EpGEFt8EpID5iFKHDlvqYZOMXxbqbnA
 x6aiDz3d0SLDiIdNJL9pmIta6e9h/udePjiWk/84i2kcLOoA8wAzdeOFq0fAb0acZVkmDTBGI4t
 wAb50zGxPfFE4QQzOtBPb6W8aD6oVtN6FL+zxs4JLQUfVlMQk8q6Dro5tAMY1QShtXE+Pm2mva5
 rxD+19M6sKVQGKBWuJl3ZVXERVI2ar8KPQ9ny0FxIo80u6wy1zVjSd/xFmPiKd7YJ6UviwFEBed
 fisFnjzC4pDribiu6pHxBwZpbFuIysgOjxynPqWEwy
X-Received: by 2002:a17:902:ebc5:b0:2b0:62dd:3a80 with SMTP id
 d9443c01a7336-2b5f9ee30aamr381425155ad.17.1777211189920; 
 Sun, 26 Apr 2026 06:46:29 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 74/84] fpu: Return struct from parts{64,128}_muladd_scalbn
Date: Sun, 26 Apr 2026 23:39:51 +1000
Message-ID: <20260426134002.865628-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 include/fpu/softfloat-parts.h |   9 +++
 fpu/softfloat.c               |  81 ++++++++++---------
 fpu/softfloat-parts.c.inc     | 148 +++++++++++++++++-----------------
 3 files changed, 122 insertions(+), 116 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 5b71809541..6416495eac 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -184,6 +184,15 @@ FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
 FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
                            float_status *s);
 
+FloatParts64 parts64_muladd_scalbn(const FloatParts64 *a,
+                                   const FloatParts64 *b,
+                                   const FloatParts64 *c,
+                                   int scale, int flags, float_status *s);
+FloatParts128 parts128_muladd_scalbn(const FloatParts128 *a,
+                                     const FloatParts128 *b,
+                                     const FloatParts128 *c,
+                                     int scale, int flags, float_status *s);
+
 void parts64_round_canonical(FloatParts64 *p, float_status *s,
                              const FloatFmt *fmt);
 
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1423695a5a..959a82636b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1904,15 +1904,15 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
     FloatParts64 pc = float16_unpack_canonical(c, status);
-    FloatParts64 *pr =
-        parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 pr = parts64_muladd_scalbn(&pa, &pb, &pc,
+                                            scale, flags, status);
 
     /* Round before applying negate result. */
-    parts64_uncanon(pr, status, &float16_params, false);
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    parts64_uncanon(&pr, status, &float16_params, false);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &float16_params);
+    return pack_raw64(&pr, &float16_params);
 }
 
 float16 float16_muladd(float16 a, float16 b, float16 c,
@@ -1928,14 +1928,15 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
     FloatParts64 pc = float32_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 pr = parts64_muladd_scalbn(&pa, &pb, &pc,
+                                            scale, flags, status);
 
     /* Round before applying negate result. */
-    parts64_uncanon(pr, status, &float32_params, false);
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    parts64_uncanon(&pr, status, &float32_params, false);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &float32_params);
+    return pack_raw64(&pr, &float32_params);
 }
 
 float64 QEMU_SOFTFLOAT_ATTR
@@ -1945,14 +1946,15 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
     FloatParts64 pc = float64_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 pr = parts64_muladd_scalbn(&pa, &pb, &pc,
+                                            scale, flags, status);
 
     /* Round before applying negate result. */
-    parts64_uncanon(pr, status, &float64_params, false);
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    parts64_uncanon(&pr, status, &float64_params, false);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &float64_params);
+    return pack_raw64(&pr, &float64_params);
 }
 
 static bool force_soft_fma;
@@ -2102,14 +2104,14 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
     FloatParts64 pc = float64_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts64 pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
-    parts64_uncanon(pr, status, &float32_params, false);
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    parts64_uncanon(&pr, status, &float32_params, false);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return float64r32_pack_raw(pr);
+    return float64r32_pack_raw(&pr);
 }
 
 bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
@@ -2118,14 +2120,14 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
     FloatParts64 pc = bfloat16_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts64 pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
-    parts64_uncanon(pr, status, &bfloat16_params, false);
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    parts64_uncanon(&pr, status, &bfloat16_params, false);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &bfloat16_params);
+    return pack_raw64(&pr, &bfloat16_params);
 }
 
 float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
@@ -2134,14 +2136,14 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
     FloatParts128 pc = float128_unpack_canonical(c, status);
-    FloatParts128 *pr = parts128_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts128 pr = parts128_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
-    parts128_uncanon(pr, status, &float128_params, false);
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    parts128_uncanon(&pr, status, &float128_params, false);
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return float128_pack_raw(pr);
+    return float128_pack_raw(&pr);
 }
 
 /*
@@ -5113,7 +5115,7 @@ float32 float32_exp2(float32 a, float_status *status)
     rp = float64_unpack_canonical(float64_one, status);
     for (int i = 0; i < 15; i++) {
         tp = float64_unpack_canonical(float32_exp2_coefficients[i], status);
-        rp = *parts64_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
+        rp = parts64_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
         xnp = *parts64_mul(&xnp, &xp, status);
     }
 
@@ -5162,7 +5164,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         n->sign = a->sign ^ b->sign;
         *cc = 0;
     } else {
-        FloatParts64 *q, q_buf, *r_precise, r_precise_buf;
+        FloatParts64 *q, q_buf, r_precise;
         int float_exception_flags = 0;
         bool is_q_smallish;
         uint32_t r_flags;
@@ -5191,12 +5193,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
                                   0, status, fmt);
 
         /* Compute precise remainder */
-        r_precise_buf = *b;
-        r_precise = parts64_muladd_scalbn(&r_precise_buf, n, a, 0,
+        r_precise = parts64_muladd_scalbn(b, n, a, 0,
                                           float_muladd_negate_product, status);
 
         /* Round remainder to the target format */
-        *r = *r_precise;
+        *r = r_precise;
         status->float_exception_flags = 0;
         parts64_round_canonical(r, status, fmt);
         r_flags = status->float_exception_flags;
@@ -5220,17 +5221,17 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
                          * toward zero) or incremented.
                          */
                         saved_r_sign = r->sign;
-                        saved_r_precise_sign = r_precise->sign;
+                        saved_r_precise_sign = r_precise.sign;
                         r->sign = false;
-                        r_precise->sign = false;
-                        if (parts64_compare(r, r_precise, status, true) <
+                        r_precise.sign = false;
+                        if (parts64_compare(r, &r_precise, status, true) <
                             float_relation_equal) {
                             *dxc = 0x8;
                         } else {
                             *dxc = 0xc;
                         }
                         r->sign = saved_r_sign;
-                        r_precise->sign = saved_r_precise_sign;
+                        r_precise.sign = saved_r_precise_sign;
                     }
                 }
             }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 82d59df406..ab773ed241 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -677,15 +677,15 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
  * Requires A and C extracted into a double-sized structure to provide the
  * extra space for the widening multiply.
  */
-static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
-                                          FloatPartsN *c, int scale,
-                                          int flags, float_status *s)
+FloatPartsN partsN(muladd_scalbn)(const FloatPartsN *a,
+                                  const FloatPartsN *b,
+                                  const FloatPartsN *c,
+                                  int scale, int flags, float_status *s)
 {
-    int ab_mask, abc_mask;
-    FloatPartsW p_widen, c_widen;
-
-    ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
-    abc_mask = float_cmask(c->cls) | ab_mask;
+    int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
+    int abc_mask = float_cmask(c->cls) | ab_mask;
+    bool c_sign = c->sign ^ !!(flags & float_muladd_negate_c);
+    bool p_sign = a->sign ^ b->sign ^ !!(flags & float_muladd_negate_product);
 
     /*
      * It is implementation-defined whether the cases of (0,inf,qnan)
@@ -694,18 +694,7 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
-        return a;
-    }
-
-    if (flags & float_muladd_negate_c) {
-        c->sign ^= 1;
-    }
-
-    /* Compute the sign of the product into A. */
-    a->sign ^= b->sign;
-    if (flags & float_muladd_negate_product) {
-        a->sign ^= 1;
+        return partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
     }
 
     if (unlikely(!cmask_is_only_normals(ab_mask))) {
@@ -715,86 +704,93 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
         }
 
         if (ab_mask & float_cmask_inf) {
-            if (c->cls == float_class_inf && a->sign != c->sign) {
+            if (c->cls == float_class_inf && p_sign != c_sign) {
                 float_raise(float_flag_invalid | float_flag_invalid_isi, s);
                 goto d_nan;
             }
-            goto return_inf;
+            record_denormals_used(abc_mask, s);
+            return (FloatPartsN){ .sign = p_sign, .cls = float_class_inf };
         }
 
-        g_assert(ab_mask & float_cmask_zero);
-        if (is_anynorm(c->cls)) {
-            *a = *c;
-            goto return_normal;
-        }
-        if (c->cls == float_class_zero) {
+        record_denormals_used(abc_mask, s);
+
+        assert(ab_mask & float_cmask_zero);
+        switch (c->cls) {
+        case float_class_normal:
+        case float_class_denormal:
+            {
+                FloatPartsN r = *c;
+                r.exp += scale;
+                return r;
+            }
+
+        case float_class_zero:
             if (flags & float_muladd_suppress_add_product_zero) {
-                a->sign = c->sign;
-            } else if (a->sign != c->sign) {
+                /* return zero with new sign */
+            } else if (p_sign != c_sign) {
                 goto return_sub_zero;
             }
-            goto return_zero;
+            goto return_zero_c;
+
+        case float_class_inf:
+            goto return_inf_c;
+
+        default:
+            g_assert_not_reached();
         }
-        g_assert(c->cls == float_class_inf);
     }
 
+    record_denormals_used(abc_mask, s);
+
     if (unlikely(c->cls == float_class_inf)) {
-        a->sign = c->sign;
-        goto return_inf;
+        goto return_inf_c;
     }
 
     /* Perform the multiplication step. */
-    p_widen.sign = a->sign;
-    p_widen.exp = a->exp + b->exp + 1;
-    fracN(mulw)(&p_widen, a, b);
-    if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
-        fracW(add)(&p_widen, &p_widen, &p_widen);
-        p_widen.exp -= 1;
-    }
+    {
+        FloatPartsW p_widen = { .sign = p_sign, .exp = a->exp + b->exp + 1 };
 
-    /* Perform the addition step. */
-    if (c->cls != float_class_zero) {
-        /* Zero-extend C to less significant bits. */
-        fracN(widen)(&c_widen, c);
-        c_widen.exp = c->exp;
+        fracN(mulw)(&p_widen, a, b);
+        if (!(p_widen.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
+            fracW(add)(&p_widen, &p_widen, &p_widen);
+            p_widen.exp -= 1;
+        }
 
-        if (a->sign == c->sign) {
-            partsW(add_normal)(&p_widen, &c_widen);
-        } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
-            goto return_sub_zero;
+        /* Perform the addition step. */
+        if (c->cls != float_class_zero) {
+            /* Zero-extend C to less significant bits. */
+            FloatPartsW c_widen = { .sign = c_sign, .exp = c->exp };
+            fracN(widen)(&c_widen, c);
+
+            if (p_widen.sign == c_sign) {
+                partsW(add_normal)(&p_widen, &c_widen);
+            } else if (!partsW(sub_normal)(&p_widen, &c_widen)) {
+                goto return_sub_zero;
+            }
+        }
+
+        /* Narrow with sticky bit, for proper rounding later. */
+        {
+            FloatPartsN r = {
+                .sign = p_widen.sign,
+                .exp = p_widen.exp + scale,
+                .cls = float_class_normal,
+            };
+            fracN(truncjam)(&r, &p_widen);
+            return r;
         }
     }
 
-    /* Narrow with sticky bit, for proper rounding later. */
-    fracN(truncjam)(a, &p_widen);
-    a->sign = p_widen.sign;
-    a->exp = p_widen.exp;
-
- return_normal:
-    a->exp += scale;
- finish_sign:
-    /*
-     * All result types except for "return the default NaN
-     * because this is an Invalid Operation" go through here;
-     * this matches the set of cases where we consumed a
-     * denormal input.
-     */
-    record_denormals_used(abc_mask, s);
-    return a;
+ return_inf_c:
+    return (FloatPartsN){ .sign = c_sign, .cls = float_class_inf };
 
  return_sub_zero:
-    a->sign = s->float_rounding_mode == float_round_down;
- return_zero:
-    a->cls = float_class_zero;
-    goto finish_sign;
-
- return_inf:
-    a->cls = float_class_inf;
-    goto finish_sign;
+    c_sign = s->float_rounding_mode == float_round_down;
+ return_zero_c:
+    return (FloatPartsN){ .sign = c_sign, .cls = float_class_zero };
 
  d_nan:
-    *a = partsN(default_nan)(s);
-    return a;
+    return partsN(default_nan)(s);
 }
 
 /*
-- 
2.43.0



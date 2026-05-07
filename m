Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5B1CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1JK-0002Q9-B8; Thu, 07 May 2026 12:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Id-0001gG-T1
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:11 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ib-00080K-Ib
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:07 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d55b97f358so735420a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778170203; x=1778775003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sb1CVOnR1v+AoYSx743vCYn6DnCjsVU4fwzve1BycZA=;
 b=IHPW0k8dfWmxfzxA09h0WcwoGYhuStrAwolxkT9agkzk3lZw1QBZ1QOtuXpm2mlKsV
 i+coGMoXP6Y42gqcura03JqbpepLilW+ZyESuUp4j6uQOtPrxj1xpHcH589rHNLfrnh3
 4X+1Fpnmbuq/D4AlHTOrWY1sseRtyjHY1BNYbWX28t2HDrlHcStYQ4nQ5m02q+w5muhL
 MHdRTMAmxol/9XTaaWFHQdhwfIX7/TcwTqZUhdBAKhms9uiT7ynrGsAPCfy81eCf0tEA
 Y5vsWsSwIIS/TGQz3dLEKptvDCdYxFeRIr2GYYwt6tsaDt+fveFavvEy/Q6wlYp7ntMN
 yq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170203; x=1778775003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sb1CVOnR1v+AoYSx743vCYn6DnCjsVU4fwzve1BycZA=;
 b=WG2zVmUkIZ3CJvUYcDhlhL5G5XQ5n9PIGBHxXt88eTytol0D4E1+ypbE762vNwkMj8
 dOgIsq1ZwiVNCVZowmFej7qoQe+pcWPxCwoGZyo8RoBjfmfI+6wM0qGEU/wlMzhng5k3
 FFGVWvjh5oEpmJix8ek60g6cxOjXS+HiefIoZKvYhKTWoXfMOLf6erfjO93PrS3JezZi
 a1wViDGnj6M/2V3vHptnMu14Rp9g9QXQH70JeA+D90yw/qmTK2yv9mTKETIjYCZkSbRx
 js3t5Fk5do5EFMWQiM8/wwUON27TI8KZ99Ef+s+kOGeG3cPDZaiYAmDmHRiMxJBK9KJk
 iKsw==
X-Gm-Message-State: AOJu0Yy7TuuQPH15KHA4peHUcqV8RRjV6iRQl3AZXDfSwSvKQYYCnpOH
 YOIno0liS3eEkiR9yG6Yfgcoa/eEMGiJJ7V02Unczr4LlsVyTTvlQpfYPiqWCzvPWxH6PEZ3Yxw
 ZYVqH
X-Gm-Gg: AeBDietSVYfwqvk6bHpdctn/lgDLcjnn6ei2n4+EeGuQa6QVbG5v0cbt/HzBBp1jdwN
 omzqqLFJcuQluDXb9NrYo9vlhDEiokdAlqe4Hq1G5DNMrO/15h+RsTTCnjcH5WP6XFBhpKlchOW
 DKMlyRzkinD/0vzITZQoEfnHP0/ixgNTuY/kcL7ckGJS/6jmMltbb5CA4U6gUaUrwu1xWHgOrdO
 YUKKkdodKP70OHTkFNGWwNipOSihd3osA+OEMvBOZL7QHftlTfSEVXARSEhNq4dCHCNWDR9EjX5
 nOBQMMp58KDxuWGThC2nj/9RiwriE0mjDvfhKvgvJJH3DF3usl3jP01jloPlGDnnuA8UwQDshCg
 9iIvtMYBEgMY9QnF8jVF7JFVWh/briqAlLxZtUGVWNK9bwom1v0L1BinlfFxWdtRAt63PGfsOu5
 BDMfcvUq+m3rjh5mUsr+6jiJcddPHaV+fRQRiCmiIs4d9Wsg==
X-Received: by 2002:a05:6830:608c:b0:7df:5fc:3fd8 with SMTP id
 46e09a7af769-7e1dee91018mr5216693a34.1.1778170203100; 
 Thu, 07 May 2026 09:10:03 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e302462fb1sm16415a34.11.2026.05.07.09.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:10:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/11] fpu: Return struct from parts{64,128}_muladd
Date: Thu,  7 May 2026 11:09:50 -0500
Message-ID: <20260507160959.449170-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160959.449170-1-richard.henderson@linaro.org>
References: <20260507160959.449170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  9 ++++
 fpu/softfloat.c               | 83 +++++++++++++++++------------------
 fpu/softfloat-parts.c.inc     | 38 ++++++++--------
 3 files changed, 69 insertions(+), 61 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 46618d217e..7170cc7b6a 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -202,6 +202,15 @@ FloatParts64 parts64_mul(const FloatParts64 *a, const FloatParts64 *b,
 FloatParts128 parts128_mul(const FloatParts128 *a, const FloatParts128 *b,
                            float_status *s);
 
+FloatParts64 parts64_muladd(const FloatParts64 *a,
+                            const FloatParts64 *b,
+                            const FloatParts64 *c,
+                            int flags, float_status *s);
+FloatParts128 parts128_muladd(const FloatParts128 *a,
+                              const FloatParts128 *b,
+                              const FloatParts128 *c,
+                              int flags, float_status *s);
+
 FloatParts64 parts64_round_to_int(const FloatParts64 *a,
                                   FloatRoundMode rmode,
                                   int scale, float_status *s,
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 90ebd83f69..72ddb19fa0 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1906,18 +1906,18 @@ float16 float16_muladd_scalbn(float16 a, float16 b, float16 c,
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
     FloatParts64 pc = float16_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Before rounding, scale. */
     if (scale) {
-        parts64_scalbn(pr, scale, status);
+        parts64_scalbn(&pr, scale, status);
     }
-    parts64_uncanon(pr, status, &float16_params, false);
+    parts64_uncanon(&pr, status, &float16_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &float16_params);
+    return pack_raw64(&pr, &float16_params);
 }
 
 float16 float16_muladd(float16 a, float16 b, float16 c,
@@ -1933,18 +1933,18 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
     FloatParts64 pc = float32_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Before rounding, scale. */
     if (scale) {
-        parts64_scalbn(pr, scale, status);
+        parts64_scalbn(&pr, scale, status);
     }
-    parts64_uncanon(pr, status, &float32_params, false);
+    parts64_uncanon(&pr, status, &float32_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &float32_params);
+    return pack_raw64(&pr, &float32_params);
 }
 
 float64 QEMU_SOFTFLOAT_ATTR
@@ -1954,18 +1954,18 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
     FloatParts64 pc = float64_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
     /* Before rounding, scale. */
     if (scale) {
-        parts64_scalbn(pr, scale, status);
+        parts64_scalbn(&pr, scale, status);
     }
-    parts64_uncanon(pr, status, &float64_params, false);
+    parts64_uncanon(&pr, status, &float64_params, false);
     /* After rounding, apply negate result, especially for -0.0. */
-    if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
-        pr->sign ^= 1;
+    if ((flags & float_muladd_negate_result) && !is_nan(pr.cls)) {
+        pr.sign ^= 1;
     }
-    return pack_raw64(pr, &float64_params);
+    return pack_raw64(&pr, &float64_params);
 }
 
 static bool force_soft_fma;
@@ -2115,14 +2115,14 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
     FloatParts64 pc = float64_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
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
 
 bfloat16 bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
@@ -2131,14 +2131,14 @@ bfloat16 bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
     FloatParts64 pc = bfloat16_unpack_canonical(c, status);
-    FloatParts64 *pr = parts64_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts64 pr = parts64_muladd(&pa, &pb, &pc, flags, status);
 
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
 
 float128 float128_muladd(float128 a, float128 b, float128 c,
@@ -2147,14 +2147,14 @@ float128 float128_muladd(float128 a, float128 b, float128 c,
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
     FloatParts128 pc = float128_unpack_canonical(c, status);
-    FloatParts128 *pr = parts128_muladd(&pa, &pb, &pc, flags, status);
+    FloatParts128 pr = parts128_muladd(&pa, &pb, &pc, flags, status);
 
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
@@ -5126,7 +5126,7 @@ float32 float32_exp2(float32 a, float_status *status)
     rp = float64_unpack_canonical(float64_one, status);
     for (int i = 0; i < 15; i++) {
         tp = float64_unpack_canonical(float32_exp2_coefficients[i], status);
-        rp = *parts64_muladd(&tp, &xnp, &rp, 0, status);
+        rp = parts64_muladd(&tp, &xnp, &rp, 0, status);
         xnp = parts64_mul(&xnp, &xp, status);
     }
 
@@ -5175,7 +5175,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         n->sign = a->sign ^ b->sign;
         *cc = 0;
     } else {
-        FloatParts64 *q, q_buf, *r_precise, r_precise_buf;
+        FloatParts64 *q, q_buf, r_precise;
         int float_exception_flags = 0;
         bool is_q_smallish;
         uint32_t r_flags;
@@ -5205,12 +5205,11 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
                                     0, fmt->frac_size);
 
         /* Compute precise remainder */
-        r_precise_buf = *b;
-        r_precise = parts64_muladd(&r_precise_buf, n, a,
+        r_precise = parts64_muladd(b, n, a,
                                    float_muladd_negate_product, status);
 
         /* Round remainder to the target format */
-        *r = *r_precise;
+        *r = r_precise;
         status->float_exception_flags = 0;
         *r = parts64_round_to_fmt(r, status, fmt);
         r_flags = status->float_exception_flags;
@@ -5234,17 +5233,17 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
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
index 3d2606c07c..87525fb4b6 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -677,9 +677,8 @@ FloatPartsN partsN(mul)(const FloatPartsN *a, const FloatPartsN *b,
  * Requires A and C extracted into a double-sized structure to provide the
  * extra space for the widening multiply.
  */
-static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
-                                   FloatPartsN *c,
-                                   int flags, float_status *s)
+FloatPartsN partsN(muladd)(const FloatPartsN *a, const FloatPartsN *b,
+                           const FloatPartsN *c, int flags, float_status *s)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
     int c_mask = float_cmask(c->cls);
@@ -717,10 +716,13 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
         }
 
         /* Narrow with sticky bit, for proper rounding later. */
-        fracN(truncjam)(a, &p_widen);
-        a->sign = p_widen.sign;
-        a->exp = p_widen.exp;
-        return a;
+        FloatPartsN r = {
+            .sign = p_widen.sign,
+            .exp = p_widen.exp,
+            .cls = float_class_normal,
+        };
+        fracN(truncjam)(&r, &p_widen);
+        return r;
     }
 
     /*
@@ -730,8 +732,7 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
-        return a;
+        return partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
     }
 
     if (unlikely(ab_mask == float_cmask_infzero)) {
@@ -748,9 +749,7 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
         }
         /* Inf + C == Inf */
         record_denormals_used(abc_mask, s);
-        a->sign = p_sign;
-        a->cls = float_class_inf;
-        return a;
+        return (FloatPartsN){ .sign = p_sign, .cls = float_class_inf };
     }
     record_denormals_used(abc_mask, s);
 
@@ -765,19 +764,20 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
     if (!(c_mask & float_cmask_zero)
         || p_sign == c_sign
         || (flags & float_muladd_suppress_add_product_zero)) {
-        c->sign = c_sign;
-        return c;
+        FloatPartsN r = *c;
+        r.sign = c_sign;
+        return r;
     }
 
  return_sub_zero:
     /* 0 - 0 == -0 for round_down, +0 otherwise. */
-    a->sign = s->float_rounding_mode == float_round_down;
-    a->cls = float_class_zero;
-    return a;
+    return (FloatPartsN){
+        .sign = s->float_rounding_mode == float_round_down,
+        .cls = float_class_zero
+    };
 
  d_nan:
-    *a = partsN(default_nan)(s);
-    return a;
+    return partsN(default_nan)(s);
 }
 
 /*
-- 
2.43.0



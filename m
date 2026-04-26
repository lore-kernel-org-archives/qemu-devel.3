Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A52CFF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpe-0000M4-Vw; Sun, 26 Apr 2026 09:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoS-000643-Cf
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:21 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoF-0001Zg-M2
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso60077045ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211166; x=1777815966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beW50+D1g4WbAR+Nda9ug1MBM7TyhcdB89Yl6qrMgjA=;
 b=vtkqN7gUuYiVdig1WmW64JLUtJReLXHKSunTdcRyTGgZAKkq14Z6B+IetIx5QsSk++
 tat4f1Mhav6HT0P/EAHWeXQQ5Gye6MShLtNNDY2kJXJ5e5A7me1hbKbrgEuk7oZjjhV+
 RLc29JUQGXYgsGApAUtkcQo28Ogytk+yA7B+F557YLrnwB8AQ0TmMeCKaA4yNy36QMtT
 x4yzk9/G3gnVhuSL9R96aGYCzFU9G6Y8jfhX9huYw2yOoQqurKzBRXgwkfN/Z4n1lGNJ
 qj0+JxTbxJXcDtX814QS6uhnxHtfcLxKrjuEnlO6zwDXsCc95rwXpiCNXiZbyzWkqjk8
 VRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211166; x=1777815966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=beW50+D1g4WbAR+Nda9ug1MBM7TyhcdB89Yl6qrMgjA=;
 b=LmAF1Fgyma7+HsUeZibfg475yZIhZWoSozKlnfunnFG2cxmAysIem28le0s1KtVNiu
 DricDgrD1C0rFvVl+sNZJ2shNyuyX4WzTKzc1MznBK1zpQFSPpq/GjjG0rxllxf0YOeH
 eUYNbnfGxvj5UVJsiD+VVghLfmTkq4nHnltRcGNPpvGawExFYHEEmdpdYnhmNX+zszUV
 grUeNvm/ZVZscLX2+VNZzinqpL33M9RtAGyz6vFUYii59ALksI//oCTqcHBW8IMP2H4Q
 16EVy94qMYKLPC6uUhO5BgasToEE8A1CurTlNvdjwevW5MmPp8inqXvtAYLbIMp+P6XF
 paVA==
X-Gm-Message-State: AOJu0YzsG5u/7Q5P99JWTJLtEPM895IKtjRe6axU47P5xi1hoSMtY18c
 arfcJWEYJs4qrCXTvVCgoM2y0aISNQAZDdKToPsXVFqTz1mk8YZ7EMU3PHQiEG9k2uBRdfMuyUB
 aBHLHiMk=
X-Gm-Gg: AeBDievB1Yahqn2sS7o9bR4sx74Zidhp/zCTPHU6N4gKSFCPugi18rz/VPUCJyVtIYQ
 +2KK5hMApBvIj1vL/oloSF31xCF0U/VCo2x2+VxKGTet3bP5p2GeYuB6h4ppL6sqVsoaYs0TCE8
 803/W6gX3VF+yBTD1WWmwUU4toBODw5S0P8ISE7Qi3WK1ZQhVyCfnkj/5gM/61j4YWjVao6NmhO
 CiD4xKFfxuDreiYTFuovze7MqTOJsxuKETBOdCwihOS8BLHEpfgvPC937P4KwtwBE4FJExsts+e
 ScV7M8lw6GX/tF3s8apNIsL3Tc5RHyUpFeE7gMTea5B3fYDhymvCnu5KaUDfKXWs62y/xXuwsn5
 g23pTYQVbEp1YqDWanwEOBAAbi6uxueDvXvgQlmMtavDHOY8re9lQyl9L/y3MEEFP/dF/aMOITn
 +wi8XTgAhPrMMUlK0dP5rLQzLLALYNxnP8lY8ryQNWxDYDnscrgK8=
X-Received: by 2002:a17:903:166e:b0:2b4:64cf:e8f8 with SMTP id
 d9443c01a7336-2b5f9dbcd22mr362877915ad.2.1777211165515; 
 Sun, 26 Apr 2026 06:46:05 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 65/84] fpu: Return struct from parts{64,128}_div
Date: Sun, 26 Apr 2026 23:39:42 +1000
Message-ID: <20260426134002.865628-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 34 ++++++++++++++---------------
 fpu/softfloat-parts.c.inc | 45 +++++++++++++++++----------------------
 2 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 246209072e..6d69b61c7f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2129,9 +2129,9 @@ float16 float16_div(float16 a, float16 b, float_status *status)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return float16_round_pack_canonical(pr, status);
+    return float16_round_pack_canonical(&pr, status);
 }
 
 static float32 QEMU_SOFTFLOAT_ATTR
@@ -2139,9 +2139,9 @@ soft_f32_div(float32 a, float32 b, float_status *status)
 {
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return float32_round_pack_canonical(pr, status);
+    return float32_round_pack_canonical(&pr, status);
 }
 
 static float64 QEMU_SOFTFLOAT_ATTR
@@ -2149,9 +2149,9 @@ soft_f64_div(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return float64_round_pack_canonical(pr, status);
+    return float64_round_pack_canonical(&pr, status);
 }
 
 static float hard_f32_div(float a, float b)
@@ -2216,9 +2216,9 @@ float64 float64r32_div(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return float64r32_round_pack_canonical(pr, status);
+    return float64r32_round_pack_canonical(&pr, status);
 }
 
 bfloat16 QEMU_FLATTEN
@@ -2226,9 +2226,9 @@ bfloat16_div(bfloat16 a, bfloat16 b, float_status *status)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pr = parts64_div(&pa, &pb, status);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    return bfloat16_round_pack_canonical(&pr, status);
 }
 
 float128 QEMU_FLATTEN
@@ -2236,22 +2236,22 @@ float128_div(float128 a, float128 b, float_status *status)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-    FloatParts128 *pr = parts128_div(&pa, &pb, status);
+    FloatParts128 pr = parts128_div(&pa, &pb, status);
 
-    return float128_round_pack_canonical(pr, status);
+    return float128_round_pack_canonical(&pr, status);
 }
 
 floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_div(&pa, &pb, status);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_div(&pa, &pb, status);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 /*
@@ -5140,8 +5140,8 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
         uint32_t r_flags;
 
         /* Compute precise quotient */
-        q_buf = *a;
-        q = parts64_div(&q_buf, b, status);
+        q_buf = parts64_div(a, b, status);
+        q = &q_buf;
 
         /*
          * Check whether two closest integers can be precisely represented,
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 40ea7e3a39..ad53286efc 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -807,68 +807,63 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
  * corresponding value `b'. The operation is performed according to
  * the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
  */
-static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
-                                float_status *s)
+static FloatPartsN partsN(div)(const FloatPartsN *a, const FloatPartsN *b,
+                               float_status *s)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
-    bool sign = a->sign ^ b->sign;
+    FloatPartsN r = *a;
+
+    r.sign ^= b->sign;
+    r.exp -= b->exp;
 
     if (likely(cmask_is_only_normals(ab_mask))) {
         if (ab_mask & float_cmask_denormal) {
             float_raise(float_flag_input_denormal_used, s);
         }
-        a->sign = sign;
-        a->exp -= b->exp + fracN(div)(a, b);
-        return a;
+        r.exp -= fracN(div)(&r, b);
+        return r;
     }
 
     /* 0/0 or Inf/Inf => NaN */
     if (unlikely(ab_mask == float_cmask_zero)) {
         float_raise(float_flag_invalid | float_flag_invalid_zdz, s);
-        goto d_nan;
+        return partsN(default_nan)(s);
     }
     if (unlikely(ab_mask == float_cmask_inf)) {
         float_raise(float_flag_invalid | float_flag_invalid_idi, s);
-        goto d_nan;
+        return partsN(default_nan)(s);
     }
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan)(a, b, s);
-	return a;
+        return partsN(pick_nan)(a, b, s);
     }
 
     if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
         float_raise(float_flag_input_denormal_used, s);
     }
 
-    a->sign = sign;
-
     /* Inf / X */
-    if (a->cls == float_class_inf) {
-        return a;
+    if (r.cls == float_class_inf) {
+        return r;
     }
 
     /* 0 / X */
-    if (a->cls == float_class_zero) {
-        return a;
+    if (r.cls == float_class_zero) {
+        return r;
     }
 
     /* X / Inf */
     if (b->cls == float_class_inf) {
-        a->cls = float_class_zero;
-        return a;
+        r.cls = float_class_zero;
+        return r;
     }
 
     /* X / 0 => Inf */
-    g_assert(b->cls == float_class_zero);
+    assert(b->cls == float_class_zero);
     float_raise(float_flag_divbyzero, s);
-    a->cls = float_class_inf;
-    return a;
-
- d_nan:
-    *a = partsN(default_nan)(s);
-    return a;
+    r.cls = float_class_inf;
+    return r;
 }
 
 /*
-- 
2.43.0



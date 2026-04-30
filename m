Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF986FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEwN-0001eV-AS; Wed, 29 Apr 2026 20:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvP-00082g-9O
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvM-0001vl-T2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:38 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82f6b592fc7so143218b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507595; x=1778112395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ueT7VE4SpknS7CF8wZVBytvmqQGc6ofvktTgtoi4goM=;
 b=mGdIo1Rcmg64nLVK+mi4IYmjbJo/WJJvoN3FJmL08pvSxghdO3IYLX+KOBrxauJlp8
 AZJ6R7keTWYx/9cjCceC0F76+8B06OW4Z7yD+Sl9HSuMn+SKMrpdZXmVGNRN8e+oF+8P
 v+xkC7yj+hFpCKdY5/rcKkWovAlG5yXFtRRFuaNSQh/YcXMYKiYL7WnOQDXrLJDvB6ng
 C7qmcRiiMdpl08pgj/isAxWqTA9pmtDFMPgC7sXI6iA45+cYa2UdEVbEsE2jw8a4cL/F
 V1Gv8gunNd7qdgW7p7PN9f+nQMXDv6v+klYITwYavqwjNLf/p5Rc8mrf+vj/D46nYzbp
 FiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507595; x=1778112395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ueT7VE4SpknS7CF8wZVBytvmqQGc6ofvktTgtoi4goM=;
 b=f3DwfBIiPAiNTMkwTN7wIONFhpozr7SfbI9QriyDc8jJDY+6jZgcc1l+gHokLT9lyb
 g+vMkHQZ1Q/Wz5npGhD7AKllVDAP9nDy4zSCU9jBwy4U0jo+6KZiezwmFPwhPVgNdDBt
 QtjVDjxvJIw3TEq4JChsJ6V+x2F4PaI7fMcF3ud3u5gjosM2BvfgVbc+o4HG5wTzam3I
 02nYfZJjYx1bqo1VILi87axtotVhcdo10nwPC+3UTSb6NysVJcz7R3oTOyEjYq5rRrmA
 44CHVmnwgH1V8swAHCiCtMc7/Sn8oenH/GtMKoEJFZmpi7FY0MWC8oruSXf3YesLgt+w
 DuhA==
X-Gm-Message-State: AOJu0YxKCN27il/t1qH+AMI39Q5unoB8rxlAIPwGaIW9zBboBVS1Hhr6
 gHLCi7yzv4I7WMRDKfDn5mSh3+DeQh9LhoSzFMd3oyuopjfrVwREB4+q3tKNXGaZwdr6WNLPqyu
 TGAGW6uA=
X-Gm-Gg: AeBDiesk5l/QAxtSw8sgPVSJxgCLtS29dGtiGmPpBYGkjOvhUi+kDB2WNEGYluLFzj6
 BVT/cMTsKcImZWR2QDaEwwKt7UH35sSQo2OGwV2siNnJdAeIaXUAbPmglLZsMi7H/Q0Cmo7uRUP
 qE1twXuLGElFo/BTU0dtDKwmIBb0vMwAGCCFXlhTwh2TsoVhUsHH1Mqbs9I85++ivMIFCIpiImP
 pZBW7IdSs/YrOGAcp73VNIxIUHEZEHi/bpAwImxaEtlprjGbG925TFdNiDeqhB9QEIXxwPDKRZi
 u1+wCoV7KUf+IoLErgMmJrkuF6/5qBa0+CQTv+Zj5fWK0WKug3shBtFNG4By2gEHYotWatLX5Ku
 nPrI0rfj7tCmTimsMg+www+K7tdnEcF5ZhYdJqDY4NKp3BAlHcOqfYm7g52k1LLM4Pga5nNBJs+
 GcI8ZQ+9LyhSTLqAcKOaqrj8RGioGGniEP8RCGYzbv
X-Received: by 2002:a05:6a00:aa04:b0:824:3bd9:aac6 with SMTP id
 d2e1a72fcca58-834fdb5c84amr828252b3a.16.1777507594532; 
 Wed, 29 Apr 2026 17:06:34 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 29/40] fpu: Return struct from parts{64,128}_mul
Date: Thu, 30 Apr 2026 10:05:12 +1000
Message-ID: <20260430000524.56046-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 include/fpu/softfloat-parts.h |  5 +++++
 fpu/softfloat.c               | 34 +++++++++++++++++-----------------
 fpu/softfloat-parts.c.inc     | 35 ++++++++++++++++-------------------
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 3183c158eb..68884e8047 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -192,6 +192,11 @@ FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
 FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
                            float_status *s);
 
+FloatParts64 parts64_mul(const FloatParts64 *a, const FloatParts64 *b,
+                         float_status *s);
+FloatParts128 parts128_mul(const FloatParts128 *a, const FloatParts128 *b,
+                           float_status *s);
+
 FloatParts64 parts64_muladd(const FloatParts64 *a,
                             const FloatParts64 *b,
                             const FloatParts64 *c,
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c2450bc078..34ef590856 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1804,9 +1804,9 @@ float16 QEMU_FLATTEN float16_mul(float16 a, float16 b, float_status *status)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float16_round_pack_canonical(pr, status);
+    return float16_round_pack_canonical(&pr, status);
 }
 
 static float32 QEMU_SOFTFLOAT_ATTR
@@ -1814,9 +1814,9 @@ soft_f32_mul(float32 a, float32 b, float_status *status)
 {
     FloatParts64 pa = float32_unpack_canonical(a, status);
     FloatParts64 pb = float32_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float32_round_pack_canonical(pr, status);
+    return float32_round_pack_canonical(&pr, status);
 }
 
 static float64 QEMU_SOFTFLOAT_ATTR
@@ -1824,9 +1824,9 @@ soft_f64_mul(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float64_round_pack_canonical(pr, status);
+    return float64_round_pack_canonical(&pr, status);
 }
 
 static float hard_f32_mul(float a, float b)
@@ -1857,9 +1857,9 @@ float64 float64r32_mul(float64 a, float64 b, float_status *status)
 {
     FloatParts64 pa = float64_unpack_canonical(a, status);
     FloatParts64 pb = float64_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return float64r32_round_pack_canonical(pr, status);
+    return float64r32_round_pack_canonical(&pr, status);
 }
 
 bfloat16 QEMU_FLATTEN
@@ -1867,9 +1867,9 @@ bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
-    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pr = parts64_mul(&pa, &pb, status);
 
-    return bfloat16_round_pack_canonical(pr, status);
+    return bfloat16_round_pack_canonical(&pr, status);
 }
 
 float128 QEMU_FLATTEN
@@ -1877,23 +1877,23 @@ float128_mul(float128 a, float128 b, float_status *status)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-    FloatParts128 *pr = parts128_mul(&pa, &pb, status);
+    FloatParts128 pr = parts128_mul(&pa, &pb, status);
 
-    return float128_round_pack_canonical(pr, status);
+    return float128_round_pack_canonical(&pr, status);
 }
 
 floatx80 QEMU_FLATTEN
 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_mul(&pa, &pb, status);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_mul(&pa, &pb, status);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 /*
@@ -5120,14 +5120,14 @@ float32 float32_exp2(float32 a, float_status *status)
     float_raise(float_flag_inexact, status);
 
     tp = float64_unpack_canonical(float64_ln2, status);
-    xp = *parts64_mul(&xp, &tp, status);
+    xp = parts64_mul(&xp, &tp, status);
     xnp = xp;
 
     rp = float64_unpack_canonical(float64_one, status);
     for (int i = 0; i < 15; i++) {
         tp = float64_unpack_canonical(float32_exp2_coefficients[i], status);
         rp = parts64_muladd(&tp, &xnp, &rp, 0, status);
-        xnp = *parts64_mul(&xnp, &xp, status);
+        xnp = parts64_mul(&xnp, &xp, status);
     }
 
     return float32_round_pack_canonical(&rp, status);
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index dfc0a22d98..84aeae2866 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -613,55 +613,52 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
  * `b'. The operation is performed according to the IEC/IEEE Standard
  * for Binary Floating-Point Arithmetic.
  */
-static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
-                                float_status *s)
+FloatPartsN partsN(mul)(const FloatPartsN *a, const FloatPartsN *b,
+                        float_status *s)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
     bool sign = a->sign ^ b->sign;
 
     if (likely(cmask_is_only_normals(ab_mask))) {
         FloatPartsW tmp;
+        FloatPartsN r = {
+            .cls = float_class_normal,
+            .sign = sign,
+            .exp = a->exp + b->exp + 1,
+        };
 
         record_denormals_used(ab_mask, s);
 
         fracN(mulw)(&tmp, a, b);
-        fracN(truncjam)(a, &tmp);
+        fracN(truncjam)(&r, &tmp);
 
-        a->exp += b->exp + 1;
-        if (!(a->frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
-            fracN(add)(a, a, a);
-            a->exp -= 1;
+        if (!(r.frac_hi & DECOMPOSED_IMPLICIT_BIT)) {
+            fracN(add)(&r, &r, &r);
+            r.exp -= 1;
         }
 
-        a->sign = sign;
-        return a;
+        return r;
     }
 
     /* Inf * Zero == NaN */
     if (unlikely(ab_mask == float_cmask_infzero)) {
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
-        *a = partsN(default_nan)(s);
-        return a;
+        return partsN(default_nan)(s);
     }
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        *a = partsN(pick_nan)(a, b, s);
-	return a;
+        return partsN(pick_nan)(a, b, s);
     }
 
     /* Multiply by 0 or Inf */
     record_denormals_used(ab_mask, s);
 
     if (ab_mask & float_cmask_inf) {
-        a->cls = float_class_inf;
-        a->sign = sign;
-        return a;
+        return (FloatPartsN){ .cls = float_class_inf, .sign = sign };
     }
 
     g_assert(ab_mask & float_cmask_zero);
-    a->cls = float_class_zero;
-    a->sign = sign;
-    return a;
+    return (FloatPartsN){ .cls = float_class_zero, .sign = sign };
 }
 
 /*
-- 
2.43.0



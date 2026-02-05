Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A421EC1E9E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxM1-0004nP-MQ; Thu, 05 Feb 2026 06:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLr-0004mT-A1
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:47 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLp-0003oQ-2c
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:46 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a8ff2ca490so4399155ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770290202; x=1770895002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9Trus/hz1i90FrTfwhpYx+wv92psw9rbjVx4v6GD0s=;
 b=ru9j2P7b7iGf8yiI78aZAdy0SziyZZd85WHc+O97Wnt9vDXbS1oxkjg4v9AlgWRrQe
 ACKvznJzxe9scrbfU4z+EuYz2OsOMM5X0+IAUTaCtCIRiZOnArRa4Vb1S4yaEgyDR5aM
 bQLbnCB9urUAy6D4C2mq16oqDnWnA9LuS5EsxATcZW/GtHIcpAroWeF5t5ZWafHojAdO
 c68t+b311MW8aYKxGtCBBf9tgiFGgtDVb3sieDbrDxxeTBnYwiQky+nYcoRGfqjT/qLr
 A+CZ30G0HRDyON2tinBDyiB9ulBR6R0ECKgUMOBTX/F5X3R8YSM9hUa7gvoUKsmuFRP8
 2ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290202; x=1770895002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9Trus/hz1i90FrTfwhpYx+wv92psw9rbjVx4v6GD0s=;
 b=SUyTehmxTL04AJDHresn8zhzwZ8NhIQip9nzE+8YDdMWZ7dcKPz4xIL7fp8B0iJqo1
 w5Wkb1mzQ41BAB9z03n6ss+QVDUDcTTsnA0HRVBc0S/vTFieDR5vQEXXA1w4Tf1i4rSJ
 hrc9daFndaQrTYO+CMPOqRaDQvoCDF6auolW74hj7E118loq93+qV3ipt7HWptFfHz7V
 qjv+1h5EcqiC8P5l5laq/VkXyVGRyq+8N9x8UZqQT4fUBGglhlLKct1BL/OIwF0tA5R6
 OSScfFGPigIbdoxbp4fcTJUY0tR3KGYv2bAnIZeazqssv/8TqYx5reSqJwLasjjWvguP
 XfVw==
X-Gm-Message-State: AOJu0YxK0EUZ37koF049MQnRkG4EXZkcJh3/H9rVtdhbp/OxOhLpktuN
 IuAK86+cMXJfdIUay8lfYQwHpZK3TlJDNZuA96SdGgCpLaUuTji/4ZqevUGSBHx9lQKYaE3r9u3
 Bd+Wiq15K8A==
X-Gm-Gg: AZuq6aL+ET2Kt5tX/VidE5DMEhLIMmme9hZk4e0WDtUpYxde2aiiehAveMTQCqp6Vrx
 RhMYuG5qUdwYVd34qQZ8ImPwafDr3aDbpmnghkQUp0m51zA8hvNpgGoZZ+9vuc23fGBzaqVfR0i
 P0luixciyGKYavruKId8P5cy6MYp0ZurYN9IGApPcYCST8ZT1nIRRITuEm+JaDqmXUOXSIElfZ1
 EOHF/+e2lIhA40CcYkIkI1auPzawA8ltcZ31w3+4Qqqxah/Ges8Xch/Gog3hspwLFKwIkwuF106
 mDUTFUsiLwjHsK7v3T4Bo37mfITyokxGHnTaoqcu/JzV3OeHcP2kEJ/lY3gczS6T9L6nbHr5yaq
 qLY7XfZdLYIz1ZgOZQRRTO376KBjIyxN79LeIva/msHWwe9XTBpfUSW3IsFXYt6Riw2sPyLfjJo
 6hLuj68f3T1df6Z9unqWTM
X-Received: by 2002:a17:902:f543:b0:29d:a26c:34b6 with SMTP id
 d9443c01a7336-2a934105868mr53918075ad.50.1770290202269; 
 Thu, 05 Feb 2026 03:16:42 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851685sm51088435ad.13.2026.02.05.03.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 03:16:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com
Subject: [PATCH v4 6/9] fpu: Add saturate parameter to parts_uncanon
Date: Thu,  5 Feb 2026 21:16:19 +1000
Message-ID: <20260205111622.461497-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205111622.461497-1-richard.henderson@linaro.org>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Max Chou <max.chou@sifive.com>

The OCP FP8 conversion operations have a parameter to control
saturate vs overflow.  Add a parameter, currently always false.

Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Split out of a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 44 +++++++++++++++++++--------------------
 fpu/softfloat-parts.c.inc | 15 +++++++------
 2 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 209eb59b48..a637d28fd3 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -771,20 +771,20 @@ static void parts128_canonicalize(FloatParts128 *p, float_status *status,
     PARTS_GENERIC_64_128(canonicalize, A)(A, S, F)
 
 static void parts64_uncanon_normal(FloatParts64 *p, float_status *status,
-                                   const FloatFmt *fmt);
+                                   const FloatFmt *fmt, bool saturate);
 static void parts128_uncanon_normal(FloatParts128 *p, float_status *status,
-                                    const FloatFmt *fmt);
+                                    const FloatFmt *fmt, bool saturate);
 
-#define parts_uncanon_normal(A, S, F) \
-    PARTS_GENERIC_64_128(uncanon_normal, A)(A, S, F)
+#define parts_uncanon_normal(A, S, F, X) \
+    PARTS_GENERIC_64_128(uncanon_normal, A)(A, S, F, X)
 
 static void parts64_uncanon(FloatParts64 *p, float_status *status,
-                            const FloatFmt *fmt);
+                            const FloatFmt *fmt, bool saturate);
 static void parts128_uncanon(FloatParts128 *p, float_status *status,
-                             const FloatFmt *fmt);
+                             const FloatFmt *fmt, bool saturate);
 
-#define parts_uncanon(A, S, F) \
-    PARTS_GENERIC_64_128(uncanon, A)(A, S, F)
+#define parts_uncanon(A, S, F, X) \
+    PARTS_GENERIC_64_128(uncanon, A)(A, S, F, X)
 
 static void parts64_add_normal(FloatParts64 *a, FloatParts64 *b);
 static void parts128_add_normal(FloatParts128 *a, FloatParts128 *b);
@@ -1699,7 +1699,7 @@ static float16 float16a_round_pack_canonical(FloatParts64 *p,
                                              float_status *s,
                                              const FloatFmt *params)
 {
-    parts_uncanon(p, s, params);
+    parts_uncanon(p, s, params, false);
     return float16_pack_raw(p);
 }
 
@@ -1712,7 +1712,7 @@ static float16 float16_round_pack_canonical(FloatParts64 *p,
 static bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p,
                                               float_status *s)
 {
-    parts_uncanon(p, s, &bfloat16_params);
+    parts_uncanon(p, s, &bfloat16_params, false);
     return bfloat16_pack_raw(p);
 }
 
@@ -1726,7 +1726,7 @@ static void float32_unpack_canonical(FloatParts64 *p, float32 f,
 static float32 float32_round_pack_canonical(FloatParts64 *p,
                                             float_status *s)
 {
-    parts_uncanon(p, s, &float32_params);
+    parts_uncanon(p, s, &float32_params, false);
     return float32_pack_raw(p);
 }
 
@@ -1740,7 +1740,7 @@ static void float64_unpack_canonical(FloatParts64 *p, float64 f,
 static float64 float64_round_pack_canonical(FloatParts64 *p,
                                             float_status *s)
 {
-    parts_uncanon(p, s, &float64_params);
+    parts_uncanon(p, s, &float64_params, false);
     return float64_pack_raw(p);
 }
 
@@ -1789,7 +1789,7 @@ static float64 float64r32_pack_raw(FloatParts64 *p)
 static float64 float64r32_round_pack_canonical(FloatParts64 *p,
                                                float_status *s)
 {
-    parts_uncanon(p, s, &float32_params);
+    parts_uncanon(p, s, &float32_params, false);
     return float64r32_pack_raw(p);
 }
 
@@ -1803,7 +1803,7 @@ static void float128_unpack_canonical(FloatParts128 *p, float128 f,
 static float128 float128_round_pack_canonical(FloatParts128 *p,
                                               float_status *s)
 {
-    parts_uncanon(p, s, &float128_params);
+    parts_uncanon(p, s, &float128_params, false);
     return float128_pack_raw(p);
 }
 
@@ -1851,7 +1851,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
     case float_class_normal:
     case float_class_denormal:
         if (s->floatx80_rounding_precision == floatx80_precision_x) {
-            parts_uncanon_normal(p, s, fmt);
+            parts_uncanon_normal(p, s, fmt, false);
             frac = p->frac_hi;
             exp = p->exp;
         } else {
@@ -1860,7 +1860,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
             p64.sign = p->sign;
             p64.exp = p->exp;
             frac_truncjam(&p64, p);
-            parts_uncanon_normal(&p64, s, fmt);
+            parts_uncanon_normal(&p64, s, fmt, false);
             frac = p64.frac;
             exp = p64.exp;
         }
@@ -2258,7 +2258,7 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float16_params);
+    parts_uncanon(pr, status, &float16_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2283,7 +2283,7 @@ float32_muladd_scalbn(float32 a, float32 b, float32 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float32_params);
+    parts_uncanon(pr, status, &float32_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2302,7 +2302,7 @@ float64_muladd_scalbn(float64 a, float64 b, float64 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float64_params);
+    parts_uncanon(pr, status, &float64_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2461,7 +2461,7 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float32_params);
+    parts_uncanon(pr, status, &float32_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2479,7 +2479,7 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &bfloat16_params);
+    parts_uncanon(pr, status, &bfloat16_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
@@ -2497,7 +2497,7 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
     pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
-    parts_uncanon(pr, status, &float128_params);
+    parts_uncanon(pr, status, &float128_params, false);
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index eada83f7a4..1e1bbb14fd 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -258,9 +258,12 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
  * are FRAC_SHIFT bits that may require rounding at the bottom of the
  * fraction; these bits will be removed. The exponent will be biased
  * by EXP_BIAS and must be bounded by [EXP_MAX-1, 0].
+ *
+ * The saturate parameter controls saturation behavior for formats that
+ * support it -- when true, overflow produces max normal instead of infinity.
  */
 static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
-                                   const FloatFmt *fmt)
+                                   const FloatFmt *fmt, bool saturate)
 {
     const int exp_max = fmt->exp_max;
     const int frac_shift = fmt->frac_shift;
@@ -269,7 +272,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     const uint64_t frac_lsbm1 = round_mask ^ (round_mask >> 1);
     const uint64_t roundeven_mask = round_mask | frac_lsb;
     uint64_t inc;
-    bool overflow_norm = false;
+    bool overflow_norm = saturate;
     int exp, flags = 0;
 
     switch (s->float_rounding_mode) {
@@ -294,11 +297,11 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         break;
     case float_round_up:
         inc = p->sign ? 0 : round_mask;
-        overflow_norm = p->sign;
+        overflow_norm |= p->sign;
         break;
     case float_round_down:
         inc = p->sign ? round_mask : 0;
-        overflow_norm = !p->sign;
+        overflow_norm |= !p->sign;
         break;
     case float_round_to_odd:
         overflow_norm = true;
@@ -445,10 +448,10 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
 }
 
 static void partsN(uncanon)(FloatPartsN *p, float_status *s,
-                            const FloatFmt *fmt)
+                            const FloatFmt *fmt, bool saturate)
 {
     if (likely(is_anynorm(p->cls))) {
-        parts_uncanon_normal(p, s, fmt);
+        parts_uncanon_normal(p, s, fmt, saturate);
     } else {
         switch (p->cls) {
         case float_class_zero:
-- 
2.43.0



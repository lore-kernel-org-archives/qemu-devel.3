Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B97CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuw-00074G-80; Wed, 29 Apr 2026 20:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuu-0006wZ-9i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEus-0001nl-I2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:07 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82f8cebc935so153831b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507565; x=1778112365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbVuK9RdGSnecOOwaf1HA58zPz8tW1paOnqbUnPnZMw=;
 b=QhgYJ8ySWzlaDuNumqw4Y00MjyE4t8hissvEZeG6Qq+X1PILOTS/gQuV+7VxAD55wO
 zysmK5jL0kZCWCHijRdWoi92Kp+/Lk/NmMspkMaBobiabA6yducdsBYIIvus+iHo6IWo
 JZDUU9vUCiltNS2J29EOMVRdJLushF5NEs8z1llY3RG2GnVqEqVqmh22OM6FgEYZXIDS
 QmtVJjFuutcut6A8IDYu12yivYyG/yR3EBOGNoMYalhtrcpgDUyWXBlOE4b1JaXXghVf
 YqW0WOWzjgd4N2o0RLWC8OJPcRFtRoOY2kR8Qvpseubk9OhBvcK47dTj3qRn5fs0HDYZ
 Y1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507565; x=1778112365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jbVuK9RdGSnecOOwaf1HA58zPz8tW1paOnqbUnPnZMw=;
 b=tVRznJgyXy7oGF5kfGEhNFntFVS3jd/BJvY+Z2TE6JgSmv8gjH5xlIhM5LI9hXweAE
 Q/QxT9UVyOpXRxOnyUNF4khLs+HLkkPGx4kB6+IuoZs8a1y+av0g9g1mKwDVYhYF/M+H
 xFjP4jfaTGjyYPYDz/I1mh0prgrwoe0KAVH8mc4jaYUBuTHk72gkNQEWD8wVESYhRPPg
 ykbs41JB+ezpW3fW0Pqh58vNZPb0DSnjFYcVwaHMachxV/KpPq/pyB5KbkQukdmMroCK
 h9Tg8R+D2SHCZYAvf9XwN7WrCEXE8cqaFpfB1TF1C+N8F1kgR8sJB2Kbm744v95LdNKo
 NRgA==
X-Gm-Message-State: AOJu0YztnNLIRWXdY9BVJGzcSnqz9uEHUTWqyVmxbt/a2LTH5CoUwws7
 IZxodcP7QsWtSZ2tNuAkJxldPw115yk7nikwuF7zr1u/aIRatzSDG8mWc2E8kLqxRoGyGlMdooc
 VAqnWbIk=
X-Gm-Gg: AeBDieuswZTicDS5e4na0HbPC5Fa1jGO5RFQTY9mjy/W+Q0INRp2Y+3nELPtOoJMOTb
 J9JY3A1CY2deNpcmYV7OA7nb+OQ25aKJSNcB9Jug1mpPYWX/dfniN/HMhxfouEEX3WkcGRFT2RZ
 MFQD8vT3rOPVgdyGwlDOd9b6fMq8xpV8V0uinM0L4CAZNAF9G/okNJSxXLxpbwRyRT6l6HQc0Mn
 jbQSaUlfELfvUWoNQo7PIvLe+y67kg3/I5bIuQeIemo7X7gFJiF+JWE0gIaLAh4sMbj8ZJZaMVK
 U3dz6fkQZBcLMVXUyFjeeRGcCRigUXaVfSl/eTDQWom20X42RMNPymNX3jMVeqIrAWXrI2E7iIo
 2f98XbUxEblHf1X/wuiNm2ruJJEVg1Hl5eimWi3a4USSeAAYK2fnua3NrRELlJt3TvHiyDC6V0S
 IxZWeFEHovksy96gBJony0HjpfYiWvSWSiaie2b0Kg
X-Received: by 2002:a05:6a00:27a4:b0:82c:7767:5ba9 with SMTP id
 d2e1a72fcca58-834fdc5be18mr757173b3a.26.1777507565141; 
 Wed, 29 Apr 2026 17:06:05 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 16/40] fpu: Return struct from parts{64,128}_pick_nan
Date: Thu, 30 Apr 2026 10:04:59 +1000
Message-ID: <20260430000524.56046-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           |  8 ++++----
 fpu/softfloat-parts.c.inc | 28 ++++++++++++++++------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b7d461bca4..246209072e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4765,15 +4765,15 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
 
 floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
+    FloatParts128 pa, pb;
 
     if (!floatx80_unpack_canonical(&pa, a, status) ||
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
 
-    pr = parts128_pick_nan(&pa, &pb, status);
-    return floatx80_round_pack_canonical(pr, status);
+    pa = parts128_pick_nan(&pa, &pb, status);
+    return floatx80_round_pack_canonical(&pa, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -5120,7 +5120,7 @@ static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
 {
     /* POp table "Results: DIVIDE TO INTEGER (Part 1 of 2)" */
     if ((float_cmask(a->cls) | float_cmask(b->cls)) & float_cmask_anynan) {
-        *r = *parts64_pick_nan(a, b, status);
+        *r = parts64_pick_nan(a, b, status);
         *n = *r;
         *cc = 1;
     } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ef46dd740c..40ea7e3a39 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -37,11 +37,11 @@ static FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
     return *a;
 }
 
-static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
-                                     float_status *s)
+static FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
+                                    float_status *s)
 {
     bool have_snan = false;
-    FloatPartsN *ret;
+    const FloatPartsN *ret;
     int cmp;
 
     if (is_snan(a->cls) || is_snan(b->cls)) {
@@ -50,8 +50,7 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (s->default_nan_mode) {
-        *a = partsN(default_nan)(s);
-        return a;
+        return partsN(default_nan)(s);
     }
 
     switch (s->float_2nan_prop_rule) {
@@ -110,9 +109,9 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        *ret = partsN(silence_nan)(ret, s);
+        return partsN(silence_nan)(ret, s);
     }
-    return ret;
+    return *ret;
 }
 
 static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
@@ -605,7 +604,8 @@ static FloatPartsN *partsN(addsub)(FloatPartsN *a, FloatPartsN *b,
     return b;
 
  p_nan:
-    return partsN(pick_nan)(a, b, s);
+    *a = partsN(pick_nan)(a, b, s);
+    return a;
 }
 
 /*
@@ -647,7 +647,8 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+	return a;
     }
 
     /* Multiply by 0 or Inf */
@@ -833,7 +834,8 @@ static FloatPartsN *partsN(div)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+	return a;
     }
 
     if ((ab_mask & float_cmask_denormal) && b->cls != float_class_zero) {
@@ -891,7 +893,8 @@ static FloatPartsN *partsN(modrem)(FloatPartsN *a, FloatPartsN *b,
 
     /* All the NaN cases */
     if (unlikely(ab_mask & float_cmask_anynan)) {
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+        return a;
     }
 
     /* Inf % N; N % 0 */
@@ -1514,7 +1517,8 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
             return is_nan(a->cls) ? b : a;
         }
 
-        return partsN(pick_nan)(a, b, s);
+        *a = partsN(pick_nan)(a, b, s);
+        return a;
     }
 
     if (ab_mask & float_cmask_denormal) {
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC905E77180
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ58-00077v-Nh; Sun, 08 Dec 2024 17:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ55-00076s-A3
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:51 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ53-0006CC-Bl
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:51 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5f2ace8a94aso207572eaf.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698128; x=1734302928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZyOB/BhM/jwpXgK9B1tPd1eLKXNKw05NeJnxUm/GVk=;
 b=W62KoYNYEUVRKGMTebTpPiRKnQKERklP7dXYoqXRlEu/MuvVDeZoWivHvzqDiXhYzd
 8Q6QQGamxi5iBI63u75u690bwvNOp3UDEqo+3j/2gaHOXgpUFXzoPdwCZmbF46S02Hph
 tiTh45Hej034DkccxyF/hwt7wF+5Xl5iZEw+LJxzDs7/Du+o2dOxgMMDXrEhDRqkXiVw
 j1VaAk7Fwp9CzfsOl7fIJYkoh11kqVjbqywlYULkoUCP1X8hOyiIL20gcn2apnlfNEKE
 /7KBZtI5PeW82jc8NXScq3SR9vXeKtdC3SAglcGUZGm357+1OZPnGpxYcRW48b3DtUSA
 Fm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698128; x=1734302928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZyOB/BhM/jwpXgK9B1tPd1eLKXNKw05NeJnxUm/GVk=;
 b=p0hLLMjpnIyFjiMAfxgg9etFKhm4hR3eQvXvZfODWnZ++SfcApuWe8B5ZxuwK8h0Gb
 rP7FFkicSN5U4TUXoM4rwypSGiRgYA6Bufr+MwmEQmevSAnBqyHiES5NVl6T7WNbEuxY
 xSdhogVhFS2+WTo05c6gSeps5FAZjpLfvpHGOT6ufha+TsUNf88Xs2FomTyEQYS3MiSw
 vzTmxmtAZZVWhlEkvCHImKSzRViXEbnzLjWDpR6Xm27L+UFs6uCTqA21hjuqFQvXz9dv
 01pgFd6r0ahMAFTSNEmgvY+sEdA0NAQ9NpMG9QAQs9Na2g5qt1MuoJgVWF0K4deR2o5i
 +V6g==
X-Gm-Message-State: AOJu0YylDKAXuFJsX8k+NEZDOGV+p71W7VM0MOaezAakjQgArG8ks5Qp
 eS5xUCvH0bzmexLJkNWKuUUyM1G4GnoABYGNfxvOwiM24uG7qzRpDD5G4EXhpkVbInB7NNHxTJ0
 WyUaZWw==
X-Gm-Gg: ASbGncuYU/Srr/Wof5iQ25qPEbIRBUJHcXbcvfYsjRjTbSJ+X1l2foFQS8O0+1nhNsW
 bFbatXUYxoHgT1kz8/rQXp9xa8PFNvG2+CFB4x3+1iwdEZt0GxZ+wVRUPQtUN0O28HqhzZdEMm+
 8c+r0dBAtClGnfUS9DB9Eq0/HQBjmtqm6AuqQNoH6vXJr+a+llALUUjdP6116ROM25O4b+8QyBz
 BNm3RvEtweF2MEg5cGwdKZFsn7tDn76V090mrS9/wVOjcC2sty5gTp/vp6j3Zp9Fxegv2EMRhzf
 XIxw2zIz04DWZ4w/zb+cPlK4ztr8EXtSU2b5
X-Google-Smtp-Source: AGHT+IGbyoSwC1R6STouElaFYkXPGkqB+rnq43Qhx6Ed+M3tNOyupdpF6x+gQ50S9J6sDeGB6irGvQ==
X-Received: by 2002:a05:6820:8187:b0:5ee:ebcb:e701 with SMTP id
 006d021491bc7-5f2870e7dc9mr6936480eaf.6.1733698127984; 
 Sun, 08 Dec 2024 14:48:47 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 01/17] softfloat: Add float{16,32,64}_muladd_scalbn
Date: Sun,  8 Dec 2024 16:48:28 -0600
Message-ID: <20241208224844.570491-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

We currently have a flag, float_muladd_halve_result, to scale
the result by 2**-1.  Extend this to handle arbitrary scaling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h   |  6 ++++
 fpu/softfloat.c           | 58 ++++++++++++++++++++++-----------------
 fpu/softfloat-parts.c.inc |  7 +++--
 3 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index eb64075b9c..c34ce0477d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -238,6 +238,8 @@ float16 float16_add(float16, float16, float_status *status);
 float16 float16_sub(float16, float16, float_status *status);
 float16 float16_mul(float16, float16, float_status *status);
 float16 float16_muladd(float16, float16, float16, int, float_status *status);
+float16 float16_muladd_scalbn(float16, float16, float16,
+                              int, int, float_status *status);
 float16 float16_div(float16, float16, float_status *status);
 float16 float16_scalbn(float16, int, float_status *status);
 float16 float16_min(float16, float16, float_status *status);
@@ -597,6 +599,8 @@ float32 float32_mul(float32, float32, float_status *status);
 float32 float32_div(float32, float32, float_status *status);
 float32 float32_rem(float32, float32, float_status *status);
 float32 float32_muladd(float32, float32, float32, int, float_status *status);
+float32 float32_muladd_scalbn(float32, float32, float32,
+                              int, int, float_status *status);
 float32 float32_sqrt(float32, float_status *status);
 float32 float32_exp2(float32, float_status *status);
 float32 float32_log2(float32, float_status *status);
@@ -792,6 +796,8 @@ float64 float64_mul(float64, float64, float_status *status);
 float64 float64_div(float64, float64, float_status *status);
 float64 float64_rem(float64, float64, float_status *status);
 float64 float64_muladd(float64, float64, float64, int, float_status *status);
+float64 float64_muladd_scalbn(float64, float64, float64,
+                              int, int, float_status *status);
 float64 float64_sqrt(float64, float_status *status);
 float64 float64_log2(float64, float_status *status);
 FloatRelation float64_compare(float64, float64, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 027a8e576d..a4174de692 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -789,15 +789,15 @@ static FloatParts128 *parts128_mul(FloatParts128 *a, FloatParts128 *b,
 #define parts_mul(A, B, S) \
     PARTS_GENERIC_64_128(mul, A)(A, B, S)
 
-static FloatParts64 *parts64_muladd(FloatParts64 *a, FloatParts64 *b,
-                                    FloatParts64 *c, int flags,
-                                    float_status *s);
-static FloatParts128 *parts128_muladd(FloatParts128 *a, FloatParts128 *b,
-                                      FloatParts128 *c, int flags,
-                                      float_status *s);
+static FloatParts64 *parts64_muladd_scalbn(FloatParts64 *a, FloatParts64 *b,
+                                           FloatParts64 *c, int scale,
+                                           int flags, float_status *s);
+static FloatParts128 *parts128_muladd_scalbn(FloatParts128 *a, FloatParts128 *b,
+                                             FloatParts128 *c, int scale,
+                                             int flags, float_status *s);
 
-#define parts_muladd(A, B, C, Z, S) \
-    PARTS_GENERIC_64_128(muladd, A)(A, B, C, Z, S)
+#define parts_muladd_scalbn(A, B, C, Z, Y, S) \
+    PARTS_GENERIC_64_128(muladd_scalbn, A)(A, B, C, Z, Y, S)
 
 static FloatParts64 *parts64_div(FloatParts64 *a, FloatParts64 *b,
                                  float_status *s);
@@ -2212,43 +2212,50 @@ floatx80_mul(floatx80 a, floatx80 b, float_status *status)
  * Fused multiply-add
  */
 
-float16 QEMU_FLATTEN float16_muladd(float16 a, float16 b, float16 c,
-                                    int flags, float_status *status)
+float16 QEMU_FLATTEN
+float16_muladd_scalbn(float16 a, float16 b, float16 c,
+                      int scale, int flags, float_status *status)
 {
     FloatParts64 pa, pb, pc, *pr;
 
     float16_unpack_canonical(&pa, a, status);
     float16_unpack_canonical(&pb, b, status);
     float16_unpack_canonical(&pc, c, status);
-    pr = parts_muladd(&pa, &pb, &pc, flags, status);
+    pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     return float16_round_pack_canonical(pr, status);
 }
 
-static float32 QEMU_SOFTFLOAT_ATTR
-soft_f32_muladd(float32 a, float32 b, float32 c, int flags,
-                float_status *status)
+float16 float16_muladd(float16 a, float16 b, float16 c,
+                       int flags, float_status *status)
+{
+    return float16_muladd_scalbn(a, b, c, 0, flags, status);
+}
+
+float32 QEMU_SOFTFLOAT_ATTR
+float32_muladd_scalbn(float32 a, float32 b, float32 c,
+                      int scale, int flags, float_status *status)
 {
     FloatParts64 pa, pb, pc, *pr;
 
     float32_unpack_canonical(&pa, a, status);
     float32_unpack_canonical(&pb, b, status);
     float32_unpack_canonical(&pc, c, status);
-    pr = parts_muladd(&pa, &pb, &pc, flags, status);
+    pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     return float32_round_pack_canonical(pr, status);
 }
 
-static float64 QEMU_SOFTFLOAT_ATTR
-soft_f64_muladd(float64 a, float64 b, float64 c, int flags,
-                float_status *status)
+float64 QEMU_SOFTFLOAT_ATTR
+float64_muladd_scalbn(float64 a, float64 b, float64 c,
+                      int scale, int flags, float_status *status)
 {
     FloatParts64 pa, pb, pc, *pr;
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
     float64_unpack_canonical(&pc, c, status);
-    pr = parts_muladd(&pa, &pb, &pc, flags, status);
+    pr = parts_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -2323,7 +2330,7 @@ float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
     return ur.s;
 
  soft:
-    return soft_f32_muladd(ua.s, ub.s, uc.s, flags, s);
+    return float32_muladd_scalbn(ua.s, ub.s, uc.s, 0, flags, s);
 }
 
 float64 QEMU_FLATTEN
@@ -2394,7 +2401,7 @@ float64_muladd(float64 xa, float64 xb, float64 xc, int flags, float_status *s)
     return ur.s;
 
  soft:
-    return soft_f64_muladd(ua.s, ub.s, uc.s, flags, s);
+    return float64_muladd_scalbn(ua.s, ub.s, uc.s, 0, flags, s);
 }
 
 float64 float64r32_muladd(float64 a, float64 b, float64 c,
@@ -2405,7 +2412,7 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
     float64_unpack_canonical(&pc, c, status);
-    pr = parts_muladd(&pa, &pb, &pc, flags, status);
+    pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     return float64r32_round_pack_canonical(pr, status);
 }
@@ -2418,7 +2425,7 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     bfloat16_unpack_canonical(&pa, a, status);
     bfloat16_unpack_canonical(&pb, b, status);
     bfloat16_unpack_canonical(&pc, c, status);
-    pr = parts_muladd(&pa, &pb, &pc, flags, status);
+    pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     return bfloat16_round_pack_canonical(pr, status);
 }
@@ -2431,7 +2438,7 @@ float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
     float128_unpack_canonical(&pa, a, status);
     float128_unpack_canonical(&pb, b, status);
     float128_unpack_canonical(&pc, c, status);
-    pr = parts_muladd(&pa, &pb, &pc, flags, status);
+    pr = parts_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -5230,8 +5237,9 @@ float32 float32_exp2(float32 a, float_status *status)
 
     float64_unpack_canonical(&rp, float64_one, status);
     for (i = 0 ; i < 15 ; i++) {
+
         float64_unpack_canonical(&tp, float32_exp2_coefficients[i], status);
-        rp = *parts_muladd(&tp, &xnp, &rp, 0, status);
+        rp = *parts_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
         xnp = *parts_mul(&xnp, &xp, status);
     }
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index cc6e06b976..5133358878 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -476,8 +476,9 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
  * Requires A and C extracted into a double-sized structure to provide the
  * extra space for the widening multiply.
  */
-static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
-                                   FloatPartsN *c, int flags, float_status *s)
+static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
+                                          FloatPartsN *c, int scale,
+                                          int flags, float_status *s)
 {
     int ab_mask, abc_mask;
     FloatPartsW p_widen, c_widen;
@@ -566,9 +567,11 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
     a->exp = p_widen.exp;
 
  return_normal:
+    /* TODO: Replace all use of float_muladd_halve_result with scale. */
     if (flags & float_muladd_halve_result) {
         a->exp -= 1;
     }
+    a->exp += scale;
  finish_sign:
     if (flags & float_muladd_negate_result) {
         a->sign ^= 1;
-- 
2.43.0



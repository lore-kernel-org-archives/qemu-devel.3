Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275EBFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDPl-0006cJ-0w; Wed, 29 Apr 2026 18:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPg-00062w-To
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:48 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPd-0006zO-Sf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:48 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35d965648a2so244999a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501784; x=1778106584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUmpIM4LfmrIkEEZVNZic3Yz4otW5xM8jl90p7Wz+D4=;
 b=OG8n12mlI9bQVj1Ns5cogYdE/StXflV8iJB4NxFFEJikOIG6eCD/nxnizSmMxHWKZm
 /zhvRo7EtAP5G06GMqi7mzE0BVE+bmqwcgTttZi2B8qbLtUCPCwEmH7Q5/4+yNEWMSsR
 Oclyrvq8Z2xtn0rcDGeBmCoEWigc5R9Aq9ahBPBZ9aGV3spyGX9C2190swpDCDepcz/O
 JDT9llEjqDbsYjAwZmV/rqwFIUikjcR3VN1ZAd7GNnbwdbJm47IMOJqEbgHEXdZyaAL/
 qfJ/E8WDgKkzC31i/CgwtIjy13Z6xvR62QmCfx3yeRwFmPg4OY1DU/1/+z6gTphW2hXU
 x6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501784; x=1778106584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CUmpIM4LfmrIkEEZVNZic3Yz4otW5xM8jl90p7Wz+D4=;
 b=N8XTW1yfKjhYq2T4Jk+UmeO+Oa7N9hupMBcp8/XvidCj3yS/h+XHAl3ELZQ2wc1VQ0
 6hoU6uhFddFPgWY1/AAKVqIk4ruYWOLlNFzEQGjQFw6qaqXrwk3Em0O6K/T2bZgrRvMD
 VdtfymIuITHodMSg1t+yTbowjrLZgEYHU0fcN/m4uWRRYfipEaoevNcSYJmwy2Mtx/LC
 e38PDeXGlscIsLQpu+UZzJGKKaGldWLY3LM+RsTGsT1kTqgs/C1+ODIyCLWXfB6hTDG5
 lAEndfgA5Qm3xUSGx+yvo0Bz9CTABc+e/jmb2zEe15HxBcPzjpVGdmPDLIrGj4/KRAbM
 DN7A==
X-Gm-Message-State: AOJu0YzuqmGpKAOJECctWGBLW95xelU1YZKxVWgSsZdGgIqWVbrwbl9q
 5jWWFvpYqzriKgAtBmVzWapZClFfmamqzYWUhgRmQ5HK/1SMXwC09p0fCGI3PAqTuUrxZJ4qy0H
 I1NQEhpM=
X-Gm-Gg: AeBDiesv9EMHhdpb05CS5EIevNWfKaAGdjKw1LraLGyKv8FZ4Q8JiBO1ng99sf6DuD4
 35RCQUeoUOm/FVoVvBJg8J2DiFf8TFJcYZhCBOlJRUxy9t7y2VbNnqs/M9CpQNBp11t47eAg7t3
 RiqtoZMP5R8/nC5G9DT61uSqCn7DLhALrCjz73XoxX7JY9xndhrtOwRygGKwVdespsg9ejpXMgI
 PpVNjWWz8UDilgc/xiGHOQPWRNYY32U4FzBlvMUtGUyAfqylDq2F91/FYYAn26zypbwXBndT9cp
 KUN736gzVVrDe8p13Shuq1p4NQSowil9F9/vuvj8LlKHkp1/0GzW1W/uQRf0+t+Dv/5F/zIA7dB
 AdAlHf7GrSWdzeov3n8KtMuIyliPK28A0HiT92sYFWmYEjed5v7usv2uM7iaJYzLwFkt4E6Ig6+
 FgvqAT7V57debhCcnjWI+4b1DnilbvCkwZO94jjlZZ
X-Received: by 2002:a17:90b:3cc3:b0:35f:b784:d3bf with SMTP id
 98e67ed59e1d1-364c2f0b457mr197691a91.1.1777501784342; 
 Wed, 29 Apr 2026 15:29:44 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm630479a91.7.2026.04.29.15.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:29:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/48] fpu: Return struct from float{32,64}_unpack_canonical
Date: Thu, 30 Apr 2026 08:24:40 +1000
Message-ID: <20260429222445.26301-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

We must change float32 and float64 at once because
of the DEFINE_S390_DIVIDE_TO_INTEGER macro.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 300 +++++++++++++++++-------------------------------
 1 file changed, 107 insertions(+), 193 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e1b92b38b6..b3208c1891 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1516,11 +1516,11 @@ static bfloat16 bfloat16_round_pack_canonical(FloatParts64 *p,
     return bfloat16_pack_raw(p);
 }
 
-static void float32_unpack_canonical(FloatParts64 *p, float32 f,
-                                     float_status *s)
+static FloatParts64 float32_unpack_canonical(float32 f, float_status *s)
 {
-    *p = unpack_raw64(&float32_params, f);
-    parts64_canonicalize(p, s, &float32_params);
+    FloatParts64 p = unpack_raw64(&float32_params, f);
+    parts64_canonicalize(&p, s, &float32_params);
+    return p;
 }
 
 static float32 float32_round_pack_canonical(FloatParts64 *p,
@@ -1530,11 +1530,11 @@ static float32 float32_round_pack_canonical(FloatParts64 *p,
     return float32_pack_raw(p);
 }
 
-static void float64_unpack_canonical(FloatParts64 *p, float64 f,
-                                     float_status *s)
+static FloatParts64 float64_unpack_canonical(float64 f, float_status *s)
 {
-    *p = unpack_raw64(&float64_params, f);
-    parts64_canonicalize(p, s, &float64_params);
+    FloatParts64 p = unpack_raw64(&float64_params, f);
+    parts64_canonicalize(&p, s, &float64_params);
+    return p;
 }
 
 static float64 float64_round_pack_canonical(FloatParts64 *p,
@@ -1722,11 +1722,9 @@ float16 float16_sub(float16 a, float16 b, float_status *status)
 static float32 QEMU_SOFTFLOAT_ATTR
 soft_f32_addsub(float32 a, float32 b, float_status *status, bool subtract)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float32_unpack_canonical(&pa, a, status);
-    float32_unpack_canonical(&pb, b, status);
-    pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pa = float32_unpack_canonical(a, status);
+    FloatParts64 pb = float32_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return float32_round_pack_canonical(pr, status);
 }
@@ -1744,11 +1742,9 @@ static float32 soft_f32_sub(float32 a, float32 b, float_status *status)
 static float64 QEMU_SOFTFLOAT_ATTR
 soft_f64_addsub(float64 a, float64 b, float_status *status, bool subtract)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float64_unpack_canonical(&pa, a, status);
-    float64_unpack_canonical(&pb, b, status);
-    pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pa = float64_unpack_canonical(a, status);
+    FloatParts64 pb = float64_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -1841,11 +1837,9 @@ float64_sub(float64 a, float64 b, float_status *s)
 static float64 float64r32_addsub(float64 a, float64 b, float_status *status,
                                  bool subtract)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float64_unpack_canonical(&pa, a, status);
-    float64_unpack_canonical(&pb, b, status);
-    pr = parts64_addsub(&pa, &pb, status, subtract);
+    FloatParts64 pa = float64_unpack_canonical(a, status);
+    FloatParts64 pb = float64_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_addsub(&pa, &pb, status, subtract);
 
     return float64r32_round_pack_canonical(pr, status);
 }
@@ -1942,11 +1936,9 @@ float16 QEMU_FLATTEN float16_mul(float16 a, float16 b, float_status *status)
 static float32 QEMU_SOFTFLOAT_ATTR
 soft_f32_mul(float32 a, float32 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float32_unpack_canonical(&pa, a, status);
-    float32_unpack_canonical(&pb, b, status);
-    pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pa = float32_unpack_canonical(a, status);
+    FloatParts64 pb = float32_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
 
     return float32_round_pack_canonical(pr, status);
 }
@@ -1954,11 +1946,9 @@ soft_f32_mul(float32 a, float32 b, float_status *status)
 static float64 QEMU_SOFTFLOAT_ATTR
 soft_f64_mul(float64 a, float64 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float64_unpack_canonical(&pa, a, status);
-    float64_unpack_canonical(&pb, b, status);
-    pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pa = float64_unpack_canonical(a, status);
+    FloatParts64 pb = float64_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -1989,11 +1979,9 @@ float64_mul(float64 a, float64 b, float_status *s)
 
 float64 float64r32_mul(float64 a, float64 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float64_unpack_canonical(&pa, a, status);
-    float64_unpack_canonical(&pb, b, status);
-    pr = parts64_mul(&pa, &pb, status);
+    FloatParts64 pa = float64_unpack_canonical(a, status);
+    FloatParts64 pb = float64_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_mul(&pa, &pb, status);
 
     return float64r32_round_pack_canonical(pr, status);
 }
@@ -2066,12 +2054,10 @@ float32 QEMU_SOFTFLOAT_ATTR
 float32_muladd_scalbn(float32 a, float32 b, float32 c,
                       int scale, int flags, float_status *status)
 {
-    FloatParts64 pa, pb, pc, *pr;
-
-    float32_unpack_canonical(&pa, a, status);
-    float32_unpack_canonical(&pb, b, status);
-    float32_unpack_canonical(&pc, c, status);
-    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 pa = float32_unpack_canonical(a, status);
+    FloatParts64 pb = float32_unpack_canonical(b, status);
+    FloatParts64 pc = float32_unpack_canonical(c, status);
+    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float32_params, false);
@@ -2085,12 +2071,10 @@ float64 QEMU_SOFTFLOAT_ATTR
 float64_muladd_scalbn(float64 a, float64 b, float64 c,
                       int scale, int flags, float_status *status)
 {
-    FloatParts64 pa, pb, pc, *pr;
-
-    float64_unpack_canonical(&pa, a, status);
-    float64_unpack_canonical(&pb, b, status);
-    float64_unpack_canonical(&pc, c, status);
-    pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
+    FloatParts64 pa = float64_unpack_canonical(a, status);
+    FloatParts64 pb = float64_unpack_canonical(b, status);
+    FloatParts64 pc = float64_unpack_canonical(c, status);
+    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, scale, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float64_params, false);
@@ -2244,12 +2228,10 @@ float64_muladd(float64 xa, float64 xb, float64 xc, int flags, float_status *s)
 float64 float64r32_muladd(float64 a, float64 b, float64 c,
                           int flags, float_status *status)
 {
-    FloatParts64 pa, pb, pc, *pr;
-
-    float64_unpack_canonical(&pa, a, status);
-    float64_unpack_canonical(&pb, b, status);
-    float64_unpack_canonical(&pc, c, status);
-    pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts64 pa = float64_unpack_canonical(a, status);
+    FloatParts64 pb = float64_unpack_canonical(b, status);
+    FloatParts64 pc = float64_unpack_canonical(c, status);
+    FloatParts64 *pr = parts64_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts64_uncanon(pr, status, &float32_params, false);
@@ -2309,11 +2291,9 @@ float16 float16_div(float16 a, float16 b, float_status *status)
 static float32 QEMU_SOFTFLOAT_ATTR
 soft_f32_div(float32 a, float32 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float32_unpack_canonical(&pa, a, status);
-    float32_unpack_canonical(&pb, b, status);
-    pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pa = float32_unpack_canonical(a, status);
+    FloatParts64 pb = float32_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_div(&pa, &pb, status);
 
     return float32_round_pack_canonical(pr, status);
 }
@@ -2321,11 +2301,9 @@ soft_f32_div(float32 a, float32 b, float_status *status)
 static float64 QEMU_SOFTFLOAT_ATTR
 soft_f64_div(float64 a, float64 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float64_unpack_canonical(&pa, a, status);
-    float64_unpack_canonical(&pb, b, status);
-    pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pa = float64_unpack_canonical(a, status);
+    FloatParts64 pb = float64_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_div(&pa, &pb, status);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -2390,11 +2368,9 @@ float64_div(float64 a, float64 b, float_status *s)
 
 float64 float64r32_div(float64 a, float64 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float64_unpack_canonical(&pa, a, status);
-    float64_unpack_canonical(&pb, b, status);
-    pr = parts64_div(&pa, &pb, status);
+    FloatParts64 pa = float64_unpack_canonical(a, status);
+    FloatParts64 pb = float64_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_div(&pa, &pb, status);
 
     return float64r32_round_pack_canonical(pr, status);
 }
@@ -2440,22 +2416,18 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
 
 float32 float32_rem(float32 a, float32 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float32_unpack_canonical(&pa, a, status);
-    float32_unpack_canonical(&pb, b, status);
-    pr = parts64_modrem(&pa, &pb, NULL, status);
+    FloatParts64 pa = float32_unpack_canonical(a, status);
+    FloatParts64 pb = float32_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_modrem(&pa, &pb, NULL, status);
 
     return float32_round_pack_canonical(pr, status);
 }
 
 float64 float64_rem(float64 a, float64 b, float_status *status)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float64_unpack_canonical(&pa, a, status);
-    float64_unpack_canonical(&pb, b, status);
-    pr = parts64_modrem(&pa, &pb, NULL, status);
+    FloatParts64 pa = float64_unpack_canonical(a, status);
+    FloatParts64 pb = float64_unpack_canonical(b, status);
+    FloatParts64 *pr = parts64_modrem(&pa, &pb, NULL, status);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -2688,28 +2660,25 @@ float64 float16_to_float64(float16 a, bool ieee, float_status *s)
 
 float8_e4m3 float32_to_float8_e4m3(float32 a, bool saturate, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float32_unpack_canonical(a, s);
 
-    float32_unpack_canonical(&p, a, s);
     parts64_float_to_float(&p, s);
     return float8_e4m3_round_pack_canonical(&p, s, saturate);
 }
 
 float8_e5m2 float32_to_float8_e5m2(float32 a, bool saturate, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float32_unpack_canonical(a, s);
 
-    float32_unpack_canonical(&p, a, s);
     parts_float_to_e5m2(&p, s, saturate);
     return float8_e5m2_round_pack_canonical(&p, s, saturate);
 }
 
 float16 float32_to_float16(float32 a, bool ieee, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float32_unpack_canonical(a, s);
     const FloatFmt *fmt;
 
-    float32_unpack_canonical(&p, a, s);
     if (ieee) {
         parts64_float_to_float(&p, s);
         fmt = &float16_params;
@@ -2723,9 +2692,8 @@ float16 float32_to_float16(float32 a, bool ieee, float_status *s)
 static float64 QEMU_SOFTFLOAT_ATTR
 soft_float32_to_float64(float32 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float32_unpack_canonical(a, s);
 
-    float32_unpack_canonical(&p, a, s);
     parts64_float_to_float(&p, s);
     return float64_round_pack_canonical(&p, s);
 }
@@ -2748,10 +2716,9 @@ float64 float32_to_float64(float32 a, float_status *s)
 
 float16 float64_to_float16(float64 a, bool ieee, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float64_unpack_canonical(a, s);
     const FloatFmt *fmt;
 
-    float64_unpack_canonical(&p, a, s);
     if (ieee) {
         parts64_float_to_float(&p, s);
         fmt = &float16_params;
@@ -2764,9 +2731,8 @@ float16 float64_to_float16(float64 a, bool ieee, float_status *s)
 
 float32 float64_to_float32(float64 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float64_unpack_canonical(a, s);
 
-    float64_unpack_canonical(&p, a, s);
     parts64_float_to_float(&p, s);
     return float32_round_pack_canonical(&p, s);
 }
@@ -2805,18 +2771,16 @@ float64 bfloat16_to_float64(bfloat16 a, float_status *s)
 
 bfloat16 float32_to_bfloat16(float32 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float32_unpack_canonical(a, s);
 
-    float32_unpack_canonical(&p, a, s);
     parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
 bfloat16 float64_to_bfloat16(float64 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float64_unpack_canonical(a, s);
 
-    float64_unpack_canonical(&p, a, s);
     parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
@@ -2843,20 +2807,18 @@ float64 float128_to_float64(float128 a, float_status *s)
 
 float128 float32_to_float128(float32 a, float_status *s)
 {
-    FloatParts64 p64;
+    FloatParts64 p64 = float32_unpack_canonical(a, s);
     FloatParts128 p128;
 
-    float32_unpack_canonical(&p64, a, s);
     parts_float_to_float_widen(&p128, &p64, s);
     return float128_round_pack_canonical(&p128, s);
 }
 
 float128 float64_to_float128(float64 a, float_status *s)
 {
-    FloatParts64 p64;
+    FloatParts64 p64 = float64_unpack_canonical(a, s);
     FloatParts128 p128;
 
-    float64_unpack_canonical(&p64, a, s);
     parts_float_to_float_widen(&p128, &p64, s);
     return float128_round_pack_canonical(&p128, s);
 }
@@ -2901,20 +2863,18 @@ float128 floatx80_to_float128(floatx80 a, float_status *s)
 
 floatx80 float32_to_floatx80(float32 a, float_status *s)
 {
-    FloatParts64 p64;
+    FloatParts64 p64 = float32_unpack_canonical(a, s);
     FloatParts128 p128;
 
-    float32_unpack_canonical(&p64, a, s);
     parts_float_to_float_widen(&p128, &p64, s);
     return floatx80_round_pack_canonical(&p128, s);
 }
 
 floatx80 float64_to_floatx80(float64 a, float_status *s)
 {
-    FloatParts64 p64;
+    FloatParts64 p64 = float64_unpack_canonical(a, s);
     FloatParts128 p128;
 
-    float64_unpack_canonical(&p64, a, s);
     parts_float_to_float_widen(&p128, &p64, s);
     return floatx80_round_pack_canonical(&p128, s);
 }
@@ -2942,18 +2902,16 @@ float16 float16_round_to_int(float16 a, float_status *s)
 
 float32 float32_round_to_int(float32 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float32_unpack_canonical(a, s);
 
-    float32_unpack_canonical(&p, a, s);
     parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float32_params);
     return float32_round_pack_canonical(&p, s);
 }
 
 float64 float64_round_to_int(float64 a, float_status *s)
 {
-    FloatParts64 p;
+    FloatParts64 p = float64_unpack_canonical(a, s);
 
-    float64_unpack_canonical(&p, a, s);
     parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float64_params);
     return float64_round_pack_canonical(&p, s);
 }
@@ -3023,54 +2981,42 @@ int64_t float16_to_int64_scalbn(float16 a, FloatRoundMode rmode, int scale,
 int16_t float32_to_int16_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float32_unpack_canonical(&p, a, s);
+    FloatParts64 p = float32_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
 int32_t float32_to_int32_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float32_unpack_canonical(&p, a, s);
+    FloatParts64 p = float32_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 int64_t float32_to_int64_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float32_unpack_canonical(&p, a, s);
+    FloatParts64 p = float32_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
 int16_t float64_to_int16_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float64_unpack_canonical(&p, a, s);
+    FloatParts64 p = float64_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
 int32_t float64_to_int32_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float64_unpack_canonical(&p, a, s);
+    FloatParts64 p = float64_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 int64_t float64_to_int64_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float64_unpack_canonical(&p, a, s);
+    FloatParts64 p = float64_unpack_canonical(a, s);
     return parts64_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
@@ -3455,18 +3401,14 @@ static int64_t parts64_float_to_sint_modulo(FloatParts64 *p,
 int32_t float64_to_int32_modulo(float64 a, FloatRoundMode rmode,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float64_unpack_canonical(&p, a, s);
+    FloatParts64 p = float64_unpack_canonical(a, s);
     return parts64_float_to_sint_modulo(&p, rmode, 31, s);
 }
 
 int64_t float64_to_int64_modulo(float64 a, FloatRoundMode rmode,
                                 float_status *s)
 {
-    FloatParts64 p;
-
-    float64_unpack_canonical(&p, a, s);
+    FloatParts64 p = float64_unpack_canonical(a, s);
     return parts64_float_to_sint_modulo(&p, rmode, 63, s);
 }
 
@@ -3505,54 +3447,42 @@ uint64_t float16_to_uint64_scalbn(float16 a, FloatRoundMode rmode, int scale,
 uint16_t float32_to_uint16_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float32_unpack_canonical(&p, a, s);
+    FloatParts64 p = float32_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
 }
 
 uint32_t float32_to_uint32_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float32_unpack_canonical(&p, a, s);
+    FloatParts64 p = float32_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 uint64_t float32_to_uint64_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float32_unpack_canonical(&p, a, s);
+    FloatParts64 p = float32_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
 uint16_t float64_to_uint16_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float64_unpack_canonical(&p, a, s);
+    FloatParts64 p = float64_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
 }
 
 uint32_t float64_to_uint32_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float64_unpack_canonical(&p, a, s);
+    FloatParts64 p = float64_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 uint64_t float64_to_uint64_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
-    FloatParts64 p;
-
-    float64_unpack_canonical(&p, a, s);
+    FloatParts64 p = float64_unpack_canonical(a, s);
     return parts64_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
@@ -4266,22 +4196,18 @@ static bfloat16 bfloat16_minmax(bfloat16 a, bfloat16 b,
 
 static float32 float32_minmax(float32 a, float32 b, float_status *s, int flags)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float32_unpack_canonical(&pa, a, s);
-    float32_unpack_canonical(&pb, b, s);
-    pr = parts64_minmax(&pa, &pb, s, flags);
+    FloatParts64 pa = float32_unpack_canonical(a, s);
+    FloatParts64 pb = float32_unpack_canonical(b, s);
+    FloatParts64 *pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float32_round_pack_canonical(pr, s);
 }
 
 static float64 float64_minmax(float64 a, float64 b, float_status *s, int flags)
 {
-    FloatParts64 pa, pb, *pr;
-
-    float64_unpack_canonical(&pa, a, s);
-    float64_unpack_canonical(&pb, b, s);
-    pr = parts64_minmax(&pa, &pb, s, flags);
+    FloatParts64 pa = float64_unpack_canonical(a, s);
+    FloatParts64 pb = float64_unpack_canonical(b, s);
+    FloatParts64 *pr = parts64_minmax(&pa, &pb, s, flags);
 
     return float64_round_pack_canonical(pr, s);
 }
@@ -4347,10 +4273,9 @@ FloatRelation float16_compare_quiet(float16 a, float16 b, float_status *s)
 static FloatRelation QEMU_SOFTFLOAT_ATTR
 float32_do_compare(float32 a, float32 b, float_status *s, bool is_quiet)
 {
-    FloatParts64 pa, pb;
+    FloatParts64 pa = float32_unpack_canonical(a, s);
+    FloatParts64 pb = float32_unpack_canonical(b, s);
 
-    float32_unpack_canonical(&pa, a, s);
-    float32_unpack_canonical(&pb, b, s);
     return parts64_compare(&pa, &pb, s, is_quiet);
 }
 
@@ -4401,10 +4326,9 @@ FloatRelation float32_compare_quiet(float32 a, float32 b, float_status *s)
 static FloatRelation QEMU_SOFTFLOAT_ATTR
 float64_do_compare(float64 a, float64 b, float_status *s, bool is_quiet)
 {
-    FloatParts64 pa, pb;
+    FloatParts64 pa = float64_unpack_canonical(a, s);
+    FloatParts64 pb = float64_unpack_canonical(b, s);
 
-    float64_unpack_canonical(&pa, a, s);
-    float64_unpack_canonical(&pb, b, s);
     return parts64_compare(&pa, &pb, s, is_quiet);
 }
 
@@ -4527,18 +4451,16 @@ float16 float16_scalbn(float16 a, int n, float_status *status)
 
 float32 float32_scalbn(float32 a, int n, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float32_unpack_canonical(a, status);
 
-    float32_unpack_canonical(&p, a, status);
     parts64_scalbn(&p, n, status);
     return float32_round_pack_canonical(&p, status);
 }
 
 float64 float64_scalbn(float64 a, int n, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float64_unpack_canonical(a, status);
 
-    float64_unpack_canonical(&p, a, status);
     parts64_scalbn(&p, n, status);
     return float64_round_pack_canonical(&p, status);
 }
@@ -4586,9 +4508,8 @@ float16 QEMU_FLATTEN float16_sqrt(float16 a, float_status *status)
 static float32 QEMU_SOFTFLOAT_ATTR
 soft_f32_sqrt(float32 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float32_unpack_canonical(a, status);
 
-    float32_unpack_canonical(&p, a, status);
     parts64_sqrt(&p, status, &float32_params);
     return float32_round_pack_canonical(&p, status);
 }
@@ -4596,9 +4517,8 @@ soft_f32_sqrt(float32 a, float_status *status)
 static float64 QEMU_SOFTFLOAT_ATTR
 soft_f64_sqrt(float64 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float64_unpack_canonical(a, status);
 
-    float64_unpack_canonical(&p, a, status);
     parts64_sqrt(&p, status, &float64_params);
     return float64_round_pack_canonical(&p, status);
 }
@@ -4659,9 +4579,8 @@ float64 QEMU_FLATTEN float64_sqrt(float64 xa, float_status *s)
 
 float64 float64r32_sqrt(float64 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float64_unpack_canonical(a, status);
 
-    float64_unpack_canonical(&p, a, status);
     parts64_sqrt(&p, status, &float64_params);
     return float64r32_round_pack_canonical(&p, status);
 }
@@ -4822,18 +4741,16 @@ static void parts64_log2(FloatParts64 *a, float_status *s, const FloatFmt *fmt)
 
 float32 float32_log2(float32 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float32_unpack_canonical(a, status);
 
-    float32_unpack_canonical(&p, a, status);
     parts64_log2(&p, status, &float32_params);
     return float32_round_pack_canonical(&p, status);
 }
 
 float64 float64_log2(float64 a, float_status *status)
 {
-    FloatParts64 p;
+    FloatParts64 p = float64_unpack_canonical(a, status);
 
-    float64_unpack_canonical(&p, a, status);
     parts64_log2(&p, status, &float64_params);
     return float64_round_pack_canonical(&p, status);
 }
@@ -5321,10 +5238,9 @@ static const float64 float32_exp2_coefficients[15] =
 
 float32 float32_exp2(float32 a, float_status *status)
 {
-    FloatParts64 xp, xnp, tp, rp;
-    int i;
+    FloatParts64 xnp, tp, rp;
+    FloatParts64 xp = float32_unpack_canonical(a, status);
 
-    float32_unpack_canonical(&xp, a, status);
     if (unlikely(xp.cls != float_class_normal)) {
         switch (xp.cls) {
         case float_class_denormal:
@@ -5344,14 +5260,13 @@ float32 float32_exp2(float32 a, float_status *status)
 
     float_raise(float_flag_inexact, status);
 
-    float64_unpack_canonical(&tp, float64_ln2, status);
+    tp = float64_unpack_canonical(float64_ln2, status);
     xp = *parts64_mul(&xp, &tp, status);
     xnp = xp;
 
-    float64_unpack_canonical(&rp, float64_one, status);
-    for (i = 0 ; i < 15 ; i++) {
-
-        float64_unpack_canonical(&tp, float32_exp2_coefficients[i], status);
+    rp = float64_unpack_canonical(float64_one, status);
+    for (int i = 0; i < 15; i++) {
+        tp = float64_unpack_canonical(float32_exp2_coefficients[i], status);
         rp = *parts64_muladd_scalbn(&tp, &xnp, &rp, 0, 0, status);
         xnp = *parts64_mul(&xnp, &xp, status);
     }
@@ -5504,10 +5419,9 @@ void floatN ## _s390_divide_to_integer(floatN a, floatN b,                     \
                                        uint32_t *cc, int *dxc,                 \
                                        float_status *status)                   \
 {                                                                              \
-    FloatParts64 pa, pb, pr, pn;                                               \
-                                                                               \
-    floatN ## _unpack_canonical(&pa, a, status);                               \
-    floatN ## _unpack_canonical(&pb, b, status);                               \
+    FloatParts64 pa = floatN ## _unpack_canonical(a, status);                  \
+    FloatParts64 pb = floatN ## _unpack_canonical(b, status);                  \
+    FloatParts64 pr, pn;                                                       \
     parts_s390_divide_to_integer(&pa, &pb, final_quotient_rounding_mode,       \
                                  mask_underflow, mask_inexact,                 \
                                  &floatN ## _params,                           \
-- 
2.43.0



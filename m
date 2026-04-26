Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0DEFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjP-0007Sc-Cc; Sun, 26 Apr 2026 09:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjN-0007Qu-A2
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:05 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjK-0008Ty-V1
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:04 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c79467f11abso6277976a12.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210861; x=1777815661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqUVZBGdiF4swkt5DYE6+XQVh3irizfDXygfT+4hhNs=;
 b=uTRncQMOmPFCvwacsuNosN5nTOsWcgsVXMjWVrYfZ1DL/halNUrcCfA8FaJ/u29lyK
 AL59ugLb8HU185IhNjkUkUK4Fkv4qOwly6byVEscTye+ID954VP2Bb24zUBD7OF1FTek
 FJiHt3HqBwi+IuVWdzTXkoWjxmuknhqYasL93Pprbf5agzUpFhRmlJqDmu9zRzm9BhQ5
 A+G0s73ssUS789k973bAh7/XK7m9Gy4FgwQbOihAE5i0/ImxKL4PhLeN4LKof3YMuAOD
 ZVp9JIEE4AWeqUuF7NvX4sW0LSnwMq+3cc8lEKuOWhX5BPqpuo34rzovlQrY7l77KLY4
 tJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210861; x=1777815661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QqUVZBGdiF4swkt5DYE6+XQVh3irizfDXygfT+4hhNs=;
 b=pqV3q+HsWMZm8c5GaWfy/WFmpItjzqY1gEfY4BaaJW+JcSgVqOIuMqi//w9gZY5F8c
 n7N46B5sdr0C/OgtIsHggeKuBpCadmr6veUwxNa9LJSOwaGx4RgOBDrz3GGJtA/oN2CI
 vUBkgGzN2Ee5nIS/7prjYa3Z4p7OXlvIcBTLXBAHwn/gTFHUowe2LE1GGZfT8b300CdU
 RIfBhJswiFPs9BZhD7v3mnaw3D7B5jHM4syt1zrBPcABb5o5SllJUbPftUcMcwpzj1u6
 S9rOeuLPA/jxuzuir9QmjIJi8FmtQfjr3V58aLMxcqIPDxR4Pb6Firjb7RIqCfQ4NdJt
 2rsQ==
X-Gm-Message-State: AOJu0Yy8dfjeb2YAvSMnTqoLU2wN+4NNYdCM9z9YjDDiRxwaltyNitEO
 3px/U0cLS5jHoOm0GdlT9kKdHlT5wDaIrZx42zFQ5XxfU3enF054VrHVxz1HImOrVI88PZHxIEk
 orjMZp10=
X-Gm-Gg: AeBDievjkhZb04yY3Btmii1OHhobFK0zuIj4fd/CyTgwjGw+QQcGj+nrGZHWjCsUJSd
 tnEq/VaCG8A42U+4/WxrnzehdZvo2HbXKJJTIrrB+XERI8c0kKMLVPuUI9FuiI95H2JDv9FARr6
 ATxvZW0NJY32agmzBHmsnqpsCZLl/DJCgVb3geIRhBhg9bv8/4CFx11laGu8wdgiPrltHExfp+k
 9Z8Sxsm7+Ty8oC1HKzBriYLy5lU6ETmoNuUu1+aOUtnmRb/YbdbswvUxUWb15p6Z9UdRdPzy/S1
 d4mB5u2QU34Ciin0AsbZ1vUYjO1OoRqoL6jKEr+JYtGo6hjkio2w4nS/Na7spEQwnPZhTcha/DZ
 n3gVd/VV55A2/RKys99i7ghXx5jMbNgLy+yRSgCSwbikh3w2SNFCx1MyObNMgiLJsX+4NuArSZJ
 oHz2X7ttBrrmC0va4uI4SWJfWsMekn7kBy1VeZFktC
X-Received: by 2002:a17:902:b695:b0:2b2:cfdf:10f2 with SMTP id
 d9443c01a7336-2b5f9f4e6e5mr299530795ad.20.1777210860990; 
 Sun, 26 Apr 2026 06:41:00 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 20/84] fpu: Drop parts_float_to_uint
Date: Sun, 26 Apr 2026 23:38:57 +1000
Message-ID: <20260426134002.865628-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Use parts{64,128}_float_to_uint at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 42ef537e12..869b592cd0 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,16 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static uint64_t parts64_float_to_uint(FloatParts64 *p, FloatRoundMode rmode,
-                                      int scale, uint64_t max,
-                                      float_status *s);
-static uint64_t parts128_float_to_uint(FloatParts128 *p, FloatRoundMode rmode,
-                                       int scale, uint64_t max,
-                                       float_status *s);
-
-#define parts_float_to_uint(P, R, Z, M, S) \
-    PARTS_GENERIC_64_128(float_to_uint, P)(P, R, Z, M, S)
-
 static int64_t parts64_float_to_sint_modulo(FloatParts64 *p,
                                             FloatRoundMode rmode,
                                             int bitsm1, float_status *s);
@@ -3596,7 +3586,7 @@ uint8_t float16_to_uint8_scalbn(float16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT8_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT8_MAX, s);
 }
 
 uint16_t float16_to_uint16_scalbn(float16 a, FloatRoundMode rmode, int scale,
@@ -3605,7 +3595,7 @@ uint16_t float16_to_uint16_scalbn(float16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
 }
 
 uint32_t float16_to_uint32_scalbn(float16 a, FloatRoundMode rmode, int scale,
@@ -3614,7 +3604,7 @@ uint32_t float16_to_uint32_scalbn(float16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 uint64_t float16_to_uint64_scalbn(float16 a, FloatRoundMode rmode, int scale,
@@ -3623,7 +3613,7 @@ uint64_t float16_to_uint64_scalbn(float16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
 uint16_t float32_to_uint16_scalbn(float32 a, FloatRoundMode rmode, int scale,
@@ -3632,7 +3622,7 @@ uint16_t float32_to_uint16_scalbn(float32 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
 }
 
 uint32_t float32_to_uint32_scalbn(float32 a, FloatRoundMode rmode, int scale,
@@ -3641,7 +3631,7 @@ uint32_t float32_to_uint32_scalbn(float32 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 uint64_t float32_to_uint64_scalbn(float32 a, FloatRoundMode rmode, int scale,
@@ -3650,7 +3640,7 @@ uint64_t float32_to_uint64_scalbn(float32 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
 uint16_t float64_to_uint16_scalbn(float64 a, FloatRoundMode rmode, int scale,
@@ -3659,7 +3649,7 @@ uint16_t float64_to_uint16_scalbn(float64 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
 }
 
 uint32_t float64_to_uint32_scalbn(float64 a, FloatRoundMode rmode, int scale,
@@ -3668,7 +3658,7 @@ uint32_t float64_to_uint32_scalbn(float64 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 uint64_t float64_to_uint64_scalbn(float64 a, FloatRoundMode rmode, int scale,
@@ -3677,7 +3667,7 @@ uint64_t float64_to_uint64_scalbn(float64 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
 uint8_t bfloat16_to_uint8_scalbn(bfloat16 a, FloatRoundMode rmode,
@@ -3686,7 +3676,7 @@ uint8_t bfloat16_to_uint8_scalbn(bfloat16 a, FloatRoundMode rmode,
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT8_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT8_MAX, s);
 }
 
 uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, FloatRoundMode rmode,
@@ -3695,7 +3685,7 @@ uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, FloatRoundMode rmode,
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT16_MAX, s);
 }
 
 uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, FloatRoundMode rmode,
@@ -3704,7 +3694,7 @@ uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, FloatRoundMode rmode,
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, FloatRoundMode rmode,
@@ -3713,7 +3703,7 @@ uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, FloatRoundMode rmode,
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
+    return parts64_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
 static uint32_t float128_to_uint32_scalbn(float128 a, FloatRoundMode rmode,
@@ -3722,7 +3712,7 @@ static uint32_t float128_to_uint32_scalbn(float128 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
+    return parts128_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 static uint64_t float128_to_uint64_scalbn(float128 a, FloatRoundMode rmode,
@@ -3731,7 +3721,7 @@ static uint64_t float128_to_uint64_scalbn(float128 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
-    return parts_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
+    return parts128_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
 static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
-- 
2.43.0



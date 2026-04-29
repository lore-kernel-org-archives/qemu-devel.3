Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE3DFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLl-0000OT-VJ; Wed, 29 Apr 2026 18:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLj-0000N1-CF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:43 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLh-00050W-9f
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:43 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-362bb3260f1so143922a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501540; x=1778106340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnqgFo2n96o5/hz/wNbPC/lo1mCwyjcbZvtAcdzySuY=;
 b=zpp0XG5q3nhgWa+nMh7MYqH/Ks7d0ynKXrO6uclsT1coY5AjJ5RbtXvf658O1OGR8n
 zUvWkksHNCbaPeZzWY/AcTRsgpTdhopinVxlvslFEJolaPeGC7Tyy7Q/CAR6EtGrUakg
 LJtGZS96+aVI43FtYO+xs0rtsKM0x7DhRCERgZkKbHIf9LiaW6erJ5BFhuGqQMkHlsq0
 wj1sJ3W4ncV5gD2AzfyXsrnzDBZ/ul6ei0tV9kzrnCMJfjWI2Z8TSJl8155JvBuKkI2/
 XZGgGAHhwHeuF7OiIYxzaz7+ns2i6b5I5NdTLoMEmFie4YOEPLoOUroDZhi6TBIUT0Nh
 cLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501540; x=1778106340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TnqgFo2n96o5/hz/wNbPC/lo1mCwyjcbZvtAcdzySuY=;
 b=QvQc5FVT6rI/fxITWHw66+iT89tg2grcFjAujwjbE5jjJdtPBgeGFZtKfYh9j+47Eg
 qU/SPpIFO5zRYgDtP/Dyz+Q8WqwbF5DeEXUVIDLbiseMn0ZErS3z8yw1BrOheweAGc/U
 Oo+4nzcAJbbzKYrYUzDp2vOlZSvZI1NwN0Sol0ZH8vHIeAVct4hpKlkSUzThsfd6xZQB
 dsEj4K7vpsLreGX6ElKwwXMkjCUebnn7YdX+HPpVF6Pb7uioN7oWqwbJSYTqqhPLjQck
 VE8uIc2D7uStg5q5xofiiz/OXJAEAvYHIxNqIEP0xYUxEsJGRY7z8S/gnRWEUhNcZLVa
 Jjrw==
X-Gm-Message-State: AOJu0YyMTceFZZ6h+m6rfzFAS9kKWKY4XtGKp/33iZqbSHXymqKmYFYI
 LZ7XVjZ2HEIvYVUAMX1rSpF9ZrMSPnP1I+KaSLzuvfs0ZQ6sqqH4FSRrnr9QVid+W4+98Uzm2yX
 6y0c5m9I=
X-Gm-Gg: AeBDieto932FmYdsMdHVtdJKRxhFYkfQiGWxY+j8rewhZw9j2wQag0ysYtro1P2H73A
 fVRoO+XuHQWZlzQPtUInamnw7jefKeW+KNx6BUw5VJKUAYIhxeyeQOAPV79GtCZ4p3iJJ6zzMC5
 s+M/+S8/calpV8BsdhX/VmXLDzXHqdawMqEbdNydBYyaIeuZm1M5DLa3iiVFD5IWMBoMvnHxOPh
 Axt4uTFWdg8FSLRg7xTMmbF2Fhex1IhDYaZYGzUc6QL8XYQsemKtz5lG25w3Lm+YWYGqOcV4x1V
 z8bHnZfOAuM2ufKeg3v4K4jX4P1cTq/r3njnzJGeLoYycFgYPqMPGx4em8ATL4dFNJqn82ngKAD
 2gm0kMXHRLZnr+7p+8s2soeOIJm9f4e2iZQAz+qtXbwCUj9FZYim0hpT8srBQK+yQ3AOFCRAEgQ
 dxYBkpGfaH0XUW+vjHOEdp9ovQEDA9iiqILvuYEmdR
X-Received: by 2002:a17:90b:3d89:b0:35e:d012:5a39 with SMTP id
 98e67ed59e1d1-364c30cb703mr178419a91.14.1777501539898; 
 Wed, 29 Apr 2026 15:25:39 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/48] fpu: Drop parts_float_to_sint
Date: Thu, 30 Apr 2026 08:24:16 +1000
Message-ID: <20260429222445.26301-20-richard.henderson@linaro.org>
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

Use parts{64,128}_float_to_sint at each call site.
Note that there was a duplicate macro redefinition.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 49 ++++++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e2341871bd..42ef537e12 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,16 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static int64_t parts64_float_to_sint(FloatParts64 *p, FloatRoundMode rmode,
-                                     int scale, int64_t min, int64_t max,
-                                     float_status *s);
-static int64_t parts128_float_to_sint(FloatParts128 *p, FloatRoundMode rmode,
-                                     int scale, int64_t min, int64_t max,
-                                     float_status *s);
-
-#define parts_float_to_sint(P, R, Z, MN, MX, S) \
-    PARTS_GENERIC_64_128(float_to_sint, P)(P, R, Z, MN, MX, S)
-
 static uint64_t parts64_float_to_uint(FloatParts64 *p, FloatRoundMode rmode,
                                       int scale, uint64_t max,
                                       float_status *s);
@@ -814,9 +804,6 @@ static void parts64_sint_to_float(FloatParts64 *p, int64_t a,
 static void parts128_sint_to_float(FloatParts128 *p, int64_t a,
                                    int scale, float_status *s);
 
-#define parts_float_to_sint(P, R, Z, MN, MX, S) \
-    PARTS_GENERIC_64_128(float_to_sint, P)(P, R, Z, MN, MX, S)
-
 #define parts_sint_to_float(P, I, Z, S) \
     PARTS_GENERIC_64_128(sint_to_float, P)(P, I, Z, S)
 
@@ -3181,7 +3168,7 @@ int8_t float16_to_int8_scalbn(float16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT8_MIN, INT8_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT8_MIN, INT8_MAX, s);
 }
 
 int16_t float16_to_int16_scalbn(float16 a, FloatRoundMode rmode, int scale,
@@ -3190,7 +3177,7 @@ int16_t float16_to_int16_scalbn(float16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
 int32_t float16_to_int32_scalbn(float16 a, FloatRoundMode rmode, int scale,
@@ -3199,7 +3186,7 @@ int32_t float16_to_int32_scalbn(float16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 int64_t float16_to_int64_scalbn(float16 a, FloatRoundMode rmode, int scale,
@@ -3208,7 +3195,7 @@ int64_t float16_to_int64_scalbn(float16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
 int16_t float32_to_int16_scalbn(float32 a, FloatRoundMode rmode, int scale,
@@ -3217,7 +3204,7 @@ int16_t float32_to_int16_scalbn(float32 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
 int32_t float32_to_int32_scalbn(float32 a, FloatRoundMode rmode, int scale,
@@ -3226,7 +3213,7 @@ int32_t float32_to_int32_scalbn(float32 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 int64_t float32_to_int64_scalbn(float32 a, FloatRoundMode rmode, int scale,
@@ -3235,7 +3222,7 @@ int64_t float32_to_int64_scalbn(float32 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
 int16_t float64_to_int16_scalbn(float64 a, FloatRoundMode rmode, int scale,
@@ -3244,7 +3231,7 @@ int16_t float64_to_int16_scalbn(float64 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
 int32_t float64_to_int32_scalbn(float64 a, FloatRoundMode rmode, int scale,
@@ -3253,7 +3240,7 @@ int32_t float64_to_int32_scalbn(float64 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 int64_t float64_to_int64_scalbn(float64 a, FloatRoundMode rmode, int scale,
@@ -3262,7 +3249,7 @@ int64_t float64_to_int64_scalbn(float64 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
 int8_t bfloat16_to_int8_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
@@ -3271,7 +3258,7 @@ int8_t bfloat16_to_int8_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT8_MIN, INT8_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT8_MIN, INT8_MAX, s);
 }
 
 int16_t bfloat16_to_int16_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
@@ -3280,7 +3267,7 @@ int16_t bfloat16_to_int16_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
 int32_t bfloat16_to_int32_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
@@ -3289,7 +3276,7 @@ int32_t bfloat16_to_int32_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 int64_t bfloat16_to_int64_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
@@ -3298,7 +3285,7 @@ int64_t bfloat16_to_int64_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
+    return parts64_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
 static int32_t float128_to_int32_scalbn(float128 a, FloatRoundMode rmode,
@@ -3307,7 +3294,7 @@ static int32_t float128_to_int32_scalbn(float128 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
+    return parts128_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 static int64_t float128_to_int64_scalbn(float128 a, FloatRoundMode rmode,
@@ -3316,7 +3303,7 @@ static int64_t float128_to_int64_scalbn(float128 a, FloatRoundMode rmode,
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
-    return parts_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
+    return parts128_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
 static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
@@ -3382,7 +3369,7 @@ static int32_t floatx80_to_int32_scalbn(floatx80 a, FloatRoundMode rmode,
     if (!floatx80_unpack_canonical(&p, a, s)) {
         parts128_default_nan(&p, s);
     }
-    return parts_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
+    return parts128_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 static int64_t floatx80_to_int64_scalbn(floatx80 a, FloatRoundMode rmode,
@@ -3393,7 +3380,7 @@ static int64_t floatx80_to_int64_scalbn(floatx80 a, FloatRoundMode rmode,
     if (!floatx80_unpack_canonical(&p, a, s)) {
         parts128_default_nan(&p, s);
     }
-    return parts_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
+    return parts128_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
 int8_t float16_to_int8(float16 a, float_status *s)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5673BFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjN-0007R0-Nk; Sun, 26 Apr 2026 09:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjL-0007PC-H4
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:03 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjH-0008TR-TX
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:03 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3590042fa8eso7174446a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210858; x=1777815658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPi8eqP8Ow9+sh4tCETdF2+qkNwPmbuMnr/uQ+0ZhR0=;
 b=u7pS/fPKzgpnm8pXq0UMT9JaQyyd472w8o1zKp7haLNmqhXCa8Y9e/JIDIrM64FzYi
 EV/2DnPfdoyvkGaPJdwm/ZgszH3+xZjKhLZjySe7SYrQng12KqNHPtmOt60I26cAGrIU
 j8yifazGR5u5bK17UFxOuf2BOgiPl5D+PLqyfWMPsdFl/YYJ8uWmFQEUPrWTU4bwBR3J
 oP3xpI/qG2WZHC5ZL9kIXy2A6L2o7QSaVUDNdxC3AkzURhu5QV4x+tGYP4aP+gbTYc0H
 gIuQEuYzxnccLQYu/nd7iy0PLAVOmnQeF1dLXhe9s37TYdtjWbQoTqQKLTboD9DqLETi
 4WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210859; x=1777815659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RPi8eqP8Ow9+sh4tCETdF2+qkNwPmbuMnr/uQ+0ZhR0=;
 b=ep5ySlqcntc9NrMEMQT2K+qXJ8nwUTNFFwARmeS1YNZ79GLMwzdx7iG7z2AETiCdMb
 zRirL1boG1VNUUFeeMZQxW/vSZUzUugLxG4Lpr2xX6G4IuSQEz00/Z45J1D/8rqcSVav
 VpzBHfbAj5anQ4OqV+TkDeIYeEz9Ru3L55qd67CrS3PS/q0IX7pOmGbe7BYiuzEa/QMT
 H015T5UnKA+5f/zXOn7b0UjIUKcspJwqH+T45csNMLKvBydF21+YpkrGqxYdtrYKvzLc
 G5HrybUweSkRpV1HbOHPNVSHnQ1JsJode/ZBiqG4YqScjCSOnFBbq7KK5Wn+8eJMzk3L
 Y01A==
X-Gm-Message-State: AOJu0Yx8HgouV34u5NTf95/yMnfjFZwZG5RSwi/WWgygn7yFFgUkSAfC
 oJed6yi9Y3imGaNzSPHYt3D4BXD4dFCuAtZBbyRnWUrZEO+NF71Ca57xPlbl1zCS+v1j6YvyPQS
 bKE3CNgw=
X-Gm-Gg: AeBDiet5vEh2tC0WQo52uNekh+fn3gpaclw7k34aXXYMm7fc4OQmGYdrU5zPuh3xBxg
 v+ailJ7XZZD8lYDTPgIx0nZBed40hDCfRzJeTtrUKu4BKZnibM9dPj4nj5s6+Yd6YxMduADdI0u
 WTsVzEIdmALnGz5JxABcOg1U8Gt0CsZ3vzZkZL2ynJ4D1n50FVvtljxairwc9DqnLd1k796VNyf
 w4W4hOXLRCMfs9bPIRVZ+tOjAT1Ip3LK8LMj4iXi/PPbCJKgmy+V1scV7VzsCKazmDeddY2zopD
 VAuik0UxkNAjxIABsrB7OtUKh+H3t9Mg1dsTY//yAEcYQHurACLGQ2oJlp6jg0e9mkEanPyf5Yb
 VfuACxF073Lyk51YIF4ar3rKa7yR8OnksYsptBHA+oiCDXLiSDOo7j7fJZ04JHTtBZfv9TfAZ3Y
 DbRBPwvRAO4CyzhiLkbGjcwCeUXZFtMdKWFahGE43E5uRwCHtc0W8=
X-Received: by 2002:a17:903:1a88:b0:2b2:5ec6:dcf6 with SMTP id
 d9443c01a7336-2b5f9e85f20mr401989715ad.8.1777210858434; 
 Sun, 26 Apr 2026 06:40:58 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 19/84] fpu: Drop parts_float_to_sint
Date: Sun, 26 Apr 2026 23:38:56 +1000
Message-ID: <20260426134002.865628-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Use parts{64,128}_float_to_sint at each call site.
Note that there was a duplicate macro redefinition.

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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95777CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLn-0000Om-CD; Wed, 29 Apr 2026 18:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLm-0000OW-7M
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:46 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLk-00052r-3G
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:45 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so264703a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501542; x=1778106342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkY6y2QwlgEZaR7GYvmrCRyKHQoVrH7Yh5h4fvSE73U=;
 b=y4Zt8A6dWCGHk9RWdgaa3+lOecPR8opr/xQynKc3TDvE4498dPzWuDO7HzVSXPbXp3
 T9oVObO865tAnRr56J1FYJh3GfskYzIL/dd+2cmwPYVo9wweo258iKKm7/wUq3cEB1TT
 2IoWsZkD+hnycgZOmSgC5aEUiomGmD5DjCWqwKVc6fXhUhssra7KS0UHA3EDjPI1h1JA
 qxtDH6TAfRYcSs6j0Rkuuh4esYAe1+vIO7SyPz8jkFv/npDYCtMgPVKi3b7lAXA9P+qI
 PPDWE3oFj1NY4K+kIdqpAUXSHZOQ7yH2iNzyTb7GC6YAarDYpLRC0/SmN7CWtsiCPvQL
 jCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501542; x=1778106342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wkY6y2QwlgEZaR7GYvmrCRyKHQoVrH7Yh5h4fvSE73U=;
 b=rlcvQ5w2ufoTAHKvtRCl6SAcKZdFrQ77ndN/oTNvyFCvG4H0vCB7Q7dB1hWlpKgqLq
 nOkIr/kSTFC5Y9xpaJE0uqYEi/u5geL+Vkjn4h+epXGyK7IvaAlgi8gKhZbe9cgiIZjA
 cu3002Xwgz9b0CxBAfauoa55uB1Oy3roq7dhdJ87vb6jDHNxrB48grwztOOxttKIBiCw
 QiiOLZVcRavrOgkBSftEfa35TKbFhX9+d0q3lhkEFDW+bdGfhBVAQBUZIqD0lmh1nV6X
 hUGHkInpe5TZvThg2Ibfy4twHPgAnHRj+YW8pO2qXb5/MkNtTLAZ4lPvCK39kw1ZiItq
 G7RQ==
X-Gm-Message-State: AOJu0YydJGVJR7zjGzcCKKxv9FJWRZliUQIKYrXp2P0CTZhkcjdH+c36
 88NORxqE0G6t9nV+PGi1SGNmi6fjiso514YWkbJZ2q/M+MfZM6ihn6IqGDjWomegA49H3WN4Ujn
 LNkK7wxo=
X-Gm-Gg: AeBDiet99IDH09poifIjLMYxhbWOGh/9uY4x5QjDXY0B0k+UPrne7wMoQd5RxdIGrVr
 hG3QWqVG/aKkCVZ7EwKsM1xR/7rx0yI27tQyXDjs9pYP6aSt1M+LVXfNCDe70g8n75EN967X2Oc
 nQXDP630feVNbQScw2AUO95M4EoZz5r9MClgCVUDH9iQRW7eV80fXJsbha9IKNotGi6XY6bUUmB
 dr0j5FukX5/wRShZNM+3yaJW+RGS8gX4hqfC8PZw5yOzsNnxRDAvoohMxYILqejswIKv/Apcpc4
 Ei08mXjhX44ieBp3IRe/B2MDd1QygtO1Vum2deUIQjtaj+MSKfG58GlRAUiBg/348whITQxNtrn
 dt0O8QxpENVXUmI+VIceFmRaNS1RtpGBL8/KTljyy/KsE+f2iMj5fjmXOiKSKz3PtZuXH79FJ5y
 s4C5jznpoP0YXP5W0SZPFk4nyFA3dE91RpW2q+uW3b
X-Received: by 2002:a17:90b:37c6:b0:364:8f64:49ea with SMTP id
 98e67ed59e1d1-364c310e563mr170408a91.27.1777501542459; 
 Wed, 29 Apr 2026 15:25:42 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/48] fpu: Drop parts_float_to_uint
Date: Thu, 30 Apr 2026 08:24:17 +1000
Message-ID: <20260429222445.26301-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Use parts{64,128}_float_to_uint at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



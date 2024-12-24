Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEEEE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBE2-0002GU-P2; Tue, 24 Dec 2024 15:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDe-0007Rc-UB
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:31 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDc-00030L-Fw
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:30 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2161eb95317so58726815ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070967; x=1735675767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTkbR01xtg3cDFd0zyp26LRPzyNskPHkgWCn6SCa0AE=;
 b=I48sZ0fa0E6WgeRWAJUJ9ayu5wg2OiF8jY2rhPLjBf0ixPyqICXd+oye8dgYPkOykk
 RnIWHYzKGwjq5t/0egSyQNHdInJjngpp9EkoPmOf3U3GAh4dnoa8Zm3egDnefGSYSHKv
 lrZx5xVSc28ir3HQXPudeP/WOQw7QUUl3V8DKX2ajQqzB5TPlcRgK3Qs30Iu9JWIX3rT
 ejHLBkTegQzsfGk4BY7AlBHAKYDF2FZV5OzjrES9POnfiP7zRkO0LDcuXlQ+Qk18YrUu
 V38qymSeUVRYITNJj6f3V3nLxgD8HF3c7quy4TukEuHhPfjE682Rn1WgTmwzbKAzU7Fc
 bjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070967; x=1735675767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTkbR01xtg3cDFd0zyp26LRPzyNskPHkgWCn6SCa0AE=;
 b=ON2dbLb3MvSoC/3I53bhX6769ydzOKqGnlb4tZHFluTu/kvWX2W2UOXQjEsPDasO/A
 7TCthvtX4FH8ShIlouxg7FM10IvCJtqJ9napyi7ut+IMfNj2519EJda1INXUTVmFTWvN
 cnE3aOxIFmuyuWgeQ9+OnS3urMPcqdCf9MaWnMw9XAszyai1MpBpDGvh6sYBBgAJhpQT
 +Zpiq7TX9A2oTCnJPDgCD1ZhtSVs3hWBm0WCLP+MV4QEaA7UoqvsT3S79VqQXZu9z4WW
 pW7IkdMmjbYOkWAIxPcAed3gixlXQcJjre/SESjvOf7h1QjBiq8nlokkvoVVljJKVR8f
 168Q==
X-Gm-Message-State: AOJu0YzRLPyoGEWpLPIWQH35/IQjUFDL3aeXOdbMjiJGS//0LtP+8LKW
 lkLNF0siPMETUaPmEcbyTWEiPs5SQOmETfr7q0K4AVnF6OeOT5ZOTSYzTu5xDo50oWNSDYwg8UW
 Lq3U=
X-Gm-Gg: ASbGncuDcta8kgEdZPAjMGrhQ4YdnaTISr4lGQS6NtCYHNPR+qDsoP9ee2TMnaMBMSt
 G+2M66Zl9JMR1hhOi840F7UYoNUEZ1Q0fYxFmizwopJMDtvvWIvDSszK7rWIM+mTjoqCWWLLORX
 75li3m/iIsXGuMIwwO5PUhLhjGm3wBpnWBc66qNuBKOWIBKXBsossCmkTyPblPjnu6byTcisOMq
 85nw/6ENLeYM8XUh8WMRV1/oRpD4oanzpE51purTRMa4rARcGWcRHQmjhQpSlGURvOdlqcdhBGS
 EfMGs4u+hwSUGTT9fmakYffc3g==
X-Google-Smtp-Source: AGHT+IHlgMGlXIvO07w0oWufQLrdbGA2bPMq6EX7uvx79Dbz9wWz+y78ypyHiSEKplDmmsJKpNYrBg==
X-Received: by 2002:a05:6a21:900e:b0:1db:ec0f:5cf4 with SMTP id
 adf61e73a8af0-1e5e081c8bbmr27968235637.39.1735070967175; 
 Tue, 24 Dec 2024 12:09:27 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 67/72] target/hexagon: Expand GEN_XF_ROUND
Date: Tue, 24 Dec 2024 12:05:16 -0800
Message-ID: <20241224200521.310066-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
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

This massive macro is now only used once.
Expand it for use only by float64.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 255 +++++++++++++++++++--------------------
 1 file changed, 127 insertions(+), 128 deletions(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 0c7c7f636c..0769de43de 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -354,136 +354,135 @@ float32 infinite_float32(uint8_t sign)
 }
 
 /* Return a maximum finite value with the requested sign */
-#define GEN_XF_ROUND(SUFFIX, MANTBITS, INF_EXP, INTERNAL_TYPE) \
-static SUFFIX accum_round_##SUFFIX(Accum a, float_status * fp_status) \
-{ \
-    if ((int128_gethi(a.mant) == 0) && (int128_getlo(a.mant) == 0) \
-        && ((a.guard | a.round | a.sticky) == 0)) { \
-        /* result zero */ \
-        switch (fp_status->float_rounding_mode) { \
-        case float_round_down: \
-            return zero_##SUFFIX(1); \
-        default: \
-            return zero_##SUFFIX(0); \
-        } \
-    } \
-    /* Normalize right */ \
-    /* We want MANTBITS bits of mantissa plus the leading one. */ \
-    /* That means that we want MANTBITS+1 bits, or 0x000000000000FF_FFFF */ \
-    /* So we need to normalize right while the high word is non-zero and \
-    * while the low word is nonzero when masked with 0xffe0_0000_0000_0000 */ \
-    while ((int128_gethi(a.mant) != 0) || \
-           ((int128_getlo(a.mant) >> (MANTBITS + 1)) != 0)) { \
-        a = accum_norm_right(a, 1); \
-    } \
-    /* \
-     * OK, now normalize left \
-     * We want to normalize left until we have a leading one in bit 24 \
-     * Theoretically, we only need to shift a maximum of one to the left if we \
-     * shifted out lots of bits from B, or if we had no shift / 1 shift sticky \
-     * should be 0  \
-     */ \
-    while ((int128_getlo(a.mant) & (1ULL << MANTBITS)) == 0) { \
-        a = accum_norm_left(a); \
-    } \
-    /* \
-     * OK, now we might need to denormalize because of potential underflow. \
-     * We need to do this before rounding, and rounding might make us normal \
-     * again \
-     */ \
-    while (a.exp <= 0) { \
-        a = accum_norm_right(a, 1 - a.exp); \
-        /* \
-         * Do we have underflow? \
-         * That's when we get an inexact answer because we ran out of bits \
-         * in a denormal. \
-         */ \
-        if (a.guard || a.round || a.sticky) { \
-            float_raise(float_flag_underflow, fp_status); \
-        } \
-    } \
-    /* OK, we're relatively canonical... now we need to round */ \
-    if (a.guard || a.round || a.sticky) { \
-        float_raise(float_flag_inexact, fp_status); \
-        switch (fp_status->float_rounding_mode) { \
-        case float_round_to_zero: \
-            /* Chop and we're done */ \
-            break; \
-        case float_round_up: \
-            if (a.sign == 0) { \
-                a.mant = int128_add(a.mant, int128_one()); \
-            } \
-            break; \
-        case float_round_down: \
-            if (a.sign != 0) { \
-                a.mant = int128_add(a.mant, int128_one()); \
-            } \
-            break; \
-        default: \
-            if (a.round || a.sticky) { \
-                /* round up if guard is 1, down if guard is zero */ \
-                a.mant = int128_add(a.mant, int128_make64(a.guard)); \
-            } else if (a.guard) { \
-                /* exactly .5, round up if odd */ \
-                a.mant = int128_add(a.mant, int128_and(a.mant, int128_one())); \
-            } \
-            break; \
-        } \
-    } \
-    /* \
-     * OK, now we might have carried all the way up. \
-     * So we might need to shr once \
-     * at least we know that the lsb should be zero if we rounded and \
-     * got a carry out... \
-     */ \
-    if ((int128_getlo(a.mant) >> (MANTBITS + 1)) != 0) { \
-        a = accum_norm_right(a, 1); \
-    } \
-    /* Overflow? */ \
-    if (a.exp >= INF_EXP) { \
-        /* Yep, inf result */ \
-        float_raise(float_flag_overflow, fp_status); \
-        float_raise(float_flag_inexact, fp_status); \
-        switch (fp_status->float_rounding_mode) { \
-        case float_round_to_zero: \
-            return maxfinite_##SUFFIX(a.sign); \
-        case float_round_up: \
-            if (a.sign == 0) { \
-                return infinite_##SUFFIX(a.sign); \
-            } else { \
-                return maxfinite_##SUFFIX(a.sign); \
-            } \
-        case float_round_down: \
-            if (a.sign != 0) { \
-                return infinite_##SUFFIX(a.sign); \
-            } else { \
-                return maxfinite_##SUFFIX(a.sign); \
-            } \
-        default: \
-            return infinite_##SUFFIX(a.sign); \
-        } \
-    } \
-    /* Underflow? */ \
-    if (int128_getlo(a.mant) & (1ULL << MANTBITS)) { \
-        /* Leading one means: No, we're normal. So, we should be done... */ \
-        INTERNAL_TYPE ret; \
-        ret.i = 0; \
-        ret.sign = a.sign; \
-        ret.exp = a.exp; \
-        ret.mant = int128_getlo(a.mant); \
-        return ret.i; \
-    } \
-    assert(a.exp == 1); \
-    INTERNAL_TYPE ret; \
-    ret.i = 0; \
-    ret.sign = a.sign; \
-    ret.exp = 0; \
-    ret.mant = int128_getlo(a.mant); \
-    return ret.i; \
+static float64 accum_round_float64(Accum a, float_status *fp_status)
+{
+    if ((int128_gethi(a.mant) == 0) && (int128_getlo(a.mant) == 0)
+        && ((a.guard | a.round | a.sticky) == 0)) {
+        /* result zero */
+        switch (fp_status->float_rounding_mode) {
+        case float_round_down:
+            return zero_float64(1);
+        default:
+            return zero_float64(0);
+        }
+    }
+    /*
+     * Normalize right
+     * We want DF_MANTBITS bits of mantissa plus the leading one.
+     * That means that we want DF_MANTBITS+1 bits, or 0x000000000000FF_FFFF
+     * So we need to normalize right while the high word is non-zero and
+     * while the low word is nonzero when masked with 0xffe0_0000_0000_0000
+     */
+    while ((int128_gethi(a.mant) != 0) ||
+           ((int128_getlo(a.mant) >> (DF_MANTBITS + 1)) != 0)) {
+        a = accum_norm_right(a, 1);
+    }
+    /*
+     * OK, now normalize left
+     * We want to normalize left until we have a leading one in bit 24
+     * Theoretically, we only need to shift a maximum of one to the left if we
+     * shifted out lots of bits from B, or if we had no shift / 1 shift sticky
+     * should be 0
+     */
+    while ((int128_getlo(a.mant) & (1ULL << DF_MANTBITS)) == 0) {
+        a = accum_norm_left(a);
+    }
+    /*
+     * OK, now we might need to denormalize because of potential underflow.
+     * We need to do this before rounding, and rounding might make us normal
+     * again
+     */
+    while (a.exp <= 0) {
+        a = accum_norm_right(a, 1 - a.exp);
+        /*
+         * Do we have underflow?
+         * That's when we get an inexact answer because we ran out of bits
+         * in a denormal.
+         */
+        if (a.guard || a.round || a.sticky) {
+            float_raise(float_flag_underflow, fp_status);
+        }
+    }
+    /* OK, we're relatively canonical... now we need to round */
+    if (a.guard || a.round || a.sticky) {
+        float_raise(float_flag_inexact, fp_status);
+        switch (fp_status->float_rounding_mode) {
+        case float_round_to_zero:
+            /* Chop and we're done */
+            break;
+        case float_round_up:
+            if (a.sign == 0) {
+                a.mant = int128_add(a.mant, int128_one());
+            }
+            break;
+        case float_round_down:
+            if (a.sign != 0) {
+                a.mant = int128_add(a.mant, int128_one());
+            }
+            break;
+        default:
+            if (a.round || a.sticky) {
+                /* round up if guard is 1, down if guard is zero */
+                a.mant = int128_add(a.mant, int128_make64(a.guard));
+            } else if (a.guard) {
+                /* exactly .5, round up if odd */
+                a.mant = int128_add(a.mant, int128_and(a.mant, int128_one()));
+            }
+            break;
+        }
+    }
+    /*
+     * OK, now we might have carried all the way up.
+     * So we might need to shr once
+     * at least we know that the lsb should be zero if we rounded and
+     * got a carry out...
+     */
+    if ((int128_getlo(a.mant) >> (DF_MANTBITS + 1)) != 0) {
+        a = accum_norm_right(a, 1);
+    }
+    /* Overflow? */
+    if (a.exp >= DF_INF_EXP) {
+        /* Yep, inf result */
+        float_raise(float_flag_overflow, fp_status);
+        float_raise(float_flag_inexact, fp_status);
+        switch (fp_status->float_rounding_mode) {
+        case float_round_to_zero:
+            return maxfinite_float64(a.sign);
+        case float_round_up:
+            if (a.sign == 0) {
+                return infinite_float64(a.sign);
+            } else {
+                return maxfinite_float64(a.sign);
+            }
+        case float_round_down:
+            if (a.sign != 0) {
+                return infinite_float64(a.sign);
+            } else {
+                return maxfinite_float64(a.sign);
+            }
+        default:
+            return infinite_float64(a.sign);
+        }
+    }
+    /* Underflow? */
+    if (int128_getlo(a.mant) & (1ULL << DF_MANTBITS)) {
+        /* Leading one means: No, we're normal. So, we should be done... */
+        Double ret;
+        ret.i = 0;
+        ret.sign = a.sign;
+        ret.exp = a.exp;
+        ret.mant = int128_getlo(a.mant);
+        return ret.i;
+    }
+    assert(a.exp == 1);
+    Double ret;
+    ret.i = 0;
+    ret.sign = a.sign;
+    ret.exp = 0;
+    ret.mant = int128_getlo(a.mant);
+    return ret.i;
 }
 
-GEN_XF_ROUND(float64, DF_MANTBITS, DF_INF_EXP, Double)
-
 float64 internal_mpyhh(float64 a, float64 b,
                       unsigned long long int accumulated,
                       float_status *fp_status)
-- 
2.43.0



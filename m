Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC98E7717F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5L-0007Ch-LS; Sun, 08 Dec 2024 17:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5J-0007C4-Kl
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:05 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5H-0006Ff-KV
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:05 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71de7b9d4f4so246415a34.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698142; x=1734302942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Y0A1gv0BAn4m7bTh6rSrOLuj4Co5Ym2ALez6VlQLvI=;
 b=i+R0P7fwZfPHtkIn/zDQGhjrks9GVMg5sABNAQ5U3e2Ac2XkGzwNv4ncpIiMNuX7RY
 5RtLlNflTHyINMdDBEM1zjUp9tjWYBBmLNUE5KJFz8DdTczHIdIDd0J0Xhh4qp+89K7U
 XoOwWPLgMDRH32ThwdHMBPtrDbFY8N0nqwbNB1N+dBL67U+Fo3d3bO9PWdjuFSMVWmqR
 7iFoU3nw7/A8g3u9rUYYMYp5uOOMk/M4SsAjckNirKSuRult4MNmppfff9osUKKjJ6TU
 5Yc6SfwgCYmLE5MTiDfJumSsKLN9DsLhfR5A+mUGibJuk2Xgm7s9XLQUQ3aDpHRB9buK
 U8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698142; x=1734302942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Y0A1gv0BAn4m7bTh6rSrOLuj4Co5Ym2ALez6VlQLvI=;
 b=xH8dRsy+ve7oxCM/p6OqnVtKSruByONjyBEZ47T1uX7nl+vxZkYtlR+qqypatxRtlK
 q9DWsyNTZA6+D4VOvBubLwaZu3qhAnu0aQY9jVTW2lCughjYP66aWKE1yApO/8tngpZL
 c5kLWoSvQc4Z6cYw1mc/Isl7F90PK5hFTH8isCf9rSl/k5aBMr/3E/Hk3HCINpCXGv57
 axk4YefC+a8IFQNeBWTmDC6VLAatByo/tJXZOs2cn6H5v5r9z235xurXgt1zTxiG11lN
 +c4vfP9YudixO3xOOqy6LKtUeuvO378IsLzAAMo+vjmdrQrQuSWTjbDo8oh7R1XoFF8T
 AmWA==
X-Gm-Message-State: AOJu0Yzo/ZMCClz1D6wH1t9jVpQLp/eCedsSRvV7D33RNJXKIf7nIjM7
 CNypVoric82BhnT1kEMG+eTMqOhrcScCHiasgOnY3j7LG5g5DX5nYM9+kOJyGNtTO45fIbHwZ1o
 E6kBbYg==
X-Gm-Gg: ASbGncvhK/sk0qvz6tNYPPlu6fbA/TgPtv/XQao8phdbL7wRV8zxKe9Vj9ZLMl/tNQI
 88dpmRUxOrtEZ3c8nsCIUYIM+pstiRiNELbJsA6YFYFmT1Vf/OdZY9Iyh1rl6hFVbnGo4bp+s5x
 0A5080uf0k4uoKfjoAzSYV+kQ7SpilpCOJvbqxstXOsCTeqJ+QWxTRbI3pUSe4hrhyj/o7asPEh
 +X7LUtiuJDymC0OZbX71gfw36Y1qGm/X20EElTouF2EfXLZijGum3FcDV17AsHHAEdc062ucSNH
 vxzWWtnvFkcLHFFyY71sxzMQC4MHJYPN0qDx
X-Google-Smtp-Source: AGHT+IGUVzw1oRp4ehl01bFZPiekHomE6JS6GZP7zB44IpYnOhITU6Zj/CCvFws497tk4xMukUpOUw==
X-Received: by 2002:a05:6808:3012:b0:3e8:1ed7:e6cf with SMTP id
 5614622812f47-3eb19c004aamr5545414b6e.7.1733698142464; 
 Sun, 08 Dec 2024 14:49:02 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:49:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 13/17] target/hexagon: Expand GEN_XF_ROUND
Date: Sun,  8 Dec 2024 16:48:40 -0600
Message-ID: <20241208224844.570491-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 253 +++++++++++++++++++--------------------
 1 file changed, 125 insertions(+), 128 deletions(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 0c7c7f636c..bce3bd4dfb 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -354,136 +354,133 @@ float32 infinite_float32(uint8_t sign)
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
+static float64 accum_round_float64(Accum a, float_status * fp_status)
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
+    /* Normalize right */
+    /* We want DF_MANTBITS bits of mantissa plus the leading one. */
+    /* That means that we want DF_MANTBITS+1 bits, or 0x000000000000FF_FFFF */
+    /* So we need to normalize right while the high word is non-zero and
+    * while the low word is nonzero when masked with 0xffe0_0000_0000_0000 */
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



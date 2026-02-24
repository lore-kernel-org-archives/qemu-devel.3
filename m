Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72684EFB800
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vulDq-0003nF-Kq; Tue, 24 Feb 2026 00:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulDo-0003mp-Ko
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:36 -0500
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulDm-0002I2-He
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:36 -0500
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso5110095eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 21:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771911873; x=1772516673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jL1s5SV3cubFpJlsGLlbrnPoja1OfqVMQ1g/z28whqY=;
 b=DvSXl3uddlyIfTVGdrHsG4N6KxCdPkk2/2q3EOLVQeU6amqHwiVSqZFYMqcFlwwcmx
 hX1BxI+/H8+5agBSFFAiHfSsocsMqTKotq2FeZs+IKGArhNdNl+Id6IUEAft0IxficwD
 pn6k+58ZUV38LN08NnxUBenlLVaIbMhEl/94lBQIjMsTcC4p+lRCG3a+27y7L4Yi+3OB
 LsRaXD4FmNCiwf3PripdQl0zMaIviibJ1p2XE2r2tb0JK4OyMuHYHP5d292RxnbnUJ2F
 AIqBGDLs0qHxOwKXyzX4VnlT6QFeoLsy2C+IR26rbT1TM86YpHDdI1T5SD8ay+MBrH8Y
 +CjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771911873; x=1772516673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jL1s5SV3cubFpJlsGLlbrnPoja1OfqVMQ1g/z28whqY=;
 b=izm7ajbuCeLTBc0OYUUGMVnEDy+VehlDIvtk8djTuVDD/pIYiFC4NLhoK8PF5uDYf3
 K/vP6iNgx2auG8zmv7CIq6JRP6WSFioJpdQkuRODWgfJ/fN1cabG+tVbKH1LKsmauBMl
 UvmbOycs+CppJxcpyw8CLJH2+fOjYuXXaV9wofrkZpdt0qTuQlGLQKCUfAY94xUIBJZr
 GJ1qqnnyEm36/SOqHJpoOVTUgFxEAIQUeHBBtZ3kAb8uSf2OCv5BLd6IBY9JApkEXAqJ
 BoZp2P5pRvIep1DZZxct8NX4Mj2hwUtGgEA9sovjBpW99/rDOJlCmQwLLfZRcNC8tVWu
 37zQ==
X-Gm-Message-State: AOJu0Yw4j6WQ1XkHrtlvIfqE6mnX2g15H/QvDTWkz6Z/3eDJwtkVM1s7
 77zJe420rrjv7vzeXS0xc8tY09dryvfeER+wv82zzQBC9nZan5Ndydm0N4cRWP/bYUrmGVO1ev1
 OSRD0j2Tjrw==
X-Gm-Gg: ATEYQzwsP+mFHJT+pdyIpyah5AkOubj3vbgvqE7VEK+T4jyL3aVzYzcMOBUVhKr1caU
 4Bx0Wqxu+snOPvDWZzT4hAm3e6fXnPscnb4V7YOb+kDZYuZoTUhVVDLUjeE3LW6txZJJCC5hit6
 8JVrAR/f4xRn7kmI0IpCQdaHTjzt7CLmmFgZjbdUB3J/NLdqrTPrviNbFgOhcUTDBWc3lnk1nu5
 SmOtXYu78praALpYjpNIsGvUE53Aln/3d2OjImssjbBpUTO3UW0fPn742MEsAafC46VJ8lMGjBT
 FHg+FZJJydoWXjSwnD5TP8N7xW97xXxT7AzZc2EPefkiUIVJ0Ox2JajsXHFQwZMCM/tAPYd+GUk
 iOeSyztERmlqAnyDQQL39L4rz7wPEpcFYYHYPdEwkEfK/pwbpSwPq5RtT6k+efWWGAvdg72oToa
 50WNC5S1+SQWNLXrKIiq6k/qq/bOW6Ldh5I81bZsf4m+jrGiJ1EheF
X-Received: by 2002:a05:693c:2c17:b0:2ba:8aa8:9bd4 with SMTP id
 5a478bee46e88-2bd7b9d54a1mr4046033eec.5.1771911872771; 
 Mon, 23 Feb 2026 21:44:32 -0800 (PST)
Received: from stoup.. ([172.56.177.223]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa37c7sm5958093eec.12.2026.02.23.21.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 21:44:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 1/9] fpu/softfloat: Refactor IEEE format NaN classification to
 share code
Date: Tue, 24 Feb 2026 16:44:09 +1100
Message-ID: <20260224054417.32430-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224054417.32430-1-richard.henderson@linaro.org>
References: <20260224054417.32430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x1341.google.com
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

The floatN_is_[quiet|signaling]_nan functions for following formats
(float16, bfloat16, float32, float64, float128) contain duplicated
logic that should be shared.
This commit introduces
[float16|bfloat16|float32|float64|float128]_nan_is_snan that determine
if a NaN is signaling.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260204051756.667397-3-max.chou@sifive.com>
---
 fpu/softfloat-specialize.c.inc | 192 ++++++++++++++-------------------
 1 file changed, 80 insertions(+), 112 deletions(-)

diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index ba4fa08b7b..7d2515c1fa 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -226,6 +226,19 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
     return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
 }
 
+/*----------------------------------------------------------------------------
+| Determine if a float16 NaN is signaling NaN.
+*----------------------------------------------------------------------------*/
+
+static bool float16_nan_is_snan(float16 a, float_status *status)
+{
+    if (no_signaling_nans(status)) {
+        return false;
+    }
+    bool frac_msb_is_one = (a >> 9) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the half-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -233,36 +246,7 @@ floatx80 floatx80_default_inf(bool zSign, float_status *status)
 
 bool float16_is_quiet_nan(float16 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float16_is_any_nan(a_);
-    } else {
-        uint16_t a = float16_val(a_);
-        if (snan_bit_is_one(status)) {
-            return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
-        } else {
-
-            return ((a >> 9) & 0x3F) == 0x3F;
-        }
-    }
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the bfloat16 value `a' is a quiet
-| NaN; otherwise returns 0.
-*----------------------------------------------------------------------------*/
-
-bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
-{
-    if (no_signaling_nans(status)) {
-        return bfloat16_is_any_nan(a_);
-    } else {
-        uint16_t a = a_;
-        if (snan_bit_is_one(status)) {
-            return (((a >> 6) & 0x1FF) == 0x1FE) && (a & 0x3F);
-        } else {
-            return ((a >> 6) & 0x1FF) == 0x1FF;
-        }
-    }
+    return float16_is_any_nan(a_) && !float16_nan_is_snan(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -272,35 +256,51 @@ bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
 
 bool float16_is_signaling_nan(float16 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint16_t a = float16_val(a_);
-        if (snan_bit_is_one(status)) {
-            return ((a >> 9) & 0x3F) == 0x3F;
-        } else {
-            return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
-        }
-    }
+    return float16_is_any_nan(a_) && float16_nan_is_snan(a_, status);
 }
 
 /*----------------------------------------------------------------------------
-| Returns 1 if the bfloat16 value `a' is a signaling
-| NaN; otherwise returns 0.
+| Determine if a bfloat16 NaN is signaling NaN.
+*----------------------------------------------------------------------------*/
+
+static bool bfloat16_nan_is_snan(bfloat16 a, float_status *status)
+{
+    if (no_signaling_nans(status)) {
+        return false;
+    }
+    bool frac_msb_is_one = (a >> 6) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the bfloat16 value `a' is a quiet NaN; otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+bool bfloat16_is_quiet_nan(bfloat16 a_, float_status *status)
+{
+    return bfloat16_is_any_nan(a_) && !bfloat16_nan_is_snan(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns 1 if the bfloat16 value `a' is a signaling NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
 bool bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
+{
+    return bfloat16_is_any_nan(a_) && bfloat16_nan_is_snan(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Determine if a float32 NaN is signaling NaN.
+*----------------------------------------------------------------------------*/
+
+static bool float32_nan_is_snan(float32 a, float_status *status)
 {
     if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint16_t a = a_;
-        if (snan_bit_is_one(status)) {
-            return ((a >> 6) & 0x1FF) == 0x1FF;
-        } else {
-            return (((a >> 6) & 0x1FF) == 0x1FE) && (a & 0x3F);
-        }
+        return false;
     }
+    bool frac_msb_is_one = (a >> 22) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
@@ -310,16 +310,7 @@ bool bfloat16_is_signaling_nan(bfloat16 a_, float_status *status)
 
 bool float32_is_quiet_nan(float32 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float32_is_any_nan(a_);
-    } else {
-        uint32_t a = float32_val(a_);
-        if (snan_bit_is_one(status)) {
-            return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
-        } else {
-            return ((uint32_t)(a << 1) >= 0xFF800000);
-        }
-    }
+    return float32_is_any_nan(a_) && !float32_nan_is_snan(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -328,17 +319,21 @@ bool float32_is_quiet_nan(float32 a_, float_status *status)
 *----------------------------------------------------------------------------*/
 
 bool float32_is_signaling_nan(float32 a_, float_status *status)
+{
+    return float32_is_any_nan(a_) && float32_nan_is_snan(a_, status);
+}
+
+/*----------------------------------------------------------------------------
+| Determine if a float64 NaN is signaling NaN.
+*----------------------------------------------------------------------------*/
+
+static bool float64_nan_is_snan(float64 a, float_status *status)
 {
     if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint32_t a = float32_val(a_);
-        if (snan_bit_is_one(status)) {
-            return ((uint32_t)(a << 1) >= 0xFF800000);
-        } else {
-            return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
-        }
+        return false;
     }
+    bool frac_msb_is_one = (a >> 51) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
@@ -348,17 +343,7 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
 
 bool float64_is_quiet_nan(float64 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float64_is_any_nan(a_);
-    } else {
-        uint64_t a = float64_val(a_);
-        if (snan_bit_is_one(status)) {
-            return (((a >> 51) & 0xFFF) == 0xFFE)
-                && (a & 0x0007FFFFFFFFFFFFULL);
-        } else {
-            return ((a << 1) >= 0xFFF0000000000000ULL);
-        }
-    }
+    return float64_is_any_nan(a_) && !float64_nan_is_snan(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -368,17 +353,7 @@ bool float64_is_quiet_nan(float64 a_, float_status *status)
 
 bool float64_is_signaling_nan(float64 a_, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        uint64_t a = float64_val(a_);
-        if (snan_bit_is_one(status)) {
-            return ((a << 1) >= 0xFFF0000000000000ULL);
-        } else {
-            return (((a >> 51) & 0xFFF) == 0xFFE)
-                && (a & UINT64_C(0x0007FFFFFFFFFFFF));
-        }
-    }
+    return float64_is_any_nan(a_) && float64_nan_is_snan(a_, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -444,6 +419,19 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
     return a;
 }
 
+/*----------------------------------------------------------------------------
+| Determine if a float128 NaN is signaling NaN.
+*----------------------------------------------------------------------------*/
+
+static bool float128_nan_is_snan(float128 a, float_status *status)
+{
+    if (no_signaling_nans(status)) {
+        return false;
+    }
+    bool frac_msb_is_one = (a.high >> 47) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
+}
+
 /*----------------------------------------------------------------------------
 | Returns 1 if the quadruple-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
@@ -451,17 +439,7 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 
 bool float128_is_quiet_nan(float128 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return float128_is_any_nan(a);
-    } else {
-        if (snan_bit_is_one(status)) {
-            return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
-                && (a.low || (a.high & 0x00007FFFFFFFFFFFULL));
-        } else {
-            return ((a.high << 1) >= 0xFFFF000000000000ULL)
-                && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
-        }
-    }
+    return float128_is_any_nan(a) && !float128_nan_is_snan(a, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -471,15 +449,5 @@ bool float128_is_quiet_nan(float128 a, float_status *status)
 
 bool float128_is_signaling_nan(float128 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        if (snan_bit_is_one(status)) {
-            return ((a.high << 1) >= 0xFFFF000000000000ULL)
-                && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
-        } else {
-            return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
-                && (a.low || (a.high & UINT64_C(0x00007FFFFFFFFFFF)));
-        }
-    }
+    return float128_is_any_nan(a) && float128_nan_is_snan(a, status);
 }
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8146EC1EA0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxM2-0004o6-Tf; Thu, 05 Feb 2026 06:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLe-0004gX-Ep
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:41 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLb-0003my-SE
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:34 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a871daa98fso6187715ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770290190; x=1770894990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jL1s5SV3cubFpJlsGLlbrnPoja1OfqVMQ1g/z28whqY=;
 b=vaaCG0hQtp4wTPNg4DJkjoPXhGW7qu3xldD3MlK8a0262KfxBPScPrqBvA4hF8P86v
 4Eu3urgvcDNATrKDrKIvuUyUzkPzKwLFZhLgjXQZSHdl8s/rnXehSh1BAfsYdgvfMTqB
 fxACLdEdOXxiKr83BQcY+Dg5wS4E7RFNbalG+BhJ94DQQfS108PDBXtCwilUV5CxAGZ6
 4lkp+UbiSwiXaUt7Qt0iqKrQwZw8H1uPcLyK2BNP+uP3dJbSugNsGiJnFSykj0CFKtvc
 DDH1TRWOYXkK0GCwr/3RvOYRduSZBwqzwjwUXD8cuLh1IKXXBCPxfwtc2ykQ4DKdFtOb
 o/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290190; x=1770894990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jL1s5SV3cubFpJlsGLlbrnPoja1OfqVMQ1g/z28whqY=;
 b=K9NohhQrEWlKhFrMNY7tcyu7Jh0kw8lae4Bd+8PEvHssVXL3SxEzSiCrkcCG/9drUN
 T3u1xleWdzKa5q/NXYscc3PGKLPG9OyFJBzl4ICf8CMKXWLxQnP1f4tZm+SwQZMt2XYh
 efKDxeze0R11A+n2yhGQC8TkzdtC2dDGcMMbdYVxx/htRt9Y0IYnd3Mts1e2fOqztJ45
 ZX/gYHQ02B8OpqFYgH6NIeURwnj5jO41hMrmHpByo857eq4PiF56UZY8gomyJVJFGhNP
 aK5iq0NmIjVEWr+ZwChOjvI+Ksj0/96ixd7OOzqiLTlQR/cJEBXDIuhaeFAlEsIzt5+g
 Lo9g==
X-Gm-Message-State: AOJu0YzqEoDQosO6YzGFdqs30mZcak6IdgAyaHqa34n24fieQULFjSMb
 riPJ6cs1eXKEhR+I8vBJ3C1+yHH5pmoh1iGWnrVYD/8FAjltr3xBZCjVwM/h2LztTpeKIA/9mzP
 mGlqPQBC8yYAF
X-Gm-Gg: AZuq6aIaeyFo6XXhK1Vh/XS5vmsjNf7BNHT7UwjzMtsY+unYr7L8xchPrstQCFm+OJU
 jCfAj/35n9d8M17KaB6bQPM4Q98ZbKM/cmSKFDDAStYnk7HxEGrapXxy010xW1uWCPTPQT3rh2w
 3OMrj4wVvXGkJt3JY3akfh1itgHtbat+XWLBSSFtQZr/PGLWZO+rIjcvct10HoEWVX+8O2bQNOS
 DT/QYXKojcNQhmiSDD+N6INuQUL15xbutL+5ag++xTRCiC4c4Mk5IsfG81mi5p+Oag5UQAw2Itm
 pw+MAtDHJatECu9x5pf1mQIYGix3kAVtCrf9Qg/kFx8IK5CeudZlHdiTBYrselP+Z0NsXyk6RwH
 qkiZFG7S/t+j2Nr8HYwY5aqzBt9V9FaoEYvErfFegOKg/kcg7IjOjYtfeZQv7/dI+JoVvoEYsF/
 VvZ8QABMTOH68kLhMBDil9GqQ5+IcmDRg=
X-Received: by 2002:a17:902:d4d2:b0:297:e3c4:b2b0 with SMTP id
 d9443c01a7336-2a93410a4d3mr63224465ad.54.1770290190286; 
 Thu, 05 Feb 2026 03:16:30 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851685sm51088435ad.13.2026.02.05.03.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 03:16:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v4 1/9] fpu/softfloat: Refactor IEEE format NaN classification
 to share code
Date: Thu,  5 Feb 2026 21:16:14 +1000
Message-ID: <20260205111622.461497-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205111622.461497-1-richard.henderson@linaro.org>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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



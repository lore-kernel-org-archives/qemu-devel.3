Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF05FF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjP-0007Sh-LJ; Sun, 26 Apr 2026 09:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjO-0007S6-VV
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:06 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjN-0008Uo-36
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so87797875ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210864; x=1777815664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VNgPUkSJ4mPnaVXZdV15UFqpYzD21LWZWEvfnl6Hto=;
 b=df+ZDg8Tmphy6YL7SbWalgzFY9zgQhSxbZxbjj+k6q+7X63hyy5+vjkRD9tgqJekEi
 XHDPiv/20Czaf2EYJK4UdnEUJ+cpiRU/da6mlPxx5AwHlSlsOYbxwtqD+B7Etw+XuQPo
 Vnb9IgmyAsECqvBjPeijPppnlIfVYY3fJ9xlEjl6HapwC0/Plg35+CAOAqyaNR06PH/m
 PLMbdvYfjfF4ZSEyl0EtdmXQdtFUxPL+9lFcXFf+q3YiVaWZGmmWh/60wClwdf6qXxsX
 D4gwu6ObfjuDh1PEKzGUiXrDU5XOHRuIp0D5PfbHMbsWZZzRxfWWjTPnfyrgNgZgR8GX
 Nm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210864; x=1777815664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6VNgPUkSJ4mPnaVXZdV15UFqpYzD21LWZWEvfnl6Hto=;
 b=K5hUfC3z/hXSrhxMDYz4iFY3fDRaK6S30xzi9afQdytaX7QsVWWcYtzhPfR8mxTS6I
 3fEGPK4NFf43QCrIL5UarwZ8a9VT0E8hfXj/QozIwBxncQVztIetOLE5KjETQDBYvsF6
 w4Az0TpYXziT/4BvwB3fLfsPBVNlR41Wkx4wC4+KQh4HIMrltVKxCBqDJlZelLG0VgYN
 i4ku8m0SKhP1W/n+YemHtejcX8IxXHtBEGTgELLD7m1ja4PI4veXpwI9MyqxPRzCVPZX
 DkxUd33RiXlGxnWvv+iW+kRrw0wXB5KvkHG2C4vbXIyYneirS6O7l1arBpT5eOUl8Sxa
 zA4Q==
X-Gm-Message-State: AOJu0YwTgvp+AwytsInpZAcsVpaXreGbEnlokdfyqUaBtP+olwwZNlqi
 UGE1rmCoCEsk0FX4P+F156H+kuKUpppO3RpSOIub5JqkSRD3+8VGyLSN7ba4WehW/7i3VVqP4uf
 2yO9jSo8=
X-Gm-Gg: AeBDietqog2K8oI+8hv4PWtrLBGd0xXhC3didzK/axrwlXuQ9rnvdd7Yc8i6bvdJj+C
 mm485tlyq/UXCoMX+ppj/uGlFW8Uo2N/xrVR7W0as1wauhR/FIxJWxqZAxqZctofldm4G8TF/gc
 Esxb5naYy+eTxUGmwJkokCkESwZiO+rlmwp/MAr+bi05xalrnaQeG13N5iiMrpCHeyqF0LaqeaB
 euzZ6gzPBWeHg1RmulghyHYVybPCGdzJ4ivcU+FsLvL3CX/39ZAGqI0Musa2QHIAMcGrW1SJTb8
 0pwkTzMxLQSEgTY8OgTxukyGT+QuFLuKdPaFnu0RysJVbjit3ulWZX57ze0xrCagLrs4fn2TGN6
 Q2BKACAIABufa5arlIcja8KEnWIkBbFZ0dfMMrwF1s3+99Zl196842Wag625CEWsdGFdn+xfGwI
 7Dxd9iR4BEF9ft5GpArULR7ybN7GpTVGv8J1la9bnN
X-Received: by 2002:a17:902:ee84:b0:2b2:4697:78f4 with SMTP id
 d9443c01a7336-2b5f9fe094fmr331295385ad.31.1777210863581; 
 Sun, 26 Apr 2026 06:41:03 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 21/84] fpu: Drop parts_float_to_sint_modulo
Date: Sun, 26 Apr 2026 23:38:58 +1000
Message-ID: <20260426134002.865628-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Use parts64_float_to_sint_modulo at each call site.

That leaves parts128_float_to_sint_modulo unused,
so move the whole function back to softfloat.c and
specialize for FloatParts64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 84 +++++++++++++++++++++++++++++++++------
 fpu/softfloat-parts.c.inc | 79 ------------------------------------
 2 files changed, 72 insertions(+), 91 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 869b592cd0..0b2638c34b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,16 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static int64_t parts64_float_to_sint_modulo(FloatParts64 *p,
-                                            FloatRoundMode rmode,
-                                            int bitsm1, float_status *s);
-static int64_t parts128_float_to_sint_modulo(FloatParts128 *p,
-                                             FloatRoundMode rmode,
-                                             int bitsm1, float_status *s);
-
-#define parts_float_to_sint_modulo(P, R, M, S) \
-    PARTS_GENERIC_64_128(float_to_sint_modulo, P)(P, R, M, S)
-
 static void parts64_sint_to_float(FloatParts64 *p, int64_t a,
                                   int scale, float_status *s);
 static void parts128_sint_to_float(FloatParts128 *p, int64_t a,
@@ -3558,13 +3548,83 @@ int64_t bfloat16_to_int64_round_to_zero(bfloat16 a, float_status *s)
     return bfloat16_to_int64_scalbn(a, float_round_to_zero, 0, s);
 }
 
+/*
+ * Like partsN(float_to_sint), except do not saturate the result.
+ * Instead, return the rounded unbounded precision two's compliment result,
+ * modulo 2**(bitsm1 + 1).
+ */
+static int64_t parts64_float_to_sint_modulo(FloatParts64 *p,
+                                            FloatRoundMode rmode,
+                                            int bitsm1, float_status *s)
+{
+    int flags = 0;
+    uint64_t r;
+    bool overflow = false;
+
+    switch (p->cls) {
+    case float_class_snan:
+        flags |= float_flag_invalid_snan;
+        /* fall through */
+    case float_class_qnan:
+        flags |= float_flag_invalid;
+        r = 0;
+        break;
+
+    case float_class_inf:
+        overflow = true;
+        r = 0;
+        break;
+
+    case float_class_zero:
+        return 0;
+
+    case float_class_normal:
+    case float_class_denormal:
+        /* TODO: 64 - 2 is frac_size for rounding; could use input fmt. */
+        if (parts64_round_to_int_normal(p, rmode, 0, 64 - 2)) {
+            flags = float_flag_inexact;
+        }
+
+        if (p->exp <= DECOMPOSED_BINARY_POINT) {
+            r = p->frac >> (DECOMPOSED_BINARY_POINT - p->exp);
+            if (p->exp < bitsm1) {
+                /* Result in range. */
+            } else if (p->exp == bitsm1) {
+                /* The only in-range value is INT_MIN. */
+                overflow = !p->sign || p->frac != DECOMPOSED_IMPLICIT_BIT;
+            } else {
+                overflow = true;
+            }
+        } else {
+            /* Overflow, but there might still be bits to return. */
+            int shl = p->exp - DECOMPOSED_BINARY_POINT;
+            r = (shl < 64 ? p->frac << shl : 0);
+            overflow = true;
+        }
+
+        if (p->sign) {
+            r = -r;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    if (overflow) {
+        flags = float_flag_invalid | float_flag_invalid_cvti;
+    }
+    float_raise(flags, s);
+    return r;
+}
+
 int32_t float64_to_int32_modulo(float64 a, FloatRoundMode rmode,
                                 float_status *s)
 {
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_sint_modulo(&p, rmode, 31, s);
+    return parts64_float_to_sint_modulo(&p, rmode, 31, s);
 }
 
 int64_t float64_to_int64_modulo(float64 a, FloatRoundMode rmode,
@@ -3573,7 +3633,7 @@ int64_t float64_to_int64_modulo(float64 a, FloatRoundMode rmode,
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    return parts_float_to_sint_modulo(&p, rmode, 63, s);
+    return parts64_float_to_sint_modulo(&p, rmode, 63, s);
 }
 
 /*
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 9b719ac5cf..d8eb9f5b78 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1415,85 +1415,6 @@ static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
     return r;
 }
 
-/*
- * Like partsN(float_to_sint), except do not saturate the result.
- * Instead, return the rounded unbounded precision two's compliment result,
- * modulo 2**(bitsm1 + 1).
- */
-static int64_t partsN(float_to_sint_modulo)(FloatPartsN *p,
-                                            FloatRoundMode rmode,
-                                            int bitsm1, float_status *s)
-{
-    int flags = 0;
-    uint64_t r;
-    bool overflow = false;
-
-    switch (p->cls) {
-    case float_class_snan:
-        flags |= float_flag_invalid_snan;
-        /* fall through */
-    case float_class_qnan:
-        flags |= float_flag_invalid;
-        r = 0;
-        break;
-
-    case float_class_inf:
-        overflow = true;
-        r = 0;
-        break;
-
-    case float_class_zero:
-        return 0;
-
-    case float_class_normal:
-    case float_class_denormal:
-        /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
-        if (partsN(round_to_int_normal)(p, rmode, 0, N - 2)) {
-            flags = float_flag_inexact;
-        }
-
-        if (p->exp <= DECOMPOSED_BINARY_POINT) {
-            /*
-             * Because we rounded to integral, and exp < 64,
-             * we know frac_low is zero.
-             */
-            r = p->frac_hi >> (DECOMPOSED_BINARY_POINT - p->exp);
-            if (p->exp < bitsm1) {
-                /* Result in range. */
-            } else if (p->exp == bitsm1) {
-                /* The only in-range value is INT_MIN. */
-                overflow = !p->sign || p->frac_hi != DECOMPOSED_IMPLICIT_BIT;
-            } else {
-                overflow = true;
-            }
-        } else {
-            /* Overflow, but there might still be bits to return. */
-            int shl = p->exp - DECOMPOSED_BINARY_POINT;
-            if (shl < N) {
-                frac_shl(p, shl);
-                r = p->frac_hi;
-            } else {
-                r = 0;
-            }
-            overflow = true;
-        }
-
-        if (p->sign) {
-            r = -r;
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-
-    if (overflow) {
-        flags = float_flag_invalid | float_flag_invalid_cvti;
-    }
-    float_raise(flags, s);
-    return r;
-}
-
 /*
  * Integer to float conversions
  *
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCEAE98E09
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRDC-0002R1-0A; Mon, 23 Feb 2026 03:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRD9-0002Nx-Tt
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:36 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vuRD8-0008LR-0K
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:22:35 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aaf9191da3so25834375ad.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 00:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771834952; x=1772439752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2HI3H4nwt9bAmN3CqANUoXDWOZ0lwHr6G12QgBDepY=;
 b=KsX+Gdi8qT7yFu8wDpsDjqz6D2d/7Ut88wJfYWCYyZD8mniYO4Iss6jFQnhwOsaArT
 5l4P9YH2aQkVmPpwXo4U2r7ge8zBcP5fwbwZaDzNQs255+Dv1A3JD+aFZez7SZhh1U15
 LIcUPz0UWhdEkYbOM2xdj7DGBcU9SkdCHDQPyanx9SHtHg6GBvN+Lnf1XmYqGvZTdmz9
 5xnoaij0QG3wljDxmEJ+vbVRiP07onGBFQN3MWcOJ+zwppOmb4bv2dP3A3HtWE8OSScb
 4CsBOUOtM+R4mSQGEkMI6TbBYrdVnOp5ULVEOx2XaPngrCIjx2M6JpmIm/wSnrl8gd9Z
 e8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771834952; x=1772439752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m2HI3H4nwt9bAmN3CqANUoXDWOZ0lwHr6G12QgBDepY=;
 b=WJbX54O3K3n3A7MbVaw3jhcpioko7x8i/C2+i9k5BVwQFeLsjmGUCjtKdYfJKaZJfX
 RADFvl7i8Lm8jCVBsu2zXPQ2WAvDKG+6Mg0AWe6x6u8/qJkV6TgvFh3VQJo7L69l24jr
 w/9ajT4aPsPuTXsWf+G55m3DYKFHysSzLm0vnL0AQGKeCROrJbl8goGHRzcMxOWbLnWk
 aO+uttwR7K75o5I6dM0zQYCNPDfiY+DxN0dIoTAtQXQQ88vEMY9ghuSVZvnDcwZJNwJx
 2zYtFs0XhH3vK5b8lIGKIY7EYe4YP8y8xvbslRXavwKvXVlulN/INmPjgwYMmJHikxXL
 ll7g==
X-Gm-Message-State: AOJu0YyfzmxmEJw+/0V1w+vxRaG8tOWdjTkmzNpLFRF69nlmof8uWmff
 2yt5bSfYWsugEFd6MOdDJ63iV6RBmAaGSghdrFfFKza1IWmT6TeCJ991kQtYja3m7qvsK/Yc/nT
 4Wl/Dhos=
X-Gm-Gg: ATEYQzy5ZRPXD0cv7dUayvpiMTv9vRMd2cJbVDVJl0tXG5s5UXoak34hg/kD+Ek7oRI
 8SUEGXBT2PQ8v4RhGxOC/hjmYZBuWKpcc0GWrBRRqLQk4nrWgtymVxATZcdvK8ZECzYYSvIAEhZ
 v36prMyPedGAtsVVe46tC6KYFr/OndTYOb1TA0voaKUvCQUei+sr5K7CHrcSBc7tx4se3a9R5B2
 rIz22TZGcamVHtykyRJDPl3UnD/ZOUowljeMnkksj4NROn06HsgBN047V9BpGEa3mRe03ezHimI
 2XFM7mzdgYYR2Rvs5JRxN9zZsRj5BlKZmTSwVlnLra6q8LBCOddZwDZHC+xFV/mF5FZ8RDgg6j0
 D56Ld+J9IFxGnUEvre2futD72oGvYrQeQbQCnWcyGUEnlcrwtNTzlwaDVbfgbMvcTNmxjLqhzge
 EM+BW6pZii40nYzq6850k7dOy7qKXhy7Og/Y4bxRRjfRTbS0JUgO+ZM+trXgNy4EbPwQ==
X-Received: by 2002:a17:902:d4c8:b0:2ab:3ac6:8d03 with SMTP id
 d9443c01a7336-2ad744e2769mr79314305ad.36.1771834952436; 
 Mon, 23 Feb 2026 00:22:32 -0800 (PST)
Received: from stoup.. (123-243-199-74.static.tpgi.com.au. [123.243.199.74])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5dd7asm86543625ad.28.2026.02.23.00.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 00:22:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	chao.liu.zevorn@gmail.com
Subject: [PATCH v5 8/9] fpu: Add conversion routines for OCP FP8 E4M3
Date: Mon, 23 Feb 2026 19:21:53 +1100
Message-ID: <20260223082154.5623-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223082154.5623-1-richard.henderson@linaro.org>
References: <20260223082154.5623-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Split out of a larger patch; adjust overflow detection.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h |  1 +
 include/fpu/softfloat.h       |  4 +++
 fpu/softfloat.c               | 62 +++++++++++++++++++++++++++++++++++
 fpu/softfloat-parts.c.inc     | 45 +++++++++++++++++++++++--
 4 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index be7e2de6e3..9c84a101e5 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -122,6 +122,7 @@ typedef uint16_t bfloat16;
 /*
  * Open Compute Project (OCP) Microscaling Formats
  */
+typedef uint8_t float8_e4m3;
 typedef uint8_t float8_e5m2;
 
 /*
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 4385462992..31d3f76d3f 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -193,6 +193,10 @@ float128 uint128_to_float128(Int128, float_status *status);
 | OCP FP8 conversion routines.
 *----------------------------------------------------------------------------*/
 
+bfloat16 float8_e4m3_to_bfloat16(float8_e4m3, float_status *status);
+float8_e4m3 bfloat16_to_float8_e4m3(bfloat16, bool sat, float_status *status);
+float8_e4m3 float32_to_float8_e4m3(float32, bool sat, float_status *status);
+
 bfloat16 float8_e5m2_to_bfloat16(float8_e5m2, float_status *status);
 float8_e5m2 bfloat16_to_float8_e5m2(bfloat16, bool sat, float_status *status);
 float8_e5m2 float32_to_float8_e5m2(float32, bool sat, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0dc769283d..6e21882ab2 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -528,6 +528,8 @@ typedef enum __attribute__((__packed__)) {
     float_expmax_ieee,
     /* exp==max is a normal number; no infinity or nan representation. */
     float_expmax_normal,
+    /* exp==max, frac==max ? nan : normal; no infinity representation. */
+    float_expmax_e4m3,
 } FloatFmtExpMaxKind;
 
 /*
@@ -572,6 +574,14 @@ typedef struct {
     .frac_shift     = (-F - 1) & 63,                    \
     .round_mask     = (1ull << ((-F - 1) & 63)) - 1
 
+static const FloatFmt float8_e4m3_params = {
+    FLOAT_PARAMS(4, 3),
+    .exp_max_kind = float_expmax_e4m3
+};
+
+/* 110 << frac_shift, with the implicit bit set */
+#define E4M3_NORMAL_FRAC_MAX  0xe000000000000000ull
+
 static const FloatFmt float8_e5m2_params = {
     FLOAT_PARAMS(5, 2)
 };
@@ -631,6 +641,11 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
     };
 }
 
+static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
+{
+    unpack_raw64(p, &float8_e4m3_params, f);
+}
+
 static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
 {
     unpack_raw64(p, &float8_e5m2_params, f);
@@ -693,6 +708,11 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
+static float8_e4m3 QEMU_FLATTEN float8_e4m3_pack_raw(const FloatParts64 *p)
+{
+    return pack_raw64(p, &float8_e4m3_params);
+}
+
 static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
 {
     return pack_raw64(p, &float8_e5m2_params);
@@ -1689,6 +1709,13 @@ static const uint16_t rsqrt_tab[128] = {
  * Pack/unpack routines with a specific FloatFmt.
  */
 
+static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
+                                         float_status *s)
+{
+    float8_e4m3_unpack_raw(p, f);
+    parts_canonicalize(p, s, &float8_e4m3_params);
+}
+
 static void float8_e5m2_unpack_canonical(FloatParts64 *p, float8_e5m2 f,
                                          float_status *s)
 {
@@ -1716,6 +1743,14 @@ static void bfloat16_unpack_canonical(FloatParts64 *p, bfloat16 f,
     parts_canonicalize(p, s, &bfloat16_params);
 }
 
+static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
+                                                    float_status *s,
+                                                    bool saturate)
+{
+    parts_uncanon(p, s, &float8_e4m3_params, saturate);
+    return float8_e4m3_pack_raw(p);
+}
+
 static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
                                                     float_status *s,
                                                     bool saturate)
@@ -2894,6 +2929,15 @@ static void parts_float_to_float_widen(FloatParts128 *a, FloatParts64 *b,
     }
 }
 
+bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
+{
+    FloatParts64 p;
+
+    float8_e4m3_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return bfloat16_round_pack_canonical(&p, s);
+}
+
 bfloat16 float8_e5m2_to_bfloat16(float8_e5m2 a, float_status *s)
 {
     FloatParts64 p;
@@ -2923,6 +2967,15 @@ float64 float16_to_float64(float16 a, bool ieee, float_status *s)
     return float64_round_pack_canonical(&p, s);
 }
 
+float8_e4m3 float32_to_float8_e4m3(float32 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    float32_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e4m3_round_pack_canonical(&p, s, saturate);
+}
+
 float8_e5m2 float32_to_float8_e5m2(float32 a, bool saturate, float_status *s)
 {
     FloatParts64 p;
@@ -2999,6 +3052,15 @@ float32 float64_to_float32(float64 a, float_status *s)
     return float32_round_pack_canonical(&p, s);
 }
 
+float8_e4m3 bfloat16_to_float8_e4m3(bfloat16 a, bool saturate, float_status *s)
+{
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    parts_float_to_float(&p, s);
+    return float8_e4m3_round_pack_canonical(&p, s, saturate);
+}
+
 float8_e5m2 bfloat16_to_float8_e5m2(bfloat16 a, bool saturate, float_status *s)
 {
     FloatParts64 p;
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 09be686645..61b07307bf 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -242,6 +242,15 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
             return;
         case float_expmax_normal:
             break;
+        case float_expmax_e4m3:
+            if (p->frac_hi == 0b111) {
+                frac_shl(p, fmt->frac_shift);
+                p->cls = (parts_is_snan_frac(p->frac_hi, status)
+                          ? float_class_snan : float_class_qnan);
+                return;
+            }
+            /* otherwise normal */
+            break;
         default:
             g_assert_not_reached();
         }
@@ -262,6 +271,21 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
  * The saturate parameter controls saturation behavior for formats that
  * support it -- when true, overflow produces max normal instead of infinity.
  */
+
+/* Helper for uncanon_normal and uncanon, for FP8 E4M3. */
+static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
+                                          const FloatFmt *fmt, bool saturate)
+{
+    assert(N == 64);
+    float_raise(float_flag_overflow | float_flag_inexact, s);
+    if (saturate) {
+        p->exp = fmt->exp_max;
+        p->frac_hi = E4M3_NORMAL_FRAC_MAX;
+    } else {
+        parts_default_nan(p, s);
+    }
+}
+
 static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                                    const FloatFmt *fmt, bool saturate)
 {
@@ -360,6 +384,12 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                 }
                 break;
 
+            case float_expmax_e4m3:
+                if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
+                    partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
+                }
+                break;
+
             default:
                 g_assert_not_reached();
             }
@@ -459,9 +489,18 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
             frac_clear(p);
             return;
         case float_class_inf:
-            assert(fmt->exp_max_kind == float_expmax_ieee);
-            p->exp = fmt->exp_max;
-            frac_clear(p);
+            switch (fmt->exp_max_kind) {
+            case float_expmax_ieee:
+                p->exp = fmt->exp_max;
+                frac_clear(p);
+                break;
+            case float_expmax_e4m3:
+                partsN(uncanon_e4m3_overflow)(p, s, fmt, saturate);
+                break;
+            case float_expmax_normal:
+            default:
+                g_assert_not_reached();
+            }
             return;
         case float_class_qnan:
         case float_class_snan:
-- 
2.43.0



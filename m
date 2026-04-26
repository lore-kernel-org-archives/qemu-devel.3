Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1C7FF8863
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzse-0007wV-2P; Sun, 26 Apr 2026 09:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzs1-00074S-Bx
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:50:01 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzrv-0002rQ-Q2
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:49:57 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso3456013b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211394; x=1777816194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KkzAlyVyy6UWqSEFvAvWqU4O3LHFj7zGLXe1wYuo3k=;
 b=R0K5zC7m/KsTfh5aNm64viD1dvNWelBNIyc8ComuccCaq5PPz9BR7/4psuzbACK7HB
 pEMlXwKIIv3fV/9BmL3PuEhG0u6pBoO9SZRYG3LZB3+YShlRGAwTFEzKTpNlhRwVc60v
 Fou75Qg7Q7ZfhBO98ZvS4xog5L4seQTM3tGCg6XOmT+rzqRUrY52EipOUV3iDaptHr5f
 +tg+pYN6FGDUQY3DJhYmwn+enTErshjSsV8LSz1B49cwYvL0btkFGNOBdz5LYId/zWNL
 Q2Jwly0OZHhoUGynomIA0xxg/biAJDsbnmPGP1iw8SPMCSD22K3+XBg5CauIMdDsf1/I
 RPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211394; x=1777816194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0KkzAlyVyy6UWqSEFvAvWqU4O3LHFj7zGLXe1wYuo3k=;
 b=R/NKIiXnB9b6PYYjF4Q2XG6cr2PwE0KP1wI+K2RuGKWgaQ2uMhSrsUcd7fZGAKw9rW
 d7mk+V9//75jeXRrTipVKxB+HLKb1Dow7VDUP+bBBlLoPe2hiZpSCt5/i6VsBbJ44qnW
 7A4yN7tIKCMhzjEDsCojcErrj62iPliCUPclQswtegBK+Zw/dkHrhPtim9fDmIk5FkCX
 DdNztFkDg1Jt6FpyQ71KG5+VCGlKFKv/raEzRRxhPFVG6hw6HB44RyARYX3CZ7mQEPIk
 w4yStUB+qRuhwbGoyIuHYWrbaK+o3EJT5e50oT5JpQaFFqUZ6p+Rs7i8qK3G/K/20Vb/
 7s9Q==
X-Gm-Message-State: AOJu0YxOIWdYEEQUL2+KJ5Xx/WEE+hDDr0giCZN2pY76zeZhDy+Ixr9w
 mThI4ZZ/EsqP2X95AKRGb82/3H9+iTfjbPo2fORv8H2xpBELT2A8I9aDcQZ0PoRQtY2UwcrYjjj
 k3bld9oQ=
X-Gm-Gg: AeBDietkFk8vydwDvg9khoJ7mSQnTMjL6WVzEP4rxAtgZzUZnirqTFpzMMUVxegSk2S
 FPuRtbBEO08oZfnvYVkkOAQ3pM6SLN8hxo8ZrAKc9cW2Ga2Z3XCwR3ORBwwhgiB+Xt01iqeLvsL
 0SWBy4eTfFvdiZlb3eNZT14KD5/ZihNt4e2amm6DCAoGh+nZVmfDBt6F3fxhyhRPZtCB8xFA9IZ
 QRvGRHe1jVOPpDkK5uvbllceqDe1B6pUsqdfEgsfZiA5n+TreaKymHWnU3xblqWpHOzTFnvLp3H
 sPgc76/C41A5IRaPxHiarHYAtkknazvPG/abe7eJ0KvP7Okkg84KephCd1B5lx8qVVywBviBS3X
 h9wUgR78RXCJ7UANqZ+M/XvT+b9s9u5qtD6VP2mbKVdOdM0k9UltniRZcjAsnvTH3jsrQEcG5xy
 GjBWGiUhYzlSPG/Vw2XqQmYaryMRVDDahIsTNfO3ikk7s8fJESxlo=
X-Received: by 2002:a05:6a00:4308:b0:82f:3733:2f96 with SMTP id
 d2e1a72fcca58-82f8c82e853mr39743818b3a.8.1777211393858; 
 Sun, 26 Apr 2026 06:49:53 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebba485sm36307102b3a.38.2026.04.26.06.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:49:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 81/84] target/s390x: Move float{32,64}_s390_divide_to_integer
Date: Sun, 26 Apr 2026 23:39:58 +1000
Message-ID: <20260426134002.865628-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Now that we've exposed enough infrastructure, this can be
implemented in the backend that needs it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h       |  11 ---
 fpu/softfloat.c               | 137 ----------------------------------
 target/s390x/tcg/fpu_helper.c | 135 +++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 148 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 8389a07b04..1580d956d5 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -1386,15 +1386,4 @@ static inline bool float128_unordered_quiet(float128 a, float128 b,
 *----------------------------------------------------------------------------*/
 float128 float128_default_nan(float_status *status);
 
-#define DECLARE_S390_DIVIDE_TO_INTEGER(floatN)                                 \
-void floatN ## _s390_divide_to_integer(floatN a, floatN b,                     \
-                                       int final_quotient_rounding_mode,       \
-                                       bool mask_underflow, bool mask_inexact, \
-                                       floatN *r, floatN *n,                   \
-                                       uint32_t *cc, int *dxc,                 \
-                                       float_status *status)
-DECLARE_S390_DIVIDE_TO_INTEGER(float32);
-DECLARE_S390_DIVIDE_TO_INTEGER(float64);
-
-
 #endif /* SOFTFLOAT_H */
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 484db3ddf6..c979679dc1 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5139,143 +5139,6 @@ floatx80 floatx80_round(floatx80 a, float_status *status)
     return floatx80_round_pack_canonical(&p, status);
 }
 
-static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
-                                         int final_quotient_rounding_mode,
-                                         bool mask_underflow, bool mask_inexact,
-                                         const FloatFmt *fmt,
-                                         FloatParts64 *r, FloatParts64 *n,
-                                         uint32_t *cc, int *dxc,
-                                         float_status *status)
-{
-    /* POp table "Results: DIVIDE TO INTEGER (Part 1 of 2)" */
-    if ((float_cmask(a->cls) | float_cmask(b->cls)) & float_cmask_anynan) {
-        *r = parts64_pick_nan(a, b, status);
-        *n = *r;
-        *cc = 1;
-    } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
-        *r = parts64_default_nan(status);
-        *n = *r;
-        *cc = 1;
-        status->float_exception_flags |= float_flag_invalid;
-    } else if (b->cls == float_class_inf) {
-        *r = *a;
-        n->cls = float_class_zero;
-        n->sign = a->sign ^ b->sign;
-        *cc = 0;
-    } else {
-        FloatParts64 *q, q_buf, r_precise;
-        int float_exception_flags = 0;
-        bool is_q_smallish;
-        uint32_t r_flags;
-
-        /* Compute precise quotient */
-        q_buf = parts64_div(a, b, status);
-        q = &q_buf;
-
-        /*
-         * Check whether two closest integers can be precisely represented,
-         * i.e., all their bits fit into the fractional part.
-         */
-        is_q_smallish = q->exp < (fmt->frac_size + 1);
-
-        /*
-         * Final quotient is rounded using final-quotient-rounding method, and
-         * partial quotient is rounded toward zero.
-         *
-         * Rounding of partial quotient may be inexact. This is the whole point
-         * of distinguishing partial quotients, so ignore the exception.
-         */
-        *n = parts64_round_to_int(q,
-                                  is_q_smallish
-                                  ? final_quotient_rounding_mode
-                                  : float_round_to_zero,
-                                  0, status, fmt);
-
-        /* Compute precise remainder */
-        r_precise = parts64_muladd_scalbn(b, n, a, 0,
-                                          float_muladd_negate_product, status);
-
-        /* Round remainder to the target format */
-        *r = r_precise;
-        status->float_exception_flags = 0;
-        parts64_round_canonical(r, status, fmt);
-        r_flags = status->float_exception_flags;
-
-        /* POp table "Results: DIVIDE TO INTEGER (Part 2 of 2)" */
-        if (is_q_smallish) {
-            if (r->cls != float_class_zero) {
-                if (r->exp < 2 - (1 << (fmt->exp_size - 1))) {
-                    if (mask_underflow) {
-                        float_exception_flags |= float_flag_underflow;
-                        *dxc = 0x10;
-                        r->exp += fmt->exp_re_bias;
-                    }
-                } else if (r_flags & float_flag_inexact) {
-                    float_exception_flags |= float_flag_inexact;
-                    if (mask_inexact) {
-                        bool saved_r_sign, saved_r_precise_sign;
-
-                        /*
-                         * Check whether remainder was truncated (rounded
-                         * toward zero) or incremented.
-                         */
-                        saved_r_sign = r->sign;
-                        saved_r_precise_sign = r_precise.sign;
-                        r->sign = false;
-                        r_precise.sign = false;
-                        if (parts64_compare(r, &r_precise, status, true) <
-                            float_relation_equal) {
-                            *dxc = 0x8;
-                        } else {
-                            *dxc = 0xc;
-                        }
-                        r->sign = saved_r_sign;
-                        r_precise.sign = saved_r_precise_sign;
-                    }
-                }
-            }
-            *cc = 0;
-        } else if (n->exp > (1 << (fmt->exp_size - 1)) - 1) {
-            n->exp -= fmt->exp_re_bias;
-            *cc = r->cls == float_class_zero ? 1 : 3;
-        } else {
-            *cc = r->cls == float_class_zero ? 0 : 2;
-        }
-
-        /* Adjust signs of zero results */
-        if (r->cls == float_class_zero) {
-            r->sign = a->sign;
-        }
-        if (n->cls == float_class_zero) {
-            n->sign = a->sign ^ b->sign;
-        }
-
-        status->float_exception_flags = float_exception_flags;
-    }
-}
-
-#define DEFINE_S390_DIVIDE_TO_INTEGER(floatN)                                  \
-void floatN ## _s390_divide_to_integer(floatN a, floatN b,                     \
-                                       int final_quotient_rounding_mode,       \
-                                       bool mask_underflow, bool mask_inexact, \
-                                       floatN *r, floatN *n,                   \
-                                       uint32_t *cc, int *dxc,                 \
-                                       float_status *status)                   \
-{                                                                              \
-    FloatParts64 pa = floatN ## _unpack_canonical(a, status);                  \
-    FloatParts64 pb = floatN ## _unpack_canonical(b, status);                  \
-    FloatParts64 pr, pn;                                                       \
-    parts_s390_divide_to_integer(&pa, &pb, final_quotient_rounding_mode,       \
-                                 mask_underflow, mask_inexact,                 \
-                                 &floatN ## _params,                           \
-                                 &pr, &pn, cc, dxc, status);                   \
-    *r = floatN ## _round_pack_canonical(&pr, status);                         \
-    *n = floatN ## _round_pack_canonical(&pn, status);                         \
-}
-
-DEFINE_S390_DIVIDE_TO_INTEGER(float32)
-DEFINE_S390_DIVIDE_TO_INTEGER(float64)
-
 static void __attribute__((constructor)) softfloat_init(void)
 {
     union_float64 ua, ub, uc, ur;
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 122994960a..66ef3b3d36 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -24,6 +24,7 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
+#include "fpu/softfloat-parts.h"
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
@@ -315,6 +316,140 @@ Int128 HELPER(dxb)(CPUS390XState *env, Int128 a, Int128 b)
     return RET128(ret);
 }
 
+static void parts_s390_divide_to_integer(FloatParts64 *a, FloatParts64 *b,
+                                         int final_quotient_rounding_mode,
+                                         bool mask_underflow, bool mask_inexact,
+                                         const FloatFmt *fmt,
+                                         FloatParts64 *r, FloatParts64 *n,
+                                         uint32_t *cc, int *dxc,
+                                         float_status *status)
+{
+    /* POp table "Results: DIVIDE TO INTEGER (Part 1 of 2)" */
+    if ((float_cmask(a->cls) | float_cmask(b->cls)) & float_cmask_anynan) {
+        *r = parts64_pick_nan(a, b, status);
+        *n = *r;
+        *cc = 1;
+    } else if (a->cls == float_class_inf || b->cls == float_class_zero) {
+        *r = parts64_default_nan(status);
+        *n = *r;
+        *cc = 1;
+        status->float_exception_flags |= float_flag_invalid;
+    } else if (b->cls == float_class_inf) {
+        *r = *a;
+        n->cls = float_class_zero;
+        n->sign = a->sign ^ b->sign;
+        *cc = 0;
+    } else {
+        FloatParts64 *q, q_buf, r_precise;
+        int float_exception_flags = 0;
+        bool is_q_smallish;
+        uint32_t r_flags;
+
+        /* Compute precise quotient */
+        q_buf = parts64_div(a, b, status);
+        q = &q_buf;
+
+        /*
+         * Check whether two closest integers can be precisely represented,
+         * i.e., all their bits fit into the fractional part.
+         */
+        is_q_smallish = q->exp < (fmt->frac_size + 1);
+
+        /*
+         * Final quotient is rounded using final-quotient-rounding method, and
+         * partial quotient is rounded toward zero.
+         *
+         * Rounding of partial quotient may be inexact. This is the whole point
+         * of distinguishing partial quotients, so ignore the exception.
+         */
+        *n = parts64_round_to_int(q,
+                                  is_q_smallish
+                                  ? final_quotient_rounding_mode
+                                  : float_round_to_zero,
+                                  0, status, fmt);
+
+        /* Compute precise remainder */
+        r_precise = parts64_muladd_scalbn(b, n, a, 0,
+                                          float_muladd_negate_product, status);
+
+        /* Round remainder to the target format */
+        *r = r_precise;
+        status->float_exception_flags = 0;
+        parts64_round_canonical(r, status, fmt);
+        r_flags = status->float_exception_flags;
+
+        /* POp table "Results: DIVIDE TO INTEGER (Part 2 of 2)" */
+        if (is_q_smallish) {
+            if (r->cls != float_class_zero) {
+                if (r->exp < 2 - (1 << (fmt->exp_size - 1))) {
+                    if (mask_underflow) {
+                        float_exception_flags |= float_flag_underflow;
+                        *dxc = 0x10;
+                        r->exp += fmt->exp_re_bias;
+                    }
+                } else if (r_flags & float_flag_inexact) {
+                    float_exception_flags |= float_flag_inexact;
+                    if (mask_inexact) {
+                        bool saved_r_sign, saved_r_precise_sign;
+
+                        /*
+                         * Check whether remainder was truncated (rounded
+                         * toward zero) or incremented.
+                         */
+                        saved_r_sign = r->sign;
+                        saved_r_precise_sign = r_precise.sign;
+                        r->sign = false;
+                        r_precise.sign = false;
+                        if (parts64_compare(r, &r_precise, status, true) <
+                            float_relation_equal) {
+                            *dxc = 0x8;
+                        } else {
+                            *dxc = 0xc;
+                        }
+                        r->sign = saved_r_sign;
+                        r_precise.sign = saved_r_precise_sign;
+                    }
+                }
+            }
+            *cc = 0;
+        } else if (n->exp > (1 << (fmt->exp_size - 1)) - 1) {
+            n->exp -= fmt->exp_re_bias;
+            *cc = r->cls == float_class_zero ? 1 : 3;
+        } else {
+            *cc = r->cls == float_class_zero ? 0 : 2;
+        }
+
+        /* Adjust signs of zero results */
+        if (r->cls == float_class_zero) {
+            r->sign = a->sign;
+        }
+        if (n->cls == float_class_zero) {
+            n->sign = a->sign ^ b->sign;
+        }
+
+        status->float_exception_flags = float_exception_flags;
+    }
+}
+
+#define DEFINE_S390_DIVIDE_TO_INTEGER(floatN)                                  \
+static void floatN ## _s390_divide_to_integer(floatN a, floatN b,              \
+    int final_quotient_rounding_mode, bool mask_underflow, bool mask_inexact,  \
+    floatN *r, floatN *n, uint32_t *cc, int *dxc, float_status *status)        \
+{                                                                              \
+    FloatParts64 pa = floatN ## _unpack_canonical(a, status);                  \
+    FloatParts64 pb = floatN ## _unpack_canonical(b, status);                  \
+    FloatParts64 pr, pn;                                                       \
+    parts_s390_divide_to_integer(&pa, &pb, final_quotient_rounding_mode,       \
+                                 mask_underflow, mask_inexact,                 \
+                                 &floatN ## _params,                           \
+                                 &pr, &pn, cc, dxc, status);                   \
+    *r = floatN ## _round_pack_canonical(&pr, status);                         \
+    *n = floatN ## _round_pack_canonical(&pn, status);                         \
+}
+
+DEFINE_S390_DIVIDE_TO_INTEGER(float32)
+DEFINE_S390_DIVIDE_TO_INTEGER(float64)
+
 void HELPER(dib)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                  uint32_t m4, uint32_t bits)
 {
-- 
2.43.0



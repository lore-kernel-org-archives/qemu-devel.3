Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC2CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1JL-0002Zw-Pv; Thu, 07 May 2026 12:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ii-0001lv-59
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:14 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1If-00088L-M1
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:11 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so530892a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778170208; x=1778775008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjstTKJT90sH1HrKciEy2EXgN+I4s6KJIu6v2tPYbj4=;
 b=LwJijNhFJQRMEKYu27KwzuALoLZzf9FuLV6HmAAFYjl3VrwvmgdYHiXqAUvP6tR0/z
 t4lMaz2PwoVw+VyYPqXm0WlGehsra1xSEW5j7E9mVSLl+E07rOWCZVmpgeHtRy0TCa9w
 PYhZLGV4J3TogiK9+vJyT1Oe1pUUgoKk3N0qj0RgJGTRQeAknHXT3maxkZNt/62fjncI
 3h5BSyI5q1IjJ+mo75nR1EONQrm92ZbtgMLHaJ7Ug/9RJ6c4hAsdfgTzNyEXtG/M3Sbr
 n2k8pQ2aeebVvRHjwJ4R/ZcGcHPyUZH/Pw0AG4CDb5sFKCaZz/yuoNy93lWfEXWuq7M6
 w9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170208; x=1778775008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IjstTKJT90sH1HrKciEy2EXgN+I4s6KJIu6v2tPYbj4=;
 b=WtXK7ybRbQyw1MH5CumQHDLCXIj7YgIpaWisq4fsJM8TKQ1FBmOiAl72mbp6c1LMOk
 O7N1wRgprNhzKtl6JjXPBoiLVuVkqV0PM0Oa9iHGvUqjbAopmclTfoa556waLVlHoAVH
 g4taHUEMNGw6eowK6dTKs5hB7/qlT6SXuxZ3jQdrLXjnAwJ7bQytvy/R77/52RzMTHZh
 Zq4EYLCDVuZ1gnB6xYVhhnp/4NZPcP89cwvsulSfqE/CbZGh7zTdBXPqUzSroOKWQ3BY
 opbipQ/J2n9wSNEfPHN2JimDaV9IdW13kZubBu0ZmQYlOveifcNqjFOPAx0p2FIAII7Q
 yJ5g==
X-Gm-Message-State: AOJu0YzqTAvAgDVuhUyL+GZPUbczTNpNleyGUWlMLtQNzbwAVpzwn45o
 z45OgGdT+uwQ5Hri5m09RsgLSRYlY/lSSICc4dEqvllQy+ABicFxYsL1SMJoB8AS0drZBtKe23M
 nZgq8
X-Gm-Gg: AeBDiesH2FctrBrpZ1iCRst8nNa5OKpHKMTORIGZikoDyqMY//KelphMZzi9EZgSZdK
 UcOuu5Jg043hJbRMpiNsKy1egCz0orXUZD4KSeDDTwUQOtV8a3JUhWbLBtqHYjOJ9qdmbdAGc+V
 +8OGEFiUapkYFYdpUgF1GS/+DD6fBCdSvmLyRwokKoz10NtGgM5VYv4ZHEhyXT+cPrNoi0H1aCM
 O7UwBPPebi++1ihUKZGv30NqQM9umqC8R04apvBUKBwjSfUiqwzkOdNL/6BcwWQBNdIFq/1+JpW
 lO6i4noRqCylReNRGWiWt4AAMJqcOY8LroDUOmVIP1OgJeJd3u8hicgbtWYkfWXUunWv+8Exka+
 r4ZJbxN7a4BRnTQYbLY0RmcHIo1w2wze7Jb+0t/texM9CXgF849QgaoU2W9uZYkjbILCzDUw8jj
 rVcYmKvbVNUDp6weZtWJnAdykhWR3aIcja31eLyV0u+fsoaA==
X-Received: by 2002:a05:6830:6d15:b0:7d9:71e7:abe5 with SMTP id
 46e09a7af769-7e1dee9096amr5434678a34.10.1778170207609; 
 Thu, 07 May 2026 09:10:07 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e302462fb1sm16415a34.11.2026.05.07.09.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:10:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 06/11] target/s390x: Move float{32,
 64}_s390_divide_to_integer
Date: Thu,  7 May 2026 11:09:54 -0500
Message-ID: <20260507160959.449170-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160959.449170-1-richard.henderson@linaro.org>
References: <20260507160959.449170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Now that we've exposed enough infrastructure, this can be
implemented in the backend that needs it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
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
index cd03ace323..6a14c5d639 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5151,143 +5151,6 @@ floatx80 floatx80_round(floatx80 a, float_status *status)
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
-        r_precise = parts64_muladd(b, n, a,
-                                   float_muladd_negate_product, status);
-
-        /* Round remainder to the target format */
-        *r = r_precise;
-        status->float_exception_flags = 0;
-        *r = parts64_round_to_fmt(r, status, fmt);
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
index 122994960a..33e0f6100d 100644
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
+        r_precise = parts64_muladd(b, n, a,
+                                   float_muladd_negate_product, status);
+
+        /* Round remainder to the target format */
+        *r = r_precise;
+        status->float_exception_flags = 0;
+        *r = parts64_round_to_fmt(r, status, fmt);
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



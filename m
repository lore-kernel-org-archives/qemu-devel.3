Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AF0CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUaz-0004lj-6K; Fri, 22 May 2026 14:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUaw-0004kb-4f
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:38 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUat-0005OV-Qm
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ba6485d219so58750255ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474454; x=1780079254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCZyoqgqjVXJJtjxCkZlZshfx8C6L5WwhqI7H2CZ8tM=;
 b=r1XBVd0ISlOEEeNo5lucXlEJe8EpdOgs0fZAKXarx7goAhP5sNRwt/NoPK3RM0JOUD
 9ZSKLtZ95vFFfDuwC6Lt/Opav09UXJjKoG+DPn6rNxt0SPgZbc4j9UDVcldgwep0PXxX
 0teZcxUwK2IwrEW8xoA/1v96UIDoCOuADDzHOIJfX8qW31zI6uBZ4mGvw4P8MhdnS908
 2CIKEkkOm/Q/LgAoSgnPzzV/hw6Z/ibp9SOes/f1C+buEjmYG1UrW/24sNY2ZhcqMadk
 mqPXwFrJgRgH2cupSGIYFCYIziZ6NurhOdHQOOkbnZE8uhVToC6E7ZXTB8m4CRWaIiEm
 kY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474454; x=1780079254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fCZyoqgqjVXJJtjxCkZlZshfx8C6L5WwhqI7H2CZ8tM=;
 b=LsV63ycIJSuVE5KAOq/wLt4vj2LYbWl4pH6zZkk6nfEVD4k2RjfcK1iR9vzicgmAsg
 YaJXM1fGZws3YjdXz+/2TS+fm1optmbMAuLZj7LI68Xtn/m7obCTuNd1YpGbR7SnwUCb
 ZLHLULn2PmMEP1FDRWg2GOeBerp94tGmeHTnpCQ0LgM0FKlH9KjtbJ8SHJ3tNtUAIQ7K
 MnzB2OH3vZRfuaTaX1+hdHB5MNwUpkqJpmBV4DBJ/slxMVa70K3qZq8Pb0kGSLwQZtq9
 YshEC5/ZJT6hDWii1qSSkg/SQk34Tle7V1NM/W7muny75anEHCqsacimnoCpkF1ELmMm
 eD9Q==
X-Gm-Message-State: AOJu0YyVmYzf4EOTWFKoNqB5ASle2ThkSUBMSXp4UU+Tc70+Th9WHE2u
 CSqInxmBWFmKK5vwMTZO4NLBPG42NcQy4p11bls6DU9MwRt2fkXgMZVaybhfwt/hu70QnbnDLSb
 PkmxE
X-Gm-Gg: Acq92OGc9Z7+5JTzgIrJ5yNLdgS/WbWwmrISLN1wGsZLbJ4mWcQjJBcM5gTE5x8PAcC
 FsxKDVjnEWt9gx3AP2ZXOZNyjiqYeZOn85l7O0qjwZuSoYUYWpBMyPA0O0K6S7PD8ZnRUCn2yEk
 LO4YN34u9gACELSISvyM8EYPfAZIkvbIg7LLxrMYiuvkicFfpBO5fMTj2Mw2eit/k7F4cldhQgq
 U3oWmt5A7i3W/njdmQxr3gXwa6m54WZU1CbM+6ezYJOGQPUCi+kwavsSRWa+D8CNUK1MBsdC1UU
 ZK+IjUkplbmHAnLPbyWNZlx7Iawz9GUa7oKXqFWXqmJ4Tzn7qOcz+QT8CWI1wBfj1cLwzOr4mTa
 DOTyXZ3mBsvdC9+HwDCwNeZIM/JGDxgpPauZuKqTN9pUXLZf32ks6kdd+GhOd0MC4KD8j+DcZpM
 4yDK/y3+q++0mxgnlTQZ85qNi04SZk
X-Received: by 2002:a17:903:3c6d:b0:2b7:86be:7673 with SMTP id
 d9443c01a7336-2beb0366450mr51607485ad.6.1779474454295; 
 Fri, 22 May 2026 11:27:34 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 07/30] target/s390x: Move float{32,64}_s390_divide_to_integer
Date: Fri, 22 May 2026 11:26:35 -0700
Message-ID: <20260522182658.184604-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 08ea56a71d..a762f4b43a 100644
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



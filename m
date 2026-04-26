Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37819FF8864
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzsh-0008Ez-DR; Sun, 26 Apr 2026 09:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzs5-0007ED-W2
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:50:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzs3-0002ui-Fb
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:50:05 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so3680033b3a.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211402; x=1777816202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0uQob+N5O8wbOKZuJ2cl6QGt2btZMLnp6lMLH+YdM8=;
 b=WAYmfVvk9iC1JFCcZFJSiiCydk7qp2AmVUV0ZDF6GruI1+dSnu7689JhTgrnisbMIl
 tk/xTA2wuDA180ok0UU+2nmUaO2tA+uQUqmPBdrYUFmxCtz7LlX3ka45qA5SlkKYBeLd
 8UQp6SXcL2buIEMorisLMGlPFlNFmRc5+bAh0VgJ2DlYDjSp+4qvt2Vs0lch/d/EFvhm
 5phUga8ADIUESzyMTnSCTNBSfxm5dhy42oi413K5/dXD4UPBb0W8hFCNtdYNcccI55Hd
 V7u0esqkLN3rUnoy5+6ObhCUWT7jy9PjsJonw+WXz26thivFwxNB19k5pYY9ZMHalzQ+
 gpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211402; x=1777816202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p0uQob+N5O8wbOKZuJ2cl6QGt2btZMLnp6lMLH+YdM8=;
 b=oMgXhEfszovTgMnXf14v9hN9Z2mKSWNTMSXHpRBGwDhbzYtAsgWSNrsmMXP8SRDsX7
 4VYBm4l18YLzwdT/UsjuGgQkSFqf5TWFaU6s1IM+gLRNrAuXy2rqCUe9iaerTc5D5oyw
 DmmSbO4UvJjm1sRamQJziCaozpoKNaxaR68rvj5y5PjAqCj9q8LivwwDeJPokIZli5di
 dgnTH7PgxmI/VXGjRMohpyoO4xDa1aXg9KDcV6u7XURCdOJjD/WMJtgDm1FEswLjFyk0
 2O2YqvmDGo6SW0nEULdFRHtqo0m7H1mf9s5xnQPnFhyDMAkEfDUayK0jraQAQ8X/YMpF
 sCRA==
X-Gm-Message-State: AOJu0YwAOiTQ2NmAvybi4oMy3hdoSd/03WMC5XbNUQjihAJZ5VOoA/kB
 w1qVHowwTgTmfeQOr53y2BgK/lEGIZo4two6s97QNaWW/B/YkRSjD6t116K5KXhkUuWSN8+bOi2
 ozov9wXA=
X-Gm-Gg: AeBDieuemHiGHP74vvPKBuZ9jK5aDR1KKdFcWtkcfy7qIO5bwd3pU2zMAqHQKf8iUkK
 0FBj9ci/2ZOt9he9TIyFr1fiiwVfrxeU8HV8wkLPo8nVYmzBg4ugYB4RTUtO2hPJ9GZB2DnaHm+
 j8+IOy7PTr9FGiYVWUDccY/hZNPNvHMMOO3g4m6gBTfFTJqPn/l/6it77Z3rRd+rz8qxj488iST
 dhYyr1fJ9WzXCtek0EeqO9Ay1ZR5nCyreQOc4RNqjrPVh1TLOaTbtYXxwekBBPQfqqeVCOSNGsF
 edQtbu0W1mQ5NrKqK4ApkGZuw+x5evMFIuEN1Sr84MOh8yHpX1hw7Cij0M+aShv00Q0yBoXQ/GO
 LfN1MmLozBch7ls7WJZX5FuxqrCRZIs7APwVvNlEkf9y4Q53uWdwLxA6pvdL7FmB3cl54QW7+87
 mU16ozry4VVYK0Dofx6muIQfIfVOAyr4hSKOZ4kqsx
X-Received: by 2002:a05:6a00:6c8d:b0:82c:7f08:8826 with SMTP id
 d2e1a72fcca58-82f8c8b3dbemr35029369b3a.17.1777211401888; 
 Sun, 26 Apr 2026 06:50:01 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebba485sm36307102b3a.38.2026.04.26.06.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:50:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 84/84] target/arm: Use FloatParts64 in f16_dotadd
Date: Sun, 26 Apr 2026 23:40:01 +1000
Message-ID: <20260426134002.865628-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Use softfloat-parts.h so that we can more naturally
perform the required operations witha single rounding step.
This happens to also simplify the NaN detection step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c | 96 ++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 56 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0702a1b129..71fe44445d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -27,6 +27,7 @@
 #include "accel/tcg/helper-retaddr.h"
 #include "qemu/int128.h"
 #include "fpu/softfloat.h"
+#include "fpu/softfloat-parts.h"
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
@@ -1227,18 +1228,15 @@ static inline uint32_t bf16mop_ah_neg_adj_pair(uint32_t pair, uint32_t pg)
 }
 
 static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
-                          float_status *s_f16, float_status *s_std,
-                          float_status *s_odd)
+                          float_status *s_f16, float_status *s_std)
 {
     /*
-     * We need three different float_status for different parts of this
+     * We need two different float_status for different parts of this
      * operation:
      *  - the input conversion of the float16 values must use the
      *    f16-specific float_status, so that the FPCR.FZ16 control is applied
      *  - operations on float32 including the final accumulation must use
      *    the normal float_status, so that FPCR.FZ is applied
-     *  - we have pre-set-up copy of s_std which is set to round-to-odd,
-     *    for the multiply (see below)
      */
     float16 h1r = e1 & 0xffff;
     float16 h1c = e1 >> 16;
@@ -1246,48 +1244,49 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
     float16 h2c = e2 >> 16;
     float32 t32;
 
+    FloatParts64 p1r = float16_unpack_canonical(h1r, s_f16);
+    FloatParts64 p1c = float16_unpack_canonical(h1c, s_f16);
+    FloatParts64 p2r = float16_unpack_canonical(h2r, s_f16);
+    FloatParts64 p2c = float16_unpack_canonical(h2c, s_f16);
+
+    int all_mask = (float_cmask(p1r.cls) | float_cmask(p1c.cls) |
+                    float_cmask(p1r.cls) | float_cmask(p1c.cls));
+
     /* C.f. FPProcessNaNs4 */
-    if (float16_is_any_nan(h1r) || float16_is_any_nan(h1c) ||
-        float16_is_any_nan(h2r) || float16_is_any_nan(h2c)) {
+    if (unlikely(all_mask & float_cmask_anynan)) {
         float16 t16;
 
-        if (float16_is_signaling_nan(h1r, s_f16)) {
-            t16 = h1r;
-        } else if (float16_is_signaling_nan(h1c, s_f16)) {
-            t16 = h1c;
-        } else if (float16_is_signaling_nan(h2r, s_f16)) {
-            t16 = h2r;
-        } else if (float16_is_signaling_nan(h2c, s_f16)) {
-            t16 = h2c;
-        } else if (float16_is_any_nan(h1r)) {
-            t16 = h1r;
-        } else if (float16_is_any_nan(h1c)) {
-            t16 = h1c;
-        } else if (float16_is_any_nan(h2r)) {
-            t16 = h2r;
+        if (unlikely(all_mask & float_cmask_snan)) {
+            if (p1r.cls == float_class_snan) {
+                t16 = h1r;
+            } else if (p1c.cls == float_class_snan) {
+                t16 = h1c;
+            } else if (p2r.cls == float_class_snan) {
+                t16 = h2r;
+            } else {
+                t16 = h2c;
+            }
         } else {
-            t16 = h2c;
+            if (p1r.cls == float_class_qnan) {
+                t16 = h1r;
+            } else if (p1c.cls == float_class_qnan) {
+                t16 = h1c;
+            } else if (p2r.cls == float_class_qnan) {
+                t16 = h2r;
+            } else {
+                t16 = h2c;
+            }
         }
         t32 = float16_to_float32(t16, true, s_f16);
     } else {
-        float64 e1r = float16_to_float64(h1r, true, s_f16);
-        float64 e1c = float16_to_float64(h1c, true, s_f16);
-        float64 e2r = float16_to_float64(h2r, true, s_f16);
-        float64 e2c = float16_to_float64(h2c, true, s_f16);
-        float64 t64;
-
         /*
          * The ARM pseudocode function FPDot performs both multiplies
-         * and the add with a single rounding operation.  Emulate this
-         * by performing the first multiply in round-to-odd, then doing
-         * the second multiply as fused multiply-add, and rounding to
-         * float32 all in one step.
+         * and the add with a single rounding operation.
          */
-        t64 = float64_mul(e1r, e2r, s_odd);
-        t64 = float64r32_muladd(e1c, e2c, t64, 0, s_std);
+        FloatParts64 tmp = parts64_mul(&p1r, &p2r, s_std);
+        tmp = parts64_muladd_scalbn(&p1c, &p2c, &tmp, 0, 0, s_std);
 
-        /* This conversion is exact, because we've already rounded. */
-        t32 = float64_to_float32(t64, s_std);
+        t32 = float32_round_pack_canonical(&tmp, s_std);
     }
 
     /* The final accumulation step is not fused. */
@@ -1299,9 +1298,6 @@ static void do_fmopa_w_h(void *vza, void *vzn, void *vzm, uint16_t *pn,
                          uint32_t negx, bool ah_neg)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
-    float_status fpst_odd = env->vfp.fp_status[FPST_ZA];
-
-    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
 
     for (row = 0; row < oprsz; ) {
         uint16_t prow = pn[H2(row >> 4)];
@@ -1325,8 +1321,7 @@ static void do_fmopa_w_h(void *vza, void *vzn, void *vzm, uint16_t *pn,
                         m = f16mop_adj_pair(m, pcol, 0);
                         *a = f16_dotadd(*a, n, m,
                                         &env->vfp.fp_status[FPST_ZA_F16],
-                                        &env->vfp.fp_status[FPST_ZA],
-                                        &fpst_odd);
+                                        &env->vfp.fp_status[FPST_ZA]);
                     }
                     col += 4;
                     pcol >>= 4;
@@ -1363,15 +1358,12 @@ void HELPER(sme2_fdot_h)(void *vd, void *vn, void *vm, void *va,
     bool za = extract32(desc, SIMD_DATA_SHIFT, 1);
     float_status *fpst_std = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     float_status *fpst_f16 = &env->vfp.fp_status[za ? FPST_ZA_F16 : FPST_A64_F16];
-    float_status fpst_odd = *fpst_std;
     float32 *d = vd, *a = va;
     uint32_t *n = vn, *m = vm;
 
-    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
-
     for (i = 0; i < oprsz / sizeof(float32); ++i) {
         d[H4(i)] = f16_dotadd(a[H4(i)], n[H4(i)], m[H4(i)],
-                              fpst_f16, fpst_std, &fpst_odd);
+                              fpst_f16, fpst_std);
     }
 }
 
@@ -1385,17 +1377,14 @@ void HELPER(sme2_fdot_idx_h)(void *vd, void *vn, void *vm, void *va,
     bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
     float_status *fpst_std = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     float_status *fpst_f16 = &env->vfp.fp_status[za ? FPST_ZA_F16 : FPST_A64_F16];
-    float_status fpst_odd = *fpst_std;
     float32 *d = vd, *a = va;
     uint32_t *n = vn, *m = (uint32_t *)vm + H4(idx);
 
-    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
-
     for (i = 0; i < elements; i += eltspersegment) {
         uint32_t mm = m[i];
         for (j = 0; j < eltspersegment; ++j) {
             d[H4(i + j)] = f16_dotadd(a[H4(i + j)], n[H4(i + j)], mm,
-                                      fpst_f16, fpst_std, &fpst_odd);
+                                      fpst_f16, fpst_std);
         }
     }
 }
@@ -1408,24 +1397,19 @@ void HELPER(sme2_fvdot_idx_h)(void *vd, void *vn, void *vm, void *va,
     intptr_t eltspersegment = MIN(4, elements);
     int idx = extract32(desc, SIMD_DATA_SHIFT, 2);
     int sel = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
-    float_status fpst_odd, *fpst_std, *fpst_f16;
     float32 *d = vd, *a = va;
     uint16_t *n0 = vn;
     uint16_t *n1 = vn + sizeof(ARMVectorReg);
     uint32_t *m = (uint32_t *)vm + H4(idx);
 
-    fpst_std = &env->vfp.fp_status[FPST_ZA];
-    fpst_f16 = &env->vfp.fp_status[FPST_ZA_F16];
-    fpst_odd = *fpst_std;
-    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
-
     for (i = 0; i < elements; i += eltspersegment) {
         uint32_t mm = m[i];
         for (j = 0; j < eltspersegment; ++j) {
             uint32_t nn = (n0[H2(2 * (i + j) + sel)])
                         | (n1[H2(2 * (i + j) + sel)] << 16);
             d[i + H4(j)] = f16_dotadd(a[i + H4(j)], nn, mm,
-                                      fpst_f16, fpst_std, &fpst_odd);
+                                      &env->vfp.fp_status[FPST_ZA_F16],
+                                      &env->vfp.fp_status[FPST_ZA]);
         }
     }
 }
-- 
2.43.0



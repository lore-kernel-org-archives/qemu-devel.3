Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65395CD98C9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX23j-0004iT-Uy; Tue, 09 Jun 2026 15:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21q-0003YJ-AF
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21e-0003zc-UH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c0c1e0b0faso41204975ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032873; x=1781637673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QL0iVLIn2tMUwkCsFfINMahk/u5B3KJfS/VipMkllMo=;
 b=mxnqq8xcNrB6C+OiYybCYK7+u1qaZ9XBrACQPyFu529haDyLxiuSxtVjh5bTMCesde
 WgxiF0WEWoEn2wkhxsaUmd9eh+F3VK/TIpIXmlfXubaplL8KDBLRzeXdeY464yuBcJZU
 t28KG8M5a5j3vB3tKvXlpwhInwrRuVMLrhIqWjR5ozkGdgaMN53n0A16PpNlu0tJaiGo
 cfOr6KjamzOmCngVTVsWFAqV5RkthieQidbiydhBvd29BgfV5QfnlCnoqIG1pMZZq9tq
 NpIYiZreQNw6OnpsnJj7H5Oxiwp1Y9yU+lMHw2rGA/AaM//881QZi33t9d3FLcPJ3etx
 o4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032873; x=1781637673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QL0iVLIn2tMUwkCsFfINMahk/u5B3KJfS/VipMkllMo=;
 b=VV1xVmygvnsecF7xls7FvwMDOqEinX6R+SJ0AYVIiZlE/fh/zY68wiBIODF8/ciF7w
 9KeP0IztwLeo6NK2Bq0D9wQlGgn7RoRiPrsvG/UsF9d0rhayL2JizCb6Vz+lmv7WmfpL
 KqsQ49j7YwHO0rB5VC5YbMGu28X8aGjO6h0OIayvys5T0vexEJtdh0aTRBnD92OPGqG4
 v8NcPOeFStj1gai2gjTicehNrI5MxB+3csSPXDCl4pwYpL58zhzHhzZszsNt8h7XhobB
 Ntc/uBzub56WwyAe8rF5VlG6nNGF3b2YZJfeVMUGGcA5T2V8624A/w95iKrI8cQXBDWt
 dbeA==
X-Gm-Message-State: AOJu0Ywx2/H/tGRmZfanKlRYLZHGXTFpB57H6/twyFz3u/tHghixKZyo
 2U1rEAeLtPp+x/dbLfDY3saAErbTD48I4c5WfaycMtmBv3LlrJioZ5yAuBvZqakM2TGQ/gPN/RC
 F6Mv9P1c=
X-Gm-Gg: Acq92OGVxnvyV4jlKH70BMz1jPYR2pz/YsQ8B7pYbeYbIjJZQe0tn5LBd1PhE8RU0Tg
 hvzFriEX9lBe0cf+uEHcLjIa7u1W8nCHjkRoQOZj9mqEcAEK954LTiSJrprH5Ee+pi1AsAcxFA0
 AThIJzvixUG9gJnHTgGXYV/hqwZpNgAzBSoxZIysbnRbwnHcaqWJLhdURJoMh7fb1egws/k63Dg
 7UBsaCghp21bF9tb0Yxyvh4rycwTZYwBjQNZLg3tpUlOL0rmdSkjGov++yH4cdVwS8DyN2WyMzz
 v4y3kBXPjE98HkSGY+Ig6LLowzyoUnkBlaLqHROUZpIOmXtGHvW7L9aiWdx/lHUYw5f5m0Y3DVY
 fuscTg+xvKBzjxQaddU2ITlO7glPCQc6DkAaB3I4nAkBYLJLNgfyOoMwii3VzCpzFwGMeiyj0yi
 +RvS2qthbmP9LG0Cem0gKdoG+pjdQlmP71xAAsc0s=
X-Received: by 2002:a17:903:1965:b0:2bf:172d:ef7e with SMTP id
 d9443c01a7336-2c1e8346fefmr243826295ad.34.1781032873440; 
 Tue, 09 Jun 2026 12:21:13 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 03/45] target/arm: Use FloatParts64 in f16_dotadd
Date: Tue,  9 Jun 2026 12:20:27 -0700
Message-ID: <20260609192110.752384-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use softfloat-parts.h so that we can more naturally
perform the required operations witha single rounding step.
This happens to also simplify the NaN detection step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260517002550.321291-11-richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c | 97 +++++++++++++++----------------------
 1 file changed, 40 insertions(+), 57 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 376fbd48d4..f508baed8a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -27,6 +27,7 @@
 #include "accel/tcg/helper-retaddr.h"
 #include "qemu/int128.h"
 #include "fpu/softfloat.h"
+#include "fpu/softfloat-parts.h"
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
@@ -1221,18 +1222,15 @@ static inline uint32_t bf16mop_ah_neg_adj_pair(uint32_t pair, uint32_t pg)
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
@@ -1240,48 +1238,48 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
     float16 h2c = e2 >> 16;
     float32 t32;
 
+    FloatParts64 p1r = float16_unpack_canonical(h1r, s_f16);
+    FloatParts64 p1c = float16_unpack_canonical(h1c, s_f16);
+    FloatParts64 p2r = float16_unpack_canonical(h2r, s_f16);
+    FloatParts64 p2c = float16_unpack_canonical(h2c, s_f16);
+
+    int all_mask = (float_cmask(p1r.cls) | float_cmask(p1c.cls) |
+                    float_cmask(p2r.cls) | float_cmask(p2c.cls));
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
-
-        /* This conversion is exact, because we've already rounded. */
-        t32 = float64_to_float32(t64, s_std);
+        FloatParts64 tmp = parts64_mul(&p1r, &p2r, s_f16);
+        tmp = parts64_muladd(&p1c, &p2c, &tmp, 0, s_f16);
+        t32 = float32_round_pack_canonical(&tmp, s_f16);
     }
 
     /* The final accumulation step is not fused. */
@@ -1293,9 +1291,6 @@ static void do_fmopa_w_h(void *vza, void *vzn, void *vzm, uint16_t *pn,
                          uint32_t negx, bool ah_neg)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
-    float_status fpst_odd = env->vfp.fp_status[FPST_ZA];
-
-    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
 
     for (row = 0; row < oprsz; ) {
         uint16_t prow = pn[H2(row >> 4)];
@@ -1319,8 +1314,7 @@ static void do_fmopa_w_h(void *vza, void *vzn, void *vzm, uint16_t *pn,
                         m = f16mop_adj_pair(m, pcol, 0);
                         *a = f16_dotadd(*a, n, m,
                                         &env->vfp.fp_status[FPST_ZA_F16],
-                                        &env->vfp.fp_status[FPST_ZA],
-                                        &fpst_odd);
+                                        &env->vfp.fp_status[FPST_ZA]);
                     }
                     col += 4;
                     pcol >>= 4;
@@ -1357,15 +1351,12 @@ void HELPER(sme2_fdot_h)(void *vd, void *vn, void *vm, void *va,
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
 
@@ -1379,17 +1370,14 @@ void HELPER(sme2_fdot_idx_h)(void *vd, void *vn, void *vm, void *va,
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
@@ -1402,24 +1390,19 @@ void HELPER(sme2_fvdot_idx_h)(void *vd, void *vn, void *vm, void *va,
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



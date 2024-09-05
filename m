Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3378CD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC72-0001Lw-5Z; Thu, 05 Sep 2024 09:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6w-000137-DQ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001jE-6T
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42bac9469e8so5914745e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541268; x=1726146068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g5k9uorZoB64FeJd18+6sOiVbENoo0GfinS46arCmIY=;
 b=IUUjiZPcTzX4UE8kCZ5cyEjymQ60F+TrIA0fxt9tXDNgYHhwzW9+lx2qgMF9zOgN0t
 3fcQMLs7+pF6fbNOtbg3on91B5Y5y9TkGO0LVWBxOUpND4QvosHF1mEU3SDerhqA1z0W
 n8FE4fztwPwqnZqnrzzmMkaOwegEsvEaf9lQM4o79bC8cWJ/egw4OfjXiUyHRwmWZ1ps
 9pNRzzAxN3YgxWouxeDpEHuUqU+wu0Yf7AG96JJchLqU32AoJX8AWjrO4KgJfos9rx93
 yneB/J7EReiQg/+idOW7mbFdsMD8Gd68u9Y1KnAwy+zs6Zm10rhm1a13/tAjT0GZyNg5
 U7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541268; x=1726146068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5k9uorZoB64FeJd18+6sOiVbENoo0GfinS46arCmIY=;
 b=hu2Vmet7JQqLFDjyGJ6NYOOkWRbB1MpbD81E3GkWtikS8zU9tle/keYnilpiehrH5Z
 DAyzsG0NIY7vT7/IcwjYW8+4oGL5t9o0My37ismblWNzSYY7PIW4eOdIIqPRnqw/xZKX
 VfjAdfP6LJjKOypTpYs4WeRok6UUur9AH+kkcbC1PFCJlTv0r1nPagOxfiyldJxuu6tN
 npnjPVSiJ34iPG+OT/upDq7GHPnQYG8haqFlBQmwruwPVB5tl1d2erejLQqRFiGaVV5R
 YMTDOe8fODYwB/RLLTQiPTzOHmVFZc9zRcYe6re0e6cs/8fNfkxv2XitLP7wrhogQre9
 ag7A==
X-Gm-Message-State: AOJu0YynIYIyeCGuaZCUBe/Skl8UZm0pHR7HwVpYCoA6JxfLRuM6DKaG
 6YTrWQ6OeOmW2TGNwjd5ZxHNil6CTLyCS17SSIzFzPThhhu++YzJ9qsrQ0IbsmKViWWOswBFsGe
 T
X-Google-Smtp-Source: AGHT+IE5bzwX33KMXrSjNSD9GRFmUc3PpxdnL8ox2bVMonFFXz03qx7TbQlv3A7FAMJFBe1B66NXWw==
X-Received: by 2002:a05:600c:3b08:b0:426:5f8f:51a4 with SMTP id
 5b1f17b1804b1-42c954503femr43438655e9.12.1725541267345; 
 Thu, 05 Sep 2024 06:01:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/25] target/arm: Prepare bfdotadd() callers for FEAT_EBF
 support
Date: Thu,  5 Sep 2024 14:00:41 +0100
Message-Id: <20240905130100.298768-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We use bfdotadd() in four callsites for various helper functions. Currently
this all assumes that we have the FPCR.EBF=0 semantics. For FPCR.EBF=1
we will need to:
 * call a different routine to bfdotadd() because we need to do a
   fused multiply-add rather than separate multiply and add steps
 * use a different float_status that honours the FPCR rounding mode
   and denormal-flushing fields
 * pass in an extra float_status that has been set up to perform
   round-to-odd rounding

To prepare for this, refactor all the callsites so that instead of
   for (...) {
       x = bfdotadd(...);
   }

they are:
   float_status fpst, fpst_odd;
   if (is_ebf(env, &fpst, &fpst_odd)) {
       for (...) {
           x = bfdotadd_ebf(..., &fpst, &fpst_odd);
       }
   } else {
       for (...) {
           x = bfdotadd(..., &fpst);
       }
   }

For the moment the is_ebf() function always returns false, sets up
fpst for EBF=0 semantics and never sets up fpst_odd; bfdotadd_ebf()
will assert if called. We'll fill in the handling for EBF=1 in the
next commit.

This change should be a zero-behaviour-change refactor.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h |  37 ++++++++-
 target/arm/tcg/sme_helper.c   |  74 ++++++++++++------
 target/arm/tcg/vec_helper.c   | 139 +++++++++++++++++++++++++---------
 3 files changed, 189 insertions(+), 61 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 3ca1b94ccf9..094f5c169ca 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -223,13 +223,46 @@ int64_t do_sqrdmlah_d(int64_t, int64_t, int64_t, bool, bool);
  * bfdotadd:
  * @sum: addend
  * @e1, @e2: multiplicand vectors
+ * @fpst: floating-point status to use
  *
  * BFloat16 2-way dot product of @e1 & @e2, accumulating with @sum.
  * The @e1 and @e2 operands correspond to the 32-bit source vector
  * slots and contain two Bfloat16 values each.
  *
- * Corresponds to the ARM pseudocode function BFDotAdd.
+ * Corresponds to the ARM pseudocode function BFDotAdd, specialized
+ * for the FPCR.EBF == 0 case.
  */
-float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2);
+float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst);
+/**
+ * bfdotadd_ebf:
+ * @sum: addend
+ * @e1, @e2: multiplicand vectors
+ * @fpst: floating-point status to use
+ * @fpst_odd: floating-point status to use for round-to-odd operations
+ *
+ * BFloat16 2-way dot product of @e1 & @e2, accumulating with @sum.
+ * The @e1 and @e2 operands correspond to the 32-bit source vector
+ * slots and contain two Bfloat16 values each.
+ *
+ * Corresponds to the ARM pseudocode function BFDotAdd, specialized
+ * for the FPCR.EBF == 1 case.
+ */
+float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
+                     float_status *fpst, float_status *fpst_odd);
+
+/**
+ * is_ebf:
+ * @env: CPU state
+ * @statusp: pointer to floating point status to fill in
+ * @oddstatusp: pointer to floating point status to fill in for round-to-odd
+ *
+ * Determine whether a BFDotAdd operation should use FPCR.EBF = 0
+ * or FPCR.EBF = 1 semantics. On return, has initialized *statusp
+ * and *oddstatusp to suitable float_status arguments to use with either
+ * bfdotadd() or bfdotadd_ebf().
+ * Returns true for EBF = 1, false for EBF = 0. (The caller should use this
+ * to decide whether to call bfdotadd() or bfdotadd_ebf().)
+ */
+bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp);
 
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 289ffabbfbe..8cf12654e56 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1085,32 +1085,62 @@ void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm,
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
     uint16_t *pn = vpn, *pm = vpm;
+    float_status fpst, fpst_odd;
 
-    for (row = 0; row < oprsz; ) {
-        uint16_t prow = pn[H2(row >> 4)];
-        do {
-            void *vza_row = vza + tile_vslice_offset(row);
-            uint32_t n = *(uint32_t *)(vzn + H1_4(row));
+    if (is_ebf(env, &fpst, &fpst_odd)) {
+        for (row = 0; row < oprsz; ) {
+            uint16_t prow = pn[H2(row >> 4)];
+            do {
+                void *vza_row = vza + tile_vslice_offset(row);
+                uint32_t n = *(uint32_t *)(vzn + H1_4(row));
 
-            n = f16mop_adj_pair(n, prow, neg);
+                n = f16mop_adj_pair(n, prow, neg);
 
-            for (col = 0; col < oprsz; ) {
-                uint16_t pcol = pm[H2(col >> 4)];
-                do {
-                    if (prow & pcol & 0b0101) {
-                        uint32_t *a = vza_row + H1_4(col);
-                        uint32_t m = *(uint32_t *)(vzm + H1_4(col));
+                for (col = 0; col < oprsz; ) {
+                    uint16_t pcol = pm[H2(col >> 4)];
+                    do {
+                        if (prow & pcol & 0b0101) {
+                            uint32_t *a = vza_row + H1_4(col);
+                            uint32_t m = *(uint32_t *)(vzm + H1_4(col));
 
-                        m = f16mop_adj_pair(m, pcol, 0);
-                        *a = bfdotadd(*a, n, m);
-                    }
-                    col += 4;
-                    pcol >>= 4;
-                } while (col & 15);
-            }
-            row += 4;
-            prow >>= 4;
-        } while (row & 15);
+                            m = f16mop_adj_pair(m, pcol, 0);
+                            *a = bfdotadd_ebf(*a, n, m, &fpst, &fpst_odd);
+                        }
+                        col += 4;
+                        pcol >>= 4;
+                    } while (col & 15);
+                }
+                row += 4;
+                prow >>= 4;
+            } while (row & 15);
+        }
+    } else {
+        for (row = 0; row < oprsz; ) {
+            uint16_t prow = pn[H2(row >> 4)];
+            do {
+                void *vza_row = vza + tile_vslice_offset(row);
+                uint32_t n = *(uint32_t *)(vzn + H1_4(row));
+
+                n = f16mop_adj_pair(n, prow, neg);
+
+                for (col = 0; col < oprsz; ) {
+                    uint16_t pcol = pm[H2(col >> 4)];
+                    do {
+                        if (prow & pcol & 0b0101) {
+                            uint32_t *a = vza_row + H1_4(col);
+                            uint32_t m = *(uint32_t *)(vzm + H1_4(col));
+
+                            m = f16mop_adj_pair(m, pcol, 0);
+                            *a = bfdotadd(*a, n, m, &fpst);
+                        }
+                        col += 4;
+                        pcol >>= 4;
+                    } while (col & 15);
+                }
+                row += 4;
+                prow >>= 4;
+            } while (row & 15);
+        }
     }
 }
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 616ec54bb77..b0de74b55f1 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2790,39 +2790,58 @@ DO_MMLA_B(gvec_usmmla_b, do_usmmla_b)
  * BFloat16 Dot Product
  */
 
-float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2)
+bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
 {
     /* FPCR is ignored for BFDOT and BFMMLA. */
-    float_status bf_status = {
+    *statusp = (float_status){
         .tininess_before_rounding = float_tininess_before_rounding,
         .float_rounding_mode = float_round_to_odd_inf,
         .flush_to_zero = true,
         .flush_inputs_to_zero = true,
         .default_nan_mode = true,
     };
+
+    return false;
+}
+
+float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
+{
     float32 t1, t2;
 
     /*
      * Extract each BFloat16 from the element pair, and shift
      * them such that they become float32.
      */
-    t1 = float32_mul(e1 << 16, e2 << 16, &bf_status);
-    t2 = float32_mul(e1 & 0xffff0000u, e2 & 0xffff0000u, &bf_status);
-    t1 = float32_add(t1, t2, &bf_status);
-    t1 = float32_add(sum, t1, &bf_status);
+    t1 = float32_mul(e1 << 16, e2 << 16, fpst);
+    t2 = float32_mul(e1 & 0xffff0000u, e2 & 0xffff0000u, fpst);
+    t1 = float32_add(t1, t2, fpst);
+    t1 = float32_add(sum, t1, fpst);
 
     return t1;
 }
 
+float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
+                     float_status *fpst, float_status *fpst_odd)
+{
+    g_assert_not_reached();
+}
+
 void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
                         CPUARMState *env, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
     float32 *d = vd, *a = va;
     uint32_t *n = vn, *m = vm;
+    float_status fpst, fpst_odd;
 
-    for (i = 0; i < opr_sz / 4; ++i) {
-        d[i] = bfdotadd(a[i], n[i], m[i]);
+    if (is_ebf(env, &fpst, &fpst_odd)) {
+        for (i = 0; i < opr_sz / 4; ++i) {
+            d[i] = bfdotadd_ebf(a[i], n[i], m[i], &fpst, &fpst_odd);
+        }
+    } else {
+        for (i = 0; i < opr_sz / 4; ++i) {
+            d[i] = bfdotadd(a[i], n[i], m[i], &fpst);
+        }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -2836,12 +2855,23 @@ void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
     intptr_t eltspersegment = MIN(16 / 4, elements);
     float32 *d = vd, *a = va;
     uint32_t *n = vn, *m = vm;
+    float_status fpst, fpst_odd;
 
-    for (i = 0; i < elements; i += eltspersegment) {
-        uint32_t m_idx = m[i + H4(index)];
+    if (is_ebf(env, &fpst, &fpst_odd)) {
+        for (i = 0; i < elements; i += eltspersegment) {
+            uint32_t m_idx = m[i + H4(index)];
 
-        for (j = i; j < i + eltspersegment; j++) {
-            d[j] = bfdotadd(a[j], n[j], m_idx);
+            for (j = i; j < i + eltspersegment; j++) {
+                d[j] = bfdotadd_ebf(a[j], n[j], m_idx, &fpst, &fpst_odd);
+            }
+        }
+    } else {
+        for (i = 0; i < elements; i += eltspersegment) {
+            uint32_t m_idx = m[i + H4(index)];
+
+            for (j = i; j < i + eltspersegment; j++) {
+                d[j] = bfdotadd(a[j], n[j], m_idx, &fpst);
+            }
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
@@ -2853,37 +2883,72 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
     intptr_t s, opr_sz = simd_oprsz(desc);
     float32 *d = vd, *a = va;
     uint32_t *n = vn, *m = vm;
+    float_status fpst, fpst_odd;
 
-    for (s = 0; s < opr_sz / 4; s += 4) {
-        float32 sum00, sum01, sum10, sum11;
+    if (is_ebf(env, &fpst, &fpst_odd)) {
+        for (s = 0; s < opr_sz / 4; s += 4) {
+            float32 sum00, sum01, sum10, sum11;
 
-        /*
-         * Process the entire segment at once, writing back the
-         * results only after we've consumed all of the inputs.
-         *
-         * Key to indices by column:
-         *               i   j           i   k             j   k
-         */
-        sum00 = a[s + H4(0 + 0)];
-        sum00 = bfdotadd(sum00, n[s + H4(0 + 0)], m[s + H4(0 + 0)]);
-        sum00 = bfdotadd(sum00, n[s + H4(0 + 1)], m[s + H4(0 + 1)]);
+            /*
+             * Process the entire segment at once, writing back the
+             * results only after we've consumed all of the inputs.
+             *
+             * Key to indices by column:
+             *               i   j               i   k             j   k
+             */
+            sum00 = a[s + H4(0 + 0)];
+            sum00 = bfdotadd_ebf(sum00, n[s + H4(0 + 0)], m[s + H4(0 + 0)], &fpst, &fpst_odd);
+            sum00 = bfdotadd_ebf(sum00, n[s + H4(0 + 1)], m[s + H4(0 + 1)], &fpst, &fpst_odd);
 
-        sum01 = a[s + H4(0 + 1)];
-        sum01 = bfdotadd(sum01, n[s + H4(0 + 0)], m[s + H4(2 + 0)]);
-        sum01 = bfdotadd(sum01, n[s + H4(0 + 1)], m[s + H4(2 + 1)]);
+            sum01 = a[s + H4(0 + 1)];
+            sum01 = bfdotadd_ebf(sum01, n[s + H4(0 + 0)], m[s + H4(2 + 0)], &fpst, &fpst_odd);
+            sum01 = bfdotadd_ebf(sum01, n[s + H4(0 + 1)], m[s + H4(2 + 1)], &fpst, &fpst_odd);
 
-        sum10 = a[s + H4(2 + 0)];
-        sum10 = bfdotadd(sum10, n[s + H4(2 + 0)], m[s + H4(0 + 0)]);
-        sum10 = bfdotadd(sum10, n[s + H4(2 + 1)], m[s + H4(0 + 1)]);
+            sum10 = a[s + H4(2 + 0)];
+            sum10 = bfdotadd_ebf(sum10, n[s + H4(2 + 0)], m[s + H4(0 + 0)], &fpst, &fpst_odd);
+            sum10 = bfdotadd_ebf(sum10, n[s + H4(2 + 1)], m[s + H4(0 + 1)], &fpst, &fpst_odd);
 
-        sum11 = a[s + H4(2 + 1)];
-        sum11 = bfdotadd(sum11, n[s + H4(2 + 0)], m[s + H4(2 + 0)]);
-        sum11 = bfdotadd(sum11, n[s + H4(2 + 1)], m[s + H4(2 + 1)]);
+            sum11 = a[s + H4(2 + 1)];
+            sum11 = bfdotadd_ebf(sum11, n[s + H4(2 + 0)], m[s + H4(2 + 0)], &fpst, &fpst_odd);
+            sum11 = bfdotadd_ebf(sum11, n[s + H4(2 + 1)], m[s + H4(2 + 1)], &fpst, &fpst_odd);
 
-        d[s + H4(0 + 0)] = sum00;
-        d[s + H4(0 + 1)] = sum01;
-        d[s + H4(2 + 0)] = sum10;
-        d[s + H4(2 + 1)] = sum11;
+            d[s + H4(0 + 0)] = sum00;
+            d[s + H4(0 + 1)] = sum01;
+            d[s + H4(2 + 0)] = sum10;
+            d[s + H4(2 + 1)] = sum11;
+        }
+    } else {
+        for (s = 0; s < opr_sz / 4; s += 4) {
+            float32 sum00, sum01, sum10, sum11;
+
+            /*
+             * Process the entire segment at once, writing back the
+             * results only after we've consumed all of the inputs.
+             *
+             * Key to indices by column:
+             *               i   j           i   k             j   k
+             */
+            sum00 = a[s + H4(0 + 0)];
+            sum00 = bfdotadd(sum00, n[s + H4(0 + 0)], m[s + H4(0 + 0)], &fpst);
+            sum00 = bfdotadd(sum00, n[s + H4(0 + 1)], m[s + H4(0 + 1)], &fpst);
+
+            sum01 = a[s + H4(0 + 1)];
+            sum01 = bfdotadd(sum01, n[s + H4(0 + 0)], m[s + H4(2 + 0)], &fpst);
+            sum01 = bfdotadd(sum01, n[s + H4(0 + 1)], m[s + H4(2 + 1)], &fpst);
+
+            sum10 = a[s + H4(2 + 0)];
+            sum10 = bfdotadd(sum10, n[s + H4(2 + 0)], m[s + H4(0 + 0)], &fpst);
+            sum10 = bfdotadd(sum10, n[s + H4(2 + 1)], m[s + H4(0 + 1)], &fpst);
+
+            sum11 = a[s + H4(2 + 1)];
+            sum11 = bfdotadd(sum11, n[s + H4(2 + 0)], m[s + H4(2 + 0)], &fpst);
+            sum11 = bfdotadd(sum11, n[s + H4(2 + 1)], m[s + H4(2 + 1)], &fpst);
+
+            d[s + H4(0 + 0)] = sum00;
+            d[s + H4(0 + 1)] = sum01;
+            d[s + H4(2 + 0)] = sum10;
+            d[s + H4(2 + 1)] = sum11;
+        }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1



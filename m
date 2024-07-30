Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E335DC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpJu-00042E-Rx; Tue, 30 Jul 2024 12:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJt-0003ta-5s
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:25 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYpJp-0000Hq-1G
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:03:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso2500687f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722355399; x=1722960199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QvrVCRfMbrZEGuOW0qBR5GVSvdV1DpAOaaHu4y3CbnQ=;
 b=P8mj6AsfbcfFPnCOdFCEkJSptuWiJODlsjFF4wmL4k1XzeEecJ9+z0lZTSc/n/Ne8a
 pPlkBD5LGNSoCIY5dXcr8Su6xQMABiKFMMKB3V2EOhcLfn6TjUdCmSAwukGh/nrnqXca
 3x3aPFZ/AT9kC/rE59OqMXPluPcYzwBO6xM5SoA4eug2TV+s9lGXLROHAD48yb4L+OCX
 UfeXWSMW5ryzifFDM29ELrJKQyuvqojmyZvlRnkJnXePB6MDgevNGdBXkqyb/Y7JgLG1
 SI+FZJEcVBk08WbjUxUXNNWGJiM0qqDNqma37RZErAiC5CbTYKK0+E1oGYCdvLKsauI2
 j8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722355399; x=1722960199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QvrVCRfMbrZEGuOW0qBR5GVSvdV1DpAOaaHu4y3CbnQ=;
 b=BvvIzNqyW8AzKZjyAbrvzfXfb/aDmzgPPWG4NoNqy3UxjZ8+84pXOb1k+mFa21XXc8
 CeiKBHqP1nx7U1xsUTV8vBMkDYJ56mWjbtTR8137dMp31gfjdcX1pXztbPFFVGcZTtZE
 h7CiOpqhCj45FSHRfc/3wx8G2frFMhl+ndJoXS41fwaCSclX9k2aJr+y5sa/q/vzRHov
 0rXz9wy+/aITH+PZJNQIBnjE/tQTJzYO7yVKC/Lvby+1M04ioCU0gdDCLBSi/Qm2ttEh
 292Y0q0LGYunjz6hPAco9hH7k8MUpo2hOm+obKbTdGUaEKCTyId+iEJBu6sDFkrKDPSX
 RLgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVollNT/f45JIhyKo4pOJWszkqbTy4EQXKuUWi6NORvuzi05pphR0Ruu8ESO/3Wd9Acq4ip9lKcS3LXgbDt4NyDq3Hz3+c=
X-Gm-Message-State: AOJu0YzHYLPlw181cyeQsVFs/XQb1CyxvNv25y5UX5uS4VbDbIUBoShu
 eGB8AptEBDjJNvR6COO972Y2w4d1vBIFxey21HXTXkjVdEAKtYt/wevusaojPFs=
X-Google-Smtp-Source: AGHT+IFATCG8GZGJDx84yDEt+a6U8QpXMwCDxSwhlh6mdDK32eVghfZVEYIbvR0rW6qNoANzj5olIw==
X-Received: by 2002:a05:6000:110a:b0:367:98e6:362b with SMTP id
 ffacd0b85a97d-36b5d353ad0mr6460218f8f.42.1722355398982; 
 Tue, 30 Jul 2024 09:03:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b3685810csm15001676f8f.71.2024.07.30.09.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:03:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 6/8] target/arm: Prepare bfdotadd() callers for FEAT_EBF
 support
Date: Tue, 30 Jul 2024 17:03:04 +0100
Message-Id: <20240730160306.2959745-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730160306.2959745-1-peter.maydell@linaro.org>
References: <20240730160306.2959745-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
---
 target/arm/tcg/vec_internal.h |  37 ++++++++-
 target/arm/tcg/sme_helper.c   |  74 ++++++++++++------
 target/arm/tcg/vec_helper.c   | 141 +++++++++++++++++++++++++---------
 3 files changed, 192 insertions(+), 60 deletions(-)

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
index f172225b2f2..e3fbfa98fa5 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1086,32 +1086,62 @@ void HELPER(sme_bfmopa)(CPUARMState *env, void *vza, void *vzn, void *vzm,
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
index 77efb5f47d8..baf04a0561b 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2790,7 +2790,7 @@ DO_MMLA_B(gvec_usmmla_b, do_usmmla_b)
  * BFloat16 Dot Product
  */
 
-float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2)
+bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
 {
     /* FPCR is ignored for BFDOT and BFMMLA. */
     float_status bf_status = {
@@ -2800,29 +2800,50 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2)
         .flush_inputs_to_zero = true,
         .default_nan_mode = true,
     };
+
+    *statusp = bf_status;
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
                         void *envp, uint32_t desc)
 {
+    CPUARMState *env = envp;
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
@@ -2830,18 +2851,30 @@ void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
 void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
                             void *va, void *envp, uint32_t desc)
 {
+    CPUARMState *env = envp;
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     intptr_t index = simd_data(desc);
     intptr_t elements = opr_sz / 4;
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
@@ -2850,40 +2883,76 @@ void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
 void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
                          void *envp, uint32_t desc)
 {
+    CPUARMState *env = envp;
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



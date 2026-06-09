Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F39CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX26F-0000FO-Pj; Tue, 09 Jun 2026 15:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21p-0003Xo-LM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21e-0003zP-DM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:20 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2bf0ddaf50fso41436605ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032873; x=1781637673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3KKJ7J3R4+CnAV2Vfwd1LHSE2hHDpi2i4scacdU0+A=;
 b=J+b5MMOq7mUTVYo9pQePU3WTjb64dbT3huoEwdNxcAa2nVPqywyv+MtOc31Kp4r9I7
 juGhBk09ayBRe1PF3aR7GOd1+9eZGgmEi8PUvskE/2pvMjYqbbkF7b34C1aMQ3ZrLtZ8
 Vg4MOpvBPgs3C3hCpj7bcwlYO1M1EU4EsVyrKaLhu2qEUBcgNS0ihLbqVJex6kmiViDS
 50vj0eW3bDEElmKaSmfTGV2N1mVAHrZI7N06R0TPFWA14E/31g+eiBvFEBwDa8mp4/Qc
 IONIbuWWzFJ6bnES9O22V7fBl3xYY0OpYeGdH9Ew8mIZLs3GRhf1+R/O9EMX5LiHmT9I
 l6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032873; x=1781637673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X3KKJ7J3R4+CnAV2Vfwd1LHSE2hHDpi2i4scacdU0+A=;
 b=HuMDyAUH9nmNVHUPFCg7Qk+kG7yqId+gwhHI5WRgHkTjr1oCP/IGWOjDzRYlLSG76v
 I6LlRAEF+ULJvtAk2gcLmCluCj8DWlJjgGsMkJYFVCOymVB3HIBkQa/GEgxGrknsMJFM
 X7VkreZ28Qb3HmYYmGADHprq3NngYNjYMmrpyi1lX3vYS1tMIrCz02c/5XwNJ74hTUmZ
 yn8W8YfWaHbTI93H8evUFcyzpAmwWX57fkib1Luqq0Es2FrYlMmfJ0tRDRFehvdBuC4Q
 pHokTAMJMnCKzjO8kusmtPsgph7ALaCE6OEfg9FNSZEtlScI/+/RJ5Q2FUypAteI6WCp
 L74A==
X-Gm-Message-State: AOJu0Yx2J5ptdEyNgIeoxHpYdWNQXQzwkTgC4zYPiDpu/51MBFs3sMJW
 TJTk6KTee3ZN/GrHCNQwlMrFHBCI9cOyg+fPVdZ/geZWd2MX8J9LopGirU9Po9nQvAqoMijoh59
 tvhuzRTc=
X-Gm-Gg: Acq92OGpwdj3FPWXSarozmDz8pHYQWpuq+GrZs0gUjQ78XzgyKUOztqTrLnZy3QLznc
 Aa1Gsymr5PB5jUE+Zx28+3+fUDKmso3jiH4hAdeVvbIf7a5I0bSrmZDgdDW7m2HW2yLc/Tn4EFB
 3Gy3827j5RmpzEloO3CYlYyfiROoR/wFIvQ3WvlZDI7rXrlD8InB7pXLdoAFfoP4sWDFLMChix6
 HXwsKGHXjFbSmpCFYcmdofKZHakVor/RFBaFi5c5Tco4JTHcQlfA3AxsdPq5nbtGiAeED6f2mzd
 9crwp1wu+19i/1L/xjFnasWbO6ztKDieoOmEocPd2FzcVmjw7mcJKyVlRNk2reZp1quQ1JXq1lK
 j9kbnvlC4XEP8bseogWopuWeLTpYU2eVg6jzebIVlxl8BtRI2FQ5XROW4K62fyQ5T5NmD7p6LqF
 SMNpt0GBqr7ZUlV0juOojHpEP+nCYaijJ9mubsSJA=
X-Received: by 2002:a17:903:138a:b0:2b4:6d92:b002 with SMTP id
 d9443c01a7336-2c1e820e32cmr227853125ad.37.1781032872703; 
 Tue, 09 Jun 2026 12:21:12 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 02/45] target/arm: Drop oddstatus from is_ebf and
 bfdotadd_ebf
Date: Tue,  9 Jun 2026 12:20:26 -0700
Message-ID: <20260609192110.752384-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This argument is no longer used.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260517002550.321291-10-richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 12 +++------
 target/arm/tcg/sme_helper.c   |  6 ++---
 target/arm/tcg/vec_helper.c   | 50 +++++++++++++++--------------------
 3 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 84f7f15228..06fef2a209 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -271,7 +271,6 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst);
  * @sum: addend
  * @e1, @e2: multiplicand vectors
  * @fpst: floating-point status to use
- * @fpst_odd: floating-point status to use for round-to-odd operations
  *
  * BFloat16 2-way dot product of @e1 & @e2, accumulating with @sum.
  * The @e1 and @e2 operands correspond to the 32-bit source vector
@@ -280,23 +279,20 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst);
  * Corresponds to the ARM pseudocode function BFDotAdd, specialized
  * for the FPCR.EBF == 1 case.
  */
-float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
-                     float_status *fpst, float_status *fpst_odd);
+float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst);
 
 /**
  * is_ebf:
  * @env: CPU state
  * @statusp: pointer to floating point status to fill in
- * @oddstatusp: pointer to floating point status to fill in for round-to-odd
  *
  * Determine whether a BFDotAdd operation should use FPCR.EBF = 0
- * or FPCR.EBF = 1 semantics. On return, has initialized *statusp
- * and *oddstatusp to suitable float_status arguments to use with either
- * bfdotadd() or bfdotadd_ebf().
+ * or FPCR.EBF = 1 semantics. On return, has initialized *statusp as suitable
+ * for float_status arguments to either bfdotadd() or bfdotadd_ebf().
  * Returns true for EBF = 1, false for EBF = 0. (The caller should use this
  * to decide whether to call bfdotadd() or bfdotadd_ebf().)
  */
-bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp);
+bool is_ebf(CPUARMState *env, float_status *statusp);
 
 /*
  * Negate as for FPCR.AH=1 -- do not negate NaNs.
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0055e97a2b..376fbd48d4 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1429,9 +1429,9 @@ static void do_bfmopa_w(void *vza, void *vzn, void *vzm,
                         uint32_t desc, uint32_t negx, bool ah_neg)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
-    float_status fpst, fpst_odd;
+    float_status fpst;
 
-    if (is_ebf(env, &fpst, &fpst_odd)) {
+    if (is_ebf(env, &fpst)) {
         for (row = 0; row < oprsz; ) {
             uint16_t prow = pn[H2(row >> 4)];
             do {
@@ -1452,7 +1452,7 @@ static void do_bfmopa_w(void *vza, void *vzn, void *vzm,
                             uint32_t m = *(uint32_t *)(vzm + H1_4(col));
 
                             m = f16mop_adj_pair(m, pcol, 0);
-                            *a = bfdotadd_ebf(*a, n, m, &fpst, &fpst_odd);
+                            *a = bfdotadd_ebf(*a, n, m, &fpst);
                         }
                         col += 4;
                         pcol >>= 4;
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 12fb62958f..bd8ae5d6a4 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2845,7 +2845,7 @@ DO_MMLA_B(gvec_usmmla_b, do_usmmla_b)
  * BFloat16 Dot Product
  */
 
-bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
+bool is_ebf(CPUARMState *env, float_status *statusp)
 {
     /*
      * For BFDOT, BFMMLA, etc, the behaviour depends on FPCR.EBF.
@@ -2865,11 +2865,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
     *statusp = env->vfp.fp_status[is_a64(env) ? FPST_A64 : FPST_A32];
     set_default_nan_mode(true, statusp);
 
-    if (ebf) {
-        /* EBF=1 needs to do a step with round-to-odd semantics */
-        *oddstatusp = *statusp;
-        set_float_rounding_mode(float_round_to_odd, oddstatusp);
-    } else {
+    if (!ebf) {
         set_flush_to_zero(true, statusp);
         set_flush_inputs_to_zero(true, statusp);
         set_float_rounding_mode(float_round_to_odd_inf, statusp);
@@ -2893,8 +2889,7 @@ float32 bfdotadd(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
     return t1;
 }
 
-float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2,
-                     float_status *fpst, float_status *fpst_odd)
+float32 bfdotadd_ebf(float32 sum, uint32_t e1, uint32_t e2, float_status *fpst)
 {
     /* Unpack two BFloat16 into two Float32, trivially. */
     float32 s1r = e1 << 16;
@@ -2964,11 +2959,11 @@ void HELPER(gvec_bfdot)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, opr_sz = simd_oprsz(desc);
     float32 *d = vd, *a = va;
     uint32_t *n = vn, *m = vm;
-    float_status fpst, fpst_odd;
+    float_status fpst;
 
-    if (is_ebf(env, &fpst, &fpst_odd)) {
+    if (is_ebf(env, &fpst)) {
         for (i = 0; i < opr_sz / 4; ++i) {
-            d[i] = bfdotadd_ebf(a[i], n[i], m[i], &fpst, &fpst_odd);
+            d[i] = bfdotadd_ebf(a[i], n[i], m[i], &fpst);
         }
     } else {
         for (i = 0; i < opr_sz / 4; ++i) {
@@ -2987,14 +2982,14 @@ void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
     intptr_t eltspersegment = MIN(16 / 4, elements);
     float32 *d = vd, *a = va;
     uint32_t *n = vn, *m = vm;
-    float_status fpst, fpst_odd;
+    float_status fpst;
 
-    if (is_ebf(env, &fpst, &fpst_odd)) {
+    if (is_ebf(env, &fpst)) {
         for (i = 0; i < elements; i += eltspersegment) {
             uint32_t m_idx = m[i + H4(index)];
 
             for (j = i; j < i + eltspersegment; j++) {
-                d[j] = bfdotadd_ebf(a[j], n[j], m_idx, &fpst, &fpst_odd);
+                d[j] = bfdotadd_ebf(a[j], n[j], m_idx, &fpst);
             }
         }
     } else {
@@ -3021,17 +3016,16 @@ void HELPER(sme2_bfvdot_idx)(void *vd, void *vn, void *vm,
     uint16_t *n0 = vn;
     uint16_t *n1 = vn + sizeof(ARMVectorReg);
     uint32_t *m = vm;
-    float_status fpst, fpst_odd;
+    float_status fpst;
 
-    if (is_ebf(env, &fpst, &fpst_odd)) {
+    if (is_ebf(env, &fpst)) {
         for (i = 0; i < elements; i += eltspersegment) {
             uint32_t m_idx = m[i + H4(idx)];
 
             for (j = 0; j < eltspersegment; j++) {
                 uint32_t nn = (n0[H2(2 * (i + j) + sel)])
                             | (n1[H2(2 * (i + j) + sel)] << 16);
-                d[i + H4(j)] = bfdotadd_ebf(a[i + H4(j)], nn, m_idx,
-                                            &fpst, &fpst_odd);
+                d[i + H4(j)] = bfdotadd_ebf(a[i + H4(j)], nn, m_idx, &fpst);
             }
         }
     } else {
@@ -3054,9 +3048,9 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
     intptr_t s, opr_sz = simd_oprsz(desc);
     float32 *d = vd, *a = va;
     uint32_t *n = vn, *m = vm;
-    float_status fpst, fpst_odd;
+    float_status fpst;
 
-    if (is_ebf(env, &fpst, &fpst_odd)) {
+    if (is_ebf(env, &fpst)) {
         for (s = 0; s < opr_sz / 4; s += 4) {
             float32 sum00, sum01, sum10, sum11;
 
@@ -3068,20 +3062,20 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
              *               i   j               i   k             j   k
              */
             sum00 = a[s + H4(0 + 0)];
-            sum00 = bfdotadd_ebf(sum00, n[s + H4(0 + 0)], m[s + H4(0 + 0)], &fpst, &fpst_odd);
-            sum00 = bfdotadd_ebf(sum00, n[s + H4(0 + 1)], m[s + H4(0 + 1)], &fpst, &fpst_odd);
+            sum00 = bfdotadd_ebf(sum00, n[s + H4(0 + 0)], m[s + H4(0 + 0)], &fpst);
+            sum00 = bfdotadd_ebf(sum00, n[s + H4(0 + 1)], m[s + H4(0 + 1)], &fpst);
 
             sum01 = a[s + H4(0 + 1)];
-            sum01 = bfdotadd_ebf(sum01, n[s + H4(0 + 0)], m[s + H4(2 + 0)], &fpst, &fpst_odd);
-            sum01 = bfdotadd_ebf(sum01, n[s + H4(0 + 1)], m[s + H4(2 + 1)], &fpst, &fpst_odd);
+            sum01 = bfdotadd_ebf(sum01, n[s + H4(0 + 0)], m[s + H4(2 + 0)], &fpst);
+            sum01 = bfdotadd_ebf(sum01, n[s + H4(0 + 1)], m[s + H4(2 + 1)], &fpst);
 
             sum10 = a[s + H4(2 + 0)];
-            sum10 = bfdotadd_ebf(sum10, n[s + H4(2 + 0)], m[s + H4(0 + 0)], &fpst, &fpst_odd);
-            sum10 = bfdotadd_ebf(sum10, n[s + H4(2 + 1)], m[s + H4(0 + 1)], &fpst, &fpst_odd);
+            sum10 = bfdotadd_ebf(sum10, n[s + H4(2 + 0)], m[s + H4(0 + 0)], &fpst);
+            sum10 = bfdotadd_ebf(sum10, n[s + H4(2 + 1)], m[s + H4(0 + 1)], &fpst);
 
             sum11 = a[s + H4(2 + 1)];
-            sum11 = bfdotadd_ebf(sum11, n[s + H4(2 + 0)], m[s + H4(2 + 0)], &fpst, &fpst_odd);
-            sum11 = bfdotadd_ebf(sum11, n[s + H4(2 + 1)], m[s + H4(2 + 1)], &fpst, &fpst_odd);
+            sum11 = bfdotadd_ebf(sum11, n[s + H4(2 + 0)], m[s + H4(2 + 0)], &fpst);
+            sum11 = bfdotadd_ebf(sum11, n[s + H4(2 + 1)], m[s + H4(2 + 1)], &fpst);
 
             d[s + H4(0 + 0)] = sum00;
             d[s + H4(0 + 1)] = sum01;
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E68C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCWn-0002k8-Sa; Fri, 28 Jun 2024 10:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCWW-0002ar-HU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:28 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCW7-0004VM-TN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:24:18 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52e764bb3fbso855234e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719584634; x=1720189434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w7xsCqJG+GOkokM323EFwKmfjonAJNK39VxKpZVtgHA=;
 b=cNOE/Wd8+lVDqhVzzDKZ7yP15aH5GyxLkyHQo7El6nThpNnHYlsf8sNPMQx8x5tx05
 qIyxmsUF2WpkNfJwSoRYvkpkMzyP7vO4TwCwgvprp+f8KSiXVs0FzJFVxzztVypfxLB4
 Cf//JSB81yFgBA1lRbq4d6L9kzH+gcogSn/FybojZTi5X9CsyXq/RD1uXgULs693E/vs
 56u2f83yOd8wBPxzERNamejCUZvPfMNGj/J12rGmdXZOzn5Yn/edMhUupDG/pC8jUB8u
 qfU47ub67M2IgS48+J9BpCX4DVftWNMB8lWx7TSseL5SLuslr01M9MbnTacjlFYH3X5H
 o16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719584634; x=1720189434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7xsCqJG+GOkokM323EFwKmfjonAJNK39VxKpZVtgHA=;
 b=r/wKumLSJSC5Qg0zrMZmaFdmh9s6TtGZNtG2gnoz7A2hs/ATafn7uluwF1bbYGrqkc
 52A3qAsDe1uFsgcJGPDKRP2lNPE7OvN7iqocTZIoE+0FMo8EuNSnhY/owoM+EoPcEZkV
 Tl/sB3wAZmhwxfjRYnW910hbNJW4r9cluZV5y+Q3yKSXVAl5LLk6xs8sbhyhUGojy5IQ
 mYo9WPX7B2LOT+glIT2C+J0nmTTklHpSme5hxLt0nVhQF6DHkk1+b6LIk02CEYgDUndF
 vaz/btG/AspfQoaSus17XWIpA6ez9CMpsOfSideL421r6P+hRa05te/akpAAOTKK0e8R
 9I9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpnafNS6AltMts3FIqccBZJHAx15BPi3BJqLkLWnmwUDdJatRjBsSX/GfDAvP+cttLjIwroiW2pup6zdSQXuA4bCQvhLs=
X-Gm-Message-State: AOJu0YyEv9XQDK35j7+iw0KuqafnrrplgIhVb6UBYbnC63w+X3DGsRJn
 urTaO4aaCvtln1futxW3xa6NwFWVBz+WGlYcO3BmrWaVITxdlgzP8ZuNXNs2XPmTBZOOi1GOTiY
 Dc8I=
X-Google-Smtp-Source: AGHT+IGGXj7PLrUym61VI8FobdhCeCebYTtR1FCy5FVVyWZGMH+qgDWcLnp0f8kqaTFq5k4oisf1zw==
X-Received: by 2002:a05:6512:3caa:b0:52c:cccf:85e1 with SMTP id
 2adb3069b0e04-52ce1865a49mr14550208e87.65.1719584634295; 
 Fri, 28 Jun 2024 07:23:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55c0asm37180945e9.15.2024.06.28.07.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 07:23:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/9] target/arm: Make vfp_set_fpscr() call vfp_set_{fpcr, fpsr}
Date: Fri, 28 Jun 2024 15:23:41 +0100
Message-Id: <20240628142347.1283015-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142347.1283015-1-peter.maydell@linaro.org>
References: <20240628142347.1283015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Make vfp_set_fpscr() call vfp_set_fpsr() and vfp_set_fpcr()
instead of the other way around.

The masking we do when getting and setting vfp.xregs[ARM_VFP_FPSCR]
is a little awkward, but we are going to change where we store the
underlying FPSR and FPCR information in a later commit, so it will
go away then.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        |  22 +++++----
 target/arm/vfp_helper.c | 100 ++++++++++++++++++++++++++--------------
 2 files changed, 78 insertions(+), 44 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 68a9922f88e..0a570afcab4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1730,17 +1730,19 @@ uint32_t vfp_get_fpsr(CPUARMState *env);
  */
 uint32_t vfp_get_fpcr(CPUARMState *env);
 
-static inline void vfp_set_fpsr(CPUARMState *env, uint32_t val)
-{
-    uint32_t new_fpscr = (vfp_get_fpscr(env) & ~FPSR_MASK) | (val & FPSR_MASK);
-    vfp_set_fpscr(env, new_fpscr);
-}
+/**
+ * vfp_set_fpsr: write the AArch64 FPSR
+ * @env: CPU context
+ * @value: new value
+ */
+void vfp_set_fpsr(CPUARMState *env, uint32_t value);
 
-static inline void vfp_set_fpcr(CPUARMState *env, uint32_t val)
-{
-    uint32_t new_fpscr = (vfp_get_fpscr(env) & ~FPCR_MASK) | (val & FPCR_MASK);
-    vfp_set_fpscr(env, new_fpscr);
-}
+/**
+ * vfp_set_fpcr: write the AArch64 FPCR
+ * @env: CPU context
+ * @value: new value
+ */
+void vfp_set_fpcr(CPUARMState *env, uint32_t value);
 
 enum arm_cpu_mode {
   ARM_CPU_MODE_USR = 0x10,
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index a87d39e4d9b..38c8aadf9b4 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -99,14 +99,27 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     return vfp_exceptbits_from_host(i);
 }
 
-static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
+static void vfp_set_fpsr_to_host(CPUARMState *env, uint32_t val)
+{
+    /*
+     * The exception flags are ORed together when we read fpscr so we
+     * only need to preserve the current state in one of our
+     * float_status values.
+     */
+    int i = vfp_exceptbits_to_host(val);
+    set_float_exception_flags(i, &env->vfp.fp_status);
+    set_float_exception_flags(0, &env->vfp.fp_status_f16);
+    set_float_exception_flags(0, &env->vfp.standard_fp_status);
+    set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
+}
+
+static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val)
 {
-    int i;
     uint32_t changed = env->vfp.xregs[ARM_VFP_FPSCR];
 
     changed ^= val;
     if (changed & (3 << 22)) {
-        i = (val >> 22) & 3;
+        int i = (val >> 22) & 3;
         switch (i) {
         case FPROUNDING_TIEEVEN:
             i = float_round_nearest_even;
@@ -141,17 +154,6 @@ static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status);
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
     }
-
-    /*
-     * The exception flags are ORed together when we read fpscr so we
-     * only need to preserve the current state in one of our
-     * float_status values.
-     */
-    i = vfp_exceptbits_to_host(val);
-    set_float_exception_flags(i, &env->vfp.fp_status);
-    set_float_exception_flags(0, &env->vfp.fp_status_f16);
-    set_float_exception_flags(0, &env->vfp.standard_fp_status);
-    set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);
 }
 
 #else
@@ -161,7 +163,11 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     return 0;
 }
 
-static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
+static void vfp_set_fpsr_to_host(CPUARMState *env, uint32_t val)
+{
+}
+
+static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val)
 {
 }
 
@@ -204,7 +210,37 @@ uint32_t vfp_get_fpscr(CPUARMState *env)
     return HELPER(vfp_get_fpscr)(env);
 }
 
-void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
+void vfp_set_fpsr(CPUARMState *env, uint32_t val)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    vfp_set_fpsr_to_host(env, val);
+
+    if (arm_feature(env, ARM_FEATURE_NEON) ||
+        cpu_isar_feature(aa32_mve, cpu)) {
+        /*
+         * The bit we set within fpscr_q is arbitrary; the register as a
+         * whole being zero/non-zero is what counts.
+         */
+        env->vfp.qc[0] = val & FPCR_QC;
+        env->vfp.qc[1] = 0;
+        env->vfp.qc[2] = 0;
+        env->vfp.qc[3] = 0;
+    }
+
+    /*
+     * The only FPSR bits we keep in vfp.xregs[FPSCR] are NZCV:
+     * the exception flags IOC|DZC|OFC|UFC|IXC|IDC are stored in
+     * fp_status, and QC is in vfp.qc[]. Store the NZCV bits there,
+     * and zero any of the other FPSR bits (but preserve the FPCR
+     * bits).
+     */
+    val &= FPCR_NZCV_MASK;
+    env->vfp.xregs[ARM_VFP_FPSCR] &= ~FPSR_MASK;
+    env->vfp.xregs[ARM_VFP_FPSCR] |= val;
+}
+
+void vfp_set_fpcr(CPUARMState *env, uint32_t val)
 {
     ARMCPU *cpu = env_archcpu(env);
 
@@ -213,7 +249,7 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         val &= ~FPCR_FZ16;
     }
 
-    vfp_set_fpscr_to_host(env, val);
+    vfp_set_fpcr_to_host(env, val);
 
     if (!arm_feature(env, ARM_FEATURE_M)) {
         /*
@@ -231,28 +267,24 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
                                      FPCR_LTPSIZE_LENGTH);
     }
 
-    if (arm_feature(env, ARM_FEATURE_NEON) ||
-        cpu_isar_feature(aa32_mve, cpu)) {
-        /*
-         * The bit we set within fpscr_q is arbitrary; the register as a
-         * whole being zero/non-zero is what counts.
-         */
-        env->vfp.qc[0] = val & FPCR_QC;
-        env->vfp.qc[1] = 0;
-        env->vfp.qc[2] = 0;
-        env->vfp.qc[3] = 0;
-    }
-
     /*
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
      *
-     * The exception flags IOC|DZC|OFC|UFC|IXC|IDC are stored in
-     * fp_status; QC, Len and Stride are stored separately earlier.
-     * Clear out all of those and the RES0 bits: only NZCV, AHP, DN,
-     * FZ, RMode and FZ16 are kept in vfp.xregs[FPSCR].
+     * The FPCR bits we keep in vfp.xregs[FPSCR] are AHP, DN, FZ, RMode
+     * and FZ16. Len, Stride and LTPSIZE we just handled. Store those bits
+     * there, and zero any of the other FPCR bits and the RES0 and RAZ/WI
+     * bits.
      */
-    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
+    val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16;
+    env->vfp.xregs[ARM_VFP_FPSCR] &= ~FPCR_MASK;
+    env->vfp.xregs[ARM_VFP_FPSCR] |= val;
+}
+
+void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
+{
+    vfp_set_fpcr(env, val & FPCR_MASK);
+    vfp_set_fpsr(env, val & FPSR_MASK);
 }
 
 void vfp_set_fpscr(CPUARMState *env, uint32_t val)
-- 
2.34.1



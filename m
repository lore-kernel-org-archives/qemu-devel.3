Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695FDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthC-0001Ur-Vk; Thu, 11 Jul 2024 09:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthA-0001Ln-CO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00062s-2g
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4265c2b602aso5787705e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703906; x=1721308706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pJLV+t+JilF0SH5EtsF88drIRKMO5yOUsex+mYBfC5M=;
 b=nxXgWBQ/bGIA2Nae7aB9TxUMg+/MmmcmJmLo90Kgw07lVgmK29Lqk4jQeMpRuITAVX
 Q9MS2YmXJh7gMImo4zt6TUj/CUorrTLmTmTo30FYDCIVEXDWkcK5QZKJcvygl6i1cwtu
 Rc/64PEy7NmBihuv6MFNTrzsGCC6IfRIrXqxrUzqbzzOIU6bK/MYbXZsvQzM1i4igVu8
 xYNQgSj3c9OnC8kPlnaDQtFFf7D3yoXnXWgiRtzotFGIlslQyULZ4ltBczqKy6rwJbx9
 jNqE7S+1FAC7l77oufSb/iYzuXpDMmYu9qC6EViwgHiC35Uf0OWzVXXLw/xv+ySOgSeb
 nK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703906; x=1721308706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJLV+t+JilF0SH5EtsF88drIRKMO5yOUsex+mYBfC5M=;
 b=qzkkXuBZnPjB2Fo1endQa5EygRrdxqFjh5tsjEhEdd2Z1Eo64Ebk56zCBUAus5F6Pm
 vqC2GoeIIGG2SWOFPTBxHw3x0NcaCYlPL3g9a4TCyzYDYleMFSA71HYkbvgjjrAf2467
 xMMb4f8Nma0vnCYKWDwOrL7ZJUCJZih3jA9Noz+Txu77qEmXpnSFobTFAkH+CLOnU0Yj
 zmcmMQJEEf1wg70N0Q5l94DdEwPKqaMqnmAhst2vDevEhI+j31ITTeDFdZsEsuI4KPWW
 NyR32qoPhxtIoascc7suhbxQb1UeTyylLaoap2nmepRxElVzEZ4aRCUK4WHRVb+6WWte
 0GlA==
X-Gm-Message-State: AOJu0Yx2A2xVDODKW+sEE02jM1FBICVLY3TXJIZvLk4QrtdQm47PLgOt
 SjFxqX7JBdM4K0crA2lo59YCpc/ayekmHMRY7HhdO65x7w2AVfMKgo3uHF+FG+5WhqoaAUaI9iW
 Mr1s=
X-Google-Smtp-Source: AGHT+IHKTge+FcdPTxX7UvhOXWH2w7ZICcH1kX/79iQjbxi/Lz1NF3ztFk8NreYOd5dDX3MBTFYdqw==
X-Received: by 2002:a05:600c:460a:b0:426:51d1:63c3 with SMTP id
 5b1f17b1804b1-426708fa8e2mr53904995e9.38.1720703906151; 
 Thu, 11 Jul 2024 06:18:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/24] target/arm: Make vfp_set_fpscr() call vfp_set_{fpcr,
 fpsr}
Date: Thu, 11 Jul 2024 14:18:01 +0100
Message-Id: <20240711131822.3909903-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240628142347.1283015-4-peter.maydell@linaro.org
---
 target/arm/cpu.h        |  22 +++++----
 target/arm/vfp_helper.c | 100 ++++++++++++++++++++++++++--------------
 2 files changed, 78 insertions(+), 44 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index abeb2f89764..b1b48c1d775 100644
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
index f0692f0c811..678de5eb6f7 100644
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
+         * The bit we set within vfp.qc[] is arbitrary; the array as a
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



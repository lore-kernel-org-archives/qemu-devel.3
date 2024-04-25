Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A2EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWR-00020K-I4; Thu, 25 Apr 2024 06:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWO-0001yr-G5
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:08 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWL-00079h-PG
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:08 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2dcc8d10d39so9275791fa.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041604; x=1714646404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+/rRCyBjJYpKJB9PngM6SBcXpQkobdS6pXKimrxoEgk=;
 b=H9VbUmafxYPwitIICHFo5rPAdBugFdUpeJmJiQF0yajGZAL+tBilmRZw1b/3vyOW79
 MIkWpD8KJaX2XBYVqg1g3BMYODichKZj36/2FJl1+FCMkQyrtsgXdRlzwIOfMZRT4LXb
 zTjTORNbKDgki+kX5jcIl5hU23rPnrnjFh6x+/vIGsyDTLNT5eGiZM26yGC7zxaVL/wP
 n++vtW+eyNCe0kfwzsOpsfGeNEKAFXw5D6buatTSeSpl8YwRTb0G0xaW8EBSlEjZdGl9
 BNRVsiNxYgCSQkJ6etelMtcsOjwsrVf63YXlQphQM9NCXxA3XvulePwLgsrBsyrgaIVZ
 0+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041604; x=1714646404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/rRCyBjJYpKJB9PngM6SBcXpQkobdS6pXKimrxoEgk=;
 b=g5RLNvNg9hW3WWcw+i/UMIRi2aORt4GbLfKyDfI7wMcevCRUFrogUbCOue8hcdWxDG
 dsVdW58F9326MdNjQd83oZegeWf40HLTYFRG6VGyfJpGo1YQUZU2NxcyRKrv7T66T1SA
 Te7rG/KDOlbsQ4OYCxsSUjnBwT7uk2YOkXrm0VAU3JYpe12lgTyDgjNLwW2URvB/Mcn2
 fZ5J9NM6AkN2uqorhGXojYE4bSeAZfob6p3opeENT6E3O9Sdun9BHHoeDb2dAqiqq5XH
 ipczyS0DkaWcbBCNyZqQqFjGatJxslJkYEntgsId7aEb9qluqquG7k1ROTH8GxLQ7ti6
 vBsA==
X-Gm-Message-State: AOJu0YxVKWIey1tKbB6sc7mZuw+xVT1M3khSQXQKJqQWszZQBdIjoVdI
 s3lSWkMl20gUgrLxE6LqWHfuo+jmjBsbu6zwL1/fSXrtiuN9NqKMb+vQCK2GHcqy+krxTr2pYRt
 u
X-Google-Smtp-Source: AGHT+IFkRygel/7Wz+gcdBbSZcgt+CnjIqsqWsjmF0XOamCqt94VGpBsgGq3EaLJudaA/8U0lrfLfw==
X-Received: by 2002:ac2:410a:0:b0:51b:7c36:da61 with SMTP id
 b10-20020ac2410a000000b0051b7c36da61mr3233607lfi.56.1714041603764; 
 Thu, 25 Apr 2024 03:40:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/37] target/arm: Add support for Non-maskable Interrupt
Date: Thu, 25 Apr 2024 11:39:27 +0100
Message-Id: <20240425103958.3237225-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

This only implements the external delivery method via the GICv3.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-7-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-qom.h   |   5 +-
 target/arm/cpu.h       |   6 ++
 target/arm/internals.h |  18 +++++
 target/arm/cpu.c       | 147 ++++++++++++++++++++++++++++++++++++++---
 target/arm/helper.c    |  33 +++++++--
 5 files changed, 193 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 8e032691dbf..b497667d61e 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -36,11 +36,14 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
 #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
-/* Meanings of the ARMCPU object's four inbound GPIO lines */
+/* Meanings of the ARMCPU object's seven inbound GPIO lines */
 #define ARM_CPU_IRQ 0
 #define ARM_CPU_FIQ 1
 #define ARM_CPU_VIRQ 2
 #define ARM_CPU_VFIQ 3
+#define ARM_CPU_NMI 4
+#define ARM_CPU_VINMI 5
+#define ARM_CPU_VFNMI 6
 
 /* For M profile, some registers are banked secure vs non-secure;
  * these are represented as a 2-element array where the first element
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index de740d223fa..08a6bc50de2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -61,6 +61,9 @@
 #define EXCP_DIVBYZERO      23   /* v7M DIVBYZERO UsageFault */
 #define EXCP_VSERR          24
 #define EXCP_GPC            25   /* v9 Granule Protection Check Fault */
+#define EXCP_NMI            26
+#define EXCP_VINMI          27
+#define EXCP_VFNMI          28
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
@@ -80,6 +83,9 @@
 #define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
 #define CPU_INTERRUPT_VFIQ  CPU_INTERRUPT_TGT_EXT_3
 #define CPU_INTERRUPT_VSERR CPU_INTERRUPT_TGT_INT_0
+#define CPU_INTERRUPT_NMI   CPU_INTERRUPT_TGT_EXT_4
+#define CPU_INTERRUPT_VINMI CPU_INTERRUPT_TGT_EXT_0
+#define CPU_INTERRUPT_VFNMI CPU_INTERRUPT_TGT_INT_1
 
 /* The usual mapping for an AArch64 system register to its AArch32
  * counterpart is for the 32 bit world to have access to the lower
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 516e0584bf5..b53f5e8ff2a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1109,6 +1109,24 @@ void arm_cpu_update_virq(ARMCPU *cpu);
  */
 void arm_cpu_update_vfiq(ARMCPU *cpu);
 
+/**
+ * arm_cpu_update_vinmi: Update CPU_INTERRUPT_VINMI bit in cs->interrupt_request
+ *
+ * Update the CPU_INTERRUPT_VINMI bit in cs->interrupt_request, following
+ * a change to either the input VNMI line from the GIC or the HCRX_EL2.VINMI.
+ * Must be called with the BQL held.
+ */
+void arm_cpu_update_vinmi(ARMCPU *cpu);
+
+/**
+ * arm_cpu_update_vfnmi: Update CPU_INTERRUPT_VFNMI bit in cs->interrupt_request
+ *
+ * Update the CPU_INTERRUPT_VFNMI bit in cs->interrupt_request, following
+ * a change to the HCRX_EL2.VFNMI.
+ * Must be called with the BQL held.
+ */
+void arm_cpu_update_vfnmi(ARMCPU *cpu);
+
 /**
  * arm_cpu_update_vserr: Update CPU_INTERRUPT_VSERR bit
  *
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ab8d007a86c..d2dfd36fd45 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -122,6 +122,13 @@ void arm_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+/*
+ * With SCTLR_ELx.NMI == 0, IRQ with Superpriority is masked identically with
+ * IRQ without Superpriority. Moreover, if the GIC is configured so that
+ * FEAT_GICv3_NMI is only set if FEAT_NMI is set, then we won't ever see
+ * CPU_INTERRUPT_*NMI anyway. So we might as well accept NMI here
+ * unconditionally.
+ */
 static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -129,6 +136,7 @@ static bool arm_cpu_has_work(CPUState *cs)
     return (cpu->power_state != PSCI_OFF)
         && cs->interrupt_request &
         (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
+         | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
          | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
          | CPU_INTERRUPT_EXITTB);
 }
@@ -668,6 +676,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     CPUARMState *env = cpu_env(cs);
     bool pstate_unmasked;
     bool unmasked = false;
+    bool allIntMask = false;
 
     /*
      * Don't take exceptions if they target a lower EL.
@@ -678,13 +687,36 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
         return false;
     }
 
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
+        env->cp15.sctlr_el[target_el] & SCTLR_NMI && cur_el == target_el) {
+        allIntMask = env->pstate & PSTATE_ALLINT ||
+                     ((env->cp15.sctlr_el[target_el] & SCTLR_SPINTMASK) &&
+                      (env->pstate & PSTATE_SP));
+    }
+
     switch (excp_idx) {
+    case EXCP_NMI:
+        pstate_unmasked = !allIntMask;
+        break;
+
+    case EXCP_VINMI:
+        if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
+            /* VINMIs are only taken when hypervized.  */
+            return false;
+        }
+        return !allIntMask;
+    case EXCP_VFNMI:
+        if (!(hcr_el2 & HCR_FMO) || (hcr_el2 & HCR_TGE)) {
+            /* VFNMIs are only taken when hypervized.  */
+            return false;
+        }
+        return !allIntMask;
     case EXCP_FIQ:
-        pstate_unmasked = !(env->daif & PSTATE_F);
+        pstate_unmasked = (!(env->daif & PSTATE_F)) && (!allIntMask);
         break;
 
     case EXCP_IRQ:
-        pstate_unmasked = !(env->daif & PSTATE_I);
+        pstate_unmasked = (!(env->daif & PSTATE_I)) && (!allIntMask);
         break;
 
     case EXCP_VFIQ:
@@ -692,13 +724,13 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
             /* VFIQs are only taken when hypervized.  */
             return false;
         }
-        return !(env->daif & PSTATE_F);
+        return !(env->daif & PSTATE_F) && (!allIntMask);
     case EXCP_VIRQ:
         if (!(hcr_el2 & HCR_IMO) || (hcr_el2 & HCR_TGE)) {
             /* VIRQs are only taken when hypervized.  */
             return false;
         }
-        return !(env->daif & PSTATE_I);
+        return !(env->daif & PSTATE_I) && (!allIntMask);
     case EXCP_VSERR:
         if (!(hcr_el2 & HCR_AMO) || (hcr_el2 & HCR_TGE)) {
             /* VIRQs are only taken when hypervized.  */
@@ -804,6 +836,48 @@ static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
     /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
 
+    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
+        (arm_sctlr(env, cur_el) & SCTLR_NMI)) {
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
+            excp_idx = EXCP_NMI;
+            target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
+            if (arm_excp_unmasked(cs, excp_idx, target_el,
+                                  cur_el, secure, hcr_el2)) {
+                goto found;
+            }
+        }
+        if (interrupt_request & CPU_INTERRUPT_VINMI) {
+            excp_idx = EXCP_VINMI;
+            target_el = 1;
+            if (arm_excp_unmasked(cs, excp_idx, target_el,
+                                  cur_el, secure, hcr_el2)) {
+                goto found;
+            }
+        }
+        if (interrupt_request & CPU_INTERRUPT_VFNMI) {
+            excp_idx = EXCP_VFNMI;
+            target_el = 1;
+            if (arm_excp_unmasked(cs, excp_idx, target_el,
+                                  cur_el, secure, hcr_el2)) {
+                goto found;
+            }
+        }
+    } else {
+        /*
+         * NMI disabled: interrupts with superpriority are handled
+         * as if they didn't have it
+         */
+        if (interrupt_request & CPU_INTERRUPT_NMI) {
+            interrupt_request |= CPU_INTERRUPT_HARD;
+        }
+        if (interrupt_request & CPU_INTERRUPT_VINMI) {
+            interrupt_request |= CPU_INTERRUPT_VIRQ;
+        }
+        if (interrupt_request & CPU_INTERRUPT_VFNMI) {
+            interrupt_request |= CPU_INTERRUPT_VFIQ;
+        }
+    }
+
     if (interrupt_request & CPU_INTERRUPT_FIQ) {
         excp_idx = EXCP_FIQ;
         target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
@@ -867,7 +941,8 @@ void arm_cpu_update_virq(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
 
-    bool new_state = (env->cp15.hcr_el2 & HCR_VI) ||
+    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
+        !(arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VIRQ);
 
     if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VIRQ) != 0)) {
@@ -888,7 +963,8 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
 
-    bool new_state = (env->cp15.hcr_el2 & HCR_VF) ||
+    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VF) &&
+        !(arm_hcrx_el2_eff(env) & HCRX_VFNMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VFIQ);
 
     if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFIQ) != 0)) {
@@ -900,6 +976,48 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
     }
 }
 
+void arm_cpu_update_vinmi(ARMCPU *cpu)
+{
+    /*
+     * Update the interrupt level for VINMI, which is the logical OR of
+     * the HCRX_EL2.VINMI bit and the input line level from the GIC.
+     */
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    bool new_state = ((arm_hcr_el2_eff(env) & HCR_VI) &&
+                      (arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
+        (env->irq_line_state & CPU_INTERRUPT_VINMI);
+
+    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VINMI) != 0)) {
+        if (new_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_VINMI);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VINMI);
+        }
+    }
+}
+
+void arm_cpu_update_vfnmi(ARMCPU *cpu)
+{
+    /*
+     * Update the interrupt level for VFNMI, which is the HCRX_EL2.VFNMI bit.
+     */
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    bool new_state = (arm_hcr_el2_eff(env) & HCR_VF) &&
+                      (arm_hcrx_el2_eff(env) & HCRX_VFNMI);
+
+    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFNMI) != 0)) {
+        if (new_state) {
+            cpu_interrupt(cs, CPU_INTERRUPT_VFNMI);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_VFNMI);
+        }
+    }
+}
+
 void arm_cpu_update_vserr(ARMCPU *cpu)
 {
     /*
@@ -929,7 +1047,9 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
         [ARM_CPU_IRQ] = CPU_INTERRUPT_HARD,
         [ARM_CPU_FIQ] = CPU_INTERRUPT_FIQ,
         [ARM_CPU_VIRQ] = CPU_INTERRUPT_VIRQ,
-        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ
+        [ARM_CPU_VFIQ] = CPU_INTERRUPT_VFIQ,
+        [ARM_CPU_NMI] = CPU_INTERRUPT_NMI,
+        [ARM_CPU_VINMI] = CPU_INTERRUPT_VINMI,
     };
 
     if (!arm_feature(env, ARM_FEATURE_EL2) &&
@@ -955,8 +1075,12 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
     case ARM_CPU_VFIQ:
         arm_cpu_update_vfiq(cpu);
         break;
+    case ARM_CPU_VINMI:
+        arm_cpu_update_vinmi(cpu);
+        break;
     case ARM_CPU_IRQ:
     case ARM_CPU_FIQ:
+    case ARM_CPU_NMI:
         if (level) {
             cpu_interrupt(cs, mask[irq]);
         } else {
@@ -1350,12 +1474,13 @@ static void arm_cpu_initfn(Object *obj)
 #else
     /* Our inbound IRQ and FIQ lines */
     if (kvm_enabled()) {
-        /* VIRQ and VFIQ are unused with KVM but we add them to maintain
-         * the same interface as non-KVM CPUs.
+        /*
+         * VIRQ, VFIQ, NMI, VINMI are unused with KVM but we add
+         * them to maintain the same interface as non-KVM CPUs.
          */
-        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 4);
+        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_kvm_set_irq, 6);
     } else {
-        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 4);
+        qdev_init_gpio_in(DEVICE(cpu), arm_cpu_set_irq, 6);
     }
 
     qdev_init_gpio_out(DEVICE(cpu), cpu->gt_timer_outputs,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b9443b1813a..f61a65d8114 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6046,15 +6046,19 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
      * and the state of the input lines from the GIC. (This requires
      * that we have the BQL, which is done by marking the
      * reginfo structs as ARM_CP_IO.)
-     * Note that if a write to HCR pends a VIRQ or VFIQ it is never
-     * possible for it to be taken immediately, because VIRQ and
-     * VFIQ are masked unless running at EL0 or EL1, and HCR
-     * can only be written at EL2.
+     * Note that if a write to HCR pends a VIRQ or VFIQ or VINMI or
+     * VFNMI, it is never possible for it to be taken immediately
+     * because VIRQ, VFIQ, VINMI and VFNMI are masked unless running
+     * at EL0 or EL1, and HCR can only be written at EL2.
      */
     g_assert(bql_locked());
     arm_cpu_update_virq(cpu);
     arm_cpu_update_vfiq(cpu);
     arm_cpu_update_vserr(cpu);
+    if (cpu_isar_feature(aa64_nmi, cpu)) {
+        arm_cpu_update_vinmi(cpu);
+        arm_cpu_update_vfnmi(cpu);
+    }
 }
 
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
@@ -6202,6 +6206,23 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
+
+    /*
+     * Updates to VINMI and VFNMI require us to update the status of
+     * virtual NMI, which are the logical OR of these bits
+     * and the state of the input lines from the GIC. (This requires
+     * that we have the BQL, which is done by marking the
+     * reginfo structs as ARM_CP_IO.)
+     * Note that if a write to HCRX pends a VINMI or VFNMI it is never
+     * possible for it to be taken immediately, because VINMI and
+     * VFNMI are masked unless running at EL0 or EL1, and HCRX
+     * can only be written at EL2.
+     */
+    if (cpu_isar_feature(aa64_nmi, cpu)) {
+        g_assert(bql_locked());
+        arm_cpu_update_vinmi(cpu);
+        arm_cpu_update_vfnmi(cpu);
+    }
 }
 
 static CPAccessResult access_hxen(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6217,6 +6238,7 @@ static CPAccessResult access_hxen(CPUARMState *env, const ARMCPRegInfo *ri,
 
 static const ARMCPRegInfo hcrx_el2_reginfo = {
     .name = "HCRX_EL2", .state = ARM_CP_STATE_AA64,
+    .type = ARM_CP_IO,
     .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 2, .opc2 = 2,
     .access = PL2_RW, .writefn = hcrx_write, .accessfn = access_hxen,
     .nv2_redirect_offset = 0xa0,
@@ -10799,6 +10821,9 @@ void arm_log_exception(CPUState *cs)
             [EXCP_DIVBYZERO] = "v7M DIVBYZERO UsageFault",
             [EXCP_VSERR] = "Virtual SERR",
             [EXCP_GPC] = "Granule Protection Check",
+            [EXCP_NMI] = "NMI",
+            [EXCP_VINMI] = "Virtual IRQ NMI",
+            [EXCP_VFNMI] = "Virtual FIQ NMI",
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
-- 
2.34.1



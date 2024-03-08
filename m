Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F98C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riawF-0007Tu-04; Fri, 08 Mar 2024 09:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riawB-0007TT-NT
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riaw8-0000Xo-NG
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709907057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KZWa1EaIDMibB3KOKOBEj0grBbJjw78JYoOrydo52I=;
 b=Ci7J4oTExLfv8o/kGlvEzSdebjaOiIoOcjwONj3Ji+x6g5oA7EDvFPDSg3pUoYwynqkrB+
 FG6iBjJCdY+okBLWnpL1QKozzAAhY3geYdNcF/tPY8ToXwYvMFxurtg0+CSK4oOsPDOF5l
 FpXhX+2uzatNXd27MxK3VqgRmbDNLhY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-Bm3KqwZANdqghiqme_Hi3g-1; Fri,
 08 Mar 2024 09:10:55 -0500
X-MC-Unique: Bm3KqwZANdqghiqme_Hi3g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 635111C54022;
 Fri,  8 Mar 2024 14:10:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7230A492BC6;
 Fri,  8 Mar 2024 14:10:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 1/3] target/arm: Move v7m-related code from cpu32.c into a
 separate file
Date: Fri,  8 Mar 2024 15:10:49 +0100
Message-ID: <20240308141051.536599-2-thuth@redhat.com>
In-Reply-To: <20240308141051.536599-1-thuth@redhat.com>
References: <20240308141051.536599-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Move the code to a separate file so that we do not have to compile
it anymore if CONFIG_ARM_V7M is not set.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/arm/tcg/cpu-v7m.c   | 290 +++++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu32.c     | 261 ---------------------------------
 target/arm/meson.build     |   3 +
 target/arm/tcg/meson.build |   3 +
 4 files changed, 296 insertions(+), 261 deletions(-)
 create mode 100644 target/arm/tcg/cpu-v7m.c

diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
new file mode 100644
index 0000000000..c059c681e9
--- /dev/null
+++ b/target/arm/tcg/cpu-v7m.c
@@ -0,0 +1,290 @@
+/*
+ * QEMU ARMv7-M TCG-only CPUs.
+ *
+ * Copyright (c) 2012 SUSE LINUX Products GmbH
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/core/tcg-cpu-ops.h"
+#include "internals.h"
+
+#if !defined(CONFIG_USER_ONLY)
+
+#include "hw/intc/armv7m_nvic.h"
+
+static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    CPUClass *cc = CPU_GET_CLASS(cs);
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    bool ret = false;
+
+    /*
+     * ARMv7-M interrupt masking works differently than -A or -R.
+     * There is no FIQ/IRQ distinction. Instead of I and F bits
+     * masking FIQ and IRQ interrupts, an exception is taken only
+     * if it is higher priority than the current execution priority
+     * (which depends on state like BASEPRI, FAULTMASK and the
+     * currently active exception).
+     */
+    if (interrupt_request & CPU_INTERRUPT_HARD
+        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
+        cs->exception_index = EXCP_IRQ;
+        cc->tcg_ops->do_interrupt(cs);
+        ret = true;
+    }
+    return ret;
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
+static void cortex_m0_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    set_feature(&cpu->env, ARM_FEATURE_V6);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+
+    cpu->midr = 0x410cc200;
+
+    /*
+     * These ID register values are not guest visible, because
+     * we do not implement the Main Extension. They must be set
+     * to values corresponding to the Cortex-M0's implemented
+     * features, because QEMU generally controls its emulation
+     * by looking at ID register fields. We use the same values as
+     * for the M3.
+     */
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000200;
+    cpu->isar.id_dfr0 = 0x00100000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00000030;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x00000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01141110;
+    cpu->isar.id_isar1 = 0x02111000;
+    cpu->isar.id_isar2 = 0x21112231;
+    cpu->isar.id_isar3 = 0x01111110;
+    cpu->isar.id_isar4 = 0x01310102;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
+}
+
+static void cortex_m3_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    cpu->midr = 0x410fc231;
+    cpu->pmsav7_dregion = 8;
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000200;
+    cpu->isar.id_dfr0 = 0x00100000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00000030;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x00000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01141110;
+    cpu->isar.id_isar1 = 0x02111000;
+    cpu->isar.id_isar2 = 0x21112231;
+    cpu->isar.id_isar3 = 0x01111110;
+    cpu->isar.id_isar4 = 0x01310102;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
+}
+
+static void cortex_m4_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr = 0x410fc240; /* r0p0 */
+    cpu->pmsav7_dregion = 8;
+    cpu->isar.mvfr0 = 0x10110021;
+    cpu->isar.mvfr1 = 0x11000011;
+    cpu->isar.mvfr2 = 0x00000000;
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000200;
+    cpu->isar.id_dfr0 = 0x00100000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00000030;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x00000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01141110;
+    cpu->isar.id_isar1 = 0x02111000;
+    cpu->isar.id_isar2 = 0x21112231;
+    cpu->isar.id_isar3 = 0x01111110;
+    cpu->isar.id_isar4 = 0x01310102;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
+}
+
+static void cortex_m7_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V7);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr = 0x411fc272; /* r1p2 */
+    cpu->pmsav7_dregion = 8;
+    cpu->isar.mvfr0 = 0x10110221;
+    cpu->isar.mvfr1 = 0x12000011;
+    cpu->isar.mvfr2 = 0x00000040;
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000200;
+    cpu->isar.id_dfr0 = 0x00100000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00100030;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x01000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01101110;
+    cpu->isar.id_isar1 = 0x02112000;
+    cpu->isar.id_isar2 = 0x20232231;
+    cpu->isar.id_isar3 = 0x01111131;
+    cpu->isar.id_isar4 = 0x01310132;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
+}
+
+static void cortex_m33_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr = 0x410fd213; /* r0p3 */
+    cpu->pmsav7_dregion = 16;
+    cpu->sau_sregion = 8;
+    cpu->isar.mvfr0 = 0x10110021;
+    cpu->isar.mvfr1 = 0x11000011;
+    cpu->isar.mvfr2 = 0x00000040;
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000210;
+    cpu->isar.id_dfr0 = 0x00200000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00101F40;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x01000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01101110;
+    cpu->isar.id_isar1 = 0x02212000;
+    cpu->isar.id_isar2 = 0x20232232;
+    cpu->isar.id_isar3 = 0x01111131;
+    cpu->isar.id_isar4 = 0x01310132;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
+    cpu->clidr = 0x00000000;
+    cpu->ctr = 0x8000c000;
+}
+
+static void cortex_m55_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    set_feature(&cpu->env, ARM_FEATURE_V8);
+    set_feature(&cpu->env, ARM_FEATURE_V8_1M);
+    set_feature(&cpu->env, ARM_FEATURE_M);
+    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
+    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
+    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
+    cpu->midr = 0x410fd221; /* r0p1 */
+    cpu->revidr = 0;
+    cpu->pmsav7_dregion = 16;
+    cpu->sau_sregion = 8;
+    /* These are the MVFR* values for the FPU + full MVE configuration */
+    cpu->isar.mvfr0 = 0x10110221;
+    cpu->isar.mvfr1 = 0x12100211;
+    cpu->isar.mvfr2 = 0x00000040;
+    cpu->isar.id_pfr0 = 0x20000030;
+    cpu->isar.id_pfr1 = 0x00000230;
+    cpu->isar.id_dfr0 = 0x10200000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00111040;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x01000000;
+    cpu->isar.id_mmfr3 = 0x00000011;
+    cpu->isar.id_isar0 = 0x01103110;
+    cpu->isar.id_isar1 = 0x02212000;
+    cpu->isar.id_isar2 = 0x20232232;
+    cpu->isar.id_isar3 = 0x01111131;
+    cpu->isar.id_isar4 = 0x01310132;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
+    cpu->clidr = 0x00000000; /* caches not implemented */
+    cpu->ctr = 0x8303c003;
+}
+
+static const TCGCPUOps arm_v7m_tcg_ops = {
+    .initialize = arm_translate_init,
+    .synchronize_from_tb = arm_cpu_synchronize_from_tb,
+    .debug_excp_handler = arm_debug_excp_handler,
+    .restore_state_to_opc = arm_restore_state_to_opc,
+
+#ifdef CONFIG_USER_ONLY
+    .record_sigsegv = arm_cpu_record_sigsegv,
+    .record_sigbus = arm_cpu_record_sigbus,
+#else
+    .tlb_fill = arm_cpu_tlb_fill,
+    .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
+    .do_interrupt = arm_v7m_cpu_do_interrupt,
+    .do_transaction_failed = arm_cpu_do_transaction_failed,
+    .do_unaligned_access = arm_cpu_do_unaligned_access,
+    .adjust_watchpoint_address = arm_adjust_watchpoint_address,
+    .debug_check_watchpoint = arm_debug_check_watchpoint,
+    .debug_check_breakpoint = arm_debug_check_breakpoint,
+#endif /* !CONFIG_USER_ONLY */
+};
+
+static void arm_v7m_class_init(ObjectClass *oc, void *data)
+{
+    ARMCPUClass *acc = ARM_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
+
+    acc->info = data;
+    cc->tcg_ops = &arm_v7m_tcg_ops;
+    cc->gdb_core_xml_file = "arm-m-profile.xml";
+}
+
+static const ARMCPUInfo arm_v7m_cpus[] = {
+    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
+                             .class_init = arm_v7m_class_init },
+    { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
+                             .class_init = arm_v7m_class_init },
+    { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
+                             .class_init = arm_v7m_class_init },
+    { .name = "cortex-m7",   .initfn = cortex_m7_initfn,
+                             .class_init = arm_v7m_class_init },
+    { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
+                             .class_init = arm_v7m_class_init },
+    { .name = "cortex-m55",  .initfn = cortex_m55_initfn,
+                             .class_init = arm_v7m_class_init },
+};
+
+static void arm_v7m_cpu_register_types(void)
+{
+    size_t i;
+
+    for (i = 0; i < ARRAY_SIZE(arm_v7m_cpus); ++i) {
+        arm_cpu_register(&arm_v7m_cpus[i]);
+    }
+}
+
+type_init(arm_v7m_cpu_register_types)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 6eb08a41b0..de8f2be941 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -17,9 +17,6 @@
 #include "hw/boards.h"
 #endif
 #include "cpregs.h"
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
-#include "hw/intc/armv7m_nvic.h"
-#endif
 
 
 /* Share AArch32 -cpu max features with AArch64. */
@@ -98,32 +95,6 @@ void aa32_max_features(ARMCPU *cpu)
 /* CPU models. These are not needed for the AArch64 linux-user build. */
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
 
-#if !defined(CONFIG_USER_ONLY)
-static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-{
-    CPUClass *cc = CPU_GET_CLASS(cs);
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    bool ret = false;
-
-    /*
-     * ARMv7-M interrupt masking works differently than -A or -R.
-     * There is no FIQ/IRQ distinction. Instead of I and F bits
-     * masking FIQ and IRQ interrupts, an exception is taken only
-     * if it is higher priority than the current execution priority
-     * (which depends on state like BASEPRI, FAULTMASK and the
-     * currently active exception).
-     */
-    if (interrupt_request & CPU_INTERRUPT_HARD
-        && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
-        cs->exception_index = EXCP_IRQ;
-        cc->tcg_ops->do_interrupt(cs);
-        ret = true;
-    }
-    return ret;
-}
-#endif /* !CONFIG_USER_ONLY */
-
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -571,195 +542,6 @@ static void cortex_a15_initfn(Object *obj)
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
 }
 
-static void cortex_m0_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-    set_feature(&cpu->env, ARM_FEATURE_V6);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-
-    cpu->midr = 0x410cc200;
-
-    /*
-     * These ID register values are not guest visible, because
-     * we do not implement the Main Extension. They must be set
-     * to values corresponding to the Cortex-M0's implemented
-     * features, because QEMU generally controls its emulation
-     * by looking at ID register fields. We use the same values as
-     * for the M3.
-     */
-    cpu->isar.id_pfr0 = 0x00000030;
-    cpu->isar.id_pfr1 = 0x00000200;
-    cpu->isar.id_dfr0 = 0x00100000;
-    cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01141110;
-    cpu->isar.id_isar1 = 0x02111000;
-    cpu->isar.id_isar2 = 0x21112231;
-    cpu->isar.id_isar3 = 0x01111110;
-    cpu->isar.id_isar4 = 0x01310102;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
-}
-
-static void cortex_m3_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-    set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
-    cpu->midr = 0x410fc231;
-    cpu->pmsav7_dregion = 8;
-    cpu->isar.id_pfr0 = 0x00000030;
-    cpu->isar.id_pfr1 = 0x00000200;
-    cpu->isar.id_dfr0 = 0x00100000;
-    cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01141110;
-    cpu->isar.id_isar1 = 0x02111000;
-    cpu->isar.id_isar2 = 0x21112231;
-    cpu->isar.id_isar3 = 0x01111110;
-    cpu->isar.id_isar4 = 0x01310102;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
-}
-
-static void cortex_m4_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    cpu->midr = 0x410fc240; /* r0p0 */
-    cpu->pmsav7_dregion = 8;
-    cpu->isar.mvfr0 = 0x10110021;
-    cpu->isar.mvfr1 = 0x11000011;
-    cpu->isar.mvfr2 = 0x00000000;
-    cpu->isar.id_pfr0 = 0x00000030;
-    cpu->isar.id_pfr1 = 0x00000200;
-    cpu->isar.id_dfr0 = 0x00100000;
-    cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00000030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x00000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01141110;
-    cpu->isar.id_isar1 = 0x02111000;
-    cpu->isar.id_isar2 = 0x21112231;
-    cpu->isar.id_isar3 = 0x01111110;
-    cpu->isar.id_isar4 = 0x01310102;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
-}
-
-static void cortex_m7_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    set_feature(&cpu->env, ARM_FEATURE_V7);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    cpu->midr = 0x411fc272; /* r1p2 */
-    cpu->pmsav7_dregion = 8;
-    cpu->isar.mvfr0 = 0x10110221;
-    cpu->isar.mvfr1 = 0x12000011;
-    cpu->isar.mvfr2 = 0x00000040;
-    cpu->isar.id_pfr0 = 0x00000030;
-    cpu->isar.id_pfr1 = 0x00000200;
-    cpu->isar.id_dfr0 = 0x00100000;
-    cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00100030;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01101110;
-    cpu->isar.id_isar1 = 0x02112000;
-    cpu->isar.id_isar2 = 0x20232231;
-    cpu->isar.id_isar3 = 0x01111131;
-    cpu->isar.id_isar4 = 0x01310132;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
-}
-
-static void cortex_m33_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
-    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    cpu->midr = 0x410fd213; /* r0p3 */
-    cpu->pmsav7_dregion = 16;
-    cpu->sau_sregion = 8;
-    cpu->isar.mvfr0 = 0x10110021;
-    cpu->isar.mvfr1 = 0x11000011;
-    cpu->isar.mvfr2 = 0x00000040;
-    cpu->isar.id_pfr0 = 0x00000030;
-    cpu->isar.id_pfr1 = 0x00000210;
-    cpu->isar.id_dfr0 = 0x00200000;
-    cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00101F40;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000000;
-    cpu->isar.id_isar0 = 0x01101110;
-    cpu->isar.id_isar1 = 0x02212000;
-    cpu->isar.id_isar2 = 0x20232232;
-    cpu->isar.id_isar3 = 0x01111131;
-    cpu->isar.id_isar4 = 0x01310132;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
-    cpu->clidr = 0x00000000;
-    cpu->ctr = 0x8000c000;
-}
-
-static void cortex_m55_initfn(Object *obj)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-
-    set_feature(&cpu->env, ARM_FEATURE_V8);
-    set_feature(&cpu->env, ARM_FEATURE_V8_1M);
-    set_feature(&cpu->env, ARM_FEATURE_M);
-    set_feature(&cpu->env, ARM_FEATURE_M_MAIN);
-    set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
-    set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
-    cpu->midr = 0x410fd221; /* r0p1 */
-    cpu->revidr = 0;
-    cpu->pmsav7_dregion = 16;
-    cpu->sau_sregion = 8;
-    /* These are the MVFR* values for the FPU + full MVE configuration */
-    cpu->isar.mvfr0 = 0x10110221;
-    cpu->isar.mvfr1 = 0x12100211;
-    cpu->isar.mvfr2 = 0x00000040;
-    cpu->isar.id_pfr0 = 0x20000030;
-    cpu->isar.id_pfr1 = 0x00000230;
-    cpu->isar.id_dfr0 = 0x10200000;
-    cpu->id_afr0 = 0x00000000;
-    cpu->isar.id_mmfr0 = 0x00111040;
-    cpu->isar.id_mmfr1 = 0x00000000;
-    cpu->isar.id_mmfr2 = 0x01000000;
-    cpu->isar.id_mmfr3 = 0x00000011;
-    cpu->isar.id_isar0 = 0x01103110;
-    cpu->isar.id_isar1 = 0x02212000;
-    cpu->isar.id_isar2 = 0x20232232;
-    cpu->isar.id_isar3 = 0x01111131;
-    cpu->isar.id_isar4 = 0x01310132;
-    cpu->isar.id_isar5 = 0x00000000;
-    cpu->isar.id_isar6 = 0x00000000;
-    cpu->clidr = 0x00000000; /* caches not implemented */
-    cpu->ctr = 0x8303c003;
-}
-
 static const ARMCPRegInfo cortexr5_cp_reginfo[] = {
     /* Dummy the TCM region regs for the moment */
     { .name = "ATCM", .cp = 15, .opc1 = 0, .crn = 9, .crm = 1, .opc2 = 0,
@@ -1127,37 +909,6 @@ static void pxa270c5_initfn(Object *obj)
     cpu->reset_sctlr = 0x00000078;
 }
 
-static const TCGCPUOps arm_v7m_tcg_ops = {
-    .initialize = arm_translate_init,
-    .synchronize_from_tb = arm_cpu_synchronize_from_tb,
-    .debug_excp_handler = arm_debug_excp_handler,
-    .restore_state_to_opc = arm_restore_state_to_opc,
-
-#ifdef CONFIG_USER_ONLY
-    .record_sigsegv = arm_cpu_record_sigsegv,
-    .record_sigbus = arm_cpu_record_sigbus,
-#else
-    .tlb_fill = arm_cpu_tlb_fill,
-    .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
-    .do_interrupt = arm_v7m_cpu_do_interrupt,
-    .do_transaction_failed = arm_cpu_do_transaction_failed,
-    .do_unaligned_access = arm_cpu_do_unaligned_access,
-    .adjust_watchpoint_address = arm_adjust_watchpoint_address,
-    .debug_check_watchpoint = arm_debug_check_watchpoint,
-    .debug_check_breakpoint = arm_debug_check_breakpoint,
-#endif /* !CONFIG_USER_ONLY */
-};
-
-static void arm_v7m_class_init(ObjectClass *oc, void *data)
-{
-    ARMCPUClass *acc = ARM_CPU_CLASS(oc);
-    CPUClass *cc = CPU_CLASS(oc);
-
-    acc->info = data;
-    cc->tcg_ops = &arm_v7m_tcg_ops;
-    cc->gdb_core_xml_file = "arm-m-profile.xml";
-}
-
 #ifndef TARGET_AARCH64
 /*
  * -cpu max: a CPU with as many features enabled as our emulation supports.
@@ -1240,18 +991,6 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "cortex-a8",   .initfn = cortex_a8_initfn },
     { .name = "cortex-a9",   .initfn = cortex_a9_initfn },
     { .name = "cortex-a15",  .initfn = cortex_a15_initfn },
-    { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
-                             .class_init = arm_v7m_class_init },
-    { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
-                             .class_init = arm_v7m_class_init },
-    { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
-                             .class_init = arm_v7m_class_init },
-    { .name = "cortex-m7",   .initfn = cortex_m7_initfn,
-                             .class_init = arm_v7m_class_init },
-    { .name = "cortex-m33",  .initfn = cortex_m33_initfn,
-                             .class_init = arm_v7m_class_init },
-    { .name = "cortex-m55",  .initfn = cortex_m55_initfn,
-                             .class_init = arm_v7m_class_init },
     { .name = "cortex-r5",   .initfn = cortex_r5_initfn },
     { .name = "cortex-r5f",  .initfn = cortex_r5f_initfn },
     { .name = "cortex-r52",  .initfn = cortex_r52_initfn },
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 46b5a21eb3..2e10464dbb 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -26,6 +26,8 @@ arm_system_ss.add(files(
   'ptw.c',
 ))
 
+arm_user_ss = ss.source_set()
+
 subdir('hvf')
 
 if 'CONFIG_TCG' in config_all_accel
@@ -36,3 +38,4 @@ endif
 
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
+target_user_arch += {'arm': arm_user_ss}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 6fca38f2cc..3b1a9f0fc5 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -55,3 +55,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss.add(files(
   'psci.c',
 ))
+
+arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
-- 
2.44.0



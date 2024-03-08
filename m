Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2746CC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricUh-0000El-Ow; Fri, 08 Mar 2024 10:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUR-0007yq-Db
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:31 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricUK-0004Ud-KP
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:50:31 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33e76d653b5so703382f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709913023; x=1710517823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hmftZX3Zj82jjyaQWolpMdQ7OIw0Yvxx8kXPvP7QUE0=;
 b=nbSE+ZkIrxBK2rPAd4u8GcJRpkg9OzeAUjkzdKLs1sWpj97lLdxhl0q6zyaZQGuc+3
 awDFHj0N64hlwnozPOJNe/LRGUXlDiOaRz6QWI/NLpOaKOrAIodSjcRAobITCa5hbBL3
 OKxFbg+hjxA+sZGsUdqHVbZK656TmX3WSfGvw7nIBWATxUc1utX7aNSYjhitxmZ1vTlC
 Ddbey/qQo1Bn7v40idkuaMKdgmi8zq5IkojxJH4k4kIamHTqhraiO9OW0c35O44BmROl
 glu8QqyEPR/hI9o/eVpVwDcDNKLMIQoP8A3ckVxFgY33ErpOHBXk4WSPp25H8Y1qKEAA
 EuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913023; x=1710517823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmftZX3Zj82jjyaQWolpMdQ7OIw0Yvxx8kXPvP7QUE0=;
 b=QnGNunRxsXK8hbD5jwfKQmSJcaql4Ew5477zpqfTrl8EvJAr4n+ai5lv/RKcx7vGNc
 KWwRHTz6qa9s9Mu079DBaa/SXBk5sn4LRidPQDbT6meEWZDIXw5+DugJKDpednCXwLQJ
 CuhwbG86Ks4LVRficijGPo8HgpY1l7QVZCP354rX+U6WE84CdnW83Qp6wQNhXxC6H7XL
 UwmnR672UknppzPjb/eIGxfUhtx8uEQ7UP6DLrsoeggGDLA+nwmrQxHlI+jIJmSelsb8
 uyEVLLkXuJG7+DYTMabBDHAaqiwcjUImMDH0Ii4PVJ7QjBb4BsvhLKll1ivwRzeCJ0Bp
 hOAw==
X-Gm-Message-State: AOJu0Yz7qWp6zCFQtl/VKbtanw+3uo2tpcOT4ow+SmknjMdZBpRnpX+F
 buPKqmBKkh+Mtha0atJRf2xpslFRVONSaM40ZS60HGoM/AfB8uPZ5yUKxRJmTSrXyc8s0xL54fZ
 N
X-Google-Smtp-Source: AGHT+IHF52lPXJ9Om8UzQKuzjKro/htNGaelkUYeqG75Y6WDa85VeGQbE9zXORU8WX/vBS9aT8VK0A==
X-Received: by 2002:adf:fc8e:0:b0:33d:284a:401 with SMTP id
 g14-20020adffc8e000000b0033d284a0401mr16087862wrr.68.1709913023001; 
 Fri, 08 Mar 2024 07:50:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f2-20020adff8c2000000b0033e7a204dc7sm856080wrq.32.2024.03.08.07.50.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 07:50:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] target/arm: Move v7m-related code from cpu32.c into a
 separate file
Date: Fri,  8 Mar 2024 15:50:15 +0000
Message-Id: <20240308155015.3637663-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308155015.3637663-1-peter.maydell@linaro.org>
References: <20240308155015.3637663-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Thomas Huth <thuth@redhat.com>

Move the code to a separate file so that we do not have to compile
it anymore if CONFIG_ARM_V7M is not set.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240308141051.536599-2-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu-v7m.c   | 290 +++++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu32.c     | 261 ---------------------------------
 target/arm/meson.build     |   3 +
 target/arm/tcg/meson.build |   3 +
 4 files changed, 296 insertions(+), 261 deletions(-)
 create mode 100644 target/arm/tcg/cpu-v7m.c

diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
new file mode 100644
index 00000000000..c059c681e94
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
index 6eb08a41b01..de8f2be9416 100644
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
index 46b5a21eb31..2e10464dbb6 100644
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
index 6fca38f2ccb..3b1a9f0fc5e 100644
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
2.34.1



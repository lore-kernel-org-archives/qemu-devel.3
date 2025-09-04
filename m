Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2F1CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGrt-0003RA-Gt; Thu, 04 Sep 2025 16:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrq-0003Q0-V7
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:38 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGro-0000iT-IL
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:38 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 201CD60BF4
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:21 +0200 (CEST)
Received: (qmail 32593 invoked by uid 990); 4 Sep 2025 20:47:21 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:20 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v6 06/25] target/arm: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:46:43 +0200
Message-ID: <3230bddf690d5facd44fb22da9cc006ddb46465b.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999952) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=xNEb41Bq4Z4GtsJUyqVZtleo7SkSVedY+dily4e9McM=;
 b=bCcF3/o0Z94dGhWKbCz2jVr7BUjNzc7jNGTJCuuMtEzon5CC+TATf5FfDduAmedkHw9hRaI42X
 5aMwMxeGArVX8jM8fx5rDoWlPSujptgRyG9XMK/kVVmO6I3ntdgfeRhFOMipDVJZ+CdmrmKQvTxv
 2KW9YK1vG0bksKWvjnt9av2qWke1ZajkrdqCFI3/zW/feTurptErGquRtAu3wNjAzRR+NgiD7zU/
 FyHiN2hNndijPNpXwhNc2ffRlb3TmdO3aRawW02yNFZwmVo6xQKTlEkRfb8mAa3qL0OMjOQst1qQ
 W/et+OTpBIxnaob13HrVf88LGQyIFuFkF5H8Ofn7UtIIpztsjr2q+3NMuk2Zuc1XB3vmond2clkW
 9/Uc5OUGOcVY+VuFEpQrjquiTBHlB7FFb3iey/BDsUAbgsD/Lo2aD5zVnxErhaFA/TpItyCJp3x+
 h7S6G5uyRbFJrzmkuddwZHPn2A/Ly5vRnDDSU04zASM/dq2Nxwo4QnNuhwffxnBKPDyObX4syDSV
 /YJXHpJqPqNMVGatO+2xcmas++4kl/dg4kGSJcZD649dMXu1McnHLa+Uq1fkY6EEKLJyJWejve1r
 wkoO6P1UxGIsCXnfoDxfPC+RfUvzbF11ZMRwvSU+RkWfHu2W9lRWbSHQbjmezNu1tIpBAP/eywY9
 s=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for ARM (and Aarch64) targets. We decided to
treat the (V)IRQ, (VI/VF)NMI, (V)FIQ and VSERR exceptions as interrupts
since they are, presumably, async in nature.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/arm/helper.c       | 24 ++++++++++++++++++++++++
 target/arm/internals.h    |  1 +
 target/arm/tcg/m_helper.c |  5 +++++
 3 files changed, 30 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19637e7301..4812b30d64 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -34,6 +34,7 @@
 #endif
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
+#include "qemu/plugin.h"
 
 #define HELPER_H "tcg/helper.h"
 #include "exec/helper-proto.h.inc"
@@ -8585,6 +8586,24 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     }
 }
 
+void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from)
+{
+    switch (cs->exception_index) {
+    case EXCP_IRQ:
+    case EXCP_VIRQ:
+    case EXCP_NMI:
+    case EXCP_VINMI:
+    case EXCP_FIQ:
+    case EXCP_VFIQ:
+    case EXCP_VFNMI:
+    case EXCP_VSERR:
+        qemu_plugin_vcpu_interrupt_cb(cs, from);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from);
+    }
+}
+
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 {
     /*
@@ -9251,6 +9270,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
+    uint64_t last_pc = cs->cc->get_pc(cs);
 
     assert(!arm_feature(env, ARM_FEATURE_M));
 
@@ -9267,6 +9287,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     }
 
@@ -9278,6 +9299,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 #ifdef CONFIG_TCG
     if (cs->exception_index == EXCP_SEMIHOST) {
         tcg_handle_semihosting(cs);
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     }
 #endif
@@ -9303,6 +9325,8 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (!kvm_enabled()) {
         cpu_set_interrupt(cs, CPU_INTERRUPT_EXITTB);
     }
+
+    arm_do_plugin_vcpu_discon_cb(cs, last_pc);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f5a1e75db3..369ec2912b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -373,6 +373,7 @@ static inline int r14_bank_number(int mode)
 
 void arm_cpu_register(const ARMCPUInfo *info);
 
+void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from);
 void register_cp_regs_for_features(ARMCPU *cpu);
 void init_cpreg_list(ARMCPU *cpu);
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 28307b5615..31d9a59ed6 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -23,6 +23,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/intc/armv7m_nvic.h"
 #endif
+#include "qemu/plugin.h"
 
 static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
                          uint32_t reg, uint32_t val)
@@ -2194,6 +2195,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     CPUARMState *env = &cpu->env;
     uint32_t lr;
     bool ignore_stackfaults;
+    uint64_t last_pc = env->regs[15];
 
     arm_log_exception(cs);
 
@@ -2361,6 +2363,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         g_assert_not_reached();
 #endif
         env->regs[15] += env->thumb ? 2 : 4;
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     case EXCP_BKPT:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
@@ -2427,6 +2430,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
     ignore_stackfaults = v7m_push_stack(cpu);
     v7m_exception_taken(cpu, lr, false, ignore_stackfaults);
+
+    arm_do_plugin_vcpu_discon_cb(cs, last_pc);
 }
 
 uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
-- 
2.49.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73117E69E88
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIC58-0005li-9T; Mon, 02 Dec 2024 14:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4u-0005jU-QR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:29 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4r-0001xG-4r
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:27 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 1F366180C08
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:27:14 +0100 (CET)
Received: (qmail 7181 invoked by uid 990); 2 Dec 2024 19:27:14 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:27:13 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH v3 06/11] target/arm: call plugin trap callbacks
Date: Mon,  2 Dec 2024 20:26:47 +0100
Message-ID: <5c4b8e6f913e3257fee662708a69902676edc628.1733063076.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) SUSPICIOUS_RECIPS(1.5) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) BAYES_HAM(-2.999999) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=n9gM0kBmO83WxtZS2NBl9dSShYXqE3eiFoCKNq/tViA=;
 b=Qxuwp23H6cgGzKlkzOADioJ0R0jHv2nPMzgCIY3OPj4UuYV6eO//sTyjc9gVjfKPMcmNcxlHSn
 qo/nsDxI00UZbaTYDN5sz75C3AMupRMK94EPcAdeGn1HP7OGACBW1TJKqSU/IKnbzGiGLX8VS3Ds
 NeSXVp6EumTrEVn4MgQ9WghRvQtyJQ4HoZDqKvvQw57x+IFkcnCmkt439IiUPPa5byek2iT2q9gs
 pkYsoHam2jO21gU4d+B6RNYPe++4DJufyix7Uoj1Q4zvk76tGTyrfrh08N+YRv0pKXDb9UuuRiRX
 1Gh8OWtDAEVBHUiHm1gavTJQKOcN+mtJeqjzO0w2Xzc45QSMMotoZcWXUlbgMRuNTqH5qGNEvTCb
 AfaoVBZwrC69yQuqfLGkXv7wRLjdET7hNyt+cqSnc21ArpXR3jMXYn0ntEJkj4JDxU0qGRDsaxEv
 yV8cpmbUMlFqk9z2/XnEDodGbKU4EY5ScVf9FLldontf0RrwQs3DvjSCLNcIHbt36+XbistADyqo
 uqshKlE0bjmWYUHoCil7KOPYDhdzF/VLhao82Zj4mBG+GFiJ7kY31XRtb90TartdYWsmBWLyvlb5
 jLVglESze1TN65VObf9PkpuCgNUur2/cqHuktBQyPxd1vfmQ8WPRQFox4JAA7sEmo5/c3XMQIzSU
 0=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 contrib/plugins/traps.c   |  2 +-
 target/arm/helper.c       | 25 +++++++++++++++++++++++++
 target/arm/tcg/m_helper.c | 18 ++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
index ecd4beac5f..cdb503e499 100644
--- a/contrib/plugins/traps.c
+++ b/contrib/plugins/traps.c
@@ -87,7 +87,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
     qemu_plugin_vcpu_for_each(id, vcpu_init);
 
-    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_TRAPS,
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
                                         vcpu_discon);
 
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f38eb054c0..57f274a037 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -31,6 +31,7 @@
 #endif
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
+#include "qemu/plugin.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
@@ -11166,6 +11167,25 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     }
 }
 
+static void arm_do_plugin_vcpu_interrupt_cb(CPUState *cs, uint64_t from,
+                                            uint64_t to)
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
+        qemu_plugin_vcpu_interrupt_cb(cs, from, to);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, from, to);
+    }
+}
+
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 {
     /*
@@ -11822,6 +11842,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
+    uint64_t last_pc = env->pc;
 
     assert(!arm_feature(env, ARM_FEATURE_M));
 
@@ -11838,6 +11859,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc, env->pc);
         return;
     }
 
@@ -11849,6 +11871,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
 #ifdef CONFIG_TCG
     if (cs->exception_index == EXCP_SEMIHOST) {
         tcg_handle_semihosting(cs);
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc, env->pc);
         return;
     }
 #endif
@@ -11874,6 +11897,8 @@ void arm_cpu_do_interrupt(CPUState *cs)
     if (!kvm_enabled()) {
         cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
     }
+
+    arm_do_plugin_vcpu_interrupt_cb(cs, last_pc, env->pc);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f7354f3c6e..3a8b55db82 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -24,6 +24,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/intc/armv7m_nvic.h"
 #endif
+#include "qemu/plugin.h"
 
 static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
                          uint32_t reg, uint32_t val)
@@ -2186,6 +2187,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     CPUARMState *env = &cpu->env;
     uint32_t lr;
     bool ignore_stackfaults;
+    uint64_t last_pc = env->pc;
 
     arm_log_exception(cs);
 
@@ -2353,6 +2355,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         g_assert_not_reached();
 #endif
         env->regs[15] += env->thumb ? 2 : 4;
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc, env->pc);
         return;
     case EXCP_BKPT:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG, false);
@@ -2419,6 +2422,21 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
     ignore_stackfaults = v7m_push_stack(cpu);
     v7m_exception_taken(cpu, lr, false, ignore_stackfaults);
+
+    switch (cs->exception_index) {
+    case EXCP_IRQ:
+    case EXCP_VIRQ:
+    case EXCP_NMI:
+    case EXCP_VINMI:
+    case EXCP_FIQ:
+    case EXCP_VFIQ:
+    case EXCP_VFNMI:
+    case EXCP_VSERR:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc, env->pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc, env->pc);
+    }
 }
 
 uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
-- 
2.45.2



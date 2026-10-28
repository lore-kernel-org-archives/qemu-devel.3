Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB02606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Yg50ZF02
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM39l-0001Fd-9q; Wed, 28 Oct 2026 08:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xM39j-0001FG-Qz
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:27 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xM39h-0003N9-6h
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:27 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c09f4.dip0.t-ipconnect.de
 [62.156.9.244])
 by linux.microsoft.com (Postfix) with ESMTPSA id B11F820B7169;
 Wed, 28 Oct 2026 05:53:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B11F820B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793191992;
 bh=ysLqVAbYfxKCz2a7+IxW7TWxV16fVnF2peR7YvfIyws=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yg50ZF02CYV8BnKdaCh5SsQWl1cEC4OW+kPjyurGDbS69AFg+XQYxQkpwLwyTJRuS
 /I6DlSSvcVx9ldG8akoeuX2cqt2Mpu2AowAuYw4E+tXgFzuafgBGWlmIKP/aMQZAEP
 ON1RCpvvzaKJrtoleENYFhuHb3BVh2lRVDFP7ziA=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/4] target/i386/mshv: deliver legacy PIC interrupts
Date: Wed, 28 Oct 2026 13:53:07 +0100
Message-Id: <20261028125308.147630-4-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
References: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To inject legacy interrupts in the MSHV accelerator, we have to request
a "deliverability notification" once the PIC asserts an interrupt. Once
we receive a INTERRUPTION_DELIVERABLE exit from the hypervisor we can
proceed to acknowledge the interrupt and write to the PENDING_EVENT0
register with EXT_INT event type and the respective vector.

Since an interrupt is supposed to wake a vCPU stopped by HLT, we do
clear the halt_suspend field of the INTERNAL_ACTIVITY_STATE register.

We also need to consider pending EXT_INT events in migration,
splitting the mapping of pending_exc into two discrete EXCEPTION and
EXT_INT event types.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 hw/i386/x86-cpu.c              |   9 +-
 include/hw/hyperv/hvgdk_mini.h |  42 ++++++++-
 include/system/mshv_int.h      |   1 +
 meson.build                    |   1 +
 target/i386/mshv/mshv-cpu.c    | 155 +++++++++++++++++++++++++++++++--
 target/i386/mshv/trace-events  |   7 ++
 target/i386/mshv/trace.h       |   2 +
 7 files changed, 200 insertions(+), 17 deletions(-)
 create mode 100644 target/i386/mshv/trace-events
 create mode 100644 target/i386/mshv/trace.h

diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index fba313376c..7b9299272a 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -46,12 +46,8 @@ static void pic_irq_request(void *opaque, int irq, int level)
 
     trace_x86_pic_interrupt(irq, level);
 
-    if (mshv_irqchip_in_kernel()) {
-        return;
-    }
-
     if (cpu_is_apic_enabled(cpu->apic_state) && !kvm_irqchip_in_kernel() &&
-        !whpx_irqchip_in_kernel()) {
+        !mshv_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
         CPU_FOREACH(cs) {
             cpu = X86_CPU(cs);
             if (apic_accept_pic_intr(cpu->apic_state)) {
@@ -77,7 +73,8 @@ int cpu_get_pic_interrupt(CPUX86State *env)
     X86CPU *cpu = env_archcpu(env);
     int intno;
 
-    if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
+    if (!kvm_irqchip_in_kernel() && !mshv_irqchip_in_kernel() &&
+        !whpx_irqchip_in_kernel()) {
         intno = apic_get_interrupt(cpu->apic_state);
         if (intno >= 0) {
             return intno;
diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 0983e3a58d..e585661b2c 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -30,10 +30,11 @@ typedef enum hv_register_name {
     HV_REGISTER_INTERNAL_ACTIVITY_STATE = 0x00000004,
 
     /* Pending Interruption Register */
-    HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
-    HV_REGISTER_INTERRUPT_STATE      = 0x00010003,
-    HV_REGISTER_PENDING_EVENT0       = 0x00010004,
-    HV_REGISTER_PENDING_EVENT1       = 0x00010005,
+    HV_REGISTER_PENDING_INTERRUPTION         = 0x00010002,
+    HV_REGISTER_INTERRUPT_STATE              = 0x00010003,
+    HV_REGISTER_PENDING_EVENT0               = 0x00010004,
+    HV_REGISTER_PENDING_EVENT1               = 0x00010005,
+    HV_REGISTER_DELIVERABILITY_NOTIFICATIONS = 0x00010006,
 
     /* X64 User-Mode Registers */
     HV_X64_REGISTER_RAX     = 0x00020000,
@@ -313,6 +314,21 @@ union hv_x64_pending_exception_event {
     };
 };
 
+#define HV_X64_PENDING_EVENT_EXCEPTION 0
+#define HV_X64_PENDING_EVENT_EXT_INT   5
+
+union hv_x64_pending_ext_int_event {
+    uint64_t as_uint64[2];
+    struct {
+        uint64_t event_pending:1;
+        uint64_t event_type:3;
+        uint64_t reserved0:4;
+        uint64_t vector:8;
+        uint64_t reserved1:48;
+        uint64_t reserved2;
+    };
+};
+
 union hv_x64_pending_virtualization_fault_event {
     uint64_t as_uint64[2];
     struct {
@@ -443,6 +459,17 @@ union hv_x64_interrupt_state_register {
     };
 };
 
+union hv_x64_deliverability_notifications_register {
+    uint64_t as_uint64;
+    struct {
+        uint64_t nmi_notification:1;
+        uint64_t interrupt_notification:1;
+        uint64_t interrupt_priority:4;
+        uint64_t reserved:42;
+        uint64_t sints:16;
+    };
+};
+
 union hv_intercept_suspend_register {
     uint64_t as_uint64;
     struct {
@@ -469,6 +496,7 @@ typedef union hv_register_value {
     union hv_x64_pending_interruption_register pending_interruption;
     union hv_x64_msr_npiep_config_contents npiep_config;
     union hv_x64_pending_exception_event pending_exception_event;
+    union hv_x64_pending_ext_int_event pending_ext_int_event;
     union hv_x64_pending_virtualization_fault_event
         pending_virtualization_fault_event;
     union hv_x64_register_sev_control sev_control;
@@ -715,6 +743,12 @@ struct hv_x64_intercept_message_header {
     uint64_t rflags;
 } QEMU_PACKED;
 
+struct hv_x64_interruption_deliverable_message {
+    struct hv_x64_intercept_message_header header;
+    uint32_t deliverable_type;
+    uint32_t reserved;
+} QEMU_PACKED;
+
 union hv_x64_io_port_access_info {
     uint8_t as_uint8;
     struct {
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 1f77ffd152..d527cd8d77 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -45,6 +45,7 @@ typedef struct MshvHvCallArgs {
 struct AccelCPUState {
     int cpufd;
     MshvHvCallArgs hvcall_args;
+    bool pic_interrupt_window;
 };
 
 typedef struct MshvMemoryListener {
diff --git a/meson.build b/meson.build
index bbef9d9c29..24caec97a9 100644
--- a/meson.build
+++ b/meson.build
@@ -3686,6 +3686,7 @@ if have_system or have_user
     'target/hppa',
     'target/i386',
     'target/i386/kvm',
+    'target/i386/mshv',
     'target/i386/whpx',
     'target/loongarch',
     'target/mips/tcg',
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index e3c155da2e..7032e0f6ac 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -771,6 +771,7 @@ static int get_vcpu_events(CPUState *cpu)
     union hv_x64_pending_interruption_register pending_int;
     union hv_x64_interrupt_state_register int_state;
     union hv_x64_pending_exception_event pending_exc;
+    union hv_x64_pending_ext_int_event pending_ext_int;
     int ret;
 
     ret = mshv_get_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
@@ -782,6 +783,7 @@ static int get_vcpu_events(CPUState *cpu)
     pending_int.as_uint64 = assocs[0].value.reg64;
     int_state.as_uint64 = assocs[1].value.reg64;
     pending_exc = assocs[2].value.pending_exception_event;
+    pending_ext_int = assocs[2].value.pending_ext_int_event;
 
     /* Clear previous state. injected ints/excs are blanked w/ -1 */
     env->interrupt_injected    = -1;
@@ -841,14 +843,25 @@ static int get_vcpu_events(CPUState *cpu)
         env->hflags2 &= ~HF2_NMI_MASK;
     }
 
-    /* HV_REGISTER_PENDING_EVENT0: pending exception not yet injected */
+    /* HV_REGISTER_PENDING_EVENT0: event not yet injected */
     if (pending_exc.event_pending) {
-        env->exception_pending     = 1;
-        env->exception_nr          = pending_exc.vector;
-        env->has_error_code        = pending_exc.deliver_error_code;
-        env->error_code            = pending_exc.error_code;
-        env->exception_has_payload = (pending_exc.exception_parameter != 0);
-        env->exception_payload     = pending_exc.exception_parameter;
+        switch (pending_exc.event_type) {
+        case HV_X64_PENDING_EVENT_EXCEPTION:
+            env->exception_pending     = 1;
+            env->exception_nr          = pending_exc.vector;
+            env->has_error_code        = pending_exc.deliver_error_code;
+            env->error_code            = pending_exc.error_code;
+            env->exception_has_payload = pending_exc.exception_parameter != 0;
+            env->exception_payload     = pending_exc.exception_parameter;
+            break;
+        case HV_X64_PENDING_EVENT_EXT_INT:
+            env->interrupt_injected = pending_ext_int.vector;
+            break;
+        default:
+            error_report("unknown pending event type %u",
+                         pending_exc.event_type);
+            return -EINVAL;
+        }
     }
 
     /*
@@ -2091,6 +2104,119 @@ static int handle_exception_interrupt(CPUState *cpu,
     return 0;
 }
 
+static int set_pic_interrupt_window(CPUState *cpu, bool enabled)
+{
+    union hv_x64_deliverability_notifications_register notifications = { 0 };
+    struct hv_register_assoc assoc = { 0 };
+    AccelCPUState *cpu_state = cpu->accel;
+    int ret;
+
+    notifications.interrupt_notification = enabled;
+
+    assoc.name        = HV_REGISTER_DELIVERABILITY_NOTIFICATIONS;
+    assoc.value.reg64 = notifications.as_uint64;
+
+    /* we are already waiting for a PIC interrupt window */
+    if (cpu_state->pic_interrupt_window == enabled) {
+        return 0;
+    }
+
+    trace_mshv_set_pic_interrupt_window(cpu->cpu_index, enabled);
+
+    ret = mshv_set_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        error_report("failed to set deliverability notifications register");
+        return ret;
+    }
+
+    cpu_state->pic_interrupt_window = enabled;
+    return 0;
+}
+
+static inline int request_pic_interrupt_window(CPUState *cpu)
+{
+    return set_pic_interrupt_window(cpu, true);
+}
+
+static inline int clear_pic_interrupt_window(CPUState *cpu)
+{
+    return set_pic_interrupt_window(cpu, false);
+}
+
+static int handle_interrupt_deliverable(CPUState *cpu,
+                                        const struct hyperv_message *msg)
+{
+    CPUX86State *env = &X86_CPU(cpu)->env;
+    struct hv_x64_interruption_deliverable_message info;
+    union hv_x64_pending_ext_int_event event = { 0 };
+    struct hv_register_assoc assocs[2] = { 0 };
+    struct hv_register_assoc *event_assoc = &assocs[0],
+                             *activity_assoc = &assocs[1];
+    union hv_internal_activity_register activity;
+    bool is_suspended;
+    int ret, vector;
+
+    memcpy(&info, msg->payload, sizeof(info));
+    if (info.deliverable_type != MSHV_HV_INTERRUPTION_TYPE_EXT_INT) {
+        error_report("unexpected deliverable interruption type %u",
+                     info.deliverable_type);
+        return -1;
+    }
+
+    ret = clear_pic_interrupt_window(cpu);
+    if (ret < 0) {
+        error_report("failed to clear PIC interrupt window");
+        return -1;
+    }
+
+    bql_lock();
+    cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
+    vector = cpu_get_pic_interrupt(env);
+    bql_unlock();
+
+    /* vector == -1 means the PIC has no longer a pending interrupt */
+    if (vector < 0) {
+        return 0;
+    }
+
+    trace_mshv_pic_interrupt(cpu->cpu_index, vector);
+
+    /* we check whether the vcpu is halted first */
+    activity_assoc->name = HV_REGISTER_INTERNAL_ACTIVITY_STATE;
+    ret = mshv_get_generic_regs(cpu, activity_assoc, 1);
+    if (ret < 0) {
+        error_report("failed to read activity state before PIC delivery");
+        return -1;
+    }
+
+    event.event_pending = 1;
+    event.event_type    = HV_X64_PENDING_EVENT_EXT_INT;
+    event.vector        = vector;
+
+    event_assoc->name                        = HV_REGISTER_PENDING_EVENT0;
+    event_assoc->value.pending_ext_int_event = event;
+
+    /*
+     * If the vcpu was hlt suspended we clear the suspend bit, otherwise we
+     * only set the pending event.
+     */
+    activity = activity_assoc->value.internal_activity;
+    is_suspended = activity.halt_suspend;
+    if (is_suspended) {
+        activity.halt_suspend = 0;
+        activity_assoc->value.internal_activity = activity;
+    }
+
+    ret = mshv_set_generic_regs(cpu, assocs, is_suspended ? 2 : 1);
+    if (ret < 0) {
+        error_report("failed to set pending event%s",
+                     is_suspended ? " and activity state" : "");
+        return ret;
+    }
+
+    return 0;
+}
+
 /*
  * Flip RFLAGS.TF like WHPX. Set it only on the live register, not env->eflags,
  * so a later store won't put it back.
@@ -2139,6 +2265,14 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
         }
     }
 
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
+        ret = request_pic_interrupt_window(cpu);
+        if (ret < 0) {
+            error_report("failed to request PIC interrupt window");
+            return -1;
+        }
+    }
+
     ret = ioctl(cpu_fd, MSHV_RUN_VP, msg);
     if (ret < 0) {
         if (errno == EINTR) {
@@ -2185,6 +2319,13 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
             return -1;
         }
         return 0;
+    case HVMSG_X64_INTERRUPTION_DELIVERABLE:
+        ret = handle_interrupt_deliverable(cpu, msg);
+        if (ret < 0) {
+            return ret;
+        }
+        *exit = MshvVmExitIgnore;
+        return 0;
     default:
         break;
     }
diff --git a/target/i386/mshv/trace-events b/target/i386/mshv/trace-events
new file mode 100644
index 0000000000..347ce040ab
--- /dev/null
+++ b/target/i386/mshv/trace-events
@@ -0,0 +1,7 @@
+# Authors: Magnus Kulke <magnuskulke@microsoft.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+mshv_run_vcpu_eintr(uint32_t cpu) "cpu_index=%d"
+mshv_set_pic_interrupt_window(uint32_t cpu, bool enabled) "cpu_index=%d enabled=%d"
+mshv_pic_interrupt(uint32_t cpu, uint8_t vector) "cpu_index=%d vector=0x%x"
diff --git a/target/i386/mshv/trace.h b/target/i386/mshv/trace.h
new file mode 100644
index 0000000000..81b6b655c7
--- /dev/null
+++ b/target/i386/mshv/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-target_i386_mshv.h"
-- 
2.34.1



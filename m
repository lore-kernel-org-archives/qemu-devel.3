Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC15C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woMJc-0006Iw-6Z; Mon, 27 Jul 2026 10:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1woMJa-0006I8-BP
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:28:22 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1woMJY-0001wB-4A
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:28:22 -0400
Received: from laptop.localdomain (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1432620B7169;
 Mon, 27 Jul 2026 07:28:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1432620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1785162483;
 bh=8YAHzdAMZOSFLjOaSrwOi22ZesU/+9SRPCYzdZqMfX4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pzTvjVVteiJBQDsRkNEg7QkothuSr4MVOBhBjxV6fIUlMusYGkAsasV8suheZA2zR
 5Se/WeA+MnUNSE80rk4OQiTx1dcQOsjdtVLe//LA1qD1ORncUdIh2flmCqTYJ0jGIV
 FOwBHyD6c7TVAzRb6Tn58Vp5AtdFP1/tRefdg5gg=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH 2/3] accel/mshv: add gdbstub software breakpoint support
Date: Mon, 27 Jul 2026 17:28:06 +0300
Message-ID: <20260727142807.84269-3-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727142807.84269-1-dblanzeanu@linux.microsoft.com>
References: <20260727142807.84269-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement software breakpoint based guest debugging for the MSHV
accelerator, modeled on the WHPX backend. The guest-visible debug
registers are not used: a breakpoint is an INT1 (opcode 0xf1)
patched into guest memory, which raises a #DB when executed.

A partition-wide intercept on #DB is installed the first time a
breakpoint (or single step) is requested. The intercept is not uninstalled,
so it stays for the lifetime of the VM and every vmexit mshv_handle_debug()
decides whether the #DB belongs to gdb (it hit one of our INT1 breakpoints) or
to the guest; a guest-owned #DB is handed back through a pending exception
event so the guest takes it through its own IDT.
Guest INT3 (#BP) is deliberately left to the guest's own IDT and is never
intercepted.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       | 165 +++++++++++++++++++++++++++++++++++-
 include/system/mshv_int.h   |  14 +++
 target/i386/mshv/mshv-cpu.c |  86 +++++++++++++++++++
 3 files changed, 264 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 72721d0f0d..afcb87b3b8 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -29,6 +29,7 @@
 
 #include "qemu/accel.h"
 #include "qemu/guest-random.h"
+#include "gdbstub/enums.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "exec/cpu-common.h"
@@ -583,6 +584,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
     s->nr_as = 1;
     s->as = g_new0(MshvAddressSpace, s->nr_as);
 
+    QTAILQ_INIT(&s->sw_breakpoints);
+
+    as->gdbstub.sstep_flags = SSTEP_ENABLE;
+
     mshv_state = s;
 
     mshv_init_irq_routing(s);
@@ -607,6 +612,153 @@ static int mshv_destroy_vcpu(CPUState *cpu)
     return 0;
 }
 
+struct MshvSwBreakpoint *mshv_find_sw_breakpoint(CPUState *cpu, vaddr pc)
+{
+    struct MshvSwBreakpoint *bp;
+
+    QTAILQ_FOREACH(bp, &mshv_state->sw_breakpoints, entry) {
+        if (bp->pc == pc) {
+            return bp;
+        }
+    }
+    return NULL;
+}
+
+static int mshv_install_exception_intercept(int vm_fd, uint16_t vector)
+{
+    struct hv_input_install_intercept in = {0};
+    struct mshv_root_hvcall args = {0};
+    int ret;
+
+    in.access_type = 1 << HV_X64_INTERCEPT_ACCESS_TYPE_EXECUTE;
+    in.intercept_type = HV_INTERCEPT_TYPE_EXCEPTION;
+    in.intercept_parameter.as_uint64 = vector;
+
+    args.code = HVCALL_INSTALL_INTERCEPT;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+
+    ret = mshv_hvcall(vm_fd, &args);
+    if (ret < 0) {
+        error_report("Failed to install exception intercept for vector %u",
+                     vector);
+    }
+    return ret;
+}
+
+/*
+ * Install the #DB intercept. This is a permanent, partition-wide latch: it is
+ * installed once on the first debug use and stays for the lifetime of the VM.
+ */
+static int mshv_init_exception_intercept(void)
+{
+    int ret;
+
+    if (mshv_state->exception_intercepts_installed) {
+        return 0;
+    }
+
+    /* Only #DB is needed: gdb breakpoints are INT1 (0xf1) */
+    ret = mshv_install_exception_intercept(mshv_state->vm, 1); /* #DB */
+    if (ret < 0) {
+        return ret;
+    }
+
+    mshv_state->exception_intercepts_installed = true;
+    return 0;
+}
+
+static int mshv_update_guest_debug(CPUState *cpu)
+{
+    if (cpu_single_stepping(cpu)) {
+        /* Installs exception intercept only on the first call */
+        return mshv_init_exception_intercept();
+    }
+    return 0;
+}
+
+static int mshv_insert_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
+                                          vaddr addr, vaddr len)
+{
+    struct MshvSwBreakpoint *bp;
+    int err;
+
+    /* We don't use the guest's debug registers. */
+    if (type != GDB_BREAKPOINT_SW) {
+        return -ENOSYS;
+    }
+
+    bp = mshv_find_sw_breakpoint(cpu, addr);
+    if (bp) {
+        bp->use_count++;
+        return 0;
+    }
+
+    bp = g_new(struct MshvSwBreakpoint, 1);
+    bp->pc = addr;
+    bp->use_count = 1;
+    err = mshv_arch_insert_sw_breakpoint(cpu, bp);
+    if (err) {
+        g_free(bp);
+        return err;
+    }
+
+    QTAILQ_INSERT_HEAD(&mshv_state->sw_breakpoints, bp, entry);
+
+    /* Installs exception intercept only on the first call */
+    return mshv_init_exception_intercept();
+}
+
+static int mshv_remove_gdbstub_breakpoint(CPUState *cpu, GdbBreakpointType type,
+                                          vaddr addr, vaddr len)
+{
+    struct MshvSwBreakpoint *bp;
+    int err;
+
+    if (type != GDB_BREAKPOINT_SW) {
+        return -ENOSYS;
+    }
+
+    bp = mshv_find_sw_breakpoint(cpu, addr);
+    if (!bp) {
+        return -ENOENT;
+    }
+
+    if (bp->use_count > 1) {
+        bp->use_count--;
+        return 0;
+    }
+
+    err = mshv_arch_remove_sw_breakpoint(cpu, bp);
+    if (err) {
+        return err;
+    }
+
+    QTAILQ_REMOVE(&mshv_state->sw_breakpoints, bp, entry);
+    g_free(bp);
+
+    return 0;
+}
+
+static void mshv_remove_all_gdbstub_breakpoints(CPUState *cpu)
+{
+    struct MshvSwBreakpoint *bp, *next;
+    CPUState *tmpcpu;
+
+    QTAILQ_FOREACH_SAFE(bp, &mshv_state->sw_breakpoints, entry, next) {
+        if (mshv_arch_remove_sw_breakpoint(cpu, bp) != 0) {
+            /* Fall back to whichever CPU still has it mapped. */
+            CPU_FOREACH(tmpcpu) {
+                if (mshv_arch_remove_sw_breakpoint(tmpcpu, bp) == 0) {
+                    break;
+                }
+            }
+        }
+        QTAILQ_REMOVE(&mshv_state->sw_breakpoints, bp, entry);
+        g_free(bp);
+    }
+}
+
 static int mshv_cpu_exec(CPUState *cpu)
 {
     hv_message mshv_msg;
@@ -637,6 +789,9 @@ static int mshv_cpu_exec(CPUState *cpu)
         switch (exit_reason) {
         case MshvVmExitIgnore:
             break;
+        case MshvVmExitDebug:
+            ret = EXCP_DEBUG;
+            break;
         default:
             ret = EXCP_INTERRUPT;
             break;
@@ -708,7 +863,10 @@ static void *mshv_vcpu_thread(void *arg)
     do {
         qemu_process_cpu_events(cpu);
         if (cpu_can_run(cpu)) {
-            mshv_cpu_exec(cpu);
+            ret = mshv_cpu_exec(cpu);
+            if (ret == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
         }
     } while (!cpu->unplug || cpu_can_run(cpu));
 
@@ -852,6 +1010,11 @@ static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = mshv_cpu_synchronize_pre_loadvm;
     ops->cpus_are_resettable = mshv_cpus_are_resettable;
     ops->handle_interrupt = generic_handle_interrupt;
+
+    ops->update_guest_debug = mshv_update_guest_debug;
+    ops->insert_gdbstub_breakpoint = mshv_insert_gdbstub_breakpoint;
+    ops->remove_gdbstub_breakpoint = mshv_remove_gdbstub_breakpoint;
+    ops->remove_all_gdbstub_breakpoints = mshv_remove_all_gdbstub_breakpoints;
 }
 
 static const TypeInfo mshv_accel_ops_type = {
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index b91c4d661a..9244915eb6 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -15,6 +15,7 @@
 #define QEMU_MSHV_INT_H
 
 #include "hw/hyperv/hvhdk.h"
+#include "exec/vaddr.h"
 
 #define MSHV_MSR_ENTRIES_COUNT 64
 
@@ -56,6 +57,13 @@ typedef struct MshvAddressSpace {
     AddressSpace *as;
 } MshvAddressSpace;
 
+struct MshvSwBreakpoint {
+    vaddr pc;
+    vaddr saved_insn;
+    int use_count;
+    QTAILQ_ENTRY(MshvSwBreakpoint) entry;
+};
+
 struct MshvState {
     AccelState parent_obj;
     int vm;
@@ -70,6 +78,8 @@ struct MshvState {
     unsigned long *used_gsi_bitmap;
     unsigned int gsi_count;
     union hv_partition_processor_features processor_features;
+    QTAILQ_HEAD(, MshvSwBreakpoint) sw_breakpoints;
+    bool exception_intercepts_installed;
 };
 
 typedef struct MshvMsiControl {
@@ -85,6 +95,7 @@ typedef enum MshvVmExit {
     MshvVmExitIgnore   = 0,
     MshvVmExitShutdown = 1,
     MshvVmExitSpecial  = 2,
+    MshvVmExitDebug    = 3,
 } MshvVmExit;
 
 void mshv_init_mmio_emu(void);
@@ -98,6 +109,9 @@ int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
                           size_t n_regs);
 int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
+int mshv_arch_insert_sw_breakpoint(CPUState *cpu, struct MshvSwBreakpoint *bp);
+int mshv_arch_remove_sw_breakpoint(CPUState *cpu, struct MshvSwBreakpoint *bp);
+struct MshvSwBreakpoint *mshv_find_sw_breakpoint(CPUState *cpu, vaddr pc);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 1c433c408c..2333d3304a 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/memalign.h"
 
 #include "system/mshv.h"
@@ -28,6 +29,7 @@
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_flags.h"
+#include "gdbstub/enums.h"
 
 #include "accel/accel-cpu-target.h"
 
@@ -1932,6 +1934,46 @@ static int handle_pio(CPUState *cpu, const struct hyperv_message *msg)
     return handle_pio_non_str(cpu, &info);
 }
 
+/* Re-inject a guest-owned #DB via a pending event */
+static int reinject_exception(CPUState *cpu,
+    struct hv_x64_exception_intercept_message *info)
+{
+    hv_register_assoc assoc = { .name = HV_REGISTER_PENDING_EVENT0 };
+
+    assoc.value.pending_exception_event.event_pending = 1;
+    assoc.value.pending_exception_event.event_type =
+        HV_X64_PENDING_EVENT_EXCEPTION;
+    assoc.value.pending_exception_event.exception_parameter =
+        info->exception_parameter;
+    assoc.value.pending_exception_event.vector = info->exception_vector;
+
+    return mshv_set_generic_regs(cpu, &assoc, 1);
+}
+
+/* Check if the intercepted #DB has been set by gdb. */
+static int handle_debug(CPUState *cpu, hv_message *msg)
+{
+    struct hv_x64_exception_intercept_message *info = (void *)msg->payload;
+
+    /* Only #DB is intercepted */
+    if (info->exception_vector != EXCP01_DB) {
+        return 0;
+    }
+
+    /* INT1 hit: RIP points at the breakpoint */
+    if (mshv_find_sw_breakpoint(cpu, info->header.rip) != NULL) {
+        return EXCP_DEBUG;
+    }
+
+    /* Check if single stepping */
+    if (cpu_single_stepping(cpu)) {
+        return EXCP_DEBUG;
+    }
+
+    /* The guest's own #DB; caller re-injects it. */
+    return 0;
+}
+
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 {
     int ret;
@@ -1960,6 +2002,24 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
             return MshvVmExitSpecial;
         }
         return MshvVmExitIgnore;
+    case HVMSG_X64_EXCEPTION_INTERCEPT:
+        bql_lock();
+        if (handle_debug(cpu, msg) == EXCP_DEBUG) {
+            *exit = MshvVmExitDebug;
+            bql_unlock();
+            return 0;
+        }
+        /* Not ours - hand the #DB back to the guest and keep running. */
+        ret = reinject_exception(cpu,
+            (struct hv_x64_exception_intercept_message *)msg->payload);
+        bql_unlock();
+        if (ret < 0) {
+            error_report("failed to reinject exception on vcpu %d",
+                         cpu->cpu_index);
+            return -1;
+        }
+        *exit = MshvVmExitIgnore;
+        return 0;
     default:
         break;
     }
@@ -1973,6 +2033,32 @@ void mshv_remove_vcpu(int vm_fd, int cpu_fd)
     close(cpu_fd);
 }
 
+int mshv_arch_insert_sw_breakpoint(CPUState *cpu, struct MshvSwBreakpoint *bp)
+{
+    static const uint8_t int1 = 0xf1;
+
+    if (cpu_memory_rw_debug(cpu, bp->pc, (uint8_t *)&bp->saved_insn, 1, 0) ||
+        cpu_memory_rw_debug(cpu, bp->pc, (uint8_t *)&int1, 1, 1)) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
+int mshv_arch_remove_sw_breakpoint(CPUState *cpu, struct MshvSwBreakpoint *bp)
+{
+    uint8_t int1;
+
+    if (cpu_memory_rw_debug(cpu, bp->pc, &int1, 1, 0)) {
+        return -EINVAL;
+    }
+    if (int1 != 0xf1) {
+        return 0;
+    }
+    if (cpu_memory_rw_debug(cpu, bp->pc, (uint8_t *)&bp->saved_insn, 1, 1)) {
+        return -EINVAL;
+    }
+    return 0;
+}
 
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
 {
-- 
2.53.0



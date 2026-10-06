Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFBCCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENFh-0000Kn-0z; Wed, 07 Oct 2026 04:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xEIxk-0001Fk-SU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:09:08 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xEIxi-00062U-7W
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:09:04 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.46])
 by linux.microsoft.com (Postfix) with ESMTPSA id DB45820B7171;
 Tue,  6 Oct 2026 09:48:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB45820B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791305338;
 bh=rpfCCQ+GbM5t0xKp54zEzxOJoexKBo4ENnKL7Lkkwug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EAm4LKyT5NakAtK4R7GyDSn2cmPg/jsjv9uNH4l9KhjUA7M9XF29I1a47539+fP4X
 boba9AonmtEb2yJ5Qpd9ptvd1DW30mL+sw0+Wh8O5MDn0WEiSLF58kavSxfSAMKyf5
 5S/U5AdYkQFr/AnQHRSJZZwpxRt0v0JCxzqYP8f8=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/11] accel/mshv: add gdbstub software breakpoint support
Date: Tue,  6 Oct 2026 18:49:04 +0200
Message-Id: <20261006164905.776466-11-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
References: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

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

(adapted to the signature change of accel_ops->update_guest_debug)

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       | 170 +++++++++++++++++++++++++++++++++++-
 include/system/mshv_int.h   |  14 +++
 target/i386/mshv/mshv-cpu.c | 104 ++++++++++++++++++++++
 3 files changed, 287 insertions(+), 1 deletion(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 5921ce693e..d820a67b95 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -29,6 +29,7 @@
 
 #include "qemu/accel.h"
 #include "qemu/guest-random.h"
+#include "gdbstub/enums.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "exec/cpu-common.h"
@@ -563,6 +564,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
     s->nr_as = 1;
     s->as = g_new0(MshvAddressSpace, s->nr_as);
 
+    QTAILQ_INIT(&s->sw_breakpoints);
+
+    as->gdbstub.sstep_flags = SSTEP_ENABLE;
+
     mshv_state = s;
 
     mshv_init_irq_routing(s);
@@ -591,6 +596,158 @@ static int mshv_destroy_vcpu(CPUState *cpu)
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
+static void mshv_update_guest_debug(CPUState *cpu)
+{
+    int ret;
+
+    if (cpu_single_stepping(cpu)) {
+        /* Installs exception intercept only on the first call */
+        ret = mshv_init_exception_intercept();
+        if (ret < 0) {
+            error_report("Failed to install exception intercept for #DB");
+            abort();
+        }
+    }
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
@@ -628,6 +785,9 @@ static int mshv_cpu_exec(CPUState *cpu)
         switch (exit_reason) {
         case MshvVmExitIgnore:
             break;
+        case MshvVmExitDebug:
+            ret = EXCP_DEBUG;
+            break;
         default:
             ret = EXCP_INTERRUPT;
             break;
@@ -695,7 +855,10 @@ static void *mshv_vcpu_thread(void *arg)
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
 
@@ -840,6 +1003,11 @@ static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->cpus_are_resettable = mshv_cpus_are_resettable;
     ops->cpu_thread_is_idle = mshv_vcpu_thread_is_idle;
     ops->handle_interrupt = generic_handle_interrupt;
+
+    ops->update_guest_debug = mshv_update_guest_debug;
+    ops->insert_gdbstub_breakpoint = mshv_insert_gdbstub_breakpoint;
+    ops->remove_gdbstub_breakpoint = mshv_remove_gdbstub_breakpoint;
+    ops->remove_all_gdbstub_breakpoints = mshv_remove_all_gdbstub_breakpoints;
 }
 
 static const TypeInfo mshv_accel_ops_type = {
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 3dffe3c5fb..1f77ffd152 100644
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
@@ -100,6 +111,9 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
 int mshv_arch_set_partition_msrs(const CPUState *cpu);
 int mshv_arch_set_mp_state(const CPUState *cpu);
+int mshv_arch_insert_sw_breakpoint(CPUState *cpu, struct MshvSwBreakpoint *bp);
+int mshv_arch_remove_sw_breakpoint(CPUState *cpu, struct MshvSwBreakpoint *bp);
+struct MshvSwBreakpoint *mshv_find_sw_breakpoint(CPUState *cpu, vaddr pc);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index f2b5641231..0670e7a5ae 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/main-loop.h"
 #include "qemu/memalign.h"
 
 #include "system/mshv.h"
@@ -27,6 +28,7 @@
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_flags.h"
+#include "gdbstub/enums.h"
 
 #include "accel/accel-cpu-target.h"
 
@@ -2023,6 +2025,72 @@ static int handle_pio(CPUState *cpu, const struct hyperv_message *msg)
     return handle_pio_non_str(cpu, &info);
 }
 
+/* Re-inject a guest-owned #DB via a pending event */
+static int reinject_exception(CPUState *cpu,
+    const struct hv_x64_exception_intercept_message *info)
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
+static bool is_debug_exception(CPUState *cpu, const hv_message *msg)
+{
+    struct hv_x64_exception_intercept_message *info = (void *)msg->payload;
+
+    /* Only #DB is intercepted */
+    if (info->exception_vector != EXCP01_DB) {
+        return false;
+    }
+
+    /* INT1 hit: RIP points at the breakpoint */
+    if (mshv_find_sw_breakpoint(cpu, info->header.rip) != NULL) {
+        return true;
+    }
+
+    /* Check if single stepping */
+    if (cpu_single_stepping(cpu)) {
+        return true;
+    }
+
+    /* The guest's own #DB; caller re-injects it. */
+    return false;
+}
+
+static int handle_exception_interrupt(CPUState *cpu,
+                                       const struct hyperv_message *msg,
+                                       MshvVmExit *exit_reason)
+{
+    int ret;
+
+    if (is_debug_exception(cpu, msg)) {
+        /* Exit early reporting debug exception */
+        *exit_reason = MshvVmExitDebug;
+        return 0;
+    }
+
+    /* Not ours - hand the #DB back to the guest and keep running. */
+    ret = reinject_exception(cpu,
+        (struct hv_x64_exception_intercept_message *) msg->payload);
+    if (ret < 0) {
+        error_report("failed to reinject exception on vcpu %d",
+                     cpu->cpu_index);
+        return -1;
+    }
+
+    *exit_reason = MshvVmExitIgnore;
+
+    return 0;
+}
+
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 {
     int ret;
@@ -2051,6 +2119,16 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
             return MshvVmExitSpecial;
         }
         return MshvVmExitIgnore;
+    case HVMSG_X64_EXCEPTION_INTERCEPT:
+        bql_lock();
+        ret = handle_exception_interrupt(cpu, msg, &exit_reason);
+        bql_unlock();
+        if (ret < 0) {
+            error_report("failed to handle exception intercept");
+            return -1;
+        }
+        *exit = exit_reason;
+        return exit_reason;
     default:
         break;
     }
@@ -2064,6 +2142,32 @@ void mshv_remove_vcpu(int vm_fd, int cpu_fd)
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
2.34.1



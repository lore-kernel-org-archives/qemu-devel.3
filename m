Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A03E6F093
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY2xt-0005G2-JQ; Tue, 23 Dec 2025 09:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vY16Q-0005L7-6x
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 07:02:58 -0500
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ashish.a6@samsung.com>)
 id 1vY16L-00028g-NV
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 07:02:57 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20251223120244epoutp024397366f2793b9c97be4368d7ed2e543~D1olVyIiv1773417734epoutp02W
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 12:02:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20251223120244epoutp024397366f2793b9c97be4368d7ed2e543~D1olVyIiv1773417734epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1766491364;
 bh=+jIeGwIatjkyU4t7V93SrU6AI+YxYI+n5AFl/dB/Tsg=;
 h=From:To:Cc:Subject:Date:References:From;
 b=dZSgEBbkRnz+wANoz2IL0vTpkCURglkL0mYCZvqeogQ++sM6Qt/JOADVJeE/3c3gs
 aL2QQ/kwm8Vuv9kXLsMxQ2S4NPnmy9dCzfI/hPI3891B42U9VJYCplzIogfgFIrIuZ
 woy7bxfcxPQk8KvuVYT7FZ996elca+eXdxkQlhVA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20251223120243epcas5p4fac8c002c8f443f8a716510b0865da50~D1olDvkCi1846618466epcas5p4m;
 Tue, 23 Dec 2025 12:02:43 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.88]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4dbDCk6m0Lz6B9m5; Tue, 23 Dec
 2025 12:02:42 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20251223120242epcas5p44b454df5afd0d517a4562a545ad11218~D1ojhtPZe1846618466epcas5p4i;
 Tue, 23 Dec 2025 12:02:42 +0000 (GMT)
Received: from test-System-Product-Name.samsungds.net (unknown
 [107.99.41.85]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20251223120240epsmtip12d23c4881f6573367aa14d8cdc9b0a04~D1ohk4nw03164831648epsmtip19;
 Tue, 23 Dec 2025 12:02:39 +0000 (GMT)
From: Ashish Anand <ashish.a6@samsung.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, y.kaushal@samsung.com,
 vishwa.mg@samsung.com, ashish.anand202@gmail.com, "ashish.a6"
 <ashish.a6@samsung.com>
Subject: [PATCH] target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M
Date: Tue, 23 Dec 2025 17:30:12 +0530
Message-ID: <20251223120012.541777-1-ashish.a6@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251223120242epcas5p44b454df5afd0d517a4562a545ad11218
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251223120242epcas5p44b454df5afd0d517a4562a545ad11218
References: <CGME20251223120242epcas5p44b454df5afd0d517a4562a545ad11218@epcas5p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=ashish.a6@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Dec 2025 09:01:09 -0500
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

From: "ashish.a6" <ashish.a6@samsung.com>

    Currently, QEMU implements the 'Wait For Event' (WFE) instruction as a
    a simple yield. This causes high host CPU usage because Guest
    RTOS idle loops effectively become busy-wait loops.

    To improve efficiency, this patch transitions WFE to use the architectural
    'Halt' state (EXCP_HLT) for M-profile CPUs. This allows the host thread
    to sleep when the guest is idle.

    To support this transition, we implement the full architectural behavior
    required for WFE, specifically the 'Event Register' and 'SEVONPEND' logic
    defined in the ARMv7-M specification. This ensures that the CPU correctly
    identifies wakeup conditions as defined by the architecture.

    Changes include:
    1.  target/arm/cpu.h: Added 'event_register' to the v7m state struct.
    2.  target/arm/cpu.c: Ensured event_register is cleared on reset and
        updated arm_cpu_has_work() to check the event register state.
    3.  target/arm/machine.c: Added VMState subsection for migration compatibility.
    4.  hw/intc/armv7m_nvic.h: Added was_pending flag, to check for SEVONPEND logic.
    5.  hw/intc/armv7m_nvic.c: Implemented SEVONPEND logic in :
        nvic_recompute_state() and nvic_recompute_state_secure().
        This sets the event register and kicks the CPU when a new interrupt
        becomes pending.
    6.  target/arm/tcg/helper.h: Declare the new helper_sev function.
    7.  target/arm/tcg/op_helper.c:
        - Update HELPER(wfe) to use EXCP_HLT for M-profile CPUs.
        - Implement HELPER(sev) to set the event register and kick all vCPUs.
    8.  target/arm/tcg/t16.decode / t32.decode: Enable decoding of the SEV
        instruction in Thumb/Thumb-2 mode.
    9.  target/arm/tcg/translate.c: Implement trans_SEV using inline
        TCG generation to ensure system-wide visibility.

    This patch enables resource-efficient idle emulation for Cortex-M.

    Signed-off-by: Ashish Anand ashish.a6@samsung.com
---
Testing Notes:
- Performance Test: Monitored host CPU usage while the guest was in an 
  idle loop. Usage dropped from 100% (busy-yield) to <5% (EXCP_HALT).
- Functional Test: Verified SEVONPEND logic using a bare-metal test 
  case on Cortex-M. Confirmed that pending interrupts correctly 
  trigger a wakeup when SEVONPEND is enabled, as per Armv7-M spec.
- Regression Test: 'make check' passes for all ARM targets.
- Note: 4 x86-specific test cases (lpc-ich9, e1000e) failed, but 
  I confirmed these also fail on a clean master branch.

 hw/intc/armv7m_nvic.c         | 22 ++++++++++++++++-
 include/hw/intc/armv7m_nvic.h |  1 +
 target/arm/cpu.c              |  7 ++++++
 target/arm/cpu.h              |  1 +
 target/arm/machine.c          | 19 +++++++++++++++
 target/arm/tcg/helper.h       |  1 +
 target/arm/tcg/op_helper.c    | 45 +++++++++++++++++++++++++++++------
 target/arm/tcg/t16.decode     |  2 +-
 target/arm/tcg/t32.decode     |  2 +-
 target/arm/tcg/translate.c    | 20 ++++++++++++----
 10 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 7c78961040..a60990c71f 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -16,6 +16,7 @@
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "hw/intc/armv7m_nvic.h"
+#include "hw/arm/armv7m.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "system/tcg.h"
@@ -232,6 +233,8 @@ static void nvic_recompute_state_secure(NVICState *s)
     int pend_irq = 0;
     bool pending_is_s_banked = false;
     int pend_subprio = 0;
+    ARMv7MState *armv7m = container_of(s, ARMv7MState, nvic);
+    ARMCPU *cpu = armv7m->cpu;
 
     /* R_CQRV: precedence is by:
      *  - lowest group priority; if both the same then
@@ -259,6 +262,14 @@ static void nvic_recompute_state_secure(NVICState *s)
                 targets_secure = !exc_is_banked(i) && exc_targets_secure(s, i);
             }
 
+            if (!vec->was_pending && vec->pending) {
+                if (cpu->env.v7m.scr[bank] & R_V7M_SCR_SEVONPEND_MASK) {
+                    cpu->env.v7m.event_register = 1;
+                    qemu_cpu_kick(CPU(cpu));
+                }
+            }
+            vec->was_pending = vec->pending;
+
             prio = exc_group_prio(s, vec->prio, targets_secure);
             subprio = vec->prio & ~nvic_gprio_mask(s, targets_secure);
             if (vec->enabled && vec->pending &&
@@ -293,6 +304,8 @@ static void nvic_recompute_state(NVICState *s)
     int pend_prio = NVIC_NOEXC_PRIO;
     int active_prio = NVIC_NOEXC_PRIO;
     int pend_irq = 0;
+    ARMv7MState *armv7m = container_of(s, ARMv7MState, nvic);
+    ARMCPU *cpu = armv7m->cpu;
 
     /* In theory we could write one function that handled both
      * the "security extension present" and "not present"; however
@@ -316,6 +329,13 @@ static void nvic_recompute_state(NVICState *s)
         if (vec->active && vec->prio < active_prio) {
             active_prio = vec->prio;
         }
+        if (!vec->was_pending && vec->pending) {
+            if (cpu->env.v7m.scr[M_REG_NS] & R_V7M_SCR_SEVONPEND_MASK) {
+                cpu->env.v7m.event_register = 1;
+                qemu_cpu_kick(CPU(cpu));
+            }
+        }
+        vec->was_pending = vec->pending;
     }
 
     if (active_prio > 0) {
@@ -1657,7 +1677,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
         /* We don't implement deep-sleep so these bits are RAZ/WI.
          * The other bits in the register are banked.
-         * QEMU's implementation ignores SEVONPEND and SLEEPONEXIT, which
+         * QEMU's implementation ignores SLEEPONEXIT, which
          * is architecturally permitted.
          */
         value &= ~(R_V7M_SCR_SLEEPDEEP_MASK | R_V7M_SCR_SLEEPDEEPS_MASK);
diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 7b9964fe7e..305eaf6e6a 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -32,6 +32,7 @@ typedef struct VecInfo {
     uint8_t pending;
     uint8_t active;
     uint8_t level; /* exceptions <=15 never set level */
+    bool was_pending;
 } VecInfo;
 
 struct NVICState {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 39292fb9bc..0a044f7254 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -143,6 +143,12 @@ static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
 
+    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+        if (cpu->env.v7m.event_register) {
+            return true;
+        }
+    }
+
     return (cpu->power_state != PSCI_OFF)
         && cpu_test_interrupt(cs,
                CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
@@ -480,6 +486,7 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
             ~(R_V7M_FPCCR_LSPEN_MASK | R_V7M_FPCCR_S_MASK);
         env->v7m.control[M_REG_S] |= R_V7M_CONTROL_FPCA_MASK;
 #endif
+        env->v7m.event_register = 0;
     }
 
     /* M profile requires that reset clears the exclusive monitor;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39f2b2e54d..44433a444c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -639,6 +639,7 @@ typedef struct CPUArchState {
         uint32_t nsacr;
         uint32_t ltpsize;
         uint32_t vpr;
+        uint32_t event_register;
     } v7m;
 
     /* Information associated with an exception about to be taken:
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 0befdb0b28..acc79188f2 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -508,6 +508,24 @@ static const VMStateDescription vmstate_m_mve = {
     },
 };
 
+static bool m_event_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    /* Only save the state if the event register is set (non-zero) */
+    return cpu->env.v7m.event_register != 0;
+}
+
+static const VMStateDescription vmstate_m_event = {
+    .name = "cpu/m/event",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = m_event_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(env.v7m.event_register, ARMCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_m = {
     .name = "cpu/m",
     .version_id = 4,
@@ -535,6 +553,7 @@ static const VMStateDescription vmstate_m = {
         &vmstate_m_v8m,
         &vmstate_m_fp,
         &vmstate_m_mve,
+        &vmstate_m_event,
         NULL
     }
 };
diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 4636d1bc03..5a10a9fba3 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -60,6 +60,7 @@ DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
 DEF_HELPER_1(vesb, void, env)
+DEF_HELPER_1(sev, void, env)
 
 DEF_HELPER_3(cpsr_write, void, env, i32, i32)
 DEF_HELPER_2(cpsr_write_eret, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 4fbd219555..ad79724778 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -469,16 +469,47 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
 #endif
 }
 
+void HELPER(sev)(CPUARMState *env)
+{
+    CPUState *cs = env_cpu(env);
+    CPU_FOREACH(cs) {
+        ARMCPU *target_cpu = ARM_CPU(cs);
+        if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
+            target_cpu->env.v7m.event_register = 1;
+        }
+        qemu_cpu_kick(cs);
+    }
+}
+
 void HELPER(wfe)(CPUARMState *env)
 {
-    /* This is a hint instruction that is semantically different
-     * from YIELD even though we currently implement it identically.
-     * Don't actually halt the CPU, just yield back to top
-     * level loop. This is not going into a "low power state"
-     * (ie halting until some event occurs), so we never take
-     * a configurable trap to a different exception level.
+    /*
+     * WFE (Wait For Event) is a hint instruction.
+     * For Cortex-M (M-profile), we implement the strict architectural behavior:
+     * 1. Check the Event Register (set by SEV or SEVONPEND).
+     * 2. If set, clear it and continue (consume the event).
      */
-    HELPER(yield)(env);
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        CPUState *cs = env_cpu(env);
+
+        if (env->v7m.event_register) {
+            env->v7m.event_register = 0;
+            return;
+        }
+
+        cs->exception_index = EXCP_HLT;
+        cs->halted = 1;
+        cpu_loop_exit(cs);
+    } else {
+        /*
+         * For A-profile and others, we rely on the existing "yield" behavior.
+         * Don't actually halt the CPU, just yield back to top
+         * level loop. This is not going into a "low power state"
+         * (ie halting until some event occurs), so we never take
+         * a configurable trap to a different exception level
+         */
+        HELPER(yield)(env);
+    }
 }
 
 void HELPER(yield)(CPUARMState *env)
diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
index 646c74929d..ac6e24ac14 100644
--- a/target/arm/tcg/t16.decode
+++ b/target/arm/tcg/t16.decode
@@ -229,7 +229,7 @@ REVSH           1011 1010 11 ... ...            @rdm
     WFI         1011 1111 0011 0000
 
     # TODO: Implement SEV, SEVL; may help SMP performance.
-    # SEV       1011 1111 0100 0000
+    SEV         1011 1111 0100 0000
     # SEVL      1011 1111 0101 0000
 
     # The canonical nop has the second nibble as 0000, but the whole of the
diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
index d327178829..59b0edf63f 100644
--- a/target/arm/tcg/t32.decode
+++ b/target/arm/tcg/t32.decode
@@ -370,7 +370,7 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
         WFI      1111 0011 1010 1111 1000 0000 0000 0011
 
         # TODO: Implement SEV, SEVL; may help SMP performance.
-        # SEV    1111 0011 1010 1111 1000 0000 0000 0100
+        SEV      1111 0011 1010 1111 1000 0000 0000 0100
         # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
 
         ESB      1111 0011 1010 1111 1000 0000 0001 0000
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 63735d9789..bfe2691884 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3241,14 +3241,25 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
     return true;
 }
 
+static bool trans_SEV(DisasContext *s, arg_SEV *a)
+{
+    gen_update_pc(s, curr_insn_len(s));
+    gen_helper_sev(tcg_env);
+    tcg_gen_exit_tb(NULL, 0);
+    s->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
     /*
      * When running single-threaded TCG code, use the helper to ensure that
-     * the next round-robin scheduled vCPU gets a crack.  In MTTCG mode we
-     * just skip this instruction.  Currently the SEV/SEVL instructions,
-     * which are *one* of many ways to wake the CPU from WFE, are not
-     * implemented so we can't sleep like WFI does.
+     * the next round-robin scheduled vCPU gets a crack.
+     *
+     * For Cortex-M, we implement the architectural WFE behavior (sleeping
+     * until an event occurs or the Event Register is set).
+     * For other profiles, we currently treat this as a NOP or yield,
+     * to preserve existing performance characteristics.
      */
     if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
         gen_update_pc(s, curr_insn_len(s));
@@ -6807,6 +6818,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             break;
         case DISAS_WFE:
             gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_YIELD:
             gen_helper_yield(tcg_env);
-- 
2.43.0



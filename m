Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DB6C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLoz-0007eW-Pj; Fri, 08 Aug 2025 08:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnc-0004HU-B8
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnY-0007C1-Uv
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754654532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLMw2B3DrLsO7jwiIReUUqrbIfw9QDzAPr9Mm3J+LjY=;
 b=H+rSwIaQajmgWRkFrPDufs6C1+lf3Y8aYhvr6++05wpyoNpbKtLTHrnLtzGzfUtZdhKmhR
 Dv9eTuoesx5Y59dEnotBbOW9Pg4x4Hp2ZoJ37WYcKlh+RUHz4KZEtv6boGczm9Gga6oTWf
 G+HwmlyUe3D8gH+0EvOk+70X7srzA9w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-fc1UNinHN8mKr87CBipgiQ-1; Fri,
 08 Aug 2025 08:02:08 -0400
X-MC-Unique: fc1UNinHN8mKr87CBipgiQ-1
X-Mimecast-MFC-AGG-ID: fc1UNinHN8mKr87CBipgiQ_1754654527
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8057519560B5; Fri,  8 Aug 2025 12:02:07 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3E9719560B4; Fri,  8 Aug 2025 12:02:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, mtosatti@redhat.com
Subject: [PATCH v3 09/10] use cpu_test_interrupt() instead of oppen coding
 checks tree wide
Date: Fri,  8 Aug 2025 14:01:36 +0200
Message-ID: <20250808120137.2208800-10-imammedo@redhat.com>
In-Reply-To: <20250808120137.2208800-1-imammedo@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

replace open coded checks for if interrupt is set with cpu_test_interrupt()
helper. It ensures that proper barriers are in place in case checks happen
outside of BQL and also makes checks more consistent/easier to read/find.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 accel/tcg/cpu-exec.c                | 10 ++++-----
 target/alpha/cpu.c                  |  8 +++----
 target/arm/cpu.c                    | 20 ++++++++---------
 target/arm/helper.c                 | 16 +++++++-------
 target/arm/hvf/hvf.c                |  6 ++---
 target/avr/cpu.c                    |  2 +-
 target/hppa/cpu.c                   |  2 +-
 target/i386/hvf/hvf.c               |  4 ++--
 target/i386/hvf/x86hvf.c            | 21 +++++++++---------
 target/i386/nvmm/nvmm-all.c         | 24 ++++++++++----------
 target/i386/tcg/system/seg_helper.c |  2 +-
 target/i386/whpx/whpx-all.c         | 34 ++++++++++++++---------------
 target/loongarch/cpu.c              |  2 +-
 target/m68k/cpu.c                   |  2 +-
 target/microblaze/cpu.c             |  2 +-
 target/mips/cpu.c                   |  6 ++---
 target/mips/kvm.c                   |  2 +-
 target/openrisc/cpu.c               |  3 +--
 target/ppc/cpu_init.c               |  2 +-
 target/ppc/kvm.c                    |  2 +-
 target/rx/cpu.c                     |  3 +--
 target/rx/helper.c                  |  2 +-
 target/s390x/cpu-system.c           |  2 +-
 target/sh4/cpu.c                    |  2 +-
 target/sh4/helper.c                 |  2 +-
 target/sparc/cpu.c                  |  2 +-
 target/sparc/int64_helper.c         |  4 ++--
 27 files changed, 92 insertions(+), 95 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 713bdb2056..1269c2c6ba 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -778,7 +778,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      */
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
 
-    if (unlikely(qatomic_read(&cpu->interrupt_request))) {
+    if (unlikely(cpu_test_interrupt(cpu, ~0))) {
         int interrupt_request;
         bql_lock();
         interrupt_request = cpu->interrupt_request;
@@ -786,7 +786,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             /* Mask out external interrupts for this step. */
             interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
         }
-        if (interrupt_request & CPU_INTERRUPT_DEBUG) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_DEBUG)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
             cpu->exception_index = EXCP_DEBUG;
             bql_unlock();
@@ -795,7 +795,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 #if !defined(CONFIG_USER_ONLY)
         if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
             /* Do nothing */
-        } else if (interrupt_request & CPU_INTERRUPT_HALT) {
+        } else if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HALT)) {
             replay_interrupt();
             cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
             cpu->halted = 1;
@@ -805,7 +805,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         } else {
             const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-            if (interrupt_request & CPU_INTERRUPT_RESET) {
+            if (cpu_test_interrupt(cpu, CPU_INTERRUPT_RESET)) {
                 replay_interrupt();
                 tcg_ops->cpu_exec_reset(cpu);
                 bql_unlock();
@@ -841,7 +841,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             interrupt_request = cpu->interrupt_request;
         }
 #endif /* !CONFIG_USER_ONLY */
-        if (interrupt_request & CPU_INTERRUPT_EXITTB) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_EXITTB)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
             /* ensure that no TB jump will be modified as
                the program flow was changed */
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index bf1787a69d..932cddac05 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -86,10 +86,10 @@ static bool alpha_cpu_has_work(CPUState *cs)
        assume that if a CPU really wants to stay asleep, it will mask
        interrupts at the chipset level, which will prevent these bits
        from being set in the first place.  */
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD
-                                    | CPU_INTERRUPT_TIMER
-                                    | CPU_INTERRUPT_SMP
-                                    | CPU_INTERRUPT_MCHK);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD
+                                  | CPU_INTERRUPT_TIMER
+                                  | CPU_INTERRUPT_SMP
+                                  | CPU_INTERRUPT_MCHK);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399..a29c3facbf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -142,11 +142,11 @@ static bool arm_cpu_has_work(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
 
     return (cpu->power_state != PSCI_OFF)
-        && cs->interrupt_request &
-        (CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
-         | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
-         | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
-         | CPU_INTERRUPT_EXITTB);
+        && cpu_test_interrupt(cs,
+               CPU_INTERRUPT_FIQ | CPU_INTERRUPT_HARD
+               | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
+               | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
+               | CPU_INTERRUPT_EXITTB);
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -958,7 +958,7 @@ void arm_cpu_update_virq(ARMCPU *cpu)
         !(arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VIRQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VIRQ) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VIRQ)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VIRQ);
         } else {
@@ -980,7 +980,7 @@ void arm_cpu_update_vfiq(ARMCPU *cpu)
         !(arm_hcrx_el2_eff(env) & HCRX_VFNMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VFIQ);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFIQ) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VFIQ)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VFIQ);
         } else {
@@ -1002,7 +1002,7 @@ void arm_cpu_update_vinmi(ARMCPU *cpu)
                       (arm_hcrx_el2_eff(env) & HCRX_VINMI)) ||
         (env->irq_line_state & CPU_INTERRUPT_VINMI);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VINMI) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VINMI)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VINMI);
         } else {
@@ -1022,7 +1022,7 @@ void arm_cpu_update_vfnmi(ARMCPU *cpu)
     bool new_state = (arm_hcr_el2_eff(env) & HCR_VF) &&
                       (arm_hcrx_el2_eff(env) & HCRX_VFNMI);
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VFNMI) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VFNMI)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VFNMI);
         } else {
@@ -1041,7 +1041,7 @@ void arm_cpu_update_vserr(ARMCPU *cpu)
 
     bool new_state = env->cp15.hcr_el2 & HCR_VSE;
 
-    if (new_state != ((cs->interrupt_request & CPU_INTERRUPT_VSERR) != 0)) {
+    if (new_state != cpu_test_interrupt(cs, CPU_INTERRUPT_VSERR)) {
         if (new_state) {
             cpu_interrupt(cs, CPU_INTERRUPT_VSERR);
         } else {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0c1299ff84..03988876e9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -833,40 +833,40 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t ret = 0;
 
     if (hcr_el2 & HCR_IMO) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VIRQ)) {
             ret |= CPSR_I;
         }
-        if (cs->interrupt_request & CPU_INTERRUPT_VINMI) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VINMI)) {
             ret |= ISR_IS;
             ret |= CPSR_I;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
             ret |= CPSR_I;
         }
 
-        if (cs->interrupt_request & CPU_INTERRUPT_NMI) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
             ret |= ISR_IS;
             ret |= CPSR_I;
         }
     }
 
     if (hcr_el2 & HCR_FMO) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VFIQ)) {
             ret |= CPSR_F;
         }
-        if (cs->interrupt_request & CPU_INTERRUPT_VFNMI) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VFNMI)) {
             ret |= ISR_FS;
             ret |= CPSR_F;
         }
     } else {
-        if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_FIQ)) {
             ret |= CPSR_F;
         }
     }
 
     if (hcr_el2 & HCR_AMO) {
-        if (cs->interrupt_request & CPU_INTERRUPT_VSERR) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_VSERR)) {
             ret |= CPSR_A;
         }
     }
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 47b0cd3a35..b77db99079 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1782,13 +1782,13 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
 
 static int hvf_inject_interrupts(CPUState *cpu)
 {
-    if (cpu->interrupt_request & CPU_INTERRUPT_FIQ) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_FIQ)) {
         trace_hvf_inject_fiq();
         hv_vcpu_set_pending_interrupt(cpu->accel->fd, HV_INTERRUPT_TYPE_FIQ,
                                       true);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         trace_hvf_inject_irq();
         hv_vcpu_set_pending_interrupt(cpu->accel->fd, HV_INTERRUPT_TYPE_IRQ,
                                       true);
@@ -1840,7 +1840,7 @@ static void hvf_wfi(CPUState *cpu)
     uint64_t nanos;
     uint32_t cntfrq;
 
-    if (cpu->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
         /* Interrupt pending, no need to wait */
         return;
     }
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 6995de6a12..a6df71d020 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -45,7 +45,7 @@ static vaddr avr_cpu_get_pc(CPUState *cs)
 
 static bool avr_cpu_has_work(CPUState *cs)
 {
-    return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET))
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET)
             && cpu_interrupts_enabled(cpu_env(cs));
 }
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 24777727e6..0ca79ee5e2 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -135,7 +135,7 @@ static void hppa_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool hppa_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 818b50419f..8445cadece 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -773,9 +773,9 @@ int hvf_vcpu_exec(CPUState *cpu)
         switch (exit_reason) {
         case EXIT_REASON_HLT: {
             macvm_set_rip(cpu, rip + ins_len);
-            if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+            if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
                 (env->eflags & IF_MASK))
-                && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
+                && !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI) &&
                 !(idtvec_info & VMCS_IDT_VEC_VALID)) {
                 cpu->halted = 1;
                 ret = EXCP_HLT;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 17fce1d3cd..9e05e0e576 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -395,7 +395,7 @@ bool hvf_inject_interrupts(CPUState *cs)
         };
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_NMI) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
             cs->interrupt_request &= ~CPU_INTERRUPT_NMI;
             info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | EXCP02_NMI;
@@ -406,7 +406,7 @@ bool hvf_inject_interrupts(CPUState *cs)
     }
 
     if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
-        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+        cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(env);
         cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
@@ -415,11 +415,10 @@ bool hvf_inject_interrupts(CPUState *cs)
                   VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
         }
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         vmx_set_int_window_exiting(cs);
     }
-    return (cs->interrupt_request
-            & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR));
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR);
 }
 
 int hvf_process_events(CPUState *cs)
@@ -432,25 +431,25 @@ int hvf_process_events(CPUState *cs)
         env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_INIT) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_INIT)) {
         cpu_synchronize_state(cs);
         do_cpu_init(cpu);
     }
 
-    if (cs->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_POLL)) {
         cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK)) ||
-        (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
         cs->halted = 0;
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_SIPI)) {
         cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_TPR)) {
         cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
         cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 92e3b8b2f4..c1ac74c4f0 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -413,11 +413,11 @@ nvmm_vcpu_pre_run(CPUState *cpu)
      * Force the VCPU out of its inner loop to process any INIT requests
      * or commit pending TPR access.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
         cpu->exit_request = 1;
     }
 
-    if (!has_event && (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+    if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         if (nvmm_can_take_nmi(cpu)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
             event->type = NVMM_VCPU_EVENT_INTR;
@@ -426,7 +426,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
         }
     }
 
-    if (!has_event && (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         if (nvmm_can_take_int(cpu)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
             event->type = NVMM_VCPU_EVENT_INTR;
@@ -436,7 +436,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Don't want SMIs. */
-    if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
     }
 
@@ -651,9 +651,9 @@ nvmm_handle_halted(struct nvmm_machine *mach, CPUState *cpu,
 
     bql_lock();
 
-    if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
           (cpu_env(cpu)->eflags & IF_MASK)) &&
-        !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu->halted = true;
         ret = 1;
@@ -691,25 +691,25 @@ nvmm_vcpu_loop(CPUState *cpu)
      * Some asynchronous events must be handled outside of the inner
      * VCPU loop. They are handled here.
      */
-    if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT)) {
         nvmm_cpu_synchronize_state(cpu);
         do_cpu_init(x86_cpu);
         /* set int/nmi windows back to the reset state */
     }
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(x86_cpu->apic_state);
     }
-    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->halted = false;
     }
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
         nvmm_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
-    if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
         nvmm_cpu_synchronize_state(cpu);
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index d4ea890c12..794a23ddfc 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -133,7 +133,7 @@ bool x86_cpu_exec_halt(CPUState *cpu)
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         bql_lock();
         apic_poll_irq(x86_cpu->apic_state);
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b72dcff3c8..878cdd1668 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1436,9 +1436,9 @@ static int whpx_handle_halt(CPUState *cpu)
     int ret = 0;
 
     bql_lock();
-    if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
           (cpu_env(cpu)->eflags & IF_MASK)) &&
-        !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->exception_index = EXCP_HLT;
         cpu->halted = true;
         ret = 1;
@@ -1469,15 +1469,15 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Inject NMI */
     if (!vcpu->interruption_pending &&
-        cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
-        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
+        cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
             vcpu->interruptable = false;
             new_int.InterruptionType = WHvX64PendingNmi;
             new_int.InterruptionPending = 1;
             new_int.InterruptionVector = 2;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
         }
     }
@@ -1486,12 +1486,12 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
      * Force the VCPU out of its inner loop to process any INIT requests or
      * commit pending TPR access.
      */
-    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
-        if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
             !(env->hflags & HF_SMM_MASK)) {
             cpu->exit_request = 1;
         }
-        if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+        if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
             cpu->exit_request = 1;
         }
     }
@@ -1501,7 +1501,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
         if (!vcpu->interruption_pending &&
             vcpu->interruptable && (env->eflags & IF_MASK)) {
             assert(!new_int.InterruptionPending);
-            if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+            if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
                 cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
                 irq = cpu_get_pic_interrupt(env);
                 if (irq >= 0) {
@@ -1519,7 +1519,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
             reg_count += 1;
         }
     } else if (vcpu->ready_for_pic_interrupt &&
-               (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+               cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
         irq = cpu_get_pic_interrupt(env);
         if (irq >= 0) {
@@ -1546,7 +1546,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
     /* Update the state of the interrupt delivery notification */
     if (!vcpu->window_registered &&
-        cpu->interrupt_request & CPU_INTERRUPT_HARD) {
+        cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         reg_values[reg_count].DeliverabilityNotifications =
             (WHV_X64_DELIVERABILITY_NOTIFICATIONS_REGISTER) {
                 .InterruptNotification = 1
@@ -1599,30 +1599,30 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     CPUX86State *env = &x86_cpu->env;
     AccelCPUState *vcpu = cpu->accel;
 
-    if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
         whpx_cpu_synchronize_state(cpu);
         do_cpu_init(x86_cpu);
         vcpu->interruptable = true;
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(x86_cpu->apic_state);
     }
 
-    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
         cpu->halted = false;
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
         whpx_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
         cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
         whpx_cpu_synchronize_state(cpu);
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index abad84c054..3a7621c0ea 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -376,7 +376,7 @@ static bool loongarch_cpu_has_work(CPUState *cs)
 {
     bool has_work = false;
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         cpu_loongarch_hw_interrupts_pending(cpu_env(cs))) {
         has_work = true;
     }
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 6a09db3a6f..f1b673119d 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -74,7 +74,7 @@ static void m68k_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool m68k_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index ee0a869a94..22231f09e6 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -129,7 +129,7 @@ static void mb_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool mb_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 1f6c41fd34..5989c3ba17 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -145,7 +145,7 @@ static bool mips_cpu_has_work(CPUState *cs)
      * check for interrupts that can be taken. For pre-release 6 CPUs,
      * check for CP0 Config7 'Wait IE ignore' bit.
      */
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         cpu_mips_hw_interrupts_pending(env)) {
         if (cpu_mips_hw_interrupts_enabled(env) ||
             (env->CP0_Config7 & (1 << CP0C7_WII)) ||
@@ -160,7 +160,7 @@ static bool mips_cpu_has_work(CPUState *cs)
          * The QEMU model will issue an _WAKE request whenever the CPUs
          * should be woken up.
          */
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_WAKE)) {
             has_work = true;
         }
 
@@ -170,7 +170,7 @@ static bool mips_cpu_has_work(CPUState *cs)
     }
     /* MIPS Release 6 has the ability to halt the CPU.  */
     if (env->CP0_Config5 & (1 << CP0C5_VP)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_WAKE)) {
             has_work = true;
         }
         if (!mips_vp_active(env)) {
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index ec53acb51a..450947c3fa 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -144,7 +144,7 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 
     bql_lock();
 
-    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
             cpu_mips_io_interrupts_pending(cpu)) {
         intr.cpu = -1;
         intr.irq = 2;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index dfbb2df643..9bbfe22ed3 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -78,8 +78,7 @@ static void openrisc_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD |
-                                    CPU_INTERRUPT_TIMER);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_TIMER);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a0e77f2673..db841f1260 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7225,7 +7225,7 @@ static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
 #ifndef CONFIG_USER_ONLY
 static bool ppc_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 015658049e..d145774b09 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1354,7 +1354,7 @@ static int kvmppc_handle_halt(PowerPCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (!cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
         FIELD_EX64(env->msr, MSR, EE)) {
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index c6dd5d6f83..da02ae7bf8 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -75,8 +75,7 @@ static void rx_restore_state_to_opc(CPUState *cs,
 
 static bool rx_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request &
-        (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
 
 static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 0640ab322b..ce003af421 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -44,7 +44,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
 void rx_cpu_do_interrupt(CPUState *cs)
 {
     CPURXState *env = cpu_env(cs);
-    int do_irq = cs->interrupt_request & INT_FLAGS;
+    int do_irq = cpu_test_interrupt(cs, INT_FLAGS);
     uint32_t save_psw;
 
     env->in_sleep = 0;
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 709ccd5299..f3a9ffb2a2 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -49,7 +49,7 @@ bool s390_cpu_has_work(CPUState *cs)
         return false;
     }
 
-    if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if (!cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         return false;
     }
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 4f561e8c91..21ccb86df4 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -108,7 +108,7 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
 
 static bool superh_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index fb7642bda1..1744ef0e6d 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -58,7 +58,7 @@ int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
 void superh_cpu_do_interrupt(CPUState *cs)
 {
     CPUSH4State *env = cpu_env(cs);
-    int do_irq = cs->interrupt_request & CPU_INTERRUPT_HARD;
+    int do_irq = cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
     int do_exp, irq_vector = cs->exception_index;
 
     /* prioritize exceptions over interrupts */
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 245caf2de0..c9773f1540 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -783,7 +783,7 @@ static void sparc_restore_state_to_opc(CPUState *cs,
 #ifndef CONFIG_USER_ONLY
 static bool sparc_cpu_has_work(CPUState *cs)
 {
-    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(cpu_env(cs));
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index bd14c7a0db..49e4e51c6d 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -89,7 +89,7 @@ void cpu_check_irqs(CPUSPARCState *env)
      * the next bit is (2 << psrpil).
      */
     if (pil < (2 << env->psrpil)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
             trace_sparc64_cpu_check_irqs_reset_irq(env->interrupt_index);
             env->interrupt_index = 0;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -120,7 +120,7 @@ void cpu_check_irqs(CPUSPARCState *env)
                 break;
             }
         }
-    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+    } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
         trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->softint,
                                               env->interrupt_index);
         env->interrupt_index = 0;
-- 
2.47.1



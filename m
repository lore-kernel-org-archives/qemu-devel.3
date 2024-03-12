Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A050C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1XZ-00081X-2M; Tue, 12 Mar 2024 08:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VG-0004Xx-IU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1V6-0000Xb-P1
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tag4W2j1bocwj19HspBSk4KT111YUXnCwEQUEp1LouI=;
 b=Zd4nITfp5Up6plcySVQQfx4wNhxSHp0qlZmA2gj1GNagnk+BpvIf7noBYt3WD3lJ1y5Y2m
 l2GUEkEL6CBPvPuT3oMKXj/zdC+CFaveypAfhGcX5LJym/UNH79W37XsGg2PzSB4wWc0Bg
 jo+EH1QwKgf+qTMBQ26mZs76hRsH948=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-v-PeDbHkMbiTPOhmLMoVug-1; Tue, 12 Mar 2024 08:44:53 -0400
X-MC-Unique: v-PeDbHkMbiTPOhmLMoVug-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80D1E101D223;
 Tue, 12 Mar 2024 12:44:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A38A492BC4;
 Tue, 12 Mar 2024 12:44:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 37/55] target: Replace CPU_GET_CLASS(cpu -> obj) in
 cpu_reset_hold() handler
Date: Tue, 12 Mar 2024 13:43:21 +0100
Message-ID: <20240312124339.761630-38-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since CPU() macro is a simple cast, the following are equivalent:

  Object *obj;
  CPUState *cs = CPU(obj)

In order to ease static analysis when running
scripts/coccinelle/cpu_env.cocci from the previous commit,
replace:

 - CPU_GET_CLASS(cpu);
 + CPU_GET_CLASS(obj);

Most code use the 'cs' variable name for CPUState handle.
Replace few 's' -> 'cs' to unify cpu_reset_hold() style.

No logical change in this patch.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240129164514.73104-7-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/arm/cpu.c        | 14 +++++++-------
 target/avr/cpu.c        |  2 +-
 target/cris/cpu.c       |  2 +-
 target/hexagon/cpu.c    |  2 +-
 target/i386/cpu.c       | 14 +++++++-------
 target/loongarch/cpu.c  |  2 +-
 target/m68k/cpu.c       |  6 +++---
 target/microblaze/cpu.c |  6 +++---
 target/mips/cpu.c       |  2 +-
 target/nios2/cpu.c      |  2 +-
 target/openrisc/cpu.c   |  8 ++++----
 target/ppc/cpu_init.c   | 12 ++++++------
 target/riscv/cpu.c      |  2 +-
 target/rx/cpu.c         |  2 +-
 target/sh4/cpu.c        |  6 +++---
 target/sparc/cpu.c      |  6 +++---
 target/tricore/cpu.c    |  6 +++---
 target/xtensa/cpu.c     |  8 ++++----
 18 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 02fc0adb65..ab8d007a86 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -214,9 +214,9 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
 
 static void arm_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    ARMCPU *cpu = ARM_CPU(s);
-    ARMCPUClass *acc = ARM_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    ARMCPU *cpu = ARM_CPU(cs);
+    ARMCPUClass *acc = ARM_CPU_GET_CLASS(obj);
     CPUARMState *env = &cpu->env;
 
     if (acc->parent_phases.hold) {
@@ -233,7 +233,7 @@ static void arm_cpu_reset_hold(Object *obj)
     env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
-    cpu->power_state = s->start_powered_off ? PSCI_OFF : PSCI_ON;
+    cpu->power_state = cs->start_powered_off ? PSCI_OFF : PSCI_ON;
 
     if (arm_feature(env, ARM_FEATURE_IWMMXT)) {
         env->iwmmxt.cregs[ARM_IWMMXT_wCID] = 0x69051000 | 'Q';
@@ -438,7 +438,7 @@ static void arm_cpu_reset_hold(Object *obj)
 
         /* Load the initial SP and PC from offset 0 and 4 in the vector table */
         vecbase = env->v7m.vecbase[env->v7m.secure];
-        rom = rom_ptr_for_as(s->as, vecbase, 8);
+        rom = rom_ptr_for_as(cs->as, vecbase, 8);
         if (rom) {
             /* Address zero is covered by ROM which hasn't yet been
              * copied into physical memory.
@@ -451,8 +451,8 @@ static void arm_cpu_reset_hold(Object *obj)
              * it got copied into memory. In the latter case, rom_ptr
              * will return a NULL pointer and we should use ldl_phys instead.
              */
-            initial_msp = ldl_phys(s->as, vecbase);
-            initial_pc = ldl_phys(s->as, vecbase + 4);
+            initial_msp = ldl_phys(cs->as, vecbase);
+            initial_pc = ldl_phys(cs->as, vecbase + 4);
         }
 
         qemu_log_mask(CPU_LOG_INT,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a50170bc69..950f6cccf0 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -79,7 +79,7 @@ static void avr_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
     AVRCPU *cpu = AVR_CPU(cs);
-    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(cpu);
+    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(obj);
     CPUAVRState *env = &cpu->env;
 
     if (mcc->parent_phases.hold) {
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 163fb05d58..ab2f169f21 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -65,7 +65,7 @@ static void cris_cpu_reset_hold(Object *obj)
 {
     CPUState *s = CPU(obj);
     CRISCPU *cpu = CRIS_CPU(s);
-    CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(cpu);
+    CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
     CPUCRISState *env = &cpu->env;
     uint32_t vr;
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index a10d87b822..d41c6452a2 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -289,7 +289,7 @@ static void hexagon_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
     HexagonCPU *cpu = HEXAGON_CPU(cs);
-    HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(cpu);
+    HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(obj);
     CPUHexagonState *env = &cpu->env;
 
     if (mcc->parent_phases.hold) {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2666ef3808..9a210d8d92 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6695,9 +6695,9 @@ static void x86_cpu_set_sgxlepubkeyhash(CPUX86State *env)
 
 static void x86_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    X86CPU *cpu = X86_CPU(s);
-    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    X86CPU *cpu = X86_CPU(cs);
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
     CPUX86State *env = &cpu->env;
     target_ulong cr4;
     uint64_t xcr0;
@@ -6785,8 +6785,8 @@ static void x86_cpu_reset_hold(Object *obj)
     memset(env->dr, 0, sizeof(env->dr));
     env->dr[6] = DR6_FIXED_1;
     env->dr[7] = DR7_FIXED_1;
-    cpu_breakpoint_remove_all(s, BP_CPU);
-    cpu_watchpoint_remove_all(s, BP_CPU);
+    cpu_breakpoint_remove_all(cs, BP_CPU);
+    cpu_watchpoint_remove_all(cs, BP_CPU);
 
     cr4 = 0;
     xcr0 = XSTATE_FP_MASK;
@@ -6837,9 +6837,9 @@ static void x86_cpu_reset_hold(Object *obj)
     env->triple_fault_pending = false;
 #if !defined(CONFIG_USER_ONLY)
     /* We hard-wire the BSP to the first CPU. */
-    apic_designate_bsp(cpu->apic_state, s->cpu_index == 0);
+    apic_designate_bsp(cpu->apic_state, cs->cpu_index == 0);
 
-    s->halted = !cpu_is_bsp(cpu);
+    cs->halted = !cpu_is_bsp(cpu);
 
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(cpu);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index bc2684179f..e935c79b68 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -510,7 +510,7 @@ static void loongarch_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(cpu);
+    LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
     CPULoongArchState *env = &cpu->env;
 
     if (lacc->parent_phases.hold) {
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index cc6e4537be..9cc1de567f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -73,9 +73,9 @@ static void m68k_unset_feature(CPUM68KState *env, int feature)
 
 static void m68k_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    M68kCPU *cpu = M68K_CPU(s);
-    M68kCPUClass *mcc = M68K_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    M68kCPU *cpu = M68K_CPU(cs);
+    M68kCPUClass *mcc = M68K_CPU_GET_CLASS(obj);
     CPUM68KState *env = &cpu->env;
     floatx80 nan = floatx80_default_nan(NULL);
     int i;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index e533e7a95e..96c2b71f7f 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -183,9 +183,9 @@ static void microblaze_cpu_set_irq(void *opaque, int irq, int level)
 
 static void mb_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(s);
-    MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_GET_CLASS(obj);
     CPUMBState *env = &cpu->env;
 
     if (mcc->parent_phases.hold) {
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d644adbc77..98ef073631 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -193,7 +193,7 @@ static void mips_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
     MIPSCPU *cpu = MIPS_CPU(cs);
-    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(cpu);
+    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(obj);
     CPUMIPSState *env = &cpu->env;
 
     if (mcc->parent_phases.hold) {
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 0760bf6b38..b10693618b 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -67,7 +67,7 @@ static void nios2_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
     Nios2CPU *cpu = NIOS2_CPU(cs);
-    Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(cpu);
+    Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(obj);
     CPUNios2State *env = &cpu->env;
 
     if (ncc->parent_phases.hold) {
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index a3cb80ca34..33c45dbf04 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -87,9 +87,9 @@ static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
 
 static void openrisc_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    OpenRISCCPU *cpu = OPENRISC_CPU(s);
-    OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
+    OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(obj);
 
     if (occ->parent_phases.hold) {
         occ->parent_phases.hold(obj);
@@ -100,7 +100,7 @@ static void openrisc_cpu_reset_hold(Object *obj)
     cpu->env.pc = 0x100;
     cpu->env.sr = SR_FO | SR_SM;
     cpu->env.lock_addr = -1;
-    s->exception_index = -1;
+    cs->exception_index = -1;
     cpu_set_fpcsr(&cpu->env, 0);
 
     set_float_detect_tininess(float_tininess_before_rounding,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1d3d1db7c3..6d9c5a6c9a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7108,9 +7108,9 @@ static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
 
 static void ppc_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    PowerPCCPU *cpu = POWERPC_CPU(s);
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(obj);
     CPUPPCState *env = &cpu->env;
     target_ulong msr;
     int i;
@@ -7159,8 +7159,8 @@ static void ppc_cpu_reset_hold(Object *obj)
     env->nip = env->hreset_vector | env->excp_prefix;
 
     if (tcg_enabled()) {
-        cpu_breakpoint_remove_all(s, BP_CPU);
-        cpu_watchpoint_remove_all(s, BP_CPU);
+        cpu_breakpoint_remove_all(cs, BP_CPU);
+        cpu_watchpoint_remove_all(cs, BP_CPU);
         if (env->mmu_model != POWERPC_MMU_REAL) {
             ppc_tlb_invalidate_all(env);
         }
@@ -7174,7 +7174,7 @@ static void ppc_cpu_reset_hold(Object *obj)
     env->reserve_addr = (target_ulong)-1ULL;
     /* Be sure no exception or interrupt is pending */
     env->pending_interrupts = 0;
-    s->exception_index = POWERPC_EXCP_NONE;
+    cs->exception_index = POWERPC_EXCP_NONE;
     env->error_code = 0;
     ppc_irq_reset(cpu);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a48d30828..c160b9216b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -926,7 +926,7 @@ static void riscv_cpu_reset_hold(Object *obj)
 #endif
     CPUState *cs = CPU(obj);
     RISCVCPU *cpu = RISCV_CPU(cs);
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
     CPURISCVState *env = &cpu->env;
 
     if (mcc->parent_phases.hold) {
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 2f878d08d6..26ff822e71 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -72,7 +72,7 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
 static void rx_cpu_reset_hold(Object *obj)
 {
     RXCPU *cpu = RX_CPU(obj);
-    RXCPUClass *rcc = RX_CPU_GET_CLASS(cpu);
+    RXCPUClass *rcc = RX_CPU_GET_CLASS(obj);
     CPURXState *env = &cpu->env;
     uint32_t *resetvec;
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 2031168dc6..eb7c551e9b 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -106,9 +106,9 @@ static int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
 
 static void superh_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    SuperHCPU *cpu = SUPERH_CPU(s);
-    SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    SuperHCPU *cpu = SUPERH_CPU(cs);
+    SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(obj);
     CPUSH4State *env = &cpu->env;
 
     if (scc->parent_phases.hold) {
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 313ebc4c11..ce6aab6bcb 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -31,9 +31,9 @@
 
 static void sparc_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    SPARCCPU *cpu = SPARC_CPU(s);
-    SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    SPARCCPU *cpu = SPARC_CPU(cs);
+    SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(obj);
     CPUSPARCState *env = &cpu->env;
 
     if (scc->parent_phases.hold) {
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 74e8a22b86..682fc290ac 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -72,9 +72,9 @@ static void tricore_restore_state_to_opc(CPUState *cs,
 
 static void tricore_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    TriCoreCPU *cpu = TRICORE_CPU(s);
-    TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    TriCoreCPU *cpu = TRICORE_CPU(cs);
+    TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(obj);
     CPUTriCoreState *env = &cpu->env;
 
     if (tcc->parent_phases.hold) {
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 79f91819df..c1cedf3f35 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -95,9 +95,9 @@ bool xtensa_abi_call0(void)
 
 static void xtensa_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    XtensaCPU *cpu = XTENSA_CPU(s);
-    XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(cpu);
+    CPUState *cs = CPU(obj);
+    XtensaCPU *cpu = XTENSA_CPU(cs);
+    XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
     CPUXtensaState *env = &cpu->env;
     bool dfpu = xtensa_option_enabled(env->config,
                                       XTENSA_OPTION_DFP_COPROCESSOR);
@@ -132,7 +132,7 @@ static void xtensa_cpu_reset_hold(Object *obj)
 
 #ifndef CONFIG_USER_ONLY
     reset_mmu(env);
-    s->halted = env->runstall;
+    cs->halted = env->runstall;
 #endif
     set_no_signaling_nans(!dfpu, &env->fp_status);
     set_use_first_nan(!dfpu, &env->fp_status);
-- 
2.44.0



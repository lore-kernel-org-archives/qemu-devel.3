Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31E7C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1VV-0005It-6L; Tue, 12 Mar 2024 08:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VK-0004el-Nt
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VI-0000bV-2U
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j7I6jHo21DMFd87Ral8MDWR+mZHxqH8tAK1NYyYQ85A=;
 b=XytPF/S9bpqk34iPCUqZmv+4N2K6rKBppEdaouvlXTCah6TmWVL5C9pLaiL0TC39987XGo
 9/WV81aZtYpFCfCMEhr+PmaSN9zTdJpw6edZKZe1EL0u9WMNhsELPKVupcp/Zo3WFxwy12
 dQWjs8Fwnq8Nz94fU9GLvmv3PnLc+m0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-BD6cYzmENxG3Rjo-qN3oPQ-1; Tue,
 12 Mar 2024 08:45:07 -0400
X-MC-Unique: BD6cYzmENxG3Rjo-qN3oPQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF02D3C0F187;
 Tue, 12 Mar 2024 12:45:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E733A492BC4;
 Tue, 12 Mar 2024 12:45:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 46/55] target/mips: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Date: Tue, 12 Mar 2024 13:43:30 +0100
Message-ID: <20240312124339.761630-47-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240129164514.73104-19-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/mips/cpu.c                       | 15 ++++----------
 target/mips/gdbstub.c                   |  6 ++----
 target/mips/kvm.c                       | 27 +++++++++----------------
 target/mips/sysemu/physaddr.c           |  3 +--
 target/mips/tcg/exception.c             |  3 +--
 target/mips/tcg/op_helper.c             |  8 +++-----
 target/mips/tcg/sysemu/special_helper.c |  3 +--
 target/mips/tcg/sysemu/tlb_helper.c     |  6 ++----
 target/mips/tcg/translate.c             |  3 +--
 9 files changed, 24 insertions(+), 50 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 98ef073631..8d8f690a53 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -80,8 +80,7 @@ static void fpu_dump_state(CPUMIPSState *env, FILE *f, int flags)
 
 static void mips_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "pc=0x" TARGET_FMT_lx " HI=0x" TARGET_FMT_lx
@@ -123,9 +122,7 @@ void cpu_set_exception_base(int vp_index, target_ulong address)
 
 static void mips_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-
-    mips_env_set_pc(&cpu->env, value);
+    mips_env_set_pc(cpu_env(cs), value);
 }
 
 static vaddr mips_cpu_get_pc(CPUState *cs)
@@ -137,8 +134,7 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
 
 static bool mips_cpu_has_work(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     bool has_work = false;
 
     /*
@@ -433,10 +429,7 @@ static void mips_cpu_reset_hold(Object *obj)
 
 static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
-    MIPSCPU *cpu = MIPS_CPU(s);
-    CPUMIPSState *env = &cpu->env;
-
-    if (!(env->insn_flags & ISA_NANOMIPS32)) {
+    if (!(cpu_env(s)->insn_flags & ISA_NANOMIPS32)) {
 #if TARGET_BIG_ENDIAN
         info->print_insn = print_insn_big_mips;
 #else
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 62d7b72407..169d47416a 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -25,8 +25,7 @@
 
 int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
 
     if (n < 32) {
         return gdb_get_regl(mem_buf, env->active_tc.gpr[n]);
@@ -78,8 +77,7 @@ int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     target_ulong tmp;
 
     tmp = ldtul_p(mem_buf);
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 15d0cf9adb..6c52e59f55 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -63,8 +63,7 @@ int kvm_arch_irqchip_create(KVMState *s)
 
 int kvm_arch_init_vcpu(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int ret = 0;
 
     qemu_add_vm_change_state_handler(kvm_mips_update_state, cs);
@@ -460,8 +459,7 @@ static inline int kvm_mips_change_one_reg(CPUState *cs, uint64_t reg_id,
  */
 static int kvm_mips_save_count(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     uint64_t count_ctl;
     int err, ret = 0;
 
@@ -502,8 +500,7 @@ static int kvm_mips_save_count(CPUState *cs)
  */
 static int kvm_mips_restore_count(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     uint64_t count_ctl;
     int err_dc, err, ret = 0;
 
@@ -590,8 +587,7 @@ static void kvm_mips_update_state(void *opaque, bool running, RunState state)
 
 static int kvm_mips_put_fpu_registers(CPUState *cs, int level)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
     unsigned int i;
 
@@ -670,8 +666,7 @@ static int kvm_mips_put_fpu_registers(CPUState *cs, int level)
 
 static int kvm_mips_get_fpu_registers(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
     unsigned int i;
 
@@ -751,8 +746,7 @@ static int kvm_mips_get_fpu_registers(CPUState *cs)
 
 static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
 
     (void)level;
@@ -974,8 +968,7 @@ static int kvm_mips_put_cp0_registers(CPUState *cs, int level)
 
 static int kvm_mips_get_cp0_registers(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int err, ret = 0;
 
     err = kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_INDEX, &env->CP0_Index);
@@ -1181,8 +1174,7 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
 
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     struct kvm_regs regs;
     int ret;
     int i;
@@ -1217,8 +1209,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
 
 int kvm_arch_get_registers(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int ret = 0;
     struct kvm_regs regs;
     int i;
diff --git a/target/mips/sysemu/physaddr.c b/target/mips/sysemu/physaddr.c
index 13c8bc8f47..5c5184e136 100644
--- a/target/mips/sysemu/physaddr.c
+++ b/target/mips/sysemu/physaddr.c
@@ -230,8 +230,7 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
 
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     hwaddr phys_addr;
     int prot;
 
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index da49a93912..13275d1ded 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -79,8 +79,7 @@ void helper_wait(CPUMIPSState *env)
 
 void mips_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
 
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
     env->active_tc.PC = tb->pc;
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 98935b5e64..65403f1a87 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -279,8 +279,7 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                   MMUAccessType access_type,
                                   int mmu_idx, uintptr_t retaddr)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     int error_code = 0;
     int excp;
 
@@ -306,9 +305,8 @@ void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                     int mmu_idx, MemTxAttrs attrs,
                                     MemTxResult response, uintptr_t retaddr)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(cpu);
-    CPUMIPSState *env = &cpu->env;
+    MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(cs);
+    CPUMIPSState *env = cpu_env(cs);
 
     if (access_type == MMU_INST_FETCH) {
         do_raise_exception(env, EXCP_IBE, retaddr);
diff --git a/target/mips/tcg/sysemu/special_helper.c b/target/mips/tcg/sysemu/special_helper.c
index 518d3fbc34..5baa25348e 100644
--- a/target/mips/tcg/sysemu/special_helper.c
+++ b/target/mips/tcg/sysemu/special_helper.c
@@ -90,8 +90,7 @@ static void debug_post_eret(CPUMIPSState *env)
 
 bool mips_io_recompile_replay_branch(CPUState *cs, const TranslationBlock *tb)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
 
     if ((env->hflags & MIPS_HFLAG_BMASK) != 0
         && !(cs->tcg_cflags & CF_PCREL) && env->active_tc.PC != tb->pc) {
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index cdae42ffdd..119eae771e 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -906,8 +906,7 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
     int ret = TLBRET_BADADDR;
@@ -1340,8 +1339,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
 bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        MIPSCPU *cpu = MIPS_CPU(cs);
-        CPUMIPSState *env = &cpu->env;
+        CPUMIPSState *env = cpu_env(cs);
 
         if (cpu_mips_hw_interrupts_enabled(env) &&
             cpu_mips_hw_interrupts_pending(env)) {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 3ba2101647..06c108cc9c 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15566,8 +15566,7 @@ void mips_restore_state_to_opc(CPUState *cs,
                                const TranslationBlock *tb,
                                const uint64_t *data)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
 
     env->active_tc.PC = data[0];
     env->hflags &= ~MIPS_HFLAG_BMASK;
-- 
2.44.0



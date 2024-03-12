Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244ADC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Xh-00005K-0T; Tue, 12 Mar 2024 08:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VI-0004bo-IK
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VB-0000ag-9R
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03aM9ZkSlQzTFx1pPNJmZ+WHNGA5kWbpYfHnIYTnn7w=;
 b=bggdwVil89ZqR6lgLAfwqyQm4BTRy17kVDnOP02kHBnO3kLzTCCmtKuYWRs4xtxnXAi5Rk
 KcntYir3cREAkOPDTZnshVHiBamZCVxnF+PUsnYZz3DFUSLlD0xB+7XMFqBQV8dgFyFPZ4
 7LpwGR+h+TpYl25snHKGlyAnqIynWmc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-HGlgJFTGP1Cvx2s0O71RCw-1; Tue,
 12 Mar 2024 08:45:03 -0400
X-MC-Unique: HGlgJFTGP1Cvx2s0O71RCw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEA36386A0A9;
 Tue, 12 Mar 2024 12:45:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B681F492BC4;
 Tue, 12 Mar 2024 12:45:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 43/55] target/loongarch: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Tue, 12 Mar 2024 13:43:27 +0100
Message-ID: <20240312124339.761630-44-thuth@redhat.com>
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
Message-ID: <20240129164514.73104-16-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[thuth: Adjusted patch for hunk that moved to cpu_helper.c]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/loongarch/cpu.c            | 39 ++++++++---------------------
 target/loongarch/cpu_helper.c     |  3 +--
 target/loongarch/gdbstub.c        |  6 ++---
 target/loongarch/kvm/kvm.c        | 41 +++++++++----------------------
 target/loongarch/tcg/tlb_helper.c |  3 +--
 5 files changed, 26 insertions(+), 66 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e935c79b68..f6ffb3aadb 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -91,18 +91,12 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
 
 static void loongarch_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
-
-    set_pc(env, value);
+    set_pc(cpu_env(cs), value);
 }
 
 static vaddr loongarch_cpu_get_pc(CPUState *cs)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
-
-    return env->pc;
+    return cpu_env(cs)->pc;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -157,8 +151,7 @@ static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 #ifndef CONFIG_USER_ONLY
 static void loongarch_cpu_do_interrupt(CPUState *cs)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
     bool update_badinstr = 1;
     int cause = -1;
     const char *name;
@@ -308,8 +301,7 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                                 MemTxResult response,
                                                 uintptr_t retaddr)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     if (access_type == MMU_INST_FETCH) {
         do_raise_exception(env, EXCCODE_ADEF, retaddr);
@@ -321,8 +313,7 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-        CPULoongArchState *env = &cpu->env;
+        CPULoongArchState *env = cpu_env(cs);
 
         if (cpu_loongarch_hw_interrupts_enabled(env) &&
             cpu_loongarch_hw_interrupts_pending(env)) {
@@ -339,21 +330,15 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
                                               const TranslationBlock *tb)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
-
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
-    set_pc(env, tb->pc);
+    set_pc(cpu_env(cs), tb->pc);
 }
 
 static void loongarch_restore_state_to_opc(CPUState *cs,
                                            const TranslationBlock *tb,
                                            const uint64_t *data)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
-
-    set_pc(env, data[0]);
+    set_pc(cpu_env(cs), data[0]);
 }
 #endif /* CONFIG_TCG */
 
@@ -362,12 +347,10 @@ static bool loongarch_cpu_has_work(CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     return true;
 #else
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
     bool has_work = false;
 
     if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-        cpu_loongarch_hw_interrupts_pending(env)) {
+        cpu_loongarch_hw_interrupts_pending(cpu_env(cs))) {
         has_work = true;
     }
 
@@ -509,9 +492,8 @@ static void loongarch_max_initfn(Object *obj)
 static void loongarch_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     if (lacc->parent_phases.hold) {
         lacc->parent_phases.hold(obj);
@@ -694,8 +676,7 @@ static ObjectClass *loongarch_cpu_class_by_name(const char *cpu_model)
 
 void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 45f821d086..960eec9567 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -218,8 +218,7 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
 
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
     hwaddr phys_addr;
     int prot;
 
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 22c6889011..a0e1439bd0 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -33,8 +33,7 @@ void write_fcc(CPULoongArchState *env, uint64_t val)
 
 int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
     uint64_t val;
 
     if (0 <= n && n < 32) {
@@ -60,8 +59,7 @@ int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
     target_ulong tmp;
     int read_length;
     int length = 0;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index c19978a970..df5e199860 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -38,8 +38,7 @@ static int kvm_loongarch_get_regs_core(CPUState *cs)
     int ret = 0;
     int i;
     struct kvm_regs regs;
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     /* Get the current register set as KVM seems it */
     ret = kvm_vcpu_ioctl(cs, KVM_GET_REGS, &regs);
@@ -62,8 +61,7 @@ static int kvm_loongarch_put_regs_core(CPUState *cs)
     int ret = 0;
     int i;
     struct kvm_regs regs;
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     /* Set the registers based on QEMU's view of things */
     for (i = 0; i < 32; i++) {
@@ -82,8 +80,7 @@ static int kvm_loongarch_put_regs_core(CPUState *cs)
 static int kvm_loongarch_get_csr(CPUState *cs)
 {
     int ret = 0;
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CRMD),
                            &env->CSR_CRMD);
@@ -253,8 +250,7 @@ static int kvm_loongarch_get_csr(CPUState *cs)
 static int kvm_loongarch_put_csr(CPUState *cs, int level)
 {
     int ret = 0;
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CRMD),
                            &env->CSR_CRMD);
@@ -430,9 +426,7 @@ static int kvm_loongarch_get_regs_fp(CPUState *cs)
 {
     int ret, i;
     struct kvm_fpu fpu;
-
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     ret = kvm_vcpu_ioctl(cs, KVM_GET_FPU, &fpu);
     if (ret < 0) {
@@ -456,9 +450,7 @@ static int kvm_loongarch_put_regs_fp(CPUState *cs)
 {
     int ret, i;
     struct kvm_fpu fpu;
-
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     fpu.fcsr = env->fcsr0;
     fpu.fcc = 0;
@@ -487,8 +479,7 @@ static int kvm_loongarch_get_mpstate(CPUState *cs)
 {
     int ret = 0;
     struct kvm_mp_state mp_state;
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     if (cap_has_mp_state) {
         ret = kvm_vcpu_ioctl(cs, KVM_GET_MP_STATE, &mp_state);
@@ -505,12 +496,8 @@ static int kvm_loongarch_get_mpstate(CPUState *cs)
 static int kvm_loongarch_put_mpstate(CPUState *cs)
 {
     int ret = 0;
-
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
-
     struct kvm_mp_state mp_state = {
-        .mp_state = env->mp_state
+        .mp_state = cpu_env(cs)->mp_state
     };
 
     if (cap_has_mp_state) {
@@ -527,8 +514,7 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
 {
     int i, ret = 0;
     uint64_t val;
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     for (i = 0; i < 21; i++) {
         ret = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
@@ -549,8 +535,7 @@ static int kvm_check_cpucfg2(CPUState *cs)
         .attr = 2,
         .addr = (uint64_t)&val,
     };
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
 
     ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
 
@@ -575,8 +560,7 @@ static int kvm_check_cpucfg2(CPUState *cs)
 static int kvm_loongarch_put_cpucfg(CPUState *cs)
 {
     int i, ret = 0;
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
     uint64_t val;
 
     for (i = 0; i < 21; i++) {
@@ -758,8 +742,7 @@ bool kvm_arch_cpu_check_are_resettable(void)
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
     MemTxAttrs attrs = {};
 
     attrs.requester_id = env_cpu(env)->cpu_index;
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a08c08b05a..22be031ac7 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -449,8 +449,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                             MMUAccessType access_type, int mmu_idx,
                             bool probe, uintptr_t retaddr)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
-    CPULoongArchState *env = &cpu->env;
+    CPULoongArchState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
     int ret;
-- 
2.44.0



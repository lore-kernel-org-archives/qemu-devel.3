Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CF7C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1Y5-0000yg-OY; Tue, 12 Mar 2024 08:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VQ-00051B-Im
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VO-0000eu-Dl
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlTemT5AJCiw9sCMWBos6k90WSpsfIrujLVatOF4rkU=;
 b=bi5YcP9ThFq2Wk4gzmeStI1UtA3776h0oqnckgcRBWCMRrpnvwfSF9AdYvf7kzaPxpyZ5g
 2kr2fUN84JthvRh7bh07KU4qQVEcPZaoDBzPBvj96aE26/IW1JloURlcQSLkGWmeUFscJC
 lViD0sptN+78GjHrvYoSvo5COqjPJ6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-wU68TWe1MGGO0uKscs37Iw-1; Tue, 12 Mar 2024 08:45:16 -0400
X-MC-Unique: wU68TWe1MGGO0uKscs37Iw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3274800267;
 Tue, 12 Mar 2024 12:45:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F8B6492BD0;
 Tue, 12 Mar 2024 12:45:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 52/55] target/sparc: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Date: Tue, 12 Mar 2024 13:43:36 +0100
Message-ID: <20240312124339.761630-53-thuth@redhat.com>
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240129164514.73104-27-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/sparc/cpu.c          | 17 +++++------------
 target/sparc/gdbstub.c      |  3 +--
 target/sparc/int32_helper.c |  3 +--
 target/sparc/int64_helper.c |  3 +--
 target/sparc/ldst_helper.c  |  6 ++----
 target/sparc/mmu_helper.c   | 15 +++++----------
 target/sparc/translate.c    |  9 +++------
 7 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ce6aab6bcb..dc9ead21fc 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -32,9 +32,8 @@
 static void sparc_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    SPARCCPU *cpu = SPARC_CPU(cs);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(obj);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
     if (scc->parent_phases.hold) {
         scc->parent_phases.hold(obj);
@@ -83,8 +82,7 @@ static void sparc_cpu_reset_hold(Object *obj)
 static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        SPARCCPU *cpu = SPARC_CPU(cs);
-        CPUSPARCState *env = &cpu->env;
+        CPUSPARCState *env = cpu_env(cs);
 
         if (cpu_interrupts_enabled(env) && env->interrupt_index > 0) {
             int pil = env->interrupt_index & 0xf;
@@ -613,8 +611,7 @@ static void cpu_print_cc(FILE *f, uint32_t cc)
 
 static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int i, x;
 
     qemu_fprintf(f, "pc: " TARGET_FMT_lx "  npc: " TARGET_FMT_lx "\n", env->pc,
@@ -711,11 +708,8 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
 
 static bool sparc_cpu_has_work(CPUState *cs)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
-
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-           cpu_interrupts_enabled(env);
+           cpu_interrupts_enabled(cpu_env(cs));
 }
 
 static int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
@@ -777,8 +771,7 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUState *cs = CPU(dev);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
-    SPARCCPU *cpu = SPARC_CPU(dev);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
 #if defined(CONFIG_USER_ONLY)
     /* We are emulating the kernel, which will trap and emulate float128. */
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index d1586b2392..07ea81ab5f 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -29,8 +29,7 @@
 
 int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
     if (n < 8) {
         /* g0..g7 */
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 058dd712b5..6b7d65b031 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -99,8 +99,7 @@ void cpu_check_irqs(CPUSPARCState *env)
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int cwp, intno = cs->exception_index;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 27df9dba89..bd14c7a0db 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -130,8 +130,7 @@ void cpu_check_irqs(CPUSPARCState *env)
 
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int intno = cs->exception_index;
     trap_state *tsptr;
 
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 1ecd58e8ff..e581bb42ac 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -418,8 +418,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
                                   bool is_write, bool is_exec, int is_asi,
                                   unsigned size, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int fault_type;
 
 #ifdef DEBUG_UNASSIGNED
@@ -480,8 +479,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
                                   bool is_write, bool is_exec, int is_asi,
                                   unsigned size, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
 #ifdef DEBUG_UNASSIGNED
     printf("Unassigned mem access to " HWADDR_FMT_plx " from " TARGET_FMT_lx
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index e7b1997d54..ad1591d9fd 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -206,8 +206,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     CPUTLBEntryFull full = {};
     target_ulong vaddr;
     int error_code = 0, access_index;
@@ -391,8 +390,7 @@ void dump_mmu(CPUSPARCState *env)
 int sparc_cpu_memory_rw_debug(CPUState *cs, vaddr address,
                               uint8_t *buf, int len, bool is_write)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     target_ulong addr = address;
     int i;
     int len1;
@@ -759,8 +757,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     CPUTLBEntryFull full = {};
     int error_code = 0, access_index;
 
@@ -898,8 +895,7 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 
 hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     hwaddr phys_addr;
     int mmu_idx = cpu_mmu_index(cs, false);
 
@@ -916,8 +912,7 @@ G_NORETURN void sparc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                               int mmu_idx,
                                               uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
 #ifdef TARGET_SPARC64
     env->dmmu.sfsr = build_sfsr(env, mmu_idx, access_type);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 692ce0b010..319934d9bd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4844,13 +4844,12 @@ TRANS(FCMPEq, ALL, do_fcmpq, a, true)
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUSPARCState *env = cpu_env(cs);
     int bound;
 
     dc->pc = dc->base.pc_first;
     dc->npc = (target_ulong)dc->base.tb->cs_base;
     dc->mem_idx = dc->base.tb->flags & TB_FLAG_MMU_MASK;
-    dc->def = &env->def;
+    dc->def = &cpu_env(cs)->def;
     dc->fpu_enabled = tb_fpu_enabled(dc->base.tb->flags);
     dc->address_mask_32bit = tb_am_enabled(dc->base.tb->flags);
 #ifndef CONFIG_USER_ONLY
@@ -4900,10 +4899,9 @@ static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUSPARCState *env = cpu_env(cs);
     unsigned int insn;
 
-    insn = translator_ldl(env, &dc->base, dc->pc);
+    insn = translator_ldl(cpu_env(cs), &dc->base, dc->pc);
     dc->base.pc_next += 4;
 
     if (!decode(dc, insn)) {
@@ -5106,8 +5104,7 @@ void sparc_restore_state_to_opc(CPUState *cs,
                                 const TranslationBlock *tb,
                                 const uint64_t *data)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     target_ulong pc = data[0];
     target_ulong npc = data[1];
 
-- 
2.44.0



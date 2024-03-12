Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02818C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1YF-0001BC-Sf; Tue, 12 Mar 2024 08:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VV-0005I5-38
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VT-0000s3-0Z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDNGuJuE3CMD4uIYpxofUQytc2L1YnHyiLboUK11HuU=;
 b=bCEy/fupTVlse0m4YNUHoitchjCj+ljwPv21TvQ5d+7mXpVUS+xSpntUqqe26Ka16ab4PF
 Gu3NGD4987jwMNbNL9d0sNffwi+xZWAOTbRZQNr0QGG29zLd/UI+UybkteDN31Dpfykoug
 /EDXUFe453pzEVTzDjaQ1w8WKw7qqvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-xygKlefXNLKGeSFzWnjREg-1; Tue, 12 Mar 2024 08:45:19 -0400
X-MC-Unique: xygKlefXNLKGeSFzWnjREg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E11786C046;
 Tue, 12 Mar 2024 12:45:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E356492BC4;
 Tue, 12 Mar 2024 12:45:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 54/55] target/xtensa: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Date: Tue, 12 Mar 2024 13:43:38 +0100
Message-ID: <20240312124339.761630-55-thuth@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240129164514.73104-29-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/xtensa/cpu.c        | 3 +--
 target/xtensa/dbg_helper.c | 3 +--
 target/xtensa/exc_helper.c | 3 +--
 target/xtensa/gdbstub.c    | 6 ++----
 target/xtensa/helper.c     | 9 +++------
 target/xtensa/translate.c  | 6 ++----
 6 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index c1cedf3f35..875cf843c9 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -96,9 +96,8 @@ bool xtensa_abi_call0(void)
 static void xtensa_cpu_reset_hold(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    XtensaCPU *cpu = XTENSA_CPU(cs);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     bool dfpu = xtensa_option_enabled(env->config,
                                       XTENSA_OPTION_DFP_COPROCESSOR);
 
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 497dafca71..5546c82ecd 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -66,8 +66,7 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
 
 bool xtensa_debug_check_breakpoint(CPUState *cs)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     unsigned int i;
 
     if (xtensa_get_cintlevel(env) >= env->config->debug_level) {
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 168419a505..0514c2c1f3 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -205,8 +205,7 @@ static void handle_interrupt(CPUXtensaState *env)
 /* Called from cpu_handle_interrupt with BQL held */
 void xtensa_cpu_do_interrupt(CPUState *cs)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
 
     if (cs->exception_index == EXC_IRQ) {
         qemu_log_mask(CPU_LOG_INT,
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 4b3bfb7e59..4748fb6532 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -65,8 +65,7 @@ void xtensa_count_regs(const XtensaConfig *config,
 
 int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     const XtensaGdbReg *reg = env->config->gdb_regmap.reg + n;
 #ifdef CONFIG_USER_ONLY
     int num_regs = env->config->gdb_regmap.num_core_regs;
@@ -120,8 +119,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int xtensa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     uint32_t tmp;
     const XtensaGdbReg *reg = env->config->gdb_regmap.reg + n;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index a9f8907083..ca214b948a 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -217,8 +217,7 @@ static uint32_t check_hw_breakpoints(CPUXtensaState *env)
 
 void xtensa_breakpoint_handler(CPUState *cs)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
 
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
@@ -266,8 +265,7 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     uint32_t paddr;
     uint32_t page_size;
     unsigned access;
@@ -297,8 +295,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       int mmu_idx, MemTxAttrs attrs,
                                       MemTxResult response, uintptr_t retaddr)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
 
     cpu_restore_state(cs, retaddr);
     HELPER(exception_cause_vaddr)(env, env->pc,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index e4772462b5..b206d57fc4 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1127,10 +1127,9 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
                                          CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUXtensaState *env = cpu_env(cpu);
     uint32_t tb_flags = dc->base.tb->flags;
 
-    dc->config = env->config;
+    dc->config = cpu_env(cpu)->config;
     dc->pc = dc->base.pc_first;
     dc->ring = tb_flags & XTENSA_TBFLAG_RING_MASK;
     dc->cring = (tb_flags & XTENSA_TBFLAG_EXCM) ? 0 : dc->ring;
@@ -1248,8 +1247,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 
 void xtensa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-    CPUXtensaState *env = &cpu->env;
+    CPUXtensaState *env = cpu_env(cs);
     xtensa_isa isa = env->config->isa;
     int i, j;
 
-- 
2.44.0



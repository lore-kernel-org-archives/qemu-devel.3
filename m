Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0C0C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1WA-00069z-1F; Tue, 12 Mar 2024 08:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VF-0004Xh-VW
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VA-0000aF-Fl
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j38YhxI5+1cvhXh9Ttj8PoXcMG7tNmX/38Gr4jWwNug=;
 b=DVyGJn901fi4vOb/EUMV8NvoLUMaDxKqPfIcp2i+LqNpQKYA+u4BETr/pjACZbyMOo+bp+
 MroFnIV/JbIxJF+oIZJRRIJZ3dW3yaXAPRsO7juvbQWXAEgDHOadgFBfkN5kJZR4AkP3pz
 FfL7xP1NVGZ2mQf6YC/QxNjaEQRV9E8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-mttuwsFnP7-kY9gX7Qnwbw-1; Tue,
 12 Mar 2024 08:44:58 -0400
X-MC-Unique: mttuwsFnP7-kY9gX7Qnwbw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E85EC1C41A19;
 Tue, 12 Mar 2024 12:44:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDD1F492BC4;
 Tue, 12 Mar 2024 12:44:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 40/55] target/cris: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Date: Tue, 12 Mar 2024 13:43:24 +0100
Message-ID: <20240312124339.761630-41-thuth@redhat.com>
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240129164514.73104-11-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/cris/cpu.c       | 10 +++-------
 target/cris/gdbstub.c   |  9 +++------
 target/cris/helper.c    | 12 ++++--------
 target/cris/translate.c |  6 ++----
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index ab2f169f21..eb4bddcb7e 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -63,10 +63,9 @@ static int cris_cpu_mmu_index(CPUState *cs, bool ifetch)
 
 static void cris_cpu_reset_hold(Object *obj)
 {
-    CPUState *s = CPU(obj);
-    CRISCPU *cpu = CRIS_CPU(s);
+    CPUState *cs = CPU(obj);
     CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     uint32_t vr;
 
     if (ccc->parent_phases.hold) {
@@ -147,10 +146,7 @@ static void cris_cpu_set_irq(void *opaque, int irq, int level)
 
 static void cris_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
-    CRISCPU *cc = CRIS_CPU(cpu);
-    CPUCRISState *env = &cc->env;
-
-    if (env->pregs[PR_VR] != 32) {
+    if (cpu_env(cpu)->pregs[PR_VR] != 32) {
         info->mach = bfd_mach_cris_v0_v10;
         info->print_insn = print_insn_crisv10;
     } else {
diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
index 25c0ca33a5..9e87069da8 100644
--- a/target/cris/gdbstub.c
+++ b/target/cris/gdbstub.c
@@ -23,8 +23,7 @@
 
 int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
 
     if (n < 15) {
         return gdb_get_reg32(mem_buf, env->regs[n]);
@@ -55,8 +54,7 @@ int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     uint8_t srs;
 
     srs = env->pregs[PR_SRS];
@@ -90,8 +88,7 @@ int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int cris_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     uint32_t tmp;
 
     if (n > 49) {
diff --git a/target/cris/helper.c b/target/cris/helper.c
index c0bf987e3e..1c3f86876f 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -53,8 +53,7 @@ bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     struct cris_mmu_result res;
     int prot, miss;
     target_ulong phy;
@@ -97,8 +96,7 @@ bool cris_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
 void crisv10_cpu_do_interrupt(CPUState *cs)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     int ex_vec = -1;
 
     D_LOG("exception index=%d interrupt_req=%d\n",
@@ -159,8 +157,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
 
 void cris_cpu_do_interrupt(CPUState *cs)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     int ex_vec = -1;
 
     D_LOG("exception index=%d interrupt_req=%d\n",
@@ -262,8 +259,7 @@ hwaddr cris_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 bool cris_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     bool ret = false;
 
     if (interrupt_request & CPU_INTERRUPT_HARD
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 8f74b6c53f..b3a4d61d0a 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3002,7 +3002,6 @@ static void cris_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void cris_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUCRISState *env = cpu_env(cs);
     unsigned int insn_len;
 
     /* Pretty disas.  */
@@ -3010,7 +3009,7 @@ static void cris_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     dc->clear_x = 1;
 
-    insn_len = dc->decoder(env, dc);
+    insn_len = dc->decoder(cpu_env(cs), dc);
     dc->ppc = dc->pc;
     dc->pc += insn_len;
     dc->base.pc_next += insn_len;
@@ -3176,8 +3175,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
 
 void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    CRISCPU *cpu = CRIS_CPU(cs);
-    CPUCRISState *env = &cpu->env;
+    CPUCRISState *env = cpu_env(cs);
     const char * const *regnames;
     const char * const *pregnames;
     int i;
-- 
2.44.0



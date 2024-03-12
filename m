Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC914C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1W6-00064J-Ox; Tue, 12 Mar 2024 08:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VP-0004rN-3t
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VL-0000dm-EJ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPBLvJtmZt/V5XmTVh2Kpqf3n4PfUcn0CyV12CErBiM=;
 b=K//7U/DxkwIRPwUCnshhSPq2tNTd/eY+2KtoDF2eSbANi9e4W8UawtiswBBx0GonT7PEkW
 aTfkXy2kB58IFDYaI03IxsH0tD4qVGJU7tIzceQ1YEWG7oR7FsJEc7A/p7b0AkiY33T2jX
 jOblX3GLM5ndDDnWEJgtW6bHyjCF+Ew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-CrRMgCH4N-2ZMHDRVSNDXw-1; Tue, 12 Mar 2024 08:45:11 -0400
X-MC-Unique: CrRMgCH4N-2ZMHDRVSNDXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A57286C049;
 Tue, 12 Mar 2024 12:45:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59F96492BC4;
 Tue, 12 Mar 2024 12:45:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 49/55] target/ppc: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Date: Tue, 12 Mar 2024 13:43:33 +0100
Message-ID: <20240312124339.761630-50-thuth@redhat.com>
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
Message-ID: <20240129164514.73104-22-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/mpc8544_guts.c         |  3 +--
 hw/ppc/pnv.c                  |  3 +--
 hw/ppc/pnv_xscom.c            |  5 +----
 hw/ppc/ppce500_spin.c         |  3 +--
 hw/ppc/spapr.c                |  3 +--
 hw/ppc/spapr_caps.c           |  7 ++-----
 target/ppc/cpu_init.c         | 11 +++--------
 target/ppc/excp_helper.c      |  3 +--
 target/ppc/gdbstub.c          | 12 ++++--------
 target/ppc/kvm.c              | 12 ++++--------
 target/ppc/ppc-qmp-cmds.c     |  3 +--
 target/ppc/user_only_helper.c |  3 +--
 12 files changed, 21 insertions(+), 47 deletions(-)

diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index a26e83d048..e3540b0281 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -71,8 +71,7 @@ static uint64_t mpc8544_guts_read(void *opaque, hwaddr addr,
                                   unsigned size)
 {
     uint32_t value = 0;
-    PowerPCCPU *cpu = POWERPC_CPU(current_cpu);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(current_cpu);
 
     addr &= MPC8544_GUTS_MMIO_SIZE - 1;
     switch (addr) {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 93d550988f..c2f2cc27be 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2412,8 +2412,7 @@ static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
 
 static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
 
     cpu_synchronize_state(cs);
     ppc_cpu_do_system_reset(cs);
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 805b1d0c87..a17816d072 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -44,15 +44,12 @@ static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
      * passed for the cpu, and no CPU completion is generated.
      */
     if (cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        CPUPPCState *env = &cpu->env;
-
         /*
          * TODO: Need a CPU helper to set HMER, also handle generation
          * of HMIs
          */
         cpu_synchronize_state(cs);
-        env->spr[SPR_HMER] |= hmer_bits;
+        cpu_env(cs)->spr[SPR_HMER] |= hmer_bits;
     }
 }
 
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index bbce63e8a4..dfbe759481 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -90,8 +90,7 @@ static void mmubooke_create_initial_mapping(CPUPPCState *env,
 
 static void spin_kick(CPUState *cs, run_on_cpu_data data)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     SpinInfo *curspin = data.host_ptr;
     hwaddr map_size = 64 * MiB;
     hwaddr map_start;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f8980b62ec..394091830d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3481,8 +3481,7 @@ static void spapr_machine_finalizefn(Object *obj)
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
 
     cpu_synchronize_state(cs);
     /* If FWNMI is inactive, addr will be -1, which will deliver to 0x100 */
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index e889244e52..cc91d59c57 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -194,8 +194,7 @@ static void cap_htm_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
 static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
 {
     ERRP_GUARD();
-    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(first_cpu);
 
     if (!val) {
         /* TODO: We don't support disabling vsx yet */
@@ -213,14 +212,12 @@ static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
 static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
 {
     ERRP_GUARD();
-    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
-    CPUPPCState *env = &cpu->env;
 
     if (!val) {
         /* TODO: We don't support disabling dfp yet */
         return;
     }
-    if (!(env->insns_flags2 & PPC2_DFP)) {
+    if (!(cpu_env(first_cpu)->insns_flags2 & PPC2_DFP)) {
         error_setg(errp, "DFP support not available");
         error_append_hint(errp, "Try appending -machine cap-dfp=off\n");
     }
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6d9c5a6c9a..1487e2e3c0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7196,12 +7196,9 @@ static void ppc_cpu_reset_hold(Object *obj)
 
 static bool ppc_cpu_is_big_endian(CPUState *cs)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
-
     cpu_synchronize_state(cs);
 
-    return !FIELD_EX64(env->msr, MSR, LE);
+    return !FIELD_EX64(cpu_env(cs)->msr, MSR, LE);
 }
 
 static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
@@ -7288,8 +7285,7 @@ static bool ppc_pvr_match_default(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
 
 static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
 
     if ((env->hflags >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
@@ -7445,8 +7441,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #define RGPL  4
 #define RFPL  4
 
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "NIP " TARGET_FMT_lx "   LR " TARGET_FMT_lx " CTR "
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 98952de267..6bb6fee8f6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2597,8 +2597,7 @@ void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
 
 bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     int interrupt;
 
     if ((interrupt_request & CPU_INTERRUPT_HARD) == 0) {
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 122ea9d0c0..769551e0ab 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -108,8 +108,7 @@ void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 
 int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     uint8_t *mem_buf;
     int r = ppc_gdb_register_len(n);
 
@@ -152,8 +151,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 
 int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     uint8_t *mem_buf;
     int r = ppc_gdb_register_len_apple(n);
 
@@ -206,8 +204,7 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
 
 int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     int r = ppc_gdb_register_len(n);
 
     if (!r) {
@@ -253,8 +250,7 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 }
 int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     int r = ppc_gdb_register_len_apple(n);
 
     if (!r) {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9f5a890655..6dfa5de444 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -546,8 +546,7 @@ static void kvm_sw_tlb_put(PowerPCCPU *cpu)
 
 static void kvm_get_one_spr(CPUState *cs, uint64_t id, int spr)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     /* Init 'val' to avoid "uninitialised value" Valgrind warnings */
     union {
         uint32_t u32;
@@ -581,8 +580,7 @@ static void kvm_get_one_spr(CPUState *cs, uint64_t id, int spr)
 
 static void kvm_put_one_spr(CPUState *cs, uint64_t id, int spr)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     union {
         uint32_t u32;
         uint64_t u64;
@@ -615,8 +613,7 @@ static void kvm_put_one_spr(CPUState *cs, uint64_t id, int spr)
 
 static int kvm_put_fp(CPUState *cs)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     struct kvm_one_reg reg;
     int i;
     int ret;
@@ -682,8 +679,7 @@ static int kvm_put_fp(CPUState *cs)
 
 static int kvm_get_fp(CPUState *cs)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     struct kvm_one_reg reg;
     int i;
     int ret;
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index ee0b99fce7..a25d86a8d1 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -137,8 +137,7 @@ static int ppc_cpu_get_reg_num(const char *numstr, int maxnum, int *pregnum)
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
 {
     int i, regnum;
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
 
     /* General purpose registers */
     if ((qemu_tolower(name[0]) == 'r') &&
diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
index 7ff76f7a06..a4d07a0d0d 100644
--- a/target/ppc/user_only_helper.c
+++ b/target/ppc/user_only_helper.c
@@ -27,8 +27,7 @@ void ppc_cpu_record_sigsegv(CPUState *cs, vaddr address,
                             MMUAccessType access_type,
                             bool maperr, uintptr_t retaddr)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     int exception, error_code;
 
     /*
-- 
2.44.0



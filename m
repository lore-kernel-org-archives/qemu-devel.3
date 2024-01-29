Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0262EC48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUoN-0005zK-QW; Mon, 29 Jan 2024 11:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnL-0000a8-BW
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnC-0004Hs-DW
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40ed356a6ecso26368615e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546848; x=1707151648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTmQyRcnNqgQwJoS6XsHQE+cWrjtXUUhl4cs1cvfE94=;
 b=looOpTelmPSGNUo7jhYH2x9y+0YYacG4Gn11QEEJnl875ZFV9Cv9aNcTG3HCrnK318
 E7MR+Wrl1090b+WvSK5TL8K/xKfzlw/hzgpYjZ6SA5G1IL0O6BJDfdCIQxSgUbZ/mexH
 LyTVcyuwfagvlEW8nPk6wmGCcolTqGiyNvpsBjIgqnYxm6sbyJOK1YTu5CHNNJCksVq0
 VjQNyxUxRJStF3bE6RLCub2TyZ1fRLiUkBRtTgyBMDrm0xvpxcFoCUZZTUw2UXkfdE6K
 ivmtOKTb7lkRoiRsaS6aOMc8yHHDaL+U2zIRLZVEejampJH+6i5z1YljuRJggxkoirRi
 /DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546848; x=1707151648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTmQyRcnNqgQwJoS6XsHQE+cWrjtXUUhl4cs1cvfE94=;
 b=hgdRhERQg18x0q3mFy1PFc0e2tOPF/pZeoZKHWqzmaWHMGiHIUlh+v7EeCRROfmxIt
 Mp+GkpX9wWoNxFOQQmtNLrULHdKjc6OVVQ8Z0zCiUKg3HuTz2C4pB0V9MYGYwiOSPw2q
 FlF/2c+KdPIK6dnoREknecYf6Uf85ls9vHa/3zwkEWCQKST2PYq20igO9VY/8sJLcUjC
 RhthvEcWh4VZ8OdI532Kojhd3tWDZJqO+ph2kuQ43kMlci0iBibVMsP+bHQET308Xul9
 LwhfV8wm8Q9w/VTCubOb8jsCDXUkhbqaxKPDAIMd1KHKDNoQzQyTcng9Z4/K4cpBWu6F
 jaQQ==
X-Gm-Message-State: AOJu0YxCHj8Dn/q5wKQpBcwL6xT069VCm6Sr11ZuXvk3iuvFz5XQtVn+
 XaUCUGmF8IHx0DSZXN1if4/AmlrSOherIrPQiyMTub5EZufFjK1Sqck1JewverazTywEdTHVszC
 o
X-Google-Smtp-Source: AGHT+IHRjk0Ni+ZTdCCitsdAD/Rw7PNydGz3Lc9DD15Omv+6GlenJU/4b1yCorKx64kreoceRIK6Ww==
X-Received: by 2002:a05:600c:19cf:b0:40e:85fe:af82 with SMTP id
 u15-20020a05600c19cf00b0040e85feaf82mr5997213wmq.24.1706546848265; 
 Mon, 29 Jan 2024 08:47:28 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 bd25-20020a05600c1f1900b0040ee0abd8f1sm9962562wmb.21.2024.01.29.08.47.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:47:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v3 21/29] target/ppc: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:45:03 +0100
Message-ID: <20240129164514.73104-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 202a569e27..77ee278a98 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2294,8 +2294,7 @@ static void pnv_machine_set_hb(Object *obj, bool value, Error **errp)
 
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
index 0b77aa5514..55d0fcb583 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3487,8 +3487,7 @@ static void spapr_machine_finalizefn(Object *obj)
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
index 61b8495a90..5d23b32c0e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7195,12 +7195,9 @@ static void ppc_cpu_reset_hold(Object *obj)
 
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
@@ -7287,8 +7284,7 @@ static bool ppc_pvr_match_default(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
 
 static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
 
     if ((env->hflags >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
@@ -7446,8 +7442,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #define RGPL  4
 #define RFPL  4
 
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "NIP " TARGET_FMT_lx "   LR " TARGET_FMT_lx " CTR "
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2ec6429e36..fccfefa88e 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2588,8 +2588,7 @@ void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
 
 bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
+    CPUPPCState *env = cpu_env(cs);
     int interrupt;
 
     if ((interrupt_request & CPU_INTERRUPT_HARD) == 0) {
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ec5731e5d6..fd986b1922 100644
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
index b95a0b4928..b0e35b31a6 100644
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
index c0c137d9d7..9ac74f5c04 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -133,8 +133,7 @@ static int ppc_cpu_get_reg_num(const char *numstr, int maxnum, int *pregnum)
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
2.41.0



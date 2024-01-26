Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2941EC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUKs-0001Tf-NP; Fri, 26 Jan 2024 17:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUKN-0008Ny-La
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:05:37 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUKJ-00049T-UD
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:05:34 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a313b51cf1fso154234866b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306729; x=1706911529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3J8OeebImZE8Elj1XiYwJgYjx4pjHQV9LzHXJrkifLg=;
 b=oegaTsIerNnG7s9Dw8byXfFavHLE0cubZdz/TjTkHzVzSK1438b8vMzAZDrxU6D1wc
 Gkg5uX3BfMUuHioLbIo/DD45LVLbvKl51b7S2F6307FY/dA/uCfzR7fu7PR4pPGUyGrr
 4VZT2eYRho8K0rd8qvAAe+C5ECEr/HrrruEfHzu+xEq8MqtCI3LPWJpvFFkuCJwITcTz
 Ri5GT2XVtx7LhuoC71DDCXtM8FxVF7hDkyzxPdRlQIBNCJzRs4c6jseBfLvXfIULKnpo
 kTJn5vMI3LDfX2urlDoQH1LFECzNCOy+ubphYmL65lmrEsp20b7+2dKyHVbn/6btvr1M
 qBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306729; x=1706911529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3J8OeebImZE8Elj1XiYwJgYjx4pjHQV9LzHXJrkifLg=;
 b=LbnDEkiNTtExLDa9H+sNbtFavfOWO9BJQfyg5gFrz20uEiXLF5C2D3gQCBOy9Ra8GK
 hNHv4PmM1ZySdeut2RmGyJo8p6tX8F33suKx7eFAKce6dKQCEJFpmgQ9NDCKirFE4YyC
 WPuYH+8/ft/sWZEPHtxdqrdQrBawt0GNJnS5/44rj9l7LEppooS4lIiYB0cf+D0tTc0R
 3QtpRl0ecB45CkrLaB5eolf+at1AXdKRr584lURT3Zz8QDZxKDMTMtl0xHWjYQw2m98q
 95gW7QvQq/h9gAgY39B/Ovx6GHQDKNRvGRwjOAe80v42+rHT2iiNIkyAA38O1jCBVywr
 Xkog==
X-Gm-Message-State: AOJu0YwsxLwwGcocO1dH4QfevaoorpGHEO3QjfJBWtAe6CoTb/dwcV0y
 nRt+6ILdKfBuhWd1AIwvzc36KyTfbXRy9/C+nCrI6JYvnz7VTi18oM/TR/rRBG7VSeoQp8kI9gU
 l
X-Google-Smtp-Source: AGHT+IFEhLA1jIB4l+ACKPiJElwY3cM/dMwsgfLQuB+LdSxqTKEjkK7rUGdxJzzKir1jjg6bT9hK9A==
X-Received: by 2002:a17:907:9805:b0:a27:d3ee:2ef5 with SMTP id
 ji5-20020a170907980500b00a27d3ee2ef5mr2958088ejc.24.1706306729550; 
 Fri, 26 Jan 2024 14:05:29 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 tl9-20020a170907c30900b00a318b8650bbsm1057523ejc.9.2024.01.26.14.05.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:05:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 13/23] target/mips: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Fri, 26 Jan 2024 23:03:55 +0100
Message-ID: <20240126220407.95022-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.c                       | 11 +++-------
 target/mips/gdbstub.c                   |  6 ++----
 target/mips/kvm.c                       | 27 +++++++++----------------
 target/mips/sysemu/physaddr.c           |  3 +--
 target/mips/tcg/exception.c             |  3 +--
 target/mips/tcg/op_helper.c             |  3 +--
 target/mips/tcg/sysemu/special_helper.c |  3 +--
 target/mips/tcg/sysemu/tlb_helper.c     |  6 ++----
 target/mips/tcg/translate.c             |  3 +--
 9 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index a0023edd43..d9c0c0dada 100644
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
@@ -137,8 +136,7 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
 
 static bool mips_cpu_has_work(CPUState *cs)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     bool has_work = false;
 
     /*
@@ -428,10 +426,7 @@ static void mips_cpu_reset_hold(Object *obj)
 
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
index 05990aa5bb..56380dfe6c 100644
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
index 98935b5e64..b57baa7ec1 100644
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
 
diff --git a/target/mips/tcg/sysemu/special_helper.c b/target/mips/tcg/sysemu/special_helper.c
index 93276f789d..7934f2ea41 100644
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
index 4ede904800..6c48c4fa80 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -910,8 +910,7 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
     int ret = TLBRET_BADADDR;
@@ -1346,8 +1345,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
 bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        MIPSCPU *cpu = MIPS_CPU(cs);
-        CPUMIPSState *env = &cpu->env;
+        CPUMIPSState *env = cpu_env(cs);
 
         if (cpu_mips_hw_interrupts_enabled(env) &&
             cpu_mips_hw_interrupts_pending(env)) {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 13e43fa3b6..e74b98de1c 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15628,8 +15628,7 @@ void mips_restore_state_to_opc(CPUState *cs,
                                const TranslationBlock *tb,
                                const uint64_t *data)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-    CPUMIPSState *env = &cpu->env;
+    CPUMIPSState *env = cpu_env(cs);
 
     env->active_tc.PC = data[0];
     env->hflags &= ~MIPS_HFLAG_BMASK;
-- 
2.41.0



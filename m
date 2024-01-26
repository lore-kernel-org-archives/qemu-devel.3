Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A4CC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTULY-0004N2-Bk; Fri, 26 Jan 2024 17:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTULQ-0003TZ-KV
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:06:40 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTULM-0004kx-IP
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:06:40 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33ae2d80b70so30260f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306795; x=1706911595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fYY/rLuA2hauAuBtrudFqwtHsgwmB3pc71dc5VwoGs=;
 b=QfDfk/ePiqy999oj8DN/7MCRPxgFlEg3hM6X/zbyX/Pi8f9N6/C2mX1wYiGSoatebO
 ro08HSnl+j6JtyKYnEJwj3H1e/De6Q1CUJPR+9vLOwGfLXvN1Konue4fFHizWeLTVNYz
 gxqjAbNdzDzT1d2aR98Zb86igrdFu4PV0cSQ3TWFLHn3YE0FjYxiQV/U8rjO0O0M2TuW
 ejDllFXbilxv63U8FsxpiKwS4LkkJjyYZFc2KFj8Cbaa9SUhBufBIXPcDwIXUxK6U9UV
 O0u95rTcUl9b/hrHxzuzhXhMaKQ01T9Jiw2JcZYGZymM5Vh1MvsBD1pNbGf4nzazscYi
 8WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306795; x=1706911595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fYY/rLuA2hauAuBtrudFqwtHsgwmB3pc71dc5VwoGs=;
 b=opP/YVi61VvgXff5WnnS1zud+eUjwnp3ztVk4k+HSMC4FrMzvFN5m67NQ360dRS62s
 gcFGcyvGrWiRUE4oa0Dbmdi1QZfwYUlpNweI0HhXTg85R5bjDzyVVLrydAvVuSVIQVNL
 7Mfj6MgmPNf3Owk6Mj3+nhLX9HbbiLaFyunbBpG+GLHUS56fEOV/QgxYuEIFpFBrHh0d
 HX/HuuIwtBzj3glaLpUp4tCgQwjEl5q8ehpsDOHNrj9cTyRc47Xvz87ptr45Rv7xHAMu
 zi81T1PyXRN+oG/ZFIcIjhA94gUlesJZAzcnX/52I+KwXLAaDkrKSwO0AOSpR1yRrjz6
 stxg==
X-Gm-Message-State: AOJu0YyRQmx5c1sBL4wPTOi3y/gYjra5GziSsvzvSX2dOMU56E1duuwU
 tQ8oLi6dSMkomUzIhZZrLU+vD79Qi21u94osI4dmuRWncP9zziuwzi372IxCLeN6f4kmyeXRJ2p
 J
X-Google-Smtp-Source: AGHT+IG7a7xEui69gg0qXrAz5p7Hrr1+TBmeVYWg5uEu5eOY3lm2QMdEghKBG4M/Df8L/t6sj7dohg==
X-Received: by 2002:a5d:4d11:0:b0:337:ca7a:313d with SMTP id
 z17-20020a5d4d11000000b00337ca7a313dmr228329wrt.10.1706306794747; 
 Fri, 26 Jan 2024 14:06:34 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 r18-20020adfce92000000b00337aed83aaasm2064013wrn.92.2024.01.26.14.06.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:06:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 23/23] target/sparc: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Fri, 26 Jan 2024 23:04:05 +0100
Message-ID: <20240126220407.95022-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
 target/sparc/cpu.c          | 14 ++++----------
 target/sparc/gdbstub.c      |  3 +--
 target/sparc/int32_helper.c |  3 +--
 target/sparc/int64_helper.c |  3 +--
 target/sparc/ldst_helper.c  |  6 ++----
 target/sparc/mmu_helper.c   | 15 +++++----------
 target/sparc/translate.c    |  3 +--
 7 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index befa7fc4eb..a53c200d8b 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -83,8 +83,7 @@ static void sparc_cpu_reset_hold(Object *obj)
 static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        SPARCCPU *cpu = SPARC_CPU(cs);
-        CPUSPARCState *env = &cpu->env;
+        CPUSPARCState *env = cpu_env(cs);
 
         if (cpu_interrupts_enabled(env) && env->interrupt_index > 0) {
             int pil = env->interrupt_index & 0xf;
@@ -613,8 +612,7 @@ static void cpu_print_cc(FILE *f, uint32_t cc)
 
 static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int i, x;
 
     qemu_fprintf(f, "pc: " TARGET_FMT_lx "  npc: " TARGET_FMT_lx "\n", env->pc,
@@ -711,11 +709,8 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
 
 static bool sparc_cpu_has_work(CPUState *cs)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
-
     return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-           cpu_interrupts_enabled(env);
+           cpu_interrupts_enabled(cpu_env(cs));
 }
 
 static char *sparc_cpu_type_name(const char *cpu_model)
@@ -749,8 +744,7 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUState *cs = CPU(dev);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
-    SPARCCPU *cpu = SPARC_CPU(dev);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
 #if defined(CONFIG_USER_ONLY)
     /* We are emulating the kernel, which will trap and emulate float128. */
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index a1c8fdc4d5..5257c49a0d 100644
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
index 09066d5487..203441bfb2 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -421,8 +421,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
                                   bool is_write, bool is_exec, int is_asi,
                                   unsigned size, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     int fault_type;
 
 #ifdef DEBUG_UNASSIGNED
@@ -483,8 +482,7 @@ static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
                                   bool is_write, bool is_exec, int is_asi,
                                   unsigned size, uintptr_t retaddr)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
 
 #ifdef DEBUG_UNASSIGNED
     printf("Unassigned mem access to " HWADDR_FMT_plx " from " TARGET_FMT_lx
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 453498c670..a05ee22315 100644
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
     int mmu_idx = cpu_mmu_index(env, false);
 
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
index 9387299559..412b7d1b66 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5406,8 +5406,7 @@ void sparc_restore_state_to_opc(CPUState *cs,
                                 const TranslationBlock *tb,
                                 const uint64_t *data)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
+    CPUSPARCState *env = cpu_env(cs);
     target_ulong pc = data[0];
     target_ulong npc = data[1];
 
-- 
2.41.0



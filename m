Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF500C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUJW-0007Mm-I8; Fri, 26 Jan 2024 17:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJV-0007M5-4W
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:41 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJQ-0003TV-Lx
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:40 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a277339dcf4so76719966b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306674; x=1706911474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZRGd7bldk8q+PytOQG4zQL+je/AXd973w95qInnP0Y=;
 b=Uo8/h+hYe/OucHNYUvgbf05pgDuN4KgNu0dGYvXwkxtCHkT+Al1dkvwLhWcrGe791e
 hPRTBHarqVdTNw2Lw+xAR+D7RxVjmO/Ib7ZJZ8EH+cKyaqbClnI0DhfQheRZRiDyxJBg
 cMEm5iqHKyrzIMEqkNTO/rSupJaaevrqK4l0OwJfkkog6PkyYwdsLz29r0f0dxa/X3QL
 uzHkmfy6R2YAu8LrAILLkd5RngdvzQ+Fyz5IsvBq5hi81vbKnIB9P1SZFOUB93Wi6pOS
 8VlYHmTZBu4rne4iaB3ZWT1Kt5v76Gp/uzNiAy2oTO+B94P/+cglT5Lu72ouDwA1OU7q
 Nbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306674; x=1706911474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZRGd7bldk8q+PytOQG4zQL+je/AXd973w95qInnP0Y=;
 b=Gl+VF+ALVs+oXcWT4pG54Xl2vzrk77JmfMtnASbFAANK2jQfqulqo88ncsV1qOHH+u
 +nfN4Cg1nK1VWkCAfNwqblETU5wJQXvc0+U6Aej82mb50jmNLZqEy/a0rNo9B/zBbCx7
 Qw+NCiKMurjf7cpFbVYiEkGWoBCDBXewDkMT71L/iJKo5pysZ/i5gZoi0Dd/Y+jg2aTN
 bNlqKZK4tTKIavlQccpiPPpJMQqmGLWpjNX0MBDDaawWEt5xmFv+dhGXSWtc5mIBOWSm
 hOsgT1+7Z1tvs9kUWWgiXor+qL0U5C6YeU2/FBXQSrQaTMlmbRMKwVz57G+nP/EjyNPv
 CPYg==
X-Gm-Message-State: AOJu0Yzs+akAXgbO3ZIFZH4CeFW3SWUQKWkP0m8DL+kTt5RaV0wnOvoe
 pohoyvlwVDZe/2kpYjCMA5FKOY7UOhFu5yrMPHfFqbDDDD64dHyiPilzDM+cd1UWo2aGrPtwH5x
 c
X-Google-Smtp-Source: AGHT+IHapGDMMDIR7ZT70/oBeOow7jZoQYe16jS+urcOsV4oetXblAiel6wHpVfPQA9ZXN8WFwidGw==
X-Received: by 2002:a17:906:adcb:b0:a2f:15b8:cbcd with SMTP id
 lb11-20020a170906adcb00b00a2f15b8cbcdmr203155ejb.8.1706306674546; 
 Fri, 26 Jan 2024 14:04:34 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 k25-20020a17090646d900b00a316490ddbbsm1039815ejs.200.2024.01.26.14.04.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:04:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/23] target/alpha: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Fri, 26 Jan 2024 23:03:46 +0100
Message-ID: <20240126220407.95022-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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
 target/alpha/cpu.c        | 31 +++++++------------------------
 target/alpha/gdbstub.c    |  6 ++----
 target/alpha/helper.c     | 12 ++++--------
 target/alpha/mem_helper.c | 11 +++--------
 4 files changed, 16 insertions(+), 44 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b8ed29e343..e21a8936c7 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -130,40 +130,27 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
 
 static void ev4_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->implver = IMPLVER_2106x;
+    cpu_env(CPU(obj))->implver = IMPLVER_2106x;
 }
 
 static void ev5_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->implver = IMPLVER_21164;
+    cpu_env(CPU(obj))->implver = IMPLVER_21164;
 }
 
 static void ev56_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->amask |= AMASK_BWX;
+    cpu_env(CPU(obj))->amask |= AMASK_BWX;
 }
 
 static void pca56_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->amask |= AMASK_MVI;
+    cpu_env(CPU(obj))->amask |= AMASK_MVI;
 }
 
 static void ev6_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(CPU(obj));
 
     env->implver = IMPLVER_21264;
     env->amask = AMASK_BWX | AMASK_FIX | AMASK_MVI | AMASK_TRAP;
@@ -171,16 +158,12 @@ static void ev6_cpu_initfn(Object *obj)
 
 static void ev67_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
-
-    env->amask |= AMASK_CIX | AMASK_PREFETCH;
+    cpu_env(CPU(obj))->amask |= AMASK_CIX | AMASK_PREFETCH;
 }
 
 static void alpha_cpu_initfn(Object *obj)
 {
-    AlphaCPU *cpu = ALPHA_CPU(obj);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(CPU(obj));
 
     env->lock_addr = -1;
 #if defined(CONFIG_USER_ONLY)
diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 0f8fa150f8..13694fd321 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -23,8 +23,7 @@
 
 int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     uint64_t val;
     CPU_DoubleU d;
 
@@ -59,8 +58,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     target_ulong tmp = ldtul_p(mem_buf);
     CPU_DoubleU d;
 
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 970c869771..eeed874e5a 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -298,8 +298,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     target_ulong phys;
     int prot, fail;
 
@@ -325,8 +324,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 
 void alpha_cpu_do_interrupt(CPUState *cs)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     int i = cs->exception_index;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
@@ -435,8 +433,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     int idx = -1;
 
     /* We never take interrupts while in PALmode.  */
@@ -487,8 +484,7 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         "a0",  "a1",  "a2", "a3",  "a4", "a5", "t8", "t9",
         "t10", "t11", "ra", "t12", "at", "gp", "sp"
     };
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
     int i;
 
     qemu_fprintf(f, "PC      " TARGET_FMT_lx " PS      %02x\n",
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index a39b52c5dd..872955f5e7 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -42,18 +42,14 @@ static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retadd
 void alpha_cpu_record_sigbus(CPUState *cs, vaddr addr,
                              MMUAccessType access_type, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
-
-    do_unaligned_access(env, addr, retaddr);
+    do_unaligned_access(cpu_env(cs), addr, retaddr);
 }
 #else
 void alpha_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type,
                                    int mmu_idx, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
 
     do_unaligned_access(env, addr, retaddr);
     cs->exception_index = EXCP_UNALIGN;
@@ -67,8 +63,7 @@ void alpha_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      int mmu_idx, MemTxAttrs attrs,
                                      MemTxResult response, uintptr_t retaddr)
 {
-    AlphaCPU *cpu = ALPHA_CPU(cs);
-    CPUAlphaState *env = &cpu->env;
+    CPUAlphaState *env = cpu_env(cs);
 
     env->trap_arg0 = addr;
     env->trap_arg1 = access_type == MMU_DATA_STORE ? 1 : 0;
-- 
2.41.0



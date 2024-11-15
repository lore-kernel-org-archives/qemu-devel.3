Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80239D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8u-0003NF-SQ; Fri, 15 Nov 2024 10:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8t-0003Mk-9F
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:51 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8l-00048o-J0
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:51 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso20620645e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684098; x=1732288898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKWMGwmFv0czeolnzZbx5rlDe+HwftXAS8FGuJHXNJM=;
 b=AHYPns+X9tpPo0vjtN4ZV/r8GDMGXE84ad766+k6wKFGKRHDSpNeOytxmbnGG6ama4
 i7IvJRjoLeHuk0B2M9If7X5DIVrFN2OMhJs95ysySXD4EpZECZgFgzxaETjGReuSpxow
 CeE0nfaUI4iKwtvzkDEv8/vJrSoqB8m54BAl06/SvKR9loyrE/Z5C8N/pGAYcJcqHcwa
 PW37oIdiEZcQCpmpeToWaKdX110D6WlR8nmFuu0Re5rnroafqKOnblezKhHIaxAU/s7U
 tysQIfWWk4KSlqzwFnI8WYFQTothSrXqFkeFHjiZSbGpqEmSF3IsDwbLHRrz4Be5xAGx
 n9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684098; x=1732288898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKWMGwmFv0czeolnzZbx5rlDe+HwftXAS8FGuJHXNJM=;
 b=QWhCSq0hgiEbqEh+2JFAW/r5YmKx37m9E9h3049vZpVBmNCfmOA4V2aafhae8LIxoX
 AVQMm1y9vKuCc9nUcS44rjRT22E0FfZHruVO9we6TCHVPGJqa4qIReGuSDqQl5WJdqpZ
 ePxGa+hzVQxqh9Rq53rmJea/TKsBVs6ARwPYdwYHoIXG75kDt/oUG0jwY4jonjBkua+F
 n82eTHNUg3xxN9hvuTdz6p5aj/wH6ZG+Olk3k32VV1Xy5XPsUYrxh8njwVPhrxieIdnX
 Br9h1AQ/KCfnw25u7gpk/jjJs2JvRHPRcwcRzYyskNh6DkM+eHnCql2l2oVj7HiGjew7
 Xvvg==
X-Gm-Message-State: AOJu0YwfbYqPkIO1EQb5C/st1MU9b8hx3awrdT3nHUd1wdxG8JOJgsig
 ZEKTOY8BBhds+S/APAkWVbREag/uk8aAyt99WwLk4hsYL0twBiTGCbt7ALibPXGU9R4W/pE/eKy
 u
X-Google-Smtp-Source: AGHT+IEYVCVsfJ8sitrAF3hmfZy+UyWf5Io+8kNnh8H099vxz1CNGN2r9u/gK7+02s4+ltj9gvU6Bg==
X-Received: by 2002:a5d:584f:0:b0:382:2467:cb32 with SMTP id
 ffacd0b85a97d-38225a21be3mr2660319f8f.4.1731684098165; 
 Fri, 15 Nov 2024 07:21:38 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae161d8sm4718500f8f.78.2024.11.15.07.21.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/10] hw/core/cpu: Pass CPUArchState to set/get_pc() handlers
Date: Fri, 15 Nov 2024 16:20:51 +0100
Message-ID: <20241115152053.66442-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CPUClass set_pc() and get_pc() handlers are target specific.
Rather than passing a generic CPUState and forcing QOM casts,
we can directly pass the target CPUArchState, simplifying.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h     |  6 +++---
 accel/tcg/cpu-exec.c      |  7 ++++---
 accel/tcg/translate-all.c |  2 +-
 hw/core/generic-loader.c  |  2 +-
 target/alpha/cpu.c        |  6 ++----
 target/arm/cpu.c          | 10 ++--------
 target/avr/cpu.c          | 12 ++++--------
 target/hexagon/cpu.c      |  8 ++++----
 target/hppa/cpu.c         | 14 +++++---------
 target/i386/cpu.c         | 12 ++++--------
 target/loongarch/cpu.c    |  8 ++++----
 target/m68k/cpu.c         | 12 ++++--------
 target/microblaze/cpu.c   | 14 +++++---------
 target/mips/cpu.c         | 10 ++++------
 target/openrisc/cpu.c     | 14 +++++---------
 target/ppc/cpu_init.c     | 12 ++++--------
 target/riscv/cpu.c        | 10 ++--------
 target/rx/cpu.c           | 12 ++++--------
 target/s390x/cpu.c        | 12 ++++--------
 target/sh4/cpu.c          | 12 ++++--------
 target/sparc/cpu.c        | 14 +++++---------
 target/tricore/cpu.c      |  8 ++++----
 target/xtensa/cpu.c       | 12 ++++--------
 23 files changed, 83 insertions(+), 146 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index db8a6fbc6e..70f5f8c3bf 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -160,8 +160,8 @@ struct CPUClass {
     int64_t (*get_arch_id)(CPUState *cpu);
     bool (*cpu_persistent_status)(CPUState *cpu);
     bool (*cpu_enabled_status)(CPUState *cpu);
-    void (*set_pc)(CPUState *cpu, vaddr value);
-    vaddr (*get_pc)(CPUState *cpu);
+    void (*set_pc)(CPUArchState *env, vaddr value);
+    vaddr (*get_pc)(CPUArchState *env);
     int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
     int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
     vaddr (*gdb_adjust_breakpoint)(CPUState *cpu, vaddr addr);
@@ -972,7 +972,7 @@ static inline void cpu_set_pc(CPUState *cpu, vaddr addr)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
-    cc->set_pc(cpu, addr);
+    cc->set_pc(cpu_env(cpu), addr);
 }
 
 /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 73bc9f00f7..b73607fea0 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -437,7 +437,7 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
 {
     if (tb_cflags(tb) & CF_PCREL) {
-        return cpu->cc->get_pc(cpu);
+        return cpu->cc->get_pc(cpu_env(cpu));
     } else {
         return tb->pc;
     }
@@ -459,13 +459,14 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
     uintptr_t ret;
     TranslationBlock *last_tb;
     const void *tb_ptr = itb->tc.ptr;
+    CPUArchState *env = cpu_env(cpu);
 
     if (qemu_loglevel_mask(CPU_LOG_TB_CPU | CPU_LOG_EXEC)) {
         log_cpu_exec(log_pc(cpu, itb), cpu, itb);
     }
 
     qemu_thread_jit_execute();
-    ret = tcg_qemu_tb_exec(cpu_env(cpu), tb_ptr);
+    ret = tcg_qemu_tb_exec(env, tb_ptr);
     cpu->neg.can_do_io = true;
     qemu_plugin_disable_mem_helpers(cpu);
     /*
@@ -494,7 +495,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
         } else {
             tcg_debug_assert(!(tb_cflags(last_tb) & CF_PCREL));
             assert(cc->set_pc);
-            cc->set_pc(cpu, last_tb->pc);
+            cc->set_pc(env, last_tb->pc);
         }
         if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
             vaddr pc = log_pc(cpu, last_tb);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8d5530e341..375100b483 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -634,7 +634,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
-        vaddr pc = cpu->cc->get_pc(cpu);
+        vaddr pc = cpu->cc->get_pc(cpu_env(cpu));
         if (qemu_log_in_addr_range(pc)) {
             qemu_log("cpu_io_recompile: rewound execution of TB to %016"
                      VADDR_PRIx "\n", pc);
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index ea8628b892..32cb5d9639 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -51,7 +51,7 @@ static void generic_loader_reset(void *opaque)
         CPUClass *cc = CPU_GET_CLASS(s->cpu);
         cpu_reset(s->cpu);
         if (cc) {
-            cc->set_pc(s->cpu, s->addr);
+            cc->set_pc(cpu_env(s->cpu), s->addr);
         }
     }
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 5d75c941f7..dce7a3ea5d 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -27,15 +27,13 @@
 #include "fpu/softfloat.h"
 
 
-static void alpha_cpu_set_pc(CPUState *cs, vaddr value)
+static void alpha_cpu_set_pc(CPUAlphaState *env, vaddr value)
 {
-    CPUAlphaState *env = cpu_env(cs);
     env->pc = value;
 }
 
-static vaddr alpha_cpu_get_pc(CPUState *cs)
+static vaddr alpha_cpu_get_pc(CPUAlphaState *env)
 {
-    CPUAlphaState *env = cpu_env(cs);
     return env->pc;
 }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b95..b7cf084019 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -51,11 +51,8 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-static void arm_cpu_set_pc(CPUState *cs, vaddr value)
+static void arm_cpu_set_pc(CPUARMState *env, vaddr value)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
     if (is_a64(env)) {
         env->pc = value;
         env->thumb = false;
@@ -65,11 +62,8 @@ static void arm_cpu_set_pc(CPUState *cs, vaddr value)
     }
 }
 
-static vaddr arm_cpu_get_pc(CPUState *cs)
+static vaddr arm_cpu_get_pc(CPUARMState *env)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
     if (is_a64(env)) {
         return env->pc;
     } else {
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 3132842d56..e85e54feb8 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -27,18 +27,14 @@
 #include "tcg/debug-assert.h"
 #include "hw/qdev-properties.h"
 
-static void avr_cpu_set_pc(CPUState *cs, vaddr value)
+static void avr_cpu_set_pc(CPUAVRState *env, vaddr value)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-
-    cpu->env.pc_w = value / 2; /* internally PC points to words */
+    env->pc_w = value / 2; /* internally PC points to words */
 }
 
-static vaddr avr_cpu_get_pc(CPUState *cs)
+static vaddr avr_cpu_get_pc(CPUAVRState *env)
 {
-    AVRCPU *cpu = AVR_CPU(cs);
-
-    return cpu->env.pc_w * 2;
+    return env->pc_w * 2;
 }
 
 static bool avr_cpu_has_work(CPUState *cs)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 020038fc49..828b7d1df3 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -245,14 +245,14 @@ void hexagon_debug(CPUHexagonState *env)
     hexagon_dump(env, stdout, CPU_DUMP_FPU);
 }
 
-static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
+static void hexagon_cpu_set_pc(CPUHexagonState *env, vaddr value)
 {
-    cpu_env(cs)->gpr[HEX_REG_PC] = value;
+    env->gpr[HEX_REG_PC] = value;
 }
 
-static vaddr hexagon_cpu_get_pc(CPUState *cs)
+static vaddr hexagon_cpu_get_pc(CPUHexagonState *env)
 {
-    return cpu_env(cs)->gpr[HEX_REG_PC];
+    return env->gpr[HEX_REG_PC];
 }
 
 static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c38439c180..d73a88b279 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -28,21 +28,17 @@
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
 
-static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
+static void hppa_cpu_set_pc(CPUHPPAState *env, vaddr value)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-
 #ifdef CONFIG_USER_ONLY
     value |= PRIV_USER;
 #endif
-    cpu->env.iaoq_f = value;
-    cpu->env.iaoq_b = value + 4;
+    env->iaoq_f = value;
+    env->iaoq_b = value + 4;
 }
 
-static vaddr hppa_cpu_get_pc(CPUState *cs)
+static vaddr hppa_cpu_get_pc(CPUHPPAState *env)
 {
-    CPUHPPAState *env = cpu_env(cs);
-
     return hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
                              env->iaoq_f & -4);
 }
@@ -59,7 +55,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
      * incomplete virtual address.  This also means that we must separate
      * out current cpu privilege from the low bits of IAOQ_F.
      */
-    *pc = hppa_cpu_get_pc(env_cpu(env));
+    *pc = hppa_cpu_get_pc(env);
     flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
 
     /*
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3725dbbc4b..5f063b18c4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8251,19 +8251,15 @@ static bool x86_cpu_get_paging_enabled(const CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static void x86_cpu_set_pc(CPUState *cs, vaddr value)
+static void x86_cpu_set_pc(CPUX86State *env, vaddr value)
 {
-    X86CPU *cpu = X86_CPU(cs);
-
-    cpu->env.eip = value;
+    env->eip = value;
 }
 
-static vaddr x86_cpu_get_pc(CPUState *cs)
+static vaddr x86_cpu_get_pc(CPUX86State *env)
 {
-    X86CPU *cpu = X86_CPU(cs);
-
     /* Match cpu_get_tb_cpu_state. */
-    return cpu->env.eip + cpu->env.segs[R_CS].base;
+    return env->eip + env->segs[R_CS].base;
 }
 
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e599beb30a..add7323f05 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -101,14 +101,14 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
     cpu_loop_exit_restore(cs, pc);
 }
 
-static void loongarch_cpu_set_pc(CPUState *cs, vaddr value)
+static void loongarch_cpu_set_pc(CPULoongArchState *env, vaddr value)
 {
-    set_pc(cpu_env(cs), value);
+    set_pc(env, value);
 }
 
-static vaddr loongarch_cpu_get_pc(CPUState *cs)
+static vaddr loongarch_cpu_get_pc(CPULoongArchState *env)
 {
-    return cpu_env(cs)->pc;
+    return env->pc;
 }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 5fe335558a..39bf6f3d90 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -24,18 +24,14 @@
 #include "migration/vmstate.h"
 #include "fpu/softfloat.h"
 
-static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
+static void m68k_cpu_set_pc(CPUM68KState *env, vaddr value)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-
-    cpu->env.pc = value;
+    env->pc = value;
 }
 
-static vaddr m68k_cpu_get_pc(CPUState *cs)
+static vaddr m68k_cpu_get_pc(CPUM68KState *env)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
-
-    return cpu->env.pc;
+    return env->pc;
 }
 
 static void m68k_restore_state_to_opc(CPUState *cs,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 710eb1146c..3e68c73898 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -78,20 +78,16 @@ static const struct {
 /* If no specific version gets selected, default to the following.  */
 #define DEFAULT_CPU_VERSION "10.0"
 
-static void mb_cpu_set_pc(CPUState *cs, vaddr value)
+static void mb_cpu_set_pc(CPUMBState *env, vaddr value)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-
-    cpu->env.pc = value;
+    env->pc = value;
     /* Ensure D_FLAG and IMM_FLAG are clear for the new PC */
-    cpu->env.iflags = 0;
+    env->iflags = 0;
 }
 
-static vaddr mb_cpu_get_pc(CPUState *cs)
+static vaddr mb_cpu_get_pc(CPUMBState *env)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-
-    return cpu->env.pc;
+    return env->pc;
 }
 
 static void mb_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 7c6f438e5d..506494f7e6 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -120,16 +120,14 @@ void cpu_set_exception_base(int vp_index, target_ulong address)
     vp->env.exception_base = address;
 }
 
-static void mips_cpu_set_pc(CPUState *cs, vaddr value)
+static void mips_cpu_set_pc(CPUMIPSState *env, vaddr value)
 {
-    mips_env_set_pc(cpu_env(cs), value);
+    mips_env_set_pc(env, value);
 }
 
-static vaddr mips_cpu_get_pc(CPUState *cs)
+static vaddr mips_cpu_get_pc(CPUMIPSState *env)
 {
-    MIPSCPU *cpu = MIPS_CPU(cs);
-
-    return cpu->env.active_tc.PC;
+    return env->active_tc.PC;
 }
 
 static bool mips_cpu_has_work(CPUState *cs)
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b96561d1f2..51ab0df82b 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -25,19 +25,15 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
-static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
+static void openrisc_cpu_set_pc(CPUOpenRISCState *env, vaddr value)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-
-    cpu->env.pc = value;
-    cpu->env.dflag = 0;
+    env->pc = value;
+    env->dflag = 0;
 }
 
-static vaddr openrisc_cpu_get_pc(CPUState *cs)
+static vaddr openrisc_cpu_get_pc(CPUOpenRISCState *env)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-
-    return cpu->env.pc;
+    return env->pc;
 }
 
 static void openrisc_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index efcb80d1c2..c8b4445aea 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7152,18 +7152,14 @@ void ppc_cpu_list(void)
 #endif
 }
 
-static void ppc_cpu_set_pc(CPUState *cs, vaddr value)
+static void ppc_cpu_set_pc(CPUPPCState *env, vaddr value)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-
-    cpu->env.nip = value;
+    env->nip = value;
 }
 
-static vaddr ppc_cpu_get_pc(CPUState *cs)
+static vaddr ppc_cpu_get_pc(CPUPPCState *env)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-
-    return cpu->env.nip;
+    return env->nip;
 }
 
 #ifdef CONFIG_TCG
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b5..dfaa9a9c1c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -878,11 +878,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
+static void riscv_cpu_set_pc(CPURISCVState *env, vaddr value)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
-
     if (env->xl == MXL_RV32) {
         env->pc = (int32_t)value;
     } else {
@@ -890,11 +887,8 @@ static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
     }
 }
 
-static vaddr riscv_cpu_get_pc(CPUState *cs)
+static vaddr riscv_cpu_get_pc(CPURISCVState *env)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
-
     /* Match cpu_get_tb_cpu_state. */
     if (env->xl == MXL_RV32) {
         return env->pc & UINT32_MAX;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 65a74ce720..0c4b63b114 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -27,18 +27,14 @@
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 
-static void rx_cpu_set_pc(CPUState *cs, vaddr value)
+static void rx_cpu_set_pc(CPURXState *env, vaddr value)
 {
-    RXCPU *cpu = RX_CPU(cs);
-
-    cpu->env.pc = value;
+    env->pc = value;
 }
 
-static vaddr rx_cpu_get_pc(CPUState *cs)
+static vaddr rx_cpu_get_pc(CPURXState *env)
 {
-    RXCPU *cpu = RX_CPU(cs);
-
-    return cpu->env.pc;
+    return env->pc;
 }
 
 static void rx_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 514c70f301..12975385e0 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -112,18 +112,14 @@ uint64_t s390_cpu_get_psw_mask(CPUS390XState *env)
     return r;
 }
 
-static void s390_cpu_set_pc(CPUState *cs, vaddr value)
+static void s390_cpu_set_pc(CPUS390XState *env, vaddr value)
 {
-    S390CPU *cpu = S390_CPU(cs);
-
-    cpu->env.psw.addr = value;
+    env->psw.addr = value;
 }
 
-static vaddr s390_cpu_get_pc(CPUState *cs)
+static vaddr s390_cpu_get_pc(CPUS390XState *env)
 {
-    S390CPU *cpu = S390_CPU(cs);
-
-    return cpu->env.psw.addr;
+    return env->psw.addr;
 }
 
 static bool s390_cpu_has_work(CPUState *cs)
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 8f07261dcf..5c6840841b 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -28,18 +28,14 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
-static void superh_cpu_set_pc(CPUState *cs, vaddr value)
+static void superh_cpu_set_pc(CPUSH4State *env, vaddr value)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-
-    cpu->env.pc = value;
+    env->pc = value;
 }
 
-static vaddr superh_cpu_get_pc(CPUState *cs)
+static vaddr superh_cpu_get_pc(CPUSH4State *env)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-
-    return cpu->env.pc;
+    return env->pc;
 }
 
 static void superh_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 59db8c8472..e1f0dfcbbd 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -688,19 +688,15 @@ static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "\n");
 }
 
-static void sparc_cpu_set_pc(CPUState *cs, vaddr value)
+static void sparc_cpu_set_pc(CPUSPARCState *env, vaddr value)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-
-    cpu->env.pc = value;
-    cpu->env.npc = value + 4;
+    env->pc = value;
+    env->npc = value + 4;
 }
 
-static vaddr sparc_cpu_get_pc(CPUState *cs)
+static vaddr sparc_cpu_get_pc(CPUSPARCState *env)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-
-    return cpu->env.pc;
+    return env->pc;
 }
 
 static void sparc_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 1a26171590..20de29d114 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -34,14 +34,14 @@ static const gchar *tricore_gdb_arch_name(CPUState *cs)
     return "tricore";
 }
 
-static void tricore_cpu_set_pc(CPUState *cs, vaddr value)
+static void tricore_cpu_set_pc(CPUTriCoreState *env, vaddr value)
 {
-    cpu_env(cs)->PC = value & ~(target_ulong)1;
+    env->PC = value & ~(target_ulong)1;
 }
 
-static vaddr tricore_cpu_get_pc(CPUState *cs)
+static vaddr tricore_cpu_get_pc(CPUTriCoreState *env)
 {
-    return cpu_env(cs)->PC;
+    return env->PC;
 }
 
 static void tricore_cpu_synchronize_from_tb(CPUState *cs,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 6f9039abae..3ab7b794f0 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -40,18 +40,14 @@
 #endif
 
 
-static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
+static void xtensa_cpu_set_pc(CPUXtensaState *env, vaddr value)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-
-    cpu->env.pc = value;
+    env->pc = value;
 }
 
-static vaddr xtensa_cpu_get_pc(CPUState *cs)
+static vaddr xtensa_cpu_get_pc(CPUXtensaState *env)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-
-    return cpu->env.pc;
+    return env->pc;
 }
 
 static void xtensa_restore_state_to_opc(CPUState *cs,
-- 
2.45.2



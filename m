Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C383D68BCA
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8t-0003Ma-5u; Fri, 15 Nov 2024 10:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8r-0003M7-To
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:49 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy8p-00049O-Df
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:49 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d533b5412so1349254f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684104; x=1732288904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKSZFc6XXY/YHJVgF3fFpq0PBmuORvG1PCcPSzgM2YQ=;
 b=XOXuMI4pbCwLBlXlUfxq2UGawbGOWUTUwi+gLTEzbbDisreoduUGQ3AqDWLzKf4HqP
 bAZd4LPctd1w9IEevRbGCG+WOatHO/gFC6fNwvnWyjDoTavU6pfxt5H1hvixCJuxXN8h
 9bJdmQ9+m+iJec8fOlchsWAuS1npzgQIIdfeZNq2adLsDmy/bdXdlU+GRi1NYyAW0miT
 JIw6Y1iJRQAiXcWiau0OYbF3ImniGLEwbLoYUbzi4nGw7AlELLN1S4QyGl5892gE0Tl3
 Yf2e6aN3BUJghxUK/kND4S0vp5iGZwg38CDVo6Lrgl/ZpqcPzeELd8Ny6U1PIkUoCRfN
 k6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684104; x=1732288904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKSZFc6XXY/YHJVgF3fFpq0PBmuORvG1PCcPSzgM2YQ=;
 b=o9KHbCTqNfQkNO66h7vhXoMyDx3OnwFCIFKaoNlzM1AURFcJ14KDJVFrLEGHNsWMG+
 AVPwV/0Ly9hSivY9n7ynp6UMjjXlDPVTCeTgSrPgVj9pkySFwR+sZXFeych5/ud8ad1Q
 5QYf4PWCHGSSSzCpeMH4oWgDPTMkvqtnOaiY3DNJ39BQwtmW/dnm7jxVvKoXXvRWOukU
 ckvRssnhD/wDX8++3SoDP14pn7tWH9V2pxHqeDq77oEy4ygB6JoJw6ysoXRN7HE3LcuR
 4NuKAkZdi/aDmSvP2mxkditxWEzglnmFd7/lSUqLy6NKdN6y3/cBFae4uJbIS6sB4LsK
 Wm2A==
X-Gm-Message-State: AOJu0YwnSZGq4RK076I4M5ff0V+ZU00ZEBsdF5ygb3+xFgbFrUsE4gx7
 /7pLYWeQWI8FRKNZmLArnhfC+LNFwXKaAu5YaEqcQhwUSnPwqUMII73JwjPA8qhdY7brvTz+oFE
 n
X-Google-Smtp-Source: AGHT+IE5jLYckOtGT81PzApi6Xg7I5yTHTU6LMGH27/t/RMWhO2vYEmXIl8SFLDzcoXAPnsZ9ksIhw==
X-Received: by 2002:a05:6000:710:b0:37d:4ebe:164f with SMTP id
 ffacd0b85a97d-38225a88ce3mr2573803f8f.46.1731684103895; 
 Fri, 15 Nov 2024 07:21:43 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adad994sm4575668f8f.38.2024.11.15.07.21.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/10] hw/core/cpu: Pass CPUArchState to
 restore_state_to_opc() handler
Date: Fri, 15 Nov 2024 16:20:52 +0100
Message-ID: <20241115152053.66442-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

CPUClass::restore_state_to_opc() handler is target specific.
Rather than passing a generic CPUState and forcing QOM casts,
we can directly pass the target CPUArchState, simplifying.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h  |  2 +-
 target/arm/internals.h         |  2 +-
 target/mips/tcg/tcg-internal.h |  2 +-
 target/s390x/s390x-internal.h  |  2 +-
 accel/tcg/translate-all.c      |  2 +-
 target/alpha/cpu.c             |  4 +---
 target/arm/cpu.c               |  4 +---
 target/avr/cpu.c               |  4 ++--
 target/hexagon/cpu.c           |  4 ++--
 target/hppa/cpu.c              |  4 +---
 target/i386/tcg/tcg-cpu.c      |  4 +---
 target/loongarch/cpu.c         |  4 ++--
 target/m68k/cpu.c              |  7 +++----
 target/microblaze/cpu.c        |  8 +++-----
 target/mips/tcg/translate.c    |  4 +---
 target/openrisc/cpu.c          | 10 ++++------
 target/ppc/cpu_init.c          |  6 ++----
 target/riscv/tcg/tcg-cpu.c     |  4 +---
 target/rx/cpu.c                |  6 ++----
 target/s390x/tcg/translate.c   |  3 +--
 target/sh4/cpu.c               |  8 +++-----
 target/sparc/cpu.c             |  3 +--
 target/tricore/cpu.c           |  4 ++--
 target/xtensa/cpu.c            |  6 ++----
 24 files changed, 40 insertions(+), 67 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 663efb9133..a15ff36dd7 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -44,7 +44,7 @@ struct TCGCPUOps {
      * state which are tracked insn-by-insn in the target-specific
      * arguments to start_insn, passed as @data.
      */
-    void (*restore_state_to_opc)(CPUState *cpu, const TranslationBlock *tb,
+    void (*restore_state_to_opc)(CPUArchState *env, const TranslationBlock *tb,
                                  const uint64_t *data);
 
     /** @cpu_exec_enter: Callback for cpu_exec preparation */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e37f459af3..b7b15800e8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -362,7 +362,7 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu);
 void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *,
                                        GPtrArray *, GPtrArray *);
 
-void arm_restore_state_to_opc(CPUState *cs,
+void arm_restore_state_to_opc(CPUARMState *env,
                               const TranslationBlock *tb,
                               const uint64_t *data);
 
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index aef032c48d..79d39801a6 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -21,7 +21,7 @@ void mips_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 G_NORETURN void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                              MMUAccessType access_type, int mmu_idx,
                                              uintptr_t retaddr);
-void mips_restore_state_to_opc(CPUState *cs,
+void mips_restore_state_to_opc(CPUMIPSState *env,
                                const TranslationBlock *tb,
                                const uint64_t *data);
 
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 825252d728..891e5f576c 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -399,7 +399,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
 
 /* translate.c */
 void s390x_translate_init(void);
-void s390x_restore_state_to_opc(CPUState *cs,
+void s390x_restore_state_to_opc(CPUS390XState *env,
                                 const TranslationBlock *tb,
                                 const uint64_t *data);
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 375100b483..264bc968e7 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -218,7 +218,7 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
         cpu->neg.icount_decr.u16.low += insns_left;
     }
 
-    cpu->cc->tcg_ops->restore_state_to_opc(cpu, tb, data);
+    cpu->cc->tcg_ops->restore_state_to_opc(cpu_env(cpu), tb, data);
 }
 
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc)
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index dce7a3ea5d..2b55bb0bd9 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -47,12 +47,10 @@ static void alpha_cpu_synchronize_from_tb(CPUState *cs,
     }
 }
 
-static void alpha_restore_state_to_opc(CPUState *cs,
+static void alpha_restore_state_to_opc(CPUAlphaState *env,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
 {
-    CPUAlphaState *env = cpu_env(cs);
-
     if (tb_cflags(tb) & CF_PCREL) {
         env->pc = (env->pc & TARGET_PAGE_MASK) | data[0];
     } else {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b7cf084019..c8e032d433 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -90,12 +90,10 @@ void arm_cpu_synchronize_from_tb(CPUState *cs,
     }
 }
 
-void arm_restore_state_to_opc(CPUState *cs,
+void arm_restore_state_to_opc(CPUARMState *env,
                               const TranslationBlock *tb,
                               const uint64_t *data)
 {
-    CPUARMState *env = cpu_env(cs);
-
     if (is_a64(env)) {
         if (tb_cflags(tb) & CF_PCREL) {
             env->pc = (env->pc & TARGET_PAGE_MASK) | data[0];
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index e85e54feb8..19b6298a31 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -55,11 +55,11 @@ static void avr_cpu_synchronize_from_tb(CPUState *cs,
     cpu_env(cs)->pc_w = tb->pc / 2; /* internally PC points to words */
 }
 
-static void avr_restore_state_to_opc(CPUState *cs,
+static void avr_restore_state_to_opc(CPUAVRState *env,
                                      const TranslationBlock *tb,
                                      const uint64_t *data)
 {
-    cpu_env(cs)->pc_w = data[0];
+    env->pc_w = data[0];
 }
 
 static void avr_cpu_reset_hold(Object *obj, ResetType type)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 828b7d1df3..8038df1c82 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -267,11 +267,11 @@ static bool hexagon_cpu_has_work(CPUState *cs)
     return true;
 }
 
-static void hexagon_restore_state_to_opc(CPUState *cs,
+static void hexagon_restore_state_to_opc(CPUHexagonState *env,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
 {
-    cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
+    env->gpr[HEX_REG_PC] = data[0];
 }
 
 static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index d73a88b279..ff937c8171 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -101,12 +101,10 @@ static void hppa_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.psw_xb = tb->flags & (PSW_X | PSW_B);
 }
 
-static void hppa_restore_state_to_opc(CPUState *cs,
+static void hppa_restore_state_to_opc(CPUHPPAState *env,
                                       const TranslationBlock *tb,
                                       const uint64_t *data)
 {
-    CPUHPPAState *env = cpu_env(cs);
-
     env->iaoq_f = (env->iaoq_f & TARGET_PAGE_MASK) | data[0];
     if (data[1] != INT32_MIN) {
         env->iaoq_b = env->iaoq_f + data[1];
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index cca19cd40e..6e624710f5 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -61,12 +61,10 @@ static void x86_cpu_synchronize_from_tb(CPUState *cs,
     }
 }
 
-static void x86_restore_state_to_opc(CPUState *cs,
+static void x86_restore_state_to_opc(CPUX86State *env,
                                      const TranslationBlock *tb,
                                      const uint64_t *data)
 {
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
     int cc_op = data[1];
     uint64_t new_pc;
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index add7323f05..6962f4b6de 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -340,11 +340,11 @@ static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
     set_pc(cpu_env(cs), tb->pc);
 }
 
-static void loongarch_restore_state_to_opc(CPUState *cs,
+static void loongarch_restore_state_to_opc(CPULoongArchState *env,
                                            const TranslationBlock *tb,
                                            const uint64_t *data)
 {
-    set_pc(cpu_env(cs), data[0]);
+    set_pc(env, data[0]);
 }
 #endif /* CONFIG_TCG */
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 39bf6f3d90..fc923dcf83 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -34,16 +34,15 @@ static vaddr m68k_cpu_get_pc(CPUM68KState *env)
     return env->pc;
 }
 
-static void m68k_restore_state_to_opc(CPUState *cs,
+static void m68k_restore_state_to_opc(CPUM68KState *env,
                                       const TranslationBlock *tb,
                                       const uint64_t *data)
 {
-    M68kCPU *cpu = M68K_CPU(cs);
     int cc_op = data[1];
 
-    cpu->env.pc = data[0];
+    env->pc = data[0];
     if (cc_op != CC_OP_DYNAMIC) {
-        cpu->env.cc_op = cc_op;
+        env->cc_op = cc_op;
     }
 }
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 3e68c73898..c2cfecd78f 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -100,14 +100,12 @@ static void mb_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.iflags = tb->flags & IFLAGS_TB_MASK;
 }
 
-static void mb_restore_state_to_opc(CPUState *cs,
+static void mb_restore_state_to_opc(CPUMBState *env,
                                     const TranslationBlock *tb,
                                     const uint64_t *data)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-
-    cpu->env.pc = data[0];
-    cpu->env.iflags = data[1];
+    env->pc = data[0];
+    env->iflags = data[1];
 }
 
 static bool mb_cpu_has_work(CPUState *cs)
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index de7045874d..7a6fedb758 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15302,12 +15302,10 @@ void mips_tcg_init(void)
     }
 }
 
-void mips_restore_state_to_opc(CPUState *cs,
+void mips_restore_state_to_opc(CPUMIPSState *env,
                                const TranslationBlock *tb,
                                const uint64_t *data)
 {
-    CPUMIPSState *env = cpu_env(cs);
-
     env->active_tc.PC = data[0];
     env->hflags &= ~MIPS_HFLAG_BMASK;
     env->hflags |= data[1];
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 51ab0df82b..5601465789 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -45,16 +45,14 @@ static void openrisc_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.pc = tb->pc;
 }
 
-static void openrisc_restore_state_to_opc(CPUState *cs,
+static void openrisc_restore_state_to_opc(CPUOpenRISCState *env,
                                           const TranslationBlock *tb,
                                           const uint64_t *data)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-
-    cpu->env.pc = data[0];
-    cpu->env.dflag = data[1] & 1;
+    env->pc = data[0];
+    env->dflag = data[1] & 1;
     if (data[1] & 2) {
-        cpu->env.ppc = cpu->env.pc - 4;
+        env->ppc = env->pc - 4;
     }
 }
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c8b4445aea..95bf78a3b7 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7163,13 +7163,11 @@ static vaddr ppc_cpu_get_pc(CPUPPCState *env)
 }
 
 #ifdef CONFIG_TCG
-static void ppc_restore_state_to_opc(CPUState *cs,
+static void ppc_restore_state_to_opc(CPUPPCState *env,
                                      const TranslationBlock *tb,
                                      const uint64_t *data)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-
-    cpu->env.nip = data[0];
+    env->nip = data[0];
 }
 #endif /* CONFIG_TCG */
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c221696..82689f06c4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -108,12 +108,10 @@ static void riscv_cpu_synchronize_from_tb(CPUState *cs,
     }
 }
 
-static void riscv_restore_state_to_opc(CPUState *cs,
+static void riscv_restore_state_to_opc(CPURISCVState *env,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
     RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
     target_ulong pc;
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 0c4b63b114..0f24893f86 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -46,13 +46,11 @@ static void rx_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.pc = tb->pc;
 }
 
-static void rx_restore_state_to_opc(CPUState *cs,
+static void rx_restore_state_to_opc(CPURXState *env,
                                     const TranslationBlock *tb,
                                     const uint64_t *data)
 {
-    RXCPU *cpu = RX_CPU(cs);
-
-    cpu->env.pc = data[0];
+    env->pc = data[0];
 }
 
 static bool rx_cpu_has_work(CPUState *cs)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index bcfff40b25..182be8b3ca 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6488,11 +6488,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
     translator_loop(cs, tb, max_insns, pc, host_pc, &s390x_tr_ops, &dc.base);
 }
 
-void s390x_restore_state_to_opc(CPUState *cs,
+void s390x_restore_state_to_opc(CPUS390XState *env,
                                 const TranslationBlock *tb,
                                 const uint64_t *data)
 {
-    CPUS390XState *env = cpu_env(cs);
     int cc_op = data[1];
 
     env->psw.addr = data[0];
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 5c6840841b..c378d0ec83 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -48,14 +48,12 @@ static void superh_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.flags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
 }
 
-static void superh_restore_state_to_opc(CPUState *cs,
+static void superh_restore_state_to_opc(CPUSH4State *env,
                                         const TranslationBlock *tb,
                                         const uint64_t *data)
 {
-    SuperHCPU *cpu = SUPERH_CPU(cs);
-
-    cpu->env.pc = data[0];
-    cpu->env.flags = data[1];
+    env->pc = data[0];
+    env->flags = data[1];
     /*
      * Theoretically delayed_pc should also be restored. In practice the
      * branch instruction is re-executed after exception, so the delayed
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e1f0dfcbbd..83c86c03bd 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -709,11 +709,10 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs,
     cpu->env.npc = tb->cs_base;
 }
 
-static void sparc_restore_state_to_opc(CPUState *cs,
+static void sparc_restore_state_to_opc(CPUSPARCState *env,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
 {
-    CPUSPARCState *env = cpu_env(cs);
     target_ulong pc = data[0];
     target_ulong npc = data[1];
 
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 20de29d114..f8a5bb8979 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -51,11 +51,11 @@ static void tricore_cpu_synchronize_from_tb(CPUState *cs,
     cpu_env(cs)->PC = tb->pc;
 }
 
-static void tricore_restore_state_to_opc(CPUState *cs,
+static void tricore_restore_state_to_opc(CPUTriCoreState *env,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
 {
-    cpu_env(cs)->PC = data[0];
+    env->PC = data[0];
 }
 
 static void tricore_cpu_reset_hold(Object *obj, ResetType type)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 3ab7b794f0..8ba8280ae9 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -50,13 +50,11 @@ static vaddr xtensa_cpu_get_pc(CPUXtensaState *env)
     return env->pc;
 }
 
-static void xtensa_restore_state_to_opc(CPUState *cs,
+static void xtensa_restore_state_to_opc(CPUXtensaState *env,
                                         const TranslationBlock *tb,
                                         const uint64_t *data)
 {
-    XtensaCPU *cpu = XTENSA_CPU(cs);
-
-    cpu->env.pc = data[0];
+    env->pc = data[0];
 }
 
 static bool xtensa_cpu_has_work(CPUState *cs)
-- 
2.45.2



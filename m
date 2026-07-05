Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475A5C44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEdy-00007y-OK; Sun, 05 Jul 2026 00:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEca-0005MX-92
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcG-0004MJ-TO
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2caf228a910so9151215ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226273; x=1783831073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L4Et02iXLolDcnUpVHlQ88k2IUsnj56a3UOUPvkHqDs=;
 b=BjgC7MFzURNxsrLEk0Z+odvkR0Ik4MF7Fip5TvfppYrqOcjpF2Dgg//nh0ZOCUZLZR
 J6LGC2FYdsBLF3XFRnpqOIZdMd/dpgQDu5aIri5pIrUskUVVqIQvc/yrrxwuHO3r4buF
 3LGQRq+gLNEp604BkUYS6z9WiUIq5of+q2vYHSmaHDdf3WE9qPFHmu0u7pC7fUYjXkjf
 tutG9dNYUMw4qBMAEbAVMqNI9m9+TZVzFGhqQVYpTgd5KCjCdWd9/q30tdr95bEBkIyu
 Wi3RWucZxJS9/Jk2Jxny8eV//w7shtAJw4RUxt4TQJPb3Be768Ey7rKn/1/WvL+dPReh
 NzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226273; x=1783831073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L4Et02iXLolDcnUpVHlQ88k2IUsnj56a3UOUPvkHqDs=;
 b=rBxmUofS/JV1DnbiB37KfuSi0Rl8QpRkkdFXoRJQoCHyrng1Lk7F2L4nM9OX+vS9Ki
 pWVjNH2DLEBdPW3+vqNBf3kb4L++TXKrcF0ElejFWJLIlCUrqFePRFUsyUAnJNIrLeB5
 WV7hsjcfI9RaV4cnJCkj+vvVkPK1L2Znlf4QGhboEgrdFeUlNqfBfAmIQ/xy2n7t5xZC
 8CdmpEHshWl0NiaQDiZv5wSFYoeeeJPj9VitxpsZdkdsgfwJtkE7hgQ2GTyLXIGOnPmj
 RbbWL+A1Ztj8FQYkkV9lQbezn4MqzoSAjztjWDUM/N1YEC/ij/Dig9J8rOzOi/g7fVaU
 mXFg==
X-Gm-Message-State: AOJu0YzDPvDfXtN6l+o3k6S+w2HjZUVCD2g9QZ2uzBZrN3XkLR54n3yP
 2g6YtU5+JapmHAwPz3vT+A8d0EUA3dbpuxPSfUzaZGH0OIJeZPgOsoNchCxrW5qQEQlvd3MEsUt
 ns60g
X-Gm-Gg: AfdE7cnJ7WCLTSc8byR33X6VmFIGEdFk/ef+GMGLeMfjn9l9GQ9FxLuU6nAgBq/NH5k
 tHNkDxiFirr54q/qMc4RxODMr2aH1pcQGEC039lX7Uyx2TfZESD4TixgSK9QkDogVl7SgEpFczv
 D7kZy4ZjoOvAkxNUFHVyjQYBne8DeM2izWgNNaYTQkz+btpVR4SOod8eSK4FVIANRf5NN/Hf5Zd
 iPUoc75bjp0Z1NRAgDXqqDrrmmVgeUf6vBhB9sktAh7MYVIKEqZtdi05uy81HyydY+3sbI4yc7J
 L/OxXtbL3Se2T5MHWziwN92Uc5tbqLYwpyrZWrwokzzJWzPhLI3uMUrps/yQdEzFOYa6v1vUjon
 MLNP+O0LIlOKQqAb8YdUImfZB3/Tr9Ss9YWiHvFIdvYklIU3pGu7FbOz9jRZuaAEm0FKV9yIBaC
 /mRCdCJNaBxYUQ5QHTW8fTetPJGLoj9DvjFNNkqiRvazwpW+w=
X-Received: by 2002:a17:902:ccd2:b0:2ca:a284:a136 with SMTP id
 d9443c01a7336-2cbb9f03982mr50899715ad.42.1783226272494; 
 Sat, 04 Jul 2026 21:37:52 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 30/46] accel/tcg: Pass watchpoint hit to debug_excp_handler
Date: Sat,  4 Jul 2026 21:37:09 -0700
Message-ID: <20260705043725.1373137-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allow the breakpoint/watchpoint causing the exception
to be passed to the target hook.  Unused so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h         | 2 +-
 target/arm/internals.h              | 2 +-
 target/i386/tcg/helper-tcg.h        | 2 +-
 target/ppc/internal.h               | 2 +-
 target/riscv/debug.h                | 2 +-
 target/s390x/tcg/tcg_s390x.h        | 2 +-
 target/xtensa/cpu.h                 | 2 +-
 accel/tcg/cpu-exec.c                | 2 +-
 target/arm/tcg/debug.c              | 2 +-
 target/i386/tcg/system/bpt_helper.c | 2 +-
 target/ppc/tcg-excp_helper.c        | 2 +-
 target/riscv/debug.c                | 2 +-
 target/s390x/tcg/debug.c            | 2 +-
 target/xtensa/helper.c              | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 2dde42cf29..734bcd537b 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -99,7 +99,7 @@ struct TCGCPUOps {
     /** @cpu_exec_exit: Callback for cpu_exec cleanup */
     void (*cpu_exec_exit)(CPUState *cpu);
     /** @debug_excp_handler: Callback for handling debug exceptions */
-    void (*debug_excp_handler)(CPUState *cpu);
+    void (*debug_excp_handler)(CPUState *cpu, CPUBreakpoint *hit);
 
     /** @mmu_index: Callback for choosing softmmu mmu index */
     int (*mmu_index)(CPUState *cpu, bool ifetch);
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5ef31aea50..51804963f9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -691,7 +691,7 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp);
 vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
 
 /* Callback function for when a watchpoint or breakpoint triggers. */
-void arm_debug_excp_handler(CPUState *cs);
+void arm_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit);
 
 #if defined(CONFIG_USER_ONLY) || !defined(CONFIG_TCG)
 static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index f4b2ff740d..01f4a8bcd0 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -42,7 +42,7 @@ bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
 
-void breakpoint_handler(CPUState *cs);
+void breakpoint_handler(CPUState *cs, CPUBreakpoint *hit);
 
 /* n must be a constant to be efficient */
 static inline target_long lshift(target_long x, int n)
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 80f4195378..5d7346a03d 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -303,7 +303,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    MMUAccessType access_type,
                                    int mmu_idx, MemTxAttrs attrs,
                                    MemTxResult response, uintptr_t retaddr);
-void ppc_cpu_debug_excp_handler(CPUState *cs);
+void ppc_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit);
 bool ppc_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp);
 
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f5234ff763..540835f2d0 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -143,7 +143,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val);
 
 target_ulong tinfo_csr_read(CPURISCVState *env);
 
-void riscv_cpu_debug_excp_handler(CPUState *cs);
+void riscv_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit);
 bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp);
 
diff --git a/target/s390x/tcg/tcg_s390x.h b/target/s390x/tcg/tcg_s390x.h
index 975f60085a..61db0c0b53 100644
--- a/target/s390x/tcg/tcg_s390x.h
+++ b/target/s390x/tcg/tcg_s390x.h
@@ -26,7 +26,7 @@ G_NORETURN void tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
 
 #ifndef CONFIG_USER_ONLY
 void s390_cpu_recompute_watchpoints(CPUState *cs);
-void s390x_cpu_debug_excp_handler(CPUState *cs);
+void s390x_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit);
 #endif
 
 #endif /* TCG_S390X_H */
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index c256ab3cc8..663ee23dc4 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -621,7 +621,7 @@ void xtensa_translate_init(void);
 void xtensa_translate_code(CPUState *cs, TranslationBlock *tb,
                            int *max_insns, vaddr pc, void *host_pc);
 void **xtensa_get_regfile_by_name(const char *name, int entries, int bits);
-void xtensa_breakpoint_handler(CPUState *cs);
+void xtensa_breakpoint_handler(CPUState *cs, CPUBreakpoint *hit);
 void xtensa_register_core(XtensaConfigList *node);
 void xtensa_sim_open_console(Chardev *chr);
 void check_interrupts(CPUXtensaState *s);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c4ee6afe13..cca403ad62 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -693,7 +693,7 @@ static inline void cpu_handle_debug_exception(CPUState *cpu)
     }
 
     if (tcg_ops->debug_excp_handler) {
-        tcg_ops->debug_excp_handler(cpu);
+        tcg_ops->debug_excp_handler(cpu, cpu->watchpoint_hit);
     }
 }
 
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 293907fdaf..fe8513a5de 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -414,7 +414,7 @@ static uint32_t arm_debug_exception_fsr(CPUARMState *env)
     }
 }
 
-void arm_debug_excp_handler(CPUState *cs)
+void arm_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
 {
     /*
      * Called by core code when a watchpoint or breakpoint fires;
diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
index c0c63e3e89..8ba5dfcfc1 100644
--- a/target/i386/tcg/system/bpt_helper.c
+++ b/target/i386/tcg/system/bpt_helper.c
@@ -202,7 +202,7 @@ bool check_hw_breakpoints(CPUX86State *env, bool force_dr6_update)
     return hit_enabled;
 }
 
-void breakpoint_handler(CPUState *cs)
+void breakpoint_handler(CPUState *cs, CPUBreakpoint *hit)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 12785dc161..51358c901f 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -309,7 +309,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void ppc_cpu_debug_excp_handler(CPUState *cs)
+void ppc_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
 {
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 958c534f4f..a8429778f6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -914,7 +914,7 @@ target_ulong tinfo_csr_read(CPURISCVState *env)
            BIT(TRIGGER_TYPE_AD_MATCH6);
 }
 
-void riscv_cpu_debug_excp_handler(CPUState *cs)
+void riscv_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index 9e724bb262..58d9cc6e79 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -49,7 +49,7 @@ void s390_cpu_recompute_watchpoints(CPUState *cs)
     }
 }
 
-void s390x_cpu_debug_excp_handler(CPUState *cs)
+void s390x_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
 {
     CPUS390XState *env = cpu_env(cs);
     CPUBreakpoint *wp_hit = cs->watchpoint_hit;
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 0db5502287..02627ada7c 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -219,7 +219,7 @@ static uint32_t check_hw_breakpoints(CPUXtensaState *env)
     return 0;
 }
 
-void xtensa_breakpoint_handler(CPUState *cs)
+void xtensa_breakpoint_handler(CPUState *cs, CPUBreakpoint *hit)
 {
     CPUXtensaState *env = cpu_env(cs);
 
-- 
2.43.0



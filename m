Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F49C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIGa-0003tV-Aa; Fri, 10 Jul 2026 16:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFP-00021n-Ix
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:59 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIF8-0000uH-Mw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:59 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-848595b338cso1566738b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716871; x=1784321671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bmhsTGQCtR7WnIwNmB8y86zKxj40+R+s322AEH4j5lE=;
 b=s9GqOZt80qWp86U0LOzFtEhyQ84vj6FkQpBX9taEksF6rKW9YmcCk7RbSwmm9lRpnb
 v3PkGnfPUCjIQTMPurETxmenj72MhjjHFgwU2Pl75TjoibAGl0LxYlZCo+yEm/fj4s9q
 o8TQ3UFVSXV8a3SRpNZmi3RxKs1Ekesks3YFVLx5sJqocdscgxbFbShUDPIxxbJunJcf
 +pGoyZNJMPnVUQ7jVAigqpD5vN6MuP7zpO3jKb/USi10byBXkWgVzoRVEWzWmCW2HMV+
 x33ibdQ/puoK5FB87dTpklg1mq7Yp3y+5l84JGzMf9RlmNfmVgFDVxhInoCth1pXw5tf
 X0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716871; x=1784321671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bmhsTGQCtR7WnIwNmB8y86zKxj40+R+s322AEH4j5lE=;
 b=kPSM1YomYsLW/ehZwjm8Qy8pDmLUNyB4U2pdwq028mqn3Gd22w5/2MdQFa1Qbj0/wJ
 5aVChQCns0nZz63bVJaNz7WklCYLZ2NFwe5yYx23ztKUMQFeqRAIJi1O6tbH6w7zj/7g
 DJvGAYFdIlg1PT/efzZFHIRrdm5wN6ka076yvsP4bgOfqWplt0Eh0H6ZdJtoclSya2m4
 JHymiClYr7SavL5hbvpKyLr9h/Pvc0Vxt10YAF1Up88vVCEc/+3MRalgMBuRE0SY0fQS
 TU+WegGsqUVEkDyHICTq+JG2n4NZTtWZfEuZecqbx/QgNbaT1NmLxxWJSpH76u31CHFG
 T1JA==
X-Gm-Message-State: AOJu0YwA2Yl2RxO0Gd3kM2X7zHV8BTqtknPlyFxBwtR2KJ+93FxQMz5X
 eEGaUzttvJusZSM5/DxO0rB6N2KLvePAjqSe7b4kaucLxrTbpr1GSoanTr70GNXpkwD4SyUjl7M
 UOpvS
X-Gm-Gg: AfdE7ckJEhcuhCIzgDERBLisnxXP10rSZgmqK+10MYqbDqGU7M6Ohyofh48iI9mn6Xh
 oo3K9XdVYs7d6MZg2qjGVvSwkbSgRQnt9g0VqbyyP0cj5pHwlderDedHAwmIocyOeX4PDceiOQs
 70w0/hmVlT99ol+SxiuCpz7HBiRZcmC4lA8PN9jTyHzm+aRzYtoqb4hBzdPTMwvDZltLxgzCVQ4
 Xj7Yx9dFhRRCQpr9+qu5feDXtVZh+TkZeOP4B9xVLTkwKw9F5/iIyywpjvLpm6cIGgsygMMtoA9
 +bsyWuyhih7n9JaSd8X+ugXZtwr14E/zE99K2SmT7Pkf1iRjuFuI6P9ig9naMemQ6twjX2uXB0H
 +HE/n4RPH9iuzbYc6WL5zEQZC1guhb0bT/1dBbcEYoxdQQUSs4amiFnAmiRqc4dMBUZq31HxiG2
 KiAJU0NwdJO+DCs9yIOA==
X-Received: by 2002:a05:6a00:2d1f:b0:848:590a:4c90 with SMTP id
 d2e1a72fcca58-84889797bdamr465210b3a.59.1783716871178; 
 Fri, 10 Jul 2026 13:54:31 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 26/51] accel/tcg: Pass watchpoint hit to debug_excp_handler
Date: Fri, 10 Jul 2026 13:53:36 -0700
Message-ID: <20260710205401.836304-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index 9d022245a2..9deb7a6e22 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -700,7 +700,7 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp);
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
index 86ce902c34..3205f365e5 100644
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



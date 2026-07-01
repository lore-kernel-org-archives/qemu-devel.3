Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54D6C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welFw-0005gu-F7; Tue, 30 Jun 2026 23:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFr-0005fi-QQ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFn-0002n8-W9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c99672293cso995045ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875086; x=1783479886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxQz3A5cSSHlQV/FJFFLwzuhdIbJxyset0vnu8TQPN0=;
 b=boqij1oDtr5aeBat0kEu2rvZrVLcatX3oLPUpOSgxcPhypF0U6tjzq08U4hVtq2zKd
 +Mvhf/W8/7lCKsK2ry8sKVTgEq7/KZA5+pUkPFEJSKuYVgLxTCVgUVVgrKE7cA5Y3exM
 UntB34cFFjnmt2ZoCZv/EFQKj58mv6vsqqYfHe1ONubE3pFfY8+v201OC59yAWFjBAGY
 M0ipMhvuvYHETzZGO3OGwnwd1Yr7DVdNDo/m2oSBGOgJH3LNxWTVqB0A24oiq+NBnkp1
 4TX5lFXlIOhVPBRf2od+fPXpF2cJ1wo4Vkp+t3EFmK67nzIKDE1dsKbmOA2AzBAM582j
 zryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875086; x=1783479886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zxQz3A5cSSHlQV/FJFFLwzuhdIbJxyset0vnu8TQPN0=;
 b=p89fetzQBpK17F9kFLhgVL0c+2lTPeIJjmAcN5aqOgNTNgsISE4vMDnH5HhD25wZoN
 5pcEKTAthHH9VNTN5/QS/1tfpmbCMJJDsT5sWhy/8YdmQAqZzz8c72iX24IZ7Qf2/HSw
 SadCMLCzcKuFJP3zDUFeSTJLhlr8PTMFiZIqqpo+pTnglgB+/c72WTMEpynFD6i2lkZo
 aYP55SWgm/vf01QlqPAQT30+pJkS5Kh0zMSwr+5pZ2PaxRK5ZEU8KDdIKJHxCdEi5MJd
 PrpmpUXzzx+AFNvvQhyNLHsc799aN6W7f2Nb0vz/EPy7fQT7IsQ8cdAYwIN+503doI1K
 hNoQ==
X-Gm-Message-State: AOJu0YwBCjb6h1Y1su5rAB0KCcbkKfVfekw4hSZOfSn+weYi4ogO43iM
 UMaTWFLV+ins4KtBEv9Z+WlZFiieS2QHGOLccue9C84ltv7Xj6RN3ZQRf5a0mNTF31SHwVW361B
 q81W8
X-Gm-Gg: AfdE7cmudX2YhynOZxtYrSIS1LpawwWof5fBw4s06/9ZtTtitdhUTWu1dPK2ZHnOBdX
 3VK8EU0fyzbpROI41qmHFl7iJz71ZXD8NrbImPZhpJeFNjropJ4z56KbdDH2UVsCtxs3T49qxOn
 EzW35GjifTkEZs527JTkAgqWV/qt5pMu40xs/igoPt4TZpMTKA7ipGxsvjeSkRIO/apOYV9JA7s
 mHtN8FYz4gxu7aFF1xnVe8vpLDs9ewvYUezCIE6XGYf5F+7RiJ5np2INLzz7UVROwlMj1L0wzLD
 yrt1eQkhpu92z43o/JK28wdbksq/VAbdPpGnKPJ3SEsBtUR1+KzxcTdicxrwg1rTCT/40xVZw8p
 5z6U+g4IkZeeoI/Vfsxl+FOkklwrSBHsSb+6ewkzXUJfcuq7pYeyq5Juxot9Nk/gLDa9FuSW9cg
 6g0A5PRSeLDR+5kMG4RHZj7apH3E4Kx8nZ6cFQhjDCGxwAdBptCg==
X-Received: by 2002:a17:902:ef09:b0:2c9:ae0b:61e3 with SMTP id
 d9443c01a7336-2ca5a52fceemr27719335ad.2.1782875086020; 
 Tue, 30 Jun 2026 20:04:46 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 01/17] accel/tcg: Pass CPUBreakpoint to debug_check_breakpoint
Date: Tue, 30 Jun 2026 20:04:27 -0700
Message-ID: <20260701030443.1382447-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For 3 of the 4 targets that use this hook, add the argument
and ignore it so far.  For riscv, drop the loop over all
breakpoints and use the new argument.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h  |  2 +-
 target/arm/internals.h       |  2 +-
 target/ppc/internal.h        |  2 +-
 target/riscv/debug.h         |  2 +-
 target/xtensa/cpu.h          |  2 +-
 accel/tcg/cpu-exec.c         |  2 +-
 target/arm/tcg/debug.c       |  2 +-
 target/i386/tcg/tcg-cpu.c    |  2 +-
 target/ppc/tcg-excp_helper.c |  2 +-
 target/riscv/debug.c         | 55 +++++++++++++++++-------------------
 target/xtensa/dbg_helper.c   |  2 +-
 11 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 710da12b82..d2b9079835 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -265,7 +265,7 @@ struct TCGCPUOps {
      * @debug_check_breakpoint: return true if the architectural
      * breakpoint whose PC has matched should really fire.
      */
-    bool (*debug_check_breakpoint)(CPUState *cpu);
+    bool (*debug_check_breakpoint)(CPUState *cpu, const CPUBreakpoint *bp);
 
     /**
      * @io_recompile_replay_branch: Callback for cpu_io_recompile.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fcce3804f3..c78c86a1fc 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -680,7 +680,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n);
 void hw_breakpoint_update_all(ARMCPU *cpu);
 
 /* Callback function for checking if a breakpoint should trigger. */
-bool arm_debug_check_breakpoint(CPUState *cs);
+bool arm_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp);
 
 /* Callback function for checking if a watchpoint should trigger. */
 bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a3bb12afd9..f3e694c4cd 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -304,7 +304,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    int mmu_idx, MemTxAttrs attrs,
                                    MemTxResult response, uintptr_t retaddr);
 void ppc_cpu_debug_excp_handler(CPUState *cs);
-bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
+bool ppc_cpu_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 55a3ac72e6..91690404df 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -144,7 +144,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val);
 target_ulong tinfo_csr_read(CPURISCVState *env);
 
 void riscv_cpu_debug_excp_handler(CPUState *cs);
-bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
+bool riscv_cpu_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp);
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 void riscv_trigger_realize(CPURISCVState *env);
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 442e98bd1b..9323f45e4b 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -591,7 +591,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       int mmu_idx, MemTxAttrs attrs,
                                       MemTxResult response, uintptr_t retaddr);
 hwaddr xtensa_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-bool xtensa_debug_check_breakpoint(CPUState *cs);
+bool xtensa_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp);
 #endif
 void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void xtensa_count_regs(const XtensaConfig *config,
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9c754b0365..66ec656861 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -328,7 +328,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
 #else
                 const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
                 assert(tcg_ops->debug_check_breakpoint);
-                match_bp = tcg_ops->debug_check_breakpoint(cpu);
+                match_bp = tcg_ops->debug_check_breakpoint(cpu, bp);
 #endif
             }
 
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 07a52643e7..565af7b985 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -373,7 +373,7 @@ static bool check_watchpoints(ARMCPU *cpu)
     return false;
 }
 
-bool arm_debug_check_breakpoint(CPUState *cs)
+bool arm_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b..ee534f0a15 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -132,7 +132,7 @@ static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool x86_debug_check_breakpoint(CPUState *cs)
+static bool x86_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index b04f07a637..7715cae342 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -331,7 +331,7 @@ void ppc_cpu_debug_excp_handler(CPUState *cs)
 #endif
 }
 
-bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
+bool ppc_cpu_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp)
 {
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 30d39ee5cd..1acec77caa 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -939,47 +939,44 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
     }
 }
 
-bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
+bool riscv_cpu_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    CPUBreakpoint *bp;
     target_ulong ctrl;
     target_ulong pc;
     int trigger_type;
     int i;
 
-    QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-        for (i = 0; i < RV_MAX_TRIGGERS; i++) {
-            trigger_type = get_trigger_type(env, i);
+    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+        trigger_type = get_trigger_type(env, i);
 
-            if (!trigger_common_match(env, trigger_type, i)) {
-                continue;
+        if (!trigger_common_match(env, trigger_type, i)) {
+            continue;
+        }
+
+        switch (trigger_type) {
+        case TRIGGER_TYPE_AD_MATCH:
+            ctrl = env->tdata1[i];
+            pc = env->tdata2[i];
+
+            if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
+                env->badaddr = pc;
+                return true;
             }
+            break;
+        case TRIGGER_TYPE_AD_MATCH6:
+            ctrl = env->tdata1[i];
+            pc = env->tdata2[i];
 
-            switch (trigger_type) {
-            case TRIGGER_TYPE_AD_MATCH:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
-
-                if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
-                }
-                break;
-            case TRIGGER_TYPE_AD_MATCH6:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
-
-                if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
-                }
-                break;
-            default:
-                /* other trigger types are not supported or irrelevant */
-                break;
+            if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
+                env->badaddr = pc;
+                return true;
             }
+            break;
+        default:
+            /* other trigger types are not supported or irrelevant */
+            break;
         }
     }
 
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 3b91f7c38a..3d1143ad5e 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -64,7 +64,7 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
     env->sregs[IBREAKA + i] = v;
 }
 
-bool xtensa_debug_check_breakpoint(CPUState *cs)
+bool xtensa_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp)
 {
     CPUXtensaState *env = cpu_env(cs);
     unsigned int i;
-- 
2.43.0



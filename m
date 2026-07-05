Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659DCC44502
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEcx-00062Q-Sa; Sun, 05 Jul 2026 00:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc4-0004rf-9D
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbr-00047k-Ho
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:51 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cae134bdc8so8703525ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226258; x=1783831058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pSHmPBg36l6D2QIL/M1qutRoTdoTNtzz/aXqVPUCxo=;
 b=MOgtWE7PLdQV+W90ekBqQIgXiFAv8GQyHOvQLzn/ehJ3g9io0UFnTzfKW5erTyUrAP
 xR3owdPrYCTNDZv8glZ5Gaere7d0WzIG/p2bKZ4dIYVns1Zf5PcpeaEuAxoOTx2a6Crr
 mA4NABLKsr4eWxz5IbR5aYhIarSc+/Xq2E2Gci0S1kfnrzzOiH6/4L72fAyLMgKjxGsN
 ZGPSGRLed5gaNLii/GxfU9jqZEUa9x8j+ld5MQ7nsUh1XBCqNq9vA3l9JbRIr499BFyQ
 +dc91VXW39dtI5CWg7zRB9Y2cC71bJyqAb56b2PsFhmnKCWd+hIn7D0h8/YPImuucebA
 W6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226258; x=1783831058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2pSHmPBg36l6D2QIL/M1qutRoTdoTNtzz/aXqVPUCxo=;
 b=Jrg+ty16YC63VlwblV05xjAY2SQJ7iklx7crf6Cxl05iVKr1oM5hsF1x3WV3xodM/z
 HKMuTiPiIkoj1eTSuaNl7B9CuCiv4RUCeduiSU+5wd16PFdRCKg+qekLXcDyFJxUa476
 BQwPEaaaiwRTWENZJB9vRTMzyFaKX4iKnaClGdjc4KQDC2JUNZMfbgUxcSvOncT3mw/E
 Yxs1J+daAsPrOFUP7nRHHUj6CzhJc8m9S9BuZjh+ADc7lgfWFIfydQTWmddr09oQX40o
 U359/HWBwgH1yHHAtuvnXSE9GMuHIX2Sf3rG4Z4DAARUTGHqZj1KvI28Z1VoWmPaP9oO
 wgrg==
X-Gm-Message-State: AOJu0Yx6zzE1yYMyGbb/P4K46j5Gsq+I0+VqYoKQa3w27pc6daSGr7o4
 xHye22V/XHGgauk9bAb6czON3dfEs3ufcf/SMauWKC1UtDP6iYqGOQBJuJ+uUFP13U8RvSabedd
 K+BUk
X-Gm-Gg: AfdE7cnQnIeYUpObXwS8oDJPV/y7p1YCy4SATZ8aqlnF8/Rnfp11juqQRtf7O8PzzcE
 ouEy5QbT0IDzJZJmSFCNW2Rv6mTByMbqat/jvZc6zD99QHafOc+1gkH7aga4ahV5gXPvn3N/xDV
 7Lbp9gVUdmrc9eJyfhkcoP6fmoiT/6vAbj1jKdH9mWxNdf5WtBz1vB6WmdfCnj6AflynrivJDDt
 BqcOPQ5S8IadGiTcWBd6r5z+HoR8ikLbknG2x/B9hU5nRUDNOlQWxOSS9kKpp9fwKM9BGZ3AcSL
 Yfm8PLUvj8d0RKwBp155WAj/gPSEj2+jBiN9e6QYbwVi3kL3PoAIyFl1Q+zBoeAF/Ct6ljqgFVK
 A9V8IpZna8dPu9iFu+Pq7woPwiq4qH5fEwFMok5MHXm1bsB3l3NCL+VqpqlJYGvsg8uATlpFU6u
 c0Hwg0hXoshbbOtK8pTxab3D23eEsKwwwHcsq/rTJit+HwGzg=
X-Received: by 2002:a17:902:d508:b0:2c9:c517:d070 with SMTP id
 d9443c01a7336-2cb98228abbmr46567475ad.3.1783226257948; 
 Sat, 04 Jul 2026 21:37:37 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 12/46] accel/tcg: Pass CPUBreakpoint to
 debug_check_breakpoint
Date: Sat,  4 Jul 2026 21:36:51 -0700
Message-ID: <20260705043725.1373137-13-richard.henderson@linaro.org>
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

Add the argument and ignore it so far in all targets.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h  | 2 +-
 target/arm/internals.h       | 2 +-
 target/ppc/internal.h        | 2 +-
 target/riscv/debug.h         | 2 +-
 target/xtensa/cpu.h          | 2 +-
 accel/tcg/cpu-exec.c         | 2 +-
 target/arm/tcg/debug.c       | 2 +-
 target/i386/tcg/tcg-cpu.c    | 2 +-
 target/ppc/tcg-excp_helper.c | 2 +-
 target/riscv/debug.c         | 2 +-
 target/xtensa/dbg_helper.c   | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 568d82cdd3..3988bef520 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -264,7 +264,7 @@ struct TCGCPUOps {
      * @debug_check_breakpoint: return true if the architectural
      * breakpoint whose PC has matched should really fire.
      */
-    bool (*debug_check_breakpoint)(CPUState *cpu);
+    bool (*debug_check_breakpoint)(CPUState *cpu, CPUBreakpoint *bp);
 
     /**
      * @io_recompile_replay_branch: Callback for cpu_io_recompile.
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fcce3804f3..370876851e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -680,7 +680,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n);
 void hw_breakpoint_update_all(ARMCPU *cpu);
 
 /* Callback function for checking if a breakpoint should trigger. */
-bool arm_debug_check_breakpoint(CPUState *cs);
+bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
 
 /* Callback function for checking if a watchpoint should trigger. */
 bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a3bb12afd9..ec057afa92 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -304,7 +304,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    int mmu_idx, MemTxAttrs attrs,
                                    MemTxResult response, uintptr_t retaddr);
 void ppc_cpu_debug_excp_handler(CPUState *cs);
-bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
+bool ppc_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index a25d099b37..8eb9eccd4c 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -144,7 +144,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val);
 target_ulong tinfo_csr_read(CPURISCVState *env);
 
 void riscv_cpu_debug_excp_handler(CPUState *cs);
-bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
+bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 void riscv_trigger_realize(CPURISCVState *env);
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index ab42b4be00..590371c4dc 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -591,7 +591,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       int mmu_idx, MemTxAttrs attrs,
                                       MemTxResult response, uintptr_t retaddr);
 hwaddr xtensa_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-bool xtensa_debug_check_breakpoint(CPUState *cs);
+bool xtensa_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
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
index 50b90ad675..306106b7e8 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -351,7 +351,7 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
     return true;
 }
 
-bool arm_debug_check_breakpoint(CPUState *cs)
+bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b..86832cfdf2 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -132,7 +132,7 @@ static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool x86_debug_check_breakpoint(CPUState *cs)
+static bool x86_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index b04f07a637..eb78a6a104 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -331,7 +331,7 @@ void ppc_cpu_debug_excp_handler(CPUState *cs)
 #endif
 }
 
-bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
+bool ppc_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
 {
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 1b88cd136c..5c378dd2e8 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -941,7 +941,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
     }
 }
 
-bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
+bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *ignore)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 20ddc527f8..557a7852c8 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -64,7 +64,7 @@ void HELPER(wsr_ibreaka)(CPUXtensaState *env, uint32_t i, uint32_t v)
     env->sregs[IBREAKA + i] = v;
 }
 
-bool xtensa_debug_check_breakpoint(CPUState *cs)
+bool xtensa_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
 {
     CPUXtensaState *env = cpu_env(cs);
     unsigned int i;
-- 
2.43.0



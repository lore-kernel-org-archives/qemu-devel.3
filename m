Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE940C44501
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEfH-0003nF-7Y; Sun, 05 Jul 2026 00:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEfE-0003bv-8q
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:08 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEfC-0006NH-Ar
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:07 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-845e363246aso2027621b3a.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226465; x=1783831265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oi77c4t6mTRvDij0KOLon4zdhMhjLviMYDkRz5tIy7Q=;
 b=Dq1lPD3spGmIiYLdk8bMry+DuQEqWSZSXqSDfKDHjHwHm49qihOCKGOXNadu+mIqAv
 AQdixeji5oSCpIYgGYqFY9qHPnZTFUapygPQDuXDq2d5yyXYJyPixMvOqzNdUEOFAuqu
 rqN6d558Kkr7n77gKcxsMJsxi+2u1Nz1wwGJNqfLEz1qshYY5m2xuYoWkbWUYHEAC2JD
 lzLbaDCxfHT+UZ/xIes2V/+0jpN42HaGVTN60g7d6eJJHcwbND3aiWXh4Euz0IPf2CP/
 NuTlOzGZbRfO9MY5FXlK9C8OhdTzOEW+clWKbk8vMUZ8S7iVISlGJvqd5/YX3/ZOc4WC
 i73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226465; x=1783831265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oi77c4t6mTRvDij0KOLon4zdhMhjLviMYDkRz5tIy7Q=;
 b=Az1vVgkKhqsXZkk7sKQW0jCXzGQ13K+HcGj6QVMc0EYAwjBT5KZ1Y3HOsHrIS2P0nM
 WfVYew+NnFgsWiQXS4fb31kturZjbZ/f8atCDnoYf7KPNEHgIWjgT3g96VVZMztKJYsj
 ge3peIZK4hOB1j59w46LFq1HzZli3CQdj0j4qq7u64h3FbCQtADLBmA+eCcc1uKHEWyU
 dmRqjpbOuRW4AYf2YXtE1gb761JdaoxmCY5k0VVCxj1p0y0Rz3P0mzMZSW4nlwn3rAJl
 7HcenwvOMPZnIkRPFpNsYOFh2ReWDbJFubVFlJ7g/60mzgvxPwWhKxWYNdgtHI6P6Tup
 ZM0Q==
X-Gm-Message-State: AOJu0Yz9tdWFiyyeM+KKPnsL6hc86OP2mkNC26zXS2uZjeFHlWiCS6Hv
 cwdqyy+B+EWvEE+IFQ5MLRQQoIoUiwJaIX39n4xTspJoM/s3gpuWMHuZjR8sbS/att/geuv/MhG
 A7H7h
X-Gm-Gg: AfdE7ckNKa/xzcVqMjW/gT3+/K1rL+tgu3ZzVP+9kWKwvBZpxUUUy+JykJNiNpK9lME
 N/Fg3l65aQDRyHk3DbkSVCmFzTBFtI4Wt4PBFMYR3AjegFifiZPrKac2C/mGUKIrU/2iV89QT/r
 JzNuxjxLFUKbSu3pvorMQ2lgS5o9Nd2+30gYk4oB1H9/2s47la3ECPcmeH23FHc673zi5stkAKV
 I8FA7iyi4Sf573qlqDzh++t57Z8P/rX20zqKsnqmBKPNONVso1c6bWqqjD1wPc5LTHQrW6rys3N
 52gecH0Rm/OU989OX4OVlA0Z5RWlsyW8XTLYj0mSF4kwXQOOw6C/akx3m3T/i5jYbB/E9bGqbOk
 /B5/IxJ81jO1JtVdsGjxcm+mdMjFnkHEIiiFECRdy6L82CpJ+Q9pcdCANQs/cTSr1cQtGZ2b2hV
 kSxdZSea7kBfVGuZNu7IiIe6qntOy0kK78SggdoSMgywzkp8k=
X-Received: by 2002:a05:6a00:4f83:b0:846:bc60:5bf8 with SMTP id
 d2e1a72fcca58-847f6d5b738mr4440975b3a.5.1783226464787; 
 Sat, 04 Jul 2026 21:41:04 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6952a0dsm1952615b3a.0.2026.07.04.21.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:41:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 42/46] target/xtensa: Restrict xtensa_breakpoint_handler to
 system mode
Date: Sat,  4 Jul 2026 21:37:21 -0700
Message-ID: <20260705043725.1373137-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h    | 2 +-
 target/xtensa/cpu.c    | 2 +-
 target/xtensa/helper.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 663ee23dc4..119a0b8187 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -592,6 +592,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       MemTxResult response, uintptr_t retaddr);
 hwaddr xtensa_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 bool xtensa_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
+void xtensa_breakpoint_handler(CPUState *cs, CPUBreakpoint *hit);
 #endif
 void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void xtensa_count_regs(const XtensaConfig *config,
@@ -621,7 +622,6 @@ void xtensa_translate_init(void);
 void xtensa_translate_code(CPUState *cs, TranslationBlock *tb,
                            int *max_insns, vaddr pc, void *host_pc);
 void **xtensa_get_regfile_by_name(const char *name, int entries, int bits);
-void xtensa_breakpoint_handler(CPUState *cs, CPUBreakpoint *hit);
 void xtensa_register_core(XtensaConfigList *node);
 void xtensa_sim_open_console(Chardev *chr);
 void check_interrupts(CPUXtensaState *s);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 2015a4e3d0..eb6758b694 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -316,7 +316,6 @@ static const TCGCPUOps xtensa_tcg_ops = {
 
     .initialize = xtensa_translate_init,
     .translate_code = xtensa_translate_code,
-    .debug_excp_handler = xtensa_breakpoint_handler,
     .get_tb_cpu_state = xtensa_get_tb_cpu_state,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
     .mmu_index = xtensa_cpu_mmu_index,
@@ -331,6 +330,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
     .do_unaligned_access = xtensa_cpu_do_unaligned_access,
     .debug_check_breakpoint = xtensa_debug_check_breakpoint,
+    .debug_excp_handler = xtensa_breakpoint_handler,
 #endif /* !CONFIG_USER_ONLY */
 };
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 02627ada7c..aa012068de 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -206,6 +206,7 @@ void xtensa_register_core(XtensaConfigList *node)
     g_free((gpointer)type.name);
 }
 
+#ifndef CONFIG_USER_ONLY
 static uint32_t check_hw_breakpoints(CPUXtensaState *env)
 {
     unsigned i;
@@ -249,7 +250,6 @@ void xtensa_breakpoint_handler(CPUState *cs, CPUBreakpoint *hit)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
 void xtensa_cpu_do_unaligned_access(CPUState *cs,
                                     vaddr addr, MMUAccessType access_type,
                                     int mmu_idx, uintptr_t retaddr)
-- 
2.43.0



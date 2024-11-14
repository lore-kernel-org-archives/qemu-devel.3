Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EE7D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcNP-00047j-Jd; Thu, 14 Nov 2024 11:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLQ-0001mC-MS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:27 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLL-00033h-Qo
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:19 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so674386a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600312; x=1732205112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PvazYVJMP5GcUwBS2MCJUYaWeFV3enL9YDBstfMYOoA=;
 b=eezgv9/Ws6bo1OcLC9OrFR8jGQBTmgBUKeB1CdpdcD6wpPen0NQBzpaPkS3eK5VtXe
 QfCyac/31cFN/uV4BuTU1szEnIDZ4uZ3LGEQ7C6I3SQPnKOU5k1h/8sio0aFWxHT1ntK
 YWZbe3oHzrWUkD0z8hhvEZYjOPULlC00TcaoaCu/Nuk2YX+O4La2rZuGM7/ZoR6dwcLg
 4iafvvi3aFRz9PoH/Td3L8lVaqwCyvWU1rUqdBxLHb1diMZK4+W8WmRJnXgyUTSdTDF9
 3QaO34r3/ywfMAw3wxQ38u6oJYlD2mvmTSbaeErm7Foeucak66P0FhrED+Q93ZJvzCQw
 uUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600312; x=1732205112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PvazYVJMP5GcUwBS2MCJUYaWeFV3enL9YDBstfMYOoA=;
 b=B6L6JpLSsd3zNzIgwj6KUBbVsHGnP+5hQSUHf3qExwO+ZgoH9J0M/xwfczqGTZ0uP+
 w5L2baH9Z2LqJXki7PDiIeO/9UasDkiDPgUDCj07lX58+MgbFv0CRXSbV1xsgACouZBJ
 UCJ08T6Q5mGw14hr5YG2/6ScByWUzna5gT2XDArml3RuBKzGcId25Aige00MAd7/5apz
 rcbnSQF99E6lcz29TGtvkLhC9o1F+Pfyq1WAG0TFOqJ0r2SPtOiML+qDrRrLpRXsNK47
 fk6v6XsnXmAfvt4EpPJzzQZGhVHOqm5xD9PWUnYK/Ul8LzHYRRbfUTSE7GbJAbLlbOZQ
 AWSg==
X-Gm-Message-State: AOJu0Yz96jk2V6KVhlEeJjMlCNIacCTDNA84eYMbC+RE1uXon3deDTF3
 nkXMwU4N4aghNb6KdVqy7FcpDfvaCCSBRRvBxmC0Vl0zeGD+S6NtZBKhPjg6kWmD+3NifhLqDgU
 8
X-Google-Smtp-Source: AGHT+IHRRECedHgC8UA8c0cg98zU4ej6leJ/NcHYkkXVAzng1uypKrz9H9pIVnN1g0TWsoz6F1d0KQ==
X-Received: by 2002:a05:6a20:4325:b0:1d6:fb1b:d07a with SMTP id
 adf61e73a8af0-1dc22b57f1dmr30731144637.31.1731600312512; 
 Thu, 14 Nov 2024 08:05:12 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 44/54] target/riscv: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:20 -0800
Message-ID: <20241114160131.48616-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h         |  8 +++++---
 target/riscv/cpu_helper.c  | 22 +++++++++++++++++-----
 target/riscv/tcg/tcg-cpu.c |  2 +-
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 284b112821..f97c4f3410 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -25,6 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "exec/cpu-defs.h"
 #include "exec/gdbstub.h"
+#include "exec/memop.h"
 #include "qemu/cpu-float.h"
 #include "qom/object.h"
 #include "qemu/int128.h"
@@ -563,9 +564,10 @@ bool cpu_get_bcfien(CPURISCVState *env);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
-bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                        MMUAccessType access_type, int mmu_idx,
-                        bool probe, uintptr_t retaddr);
+bool riscv_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                              vaddr addr, MMUAccessType access_type,
+                              int mmu_idx, MemOp memop, int size,
+                              bool probe, uintptr_t ra);
 char *riscv_isa_string(RISCVCPU *cpu);
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(const char *optname);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69ea..edb2edfc55 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1429,9 +1429,10 @@ static void pmu_tlb_fill_incr_ctr(RISCVCPU *cpu, MMUAccessType access_type)
     riscv_pmu_incr_ctr(cpu, pmu_event_type);
 }
 
-bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                        MMUAccessType access_type, int mmu_idx,
-                        bool probe, uintptr_t retaddr)
+bool riscv_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                              vaddr address, MMUAccessType access_type,
+                              int mmu_idx, MemOp memop, int size,
+                              bool probe, uintptr_t retaddr)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -1452,6 +1453,14 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        riscv_cpu_do_unaligned_access(cs, address, access_type,
+                                      mmu_idx, retaddr);
+    }
+
     pmu_tlb_fill_incr_ctr(cpu, access_type);
     if (two_stage_lookup) {
         /* Two stage lookup */
@@ -1544,8 +1553,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     if (ret == TRANSLATE_SUCCESS) {
-        tlb_set_page(cs, address & ~(tlb_size - 1), pa & ~(tlb_size - 1),
-                     prot, mmu_idx, tlb_size);
+        memset(out, 0, sizeof(*out));
+        out->phys_addr = pa;
+        out->prot = prot;
+        out->lg_page_size = ctz64(tlb_size);
+        out->attrs = MEMTXATTRS_UNSPECIFIED;
         return true;
     } else if (probe) {
         return false;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c221696..f3b436bb86 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -138,7 +138,7 @@ static const TCGCPUOps riscv_tcg_ops = {
     .restore_state_to_opc = riscv_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill = riscv_cpu_tlb_fill,
+    .tlb_fill_align = riscv_cpu_tlb_fill_align,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
     .do_interrupt = riscv_cpu_do_interrupt,
-- 
2.43.0



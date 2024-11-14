Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6DBD68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcM6-00022X-Ch; Thu, 14 Nov 2024 11:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLO-0001gT-7Y
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:20 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLI-00031L-KC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:14 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720c286bcd6so729630b3a.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600311; x=1732205111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lXqCqubeCT0QNAMQLrmscFNdjuU77OyZLOi8s3DYmiM=;
 b=j4QrfB6GyOucNYUDaNyshWMzV2KpKNYbGeSCs1yusJ2bEKVqr8fHWUk1IADVgIIwOC
 kmt419hEjy7jaPmZzL0PEcLDpCJr2leGlxBvk0ko+ZPdJzoMDl1NzBwSfZuPp5v9leiQ
 rv/hozMTfUnqHbBRG1pG+KfMWjT1Xret9/bVNdzc82oImS7OEjYhyD6pSGZVAfDILO4o
 3kmj+S0wKwt7oyh4/roFbhPUS0rXff4d78cCQK3SKCMSe0rMd4OOrzuwOlJWaRQ9FsUj
 l6Yt+ZSzO0qhW2hVJtqGEWIrtmZzdCtn6fNpd/UprRgvp4JiiQvGOf+7ptAvBWln1fgz
 ysng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600311; x=1732205111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lXqCqubeCT0QNAMQLrmscFNdjuU77OyZLOi8s3DYmiM=;
 b=t4f7CDRvzoz7OMk4njDgRRjKMBnGKGG6iWRDcnzv/nvCEAbX0fbSQYPieKZSiUIhCh
 6GEQCR8/9oZN3DHTQH0BErc4H8lZ4iEt0Ed/F7b4ybq4py0tLmR2hl6pXq+K57ffFrPB
 kcKfDHh9Hw3xOLjTgZ7LSrwlhtk6eHKVSRDrJjD0IY68Wh626LrFK75uo6YqbdUcgemm
 YpCqg1uP//nqpFQaB1yhiKUtmMO2gVf6z+dVWNfRWUNwvYaje2x/miI31DkntoNPrgHM
 IQLobeFHfvsnEJfTEvRrd09GJJ1GjrQvU44gMAm7XOyYBFBTsSwpn2xtjfq+X7vYATRc
 aIpg==
X-Gm-Message-State: AOJu0YxYdfZpbbC3tHPsN9cieeo+fcBLy8e0roeaEPjRrlJzGvB3BhDA
 9nF3D7C6slE4DTPsFToIgPeaOOzkNVr6CcrEkeOUDog6n2mQXrLo+tOtPr72T0nr0/9ojvdBN3A
 s
X-Google-Smtp-Source: AGHT+IE7g5LfgO4J+I6h04FvuntiNTMaS3e0coLJeLtKjCUdDv7iMXtK+Oc4rDakvNBP+F9Ef07cJQ==
X-Received: by 2002:a05:6a00:124c:b0:71e:722b:ae1d with SMTP id
 d2e1a72fcca58-724133b687emr30389114b3a.25.1731600311041; 
 Thu, 14 Nov 2024 08:05:11 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 42/54] target/openrisc: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:18 -0800
Message-ID: <20241114160131.48616-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
 target/openrisc/cpu.h |  8 +++++---
 target/openrisc/cpu.c |  2 +-
 target/openrisc/mmu.c | 39 +++++++++++++++++++++------------------
 3 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index c9fe9ae12d..e177ad8b84 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/memop.h"
 #include "fpu/softfloat-types.h"
 
 /**
@@ -306,9 +307,10 @@ int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 #ifndef CONFIG_USER_ONLY
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
-bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                           MMUAccessType access_type, int mmu_idx,
-                           bool probe, uintptr_t retaddr);
+bool openrisc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                                 vaddr addr, MMUAccessType access_type,
+                                 int mmu_idx, MemOp memop, int size,
+                                 bool probe, uintptr_t ra);
 
 extern const VMStateDescription vmstate_openrisc_cpu;
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b96561d1f2..6aa04ff7d3 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -237,7 +237,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .restore_state_to_opc = openrisc_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill = openrisc_cpu_tlb_fill,
+    .tlb_fill_align = openrisc_cpu_tlb_fill_align,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
     .cpu_exec_halt = openrisc_cpu_has_work,
     .do_interrupt = openrisc_cpu_do_interrupt,
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index c632d5230b..eafab356a6 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -104,39 +104,42 @@ static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
     cpu->env.lock_addr = -1;
 }
 
-bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
-                           MMUAccessType access_type, int mmu_idx,
-                           bool probe, uintptr_t retaddr)
+bool openrisc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                                 vaddr addr, MMUAccessType access_type,
+                                 int mmu_idx, MemOp memop, int size,
+                                 bool probe, uintptr_t retaddr)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    int excp = EXCP_DPF;
     int prot;
     hwaddr phys_addr;
 
+    /* TODO: alignment faults not currently handled. */
+
     if (mmu_idx == MMU_NOMMU_IDX) {
         /* The mmu is disabled; lookups never fail.  */
         get_phys_nommu(&phys_addr, &prot, addr);
-        excp = 0;
     } else {
         bool super = mmu_idx == MMU_SUPERVISOR_IDX;
         int need = (access_type == MMU_INST_FETCH ? PAGE_EXEC
                     : access_type == MMU_DATA_STORE ? PAGE_WRITE
                     : PAGE_READ);
-        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr, need, super);
+        int excp = get_phys_mmu(cpu, &phys_addr, &prot, addr, need, super);
+
+        if (unlikely(excp)) {
+            if (probe) {
+                return false;
+            }
+            raise_mmu_exception(cpu, addr, excp);
+            cpu_loop_exit_restore(cs, retaddr);
+        }
     }
 
-    if (likely(excp == 0)) {
-        tlb_set_page(cs, addr & TARGET_PAGE_MASK,
-                     phys_addr & TARGET_PAGE_MASK, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
-        return true;
-    }
-    if (probe) {
-        return false;
-    }
-
-    raise_mmu_exception(cpu, addr, excp);
-    cpu_loop_exit_restore(cs, retaddr);
+    memset(out, 0, sizeof(*out));
+    out->phys_addr = phys_addr;
+    out->prot = prot;
+    out->lg_page_size = TARGET_PAGE_BITS;
+    out->attrs = MEMTXATTRS_UNSPECIFIED;
+    return true;
 }
 
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.43.0



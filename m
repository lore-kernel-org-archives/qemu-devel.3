Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB179D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcMx-0002fK-2Z; Thu, 14 Nov 2024 11:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLS-0001mU-Me
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:28 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLO-00036B-9Y
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:21 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72061bfec2dso590718b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600314; x=1732205114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XzIjtrWoIZsOWLPYm1QVw15canDC/nSQkt85xis2OP4=;
 b=IfBm3AwKTdf/B9PpEaSEqxqequ1nXEtbz0Bz7xXDanCdHDcILBM6zgF94jArq/Tly7
 uZENvWz8XGJmD0e5uOEU+sfbGU31X48kgUn1URah8slQ+mpJAvVb7062RErxghd+ul4X
 0oHlgqdjF7ZT9Np3VOLRqgsNbTdxrDLvzKf9w/ORi55cy9/NykOKOIrDeNuN2kX9OJG/
 pVgAae314ZPZxSE1qRVlLSrYhQ5j/KAp78C8VpdY8X8NOJzfBrnvRSRhHPOmwWLintY+
 5ODFNRVz75vlGvQXlFKIfKSdu0Yu3fzpaneKhhiqIibMMvxwM/I39aT5lIqCFNYsx5pA
 UhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600314; x=1732205114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XzIjtrWoIZsOWLPYm1QVw15canDC/nSQkt85xis2OP4=;
 b=JIxwONkILEcx/nGIJ81kZKRTmIPs4Y9sLzWsYeeuD5Mx6ZBMcgNTwGlfm0KWwJPXNO
 pV5Hgd1vJzGizQDzJTL8JA4+kSYm4zRHd9Aw4F2ySCl31f3ELRwWsJVkQUuHTUwn/aLl
 W1F/b3ifxqbqt6L/aBkRTDTF9Rjs5qeBDBtc33E1pBKbeuBbZwLOalNR43pEzVZzC1gE
 KuZiPrBpFPjk5bE+XDfEBJzeHB3namQGiV49hcJXrX+UQzbxaYn05pKLVbIYOvshXOsp
 pVu9C7fypXhKpXRG7+4Ya0uk+dX6F32Rvzb1ywmKPsvza3andFj1aVHKQzqm1R9NOXWO
 nVTQ==
X-Gm-Message-State: AOJu0YyAQ3vJ0ZnjCuKqWkSgafiCnA7TfOyx5zGch/EJGOYwPgt++Gmp
 Am+wGnk0xxArmIwCFfCodTkmxxamtjgfy8YZZTPlipsepi8julu8p1tT1m4SSkVfaiOPnsB6MSz
 P
X-Google-Smtp-Source: AGHT+IHyZb/kd+QONYmo2tnnYuVkEviprnW6EUVFPAsQsweUgcLfJtHzNUAcamblJ5QgNVkAwU9drQ==
X-Received: by 2002:a05:6a00:1394:b0:724:59e0:5d22 with SMTP id
 d2e1a72fcca58-72469df0a7fmr3581313b3a.20.1731600313922; 
 Thu, 14 Nov 2024 08:05:13 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 46/54] target/s390x: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:22 -0800
Message-ID: <20241114160131.48616-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/s390x/s390x-internal.h  |  7 ++++---
 target/s390x/cpu.c             |  4 ++--
 target/s390x/tcg/excp_helper.c | 23 ++++++++++++++++++-----
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 825252d728..eb6fe24c9a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -278,9 +278,10 @@ void s390_cpu_record_sigsegv(CPUState *cs, vaddr address,
 void s390_cpu_record_sigbus(CPUState *cs, vaddr address,
                             MMUAccessType access_type, uintptr_t retaddr);
 #else
-bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool probe, uintptr_t retaddr);
+bool s390x_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                              vaddr addr, MMUAccessType access_type,
+                              int mmu_idx, MemOp memop, int size,
+                              bool probe, uintptr_t retaddr);
 G_NORETURN void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                               MMUAccessType access_type, int mmu_idx,
                                               uintptr_t retaddr);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 514c70f301..4d0eb129e3 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -330,7 +330,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
          * Instructions must be at even addresses.
          * This needs to be checked before address translation.
          */
-        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
+        env->int_pgm_ilen = 2; /* see s390x_cpu_tlb_fill_align() */
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
     }
 
@@ -364,7 +364,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .record_sigsegv = s390_cpu_record_sigsegv,
     .record_sigbus = s390_cpu_record_sigbus,
 #else
-    .tlb_fill = s390_cpu_tlb_fill,
+    .tlb_fill_align = s390x_cpu_tlb_fill_align,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
     .cpu_exec_halt = s390_cpu_has_work,
     .do_interrupt = s390_cpu_do_interrupt,
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 4c0b692c9e..6d61032a4a 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -139,9 +139,10 @@ static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
     }
 }
 
-bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool probe, uintptr_t retaddr)
+bool s390x_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                              vaddr address, MMUAccessType access_type,
+                              int mmu_idx, MemOp memop, int size,
+                              bool probe, uintptr_t retaddr)
 {
     CPUS390XState *env = cpu_env(cs);
     target_ulong vaddr, raddr;
@@ -151,6 +152,14 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        s390x_cpu_do_unaligned_access(cs, address, access_type,
+                                      mmu_idx, retaddr);
+    }
+
     vaddr = address;
 
     if (mmu_idx < MMU_REAL_IDX) {
@@ -177,8 +186,12 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         qemu_log_mask(CPU_LOG_MMU,
                       "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
                       __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
-        tlb_set_page(cs, address & TARGET_PAGE_MASK, raddr, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
+
+        memset(out, 0, sizeof(*out));
+        out->phys_addr = raddr;
+        out->prot = prot;
+        out->lg_page_size = TARGET_PAGE_BITS;
+        out->attrs = MEMTXATTRS_UNSPECIFIED;
         return true;
     }
     if (probe) {
-- 
2.43.0



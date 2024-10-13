Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72151CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06q3-0007IQ-Jw; Sun, 13 Oct 2024 18:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pj-0007DE-SC
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:04 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pi-0000xm-7w
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:03 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2a97c2681so2633652a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857581; x=1729462381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+vEW0gmQhnEtA5RzJM7KFg+N4W9KtFO8BjH5/MF//A=;
 b=RN7KYxBg/ZwhFiFkBrMw7/CRWtFbJZtW8uVqqgpbpsfHFIg+dwX/qfgA+se5ks/5Ie
 qecyrVSfUvXdmhy7Z405NqpryT3nAnFwq1U6UgBenM5pPFHkBGdCM0E1evPTv70fuhcD
 g6vjtf5OYEgm2a4AfH7fgr/zQO7gHeHDYUd1Y1gKetyNARRojUDSGolEgXlQKdbPEbh+
 rvFSfA8HEvS0oKvx/dwmnJ0qBRkkG/OJbISJVWMejoNcuSyNSNtW6XHevdBl6kHY2JwD
 Ugv5gjS3wXWBUPXj1bQKxrrPQuBbzniQp3jpIbbTJRiefkTABbP6P+XKTyyDPWVyvLJd
 11ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857581; x=1729462381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+vEW0gmQhnEtA5RzJM7KFg+N4W9KtFO8BjH5/MF//A=;
 b=TGhkDLuNJuPiIj37AJaWopH5xYaxRpEEQHT8hL/g0nU2uU3dcyw7wN/bdpv0ZaPnTG
 +e+GE0nrSO4dFtT9naVrVEnA7XtOM3QvKOhyxV2f5mxdzb15citHDfOl9YfD8+gPZ5q0
 8vka/9cTkJT2/bd/blEIv+0nRTtMiD8hQZ8+8G0ch4os/Ro+VVRuXL30YUpR4hVpkiCf
 I0Ht4Jdxvt9x0+v90HGdWUvn+A42dQEfO7fy2W71Bqb2LISH3OGDCCMZD7fskTSm9Skr
 QQC4pcG43HXZtBakKsOtC0wRkkQh45FBqPeFtAbTrB9KG+Bzib9RDCVcpMRp/o84OTvt
 19Eg==
X-Gm-Message-State: AOJu0YzAkXRkELdpxGGngShWhlK25Gvzl4TlEg1o8WNcjjEshoJRcTEe
 3BagFZwt/zXs+dbKKGK+ZptcYR0cahYeWFxHo2fO8IdrMRcNe6kp58l/T8Gp8KJseOIxgQjbh3b
 1
X-Google-Smtp-Source: AGHT+IE8odUALb7Bp2QQwhArRc/UPU6DqIBUaiM04O3oaTB/RMTGF0m2ka1YmYWXlv8f2srBYPTr3g==
X-Received: by 2002:a17:90a:67c6:b0:2e0:f896:b806 with SMTP id
 98e67ed59e1d1-2e2f0d7aa36mr12237239a91.27.1728857580881; 
 Sun, 13 Oct 2024 15:13:00 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:13:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 26/27] target/arm: Implement TCGCPUOps.tlb_fill_align
Date: Sun, 13 Oct 2024 15:12:34 -0700
Message-ID: <20241013221235.1585193-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Fill in the tlb_fill_align hook.  Handle alignment not due to
memory type, since that's no longer handled by generic code.
Pass memop to get_phys_addr.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  6 ++---
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/cpu-v7m.c    |  2 +-
 target/arm/tcg/tlb_helper.c | 49 ++++++++++++++-----------------------
 4 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a6088d551c..299a96a81a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -816,9 +816,9 @@ void arm_cpu_record_sigsegv(CPUState *cpu, vaddr addr,
 void arm_cpu_record_sigbus(CPUState *cpu, vaddr addr,
                            MMUAccessType access_type, uintptr_t ra);
 #else
-bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr);
+bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+                            MMUAccessType access_type, int mmu_idx,
+                            MemOp memop, int size, bool probe, uintptr_t ra);
 #endif
 
 static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 19191c2391..1320fd8c8f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2663,7 +2663,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
 #else
-    .tlb_fill = arm_cpu_tlb_fill,
+    .tlb_fill_align = arm_cpu_tlb_fill_align,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .do_interrupt = arm_cpu_do_interrupt,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 5496f14dc1..58e54578d6 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -242,7 +242,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
 #else
-    .tlb_fill = arm_cpu_tlb_fill,
+    .tlb_fill_align = arm_cpu_tlb_fill_align,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 1d8b7bcaa2..8841f039bc 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -318,14 +318,13 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     arm_deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
 }
 
-bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr)
+bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
+                            MMUAccessType access_type, int mmu_idx,
+                            MemOp memop, int size, bool probe, uintptr_t ra)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo local_fi, *fi;
-    int ret;
 
     /*
      * Allow S1_ptw_translate to see any fault generated here.
@@ -339,37 +338,27 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     /*
-     * Walk the page table and (if the mapping exists) add the page
-     * to the TLB.  On success, return true.  Otherwise, if probing,
-     * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
-     * register format, and signal the fault.
+     * Per R_XCHFJ, alignment fault not due to memory type has
+     * highest precedence.  Otherwise, walk the page table and
+     * and collect the page description.
      */
-    ret = get_phys_addr(&cpu->env, address, access_type, 0,
-                        core_to_arm_mmu_idx(&cpu->env, mmu_idx),
-                        &res, fi);
-    if (likely(!ret)) {
-        /*
-         * Map a single [sub]page. Regions smaller than our declared
-         * target page size are handled specially, so for those we
-         * pass in the exact addresses.
-         */
-        if (res.f.lg_page_size >= TARGET_PAGE_BITS) {
-            res.f.phys_addr &= TARGET_PAGE_MASK;
-            address &= TARGET_PAGE_MASK;
-        }
-
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        fi->type = ARMFault_Alignment;
+    } else if (!get_phys_addr(&cpu->env, address, access_type, memop,
+                              core_to_arm_mmu_idx(&cpu->env, mmu_idx),
+                              &res, fi)) {
         res.f.extra.arm.pte_attrs = res.cacheattrs.attrs;
         res.f.extra.arm.shareability = res.cacheattrs.shareability;
-
-        tlb_set_page_full(cs, mmu_idx, address, &res.f);
+        *out = res.f;
         return true;
-    } else if (probe) {
-        return false;
-    } else {
-        /* now we have a real cpu fault */
-        cpu_restore_state(cs, retaddr);
-        arm_deliver_fault(cpu, address, access_type, mmu_idx, fi);
     }
+    if (probe) {
+        return false;
+    }
+
+    /* Now we have a real cpu fault. */
+    cpu_restore_state(cs, ra);
+    arm_deliver_fault(cpu, address, access_type, mmu_idx, fi);
 }
 #else
 void arm_cpu_record_sigsegv(CPUState *cs, vaddr addr,
-- 
2.43.0



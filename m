Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AD4D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcNc-0004WK-LD; Thu, 14 Nov 2024 11:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLS-0001mT-MG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:27 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLO-00036Q-9y
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:21 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20e576dbc42so9331385ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600315; x=1732205115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=72w17lGLoodIUSQZn/s5b+crRwhLJRO07+3KfBN9KKk=;
 b=PHOtPFfOYxe6eiMf3ClgLfSaoMxF3PM5++CNFvrYZ4YUVq3XHRt34XfYpzqeYclqgJ
 Rawn8t1NYUVKdThvGT3Z6PedYJ5pLrYVc68k6QKZ7bOVgFt8Hf1kvojSnkuTMDEAmDNs
 s7RzDem3W8GtWIJdHUIe+Q3kVa/dXbC6yDd1IkjTAPFB7eENbfDmta2zV6sqm9QMlseX
 oldchgxhxak9SksD4/nh+p/5kkncshKhdFWVsyfGw9C7lnvNBMzaFXivgV8xPrmZG9yq
 q86SrxjQL/vtSgynvrCCDxkZWl7fozUF4Jj5m1tUu3d8APBpW5/I7D1s8jCVsqtjvQ9a
 Vdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600315; x=1732205115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72w17lGLoodIUSQZn/s5b+crRwhLJRO07+3KfBN9KKk=;
 b=q8TSV4Z+Y+zW6SHeKoTIpETf31aCR+5TZDjDj1O5/1LVpjitj6ea4n6mhWm9PsrVhA
 L3T0Lo/cFceodqnGvfm+lTClIK+HkCsC+70VDaeHvSg5k6DKzA9/e6z/kBVV8LO4NC5S
 LPYq4yueO1v81YkiTZo7hCWkq71vmtcaPuJjJDnx1NKWrR1s89NGvay60uPidcyIG7gG
 QhiA3DKg/le32Zi39sMlBNtIKmWOzpVyiQwfsdLyYVBqOzoJ5JuwMG4SvDqRI+0LYhO5
 jKzWAWt9HbYxRBOG4EtdHB2ufetviuIA6kti2JlEnhg7wFsrXtr3XcsxRr/jxdLgAlfn
 1VMw==
X-Gm-Message-State: AOJu0Yy7l8dd7cKG1WrHW6Efnkq0VttqTnKloCv6ClHoR17J7wjO4jf/
 9uMjSRUkONhZGj0QHcANRvTywzd2EyqHW0lgkc2p1oi3VTp2xMLKb2P2IJydwDbApRNvWMTviG0
 g
X-Google-Smtp-Source: AGHT+IE0QyvZdI3vLQn4HufGwcv0pfYvUNiM+X3EG/cq1gFpGvkpib2IeHYpzweL4FriZ25FFpIMew==
X-Received: by 2002:a17:903:2ac6:b0:20c:e169:eb75 with SMTP id
 d9443c01a7336-211b65d93c4mr87296725ad.2.1731600315493; 
 Thu, 14 Nov 2024 08:05:15 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 48/54] target/sparc: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:24 -0800
Message-ID: <20241114160131.48616-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/sparc/cpu.h        |  8 ++++---
 target/sparc/cpu.c        |  2 +-
 target/sparc/mmu_helper.c | 44 +++++++++++++++++++++++++--------------
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f517e5a383..4c8927e9fa 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -4,6 +4,7 @@
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/memop.h"
 #include "qemu/cpu-float.h"
 
 #if !defined(TARGET_SPARC64)
@@ -596,9 +597,10 @@ G_NORETURN void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t);
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
 void sparc_cpu_list(void);
 /* mmu_helper.c */
-bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                        MMUAccessType access_type, int mmu_idx,
-                        bool probe, uintptr_t retaddr);
+bool sparc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                              vaddr addr, MMUAccessType access_type,
+                              int mmu_idx, MemOp memop, int size,
+                              bool probe, uintptr_t retaddr);
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
 void dump_mmu(CPUSPARCState *env);
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dd7af86de7..57ae53bd71 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -932,7 +932,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .restore_state_to_opc = sparc_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill = sparc_cpu_tlb_fill,
+    .tlb_fill_align = sparc_cpu_tlb_fill_align,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
     .cpu_exec_halt = sparc_cpu_has_work,
     .do_interrupt = sparc_cpu_do_interrupt,
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 9ff06026b8..32766a37d6 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -203,12 +203,12 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
 }
 
 /* Perform address translation */
-bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                        MMUAccessType access_type, int mmu_idx,
-                        bool probe, uintptr_t retaddr)
+bool sparc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                              vaddr address, MMUAccessType access_type,
+                              int mmu_idx, MemOp memop, int size,
+                              bool probe, uintptr_t retaddr)
 {
     CPUSPARCState *env = cpu_env(cs);
-    CPUTLBEntryFull full = {};
     target_ulong vaddr;
     int error_code = 0, access_index;
 
@@ -220,16 +220,21 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
      */
     assert(!probe);
 
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        sparc_cpu_do_unaligned_access(cs, address, access_type,
+                                      mmu_idx, retaddr);
+    }
+
+    memset(out, 0, sizeof(*out));
     address &= TARGET_PAGE_MASK;
-    error_code = get_physical_address(env, &full, &access_index,
+    error_code = get_physical_address(env, out, &access_index,
                                       address, access_type, mmu_idx);
     vaddr = address;
     if (likely(error_code == 0)) {
         qemu_log_mask(CPU_LOG_MMU,
                       "Translate at %" VADDR_PRIx " -> "
                       HWADDR_FMT_plx ", vaddr " TARGET_FMT_lx "\n",
-                      address, full.phys_addr, vaddr);
-        tlb_set_page_full(cs, mmu_idx, vaddr, &full);
+                      address, out->phys_addr, vaddr);
         return true;
     }
 
@@ -244,8 +249,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
            permissions. If no mapping is available, redirect accesses to
            neverland. Fake/overridden mappings will be flushed when
            switching to normal mode. */
-        full.prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-        tlb_set_page_full(cs, mmu_idx, vaddr, &full);
+        out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return true;
     } else {
         if (access_type == MMU_INST_FETCH) {
@@ -754,22 +758,30 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
 }
 
 /* Perform address translation */
-bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                        MMUAccessType access_type, int mmu_idx,
-                        bool probe, uintptr_t retaddr)
+bool sparc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                              vaddr address, MMUAccessType access_type,
+                              int mmu_idx, MemOp memop, int size,
+                              bool probe, uintptr_t retaddr)
 {
     CPUSPARCState *env = cpu_env(cs);
-    CPUTLBEntryFull full = {};
     int error_code = 0, access_index;
 
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        sparc_cpu_do_unaligned_access(cs, address, access_type,
+                                      mmu_idx, retaddr);
+    }
+
+    memset(out, 0, sizeof(*out));
     address &= TARGET_PAGE_MASK;
-    error_code = get_physical_address(env, &full, &access_index,
+    error_code = get_physical_address(env, out, &access_index,
                                       address, access_type, mmu_idx);
     if (likely(error_code == 0)) {
-        trace_mmu_helper_mmu_fault(address, full.phys_addr, mmu_idx, env->tl,
+        trace_mmu_helper_mmu_fault(address, out->phys_addr, mmu_idx, env->tl,
                                    env->dmmu.mmu_primary_context,
                                    env->dmmu.mmu_secondary_context);
-        tlb_set_page_full(cs, mmu_idx, address, &full);
         return true;
     }
     if (probe) {
-- 
2.43.0



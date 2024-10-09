Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C64CF042E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCP-0004Gf-Ql; Tue, 08 Oct 2024 20:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCN-0004DY-Ps
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:03 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCL-0002fG-Hp
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:03 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c5a7b2908so9763565ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432300; x=1729037100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRlC3mms3e9Sb+Qb/UGEoW53IughvKHiILVrUessrrs=;
 b=Cq0JQAO1GBTJ0yQ/WQW6q0qXX0jv04gk0dKDdyo6qhz5pBfEysoqDDBIvhtPnJ8ZUc
 WOEggWFVZsEsC4wpVhrp9RLZRXZAti6JG0ZVi7rCC7T+mYxHK+BIB5uKrctWsy/OI+HO
 cXrqia7Z5/yNTxeWsmaXm5i6f4ff2QlHn6zcmvS2OBt0XZdjDx8mtTC+5IQYnjr0ke7T
 kF72lKbCPW4eUJGuhcaCmxp3DbYcexZi3QWE974swsmdZiZwaOEZGxiPfrjslFbMQm0Y
 O5evQku6P5cMWM6PGs6Lo8WrGaEbA+cWnYErTWaWlKRvDwwurS4dq4tziLfZxcbfo+Dt
 K5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432300; x=1729037100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRlC3mms3e9Sb+Qb/UGEoW53IughvKHiILVrUessrrs=;
 b=d/Y1oc6ohYwZR467uAFIn+QvBDKl0YoTt7GQasfhwUij9z48EGE57OcWn6GVgwaeiD
 sO/MkjZ4pPK9nRR5rdWiTykBkgwj3omFLxDF9zF+PwFSqjf88qB60202FSBZTkmr67sr
 VJDKDkkMcP5yLYJlXxO9k3a5dgLZhKkilZl1gKJxuus9EM8xBpywAQi86Rvol21jVe2q
 eySLPDEN0P3Cn8kp37bJAH+sNbfX4h2v5JEhxp+rl+DoAnlh/CiqRviLPI1liwm3Cyq8
 CpXB5kzZmvROG2Yk32qbbfiksxhcshhxMkll82Yao/6+CpyHnMgvhR+Kc+IO9rosSx1w
 614Q==
X-Gm-Message-State: AOJu0Yxb4M3NVd2mRVmjmyAOiK5iQ2uF0y1bzeFIxKoJhfMRjAjtYcCV
 eRdBuNubBJmc7DCZBaQQbrxSPjyamqsVE+A2ffAk5RvOBWDdufnjtRy01/uteatiZL/AQobEMdC
 C
X-Google-Smtp-Source: AGHT+IFCFvVKxRyLlvfGXYLtSu9ozN9PdneS174Hz9Cj7lMpmt/cbo6+LfjS0UmFUu6tz4mWEHkH6A==
X-Received: by 2002:a17:903:98b:b0:208:b468:db21 with SMTP id
 d9443c01a7336-20c63748357mr13630815ad.30.1728432299990; 
 Tue, 08 Oct 2024 17:04:59 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:04:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v3 05/20] accel/tcg: Add TCGCPUOps.tlb_fill_align
Date: Tue,  8 Oct 2024 17:04:38 -0700
Message-ID: <20241009000453.315652-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Add a new callback to handle softmmu paging.  Return the page
details directly, instead of passing them indirectly to
tlb_set_page.  Handle alignment simultaneously with paging so
that faults are handled with target-specific priority.

Route all calls the two hooks through a tlb_fill_align
function local to cputlb.c.

As yet no targets implement the new hook.
As yet cputlb.c does not use the new alignment check.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h         |  4 +--
 include/hw/core/tcg-cpu-ops.h | 26 +++++++++++++++
 include/qemu/typedefs.h       |  1 +
 accel/tcg/cputlb.c            | 61 ++++++++++++++++++++++-------------
 4 files changed, 67 insertions(+), 25 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 04e9ad4996..d21a24c82f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -205,7 +205,7 @@ struct CPUClass {
  * so the layout is not as critical as that of CPUTLBEntry. This is
  * also why we don't want to combine the two structs.
  */
-typedef struct CPUTLBEntryFull {
+struct CPUTLBEntryFull {
     /*
      * @xlat_section contains:
      *  - in the lower TARGET_PAGE_BITS, a physical section number
@@ -261,7 +261,7 @@ typedef struct CPUTLBEntryFull {
             bool guarded;
         } arm;
     } extra;
-} CPUTLBEntryFull;
+};
 
 /*
  * Data elements that are per MMU mode, minus the bits accessed by
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 34318cf0e6..c932690621 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -13,6 +13,7 @@
 #include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
+#include "exec/memop.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
 
@@ -131,6 +132,31 @@ struct TCGCPUOps {
      * same function signature.
      */
     bool (*cpu_exec_halt)(CPUState *cpu);
+    /**
+     * @tlb_fill_align: Handle a softmmu tlb miss
+     * @cpu: cpu context
+     * @out: output page properties
+     * @addr: virtual address
+     * @access_type: read, write or execute
+     * @mmu_idx: mmu context
+     * @memop: memory operation for the access
+     * @size: memory access size, or 0 for whole page
+     * @probe: test only, no fault
+     * @ra: host return address for exception unwind
+     *
+     * If the access is valid, fill in @out and return true.
+     * Otherwise if probe is true, return false.
+     * Otherwise raise and exception and do not return.
+     *
+     * The alignment check for the access is deferred to this hook,
+     * so that the target can determine the priority of any alignment
+     * fault with respect to other potential faults from paging.
+     * Zero may be passed for @memop to skip any alignment check
+     * for non-memory-access operations such as probing.
+     */
+    bool (*tlb_fill_align)(CPUState *cpu, CPUTLBEntryFull *out, vaddr addr,
+                           MMUAccessType access_type, int mmu_idx,
+                           MemOp memop, int size, bool probe, uintptr_t ra);
     /**
      * @tlb_fill: Handle a softmmu tlb miss
      *
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 9d222dc376..3d84efcac4 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -40,6 +40,7 @@ typedef struct ConfidentialGuestSupport ConfidentialGuestSupport;
 typedef struct CPUArchState CPUArchState;
 typedef struct CPUPluginState CPUPluginState;
 typedef struct CPUState CPUState;
+typedef struct CPUTLBEntryFull CPUTLBEntryFull;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisasContextBase DisasContextBase;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 35cda1e2b0..d72f454e9e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1221,22 +1221,35 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
 }
 
 /*
- * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
- * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
- * be discarded and looked up again (e.g. via tlb_entry()).
+ * Note: tlb_fill_align() can trigger a resize of the TLB.
+ * This means that all of the caller's prior references to the TLB table
+ * (e.g. CPUTLBEntry pointers) must be discarded and looked up again
+ * (e.g. via tlb_entry()).
  */
-static void tlb_fill(CPUState *cpu, vaddr addr, int size,
-                     MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
+                           int mmu_idx, MemOp memop, int size,
+                           bool probe, uintptr_t ra)
 {
-    bool ok;
+    const TCGCPUOps *ops = cpu->cc->tcg_ops;
+    CPUTLBEntryFull full;
 
-    /*
-     * This is not a probe, so only valid return is success; failure
-     * should result in exception + longjmp to the cpu loop.
-     */
-    ok = cpu->cc->tcg_ops->tlb_fill(cpu, addr, size,
-                                    access_type, mmu_idx, false, retaddr);
-    assert(ok);
+    if (ops->tlb_fill_align) {
+        if (ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
+                                memop, size, probe, ra)) {
+            tlb_set_page_full(cpu, mmu_idx, addr, &full);
+            return true;
+        }
+    } else {
+        /* Legacy behaviour is alignment before paging. */
+        if (addr & ((1u << memop_alignment_bits(memop)) - 1)) {
+            ops->do_unaligned_access(cpu, addr, type, mmu_idx, ra);
+        }
+        if (ops->tlb_fill(cpu, addr, size, type, mmu_idx, probe, ra)) {
+            return true;
+        }
+    }
+    assert(probe);
+    return false;
 }
 
 static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
@@ -1351,22 +1364,22 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, page_addr)) {
-            if (!cpu->cc->tcg_ops->tlb_fill(cpu, addr, fault_size, access_type,
-                                            mmu_idx, nonfault, retaddr)) {
+            if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
+                                0, fault_size, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
                 *phost = NULL;
                 *pfull = NULL;
                 return TLB_INVALID_MASK;
             }
 
-            /* TLB resize via tlb_fill may have moved the entry.  */
+            /* TLB resize via tlb_fill_align may have moved the entry.  */
             index = tlb_index(cpu, mmu_idx, addr);
             entry = tlb_entry(cpu, mmu_idx, addr);
 
             /*
              * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
-             * to force the next access through tlb_fill.  We've just
-             * called tlb_fill, so we know that this entry *is* valid.
+             * to force the next access through tlb_fill_align.  We've just
+             * called tlb_fill_align, so we know that this entry *is* valid.
              */
             flags &= ~TLB_INVALID_MASK;
         }
@@ -1613,7 +1626,7 @@ typedef struct MMULookupLocals {
  *
  * Resolve the translation for the one page at @data.addr, filling in
  * the rest of @data with the results.  If the translation fails,
- * tlb_fill will longjmp out.  Return true if the softmmu tlb for
+ * tlb_fill_align will longjmp out.  Return true if the softmmu tlb for
  * @mmu_idx may have resized.
  */
 static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
@@ -1631,7 +1644,8 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
                             addr & TARGET_PAGE_MASK)) {
-            tlb_fill(cpu, addr, data->size, access_type, mmu_idx, ra);
+            tlb_fill_align(cpu, addr, access_type, mmu_idx,
+                           0, data->size, false, ra);
             maybe_resized = true;
             index = tlb_index(cpu, mmu_idx, addr);
             entry = tlb_entry(cpu, mmu_idx, addr);
@@ -1821,8 +1835,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
                             addr & TARGET_PAGE_MASK)) {
-            tlb_fill(cpu, addr, size,
-                     MMU_DATA_STORE, mmu_idx, retaddr);
+            tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
+                           0, size, false, retaddr);
             index = tlb_index(cpu, mmu_idx, addr);
             tlbe = tlb_entry(cpu, mmu_idx, addr);
         }
@@ -1836,7 +1850,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
      * but addr_read will only be -1 if PAGE_READ was unset.
      */
     if (unlikely(tlbe->addr_read == -1)) {
-        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        tlb_fill_align(cpu, addr, MMU_DATA_LOAD, mmu_idx,
+                       0, size, false, retaddr);
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
-- 
2.43.0



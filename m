Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73052CEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJU-0001Ys-4E; Wed, 09 Oct 2024 11:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJS-0001XT-4F
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJQ-0007zm-6n
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:17 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e10ae746aso1878823b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486555; x=1729091355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a2Nnnz5s/lwcWhx3xXVKANRp1+FyXlqnqYoni9ory64=;
 b=UlUgnYBg1/3GvWvrDXKLBP1X6yhC97sZP6BhyI6OBbMTtx5Pfej6jr4koTOve1HQyB
 Fv7Ad69nwW+7U1VQZTyPfgn1D8FVV5ra9w2Eob2Hbf2Wvyh/4eF04jMz6GX3k8nBuZ9L
 kKOHKqNDH9p99sp0Cmw/nkSjt7uZcFTBQWtvDQ1vqPPVAKcthhfMxDWAZmlFP84Ciadn
 VmrHUUzfxoiQQGBXA6fH9KTINXdr5FDPJ1GDPk+311NIqaZfrtM6TxUPykiHQxCFAIdv
 D5HQhjPphVFy8jy0+/Wrdp3adD6C7qvVZyjle+QEQAPIW+tMhAAyfkhw3PtQTdUCiCt4
 EcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486555; x=1729091355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2Nnnz5s/lwcWhx3xXVKANRp1+FyXlqnqYoni9ory64=;
 b=IADUxxFlnY86TnYfpdm2vnBJDCUUmiPOs+36awBv7ae/S68g7Jvepgr+v08mvdt22Z
 iVh9feAzUXEtbf26ueqAKbIhSDg4vwERZ+IxBTdw1wN++MHJjYHbBXwDyM6FDwtotvBN
 BT/HcF6dDWbTnrp5uA+tG2rKHJ+97Hv+rwYOhMSVnq9N1CS0tjbJL8b8SctW/lUws2sJ
 1HDMkk7HhyKws8xsmBISrKnOasazvGfKBWdT8D2EEIRwYGtv0ctHc2UmDyZ1v+qFkdqg
 +m6sU37ZFKNEBCSIlE6effMmW+p246fhIUA1yKFhrgEZdm5TcsdT7rbOKniwuBAQ4F4K
 IE9w==
X-Gm-Message-State: AOJu0Yx31SyEm4K3whe33C3l602pXpvgcRYiqnXls7hF6lnvH1wAn8mG
 isXHPQ9seFlhCrPnqRuMx+YXGzxl7qreYnx7AMZPxoIrjU8n2erSKcVBZnR5T9HsV5XzvAyle5r
 6
X-Google-Smtp-Source: AGHT+IFemim3MU4U01Z6GiTFgDZ4OwrAoPF8hQ2pxoZmpieHcMYRF/EsgrH7GCcgWD/k43hfJdM5dQ==
X-Received: by 2002:a05:6a00:3cd3:b0:71d:fb83:6301 with SMTP id
 d2e1a72fcca58-71e1db878d0mr4005593b3a.16.1728486554569; 
 Wed, 09 Oct 2024 08:09:14 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/23] accel/tcg: Link CPUTLBEntry to CPUTLBEntryTree
Date: Wed,  9 Oct 2024 08:08:52 -0700
Message-ID: <20241009150855.804605-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Link from the fast tlb entry to the interval tree node.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-common.h |  2 ++
 accel/tcg/cputlb.c        | 59 ++++++++++++++-------------------------
 2 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index feaa471299..3b57d61112 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -31,6 +31,8 @@ typedef union CPUTLBEntry {
          * use the corresponding iotlb value.
          */
         uintptr_t addend;
+        /* The defining IntervalTree entry. */
+        struct CPUTLBEntryTree *tree;
     };
     /*
      * Padding to get a power of two size, as well as index
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7c8308355d..2a8d1b4fb2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -505,7 +505,10 @@ static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
                                         vaddr mask)
 {
     if (tlb_hit_page_mask_anyprot(tlb_entry, page, mask)) {
-        memset(tlb_entry, -1, sizeof(*tlb_entry));
+        tlb_entry->addr_read = -1;
+        tlb_entry->addr_write = -1;
+        tlb_entry->addend = 0;
+        tlb_entry->tree = NULL;
         return true;
     }
     return false;
@@ -1212,6 +1215,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
     /* Now calculate the new entry */
     node->copy.addend = addend - addr_page;
+    node->copy.tree = node;
 
     if (wp_flags & BP_MEM_READ) {
         read_flags |= TLB_WATCHPOINT;
@@ -1425,7 +1429,6 @@ static int probe_access_internal_data(CPUState *cpu, vaddr addr,
                                       void **phost, CPUTLBEntryFull **pfull,
                                       uintptr_t retaddr, bool check_mem_cbs)
 {
-    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
@@ -1442,7 +1445,6 @@ static int probe_access_internal_data(CPUState *cpu, vaddr addr,
             }
 
             /* TLB resize via tlb_fill_align may have moved the entry.  */
-            index = tlb_index(cpu, mmu_idx, addr);
             entry = tlb_entry(cpu, mmu_idx, addr);
 
             /*
@@ -1456,7 +1458,7 @@ static int probe_access_internal_data(CPUState *cpu, vaddr addr,
     }
     flags &= tlb_addr;
 
-    *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+    *pfull = full = &entry->tree->full;
     flags |= full->slow_flags[access_type];
 
     /*
@@ -1659,7 +1661,6 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
                        bool is_store, struct qemu_plugin_hwaddr *data)
 {
     CPUTLBEntry *tlbe = tlb_entry(cpu, mmu_idx, addr);
-    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
     MMUAccessType access_type = is_store ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t tlb_addr = tlb_read_idx(tlbe, access_type);
     CPUTLBEntryFull *full;
@@ -1668,7 +1669,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
         return false;
     }
 
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+    full = &tlbe->tree->full;
     data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
     /* We must have an iotlb entry for MMIO */
@@ -1716,20 +1717,17 @@ typedef struct MMULookupLocals {
  *
  * Resolve the translation for the one page at @data.addr, filling in
  * the rest of @data with the results.  If the translation fails,
- * tlb_fill_align will longjmp out.  Return true if the softmmu tlb for
- * @mmu_idx may have resized.
+ * tlb_fill_align will longjmp out.
  */
-static bool mmu_lookup1_code(CPUState *cpu, MMULookupPageData *data,
+static void mmu_lookup1_code(CPUState *cpu, MMULookupPageData *data,
                              MemOp memop, int mmu_idx, uintptr_t ra)
 {
     vaddr addr = data->addr;
     CPUTLBEntryTree *t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
-    bool maybe_resized = true;
 
     if (!t || !(t->full.prot & PAGE_EXEC)) {
         tlb_fill_align(cpu, addr, MMU_INST_FETCH, mmu_idx,
                        memop, data->size, false, ra);
-        maybe_resized = true;
         t = tlbtree_lookup_addr(&cpu->neg.tlb.d[mmu_idx], addr);
     }
 
@@ -1737,19 +1735,16 @@ static bool mmu_lookup1_code(CPUState *cpu, MMULookupPageData *data,
     data->flags = t->copy.addr_read & TLB_EXEC_FLAGS_MASK;
     /* Compute haddr speculatively; depending on flags it might be invalid. */
     data->haddr = (void *)((uintptr_t)addr + t->copy.addend);
-
-    return maybe_resized;
 }
 
-static bool mmu_lookup1_data(CPUState *cpu, MMULookupPageData *data,
+static void mmu_lookup1_data(CPUState *cpu, MMULookupPageData *data,
                              MemOp memop, int mmu_idx,
                              MMUAccessType access_type, uintptr_t ra)
 {
     vaddr addr = data->addr;
-    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
     uint64_t tlb_addr = tlb_read_idx(entry, access_type);
-    bool maybe_resized = false;
+    bool did_tlb_fill = false;
     CPUTLBEntryFull *full;
     int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
 
@@ -1758,8 +1753,7 @@ static bool mmu_lookup1_data(CPUState *cpu, MMULookupPageData *data,
         if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
             tlb_fill_align(cpu, addr, access_type, mmu_idx,
                            memop, data->size, false, ra);
-            maybe_resized = true;
-            index = tlb_index(cpu, mmu_idx, addr);
+            did_tlb_fill = true;
             entry = tlb_entry(cpu, mmu_idx, addr);
             /*
              * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
@@ -1771,11 +1765,11 @@ static bool mmu_lookup1_data(CPUState *cpu, MMULookupPageData *data,
         tlb_addr = tlb_read_idx(entry, access_type);
     }
 
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
-    flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
+    full = &entry->tree->full;
+    flags &= tlb_addr;
     flags |= full->slow_flags[access_type];
 
-    if (likely(!maybe_resized)) {
+    if (likely(!did_tlb_fill)) {
         /* Alignment has not been checked by tlb_fill_align. */
         int a_bits = memop_alignment_bits(memop);
 
@@ -1798,17 +1792,15 @@ static bool mmu_lookup1_data(CPUState *cpu, MMULookupPageData *data,
     data->flags = flags;
     /* Compute haddr speculatively; depending on flags it might be invalid. */
     data->haddr = (void *)((uintptr_t)addr + entry->addend);
-
-    return maybe_resized;
 }
 
-static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
+static void mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
                         int mmu_idx, MMUAccessType access_type, uintptr_t ra)
 {
     if (access_type == MMU_INST_FETCH) {
-        return mmu_lookup1_code(cpu, data, memop, mmu_idx, ra);
+        mmu_lookup1_code(cpu, data, memop, mmu_idx, ra);
     }
-    return mmu_lookup1_data(cpu, data, memop, mmu_idx, access_type, ra);
+    mmu_lookup1_data(cpu, data, memop, mmu_idx, access_type, ra);
 }
 
 /**
@@ -1889,15 +1881,9 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         l->page[1].size = l->page[0].size - size0;
         l->page[0].size = size0;
 
-        /*
-         * Lookup both pages, recognizing exceptions from either.  If the
-         * second lookup potentially resized, refresh first CPUTLBEntryFull.
-         */
+        /* Lookup both pages, recognizing exceptions from either. */
         mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
-        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
-            uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
-            l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
-        }
+        mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra);
 
         flags = l->page[0].flags | l->page[1].flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
@@ -1925,7 +1911,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 {
     uintptr_t mmu_idx = get_mmuidx(oi);
     MemOp mop = get_memop(oi);
-    uintptr_t index;
     CPUTLBEntry *tlbe;
     void *hostaddr;
     CPUTLBEntryFull *full;
@@ -1937,7 +1922,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     /* Adjust the given return address.  */
     retaddr -= GETPC_ADJ;
 
-    index = tlb_index(cpu, mmu_idx, addr);
     tlbe = tlb_entry(cpu, mmu_idx, addr);
 
     /* Check TLB entry and enforce page permissions.  */
@@ -1947,7 +1931,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
             tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
                            mop, size, false, retaddr);
             did_tlb_fill = true;
-            index = tlb_index(cpu, mmu_idx, addr);
             tlbe = tlb_entry(cpu, mmu_idx, addr);
             /*
              * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
@@ -1958,7 +1941,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         }
     }
 
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+    full = &tlbe->tree->full;
 
     /*
      * Let the guest notice RMW on a write-only page.
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F0FD68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJV-0006N4-Df; Thu, 14 Nov 2024 11:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIR-00055Q-Dc
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:15 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-0002H5-9V
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:14 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso736807a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600117; x=1732204917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LsY9qG1BO160UZ3oT54r8qS8sJnVh1lfu8JqWoX9HKs=;
 b=Ff2wmvpUdD2EO1f7TlSEKgvFRCBGLSSVVfVZJTayf5x1Xodt5YQu9pXnksMJYLpu7z
 zOagINypcEtvZpNxrbklxytPXhWB1lM45ka2B2tf/b1YQ5M/IVKoo37NUtAI+q5BYlK8
 ChfNGcy5EHbmgBCJ+4h5eS+1AkkOjlFcdkwyTFTVpo5giys/iQ3xkBZbWepXbLxJX+CD
 gSjGE+0T5KFGYrtkPrQ9lwP6jXk8mDRw/cAJFce9/J99BFjWblrU1z9LKjoXmkGI78gv
 ln6c49qJ5uLSKD6nqBLPHHTqzfxtONvK+jz5RqtpHPBmHJcfQ/q56CCFYDGFOD3q18mm
 Xevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600117; x=1732204917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsY9qG1BO160UZ3oT54r8qS8sJnVh1lfu8JqWoX9HKs=;
 b=xMA/VbgRcDm89KX0zH2lP/of3BA4btFs8gkEYIv6IE5FrFngDWFk/UW6Vgxh/35PwX
 uEL8XUrsVfSOQSWnglMqvfvznRKpHug0mJNcnfPM0YnHX/8ocFXSgtkl21+8ARNBm5kR
 a7EfEeQpRfGCcUmAkg7hSxCG7L/ofsFJqZgPxRyqylucLVcP1vzWnjc9NyoJNSVFef+t
 mQOzSXtZfLVmLvafUqTA4wFbxrlswVMw4Oy9SUJf+u3dVPkzm15Ea4vuWzZKHixKYuaW
 nYbNueMCJE3uWyGvTr+KL/ZyJ7X/+RFCE1o/rhkGnOai0SNpXpAWXyykNeBkVz4n+mr0
 d+Qw==
X-Gm-Message-State: AOJu0YyNG14MKxbRvq02FFpGo/NR78neJaDrvXTyM3LqCJvgKy/oOZgE
 JC/4gKAZaPkvvV3MuGw+57xAaAo6tOdnnL7fj4eikG/mUTbU5n8FgrpI3ft+ccQZ01EfyHfjZxU
 0
X-Google-Smtp-Source: AGHT+IHnNhDS49CGt44Gxs8BVTqUpIENQno7yxoNeG6lAU+lTa83Immbnso9WHnc97AumqC+86docw==
X-Received: by 2002:a17:90a:dfc4:b0:2ea:1293:7db1 with SMTP id
 98e67ed59e1d1-2ea12937f38mr645040a91.33.1731600116195; 
 Thu, 14 Nov 2024 08:01:56 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/54] accel/tcg: Introduce tlb_lookup
Date: Thu, 14 Nov 2024 08:01:04 -0800
Message-ID: <20241114160131.48616-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Unify 3 instances of tlb lookup, through tlb_hit, tlbtree_hit,
and tlb_full_align.  Use structures to avoid too many arguments.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 369 ++++++++++++++++++++++-----------------------
 1 file changed, 178 insertions(+), 191 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 41b2f76cc9..a33bebf55a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1271,6 +1271,118 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
                                           mmu_idx, retaddr);
 }
 
+typedef struct TLBLookupInput {
+    vaddr addr;
+    uintptr_t ra;
+    int memop_probe           : 16;
+    unsigned int size         : 8;
+    MMUAccessType access_type : 4;
+    unsigned int mmu_idx      : 4;
+} TLBLookupInput;
+
+typedef struct TLBLookupOutput {
+    CPUTLBEntryFull full;
+    void *haddr;
+    int flags;
+    bool did_tlb_fill;
+} TLBLookupOutput;
+
+static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
+                       const TLBLookupInput *i)
+{
+    CPUTLBDesc *desc = &cpu->neg.tlb.d[i->mmu_idx];
+    CPUTLBDescFast *fast = &cpu->neg.tlb.f[i->mmu_idx];
+    vaddr addr = i->addr;
+    MMUAccessType access_type = i->access_type;
+    CPUTLBEntryFull *full;
+    CPUTLBEntryTree *node;
+    CPUTLBEntry *entry;
+    uint64_t cmp;
+    bool probe = i->memop_probe < 0;
+    MemOp memop = probe ? 0 : i->memop_probe;
+    int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
+
+    assert_cpu_is_self(cpu);
+    o->did_tlb_fill = false;
+
+    /* Primary lookup in the fast tlb. */
+    entry = tlbfast_entry(fast, addr);
+    full = &desc->fulltlb[tlbfast_index(fast, addr)];
+    cmp = tlb_read_idx(entry, access_type);
+    if (tlb_hit(cmp, addr)) {
+        goto found;
+    }
+
+    /* Secondary lookup in the IntervalTree. */
+    node = tlbtree_lookup_addr(desc, addr);
+    if (node) {
+        cmp = tlb_read_idx(&node->copy, access_type);
+        if (tlb_hit(cmp, addr)) {
+            /* Install the cached entry. */
+            qemu_spin_lock(&cpu->neg.tlb.c.lock);
+            copy_tlb_helper_locked(entry, &node->copy);
+            qemu_spin_unlock(&cpu->neg.tlb.c.lock);
+            *full = node->full;
+            goto found;
+        }
+    }
+
+    /* Finally, query the target hook. */
+    if (!tlb_fill_align(cpu, addr, access_type, i->mmu_idx,
+                        memop, i->size, probe, i->ra)) {
+        tcg_debug_assert(probe);
+        return false;
+    }
+
+    o->did_tlb_fill = true;
+
+    entry = tlbfast_entry(fast, addr);
+    full = &desc->fulltlb[tlbfast_index(fast, addr)];
+    cmp = tlb_read_idx(entry, access_type);
+    /*
+     * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
+     * to force the next access through tlb_fill_align.  We've just
+     * called tlb_fill_align, so we know that this entry *is* valid.
+     */
+    flags &= ~TLB_INVALID_MASK;
+    goto done;
+
+ found:
+    /* Alignment has not been checked by tlb_fill_align. */
+    {
+        int a_bits = memop_alignment_bits(memop);
+
+        /*
+         * The TLB_CHECK_ALIGNED check differs from the normal alignment
+         * check, in that this is based on the atomicity of the operation.
+         * The intended use case is the ARM memory type field of each PTE,
+         * where access to pages with Device memory type require alignment.
+         */
+        if (unlikely(flags & TLB_CHECK_ALIGNED)) {
+            int at_bits = memop_atomicity_bits(memop);
+            a_bits = MAX(a_bits, at_bits);
+        }
+        if (unlikely(addr & ((1 << a_bits) - 1))) {
+            cpu_unaligned_access(cpu, addr, access_type, i->mmu_idx, i->ra);
+        }
+    }
+
+ done:
+    flags &= cmp;
+    flags |= full->slow_flags[access_type];
+    o->flags = flags;
+    o->full = *full;
+    o->haddr = (void *)((uintptr_t)addr + entry->addend);
+    return true;
+}
+
+static void tlb_lookup_nofail(CPUState *cpu, TLBLookupOutput *o,
+                              const TLBLookupInput *i)
+{
+    bool ok = tlb_lookup(cpu, o, i);
+    tcg_debug_assert(ok);
+}
+
 static MemoryRegionSection *
 io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
            MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
@@ -1303,40 +1415,6 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
     }
 }
 
-/*
- * Return true if ADDR is present in the interval tree,
- * and has been copied back to the main tlb.
- */
-static bool tlbtree_hit(CPUState *cpu, int mmu_idx,
-                        MMUAccessType access_type, vaddr addr)
-{
-    CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
-    CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
-    CPUTLBEntryTree *node;
-    size_t index;
-
-    assert_cpu_is_self(cpu);
-    node = tlbtree_lookup_addr(desc, addr);
-    if (!node) {
-        /* There is no cached mapping for this page. */
-        return false;
-    }
-
-    if (!tlb_hit(tlb_read_idx(&node->copy, access_type), addr)) {
-        /* This access is not permitted. */
-        return false;
-    }
-
-    /* Install the cached entry. */
-    index = tlbfast_index(fast, addr);
-    qemu_spin_lock(&cpu->neg.tlb.c.lock);
-    copy_tlb_helper_locked(&fast->table[index], &node->copy);
-    qemu_spin_unlock(&cpu->neg.tlb.c.lock);
-
-    desc->fulltlb[index] = node->full;
-    return true;
-}
-
 static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
                            CPUTLBEntryFull *full, uintptr_t retaddr)
 {
@@ -1367,40 +1445,26 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
                                  void **phost, CPUTLBEntryFull *pfull,
                                  uintptr_t retaddr, bool check_mem_cbs)
 {
-    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
-    uint64_t tlb_addr = tlb_read_idx(entry, access_type);
-    int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
-    CPUTLBEntryFull *full;
+    TLBLookupInput i = {
+        .addr = addr,
+        .ra = retaddr,
+        .access_type = access_type,
+        .size = fault_size,
+        .memop_probe = nonfault ? -1 : 0,
+        .mmu_idx = mmu_idx,
+    };
+    TLBLookupOutput o;
+    int flags;
 
-    if (!tlb_hit(tlb_addr, addr)) {
-        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
-            if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
-                                0, fault_size, nonfault, retaddr)) {
-                /* Non-faulting page table read failed.  */
-                *phost = NULL;
-                memset(pfull, 0, sizeof(*pfull));
-                return TLB_INVALID_MASK;
-            }
-
-            /* TLB resize via tlb_fill_align may have moved the entry.  */
-            index = tlb_index(cpu, mmu_idx, addr);
-            entry = tlb_entry(cpu, mmu_idx, addr);
-
-            /*
-             * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
-             * to force the next access through tlb_fill_align.  We've just
-             * called tlb_fill_align, so we know that this entry *is* valid.
-             */
-            flags &= ~TLB_INVALID_MASK;
-        }
-        tlb_addr = tlb_read_idx(entry, access_type);
+    if (!tlb_lookup(cpu, &o, &i)) {
+        /* Non-faulting page table read failed.  */
+        *phost = NULL;
+        memset(pfull, 0, sizeof(*pfull));
+        return TLB_INVALID_MASK;
     }
-    flags &= tlb_addr;
 
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
-    flags |= full->slow_flags[access_type];
-    *pfull = *full;
+    *pfull = o.full;
+    flags = o.flags;
 
     /*
      * Fold all "mmio-like" bits, and required plugin callbacks, to TLB_MMIO.
@@ -1415,7 +1479,7 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     }
 
     /* Everything else is RAM. */
-    *phost = (void *)((uintptr_t)addr + entry->addend);
+    *phost = o.haddr;
     return flags;
 }
 
@@ -1625,6 +1689,7 @@ typedef struct MMULookupPageData {
     vaddr addr;
     int flags;
     int size;
+    TLBLookupOutput o;
 } MMULookupPageData;
 
 typedef struct MMULookupLocals {
@@ -1644,67 +1709,25 @@ typedef struct MMULookupLocals {
  *
  * Resolve the translation for the one page at @data.addr, filling in
  * the rest of @data with the results.  If the translation fails,
- * tlb_fill_align will longjmp out.  Return true if the softmmu tlb for
- * @mmu_idx may have resized.
+ * tlb_fill_align will longjmp out.
  */
-static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
+static void mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
                         int mmu_idx, MMUAccessType access_type, uintptr_t ra)
 {
-    vaddr addr = data->addr;
-    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(cpu, mmu_idx, addr);
-    uint64_t tlb_addr = tlb_read_idx(entry, access_type);
-    bool maybe_resized = false;
-    CPUTLBEntryFull *full;
-    int flags = TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
+    TLBLookupInput i = {
+        .addr = data->addr,
+        .ra = ra,
+        .access_type = access_type,
+        .memop_probe = memop,
+        .size = data->size,
+        .mmu_idx = mmu_idx,
+    };
 
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if (!tlb_hit(tlb_addr, addr)) {
-        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
-            tlb_fill_align(cpu, addr, access_type, mmu_idx,
-                           memop, data->size, false, ra);
-            maybe_resized = true;
-            index = tlb_index(cpu, mmu_idx, addr);
-            entry = tlb_entry(cpu, mmu_idx, addr);
-            /*
-             * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
-             * to force the next access through tlb_fill.  We've just
-             * called tlb_fill, so we know that this entry *is* valid.
-             */
-            flags &= ~TLB_INVALID_MASK;
-        }
-        tlb_addr = tlb_read_idx(entry, access_type);
-    }
+    tlb_lookup_nofail(cpu, &data->o, &i);
 
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
-    flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
-    flags |= full->slow_flags[access_type];
-
-    if (likely(!maybe_resized)) {
-        /* Alignment has not been checked by tlb_fill_align. */
-        int a_bits = memop_alignment_bits(memop);
-
-        /*
-         * This alignment check differs from the one above, in that this is
-         * based on the atomicity of the operation. The intended use case is
-         * the ARM memory type field of each PTE, where access to pages with
-         * Device memory type require alignment.
-         */
-        if (unlikely(flags & TLB_CHECK_ALIGNED)) {
-            int at_bits = memop_atomicity_bits(memop);
-            a_bits = MAX(a_bits, at_bits);
-        }
-        if (unlikely(addr & ((1 << a_bits) - 1))) {
-            cpu_unaligned_access(cpu, addr, access_type, mmu_idx, ra);
-        }
-    }
-
-    data->full = full;
-    data->flags = flags;
-    /* Compute haddr speculatively; depending on flags it might be invalid. */
-    data->haddr = (void *)((uintptr_t)addr + entry->addend);
-
-    return maybe_resized;
+    data->full = &data->o.full;
+    data->flags = data->o.flags;
+    data->haddr = data->o.haddr;
 }
 
 /**
@@ -1785,15 +1808,9 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
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
@@ -1819,49 +1836,26 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                                int size, uintptr_t retaddr)
 {
-    uintptr_t mmu_idx = get_mmuidx(oi);
-    MemOp mop = get_memop(oi);
-    uintptr_t index;
-    CPUTLBEntry *tlbe;
-    void *hostaddr;
-    CPUTLBEntryFull *full;
-    bool did_tlb_fill = false;
-    int flags;
+    TLBLookupInput i = {
+        .addr = addr,
+        .ra = retaddr - GETPC_ADJ,
+        .access_type = MMU_DATA_STORE,
+        .memop_probe = get_memop(oi),
+        .mmu_idx = get_mmuidx(oi),
+    };
+    TLBLookupOutput o;
+    int flags, wp_flags;
 
-    tcg_debug_assert(mmu_idx < NB_MMU_MODES);
-
-    /* Adjust the given return address.  */
-    retaddr -= GETPC_ADJ;
-
-    index = tlb_index(cpu, mmu_idx, addr);
-    tlbe = tlb_entry(cpu, mmu_idx, addr);
-
-    /* Check TLB entry and enforce page permissions.  */
-    flags = TLB_FLAGS_MASK;
-    if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
-        if (!tlbtree_hit(cpu, mmu_idx, MMU_DATA_STORE, addr)) {
-            tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
-                           mop, size, false, retaddr);
-            did_tlb_fill = true;
-            index = tlb_index(cpu, mmu_idx, addr);
-            tlbe = tlb_entry(cpu, mmu_idx, addr);
-            /*
-             * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
-             * to force the next access through tlb_fill.  We've just
-             * called tlb_fill, so we know that this entry *is* valid.
-             */
-            flags &= ~TLB_INVALID_MASK;
-        }
-    }
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+    i.size = memop_size(i.memop_probe);
+    tlb_lookup_nofail(cpu, &o, &i);
 
     /*
      * Let the guest notice RMW on a write-only page.
      * We have just verified that the page is writable.
      */
-    if (unlikely(!(full->prot & PAGE_READ))) {
-        tlb_fill_align(cpu, addr, MMU_DATA_LOAD, mmu_idx,
-                       0, size, false, retaddr);
+    if (unlikely(!(o.full.prot & PAGE_READ))) {
+        tlb_fill_align(cpu, addr, MMU_DATA_LOAD, i.mmu_idx,
+                       0, i.size, false, i.ra);
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
@@ -1871,12 +1865,13 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     }
 
     /* Enforce guest required alignment, if not handled by tlb_fill_align. */
-    if (!did_tlb_fill && (addr & ((1 << memop_alignment_bits(mop)) - 1))) {
-        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE, mmu_idx, retaddr);
+    if (!o.did_tlb_fill
+        && (addr & ((1 << memop_alignment_bits(i.memop_probe)) - 1))) {
+        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE, i.mmu_idx, i.ra);
     }
 
     /* Enforce qemu required alignment.  */
-    if (unlikely(addr & (size - 1))) {
+    if (unlikely(addr & (i.size - 1))) {
         /*
          * We get here if guest alignment was not requested, or was not
          * enforced by cpu_unaligned_access or tlb_fill_align above.
@@ -1886,41 +1881,33 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         goto stop_the_world;
     }
 
-    /* Collect tlb flags for read and write. */
-    flags &= tlbe->addr_read | tlb_addr_write(tlbe);
-
     /* Notice an IO access or a needs-MMU-lookup access */
+    flags = o.flags;
     if (unlikely(flags & (TLB_MMIO | TLB_DISCARD_WRITE))) {
         /* There's really nothing that can be done to
            support this apart from stop-the-world.  */
         goto stop_the_world;
     }
 
-    hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
-
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(cpu, addr, size, full, retaddr);
+        notdirty_write(cpu, addr, i.size, &o.full, i.ra);
     }
 
-    if (unlikely(flags & TLB_FORCE_SLOW)) {
-        int wp_flags = 0;
-
-        if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
-            wp_flags |= BP_MEM_WRITE;
-        }
-        if (full->slow_flags[MMU_DATA_LOAD] & TLB_WATCHPOINT) {
-            wp_flags |= BP_MEM_READ;
-        }
-        if (wp_flags) {
-            cpu_check_watchpoint(cpu, addr, size,
-                                 full->attrs, wp_flags, retaddr);
-        }
+    wp_flags = 0;
+    if (flags & TLB_WATCHPOINT) {
+        wp_flags |= BP_MEM_WRITE;
+    }
+    if (o.full.slow_flags[MMU_DATA_LOAD] & TLB_WATCHPOINT) {
+        wp_flags |= BP_MEM_READ;
+    }
+    if (unlikely(wp_flags)) {
+        cpu_check_watchpoint(cpu, addr, i.size, o.full.attrs, wp_flags, i.ra);
     }
 
-    return hostaddr;
+    return o.haddr;
 
  stop_the_world:
-    cpu_loop_exit_atomic(cpu, retaddr);
+    cpu_loop_exit_atomic(cpu, i.ra);
 }
 
 /*
-- 
2.43.0



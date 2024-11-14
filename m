Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C71D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJI-0005yK-V8; Thu, 14 Nov 2024 11:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI5-0004zx-GD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:56 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI0-0002E6-TE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:51 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso620755b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600106; x=1732204906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Tsi6XDXpoiCgHSBmhIafrnzhnOLjjswRzo90Xc17TQ=;
 b=ntbMaoUrkaLnXBdMso4jRlo0CS6oDfDZuJRG97WW+cfp/6OCcUkGK7E0QkJ+u5sfVd
 Rcth8mpqkqLOb5W+gPof2u5+JfAyCKM+/Dq2mu1Ea9wHCLAi/qTMUnn3sR01IwvHSyQC
 csh6ErcCztrQCQaXOtBai4SmN7Mu+FxduTnseCMwNuU0jSUmWP1ySi7rIFxue0keVgPI
 0oD+nTGFx0fq7WIx1qJfCZLMlOeaot9Ojgp4AooluyUSV5InXGxpeRIUNEQZI8oIGFr9
 hqt/UjYLJ9tTKFsPp8p/GTiRSa3V+LXRGY+wp0PtpYATrJGM3mZBLG15wyk8hzLX5doP
 PiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600106; x=1732204906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Tsi6XDXpoiCgHSBmhIafrnzhnOLjjswRzo90Xc17TQ=;
 b=WeOQ3YAzjJ4pUxMzveXnCkveRGdkahiB6hTDQQv+rHvtDbNhFnuZAs3v9JU8QRvqNO
 GDF+i59xwHcrwoj/DWQzU1SOnxpcZQCYuZloha7dBmKXjKndvlKStCBzeDLpEC8nm4t/
 QxL4nSaOxAi+CJfzjvMQ9WJwO6dxc1PgwiExc9IYPU5n3nGTpi37BMbp4A+k6YEpHmY/
 p1PqsCzlDyRySXJ4NTTbCyERaHjUXsEWwKxV+kPuHWuH/MgY+Vz7+ETAOlvP0tJFhU6Z
 0HsJdvsbl6z8OLjPddx9aLrYsicCaQUl0YNhbgk9xArHmQLGETCDKIlSGW0rNNY8zuPG
 +OFQ==
X-Gm-Message-State: AOJu0YyanLo11wIu8a2BAg8VAy7BbSyYsCMF1vQKZfgJZyDhOOGrAjL/
 tbdfSTw3KXTZuWwPKgLHDCk3xPwGqbmiP3GrRhifOYqE+647xAAhw4QgLDr9v9qWKxRK7jb4bDf
 n
X-Google-Smtp-Source: AGHT+IFgqgc1AF2jPV/QhIO0BEvsoj+GnOyd4MyxiGFsZdNwzmSho2dBI3ACk8Z6JUPgWAA4Zj1XLg==
X-Received: by 2002:a17:90b:4f47:b0:2e2:af52:a7b7 with SMTP id
 98e67ed59e1d1-2ea06ab3892mr2496657a91.34.1731600105864; 
 Thu, 14 Nov 2024 08:01:45 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/54] accel/tcg: Remove the victim tlb
Date: Thu, 14 Nov 2024 08:00:54 -0800
Message-ID: <20241114160131.48616-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
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

This has been functionally replaced by the IntervalTree.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  8 -----
 accel/tcg/cputlb.c    | 74 -------------------------------------------
 2 files changed, 82 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1ebc999a73..8eda0574b2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -201,9 +201,6 @@ struct CPUClass {
  */
 #define NB_MMU_MODES 16
 
-/* Use a fully associative victim tlb of 8 entries. */
-#define CPU_VTLB_SIZE 8
-
 /*
  * The full TLB entry, which is not accessed by generated TCG code,
  * so the layout is not as critical as that of CPUTLBEntry. This is
@@ -285,11 +282,6 @@ typedef struct CPUTLBDesc {
     /* maximum number of entries observed in the window */
     size_t window_max_entries;
     size_t n_used_entries;
-    /* The next index to use in the tlb victim table.  */
-    size_t vindex;
-    /* The tlb victim table, in two parts.  */
-    CPUTLBEntry vtable[CPU_VTLB_SIZE];
-    CPUTLBEntryFull vfulltlb[CPU_VTLB_SIZE];
     CPUTLBEntryFull *fulltlb;
     /* All active tlb entries for this address space. */
     IntervalTreeRoot iroot;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ea4b78866b..8caa8c0f1d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -328,8 +328,6 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     tlbfast_flush_locked(desc, fast);
     desc->large_page_addr = -1;
     desc->large_page_mask = -1;
-    desc->vindex = 0;
-    memset(desc->vtable, -1, sizeof(desc->vtable));
     interval_tree_free_nodes(&desc->iroot, offsetof(CPUTLBEntryTree, itree));
 }
 
@@ -361,11 +359,6 @@ static inline void tlb_n_used_entries_inc(CPUState *cpu, uintptr_t mmu_idx)
     cpu->neg.tlb.d[mmu_idx].n_used_entries++;
 }
 
-static inline void tlb_n_used_entries_dec(CPUState *cpu, uintptr_t mmu_idx)
-{
-    cpu->neg.tlb.d[mmu_idx].n_used_entries--;
-}
-
 void tlb_init(CPUState *cpu)
 {
     int64_t now = get_clock_realtime();
@@ -496,20 +489,6 @@ static bool tlb_hit_page_mask_anyprot(CPUTLBEntry *tlb_entry,
             page == (tlb_entry->addr_code & mask));
 }
 
-static inline bool tlb_hit_page_anyprot(CPUTLBEntry *tlb_entry, vaddr page)
-{
-    return tlb_hit_page_mask_anyprot(tlb_entry, page, -1);
-}
-
-/**
- * tlb_entry_is_empty - return true if the entry is not in use
- * @te: pointer to CPUTLBEntry
- */
-static inline bool tlb_entry_is_empty(const CPUTLBEntry *te)
-{
-    return te->addr_read == -1 && te->addr_write == -1 && te->addr_code == -1;
-}
-
 /* Called with tlb_c.lock held */
 static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
                                         vaddr page,
@@ -522,28 +501,6 @@ static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
     return false;
 }
 
-/* Called with tlb_c.lock held */
-static void tlb_flush_vtlb_page_mask_locked(CPUState *cpu, int mmu_idx,
-                                            vaddr page,
-                                            vaddr mask)
-{
-    CPUTLBDesc *d = &cpu->neg.tlb.d[mmu_idx];
-    int k;
-
-    assert_cpu_is_self(cpu);
-    for (k = 0; k < CPU_VTLB_SIZE; k++) {
-        if (tlb_flush_entry_mask_locked(&d->vtable[k], page, mask)) {
-            tlb_n_used_entries_dec(cpu, mmu_idx);
-        }
-    }
-}
-
-static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
-                                              vaddr page)
-{
-    tlb_flush_vtlb_page_mask_locked(cpu, mmu_idx, page, -1);
-}
-
 static void tlbfast_flush_range_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
                                        vaddr addr, vaddr len, vaddr mask)
 {
@@ -588,7 +545,6 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
 
     tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
                                page, TARGET_PAGE_SIZE, -1);
-    tlb_flush_vtlb_page_locked(cpu, midx, page);
 
     node = tlbtree_lookup_addr(desc, page);
     if (node) {
@@ -764,11 +720,6 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
 
     tlbfast_flush_range_locked(d, f, addr, len, mask);
 
-    for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
-        vaddr page = addr + i;
-        tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
-    }
-
     addr_mask = addr & mask;
     last_mask = addr_mask + len - 1;
     last_imask = last_mask | ~mask;
@@ -1017,10 +968,6 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
             tlb_reset_dirty_range_locked(&fast->table[i], start1, length);
         }
 
-        for (size_t i = 0; i < CPU_VTLB_SIZE; i++) {
-            tlb_reset_dirty_range_locked(&desc->vtable[i], start1, length);
-        }
-
         for (CPUTLBEntryTree *t = tlbtree_lookup_range(desc, 0, -1); t;
              t = tlbtree_lookup_range_next(t, 0, -1)) {
             tlb_reset_dirty_range_locked(&t->copy, start1, length);
@@ -1054,10 +1001,6 @@ static void tlb_set_dirty(CPUState *cpu, vaddr addr)
 
         tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
 
-        for (int k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_set_dirty1_locked(&desc->vtable[k], addr);
-        }
-
         node = tlbtree_lookup_addr(desc, addr);
         if (node) {
             tlb_set_dirty1_locked(&node->copy, addr);
@@ -1216,23 +1159,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     /* Note that the tlb is no longer clean.  */
     tlb->c.dirty |= 1 << mmu_idx;
 
-    /* Make sure there's no cached translation for the new page.  */
-    tlb_flush_vtlb_page_locked(cpu, mmu_idx, addr_page);
-
-    /*
-     * Only evict the old entry to the victim tlb if it's for a
-     * different page; otherwise just overwrite the stale data.
-     */
-    if (!tlb_hit_page_anyprot(te, addr_page) && !tlb_entry_is_empty(te)) {
-        unsigned vidx = desc->vindex++ % CPU_VTLB_SIZE;
-        CPUTLBEntry *tv = &desc->vtable[vidx];
-
-        /* Evict the old entry into the victim tlb.  */
-        copy_tlb_helper_locked(tv, te);
-        desc->vfulltlb[vidx] = desc->fulltlb[index];
-        tlb_n_used_entries_dec(cpu, mmu_idx);
-    }
-
     /* Replace an old IntervalTree entry, or create a new one. */
     node = tlbtree_lookup_addr(desc, addr_page);
     if (!node) {
-- 
2.43.0



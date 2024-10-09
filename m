Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A765BCEDDA7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJL-0001PF-CW; Wed, 09 Oct 2024 11:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJI-0001Ly-AR
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJG-0007xD-Jr
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71de9e1f431so4400093b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486545; x=1729091345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+DRNYHg5CeN//65T5XbeaPm5JgKwHf9cf4eBzefEY3o=;
 b=hIvCefCKvAs+vRHwovjvah8iTDjFAwEgLgmX/F785MGKkgU7mF2SJ1sIeqarmBY69Q
 D3ABz/cIYGDt1EGjf7YSn9HTH5xLnQ+4i1c7gE5YB4mcg/uJmpvXFf26PFKwZdnko0G7
 YlMv7owmyQ+kN1kfV0N18d26chRUAgpfBtDZAY/jNJxPvqsWHjMYf+E1Fr8ssFBGYLM7
 NSg2G9WOT8Ossq7QAezgIkZFpzTtaHtcveiWwzHCCo4Ppsym/XtXlamYYy/BHRLHBmTU
 klEUmIykaBcNmeVsaXpe+g96pMLuNZX+Qz0+oM9tPZmQ7Xxru/Qh3hhSlju14KKW8VGp
 b5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486545; x=1729091345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+DRNYHg5CeN//65T5XbeaPm5JgKwHf9cf4eBzefEY3o=;
 b=YZPRGSLCAA9fvZ4ZxdVJixuxe2BHY8GjcNbJtzJRZD/p+kzrMGFAPk9UhF/0zlrbcv
 NWWCCT7qMwV1f+Iyv4Js1earbxpovE6pfyL19FTd/ISbiQ1pvTU5f299LctkM6eRMGw/
 4v4jKvy6AsUAwUfOWYc6fUaA7ae9JO3HOzgn3PUBfO3e3aCWMsbGiz9v6eDbut+OeiU+
 iWr6qoOFsi4OAIMegT2uZwOHApFHXN0pMDel7UWPHn8RkvV3qJ/6/4c2bmnr/pih5fKr
 0qCQ7X4hltD9S60XN7FLC47Y026eLSq9lw7DuDChr/smM1VYcHqajduhhOgpYxD1CLlp
 iiFw==
X-Gm-Message-State: AOJu0Yx/6PR3wwhFm6pC/NMiiwluykKD5Lni/SbJHQsqyyF3+Dz5rp7S
 ChlGl3maE+AzUoekLAtgHHaBI7zF+Yj9fjcIvJkeT52JJWiKGyvjUWbes7cejLWrjtQAtRPXhTV
 u
X-Google-Smtp-Source: AGHT+IFsMmrbSg+cuSARvgU1CIe/+EUBsQhE8Mr2v1NwLoPUuIyLmBqfjenJdJzA1f/aDSkEN84ifg==
X-Received: by 2002:a05:6a21:4006:b0:1d7:f4f:9868 with SMTP id
 adf61e73a8af0-1d8a3c4b90cmr5172963637.37.1728486545116; 
 Wed, 09 Oct 2024 08:09:05 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/23] accel/tcg: Populate IntervalTree in tlb_set_page_full
Date: Wed,  9 Oct 2024 08:08:41 -0700
Message-ID: <20241009150855.804605-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Add or replace an entry in the IntervalTree for each
page installed into softmmu.  We do not yet use the
tree for anything else.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 435c2dc132..d964e1b2e8 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -305,6 +305,17 @@ static void tlbfast_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     memset(fast->table, -1, sizeof_tlb(fast));
 }
 
+static CPUTLBEntryTree *tlbtree_lookup_range(CPUTLBDesc *desc, vaddr s, vaddr l)
+{
+    IntervalTreeNode *i = interval_tree_iter_first(&desc->iroot, s, l);
+    return i ? container_of(i, CPUTLBEntryTree, itree) : NULL;
+}
+
+static CPUTLBEntryTree *tlbtree_lookup_addr(CPUTLBDesc *desc, vaddr addr)
+{
+    return tlbtree_lookup_range(desc, addr, addr);
+}
+
 static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
 {
     tlbfast_flush_locked(desc, fast);
@@ -1086,7 +1097,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     MemoryRegionSection *section;
     unsigned int index, read_flags, write_flags;
     uintptr_t addend;
-    CPUTLBEntry *te, tn;
+    CPUTLBEntry *te;
+    CPUTLBEntryTree *node;
     hwaddr iotlb, xlat, sz, paddr_page;
     vaddr addr_page;
     int asidx, wp_flags, prot;
@@ -1194,6 +1206,15 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         tlb_n_used_entries_dec(cpu, mmu_idx);
     }
 
+    /* Replace an old IntervalTree entry, or create a new one. */
+    node = tlbtree_lookup_addr(desc, addr_page);
+    if (!node) {
+        node = g_new(CPUTLBEntryTree, 1);
+        node->itree.start = addr_page;
+        node->itree.last = addr_page + TARGET_PAGE_SIZE - 1;
+        interval_tree_insert(&node->itree, &desc->iroot);
+    }
+
     /* refill the tlb */
     /*
      * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
@@ -1215,15 +1236,15 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     full->phys_addr = paddr_page;
 
     /* Now calculate the new entry */
-    tn.addend = addend - addr_page;
+    node->copy.addend = addend - addr_page;
 
-    tlb_set_compare(full, &tn, addr_page, read_flags,
+    tlb_set_compare(full, &node->copy, addr_page, read_flags,
                     MMU_INST_FETCH, prot & PAGE_EXEC);
 
     if (wp_flags & BP_MEM_READ) {
         read_flags |= TLB_WATCHPOINT;
     }
-    tlb_set_compare(full, &tn, addr_page, read_flags,
+    tlb_set_compare(full, &node->copy, addr_page, read_flags,
                     MMU_DATA_LOAD, prot & PAGE_READ);
 
     if (prot & PAGE_WRITE_INV) {
@@ -1232,10 +1253,11 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     if (wp_flags & BP_MEM_WRITE) {
         write_flags |= TLB_WATCHPOINT;
     }
-    tlb_set_compare(full, &tn, addr_page, write_flags,
+    tlb_set_compare(full, &node->copy, addr_page, write_flags,
                     MMU_DATA_STORE, prot & PAGE_WRITE);
 
-    copy_tlb_helper_locked(te, &tn);
+    node->full = *full;
+    copy_tlb_helper_locked(te, &node->copy);
     tlb_n_used_entries_inc(cpu, mmu_idx);
     qemu_spin_unlock(&tlb->c.lock);
 }
-- 
2.43.0



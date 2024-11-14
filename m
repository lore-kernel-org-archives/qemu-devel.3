Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93E8D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcON-0005IR-IN; Thu, 14 Nov 2024 11:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLi-0001v0-AM
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:41 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLd-00039O-1w
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:34 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7205b6f51f3so553364b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600330; x=1732205130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KflgX9SpwT1nWAco5X5rdlvjIGuNkPShcCz1Q+BgM4A=;
 b=XfSyYBwDHMCAvNQd6rQiqbC0jfTSBt2vDp3WcM56kZlEg7a8n1swaR9mCdc/bQ31gL
 51DEGkXv1U1zWRCjmXW3S6MVQAqZALS0jZA/TmcjX73PrwBeSh9vaxLTPSCLFaBFhCVE
 iZXCTJy0xiWpYTbrWlIi97eXgCaWIGXm94liw8b9WxdJJExvG2EwzjAguUuCpjN5u85v
 uRuUMVLwG+XJgWEBYHP4gc7Ssyry/+3MwwIEb1Acqdfo2+jRWertP3N4JXasLSr/GZb9
 gSSyMSINQfu3Hl1nAzc73i1nXyB8g9rglzvYl0I7h2TOKDS/+eJ81a10Y/74ulej80zL
 Bp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600330; x=1732205130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KflgX9SpwT1nWAco5X5rdlvjIGuNkPShcCz1Q+BgM4A=;
 b=MPh1D4YAe196kHPRu2uNpd6Z9dT/yrm1sEWsYyQ5F87IuTOpDm0PivyN3mZHTCrm5C
 q9FOLwgvnwxhdZroJe4c6n5irDr7K2FjAVMYNdtYvLJTx0JsRnpTBDZTD0cauaheSuBt
 6PMIave0QvIX9N+SllElaurQdqFRxIauvCjDRczmbozAzC6WhH1gxp9iU7SSH+otZ6RZ
 n+f0B6/bF3y+Ya4De9yLvsW3K/fRxsf9p+RvnVJxnYfv6DVrM4d5Q+Z6GzF2WLYzogmg
 EuBr586378eePmpF527QWI/NqYf6lPxKk1vryxd8DlCoIHdukw77xzmWBjV/CT5/pcXS
 18ww==
X-Gm-Message-State: AOJu0YxBHSMU3bIgg7MScdPILfwT5eQpW90/rken14JTegtma8CI8D1P
 CASkcMEslaB/2ZnnVR3KKlNG9mr/9tGMvGiMLmyPep0pIlxpkb3kAz68LbEVDQfHD+cVNiQmqiY
 q
X-Google-Smtp-Source: AGHT+IGO3jezWbdtn0uPJqPEsS05jrM4krkq5yq0KebbNJckuiUrDWpVdCdNdkuMMrJmBoVvUDX4KQ==
X-Received: by 2002:a05:6a00:3d49:b0:724:680d:d12c with SMTP id
 d2e1a72fcca58-72469cd7843mr2774768b3a.12.1731600319259; 
 Thu, 14 Nov 2024 08:05:19 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 52/54] accel/tcg: Unexport tlb_set_page*
Date: Thu, 14 Nov 2024 08:01:28 -0800
Message-ID: <20241114160131.48616-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

The new tlb_fill_align hook returns page data via structure
rather than by function call, so we can make tlb_set_page_full
be local to cputlb.c.  There are no users of tlb_set_page
or tlb_set_page_with_attrs, so those can be eliminated.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 57 -----------------------------------------
 accel/tcg/cputlb.c      | 27 ++-----------------
 2 files changed, 2 insertions(+), 82 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 69bdb77584..b65fc547bd 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -184,63 +184,6 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                vaddr len,
                                                uint16_t idxmap,
                                                unsigned bits);
-
-/**
- * tlb_set_page_full:
- * @cpu: CPU context
- * @mmu_idx: mmu index of the tlb to modify
- * @addr: virtual address of the entry to add
- * @full: the details of the tlb entry
- *
- * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
- * @full must be filled, except for xlat_section, and constitute
- * the complete description of the translated page.
- *
- * This is generally called by the target tlb_fill function after
- * having performed a successful page table walk to find the physical
- * address and attributes for the translation.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
-                       CPUTLBEntryFull *full);
-
-/**
- * tlb_set_page_with_attrs:
- * @cpu: CPU to add this TLB entry for
- * @addr: virtual address of page to add entry for
- * @paddr: physical address of the page
- * @attrs: memory transaction attributes
- * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
- * @mmu_idx: MMU index to insert TLB entry for
- * @size: size of the page in bytes
- *
- * Add an entry to this CPU's TLB (a mapping from virtual address
- * @addr to physical address @paddr) with the specified memory
- * transaction attributes. This is generally called by the target CPU
- * specific code after it has been called through the tlb_fill()
- * entry point and performed a successful page table walk to find
- * the physical address and attributes for the virtual address
- * which provoked the TLB miss.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
-                             hwaddr paddr, MemTxAttrs attrs,
-                             int prot, int mmu_idx, vaddr size);
-/* tlb_set_page:
- *
- * This function is equivalent to calling tlb_set_page_with_attrs()
- * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
- * as a convenience for CPUs which don't use memory transaction attributes.
- */
-void tlb_set_page(CPUState *cpu, vaddr addr,
-                  hwaddr paddr, int prot,
-                  int mmu_idx, vaddr size);
 #else
 static inline void tlb_init(CPUState *cpu)
 {
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ec597ed6f5..3d731b8f3d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1037,8 +1037,8 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
  * Called from TCG-generated code, which is under an RCU read-side
  * critical section.
  */
-void tlb_set_page_full(CPUState *cpu, int mmu_idx,
-                       vaddr addr, CPUTLBEntryFull *full)
+static void tlb_set_page_full(CPUState *cpu, int mmu_idx,
+                              vaddr addr, CPUTLBEntryFull *full)
 {
     CPUTLB *tlb = &cpu->neg.tlb;
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
@@ -1189,29 +1189,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     qemu_spin_unlock(&tlb->c.lock);
 }
 
-void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
-                             hwaddr paddr, MemTxAttrs attrs, int prot,
-                             int mmu_idx, uint64_t size)
-{
-    CPUTLBEntryFull full = {
-        .phys_addr = paddr,
-        .attrs = attrs,
-        .prot = prot,
-        .lg_page_size = ctz64(size)
-    };
-
-    assert(is_power_of_2(size));
-    tlb_set_page_full(cpu, mmu_idx, addr, &full);
-}
-
-void tlb_set_page(CPUState *cpu, vaddr addr,
-                  hwaddr paddr, int prot,
-                  int mmu_idx, uint64_t size)
-{
-    tlb_set_page_with_attrs(cpu, addr, paddr, MEMTXATTRS_UNSPECIFIED,
-                            prot, mmu_idx, size);
-}
-
 /*
  * Note: tlb_fill_align() can trigger a resize of the TLB.
  * This means that all of the caller's prior references to the TLB table
-- 
2.43.0



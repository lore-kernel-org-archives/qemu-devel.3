Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57733CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJV-0001a1-W2; Wed, 09 Oct 2024 11:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJU-0001ZB-J0
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJS-00080P-Pb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:20 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e15fe56c9so1476805b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486557; x=1729091357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y/9VaB8UKZR/34uiKoujjlQexVYllhaoIzyzusyrgR4=;
 b=oa2ZRzTkGJY03KyazUMFhSI0xkAsUyzEdTf4VmN5PIgfTLHn+pNcPy+LdVpjxTBZ83
 5tglmSKuoC/ITqOCGnF13hSz6VL2vCy1qUhTjeG8odLuBEaN1V2y2nVWX5wdHlfS1P4a
 Z0/0EWA3sx3pX90T5nD3bzIqFoSs7JX4rtAZ9AhPWd7DqPD0Hs0DnMTqjYysgxSpiT81
 XGC8lRvJZ13sQF3R+o98shyVnf2IQsIKfdEWtmSH077EFnKAV4w9qc8BD5e99yNdPHat
 0hMIfnLAfVNgnlorvzLX9vyu3HysgZbAfk8qbuT0rFsa5LcawAthTbawIIV3rGNwWPE2
 t3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486557; x=1729091357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/9VaB8UKZR/34uiKoujjlQexVYllhaoIzyzusyrgR4=;
 b=MWryf/bjDqsotaWKnPcq7JMp7PCoHTnbh5wXIV+g5BuOXsB4vSfyyf9dzWCDHuHJzQ
 H34wbSOY9iFa57CvuGMQrL8Bk4DHC06R536jl2YohdyhwZNqFRbZuwhAJqTn5b8LH/yX
 gP4mZktoyVRvUhBBJUYE74/rw1Lrj1IiqhOo8X2kjcO/yW8MalzbkoqRaORvAVlbrvS9
 IpM8sjX7gmf7Y/HCDKXzPH18mqeU4gTs8gOYREwxYZJiANPAG51GYy4eCWX47hUXsOvc
 LydYAPPKCUmlajtX2/T8JZke5XWioDD9KT9XL6gr4I3m7skIwuPUQBqAeQN40+xPTEwZ
 Zrsg==
X-Gm-Message-State: AOJu0YzPUJCAf2FVj/harXkm4saQXCpgDy6R4RNgE0r+jr3HRPIgAJLT
 1wLMRCTTMw/ROKKWnSlbpUs9ivAdXhEq1+tjrNs/10/mzte0pXIx+NvjRFmPNmhMhQ4M3QFoxEl
 S
X-Google-Smtp-Source: AGHT+IEZfm2sQtDYrRys4aZEV9UBsYmfgLvgFbYzKIhBM8I9d4qW+oIRGBhN46jowJtOlINnxyBOZA==
X-Received: by 2002:a05:6a00:23c1:b0:71e:210:be12 with SMTP id
 d2e1a72fcca58-71e267f710cmr440700b3a.21.1728486557301; 
 Wed, 09 Oct 2024 08:09:17 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [NOTYET PATCH 23/23] accel/tcg: Unexport tlb_set_page*
Date: Wed,  9 Oct 2024 08:08:55 -0700
Message-ID: <20241009150855.804605-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index 72240ef426..8e2ab26902 100644
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
index 55c7bf737b..5efd6e536c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1066,8 +1066,8 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
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
@@ -1218,29 +1218,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33FCC5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8i-0008Er-1V; Sat, 15 Aug 2026 16:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8f-0008BB-KF
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8c-0008JD-FQ
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:57 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2d02b4c3601so24310815ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826268; x=1787431068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zk4qMQYX28j97m/g2YYmzDXr2lMBSgsykgiPV83NOik=;
 b=mH3kNAvpGqGmXxeYUOQITd01LHGip8KIoNUsqx/F5OMkQVqD6JXhH7UDM4Q6hrWdMT
 XkHxogjnt4odaft2J57YH4hJRUvaaHg6CopBHh6evmb5Hg/NTqQqJsMJZFKl9ZrLJENz
 Ba/fWPweZa7XYeJvklJ3LPjf8E7wrSg7JaXizWShWv52+MeJiGb2OjWyY/DuNZRrfOnL
 UhTtzcctOELfMF0MBxxZrHkcdAZiC4vZJSid9Lf2KQ0Y0jo6E1i9eYHHouiGsUdBgcek
 GgrMnkk6XRuUfLLOmypBZltuYuaN6fO7PIIUPm2QWzSG5CAHF1rOf7zPPO0mTLQOOGxv
 yaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826268; x=1787431068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zk4qMQYX28j97m/g2YYmzDXr2lMBSgsykgiPV83NOik=;
 b=NoXqanqw5YaOi/a59UjJ9hDbSWGxiWdLyeC8ZY6tpoXfkCya54jI+VDcjKOJcoHNpG
 vi+9EGtHc+iQucpQi9QYxPOJdmqztZ0zITY17syoee72/vpdQeAckPeR2nN/kEe+qiBE
 1KorHdUr43Ts6VEn6ALUjGathDBV7CPxEKHVr6Aud+VuQfQLqdAQR0DZya5iUNDBISq8
 +EfRuTrICCjWCVoh5qBqIuXnDmum0uQ0pGTy07Uf3iMEkJlH83PJDX4sbqG5ONIcJiCs
 NDSlVMGHlCO5eojSYndwlKjRQ8R+wlgHd18ZiAn3yM9itvQMF+ENCPj9jl0jZM6JumTT
 bULg==
X-Gm-Message-State: AOJu0YytK/bgpfKtK2oHppYHI/Xtl1O7ox+0VkDe+mmi6YyxXB0fD/bW
 N6TSXz/iCXvXC9QB0CEAxOYxHQcZjRd5FNHTa8+osGVEeYEE9CxNKTBzPp/MVkrBlVzAAXOXVRS
 M4RPk
X-Gm-Gg: AR+sD12d9se/E8TLKOrGJ5mBsDeN5CIEncw3/HVrA49hcns36u9Ai8L4/fhkAEiwsaT
 29VQ8qW5SxZugqdL4jLXeLOIkdUbA31cGS5md1AtTbZH5G8DSJJaLQXlYIjU7mWQ6u+F7qSlYOj
 MH0YrORZVWp13yoaw/HPW5di0hPKLP03I374ctqcutd4Yt1L7sdsJBTogK0RSyrU4y02A7UaZIt
 3JUrzQZvsnjFv+nNbTgIecpT/e9vdpXSj7RoaTjWbLoIlDS0Dl6GvbOLcdoeqmPqlM14KihKSwU
 wiNqzHdnIn6P6+vvQuxuAv4zaTMJIEZx0vFaeEcup3sHw8i3/CmHVu93rp+r9aHkD5rBOsPlxii
 lu6/m8nJfTPb6hWA0hmG1iVFZSREZ8c+aRaH4mAJaeiIMG7IXZybNqaDE4cD/0Or44IofCQjWgJ
 9y3AXDoYeu4i9tFfSbiqcBM4g4WkLBMWtyeY1S4b9WmaDh085CymcohN1RUyiQlV1R4YCalNEr2
 girF8C6ypoM7KPsyqnY
X-Received: by 2002:a17:90b:2781:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-3933b87a55cmr17424460a91.13.1786826268066; 
 Sat, 15 Aug 2026 13:37:48 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 11/18] accel/tcg: Replace size with first/last in
 tlb_fill_align
Date: Sat, 15 Aug 2026 13:37:23 -0700
Message-ID: <20260815203730.1468365-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Propagate the API change down one step further within cputlb.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b8c23b2948..95db2c22e2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1236,11 +1236,12 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
  * (e.g. CPUTLBEntry pointers) must be discarded and looked up again
  * (e.g. via tlb_entry()).
  */
-static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
-                           int mmu_idx, MemOp memop, int size,
+static bool tlb_fill_align(CPUState *cpu, vaddr addr, vaddr first, vaddr last,
+                           MMUAccessType type, int mmu_idx, MemOp memop,
                            bool probe, uintptr_t ra)
 {
     const TCGCPUOps *ops = cpu->cc->tcg_ops;
+    int size = last - addr + 1;
     CPUTLBEntryFull full;
 
     if (ops->tlb_fill_align) {
@@ -1374,8 +1375,8 @@ static int probe_access_internal(CPUState *cpu, vaddr addr, vaddr first,
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, page_addr)) {
-            if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
-                                0, last - addr + 1, nonfault, retaddr)) {
+            if (!tlb_fill_align(cpu, addr, first, last, access_type,
+                                mmu_idx, MO_UNALN, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
                 *phost = NULL;
                 *pfull = NULL;
@@ -1664,8 +1665,8 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
                             addr & TARGET_PAGE_MASK)) {
-            tlb_fill_align(cpu, addr, access_type, mmu_idx,
-                           memop, data->size, false, ra);
+            tlb_fill_align(cpu, addr, addr, addr + data->size - 1,
+                           access_type, mmu_idx, memop, false, ra);
             maybe_resized = true;
             index = tlb_index(cpu, mmu_idx, addr);
             entry = tlb_entry(cpu, mmu_idx, addr);
@@ -1833,8 +1834,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
                             addr & TARGET_PAGE_MASK)) {
-            tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
-                           mop, size, false, retaddr);
+            tlb_fill_align(cpu, addr, addr, addr + size - 1,
+                           MMU_DATA_STORE, mmu_idx, mop, false, retaddr);
             did_tlb_fill = true;
             index = tlb_index(cpu, mmu_idx, addr);
             tlbe = tlb_entry(cpu, mmu_idx, addr);
@@ -1849,8 +1850,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
      * but addr_read will only be -1 if PAGE_READ was unset.
      */
     if (unlikely(tlbe->addr_read == -1)) {
-        tlb_fill_align(cpu, addr, MMU_DATA_LOAD, mmu_idx,
-                       0, size, false, retaddr);
+        tlb_fill_align(cpu, addr, addr, addr + size - 1,
+                       MMU_DATA_LOAD, mmu_idx, 0, false, retaddr);
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
-- 
2.43.0



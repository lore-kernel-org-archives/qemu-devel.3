Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09AFCEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJO-0001VR-H4; Wed, 09 Oct 2024 11:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJM-0001S8-IS
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:12 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJK-0007yS-Iz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e15fe56c9so1476689b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486549; x=1729091349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vtsD+NWTF2Y7/FLWaniy0sQLDGJ5gtBdhjO1P4fjsBU=;
 b=Gwgr3HMv8Ra1ReLwmZ3mY6WrfKq/XmgNuV3MXjTxADB5E+u61MTzU8Z1hBp3Q3xnAV
 88gpU5nlIn5OHA47nkTwz+Xc39kuQ2qAhX+RBTQ4+cD/CF0oNUhSkgKd7mLCfAxJa3Pz
 sbFo1z/oJiP8iHDgaBViWuKoWNbcj20MKZdkaDmfO5a3B2upjR/G4pD/yKACzvNokBeT
 xsOnAKtpoHUBH+KuCSFBqCmx3CsmtQq7TVIAi3qdDQWUanjSc5bBPikeaNhahoBBYhz0
 33jfaAMYYYipKK+V4owHvlQmUUVYCncwsA1GyLAOxPrzzyp4AiNVxP+7DsCEXR5hpV4F
 KEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486549; x=1729091349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtsD+NWTF2Y7/FLWaniy0sQLDGJ5gtBdhjO1P4fjsBU=;
 b=cb8+3GRJfzk9i3OcspzYNt2RGhtGddEqf0BMlWqQfieEGCLMokwe7qLyisp9VTCQ33
 rsD/TX0fj2UeoLYKX++7FQVAkExRP4crxg3y7cPzMDN2X+05nuiD+cCymkA00fpnamWQ
 eMJq0Vn9uwl+dskAS1nJ5F7ZhjYVHzDDXxRbuZiv7Qqz9tUMjTu1C/aXo9rTj/Co++v3
 qh9pF7FAnBqcLNqXtgKsEG63k15kzFMV3xrwj9tZUdBcF+bYmqODP+bD+yAEI2e8oM/t
 rCVZ6XQ7mtXURssMh0kClJqeSMPWclxBhDJJCWonPJj7Apdb6SJRu9GK+f1pHGkt5B1w
 RP2Q==
X-Gm-Message-State: AOJu0YwyWYEuHQqYtruCa89kgNq5Mvvlbkf/i3XWrHEBS1Kl1jArkXKk
 SMyt1gjZbLbEOoCco/UnI/K6Ca/VPVy19E8nswcvj93ZueidgBFyE6llDDO8o2/vQD4nGmgQHIz
 u
X-Google-Smtp-Source: AGHT+IGyrwHOkiXiXEtijdkYc8915t8C8f2vkVxacIVa9uZj/BtX+W3hC7El/6HB1H4aA+nynQ5mqg==
X-Received: by 2002:a05:6a00:928f:b0:71d:ffef:c165 with SMTP id
 d2e1a72fcca58-71e2680af1dmr376158b3a.25.1728486549222; 
 Wed, 09 Oct 2024 08:09:09 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/23] accel/tcg: Replace victim_tlb_hit with tlbtree_hit
Date: Wed,  9 Oct 2024 08:08:46 -0700
Message-ID: <20241009150855.804605-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Change from a linear search on the victim tlb
to a balanced binary tree search on the interval tree.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 62 +++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ec989f1290..b10b0a357c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1398,36 +1398,38 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
     }
 }
 
-/* Return true if ADDR is present in the victim tlb, and has been copied
-   back to the main tlb.  */
-static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
-                           MMUAccessType access_type, vaddr page)
+/*
+ * Return true if ADDR is present in the interval tree,
+ * and has been copied back to the main tlb.
+ */
+static bool tlbtree_hit(CPUState *cpu, int mmu_idx,
+                        MMUAccessType access_type, vaddr addr)
 {
-    size_t vidx;
+    CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
+    CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
+    CPUTLBEntryTree *node;
+    size_t index;
 
     assert_cpu_is_self(cpu);
-    for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
-        CPUTLBEntry *vtlb = &cpu->neg.tlb.d[mmu_idx].vtable[vidx];
-        uint64_t cmp = tlb_read_idx(vtlb, access_type);
-
-        if (cmp == page) {
-            /* Found entry in victim tlb, swap tlb and iotlb.  */
-            CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
-
-            qemu_spin_lock(&cpu->neg.tlb.c.lock);
-            copy_tlb_helper_locked(&tmptlb, tlb);
-            copy_tlb_helper_locked(tlb, vtlb);
-            copy_tlb_helper_locked(vtlb, &tmptlb);
-            qemu_spin_unlock(&cpu->neg.tlb.c.lock);
-
-            CPUTLBEntryFull *f1 = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
-            CPUTLBEntryFull *f2 = &cpu->neg.tlb.d[mmu_idx].vfulltlb[vidx];
-            CPUTLBEntryFull tmpf;
-            tmpf = *f1; *f1 = *f2; *f2 = tmpf;
-            return true;
-        }
+    node = tlbtree_lookup_addr(desc, addr);
+    if (!node) {
+        /* There is no cached mapping for this page. */
+        return false;
     }
-    return false;
+
+    if (!tlb_hit(tlb_read_idx(&node->copy, access_type), addr)) {
+        /* This access is not permitted. */
+        return false;
+    }
+
+    /* Install the cached entry. */
+    index = tlbfast_index(fast, addr);
+    qemu_spin_lock(&cpu->neg.tlb.c.lock);
+    copy_tlb_helper_locked(&fast->table[index], &node->copy);
+    qemu_spin_unlock(&cpu->neg.tlb.c.lock);
+
+    desc->fulltlb[index] = node->full;
+    return true;
 }
 
 static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
@@ -1469,7 +1471,7 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     CPUTLBEntryFull *full;
 
     if (!tlb_hit_page(tlb_addr, page_addr)) {
-        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, page_addr)) {
+        if (!tlbtree_hit(cpu, mmu_idx, access_type, page_addr)) {
             if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
                                 0, fault_size, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
@@ -1749,8 +1751,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
-        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
-                            addr & TARGET_PAGE_MASK)) {
+        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
             tlb_fill_align(cpu, addr, access_type, mmu_idx,
                            memop, data->size, false, ra);
             maybe_resized = true;
@@ -1929,8 +1930,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     /* Check TLB entry and enforce page permissions.  */
     flags = TLB_FLAGS_MASK;
     if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
-        if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
-                            addr & TARGET_PAGE_MASK)) {
+        if (!tlbtree_hit(cpu, mmu_idx, MMU_DATA_STORE, addr)) {
             tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
                            mop, size, false, retaddr);
             did_tlb_fill = true;
-- 
2.43.0



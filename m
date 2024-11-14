Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEE8D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJU-0006JX-0C; Thu, 14 Nov 2024 11:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI3-0004zA-NZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:51 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI0-0002Dp-OO
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:51 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72410cc7be9so731796b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600105; x=1732204905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qWIXUHGQnTcdkm072yvGDVIoDbE1775WHviaFUbmmuU=;
 b=ovA8eWyTCJLl8iHhUBRmn93o83Eq2I4oEyHSNgLisnbg3WffO2OIvvhWs0N3LEZGcp
 +nntnn0adTEZ1UoPuh3EP9n+HgZ+scVffr+hGbkCuBijx4B6UMbyoxLvlRvGtzXIt0e5
 YEHa/YR46Newt+2wdiI7pUslJSbH31ELw9qbZDE2H/oXnlOGswS9mXvI3Hu0EB6xxtLG
 OLXjMOngFlX/yDIJLgB+8DVY2ncqzmYI5qmS7ceS8u1rsUu8qrrG75GHC73JPrHx4lZU
 5AuSl6T5+A5BQh+ZOPH84Vt6KzNl/N1ytmZ0hrhkVVWPf4CeN6FC4YaQaAYEsFRShiro
 5QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600105; x=1732204905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWIXUHGQnTcdkm072yvGDVIoDbE1775WHviaFUbmmuU=;
 b=TYFb/kSYtvymoFeF2WCQaUs+a4z7v/qKFlkI+rOEDAEGzJVUN16rfX72XXZLB1erIE
 DCyt01bcRUegcflaPuqd6xxmNpwsC2UQJvO15dgOzGVdrxAUaTjmiFmDk8E5TY6ucmZH
 aR9r6LGZHwdtXt60Zg+ktVyb1sVHhdqmHhiM2vQ79be62MyV49fAks70M+3RbM3AmOW6
 T0tTZcMQEzTzxZo9MD8iHTSuSYUr7T8wd8wA9q+7i2OON9F39GnbLf3KXCepNo/Pb443
 n5T85nP8mAlBPTpChubC2Hu+lLSIqYfKdv5zYTq5mjZesYCkMKbV7jQiVOohUEK0XyJB
 8RfA==
X-Gm-Message-State: AOJu0YwG5JBPcDRFwKfSqnnr22rgv5/rUMA4pGI1anBzS5QNvohEMCxQ
 NtpFJumlOczIo4z9GvD2XqMzpcPI1f7jQ6uNAS09faYIGlnVEMZpmurv4aRawKEW0Uhc1plEiwT
 /
X-Google-Smtp-Source: AGHT+IHPvPz14MAvO19icCcoybrM8ZtKp3yBE5tx84N/3/o3EC5HVEijtTtZIi2335BwNZMR67Pj6A==
X-Received: by 2002:a17:90b:3883:b0:2e2:d3e1:f863 with SMTP id
 98e67ed59e1d1-2e9b171e360mr33853299a91.12.1731600105146; 
 Thu, 14 Nov 2024 08:01:45 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/54] accel/tcg: Replace victim_tlb_hit with tlbtree_hit
Date: Thu, 14 Nov 2024 08:00:53 -0800
Message-ID: <20241114160131.48616-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 accel/tcg/cputlb.c | 59 ++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3aab72ea82..ea4b78866b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1384,35 +1384,38 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
     }
 }
 
-/* Return true if ADDR is present in the victim tlb, and has been copied
-   back to the main tlb.  */
-static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
-                           MMUAccessType access_type, vaddr addr)
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
-
-        if (tlb_hit(tlb_read_idx(vtlb, access_type), addr)) {
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
@@ -1453,7 +1456,7 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     CPUTLBEntryFull *full;
 
     if (!tlb_hit(tlb_addr, addr)) {
-        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, addr)) {
+        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
             if (!tlb_fill_align(cpu, addr, access_type, mmu_idx,
                                 0, fault_size, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
@@ -1733,7 +1736,7 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
 
     /* If the TLB entry is for a different page, reload and try again.  */
     if (!tlb_hit(tlb_addr, addr)) {
-        if (!victim_tlb_hit(cpu, mmu_idx, index, access_type, addr)) {
+        if (!tlbtree_hit(cpu, mmu_idx, access_type, addr)) {
             tlb_fill_align(cpu, addr, access_type, mmu_idx,
                            memop, data->size, false, ra);
             maybe_resized = true;
@@ -1912,7 +1915,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     /* Check TLB entry and enforce page permissions.  */
     flags = TLB_FLAGS_MASK;
     if (!tlb_hit(tlb_addr_write(tlbe), addr)) {
-        if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE, addr)) {
+        if (!tlbtree_hit(cpu, mmu_idx, MMU_DATA_STORE, addr)) {
             tlb_fill_align(cpu, addr, MMU_DATA_STORE, mmu_idx,
                            mop, size, false, retaddr);
             did_tlb_fill = true;
-- 
2.43.0



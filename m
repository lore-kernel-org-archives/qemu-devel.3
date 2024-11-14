Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BD7D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJY-0006ik-TP; Thu, 14 Nov 2024 11:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIJ-000527-PF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:09 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcID-0002HL-LI
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:05 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e9ff7a778cso766594a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600120; x=1732204920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gRqWI+rp5TQr50PN/dQhc9ynBvziyOUstyxN8uI5DJA=;
 b=zOXir8AT4W9R7vUhOk9GOfjuHugytrZOF2H3G0mB4JM15HGAk1KvkGilEzziqSNI/Y
 jZwrK8l7MBVNar1h8zwjMyzLQeaK1a8b7qlCeOU8H6oRpR26PliTEg2u+jTwxZ0h8NOC
 MalEWlBOOAAfx8fAcszj4lJjt9WentAUU5pEygvtbxejChXANTUCOD+Tm8sEepWVoLQj
 G/ikxU27HRtkHtADcKGW1rgGfxqNOeO80V2v0O0WXpLkjkWCM8RR7NT6t1ecxxoSLxEq
 7S75rlm9JpYPNorQ18End7xqgsB0p54eBYFBiPZTvHI/FYiuWT3J+GY1DcTjXEcnJQan
 dcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600120; x=1732204920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRqWI+rp5TQr50PN/dQhc9ynBvziyOUstyxN8uI5DJA=;
 b=ms+abNZT2Im/R2D2fV5fPNp+BnASk1mQHAmsJ0uOD7Fpw5dgLQohqEFhBGRxWMhkBw
 OZQ3VD8KGvKfbe4u44qNkETyD4hKX1BhstPGSfTi6zvD39x2hzfGlsFqYLHXy417rCr8
 /nKR3aL0uOmQ3st0yySRsHp4N3NfkSXC7jSi0bBbfkGqjVvh+zuFJaWE6H1cCEAf91mG
 1FY0GawSRpZmpN86G4fprF3vzXUhlLlmZffFHSGVp9CZj4A9kIT140yD+AtLwbl/36N2
 w33uunjOG7ZWJiPtWikn2HXORjz65aGD1f8yUZemlpzvbmAuTN4Zk2wR6mVxZ2DDW6/A
 7T3A==
X-Gm-Message-State: AOJu0Yxmc7qQSod1KHH4Wf+ttsiAdDy/ZaHxUYb9q0WUGRzWNKi45Z+y
 GrEle56I0sBsyalhT7/eqG47NYTL6nBntxVgSQhErR64GbaVbqNwUNZNnNqOtDhw3HzizXVlKom
 /
X-Google-Smtp-Source: AGHT+IFJ5BI//ltdBDttI/6INQQy1I3mSJ5gcLja933v+C+AcspAAagD/nkkOznE3BryN8lA/sIrqA==
X-Received: by 2002:a17:90b:3503:b0:2e9:3056:71dd with SMTP id
 98e67ed59e1d1-2e9fe62dd8cmr6507773a91.7.1731600119527; 
 Thu, 14 Nov 2024 08:01:59 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 31/54] accel/tcg: Always use IntervalTree for code lookups
Date: Thu, 14 Nov 2024 08:01:07 -0800
Message-ID: <20241114160131.48616-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Because translation is special, we don't need the speed
of the direct-mapped softmmu tlb.  We cache a lookups in
DisasContextBase within the translator loop anyway.

Drop the addr_code comparator from CPUTLBEntry.
Go directly to the IntervalTree for MMU_INST_FETCH.
Derive exec flags from read flags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    |  3 ++
 include/exec/tlb-common.h |  5 ++-
 accel/tcg/cputlb.c        | 76 ++++++++++++++++++++++++---------------
 3 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 45e6676938..ad160c328a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -339,6 +339,9 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
     (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
     | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
 
+/* Filter read flags to exec flags. */
+#define TLB_EXEC_FLAGS_MASK  (TLB_MMIO)
+
 /*
  * Flags stored in CPUTLBEntryFull.slow_flags[x].
  * TLB_FORCE_SLOW must be set in CPUTLBEntry.addr_idx[x].
diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
index 300f9fae67..feaa471299 100644
--- a/include/exec/tlb-common.h
+++ b/include/exec/tlb-common.h
@@ -26,7 +26,6 @@ typedef union CPUTLBEntry {
     struct {
         uint64_t addr_read;
         uint64_t addr_write;
-        uint64_t addr_code;
         /*
          * Addend to virtual address to get host address.  IO accesses
          * use the corresponding iotlb value.
@@ -35,7 +34,7 @@ typedef union CPUTLBEntry {
     };
     /*
      * Padding to get a power of two size, as well as index
-     * access to addr_{read,write,code}.
+     * access to addr_{read,write}.
      */
     uint64_t addr_idx[(1 << CPU_TLB_ENTRY_BITS) / sizeof(uint64_t)];
 } CPUTLBEntry;
@@ -92,7 +91,7 @@ struct CPUTLBEntryFull {
      * Additional tlb flags for use by the slow path. If non-zero,
      * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
      */
-    uint8_t slow_flags[MMU_ACCESS_COUNT];
+    uint8_t slow_flags[2];
 
     /*
      * Allow target-specific additions to this structure.
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 981098a6f2..be2ea1bc70 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -114,8 +114,9 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
                       MMU_DATA_LOAD * sizeof(uint64_t));
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
                       MMU_DATA_STORE * sizeof(uint64_t));
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
-                      MMU_INST_FETCH * sizeof(uint64_t));
+
+    tcg_debug_assert(access_type == MMU_DATA_LOAD ||
+                     access_type == MMU_DATA_STORE);
 
 #if TARGET_LONG_BITS == 32
     /* Use qatomic_read, in case of addr_write; only care about low bits. */
@@ -480,8 +481,7 @@ static bool tlb_hit_page_mask_anyprot(CPUTLBEntry *tlb_entry,
     mask &= TARGET_PAGE_MASK | TLB_INVALID_MASK;
 
     return (page == (tlb_entry->addr_read & mask) ||
-            page == (tlb_addr_write(tlb_entry) & mask) ||
-            page == (tlb_entry->addr_code & mask));
+            page == (tlb_addr_write(tlb_entry) & mask));
 }
 
 /* Called with tlb_c.lock held */
@@ -1184,9 +1184,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     /* Now calculate the new entry */
     node->copy.addend = addend - addr_page;
 
-    tlb_set_compare(full, &node->copy, addr_page, read_flags,
-                    MMU_INST_FETCH, prot & PAGE_EXEC);
-
     if (wp_flags & BP_MEM_READ) {
         read_flags |= TLB_WATCHPOINT;
     }
@@ -1308,22 +1305,30 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
     /* Primary lookup in the fast tlb. */
     entry = tlbfast_entry(fast, addr);
     full = &desc->fulltlb[tlbfast_index(fast, addr)];
-    cmp = tlb_read_idx(entry, access_type);
-    if (tlb_hit(cmp, addr)) {
-        goto found;
+    if (access_type != MMU_INST_FETCH) {
+        cmp = tlb_read_idx(entry, access_type);
+        if (tlb_hit(cmp, addr)) {
+            goto found_data;
+        }
     }
 
     /* Secondary lookup in the IntervalTree. */
     node = tlbtree_lookup_addr(desc, addr);
     if (node) {
-        cmp = tlb_read_idx(&node->copy, access_type);
-        if (tlb_hit(cmp, addr)) {
-            /* Install the cached entry. */
-            qemu_spin_lock(&cpu->neg.tlb.c.lock);
-            copy_tlb_helper_locked(entry, &node->copy);
-            qemu_spin_unlock(&cpu->neg.tlb.c.lock);
-            *full = node->full;
-            goto found;
+        if (access_type == MMU_INST_FETCH) {
+            if (node->full.prot & PAGE_EXEC) {
+                goto found_code;
+            }
+        } else {
+            cmp = tlb_read_idx(&node->copy, access_type);
+            if (tlb_hit(cmp, addr)) {
+                /* Install the cached entry. */
+                qemu_spin_lock(&cpu->neg.tlb.c.lock);
+                copy_tlb_helper_locked(entry, &node->copy);
+                qemu_spin_unlock(&cpu->neg.tlb.c.lock);
+                *full = node->full;
+                goto found_data;
+            }
         }
     }
 
@@ -1333,9 +1338,14 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
         tcg_debug_assert(probe);
         return false;
     }
-
     o->did_tlb_fill = true;
 
+    if (access_type == MMU_INST_FETCH) {
+        node = tlbtree_lookup_addr(desc, addr);
+        tcg_debug_assert(node);
+        goto found_code;
+    }
+
     entry = tlbfast_entry(fast, addr);
     full = &desc->fulltlb[tlbfast_index(fast, addr)];
     cmp = tlb_read_idx(entry, access_type);
@@ -1345,14 +1355,29 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
      * called tlb_fill_align, so we know that this entry *is* valid.
      */
     flags &= ~TLB_INVALID_MASK;
+    goto found_data;
+
+ found_data:
+    flags &= cmp;
+    flags |= full->slow_flags[access_type];
+    o->flags = flags;
+    o->full = *full;
+    o->haddr = (void *)((uintptr_t)addr + entry->addend);
     goto done;
 
- found:
-    /* Alignment has not been checked by tlb_fill_align. */
-    {
+ found_code:
+    o->flags = node->copy.addr_read & TLB_EXEC_FLAGS_MASK;
+    o->full = node->full;
+    o->haddr = (void *)((uintptr_t)addr + node->copy.addend);
+    goto done;
+
+ done:
+    if (!o->did_tlb_fill) {
         int a_bits = memop_alignment_bits(memop);
 
         /*
+         * Alignment has not been checked by tlb_fill_align.
+         *
          * The TLB_CHECK_ALIGNED check differs from the normal alignment
          * check, in that this is based on the atomicity of the operation.
          * The intended use case is the ARM memory type field of each PTE,
@@ -1366,13 +1391,6 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
             cpu_unaligned_access(cpu, addr, access_type, i->mmu_idx, i->ra);
         }
     }
-
- done:
-    flags &= cmp;
-    flags |= full->slow_flags[access_type];
-    o->flags = flags;
-    o->full = *full;
-    o->haddr = (void *)((uintptr_t)addr + entry->addend);
     return true;
 }
 
-- 
2.43.0



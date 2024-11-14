Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0C4D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJ5-0005cE-4L; Thu, 14 Nov 2024 11:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-00052J-Jh
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:11 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIF-0002HU-Ij
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:07 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7ed9c16f687so615276a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600121; x=1732204921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C92gX+NWcvvyINoBcMpyemaXSV00oH2ZBkWs2vS0nJE=;
 b=WcY5B3wR5JMvxhfpO2pxX925ODmxlMKnsvSEdi4s6uhJhBvD3V60MqViUXf1tKzxKQ
 7qQqrJTfolPTgB/90aj2lEiWqSj3K40nUrF5k/0k8fbfhMpd//nOWuMO6W62EuGEN5Hq
 kyzHX82LHmucwXRhzNtJvm3xapdchg7l0e7xpKk9MW+9Ca+7k0nqxSwzZq6JlipCiRAc
 yQKYW80uhuH1pLGEQrWwJV4JLKyVhRWvgeciZYLapevBONGT0EVyHAMLkFmnbN4qzXuf
 4RJ4clkueykR+dOD9pQFJhfaf4KNDhVIHLB+3n88Xc3pnhKjVATq39pt+CJtXmGg/1Ro
 wCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600121; x=1732204921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C92gX+NWcvvyINoBcMpyemaXSV00oH2ZBkWs2vS0nJE=;
 b=r7bcBgRxkYpdGb/QpOxgGg00rZzxp5cP8wSG4SKEYLqx4Gxdf3ywpvKppY7zhS2asG
 ujSoVfHOf8AF3T8o0N7+8d9303UJvLfoShLjOQ8EqI3gLMfge+dkjfWi8p0ncmdbxa3z
 TrYfo7H0Yw1Qxoz54yW0BZdCW1DTdT/Mw7+ny/8EbsY7D6Dx75Mue4sIkZSoOjOkA6ok
 lyjbmEFmOtEdG0xJHUeBs/ZN6VIQlkol0k84lUAZg8LmD8BKJFU3uv8Vl4l8WO3zNVkb
 gEQorTt/8TO2OAmENY5cwXJEnPLGRFW8IKwqYPosJxCANdJqu+Z1xzFrJzSjXP25x9wT
 p1XA==
X-Gm-Message-State: AOJu0Yyxjg7d8heqz39NtD/MUermjWeP1CSea5spb9w/pIyP6rf7qlCy
 JSA2MAGsUautGIuHlprCY9uNl5pxh7wKDDSugUG/DDMFDKpWjM235VkVArX8+KxEULPF9fSqRai
 P
X-Google-Smtp-Source: AGHT+IH1bmGFUpP5442RkaAfKsgvmPq8vkXQThC5va/ntSAMd2rmyRSBzkZHXnVp8ir6wCg57S9F4g==
X-Received: by 2002:a17:90b:4b0f:b0:2e2:a013:859a with SMTP id
 98e67ed59e1d1-2e9f2c4ef3bmr9095877a91.7.1731600120301; 
 Thu, 14 Nov 2024 08:02:00 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 32/54] accel/tcg: Link CPUTLBEntry to CPUTLBEntryTree
Date: Thu, 14 Nov 2024 08:01:08 -0800
Message-ID: <20241114160131.48616-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 accel/tcg/cputlb.c        | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 13 deletions(-)

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
index be2ea1bc70..3282436752 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -490,7 +490,10 @@ static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
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
@@ -1183,6 +1186,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
     /* Now calculate the new entry */
     node->copy.addend = addend - addr_page;
+    node->copy.tree = node;
 
     if (wp_flags & BP_MEM_READ) {
         read_flags |= TLB_WATCHPOINT;
@@ -1291,7 +1295,6 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
     CPUTLBDescFast *fast = &cpu->neg.tlb.f[i->mmu_idx];
     vaddr addr = i->addr;
     MMUAccessType access_type = i->access_type;
-    CPUTLBEntryFull *full;
     CPUTLBEntryTree *node;
     CPUTLBEntry *entry;
     uint64_t cmp;
@@ -1304,9 +1307,9 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
 
     /* Primary lookup in the fast tlb. */
     entry = tlbfast_entry(fast, addr);
-    full = &desc->fulltlb[tlbfast_index(fast, addr)];
     if (access_type != MMU_INST_FETCH) {
         cmp = tlb_read_idx(entry, access_type);
+        node = entry->tree;
         if (tlb_hit(cmp, addr)) {
             goto found_data;
         }
@@ -1326,7 +1329,6 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
                 qemu_spin_lock(&cpu->neg.tlb.c.lock);
                 copy_tlb_helper_locked(entry, &node->copy);
                 qemu_spin_unlock(&cpu->neg.tlb.c.lock);
-                *full = node->full;
                 goto found_data;
             }
         }
@@ -1347,8 +1349,8 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
     }
 
     entry = tlbfast_entry(fast, addr);
-    full = &desc->fulltlb[tlbfast_index(fast, addr)];
     cmp = tlb_read_idx(entry, access_type);
+    node = entry->tree;
     /*
      * With PAGE_WRITE_INV, we set TLB_INVALID_MASK immediately,
      * to force the next access through tlb_fill_align.  We've just
@@ -1359,19 +1361,18 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
 
  found_data:
     flags &= cmp;
-    flags |= full->slow_flags[access_type];
+    flags |= node->full.slow_flags[access_type];
     o->flags = flags;
-    o->full = *full;
-    o->haddr = (void *)((uintptr_t)addr + entry->addend);
-    goto done;
+    goto found_common;
 
  found_code:
     o->flags = node->copy.addr_read & TLB_EXEC_FLAGS_MASK;
+    goto found_common;
+
+ found_common:
     o->full = node->full;
     o->haddr = (void *)((uintptr_t)addr + node->copy.addend);
-    goto done;
 
- done:
     if (!o->did_tlb_fill) {
         int a_bits = memop_alignment_bits(memop);
 
@@ -1669,7 +1670,6 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
                        bool is_store, struct qemu_plugin_hwaddr *data)
 {
     CPUTLBEntry *tlbe = tlb_entry(cpu, mmu_idx, addr);
-    uintptr_t index = tlb_index(cpu, mmu_idx, addr);
     MMUAccessType access_type = is_store ? MMU_DATA_STORE : MMU_DATA_LOAD;
     uint64_t tlb_addr = tlb_read_idx(tlbe, access_type);
     CPUTLBEntryFull *full;
@@ -1678,7 +1678,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
         return false;
     }
 
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+    full = &tlbe->tree->full;
     data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
     /* We must have an iotlb entry for MMIO */
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DD0D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJ8-0005m8-Ui; Thu, 14 Nov 2024 11:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIO-00053N-II
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:13 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIJ-0002Gz-D8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:12 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ea0c38f0fdso444987a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600115; x=1732204915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KiD2QRw11IfiGIBgEwLODrTbmi4491+hXDJh5Wff0xY=;
 b=hzZjhiJ7yxmab5kHBwn7TxHmvcC3MJ4lvsZzDr0MoD7RVgdTDxEwTqL9bsOSKUuXvl
 ZCv/91/sMpkvPSbZHDda2IvpmQOM5/gt1NZHwTMHko/ea0J/R4S0dV1FAg/q3n+GBQoz
 a1UUckLCduoSfQVSh568ARFqUoL1pC+jp0PxCKSOOF7K4kIj61N0stRpWWA/HNE8hD7m
 rHegTpfWZ7uy43ZzM5mQD2troZo8n1OZ2c8jy/y+dyYoYFKLBx/ZyRi9VMf/y2rUK+h0
 rbxkUauOPWi1TAe385zaZrpcQG3mV28VsonbiJWTyRwh9S1G9RcGSWvf5s8jNaX5xgDR
 soHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600115; x=1732204915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KiD2QRw11IfiGIBgEwLODrTbmi4491+hXDJh5Wff0xY=;
 b=dkFsENO8rHXvYLm4AyAvadq9gz1lYSOL8i7ZiJ5zls94AZHlItijDHMFC3XQearmh9
 utnVgLvgZ9EBRm0ztMFZJ00XaRwrZYfJ5Sh3tH3IwaA0+UZZrNByzx5276IwuUcdqJmH
 5JZZ+F3wBeL8RLhMnFMWcD+EMiKXESCbaP4j3bcb+KW44rKEqiMWFcl9w77vz9oVyKNt
 5YCfa1sdUdIhgvwPKT5ph+A9alG45kTS9VFmV7DdHM449S/gYNiiozN5mKY36fPl5uuc
 TN72kKMHTDPSv6EbOhwU9omnVfisUkBG65RI0ZdbBZfhty5LtNtp6ctHc9+ZK0sMtHIB
 Jtiw==
X-Gm-Message-State: AOJu0YyNtvtHamoCEgWjiJMNl0h0vNpKNSP/msx1uWgfxDXih6C+WQii
 lvOf96GxYqhehU5mw590zKqKLnVI89gghgJf3BhlrbGrCM0+jq5bWeoqFAkKsNeqNAZp91nMmu7
 1
X-Google-Smtp-Source: AGHT+IEwAnamhG6Wsz49aAe8amyREuM4MSSY0/Enh1wOpOfXJdOfDELR22yWAUTA0birea61vPeX8A==
X-Received: by 2002:a17:90a:d2cc:b0:2e9:c902:d53 with SMTP id
 98e67ed59e1d1-2e9c9020e26mr22441031a91.14.1731600114497; 
 Thu, 14 Nov 2024 08:01:54 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 26/54] accel/tcg: Return CPUTLBEntryFull not pointer in
 probe_access_full
Date: Thu, 14 Nov 2024 08:01:02 -0800
Message-ID: <20241114160131.48616-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Return a copy of the structure, not a pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h     |  6 +-----
 accel/tcg/cputlb.c          |  8 +++++---
 target/arm/tcg/helper-a64.c |  4 ++--
 target/arm/tcg/mte_helper.c | 15 ++++++---------
 target/arm/tcg/sve_helper.c |  6 +++---
 5 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index df7d0b5ad0..69bdb77584 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -365,10 +365,6 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
  * probe_access_full:
  * Like probe_access_flags, except also return into @pfull.
  *
- * The CPUTLBEntryFull structure returned via @pfull is transient
- * and must be consumed or copied immediately, before any further
- * access or changes to TLB @mmu_idx.
- *
  * This function will not fault if @nonfault is set, but will
  * return TLB_INVALID_MASK if the page is not mapped, or is not
  * accessible with @access_type.
@@ -379,7 +375,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool nonfault, void **phost,
-                      CPUTLBEntryFull **pfull, uintptr_t retaddr);
+                      CPUTLBEntryFull *pfull, uintptr_t retaddr);
 
 /**
  * probe_access_full_mmu:
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 81135524eb..84e7e633e3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1420,20 +1420,22 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
 
 int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
-                      bool nonfault, void **phost, CPUTLBEntryFull **pfull,
+                      bool nonfault, void **phost, CPUTLBEntryFull *pfull,
                       uintptr_t retaddr)
 {
+    CPUTLBEntryFull *full;
     int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
-                                      mmu_idx, nonfault, phost, pfull, retaddr,
+                                      mmu_idx, nonfault, phost, &full, retaddr,
                                       true);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
         int dirtysize = size == 0 ? 1 : size;
-        notdirty_write(env_cpu(env), addr, dirtysize, *pfull, retaddr);
+        notdirty_write(env_cpu(env), addr, dirtysize, full, retaddr);
         flags &= ~TLB_NOTDIRTY;
     }
 
+    *pfull = *full;
     return flags;
 }
 
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 8f42a28d07..783864d6db 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1883,14 +1883,14 @@ static bool is_guarded_page(CPUARMState *env, target_ulong addr, uintptr_t ra)
 #ifdef CONFIG_USER_ONLY
     return page_get_flags(addr) & PAGE_BTI;
 #else
-    CPUTLBEntryFull *full;
+    CPUTLBEntryFull full;
     void *host;
     int mmu_idx = cpu_mmu_index(env_cpu(env), true);
     int flags = probe_access_full(env, addr, 0, MMU_INST_FETCH, mmu_idx,
                                   false, &host, &full, ra);
 
     assert(!(flags & TLB_INVALID_MASK));
-    return full->extra.arm.guarded;
+    return full.extra.arm.guarded;
 #endif
 }
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 9d2ba287ee..870b2875af 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -83,8 +83,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                       TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
     return tags + index;
 #else
-    CPUTLBEntryFull *full;
-    MemTxAttrs attrs;
+    CPUTLBEntryFull full;
     int in_page, flags;
     hwaddr ptr_paddr, tag_paddr, xlat;
     MemoryRegion *mr;
@@ -110,7 +109,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     assert(!(flags & TLB_INVALID_MASK));
 
     /* If the virtual page MemAttr != Tagged, access unchecked. */
-    if (full->extra.arm.pte_attrs != 0xf0) {
+    if (full.extra.arm.pte_attrs != 0xf0) {
         return NULL;
     }
 
@@ -129,9 +128,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
      * Remember these values across the second lookup below,
      * which may invalidate this pointer via tlb resize.
      */
-    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
-    attrs = full->attrs;
-    full = NULL;
+    ptr_paddr = full.phys_addr | (ptr & ~TARGET_PAGE_MASK);
 
     /*
      * The Normal memory access can extend to the next page.  E.g. a single
@@ -150,17 +147,17 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
         int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
         assert(ra != 0);
-        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
+        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, full.attrs, wp, ra);
     }
 
     /* Convert to the physical address in tag space.  */
     tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
 
     /* Look up the address in tag space. */
-    tag_asi = attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
+    tag_asi = full.attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
     tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
     mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
-                                 tag_access == MMU_DATA_STORE, attrs);
+                                 tag_access == MMU_DATA_STORE, full.attrs);
 
     /*
      * Note that @mr will never be NULL.  If there is nothing in the address
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f1ee0e060f..dad0d5e518 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5357,7 +5357,7 @@ bool sve_probe_page(SVEHostPage *info, bool nofault, CPUARMState *env,
     flags = probe_access_flags(env, addr, 0, access_type, mmu_idx, nofault,
                                &info->host, retaddr);
 #else
-    CPUTLBEntryFull *full;
+    CPUTLBEntryFull full;
     flags = probe_access_full(env, addr, 0, access_type, mmu_idx, nofault,
                               &info->host, &full, retaddr);
 #endif
@@ -5373,8 +5373,8 @@ bool sve_probe_page(SVEHostPage *info, bool nofault, CPUARMState *env,
     /* Require both ANON and MTE; see allocation_tag_mem(). */
     info->tagged = (flags & PAGE_ANON) && (flags & PAGE_MTE);
 #else
-    info->attrs = full->attrs;
-    info->tagged = full->extra.arm.pte_attrs == 0xf0;
+    info->attrs = full.attrs;
+    info->tagged = full.extra.arm.pte_attrs == 0xf0;
 #endif
 
     /* Ensure that info->host[] is relative to addr, not addr + mem_off. */
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7EDC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrtz-0001bL-U7; Fri, 17 Jul 2026 19:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrts-0001Wm-5K
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:24 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrto-0006zB-SB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:23 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-385ea3ce80dso8297708a91.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330597; x=1784935397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yFRAsWMA+NNoAvoC+xKcAlWuQ4eHUr0T9NC0Mnxt+fA=;
 b=EiDZQT0u+qvFJ4HRTBiAEMANPq8iJXFTK2l7jc5g13rTyfpI3zkc8tnX3b6TF69EH0
 d7MxlJNH4jmqReXzNFpxQePmoaSykuVoqY0Jfc/bXnogRALiN+Rn4Ml8+27DU3ykv+oX
 hf52Ep0lH3fP+uEcm47Dk2+xFjjyNhpvnfHdk4mM3hwH61XNji+h4kZFiHnjZQv4MOmP
 BRP6Lwt9HYe8pACuC0Jap6TIWWmJWob9BrTBGOeEE7vgagoTa4LSyp2jz7BsEqRpTmef
 TVkrCza1hkJsYNoI/xYeT+bWOC0DO3maIIwZ9zV1Sh7LXBiBaX3ekRk0uTZw+ZfQpeD+
 rilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330597; x=1784935397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yFRAsWMA+NNoAvoC+xKcAlWuQ4eHUr0T9NC0Mnxt+fA=;
 b=FejYiSAPn/sxlX9KINovPkjCxQoAelt+VHpm9ZFG4r56iH1MT2son/GKfi6qjTHLCN
 Z2gw6iAzgYLFu3mDfpR/50APF+ehpu0NQdaaPTLCq3INK0Br7rQFxLmWhsnsaujE3Wrn
 8BV1klY+t02Y2g7l2auXDl0KbjPuGvPOlDp7250liPSqPIkvU3WAPgI0bFL3h2W5tlfL
 0wpUpe/CX4Py8k5Je0R9ieQWrsOsoiQh/QSGz+mZv2aiJlujCHI+cW1fnbZ7mo6yHS61
 YCCVCeE6o53uCL7W4Rt2FivSI2tckVw3W+4+aC2wQyYvC1Mx1k8J9VmRhkbKllLhwSmd
 uBag==
X-Gm-Message-State: AOJu0Yz3ttXc70fMM291bthfw0MCL3mNo9dHb2X2BT7vtTAVYJtv9fKQ
 bqoryph8h4CTsbhxohhopVEHls5ACsa9zH5pd989S0iB+bgpGQ8l7Wpj04apkMunDyRTcw7xSMw
 sdukM
X-Gm-Gg: AfdE7clCVJ7xgyrdKT77NaVcLt+8QLTTU4woRy7MlEVn0BmbuAT4JM3QrvMzfQyBCgF
 3h6zz5GQaaO/pMzEfCVKQThleEvVYRLn0kMEhes+lAwSWLB6qKHPIh7bs3/WEB/CjfWeHoB3qv9
 TojCj2SQfTAqB7PAuYT3aun0rcPZ7ZqWcyRBMXma9gEGyvE5E9jT2nfd7CYNjPZb1jeGX+vVCWO
 u7AQleWm/VWn7ocIWBXNUGf1vpMge22j8MnzXjcKQJKy7MdCxzVlUBCKnXUtOzm/h4xMGM2h0c5
 cTb5G7eBhDNheh0byaMAHy54AOKcuAu5iT+u7ITN+6vZuL+v+2Q8uC2VYLbpMxlkxowEChnhl4i
 wsBy6vL7s3d+rnTkkVWx+zsUxqaxqHVQyDEMKF592nnwpVJKCE8y3w8M1lThCGffEeaiKaUWtHk
 /4u/c5bcs=
X-Received: by 2002:a17:90b:5908:b0:380:71eb:4014 with SMTP id
 98e67ed59e1d1-38e4b448c32mr5085573a91.15.1784330597467; 
 Fri, 17 Jul 2026 16:23:17 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/17] target/arm: Return struct from
 allocation_tag_mem_internal
Date: Fri, 17 Jul 2026 16:22:55 -0700
Message-ID: <20260717232306.378988-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Return not just the tag memory, but the data memory, flags,
and attributes.  Make sure probe of NoTagAccess looks like
any other page permission failure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 102 +++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 8f7a222b9c..e6e78634b6 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -27,6 +27,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "user/cpu_loop.h"
 #include "user/page-protection.h"
+#include "user/guest-host.h"
 #else
 #include "system/physmem.h"
 #endif
@@ -80,46 +81,53 @@ static void mte_perm_check_fail(CPUARMState *env, uint64_t dirty_ptr,
 }
 #endif
 
-static uint8_t *
+typedef struct AllocationTagMem {
+    uint8_t *tag_mem;
+    void *ptr_mem;
+    int flags;
+    MemTxAttrs attrs;
+} AllocationTagMem;
+
+static AllocationTagMem
 allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
-                            uint64_t ptr, MMUAccessType ptr_access,
+                            vaddr ptr, MMUAccessType ptr_access,
                             int ptr_size, MMUAccessType tag_access,
                             bool probe, uintptr_t ra)
 {
-#ifdef CONFIG_USER_ONLY
-    const size_t page_data_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
-    uint64_t clean_ptr = useronly_clean_ptr(ptr);
-    int flags = page_get_flags(clean_ptr);
-    uint8_t *tags;
-    uintptr_t index;
+    AllocationTagMem ret = { };
 
-    if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+#ifdef CONFIG_USER_ONLY
+    vaddr clean_ptr = useronly_clean_ptr(ptr);
+    int flags = page_get_flags(clean_ptr);
+    int req_flags = ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ;
+
+    if (unlikely(!(flags & req_flags))) {
         if (probe) {
-            return NULL;
+            ret.flags = TLB_INVALID_MASK;
+            goto fini;
         }
         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
                               !(flags & PAGE_VALID), ra);
     }
 
     /* Require both MAP_ANON and PROT_MTE for the page. */
-    if (!(flags & PAGE_ANON) || !(flags & PAGE_MTE)) {
-        return NULL;
+    if ((flags & PAGE_ANON) && (flags & PAGE_MTE)) {
+        size_t page_data_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
+        uint8_t *tags = page_get_target_data(clean_ptr, page_data_size);
+        uintptr_t index = extract64(ptr, LOG2_TAG_GRANULE + 1,
+                                    TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
+        ret.tag_mem = tags + index;
     }
 
-    tags = page_get_target_data(clean_ptr, page_data_size);
-
-    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
-                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
-    return tags + index;
+    ret.ptr_mem = g2h_untagged_vaddr(clean_ptr);
+    ret.attrs = MEMTXATTRS_UNSPECIFIED;
 #else
     CPUTLBEntryFull *full;
-    MemTxAttrs attrs;
-    int in_page, flags;
+    int in_page;
     hwaddr ptr_paddr, tag_paddr, xlat;
     MemoryRegion *mr;
     ARMASIdx tag_asi;
     AddressSpace *tag_as;
-    void *host;
 
     /*
      * Probe the first byte of the virtual address.  This raises an
@@ -131,12 +139,13 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
      * for the pure probe, or assert that we received a valid page for the
      * no-fault-expected probe.
      */
-    flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
-                              ra == 0, &host, &full, ra);
-    if (unlikely(flags & TLB_INVALID_MASK)) {
+    ret.flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
+                                  ra == 0, &ret.ptr_mem, &full, ra);
+    if (unlikely(ret.flags & TLB_INVALID_MASK)) {
         assert(probe);
-        return NULL;
+        goto fini;
     }
+    ret.attrs = full->attrs;
 
     switch (full->extra.arm.pte_attrs) {
     case 0xf0: /* Tagged */
@@ -145,7 +154,9 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
     case 0xe0: /* NoTagAccess */
         if (cpu_isar_feature(aa64_mteperm, env_archcpu(env))) {
             if (probe) {
-                return NULL;
+                ret.ptr_mem = NULL;
+                ret.flags = TLB_INVALID_MASK;
+                goto fini;
             }
             assert(ra);
             mte_perm_check_fail(env, ptr, ra, tag_access == MMU_DATA_STORE);
@@ -153,27 +164,25 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
         /* fall through */
 
     default: /* Not Tagged */
-        return NULL;
+        goto fini;
     }
 
     /*
      * If not backed by host ram, there is no tag storage: access unchecked.
      * This is probably a guest os bug though, so log it.
      */
-    if (unlikely(flags & TLB_MMIO)) {
+    if (unlikely(ret.flags & TLB_MMIO)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
                       "but is not backed by host ram\n", ptr);
-        return NULL;
+        goto fini;
     }
 
     /*
-     * Remember these values across the second lookup below,
+     * Remember this across the second lookup below,
      * which may invalidate this pointer via tlb resize.
      */
     ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
-    attrs = full->attrs;
-    full = NULL;
 
     /*
      * The Normal memory access can extend to the next page.  E.g. a single
@@ -183,26 +192,30 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
      */
     in_page = -(ptr | TARGET_PAGE_MASK);
     if (unlikely(ptr_size > in_page)) {
-        flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
-                                   ptr_mmu_idx, ra == 0, &host, &full, ra);
-        assert(!(flags & TLB_INVALID_MASK));
+        void *discard_mem;
+        int flags2 = probe_access_full(env, ptr + in_page, 0, ptr_access,
+                                       ptr_mmu_idx, ra == 0,
+                                       &discard_mem, &full, ra);
+
+        assert(!(flags2 & TLB_INVALID_MASK));
+        ret.flags |= flags2;
     }
 
     /* Any debug exception has priority over a tag check exception. */
-    if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
+    if (!probe && unlikely(ret.flags & TLB_WATCHPOINT)) {
         int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
         assert(ra != 0);
-        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
+        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, ret.attrs, wp, ra);
     }
 
     /* Convert to the physical address in tag space.  */
     tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
 
     /* Look up the address in tag space. */
-    tag_asi = attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
+    tag_asi = ret.attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
     tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
     mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
-                                 tag_access == MMU_DATA_STORE, attrs);
+                                 tag_access == MMU_DATA_STORE, ret.attrs);
 
     /*
      * Note that @mr will never be NULL.  If there is nothing in the address
@@ -215,7 +228,7 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
                       "Tag Memory @ 0x%" HWADDR_PRIx " not found for "
                       "Normal Memory @ 0x%" HWADDR_PRIx "\n",
                       tag_paddr, ptr_paddr);
-        return NULL;
+        goto fini;
     }
 
     /*
@@ -227,8 +240,11 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
         physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
     }
 
-    return memory_region_get_ram_ptr(mr) + xlat;
+    ret.tag_mem = memory_region_get_ram_ptr(mr) + xlat;
 #endif
+
+ fini:
+    return ret;
 }
 
 static G_NORETURN void canonical_tag_write_fail(CPUARMState *env,
@@ -250,7 +266,8 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    uintptr_t ra)
 {
     return allocation_tag_mem_internal(env, ptr_mmu_idx, ptr, ptr_access,
-                                       ptr_size, tag_access, false, ra);
+                                       ptr_size, tag_access, false, ra)
+           .tag_mem;
 }
 
 uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
@@ -258,7 +275,8 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                                   int ptr_size, MMUAccessType tag_access)
 {
     return allocation_tag_mem_internal(env, ptr_mmu_idx, ptr, ptr_access,
-                                       ptr_size, tag_access, true, 0);
+                                       ptr_size, tag_access, true, 0)
+           .tag_mem;
 }
 
 uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
-- 
2.43.0



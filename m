Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60410C5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8b-000876-My; Sat, 15 Aug 2026 16:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8S-000844-Je
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:44 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8P-0008Bc-Qf
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:44 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso2203621a91.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826260; x=1787431060; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2NpX2FG+Yin+lMvsHrz/bAcYKjkQ36ULcGX8tyKPbsQ=;
 b=essgJllTER5fHQG/fyZnUhGq2MGA400EhnhMb/E2HytQzhTOeVPiMkA/bhQj+oqg6R
 TZvkYKLlcwC4jF0kgyel6aizieTssw58ulo645KzTOoF+Wbl9Ie3lmndMCiiD7njrMq/
 CJVxxtNvh8iGkJ9Vg8hsZh3TykQXjccE1H8z/oRPNViB7WsxEDuNUZ1mvAFF9ndMUASu
 FneG81jFtVpVQQqAG6ronca5dLyuvezy93Ka5ZdeFptjbS+6aPnZDyjDzUMxwfUCkaZi
 GRllPYPUSao/U23CbsvFQxmbnW9M8s+uLaMzx5uHCuftpSVz0EoeUx+Os7iLy8IVP6cr
 gcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826260; x=1787431060;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2NpX2FG+Yin+lMvsHrz/bAcYKjkQ36ULcGX8tyKPbsQ=;
 b=BLei2VL0SsMNABAwVpj78SDrOVD7p+b52aggOUYpskJUlB7DLCegN3O5YSuFmsTsuF
 e8EBQz6Jnud2um7mCMH85z6F159v42Tv81ZTvNBQ0CJFNHl/4god5lAr3Tc6L7xYLMKV
 nZzyifkS9AoQitBFt98ypGBkQTuyUP8kWaM4R5U6uhHAXilTvAJsmVl1efa89Ml3kjBF
 giDvyJ5rK0guSollDGhBrzhi08Xxmw+/AWd/7BaZbadmI594HY1NXd4F5mDhgrxqNXCa
 tAgMeLxJCmORl3Ph8OQfX6NTAl37Ea2WXlIOoRKlZlzG4W1nCVyZTHKECJFO5JmilyBK
 kBRA==
X-Gm-Message-State: AOJu0YyOQAl2rcp+CN7nS54iMFI6uCrOK4g50If7wFT1rITbc1U9a70m
 vbILq52pmAXipc57OXCRVqzHwwCCNYKc5K2iD8t76gE8Y8GSiB2Xh53nwPWuRhkn5DwtjWDpBlx
 OH3hm
X-Gm-Gg: AR+sD10+K7BTgOuhRMBf5VhtYibB4xYOlYiK5rwoZ7KQcFN82NQ19CyjXP3mb6KsnkW
 vt/A3RvS/qhP+Xkg6y3Gj7iGo7le6n/ZudbQ+JvolC2xxwemn305Zn2vhYUzlYMbe/gv+jgEebH
 3UlvLCssI2CogNxIpCM1Gmrkbk2YRCMADK+PxMI8s6PzIZQVgCp9FnV/dQvCCjXWjB+mOnuanOD
 RTUYGBUTjcH4TgIb77UHGkWCtjGrK0elsurwY56xTDIpjBMQHB4cBEJAQya7IeN+K7c07fjHkUV
 x6/y4JZbLzAYW+hpUD/JoHBY4wQowMiygzZ5iTraUzbO3VAQJ+Ru4K95sJzOQFJV7Zf5oFQ4j9g
 yPbz0Y4ch9ckaueGHqVPYJuwFrc/KCEOO0wNo6BIUgm5pKhZkJ/9a5zuKDCmZxCga4t3P8vwxsG
 PCcDDU42uv/8Ah6lOaZfbnHtXCZrfYOBZ5bd6/8pEbsWSEcCwWCY/fhKpjJ53EyzMsqCVD3KCIY
 pi0T0BhoZkw7RAkaHi4
X-Received: by 2002:a17:90b:134c:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-3933b8721a1mr15988084a91.10.1786826260486; 
 Sat, 15 Aug 2026 13:37:40 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH 03/18] target/arm: Return struct from
 allocation_tag_mem_internal
Date: Sat, 15 Aug 2026 13:37:15 -0700
Message-ID: <20260815203730.1468365-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Return not just the tag memory, but the data memory, flags,
and attributes.  Make sure probe of NoTagAccess looks like
any other page permission failure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 104 +++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index e3952fcabf..dd4c10ef4f 100644
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
@@ -79,46 +80,55 @@ static void mte_perm_check_fail(CPUARMState *env, uint64_t dirty_ptr,
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
+    AllocationTagMem ret = {
+        .flags = TLB_INVALID_MASK,
+        .attrs = MEMTXATTRS_UNSPECIFIED,
+    };
 
-    if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+#ifdef CONFIG_USER_ONLY
+    vaddr clean_ptr = useronly_clean_ptr(ptr);
+    int flags = page_get_flags(clean_ptr);
+    int req_flags = ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ;
+
+    if (unlikely(!(flags & req_flags))) {
         if (probe) {
-            return NULL;
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
+    ret.flags = 0;
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
@@ -130,12 +140,13 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
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
@@ -144,7 +155,9 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
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
@@ -152,27 +165,25 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
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
@@ -182,26 +193,30 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
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
@@ -214,7 +229,7 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
                       "Tag Memory @ 0x%" HWADDR_PRIx " not found for "
                       "Normal Memory @ 0x%" HWADDR_PRIx "\n",
                       tag_paddr, ptr_paddr);
-        return NULL;
+        goto fini;
     }
 
     /*
@@ -226,8 +241,11 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
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
@@ -249,7 +267,8 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    uintptr_t ra)
 {
     return allocation_tag_mem_internal(env, ptr_mmu_idx, ptr, ptr_access,
-                                       ptr_size, tag_access, false, ra);
+                                       ptr_size, tag_access, false, ra)
+           .tag_mem;
 }
 
 uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
@@ -257,7 +276,8 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
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



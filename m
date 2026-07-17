Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD865C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrtu-0001ZA-TB; Fri, 17 Jul 2026 19:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtt-0001Xj-HK
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:25 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtr-0006zz-8u
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:25 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so4156912a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330602; x=1784935402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lhhqC/hOwEz9oJ5MIevvbAiCo2J0aN9y+C175uWjrEg=;
 b=K14lUA2q0RzRzlCOUa8/TfpckDJkZ0PzCrkq7YzK/NIv0ABIbivtnwbBMhRmkKI9x7
 ghScR7fag77WOmnXhVKCwevKaY7Iq24ddzVjK2JOaj/xMHp2nVn+dZra2v9o1i5sv1Ow
 6B+ZX6vdZq5+ioi29W7szGmgEK6bI3HgoTepLGKhTAh/yZHbu0tpxVdHUw7t+K973/Eu
 UKGdhg5dhBfe8aj/6FFjkJttNaopqYTy7fkd6wuDOQJta9bvti7/FN7/221nk2KIzoS8
 gNwtW5iukcPVIaNqj1nKfzzJyNiwlB4v6Jm9KSLoWYq7ZDtwMrYO0Wx55UzLd4NqEGdn
 6lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330602; x=1784935402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lhhqC/hOwEz9oJ5MIevvbAiCo2J0aN9y+C175uWjrEg=;
 b=CZ2dANV4VbFVVL7pBlMFGdHsXGbRSt3cwX6LquhclLPG6PkJq5ETWRUbdNsSoI6BZn
 7D082WyeLG/INlrfmTSwheMSbDBiitz24US/eei6ScuzmpTevG02kFq7DcIa0imPKcqk
 41SK48AqZc/fRXlWANRFm2FY7AbFu7/XdKyeR0Ailloj+DNaQcU6QRI+LxX7kQMkW8Rw
 j6WuA0ELa5z2mLUR9xrnLmyFGFH/DGM4MZWhSPAEjfNfiaV1YTeFBxRVjg9iilO/I+DL
 9rv8AIkY4JgMpmGkYuEqWWLVvcimtazHYuP0xMb7SbBM1eH+luVp3eU3M1uInlcCfZA2
 Gjxw==
X-Gm-Message-State: AOJu0YwCCtoCmNtidxdZlx17yret5y+fldlgZJqy6SCta4WzHkqJZDx0
 K9tI2LVEZ9cunuRoz+d7q9WpvYk8zzRDAeIFmkwpiYVbsW8ormerYMpzGA/i8ijf9Kie1XfiMc8
 QOPYS
X-Gm-Gg: AfdE7cmZKUwnPJLcp4RJUzWcQ1LZy+aI03tkQxQIMjkOMSG00uvHHXs55XodXCqyxBK
 YkqIFqaQeo+gEee3QcNdeRVsXnrrVharLRrvuq6yVIYdR+yRH8xmEk6jQTcdqu/fRYNyafOMu3T
 OwIMJaeZHqn3fJ3+gFzcBMCX2icAwlEDvXFzYR6nvNXiNtOxWv34JuBJzb91PY6XyFYfs/7nnWn
 inKWfQ7OcbST2y1dxTaEo35pHpeFKS0/MFe1ZgZ0gw8lJ7HbZnFxQX3NXXKOChkQViQllyxT5N0
 WyAbHtaaJ/6BIKpF51ijER39ryU6dJA8K8CpVEWUgnxy0JRWKoW/jnrlZdArOcp7/1Ve5zlvqaU
 zBERugsAvNZXlms1HuKibpVMiuP4QKz5dIYzFEvksYwsH2DGzJxt3YMmmVriQwAkmC/4GQpvskE
 aR/ws1JPg=
X-Received: by 2002:a17:90b:534d:b0:37f:a915:1c29 with SMTP id
 98e67ed59e1d1-38e4b42ebd6mr4918785a91.19.1784330601769; 
 Fri, 17 Jul 2026 16:23:21 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/17] target/arm: Probe second page earlier in
 allocation_tag_mem_internal
Date: Fri, 17 Jul 2026 16:22:58 -0700
Message-ID: <20260717232306.378988-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Translation faults have priority over everything else in
this function.  We were failing to trap for the second page
entirely in the user-only case, and when tag access is disabled
on the first page for the system case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 64 +++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 6177dea842..6e1f701c4c 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -129,6 +129,13 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
             g_assert_not_reached();
         }
     }
+    if (atm_kind == ATM_NORMAL) {
+        int in_page = -(ptr | TARGET_PAGE_MASK);
+        if (unlikely(ptr_size > in_page)) {
+            probe_access(env, ptr + in_page, ptr_size - in_page,
+                         ptr_access, MMU_USER_IDX, ra);
+        }
+    }
 
     /* Require both MAP_ANON and PROT_MTE for the page. */
     if ((flags & PAGE_ANON) && (flags & PAGE_MTE)) {
@@ -147,6 +154,7 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
     MemoryRegion *mr;
     ARMASIdx tag_asi;
     AddressSpace *tag_as;
+    uint8_t pte_attrs;
 
     /*
      * Probe the first byte of the virtual address.  This raises an
@@ -160,9 +168,32 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
         assert(atm_kind == ATM_PROBE_PAGES);
         goto fini;
     }
+
+    /*
+     * Remember these across the second lookup below,
+     * which may invalidate this pointer via tlb resize.
+     */
+    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
+    pte_attrs = full->extra.arm.pte_attrs;
     ret.attrs = full->attrs;
 
-    switch (full->extra.arm.pte_attrs) {
+    /*
+     * The Normal memory access can extend to the next page.  E.g. a single
+     * 8-byte access to the last byte of a page will check only the last
+     * tag on the first page.
+     * Any page access exception has priority over tag check exception.
+     */
+    if (atm_kind == ATM_NORMAL) {
+        int in_page = -(ptr | TARGET_PAGE_MASK);
+        if (unlikely(ptr_size > in_page)) {
+            void *discard_mem;
+            ret.flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
+                                           ptr_mmu_idx, false,
+                                           &discard_mem, &full, ra);
+        }
+    }
+
+    switch (pte_attrs) {
     case 0xf0: /* Tagged */
         break;
 
@@ -181,33 +212,10 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
         goto fini;
     }
 
-    /*
-     * Remember this across the second lookup below,
-     * which may invalidate this pointer via tlb resize.
-     */
-    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
-
-    /*
-     * The Normal memory access can extend to the next page.  E.g. a single
-     * 8-byte access to the last byte of a page will check only the last
-     * tag on the first page.
-     * Any page access exception has priority over tag check exception.
-     */
-    if (atm_kind == ATM_NORMAL) {
-        int in_page = -(ptr | TARGET_PAGE_MASK);
-        if (unlikely(ptr_size > in_page)) {
-            void *discard_mem;
-            ret.flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
-                                           ptr_mmu_idx, false,
-                                           &discard_mem, &full, ra);
-        }
-
-        /* Any debug exception has priority over a tag check exception. */
-        if (unlikely(ret.flags & TLB_WATCHPOINT)) {
-            int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
-            cpu_check_watchpoint(env_cpu(env), ptr, ptr_size,
-                                 ret.attrs, wp, ra);
-        }
+    /* Any debug exception has priority over a tag check exception. */
+    if (unlikely(ret.flags & TLB_WATCHPOINT) && atm_kind == ATM_NORMAL) {
+        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
+        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, ret.attrs, wp, ra);
     }
 
     /* Convert to the physical address in tag space.  */
-- 
2.43.0



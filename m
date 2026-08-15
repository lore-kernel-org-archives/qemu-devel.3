Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5EEC5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8e-00089t-KJ; Sat, 15 Aug 2026 16:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8c-000885-TA
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8S-0008Ep-5x
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:47 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso1472286a91.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826263; x=1787431063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9QUKUc1DTLQNdki6YTXLbAayjzSGK/v6LBFa+ortZzU=;
 b=Vnk4gFBditEutrmlnh+duGZvBit/jwxMNK7IvMHA3oJrcDvxfitwtbyoWRww5YGL9X
 pcO0qApXH73aCpJt3xzNpt7qhFsf+0nsxNYweZaoaggtaFQ1p4dF8ysznCT2v+/GoXJw
 dR/0n8GoFpl0FI3R5JF5SWlSWHgdd3PjTSTRsd+07B0W07+Wd0PDt4tgHdtmDllwPYgi
 +9V+GLsrwulqvkDlfTvqLh6kkS+JvqQ4WXXi5C9Ox0PHqx+cgoGM6I58UtngxhsbbMwk
 fpi5jcD7uF1QRy7OJqgC8hUHAfjAaX9h2peLaUmjPEQkE6jBbe36KcIGp7k6ibjaNPJd
 bCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826263; x=1787431063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9QUKUc1DTLQNdki6YTXLbAayjzSGK/v6LBFa+ortZzU=;
 b=SFfqsYhAquVO5IEohUGSAM9LkNl32o4Va1ojVxk7vmPUEcvJhEdLxDG7RA1D2r87Aq
 fEpE9qk8fPrTTPPV5WgI/nOUKKEDd+yrur3POy/Bk44FlmNl/kt8jFaJKIQZ1IvbGOAa
 mF/RQL3oZz3fgxV748WK1ucHWBqoRUXoCPkwU9UnHB5HteU4zS3vyMBD8kS6zwiAVLUh
 Q67j76vfSn/m/IEds5NuTSQ3G9xCt87V5Tt1Bw2S49iIpT+8oqwiRmv6bhg1b221m4dN
 /m3evm22FVMa3FodyaQp9kQDrJc3AQq/V7ykeN8gYecVVu36VTDjt9faW/EJ2rfjLt7e
 sKfw==
X-Gm-Message-State: AOJu0YxZ8ThUgu94jBVTBwNo6Hg2uKFMCdlOCuuenk6L19JwJMMhuCBi
 YyTv6p5TO0lO9Ea/FvhqWDp4IK/gEPq/ScPpLO/jo9GiMmBHTPSzDH11XMuZ7/5KQErxFAEPy85
 w9dNC
X-Gm-Gg: AR+sD13YzWfZuihZXhcqXTv2Aee6kksxynsqGuOK9hYkIvnvF/6f15GsE9Gcr1BGT3y
 ZEjaE8BRIx/QkIHfnKJCh5GOBVPNLMeDyxO0Xrxu9OqDuS/TsEqZTIbAHcDnWlVmZbnUo0Bj6Pp
 JaE2X4ExCWdpJ5RESlObOGG99LSRkilFWvp5aRYbbTXb6f4RFoGeUvxhn8nJfnXueSTzG2Qv3Hc
 2GfCirXtqBwhqatM4jsq7+6cR1dqLc/72ZV6HMpR0nIhy3g2OUmjYY6rgYaR1nxZlkZR4rK4e25
 cmcjApF3KAZEdTp1F/FV3yQMsV8/zPIvOzzoOeBvi/NQ3qE/RuMPwDF+pS3lC07jZ0hCNyIB8kC
 HKHClMjDW96z5K5LyIhxmjEab1miDbLQu2QaP0wZfV8B+wmUee+adV3PfXrnuWP+9tJkrRr4ZBI
 0PRSNb2jizlY3kGeB0dpPdHFmtfIGrHETtvgLAdG0ZV+H6y+hOPsoPS/1gMKjVQgMn/nV1RjIFV
 286317p9W/phCse81G/rDXdns+s/K4nZ6th
X-Received: by 2002:a17:90b:35c6:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-3933b95d5e1mr16015850a91.13.1786826262670; 
 Sat, 15 Aug 2026 13:37:42 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 05/18] target/arm: Probe second page earlier in
 allocation_tag_mem_internal
Date: Sat, 15 Aug 2026 13:37:17 -0700
Message-ID: <20260815203730.1468365-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Translation faults have priority over everything else in
this function.  We were failing to trap for the second page
entirely in the user-only case, and when tag access is disabled
on the first page for the system case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 55 ++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 31bf58c937..399bca30c9 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -130,6 +130,13 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
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
@@ -148,6 +155,7 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
     MemoryRegion *mr;
     ARMASIdx tag_asi;
     AddressSpace *tag_as;
+    uint8_t pte_attrs;
 
     /*
      * Probe the first byte of the virtual address.  This raises an
@@ -161,9 +169,32 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
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
 
@@ -193,28 +224,8 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
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
+    /* Any debug exception has priority over a tag check exception. */
     if (atm_kind == ATM_NORMAL) {
-        int in_page = -(ptr | TARGET_PAGE_MASK);
-        if (unlikely(ptr_size > in_page)) {
-            void *discard_mem;
-            ret.flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
-                                           ptr_mmu_idx, false,
-                                           &discard_mem, &full, ra);
-        }
-
-        /* Any debug exception has priority over a tag check exception. */
         if (unlikely(ret.flags & TLB_WATCHPOINT)) {
             int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
             cpu_check_watchpoint(env_cpu(env), ptr, ptr_size,
-- 
2.43.0



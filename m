Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B8BD68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJl-000746-3j; Thu, 14 Nov 2024 11:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIH-00051a-Ly
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:07 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcID-0002HH-LR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:04 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7245a9d0e92so810658b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600119; x=1732204919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I5LJCTHDiHg5qibWbzvdQL13bnVE+48Q0Fcqf1mDluc=;
 b=dYKiJJX3bCzbH67y6W29tKuwasvWt4/6uRtdxwZHJotXkdBQoGnpcOHkERSPguVIt6
 oOY23LsnSUFuDIj/rOFvurDemGuZ+vqrebSdUygJUM9BttS3ddrFYvCsAZQn9Rbm8p5P
 GiaWrk7oPdhSEwk14UHFJTOYQlVlUBDOCET4nMB9eVof0T70h7ebSAfaTnyTUzjXrpkh
 MCqGD+nt4PMhLG5Lbmz3GT1hs//ISWM7osLVdGcUpnGju+C6ClKzZwrhtwnhCvGcZ3mq
 yFw60LrizxqRQ2nCvxN8GadFN6GeiLL2t8tbnmPAiEQLD+q0/vB8+Xes+hcR96tBCkBJ
 BDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600119; x=1732204919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5LJCTHDiHg5qibWbzvdQL13bnVE+48Q0Fcqf1mDluc=;
 b=OlH9SYmA/PZ/uSI5Rx9K0QmrHHM8CmPXUR8QTL54V5ysOC86Qz05YLbj5CFFvCrPOX
 apwGEZQjjAQu0cu44N+W9Fsjv6lpv6Sw134D+UO8MOlRhnsb95LXaXQXBATM0fkLyg5M
 GSRZ2593mHCil4iqdSZF9A0wJ+XorFDzG0bl5HdRWvYNpsm5AJf5TpojTqT68SFy0aqg
 mkD2kL46vwVr6G+n++Wu6qPiZhpVtQ9YY2A9Vyu4w4vd5vIvqIrDDpKXa47/egHKQcYh
 2u5g0sGryjTGdXSHwkZ7iPct5DhSmPATfpm5BEsgIXrpg+J1h+v7q0CGqO9IxrCawgwF
 fEng==
X-Gm-Message-State: AOJu0Yztk7NiREMyFle/gW1Rc5ts0YFU1hwmlLZsV9C6hTCHJkEsVdXl
 5ZaeouLlPhskVT029DL9900TUt5SKScmyT+7fuKWk58E4CkoZ/CcCKXcIyj2VA/6bMP+/Dw3c72
 p
X-Google-Smtp-Source: AGHT+IFtqNE4fDPhggwOVTT8HUG4faBR+wiHn7so7IBz8pIQxvUeMUYmt4T7rrgnrw3ulxBhRsPVgA==
X-Received: by 2002:a17:90b:3c12:b0:2e2:b2ce:e41e with SMTP id
 98e67ed59e1d1-2e9f2c78421mr8571311a91.13.1731600118769; 
 Thu, 14 Nov 2024 08:01:58 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/54] accel/tcg: Merge mmu_lookup1 into mmu_lookup
Date: Thu, 14 Nov 2024 08:01:06 -0800
Message-ID: <20241114160131.48616-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Reuse most of TLBLookupInput between calls to tlb_lookup.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 65 ++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 8f459be5a8..981098a6f2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1695,34 +1695,6 @@ typedef struct MMULookupLocals {
     int mmu_idx;
 } MMULookupLocals;
 
-/**
- * mmu_lookup1: translate one page
- * @cpu: generic cpu state
- * @data: lookup parameters
- * @memop: memory operation for the access, or 0
- * @mmu_idx: virtual address context
- * @access_type: load/store/code
- * @ra: return address into tcg generated code, or 0
- *
- * Resolve the translation for the one page at @data.addr, filling in
- * the rest of @data with the results.  If the translation fails,
- * tlb_fill_align will longjmp out.
- */
-static void mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
-                        int mmu_idx, MMUAccessType access_type, uintptr_t ra)
-{
-    TLBLookupInput i = {
-        .addr = data->addr,
-        .ra = ra,
-        .access_type = access_type,
-        .memop_probe = memop,
-        .size = data->size,
-        .mmu_idx = mmu_idx,
-    };
-
-    tlb_lookup_nofail(cpu, &data->o, &i);
-}
-
 /**
  * mmu_watch_or_dirty
  * @cpu: generic cpu state
@@ -1769,26 +1741,36 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
 static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
                        uintptr_t ra, MMUAccessType type, MMULookupLocals *l)
 {
+    MemOp memop = get_memop(oi);
+    int mmu_idx = get_mmuidx(oi);
+    TLBLookupInput i = {
+        .addr = addr,
+        .ra = ra,
+        .access_type = type,
+        .memop_probe = memop,
+        .size = memop_size(memop),
+        .mmu_idx = mmu_idx,
+    };
     bool crosspage;
     int flags;
 
-    l->memop = get_memop(oi);
-    l->mmu_idx = get_mmuidx(oi);
+    l->memop = memop;
+    l->mmu_idx = mmu_idx;
 
-    tcg_debug_assert(l->mmu_idx < NB_MMU_MODES);
+    tcg_debug_assert(mmu_idx < NB_MMU_MODES);
 
     l->page[0].addr = addr;
-    l->page[0].size = memop_size(l->memop);
-    l->page[1].addr = (addr + l->page[0].size - 1) & TARGET_PAGE_MASK;
+    l->page[0].size = i.size;
+    l->page[1].addr = (addr + i.size - 1) & TARGET_PAGE_MASK;
     l->page[1].size = 0;
     crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
 
     if (likely(!crosspage)) {
-        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
+        tlb_lookup_nofail(cpu, &l->page[0].o, &i);
 
         flags = l->page[0].o.flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
-            mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
+            mmu_watch_or_dirty(cpu, &l->page[0], i.access_type, i.ra);
         }
         if (unlikely(flags & TLB_BSWAP)) {
             l->memop ^= MO_BSWAP;
@@ -1796,17 +1778,20 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     } else {
         /* Finish compute of page crossing. */
         int size0 = l->page[1].addr - addr;
-        l->page[1].size = l->page[0].size - size0;
+        l->page[1].size = i.size - size0;
         l->page[0].size = size0;
 
         /* Lookup both pages, recognizing exceptions from either. */
-        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
-        mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra);
+        i.size = size0;
+        tlb_lookup_nofail(cpu, &l->page[0].o, &i);
+        i.addr = l->page[1].addr;
+        i.size = l->page[1].size;
+        tlb_lookup_nofail(cpu, &l->page[1].o, &i);
 
         flags = l->page[0].o.flags | l->page[1].o.flags;
         if (unlikely(flags & (TLB_WATCHPOINT | TLB_NOTDIRTY))) {
-            mmu_watch_or_dirty(cpu, &l->page[0], type, ra);
-            mmu_watch_or_dirty(cpu, &l->page[1], type, ra);
+            mmu_watch_or_dirty(cpu, &l->page[0], i.access_type, i.ra);
+            mmu_watch_or_dirty(cpu, &l->page[1], i.access_type, i.ra);
         }
 
         /*
-- 
2.43.0



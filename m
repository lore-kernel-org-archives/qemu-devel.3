Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1E8D68B35
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcNN-0003zo-G5; Thu, 14 Nov 2024 11:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLj-0001wv-Ew
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:43 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLd-00039n-ND
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:39 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20cdb889222so8296375ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600331; x=1732205131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kszkBxHzd0i3pHfwTrRD6LMnpSdmBjH+8x+WNocCo4c=;
 b=JaYBhne0qGJs/FNxFWMqbHW0IPxJpAkOqHv0C0W4DlHd9nO2lzjhq/wsRypJFhvemb
 swIth7Wn8+MtjZ1v1yt/vRMV4abzkO7CHZxf6J2XuD6mDgiZF43ojEwIQoiisKy/IV2z
 03EefWumcoJSsJ5PmMimbl+PFw59yW6KOp6mDh2SBf8y1+2yT9bI4xiAQi0Co/ObrePK
 UCxzTuBoANmKjl10U5r7Q61fKcFCECHiX/XMZwoBS+S4LNvjFRN1SWIRuuWO5MBzsKhz
 VtwYHb9w5oP1pwdrVqrm8UGH/mPWsJZcr++t4dIX1g5rZNhiR31fYLxuI9NB/INOCZqe
 EUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600331; x=1732205131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kszkBxHzd0i3pHfwTrRD6LMnpSdmBjH+8x+WNocCo4c=;
 b=ExDG3kBgesUxCeNgiOXiINGZHyDefJ6FgeuV6ITG6qxujwGhuj9zLCMUW222lLyce9
 lzNnW3ZnPUmY7tPw/BO84muF2C1kgJlMZlclgaUF87h9cqZU2d8HzX3TSoxz8ZD+vE6n
 KrmExvhbxD2aNqz8TvqkNenCesfB94Fx15Ny9JPRoKsE4/4jDMEVRduxgEF1hMImOOGd
 5RGSsbGbDXS7AhyPMqb1/icxtXoGuGNH2tDx5JwsIGMaZOxsMP2LR2yoarqq6Fd/DFvL
 TJab+CZv8zmd7kMHdYt+1uxP5OZulkk1DRyE1M1i42iz1+O3JCOX3n5Wlo1dKeY03FGT
 PhQQ==
X-Gm-Message-State: AOJu0YzQBHDBUH+CBOvUYsX4S3t0BveOsWSTf907SYd+IrxHbSsqYF8b
 0+/9RNA5Ys9FenLtLwdyT7lCncRr0c/oLL30+rb+soelHWSEON7m9fy5udBynJo9Go2j87h/+rc
 w
X-Google-Smtp-Source: AGHT+IHfV2PmkvW1JQisvwXqKrg1ceGhBQyVkQZzMtmDKkNczdk132iVVqRFoO6F0xVqEilcj9oFCA==
X-Received: by 2002:a17:902:d4d1:b0:210:fce4:11ec with SMTP id
 d9443c01a7336-211b5bcc223mr100430365ad.1.1731600330998; 
 Thu, 14 Nov 2024 08:05:30 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 53/54] accel/tcg: Merge tlb_fill_align into callers
Date: Thu, 14 Nov 2024 08:01:29 -0800
Message-ID: <20241114160131.48616-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

In tlb_lookup, we still call tlb_set_page_full.
In atomic_mmu_lookup, we're expecting noreturn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3d731b8f3d..20af48c6c5 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1189,27 +1189,6 @@ static void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     qemu_spin_unlock(&tlb->c.lock);
 }
 
-/*
- * Note: tlb_fill_align() can trigger a resize of the TLB.
- * This means that all of the caller's prior references to the TLB table
- * (e.g. CPUTLBEntry pointers) must be discarded and looked up again
- * (e.g. via tlb_entry()).
- */
-static bool tlb_fill_align(CPUState *cpu, vaddr addr, MMUAccessType type,
-                           int mmu_idx, MemOp memop, int size,
-                           bool probe, uintptr_t ra)
-{
-    CPUTLBEntryFull full;
-
-    if (cpu->cc->tcg_ops->tlb_fill_align(cpu, &full, addr, type, mmu_idx,
-                                         memop, size, probe, ra)) {
-        tlb_set_page_full(cpu, mmu_idx, addr, &full);
-        return true;
-    }
-    assert(probe);
-    return false;
-}
-
 static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
                                         MMUAccessType access_type,
                                         int mmu_idx, uintptr_t retaddr)
@@ -1281,11 +1260,13 @@ static bool tlb_lookup(CPUState *cpu, TLBLookupOutput *o,
     }
 
     /* Finally, query the target hook. */
-    if (!tlb_fill_align(cpu, addr, access_type, i->mmu_idx,
-                        memop, i->size, probe, i->ra)) {
+    if (!cpu->cc->tcg_ops->tlb_fill_align(cpu, &o->full, addr, access_type,
+                                          i->mmu_idx, memop, i->size,
+                                          probe, i->ra)) {
         tcg_debug_assert(probe);
         return false;
     }
+    tlb_set_page_full(cpu, i->mmu_idx, addr, &o->full);
     o->did_tlb_fill = true;
 
     if (access_type == MMU_INST_FETCH) {
@@ -1794,8 +1775,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
      * We have just verified that the page is writable.
      */
     if (unlikely(!(o.full.prot & PAGE_READ))) {
-        tlb_fill_align(cpu, addr, MMU_DATA_LOAD, i.mmu_idx,
-                       0, i.size, false, i.ra);
+        cpu->cc->tcg_ops->tlb_fill_align(cpu, &o.full, addr, MMU_DATA_LOAD,
+                                         i.mmu_idx, 0, i.size, false, i.ra);
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
-- 
2.43.0



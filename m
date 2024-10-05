Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04A6CFA742
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fP-0001yR-Jl; Sat, 05 Oct 2024 11:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fN-0001wq-Pp
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:25:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fM-0002KS-85
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:25:57 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b6458ee37so36306035ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141955; x=1728746755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBthGFf8BfR2i4dob959bB47CFsEJX0Mf+aRMHd0jM4=;
 b=NRxMumqhUyi4JtJy/8PTggZsUF1jOR0NNV50ryHAaU2cqj05VlICmZs3b06OiKYHnv
 gmjMgSyapT0roF9bCsU9+qDLqmCHetHwarcbolRovDLfXFsn23n1LAsNuG+GZE0aDE8H
 vSeelEQ/kaGrblkkrNZ1SQl9DEJMHPaBozsr3CjaMXvok/vpShsAWVfSdfvBsZYginUf
 DsvXzJOndqPLLcROLUngHqT/DOj4ZxMWt7vh5gRCbZdz+IOMZj6e6Pguas53nIEYEqBJ
 iYSKUlPHLkG1SitzO9aBt6OLh/8J8teDYp6LRx70eZPtGfjge0+f7PxwQcCCxgek8fAt
 DAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141955; x=1728746755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBthGFf8BfR2i4dob959bB47CFsEJX0Mf+aRMHd0jM4=;
 b=ocWFPcy6DZgGoY42joWFetRjXpKZgHfl+PvOWeHHEq5+tCnFV+MHyS0Dcj/rzTwD/N
 4gU/0YbIDVUQHXIjpWygT3G5aY6owK0izWw6SEiQu0DaAQ6QapT3acTqaGOltN0RB07e
 qlOW1mj6oVty+BZZKTjV2imrOhlqLyqoWiW46nE+pPfQSB/XjcTvR54GB2tqLTxQChcD
 kRXfOmjQsQXadhoWFi1Ty4rYU2TVw0GG7QgpeMboqKOBEvyrm3v9fvmsFGffzXlmJ8aK
 2YQiRF423XSkkO0hQdYHfA8fDlYv35fuXkQsBSBIAV6QAc/MIGVNrWf2vB4ZjpCvYaIy
 hiWQ==
X-Gm-Message-State: AOJu0Ywz9MnbOQWAgNPbQXU4P0ktrQeIPnLSF/1qz7Jz96LyzM2d18C0
 xcWRz7zeXP27LlYhFdVajIITrQ7J2Z5c6id7jD/adfYm8y/OnEsVH40FC+/Ylt4n3o6PdCCeF67
 Q
X-Google-Smtp-Source: AGHT+IH7Xmy/UoZFDozrpGZR2JXAjehjcUEjjy3Gt9EAYcog/cZlmR6Wqao6wjaMYAvpmgnjtSqiEQ==
X-Received: by 2002:a17:902:d581:b0:20b:419e:9f15 with SMTP id
 d9443c01a7336-20bfea570admr86092045ad.46.1728141954795; 
 Sat, 05 Oct 2024 08:25:54 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:25:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 02/20] accel/tcg: Expand tlb_fill for 3 callers
Date: Sat,  5 Oct 2024 08:25:33 -0700
Message-ID: <20241005152551.307923-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fd6459b695..58960969f4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1220,25 +1220,6 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
                             prot, mmu_idx, size);
 }
 
-/*
- * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
- * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
- * be discarded and looked up again (e.g. via tlb_entry()).
- */
-static void tlb_fill(CPUState *cpu, vaddr addr, int size,
-                     MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    bool ok;
-
-    /*
-     * This is not a probe, so only valid return is success; failure
-     * should result in exception + longjmp to the cpu loop.
-     */
-    ok = cpu->cc->tcg_ops->tlb_fill(cpu, addr, size,
-                                    access_type, mmu_idx, false, retaddr);
-    assert(ok);
-}
-
 static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
                                         MMUAccessType access_type,
                                         int mmu_idx, uintptr_t retaddr)
@@ -1631,7 +1612,10 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data,
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, access_type,
                             addr & TARGET_PAGE_MASK)) {
-            tlb_fill(cpu, addr, data->size, access_type, mmu_idx, ra);
+            bool ok = cpu->cc->tcg_ops->tlb_fill(cpu, addr, data->size,
+                                                 access_type, mmu_idx,
+                                                 false, ra);
+            assert(ok);
             maybe_resized = true;
             index = tlb_index(cpu, mmu_idx, addr);
             entry = tlb_entry(cpu, mmu_idx, addr);
@@ -1833,8 +1817,10 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     if (!tlb_hit(tlb_addr, addr)) {
         if (!victim_tlb_hit(cpu, mmu_idx, index, MMU_DATA_STORE,
                             addr & TARGET_PAGE_MASK)) {
-            tlb_fill(cpu, addr, size,
-                     MMU_DATA_STORE, mmu_idx, retaddr);
+            bool ok = cpu->cc->tcg_ops->tlb_fill(cpu, addr, size,
+                                                 MMU_DATA_STORE, mmu_idx,
+                                                 false, retaddr);
+            assert(ok);
             index = tlb_index(cpu, mmu_idx, addr);
             tlbe = tlb_entry(cpu, mmu_idx, addr);
         }
@@ -1848,7 +1834,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
      * but addr_read will only be -1 if PAGE_READ was unset.
      */
     if (unlikely(tlbe->addr_read == -1)) {
-        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+        cpu->cc->tcg_ops->tlb_fill(cpu, addr, size, MMU_DATA_LOAD,
+                                   mmu_idx, false, retaddr);
         /*
          * Since we don't support reads and writes to different
          * addresses, and we do have the proper page loaded for
-- 
2.43.0



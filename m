Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220F9D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcMo-0002Zv-8A; Thu, 14 Nov 2024 11:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLO-0001gV-85
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:20 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLJ-00033L-KB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:15 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7245a9d0e92so815347b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600312; x=1732205112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6ZNcg828iubR7iZKSP5M7BkBGmFtklgKRp8DrOlWIfY=;
 b=B8dtA3+4K5ZJXvkhImcNeLWJvQnqYnQe/1rnzdw/1QBAUm00pKkKo9NptafVBPtgT7
 zb0mhc34mFOUMxyla/tSe8Xnic0b9TTew87fWxpCedqtB1moi4x/ZHoSccXv93uByd5f
 okT5cC5wPiAKi2Y31q78bhzRZ/AN34T5E3znCaw3afZJKhgLh0Zrq2OfGS4W7heCtyC/
 F/UV/xgJzrsVcOpqsvfZV1k3aInkNkeJpAmcO9AyRHRfvvVwhdBYggJ2tlRZm6yxClf3
 lR4ODPmhop6gYPJF1Z/WStO/UpgN0gLbycLRLbEYlxnC15Cf6RD60fKskew29CkYA1v+
 bc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600312; x=1732205112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ZNcg828iubR7iZKSP5M7BkBGmFtklgKRp8DrOlWIfY=;
 b=Piunb46B5hEswoV/hYsr4rUZMg5oNB996Ga+ZBW+pXLS5hKpuoVqhXbc47aVj/PtuR
 f7EubWW9wGrE/2Yke9roOT2BNId5QPklz2VH2Pixf21HS2eg56gR3tfYFSL9DS4qnLM+
 D8v02wRO/CKP6K1gXcll1U+A8+l4ImeGge+lnt94xRSaUXywwhfn2NFuwRSr1tNeLPZ6
 rN4nyURgKoRLd1KtMvUGzn/mlOPUtpIXvVcDMIL0329Q2cvdvfyjhPYRK+zBJVVZwQdJ
 UNViBk4QLatY1KQqzQr5gxbNgYxP92wPs2QUzYWRCZnnGt2yCIIsIVhwHtQ6iEyL2SnC
 L7PQ==
X-Gm-Message-State: AOJu0Yy9TTqLcC/LGn5g/2xSuTFXfcEgr9n+8aFD8pLHh+rReOXEPuyg
 IDCbF0qDT/M1OC1SNy1krEfgQrJ188+V/DmZ+queoQDg1Qg3MbrYRz6VZZUUx5gNEK4tPNC5nUJ
 C
X-Google-Smtp-Source: AGHT+IG8r4WbMldXia9Btm6/A9nnQQIH7XWeXWgD4MMho9TEz/vY24mIEL+xQy0vGk4oqgrCs/tz/A==
X-Received: by 2002:a05:6a00:3a06:b0:71e:4c34:e294 with SMTP id
 d2e1a72fcca58-7245799d47bmr8657997b3a.7.1731600311849; 
 Thu, 14 Nov 2024 08:05:11 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 43/54] target/ppc: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:19 -0800
Message-ID: <20241114160131.48616-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/ppc/internal.h   |  7 ++++---
 target/ppc/cpu_init.c   |  2 +-
 target/ppc/mmu_helper.c | 21 ++++++++++++++++-----
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 20fb2ec593..9d132d35a1 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -273,9 +273,10 @@ void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
                             MMUAccessType access_type,
                             bool maperr, uintptr_t ra);
 #else
-bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr);
+bool ppc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                            vaddr addr, MMUAccessType access_type,
+                            int mmu_idx, MemOp memop, int size,
+                            bool probe, uintptr_t ra);
 G_NORETURN void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                             MMUAccessType access_type, int mmu_idx,
                                             uintptr_t retaddr);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index efcb80d1c2..387c7ff2da 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7422,7 +7422,7 @@ static const TCGCPUOps ppc_tcg_ops = {
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
 #else
-  .tlb_fill = ppc_cpu_tlb_fill,
+  .tlb_fill_align = ppc_cpu_tlb_fill_align,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
   .cpu_exec_halt = ppc_cpu_has_work,
   .do_interrupt = ppc_cpu_do_interrupt,
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index b167b37e0a..bf98e0efb0 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1357,18 +1357,29 @@ void helper_check_tlb_flush_global(CPUPPCState *env)
 }
 
 
-bool ppc_cpu_tlb_fill(CPUState *cs, vaddr eaddr, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr)
+bool ppc_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                            vaddr eaddr, MMUAccessType access_type,
+                            int mmu_idx, MemOp memop, int size,
+                            bool probe, uintptr_t retaddr)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     hwaddr raddr;
     int page_size, prot;
 
+    if (eaddr & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        ppc_cpu_do_unaligned_access(cs, eaddr, access_type, mmu_idx, retaddr);
+    }
+
     if (ppc_xlate(cpu, eaddr, access_type, &raddr,
                   &page_size, &prot, mmu_idx, !probe)) {
-        tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
-                     prot, mmu_idx, 1UL << page_size);
+        memset(out, 0, sizeof(*out));
+        out->phys_addr = raddr;
+        out->prot = prot;
+        out->lg_page_size = page_size;
+        out->attrs = MEMTXATTRS_UNSPECIFIED;
         return true;
     }
     if (probe) {
-- 
2.43.0



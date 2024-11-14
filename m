Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B24FD68B35
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcMn-0002YX-3y; Thu, 14 Nov 2024 11:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLO-0001gU-7Y
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:20 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLH-00031B-Qk
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:14 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20e576dbc42so9330005ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600310; x=1732205110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o/Mf+gksylMlQN4tQ9eK2BqWgWCztBtTJCqnsjP2hVE=;
 b=btLcgMsxgDdMq1Gxjxc3ntlYPAhD0fOhAshWxejL12B/H5iuAtR+l4gH6qCNO/WMBE
 aQsQeLvZiZmUXZe/WlNwbzToxzMcQujtdpdIVLEyF0HcEal81Ah4bHJ+9O8lbArePm6R
 NAUxTZDRjEpLXLkv6iIjDKhrAiC/n04weAdd8E4Lt3OWAhBzFMo7GxUBjTNFpY0h0EX1
 Z5Q/8Bgk3nR2U47iWI9/3cccEs6czXCBaIFJ9e4OZA8gSDETmx1wl5L6UaqOK2In4oJj
 UdC00EVQ6bWuF7NSNz8TOA6pRvQ8VzhaJDBxZnLi68WjvIvlrYW5z+gNU+T3uoQ3K3P5
 PrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600310; x=1732205110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/Mf+gksylMlQN4tQ9eK2BqWgWCztBtTJCqnsjP2hVE=;
 b=Ur8J5NbBcPrSTn9qzuIG0KMENtFxJh+S2stN7LgENBjcaOeXFgjgVmRH+SMhVEdhyh
 laG5EOxsrE0A4rzeFTwcUotuR2QA9Sz0Vw1FKW3b8wYpem/hg687fURoewedKF+tqxbF
 IsbhiYmbpYAoakBl7eLSlBJGghBs8YfYO2pP4vCBzJQ+m90vsdI8cvs1RffS27GAglCa
 Hc76+vJAV16fGg6jcD0/6dyIR4s2Rw+ayo+ZW/vLu+yVChqxBB+NazIsT409LwPOvtuz
 3hWugHUGgrLQ5cgyw3Zy9Wez3bSxX9rrwx2pqc7g+GQehTGS0lZ7+2R3mF6DWHla8jZ6
 Zwkg==
X-Gm-Message-State: AOJu0YzoAvMHfmYE709j0GBC1P8ycWy5BuKfS30xkOxLb/IV0lnJekPQ
 tdBCPZrwNnA7uLv7vUIXyRv6SixmpzITYK31GhreA5qiRVud0MYlRnJC1ELCn1LcU8X6whVP2mb
 R
X-Google-Smtp-Source: AGHT+IHQN+uOU3UVH1D1p7YIV0yK+4+t6thqFAG0EHZgQpoAv0yDRjFLg3x2Q8ssA/CLjeSxHUzB7g==
X-Received: by 2002:a17:903:185:b0:211:3275:3fe with SMTP id
 d9443c01a7336-211b661af32mr80266145ad.17.1731600310179; 
 Thu, 14 Nov 2024 08:05:10 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 41/54] target/mips: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:17 -0800
Message-ID: <20241114160131.48616-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/mips/tcg/tcg-internal.h      |  6 +++---
 target/mips/cpu.c                   |  2 +-
 target/mips/tcg/sysemu/tlb_helper.c | 29 ++++++++++++++++++++---------
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index aef032c48d..f4b00354af 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -61,9 +61,9 @@ void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                     MemTxResult response, uintptr_t retaddr);
 void cpu_mips_tlb_flush(CPUMIPSState *env);
 
-bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool probe, uintptr_t retaddr);
+bool mips_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
+                             MMUAccessType access_type, int mmu_idx,
+                             MemOp memop, int size, bool probe, uintptr_t ra);
 
 void mips_semihosting(CPUMIPSState *env);
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d0a43b6d5c..3a453c9285 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -556,7 +556,7 @@ static const TCGCPUOps mips_tcg_ops = {
     .restore_state_to_opc = mips_restore_state_to_opc,
 
 #if !defined(CONFIG_USER_ONLY)
-    .tlb_fill = mips_cpu_tlb_fill,
+    .tlb_fill_align = mips_cpu_tlb_fill_align,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
     .cpu_exec_halt = mips_cpu_has_work,
     .do_interrupt = mips_cpu_do_interrupt,
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index e98bb95951..ac76396525 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -904,15 +904,28 @@ refill:
 }
 #endif
 
-bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool probe, uintptr_t retaddr)
+bool mips_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
+                             MMUAccessType access_type, int mmu_idx,
+                             MemOp memop, int size,
+                             bool probe, uintptr_t retaddr)
 {
     CPUMIPSState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
     int ret = TLBRET_BADADDR;
 
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        mips_cpu_do_unaligned_access(cs, address, access_type,
+                                     mmu_idx, retaddr);
+    }
+
+    memset(out, 0, sizeof(*out));
+    out->attrs = MEMTXATTRS_UNSPECIFIED;
+    out->lg_page_size = TARGET_PAGE_BITS;
+
     /* data access */
     /* XXX: put correct access by using cpu_restore_state() correctly */
     ret = get_physical_address(env, &physical, &prot, address,
@@ -930,9 +943,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         break;
     }
     if (ret == TLBRET_MATCH) {
-        tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
+        out->phys_addr = physical;
+        out->prot = prot;
         return true;
     }
 #if !defined(TARGET_MIPS64)
@@ -948,9 +960,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
             ret = get_physical_address(env, &physical, &prot, address,
                                        access_type, mmu_idx);
             if (ret == TLBRET_MATCH) {
-                tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                             physical & TARGET_PAGE_MASK, prot,
-                             mmu_idx, TARGET_PAGE_SIZE);
+                out->phys_addr = physical;
+                out->prot = prot;
                 return true;
             }
         }
-- 
2.43.0



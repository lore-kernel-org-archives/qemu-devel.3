Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C977D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcI1-0004xi-GN; Thu, 14 Nov 2024 11:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHu-0004vl-8l
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:42 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHs-0002CC-JE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:41 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ea0ad89e84so491935a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600099; x=1732204899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZmBByG8TldvCZTNhOs8dLsatn8HWp1mSaaGpDvl40n8=;
 b=qB1GvrdCcsv6YqgL7klY/NLq/UD6jlFedudBCgt2IbHuteCNO/9B2PyZhI0shev6tD
 amsZhe4po3N6Q9mIqG1jgSUWnvhJzM9I8J9D77xAUsZRY56dr5qaN6eCQ7O8/4vJGLEV
 aOfYrzlooJ8b5q9W97kV0pPAIZK/n+vMc4UYhdmrKGPjeeevifpU28NWlib1Bdldpevx
 VP+GtjQsNie5ZgcFopzw17w6j9WyZ8Z0+r7+J0m8xIDRrqZT/XWni2lkExjU/yObT+OW
 QmevbqMGg7KDvOjpZcU2Cu4GXNejbbGRIieCDfUxRFExjd6i6A2pyiGDUsu8WzHoLq/i
 Ikiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600099; x=1732204899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmBByG8TldvCZTNhOs8dLsatn8HWp1mSaaGpDvl40n8=;
 b=KnAVqRoFsyrGXNpUsDyZIYv04QoRtMs9F4JE+4cfLIyNWrAD8kzrmtrUFzKTn1UW14
 Tai87bWNncVeYb4CSA0PXKRCWYFGGoaMrZg+fK0l3QaKa1Ft9GThTTjitHRRcEnxr2N9
 Cmo+FG3MRY3IPURVrR19CUKgKQlXf7vc+JwqtBGd3C5pI4fyk53K7C4kn6Js4kDQDqXw
 caFa7MCLyWrleZrWKQMsHFQ4N5GSGRRAK05rB672k6IpOPMOAV3qLVW+Jbwuskd0fSsH
 6JGtIA2XfCnKy95jifevIDhouCwM57lv6LaTjMjMY1DKnjjl2AOM6hLr5/eST2odsG1l
 dtsg==
X-Gm-Message-State: AOJu0Yx7adjL8HfLEQW+7LO7BAxNZfz+ujO7ZO5Gtf77U2n3ArzDHhaB
 fjyztEmrKV5XjvxnUDaQGt+rnc8832fov2kgDCcwyARPsJFg6dNmvj68iow8Sh3FraBkDzX6+1D
 M
X-Google-Smtp-Source: AGHT+IEKv+BQbIXfODjLdJsnKc+8bAuwg6xhNZ5R6C+vHkigu3jSNFrpb3Z8cRRT5GY7aCzaFTIkHA==
X-Received: by 2002:a17:90b:538f:b0:2e7:6e84:a854 with SMTP id
 98e67ed59e1d1-2ea062dd600mr2936115a91.1.1731600099219; 
 Thu, 14 Nov 2024 08:01:39 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/54] accel/tcg: Add IntervalTreeRoot to CPUTLBDesc
Date: Thu, 14 Nov 2024 08:00:45 -0800
Message-ID: <20241114160131.48616-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Add the data structures for tracking softmmu pages via
a balanced interval tree.  So far, only initialize and
destroy the data structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  3 +++
 accel/tcg/cputlb.c    | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index db8a6fbc6e..1ebc999a73 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -35,6 +35,7 @@
 #include "qemu/queue.h"
 #include "qemu/lockcnt.h"
 #include "qemu/thread.h"
+#include "qemu/interval-tree.h"
 #include "qom/object.h"
 
 typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
@@ -290,6 +291,8 @@ typedef struct CPUTLBDesc {
     CPUTLBEntry vtable[CPU_VTLB_SIZE];
     CPUTLBEntryFull vfulltlb[CPU_VTLB_SIZE];
     CPUTLBEntryFull *fulltlb;
+    /* All active tlb entries for this address space. */
+    IntervalTreeRoot iroot;
 } CPUTLBDesc;
 
 /*
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 31c45a6213..aa51fc1d26 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -89,6 +89,13 @@ QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
+/* Extra data required to manage CPUTLBEntryFull within an interval tree. */
+typedef struct CPUTLBEntryTree {
+    IntervalTreeNode itree;
+    CPUTLBEntry copy;
+    CPUTLBEntryFull full;
+} CPUTLBEntryTree;
+
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
 {
     return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
@@ -305,6 +312,7 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
     desc->large_page_mask = -1;
     desc->vindex = 0;
     memset(desc->vtable, -1, sizeof(desc->vtable));
+    interval_tree_free_nodes(&desc->iroot, offsetof(CPUTLBEntryTree, itree));
 }
 
 static void tlb_flush_one_mmuidx_locked(CPUState *cpu, int mmu_idx,
@@ -326,6 +334,7 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
     fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
     fast->table = g_new(CPUTLBEntry, n_entries);
     desc->fulltlb = g_new(CPUTLBEntryFull, n_entries);
+    memset(&desc->iroot, 0, sizeof(desc->iroot));
     tlb_mmu_flush_locked(desc, fast);
 }
 
@@ -365,6 +374,8 @@ void tlb_destroy(CPUState *cpu)
 
         g_free(fast->table);
         g_free(desc->fulltlb);
+        interval_tree_free_nodes(&cpu->neg.tlb.d[i].iroot,
+                                 offsetof(CPUTLBEntryTree, itree));
     }
 }
 
-- 
2.43.0



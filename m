Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9860DC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsW-0007U8-Ib; Fri, 07 Mar 2025 13:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsQ-0007Rj-ED
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:54 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsO-0007m1-GG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:54 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2235908a30aso15234785ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373811; x=1741978611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzyDViup58ROLXi9a5eLqmvAZgtt4FP4fwTvGjoaRo8=;
 b=DywH/P87pkGFFqMRxJ7xn6GRLtOnOdrrX0ym/RwcEANRUHBq7APug8TCsdVZx5OtE2
 ho45EyhEZfKedbyo+D9mKm3uOslz9zi5h36ErRrVztTdjYgs/d3ygVqIF2D9hui7jRMo
 L+g34Ogado4luUc0bH7SzDsHungxD6OvYYVHZtPzlfwGhj0xDhWhOzW/6mKUydJDTbxI
 WTFJfzfMJeTOZR4tDp4J9c3aDm397Uuyax16+ya+avu8hVoO64vLaV95bVdzDMrWN0kL
 Njnm7DnMoR4yopWHlwhy+eGI+LEBPYKwDxAPPmncHmSmlFQBuXXQZu6zJA+yiqUGyAfx
 mR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373811; x=1741978611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzyDViup58ROLXi9a5eLqmvAZgtt4FP4fwTvGjoaRo8=;
 b=BgMs+5RJ8QykdonwP5ODZbmodKptPcd5VJkNesbapQBTwq38nyoR6wg3UhpNP3SfzZ
 +hkDuaK35LKdAyXO73MTprOjz1mzlWZ72lDstWWY3FWT2NTbx32tTi2k4dw0Pt4qGhha
 l49LYa4UNEqvqxiEf/K3BqmGznLG+lfLiSM4Wbe/6WPuehpFKAn2iMjrkI3CNs2jHKcl
 7PaBlVdRG5uM9qnETZ8SfUyjcZj+EnIbCoL1pCr4YpZbtBpp4ISx3ZpqynrC1cbYyXje
 Z3a04yn/BqwZU9hJkVWTbwBL7tXWByQM0aUwvUJAjF+Bq2mTv+DpmqFfEObWtC7GhRpd
 kqGg==
X-Gm-Message-State: AOJu0Yz+CzvNXRU9yLaJYRe0JM8jCGNKAgn8IMMnVgwIMnjC6hmWs5mn
 T1V1FMnlRNjbKPTtmN8Z65tkphgo5EhqlGda+mA7YeTZUzh3OQpz9duLtTSoQMKn99KJefPBGze
 h
X-Gm-Gg: ASbGncvLFfK+oqV52fnFxKQZq24ryrAWzBffERaUeKGj1/7RSEhavypSDkCdgmA4Tfm
 +9SO+rxZgd3QwQxaZ4SJGBRK2W+8LzFlCEnO8HZ1IqjAN8z/zPdKOTRBgR/PhPsRgkMDISpcSDe
 vb1yP7UcXMKRKjOlEgxm6R+YrK2NWu9ODCyeJZzCA5nmYj2GxamlWBWPE3ai/OkRWemlteO76IU
 1Zy/M5ZNiGSCCsu+BVESFJtOD1t/uVMU1WrzOvyqnr6/cRf9H2LNLlvit22cXM7mA6G/v3hdfXW
 rlb9QdFyPtD8fCMBdrQY0tIXZdn4Xx9wHWcBCZHq3eS//TYSzDmqMTxZhTIIKIzhtwy7G92L/LQ
 S
X-Google-Smtp-Source: AGHT+IHHWMIx9HNmHaffyTP2HpiJ/yDQRPiibxBLg45i8lTaa1UT1sXFbutkrSYnD8yZrerMKPYwUA==
X-Received: by 2002:a17:902:e5ce:b0:224:26f5:9c1e with SMTP id
 d9443c01a7336-22428880333mr69820735ad.2.1741373811125; 
 Fri, 07 Mar 2025 10:56:51 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 04/16] exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
Date: Fri,  7 Mar 2025 10:56:33 -0800
Message-ID: <20250307185645.970034-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241114011310.3615-16-philmd@linaro.org>
---
 include/exec/cputlb.h     | 23 +++++++++++++++++++++++
 include/exec/exec-all.h   | 22 ----------------------
 target/sparc/mmu_helper.c |  2 +-
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 6cac7d530f..733ef012d1 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -21,6 +21,7 @@
 #define CPUTLB_H
 
 #include "exec/cpu-common.h"
+#include "exec/vaddr.h"
 
 #ifdef CONFIG_TCG
 
@@ -39,4 +40,26 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 
 #endif
 
+/**
+ * tlb_set_page_full:
+ * @cpu: CPU context
+ * @mmu_idx: mmu index of the tlb to modify
+ * @addr: virtual address of the entry to add
+ * @full: the details of the tlb entry
+ *
+ * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
+ * @full must be filled, except for xlat_section, and constitute
+ * the complete description of the translated page.
+ *
+ * This is generally called by the target tlb_fill function after
+ * having performed a successful page table walk to find the physical
+ * address and attributes for the translation.
+ *
+ * At most one entry for a given virtual address is permitted. Only a
+ * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
+ * used by tlb_flush_page.
+ */
+void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
+                       CPUTLBEntryFull *full);
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index f24256fb5e..f43c67366b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -156,28 +156,6 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                uint16_t idxmap,
                                                unsigned bits);
 
-/**
- * tlb_set_page_full:
- * @cpu: CPU context
- * @mmu_idx: mmu index of the tlb to modify
- * @addr: virtual address of the entry to add
- * @full: the details of the tlb entry
- *
- * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
- * @full must be filled, except for xlat_section, and constitute
- * the complete description of the translated page.
- *
- * This is generally called by the target tlb_fill function after
- * having performed a successful page table walk to find the physical
- * address and attributes for the translation.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
-                       CPUTLBEntryFull *full);
-
 /**
  * tlb_set_page_with_attrs:
  * @cpu: CPU to add this TLB entry for
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 9ff06026b8..7548d01777 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "qemu/qemu-print.h"
 #include "trace.h"
-- 
2.43.0



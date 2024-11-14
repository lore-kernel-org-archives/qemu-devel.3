Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A8D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIh-0005JV-52; Thu, 14 Nov 2024 11:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIN-00052s-1G
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:11 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIH-0002IS-EI
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:10 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ea7e250c54so586571a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600123; x=1732204923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tAszhXmbZO1yYFyoLknvdTRmxQFGefE5ni84P6772pk=;
 b=ydf2ymps/IarHO5o/GpyAgt3AsjHQd14WE2T7hKQKMT4PM/kaZY6oMKLj4XkMaH8l3
 /lYbpAlYAKdUY2P0HxO6btQPd9WERHnzN929ACbcb5jD+Q3tNpTRkh8u+qXPHDIW+lY/
 lMlnv5g8/HoexYPneOLb14i4AyxSqE3CLfVIvS5tUFTeqfOXWH2pAl5Ip+gk93T3BLMv
 WUDu+DoQWjXc/QDfe7hlWkSFwBbW6RePz59ltv1Nm2nRTg/xiXNTvy5UrPm0oe3QooG8
 YCaw87m2YFo0xOfYYdC/PNJHHg2W7qXwtjMX8WWc8+9BuF7+nBGyetkvOciEX85ypLe3
 DZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600123; x=1732204923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAszhXmbZO1yYFyoLknvdTRmxQFGefE5ni84P6772pk=;
 b=i047K5z0+dH4iunKH45pucYlksl5z1EDJfuVJPSTHrZbpG7hSN8xXE8rSxmkp5Wr52
 kOjYDAXWLhXUEet1/5SxzdyQqaeZ7d3QUE/QoeYFvo1VnByat7Eg6g2VSXW4tHcYant+
 KrtPlkd22PrN/z7JFKDWb7YoZqd87xWt3uRUi0ysrF5Jsy2jzdQoYOaoQT3VeuGaKIhE
 pdjkxj1SKtSFE2fnWnwzNs1D2rM7kYYnOvTMjE3jwm0d3fwCQpJchT08NgQpdIfy3y6y
 PXdKauqPNReHA6aQMh0OLQhQfkYCu5szaVn2XTphsv4mEVy5dSq2WZTFtckjF3yJS3f5
 IrBQ==
X-Gm-Message-State: AOJu0YwWLGyDfX9nSwlZfA3XlrYpWJzkU8qZp/4ntz/EWBjlVbDzuy6I
 Q4HkskJvlE9GAOOdsCCLIvK3sTDdHPIevSw6+vc3cEj+EPf1KanE0gIzBSBiGwhHt3/QuiGU+KE
 9
X-Google-Smtp-Source: AGHT+IEyV/vCAiEEJ8K8TBwPUbaYg4B2DmSZnWhdKc8ort+PrLfvfAeh3rjDBqzYjVZcpVu2Ohs8iQ==
X-Received: by 2002:a17:90b:2e8e:b0:2e2:f044:caaa with SMTP id
 98e67ed59e1d1-2ea06a63e77mr3122535a91.37.1731600122925; 
 Thu, 14 Nov 2024 08:02:02 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.02.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:02:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 35/54] target/avr: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:11 -0800
Message-ID: <20241114160131.48616-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
 target/avr/cpu.h    |  7 ++++---
 target/avr/cpu.c    |  2 +-
 target/avr/helper.c | 19 ++++++++++++-------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 4725535102..cdd3bcd418 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -23,6 +23,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/memop.h"
 
 #ifdef CONFIG_USER_ONLY
 #error "AVR 8-bit does not support user mode"
@@ -238,9 +239,9 @@ static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
     env->sregI = (sreg >> 7) & 0x01;
 }
 
-bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr);
+bool avr_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+                            MMUAccessType access_type, int mmu_idx,
+                            MemOp memop, int size, bool probe, uintptr_t ra);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 3132842d56..a7fe869396 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -211,7 +211,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .restore_state_to_opc = avr_restore_state_to_opc,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
     .cpu_exec_halt = avr_cpu_has_work,
-    .tlb_fill = avr_cpu_tlb_fill,
+    .tlb_fill_align = avr_cpu_tlb_fill_align,
     .do_interrupt = avr_cpu_do_interrupt,
 };
 
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 345708a1b3..a18f11aa9f 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -104,11 +104,11 @@ hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return addr; /* I assume 1:1 address correspondence */
 }
 
-bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr)
+bool avr_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
+                            MMUAccessType access_type, int mmu_idx,
+                            MemOp memop, int size, bool probe, uintptr_t ra)
 {
-    int prot, page_size = TARGET_PAGE_SIZE;
+    int prot, lg_page_size = TARGET_PAGE_BITS;
     uint32_t paddr;
 
     address &= TARGET_PAGE_MASK;
@@ -141,15 +141,20 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
              * to force tlb_fill to be called for the next access.
              */
             if (probe) {
-                page_size = 1;
+                lg_page_size = 0;
             } else {
                 cpu_env(cs)->fullacc = 1;
-                cpu_loop_exit_restore(cs, retaddr);
+                cpu_loop_exit_restore(cs, ra);
             }
         }
     }
 
-    tlb_set_page(cs, address, paddr, prot, mmu_idx, page_size);
+    memset(out, 0, sizeof(*out));
+    out->phys_addr = paddr;
+    out->prot = prot;
+    out->attrs = MEMTXATTRS_UNSPECIFIED;
+    out->lg_page_size = lg_page_size;
+
     return true;
 }
 
-- 
2.43.0



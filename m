Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7780ED68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcO7-0004tS-BL; Thu, 14 Nov 2024 11:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLS-0001mS-M9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:27 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLO-00036c-Rd
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:21 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-724455f40a0so576984b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600317; x=1732205117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bj/Re7YaCahV1M4/AVlcGxlPUjwCTTqNcJS3jvHiVnM=;
 b=sm79gGcY8d7R9U9YKWSOalv1jMZv7UuBvgPq7cdJ6da+g9NKr/UziNuCvqYSNH47hQ
 Srumo0PlGl/nla/gilPMRIM9t8Hw6wjsiaasmqa56T5oP/fWWrXxaDgw8jRzRsdEhpYz
 chkQwvqcaOdeXA1ZHsQLlbHd1b4Rs8Y9QRulNIFardDgZ1giQmgWH5TeEdREBlCFoWoW
 5RTXRSDjWbJwN/A9HKPFvLr6MjpR+e2fu65zGAZQh9OYTT4HtIvLnM11+0lMTHIBtSka
 JddtHbtV0kVwKYbmQ970agVARjrNylphT6XkzRbTMKvEgQQ8VVCpfbI+4DJYCa/uUasj
 lcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600317; x=1732205117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bj/Re7YaCahV1M4/AVlcGxlPUjwCTTqNcJS3jvHiVnM=;
 b=ZquKvEDMMsg5ky/ObvffKmMpE4Y6MSYA1gQ4yiLTwr2djc2X2798/9WqZkUi39MTZA
 G4h46Bl6eJsiOZcSVCWVRPQgP3ewoJSPVm8EeBKaGIKZd3uaKV1YS0BKESBMkNhLd61q
 beECbKUQM4XmkiMOF6rFeYJ6RwTZZZXq6YOydlJRt11Z9OtX+YJLWsev75RMSNyzQs+x
 rU9lvabAgLkrnCUOcMz+IjH6nGcuefSjbmP/HggxvA5u9N8n6bGLO6TY/9z3G2Qas/lk
 etyZ5D64ZdeeC1MS+djDk9COnKmEsc3tEKhmryqNZIzVagSSPVVPIaqs9JcRyoILhU8K
 Z1BA==
X-Gm-Message-State: AOJu0YwsbDmsJL2N09nu7UqGN31CfvQUEBdBzeRAepFPxziNiHWNscSR
 unQcw+OW8BVT/RE6WWn5RLArVaHGR1/L+7YNcA9uO9NRx1eJjTeJOKmIXNMnZsS5MaHRaqkdwaD
 0
X-Google-Smtp-Source: AGHT+IHHzrlH5cH6Mf/qYJuZTB1/8Ct1LLnp88Scf1vNvjfLmK/5f02XQ1P2dX3PBcxmhrvvqlLEOg==
X-Received: by 2002:aa7:88c9:0:b0:71e:592d:6fa9 with SMTP id
 d2e1a72fcca58-7241327b6a4mr30110491b3a.1.1731600317101; 
 Thu, 14 Nov 2024 08:05:17 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 50/54] target/xtensa: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:26 -0800
Message-ID: <20241114160131.48616-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/xtensa/cpu.h    |  8 +++++---
 target/xtensa/cpu.c    |  2 +-
 target/xtensa/helper.c | 28 ++++++++++++++++++++--------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 77e48eef19..68c3d90d41 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -31,6 +31,7 @@
 #include "cpu-qom.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-defs.h"
+#include "exec/memop.h"
 #include "hw/clock.h"
 #include "xtensa-isa.h"
 
@@ -580,9 +581,10 @@ struct XtensaCPUClass {
 };
 
 #ifndef CONFIG_USER_ONLY
-bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                         MMUAccessType access_type, int mmu_idx,
-                         bool probe, uintptr_t retaddr);
+bool xtensa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                               vaddr addr, MMUAccessType access_type,
+                               int mmu_idx, MemOp memop, int size,
+                               bool probe, uintptr_t retaddr);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
 bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 6f9039abae..3e4ec97e0e 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -232,7 +232,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .restore_state_to_opc = xtensa_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill = xtensa_cpu_tlb_fill,
+    .tlb_fill_align = xtensa_cpu_tlb_fill_align,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
     .cpu_exec_halt = xtensa_cpu_has_work,
     .do_interrupt = xtensa_cpu_do_interrupt,
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index ca214b948a..69b0e661c8 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -261,15 +261,26 @@ void xtensa_cpu_do_unaligned_access(CPUState *cs,
                                   addr);
 }
 
-bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                         MMUAccessType access_type, int mmu_idx,
-                         bool probe, uintptr_t retaddr)
+bool xtensa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                               vaddr address, MMUAccessType access_type,
+                               int mmu_idx, MemOp memop, int size,
+                               bool probe, uintptr_t retaddr)
 {
     CPUXtensaState *env = cpu_env(cs);
     uint32_t paddr;
     uint32_t page_size;
     unsigned access;
-    int ret = xtensa_get_physical_addr(env, true, address, access_type,
+    int ret;
+
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        xtensa_cpu_do_unaligned_access(cs, address, access_type,
+                                       mmu_idx, retaddr);
+    }
+
+    ret = xtensa_get_physical_addr(env, true, address, access_type,
                                        mmu_idx, &paddr, &page_size, &access);
 
     qemu_log_mask(CPU_LOG_MMU, "%s(%08" VADDR_PRIx
@@ -277,10 +288,11 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                   __func__, address, access_type, mmu_idx, paddr, ret);
 
     if (ret == 0) {
-        tlb_set_page(cs,
-                     address & TARGET_PAGE_MASK,
-                     paddr & TARGET_PAGE_MASK,
-                     access, mmu_idx, page_size);
+        memset(out, 0, sizeof(*out));
+        out->phys_addr = paddr;
+        out->prot = access;
+        out->lg_page_size = ctz32(page_size);
+        out->attrs = MEMTXATTRS_UNSPECIFIED;
         return true;
     } else if (probe) {
         return false;
-- 
2.43.0



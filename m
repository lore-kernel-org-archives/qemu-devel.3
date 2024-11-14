Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC833D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcNJ-0003lS-Et; Thu, 14 Nov 2024 11:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLQ-0001mE-UB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:27 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLO-00036L-9s
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:20 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e681bc315so597778b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600315; x=1732205115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/iKuhhsqlR0EuYEh+MzJkcjXdpnBDTTasC9nFU82FI0=;
 b=GHW9UMAK3ncz9iOPZ/c7Cn+L/0cTqVzgbQ3pJHQ25HdofRMzr79EY69TN84A+J+0vm
 XTOHFd+bkF6XzQ5sbLvIq9xzPjXRoNvyzct59Jlxlyu+BACLUaXFBpy06+63b3IevLh/
 ox8v6XPCW1UXd2r0teyFhE6S1lYkWvCVNG/gSeVqDRpuEb9P3DySJYYnT4OBOsIdalsT
 xUMuLf/EoZBW6XseLaKyFpc3fZAu6oWVOJNGXkJMoMf1O+4zk7LHWPlsOXTnp4ffHwkV
 pV2f8Svr/lX/UBQ8DBXREmV/I0kxnIfiBIPakuJZKWvkcEZOoimGWuMqZXXeTBx8razC
 ce+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600315; x=1732205115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iKuhhsqlR0EuYEh+MzJkcjXdpnBDTTasC9nFU82FI0=;
 b=bAOk9aE6BA6YvgJqaD/W5+rKDjVkSUUHSnuKPRkupd79cKQEIDVNbSyQ3Aam2Oqle/
 +QaPcmSBWDncmj2tryoOxdWyjJzyIGoonU5hnZCE3vR/0Jass7uVZi6Zit7OG/NV65g1
 HP4yYX9Ve43wGt0Mxl3FZ6/rA1HRQ5DBRtqNY/zvZDUOEvMp16EWQxLMNGlgMASBEIwB
 zJ99u4MJkzUQksajcHuDUL9JWfrMqi6UgDUYPAjgtvOa321ZsfZKPX1M7O5XA+/14AJq
 dRY2EzLnHsWZQ8247pbA/oRXh3tF06VYXAVSs1WRCMd3XfJExAUOtTGIPhzue5DP8CGo
 JoAA==
X-Gm-Message-State: AOJu0YwD5DGnycTU5wlD5np3aNOc21q6Kpe17ODNj8Kfa+Dji/Yo36Wg
 l0bzErJ7FNLSxVmg7hwhKT8QykdzprA0T4KlnYNoOIcrJlaeatmPqZl1jsb4GXGh49F2qZ3NyAp
 m
X-Google-Smtp-Source: AGHT+IGVRLIEpFo5IYTccYGmcv3ovGhtJ2PB1h97+XbdHJh4OBbjXz/1MeXXWgdkVOzRDwCGvzyMKg==
X-Received: by 2002:a05:6a00:3bf4:b0:724:6804:d663 with SMTP id
 d2e1a72fcca58-7246804d6ddmr4556490b3a.1.1731600314704; 
 Thu, 14 Nov 2024 08:05:14 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 47/54] target/sh4: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:23 -0800
Message-ID: <20241114160131.48616-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/sh4/cpu.h    |  8 +++++---
 target/sh4/cpu.c    |  2 +-
 target/sh4/helper.c | 24 +++++++++++++++++-------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index d928bcf006..161efdefcf 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -22,6 +22,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
+#include "exec/memop.h"
 #include "qemu/cpu-float.h"
 
 /* CPU Subtypes */
@@ -251,9 +252,10 @@ void sh4_translate_init(void);
 
 #if !defined(CONFIG_USER_ONLY)
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                         MMUAccessType access_type, int mmu_idx,
-                         bool probe, uintptr_t retaddr);
+bool superh_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                               vaddr addr, MMUAccessType access_type,
+                               int mmu_idx, MemOp memop, int size,
+                               bool probe, uintptr_t retaddr);
 void superh_cpu_do_interrupt(CPUState *cpu);
 bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void cpu_sh4_invalidate_tlb(CPUSH4State *s);
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 8f07261dcf..8ca8b90e3c 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -252,7 +252,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .restore_state_to_opc = superh_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill = superh_cpu_tlb_fill,
+    .tlb_fill_align = superh_cpu_tlb_fill_align,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
     .cpu_exec_halt = superh_cpu_has_work,
     .do_interrupt = superh_cpu_do_interrupt,
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 9659c69550..543ac1b843 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -792,22 +792,32 @@ bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                         MMUAccessType access_type, int mmu_idx,
-                         bool probe, uintptr_t retaddr)
+bool superh_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                               vaddr address, MMUAccessType access_type,
+                               int mmu_idx, MemOp memop, int size,
+                               bool probe, uintptr_t retaddr)
 {
     CPUSH4State *env = cpu_env(cs);
     int ret;
-
     target_ulong physical;
     int prot;
 
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        superh_cpu_do_unaligned_access(cs, address, access_type,
+                                       mmu_idx, retaddr);
+    }
+
     ret = get_physical_address(env, &physical, &prot, address, access_type);
 
     if (ret == MMU_OK) {
-        address &= TARGET_PAGE_MASK;
-        physical &= TARGET_PAGE_MASK;
-        tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
+        memset(out, 0, sizeof(*out));
+        out->phys_addr = physical;
+        out->prot = prot;
+        out->lg_page_size = TARGET_PAGE_BITS;
+        out->attrs = MEMTXATTRS_UNSPECIFIED;
         return true;
     }
     if (probe) {
-- 
2.43.0



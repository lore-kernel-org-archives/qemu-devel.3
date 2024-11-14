Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08866D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIc-00059v-1m; Thu, 14 Nov 2024 11:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIO-00053O-Ix
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:13 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-0002J0-AD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:12 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7f46d5d1ad5so601308a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600126; x=1732204926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mq+U5IXUnwEDeWR+OTODGDDIW/H0+4jqgpkcDbxZSzQ=;
 b=ch3zCWn3m6vVm0/JhzFsbYEJVXMIqlFLVVNLbO4EZDhBLwzpKGC+15GnmMVEZiBSaQ
 sE3yCWwU/G9YQgZRgZ4BUI6a2hgf9YdJAoLyvaapwxzcM7x7E2GAnz8NTzI+1mxwAIw4
 qol8Oz2unj7GIrtYuJuAIKxBa1377IA8CTLb3Xc599KFm1+JEynCvtiA3krfgbOrlmxo
 Owbhn6XUwGhOiAkXnc3cxeD1ZKYrhALDSHunOmez+EYrgDuvSon8bPes/dtkLm0Qx7BC
 cPPCBiw9nuD7DLemX/dK5Q6+zCa+Z57rQK+fge+bOePsU+dDOB55+lZ2EBzMnFkkgRWe
 esXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600126; x=1732204926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mq+U5IXUnwEDeWR+OTODGDDIW/H0+4jqgpkcDbxZSzQ=;
 b=MhkR77j0SdHXSWa1Y1mLxEBTliB77pPE05AT8KQAUZJ82BP4EE3Zz+OWBkL9VVzFDT
 EiaUPvSfgCGuD7NXjJ8ZwTHpBQQgZzUtXs900+WE4vXEsCYKiVHhP7y3TztCPkI7HWGD
 pUGASGQD9EZVvzMwWr4G1ibUrpKfA/5SJhdUuJ1mYB4u1ZYSf87uXeNeHH0f/MdZ3+eQ
 v67Gh1RlATsefDAw3ZopeEBDqrANhOp9YNeh5pb4kr6FErl+DWb5yL49nltj8oS1GypW
 CB0lh4NpmttUMGMPW1k9rGyCo3XAvJTOh/XMY5FauTIkY6FXS3v1eiMIOG/qtBAXFvDV
 6d2w==
X-Gm-Message-State: AOJu0YxyEYNA4Qe5PK576Z3DqioWZL2vnUmA8bcYh8zzcCM0nPLwUvh5
 BD7qmduFEopVdrwuA1/TmswX9l7ny06pDNdG9BDj/9i6fk9JAPewippImr0L9ki9x8dngOJmVxs
 4
X-Google-Smtp-Source: AGHT+IGaIzzKrdFQmlHStSAhN9967MNqQOTFltJwD57bsotl36k3RDoYmyM7ot6mo6bkgjcnNC28uA==
X-Received: by 2002:a17:90b:1d81:b0:2e2:b41b:854e with SMTP id
 98e67ed59e1d1-2ea0631e509mr3132742a91.20.1731600126372; 
 Thu, 14 Nov 2024 08:02:06 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.02.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:02:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 38/54] target/m68k: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:14 -0800
Message-ID: <20241114160131.48616-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
 target/m68k/cpu.h    |  7 ++++---
 target/m68k/cpu.c    |  2 +-
 target/m68k/helper.c | 22 +++++++++++++---------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b5bbeedb7a..4401426a0b 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -22,6 +22,7 @@
 #define M68K_CPU_H
 
 #include "exec/cpu-defs.h"
+#include "exec/memop.h"
 #include "qemu/cpu-float.h"
 #include "cpu-qom.h"
 
@@ -582,10 +583,10 @@ enum {
 #define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 1
 
-bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool probe, uintptr_t retaddr);
 #ifndef CONFIG_USER_ONLY
+bool m68k_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+                             MMUAccessType access_type, int mmu_idx,
+                             MemOp memop, int size, bool probe, uintptr_t ra);
 void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  unsigned size, MMUAccessType access_type,
                                  int mmu_idx, MemTxAttrs attrs,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 5fe335558a..5316cf8922 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -550,7 +550,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill = m68k_cpu_tlb_fill,
+    .tlb_fill_align = m68k_cpu_tlb_fill_align,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
     .cpu_exec_halt = m68k_cpu_has_work,
     .do_interrupt = m68k_cpu_do_interrupt,
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9bfc6ae97c..1decb6f39c 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -950,9 +950,10 @@ void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector)
     }
 }
 
-bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                       MMUAccessType qemu_access_type, int mmu_idx,
-                       bool probe, uintptr_t retaddr)
+bool m68k_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                             vaddr address, MMUAccessType qemu_access_type,
+                             int mmu_idx, MemOp memop, int size,
+                             bool probe, uintptr_t retaddr)
 {
     CPUM68KState *env = cpu_env(cs);
     hwaddr physical;
@@ -961,12 +962,14 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     int ret;
     target_ulong page_size;
 
+    memset(out, 0, sizeof(*out));
+    out->attrs = MEMTXATTRS_UNSPECIFIED;
+
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         /* MMU disabled */
-        tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     address & TARGET_PAGE_MASK,
-                     PAGE_READ | PAGE_WRITE | PAGE_EXEC,
-                     mmu_idx, TARGET_PAGE_SIZE);
+        out->phys_addr = address;
+        out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        out->lg_page_size = TARGET_PAGE_BITS;
         return true;
     }
 
@@ -985,8 +988,9 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     ret = get_physical_address(env, &physical, &prot,
                                address, access_type, &page_size);
     if (likely(ret == 0)) {
-        tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot, mmu_idx, page_size);
+        out->phys_addr = physical;
+        out->prot = prot;
+        out->lg_page_size = ctz32(page_size);
         return true;
     }
 
-- 
2.43.0



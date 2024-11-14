Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56183D68B35
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJR-0006DW-Gs; Thu, 14 Nov 2024 11:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIO-00053M-E9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:13 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIH-0002IL-EO
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:12 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ea0c38f0fdso445138a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600122; x=1732204922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EV/r07ktWnLxfLmkCAX5tos07YFLZkZRGQVALb+yUNI=;
 b=H0VUJMztw/msRM7o+u2NlBt+hA+iTUI4lbaDdutJIC2HbR5JM5hU1Tg2AcA2mdQke1
 kljYLq8X0ik/0Jc4AegTU6E28/4yr86P1vQOrGPVuGcHvTBGWEgAoEofQoVH3Gf/cAN4
 18lChzKs/5qzrl3zWRiZPFqbGMAmdeUHCnSV9vr/zEhvFWahLc9vVQq/fKSqFWEKHDq4
 YYAX8FkCh9TpT8dWjqs/z9f3LaXaSgy/QiA3G5OWaDO7iz50O19jKXy4Dlty03lGQsYu
 mKr7889mAdNO6i/xAcLLgj7MigAaMW3GBOG/kMkaknEFVod1c4FEar/peXFtOOcZVRzm
 x10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600122; x=1732204922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EV/r07ktWnLxfLmkCAX5tos07YFLZkZRGQVALb+yUNI=;
 b=wIVJEUlNX2TYsGyzSKqu/aECHUxCxvqQc4DRqADNcsRRAsjv8bLCwxKxa8pRwvC9Kr
 nEADhyhY5MQwFHv7o4xNJmJ8NiIz4hMe5uhg78Z6kDoVY23uEKCgPKl2QICAsKKjf1Tn
 3blpQeGx9ZXwvi6PJzVWzvdNJ7XWrjGFkrjnIfc4iJ4oHE6kWGf0ZS6pRzM5djg1dzxa
 4zoGT0pPNJIC2gYLfyflUQunoSekdvNuT56D4xU0u7PAgQQjydDajuOM9I8NbgIwNM/V
 wSI6zSNnci6wCLSPRHjurTDPIPY3eqHB1HyW0NBTBO/pga+OCrpkTFQNt+oCIIOjLBLJ
 SwkQ==
X-Gm-Message-State: AOJu0YzJvkkUeZKkqRiaMmfoEeqQBUlHSc7oakmLRPh7hlA5VqrOFeMb
 tyoaQq3sH7JsJS/lB2TxvHnExfaMaiNmj+chIqItyB3ALgnvaWzR+hLuw9DdfDB8AEI9/s46H64
 Y
X-Google-Smtp-Source: AGHT+IGO2bsWqDyD+rL/vjKX4YAILOdj+fMZ7o0pC47qOMByxfmN28ckAczbfFCVv3HsxgM3Ws+Xpw==
X-Received: by 2002:a17:90b:1c8d:b0:2e2:de27:db09 with SMTP id
 98e67ed59e1d1-2e9b17415demr31437722a91.19.1731600122206; 
 Thu, 14 Nov 2024 08:02:02 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.02.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:02:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 34/54] target/alpha: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:10 -0800
Message-ID: <20241114160131.48616-35-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h    |  6 +++---
 target/alpha/cpu.c    |  2 +-
 target/alpha/helper.c | 23 +++++++++++++++++------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 3556d3227f..70331c0b83 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -449,9 +449,9 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
 void alpha_cpu_record_sigbus(CPUState *cs, vaddr address,
                              MMUAccessType access_type, uintptr_t retaddr);
 #else
-bool alpha_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                        MMUAccessType access_type, int mmu_idx,
-                        bool probe, uintptr_t retaddr);
+bool alpha_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+                              MMUAccessType access_type, int mmu_idx,
+                              MemOp memop, int size, bool probe, uintptr_t ra);
 G_NORETURN void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                               MMUAccessType access_type, int mmu_idx,
                                               uintptr_t retaddr);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 5d75c941f7..7bcc48420d 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -228,7 +228,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .record_sigsegv = alpha_cpu_record_sigsegv,
     .record_sigbus = alpha_cpu_record_sigbus,
 #else
-    .tlb_fill = alpha_cpu_tlb_fill,
+    .tlb_fill_align = alpha_cpu_tlb_fill_align,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
     .cpu_exec_halt = alpha_cpu_has_work,
     .do_interrupt = alpha_cpu_do_interrupt,
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2f1000c99f..26eadfe3ca 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -294,14 +294,21 @@ hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return (fail >= 0 ? -1 : phys);
 }
 
-bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
-                        MMUAccessType access_type, int mmu_idx,
-                        bool probe, uintptr_t retaddr)
+bool alpha_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+                              MMUAccessType access_type, int mmu_idx,
+                              MemOp memop, int size, bool probe, uintptr_t ra)
 {
     CPUAlphaState *env = cpu_env(cs);
     target_ulong phys;
     int prot, fail;
 
+    if (addr & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        alpha_cpu_do_unaligned_access(cs, addr, access_type, mmu_idx, ra);
+    }
+
     fail = get_physical_address(env, addr, 1 << access_type,
                                 mmu_idx, &phys, &prot);
     if (unlikely(fail >= 0)) {
@@ -314,11 +321,15 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         env->trap_arg2 = (access_type == MMU_DATA_LOAD ? 0ull :
                           access_type == MMU_DATA_STORE ? 1ull :
                           /* access_type == MMU_INST_FETCH */ -1ull);
-        cpu_loop_exit_restore(cs, retaddr);
+        cpu_loop_exit_restore(cs, ra);
     }
 
-    tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
-                 prot, mmu_idx, TARGET_PAGE_SIZE);
+    memset(out, 0, sizeof(*out));
+    out->phys_addr = phys;
+    out->prot = prot;
+    out->attrs = MEMTXATTRS_UNSPECIFIED;
+    out->lg_page_size = TARGET_PAGE_BITS;
+
     return true;
 }
 
-- 
2.43.0



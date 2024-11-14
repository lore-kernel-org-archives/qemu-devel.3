Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD90D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcOQ-0005Jt-2q; Thu, 14 Nov 2024 11:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLQ-0001mB-MG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:27 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLO-00036X-9p
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:19 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so636044b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600316; x=1732205116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9nz66+lLu2GQe/uhCiK8Lu0UqaZ0it8xcxl9KTGeICs=;
 b=hrhomyc7oDrtl/T+yrlHVuMTxj2igSBr9po7/BPODnR5tcCrnENEn237BYsdgdYo9Y
 ha1+xKlopP/X/fVvHyNDLK3ixSS2WiPeQwnMCTA95fTD/RLRLJVcHyjhsnsjSz9PCHi9
 0HGT8foPKd9NGJTLz+itgKrlK60ISSIhDJGWVCcrdozbFw9Dk6VpczFvRpHrCf9Ib7wh
 1PNernK2LwD0v261CsenbYzJObTAdrYsUp+1U4h4lgmdb+33NQoSvy3Ko3QK5DQxb5SD
 ZFxMYu1rjarSK7HACJCoKiakRhpYOoShylOvDLSAOmpoLVQffUKEDtnyv5YI4W8KqX9M
 B3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600316; x=1732205116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nz66+lLu2GQe/uhCiK8Lu0UqaZ0it8xcxl9KTGeICs=;
 b=fze+oRAmb+b7gyI9CbPuX/9BT5NglE9Vc18VfezpllVwhfwCoC2NGQbhBNTi4zb7dB
 iUf4vqahfndBttfekcEU0o+NavXtCVe75zjCW4ma+REwQaeAvIcUlfr8MFG0jvNgp+gP
 LVxO4eJKcrOCbl46gY5BTXQ5DkfFDga+/VJM/k051oKV0yaH1/4z8wc9M/XqKpL1bp9e
 8isBHKiqMqJqSMikoynK2+PL16AL+O1VY1ZKIazM1gwRj870r9QvTyYc1klDJUoUdxgA
 A5P/NPCzu2IW6zxgfCZTgFSnjqqSnIMAR4LmRWplWXfM7UYQtTu8G+ICf3N5dNarZuE/
 Qtyw==
X-Gm-Message-State: AOJu0YzcBP6eZGfhI2qunHunPNxKrrQX/MY7W0vswDBNOztJyTYrk7zm
 oCNO8dFomjmuI80Rd/3GWuEo0vDdR8Pgb5jemVbp2HGnJsDDJNc7xAsgpQs1SMBXM3eqpyy7tTw
 9
X-Google-Smtp-Source: AGHT+IF8SLdAKjSr5fcT9yE2AZtutkW+OgOe31Z/tOjbkTvktdkTDUwzv3LOGjNXVzdwBlfCyc5j2g==
X-Received: by 2002:aa7:88c8:0:b0:71e:f83:5c00 with SMTP id
 d2e1a72fcca58-72469c485bfmr3740544b3a.2.1731600316282; 
 Thu, 14 Nov 2024 08:05:16 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 49/54] target/tricore: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:25 -0800
Message-ID: <20241114160131.48616-50-richard.henderson@linaro.org>
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
 target/tricore/cpu.h    |  7 ++++---
 target/tricore/cpu.c    |  2 +-
 target/tricore/helper.c | 19 ++++++++++++-------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 220af69fc2..5f141ce8f3 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -268,8 +268,9 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, vaddr *pc,
 #define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
 
 /* helpers.c */
-bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                          MMUAccessType access_type, int mmu_idx,
-                          bool probe, uintptr_t retaddr);
+bool tricore_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                                vaddr addr, MMUAccessType access_type,
+                                int mmu_idx, MemOp memop, int size,
+                                bool probe, uintptr_t retaddr);
 
 #endif /* TRICORE_CPU_H */
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 1a26171590..29e0b5d129 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -173,7 +173,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .initialize = tricore_tcg_init,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
-    .tlb_fill = tricore_cpu_tlb_fill,
+    .tlb_fill_align = tricore_cpu_tlb_fill_align,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
 };
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 7014255f77..8c6bf63298 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -64,16 +64,19 @@ static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
 {
 }
 
-bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                          MMUAccessType rw, int mmu_idx,
-                          bool probe, uintptr_t retaddr)
+bool tricore_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                                vaddr address, MMUAccessType access_type,
+                                int mmu_idx, MemOp memop, int size,
+                                bool probe, uintptr_t retaddr)
 {
     CPUTriCoreState *env = cpu_env(cs);
     hwaddr physical;
     int prot;
     int ret = 0;
+    int rw = access_type & 1;
+
+    /* TODO: alignment faults not currently handled. */
 
-    rw &= 1;
     ret = get_physical_address(env, &physical, &prot,
                                address, rw, mmu_idx);
 
@@ -82,9 +85,11 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                   __func__, address, ret, physical, prot);
 
     if (ret == TLBRET_MATCH) {
-        tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
-                     mmu_idx, TARGET_PAGE_SIZE);
+        memset(out, 0, sizeof(*out));
+        out->phys_addr = physical;
+        out->prot = prot | PAGE_EXEC;
+        out->lg_page_size = TARGET_PAGE_BITS;
+        out->attrs = MEMTXATTRS_UNSPECIFIED;
         return true;
     } else {
         assert(ret < 0);
-- 
2.43.0



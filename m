Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B56CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2x-0006W8-Ga; Sat, 05 Oct 2024 16:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2w-0006V3-DX
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:34 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2s-0001pQ-IC
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20bc506347dso27103995ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158780; x=1728763580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AFMCCsh2dZpLpZMXFYavJotm9FHniFYW8AGrgK05Hs=;
 b=W684qDrv9e+rU+AfZ4SNTfi6obvo2LcmM2x0VKZHOP8T1tKDu3J/W8ja2ztaDZN4Nb
 MHyquZihJ1yEtGfdE3QD8uXTts9ej2COkd31/g/cnjMqsjWH5eq+h5HY232pRyLGT4Og
 aS7vaCA2Eu1GbCS3hVYJe8S1SNPilNWWsVoC5jJ4dsiS3W9tIHefW0RqSBgTy6im7jzJ
 +dYpjJOhpffigFCycRiKrz6YhVXappHs38kWY6XO84EXSKS85L6Tlu7Lyx4xoTOvMTzP
 iIBDU1jDCg96Nuc/YueoTefDM9QSbn0ZxwEl/NGB+afyf8UUOCFS5Q8dF/txgvpPBGcp
 xyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158780; x=1728763580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0AFMCCsh2dZpLpZMXFYavJotm9FHniFYW8AGrgK05Hs=;
 b=JXQPTpR71wN8qvHWbdnXkOUjL+WneSvpUYkhXfgXLNVDXQKYZreQPcHWAkjGjwszgD
 GFfPR+hbzHJ+SViOvcJHLWC/KqFbjS2vRRxIaGAAUMKP/G/fFlSsKhczIV1ZLVwVDPqz
 WWWopR6CpXSkWG9D0lUlllv7fNBPiPmzA6RMvLFApJUqXOCVWtZ8ddhfxQGPiqTCNvDi
 6P5WFgrRfSTCBMhFVhEhqbhQbKIS/3Z0z7thQusBZ1FFapp7x/EWPIsudJ/HX/h8gc7d
 tRl/8ySPhReC7CYeE31G74QWs3DzT8KyqOVcn2+Fo+HA+cE4ETpOFEwx2b+JddLoE6tY
 LaHg==
X-Gm-Message-State: AOJu0YyF296gqZNwvrogQirfqOTwtQglrhMFSL5y6A5v7XZ7lb9c272b
 8Jb4LMloLTRGu7PC7O8AqJY1Iqaf0wBtl1017IC5bK9Vyzp30zWZfv90tTy2d/OE893SVMz8/C8
 9
X-Google-Smtp-Source: AGHT+IFQWlOaLHXh4IPf9U+1cxmSVfYPLms4xolaX7BFBENlDrFNojC92ydhZIWJvqWY9iSxsqXglg==
X-Received: by 2002:a17:903:32ca:b0:206:9818:5439 with SMTP id
 d9443c01a7336-20bfdff2fe6mr85317145ad.19.1728158780508; 
 Sat, 05 Oct 2024 13:06:20 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 20/21] target/arm: Add arm_cpu_tlb_fill_align
Date: Sat,  5 Oct 2024 13:05:59 -0700
Message-ID: <20241005200600.493604-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fill in the tlb_fill_align hook.  So far this is the same
as tlb_fill_align_first, except that we can pass memop to
get_phys_addr as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  3 +++
 target/arm/cpu.c            |  2 +-
 target/arm/tcg/cpu-v7m.c    |  2 +-
 target/arm/tcg/tlb_helper.c | 27 +++++++++++++++++++++++----
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a6088d551c..6916d43009 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -819,6 +819,9 @@ void arm_cpu_record_sigbus(CPUState *cpu, vaddr addr,
 bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
+bool arm_cpu_tlb_fill_align(CPUState *cs, vaddr address, MemOp memop,
+                            int size, MMUAccessType access_type,
+                            int mmu_idx, bool probe, uintptr_t retaddr);
 #endif
 
 static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 08731ed4e0..293eb5949e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2663,7 +2663,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
 #else
-    .tlb_fill_align = tlb_fill_align_first,
+    .tlb_fill_align = arm_cpu_tlb_fill_align,
     .tlb_fill = arm_cpu_tlb_fill,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 8874fe0e11..a071979636 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -242,7 +242,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
 #else
-    .tlb_fill_align = tlb_fill_align_first,
+    .tlb_fill_align = arm_cpu_tlb_fill_align,
     .tlb_fill = arm_cpu_tlb_fill,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 1d8b7bcaa2..e83ece9462 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -318,9 +318,9 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     arm_deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
 }
 
-bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr)
+static bool tlb_fill_internal(CPUState *cs, vaddr address, int size,
+                              MMUAccessType access_type, MemOp memop,
+                              int mmu_idx, bool probe, uintptr_t retaddr)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GetPhysAddrResult res = {};
@@ -344,7 +344,7 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
      * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
      * register format, and signal the fault.
      */
-    ret = get_phys_addr(&cpu->env, address, access_type, 0,
+    ret = get_phys_addr(&cpu->env, address, access_type, memop,
                         core_to_arm_mmu_idx(&cpu->env, mmu_idx),
                         &res, fi);
     if (likely(!ret)) {
@@ -371,6 +371,25 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         arm_deliver_fault(cpu, address, access_type, mmu_idx, fi);
     }
 }
+
+bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
+{
+    return tlb_fill_internal(cs, address, size, access_type, 0,
+                             mmu_idx, probe, retaddr);
+}
+
+bool arm_cpu_tlb_fill_align(CPUState *cs, vaddr address, MemOp memop,
+                            int size, MMUAccessType access_type,
+                            int mmu_idx, bool probe, uintptr_t retaddr)
+{
+    if (unlikely(address & ((1 << memop_alignment_bits(memop)) - 1))) {
+        arm_cpu_do_unaligned_access(cs, address, access_type, mmu_idx, retaddr);
+    }
+    return tlb_fill_internal(cs, address, size, access_type, memop,
+                             mmu_idx, probe, retaddr);
+}
 #else
 void arm_cpu_record_sigsegv(CPUState *cs, vaddr addr,
                             MMUAccessType access_type,
-- 
2.43.0



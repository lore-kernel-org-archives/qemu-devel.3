Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A076D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcM0-00020K-Nk; Thu, 14 Nov 2024 11:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLJ-0001dy-Rx
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:16 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLH-000314-QN
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:13 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7240d93fffdso620182b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600309; x=1732205109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4jkf2KaCd4Q7nWGpqdRhWv638MMOGvY55gPInd4iokE=;
 b=b4bQzPKk66Q3c61TVcrRkiOxgH0vHPzwVvItgZSVJ5kLwsN2Vh53vzXtY+WtqFb1M9
 q2DWZc1DQOxM8iECoyo+iU373/1VTKNJP990HvSDM25cPY/nVfBnHdtCEmEF1TBrbpQH
 n+KjXHzk2C/xjXBxEeBZbtcF98Cge4axwnZzZp155yznejwqqermD9bf6gu2cBG25Fk4
 Q6Do57vHmMj5E/ivI1y2Q8O2fISTnGPLRc0uo9VEiR/5bgeu83q5Gno9cJOJVFu3cxL6
 /WEO3X/KKVGEksgwviwHglw5pYxGmqZkk6f9WOrLuRrvZBW3thscqNpC/Xuz00WFcJN9
 uQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600309; x=1732205109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4jkf2KaCd4Q7nWGpqdRhWv638MMOGvY55gPInd4iokE=;
 b=blBHoq02kY05FRxdf3zJtsZDCwhZHQaS2g0SjtZ9vCQaxPGR216ejSTm7lTIBthpAX
 2bYbSGHxas4j4pkHqE9ElTqdTFRHcForx22OtHxRgosVWJQkNeDwt1FWUu2OJI0U1yu2
 zZ4pV4y9rtkYzQtvIW8R1tvrTMNE/cBp6AO/0wuH2FiAFPoyHUNL/JYDTI7YGrNW1VVd
 DoWzisS8SXSvFd7vKPBbCR6ywDZop//TyMWeZk63Vx51h4kbwh+XkTBy/24DPpZnav/j
 QI8FhHjBMI4dmEFK/z5KeEDgNqovN/kXjY61h4oljpWfFMLjwGV6leazaPPzPjgtXo3I
 i7Kg==
X-Gm-Message-State: AOJu0YyJvxVwC0WozJPlhqRsfmi3pkOWkago2ejffcweWf60Jjv8RDWo
 XNSKV1i/8GNy/o2QZ4mYTkWQbg7c74eY5DUknaOY7fsi1I9vwNTI1VbPiA6sGlmNHfNIldPps+8
 1
X-Google-Smtp-Source: AGHT+IFFeIzm6hWAZPY2v/wwoyv/wazNDLdLgnmOTVwADsqlppY7G8NekegJo5pZrItxcmG+MXrgXg==
X-Received: by 2002:a05:6a00:21ca:b0:71e:6a57:7290 with SMTP id
 d2e1a72fcca58-72457828d9amr9003406b3a.0.1731600309345; 
 Thu, 14 Nov 2024 08:05:09 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 40/54] target/microblaze: Convert to
 TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:16 -0800
Message-ID: <20241114160131.48616-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
 target/microblaze/cpu.h    |  7 +++----
 target/microblaze/cpu.c    |  2 +-
 target/microblaze/helper.c | 33 ++++++++++++++++++++-------------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3e5a3e5c60..b0eadfd9b1 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -421,10 +421,9 @@ static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
 }
 
 #if !defined(CONFIG_USER_ONLY)
-bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                     MMUAccessType access_type, int mmu_idx,
-                     bool probe, uintptr_t retaddr);
-
+bool mb_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
+                            MMUAccessType access_type, int mmu_idx,
+                           MemOp memop, int size, bool probe, uintptr_t ra);
 void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                unsigned size, MMUAccessType access_type,
                                int mmu_idx, MemTxAttrs attrs,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 710eb1146c..212cad2143 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -425,7 +425,7 @@ static const TCGCPUOps mb_tcg_ops = {
     .restore_state_to_opc = mb_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill = mb_cpu_tlb_fill,
+    .tlb_fill_align = mb_cpu_tlb_fill_align,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
     .cpu_exec_halt = mb_cpu_has_work,
     .do_interrupt = mb_cpu_do_interrupt,
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 5d3259ce31..b6375564b4 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -36,37 +36,44 @@ static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
     }
 }
 
-bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                     MMUAccessType access_type, int mmu_idx,
-                     bool probe, uintptr_t retaddr)
+bool mb_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
+                           MMUAccessType access_type, int mmu_idx,
+                           MemOp memop, int size,
+                           bool probe, uintptr_t retaddr)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
     MicroBlazeMMULookup lu;
     unsigned int hit;
-    int prot;
-    MemTxAttrs attrs = {};
 
-    attrs.secure = mb_cpu_access_is_secure(cpu, access_type);
+    if (address & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        mb_cpu_do_unaligned_access(cs, address, access_type, mmu_idx, retaddr);
+    }
+
+    memset(out, 0, sizeof(*out));
+    out->attrs.secure = mb_cpu_access_is_secure(cpu, access_type);
+    out->lg_page_size = TARGET_PAGE_BITS;
 
     if (mmu_idx == MMU_NOMMU_IDX) {
         /* MMU disabled or not available.  */
-        address &= TARGET_PAGE_MASK;
-        prot = PAGE_RWX;
-        tlb_set_page_with_attrs(cs, address, address, attrs, prot, mmu_idx,
-                                TARGET_PAGE_SIZE);
+        out->phys_addr = address;
+        out->prot = PAGE_RWX;
         return true;
     }
 
     hit = mmu_translate(cpu, &lu, address, access_type, mmu_idx);
     if (likely(hit)) {
-        uint32_t vaddr = address & TARGET_PAGE_MASK;
+        uint32_t vaddr = address;
         uint32_t paddr = lu.paddr + vaddr - lu.vaddr;
 
         qemu_log_mask(CPU_LOG_MMU, "MMU map mmu=%d v=%x p=%x prot=%x\n",
                       mmu_idx, vaddr, paddr, lu.prot);
-        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, lu.prot, mmu_idx,
-                                TARGET_PAGE_SIZE);
+
+        out->phys_addr = paddr;
+        out->prot = lu.prot;
         return true;
     }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34942CFA742
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fb-00026q-Pu; Sat, 05 Oct 2024 11:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fY-00024p-87
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:08 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fW-0002O9-9y
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:26:08 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20b90ab6c19so33845305ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141964; x=1728746764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rc7m2CC+o/vfg9459Vx/ro/giFzSXc14VGjLvy+03yM=;
 b=RGG8ZX+/MqLNYXDfLP15/ANLNc65VPRwR3KzFbN3af0xA2e5ROyFd2XeC2/Lt1TwZm
 V2dz+vxSngftG+64OLK1zXC8HJzEmDEDu3HUTk0expctHzWMWHw3yixx3w+DSvkK3+A6
 a5VWGlfF5QwB84qAMwv/49Pm1WKoWkfidLBUiJAnWv/P8ZtlwvVOi8b1th/Z6VfuAE/t
 smI6poTYw/liJiC34tA+gCdqCcmAwDmkA+09Fk6x9OvoE5H/wT7jRvFKM8yHqDxjl7fX
 HDWlhtTtzqq+Fx4fE5ZyXf6Uect8x9VgNpJOsPcBIW4rf0gcvioe27LiXHnl0g2eer3Y
 5lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141964; x=1728746764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rc7m2CC+o/vfg9459Vx/ro/giFzSXc14VGjLvy+03yM=;
 b=SLynjWMJWAF49kqvQ/Nz89uqdQsdhf7Cd5LQGjAWK2GAh7VWYbgLOY5tRwFmp86SJ+
 9LLLLyejJrGwz67/pqCSC3DksLTn6JtB3C2yJxMQGCXesiAJFB495Ode6+OtwOlM5t8a
 wK0+WjKs8PK//u9zPCTLZK+uy4FwyeQ9ipKasZPJ/Hp+2i950N0pacOH19pxgM8If3lk
 0vQpN8iHqJNceBS8NKdNNeWh4nuXTeRUBviFH8/4TUpNHBihnOk7pcBnnfKhUe8HOGEI
 5iRL3fWrrkdlTpkvl3DSmlBBfRHKLaysMgc6LBaw0sgXBhDTyLCm/gQzirRWdzOBGSHe
 Pm8g==
X-Gm-Message-State: AOJu0YzzpgVyqtnqYuLNS3erxDSIUrKrm6wpFHiM+EwpCkJKG34BBTcI
 Uc8sOXAH8UGH2aVl4t/+IRoQDfX0GF5NDhGSGusMjZeWKNzaGncquvRqqoaPro+nRyjHlDU8MsK
 F
X-Google-Smtp-Source: AGHT+IEvLU9GLG2DeoI40muI2sipayJdhU5jBLMkBCCO1UbeJJe53a/eQXNvSkSI8ZhFOYTqxOfpOg==
X-Received: by 2002:a17:902:db04:b0:205:709e:1949 with SMTP id
 d9443c01a7336-20bff04dd11mr92195455ad.57.1728141964403; 
 Sat, 05 Oct 2024 08:26:04 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:26:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 12/20] target/hppa: Add hppa_cpu_tlb_fill_align
Date: Sat,  5 Oct 2024 08:25:43 -0700
Message-ID: <20241005152551.307923-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Fill in the tlb_fill_align hook, so that we can recognize
alignment exceptions in the correct priority order.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  3 +++
 target/hppa/cpu.c        |  2 +-
 target/hppa/mem_helper.c | 16 ++++++++++++----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 526855f982..c0567ce0ab 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -366,6 +366,9 @@ void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled);
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
+bool hppa_cpu_tlb_fill_align(CPUState *cs, vaddr address, MemOp mop, int size,
+                             MMUAccessType access_type, int mmu_idx,
+                             bool probe, uintptr_t retaddr);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 3b6c325e09..768abc6e5d 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -226,7 +226,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill_align = tlb_fill_align_first,
+    .tlb_fill_align = hppa_cpu_tlb_fill_align,
     .tlb_fill = hppa_cpu_tlb_fill,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
     .cpu_exec_halt = hppa_cpu_has_work,
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index d38054da8a..35e9170bf3 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -424,9 +424,9 @@ void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     }
 }
 
-bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
-                       MMUAccessType type, int mmu_idx,
-                       bool probe, uintptr_t retaddr)
+bool hppa_cpu_tlb_fill_align(CPUState *cs, vaddr addr, MemOp mop, int size,
+                             MMUAccessType type, int mmu_idx,
+                             bool probe, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
@@ -445,7 +445,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         break;
     }
 
-    excp = hppa_get_physical_address(env, addr, mmu_idx, a_prot, 0,
+    excp = hppa_get_physical_address(env, addr, mmu_idx, a_prot, mop,
                                      &phys, &prot);
     if (unlikely(excp >= 0)) {
         if (probe) {
@@ -473,6 +473,14 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     return true;
 }
 
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                       MMUAccessType type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
+{
+    return hppa_cpu_tlb_fill_align(cs, addr, 0, size, type,
+                                   mmu_idx, probe, retaddr);
+}
+
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
 void HELPER(itlba_pa11)(CPUHPPAState *env, target_ulong addr, target_ulong reg)
 {
-- 
2.43.0



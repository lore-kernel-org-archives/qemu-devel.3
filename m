Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498A4D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcNP-00047h-UP; Thu, 14 Nov 2024 11:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLQ-0001mA-LU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:27 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcLO-00034C-0S
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:05:19 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-723db2798caso751484b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600313; x=1732205113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nc2uEpCTHuP4WgyDpbnyFTPw+frcLZQWSz4dicwWNic=;
 b=o0XFkiQmvEzGYalgTWKCceMWsbKFRP8vYi/6a4G+l1Fa/79+7kamd2qdo/kMwuBKMQ
 aPRJSc0V5/6A8FhUFxHw6twjn+f/AtnIWf4l5Mf39ifOTtSlRmPRuk9n498y61nJQzCV
 FsQ14Wrh+GajGr+oYl2ewhfsd2O+1A59nHZEloAzSi5rKrDMGwpL+kz3EkXDGPHjqtmt
 6cLwiZKBiMFe5BuUsfiYHrrF99hDpxUxwddutaAVEpgRw747n6gwWU4ATYvzM7vMtDU2
 BwFx0NydBuZOtyKzVnORgqLKtcDCz0+1gm0vmWAXLy97ZIiSummH1n4FV+3B7MUucMas
 Sodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600313; x=1732205113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nc2uEpCTHuP4WgyDpbnyFTPw+frcLZQWSz4dicwWNic=;
 b=TY20KlZZGONqyzvMpMMVEfMM0Yso8CsQi/8gYm1Xk0J926iWf/aDOonrf1BxOD/1vg
 Zv45AZlmil5Q796WYs8sEiCkaD8wITrbgOpWGZ8OTh/G4an2dy2MyQPxZGEqF05K8TwP
 w8GNpyDjV8q9owYMEjV+PsWmy5y9R3Rb4rdgX/ObtRO3dTFIUQwkgMO89/RkBDRqhsHI
 PXWWdNA7Jxc9jwM8QC/0X9Hg7p30Cn5XN3HbYHcohzEihEJ6kYmNX55gTnA/cl1K/1BS
 krKLP+K5QaQwXYnwdQZgdkxP3G6E50ZSY6hy82osrFjxXKp8s8NuWa4/ZpWXjcAyd9W7
 TY8A==
X-Gm-Message-State: AOJu0Yz9YbSynId93uwhZ+AcWobXsUZZ77CAHcRB77eFC9nHeXJXiB79
 Xu4GVGI5LFU4/G0bAxyMso0J8arH2aRrVUO1Ge4a9rdc8bE9t2rnGPIW3+lb6oqRhTcEjbh+RVp
 i
X-Google-Smtp-Source: AGHT+IHQRU9f+dWRMqldDHp7M+xVk37euYiBWfVuo+7EeuLplWzUbxFNAjcJ2Wvq4BK4cu6aKsrS3w==
X-Received: by 2002:a05:6a00:3d01:b0:71e:8046:2728 with SMTP id
 d2e1a72fcca58-7244a59f534mr15160202b3a.17.1731600313250; 
 Thu, 14 Nov 2024 08:05:13 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bab70sm1417926b3a.152.2024.11.14.08.05.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:05:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 45/54] target/rx: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:21 -0800
Message-ID: <20241114160131.48616-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/rx/cpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 65a74ce720..c83a582141 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -161,16 +161,19 @@ static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
     info->print_insn = print_insn_rx;
 }
 
-static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
-                            MMUAccessType access_type, int mmu_idx,
-                            bool probe, uintptr_t retaddr)
+static bool rx_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                                  vaddr addr, MMUAccessType access_type,
+                                  int mmu_idx, MemOp memop, int size,
+                                  bool probe, uintptr_t retaddr)
 {
-    uint32_t address, physical, prot;
+    /* TODO: alignment faults not currently handled. */
 
     /* Linear mapping */
-    address = physical = addr & TARGET_PAGE_MASK;
-    prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
+    memset(out, 0, sizeof(*out));
+    out->phys_addr = addr;
+    out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    out->lg_page_size = TARGET_PAGE_BITS;
+    out->attrs = MEMTXATTRS_UNSPECIFIED;
     return true;
 }
 
@@ -195,7 +198,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .initialize = rx_translate_init,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
-    .tlb_fill = rx_cpu_tlb_fill,
+    .tlb_fill_align = rx_cpu_tlb_fill_align,
 
 #ifndef CONFIG_USER_ONLY
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
-- 
2.43.0



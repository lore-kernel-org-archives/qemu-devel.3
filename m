Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDF3D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJI-0005yJ-RT; Thu, 14 Nov 2024 11:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIR-00055R-Ef
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:16 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-0002Is-Ac
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:13 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ee020ec76dso610587a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600125; x=1732204925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SAnTQwSzdXGj8FtiG366nzj4chRAQvpTBuCvSfGJDoU=;
 b=f2cqVK+DI9DALgZuOtT/cFVU4OxXZ0XIe0VoWGVw+clCRil6WifIuy6mJXoWELClLw
 oRAXH30gtoxx3moWoiwlmL4MkZHVd/bWeKbGkcbC8Da1VAbmxc6udw5W2r1cdY4usINA
 dYepNbMiGYsFEDgm4SBQDD0TutyhPFsnwkPn+EPSNAvdkQ/KtTstTTEUQ2CEbiquIdLq
 QmpkLHj1qUoqDlu8Y3apntpIfSIppUk0D//c1OXIEd9IQukcx9E/2P7TibBS7z6WmwVg
 rBg6Xxu0Wm7PrExKmncgWDHV18FggRAjPgqwocSnac+vTblVV647fmsy4rhDPuGt5xna
 Rx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600125; x=1732204925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAnTQwSzdXGj8FtiG366nzj4chRAQvpTBuCvSfGJDoU=;
 b=q/ytjOIvuHz9Cd9nGg7A6YGcvpJcC23VEVeLUMGRmYR1cxsaLLY27TXNPsfNG70+E8
 sLshzWsEJ0n68Tq/NdFw/ZignkVYGawzgnoQ38alfp78I42ricOYdzGhM7ZbBZGudKWJ
 yawdJwvxK0pZQUwnbUYSzvNtLri8p8tXRAGM2VGTKkAL9agEnKWHhwqzI7M/TgAbHE5U
 coqNILimxKkbp0EDXF1xgD5VzGEl1DYaMj4QHeYfnQkalWrvsGIUOImwKORDm7JWS9ao
 jLJOeMQrkwPxXNCTY+B5Ej/KI/xnCc1gQY6p3R6QYP/sGIWU1ogBX0TeKp3RlTUuxX8R
 //Wg==
X-Gm-Message-State: AOJu0YzmvcFZkqoDoa/UWlkTB85GMzCPkBECNjT4Jpki9QIg28z+V5cB
 lJxZKSpDKEI9H+kjZCBjrGwMiojXmfl0soZWNZRXX1nA+oUargOA6oHYvxgtsMdCzFVq7LQV6qV
 2
X-Google-Smtp-Source: AGHT+IEF5h1yU/MTIq/579zafoCKA9obeHgknNJhdyCc70CyiIPZtnW4cbtX0pAochofmI5hUNHq7w==
X-Received: by 2002:a17:90b:3ec5:b0:2e2:8472:c350 with SMTP id
 98e67ed59e1d1-2e9b173dd4cmr34193452a91.17.1731600125199; 
 Thu, 14 Nov 2024 08:02:05 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.02.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:02:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 37/54] target/loongarch: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:13 -0800
Message-ID: <20241114160131.48616-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
 target/loongarch/internals.h      |  7 ++++---
 target/loongarch/cpu.c            |  2 +-
 target/loongarch/tcg/tlb_helper.c | 17 +++++++++++------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 1a02427627..a9f73f27b2 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -60,9 +60,10 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
 #ifdef CONFIG_TCG
-bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                            MMUAccessType access_type, int mmu_idx,
-                            bool probe, uintptr_t retaddr);
+bool loongarch_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                                  vaddr addr, MMUAccessType access_type,
+                                  int mmu_idx, MemOp memop, int size,
+                                  bool probe, uintptr_t ra);
 #endif
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 57cc4f314b..47d69f1788 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -798,7 +798,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .restore_state_to_opc = loongarch_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill = loongarch_cpu_tlb_fill,
+    .tlb_fill_align = loongarch_cpu_tlb_fill_align,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
     .cpu_exec_halt = loongarch_cpu_has_work,
     .do_interrupt = loongarch_cpu_do_interrupt,
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 97f38fc391..94d5df08a4 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -474,9 +474,10 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
     tlb_flush(env_cpu(env));
 }
 
-bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                            MMUAccessType access_type, int mmu_idx,
-                            bool probe, uintptr_t retaddr)
+bool loongarch_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out,
+                                  vaddr address, MMUAccessType access_type,
+                                  int mmu_idx, MemOp memop, int size,
+                                  bool probe, uintptr_t retaddr)
 {
     CPULoongArchState *env = cpu_env(cs);
     hwaddr physical;
@@ -488,12 +489,16 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                                access_type, mmu_idx);
 
     if (ret == TLBRET_MATCH) {
-        tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot,
-                     mmu_idx, TARGET_PAGE_SIZE);
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
                       " prot %d\n", __func__, address, physical, prot);
+
+        memset(out, 0, sizeof(*out));
+        out->phys_addr = physical;
+        out->prot = prot;
+        out->attrs = MEMTXATTRS_UNSPECIFIED;
+        out->lg_page_size = TARGET_PAGE_BITS;
+
         return true;
     } else {
         qemu_log_mask(CPU_LOG_MMU,
-- 
2.43.0



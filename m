Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D88CF2594
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06py-0007Fj-JL; Sun, 13 Oct 2024 18:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pc-0007BM-UH
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:57 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pb-0000wH-4X
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:56 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2e88cb0bbso1768458a91.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857574; x=1729462374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyIQGMW9LXzuIdZhtsfgRRXnueKIctdP5fxMu5c0xxA=;
 b=Ha8hBcWJZBqC0dqeRMt42qSIFViRbZwvlZJqcgb78f94Zwc5mRtwnEp12MP5RJTuH8
 en2rp4MJQju5XVVGKAqPeAOV5OOyE4T4mP4wssthd3vyOlsaHtkHS0DBjGQ8cJvKb+z1
 zrg8KRPmbysjfd/bCKDJaSZualYeNsCUxclkqExeREXFDlVGtQsjXm5UYXw1KixWX3d2
 bvVOKq2ulGWx8hGtwJCkg9vV8xCpx7QEg7het7ECbIlIzQcdVAzJz//J0QD95Eh+/qbr
 bKI60w1if33ImZyOBd1aGTeD0g3ZZJm9Ep8aP3cXIFA5o7HhCZEZsIW1Ms7Vus2ue22b
 SjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857574; x=1729462374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyIQGMW9LXzuIdZhtsfgRRXnueKIctdP5fxMu5c0xxA=;
 b=iFWKOSskvaDAsCkzVm3yo+b/TpoaRQ9a0BEq4/mpNN50RUJc3Pn7AEgMLUHa2MnrQs
 D7GojFfexhjeOjeCj+RXTGmZpUCWcHSOL7Rkd1S+4bHtC53bBU6fk2oVpm/h4Ar6tOFC
 N8hmKgwYyuESxEqxUjsnux4+FETz/4nRE6fP4tqWQib2+Wg/7q4j1YD3srY5Pp75Rr5z
 bNJKeyALjsI4N1bMfhLVqlHPXB7VZxG7ypx9LxPR3pDfqtelGAWblb3vOjdBVoeYWtdY
 66TUpF9Y/xIGKpFHglv5Ut/yhWCELZWa5a6kPv/UTtA93XRLaXzpVoR/aTMO9V/Q1BCj
 l40A==
X-Gm-Message-State: AOJu0YwLrcm2JJP00urSPLwNiW3Z605SrEQh+jIEU3ycRnvT44coQH3k
 ZGT5qwoj05E3rflII6O4DiQuHlUAf0Qdt6BQ0/i2zu3s2hV7BNHRA/ITbDGjm1QyydESFIrI62L
 D
X-Google-Smtp-Source: AGHT+IGw5ei1TeTL1x5T8u6u4Ks7+rpPGkZB8Rw6zCGDuF6yYpXwTHw5uTtODfZt5x35gLBHvoxAeA==
X-Received: by 2002:a17:90a:be08:b0:2e2:991c:d796 with SMTP id
 98e67ed59e1d1-2e2f0aa561bmr12164691a91.9.1728857573821; 
 Sun, 13 Oct 2024 15:12:53 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 18/27] target/hppa: Implement TCGCPUOps.tlb_fill_align
Date: Sun, 13 Oct 2024 15:12:26 -0700
Message-ID: <20241013221235.1585193-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Convert hppa_cpu_tlb_fill to hppa_cpu_tlb_fill_align so that we
can recognize alignment exceptions in the correct priority order.

Resolves: https://bugzilla.kernel.org/show_bug.cgi?id=219339
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  6 +++---
 target/hppa/cpu.c        |  2 +-
 target/hppa/mem_helper.c | 21 ++++++++++++---------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 526855f982..e45ba50a59 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -363,9 +363,9 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 void hppa_ptlbe(CPUHPPAState *env);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 void hppa_set_ior_and_isr(CPUHPPAState *env, vaddr addr, bool mmu_disabled);
-bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool probe, uintptr_t retaddr);
+bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+                             MMUAccessType access_type, int mmu_idx,
+                             MemOp memop, int size, bool probe, uintptr_t ra);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 7cf2e2f266..c38439c180 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -226,7 +226,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
-    .tlb_fill = hppa_cpu_tlb_fill,
+    .tlb_fill_align = hppa_cpu_tlb_fill_align,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
     .cpu_exec_halt = hppa_cpu_has_work,
     .do_interrupt = hppa_cpu_do_interrupt,
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index d38054da8a..b8c3e55170 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -424,12 +424,11 @@ void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
     }
 }
 
-bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
-                       MMUAccessType type, int mmu_idx,
-                       bool probe, uintptr_t retaddr)
+bool hppa_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+                             MMUAccessType type, int mmu_idx,
+                             MemOp memop, int size, bool probe, uintptr_t ra)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
+    CPUHPPAState *env = cpu_env(cs);
     int prot, excp, a_prot;
     hwaddr phys;
 
@@ -445,7 +444,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         break;
     }
 
-    excp = hppa_get_physical_address(env, addr, mmu_idx, a_prot, 0,
+    excp = hppa_get_physical_address(env, addr, mmu_idx, a_prot, memop,
                                      &phys, &prot);
     if (unlikely(excp >= 0)) {
         if (probe) {
@@ -454,7 +453,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         trace_hppa_tlb_fill_excp(env, addr, size, type, mmu_idx);
 
         /* Failure.  Raise the indicated exception.  */
-        raise_exception_with_ior(env, excp, retaddr, addr,
+        raise_exception_with_ior(env, excp, ra, addr,
                                  MMU_IDX_MMU_DISABLED(mmu_idx));
     }
 
@@ -468,8 +467,12 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
      * the large page protection mask.  We do not require this,
      * because we record the large page here in the hppa tlb.
      */
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



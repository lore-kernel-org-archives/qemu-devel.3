Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BC0D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJ8-0005mB-UJ; Thu, 14 Nov 2024 11:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIO-00053P-O5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:13 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-0002Ic-AU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:12 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e9b55b83d2so651264a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600124; x=1732204924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QF7xEZ+McMkBHbikVqFxssmRyGZDCQmLdpfkAwqKmS0=;
 b=akE++NJmTcdv3IZB59T9YFINNNU5WjK+2XnnuVSRAg2E5qf0OsmBuaAhQHC4HuhzeB
 vbciDnrkhNJPQUzpXWL3osYaMm572kJE1Iadkx0K5DOmFnYaP6LFXtefx5v7mdqZRbkI
 wC0qEDzlFXRNou30JDcPOCB+AN+w0Nsf+rbmS+zEshbLKueCKR/HH5BYW5phfzHEykC7
 tnyFvOgePg3S+KzvK50fyjHSjrvohxIRjihTkamtFcBTwXaTyn7jGhjm0qhuCRG8fVQQ
 Bkm83tL4ezwYYv9S+VFEQnWKZ3UomAclmR79pRmGmSV/DK9Cjyj68Oh4fptltITof029
 IwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600124; x=1732204924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QF7xEZ+McMkBHbikVqFxssmRyGZDCQmLdpfkAwqKmS0=;
 b=PiBDb+ulxvJYSFqliUCOdG7Ms9UdoocKnZF7ZuDN0aqz7fUbux191E1DfydmYVIkgo
 WrmG8XJrqmpD7yDBhE7dDhtwBcwXm3GTQCVkQhK1iENMdCtnw3lARRIdmH3NFjDWO4hA
 LJgOd6jJfcEb6vk4f/tEWe0yu/3pjoGrQhpsJ7rX96/C0oIBR4Yz9Lqy9sTaUdyMaqLb
 BFPhU+0U6+qYQ9RiEj5cNUQAHeDlX87csYb0TPPxeCTBjR7/OXBRVmdLNRiqQcsgcBn6
 sjgg41kHvF6vRAQqA6Oe5FcrqHDcr9+yqd6rKsdYKGFN02PR2ZCJvqqAkdhS2leBT2B9
 CByQ==
X-Gm-Message-State: AOJu0YzLA0gGlGpvkbWC2ylU8tSFCa8bdRRQnYV2CuTgPg4vaUKz6y4z
 4Q3C7kus7aD67+vHoGz3HJQ0qRUDKpmNgZ3MPv+ltsUxdG72hcyv1i8RD/GVAKbyL251gsvLHiM
 t
X-Google-Smtp-Source: AGHT+IH0C7SLi7d1YnIk4aDAQmiGhzzuP6i5coFmCgfbh1Y/MtJ+bvLwoXl0pz1rmNshi3q9u326SQ==
X-Received: by 2002:a17:90b:5444:b0:2e2:e597:6cdc with SMTP id
 98e67ed59e1d1-2e9f2c906c0mr7877746a91.22.1731600123715; 
 Thu, 14 Nov 2024 08:02:03 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.02.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:02:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 36/54] target/i386: Convert to TCGCPUOps.tlb_fill_align
Date: Thu, 14 Nov 2024 08:01:12 -0800
Message-ID: <20241114160131.48616-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 target/i386/tcg/helper-tcg.h         |  6 +++---
 target/i386/tcg/sysemu/excp_helper.c | 28 ++++++++++++++++------------
 target/i386/tcg/tcg-cpu.c            |  2 +-
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 696d6ef016..b2164f41e6 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -79,9 +79,9 @@ void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
 void x86_cpu_record_sigbus(CPUState *cs, vaddr addr,
                            MMUAccessType access_type, uintptr_t ra);
 #else
-bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr);
+bool x86_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr addr,
+                            MMUAccessType access_type, int mmu_idx,
+                            MemOp memop, int size, bool probe, uintptr_t ra);
 G_NORETURN void x86_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                             MMUAccessType access_type,
                                             int mmu_idx, uintptr_t retaddr);
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 168ff8e5f3..d23d28fef5 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -601,25 +601,29 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
     return true;
 }
 
-bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr)
+bool x86_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *full, vaddr addr,
+                            MMUAccessType access_type, int mmu_idx,
+                            MemOp memop, int size, bool probe,
+                            uintptr_t retaddr)
 {
     CPUX86State *env = cpu_env(cs);
     TranslateResult out;
     TranslateFault err;
 
+    if (addr & ((1 << memop_alignment_bits(memop)) - 1)) {
+        if (probe) {
+            return false;
+        }
+        x86_cpu_do_unaligned_access(cs, addr, access_type, mmu_idx, retaddr);
+    }
+
     if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err,
                              retaddr)) {
-        /*
-         * Even if 4MB pages, we map only one 4KB page in the cache to
-         * avoid filling it too fast.
-         */
-        assert(out.prot & (1 << access_type));
-        tlb_set_page_with_attrs(cs, addr & TARGET_PAGE_MASK,
-                                out.paddr & TARGET_PAGE_MASK,
-                                cpu_get_mem_attrs(env),
-                                out.prot, mmu_idx, out.page_size);
+        memset(full, 0, sizeof(*full));
+        full->phys_addr = out.paddr;
+        full->prot = out.prot;
+        full->lg_page_size = ctz32(out.page_size);
+        full->attrs = cpu_get_mem_attrs(env);
         return true;
     }
 
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index cca19cd40e..6fce6227c7 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -117,7 +117,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .record_sigsegv = x86_cpu_record_sigsegv,
     .record_sigbus = x86_cpu_record_sigbus,
 #else
-    .tlb_fill = x86_cpu_tlb_fill,
+    .tlb_fill_align = x86_cpu_tlb_fill_align,
     .do_interrupt = x86_cpu_do_interrupt,
     .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
-- 
2.43.0



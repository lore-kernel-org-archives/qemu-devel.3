Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05701C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 14:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIq3E-00042q-KC; Sat, 24 May 2025 10:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIq3C-00042O-87
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:40:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIq3A-0007t3-5g
 for qemu-devel@nongnu.org; Sat, 24 May 2025 10:40:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-443a787bd14so12825555e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748097634; x=1748702434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kjmi0hZCzV/Fx+nP0mjfHBg3/IPtSl05rTWpGvdIScc=;
 b=VHUJ99jL5p9gGtpJMLc5Q7Pj8wQ56QJTbOzifdw/H3I9t0fefbc3Vz0Zvpg71XJet+
 Kv0tvO+Dun03/IJds8UN1uv/9UgWk6MJ3hcxVKHlVAmlAAsOgmow+T5nyCuL/yaTLk3z
 SLSefddKTVVgw0n7mede1dHe28++ahUdXep0Ruc+YmEtPQ/HX1h7Ej9a5Fko8OhtpmCq
 nhAtsa3FV95mDatuzT0lJrLbWctM+LY3sihRfaUuoVxlNKU28Fn+Be44F3jWYhuSLGDV
 iRAj11dCE3+Laf2P/ZQHwNi7QyFLxcxZQ9kD8BgUatuB4pvdw2FaSGKUgAbxvxR1u6fx
 49Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748097634; x=1748702434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kjmi0hZCzV/Fx+nP0mjfHBg3/IPtSl05rTWpGvdIScc=;
 b=ShTOFEpYviKOKegz2UkQZMVSI0sLmtp7/nwLO+jU0XlN3f2sNT1DttJ0JoTTUl/Dhx
 JWn+W33WX+79Nlv057KLJSejGEUuyReYMD6/sQILVRUGpTGG3E419x05FyDuIF+CteLt
 7OS+PS81vekQvD/g3nBPyt/k3IXmpg5TTzS950Q32xVrWp95Pq4w2hc59Kf7mh9d3JuD
 IiLL5Ot5330M0TK9Al3EYSGM4mKH9HLHivCQKgWTk7cnywdhQaILaZBddrNmzje5t45F
 170YxBgnYsGZuJMKDvL3uuRire0Ror43fmskdOlEzTvGsJOPiiaKg6N2FDPoXpc5GMkG
 wnjA==
X-Gm-Message-State: AOJu0YyAcXs1+pWe0uEMA2L67BDvdbratouUpAiuv7F9StNt8guJnhxN
 PquOFypixbe72oRX8l3Vd+ifqOSIvm22+2TpJx7g79ZeX4NHd5+0mGpC5kDng55Ekj+KO8F5+EG
 MBAXrIUleRQ==
X-Gm-Gg: ASbGncuZfzscKousJcNxTBRIXc6wudEcuvQ0L62wjPEpurT4+/0Q3z9ASo0BImskM8q
 l2Wm8QSkTb3IlcStUsvNCEB02BzDKz8/w6TXk7Iz4UuO89DbJ0C+Q+YV2zqiMTooYZJL3FDnL38
 SVdYPPmCCdUdj91kltec7LLM/9b6eBmjGaxVbnkWO8BOYGDjm+PNxlgeX3ihc4xzUAo6BaPhKFq
 Lh3hXJS/fFL130ZTJcpX1uyNMh49HoqN+8C8l8JaQ1jifbgEkISQU0A0W4S7a+XRaZ6mLU96s3/
 Cb1If++brb2VEGqLeK2Xv2INyO2/5AneNd2u04DFlXP0BwQU9TANT60a
X-Google-Smtp-Source: AGHT+IHIskrE17tecLd4CbdGzvqZkzSTqGEEbg/1Uuwo9slp4GD5WLsGjwuFnDnKm7GC9AJldV3NRg==
X-Received: by 2002:a05:600c:3b12:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-44c7aa383d7mr29666025e9.5.1748097633846; 
 Sat, 24 May 2025 07:40:33 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7bae3b9sm176246915e9.33.2025.05.24.07.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 07:40:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
Date: Sat, 24 May 2025 15:40:31 +0100
Message-ID: <20250524144031.49810-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

When we moved TLB_MMIO and TLB_DISCARD_WRITE to TLB_SLOW_FLAGS_MASK,
we failed to update atomic_mmu_lookup to properly reconstruct flags.

Fixes: 24b5e0fdb543 ("include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to slow flags")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5f6d7c601c..86d0deb08c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1871,8 +1871,12 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         goto stop_the_world;
     }
 
-    /* Collect tlb flags for read. */
+    /* Finish collecting tlb flags for both read and write. */
+    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     tlb_addr |= tlbe->addr_read;
+    tlb_addr &= TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
+    tlb_addr |= full->slow_flags[MMU_DATA_STORE];
+    tlb_addr |= full->slow_flags[MMU_DATA_LOAD];
 
     /* Notice an IO access or a needs-MMU-lookup access */
     if (unlikely(tlb_addr & (TLB_MMIO | TLB_DISCARD_WRITE))) {
@@ -1882,13 +1886,12 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     }
 
     hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
 
     if (unlikely(tlb_addr & TLB_NOTDIRTY)) {
         notdirty_write(cpu, addr, size, full, retaddr);
     }
 
-    if (unlikely(tlb_addr & TLB_FORCE_SLOW)) {
+    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
         int wp_flags = 0;
 
         if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
@@ -1897,10 +1900,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         if (full->slow_flags[MMU_DATA_LOAD] & TLB_WATCHPOINT) {
             wp_flags |= BP_MEM_READ;
         }
-        if (wp_flags) {
-            cpu_check_watchpoint(cpu, addr, size,
-                                 full->attrs, wp_flags, retaddr);
-        }
+        cpu_check_watchpoint(cpu, addr, size,
+                             full->attrs, wp_flags, retaddr);
     }
 
     return hostaddr;
-- 
2.43.0



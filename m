Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFB3C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEo-0001V4-Ne; Tue, 05 Mar 2024 08:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVE0-0000xP-CM
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:06 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDr-0005yL-RA
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:56 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e17fc5aceso2809921f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646766; x=1710251566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vYTT5LKkD29WLg/lq++0uN/w1V7H7bdZ2aB09S5WWmU=;
 b=yyw65yUizfuHOcaRTiTiZvnPMkygeNYm7qBTCVjFnyZwgwFoFguRQLHoTx7qQFUiN/
 ZqZrU7ss7KPD2ofYJHUhurITxsaytLIy/Nzj8qLiEHXOm+uVQRd1gCxdAbMlJoexBc7l
 SBZoGJios7RS6vqMliJPkl1isNU0ukc4OG3xNP2Lx3PnN1Aai+9OSJi6Db47HpilDOYS
 4wI0oMRdvTJMRQ6JcEXUMh5IF6gseAVnNATimV5IinMmX7ug+J9vMRKgToY9U5L+ch1W
 +xpGWUjL8d8R/YbUCbf51435mPLfafbPeTxNNHRnDTsP/FDfz/P9K1A5rfZRpvcYnJ8R
 rg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646766; x=1710251566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYTT5LKkD29WLg/lq++0uN/w1V7H7bdZ2aB09S5WWmU=;
 b=q4qJ8wgUpGgLnqRulAjbXHgKamDUjUikzpQ4E6roLLM2y2li3xdakmdrI3mhYQtDRq
 +PJiFcOg82hpevlH0D1OZGeUq2URnhFwkPjHARr3fxuBGy8uMKo84LKb/KGvs0xnZJUh
 g1YDF4e+cJnyyGjRx2ddrnOB90YkGWc6VYEVZyo7O8BvUfL0EY3KVcKl6WIJny9nyehO
 iDr6yuhFpp6Opk0KYc+pjrV4bvQrPdh598dwAdG2ZiYNTi1CJvya9rUSwGccDo53GYZ5
 fwt22lb7Mm+BmTUKgntxY/FQcYJTv3JP1KCm6RWnYNel85C8IUgyiEMxhI/QPuDFeA+E
 ik/Q==
X-Gm-Message-State: AOJu0Yx0SQswQi1L3w/VG5EIC9L/TTr77ktONeo34m+uCnmPATwApqRb
 TlsuRme90ytGMg3Z1ViKAfVv2mbimKJH/C9dKhr+it43sux8mb3KdSy4l506kOVBgoBlb41Mqsr
 u
X-Google-Smtp-Source: AGHT+IH4JHeW54sIWhAbnjMSkVOGpZxbpjvvp7KrrvGgqWWP3pf2VIe0a/s0xwyBJsxvEQwfIGa82A==
X-Received: by 2002:adf:c793:0:b0:33e:1651:2a04 with SMTP id
 l19-20020adfc793000000b0033e16512a04mr2689928wrg.8.1709646766497; 
 Tue, 05 Mar 2024 05:52:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] accel/tcg: Add tlb_fill_flags to CPUTLBEntryFull
Date: Tue,  5 Mar 2024 13:52:32 +0000
Message-Id: <20240305135237.3111642-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Allow the target to set tlb flags to apply to all of the
comparators.  Remove MemTxAttrs.byte_swap, as the bit is
not relevant to memory transactions, only the page mapping.
Adjust target/sparc to set TLB_BSWAP directly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301204110.656742-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memattrs.h   | 2 --
 include/hw/core/cpu.h     | 3 +++
 accel/tcg/cputlb.c        | 5 +----
 target/sparc/mmu_helper.c | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index afa885f9830..14cdd8d5824 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -52,8 +52,6 @@ typedef struct MemTxAttrs {
     unsigned int memory:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
-    /* Invert endianness for this page */
-    unsigned int byte_swap:1;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d0e345419fc..ec14f74ce5d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -230,6 +230,9 @@ typedef struct CPUTLBEntryFull {
     /* @lg_page_size contains the log2 of the page size. */
     uint8_t lg_page_size;
 
+    /* Additional tlb flags requested by tlb_fill. */
+    uint8_t tlb_fill_flags;
+
     /*
      * Additional tlb flags for use by the slow path. If non-zero,
      * the corresponding CPUTLBEntry comparator must have TLB_FORCE_SLOW.
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6243bcb1791..ac986cb8ea5 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1145,14 +1145,11 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
               " prot=%x idx=%d\n",
               addr, full->phys_addr, prot, mmu_idx);
 
-    read_flags = 0;
+    read_flags = full->tlb_fill_flags;
     if (full->lg_page_size < TARGET_PAGE_BITS) {
         /* Repeat the MMU check and TLB fill on every access.  */
         read_flags |= TLB_INVALID_MASK;
     }
-    if (full->attrs.byte_swap) {
-        read_flags |= TLB_BSWAP;
-    }
 
     is_ram = memory_region_is_ram(section->mr);
     is_romd = memory_region_is_romd(section->mr);
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 5170a668bb4..e7b1997d54e 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -580,7 +580,7 @@ static int get_physical_address_data(CPUSPARCState *env, CPUTLBEntryFull *full,
             int do_fault = 0;
 
             if (TTE_IS_IE(env->dtlb[i].tte)) {
-                full->attrs.byte_swap = true;
+                full->tlb_fill_flags |= TLB_BSWAP;
             }
 
             /* access ok? */
-- 
2.34.1



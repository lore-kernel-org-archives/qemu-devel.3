Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F06C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5W-0008Nm-Vp; Mon, 19 Feb 2024 03:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5S-0007kx-3w; Mon, 19 Feb 2024 03:33:18 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz5P-0002jh-Fm; Mon, 19 Feb 2024 03:33:17 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso19291315ad.2; 
 Mon, 19 Feb 2024 00:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331593; x=1708936393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZdatq3vYOtwDhs+2bqO9//78PD1EpkdiB+KCSZTTMM=;
 b=C1I277/LSx5amaU4Doms7HQQDuXqCk6bIzMfjyjnENuDpH9idIlnVJECSgt3hG/Iyi
 nOB7vd/j/NXHjHkEa39H6XXdl4cGbrKAF/xswr2BuLxMXcgIIvZYC0lcX5e2nIpvpzpr
 5KMHZERO1SAZJx+28eSyQAzr4dsa9iAuP/CfORwDsMbOzronN2lEJs+V8oDyEmX6nbbH
 fYlF0unBANzy+H8815nphUxVSoFJDpX2mlFDfmjx4M6qydzAIigLv391emwlEPl3jdVm
 t2eG/SMqIKUg3BwUW9+5RDiWMk3Br7i695f3eZF4b55Kkm7m+YPgbrf40yzpKqqg5ozp
 Oq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331593; x=1708936393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZdatq3vYOtwDhs+2bqO9//78PD1EpkdiB+KCSZTTMM=;
 b=BrRKqKshL86wkZ0h8jsHUgT2GZMOnjtLZ7YqRkHYF+0KZi5eGuwQuuEXtzqghpkVmQ
 MvRUSJmt30gQMurL5ZBElG1mLBKvBL8ibqjRHUqAWQPD2sLV1qZ93RAk3hZ3w6X75vly
 YuOjz8R9wdORpTlVhakKvdDUFkdM+hzWGDSAktbYcxSWB21/iIcIcR4WS4fjpOxN0bM4
 9LE+ZQ+Xsej+Clf2dADVHsgk34vBpPPel2l3eqT/AKpT7D3j67xtZLVYsHbKNYhihBn1
 /LHSdr0QXtiFEHRg7dbFz/z7V+yOm1fUMaSbbczs+OFBJDJit5G3XsZnSgEi1cShW5wG
 B2vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUet8bRk8KIOFCkXBg1zr9TmHps4qt7WAcD97xfS6sA+2Vw51bc+xYRsCLSl8EbS09+3iAKcRWCWSNQyQL3XxBzDafo
X-Gm-Message-State: AOJu0YwcRdYFiti6HcT2Rgs93onV2AFqst0g4KRShmJi/gdD/0pZ5MQd
 E2AeAdStv+H7e6cboEh94cQPhDQaIeTOE6LPXvbo3xCzW2gd2Xy3dg8Z8RIX
X-Google-Smtp-Source: AGHT+IFnehip4HhP4vfwIG+tKXbhA8V+sZ7bofHry4a7c1HJR04hCLO27Ib9+09DSdbObXtFU6olIA==
X-Received: by 2002:a17:902:ce01:b0:1db:8eb2:9a11 with SMTP id
 k1-20020a170902ce0100b001db8eb29a11mr12908334plg.53.1708331592371; 
 Mon, 19 Feb 2024 00:33:12 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:33:12 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 44/49] target/ppc: Fix 440 tlbwe TLB invalidation gaps
Date: Mon, 19 Feb 2024 18:29:33 +1000
Message-ID: <20240219082938.238302-45-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The 440 tlbwe (write entry) instruction misses several cases that must
flush the TCG TLB:

- If the new size is smaller than the existing size, the EA no longer
  covered should be flushed. This looks like an inverted inequality
  test.
- If the TLB PID changes.
- If the TLB attr bit 0 (translation address space) changes.
- If low prot (access control) bits change.

Fix this by removing tricks to avoid TLB flushes, and just invalidate
the TLB if any valid entry is being changed, similarly to 4xx.
Optimisations will be introduced in subsequent changes.

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index f87d35379a..c140f3c96d 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -855,49 +855,34 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
                       target_ulong value)
 {
     ppcemb_tlb_t *tlb;
-    target_ulong EPN, RPN, size;
-    int do_flush_tlbs;
 
     qemu_log_mask(CPU_LOG_MMU, "%s word %d entry %d value " TARGET_FMT_lx "\n",
                   __func__, word, (int)entry, value);
-    do_flush_tlbs = 0;
     entry &= 0x3F;
     tlb = &env->tlb.tlbe[entry];
+
+    /* Invalidate previous TLB (if it's valid) */
+    if (tlb->prot & PAGE_VALID) {
+        tlb_flush(env_cpu(env));
+    }
+
     switch (word) {
     default:
         /* Just here to please gcc */
     case 0:
-        EPN = value & 0xFFFFFC00;
-        if ((tlb->prot & PAGE_VALID) && EPN != tlb->EPN) {
-            do_flush_tlbs = 1;
-        }
-        tlb->EPN = EPN;
-        size = booke_tlb_to_page_size((value >> 4) & 0xF);
-        if ((tlb->prot & PAGE_VALID) && tlb->size < size) {
-            do_flush_tlbs = 1;
-        }
-        tlb->size = size;
+        tlb->EPN = value & 0xFFFFFC00;
+        tlb->size = booke_tlb_to_page_size((value >> 4) & 0xF);
         tlb->attr &= ~0x1;
         tlb->attr |= (value >> 8) & 1;
         if (value & 0x200) {
             tlb->prot |= PAGE_VALID;
         } else {
-            if (tlb->prot & PAGE_VALID) {
-                tlb->prot &= ~PAGE_VALID;
-                do_flush_tlbs = 1;
-            }
+            tlb->prot &= ~PAGE_VALID;
         }
         tlb->PID = env->spr[SPR_440_MMUCR] & 0x000000FF;
-        if (do_flush_tlbs) {
-            tlb_flush(env_cpu(env));
-        }
         break;
     case 1:
-        RPN = value & 0xFFFFFC0F;
-        if ((tlb->prot & PAGE_VALID) && tlb->RPN != RPN) {
-            tlb_flush(env_cpu(env));
-        }
-        tlb->RPN = RPN;
+        tlb->RPN = value & 0xFFFFFC0F;
         break;
     case 2:
         tlb->attr = (tlb->attr & 0x1) | (value & 0x0000FF00);
-- 
2.42.0



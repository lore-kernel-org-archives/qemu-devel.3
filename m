Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208F0D68B35
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcI4-0004zJ-5H; Thu, 14 Nov 2024 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI0-0004xk-Nr
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:49 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHu-0002Cq-3h
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:43 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so712292a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600101; x=1732204901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hz/db0U//GrGJtv1TKp+9GNtVl8RODviEX3vH3DtlZo=;
 b=NLYWol+PQJdmkmF5vaOCTGF7mRWl+RO+T2Dab1p0wSSkr1fp67aHstLPHcIx7v69xH
 0lOaShaXZlkuDs3h1nZETORfxvCAhqUAJgbb2a+4V2PMVjNCCZSTltys1+LB022Pr+mo
 YNQy3Q8h1BWEHQvtlb901uvrLX53DichaK4BaMqfetxA4Ppd8JXHJLQeePn8FAF8bTNz
 sdlsn71KrA+TAmMSoQWpKZ7B1F9TC2K4SSUy0LM997DR+XmJjuKvpJZ526ckGltBK2w7
 Okg0S37BhQX0OK0j3bnK67JsgX/jd8bynazgK2j9IqNrNqS4V7FRpkwK1obmDwE6urTS
 hqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600101; x=1732204901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hz/db0U//GrGJtv1TKp+9GNtVl8RODviEX3vH3DtlZo=;
 b=Ga4/0EamY5VPjlxJ6CSNPYzW+umBLYpYrZbEZULKRYPNA4SwYxxu9YrxtiiYvqDn6x
 kNvbLhqMGIGQrYl7mlqTwdX2YnXEuGIwjCR48ws39vtZoYecGGG9DQ8XleT6laTGC+y7
 E0KTbriLskLTaTAsTfBrKFQiv7pEe8dAFCT3aLV2Z2zE+ak0JIaGi1hUQAZFurxA6BN1
 CWle/pJ9dS+iw12jOoCWs2GiqMk3ytjqSyzR+f0hIt26pRSTBjD44uBmM+Ck0WJ/lOsI
 rbWETlnY+otOT/o6TJkt9YKOQG0bEGCPKa/nLN+Ynp62K4nIP7FGg73N4uTd/hvVwjnc
 HhSA==
X-Gm-Message-State: AOJu0YyUJ9X91t/7vSFTHuonTj5ZLuyvKwaHNY1PfwwCorDi7wAYAS46
 gEDXqAVVboj2jbaLlBX3+82Z2CY4gDu27hE6REHesc307CA8aACOlhQ7w0GRJLZz6KD80Tn5TmX
 l
X-Google-Smtp-Source: AGHT+IHcXVH3KaUHtQLFLDkMwOtcHGIrmarOlz54PW7Z4JpmceQuSWMN25JiJlrSZXxhUbG4TyrWBQ==
X-Received: by 2002:a17:90b:4c03:b0:2c8:65cf:e820 with SMTP id
 98e67ed59e1d1-2ea06346505mr2754826a91.2.1731600100692; 
 Thu, 14 Nov 2024 08:01:40 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/54] accel/tcg: Remove IntervalTree entry in
 tlb_flush_page_locked
Date: Thu, 14 Nov 2024 08:00:47 -0800
Message-ID: <20241114160131.48616-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Flush a page from the IntervalTree cache.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ea6a5177de..d532d69083 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -568,6 +568,7 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
     CPUTLBDesc *desc = &cpu->neg.tlb.d[midx];
     vaddr lp_addr = desc->large_page_addr;
     vaddr lp_mask = desc->large_page_mask;
+    CPUTLBEntryTree *node;
 
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
@@ -575,10 +576,17 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
                   VADDR_PRIx "/%016" VADDR_PRIx ")\n",
                   midx, lp_addr, lp_mask);
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
-    } else {
-        tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
-                                   page, TARGET_PAGE_SIZE, -1);
-        tlb_flush_vtlb_page_locked(cpu, midx, page);
+        return;
+    }
+
+    tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
+                               page, TARGET_PAGE_SIZE, -1);
+    tlb_flush_vtlb_page_locked(cpu, midx, page);
+
+    node = tlbtree_lookup_addr(desc, page);
+    if (node) {
+        interval_tree_remove(&node->itree, &desc->iroot);
+        g_free(node);
     }
 }
 
-- 
2.43.0



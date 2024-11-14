Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48D7D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIf-0005GS-Kb; Thu, 14 Nov 2024 11:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI5-0004zw-2m
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:56 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI0-0002DZ-TS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:51 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-72467c35ddeso751977b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600103; x=1732204903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E4pmRCXWy/4R+SRD3ehMnfQVgg8YaLPMO4JGcA4dSk8=;
 b=YU3qMoSb8fhIO3z6Bi1giY3GVMyh1JkLCYDKBz+q7RKVqMUph72B4i9dKVieXWCG3T
 X+h0p8QEFDPufOSNQLftQsKLVJUp2sP1Bk0xlQy+qMGy0ZZCrAJ7/YTNA+UmkgPllAMP
 iRMmZFb3PpgCEBw2IMizmVWEEoUbf3zbDuzpiK7Hy48v9RzfIWQCr0XAr9UYd2T+cbR4
 kLgCkWnDMUIsExNDhio15v3PiQiavti8qVYivnf3sZsWcYTs8bqHHb5lqhcPVAiSY6Ru
 91aQbE74zfF+8yVscdG4pOj00Hy3y0NqRdINa12EnmQWjoP+chG73ANwHHaZIQLCuhDV
 pSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600103; x=1732204903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4pmRCXWy/4R+SRD3ehMnfQVgg8YaLPMO4JGcA4dSk8=;
 b=JOZZBgXFmrwuebcdg2ZtO80j5RD/BpZcAvkEUiihD4fJChU96rK7ukDyaB8mbNjw0T
 qxT8FJyfukYFGXB9PQI8nEN/9/zOKjQJZvTQh13eLpGtxW7me6DVuBA5Ovo1iVunarAw
 DFtbXGV6jBWmHoD8AR6mlikgU6MriYwhXp3HnYIKXHGxmNsKmnetSoksLAblgfGWHVtu
 UHD7Gnb9cqXCMDfj0k6Tvb9ActGNB49yblvw2rFWm+0QCjg6W/31ZYJ5j1L4BoOzReMI
 1J/TD0QRywL8VLo/pOhGqHO0XJHA2EjdJHg+BdhFjZpfs5RrmVJUyDoVY+fJVPurlWfL
 0KlQ==
X-Gm-Message-State: AOJu0Yy8cdsVMb0mWohnPiKP+kBRx972qF5yqKbWJx0gv03yWYXCEpe6
 ccB9VQX2Zl8DYjhj7lOpnk9vd87sQErzFKC7OtZ9gXGJXyTp2jf40PzAGMSiOl5h3U1Lmwy0Itx
 +
X-Google-Smtp-Source: AGHT+IF7pTcW6gix9jbZ5CedeOcwDTDFruBmXkucISr2+sP4bwHmeWtl2vtFqCqf4Lx5c+cZETU5RQ==
X-Received: by 2002:a17:90b:2801:b0:2e0:8780:ecb with SMTP id
 98e67ed59e1d1-2e9fe649b2amr5717448a91.12.1731600103088; 
 Thu, 14 Nov 2024 08:01:43 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/54] accel/tcg: Process IntervalTree entries in
 tlb_set_dirty
Date: Thu, 14 Nov 2024 08:00:50 -0800
Message-ID: <20241114160131.48616-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Update the addr_write copy within an interval tree node.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0c9f834cbe..eb85e96ee2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1049,13 +1049,18 @@ static void tlb_set_dirty(CPUState *cpu, vaddr addr)
     addr &= TARGET_PAGE_MASK;
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
-    }
+        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
+        CPUTLBEntryTree *node;
 
-    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        int k;
-        for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_set_dirty1_locked(&cpu->neg.tlb.d[mmu_idx].vtable[k], addr);
+        tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
+
+        for (int k = 0; k < CPU_VTLB_SIZE; k++) {
+            tlb_set_dirty1_locked(&desc->vtable[k], addr);
+        }
+
+        node = tlbtree_lookup_addr(desc, addr);
+        if (node) {
+            tlb_set_dirty1_locked(&node->copy, addr);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
-- 
2.43.0



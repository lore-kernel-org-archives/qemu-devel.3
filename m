Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D785D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcHx-0004xA-CD; Thu, 14 Nov 2024 11:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHr-0004ub-Qk
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:41 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHp-0002BG-8s
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:39 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7e6cbf6cd1dso549443a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600095; x=1732204895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqnKReoBjQRrcKu52BeUjvV/aI8mQFMQp+BRc29T3cQ=;
 b=KghsZxvg5cjQ/bwK7bamKa4G8kvhTtArlXw4bi7UU7OWbWMWDNsfEIPwYO5JheIkJL
 JPYTtpo/LSkaIFgp0Y3UTn5U+fFFqquyJBcKOh9gFBJ196lNXGoX5PbAzi+LSMD5byy3
 ZanistM46CNIkIJz6psfJ4pmZaDHOXw1FssDRY/PaEFOi5tUiZ5YE8fiuVIbPYlmaURr
 1twVE+rYyI9OltaqPfthMexlBNdPDdJNQkBJEk2PjXPY7tbnx2eSKOa6s3tgFjrTutQw
 GrONHuyDFGrwho20qHqfRYv0epqYs7tYpAh1wdY7QCl5eeYY13Vx8RuUvJ5LOhD0Bft0
 NEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600095; x=1732204895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MqnKReoBjQRrcKu52BeUjvV/aI8mQFMQp+BRc29T3cQ=;
 b=DqxwvDbzh2vLagOpTApuWr3LwxnSHIT14m7c1lmO67VgBEhzz+kgr6WLm6TS8toZ+y
 BBTnauonTb3IloaBsWBaxX58INFk1juvENfIfdPurfOP+whMt1Lgzxg0+fge067dV+7z
 CkdQHSQz/bxa9gTPF7DE5RprQqKQimMI3aXNKJjj+2MAnFVNzQ6rzn1DpXpomqxiAaOB
 tDuSONZf8qVEJxkSYDxdDjZnWGnaadS8C6Fj2d065tOfABPUwmGWfqd7DcX1I+Ch5l9s
 6mRsNfAF11MjXMYbnVxXQFEt/auS+1Wez33eMlii6ibS6hanwoj20goPdCqopCIkJFrs
 6l0A==
X-Gm-Message-State: AOJu0Yz90LmY4+cVqUeVDLhJpq9gHk3jfRGTSCkZW32rlCctsgukUO9R
 DLnIBJJNOGHZ4WLLysUCkOSNI8EgW5xsVwOZK4/79WKzv3b9TWDkTAiesTRo3K9yxZd5d5x/FdR
 E
X-Google-Smtp-Source: AGHT+IFoQto2KZJ9KfoG6yGpxSDOUHwph0+XFkztELwNnaAm8ESL0lU+tqb8FitL8JoOLXVb4ZFkAw==
X-Received: by 2002:a17:90b:4cc1:b0:2d8:e7db:9996 with SMTP id
 98e67ed59e1d1-2e9e4add8c1mr13447495a91.13.1731600095486; 
 Thu, 14 Nov 2024 08:01:35 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 04/54] accel/tcg: Split out tlbfast_flush_range_locked
Date: Thu, 14 Nov 2024 08:00:40 -0800
Message-ID: <20241114160131.48616-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

While this may at present be overly complicated for use
by single page flushes, do so with the expectation that
this will eventually allow simplification of large pages.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 66 +++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e37af24525..46fa0ae802 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -493,11 +493,6 @@ static bool tlb_flush_entry_mask_locked(CPUTLBEntry *tlb_entry,
     return false;
 }
 
-static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry, vaddr page)
-{
-    return tlb_flush_entry_mask_locked(tlb_entry, page, -1);
-}
-
 /* Called with tlb_c.lock held */
 static void tlb_flush_vtlb_page_mask_locked(CPUState *cpu, int mmu_idx,
                                             vaddr page,
@@ -520,10 +515,37 @@ static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
     tlb_flush_vtlb_page_mask_locked(cpu, mmu_idx, page, -1);
 }
 
+static void tlbfast_flush_range_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast,
+                                       vaddr addr, vaddr len, vaddr mask)
+{
+    /*
+     * If @mask is smaller than the tlb size, there may be multiple entries
+     * within the TLB; for now, just flush the entire TLB.
+     * Otherwise all addresses that match under @mask hit the same TLB entry.
+     *
+     * If @len is larger than the tlb size, then it will take longer to
+     * test all of the entries in the TLB than it will to flush it all.
+     */
+    if (mask < fast->mask || len > fast->mask) {
+        tlbfast_flush_locked(desc, fast);
+        return;
+    }
+
+    for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
+        vaddr page = addr + i;
+        CPUTLBEntry *entry = tlbfast_entry(fast, page);
+
+        if (tlb_flush_entry_mask_locked(entry, page, mask)) {
+            desc->n_used_entries--;
+        }
+    }
+}
+
 static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
 {
-    vaddr lp_addr = cpu->neg.tlb.d[midx].large_page_addr;
-    vaddr lp_mask = cpu->neg.tlb.d[midx].large_page_mask;
+    CPUTLBDesc *desc = &cpu->neg.tlb.d[midx];
+    vaddr lp_addr = desc->large_page_addr;
+    vaddr lp_mask = desc->large_page_mask;
 
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
@@ -532,9 +554,8 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
                   midx, lp_addr, lp_mask);
         tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
     } else {
-        if (tlb_flush_entry_locked(tlb_entry(cpu, midx, page), page)) {
-            tlb_n_used_entries_dec(cpu, midx);
-        }
+        tlbfast_flush_range_locked(desc, &cpu->neg.tlb.f[midx],
+                                   page, TARGET_PAGE_SIZE, -1);
         tlb_flush_vtlb_page_locked(cpu, midx, page);
     }
 }
@@ -689,24 +710,6 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
     CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
     vaddr mask = MAKE_64BIT_MASK(0, bits);
 
-    /*
-     * If @bits is smaller than the tlb size, there may be multiple entries
-     * within the TLB; otherwise all addresses that match under @mask hit
-     * the same TLB entry.
-     * TODO: Perhaps allow bits to be a few bits less than the size.
-     * For now, just flush the entire TLB.
-     *
-     * If @len is larger than the tlb size, then it will take longer to
-     * test all of the entries in the TLB than it will to flush it all.
-     */
-    if (mask < f->mask || len > f->mask) {
-        tlb_debug("forcing full flush midx %d ("
-                  "%016" VADDR_PRIx "/%016" VADDR_PRIx "+%016" VADDR_PRIx ")\n",
-                  midx, addr, mask, len);
-        tlb_flush_one_mmuidx_locked(cpu, midx, get_clock_realtime());
-        return;
-    }
-
     /*
      * Check if we need to flush due to large pages.
      * Because large_page_mask contains all 1's from the msb,
@@ -720,13 +723,10 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
         return;
     }
 
+    tlbfast_flush_range_locked(d, f, addr, len, mask);
+
     for (vaddr i = 0; i < len; i += TARGET_PAGE_SIZE) {
         vaddr page = addr + i;
-        CPUTLBEntry *entry = tlb_entry(cpu, midx, page);
-
-        if (tlb_flush_entry_mask_locked(entry, page, mask)) {
-            tlb_n_used_entries_dec(cpu, midx);
-        }
         tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
     }
 }
-- 
2.43.0



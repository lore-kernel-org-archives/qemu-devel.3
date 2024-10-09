Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE621CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJH-0001LQ-RB; Wed, 09 Oct 2024 11:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJG-0001K8-AJ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:06 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJC-0007wT-Iw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e10ae746aso1878523b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486541; x=1729091341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=24CMkQMrWOo8hDSF+GETpHYU0Rfi9fKfFw2PUYnta2A=;
 b=eVIoe5ckJBAkJ5mvp5U1hZZ51/r0B3EReei2bzEP5PvCZwrC3X+vDXkN+VfaN3Mb+A
 aSduhAfJEnwoTM1rgihVRgKBJ8nyZJ+osiCSZ9M/j69HHD3kqFD2U3OnOHqlytD4d9Xx
 3n46waff8z1QE6aF+5W7dCKiaUq//Lgmni/oOxXb8ZypqU67iE395gMWNqXiLo5gAYoU
 J9VbhKE0DFKA8+BnWojQ3WkNkPWsQfurPYddvBLAX1M5CFHsZNoQjQwCz3rL5U/LD6yB
 A15THJ004xiHwLlnBEORa4TKe0hISOgJKgHvHnqNxaWA8h3VH9XfEtfDEYYJLouWxGs0
 x1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486541; x=1729091341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24CMkQMrWOo8hDSF+GETpHYU0Rfi9fKfFw2PUYnta2A=;
 b=EltBpBd3b+5i+1YjtbPDAg7CScOiHNW8vUi/iuldtp0WzLNQIMoR4ytsebEGrsbnu2
 vev6e2ojST9yY6RYVZdCS3vDwOA5UWNS3EUAYDlXau2ViaruJs2YLs2HyBATytX8orHh
 BK/Gpo6ViF+KXyalP6n6PLRGxE5S9/7N1UqLMlBQljYY3ojUA4heV1rtA4EoNZi9Qx+j
 Gk2Viyu/KnhFebp7dJgvZzRbXn+ikT/elwynz4BWDCOw8fchgh5ZKco1Pa0evpemULtd
 aFAXPf9ExWMNxp8x2Q1zmuEDJ9PwBXThmvBy/U7C9hdaNBpG7S61KjwCaNcA7CSbTVL/
 d9xQ==
X-Gm-Message-State: AOJu0Yzpbd1+rLEd9zAqtLqbamH2We9AnQ2J/2wu8uOBGXW94jH3mcMe
 Sx6+f25NVwi/0dV/BFxGarP1RFDJXS/dlz679/8ZVZ6vyZHB5GYNarQBTTypxOvk2p9wB6StYBA
 S
X-Google-Smtp-Source: AGHT+IFW6X21xATWnjs19uf+VAQ6MGgZYTZoVKA/0G6LpR232u94VmzYtKkSIJheRagPblZypXdAZQ==
X-Received: by 2002:a05:6a00:1a8b:b0:71e:48b:6422 with SMTP id
 d2e1a72fcca58-71e1db64785mr4342135b3a.2.1728486540635; 
 Wed, 09 Oct 2024 08:09:00 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/23] accel/tcg: Split out tlbfast_flush_range_locked
Date: Wed,  9 Oct 2024 08:08:36 -0700
Message-ID: <20241009150855.804605-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 61 +++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e37af24525..6773874f2d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -520,10 +520,37 @@ static inline void tlb_flush_vtlb_page_locked(CPUState *cpu, int mmu_idx,
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
@@ -532,9 +559,8 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
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
@@ -689,24 +715,6 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
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
@@ -720,13 +728,10 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
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



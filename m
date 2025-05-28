Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902B2C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBvh-0007uZ-Fd; Wed, 28 May 2025 04:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBva-0007tk-DX
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvY-0005Cq-E5
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so853575e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420054; x=1749024854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2R0giq/C1Km848MTITSAVr0NKLywWDm7jQSIufkU8ao=;
 b=JETGH+qr311FGoEq/iablvxe1OoVIPEYhrEqFBmoRQbLgCylhJ9U9iLc//x8EDD/kN
 +wDpKCzQCJmRg1dYg1iHNa4zSgkAhJbhvbFJH9nlIbGiT9ZokBIkgrrdQJ3Y79BTXqXY
 DrSubNImnNnK7Cgbp7PeGCTelIW8RkFVEhsfqjffhgbF2dD5Hw17bySx5KPxIt0xWj5I
 KXa8Un0hxrgXNzdjfxtUIP1OZKfJpQZoRZq75h0fYncmj58HGTb1fNBvelw+4p+fRQ2j
 Staq9zMkpjMgxl7oFEC35yg61A5CikXVTkFaqr9eDis+aD9A16pFQ2OUAeoree/fP5gy
 9JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420054; x=1749024854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2R0giq/C1Km848MTITSAVr0NKLywWDm7jQSIufkU8ao=;
 b=NO/V0jY5SRuhnFeXAoVWz4ZOzl35YTrNN9dqSn8PvLqbNjrqPVOBsfHIvk/IdV5cxf
 4RYydkGk5Q2/r+picRNE6PCc7T2SKbKc5A+5J4HcMx4HaKHiaHk7mnPrG4kXMgQ1u3E9
 mnJ2kotS6GRxOvWhxaVAb9YkOQKWHZ1odKpG+CDHMxD3VHX3gRHA+/NRApf4ZZTtY7K8
 PwFJYx9plNIAl4glS4KhLRIzohUzZyWUIpQu+yFknTLPpDVE8VmtJyldRroOBnxJYghr
 n8foXXMEQyd0mB8dSOHXMtASjeU9blY6C/9H0xc7UYWZ/cAYgGQGozY7VS9oc7lZaf5p
 9mFA==
X-Gm-Message-State: AOJu0YywFD2q9iyCltKHIXVioytST+8UK62vldXoS7vFhLGogb70fQ3z
 FfnI7bOmBnEVz3nzMKKt6L4IegYqpDEG1Jy4tsU9tBOdlZ8m2ffWcXuw0QoKlAzQW4loUJD5VyC
 nSmJ8mt6oug==
X-Gm-Gg: ASbGnctqJONYd5qUuWAST4fwrMi0qt2K3GElK21FGzcAoXy4BYhvIaMRznghULkMjHZ
 zlBuQotvrBHpTLzevSTJBXfqXYQn2TiwZVJ5nYSDeewey+mSr1VrYZaV4HGQRy5/KNbWg5OXYHX
 +pInTUrcg5JPC6T4lnMNnOSi5DkFcoFW1MMkwt1IUiiG0XXJJbDlzIiH6tr+fGlQSJKl9vlFhKH
 GLI8oxlQ4OG312iY08bZYU4Gs8KTQFyr97+vNcMSel1vtAtPiZYWUnEOJ4vih6D8B0YXGboEOjv
 XcTdlWg7+g7F+HtVJmp/c4N8GhtDDI1fI/KWEZ1ZEHYrdBhTnK9s+HJQ
X-Google-Smtp-Source: AGHT+IFHZe1SlQY5/1iPKV3XcI+2t/HPJIxj6wmQEmej4pLu6jcecGAkPcmrijn1njD81RajnchqyA==
X-Received: by 2002:a05:600c:46cb:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-44c919e16a8mr134045325e9.13.1748420054317; 
 Wed, 28 May 2025 01:14:14 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/28] accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
Date: Wed, 28 May 2025 09:13:43 +0100
Message-ID: <20250528081410.157251-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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



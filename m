Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72006C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kru-0006vA-RS; Wed, 23 Apr 2025 20:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015Y-QK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqD-0004jQ-B8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:26 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so358367b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456004; x=1746060804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaiqXvx8en6VCToTimGXoyGSBAmucTN+awgeSbs/f3M=;
 b=S6l6K39Z0q4Y89w4InfOGK/o2uKD6gH5ezX23jC5KFUsXZd+j/kZifShOr53jWRHh3
 T/epGCixYgqq4mCHtQWuvPaxr45yXoel419k573V8g/BLupcZvAOiAE2fAqayFNAHuLB
 uHI3SmmN+4fwboxLPw4466ybLjTdTvM/AzjjA7XLkI49/gqo2v1RScSmTXE25CFZEbT2
 UZNxZSKIQHR01k4fnafHzrbajvn10Or8K4mKcodwI3k6dI9ZNWOHV5wey4e68DbCGZl7
 3Qaa/LY3UH2QcRvORsehbIJW581zBEren4vdFiB7BkH/zvUHy81nVKWHUY/dzwDEJQlh
 bgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456004; x=1746060804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaiqXvx8en6VCToTimGXoyGSBAmucTN+awgeSbs/f3M=;
 b=saYJD0O34tqKTE0F+gKYvxFK4rQa3E7/HRtPUzDn5ztGsff3iI8qhrqRKdHBGvRW9C
 T6r+kYoVL5RSpxt9ANDhj3LkE8ey39utPPBYL45s0Daa5ULUuGePrksV1UJ7VSNA4kKL
 dPiJ+3FpxGlkvHGpM77aInHgPVAwpMTwXyfy3YkAhiyDQLxEcwv+2jwyJX9TwCR8lPMT
 idZHrpvQRzP19gz8wqlLgrY+NS+cVy1yr30JjjINmivBObS7xXdaEsBooOi1/GT1xLO7
 t2YLEl+d4L3PiV9utzvHiS8bRE5P8gukrXY4lXN2j4Wxf1Mv2ZbdGxBTgNppQp7vfZlY
 tUJQ==
X-Gm-Message-State: AOJu0YwW1UoLQkheHmoSvtKtQWI2xKVOypkP/WG+4p8VBHOTmfNeN47T
 ui2Iv0K3UDWbXVldXMPJqjGga2yg9EfPZGFIgEThJGEYI8XpCyzjiVDsRIYRc3oGn0Wc7HVpxP8
 G
X-Gm-Gg: ASbGncsRj/Xkt0iHWVIpG+IAatJT2NweJTKTlWSIaqLgY9Hdn42jOiNhXbDMaqaCnXE
 J+IdhEf0rtJ5pwwAxA6x9uDuPoDjDJnXRGnW5OJ4HFkfeGFWz68qfYWSilhNNKY4seKEoGlkQml
 fbezmd+vXhiDqe5t1+VjWUiOpaWUSUvEPYShA7JKC3SZf1JcTi2Yfy7UXz4dLXmxYVSCpGxdgap
 UjermOd0DWkvealMOJgwlnR53mmNa0MHMeo/TJRL472UrBU59zWondSAbZMZSQaVrTdxMGMYQNy
 /8ncGvc9Ox/SIfFruRRVdCnYDoSfTPoQBr64CDKdoDLk2oAEDYrhuSGuBvNRyuxIo+i/pMT1yp4
 =
X-Google-Smtp-Source: AGHT+IERMB1wGQM+Yp3acw8m6YcGImStLuJyyS4qxoxIrgago7BnuwSD/vzihVfc2aRFS3EakzrTZw==
X-Received: by 2002:a05:6a21:69c:b0:1ee:c8e7:203c with SMTP id
 adf61e73a8af0-20444ebefb6mr916079637.24.1745456003870; 
 Wed, 23 Apr 2025 17:53:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 064/148] accel/tcg: Pass CPUTLBEntryFull to
 tlb_reset_dirty_range_locked
Date: Wed, 23 Apr 2025 17:48:09 -0700
Message-ID: <20250424004934.598783-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

While we're renaming things, don't modify addr; save it for
reuse in the qatomic_set.  Compute the host address into a
new local variable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 10090067f7..5df98d93d0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -882,18 +882,16 @@ void tlb_unprotect_code(ram_addr_t ram_addr)
  *
  * Called with tlb_c.lock held.
  */
-static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
+static void tlb_reset_dirty_range_locked(CPUTLBEntryFull *full, CPUTLBEntry *ent,
                                          uintptr_t start, uintptr_t length)
 {
-    uintptr_t addr = tlb_entry->addr_write;
+    const uintptr_t addr = ent->addr_write;
 
     if ((addr & (TLB_INVALID_MASK | TLB_MMIO |
                  TLB_DISCARD_WRITE | TLB_NOTDIRTY)) == 0) {
-        addr &= TARGET_PAGE_MASK;
-        addr += tlb_entry->addend;
-        if ((addr - start) < length) {
-            qatomic_set(&tlb_entry->addr_write,
-                        tlb_entry->addr_write | TLB_NOTDIRTY);
+        uintptr_t host = (addr & TARGET_PAGE_MASK) + ent->addend;
+        if ((host - start) < length) {
+            qatomic_set(&ent->addr_write, addr | TLB_NOTDIRTY);
         }
     }
 }
@@ -918,16 +916,18 @@ void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
+        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
+        CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
+        unsigned int n = tlb_n_entries(fast);
         unsigned int i;
-        unsigned int n = tlb_n_entries(&cpu->neg.tlb.f[mmu_idx]);
 
         for (i = 0; i < n; i++) {
-            tlb_reset_dirty_range_locked(&cpu->neg.tlb.f[mmu_idx].table[i],
+            tlb_reset_dirty_range_locked(&desc->fulltlb[i], &fast->table[i],
                                          start, length);
         }
 
         for (i = 0; i < CPU_VTLB_SIZE; i++) {
-            tlb_reset_dirty_range_locked(&cpu->neg.tlb.d[mmu_idx].vtable[i],
+            tlb_reset_dirty_range_locked(&desc->vfulltlb[i], &desc->vtable[i],
                                          start, length);
         }
     }
-- 
2.43.0



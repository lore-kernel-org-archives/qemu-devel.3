Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3BAD68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcHu-0004vd-6q; Thu, 14 Nov 2024 11:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHr-0004uW-9z
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:40 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHp-0002B9-87
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:38 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-720d01caa66so742974b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600095; x=1732204895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D/kCglcC+IjHEzmMz83kkwbAHqcDArOp+yBPf3gcvXc=;
 b=dTBMZ5QZd6Iiwgn+qIvOVLidhYCA9dTLgLtmU7sLAukEBopYcOzJOMaVnub/z38W3a
 RYJNLQH4Wj+/QsQrRHKmhdde93EB1PrH96siklbYfvbnTQ93lxcOz1j/cQwjVhL2J9mo
 8oJlwOXnpSOWlOirnpjc8sua4BHY3HjKR6Ftf5Yy4n/9/v9A6BjueIVZzZC/YCYXsopG
 TdxapY14tYya8MqNPi/ih0E3tE79nLoTj7jSm1OeThrV926EEcXF/SsbYvYtH9RM9Ltx
 ka+P6mWR+TyV5i+DcmzY8uCahx9Nh3GluOcMcwuFDam07ZgnTmI+oRVTLPOu7Uj/py1F
 ZqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600095; x=1732204895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/kCglcC+IjHEzmMz83kkwbAHqcDArOp+yBPf3gcvXc=;
 b=OkV4EneVxpTju2eeuVYLvs7CHp2reGP+XUtEm8sIvCrpnHtg5855hL7BsQNtILB632
 rZcHTzawYlqMKNov0haYGHsAXaM/u8mRXjIv4MOKbafv8g5c5KrPKmO2GdA/ayhQDEoF
 ohp+XS5P/HkQAP3YzOAh8NmZq22mGuyDnfb0aegWVU7ZXUYCdHbaWzr4Qy8oT++Yf85q
 4OneCdQbMRTaUbt48tBYa2c3c+uiSWmy9OTN0/AEoUsz/dxgif5w8KRdQHjl2fT8c9kz
 VUpM6R28y8jiRaO0UnOoxQt/Q5RednzyoLNXxnYlpUzO3zXd380lxnnoQCUkhXotf/Ix
 +TIQ==
X-Gm-Message-State: AOJu0YxJhu95LGAlepIt+A1iKWl0pP4lr5rTevVgQbl/cTmMAnr2548m
 r7IbVF28HW5XRqIrq9xWEGBxnI2RwLvQobCsw1REiw460nI1ihOZ8OWKsB7zrcaiW9FgaTGBLjX
 a
X-Google-Smtp-Source: AGHT+IHHVQCIW8ZP7pg9m4QMeIwLQbHEjchContFqQR/igzca7bl3SocsqX180HON64phWEJ4OHlng==
X-Received: by 2002:a17:90b:4f47:b0:2ea:f91:f32 with SMTP id
 98e67ed59e1d1-2ea0f91108cmr1355267a91.9.1731600094719; 
 Thu, 14 Nov 2024 08:01:34 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/54] accel/tcg: Split out tlbfast_{index,entry}
Date: Thu, 14 Nov 2024 08:00:39 -0800
Message-ID: <20241114160131.48616-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Often we already have the CPUTLBDescFast structure pointer.
Allows future code simplification.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c1838412e8..e37af24525 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -131,20 +131,28 @@ static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
     return tlb_read_idx(entry, MMU_DATA_STORE);
 }
 
+static inline uintptr_t tlbfast_index(CPUTLBDescFast *fast, vaddr addr)
+{
+    return (addr >> TARGET_PAGE_BITS) & (fast->mask >> CPU_TLB_ENTRY_BITS);
+}
+
+static inline CPUTLBEntry *tlbfast_entry(CPUTLBDescFast *fast, vaddr addr)
+{
+    return fast->table + tlbfast_index(fast, addr);
+}
+
 /* Find the TLB index corresponding to the mmu_idx + address pair.  */
 static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
                                   vaddr addr)
 {
-    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
-
-    return (addr >> TARGET_PAGE_BITS) & size_mask;
+    return tlbfast_index(&cpu->neg.tlb.f[mmu_idx], addr);
 }
 
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
 static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
                                      vaddr addr)
 {
-    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
+    return tlbfast_entry(&cpu->neg.tlb.f[mmu_idx], addr);
 }
 
 static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
-- 
2.43.0



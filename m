Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B887CEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJN-0001SK-4a; Wed, 09 Oct 2024 11:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJL-0001OP-4L
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:11 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJJ-0007y9-4X
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:10 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso4764449a12.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486547; x=1729091347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gS/HO+CQQbelj0MUB4nbL/FHeSZv7sIrZF8Xsr6MsdQ=;
 b=GT5/sWYY54cpOdo69RTWmIFDNb06f8QWnS6ROJeCtw5Wkc1tiC4O47x4vuqdA0gLmX
 65i8t4KUtNl55aSGUuAoNHY3hwx2b+Qd39P+VTD2UCuH6psS3+Te6P4zSL8siXJGwqB4
 jYJiXHDB4zXGMv9KpLd5ZoH/G/GW7Lw7kMYwZjI7nyUWO3Xy9CFwMC3aLDZUoe2/K1hb
 H0yUo57sbCP3UKKrvrWcMHAOOg10qTKI/0BnM7EtfmtqmAlG1kIciahAAK0WGnJpzMCA
 K1vg8PJksZ3W8U+ogBC7MOhPhSyCq2yyfg8ovSqRGAXFAKP9NTiVhDcDUKswsLlVlct8
 1yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486547; x=1729091347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gS/HO+CQQbelj0MUB4nbL/FHeSZv7sIrZF8Xsr6MsdQ=;
 b=WSGs9VDPMJa0YSy7doYS/+mjI4WtfaaYY8bkNSPJWkxICfyFYkrkG4wse3XjmTveKC
 NCxHX1aYqgf6DngRasU+el3QLtBvX3YgTs86EtpScsUbqsvPZsXmdLl3slBHFGPdI1tj
 KiXCSQlJFqH4NU0YYd4vSmcxzZJHClTjJxRYs+Arm9m66CF21XvbpxD4k5WmDBi0+FFv
 5VJ022J58FRivZiusUlC1Cli/yc4P8plOw8su90bN7NP3jvQnwYlEFdq31drF4JpEJxe
 U9wcMVHwo+2MUBCj40WU0ysUuiaCZgMgXDIZ8azHOOx4ST7vBxoebAqmnm0xzmINShdS
 PB2Q==
X-Gm-Message-State: AOJu0YzP4Tym+ASwD/hfHeD6EIcKGnFb7sdM+4HuBD1f+7IHsB29CLr3
 +0BEGnlLlv9lVl3cl8qhNMUSBvUITcqP67EraXmvdHOU7pTui0byLDCRDt0dhnAOOI4EuV0QvH7
 1
X-Google-Smtp-Source: AGHT+IHMfmKkV7kFockoOLPbGAVQuA9HBLhFJpeDPtEUooE+gUeL7QXusNsF59CaEkEHBrwDFdRbuw==
X-Received: by 2002:a05:6a21:1304:b0:1d8:a899:889d with SMTP id
 adf61e73a8af0-1d8ad7dd2acmr353752637.26.1728486547587; 
 Wed, 09 Oct 2024 08:09:07 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/23] accel/tcg: Process IntervalTree entries in
 tlb_reset_dirty
Date: Wed,  9 Oct 2024 08:08:44 -0700
Message-ID: <20241009150855.804605-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Update the addr_write copy within each interval tree node.
Tidy the iteration within the other two loops as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 709ad75616..95f78afee6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1024,17 +1024,20 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        unsigned int i;
-        unsigned int n = tlb_n_entries(&cpu->neg.tlb.f[mmu_idx]);
+        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
+        CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
 
-        for (i = 0; i < n; i++) {
-            tlb_reset_dirty_range_locked(&cpu->neg.tlb.f[mmu_idx].table[i],
-                                         start1, length);
+        for (size_t i = 0, n = tlb_n_entries(fast); i < n; i++) {
+            tlb_reset_dirty_range_locked(&fast->table[i], start1, length);
         }
 
-        for (i = 0; i < CPU_VTLB_SIZE; i++) {
-            tlb_reset_dirty_range_locked(&cpu->neg.tlb.d[mmu_idx].vtable[i],
-                                         start1, length);
+        for (size_t i = 0; i < CPU_VTLB_SIZE; i++) {
+            tlb_reset_dirty_range_locked(&desc->vtable[i], start1, length);
+        }
+
+        for (CPUTLBEntryTree *t = tlbtree_lookup_range(desc, 0, -1); t;
+             t = tlbtree_lookup_range_next(t, 0, -1)) {
+            tlb_reset_dirty_range_locked(&t->copy, start1, length);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
-- 
2.43.0



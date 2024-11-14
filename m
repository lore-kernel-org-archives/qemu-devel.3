Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44346D68B34
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIb-00059J-0P; Thu, 14 Nov 2024 11:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI3-0004z6-Kv
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:51 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHz-0002DP-OF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:50 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20c805a0753so8528885ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600102; x=1732204902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8p+yJfYhOb0hWvZrgDQ+COQgpXoEivuXg56vfDbFxMU=;
 b=KiajS9YeEOeO4bZTjdzULh4VpNgvL5pqxep+40EDsK9N5NqxNL97d4xbSgDSTatEyq
 w6Hdnb0V0hssYu4RjogALWmFYqmSKxDc/LemuzMjSvZazqQEBm72pTNMwQYHftSidkIP
 njRuYqIe6ntvHlCWOc7Ib7so+bNhs08/lmPoENFWx//ueRmYO/krAPsUAWTDPJqM0aGx
 GxJrfTBQYbNjzivPTLQDtiUnhWuBDoonTNWBs9+keiKRIYzDfJ3M4tb2bL+O45818I1h
 5Vsf358KuqiJUJjDGYNdgufKOoqUAoV/1baC7vDG1AHPgl1IlRn1bRj5+45UWjpFQhmw
 ofpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600102; x=1732204902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8p+yJfYhOb0hWvZrgDQ+COQgpXoEivuXg56vfDbFxMU=;
 b=HOdDt71TwNh0uytU33D74xlbAVvRgjMBSY84LkSWjQm/iYOcCy5qTFW7zIV+7Ic1Op
 Pneu5VSyQ2pg7nTYDLv70Lyt8hT33ktn9+az1CxxpQcELPXsdzZgv19VQwzQ5785JdtI
 6pCBwginatQRLcJ8LQFwBKkhYI0UCTR4Y5PXtKr1JmVNqSqiwN2edZx2HmIDINDYrqkl
 60dcjPaDQIL/+KyvFIhBVBcsQDAijIFCcxma+KYfw8uIZDmvQme7xNeG0ghcyrcBLcso
 hKlsZxFvl4VkyPeA54r+ZXkl7Ri9SfokswdrMfQoAQQ9CG2R8R1uQBWzF5njN7pwMN1t
 O3PQ==
X-Gm-Message-State: AOJu0YwsXl1TW+zddpnFlMhsmFCSx9TSSHamhL4sd3uHiqwTKUo1DNzK
 UPM1ini8fyZwtqqnpBdNLU3BBJtkl3hu1L1b4mNShyPLXUFAz5QT7mJAT1CXRwquk7W+1XVtw+G
 7
X-Google-Smtp-Source: AGHT+IF+jprbCTqOgF4ottpXzA4kVHm5nA2aY5cLD3avsiOEsDtDYzt3Mjqc6TXOAMl/TajT0Xx8dA==
X-Received: by 2002:a17:902:8f8c:b0:20c:bcd8:5ccb with SMTP id
 d9443c01a7336-21183d67984mr268991755ad.30.1731600101979; 
 Thu, 14 Nov 2024 08:01:41 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/54] accel/tcg: Process IntervalTree entries in
 tlb_reset_dirty
Date: Thu, 14 Nov 2024 08:00:49 -0800
Message-ID: <20241114160131.48616-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index e2c855f147..0c9f834cbe 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1010,17 +1010,20 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 
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



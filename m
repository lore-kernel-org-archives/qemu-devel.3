Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3F8CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UmH-00076g-Le; Wed, 24 Sep 2025 15:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkL-0006Iu-UZ
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:01:51 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uk8-0007sN-9D
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:01:41 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b551350adfaso121698a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740479; x=1759345279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdg7wNUUpw9jfLHUtwMuanp6SWiKBj06yvk0f2EBI74=;
 b=clcxOAFDSnfY8UysJBbUKwJIvFOjLdZAvF8KNjAwPbNiHGBl1CblIDtIHrcHZxDwLS
 wFKh4BxfIK6b7QP/Rhcwt+/lcpwsqYeOicxQHbgQ+1Y8BHQau7VP/KdM8hPHhbRDHaA5
 8Q1m0ZoMEr3QRbtF8ftKzAtaZmqX4YSlsE6wBIH44ZTbPAWeCxKY0gaMHFxz2jXTSDic
 7+X6uflsqlNpoEvQT/TRBcaQISu5laLoQjSv0Xky1lRutAsitYhZp7yQUFI5PwgfuWSs
 /J6xWPzsr0Xa03YoSY6I1snvrEkkfh/5r2Iuymjvcw0Y3OdWx7TV2alvTsjvvXtg5BSV
 0kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740479; x=1759345279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdg7wNUUpw9jfLHUtwMuanp6SWiKBj06yvk0f2EBI74=;
 b=krCpgGXDSBp2M8mZNyrao+rhnBL4NFdrBIergQxsZzvMJfVHKVzMlA4K9W/GFI1PJP
 1C87r1rP1+KsFtIt5UJ3qdPaFKLpBKGuIjWAS83a2NWb4EDbNDG0A8guArFrZVCnGoPk
 f8t/8n7+hk2MiG1xx6nF+sODyKTYe6s+bbOsxQZ0JCR8rteYeJwyUNjQ0Ok4TcvxOWBQ
 uaauKXQ7+4mogjEFzPMOlqdoo0a5cY9U4lKCz+k75DZnose8hMzZeioSSHzk1Ww6CgFd
 oDC72itonEOQgLUKNcL7sZimdVgVywuy1gtIgh+RxUCbpmKSNpRfCG99rv6XytDbpxp/
 myAg==
X-Gm-Message-State: AOJu0Yw4gYYguVF36Cutqz2gvhju37oicLr8KQFK3aw5Z+3sCMlO8BHo
 C7uPEDuah+6PPUoAsoyK9QEMJ9C8YcN8PBiO66NuU5LVGcneti2pKorjompe7lrQmZQ/Hfio+KW
 4Q29/
X-Gm-Gg: ASbGnctpHe4yE+y5Lu/TjTLXrrnmofY2EDGeNf79mxVng6veeZUNfzIUUxwPVV1Y0t2
 U5nTDLrsG5JunhzDHvHYxrsCbaAtX8dSo7yfq98DXcGIxid6VhrWtkRYbK7voVyz1acrNYD6Kp+
 VLSCuPCGL8DyocasXMOIu8x85pJ+1wsZ6wcYqy8uJAWXP6qzr2STX2tqsIPqxE+oO3xdyBUEaPX
 Wnx8M1rjbH8qJZtNd+wjGUthkXbdT8K4U7K5iA6vVpoTC7wg0kHxkSTZW+P1XKhb1ozSOavCrWY
 p5Ep6Ge1jslhiUbT1zl5D/isCxlf0Zss/LmhnwfWhYn01/y42uaLh+XAFHo5tggFegOH6pBY+e1
 TOJ0yBirn7eyDxYAdaEd0pv241CmClGNTLcqzHWk=
X-Google-Smtp-Source: AGHT+IGPJOBKXHhdSC6F46KhxNMS3wtFITmsfilIWgPRQweX/n0iXUP6dFuHzyy9NzzaMN8LLC8FQg==
X-Received: by 2002:a17:903:228e:b0:275:b1cf:6ddc with SMTP id
 d9443c01a7336-27ed49b86c6mr9810495ad.5.1758740479457; 
 Wed, 24 Sep 2025 12:01:19 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/32] include/hw/core/cpu: Introduce cpu_tlb_fast
Date: Wed, 24 Sep 2025 12:00:49 -0700
Message-ID: <20250924190106.7089-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Encapsulate access to cpu->neg.tlb.f[] in a function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h        |  7 +++++++
 accel/tcg/cputlb.c           | 16 ++++++++--------
 tcg/aarch64/tcg-target.c.inc |  2 +-
 tcg/arm/tcg-target.c.inc     |  2 +-
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8dd83f7457..22a78c9ee1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -602,6 +602,13 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
     return (CPUArchState *)(cpu + 1);
 }
 
+#ifdef CONFIG_TCG
+static inline CPUTLBDescFast *cpu_tlb_fast(CPUState *cpu, int mmu_idx)
+{
+    return &cpu->neg.tlb.f[mmu_idx];
+}
+#endif
+
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
 extern CPUTailQ cpus_queue;
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d324f33339..2a6aa01c57 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -129,7 +129,7 @@ static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
 static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
                                   vaddr addr)
 {
-    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
+    uintptr_t size_mask = cpu_tlb_fast(cpu, mmu_idx)->mask >> CPU_TLB_ENTRY_BITS;
 
     return (addr >> TARGET_PAGE_BITS) & size_mask;
 }
@@ -138,7 +138,7 @@ static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
 static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
                                      vaddr addr)
 {
-    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
+    return &cpu_tlb_fast(cpu, mmu_idx)->table[tlb_index(cpu, mmu_idx, addr)];
 }
 
 static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
@@ -292,7 +292,7 @@ static void tlb_flush_one_mmuidx_locked(CPUState *cpu, int mmu_idx,
                                         int64_t now)
 {
     CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
-    CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
+    CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
 
     tlb_mmu_resize_locked(desc, fast, now);
     tlb_mmu_flush_locked(desc, fast);
@@ -331,7 +331,7 @@ void tlb_init(CPUState *cpu)
     cpu->neg.tlb.c.dirty = 0;
 
     for (i = 0; i < NB_MMU_MODES; i++) {
-        tlb_mmu_init(&cpu->neg.tlb.d[i], &cpu->neg.tlb.f[i], now);
+        tlb_mmu_init(&cpu->neg.tlb.d[i], cpu_tlb_fast(cpu, i), now);
     }
 }
 
@@ -342,7 +342,7 @@ void tlb_destroy(CPUState *cpu)
     qemu_spin_destroy(&cpu->neg.tlb.c.lock);
     for (i = 0; i < NB_MMU_MODES; i++) {
         CPUTLBDesc *desc = &cpu->neg.tlb.d[i];
-        CPUTLBDescFast *fast = &cpu->neg.tlb.f[i];
+        CPUTLBDescFast *fast = cpu_tlb_fast(cpu, i);
 
         g_free(fast->table);
         g_free(desc->fulltlb);
@@ -667,7 +667,7 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
                                    unsigned bits)
 {
     CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
-    CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
+    CPUTLBDescFast *f = cpu_tlb_fast(cpu, midx);
     vaddr mask = MAKE_64BIT_MASK(0, bits);
 
     /*
@@ -923,7 +923,7 @@ void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
-        CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
+        CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
         unsigned int n = tlb_n_entries(fast);
         unsigned int i;
 
@@ -1316,7 +1316,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
-            CPUTLBEntry tmptlb, *tlb = &cpu->neg.tlb.f[mmu_idx].table[index];
+            CPUTLBEntry tmptlb, *tlb = &cpu_tlb_fast(cpu, mmu_idx)->table[index];
 
             qemu_spin_lock(&cpu->neg.tlb.c.lock);
             copy_tlb_helper_locked(&tmptlb, tlb);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 3b088b7bd9..caf79c742d 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1668,7 +1668,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->oi = oi;
         ldst->addr_reg = addr_reg;
 
-        /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
+        /* Load CPUTLBDescFast.{mask,table} into {tmp0,tmp1}. */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
         tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 338c57b061..87ca66bb02 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1421,7 +1421,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->oi = oi;
         ldst->addr_reg = addr;
 
-        /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
+        /* Load CPUTLBDescFast.{mask,table} into {r0,r1}.  */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
         tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
-- 
2.43.0



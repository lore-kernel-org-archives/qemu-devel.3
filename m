Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311E0C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwMZ-0000xu-Vb; Sun, 27 Jul 2025 04:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLx-0005fK-4Y
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:29 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLv-00048d-3p
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:28 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b391ca6146eso3084847a12.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603406; x=1754208206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlJ6FDp1q2NQgZlTviuGz87rhz20dNXg1agPJ/fUdpY=;
 b=lj/uK+J9yJUhcrvtcr46OcwAIm4K63erUNWGUN5FWl9Jtxi/AVp+JEik/OvuiAOBGC
 WURn2/EkVor6nS2xKUoccvYhwqse+JiaEifMyMQqgrCzbmKmN0dBNv9lJMDN0Gi2K95I
 RlINsOw9Otxh6DMNSBCi1BjUxDfcb0cIay+yu/PvS516OM1JWguRvLXOD2wa2OfYnqK7
 XJpiH0+fp16YQWXr1QYtgHeRYEtMpte7/RDtLX3U4F8/fr4YI7A7eOsa5mcFza0LBWii
 5bO4tuNAE4WfKigsd4pVFgrZP1MFqE7ZXV9vAxRtISykmtyla1Usk2d6czfhjsr+JI3e
 Zk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603406; x=1754208206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlJ6FDp1q2NQgZlTviuGz87rhz20dNXg1agPJ/fUdpY=;
 b=QEEU5yWPTZrpoUx6sBin3OC8IE2gSdLh/1N5TYvFV4/EqC39SmUKV7Dg6/JF6kyW9T
 wjjd7d6AeZILDZoDU1y+l9e6J5f10kJK0w2nCBfVtsGtUmvNVwYqXWRwyhSNB06N3gzm
 ZaNd52VhyZk1e9K4d7aGs6NK8whvcJrtnlHDxmaVHmujco/gjGb/8wQTphp9QRAZ4rM8
 dQcSF/GUC4GtapXsiyuwB9YanjCswDBVPFT8wrCq4xj6Mp6WRuJ/qEaSyfNxtN0Swh4i
 tSFyaiTTE9ZCL7Axe84/UdJW6yc8KL/P0z9PJkhEWG3X4xoUvZK6fn8YXyiLbcDfGTiK
 gcRA==
X-Gm-Message-State: AOJu0YzyTe/KdoImWb4L9jgh/7DUqnrQiwvftBgglNdyY1JdfqshjJlp
 o8GRvIpsQNRpOJylX9EoK1pO0zy6cExf54UdU6mJhmuMS/h1v/bX/fAX9OmQekkL/AjEjycv4+Z
 gHqMM
X-Gm-Gg: ASbGncsyHUd3j1ca0qWHx3uTfN6Cxm5BJx7RiTy6okGePmZ2oyp80w5WnI0LGvtj29E
 xv/XaUUiW0/GYA89fW9wIVbEbqcMNfnBMZDHyyGlqMwVucrL2spnIVd4iAF3NSlr+DBwJ1rz81t
 TjCDhz4DzOBWSz5dcF+KDJQXYhq7FnrufIeeE4GOGxVSYjOK4imMMqMZRCKY6CerB+abEOAurEE
 3wBBt1dxNUGXV0AYOerXNy3Jl8s/JVMHf0UgRDWCQFtYXfse8rA5+KeV7t1/BLXXvb+5Qb9p96l
 2KZH7gCZWOnD+9Knu7nA5xBi7IBqujSwADcDEgn7uIb3cj04xhwMDqNNKkF9h5cuMGoe8+guO5N
 qaLbUNR5M6TUfo0Gy9AY16sdLJZTSyhKccpqbHYxlt3iY7Ywor+YWAxedcCUfMW5jLSqsvqS5FG
 ijuD+8eYT3DQ==
X-Google-Smtp-Source: AGHT+IFwnlPl9ex85Y1qAQIlHahJ5Um2Cb1c1wxF89A5WEIwgxzqx4+rwrcpDIfiHpSVHCTt4AfPIg==
X-Received: by 2002:a17:903:3c26:b0:237:f76f:ce34 with SMTP id
 d9443c01a7336-23fb3082c1bmr120976475ad.15.1753603405649; 
 Sun, 27 Jul 2025 01:03:25 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 24/82] include/hw/core/cpu: Introduce cpu_tlb_fast
Date: Sat, 26 Jul 2025 22:01:56 -1000
Message-ID: <20250727080254.83840-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Encapsulate access to cpu->neg.tlb.f[] in a function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  7 +++++++
 accel/tcg/cputlb.c    | 16 ++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1153cadb70..bd835b07d5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -593,6 +593,13 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
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
-- 
2.43.0



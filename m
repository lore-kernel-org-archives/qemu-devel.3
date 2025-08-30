Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E00DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNw0-0008AA-VF; Sat, 30 Aug 2025 11:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMX-00069J-J0
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:53 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMV-0004GR-Po
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7722f2f2aa4so1626108b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532570; x=1757137370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jdo4eXfghXIxBtW7gGLE9m9wdInFFP/OSUyrEzGuH10=;
 b=LTPviQQ0Sg7qUJGXXLrjBBwoKzF+bSCDW/m0Lxo1svTZLs3CIBMq1zTKcYzl/mq9ki
 3dt/qvmGpuufj0poH6nygScl6HGtEvQZA78En14yNVGxmlWI8oakQICu+X7QoiaqmjSO
 Q2S+AJWDfirWtGHYZv9jf3oQxSZFCUCOi0+srrguoUSv0FKYFTyhCXBxtDnqLd6vozBp
 J7ohezni11/mb5xECa3FgOkZhtNm2I9H7GrEd7lzhgK+T8VDKuE9qUxoUG9H6dcxdkh3
 16e2N3bRloduSBiF68OwlZk1C1NHMnaL9Ba1SyctjpxFm6YktiM7b5trpK7+nqFFYlZc
 Onxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532570; x=1757137370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jdo4eXfghXIxBtW7gGLE9m9wdInFFP/OSUyrEzGuH10=;
 b=WNp4KC0Vb7S39qAk2yGwZd5A/vDOmxUVQVlUQ2OKX8BhxtiNNIoDJgRjAiAHa8s/L8
 x0d8Bw+qhzRrYl12yci863EJVCx2jTohhtJUPL7/kZYwBgUeaxPf+SRrfzTE+Nu1W5H4
 fr5teQhzYYy4wo1f8AQro0PQqWjmX/BBHOM9lnyxsbzTeM0o3nEF700QK4Y6z3m2U/Jy
 Berze9C1EnQqfo38AiWEfGJMtLXfDZQomS0N8bRSfGGjx//gQT1NEXCI4d3pt1dZzzbA
 2Vz8HzjB7IT8WoE2WAIm0Rroheb8dh4+E2sON9Ty56G8/kY0aSLAVmYPqH+/bwSMcqCu
 /wFg==
X-Gm-Message-State: AOJu0YxQp4u7ULDeQGqt7Flvt04hNXaPir93ZqicYlQj4OXLtRepmEMM
 EgUrE7ZhDGE3W1JfkoV1CZnNnoAE+kPoGZA6A/fCPBVzGr3fcbkaPRxTPBV9B9MC+J1puwzV3aB
 FXh5mGkQ=
X-Gm-Gg: ASbGncsHYW8gqQYmbrVhCNjX20TrgvMHTAcXqJD5cHEfrLpMtps36uYBy/2PV2Yw34l
 h/VJZS4oax3tKwhykVOqACq6UC5H87nktaezEgt5HkFZfZ3ueHgsaEL8VCWrxAuyaSSpU+8dIp8
 fgLF0FPIDC2WnIf3iAiRDu3QnnaC/7OwFaSV3M18BDNa0X+2JAvQ3nvfI7KTJXMMo4eWpD4gSoC
 tYMC06OoYH6wzn7R3gvRLf2QOPWP4U9ZcP+QNHn8sdDH1aoWnfKW5NS/YX2WDlJGpZgdTQChHmg
 5KU4ElHJr8AJLFD+BaFsAofxQJiiZf7wbKtm/mYmYXlzZLdoFuufwRRqzU0/soddqwmVqWEJf3v
 li7Ju82aTKtDypvYqLgYezHV1stEQeQ1l9aTzOGyzxmxFu7f1PieiUhCpD3OsXm1N8UKWB50=
X-Google-Smtp-Source: AGHT+IF3VT9uEIlI6pQXs5VR24ZSOkvF6uhjHqpH8aYDRsBz/7E5E8fAkVVguGSs9K4iHu4MW//DbQ==
X-Received: by 2002:a05:6300:2109:b0:243:b3e2:ca07 with SMTP id
 adf61e73a8af0-243d6f7ef5dmr1552786637.58.1756532570323; 
 Fri, 29 Aug 2025 22:42:50 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 27/84] include/hw/core/cpu: Introduce cpu_tlb_fast
Date: Sat, 30 Aug 2025 15:40:31 +1000
Message-ID: <20250830054128.448363-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
index 836894b16a..4069508272 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1420,7 +1420,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->oi = oi;
         ldst->addr_reg = addr;
 
-        /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
+        /* Load CPUTLBDescFast.{mask,table} into {r0,r1}.  */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
         tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
-- 
2.43.0



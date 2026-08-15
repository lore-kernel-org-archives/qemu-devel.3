Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EA0C5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKw-0007Zj-GM; Sat, 15 Aug 2026 15:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKg-0007Je-Ob
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:21 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKd-0008KI-EN
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:17 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso18721415ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823174; x=1787427974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UhKBD+tRgxL1bjQJ7VX4BBXuneohxZ5oDU1L18T6RBU=;
 b=Kvn7KsXjkbjjkN/BDjVxbahGsGf0aq1uGtUcH55tGoH80MqmJp/gZUKRVug8YUmcgE
 5GmoqihDdh5WYNpviPfRdL3ZjSBwbA9zaEBiTei19NPY1zWUoOXZvasfM6Zu/EQtPRVe
 srHZ6TAOHFOyF/5KZqWJWYsdsRo4Aae+3z97lLN8kxu26kVCVjLCj3ySpmjV2N6dgXrd
 RfF3i7LGaWSp/lKTF376q1Ad8aZCrDJkUpBnMFMD4eoaedeYk3B2NXCmMYr8zBhHEvKO
 8suBxf30dirh7g5GcpMOtpHVoQL2pLj2XWCbTC5q1jfdIsc3QG/NGURyy6ZvyfT2N1Iw
 nNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823174; x=1787427974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UhKBD+tRgxL1bjQJ7VX4BBXuneohxZ5oDU1L18T6RBU=;
 b=BP0/mAzMgChZyMJ1qw/MuGexjm960+lT+FswyxxWqtN8MBnetft24gta2vEcTxuiG0
 XBwGA5b5Xyun+3AjnzrFcjYPAHNfd2FJnf9Qqssvyqtea/clynaUO28dTeQ+7CWSDBRo
 31WT4p185fC8z8Q/f8axaWfgifQ2mD442PnCMHq3JOUlYYudOluTgKqLo4l/BVfjqC5m
 bQgZJ/5NcsNcleXDOzbQFgnTm4gK4pkmamlWSa/O2IWE5z+jbATvxPmur8EUkKjs92VZ
 b518mYhSnD7ShajwULP8lL0SQWNrYJzPrd3y0qk7nS8jEUY/KWEBwsL9px4I0zMuMicS
 EF5A==
X-Gm-Message-State: AOJu0YzCfUylJzMZwHpoozLogQgCR3eFQsDV1v+Um+h50Pjohr+9HV2o
 iZcIz9aFm/jupqnH1vtg7G4jjV24O4uuA9fvZru40Qal3GvZ+ErxxBmKI1esNmaFOLE8u9jJQlo
 W2WhL
X-Gm-Gg: AR+sD12xdQxb1qTw1CR8QPzAp1ONaf6q9zHGXfHJqhBWPbg2Y1qsOtXzJL8f8UQd4VX
 UNSPktcxuAL1PA/lQuh2JAayXly2utQGvdU12qM5JuPZQVkMtGHI0ySCGQyT8yPJtugtYGCEZfI
 3xG1ZybMz2IRTSbXBDD0WlJ0/7/WzBP8R3l65mdbeRlbzIVy7J/dBNBTKU26yuq3MPXi0TR+0tb
 lvqzZNXVj0EsDpoxWlX3pWv1AiObu+LMjzwYG83raAR6HIc7JfKGhNcrMboMoLNZqj9/Wxc4/xa
 AvuJ7sa2XEg8T8iN/jzvmQuxW49YRGZRF/aN7ZZ+gIBTh0enU0fMBRFSlbbuACpXlDmFR0aXJvl
 UyCA/7cOU5fuKf7Dr8/yQt400A20C9mlS8p66zoD/zuf7R/hGXZK8F9lmZlImehCjDfb/hOCx7Q
 VmqvYUyVqKcqncBBnA49O1+WO7BgpznY9q4rllt+Mh0s7W6nkNxN/o61zq6u0kZdBEEdcvo3C1q
 mrC/8tzADMU3G+q/5KN
X-Received: by 2002:a17:903:32cd:b0:2d3:a572:7d52 with SMTP id
 d9443c01a7336-2d3b0d5c87dmr151528925ad.18.1786823173898; 
 Sat, 15 Aug 2026 12:46:13 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 13/23] target/riscv: Use vext_ldst_us in vext_ldst_whole
Date: Sat, 15 Aug 2026 12:45:38 -0700
Message-ID: <20260815194549.1377505-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This eliminates the last use of probe_pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 120 +------------------------------
 1 file changed, 3 insertions(+), 117 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index abb1ebcb43..178ed32429 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -149,50 +149,6 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
     return scale < 0 ? vlenb >> -scale : vlenb << scale;
 }
 
-/*
- * This function checks watchpoint before real load operation.
- *
- * In system mode, the TLB API probe_access is enough for watchpoint check.
- * In user mode, there is no watchpoint support now.
- *
- * It will trigger an exception if there is no mapping in TLB
- * and page table walk can't fill the TLB entry. Then the guest
- * software can return here after process the exception or never return.
- *
- * This function can also be used when direct access to probe_access_flags is
- * needed in order to access the flags. If a pointer to a flags operand is
- * provided the function will call probe_access_flags instead, use nonfault
- * and update host and flags.
- */
-static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
-                        uintptr_t ra, MMUAccessType access_type, int mmu_index,
-                        void **host, int *flags, bool nonfault)
-{
-    target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
-    target_ulong curlen = MIN(pagelen, len);
-
-    if (flags != NULL) {
-        *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
-                                    access_type, mmu_index, nonfault, host, ra);
-    } else {
-        probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                     mmu_index, ra);
-    }
-
-    if (len > curlen) {
-        addr += curlen;
-        curlen = len - curlen;
-        if (flags != NULL) {
-            *flags |= probe_access_flags(env, adjust_addr(env, addr), curlen,
-                                         access_type, mmu_index, nonfault,
-                                         host, ra);
-        } else {
-            probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                         mmu_index, ra);
-        }
-    }
-}
-
 static inline void vext_set_elem_mask(void *v0, int index,
                                       uint8_t value)
 {
@@ -436,33 +392,6 @@ vext_page_ldst_us_tlb(CPURISCVState *env, void *vd, target_ulong addr,
     } while (i < evl);
 }
 
-static inline QEMU_ALWAYS_INLINE void
-vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
-                  uint32_t elems, uint32_t nf, uint32_t max_elems,
-                  uint32_t log2_esz, bool is_load, int mmu_index,
-                  vext_ldst_elem_fn_tlb *ldst_tlb,
-                  vext_ldst_elem_fn_host *ldst_host, uintptr_t ra)
-{
-    void *host;
-    int flags;
-    uint32_t size = (elems * nf) << log2_esz;
-    uint32_t i = env->vstart;
-    MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
-
-    /* Check page permission/pmp/watchpoint/etc. */
-    probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
-                true);
-
-    if (flags == 0) {
-        vext_page_ldst_us_host(vd, host, i, i + elems, nf,
-                               log2_esz, max_elems, ldst_host);
-        env->vstart += elems;
-    } else {
-        vext_page_ldst_us_tlb(env, vd, addr, i, i + elems, nf, log2_esz,
-                              max_elems, ldst_tlb, mmu_index, ra);
-    }
-}
-
 static void vext_test_alignment(CPURISCVState *env, vaddr addr, uint32_t esz,
                                 MMUAccessType access_type, int mmu_index,
                                 uintptr_t ra)
@@ -1026,53 +955,10 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
                 vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
                 uintptr_t ra, bool is_load)
 {
-    target_ulong page_split, elems, addr;
-    uint32_t nf = vext_nf(desc);
-    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
-    uint32_t max_elems = vlenb >> log2_esz;
-    uint32_t evl = nf * max_elems;
-    uint32_t esz = 1 << log2_esz;
-    int mmu_index = riscv_env_mmu_index(env, false);
-    MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
+    uint32_t evl = (riscv_cpu_cfg(env)->vlenb * vext_nf(desc)) >> log2_esz;
 
-    /* Calculate the page range of first page */
-    addr = base + (env->vstart << log2_esz);
-
-    /* Recognize alignment fault before memory protection fault. */
-    vext_test_alignment(env, addr, esz, access_type, mmu_index, ra);
-
-    page_split = -(addr | TARGET_PAGE_MASK);
-    /* Get number of elements */
-    elems = page_split / esz;
-    if (unlikely(env->vstart + elems >= evl)) {
-        elems = evl - env->vstart;
-    }
-
-    /* Load/store elements in the first page */
-    if (likely(elems)) {
-        vext_page_ldst_us(env, vd, addr, elems, 1, max_elems, log2_esz,
-                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
-    }
-
-    /* Load/store elements in the second page */
-    if (unlikely(env->vstart < evl)) {
-        /* Cross page element */
-        if (unlikely(page_split % esz)) {
-            addr = base + (env->vstart << log2_esz);
-            ldst_tlb(env, adjust_addr(env, addr), env->vstart, vd, ra);
-            env->vstart++;
-        }
-
-        addr = base + (env->vstart << log2_esz);
-        /* Get number of elements of second page */
-        elems = evl - env->vstart;
-
-        /* Load/store elements in the second page */
-        vext_page_ldst_us(env, vd, addr, elems, 1, max_elems, log2_esz,
-                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
-    }
-
-    env->vstart = 0;
+    vext_ldst_us(vd, base, env, log2_esz, 1, evl, evl, false,
+                 ldst_tlb, ldst_host, ra, is_load);
 }
 
 #define GEN_VEXT_LD_WHOLE(NAME, ETYPE, LOAD_FN_TLB, LOAD_FN_HOST)   \
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65E2C5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUP-00061y-7C; Fri, 21 Aug 2026 00:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUN-00060R-7B
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUL-0003B2-8g
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2d58efc7356so7077845ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285056; x=1787889856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kFG+X+gNFB2lQusybVgjPeXj7Ar+44XCtkZGXEI5MiU=;
 b=lyS4tjgiyZTR7VhSqeYXblio0umpvpT3nFlkZdyy17Ybnb/PUFxpqb1fnkujMwzKWs
 dqca1qGZw6Wgx+YTbJka4159uLBphHulFUhbmk/r2x1sazWtnHyxBoCP8rCZTb0bMBJ1
 ZbN3uKSTvbeCPMzM2sthAXRf4diBYERtZksPav5vGbKRdWlerbRnU7ZXsunb3KrEyitU
 fyqyUW4YkVSJQvVQXBaYbD1SQP5WErdSFXDyKVq1d6xvGy3sOr3Dv3/i/nqCdyCIhJff
 GBseTbLmWvvRROfga8ymaNjeHWJInRUCRvYfY//cmHOABDiwS2HD8P/XorHZqC+MflbZ
 HJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285056; x=1787889856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kFG+X+gNFB2lQusybVgjPeXj7Ar+44XCtkZGXEI5MiU=;
 b=nMdzo2J+ygUWUdM98404ZZkQz6SM8DboYXmamZwAhIiAxXoUMLI86A6jbJhLFRxaXZ
 dWqukZfMzPOKET8C7UIcF1TPI8/6Y2Dlfnheb/cdFwzObJngi2uSjyDPu+tGogg4UX8k
 z8hngltkWDbNuStHXVCctmjM24lZVu2irRba7kMK62FBrbYazTXoC5nyTSr2+IKNIL83
 okc2cP9H3sn8cBIFfJrSbHaWYd6AfxqNY0+tRhKPnSTUPKrxVubGnVe2m1DU4Dzw+VIO
 jzf7tUDeclThXqjkH62b4km44DIx6qSU2s3DlkN+ccUbO5D3WFhC884q6NMHX6hXw+jY
 GKsg==
X-Gm-Message-State: AFuF++lbInZOfgCKQhxhdyW0/r0rYKt7I+V/vIjx1Sauf9rW/4eKLZoq
 m1lOrvC5fHcjfxYdgNzt+rPwq2HbIR0zq3riv2uikmVgZSNDi10Iws+aTHR1NmbC9qog+YVKR1f
 g5Qzo
X-Gm-Gg: AR+sD12tFaJ0WheVb6m/QJqTfAMaM2WRDGFKRTfirF8iD/nZsnBox8OAMJtHNU5uJnp
 ntXFU21XwdAOWOPoYmNnugiKJpOElu7bSphhFgFtgsa3Nyxls4nx+QAHqjAlE0IFVU+l3w8Rq1e
 OUX73+nPaA8bNFtgotW9XmFPg7RJEKXjNP0sNl9ydebX0PV0jZWfxepkoU6D9Lfo4YdHVBFngdp
 I6G3drd9DZxB/T7cA3OBdQ9UqC0ko9uJbfmHtWhCrwkImbpNunVGXN169GcpdTipIUGCzn09PBT
 xakF2jTUntxace+bmSn9o5VsbZjr0/Ysrv5VzDfTtw86mAgbJ0cxhfEaMKLDGS8RDmx6FhWIpat
 +p25JsEgDpA+h7yG4xBEPKr7r5sUqGWIQ5PjOiOpDKqLZqB3tIAdr04EOMmwdY7jkZcHbNkUVZ2
 YB6poe3KYkZSIiIydOCOsb1Bthp8ZQ006Zo6nDCxrE+M+ntIVuNivdMeifmFaNPdXM+S8=
X-Received: by 2002:a17:90b:3912:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-395c3738b35mr5334615a91.13.1787285055674; 
 Thu, 20 Aug 2026 21:04:15 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 06/23] target/riscv: Move misalignment check out of
 vext_page_ldst_us
Date: Thu, 20 Aug 2026 21:03:47 -0700
Message-ID: <20260821040404.268123-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Alignment faults generally have precedence over page faults,
therefore we need to test for that before probing pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 62 +++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 63a51f2b48..18840336cb 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -31,6 +31,9 @@
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
 #include "vector_internals.h"
+#ifdef CONFIG_USER_ONLY
+#include "user/cpu_loop.h"
+#endif
 #include <math.h>
 
 static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
@@ -433,16 +436,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
                 true);
 
-    bool misaligned = addr & (esz - 1);
-
-    /*
-     * Allow the host fast-pash when:
-     *   1. Page permission/pmp/watchpoint are checked and we have a contigous
-     *      host mapping.
-     *   2. Zicclsm is enabled or load/store is not a misaligned access.
-     * Otherwise, we will fall back to the slow TLB-path.
-     */
-    if (flags == 0 && (riscv_cpu_cfg(env)->ext_zicclsm || !misaligned)) {
+    if (flags == 0) {
         if (nf == 1) {
             vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
                                       host, esz, is_load);
@@ -462,6 +456,20 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     }
 }
 
+static void vext_test_alignment(CPURISCVState *env, vaddr addr, uint32_t esz,
+                                MMUAccessType access_type, int mmu_index,
+                                uintptr_t ra)
+{
+    if (!riscv_cpu_cfg(env)->ext_zicclsm && (addr & (esz - 1)) != 0) {
+#ifdef CONFIG_USER_ONLY
+        cpu_loop_exit_sigbus(env_cpu(env), addr, access_type, ra);
+#else
+        riscv_cpu_do_unaligned_access(env_cpu(env), addr, access_type,
+                                      mmu_index, ra);
+#endif
+    }
+}
+
 static inline QEMU_ALWAYS_INLINE void
 vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn_tlb *ldst_tlb,
@@ -474,16 +482,21 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     int mmu_index = riscv_env_mmu_index(env, false);
+    MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
 
     VSTART_CHECK_EARLY_EXIT(env, evl);
 
+    addr = base + env->vstart * msize;
+
+    /* Recognize alignment fault before memory protection fault. */
+    vext_test_alignment(env, addr, esz, access_type, mmu_index, ra);
+
 #if defined(CONFIG_USER_ONLY)
     /*
      * For data sizes <= 6 bytes we get better performance
      * by simply calling ldst_tlb.
      */
     if (nf == 1 && (evl << log2_esz) <= 6) {
-        addr = base + (env->vstart << log2_esz);
         for (uint32_t i = env->vstart; i < evl;
              env->vstart = ++i, addr += esz) {
             ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
@@ -495,7 +508,6 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 #endif
 
     /* Calculate the page range of first page */
-    addr = base + ((env->vstart * nf) << log2_esz);
     page_split = -(addr | TARGET_PAGE_MASK);
     /* Get number of elements */
     elems = page_split / msize;
@@ -725,7 +737,27 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
+    /* Search for the first active element. */
+    if (!vm) {
+        for (i = env->vstart; i < env->vl; ++i) {
+            if (vext_elem_mask(v0, i)) {
+                break;
+            }
+            if (vma) {
+                vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
+            }
+        }
+        if (i == env->vl) {
+            goto tail;
+        }
+        env->vstart = i;
+    }
+
     addr = base + ((env->vstart * nf) << log2_esz);
+
+    /* Recognize alignment fault before memory protection fault. */
+    vext_test_alignment(env, addr, esz, MMU_DATA_LOAD, mmu_index, ra);
+
     page_split = -(addr | TARGET_PAGE_MASK);
     /* Get number of elements */
     elems = page_split / msize;
@@ -823,6 +855,7 @@ ProbeSuccess:
         }
     }
 
+ tail:
     env->vstart = 0;
     vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
 }
@@ -866,9 +899,14 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t evl = nf * max_elems;
     uint32_t esz = 1 << log2_esz;
     int mmu_index = riscv_env_mmu_index(env, false);
+    MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
 
     /* Calculate the page range of first page */
     addr = base + (env->vstart << log2_esz);
+
+    /* Recognize alignment fault before memory protection fault. */
+    vext_test_alignment(env, addr, esz, access_type, mmu_index, ra);
+
     page_split = -(addr | TARGET_PAGE_MASK);
     /* Get number of elements */
     elems = page_split / esz;
-- 
2.43.0



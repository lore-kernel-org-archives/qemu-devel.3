Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F05AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUR-00065s-VK; Fri, 21 Aug 2026 00:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUP-00062M-Kw
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:21 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUN-0003CE-FL
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:21 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso498041a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285058; x=1787889858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yg0R9lp1wA+wZ7tNXGKNkxI/zEhk3zYnixoj/UZ92CU=;
 b=vUgU5ibilclgcA2pUVS+mY+sfjDAT7pvVoLbp4q60k1VUTk1KQjlDJWCtGPSWQ8Hgj
 sCgxdQWeWTgY/olviwNY6ffvgRj3Pe+Hz2DYNEMAEvF3FvIWQc5F5nM3R5Ldw/0NiCDr
 e/CIkFDD8yd+L8Uc/4WzN/4z5jvj4gKerFVUpbM2XInVcukrpoaITgHZvyV+O2fooxHF
 wC6WeGrKRB69Sw/1Qeb5pe2i81od4zy6HCFsIRUs6F4U1fIjGZ/otITfPc45nV9Xep0H
 MCnSu//ye9TWJ00Vg/H+DWdvRJ3JAoqZ+sM/iyTD0DH8+4htmr4bfFvsES4wzSoR7kdu
 i9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285058; x=1787889858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yg0R9lp1wA+wZ7tNXGKNkxI/zEhk3zYnixoj/UZ92CU=;
 b=IcKNLKFqdpymxHSMHE4S7kTjKm88viyWtWx36U/oqA7mrvgQGq59KBzVepx6PT8M4+
 fyu7UQFSOMYNTrvJR6t0eccLLn4TykCywcFZ3QD07h8kuVJq5ka6BOMvDF7tty/EtmDt
 GZ9UzNG3tg8yBEl5hQJ2Xk049t1L+/vClVB43FNiueZGV7Zi9CAvH4vsx3EgNGRKyYqI
 AtMOCjJSTpQHTEu0GiTvtNm5tTf1TqEHzOw4DpS14qQC5wf26lth2RqvuxS+vhZRFPD/
 yapri9i65XAZSfk5ToN5OcdCVpxe6hXNuJ7dLbFcWs7a0Hsf9/0SOLcF+MLg2Y2s7QoM
 5mGg==
X-Gm-Message-State: AFuF++nL0cWO6jPnMlkPuqN85gRUfOUWzG2UeejRteP+ozj6ewhSmq9q
 CMR4PIj8tDa8sYdaBNAcgda4zB4NXqiLw3YNCoZhA9U6C6hX0h4uetnTzmZICH8tjhectfg44sG
 Kb2sH
X-Gm-Gg: AR+sD11EhboYaXyqPajA4D03CV9qN86477/egVnI9iQ/bIDHjVqZQctQUlXUvAeG69m
 Z6kZodnjFPDAkxExkqqgsOYsObCrWNBeas1oLYqYzW3UpAWX+I9YkVdleAgPhD9W/Ezhme5rPAa
 N57C9DClRWAvcOxDo5teSzb16QvP6Wi3I18wTniee5l55KDM7wB3fgb0rh29uGXpXWVxAfBKJOa
 PrRrzXATClbMxbIz9nJysmZ6WlyHtPVDZNirx+L9YuM1L09CUnamjZhGiLl6EAMm7psxWdv4if0
 0HvI3K4+ZE3MzDhsLEgVN40nhGoO2hyuYSdUZaMM3Fuh6xGvcxJKt8mSEto8d2ZP0JVgSfd9prG
 4xSt9pvS1H40gM/hGZLEOsmThAqKD6wXwGe5LQVSj6/Zq73uMq3p13GDVDTYtRQiV4kcJ8lKTu6
 +ad3+uRoyutX9mCDehNVKu5WPuAQICmSQhCVeiW5VmAYmzi66cDs4YqYJXBezKJMeqea4=
X-Received: by 2002:a17:90a:e7c3:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-395c37130d0mr6036466a91.12.1787285057907; 
 Thu, 20 Aug 2026 21:04:17 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 09/23] target/riscv: Rewrite vext_ldff
Date: Thu, 20 Aug 2026 21:03:50 -0700
Message-ID: <20260821040404.268123-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Do not call probe_pages for every active element.
We can make do with no more than 2 such calls for
the two pages the insn might reference.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 256 +++++++++++++++++++++----------
 1 file changed, 171 insertions(+), 85 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 36e64465f2..abfd2ec45d 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -748,135 +748,221 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
           uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
           vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
 {
-    uint32_t i, vl = 0;
+    uint32_t i = env->vstart, vl = env->vl;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     uint32_t vma = vext_vma(desc);
-    target_ulong addr, addr_i, offset, remain, page_split, elems;
+    target_ulong addr, last, last_in_page, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
+    bool first_active;
     int flags;
     void *host;
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
 
-    /* Search for the first active element. */
-    if (!vm) {
-        for (i = env->vstart; i < env->vl; ++i) {
+    /* Skip forward to the first active element. */
+    if (vm) {
+        first_active = i == 0;
+    } else if (i == 0 && vext_elem_mask(v0, 0)) {
+        first_active = true;
+    } else {
+        first_active = false;
+        while (1) {
             if (vext_elem_mask(v0, i)) {
                 break;
             }
             if (vma) {
                 vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
             }
+            if (++i == vl) {
+                goto tail;
+            }
         }
-        if (i == env->vl) {
-            goto tail;
-        }
-        env->vstart = i;
     }
-
-    addr = base + ((env->vstart * nf) << log2_esz);
+    addr = base + i * msize;
 
     /* Recognize alignment fault before memory protection fault. */
     vext_test_alignment(env, addr, esz, MMU_DATA_LOAD, mmu_index, ra);
 
+    /* Calculate the page range of first page. */
+    last = base + vl * msize - 1;
+    last_in_page = addr | ~TARGET_PAGE_MASK;
     page_split = -(addr | TARGET_PAGE_MASK);
-    /* Get number of elements */
-    elems = page_split / msize;
-    if (unlikely(env->vstart + elems >= env->vl)) {
-        elems = env->vl - env->vstart;
+
+    /*
+     * If the first element is active, it must succeed.
+     * If it also crosses the page, just go ahead and load it.
+     */
+    if (unlikely(page_split < msize) && first_active) {
+        vext_ldst_nf_tlb(env, vd, addr, 0, nf, esz, max_elems, ldst_tlb, ra);
+        env->vstart = i = 1;
+        addr += msize;
+        page_split = -(addr | TARGET_PAGE_MASK);
+        first_active = false;
     }
 
-    /* Check page permission/pmp/watchpoint/etc. */
-    probe_pages(env, addr, (env->vl - env->vstart) * msize, ra, MMU_DATA_LOAD,
-                mmu_index, &host, &flags, true);
+    /*
+     * Test whether the first page is accessible.
+     * If the first element is active, it must succeed.
+     */
+    flags = probe_access_flags(env, adjust_addr(env, addr),
+                               MIN(last, last_in_page) - addr + 1,
+                               MMU_DATA_LOAD, mmu_index, !first_active,
+                               &host, ra);
 
-    if (flags & ~TLB_WATCHPOINT) {
-        /* probe every access */
-        for (i = env->vstart; i < env->vl; i++) {
-            if (!vm && !vext_elem_mask(v0, i)) {
-                continue;
-            }
-            addr_i = adjust_addr(env, base + i * (nf << log2_esz));
-            if (i == 0) {
-                /* Allow fault on first element. */
-                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD,
-                            mmu_index, &host, NULL, false);
+    /* Get number of complete elements in the first page. */
+    elems = MIN(page_split / msize, vl - i);
+
+    /* Load complete elements from the first page. */
+    if (likely(elems)) {
+        uint32_t page_evl = i + elems;
+
+        if (flags == 0) {
+            if (vm) {
+                vext_page_ldst_us_host(vd, host, i, page_evl, nf, log2_esz,
+                                       max_elems, ldst_host, true);
             } else {
-                remain = nf << log2_esz;
-                while (remain > 0) {
-                    offset = -(addr_i | TARGET_PAGE_MASK);
-
-                    /* Probe nonfault on subsequent elements. */
-                    probe_pages(env, addr_i, offset, 0, MMU_DATA_LOAD,
-                                mmu_index, &host, &flags, true);
-
-                    /*
-                     * Stop if invalid (unmapped) or mmio (transaction may
-                     * fail). Do not stop if watchpoint, as the spec says that
-                     * first-fault should continue to access the same
-                     * elements regardless of any watchpoint.
-                     */
-                    if (flags & ~TLB_WATCHPOINT) {
-                        vl = i;
-                        goto ProbeSuccess;
+                host -= addr - base;
+                do {
+                    if (vext_elem_mask(v0, i)) {
+                        vext_ldst_nf_host(vd, host + i * msize, i, nf, esz,
+                                          max_elems, ldst_host);
+                    } else if (vma) {
+                        vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
                     }
-                    if (remain <= offset) {
-                        break;
+                } while (++i < page_evl);
+            }
+        } else {
+            /*
+             * If the first element is active, it must succeed.
+             * This will load from MMIO or fault from INVALID.
+             */
+            if (first_active) {
+                vext_ldst_nf_tlb(env, vd, addr, 0, nf, esz,
+                                 max_elems, ldst_tlb, ra);
+                i = 1;
+                addr += msize;
+            }
+
+            /* Stop if invalid (unmapped) or mmio (transaction may fail). */
+            if (flags & (TLB_INVALID_MASK | TLB_MMIO)) {
+                env->vl = i;
+                goto tail;
+            }
+
+            /* None of these ldst_tlb calls may fault. */
+            if (vm) {
+                vext_page_ldst_us_tlb(env, vd, addr, i, page_evl, nf,
+                                      log2_esz, max_elems,
+                                      ldst_tlb, mmu_index, ra);
+            } else {
+                do {
+                    if (vext_elem_mask(v0, i)) {
+                        vext_ldst_nf_tlb(env, vd, base + i * msize, i, nf,
+                                         esz, max_elems, ldst_tlb, ra);
+                    } else if (vma) {
+                        vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
                     }
-                    remain -= offset;
-                    addr_i = adjust_addr(env, addr_i + offset);
-                }
+                } while (++i < page_evl);
+            }
+        }
+
+        /* Usually the first page contains the entire vector. */
+        if (likely(page_evl == vl)) {
+            goto tail;
+        }
+        i = page_evl;
+    }
+
+    /* Skip forward to the next active element. */
+    if (!vm) {
+        while (1) {
+            if (vext_elem_mask(v0, i)) {
+                break;
+            }
+            if (vma) {
+                vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
+            }
+            if (++i == vl) {
+                goto tail;
             }
         }
     }
-ProbeSuccess:
-    /* load bytes from guest memory */
-    if (vl != 0) {
-        env->vl = vl;
+
+    addr = base + i * msize;
+    page_split = -(addr | TARGET_PAGE_MASK);
+
+    /* Validate the second page is accessible. */
+    if (unlikely(page_split < msize)) {
+        /*
+         * Cross page element which isn't first.
+         * We have not yet advanced addr to the next page.
+         */
+        target_ulong next_page = addr + page_split;
+        flags |= probe_access_flags(env, adjust_addr(env, next_page),
+                                    last - next_page + 1, MMU_DATA_LOAD,
+                                    mmu_index, true, &host, ra);
+
+        /* Stop if invalid (unmapped) or mmio (transaction may fail). */
+        if (flags & (TLB_INVALID_MASK | TLB_MMIO)) {
+            env->vl = i;
+            goto tail;
+        }
+
+        vext_ldst_nf_tlb(env, vd, addr, i, nf, esz, max_elems, ldst_tlb, ra);
+        if (++i == vl) {
+            goto tail;
+        }
+        addr += msize;
+        if (host) {
+            host += addr - next_page;
+        }
+    } else {
+        flags = probe_access_flags(env, adjust_addr(env, addr),
+                                   last - addr + 1, MMU_DATA_LOAD,
+                                   mmu_index, true, &host, ra);
+
+        /* Stop if invalid (unmapped) or mmio (transaction may fail). */
+        if (flags & (TLB_INVALID_MASK | TLB_MMIO)) {
+            env->vl = i;
+            goto tail;
+        }
     }
 
-    if (env->vstart < env->vl) {
+    /* Load complete elements from the second page. */
+    if (flags == 0) {
         if (vm) {
-            /* Load/store elements in the first page */
-            if (likely(elems)) {
-                vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
-                                  log2_esz, true, mmu_index, ldst_tlb,
-                                  ldst_host, ra);
-            }
-
-            /* Load/store elements in the second page */
-            if (unlikely(env->vstart < env->vl)) {
-                addr = base + env->vstart * msize;
-
-                /* Cross page element */
-                if (unlikely(page_split % msize)) {
-                    vext_ldst_nf_tlb(env, vd, addr, env->vstart, nf,
-                                     esz, max_elems, ldst_tlb, ra);
-                    env->vstart++;
-                    addr += msize;
-                }
-
-                /* Get number of elements of second page */
-                elems = env->vl - env->vstart;
-
-                /* Load/store elements in the second page */
-                vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
-                                  log2_esz, true, mmu_index, ldst_tlb,
-                                  ldst_host, ra);
-            }
+            vext_page_ldst_us_host(vd, host, i, vl, nf, log2_esz,
+                                   max_elems, ldst_host, true);
         } else {
-            for (i = env->vstart; i < env->vl; i++) {
+            host -= addr - base;
+            do {
+                if (vext_elem_mask(v0, i)) {
+                    vext_ldst_nf_host(vd, host + i * msize, i, nf, esz,
+                                      max_elems, ldst_host);
+                } else if (vma) {
+                    vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
+                }
+            } while (++i < vl);
+        }
+    } else {
+        /* None of these ldst_tlb calls may fault. */
+        if (vm) {
+            vext_page_ldst_us_tlb(env, vd, addr, i, vl, nf,
+                                  log2_esz, max_elems,
+                                  ldst_tlb, mmu_index, ra);
+        } else {
+            do {
                 if (vext_elem_mask(v0, i)) {
                     vext_ldst_nf_tlb(env, vd, base + i * msize, i, nf,
                                      esz, max_elems, ldst_tlb, ra);
                 } else if (vma) {
                     vext_set_nf_elems_1s(vd, i, nf, esz, max_elems);
                 }
-            }
+            } while (++i < vl);
         }
     }
 
-- 
2.43.0



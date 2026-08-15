Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB6FC5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKr-0007UE-6f; Sat, 15 Aug 2026 15:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKZ-0007J1-Ov
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKX-0008IE-J9
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so20692695ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823167; x=1787427967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=igBGUbI9Br7/yOtZA1N4yUxnnhsC2oSUup6hyiOZht8=;
 b=urzUJyYaPFSczIbSa/HZLkv49bsag/CVepml2lD2R4fGaDvJZcu3nkvbUG8JLCSUr6
 czjVlF+znvvrrGB89KHxgks3llCK9uy7hOiXHYhvFHe/PmllOsfzFkpExqRBwahj8KX7
 QkdbYqbxKW9/ptKZXGZhdvm5gPKOoDKbzHuRDCXWFFBBKvPuftsiHHCkfOBLzU5IkAD2
 iYLXjE3BddI2CMoxQhvM1JcRMFIkjzsqlp2cH4TZE+B+rigIcYY+umTQUOPHB/cV5mEN
 hXEFXZE0NK0tLe/gKXfS6URCVww2kJGo8pOb4dHBqnyMfaLWMsS2S4e3bEyFdJIQkejL
 VnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823167; x=1787427967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=igBGUbI9Br7/yOtZA1N4yUxnnhsC2oSUup6hyiOZht8=;
 b=h9gnguVfa/bVXglrRcMiLYuNb1lA79cfWLFgJvkC7ieOxP1/aFx1/0Ho6sTESktCpg
 lGsLdRNZCeHoP+wGyjW6LNRWqDz6jIzecfR821VcRsxTnqmVMWbOfIp7AgrMEFSY+YgX
 xUAX1qJlcGmvG6kobEtouTqojA32Fv9BAwtQ/ofascctcp6mc9xZSDDB23OZ0sQUJhH6
 ifqDA1Oe/t/VLtGmqIq5w3ULnWVRVOy+wul/JIW7ZggFYIPKIFxyRtuXB/hEUKK8WR5e
 jtMux5ZVTrnqXKH5ws07/z0hs5bdzdwGbit37mHmcsZ+139Fj4mvULQ3yOtFjky2cdx+
 Fyvw==
X-Gm-Message-State: AOJu0Yx03xFyEMvh3WLyW7bSYL5MLqtwjSei4TLOR6xIoVfp98YWjm8M
 Zc4L6KYZ0Bh6oyo6lR1CnLW8/ZU4xSi7l3MB2Qv7KbPm9XfAkywrMRuquWiNkCzSGW2ka86Ahwk
 agqkA
X-Gm-Gg: AR+sD1138JE/VUiQLJ903kfCPvSpCSYyHqwuvCZrIPR6PW8KiBEbX233gTs2ulSt7D/
 GZYiMQ6sgDjJ5GJep24px9eVkIoMDIkK1BHLfrfxXJL9yAfRzDYXB8RjqbuOQj5GbofAU64/3my
 LfC+87qsyu0sj6AK7D2scdAVKknRbj1mWSAFAN4RjKcASHFRB90KOKbE1+KPC8kXHdstSAfhTlh
 sE75S552IFJlEkPZpn3WAsuuau+ypVJeIFqqwjr+ya/tYywSa2Sj8ilsqHxuYRzZdYHQoDG5Z3y
 KBJ9NJVmPUbXnHcJEb2FwdypdBUvCjC24xze4TmwME2tFd6UU96tyH/B820S6+l3rmaoyg7zEts
 XYR0jVftWqr/UGFnrkYgkfSgzEO3HWwP0zWEVSJDjnJjtwv638GSkJ445JK9iAaLqzVV9cyE2IH
 D3Jlrea7aglc/HlA2Xvk0xi+Mi4sigwvDNCegoZLQqae3QaLNI28gQhMaWzyNJoDMUBubK3WBvT
 uNyqNNxfdTxV1t0x8e9
X-Received: by 2002:a17:903:3c6b:b0:2ca:ed57:8586 with SMTP id
 d9443c01a7336-2d3b0da5dc0mr166165965ad.23.1786823167045; 
 Sat, 15 Aug 2026 12:46:07 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 08/23] target/riscv: Move misalignment check out of
 vext_page_ldst_us
Date: Sat, 15 Aug 2026 12:45:33 -0700
Message-ID: <20260815194549.1377505-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index 79c1d77a14..12ef020840 100644
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
@@ -425,16 +428,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
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
             ldst_host(vd, host, env->vstart, evl);
         } else {
@@ -453,6 +447,20 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
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
@@ -466,16 +474,21 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
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
@@ -489,7 +502,6 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
 #endif
 
     /* Calculate the page range of first page */
-    addr = base + ((env->vstart * nf) << log2_esz);
     page_split = -(addr | TARGET_PAGE_MASK);
     /* Get number of elements */
     elems = page_split / msize;
@@ -723,7 +735,27 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
 
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
@@ -821,6 +853,7 @@ ProbeSuccess:
         }
     }
 
+ tail:
     env->vstart = 0;
     if (vma) {
         vext_set_tail_elems_1s(env->vl, vd, nf, esz, max_elems);
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



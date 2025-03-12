Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEE2C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRf2-0008MR-JG; Wed, 12 Mar 2025 15:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tsRev-0008Kl-13
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:22:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tsReo-0002VI-NR
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:22:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912c09be7dso131426f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1741807340; x=1742412140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0YnjXDNpttgXUs2gL4RwCNxe64IM7pUjPhQO2nAK70=;
 b=cpu/j0nB/JwosHUMfuQc1yvl6f0BKU6RS/3Z7jxglOv4LtTGCAcxBmtgFomHemNZ9C
 rQDykJvFffCV6BnB+4VhE049qaCuaBXVwgTC/alinEhlP7blSnd7J338Ix6QFc2t9UEr
 ud/3heNtd2QybMfIE4G7IVbtzdV7aHorFTRRm7zfV6roRXA5ROJ/8OUIrrUbSzBiqLCo
 6Vel8RoZy4y25f9H/R1LpvH29YYUXGmfUjv5RV2KfL63oKgPrfxeT1jqg2S3nW2Gi8nJ
 5dAK84oX1JBs4HH9Dc9gScGvKcPXUECDlPoF4V0j9OvDHx/sJquqTSUwpN/F8Ka1zoRq
 Acag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741807340; x=1742412140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0YnjXDNpttgXUs2gL4RwCNxe64IM7pUjPhQO2nAK70=;
 b=gtZ2ELhWEn/BtI/Abco/A5okUBUgimqZxN2tS7Qff0q/KLnb7cWIfRZ+UR4eOhRF4S
 jkMYx/ixPIRf/f5/5Fi2DDLrszPiayzKHXCJsoasKnGVWZztpw3JzuBiM9oeGPl/BO5f
 7TMA15LcnihcJavTdDHK/LyNCu2nXuCKIOwBIEqjdAfJ5NYPV36uq+pXh2NRbtIOMr1D
 35h1QqsuR4G0/hkPJc3bmGLY1o/kCb0lc6+GOYgwdtwEdXU5iV43yU2r09FmHics5LIK
 qXZVxybn7AqDd++a+s0W7TaIXuBCMb1F0uYVfEIIPi4uVGBWrWYRWl2t4PNOlZ98LKHv
 svjg==
X-Gm-Message-State: AOJu0YzvI27jkkZi427Rp+QjBk8QwPfl8D8GVkCUwVB+ks4Fnfbr+RYh
 YBTxJyjrrPv2adZAetN2sOEQj17BOnk/DWyvC4Z21w0r2/graPo5sVYzY3c9CxBCOalkvq/k+yz
 YWmVErw==
X-Gm-Gg: ASbGncunht4QtRchQo25YqHa63SJNAsCmkozn9DyOur24oJ9fHgiiGyiyJG/81nSvbu
 69Q6VkMaU0eGFs0yUjfiehmXzyh+12rz6uewZ0dgC2F71o7iaSQ7vrWzYAdMjVYsDya+u5C8+KT
 KizV4zPheSojhPhBe8LxVIJOGmEN/Jeb8l3av3bDKCzGg81kcW4F+4GlOmDA5x0MRRbGEoaiWxz
 ScQc2lwq2YTA075uxehpU4C7McjvwoEbNUcRPkWgKx3hoEdu1FD1kAePFnKOutN3fIFpZbh0yvu
 wsWmvXcIf9RCJgw2pHL0W962OSfZPLCEJJHVSdn+ng1sVGWJDJU8u9k+YyTRVL4NCK/z4cJLvA=
 =
X-Google-Smtp-Source: AGHT+IH2Y1pDXhX+0QKx5aj3OgsAcBUzqCNRyMk2nedCzdNFbooTYUl9RLgKLTt49VSteWIDuOWT4g==
X-Received: by 2002:a05:6000:1a86:b0:38d:e48b:1787 with SMTP id
 ffacd0b85a97d-39132d1d1efmr19223162f8f.14.1741807339630; 
 Wed, 12 Mar 2025 12:22:19 -0700 (PDT)
Received: from paolo-laptop-amd.. ([2a0e:cb01:d3:f100:3f9b:7278:8381:286b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba686sm22331645f8f.19.2025.03.12.12.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 12:22:19 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>
Subject: [PATCH 1/1 v3] target/riscv: optimize the memory probing for vector
 fault-only-first loads.
Date: Wed, 12 Mar 2025 19:22:15 +0000
Message-ID: <20250312192215.318565-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312192215.318565-1-paolo.savini@embecosm.com>
References: <20250312192215.318565-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Fault-only-first loads in the RISC-V vector extension need to update
the vl with the element index that causes an exception.
In order to ensure this the emulation of this instruction used to probe the
memory covered by the load operation with a loop that iterated over each element
so that when a flag was raised it was possible to set the vl to the
corresponding element index.
This loop was executed every time whether an exception happened or not.

This commit removes the per element memory probing from the main execution path
and adds a broad memory probing first. If this probing raises any flag that is
not a watchpoint flag (that per standard is allowed by this instruction) we
proceed with the per element probing to find the index of the element causing
the exception and set vl to such index.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 103 ++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7773df6a7c..71b823d5d4 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -633,47 +633,69 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     uint32_t vma = vext_vma(desc);
-    target_ulong addr, offset, remain, page_split, elems;
+    target_ulong addr, addr_probe, addr_i, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
+    int flags;
+    void *host;
 
     VSTART_CHECK_EARLY_EXIT(env);
 
-    /* probe every access */
-    for (i = env->vstart; i < env->vl; i++) {
-        if (!vm && !vext_elem_mask(v0, i)) {
-            continue;
-        }
-        addr = adjust_addr(env, base + i * (nf << log2_esz));
-        if (i == 0) {
-            /* Allow fault on first element. */
-            probe_pages(env, addr, nf << log2_esz, ra, MMU_DATA_LOAD);
-        } else {
-            remain = nf << log2_esz;
-            while (remain > 0) {
-                void *host;
-                int flags;
-
-                offset = -(addr | TARGET_PAGE_MASK);
-
-                /* Probe nonfault on subsequent elements. */
-                flags = probe_access_flags(env, addr, offset, MMU_DATA_LOAD,
-                                           mmu_index, true, &host, 0);
-
-                /*
-                 * Stop if invalid (unmapped) or mmio (transaction may fail).
-                 * Do not stop if watchpoint, as the spec says that
-                 * first-fault should continue to access the same
-                 * elements regardless of any watchpoint.
-                 */
-                if (flags & ~TLB_WATCHPOINT) {
-                    vl = i;
-                    goto ProbeSuccess;
-                }
-                if (remain <= offset) {
-                    break;
+    addr = base + ((env->vstart * nf) << log2_esz);
+    page_split = -(addr | TARGET_PAGE_MASK);
+    /* Get number of elements */
+    elems = page_split / msize;
+    if (unlikely(env->vstart + elems >= env->vl)) {
+        elems = env->vl - env->vstart;
+    }
+
+    /* Check page permission/pmp/watchpoint/etc. */
+    flags = probe_access_flags(env, adjust_addr(env, addr), elems * msize,
+                               MMU_DATA_LOAD, mmu_index, true, &host, ra);
+
+    /* If we are crossing a page check also the second page. */
+    if (env->vl > elems) {
+        addr_probe = addr + (elems << log2_esz);
+        flags |= probe_access_flags(env, adjust_addr(env, addr_probe),
+                                    elems * msize, MMU_DATA_LOAD, mmu_index,
+                                    true, &host, ra);
+    }
+
+    if (flags & ~TLB_WATCHPOINT) {
+        /* probe every access */
+        for (i = env->vstart; i < env->vl; i++) {
+            if (!vm && !vext_elem_mask(v0, i)) {
+                continue;
+            }
+            addr_i = adjust_addr(env, base + i * (nf << log2_esz));
+            if (i == 0) {
+                /* Allow fault on first element. */
+                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD);
+            } else {
+                remain = nf << log2_esz;
+                while (remain > 0) {
+                    offset = -(addr_i | TARGET_PAGE_MASK);
+
+                    /* Probe nonfault on subsequent elements. */
+                    flags = probe_access_flags(env, addr_i, offset,
+                                               MMU_DATA_LOAD, mmu_index, true,
+                                               &host, 0);
+
+                    /*
+                     * Stop if invalid (unmapped) or mmio (transaction may
+                     * fail). Do not stop if watchpoint, as the spec says that
+                     * first-fault should continue to access the same
+                     * elements regardless of any watchpoint.
+                     */
+                    if (flags & ~TLB_WATCHPOINT) {
+                        vl = i;
+                        goto ProbeSuccess;
+                    }
+                    if (remain <= offset) {
+                        break;
+                    }
+                    remain -= offset;
+                    addr_i = adjust_addr(env, addr_i + offset);
                 }
-                remain -= offset;
-                addr = adjust_addr(env, addr + offset);
             }
         }
     }
@@ -685,15 +707,6 @@ ProbeSuccess:
 
     if (env->vstart < env->vl) {
         if (vm) {
-            /* Calculate the page range of first page */
-            addr = base + ((env->vstart * nf) << log2_esz);
-            page_split = -(addr | TARGET_PAGE_MASK);
-            /* Get number of elements */
-            elems = page_split / msize;
-            if (unlikely(env->vstart + elems >= env->vl)) {
-                elems = env->vl - env->vstart;
-            }
-
             /* Load/store elements in the first page */
             if (likely(elems)) {
                 vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
-- 
2.34.1



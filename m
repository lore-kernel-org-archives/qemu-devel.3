Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0006FC5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKm-0007OC-4Q; Sat, 15 Aug 2026 15:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKc-0007JG-WA
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKb-0008J6-53
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso39477365ad.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823170; x=1787427970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GMRQ7YEyei+qjQhGFj1uUysjBQ7VBvuvI2+o6V/d73c=;
 b=ORGuE/uOz4V6/NSBgarQfy+okIkapNV7bgrXr7MNfU+rDyK9o4Bz5z/C1R+iOGmRny
 cePBShvx5lzdOgKN+fJt0mPqRpU4CUTWbQr/2hN9+89JigP8+JTr+jdT5oZyzbd9bTGh
 aXyfwH16Qy6+wlXh6e/ubB7QChKu893ixEJGt9z7LbYFwMNtgeZ+WdwLh/xueqMSdiOv
 MmeEfvBmowl+e7zquGrEAG6kABmV0GM2T/xA6VBMLWTqcutpu7R/e2eBVqBRj2d0vbgl
 gIzwNJ/w5qjoyQeRKiM13pgnewRTT/UzNiLIpYjp2A0cBTx1M8uRVGN4dsLA6zXdKGvn
 ZOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823170; x=1787427970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GMRQ7YEyei+qjQhGFj1uUysjBQ7VBvuvI2+o6V/d73c=;
 b=KcodtsA2d0PjmLbSjTjUOnbYTdjI5oVNP3d9qM1OH5qNKcf9FGGBekMtcQONQi/NoH
 +2pfHMW4jqqz1WHCxWJw7C+30UEl1TCXSujcioR1z4f2KaOGCIzqMbUOc7SDOTWtl/cg
 FNz0LwTAfBeZXh2pZapcSmOCsj9mz1qQXKZWLB0hLib0fbBk3Mmwz2VcBXc8Xf8ZrmbB
 mx/VXF8OIvGDdR0HOTlOFzKC6pTIeY2cJ1TlWb4r9BPYVOuXdx0tyPYm7mHX2wAQ0kBj
 7EwvjE+jEeo8/E9/DNR2h+gjG2Msh/2PcAeaf6/XxEOvTUGfcC1OXBdmBhYCiSnrI6F/
 6ZAg==
X-Gm-Message-State: AOJu0YyXKIWzXpep0knK551GENbAu4pn5UvtIoo7FY1CMevv6RvlWOhz
 XIO18hlQL6bmH2lOk4JjIxf87/tYSYzxljlP+CC43EH9HEerUAj2jr91IOE5wdr3ZinFwPO6CwS
 gqhK6
X-Gm-Gg: AR+sD11fAwiDcuvRWr8FeyJ/1ZGH7klwdt9CzF8bv+PEB4QeOpOq2HW3mA0ZAA49/IN
 2okh3zFJ1yddAeULbk3rjLPnW3L0tIGVoZYW2v0cc/p8IIwYVFllyLf9GSp+6bgovQpGayvLVbN
 K7lWlcmdPbYw/lfHGCbIrV4vByITQFbKup03GP1e9YWOiTlEAzinvhGFAH615BQkJkOsfmLoY1Y
 yWi4dbzhyJMH6tMTWNkUBOliLz42rzK7AD7oc36HsN9liV8cz3YU8jqYoGUtJs/crfj2JmzC75h
 MbLyzfnfUXsRZjHDOvJsmD4LHV2EBM5PE0p1c079xWwoqiSUD7uZ7vfTII/Y4O+frtMXQ/zUdXd
 cXI0HBcTkELSk9p2GrfsVopZ0zGf66Lql/P2Vw63JY2a987BJFws3rwYCZ1u9q7qM+xgU411RDi
 ED4lAM233YWOnwd6d1yNerSdBohRcffCi1cyyItHf83VXH+tOYmTzD5nF2a7IB7hf5ABzExvliT
 tUERreMYKclZkDb768k
X-Received: by 2002:a17:903:3c6b:b0:2d2:cb45:35ac with SMTP id
 d9443c01a7336-2d3b0037d06mr117765765ad.18.1786823170299; 
 Sat, 15 Aug 2026 12:46:10 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 10/23] target/riscv: Rewrite vext_ldst_us
Date: Sat, 15 Aug 2026 12:45:35 -0700
Message-ID: <20260815194549.1377505-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

We already computed the page split here, which means we
were quite ready to call probe_access directly.  Do so,
then use vext_ldst_nf_{host,tlb} to load the elements.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 92 ++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 7f721dc24d..5b03e23fc3 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -483,7 +483,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
              vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz,
              uint32_t evl, uintptr_t ra, bool is_load)
 {
-    target_ulong page_split, elems, addr;
+    target_ulong elems, addr, last, last_in_page, page_split;
     uint32_t nf = vext_nf(desc);
     uint32_t vma = vext_vma(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
@@ -491,10 +491,12 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t msize = nf * esz;
     int mmu_index = riscv_env_mmu_index(env, false);
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
+    uint32_t i = env->vstart;
+    void *host;
 
     VSTART_CHECK_EARLY_EXIT(env, evl);
 
-    addr = base + env->vstart * msize;
+    addr = base + i * msize;
 
     /* Recognize alignment fault before memory protection fault. */
     vext_test_alignment(env, addr, esz, access_type, mmu_index, ra);
@@ -505,52 +507,72 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
      * by simply calling ldst_tlb.
      */
     if (nf == 1 && (evl << log2_esz) <= 6) {
-        for (uint32_t i = env->vstart; i < evl;
-             env->vstart = ++i, addr += esz) {
+        for (; i < evl; env->vstart = ++i, addr += esz) {
             ldst_tlb(env, adjust_addr(env, addr), i, vd, ra);
         }
-        env->vstart = 0;
-        if (vma) {
-            vext_set_tail_elems_1s(evl, vd, nf, esz, max_elems);
-        }
-        return;
+        goto tail;
     }
 #endif
 
-    /* Calculate the page range of first page */
-    page_split = -(addr | TARGET_PAGE_MASK);
-    /* Get number of elements */
-    elems = page_split / msize;
-    if (unlikely(env->vstart + elems >= evl)) {
-        elems = evl - env->vstart;
-    }
+    /* Calculate the page range of first page. */
+    last = base + evl * msize - 1;
+    last_in_page = addr | ~TARGET_PAGE_MASK;
+    page_split = last_in_page - addr;
+
+    /* Validate the first page is accessible. */
+    host = probe_access(env, adjust_addr(env, addr),
+                        MIN(last, last_in_page) - addr + 1,
+                        access_type, mmu_index, ra);
+
+    /* Get number of complete elements in the first page. */
+    elems = MIN(page_split / msize, evl - i);
 
     /* Load/store elements in the first page */
     if (likely(elems)) {
-        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,
-                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
-    }
+        uint32_t page_evl = i + elems;
 
-    /* Load/store elements in the second page */
-    if (unlikely(env->vstart < evl)) {
-        addr = base + env->vstart * msize;
-
-        /* Cross page element */
-        if (unlikely(page_split % msize)) {
-            vext_ldst_nf_tlb(env, vd, addr, env->vstart,
-                             nf, esz, max_elems, ldst_tlb, ra);
-            env->vstart++;
-            addr += msize;
+        if (host) {
+            vext_page_ldst_us_host(vd, host, i, page_evl, nf,
+                                   log2_esz, max_elems, ldst_host);
+        } else {
+            vext_page_ldst_us_tlb(env, vd, addr, i, page_evl, nf,
+                                  log2_esz, max_elems,
+                                  ldst_tlb, mmu_index, ra);
         }
 
-        /* Get number of elements of second page */
-        elems = evl - env->vstart;
-
-        /* Load/store elements in the second page */
-        vext_page_ldst_us(env, vd, addr, elems, nf, max_elems, log2_esz,
-                          is_load, mmu_index, ldst_tlb, ldst_host, ra);
+        /* Usually the first page contains the entire vector. */
+        if (likely(page_evl == evl)) {
+            goto tail;
+        }
+        env->vstart = i = page_evl;
+        addr += elems * msize;
     }
 
+    /* Cross page element */
+    if (unlikely(page_split % msize)) {
+        vext_ldst_nf_tlb(env, vd, addr, i++, nf, esz, max_elems, ldst_tlb, ra);
+        if (i == evl) {
+            goto tail;
+        }
+        env->vstart = i;
+        addr += msize;
+    }
+
+    /* Validate the second page is accessible. */
+    assert(i < evl);
+    elems = evl - i;
+    host = probe_access(env, adjust_addr(env, addr), elems * msize,
+                        access_type, mmu_index, ra);
+
+    if (host) {
+        vext_page_ldst_us_host(vd, host, i, evl, nf,
+                               log2_esz, max_elems, ldst_host);
+    } else {
+        vext_page_ldst_us_tlb(env, vd, addr, i, evl, nf, log2_esz, max_elems,
+                              ldst_tlb, mmu_index, ra);
+    }
+
+ tail:
     env->vstart = 0;
     if (vma) {
         vext_set_tail_elems_1s(evl, vd, nf, esz, max_elems);
-- 
2.43.0



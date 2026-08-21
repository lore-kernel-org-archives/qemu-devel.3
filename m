Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465BCC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGUT-00067Q-JU; Fri, 21 Aug 2026 00:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUR-00065A-28
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:23 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUP-0003Cz-56
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:22 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so1179337a91.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285060; x=1787889860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zakSNcKNR+QZBPobFR1l5c+AA7ezfGojoAb40bpT830=;
 b=lmpv914v6z0oLWBs6VX7NteSitlUk/jJgv8kPWMox1PjGNB+kddAcKdkwGS/8J7vl4
 jKfqZ7nWvdKsIjH4KVkPn4i3QKqaK72QmsbNzrEkBbszeQfGg9U19fnu62H64Mw7+RD9
 sRq4q99Sxqdt4i/hsnCurGT0wXbU1kPkc/hDLOirHDaPIqyXYFIzvApyZa8TwtVPJtjk
 ylZW6lJ1CLd0TOmGs4aEpReo1wBj52L/QexM+sUBJngfgW9rwoDFvdDWdoAKq1mkAPr8
 tnMemV6f11G4Wh9KLyQ0Mx2VOyZmZ8rfAc4c7iKT22UKTxowQU1rEIgcK0upgJmwC8Pu
 5JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285060; x=1787889860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zakSNcKNR+QZBPobFR1l5c+AA7ezfGojoAb40bpT830=;
 b=EggMqOhCSpkq3qr5aZ28NruT4b/m+9Wv04P4HYgYVWOZHW8Sv2BA8NI3QrEb830IA1
 3nClQXbCZxjmhNC72Y/6txbkoO+vvjKN3zcs4pvwYld96/JkvCjUBsmNYatUeT9sFd2J
 YjdS1Mi9Cilik9M4P4BRRMaNdIal3XghjD4NK/LyL9QxV/eE1njwTVBa2v+RGv4Yp+wu
 wk5SMcwOkbDq41GIGIXNr0wfQRjXM94GhKf9iykBqTwRe//QA311gs3Pi8HOKtzG2jP2
 WfvFSV6BzuakRydwsrHhXuMlyPTjdmvLsOFvc0QNs5Dm3w30yEqRpnTpAsPCB3Uyr9I6
 9vTA==
X-Gm-Message-State: AFuF++meChHNEz5JEDWCIaBRNJpqUtb//CyEiCX2TbAjAqfbZef2sGCV
 PNZbKPgv/PcVAf2is32YR63U7CO2R6M8qpOVXtpDqVczaE3+czNVl7M+UzbPw9mj7rtLrduLdzY
 dJX5m
X-Gm-Gg: AR+sD12suwDV6oEEmnCgSBbqfumuUINo8BfzHPHLtuVB0xQ6Y4WQVh1spXBDvrhgVe/
 Mg15KgUXiPOWfGm5GSoVAjmAv9uoJA/Vav+YxvAjROAHAvfEIAOvyQpmkjHiUfykiWzl1KK2EQW
 Mceirfec4CgYrwKeRO1k6dYKsdH+7hS4RqB99XhcFW5S+HezBuFNCYHDTF3UFECIscUB96uf2bJ
 asOtrIqMOLjLIIikcHggcuOghFFck3K+AbpKS7fgwwufvENUvUezdbWn/LREe85mKIX0sPP1tn6
 kOB7aexzJC8ew9iOPI4ndVZwGOrZtkn0fr0IQTHBPZm3sljL88/JrTuW+cTgA3FliIttjJlG8Cq
 6b2cSDilpzdqwoTBDlyWvQ278FeCE8gu73xZvDRdNo7WqkCk5jea/8jbCX4XFcm6XOsH7ssEszy
 nMeZWQDL91kKc0nxPLtLxlcFhePraYREp5+f++7yJPxpgr7QDir1t66niDl02RZSUQI/78
X-Received: by 2002:a17:90b:2e4b:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-395c514b5cbmr2741953a91.10.1787285059543; 
 Thu, 20 Aug 2026 21:04:19 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH v2 11/23] target/riscv: Use vext_ldst_us_notail in
 vext_ldst_whole
Date: Thu, 20 Aug 2026 21:03:52 -0700
Message-ID: <20260821040404.268123-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
 target/riscv/tcg/vector_helper.c | 119 +------------------------------
 1 file changed, 3 insertions(+), 116 deletions(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 76f3babed6..76990894e5 100644
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
@@ -430,33 +386,6 @@ vext_page_ldst_us_tlb(CPURISCVState *env, void *vd, target_ulong addr,
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
-        vext_page_ldst_us_host(vd, host, i, i + elems, nf, log2_esz,
-                               max_elems, ldst_host, is_load);
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
@@ -1015,52 +944,10 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
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
-
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
+    uint32_t evl = (riscv_cpu_cfg(env)->vlenb * vext_nf(desc)) >> log2_esz;
 
+    vext_ldst_us_notail(vd, base, env, log2_esz, 1, evl, evl, false,
+                        ldst_tlb, ldst_host, ra, is_load);
     env->vstart = 0;
 }
 
-- 
2.43.0



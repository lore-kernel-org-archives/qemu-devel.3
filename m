Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3771CCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu97-0004v5-8M; Tue, 12 May 2026 16:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu93-0004lK-S9; Tue, 12 May 2026 16:56:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu90-00039A-FS; Tue, 12 May 2026 16:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619274; bh=LToFnHP4IGVx7WGv/Q89mzg69hdbQi83BH1usxyH5/I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sdTO6ZX2+ANcDISMBjzxEfupkDKRmqbzHhOdNKpkmvfzWm4w9sOq/ISp+BTftm4NU
 /i8Ai6RJ+85IpvP+PB5RpN/qvmMmRKubagdGlT5gLu0/krIS31dnAvqr4xri903lEj
 MN7vnxEDQ3aBOEQ7/UwQxNl2zAs0y/EjgKpqSq7qDIi+nIrOlaxUq0/6LZoa8m/DQH
 ydx92KmBXzPqSvchT2uSp8zRs1dUzNuM2NK/1ofmZUXA+60w10A57EssR+YNH3VTNU
 uPp4ng2fa0JU4OO+vdAKbeUoZvQEcLb0EAeOUeBScBSsKWFTpURQ5dhW2a8IOVgN7f
 zr6z9acxLcRXA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 55FFD1AA2DB;
 Tue, 12 May 2026 23:54:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 610B63ABC4C;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Savini <paolo.savini@embecosm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 015/107] Expand the probe_pages helper function to
 handle probe flags.
Date: Tue, 12 May 2026 23:53:02 +0300
Message-ID: <20260512205437.360850-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Paolo Savini <paolo.savini@embecosm.com>

This commit expands the probe_pages helper function in
target/riscv/vector_helper.c to handle also the cases in which we need access to
the flags raised while probing the memory and the host address.
This is done in order to provide a unified interface to probe_access and
probe_access_flags.
The new version of probe_pages can now act as a regular call to probe_access as
before and as a call to probe_access_flags. In the latter case the user need to
pass pointers to flags and host address and a boolean value for nonfault.
The flags and host address will be set and made available as for a direct call
to probe_access_flags.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250313123926.374878-2-paolo.savini@embecosm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit d887736225984fcb3926e3f32f3cdc332c03ba8f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 559c660566..73ec650c32 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -114,25 +114,42 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
  * It will trigger an exception if there is no mapping in TLB
  * and page table walk can't fill the TLB entry. Then the guest
  * software can return here after process the exception or never return.
+ *
+ * This function can also be used when direct access to probe_access_flags is
+ * needed in order to access the flags. If a pointer to a flags operand is
+ * provided the function will call probe_access_flags instead, use nonfault
+ * and update host and flags.
  */
-static void probe_pages(CPURISCVState *env, target_ulong addr,
-                        target_ulong len, uintptr_t ra,
-                        MMUAccessType access_type)
+static void probe_pages(CPURISCVState *env, target_ulong addr, target_ulong len,
+                        uintptr_t ra, MMUAccessType access_type, int mmu_index,
+                        void **host, int *flags, bool nonfault)
 {
     target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
     target_ulong curlen = MIN(pagelen, len);
-    int mmu_index = riscv_env_mmu_index(env, false);
 
-    probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                 mmu_index, ra);
+    if (flags != NULL) {
+        *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
+                                    access_type, mmu_index, nonfault, host, ra);
+    } else {
+        probe_access(env, adjust_addr(env, addr), curlen, access_type,
+                     mmu_index, ra);
+    }
+
     if (len > curlen) {
         addr += curlen;
         curlen = len - curlen;
-        probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                     mmu_index, ra);
+        if (flags != NULL) {
+            *flags = probe_access_flags(env, adjust_addr(env, addr), curlen,
+                                        access_type, mmu_index, nonfault,
+                                        host, ra);
+        } else {
+            probe_access(env, adjust_addr(env, addr), curlen, access_type,
+                         mmu_index, ra);
+        }
     }
 }
 
+
 static inline void vext_set_elem_mask(void *v0, int index,
                                       uint8_t value)
 {
@@ -332,8 +349,8 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     MMUAccessType access_type = is_load ? MMU_DATA_LOAD : MMU_DATA_STORE;
 
     /* Check page permission/pmp/watchpoint/etc. */
-    flags = probe_access_flags(env, adjust_addr(env, addr), size, access_type,
-                               mmu_index, true, &host, ra);
+    probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &flags,
+                true);
 
     if (flags == 0) {
         if (nf == 1) {
@@ -632,7 +649,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t vma = vext_vma(desc);
     target_ulong addr, addr_probe, addr_i, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
-    int flags;
+    int flags, probe_flags;
     void *host;
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
@@ -646,15 +663,15 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     }
 
     /* Check page permission/pmp/watchpoint/etc. */
-    flags = probe_access_flags(env, adjust_addr(env, addr), elems * msize,
-                               MMU_DATA_LOAD, mmu_index, true, &host, ra);
+    probe_pages(env, addr, elems * msize, ra, MMU_DATA_LOAD, mmu_index, &host,
+                &flags, true);
 
     /* If we are crossing a page check also the second page. */
     if (env->vl > elems) {
         addr_probe = addr + (elems << log2_esz);
-        flags |= probe_access_flags(env, adjust_addr(env, addr_probe),
-                                    elems * msize, MMU_DATA_LOAD, mmu_index,
-                                    true, &host, ra);
+        probe_pages(env, addr_probe, elems * msize, ra, MMU_DATA_LOAD,
+                    mmu_index, &host, &probe_flags, true);
+        flags |= probe_flags;
     }
 
     if (flags & ~TLB_WATCHPOINT) {
@@ -666,16 +683,16 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
             addr_i = adjust_addr(env, base + i * (nf << log2_esz));
             if (i == 0) {
                 /* Allow fault on first element. */
-                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD);
+                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LOAD,
+                            mmu_index, &host, NULL, false);
             } else {
                 remain = nf << log2_esz;
                 while (remain > 0) {
                     offset = -(addr_i | TARGET_PAGE_MASK);
 
                     /* Probe nonfault on subsequent elements. */
-                    flags = probe_access_flags(env, addr_i, offset,
-                                               MMU_DATA_LOAD, mmu_index, true,
-                                               &host, 0);
+                    probe_pages(env, addr_i, offset, 0, MMU_DATA_LOAD,
+                                mmu_index, &host, &flags, true);
 
                     /*
                      * Stop if invalid (unmapped) or mmio (transaction may
-- 
2.47.3



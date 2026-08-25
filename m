Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD0FC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp80-0003Gq-RK; Tue, 25 Aug 2026 07:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7w-0002y9-Fq; Tue, 25 Aug 2026 07:15:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp7u-0000ek-DV; Tue, 25 Aug 2026 07:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=N/ExKRInfzeAOKkR7Ewp1aPGREzUzH8K1NQMEMsBBhw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aRqosoCbzsVEO4gaKBpDxcK3TKkszIt3RJPHXESLqZpAeCvFN4W7rQSUSq2FDkj40
 H2R9InQKVftDMIUfqmgZyEeVAQ6hs9TQ/Na3GmznGNpqk1V1lUltiEwDH0Zs9cKQb8
 5jJbPzAYMKK8Bw/cSrmxlpfofnL5BPJoXF7SSeDznLbIiNHaGG+P0jxVhhQ0dyfJSx
 Io6OgZAOtujB3XNMkHnew8SCPxRYAjpjAm1lhK43huo+TZ3+nAMLWWnqSio/9snRvw
 ATAFsyjOOiBYJIsp4xstSPbLBklgL7vJS/+ehGYUhb+/gokJlqdXmiiGJH4uuNo2b/
 D/U2VAc7ulQOQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 745D71CE4BA;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8C58A416286;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A78AF325B7; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 158/166] hw/riscv/riscv-iommu: preserve requested
 perm in spa_fetch()
Date: Tue, 25 Aug 2026 14:11:54 +0300
Message-ID: <20260825111206.482723-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
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

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

b18e3f0e2d0f fixed spa_fetch() faults whose TTYP used the leaf PTE
permission instead of the original request permission.  However, it kept
that request-narrowed value in iotlb->perm after a successful walk, and
riscv_iommu_translate() caches iotlb->perm for later accesses to the same
IOVA.

That means a write to an RW mapping can cache the entry as write-only.
A later read then hits the cache and faults even though the mapping allows
it, which showed up in NVMe testing as bogus completions and controller
timeouts.

Keep the requested permission in a separate req_perm and use it for all
permission checks and fault-type decisions.  Accumulate the leaf
permissions separately and copy them to iotlb->perm only after the full
walk succeeds, so cached entries describe the mapping rather than the
current request.  Since faults leave iotlb->perm as the original request,
the S-stage and G-stage TTYP fixes remain intact.

Fixes: b18e3f0e2d0f ("hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults")
Fixes: 12422e1f4493 in 10.0.x
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260717144525.1154204-1-andrew.jones@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit aa51eec004461f671f878145d3fc921c6cabee48)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 97796a414ff..715e5d760b4 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -278,7 +278,7 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUTLBEntry *iotlb)
 {
-    IOMMUAccessFlags pte_perm;
+    IOMMUAccessFlags trans_perm = IOMMU_NONE;
     dma_addr_t addr, base;
     uint64_t satp, gatp, pte;
     bool en_s, en_g;
@@ -295,6 +295,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     } pass;
     MemTxResult ret;
     bool pv = !!ctx->process_id;
+    /*
+     * Keep the request permission separate from iotlb->perm.  G-stage
+     * walks translate S-stage PTE addresses before the real leaf is
+     * reached, but permission checks and fault types must still use the
+     * original request.  A successful walk leaves iotlb->perm with the
+     * effective leaf permission for the translation cache.
+     */
+    const IOMMUAccessFlags req_perm = iotlb->perm;
 
     satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
     gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
@@ -313,7 +321,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      * means we can't do an early MSI check unless we have
      * strictly !en_s.
      */
-    if (!en_s && (iotlb->perm & IOMMU_WO) &&
+    if (!en_s && (req_perm & IOMMU_WO) &&
         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
         iotlb->target_as = &s->trap_as;
         iotlb->translated_addr = iotlb->iova;
@@ -431,13 +439,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 masked_msbs = (addr >> (va_len - 1)) & mask;
 
                 if (masked_msbs != 0 && masked_msbs != mask) {
-                    return (iotlb->perm & IOMMU_WO) ?
+                    return (req_perm & IOMMU_WO) ?
                                 RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
                                 RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
                 }
             } else {
                 if ((addr & va_mask) != addr) {
-                    return (iotlb->perm & IOMMU_WO) ?
+                    return (req_perm & IOMMU_WO) ?
                                 RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                                 RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
                 }
@@ -462,8 +470,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                              MEMTXATTRS_UNSPECIFIED);
         }
         if (ret != MEMTX_OK) {
-            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
-                                            : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
+            return (req_perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
+                                         : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
         }
 
         sc[pass].step++;
@@ -488,13 +496,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
              * non-user mode leaf PTE and !pv we need to fault.
              */
             break;
-        } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
+        } else if ((req_perm & IOMMU_RO) && !(pte & PTE_R)) {
             break;                /* Read access check failed */
-        } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
+        } else if ((req_perm & IOMMU_WO) && !(pte & PTE_W)) {
             break;                /* Write access check failed */
         } else if (!ade && !(pte & PTE_A)) {
             break;                /* Access bit not set */
-        } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
+        } else if ((req_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
             break;                /* Dirty bit not set */
         } else if (pass == G_STAGE && !(pte & PTE_U)) {
             /*
@@ -529,21 +537,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 addr = iotlb->iova;
                 continue;
             }
+
+            /* Cache the effective permission, not this request's subset. */
+            IOMMUAccessFlags leaf_perm = (pte & PTE_W) ?
+                                         ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO) :
+                                         IOMMU_RO;
+
+            trans_perm = trans_perm == IOMMU_NONE ?
+                         leaf_perm : trans_perm & leaf_perm;
+
             /* Translation phase completed (GPA or SPA) */
             iotlb->translated_addr = base;
 
-            /*
-             * Do a bit_and between the PTE bits and the original
-             * request flags to determine the exact permission we
-             * need, i.e. if the original request is RO and the
-             * PTE has RW flags the actual perm is RO.
-             */
-            pte_perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
-                                     : IOMMU_RO;
-            iotlb->perm &= pte_perm;
-
             /* Check MSI GPA address match */
-            if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
+            if (pass == S_STAGE && (req_perm & IOMMU_WO) &&
                 riscv_iommu_msi_check(s, ctx, base)) {
                 /* Trap MSI writes and return GPA address. */
                 iotlb->target_as = &s->trap_as;
@@ -560,6 +567,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
                 continue;
             }
 
+            iotlb->perm = trans_perm;
             return 0;
         }
 
@@ -584,7 +592,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
      */
     iotlb->translated_addr = addr;
 
-    return (iotlb->perm & IOMMU_WO) ?
+    return (req_perm & IOMMU_WO) ?
                 (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                         RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
                 (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :
-- 
2.47.3



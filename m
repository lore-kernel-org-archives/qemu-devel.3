Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB1FCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1op1-0007Do-8J; Thu, 25 Sep 2025 12:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1oo6-0006S2-DZ; Thu, 25 Sep 2025 12:27:00 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1ons-0004l7-8I; Thu, 25 Sep 2025 12:26:57 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHXWE3bdVopzN6Bw--.5704S2;
 Fri, 26 Sep 2025 00:26:31 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHLestbdVoW_MeAA--.7120S11;
 Fri, 26 Sep 2025 00:26:30 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 08/14] hw/arm/smmuv3: Add security-state handling for page
 table walks
Date: Fri, 26 Sep 2025 00:26:12 +0800
Message-Id: <20250925162618.191242-9-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHLestbdVoW_MeAA--.7120S11
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWjUSMIHvQAAsM
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtFW3XrWDtw45XF4DuryDKFg_yoWDGF43p3
 yxGrnxtr4rtF1SvrWkAr42v3Z3G34vgF4DKryDCr9akayYqry8AF1DKFy5CFZ0gr15J39r
 Zr1vgr4xZrnrXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch introduces the necessary logic to handle security states
during the page table translation process.

Support for the NS (Non-secure) attribute bit is added to the parsing of
various translation structures, including CD and PTEs. This allows the
SMMU model to correctly determine the security properties of memory
during a translation.

With this change, a new translation stage is added:

- Secure Stage 1 translation

Note that this commit does not include support for Secure Stage 2
translation, which will be addressed in the future.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 55 ++++++++++++++++++++++++++++++++----
 hw/arm/smmu-internal.h       |  7 +++++
 hw/arm/smmuv3-internal.h     |  2 ++
 hw/arm/smmuv3.c              |  2 ++
 hw/arm/trace-events          |  2 +-
 include/hw/arm/smmu-common.h |  4 +++
 6 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index bc13b00f1d..f563cba023 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -398,20 +398,25 @@ void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
  * @base_addr[@index]
  */
 static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
-                   SMMUPTWEventInfo *info)
+                   SMMUPTWEventInfo *info, SMMUTransCfg *cfg, int walk_ns)
 {
     int ret;
     dma_addr_t addr = baseaddr + index * sizeof(*pte);
+    /* Only support Secure PA Space as RME isn't implemented yet */
+    MemTxAttrs attrs =
+        smmu_get_txattrs(walk_ns ? SMMU_SEC_IDX_NS : SMMU_SEC_IDX_S);
+    AddressSpace *as =
+        smmu_get_address_space(walk_ns ? SMMU_SEC_IDX_NS : SMMU_SEC_IDX_S);
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
+    ret = ldq_le_dma(as, addr, pte, attrs);
 
     if (ret != MEMTX_OK) {
         info->type = SMMU_PTW_ERR_WALK_EABT;
         info->addr = addr;
         return -EINVAL;
     }
-    trace_smmu_get_pte(baseaddr, index, addr, *pte);
+    trace_smmu_get_pte(baseaddr, index, addr, *pte, walk_ns);
     return 0;
 }
 
@@ -542,6 +547,8 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
 
     baseaddr = extract64(tt->ttb, 0, cfg->oas);
     baseaddr &= ~indexmask;
+    int nscfg = tt->nscfg;
+    bool forced_ns = false;  /* Track if NSTable=1 forced NS mode */
 
     while (level < VMSA_LEVELS) {
         uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
@@ -551,7 +558,9 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
         dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
         uint8_t ap;
 
-        if (get_pte(baseaddr, offset, &pte, info)) {
+        /* Use NS if forced by previous NSTable=1 or current nscfg */
+        int current_ns = forced_ns || nscfg;
+        if (get_pte(baseaddr, offset, &pte, info, cfg, current_ns)) {
                 goto error;
         }
         trace_smmu_ptw_level(stage, level, iova, subpage_size,
@@ -576,6 +585,26 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
                     goto error;
                 }
             }
+
+            /*
+             * Hierarchical control of Secure/Non-secure accesses:
+             * If NSTable=1 from Secure space, force all subsequent lookups to
+             * Non-secure space and ignore future NSTable according to
+             * (IHI 0070G.b) 13.4.1 Stage 1 page permissions and
+             * (DDI 0487H.a)D8.4.2 Control of Secure or Non-secure memory access
+             */
+            if (!forced_ns) {
+                int new_nstable = PTE_NSTABLE(pte);
+                if (!current_ns && new_nstable) {
+                    /* First transition from Secure to Non-secure */
+                    forced_ns = true;
+                    nscfg = 1;
+                } else if (!forced_ns) {
+                    /* Still in original mode, update nscfg normally */
+                    nscfg = new_nstable;
+                }
+                /* If forced_ns is already true, ignore NSTable bit */
+            }
             level++;
             continue;
         } else if (is_page_pte(pte, level)) {
@@ -618,6 +647,8 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
             goto error;
         }
 
+        tlbe->sec_idx = PTE_NS(pte) ? SMMU_SEC_IDX_NS : SMMU_SEC_IDX_S;
+        tlbe->entry.target_as = smmu_get_address_space(tlbe->sec_idx);
         tlbe->entry.translated_addr = gpa;
         tlbe->entry.iova = iova & ~mask;
         tlbe->entry.addr_mask = mask;
@@ -687,7 +718,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
         dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
         uint8_t s2ap;
 
-        if (get_pte(baseaddr, offset, &pte, info)) {
+        /* Use NS as Secure Stage 2 is not implemented (SMMU_S_IDR1.SEL2 == 0)*/
+        if (get_pte(baseaddr, offset, &pte, info, cfg, 1)) {
                 goto error;
         }
         trace_smmu_ptw_level(stage, level, ipa, subpage_size,
@@ -740,6 +772,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
             goto error_ipa;
         }
 
+        tlbe->sec_idx = SMMU_SEC_IDX_NS;
+        tlbe->entry.target_as = &address_space_memory;
         tlbe->entry.translated_addr = gpa;
         tlbe->entry.iova = ipa & ~mask;
         tlbe->entry.addr_mask = mask;
@@ -824,6 +858,17 @@ int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
         return ret;
     }
 
+    if (!cfg->sel2 && tlbe->sec_idx > SMMU_SEC_IDX_NS) {
+        /*
+         * Nested translation with Secure IPA output is not supported if
+         * Secure Stage 2 is not implemented.
+         */
+        info->type = SMMU_PTW_ERR_TRANSLATION;
+        info->stage = SMMU_STAGE_1;
+        tlbe->entry.perm = IOMMU_NONE;
+        return -EINVAL;
+    }
+
     ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
     ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
     if (ret) {
diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index d143d296f3..cb3a6eb8d1 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -58,6 +58,10 @@
     ((level == 3) &&                                                    \
      ((pte & ARM_LPAE_PTE_TYPE_MASK) == ARM_LPAE_L3_PTE_TYPE_PAGE))
 
+/* Non-secure bit */
+#define PTE_NS(pte) \
+    (extract64(pte, 5, 1))
+
 /* access permissions */
 
 #define PTE_AP(pte) \
@@ -66,6 +70,9 @@
 #define PTE_APTABLE(pte) \
     (extract64(pte, 61, 2))
 
+#define PTE_NSTABLE(pte) \
+    (extract64(pte, 63, 1))
+
 #define PTE_AF(pte) \
     (extract64(pte, 10, 1))
 /*
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index cf17c405de..af2936cf16 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -704,6 +704,8 @@ static inline int oas2bits(int oas_field)
 #define CD_R(x)          extract32((x)->word[1], 13, 1)
 #define CD_A(x)          extract32((x)->word[1], 14, 1)
 #define CD_AARCH64(x)    extract32((x)->word[1], 9 , 1)
+#define CD_NSCFG0(x)     extract32((x)->word[2], 0, 1)
+#define CD_NSCFG1(x)     extract32((x)->word[4], 0, 1)
 
 /**
  * tg2granule - Decodes the CD translation granule size field according
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index eba709ae2b..2f8494c346 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -832,6 +832,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
             tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
         }
 
+        tt->nscfg = i ? CD_NSCFG1(cd) : CD_NSCFG0(cd);
         tt->had = CD_HAD(cd, i);
         trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
     }
@@ -929,6 +930,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
         cfg->sec_idx = sec_idx;
         cfg->txattrs = smmu_get_txattrs(sec_idx);
         cfg->as = smmu_get_address_space(sec_idx);
+        cfg->sel2 = s->bank[SMMU_SEC_IDX_S].idr[1];
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
             SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 80cb4d6b04..f99de78655 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -16,7 +16,7 @@ smmu_ptw_level(int stage, int level, uint64_t iova, size_t subpage_size, uint64_
 smmu_ptw_invalid_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint32_t offset, uint64_t pte) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" offset=%d pte=0x%"PRIx64
 smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=%d level=%d iova=0x%"PRIx64" base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" page address = 0x%"PRIx64
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
-smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
+smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte, bool ns_walk) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64" ns_walk=%d"
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
 smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
 smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index ed21db7728..c27aec8bd4 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -109,6 +109,7 @@ typedef struct SMMUTransTableInfo {
     uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
     uint8_t granule_sz;        /* granule page shift */
     bool had;                  /* hierarchical attribute disable */
+    bool nscfg;                /* Non-secure attribute of Starting-level TT */
 } SMMUTransTableInfo;
 
 typedef struct SMMUTLBEntry {
@@ -116,6 +117,7 @@ typedef struct SMMUTLBEntry {
     uint8_t level;
     uint8_t granule;
     IOMMUAccessFlags parent_perm;
+    SMMUSecurityIndex sec_idx;
 } SMMUTLBEntry;
 
 /* Stage-2 configuration. */
@@ -156,6 +158,8 @@ typedef struct SMMUTransCfg {
     SMMUSecurityIndex sec_idx; /* cached security index */
     MemTxAttrs txattrs;        /* cached transaction attributes */
     AddressSpace *as;          /* cached address space */
+    bool current_walk_ns;      /* cached if the current walk is non-secure */
+    bool sel2;
 } SMMUTransCfg;
 
 typedef struct SMMUDevice {
-- 
2.34.1



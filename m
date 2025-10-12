Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A64CCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 15:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xk5-000847-2f; Sun, 12 Oct 2025 11:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xk3-00083h-LA; Sun, 12 Oct 2025 11:12:11 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xk1-0002PV-HN; Sun, 12 Oct 2025 11:12:11 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCniGBExeto8lSgAA--.23S2;
 Sun, 12 Oct 2025 23:12:04 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3WedDxetoKHhMAA--.2261S3;
 Sun, 12 Oct 2025 23:12:03 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 12/21] hw/arm/smmu-common: Implement secure state handling in
 ptw
Date: Sun, 12 Oct 2025 23:12:00 +0800
Message-Id: <20251012151200.4129164-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3WedDxetoKHhMAA--.2261S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBaAAAsZ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3AF47JFW8GrWxGw4UZr4xJFb_yoW3GF13pr
 WxGr9Ivr4rtFySvrZ3ZF4qv3WrC3yqgF45Kryqkr9akayDtr1kuFWqyr98AFZYgr13J39r
 Z34jkr4xZrnrX3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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

Enhance the page table walker to correctly handle secure and non-secure
memory accesses. This change introduces logic to select the appropriate
address space and enforce architectural security policies during walks.

The page table walker now correctly processes Secure Stage 1
translations. Key changes include:

- The get_pte function now uses the security context to fetch table
entries from either the Secure or Non-secure address space.

- The stage 1 walker tracks the security state, respecting the NSCFG
and NSTable attributes. It correctly handles the hierarchical security
model: if a table descriptor in a secure walk has NSTable=1, all
subsequent lookups for that walk are forced into the Non-secure space.
This is a one-way transition, as specified by the architecture.

- A check is added to fault nested translations that produce a Secure
IPA when Secure stage 2 is not supported (SMMU_S_IDR1.SEL2 == 0).

- The final TLB entry is tagged with the correct output address space,
ensuring proper memory isolation.

Stage 2 translations are currently limited to Non-secure lookups. Full
support for Secure Stage 2 translation will be added in a future series.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c | 64 +++++++++++++++++++++++++++++++++++++++-----
 hw/arm/trace-events  |  2 +-
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 5fabe30c75..a092bb5a8d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -399,20 +399,26 @@ void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
  * @base_addr[@index]
  */
 static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
-                   SMMUPTWEventInfo *info)
+                   SMMUPTWEventInfo *info, SMMUSecSID sec_sid)
 {
     int ret;
     dma_addr_t addr = baseaddr + index * sizeof(*pte);
-
+    MemTxAttrs attrs = smmu_get_txattrs(sec_sid);
+    AddressSpace *as = smmu_get_address_space(sec_sid);
+    if (!as) {
+        info->type = SMMU_PTW_ERR_WALK_EABT;
+        info->addr = addr;
+        return -EINVAL;
+    }
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
+    ret = ldq_le_dma(as, addr, pte, attrs);
 
     if (ret != MEMTX_OK) {
         info->type = SMMU_PTW_ERR_WALK_EABT;
         info->addr = addr;
         return -EINVAL;
     }
-    trace_smmu_get_pte(baseaddr, index, addr, *pte);
+    trace_smmu_get_pte(sec_sid, baseaddr, index, addr, *pte);
     return 0;
 }
 
@@ -543,6 +549,8 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
 
     baseaddr = extract64(tt->ttb, 0, cfg->oas);
     baseaddr &= ~indexmask;
+    int nscfg = tt->nscfg;
+    bool forced_ns = false;  /* Track if NSTable=1 forced NS mode */
 
     while (level < VMSA_LEVELS) {
         uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
@@ -552,7 +560,10 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
         dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
         uint8_t ap;
 
-        if (get_pte(baseaddr, offset, &pte, info)) {
+        /* Use NS if forced by previous NSTable=1 or current nscfg */
+        int current_ns = forced_ns || nscfg;
+        SMMUSecSID sec_sid = current_ns ? SMMU_SEC_SID_NS : SMMU_SEC_SID_S;
+        if (get_pte(baseaddr, offset, &pte, info, sec_sid)) {
                 goto error;
         }
         trace_smmu_ptw_level(stage, level, iova, subpage_size,
@@ -577,6 +588,26 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
                     goto error;
                 }
             }
+
+            /*
+             * Hierarchical control of Secure/Non-secure accesses:
+             * If NSTable=1 from Secure space, force all subsequent lookups to
+             * Non-secure space and ignore future NSTable according to
+             * (IHI 0070G.b)13.4.1 Stage 1 page permissions and
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
@@ -619,6 +650,13 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
             goto error;
         }
 
+        tlbe->sec_sid = PTE_NS(pte) ? SMMU_SEC_SID_NS : SMMU_SEC_SID_S;
+        tlbe->entry.target_as = smmu_get_address_space(tlbe->sec_sid);
+        if (!tlbe->entry.target_as) {
+            info->type = SMMU_PTW_ERR_WALK_EABT;
+            info->addr = gpa;
+            goto error;
+        }
         tlbe->entry.translated_addr = gpa;
         tlbe->entry.iova = iova & ~mask;
         tlbe->entry.addr_mask = mask;
@@ -688,7 +726,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
         dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
         uint8_t s2ap;
 
-        if (get_pte(baseaddr, offset, &pte, info)) {
+        /* Use NS as Secure Stage 2 is not implemented (SMMU_S_IDR1.SEL2 == 0)*/
+        if (get_pte(baseaddr, offset, &pte, info, SMMU_SEC_SID_NS)) {
                 goto error;
         }
         trace_smmu_ptw_level(stage, level, ipa, subpage_size,
@@ -741,6 +780,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
             goto error_ipa;
         }
 
+        tlbe->sec_sid = SMMU_SEC_SID_NS;
+        tlbe->entry.target_as = &address_space_memory;
         tlbe->entry.translated_addr = gpa;
         tlbe->entry.iova = ipa & ~mask;
         tlbe->entry.addr_mask = mask;
@@ -825,6 +866,17 @@ int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
         return ret;
     }
 
+    if (!cfg->sel2 && tlbe->sec_sid > SMMU_SEC_SID_NS) {
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
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 96ebd1b11b..a37e894766 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -16,7 +16,7 @@ smmu_ptw_level(int stage, int level, uint64_t iova, size_t subpage_size, uint64_
 smmu_ptw_invalid_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint32_t offset, uint64_t pte) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" offset=%d pte=0x%"PRIx64
 smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=%d level=%d iova=0x%"PRIx64" base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" page address = 0x%"PRIx64
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
-smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
+smmu_get_pte(int sec_sid, uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "sec_sid=%d baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64""
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
 smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
 smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
-- 
2.34.1



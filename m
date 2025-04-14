Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B618C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49B8-0007Mr-Fj; Sun, 13 Apr 2025 22:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49At-0007HX-49
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Aq-0007Uh-Ff
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:50 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E1qKSB029524;
 Mon, 14 Apr 2025 02:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=sB5Wn
 3qDMven+8GyT+YuIrtINU7IHZ0+1VwyZg5/mu0=; b=MAZK+QcuVu1SArUYEIKPk
 noME/Eqwym+NRo3C7Ey3l5eRwz/gTMibcLFlUv8KBIdre85Dd87i08MEMbSo558S
 RvCORNfTvUuj+izaTDGawz0vV7oCMymDWGrGNu0Za9T3ov+B3YsxjxFif+MfzybW
 46qKU+2hBRBMgdtWZG2xTIrGXxbXfwBnbVI2nB+BGLLhc81Vg5wTzuU2Xim7NBax
 WgLXhXtvQ7HUoLOqEY/6sgMdXXaHVp9Oe/3KE5Wipf/d2Qi5OiukOAG33etff5yU
 8FQoDLigSDCsN0JS6cg6k8n3EEOZMlEpmKff4ZUMW6FG6QvcRslvypchMWCj7QIf
 A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460s2u007r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DN495r009241; Mon, 14 Apr 2025 02:03:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:42 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYi035550;
 Mon, 14 Apr 2025 02:03:42 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-12; Mon, 14 Apr 2025 02:03:41 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 11/18] amd_iommu: Sync shadow page tables on page invalidation
Date: Mon, 14 Apr 2025 02:02:46 +0000
Message-ID: <20250414020253.443831-12-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_12,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140014
X-Proofpoint-GUID: NF_maUNq2HNSkukzcd85uoXwDFNcrLhO
X-Proofpoint-ORIG-GUID: NF_maUNq2HNSkukzcd85uoXwDFNcrLhO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.266,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When the guest issues an INVALIDATE_IOMMU_PAGES command, decode the
address and size of the invalidation and sync the guest page table state
with the host. This requires walking the guest page table and calling
notifiers registered for address spaces matching the domain ID encoded
in the command.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 110 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 8 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6789e1e9b688..cf83ac607064 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -97,6 +97,9 @@ typedef enum AMDVIFaultReason {
 } AMDVIFaultReason;
 
 static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte);
+static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
+                                               uint64_t *dte, hwaddr addr,
+                                               uint64_t size, bool send_unmap);
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
@@ -497,8 +500,7 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
  * first zero at bit 51 or larger is a request to invalidate the entire address
  * space.
  */
-static uint64_t __attribute__((unused))
-amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
+static uint64_t amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
 {
     uint64_t size = AMDVI_PAGE_SIZE;
     uint8_t fzbit = 0;
@@ -515,10 +517,101 @@ amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
     return size;
 }
 
+/*
+ * Synchronize the guest page tables with the shadow page tables kept in the
+ * host for the specified range.
+ * The invalidation command issued by the guest and intercepted by the VMM
+ * does not specify a device, but a domain, since all devices in the same domain
+ * share the same page tables. However, vIOMMU emulation creates separate
+ * address spaces per device, so it is necessary to traverse the list of all of
+ * address spaces (i.e. devices) that have notifiers registered in order to
+ * propagate the changes to the host page tables. This could generate redundant
+ * requests to map/unmap regions when there are several devices in a same domain
+ * but it must be optimized by maintaining an internal representation of the
+ * per-domain address space, and avoid invoking a notifier when the change is
+ * already reflected in the host page tables.
+ *
+ * We cannot return early from this function once a matching domain has been
+ * identified and its page tables synced (based on the fact that all devices in
+ * the same domain share the page tables). The reason is that different devices
+ * (i.e. address spaces) could have different notifiers registered, and by
+ * skipping address spaces that appear later on the amdvi_as_with_notifiers list
+ * their notifiers (which could differ from the ones registered for the first
+ * device/address space) would not be invoked.
+ */
+static void amdvi_sync_domain(AMDVIState *s, uint16_t domid, uint64_t addr,
+                              uint16_t flags)
+{
+    AMDVIAddressSpace *as;
+
+    uint64_t size = amdvi_decode_invalidation_size(addr, flags);
+
+    if (size == AMDVI_INV_ALL_PAGES) {
+        addr = 0;       /* Set start address to 0 and invalidate entire AS */
+    } else {
+        addr &= ~(size - 1);
+    }
+
+    /*
+     * Call notifiers that have registered for each address space matching the
+     * domain ID, in order to sync the guest pagetable state with the host.
+     */
+    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
+
+        uint64_t dte[4] = { 0 };
+
+        /*
+         * Retrieve the Device Table entry for the devid corresponding to the
+         * current address space, and verify the DomainID matches i.e. the page
+         * tables to be synced belong to devices in the domain.
+         */
+        if (amdvi_as_to_dte(as, dte)) {
+            continue;
+        }
+
+        /* Only need to sync the Page Tables for a matching domain */
+        if (domid != (dte[1] & AMDVI_DEV_DOMID_ID_MASK)) {
+            continue;
+        }
+
+        /*
+         * We have determined that there is a valid Device Table Entry for a
+         * device matching the DomainID in the INV_IOMMU_PAGES command issued by
+         * the guest. Walk the guest page table to sync shadow page table.
+         *
+         * An optimization can be made if only UNMAP notifiers are registered to
+         * avoid walking the page table and just invalidate the requested range.
+         */
+        if (as->notifier_flags & IOMMU_NOTIFIER_MAP) {
+
+            /* Sync guest IOMMU mappings with host */
+            amdvi_sync_shadow_page_table_range(as, &dte[0], addr, size, true);
+        } else {
+            /*
+             * For UNMAP only notifiers, invalidate the requested size. No page
+             * table walk is required since there is no need to replay mappings.
+             */
+            IOMMUTLBEvent event = {
+                .type = IOMMU_NOTIFIER_UNMAP,
+                .entry = {
+                    .target_as = &address_space_memory,
+                    .iova = addr,
+                    .translated_addr = 0, /* Irrelevant for unmap case */
+                    .addr_mask = size - 1,
+                    .perm = IOMMU_NONE,
+                },
+            };
+            memory_region_notify_iommu(&as->iommu, 0, event);
+        }
+    }
+}
+
 /* we don't have devid - we can't remove pages by address */
 static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
     uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
+    uint64_t addr = cpu_to_le64(extract64(cmd[1], 12, 52)) << 12;
+    uint16_t flags = cpu_to_le16((uint16_t)extract64(cmd[1], 0, 3));
 
     if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
         extract64(cmd[1], 3, 9)) {
@@ -528,6 +621,8 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 
     g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_domid,
                                 &domid);
+
+    amdvi_sync_domain(s, domid, addr, flags);
     trace_amdvi_pages_inval(domid);
 }
 
@@ -1589,9 +1684,8 @@ static uint64_t large_pte_page_size(uint64_t pte)
  *  0:  PTE is marked not present, or entry is 0.
  * >0:  Leaf PTE value resolved from walking Guest IO Page Table.
  */
-static uint64_t __attribute__((unused))
-fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
-          hwaddr *page_size)
+static uint64_t fetch_pte(AMDVIAddressSpace *as, const hwaddr address,
+                          uint64_t dte, hwaddr *page_size)
 {
     IOMMUAccessFlags perms = amdvi_get_perms(dte);
 
@@ -1693,9 +1787,9 @@ fetch_pte(AMDVIAddressSpace *as, const hwaddr address, uint64_t dte,
  * notifiers to sync the shadow page tables in the host.
  * Must be called with a valid DTE for DMA remapping i.e. V=1,TV=1
  */
-static void __attribute__((unused))
-amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as, uint64_t *dte,
-                                   hwaddr addr, uint64_t size, bool send_unmap)
+static void amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as,
+                                               uint64_t *dte, hwaddr addr,
+                                               uint64_t size, bool send_unmap)
 {
     IOMMUTLBEvent event;
 
-- 
2.43.5



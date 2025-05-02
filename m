Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E605C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfx0-0003sU-D5; Thu, 01 May 2025 22:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfww-0003rh-Bj
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwu-0007Q1-BK
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:26 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeRSm022623;
 Fri, 2 May 2025 02:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=fb/h1
 6Ty+CUuGFy+swhun6Znuo6+EtUD/rHMmFydH2Y=; b=f+9IR5gexCKvScuzZm9n1
 dUNusnJru3W24MzfCGH7ykH01bBrhzZS1FGgKeuFCP3SGm1XAm/V1CAeMTK4sM5w
 asd/AjSN2l1+snaN4F+1g5l3S2qE5MMz78G6jmh2rOH0RZPcALK3ACKKKVsvIIfb
 lONqc495HhjTw+aN2KamhskHN2Ryf7455rsEHsIknc8i9oZGuFZ9JlcN4mI9Yofd
 xXINSOfMAVXU467pTv/kTngzNJhUzbY+6WzUA2u+EJkfh6gzOREki4XrTiBwwzae
 3rlM3Ps3Q9hSVxOULvT/75xJZvxU8MZfMhKpI3npbsMxJa+JCGGdysbhtKo9eIgd
 Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uumdb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 541Nd1kc023774; Fri, 2 May 2025 02:16:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh01a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:14 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsA011525;
 Fri, 2 May 2025 02:16:13 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-11; Fri, 02 May 2025 02:16:13 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 10/20] amd_iommu: Sync shadow page tables on page
 invalidation
Date: Fri,  2 May 2025 02:15:55 +0000
Message-ID: <20250502021605.1795985-11-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfX+mcbuvatsp2e
 LXEdbq5qQbW6es/mrYvrOVWU+9GpUnhVP+moo7/QIdCNe/DPQBj5mT/sj6HZNruUCtmLQ4tOetr
 lev7emsSK3Sr45GG551swnE0VLK3zXoHN2rCaJkZal6Ohs6IJcUtGrs3UW6h/EWPz5cQYgE7Meb
 QwpeUqIr3Vn8BmEniOcjBCtPcvBT862tFNvhfoz5exTiv6fYzgtOuIAyqbTyAYI5uAZo4j02wAT
 x2S+CNvHvf7DNSGl/VSXtx4iDdWnu4b4kWr4VUidAXUbHCMmJ9nDExYb+zaExsjOcFqIBnIQP+b
 91xOIkOPvfuK+hJTubg2hgdA/FezfuTjSuDOAGTxcd1pvE2QRdUIxGM7idPgv8d4UubDVVXEjIA
 ss8gmT1xKQiasUmrulC5+H2CxWR3zdF41zFGMky+oR3G6uBVyShHt+puOqiF9f1+fq1HwMiL
X-Authority-Analysis: v=2.4 cv=Ve/3PEp9 c=1 sm=1 tr=0 ts=68142af0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=yYEnZJB5WiW7dih4ZO4A:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: 08WLYo0hqA-dDDdfyXCLK23FllZ-wZHS
X-Proofpoint-GUID: 08WLYo0hqA-dDDdfyXCLK23FllZ-wZHS
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When the guest issues an INVALIDATE_IOMMU_PAGES command, decode the address
and size of the invalidation and sync the guest page table state with the
host. This requires walking the guest page table and calling notifiers
registered for address spaces matching the domain ID encoded in the command.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 82 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 2f69459ab68d..bddfe2f93136 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -559,9 +559,8 @@ static uint64_t large_pte_page_size(uint64_t pte)
  *      page table walk. This means that the DTE has valid data, but one of the
  *      lower level entries in the Page Table could not be read.
  */
-static int __attribute__((unused))
-fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
-          hwaddr *page_size)
+static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
+                          uint64_t *pte, hwaddr *page_size)
 {
     IOMMUAccessFlags perms = amdvi_get_perms(dte);
 
@@ -659,9 +658,9 @@ fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
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
 
@@ -798,8 +797,7 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
  * first zero at bit 51 or larger is a request to invalidate the entire address
  * space.
  */
-static uint64_t __attribute__((unused))
-amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
+static uint64_t amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
 {
     uint64_t size = AMDVI_PAGE_SIZE;
     uint8_t fzbit = 0;
@@ -816,10 +814,76 @@ amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
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
+ * propagate the changes to the host page tables.
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
+         */
+        if (as->notifier_flags & IOMMU_NOTIFIER_MAP) {
+            /* Sync guest IOMMU mappings with host */
+            amdvi_sync_shadow_page_table_range(as, &dte[0], addr, size, true);
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
@@ -829,6 +893,8 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 
     g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_domid,
                                 &domid);
+
+    amdvi_sync_domain(s, domid, addr, flags);
     trace_amdvi_pages_inval(domid);
 }
 
-- 
2.43.5



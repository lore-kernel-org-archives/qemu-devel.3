Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52836CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzilr-0006AZ-ME; Fri, 19 Sep 2025 17:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilp-00069s-AX
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilk-0002WM-Ny
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:55 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtn9g016546;
 Fri, 19 Sep 2025 21:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=Wi45w
 Ont2UqDSvriQiYFiUq6a9+9GtKxIDSVzeMQtV4=; b=BN845PTod14Gm7qBlv03j
 10qG+mY6d6T7y3UbCzAmb9VoZiC+kR1XSgcmcS2Kuh9Ez3/iMVdVsgLQmu+NmRNf
 gwQNJD+q9zZNv/PAiJhOSCLJyEGkm+otVWrI12v7xxUH9EEXiICxcP23Ci7wLa30
 mu2cPHiWx4r4uaEhLL9Hm81mjhX27CZgjcUK/wNkKgQ/tE/C7h3/koGj2ILsB0tP
 H1RwonpjOtiuwDRR007Ves9FJODJqxMnIPbRVUWY4l2aGVoMoR2SZJMhz3YQP0ru
 34zAz1GETGoErXTXphC3AWtRIUTI0b1y8jqGlA3daqK3RcMVrfIazlmYIv1wz38m
 w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0keg05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:44 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JKxVmm033703; Fri, 19 Sep 2025 21:35:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0H004301;
 Fri, 19 Sep 2025 21:35:42 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-11; Fri, 19 Sep 2025 21:35:42 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 10/22] amd_iommu: Sync shadow page tables on page
 invalidation
Date: Fri, 19 Sep 2025 21:35:03 +0000
Message-ID: <20250919213515.917111-11-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cdccb0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=yYEnZJB5WiW7dih4ZO4A:9
X-Proofpoint-GUID: K00OrH2mVkSosCiLLKGSZhzsmhMsJXtX
X-Proofpoint-ORIG-GUID: K00OrH2mVkSosCiLLKGSZhzsmhMsJXtX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfXzKwSepgNcKBI
 gaVd0dHu5GmbTiJ5aS2O9IcIm54Q4GHoyF6itk9w8/x8eRHU5FjJQjDmpqbyCo9osv951AQokTj
 pDGJgXzVuKOBVF7nqyJ5XgprrWP4kc8aa/r6jct1WT1qjIwrd0MRxf9UKbxdhXQ4XvAs52QYCt4
 9LxAZTEiGAdHHoa9keGGfWyrLAky1IPH5ax5MoLo3hDxpRFxZIfi2YOR3YPoeaR+ZwldmKtrOfn
 bPpmEJ9KslcCZae0wP/2tHtVoTkOha8gFCuigWYHfCFwE0ovzT90TMpxLbRkR+OrQXgfqsusVsX
 POB1oJxpws+smgt5HyKqjnf0a7/B/gSj8yJP3qvlvJcajZpieJRR47sfdbBpWMX2eQPl9ayTpCH
 GXwuYYOj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When the guest issues an INVALIDATE_IOMMU_PAGES command, decode the address
and size of the invalidation and sync the guest page table state with the
host. This requires walking the guest page table and calling notifiers
registered for address spaces matching the domain ID encoded in the command.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 82 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d8a451b3a5ff1..caae65c4b3565 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -591,9 +591,8 @@ static uint64_t large_pte_page_size(uint64_t pte)
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
 
@@ -691,9 +690,9 @@ fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
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
 
@@ -835,8 +834,7 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
  * first zero at bit 51 or larger is a request to invalidate the entire address
  * space.
  */
-static uint64_t __attribute__((unused))
-amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
+static uint64_t amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
 {
     uint64_t size = AMDVI_PAGE_SIZE;
     uint8_t fzbit = 0;
@@ -853,10 +851,76 @@ amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
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
@@ -866,6 +930,8 @@ static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 
     g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_domid,
                                 &domid);
+
+    amdvi_sync_domain(s, domid, addr, flags);
     trace_amdvi_pages_inval(domid);
 }
 
-- 
2.43.5



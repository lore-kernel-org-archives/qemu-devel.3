Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAB8C531FC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnOTB-0001Up-Ne; Fri, 24 Jul 2026 18:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSn-0001Rc-FJ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSl-0001H5-PN
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OJcV3e4097152; Fri, 24 Jul 2026 22:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=IGX3n
 gu3NASPOACBJkwnnUr57RueWv7vManp8ZoyWJ4=; b=OMMpMTlkgd/2Sfhk0uaEY
 pITuVcpDNr5NTqMQKw1xFxxmj7EHpxeEQz08jenZ/IVZrlvUnrJQ/TmA4bkjFo/A
 uBGL4dL15XZvJ7FnK+ezunbwQFw4oWULp34EHjfnu/Bh+QF13LqF5gwWDnvBALvP
 n4rPAwtGnlB4Jyr2zaTW204udILtkLZ1UlMAD0G9PbcHEch/Zek/x7tyRtBxq96X
 EvRMgzYqZoMFrj3FCUfGv7+suNc8U58kB+Jsdp9nqaWHvgV1jigyrFfMUEIrXmmt
 QK2/ZQ3EH/t3ux/mo0L5uP+31t/IVHYs3RUAMr8FXu0OcZj4OYuF8qriTaj/m72e
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1n3s7j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66OMXYe2028235; Fri, 24 Jul 2026 22:33:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ffyxtq3d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:47 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66OMXiTQ029565;
 Fri, 24 Jul 2026 22:33:46 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ffyxtq3a1-3; Fri, 24 Jul 2026 22:33:46 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, joe.jin@oracle.com
Subject: [PATCH v2 2/5] amd_iommu: Use full BDF when reporting page faults
Date: Fri, 24 Jul 2026 15:31:28 -0700
Message-ID: <20260724223216.108667-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260724223216.108667-1-dongli.zhang@oracle.com>
References: <20260724223216.108667-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607240203
X-Proofpoint-GUID: 2ynUMMwf6vdggyvQDwtuaTQ0sM3PHMcg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX8GUylUbv6g9E
 LABKMRzGzRJD53w8sh7sU981APxMGb2+BqLLm0T8Rh0yoURVYeclvh9oqrTywXkFmMKn86xX3y4
 90UuBrzZWTo8FLmPeXpJDg+AjJi1Mn3oBKbtCwSYyY1u2tkoGQd3
X-Proofpoint-ORIG-GUID: 2ynUMMwf6vdggyvQDwtuaTQ0sM3PHMcg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfXwy1z6MZAqRnW
 O+YQZixvRAIMLGpVw6PmqtgDWSNOaFq37+yFZmYndKY3groJSVMLp+o1MWC95Urz2DGp9jW0TV+
 qr7cCNOaNwSToCqZ28s5zjtwcgwuYJ9RZP5qEn9sNSWXzBZeZaZrJQJ+tJNANjuw5bBS1VraO40
 4yMQ1dnGBsM5Re1AE2QCM6URUb8JRlnNRoE6AnAzpYgsYw1UVTHFcNrxgGfN1a3B8WWhKbZ6uml
 qAuI/bsi8jl+YOAZZdr/2BdFwq0q7OVVr5pmjHSYgyiWUaep3DSgkvoehzozqu7FPjF+sDxNX5+
 lvGG0YC/2tIdmMcJIpGCdrNOFggs9EMGO0rTka7agmmp5LvW6j7yaycLjq4keZmeWhk6GCbjgoZ
 lJn25kpJXwqhU8fugkfNiYVxWQQ0LV+w+Y9C/czE+z0YQRBhxiZahUyZVf5LrZiVj+62qcGzQQz
 apfpBKK9JmD1Y6VKNYRemRSRcnm7Ze6XrKHzk260=
X-Authority-Analysis: v=2.4 cv=PryjqQM3 c=1 sm=1 tr=0 ts=6a63e84c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=rr2mO2NlkmEzDuUfnTYA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12114
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AMDVIAddressSpace->devfn only contains the PCI device/function number.
AMD-Vi event log entries require the full DeviceID, including the PCI
bus number.

When reporting IO page faults for devices behind a pcie-root-port, QEMU
logs the fault against the wrong requester. For example, a fault from
01:00.0 is reported as 00:00.0 because only devfn is passed to
amdvi_page_fault().

[root@vm ~]# lspci
... ...
01:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)

[   58.154050] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]
[   58.156968] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]

Use the full BDF consistently for AMD-Vi address spaces and pass it to
page fault and page-table access error reporting.

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
v1->v2:
  - Add Fixes tag.
  - Rename amdvi_as_devid() to amdvi_get_as_devid().
  - Introduce amdvi_get_devid().
  - Rebase to call amdvi_get_devid() at amdvi_find_as_by_devid().

 hw/i386/amd_iommu.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index a5682747ac..2fd680c4ff 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -65,6 +65,16 @@ typedef struct AMDVIIOTLBEntry {
     uint64_t page_mask;         /* physical page size  */
 } AMDVIIOTLBEntry;
 
+static uint16_t amdvi_get_devid(PCIBus *bus, uint8_t devfn)
+{
+    return PCI_BUILD_BDF(pci_bus_num(bus), devfn);
+}
+
+static uint16_t amdvi_get_as_devid(AMDVIAddressSpace *as)
+{
+    return amdvi_get_devid(as->bus, as->devfn);
+}
+
 /*
  * These 'fault' reasons have an overloaded meaning since they are not only
  * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
@@ -459,7 +469,7 @@ static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
     const AMDVIAsKey *as = key;
     const uint16_t *devidp = user_data;
 
-    return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+    return *devidp == amdvi_get_devid(as->bus, as->devfn);
 }
 
 static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
@@ -664,7 +674,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
 
 static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
 {
-    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+    uint16_t devid = amdvi_get_as_devid(as);
     AMDVIState *s = as->iommu_state;
 
     if (!amdvi_get_dte(s, devid, dte)) {
@@ -763,6 +773,7 @@ static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
     uint8_t pt_level, next_pt_level;
     IOMMUAccessFlags perms;
     int ret;
+    uint16_t devid = amdvi_get_as_devid(as);
 
     *page_size = 0;
 
@@ -780,7 +791,7 @@ static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
      * Pointer and indexing the top level table using the IOVA from the request.
      */
     pte_addr = NEXT_PTE_ADDR(dte, pt_level, address);
-    *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+    *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, devid);
 
     if (*pte == (uint64_t)-1) {
         /*
@@ -836,7 +847,7 @@ static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
         *page_size = PTE_LEVEL_PAGE_SIZE(pt_level);
 
         pte_addr = NEXT_PTE_ADDR(*pte, pt_level, address);
-        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, devid);
 
         if (*pte == (uint64_t)-1) {
             /* Failure to read PTE. Page walk skips a page_size chunk */
@@ -1897,6 +1908,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     uint8_t mode;
     uint64_t pte;
     int fetch_ret;
+    uint16_t devid = amdvi_get_as_devid(as);
 
     /* make sure the DTE has TV = 1 */
     if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
@@ -1930,7 +1942,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
     if (fetch_ret < 0 || !IOMMU_PTE_PRESENT(pte) ||
         perms != (perms & amdvi_get_perms(pte))) {
 
-        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
+        amdvi_page_fault(as->iommu_state, devid, addr, perms);
         trace_amdvi_page_fault(addr);
         return;
     }
@@ -1957,7 +1969,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
                                bool is_write, IOMMUTLBEntry *ret)
 {
     AMDVIState *s = as->iommu_state;
-    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+    uint16_t devid = amdvi_get_as_devid(as);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
     int dte_ret;
-- 
2.39.3



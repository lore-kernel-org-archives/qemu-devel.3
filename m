Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6F3C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49Av-0007HJ-8R; Sun, 13 Apr 2025 22:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ad-0007Br-Uq
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Aa-0007Rw-TQ
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:34 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E1l2ZH003262;
 Mon, 14 Apr 2025 02:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=h5oce
 Mhigr9JX5hSxTqBSh112Kx58W0lFQtieHOS20k=; b=kzI2CPAnYwwZKo0RMu+Sl
 qruU+itCUKbsdnA9R1hr9KJ5QRyEpG7TtPwc/Mi9xYW8CHqPDHXMSEtt5zHyAmfI
 zHv4jV71zYF1Ms31HXvVcBiuAWa1BKY9PbEhW86wQUkv4ZlUk2/9yOXCBYlDENI4
 dCsUWfT5tgFSyE+RTWRNePntye7Iqf8G/ZNV7iaugCU5idm2PKTO8uFjuharsgUg
 0eM+mcnfT9QJNvHcOFYNqZQZiYokTDVeoytweKzgZnT1mm1AcTZTUihkEBiDTH96
 dDaIVCHunPOmi6LADJUqnN6HFf9+aUoe1DDTYz93XtqI0hwVwrigVuGAFTElMsTK
 g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460s0g00b5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53E0ZlVW009173; Mon, 14 Apr 2025 02:03:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYS035550;
 Mon, 14 Apr 2025 02:03:26 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-4; Mon, 14 Apr 2025 02:03:25 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 03/18] amd_iommu: Add support for IOMMU notifier
Date: Mon, 14 Apr 2025 02:02:38 +0000
Message-ID: <20250414020253.443831-4-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: lozsbfUPFLZvGYVTvfaT4nsP2pcysNco
X-Proofpoint-GUID: lozsbfUPFLZvGYVTvfaT4nsP2pcysNco
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

In order to enable device assignment with IOMMU protection and guest
DMA address translation, IOMMU notifier support is necessary to allow
users like VFIO to synchronize the shadow page tables i.e. to receive
notifications when the guest updates its IO page tables and replay the
mappings onto host IO page tables.

This requires the vIOMMU is configured with the NpCache capability,
so the guest issues IOMMU invalidations for both map() and unmap()
operations. This capability is already part of AMDVI_CAPAB_FEATURES,
and is written to the configuration in amdvi_pci_realize().

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 34 ++++++++++++++++++++++++++++------
 hw/i386/amd_iommu.h |  6 ++++++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 22d648c2e0e3..8dbb10d91339 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -66,6 +66,13 @@ struct AMDVIAddressSpace {
     MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
     MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
     AddressSpace as;            /* device's corresponding address space */
+
+    /* DMA address translation support */
+    IOMMUNotifierFlag notifier_flags;
+    /* entry in list of Address spaces with registered notifiers */
+    QLIST_ENTRY(AMDVIAddressSpace) next;
+    /* DMA address translation active */
+    bool addr_translation;
 };
 
 /* AMDVI cache entry */
@@ -1561,14 +1568,28 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
                                            Error **errp)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
+    AMDVIState *s = as->iommu_state;
+
+    /* DMA remapping capability is required to implement IOMMU notifier */
+    if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
+        error_setg_errno(errp, ENOTSUP,
+                "device %02x.%02x.%x requires dma-remap=1",
+                as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
+        return -ENOTSUP;
+    }
 
-    if (new & IOMMU_NOTIFIER_MAP) {
-        error_setg(errp,
-                   "device %02x.%02x.%x requires iommu notifier which is not "
-                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
-                   PCI_FUNC(as->devfn));
-        return -EINVAL;
+    /*
+     * Update notifier flags for address space and the list of address spaces
+     * with registered notifiers.
+     */
+    as->notifier_flags = new;
+
+    if (old == IOMMU_NOTIFIER_NONE) {
+        QLIST_INSERT_HEAD(&s->amdvi_as_with_notifiers, as, next);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        QLIST_REMOVE(as, next);
     }
+
     return 0;
 }
 
@@ -1700,6 +1721,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 
 static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
+    DEFINE_PROP_BOOL("dma-remap", AMDVIState, dma_remap, false),
 };
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 28125130c6fc..e12ecade4baa 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -365,12 +365,18 @@ struct AMDVIState {
     /* for each served device */
     AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
 
+    /* list of address spaces with registered notifiers */
+    QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
+
     /* IOTLB */
     GHashTable *iotlb;
 
     /* Interrupt remapping */
     bool ga_enabled;
     bool xtsup;
+
+    /* DMA address translation */
+    bool dma_remap;
 };
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s);
-- 
2.43.5



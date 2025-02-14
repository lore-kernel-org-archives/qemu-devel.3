Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51A2C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwTJ-0005SP-56; Fri, 14 Feb 2025 09:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTD-0005J1-4i
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTA-0004bh-Mq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:06 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtShS001883;
 Fri, 14 Feb 2025 14:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=/6XhSvv3sFczrEGfq/gelvALvNCL1zXAoPUq7EQ3ALE=; b=
 LvMVY28nEl88v4juH7obTiLHs0OvCx6s9FlkkJcpQ/UWVKV5YJNfJHd4zLOACRfK
 RPjN8D/baTzKSGC1Zuf7rbPi+xCF46qSih6421CDYAJ/SzEwnzN/b7TeZiXk0dqu
 rZWQbwCjIrQVi7nNtixSQfKkNYbRr3IUCPjzOi0I4GlPjQ7PzJL9ZjhC8vfhnXoJ
 c2sZtkPQjydvLQuIy2/4UoYSn1PFPSP2KWebSE7zSMvxoAs/leTa43gz04ZaVYJ/
 0XlUPDir8vHeiSYE30c0CvCvhE+Mvr/sHojHzm2jFTmyVONS6wcR0oCb9HvSmv9h
 nhHoFq4Bnf1FZw6Vv5myxg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyusvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECZ4j2025433; Fri, 14 Feb 2025 14:15:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksgjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:00 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPx006920;
 Fri, 14 Feb 2025 14:15:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-24; Fri, 14 Feb 2025 14:14:59 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 23/45] vfio/pci: export MSI functions
Date: Fri, 14 Feb 2025 06:14:05 -0800
Message-Id: <1739542467-226739-24-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-ORIG-GUID: LaGo8S9kng3rmpptxLp4YFuZvtuVKc_n
X-Proofpoint-GUID: LaGo8S9kng3rmpptxLp4YFuZvtuVKc_n
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Export various MSI functions, for use by CPR in subsequent patches.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 21 ++++++++++-----------
 hw/vfio/pci.h | 12 ++++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index fd51b9e..29a5b3d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -277,7 +277,7 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
     vfio_intx_update(vdev, &vdev->intx.route);
 }
 
-static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
     Error *err = NULL;
@@ -351,7 +351,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
 /*
  * MSI/X
  */
-static void vfio_msi_interrupt(void *opaque)
+void vfio_msi_interrupt(void *opaque)
 {
     VFIOMSIVector *vector = opaque;
     VFIOPCIDevice *vdev = vector->vdev;
@@ -474,8 +474,8 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
     return ret;
 }
 
-static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
-                                  int vector_n, bool msix)
+void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
+                           int vector_n, bool msix)
 {
     if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
         return;
@@ -529,7 +529,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
     kvm_irqchip_commit_routes(kvm_state);
 }
 
-static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
+void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = &vdev->pdev;
@@ -640,13 +640,12 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     return 0;
 }
 
-static int vfio_msix_vector_use(PCIDevice *pdev,
-                                unsigned int nr, MSIMessage msg)
+int vfio_msix_vector_use(PCIDevice *pdev, unsigned int nr, MSIMessage msg)
 {
     return vfio_msix_vector_do_use(pdev, nr, &msg, vfio_msi_interrupt);
 }
 
-static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
+void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
@@ -673,14 +672,14 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
     }
 }
 
-static void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
+void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     assert(!vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = true;
     vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
 }
 
-static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
+void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -2587,7 +2586,7 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
     return OBJECT(vdev);
 }
 
-static bool vfio_msix_present(void *opaque, int version_id)
+bool vfio_msix_present(void *opaque, int version_id)
 {
     PCIDevice *pdev = opaque;
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 43c1666..49faf57 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -197,6 +197,18 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
     return class == PCI_CLASS_DISPLAY_VGA;
 }
 
+/* MSI/MSI-X/INTx */
+void vfio_vector_init(VFIOPCIDevice *vdev, int nr);
+void vfio_msi_interrupt(void *opaque);
+void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
+                           int vector_n, bool msix);
+int vfio_msix_vector_use(PCIDevice *pdev, unsigned int nr, MSIMessage msg);
+void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr);
+bool vfio_msix_present(void *opaque, int version_id);
+void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
+void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
+bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp);
+
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
-- 
1.8.3.1



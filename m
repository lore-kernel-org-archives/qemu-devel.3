Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0A2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVA0-00057S-AA; Mon, 12 May 2025 11:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9i-0004Y9-Nl
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9g-0006gi-G9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:26 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9eI9017594;
 Mon, 12 May 2025 15:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=Qx2rBXYk2HKbeFdxrv8SRi6W8Cz/qtENT7p3cr5JYxs=; b=
 flv+HWLoyl6QN7UJHMFhsneOGMpqClmybW9XU8Pjc9aL+LrTIUSMglHmvjsC0jyC
 VAUuUDBJGp4dfVydOvIJztfID3yMZqbqQBCIBhzKWC+7UQpwx8aFRZJFJUuxcrTx
 F4JknseL4hcUTUiG9aMhMMI/e0cM6NeKMU+DXhzOavFlXF8SjzK8UaFFUG/VToaz
 qnC/lUT/HxCUnQCj8sy0qEc9mfcTW9KH88Gefr+NDEz0NFDqz8PX2bmu3jPdw5pu
 PfgQ4aS1ogItqSj6on8GFQe1M5Xl2GxnUtkbliAjaF71S5vOKJyW4VyUH6wGIAad
 nskNocb6hjOtKgbakulVag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059tvft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEI9FX002457; Mon, 12 May 2025 15:33:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366ja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:11 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5K030605;
 Mon, 12 May 2025 15:33:10 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-22; Mon, 12 May 2025 15:33:10 +0000
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
Subject: [PATCH V3 21/42] vfio/pci: export MSI functions
Date: Mon, 12 May 2025 08:32:32 -0700
Message-Id: <1747063973-124548-22-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX+vfh0KYLIm8i
 dFAOgrTR8aYTnvr10zk8v5B6gXG7EH+aet6PJ52kmCsbmSKgEiKxrCe5vmCY+Wb51xW4Uphp5k6
 TBxFCsSgfv962BiTNZVZaP2LIH6D8LlfSQuxmQAi75nwRkoyMQ8Z6Fm84BwpDRJ03ROX8nXiQUU
 7UkR6dMsio2NRiVygTWjxNGnt6ljXzgVhT/CHP/GtNNONiIszCEVN2BfIydYXvfQMfBOUOvII/0
 SyioE0XoXTm6pM5T5Ro1ILdnbdVYG+mg3DXfPR5sGqTdL7ODh+m8RYfosBXr50wwllwxr+wVYxq
 xjFcDBzyG1/FiIP5QAmFphGgfrfWZHqJOnUfCJPQXEODVnr7m6GuZrcAxrhWoJBu8tWfPXI3Fj5
 nWgmoVYgxVpr3fegcND3fRVYIXyXR3xdEnFTD7WDqfTuaRunUqIPG09mduA6hb9P4tiNV32n
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682214b7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=btuZ-Ae0IaEO041L-RMA:9
X-Proofpoint-ORIG-GUID: RShJeieCBeJBIydneEo-eZbpzRmocJ9p
X-Proofpoint-GUID: RShJeieCBeJBIydneEo-eZbpzRmocJ9p
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Export various MSI functions, for use by CPR in subsequent patches.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 21 ++++++++++-----------
 hw/vfio/pci.h | 12 ++++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d2b08a3..1bca415 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -279,7 +279,7 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
     vfio_intx_update(vdev, &vdev->intx.route);
 }
 
-static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
     Error *err = NULL;
@@ -353,7 +353,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
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
@@ -641,13 +641,12 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
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
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
@@ -674,14 +673,14 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
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
 
@@ -2632,7 +2631,7 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
     return OBJECT(vdev);
 }
 
-static bool vfio_msix_present(void *opaque, int version_id)
+bool vfio_msix_present(void *opaque, int version_id)
 {
     PCIDevice *pdev = opaque;
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ce0fb9..c892054 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -210,6 +210,18 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
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



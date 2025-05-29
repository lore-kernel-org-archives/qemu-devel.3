Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB60C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisn-0004Jo-MU; Thu, 29 May 2025 15:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisO-0004BO-MO
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisL-0000Ex-AP
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsE4009707;
 Thu, 29 May 2025 19:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=HqyIbM+FEe0z0QQ8zQ9yjrriGXdtSdCweGCsMBFysCA=; b=
 r07pMbsy9WgkMFjmHdgQ2znAsephXAt4Mv5Z3iLYdgEl7uRVXn/uzYSEUk7wZZU4
 z0m6A34jHkwkTv3JuXrP4ZKhXuc1XbGBmCmB6l41S2dj94C8mLIaFYc78BvTWq7G
 oSR8DpQVON/lrar6q6EzXBaCkvxrGhst3B4KiBRgv5wMju+IiVhtUbWlCaUzZtm/
 8ALt9aSKlMiDCSJNeEeJNS8CuOKWxQ3Yhb9H/0Q3Es15GvyYqZdLQae0KNTejt8R
 kaxID7i8fQsTA5WFl7EdSH6o1LP48CIn8LyB5F822FLHClReK4NKWL0b/bMAjNep
 e1YrCahwZIFkxy6N+VLzAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u0yut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THgu8N020363; Thu, 29 May 2025 19:25:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:00 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRX022158;
 Thu, 29 May 2025 19:24:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-24; Thu, 29 May 2025 19:24:59 +0000
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
Subject: [PATCH V4 23/43] vfio/pci: export MSI functions
Date: Thu, 29 May 2025 12:24:19 -0700
Message-Id: <1748546679-154091-24-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: QjTCOOkbZQmTubmA56aZ8_zTD5WOR-af
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX4qqGvSF0MEaU
 0eTf3aC1rRq/qzcha1r8fvpxnYiU876M/LmgQENjhqme5cwsKYJTU87Kc9fGEOtWYcJVMy4/VJ9
 pztr+kB5fOxRxObUz474K78c3CDUwQ0nJ6ApIaAjSfcUijSZ1I4p1G/1ZAqpNiihTfpAQRxjzw2
 WZliVlnb3s+rvyxKqJN7NvJRApsmYQPMaLfKRNR3dpan5fSr0i312NhF+CCO7aDyihUi8CMa+ow
 wuV49P6U2aDfgZ1KnQtzeZXCVEgcKxwMs3lbis0CJiZtByy+odL1lAXmhIuq2D0CRbQjM6jqHjV
 dr2sz5CA/mjJBTIolT1F4pjO/6IRzEV/oNXC+VKKG9dFPLZFAFPedXh/4kiUO8DMg0XPtm+Vl7h
 P1T/JtNvs+B67tcsPXdNk/LJkyPRYg59JO2+mfX4jGk9HhTLZzfT1xl91ne+z/a7isa5PlfW
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6838b48c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=V8Kzaf1nqGCOsZu2D94A:9
X-Proofpoint-ORIG-GUID: QjTCOOkbZQmTubmA56aZ8_zTD5WOR-af
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

Export various MSI functions, renamed with a vfio_pci prefix, for use by
CPR in subsequent patches.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.h |  8 ++++++++
 hw/vfio/pci.c | 29 +++++++++++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ce0fb9..6e4840d 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -210,6 +210,14 @@ static inline bool vfio_is_vga(VFIOPCIDevice *vdev)
     return class == PCI_CLASS_DISPLAY_VGA;
 }
 
+/* MSI/MSI-X/INTx */
+void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr);
+void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
+                               int vector_n, bool msix);
+void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
+void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
+bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
+
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6aa37fe..13d7c84 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -351,6 +351,11 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
     trace_vfio_intx_disable(vdev->vbasedev.name);
 }
 
+bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp)
+{
+    return vfio_intx_enable(vdev, errp);
+}
+
 /*
  * MSI/X
  */
@@ -475,8 +480,8 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
     return ret;
 }
 
-static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
-                                  int vector_n, bool msix)
+void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
+                               int vector_n, bool msix)
 {
     if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
         return;
@@ -530,7 +535,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
     kvm_irqchip_commit_routes(kvm_state);
 }
 
-static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
+void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = &vdev->pdev;
@@ -580,10 +585,10 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     } else {
         if (msg) {
             if (vdev->defer_kvm_irq_routing) {
-                vfio_add_kvm_msi_virq(vdev, vector, nr, true);
+                vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
             } else {
                 vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
-                vfio_add_kvm_msi_virq(vdev, vector, nr, true);
+                vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector, nr);
             }
@@ -676,14 +681,14 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
     }
 }
 
-static void vfio_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
+void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     assert(!vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = true;
     vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
 }
 
-static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
+void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -713,14 +718,14 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
      * routes once rather than per vector provides a substantial
      * performance improvement.
      */
-    vfio_prepare_kvm_msi_virq_batch(vdev);
+    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
 
     if (msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
                                   vfio_msix_vector_release, NULL)) {
         error_report("vfio: msix_set_vector_notifiers failed");
     }
 
-    vfio_commit_kvm_msi_virq_batch(vdev);
+    vfio_pci_commit_kvm_msi_virq_batch(vdev);
 
     if (vdev->nr_vectors) {
         ret = vfio_enable_vectors(vdev, true);
@@ -764,7 +769,7 @@ retry:
      * Deferring to commit the KVM routes once rather than per vector
      * provides a substantial performance improvement.
      */
-    vfio_prepare_kvm_msi_virq_batch(vdev);
+    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
 
     vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->nr_vectors);
 
@@ -788,10 +793,10 @@ retry:
          * Attempt to enable route through KVM irqchip,
          * default to userspace handling if unavailable.
          */
-        vfio_add_kvm_msi_virq(vdev, vector, i, false);
+        vfio_pci_add_kvm_msi_virq(vdev, vector, i, false);
     }
 
-    vfio_commit_kvm_msi_virq_batch(vdev);
+    vfio_pci_commit_kvm_msi_virq_batch(vdev);
 
     /* Set interrupt type prior to possible interrupts */
     vdev->interrupt = VFIO_INT_MSI;
-- 
1.8.3.1



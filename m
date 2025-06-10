Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCCEC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP276-0001ut-7K; Tue, 10 Jun 2025 12:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15N-0004Sv-Om
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15L-0006CN-IX
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:25 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXcug027850;
 Tue, 10 Jun 2025 15:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=mZNyeOE1c3+P02VWBgfrMAQPIj4o3h1xSiTOAOx7fl8=; b=
 VkhEILjdywSa00B3T/d4V1QWEYokxzDIisFtOUGsN3XZ9vSi/LP0adXZURGjEu+4
 jtVZeS49pzUYipf9mD8iP1c7c7iz3ZOepwzLwtVPB37K7u5lvRnsp8fqPLme/aC4
 SqV7ZuS47/4meKtFqIithejDIKKtdnu1gfzcfnS62E9teBbH/FvQAaWXj9QwWYBT
 Vsj+p4hVQQPRBiCoM/UrstCht9ayY4Wq5nUzNGxmPNiHLN9nz8d38C9P6Ov2CtX+
 rSCULebBEkeID3GgQSd3j3GX8jItNUePF0qU/4ajWbt28OHktHY8tQ+OCdgVyzlr
 tFiCmdggdQ0KwyTYh2Qz2A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbech60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AF0Xvf003202; Tue, 10 Jun 2025 15:40:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wb9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrff028825;
 Tue, 10 Jun 2025 15:40:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-18; Tue, 10 Jun 2025 15:40:18 +0000
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
Subject: [PATCH V5 17/38] vfio/pci: export MSI functions
Date: Tue, 10 Jun 2025 08:39:30 -0700
Message-Id: <1749569991-25171-18-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: j4rbHk7lcGdNgwu0w3TWuBtc49qxUlMp
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=684851e4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=tmrsQydYa56TIWcunzAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: j4rbHk7lcGdNgwu0w3TWuBtc49qxUlMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXxQ9887p667uh
 riDEqr1bMvZ2cnyW7p8MJ+SzED71Eeix1qFT4HOdrCGUjzcwUPVz9WDG3Q3p6sqvBaFPXYsXmdl
 0hErBxFtJzf+MyeYQW2+7DlOO1zCwxFFiRbdaN1TjaAj4b4sCH2XGiefxSonq/kuQ3HBkjG5QAS
 7OyIybfIgEUrRG6foEqcpipKYQ0XY8HCpviZIxWQRHUf8lD8b/w/80wd6DroITmJhaWiMTNXZpe
 FqWramNZlA4KbAWofnD9GZwOfQX+Mhe4Wn6tnglqHkt7rQwUWBRsKq4oKoQjMa8scVhk420VjkN
 8XEVD/ZMk4SwmEXH8371oZGl5nVf9tYvvpwzbTW7yArzP/+HOyVP/liiMNSjnCDlfM1r4WqV5IU
 jtnKP+XIPY4t/Vuabx1rvw4NuZO968OCRFtcFXiVydR+4VgV4w1fByTFKI1m1dHbaqu0L3+m
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Export various MSI functions, renamed with a vfio_pci prefix, for use by
CPR in subsequent patches.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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
index 508701c..4cda6dc 100644
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
@@ -549,7 +554,7 @@ static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
     }
 }
 
-static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
+void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = &vdev->pdev;
@@ -599,10 +604,10 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
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
@@ -681,14 +686,14 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
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
 
@@ -718,14 +723,14 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
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
@@ -769,7 +774,7 @@ retry:
      * Deferring to commit the KVM routes once rather than per vector
      * provides a substantial performance improvement.
      */
-    vfio_prepare_kvm_msi_virq_batch(vdev);
+    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
 
     vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->nr_vectors);
 
@@ -793,10 +798,10 @@ retry:
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



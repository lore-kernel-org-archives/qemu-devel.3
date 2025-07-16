Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E43C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6Z1-0005iG-Sf; Wed, 16 Jul 2025 14:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6WM-0003tA-P9
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:06:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6WK-0006Wo-R2
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:06:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHgP4w026740;
 Wed, 16 Jul 2025 18:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0HA4wTO4mzfLXU7dYzl7CSy+ijdhBue+GZMIu0IWqh8=; b=
 Ae+AQKb9CuVvLnkZoubYZZG7+bgRChkgPxHmOLcYtG5a/nT7GSkAlGgfX55bnsCh
 HFR2hKsY60DeRwlukXgbnDZu/bJ7Dp83FqAXwLCVyivdSa8qrKeiXEWtgFBuSVTx
 bLwju3hvzFdXyUCmfFA0WeQOBcLUmp027xlzYkzLobESXhv8pNTQFCyF0/g5QSkx
 5Dw/LhZFGJ2zBL//7bFUeqNMobB1L3RSIWQpjK0c581E7JqhjLYlVvusD8jj80tm
 4AXGYkjgQFnA8hgUZdGWtds1wA+wSKyLiiNFPd0Sc6J4cxWNq2dA0RL64ERQud4Q
 ZLtCN/6+eN1Ddncp+jZbsw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g1jbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 18:06:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56GH5X88039704; Wed, 16 Jul 2025 18:06:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5bq5ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 18:06:12 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56GI5BvF002385;
 Wed, 16 Jul 2025 18:06:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5bq5tx-2; Wed, 16 Jul 2025 18:06:11 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 1/2] vfio/pci: augment set_handler
Date: Wed, 16 Jul 2025 11:06:08 -0700
Message-Id: <1752689169-233452-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
References: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160163
X-Proofpoint-ORIG-GUID: 4yMk2SxD5xdQKRwIMnpITvwWnAxssTcO
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=6877ea1a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=L_EaPDnd0c-cMekQ7JYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: 4yMk2SxD5xdQKRwIMnpITvwWnAxssTcO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2MyBTYWx0ZWRfX6d4jrlBTVEnC
 Pk21Gkog++qKebogWUucQDzXNumtTvU4leHnpXw4xjqPfVEVSxAdIEvkcCSrOAxAjNxrEsRyqm+
 xFjMDK40M9M6i7mHMZD2hfyEyG+PXNmM+Cj4cMoeEs7rEC3o2DjczJNpb52/HsdKjDyV4XXZRwo
 dG1hsq4hvg2bq8aCxtwsJHzjRJPX/wLGcoJGXZ23WyUigMC3YVPUBUKeBO6oHaP9H+WjPk/B4Z6
 5kh9fOFl5FahIea8xhSZyzoL/OFVqjVW3HNVMpiGOz4o7xpaBjhupfMfothLZX03yzJR/dmOk98
 bqdjtIe6bPq5As7KlST8N3BZ0iJQK2kvcPxIgvaX7eU6ekPMRJ4txvrwdYD2innDAziAB9S47c8
 AEkhDv2nCHU6osf3sgwEHyaDdrPVGaPUV9hr8sqbQ/LMZjkSD5lSKgb99gkIeYNDkIyOoC8s
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Extend vfio_pci_msi_set_handler() so it can set or clear the handler.
Add a similar accessor for INTx.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr.c |  2 +-
 hw/vfio/pci.c | 13 +++++++++++--
 hw/vfio/pci.h |  3 ++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index af0f12a7ad..2a244fc4b6 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -70,7 +70,7 @@ static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
         fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
         if (fd >= 0) {
             vfio_pci_vector_init(vdev, i);
-            vfio_pci_msi_set_handler(vdev, i);
+            vfio_pci_msi_set_handler(vdev, i, true);
         }
 
         if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1093b28df7..8b471c054a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -415,6 +415,14 @@ bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     return vfio_intx_enable(vdev, errp);
 }
 
+void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable)
+{
+    int fd = event_notifier_get_fd(&vdev->intx.interrupt);
+    IOHandler *handler = (enable ? vfio_intx_interrupt : NULL);
+
+    qemu_set_fd_handler(fd, handler, NULL, vdev);
+}
+
 /*
  * MSI/X
  */
@@ -453,12 +461,13 @@ static void vfio_msi_interrupt(void *opaque)
     notify(&vdev->pdev, nr);
 }
 
-void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
+void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     int fd = event_notifier_get_fd(&vector->interrupt);
+    IOHandler *handler = (enable ? vfio_msi_interrupt : NULL);
 
-    qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
+    qemu_set_fd_handler(fd, handler, NULL, vector);
 }
 
 /*
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 495fae737d..80c8fcfa07 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,8 +218,9 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
 void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
 void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
 bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable);
 void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
-void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr);
+void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable);
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
-- 
2.39.3



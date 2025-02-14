Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35DBC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwTC-0005EK-5f; Fri, 14 Feb 2025 09:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwT8-00056P-9B
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwT6-0004Ue-K6
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:02 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECteQB002102;
 Fri, 14 Feb 2025 14:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=1TLnU8WpA/v27WOQ3L6Dkn5Vvy+ojGBtj2U5fbK8qRo=; b=
 j2IyHA7t9QqvkcM7lWGS5mDNu8j4Bq7rjlR2DtR9zT/hZvu5xGCLyTeEbj1PekOF
 6FbAX9MtXoMdiYgtRZclgDS9C++jXP9g5xu9EVtmAGturyO4xG107Zl+23hjlBwc
 aOpBHQmVEmkb8pdPGHttn3pG6viFj9F7ozwuosR2H9VjddV/p9jiSzdrPHiu55vj
 tfCQIevmMG67ZheoVlq+NERdZlLFaW35BnJxYyWPBrgJ8Ef9u36Vw7i+VOQrsHx1
 hgyKQLzGDh1g/39gQUs0KVWHOuqScnXJQWNaz6Rl1rvtKeu38NlbAmZecp7NXYHB
 MKEWz3K7Nmk1zh8FCAZ4cg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyusvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECog1I025151; Fri, 14 Feb 2025 14:14:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksgg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPr006920;
 Fri, 14 Feb 2025 14:14:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-21; Fri, 14 Feb 2025 14:14:55 +0000
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
Subject: [PATCH V2 20/45] vfio/pci: pass vector to virq functions
Date: Fri, 14 Feb 2025 06:14:02 -0800
Message-Id: <1739542467-226739-21-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: jJH0Nzfuc1Eqh9o82nAMlzOLf74cQ3yx
X-Proofpoint-GUID: jJH0Nzfuc1Eqh9o82nAMlzOLf74cQ3yx
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

Pass the vector number to vfio_connect_kvm_msi_virq and
vfio_remove_kvm_msi_virq, so it can be passed to their subroutines in
a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 688b7d3..7b2d185 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -477,7 +477,7 @@ static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
                                              vector_n, &vdev->pdev);
 }
 
-static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
+static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
 {
     const char *name = "kvm_interrupt";
 
@@ -503,7 +503,8 @@ fail_notifier:
     vector->virq = -1;
 }
 
-static void vfio_remove_kvm_msi_virq(VFIOMSIVector *vector)
+static void vfio_remove_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
+                                     int nr)
 {
     kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vector->kvm_interrupt,
                                           vector->virq);
@@ -561,7 +562,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
      */
     if (vector->virq >= 0) {
         if (!msg) {
-            vfio_remove_kvm_msi_virq(vector);
+            vfio_remove_kvm_msi_virq(vdev, vector, nr);
         } else {
             vfio_update_kvm_msi_virq(vector, *msg, pdev);
         }
@@ -573,7 +574,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
                 vfio_add_kvm_msi_virq(vdev, vector, nr, true);
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
-                vfio_connect_kvm_msi_virq(vector);
+                vfio_connect_kvm_msi_virq(vector, nr);
             }
         }
     }
@@ -680,7 +681,7 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
     kvm_irqchip_commit_route_changes(&vfio_route_change);
 
     for (i = 0; i < vdev->nr_vectors; i++) {
-        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i]);
+        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i], i);
     }
 }
 
@@ -817,7 +818,7 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
         VFIOMSIVector *vector = &vdev->msi_vectors[i];
         if (vdev->msi_vectors[i].use) {
             if (vector->virq >= 0) {
-                vfio_remove_kvm_msi_virq(vector);
+                vfio_remove_kvm_msi_virq(vdev, vector, i);
             }
             qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
                                 NULL, NULL, NULL);
-- 
1.8.3.1



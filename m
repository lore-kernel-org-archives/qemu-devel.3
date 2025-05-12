Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F154DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9o-0004lk-TO; Mon, 12 May 2025 11:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9g-0004VK-EJ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9e-0006gQ-DD
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:24 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CCAADm019736;
 Mon, 12 May 2025 15:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=tais4lZPWezEi902l5LKBZWxLfdcn9K8XK/NbQRmZPo=; b=
 NejpGcGxiSMPUZmtXEsoUP7OPu5cLJ+FZ5iP58ms3eAVDzL327jSMfax7bQD0tEs
 l5elHG0hK0/LOatQSAkLniZ5qsnXO2R6Z+Gd8dzjPRxiIlFPgfTgz9VbsOj5vhPt
 W+g8yA+OP1fc0QeS/59VYdw0mubmH2vawgc1wZ/BJ0YGUzaSXejn3pkpIQ3ECjW0
 45HnLzYe10FCrp2jAEz9c4yI5dohPRWpJoq7HZgoB3bvTZ212sJG0MHNLUm/ZJq1
 OSLq2ExVOcPLRZzYwtGK48G3LwyFcb6eCkbbzzdxpR1ZjSD3rm7bEtP295A7Vnv7
 NdPQRSGizURIgbUdeXQF0Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2sdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE0qCR002414; Mon, 12 May 2025 15:33:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366fj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5E030605;
 Mon, 12 May 2025 15:33:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-19; Mon, 12 May 2025 15:33:07 +0000
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
Subject: [PATCH V3 18/42] vfio/pci: pass vector to virq functions
Date: Mon, 12 May 2025 08:32:29 -0700
Message-Id: <1747063973-124548-19-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX3r2jfxOlWfwX
 eiWRNWm/8hwR+1SYGC+cvs/AetYKsqnZvFLsP2im2Wj+wPoW4o5qBUzJNezekPLIBKunf4KVsui
 2ospSdt2p3os1WluYux7O3BD+DEI3mA5s2W7gwMBShE6foRWR5T3EO/icoT/2xoQAWi7hoEbmOT
 yERFac4qXadW6kwgNIWaBO7hhUKnRZCLXlbrhexny1QX2UzOFm2WyjdY2T33ORhE5WA1BItwOXd
 XvkA6twl3FOMeWiTqkPkZtiHd7OBqr4S8JLUPXQVtGyC8WIH9t7nwaiKFeO+HCLceChvGW9gNWp
 4XUCwdaVeSbiLZ7hqZChIj/aJ79v+kUdHF1JEopuP4OavVyxh62y2UJ/mcFh8cTvmoXHDFyYKfq
 uOS0WveI5eiNbXtoDaBlEdlylz1O8MNCJ5AXj6W2g49SrsW4iLp5vlUbcr1I7lnJdqySd4FU
X-Proofpoint-GUID: HdsUD-rtamP_U12wuj0GzlY03JPqVUzN
X-Proofpoint-ORIG-GUID: HdsUD-rtamP_U12wuj0GzlY03JPqVUzN
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214b5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=KuRfteT1783q8DwuiuAA:9
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

Pass the vector number to vfio_connect_kvm_msi_virq and
vfio_remove_kvm_msi_virq, so it can be passed to their subroutines in
a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4159deb..dad6209 100644
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
@@ -681,7 +682,7 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
     kvm_irqchip_commit_route_changes(&vfio_route_change);
 
     for (i = 0; i < vdev->nr_vectors; i++) {
-        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i]);
+        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i], i);
     }
 }
 
@@ -821,7 +822,7 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
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



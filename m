Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F531C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLOe-0002tA-8S; Mon, 14 Jul 2025 11:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKAU-0007bf-S1
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:28:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKAL-0002XW-BQ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:28:33 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z4t1001264;
 Mon, 14 Jul 2025 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=v9k/mku2MsrMxCPoT/ZZQ3ZjzmB3Vu5APEpDIKkgEic=; b=
 k+ygHiRsQKXWAIumZ01yHEG9NfpguG5llELiP/N/rybpJh79mfypSqWwQReXIanM
 dVf1cUO/48G+pgptLJ/eCh6gZG4FJItj5YwgmYTFl3f4a/a3MEbWtpsvakjsGgYS
 XBIkwMgy6EhkbX+KssAw/Ewyr3em2xlz79NjGVyKYk5y41mQkbYGYWMNIXbUJexy
 fzw/5rEdBR3cdG5DnR3mjinq3/bKZJ5GAq/0fTO3tXn3iQvpb34c1DBne6GuxrwG
 eFWcLFB0XdnVSt2Scj/FBPFYBuO7b2yi3/Zs5CsHAMc36o3IY0kPUVoTuqa9E5MC
 UgYxwuKFyA/jJAVBoShgwg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fv836-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56ED84Sl011692; Mon, 14 Jul 2025 14:27:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58kgg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EER3Mv039980;
 Mon, 14 Jul 2025 14:27:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue58kgf3-2; Mon, 14 Jul 2025 14:27:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 1/2] vfio/pci: augment set_handler
Date: Mon, 14 Jul 2025 07:27:01 -0700
Message-Id: <1752503222-222669-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752503222-222669-1-git-send-email-steven.sistare@oracle.com>
References: <1752503222-222669-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140085
X-Proofpoint-ORIG-GUID: 8Pzu8MKGJ1LbaY8hZ--Ufz49ZIiqgEk2
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687513ba b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=L_EaPDnd0c-cMekQ7JYA:9 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: 8Pzu8MKGJ1LbaY8hZ--Ufz49ZIiqgEk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NSBTYWx0ZWRfX3ntQoflepAhz
 E37Yz+SgpH5rnRUwkzsonXn7gv8Umtxhd8pbTk+c4R3YuVfvqfNsQLdJ9EtE4Es2udnDAe/drk5
 2hmPz6lDraAaUemOm34cgxKKUFQxR5YCoeOOEAVauHLPfvG7lET6gcfyj+DAsh8XeLRPMyCo90p
 vLxjwbULcg8VXaX02rEmstbqVgC/ru+8bjcAVfMybE3k2d6z1sbq+eFAjcNCG+ZgZFEq56lKR9L
 LGu3a0PbJFXfzkX2QVMCczYOVrT2re34pE/2F/3uNlQwwLqfDzPvFy9BjAPHd+ZirEf2DL0ilU7
 Q4wNZy4MRoQTSvEnYR0Di/s12q6WWGs4z3b23ndmOYp2d7wCZ9XkejZGRpj+z2vSoHFLP/Ny+3R
 oLNi5vgQKvACwfyd0eUy3e2Lg8IPZrv/nb0NoJvKolqelaHxdV3virgovpUMuyqESEwLLf8w
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



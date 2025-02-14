Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD7DC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwTP-0005me-Mz; Fri, 14 Feb 2025 09:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTK-0005Zh-7L
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTH-0004Uk-F4
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:13 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtUQv017777;
 Fri, 14 Feb 2025 14:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=PmsytVwoBKbySCvQqfdLb/N4Rogz3pa//tRNboKj3SM=; b=
 Hsnx6mi8GygqiUDZ5WZEqZ4Gp3urAm5Q+AGwQuf+gHBxTgdXO43L2+nFp8vTpJxe
 nEa+GCLnrFDq2aPbLTwg4tr3j6rwqkhzWu4vd8ox+C/V92v72S3PeSv8p2X31GQH
 ZQVAIhu10Nx4PKeK07JSIRW+7PbekhCTRqibWSTm+cDo+qwF2SK0FU+YAKwBIi4k
 wAPGGohxV4j4//VNscdfHnHPAycLnWNq2djK9V7MGYkCKE5uvORlhNN7c5JHExdH
 EbObVDD/kxfFF7x+wVszLb6u+Q3s23MycW1ZOdsR1jd/vibDMGREW5Uh007up2ZB
 ZNVdKHbCfG0DoWVVdIohBg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tgbtw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECelZ4025288; Fri, 14 Feb 2025 14:14:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksgh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:57 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPt006920;
 Fri, 14 Feb 2025 14:14:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-22; Fri, 14 Feb 2025 14:14:57 +0000
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
Subject: [PATCH V2 21/45] vfio/pci: vfio_notifier_init cpr parameters
Date: Fri, 14 Feb 2025 06:14:03 -0800
Message-Id: <1739542467-226739-22-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: zsOkuO0ATAr91Zpl0RhGy27sF95gtiIf
X-Proofpoint-ORIG-GUID: zsOkuO0ATAr91Zpl0RhGy27sF95gtiIf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Pass vdev and nr to vfio_notifier_init, for use by CPR in a subsequent
patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7b2d185..63fb2d9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -54,7 +54,8 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
-static bool vfio_notifier_init(EventNotifier *e, const char *name, Error **errp)
+static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
+                               const char *name, int nr, Error **errp)
 {
     int ret = event_notifier_init(e, 0);
 
@@ -144,7 +145,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     pci_irq_deassert(&vdev->pdev);
 
     /* Get an eventfd for resample/unmask */
-    if (!vfio_notifier_init(&vdev->intx.unmask, "intx-unmask", errp)) {
+    if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
         goto fail;
     }
 
@@ -297,7 +298,8 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     }
 #endif
 
-    if (!vfio_notifier_init(&vdev->intx.interrupt, "intx-interrupt", errp)) {
+    if (!vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0,
+                            errp)) {
         return false;
     }
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -485,7 +487,8 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
         return;
     }
 
-    if (!vfio_notifier_init(&vector->kvm_interrupt, name, NULL)) {
+    if (!vfio_notifier_init(vector->vdev, &vector->kvm_interrupt, name, nr,
+                            NULL)) {
         goto fail_notifier;
     }
 
@@ -528,7 +531,7 @@ static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
 
     vector->vdev = vdev;
     vector->virq = -1;
-    if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
+    if (!vfio_notifier_init(vdev, &vector->interrupt, "interrupt", nr, &err)) {
         error_report_err(err);
     }
     vector->use = true;
@@ -762,7 +765,8 @@ retry:
         vector->virq = -1;
         vector->use = true;
 
-        if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
+        if (!vfio_notifier_init(vdev, &vector->interrupt, "interrupt", i,
+                                &err)) {
             error_report_err(err);
         }
 
@@ -2875,7 +2879,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (!vfio_notifier_init(&vdev->err_notifier, "err_notifier", &err)) {
+    if (!vfio_notifier_init(vdev, &vdev->err_notifier, "err_notifier", 0,
+                            &err)) {
         error_report_err(err);
         vdev->pci_aer = false;
         return;
@@ -2941,7 +2946,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (!vfio_notifier_init(&vdev->req_notifier, "req_notifier", &err)) {
+    if (!vfio_notifier_init(vdev, &vdev->req_notifier, "req_notifier", 0,
+                            &err)) {
         error_report_err(err);
         return;
     }
-- 
1.8.3.1



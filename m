Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D2FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9n-0004cn-PQ; Mon, 12 May 2025 11:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9f-0004UK-Cr
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9d-0006gK-Dn
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9x3V018773;
 Mon, 12 May 2025 15:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=7GXCEUBcui7dEk6h4En7eDvmF2/xAi/yupSvWW7uD4c=; b=
 Fd4k+rOQ57Eeyi9luPKPbq3zXD1cDnIQA6NCoHJbX2QVQdKj5376k7/WuvR4bSRI
 8BvEPbpjiv5xd7gOSNguEtBJ3ch47Cx4+Jx97RCjmFSYaiMFCtg5a9Xw6vQFolIG
 Ur56mdZwoOUaXdvUmcwDxmdTOUhxKU8Fe+EOBgOBPs59wmznzIL1zXekiKMUygZ3
 apZ1iCnp/JCwCYVgwyrcEmjoN8NcxIuW9tmJbtL5dhuecY/3bGRS9gIYolfJAf9J
 8pU2YoqeVpIm7KY1fWx0dQh/MrKbocb6o6ixGfqCkt0jMFYTe/P3foAwrBZ+ULCb
 +V8B29h6LCBCo+dIwKcsIA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2sdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEI9FT002457; Mon, 12 May 2025 15:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366eq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5C030605;
 Mon, 12 May 2025 15:33:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-18; Mon, 12 May 2025 15:33:07 +0000
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
Subject: [PATCH V3 17/42] vfio/pci: vfio_notifier_init
Date: Mon, 12 May 2025 08:32:28 -0700
Message-Id: <1747063973-124548-18-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX/H2GRP8dSBfQ
 pOyVoI1aF4jgbQymZMNd+3Hs7r9CTWUAUk1fWvT6ym2cPR7f6n8gARNbdwP09oXL8sfqG/7Gidx
 d/uUno4ywljixx30QRxSBluq1mYRdFCPJjMB2G4vwi/AiRQlxf3tgeKp8HlMlOa7SYUHBslNd4M
 PoVcRLR5MPOtPwEgnivaXjCe0VsllhS43qsOpfHntm6DiP0yQQqe4+NmxTk06YT3u/vCQ8/gGuu
 phi9Avul+os6ZN1z/CwDJu5T8rZmw/N8TWWb/xd8KGDx8gT3BPj/kzygzZIiAMBR9bvfQGvkqVP
 EM/IkMI1L3AOqoavI3qAIySbZkE/eOtP2n4HsZTfJQr/znz7SyRPd46mMywE0sgHYP4+iJmVc/8
 aRKDREfkkesUlYsI5kYoAzn3Mq0GPFrrlHSzLvYeyuulWotB0m8uCYej6lsI0QViABMr70zX
X-Proofpoint-GUID: kj6I7A6zpwzIeM0N4_mVrqnZgp7-7IlQ
X-Proofpoint-ORIG-GUID: kj6I7A6zpwzIeM0N4_mVrqnZgp7-7IlQ
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214b4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=w3t5z44oxExOTv3jo9sA:9
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

Move event_notifier_init calls to a helper vfio_notifier_init.
This version is trivial, but it will be expanded to support CPR
in subsequent patches.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b46c42e..4159deb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -56,6 +56,16 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
+static bool vfio_notifier_init(EventNotifier *e, const char *name, Error **errp)
+{
+    int ret = event_notifier_init(e, 0);
+
+    if (ret) {
+        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
+    }
+    return !ret;
+}
+
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
  * also be a huge overhead.  We try to get the best of both worlds by
@@ -136,8 +146,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     pci_irq_deassert(&vdev->pdev);
 
     /* Get an eventfd for resample/unmask */
-    if (event_notifier_init(&vdev->intx.unmask, 0)) {
-        error_setg(errp, "event_notifier_init failed eoi");
+    if (!vfio_notifier_init(&vdev->intx.unmask, "intx-unmask", errp)) {
         goto fail;
     }
 
@@ -268,7 +277,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
     Error *err = NULL;
     int32_t fd;
-    int ret;
 
 
     if (!pin) {
@@ -291,9 +299,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     }
 #endif
 
-    ret = event_notifier_init(&vdev->intx.interrupt, 0);
-    if (ret) {
-        error_setg_errno(errp, -ret, "event_notifier_init failed");
+    if (!vfio_notifier_init(&vdev->intx.interrupt, "intx-interrupt", errp)) {
         return false;
     }
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -473,11 +479,13 @@ static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
 
 static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
 {
+    const char *name = "kvm_interrupt";
+
     if (vector->virq < 0) {
         return;
     }
 
-    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
+    if (!vfio_notifier_init(&vector->kvm_interrupt, name, NULL)) {
         goto fail_notifier;
     }
 
@@ -515,11 +523,12 @@ static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = &vdev->pdev;
+    Error *err = NULL;
 
     vector->vdev = vdev;
     vector->virq = -1;
-    if (event_notifier_init(&vector->interrupt, 0)) {
-        error_report("vfio: Error: event_notifier_init failed");
+    if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
+        error_report_err(err);
     }
     vector->use = true;
     if (vdev->interrupt == VFIO_INT_MSIX) {
@@ -749,13 +758,14 @@ retry:
 
     for (i = 0; i < vdev->nr_vectors; i++) {
         VFIOMSIVector *vector = &vdev->msi_vectors[i];
+        Error *err = NULL;
 
         vector->vdev = vdev;
         vector->virq = -1;
         vector->use = true;
 
-        if (event_notifier_init(&vector->interrupt, 0)) {
-            error_report("vfio: Error: event_notifier_init failed");
+        if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
+            error_report_err(err);
         }
 
         qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
@@ -2907,8 +2917,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (event_notifier_init(&vdev->err_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for error detection");
+    if (!vfio_notifier_init(&vdev->err_notifier, "err_notifier", &err)) {
+        error_report_err(err);
         vdev->pci_aer = false;
         return;
     }
@@ -2974,8 +2984,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (event_notifier_init(&vdev->req_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for device request");
+    if (!vfio_notifier_init(&vdev->req_notifier, "req_notifier", &err)) {
+        error_report_err(err);
         return;
     }
 
-- 
1.8.3.1



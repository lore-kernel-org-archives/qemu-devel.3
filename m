Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A20C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27j-0002oj-VE; Tue, 10 Jun 2025 12:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15J-0004Qa-Mm
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15H-0006BR-OH
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:21 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXdQ7031132;
 Tue, 10 Jun 2025 15:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=7KjLChNKYftLDBg2MG/3EU+4ngFSxntqkzJpHXBx8bc=; b=
 leQAHdnwtQ+Ur/Z37chleNW9LI+wOBw0hEPAhZTPJ2eKms+CeTkzgx2t2cgSr+Ca
 R/9l2FF2HIPphwzM9rykc3TF9IVT+Dkncw1/8P+cDYykcTXlTao/PVlLHuv6mDdK
 0QKpsBHNsgv7Pda0OYnkl4aiQum3rAyB4gmJWANe64KX6ERHy7xeKzY+h4uvldpX
 uEWF5tBJl1DK7ASl0eWIlOiHVFMKD1z1GrLovczNv9xBxN369cxXbSMLuZ0OAiRq
 Q9L1L0QzZYl6Lr/iOyWM2AakQddJpvMAI4q9NJHYoSveYJiMW4G/FyuGvszq/vS5
 UbUcbGQp290q1lA+dgE6EA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywvgs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:17 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEiqkT003975; Tue, 10 Jun 2025 15:40:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wb68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:15 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfb028825;
 Tue, 10 Jun 2025 15:40:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-16; Tue, 10 Jun 2025 15:40:15 +0000
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
Subject: [PATCH V5 15/38] vfio/pci: vfio_notifier_init cpr parameters
Date: Tue, 10 Jun 2025 08:39:28 -0700
Message-Id: <1749569991-25171-16-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684851e1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=jRqgxlNjA3WZj7__-qIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: OK5aVthmea9Kr7atO5R2iI7CSWcoJfZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX7ZHhrPPWEqfV
 vIRr6BWTWrjlTmQOZjBnSfDiTDhcaLhWBp+qUqi/ILfyNmaHlA/AEtyExNAhMt5koYvNrI4s4Fk
 wCdtHEr+hYuESVx7uNCqASqe/M4EG23uA9F4o9wDZC/9mSKN6TxosHUaYeO0TnnjdMe0fWl/FC/
 GBFaSf9AoTVhjEWgqyva8uR6muUfKVUJJEPQTCFJbFWfrNHUnTQlh2sM2HVGxb0mFl8B3OXJFd2
 2sPIQqThACGLCPZKvaYuojPuK1xhs7IHgltSnBEMp6pET1vdplWc8we1hHZ3kzwkZOiKLzjScVt
 7bc2kFLtD9aG+YDwxsleXRbfJDwbpai4/0pf8ztGTAGT/KnPZubc2HEpm4aP+YM9bd2m89cHbRx
 x+bVt4wBKHpGvkorhmj0Niws5gjuakzh6bqDCfN3EykwiXOkNZuO+km1IMquomHoxfuYjF9j
X-Proofpoint-GUID: OK5aVthmea9Kr7atO5R2iI7CSWcoJfZZ
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

Pass vdev and nr to vfio_notifier_init, for use by CPR in a subsequent
patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e40402a..ebc1a4b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -57,7 +57,8 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
-static bool vfio_notifier_init(EventNotifier *e, const char *name, Error **errp)
+static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
+                               const char *name, int nr, Error **errp)
 {
     int ret = event_notifier_init(e, 0);
 
@@ -147,7 +148,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     pci_irq_deassert(&vdev->pdev);
 
     /* Get an eventfd for resample/unmask */
-    if (!vfio_notifier_init(&vdev->intx.unmask, "intx-unmask", errp)) {
+    if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
         goto fail;
     }
 
@@ -300,7 +301,8 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     }
 #endif
 
-    if (!vfio_notifier_init(&vdev->intx.interrupt, "intx-interrupt", errp)) {
+    if (!vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0,
+                            errp)) {
         return false;
     }
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -486,7 +488,8 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
         return;
     }
 
-    if (!vfio_notifier_init(&vector->kvm_interrupt, name, NULL)) {
+    if (!vfio_notifier_init(vector->vdev, &vector->kvm_interrupt, name, nr,
+                            NULL)) {
         goto fail_notifier;
     }
 
@@ -544,12 +547,13 @@ static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = &vdev->pdev;
-    Error *err = NULL;
+    Error *local_err = NULL;
 
     vector->vdev = vdev;
     vector->virq = -1;
-    if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
-        error_report_err(err);
+    if (!vfio_notifier_init(vdev, &vector->interrupt, "interrupt", nr,
+                            &local_err)) {
+        error_report_err(local_err);
     }
     vector->use = true;
     if (vdev->interrupt == VFIO_INT_MSIX) {
@@ -765,14 +769,15 @@ retry:
 
     for (i = 0; i < vdev->nr_vectors; i++) {
         VFIOMSIVector *vector = &vdev->msi_vectors[i];
-        Error *err = NULL;
+        Error *local_err = NULL;
 
         vector->vdev = vdev;
         vector->virq = -1;
         vector->use = true;
 
-        if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
-            error_report_err(err);
+        if (!vfio_notifier_init(vdev, &vector->interrupt, "interrupt", i,
+                                &local_err)) {
+            error_report_err(local_err);
         }
 
         qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
@@ -2936,7 +2941,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (!vfio_notifier_init(&vdev->err_notifier, "err_notifier", &err)) {
+    if (!vfio_notifier_init(vdev, &vdev->err_notifier, "err_notifier", 0,
+                            &err)) {
         error_report_err(err);
         vdev->pci_aer = false;
         return;
@@ -3003,7 +3009,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
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



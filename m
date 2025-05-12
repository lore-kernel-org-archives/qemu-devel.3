Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E57CC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9u-0004rc-F8; Mon, 12 May 2025 11:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9h-0004VL-0K
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9e-0006gU-LA
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:24 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9md0027390;
 Mon, 12 May 2025 15:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=J7O0G6R+T7Thp9NkLQR+2RFhO7PQo45vh9/97Q0mb98=; b=
 j0mAPbw6pPAHjphuONVmhINBKhXQG4Q7RKTyuG3ASEFNrBxkGAR4CM1SxOhXFBST
 zAsJ32dMKPIwnodfEuxao7113vQiz+iIKhdIls0WiRzTgRnz9ooIhChrjeLZfN92
 x5XnfGuHRW45JrS+YtJoCiUtzUf3Ok/akZvb8jq/hlLwqbw+B+QTkNjSZ571oGsZ
 u3M+jotkQSOVRDq19vOcpWMCyeqcaFsVTCBGsAqISqBoQN8wch+fHBF3WoXuCFRh
 31DBrhBgdkceE5XlTd/Xsg+HKIyPLfw9t6W/ZDX3diQROwVETnzb73h1odbcNt12
 j2HKyo74MHe86s6PZOvYQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1662us2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CERhNl002421; Mon, 12 May 2025 15:33:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:09 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5G030605;
 Mon, 12 May 2025 15:33:08 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-20; Mon, 12 May 2025 15:33:08 +0000
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
Subject: [PATCH V3 19/42] vfio/pci: vfio_notifier_init cpr parameters
Date: Mon, 12 May 2025 08:32:30 -0700
Message-Id: <1747063973-124548-20-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX/YthC5zGIwmh
 n640hUoicPEXmANpS3lP55yk5gq2h/Yx+og+inlHHs2gApGNcHJHUToxMJIGUm0D6IvWQoqTNuo
 KNlHefNHKR6ryGgbVoBWDKaaxqhRYnoVqEJoOO0M/vvf73bIBQNw0GxQ/MFv3CVvH8lqSFSdSjx
 zcLuG5YufO/NAyareqXw4r5dKV7MiJXWPzqBADd7gH7s2ArzZnFX/8A++GXWQaU/cgzVJpEDunf
 pwgcsZhAMqVKkytTKfBDTJQOYbhc0S+gHUJTGGoY700Lk/EtgqkLTVEEq+m76a1rhq11eLpP4J7
 o02CVD4+dn2Qaxe4Kul+9UvGQ0bGVmtc02vLt5xoeoqYDMaHOcC6hR3GjWlndIl0FZvFwW+6kBd
 c/uq/lkSzE7iO1wk8ExTo00AfjKN5gQ1H+BK2wT+dZz6xC0jLupAD0pU8FUWXAlkYrNgWKyI
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682214b6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=jKZADUptkdJhXbhI8koA:9
X-Proofpoint-ORIG-GUID: pUDHeHEFKARWUc13Cj5bBQ4mLxQatXEI
X-Proofpoint-GUID: pUDHeHEFKARWUc13Cj5bBQ4mLxQatXEI
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

Pass vdev and nr to vfio_notifier_init, for use by CPR in a subsequent
patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dad6209..bfeaafa 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -56,7 +56,8 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
-static bool vfio_notifier_init(EventNotifier *e, const char *name, Error **errp)
+static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
+                               const char *name, int nr, Error **errp)
 {
     int ret = event_notifier_init(e, 0);
 
@@ -146,7 +147,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     pci_irq_deassert(&vdev->pdev);
 
     /* Get an eventfd for resample/unmask */
-    if (!vfio_notifier_init(&vdev->intx.unmask, "intx-unmask", errp)) {
+    if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
         goto fail;
     }
 
@@ -299,7 +300,8 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
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
@@ -765,7 +768,8 @@ retry:
         vector->virq = -1;
         vector->use = true;
 
-        if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
+        if (!vfio_notifier_init(vdev, &vector->interrupt, "interrupt", i,
+                                &err)) {
             error_report_err(err);
         }
 
@@ -2918,7 +2922,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (!vfio_notifier_init(&vdev->err_notifier, "err_notifier", &err)) {
+    if (!vfio_notifier_init(vdev, &vdev->err_notifier, "err_notifier", 0,
+                            &err)) {
         error_report_err(err);
         vdev->pci_aer = false;
         return;
@@ -2985,7 +2990,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F9CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbaB-0005X7-7R; Thu, 14 Aug 2025 13:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umbaA-0005Vq-0J
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umba7-0002rL-E4
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:17:41 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECg2W3020129;
 Thu, 14 Aug 2025 17:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=h4XrkcKhSJInpvoA+ypikKSHM433+/9u2Pw/jSXyyr4=; b=
 L/iphArO9+4zdQRk+HrMtpFVkRDmMbzibtQv5gDFAxc68+/LAoMkcKDfSd1NwlmD
 hxDB2Cs/5nJfoNtXS9fypvbpBdpJo1CC5JtnlcEobvXYnBE0mc9LaagUKJj1xYgc
 wrZuGJ3nXecFera1Fa3qQ7iD2wHgi0EhQIPigX19evn8BHktzy+7bAx3eqxd/VQZ
 8TvpwyX7/TIdPcCEICXxTYRGYCiSWb47cEcTAKtVwa6ak9V3NCxpdpM+g5CIQdrt
 I48R50XqDtRofnkIAv45CUNrokEfRi6FJwz/z1doQseomwiya+SSK+q6LvG8zI86
 xp54pBwHiD3jtt1hDXsKCA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4jhar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EH1epn009691; Thu, 14 Aug 2025 17:17:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvskbs3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:17:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57EHGwuO038225;
 Thu, 14 Aug 2025 17:17:35 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvskbrx5-10; Thu, 14 Aug 2025 17:17:35 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 9/9] vfio: cpr-exec mode
Date: Thu, 14 Aug 2025 10:17:23 -0700
Message-Id: <1755191843-283480-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0OCBTYWx0ZWRfX4Cu8YJVeBv+V
 P6qA6ONr3JUs9VJaXgLtoNU25bJRzc1fdVEZZ/t5QyVy9jqzGxKyvrHjOz+8Yoo4cV2ZrPBVxsw
 zjcrHQLrNk5bAITazr+eU94YW/XLuF+PMPe5MhF9DILQYV09nWGaSf7g1VthIGI/Bcv/5lj9LQS
 NjYgg4l8U6kNRP/03moh0sH/yQsEgpySArIMrz/4lELg+MCm7bCNMVLybJYzY6ZG69X9YJNGEAG
 bTxifmLDuzoWsusmWuWBJsgQJberazj5Ke5DX/KpkGuBHZ95GcXEml3VWt05cHv5VS6MEFgnz7T
 0HroTi+Dun/8Gkgsu2LUGiq80mrw+02+v3cIMNQzDMTScN0kzfQpfA4AI+GXaIm9BJFYDE+REDN
 a4swJwAbfv9uVHlqOE8UPqkHly5crwrxB6dLlB0LT8l+9CYYVSOJ5tgVB+dUpttB9O3u0eYw
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689e1a31 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=V7xkzyaGXGj9tJ5OYwUA:9 cc=ntf
 awl=host:12069
X-Proofpoint-GUID: IZH-R1vqt2FN-ygYx45DO59_nguYSEGR
X-Proofpoint-ORIG-GUID: IZH-R1vqt2FN-ygYx45DO59_nguYSEGR
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

All blockers and notifiers for cpr-transfer mode also apply to cpr-exec.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c   |  3 ++-
 hw/vfio/cpr-iommufd.c |  3 ++-
 hw/vfio/cpr-legacy.c  |  9 +++++----
 hw/vfio/cpr.c         | 13 +++++++------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3e13fea..735b769 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -993,7 +993,8 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         error_setg(&vbasedev->cpr.mdev_blocker,
                    "CPR does not support vfio mdev %s", vbasedev->name);
         if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
-                                      MIG_MODE_CPR_TRANSFER, -1) < 0) {
+                                      MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
+                                      -1) < 0) {
             goto hiod_unref_exit;
         }
     }
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 148a06d..e1f1854 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -159,7 +159,8 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
 
     if (!vfio_cpr_supported(be, cpr_blocker)) {
         return migrate_add_blocker_modes(cpr_blocker, errp,
-                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
+                                         MIG_MODE_CPR_TRANSFER,
+                                         MIG_MODE_CPR_EXEC, -1) == 0;
     }
 
     vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 553b203..7c73439 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -176,16 +176,17 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
     if (!vfio_cpr_supported(container, cpr_blocker)) {
         return migrate_add_blocker_modes(cpr_blocker, errp,
-                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
+                                         MIG_MODE_CPR_TRANSFER,
+                                         MIG_MODE_CPR_EXEC, -1) == 0;
     }
 
     vfio_cpr_add_kvm_notifier();
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
-    migration_add_notifier_mode(&container->cpr.transfer_notifier,
-                                vfio_cpr_fail_notifier,
-                                MIG_MODE_CPR_TRANSFER);
+    migration_add_notifier_modes(&container->cpr.transfer_notifier,
+                                 vfio_cpr_fail_notifier,
+                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
     return true;
 }
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index a831243..a176971 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -195,9 +195,10 @@ static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
 void vfio_cpr_add_kvm_notifier(void)
 {
     if (!kvm_close_notifier.notify) {
-        migration_add_notifier_mode(&kvm_close_notifier,
-                                    vfio_cpr_kvm_close_notifier,
-                                    MIG_MODE_CPR_TRANSFER);
+        migration_add_notifier_modes(&kvm_close_notifier,
+                                     vfio_cpr_kvm_close_notifier,
+                                     MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
+                                     -1);
     }
 }
 
@@ -282,9 +283,9 @@ static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
 
 void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
 {
-    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
-                                vfio_cpr_pci_notifier,
-                                MIG_MODE_CPR_TRANSFER);
+    migration_add_notifier_modes(&vdev->cpr.transfer_notifier,
+                                 vfio_cpr_pci_notifier,
+                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
 }
 
 void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
-- 
1.8.3.1



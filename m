Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9DCCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gve-0000SP-Pk; Mon, 22 Sep 2025 09:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvc-0000Re-GE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gva-0001vj-7T
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:04 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NQTE029561;
 Mon, 22 Sep 2025 13:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=BPXzv5B6T9PMErDiIgdcjXInWBOu92+1LXdsiyJ/RNU=; b=
 TxBw/k39lwCLXUTihBTwDGxvqn0snIIyy8T+KE5oYCGK396fj+U9OPO/vEFHwdIz
 gpcMXGR0bnS+RBVVHkwJWMeNca54uIjCXDouOlAumSl7nRdnb3ZUcvBnhBCkkMbj
 b3QsxTd7l9CC66y7G5igIukEWzMTIDaoRgUIMRRfkS34cIrCNNov6Gx1/f6UI3La
 DDoEJGVnHg2zwWE2D4Kif30otlH5dQXo1HQUY0PAoU/Jf+ZfsHTygnUKZjEUQhCp
 NvMZPmJ8a95v8r/mrxk7jjYMjfUiJM1VlIZwXfkn5ZcBv9uOlgkG7w5EA73t1zcc
 JLuK5XlCZYwjtqJ2Bji6/A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k23agdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MCGk9Q034253; Mon, 22 Sep 2025 13:49:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhane6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58MDnlWR004351;
 Mon, 22 Sep 2025 13:49:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49a6nhan6x-9; Mon, 22 Sep 2025 13:49:58 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 8/8] vfio: cpr-exec mode
Date: Mon, 22 Sep 2025 06:49:45 -0700
Message-Id: <1758548985-354793-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220135
X-Authority-Analysis: v=2.4 cv=C5XpyRP+ c=1 sm=1 tr=0 ts=68d15407 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=V7xkzyaGXGj9tJ5OYwUA:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: CdSSvPKFurojM_uFpi2P62fndT3sqUnz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNiBTYWx0ZWRfX3EXTur+NXMQJ
 hIXe+CLuPvGvuArIxbuGIlJrn2ZuoSOhYb40l5McV39VuTKSJMr67/RsSX94oknqO0Ebq3DkszX
 YhDQf6/SnOVhlRfSCUGpSG9vlIIkYgXLR7qkl3u0flaFlkl5hAWgWfOxi1hwVbpPFZFRnzOurbt
 NOEuUKLnfF+XFLKSN31Z/5oLdcPZg0Memu1mTzoJJdo50vsAy6M7WBgbznOBv83b8Lhzw/Q5wuH
 6ra6D9TG3CmvLBK+hzpTsMCNGSOF+B8bc6PYMCV/5v6Ct6czifWzsKynojsdKyAiAOvqqko4IIK
 veQ/OclP/3ukAniPRNFcxIscipDdP9Ix9jTlCOKjcCdcLPsHaeR0AJLvKcCwV4qm39SR1YHe9i2
 uXuS1QMJWZaVkKr1zkULArQ4OiNiCg==
X-Proofpoint-ORIG-GUID: CdSSvPKFurojM_uFpi2P62fndT3sqUnz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All blockers and notifiers for cpr-transfer mode also apply to cpr-exec.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c   |  3 ++-
 hw/vfio/cpr-iommufd.c |  3 ++-
 hw/vfio/cpr-legacy.c  |  9 +++++----
 hw/vfio/cpr.c         | 13 +++++++------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 030c6d3..935f14d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -988,7 +988,8 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
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
index 8f43719..eebb3bf 100644
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
index 2c71fc1..db462aa 100644
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



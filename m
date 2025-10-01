Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEDCCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yr8-0005BQ-6W; Wed, 01 Oct 2025 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yr5-00059y-Va
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqn-0006Qc-JX
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:34:58 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FN1bO011644;
 Wed, 1 Oct 2025 15:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=cWEmIGjNYcnv+6g3XDpGVx8V1KbzLszlS/6DAQxhNNo=; b=
 IWsbbqdRub0S3FhSGv+hyZBq4+NED6Dj1fqiEky5M3H4FA1BTBCUfswKnVrdjG1r
 4BjTAvBvUwl/SAJ2gjjCWT6LVU11nSp3Rw+z6XKKyC8rZ7ZSAAKROJrODeMVwQl8
 fgIoi52Zom8ostiuiwEkaK6/M9VB9XlufMnrbNpduGKqurg/vUygO20PiHIBPUoE
 wtfaHWSwUxtfjrVvpec9IIwPy6mtC4lh0IfjHRypnEAOkv41a9dQ8bZqVwGBVMNq
 oj4VkzYt2405Yjpt5Jk8ZjGJS+n9Zbd3rkWDUrB4okHE/OgH2j5i9rGXE4G7fJop
 j0FsygYp2ZK6u33hcVkOhQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmacspwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591El06j023189; Wed, 1 Oct 2025 15:34:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:18 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCqs014790;
 Wed, 1 Oct 2025 15:34:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-9; Wed, 01 Oct 2025 15:34:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 08/19] vfio: cpr-exec mode
Date: Wed,  1 Oct 2025 08:34:00 -0700
Message-Id: <1759332851-370353-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68dd49fc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=V7xkzyaGXGj9tJ5OYwUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GcpTjs270--3Jxpy7omwFxNOy_Vz-Tuk
X-Proofpoint-GUID: GcpTjs270--3Jxpy7omwFxNOy_Vz-Tuk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX+8JGNRxp4QBP
 m3k1ZeLLsqJGL5mNW3+HMoC3zi5vAnGIX+hfvCV1pAVg6XQbPshNaI6dh6nCwop75s209CgWiYq
 crxbTIN+I9Y+DUTCcAjtsPYIlcPW6s/CKvDlco15Eo2g/jk4pSNyAc/s9PBTPLcHgqJmhMxs/Y1
 18eCS5pZ6qJOcUCd2HAS3WAiA/LgROZvlxu46BroAoJ3lshi78cBJHWrdSBqXsdM9nYjcrG5tVi
 3gpJfzKn1jiQY2kgA58Xwr89auoBRdWIOclkVPQTmva+FFCcP73yjFeZJG3vFiAcEXwdbmhawjX
 jjlgvM9J0QNLdU8w2ZYOfcVNe4HboAsxsGPwED1qZEMrqk0gC0zo0RZw+/da7Gk1kIOHByD11dT
 1UOGL9IIIYYjskoU2nPaUibREtQqfw==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Acked-by: Cédric Le Goater <clg@redhat.com>
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



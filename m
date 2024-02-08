Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347CEC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9Xc-0001b8-JJ; Thu, 08 Feb 2024 13:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9Xb-0001aj-Gi
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9Xa-0005pS-0s
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:31 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 418Ijxwk009881; Thu, 8 Feb 2024 18:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=gsBCfpYo6nRhd1lyMEyOJxnbTlx2IARryMCqC21aU7A=;
 b=L7tQhorEBYhiOU4EewcJixD4HApcBzArDmO9jqrtWsxue6QNklFBYCS6tAQeFLQFuYZK
 a9hf2gcgD9tyjX1eMot5o4mXnSu9sBv97pg8IYP3eYCeVBwujfwAJcE9gSua+QjD2ZfL
 6y+uNnG9fPA1HMJFg0K+TRILSPPfEUofR+khdc22IA1kvjQkK8WLKkuKS+DURqml/Rzf
 XjvKP62RO6Ur6WmqtC4LhlMBguA5PnAsoK0uWmLBmN7ipZToXeOF7+IAqIZ6587G0pdn
 /X/+WzXEAkUt7ajPMeXETuC+U0dv9wFPt9llqU+XbYe4gVTXT0VQv4CVzGaYLIS7mnGf +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c945qax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:28 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 418IfoeF038357; Thu, 8 Feb 2024 18:54:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxawnke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:27 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418Iq36L013534;
 Thu, 8 Feb 2024 18:54:27 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3w1bxawmw9-13; Thu, 08 Feb 2024 18:54:27 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 12/13] vfio: allow cpr-reboot migration if suspended
Date: Thu,  8 Feb 2024 10:54:05 -0800
Message-Id: <1707418446-134863-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080099
X-Proofpoint-ORIG-GUID: XBX4lnxbA_a-yYBgDpne9D8xZX0P2RPB
X-Proofpoint-GUID: XBX4lnxbA_a-yYBgDpne9D8xZX0P2RPB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
guest drivers' suspend methods flush outstanding requests and re-initialize
the devices, and thus there is no device state to save and restore.  The
user is responsible for suspending the guest before initiating cpr, such as
by issuing guest-suspend-ram to the qemu guest agent.

Relax the vfio blocker so it does not apply to cpr, and add a notifier that
verifies the guest is suspended.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/common.c                      |  2 +-
 hw/vfio/cpr.c                         | 20 ++++++++++++++++++++
 hw/vfio/migration.c                   |  2 +-
 include/hw/vfio/vfio-container-base.h |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 059bfdc..ff88c3f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     error_setg(&multiple_devices_migration_blocker,
                "Multiple VFIO devices migration is supported only if all of "
                "them support P2P migration");
-    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
 
     return ret;
 }
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 3bede54..392c2dd 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -7,13 +7,33 @@
 
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-common.h"
+#include "migration/misc.h"
 #include "qapi/error.h"
+#include "sysemu/runstate.h"
+
+static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
+                                    MigrationEvent *e, Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_SETUP &&
+        !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
+
+        error_setg(errp,
+            "VFIO device only supports cpr-reboot for runstate suspended");
+
+        return -1;
+    }
+    return 0;
+}
 
 int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
 {
+    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
+                                vfio_cpr_reboot_notifier,
+                                MIG_MODE_CPR_REBOOT);
     return 0;
 }
 
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
 {
+    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 50140ed..2050ac8 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -889,7 +889,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
     vbasedev->migration_blocker = error_copy(err);
     error_free(err);
 
-    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
+    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
 }
 
 /* ---------------------------------------------------------------------- */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index b2813b0..3582d5f 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -49,6 +49,7 @@ typedef struct VFIOContainerBase {
     QLIST_ENTRY(VFIOContainerBase) next;
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
+    NotifierWithReturn cpr_reboot_notifier;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
-- 
1.8.3.1



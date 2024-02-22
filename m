Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA02C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsy-0005jR-Mz; Thu, 22 Feb 2024 12:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsw-0005fm-WF
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsh-0003HX-Vp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:26 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MH91q4026007; Thu, 22 Feb 2024 17:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=WXOj8Hs3aVF9OD0ufbP6GM+yImju3a8Lnlz3aHOX2EE=;
 b=HgfO5L4sFrrimAc+gYIGiBH/AYstVnClKHDbJfobn8i2s57byR++5wulqhtKtJ9FlHIO
 /tS+Z6cc7j7nkZtMOLVNRG2gpE5NDitgTsGjnblmIM4Z+nBeSUr5I4Hxi4MNNoPLwLEL
 JqZyFW+rKGoIV7SWx+yuq5BnKL//+z1DNWUlXDJRNoQK51tW/1jMs+SEp64xffdci0T/
 uymgNV6x8H8vkU0RJcqGGhHKpQu7KupO36nNSoLXEAFEj8NsTmSdOqHEf6pdnj3IAefu
 L0rPfcLHOjRqYAPpa313GoKR0ehN2iQtkH7AZYIOKOfmRZDQ3awCeGln8go/LsApAemm kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk45cxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:29:03 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MHSVQl024791; Thu, 22 Feb 2024 17:28:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ayrp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:51 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSgA1032453;
 Thu, 22 Feb 2024 17:28:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-7; Thu, 22 Feb 2024 17:28:50 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 06/14] migration: MigrationNotifyFunc
Date: Thu, 22 Feb 2024 09:28:32 -0800
Message-Id: <1708622920-68779-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220138
X-Proofpoint-ORIG-GUID: rfk0UvxOKih5dJPhM3PNV8eIT7LA2kpL
X-Proofpoint-GUID: rfk0UvxOKih5dJPhM3PNV8eIT7LA2kpL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Define MigrationNotifyFunc to improve type safety and simplify migration
notifiers.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/net/virtio-net.c      | 4 +---
 hw/vfio/migration.c      | 3 +--
 include/migration/misc.h | 5 ++++-
 migration/migration.c    | 4 ++--
 net/vhost-vdpa.c         | 6 ++----
 ui/spice-core.c          | 4 +---
 6 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e803f98..a3c711b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3535,10 +3535,8 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
 }
 
 static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
-                                               void *data, Error **errp)
+                                               MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
-
     VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
     virtio_net_handle_migration_primary(n, e);
     return 0;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 869d841..50140ed 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -755,9 +755,8 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 }
 
 static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
-                                         void *data, Error **errp)
+                                         MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
                                             migration_state);
     VFIODevice *vbasedev = migration->vbasedev;
diff --git a/include/migration/misc.h b/include/migration/misc.h
index e615000..e36a1f3 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -72,6 +72,9 @@ typedef struct MigrationEvent {
     MigrationEventType type;
 } MigrationEvent;
 
+typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
+                                   MigrationEvent *e, Error **errp);
+
 /*
  * Register the notifier @notify to be called when a migration event occurs
  * for MIG_MODE_NORMAL, as specified by the MigrationEvent passed to @func.
@@ -81,7 +84,7 @@ typedef struct MigrationEvent {
  *    - MIG_EVENT_PRECOPY_FAILED
  */
 void migration_add_notifier(NotifierWithReturn *notify,
-                            NotifierWithReturnFunc func);
+                            MigrationNotifyFunc func);
 
 void migration_remove_notifier(NotifierWithReturn *notify);
 void migration_call_notifiers(MigrationState *s, MigrationEventType type);
diff --git a/migration/migration.c b/migration/migration.c
index 8f7f2d9..33149c4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1464,9 +1464,9 @@ static void migrate_fd_cancel(MigrationState *s)
 }
 
 void migration_add_notifier(NotifierWithReturn *notify,
-                            NotifierWithReturnFunc func)
+                            MigrationNotifyFunc func)
 {
-    notify->notify = func;
+    notify->notify = (NotifierWithReturnFunc)func;
     notifier_with_return_list_add(&migration_state_notifiers, notify);
 }
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a29d18a..e6bdb45 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -323,11 +323,9 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
 }
 
 static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
-                                             void *data, Error **errp)
+                                             MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
-    VhostVDPAState *s = container_of(notifier, VhostVDPAState,
-                                     migration_state);
+    VhostVDPAState *s = container_of(notifier, VhostVDPAState, migration_state);
 
     if (e->type == MIG_EVENT_PRECOPY_SETUP) {
         vhost_vdpa_net_log_global_enable(s, true);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 0a59876..15be640 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -569,10 +569,8 @@ static SpiceInfo *qmp_query_spice_real(Error **errp)
 }
 
 static int migration_state_notifier(NotifierWithReturn *notifier,
-                                    void *data, Error **errp)
+                                    MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
-
     if (!spice_have_target_host) {
         return 0;
     }
-- 
1.8.3.1



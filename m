Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A583C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9XU-0001Y3-BI; Thu, 08 Feb 2024 13:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XP-0001R4-9T
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XN-0005nC-3r
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:18 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 418IjqxG001625; Thu, 8 Feb 2024 18:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=01qgn5wow+x15Aw11bvu61/gEclzEp7mkjETYFlCgaI=;
 b=Wcz2uL44Qq149UHAZvq3MdJWnasJqmaV3JAWw2An1XYmS8all0wFr49oUtocI8fT5wiY
 gN5FGU62bpFr1/CyGxUjHFyp1STZeM7OKQKO5iWhpqL3FIyepugkRxHkHgh+DGI2YJr1
 v1qKUolxUQj+BQukY10AaPgFna246yMPUbVOMg2aFy9/BmW79w+7zAQwJU6LjslHDKTR
 a/nx5APVoxH+oYrHt5v36NzX8qDQajZjMqwfpaF2qeNl0dXqwoHUmhBeBVN6a9zaXD1t
 yBmeUwJjzfD4Z4OuY3UXR8Ds2YE+DKKmmzw745JJlQVpJl+wJHImQ5YNoArneCTupC18 IA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1vdgut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:11 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 418IkLW5038437; Thu, 8 Feb 2024 18:54:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxawn0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418Iq35x013534;
 Thu, 8 Feb 2024 18:54:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3w1bxawmw9-2; Thu, 08 Feb 2024 18:54:09 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 01/13] notify: pass error to notifier with return
Date: Thu,  8 Feb 2024 10:53:54 -0800
Message-Id: <1707418446-134863-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: FA1TZ3xpyaALqaT1nauBvjm1TdDIdopY
X-Proofpoint-ORIG-GUID: FA1TZ3xpyaALqaT1nauBvjm1TdDIdopY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pass an error object as the third parameter to "notifier with return"
notifiers, so clients no longer need to bundle an error object in the
opaque data.  The new parameter is used in a later patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/virtio/vhost-user.c     | 2 +-
 hw/virtio/virtio-balloon.c | 3 ++-
 include/qemu/notify.h      | 7 +++++--
 migration/postcopy-ram.c   | 2 +-
 migration/ram.c            | 2 +-
 util/notify.c              | 5 +++--
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f214df8..f502345 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2084,7 +2084,7 @@ static int vhost_user_postcopy_end(struct vhost_dev *dev, Error **errp)
 }
 
 static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
-                                        void *opaque)
+                                        void *opaque, Error **errp)
 {
     struct PostcopyNotifyData *pnd = opaque;
     struct vhost_user *u = container_of(notifier, struct vhost_user,
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 486fe3d..89f853f 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -633,7 +633,8 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
 }
 
 static int
-virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data)
+virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data,
+                                     Error **errp)
 {
     VirtIOBalloon *dev = container_of(n, VirtIOBalloon, free_page_hint_notify);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
diff --git a/include/qemu/notify.h b/include/qemu/notify.h
index bcfa70f..9a85631 100644
--- a/include/qemu/notify.h
+++ b/include/qemu/notify.h
@@ -45,12 +45,15 @@ bool notifier_list_empty(NotifierList *list);
 /* Same as Notifier but allows .notify() to return errors */
 typedef struct NotifierWithReturn NotifierWithReturn;
 
+typedef int (*NotifierWithReturnFunc)(NotifierWithReturn *notifier, void *data,
+                                      Error **errp);
+
 struct NotifierWithReturn {
     /**
      * Return 0 on success (next notifier will be invoked), otherwise
      * notifier_with_return_list_notify() will stop and return the value.
      */
-    int (*notify)(NotifierWithReturn *notifier, void *data);
+    NotifierWithReturnFunc notify;
     QLIST_ENTRY(NotifierWithReturn) node;
 };
 
@@ -69,6 +72,6 @@ void notifier_with_return_list_add(NotifierWithReturnList *list,
 void notifier_with_return_remove(NotifierWithReturn *notifier);
 
 int notifier_with_return_list_notify(NotifierWithReturnList *list,
-                                     void *data);
+                                     void *data, Error **errp);
 
 #endif
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 893ec8f..3ab2f6b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -80,7 +80,7 @@ int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
     pnd.errp = errp;
 
     return notifier_with_return_list_notify(&postcopy_notifier_list,
-                                            &pnd);
+                                            &pnd, errp);
 }
 
 /*
diff --git a/migration/ram.c b/migration/ram.c
index d5b7cd5..ed9241a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -428,7 +428,7 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp)
     pnd.reason = reason;
     pnd.errp = errp;
 
-    return notifier_with_return_list_notify(&precopy_notifier_list, &pnd);
+    return notifier_with_return_list_notify(&precopy_notifier_list, &pnd, errp);
 }
 
 uint64_t ram_bytes_remaining(void)
diff --git a/util/notify.c b/util/notify.c
index 76bab21..c6e158f 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -61,13 +61,14 @@ void notifier_with_return_remove(NotifierWithReturn *notifier)
     QLIST_REMOVE(notifier, node);
 }
 
-int notifier_with_return_list_notify(NotifierWithReturnList *list, void *data)
+int notifier_with_return_list_notify(NotifierWithReturnList *list, void *data,
+                                     Error **errp)
 {
     NotifierWithReturn *notifier, *next;
     int ret = 0;
 
     QLIST_FOREACH_SAFE(notifier, &list->notifiers, node, next) {
-        ret = notifier->notify(notifier, data);
+        ret = notifier->notify(notifier, data, errp);
         if (ret != 0) {
             break;
         }
-- 
1.8.3.1



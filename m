Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1203C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsR-0004f5-70; Thu, 22 Feb 2024 12:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsP-0004Z2-AY
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:53 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsN-0003Bd-B3
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:53 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MH940A003399; Thu, 22 Feb 2024 17:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=alSGxZlfCylgGyVfn6yQmA3B7Gi0wPsmqVLM6lxwUBE=;
 b=lI2FZgDhYXLUVjNlzC79FVxaylkYklgf7+ALN5nSwXpHg7gpnJN3APFvmeU5TOP1MY5x
 R4y1sTz23H6UZZudu20BOVpQsdm5i/dMCANp9Y1FhEPWIb5Y2GFTFzC9aV7mp/0Wi2Bi
 6FVt0uGLMkc/ebJwMAnzRq6M8KkLVwPJ/9qdiEem286vyapmkUSxm6uZUpWKqKQHgB9Z
 dmt1ToCZHnaMHcYWp9SXlP98v0xoiFSXBoWEA4B3/2YdJ6WM7w1L3ngrRJW7yHNIzEV9
 ZRhVu2hsFU49H85Iwse62ZzYmFQKCVJXgO26p/V+ILWpwKmhpesXKOVP0SaRmTNhUls+ /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knw19y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:49 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MG8elX024593; Thu, 22 Feb 2024 17:28:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ayrgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSg9n032453;
 Thu, 22 Feb 2024 17:28:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-2; Thu, 22 Feb 2024 17:28:43 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 01/14] notify: pass error to notifier with return
Date: Thu, 22 Feb 2024 09:28:27 -0800
Message-Id: <1708622920-68779-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: RI5Om39NcVMwLgtzzAB3vNHPWXyNOUkD
X-Proofpoint-GUID: RI5Om39NcVMwLgtzzAB3vNHPWXyNOUkD
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pass an error object as the third parameter to "notifier with return"
notifiers, so clients no longer need to bundle an error object in the
opaque data.  The new parameter is used in a later patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
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
index 4649a81..5b6b09e 100644
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



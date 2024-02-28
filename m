Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A513C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCI3-0000Fm-Fn; Wed, 28 Feb 2024 00:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHl-0008L7-Qy
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHf-0006gj-UA
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9J0QDXBWyQDq5N2g2mm0OQe1YMBW0IeKpsBQMUDkGU=;
 b=N+x6s16hu2f5h46zgPt6hPJy8SkvDbqqxPiHkBeAFX+1oNCM3jF+ODIFM41RdpGiwSwqNE
 arSjF0wIvioUzu3QCANKG4rjMhbdfKoYe4g3+wqb6PEyp6X0RESxfDrQvLRc+CQqnkxge/
 v+kEnEBF6w3vh23s3SBwOhY2B42jLsg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-j8a1JoTZOeWSCUUozwR12Q-1; Wed,
 28 Feb 2024 00:15:08 -0500
X-MC-Unique: j8a1JoTZOeWSCUUozwR12Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAABF3C11CC3;
 Wed, 28 Feb 2024 05:15:07 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD7C41C06710;
 Wed, 28 Feb 2024 05:14:58 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 11/25] notify: pass error to notifier with return
Date: Wed, 28 Feb 2024 13:13:01 +0800
Message-ID: <20240228051315.400759-12-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Pass an error object as the third parameter to "notifier with return"
notifiers, so clients no longer need to bundle an error object in the
opaque data.  The new parameter is used in a later patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-2-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/notify.h      | 7 +++++--
 hw/virtio/vhost-user.c     | 2 +-
 hw/virtio/virtio-balloon.c | 3 ++-
 migration/postcopy-ram.c   | 2 +-
 migration/ram.c            | 2 +-
 util/notify.c              | 5 +++--
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/qemu/notify.h b/include/qemu/notify.h
index bcfa70fb2e..9a85631864 100644
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
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f214df804b..f502345f37 100644
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
index 486fe3da32..89f853fa9e 100644
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
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 893ec8fa89..3ab2f6b8fd 100644
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
index 4649a81204..5b6b09edd9 100644
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
index 76bab212ae..c6e158ffb3 100644
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
2.43.0



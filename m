Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE10CFC519
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdUH-000805-GW; Fri, 21 Nov 2025 21:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcBx-0007cy-Nt; Fri, 21 Nov 2025 20:13:33 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMc9u-0004cT-Ts; Fri, 21 Nov 2025 20:13:29 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2193116CA63;
 Fri, 21 Nov 2025 21:44:25 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D177E321C9F;
 Fri, 21 Nov 2025 21:44:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 40/81] vhost-user: fix shared object lookup handler
 logic
Date: Fri, 21 Nov 2025 21:43:39 +0300
Message-ID: <20251121184424.1137669-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Albert Esteve <aesteve@redhat.com>

Refactor backend_read() function and add a reply_ack variable
to have the option for handlers to force tweak whether they should
send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
flag.

This fixes an issue with
vhost_user_backend_handle_shared_object_lookup() logic, as the
error path was not closing the backend channel correctly. So,
we can remove the reply call from within the handler, make
sure it returns early on errors as other handlers do and
set the reply_ack variable on backend_read() to true to ensure
that it will send a response, thus keeping the original intent.

Fixes: 1609476662 ("vhost-user: add shared_object msg")
Cc: qemu-stable@nongnu.org
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251017072011.1874874-2-aesteve@redhat.com>
(cherry picked from commit fde5930cc37175cfcd0f03a089e26f4458a52311)
(Mjt: context fix)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 267b612587..7961e3c9e8 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1670,14 +1670,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
     return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
 }
 
-static bool
-vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
-                                  VhostUserPayload *payload, Error **errp)
-{
-    hdr->size = sizeof(payload->u64);
-    return vhost_user_send_resp(ioc, hdr, payload, errp);
-}
-
 int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
                                  int *dmabuf_fd)
 {
@@ -1718,19 +1710,15 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
 
 static int
 vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
-                                               QIOChannel *ioc,
-                                               VhostUserHeader *hdr,
-                                               VhostUserPayload *payload)
+                                               VhostUserShared *object)
 {
     QemuUUID uuid;
     CharBackend *chr = u->user->chr;
-    Error *local_err = NULL;
     int dmabuf_fd = -1;
     int fd_num = 0;
 
-    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
+    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
 
-    payload->u64 = 0;
     switch (virtio_object_type(&uuid)) {
     case TYPE_DMABUF:
         dmabuf_fd = virtio_lookup_dmabuf(&uuid);
@@ -1739,18 +1727,16 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
     {
         struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
         if (dev == NULL) {
-            payload->u64 = -EINVAL;
-            break;
+            return -EINVAL;
         }
         int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
         if (ret < 0) {
-            payload->u64 = ret;
+            return ret;
         }
         break;
     }
     case TYPE_INVALID:
-        payload->u64 = -EINVAL;
-        break;
+        return -EINVAL;
     }
 
     if (dmabuf_fd != -1) {
@@ -1759,11 +1745,6 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
 
     if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
         error_report("Failed to set msg fds.");
-        payload->u64 = -EINVAL;
-    }
-
-    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
-        error_report_err(local_err);
         return -EINVAL;
     }
 
@@ -1792,6 +1773,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
     struct iovec iov;
     g_autofree int *fd = NULL;
     size_t fdsize = 0;
+    bool reply_ack;
     int i;
 
     /* Read header */
@@ -1810,6 +1792,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         goto err;
     }
 
+    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
+
     /* Read payload */
     if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
         error_report_err(local_err);
@@ -1835,8 +1819,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
                                                              &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
-        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
-                                                             &hdr, &payload);
+        /* The backend always expects a response */
+        reply_ack = true;
+        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque,
+                                                             &payload.object);
         break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
@@ -1847,7 +1833,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
      * REPLY_ACK feature handling. Other reply types has to be managed
      * directly in their request handlers.
      */
-    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+    if (reply_ack) {
         payload.u64 = !!ret;
         hdr.size = sizeof(payload.u64);
 
-- 
2.47.3



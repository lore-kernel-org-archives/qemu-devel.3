Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E57FCCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 07:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9elO-0001P4-LE; Fri, 17 Oct 2025 03:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9elL-0001Oo-Pp
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 03:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9elH-0000LC-BT
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 03:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760685622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YaRyDgayZN600ydIygjn7F97Dn8EMi5jvzz7L5NEWE=;
 b=VtjVzyo3CcVFtaIj+Mt+fynlDR5I1xNKjhGl2kM5+7yYytIGLpfh+wY4frVWs0AQsWToDl
 EIIhyv4xnixAKNUTbD3jTnaHh7y3c4dMFdHCV59v0elfHJ1XtHgsohXRYxeQa4MvNdlxgx
 HlSEdUxNtyj5lq7fndtZX3xxrst9izs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-AI84dCDEP1Cr42RebAI_EQ-1; Fri,
 17 Oct 2025 03:20:20 -0400
X-MC-Unique: AI84dCDEP1Cr42RebAI_EQ-1
X-Mimecast-MFC-AGG-ID: AI84dCDEP1Cr42RebAI_EQ_1760685619
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E00431954210; Fri, 17 Oct 2025 07:20:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DD7E1956056; Fri, 17 Oct 2025 07:20:16 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v4 1/1] vhost-user: fix shared object lookup handler logic
Date: Fri, 17 Oct 2025 09:20:11 +0200
Message-ID: <20251017072011.1874874-2-aesteve@redhat.com>
In-Reply-To: <20251017072011.1874874-1-aesteve@redhat.com>
References: <20251017072011.1874874-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
Cc: qemu-stable@nongnu.org
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 890be55937..762d7218d3 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1696,14 +1696,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
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
@@ -1744,19 +1736,15 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
 
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
@@ -1765,18 +1753,16 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
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
@@ -1785,11 +1771,6 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
 
     if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
         error_report("Failed to set msg fds.");
-        payload->u64 = -EINVAL;
-    }
-
-    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
-        error_report_err(local_err);
         return -EINVAL;
     }
 
@@ -2008,6 +1989,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
     struct iovec iov;
     g_autofree int *fd = NULL;
     size_t fdsize = 0;
+    bool reply_ack;
     int i;
 
     /* Read header */
@@ -2026,6 +2008,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         goto err;
     }
 
+    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
+
     /* Read payload */
     if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
         error_report_err(local_err);
@@ -2051,11 +2035,14 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
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
     case VHOST_USER_BACKEND_SHMEM_MAP:
         /* Handler manages its own response, check error and close connection */
+        reply_ack = false;
         if (vhost_user_backend_handle_shmem_map(dev, ioc, &hdr, &payload,
                                                 fd ? fd[0] : -1) < 0) {
             goto err;
@@ -2063,6 +2050,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         break;
     case VHOST_USER_BACKEND_SHMEM_UNMAP:
         /* Handler manages its own response, check error and close connection */
+        reply_ack = false;
         if (vhost_user_backend_handle_shmem_unmap(dev, ioc, &hdr, &payload) < 0) {
             goto err;
         }
@@ -2076,7 +2064,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
      * REPLY_ACK feature handling. Other reply types has to be managed
      * directly in their request handlers.
      */
-    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+    if (reply_ack) {
         payload.u64 = !!ret;
         hdr.size = sizeof(payload.u64);
 
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24F1CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 11:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zoe-0004Ss-78; Wed, 15 Oct 2025 07:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8zoc-0004SP-2u
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v8zoP-00057T-9O
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 07:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760528207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+KOOYdnB6976Fp3HndQv0nfTpSQNdIyJViMMfeepJaY=;
 b=fvA3DKxOmd6z1WeWFRANlO5QmeEmXdkVl2x4IsmoGgmPcdrQwhecOCKZ9LSYOhT8XIXEeX
 mvgC4I2suqNI20lLRMl5Frr5bq7HBRroyAo0NfXPevAP90Vi8eu9AnKKxoazygqPQVf4xa
 Ifc84wzfulfy72Amz/WoIQTFXTduwLE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-D5aTco9aPNeXFj-JIvJXpw-1; Wed,
 15 Oct 2025 07:36:46 -0400
X-MC-Unique: D5aTco9aPNeXFj-JIvJXpw-1
X-Mimecast-MFC-AGG-ID: D5aTco9aPNeXFj-JIvJXpw_1760528205
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C395F18002DD
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:36:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.32.123])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCA33180044F; Wed, 15 Oct 2025 11:36:43 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v2] vhost-user: add reply_ack to backend_read
Date: Wed, 15 Oct 2025 13:36:34 +0200
Message-ID: <20251015113634.1566785-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 36c9c2e04d..b0bcee2d30 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1668,14 +1668,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
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
@@ -1716,19 +1708,15 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
 
 static int
 vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
-                                               QIOChannel *ioc,
-                                               VhostUserHeader *hdr,
                                                VhostUserPayload *payload)
 {
     QemuUUID uuid;
     CharBackend *chr = u->user->chr;
-    Error *local_err = NULL;
     int dmabuf_fd = -1;
     int fd_num = 0;
 
     memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
 
-    payload->u64 = 0;
     switch (virtio_object_type(&uuid)) {
     case TYPE_DMABUF:
         dmabuf_fd = virtio_lookup_dmabuf(&uuid);
@@ -1737,18 +1725,16 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
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
@@ -1757,11 +1743,6 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
 
     if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
         error_report("Failed to set msg fds.");
-        payload->u64 = -EINVAL;
-    }
-
-    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
-        error_report_err(local_err);
         return -EINVAL;
     }
 
@@ -1790,6 +1771,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
     struct iovec iov;
     g_autofree int *fd = NULL;
     size_t fdsize = 0;
+    bool reply_ack;
     int i;
 
     /* Read header */
@@ -1808,6 +1790,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         goto err;
     }
 
+    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
+
     /* Read payload */
     if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
         error_report_err(local_err);
@@ -1833,8 +1817,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
                                                              &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
-        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
-                                                             &hdr, &payload);
+        /* The backend always expects a response */
+        reply_ack = true;
+        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque,
+                                                             &payload);
         break;
     default:
         error_report("Received unexpected msg type: %d.", hdr.request);
@@ -1845,7 +1831,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
      * REPLY_ACK feature handling. Other reply types has to be managed
      * directly in their request handlers.
      */
-    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
+    if (reply_ack) {
         payload.u64 = !!ret;
         hdr.size = sizeof(payload.u64);
 
-- 
2.49.0



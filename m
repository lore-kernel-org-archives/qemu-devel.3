Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BFDC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4jE-0007hD-PO; Mon, 19 Feb 2024 09:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4jD-0007ge-2a
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4jB-0003qx-IT
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708353280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QflzN+GYU1vmQXpDdo+yVT7fHd7rc1xlsl1lzxUT6A=;
 b=goLWiOk4OOffnJ0baxD5hdeUDwzIC9OuWAKgJ9kYMncoViWL6oTbhXWF1sh/SwZdn5l7r3
 LW+UB3NIAJpX3QKquS3aVXJsUl2o2ZGlfcz0VfTS7eRHJrAqhquoaFMoSM5GX72O3SNIWB
 mH0NddKJUmHAFsWsjScLRnV/jyHNZpc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-yEHI0NOZPO6NponbH3xDbA-1; Mon,
 19 Feb 2024 09:34:35 -0500
X-MC-Unique: yEHI0NOZPO6NponbH3xDbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C1D5282D3CD;
 Mon, 19 Feb 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E80F4200B251;
 Mon, 19 Feb 2024 14:34:31 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@gmail.com, Albert Esteve <aesteve@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v4 1/5] hw/virtio: check owner for removing objects
Date: Mon, 19 Feb 2024 15:34:19 +0100
Message-ID: <20240219143423.272012-2-aesteve@redhat.com>
In-Reply-To: <20240219143423.272012-1-aesteve@redhat.com>
References: <20240219143423.272012-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

Shared objects lack spoofing protection.
For VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE messages
received by the vhost-user interface, any backend was
allowed to remove entries from the shared table just
by knowing the UUID. Only the owner of the entry
shall be allowed to removed their resources
from the table.

To fix that, add a check for all
*SHARED_OBJECT_REMOVE messages received.
A vhost device can only remove TYPE_VHOST_DEV
entries that are owned by them, otherwise skip
the removal, and inform the device that the entry
has not been removed in the answer.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/interop/vhost-user.rst |  4 +++-
 hw/virtio/vhost-user.c      | 21 +++++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index ad6e142f23..32496b5aa9 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -1839,7 +1839,9 @@ is sent by the front-end.
   When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
   feature has been successfully negotiated, this message can be submitted
   by the backend to remove themselves from to the virtio-dmabuf shared
-  table API. The shared table will remove the back-end device associated with
+  table API. Only the back-end owning the entry (i.e., the one that first added
+  it) will have permission to remove it. Otherwise, the message is ignored.
+  The shared table will remove the back-end device associated with
   the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the
   back-end sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond
   with zero when operation is successfully completed, or non-zero otherwise.
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f214df804b..152710d30d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1611,11 +1611,27 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
 }
 
 static int
-vhost_user_backend_handle_shared_object_remove(VhostUserShared *object)
+vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
+                                               VhostUserShared *object)
 {
     QemuUUID uuid;
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
+    switch (virtio_object_type(&uuid)) {
+    case TYPE_VHOST_DEV:
+    {
+        struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
+        if (dev != owner) {
+            /* Not allowed to remove non-owned entries */
+            return 0;
+        }
+        break;
+    }
+    default:
+        /* Not allowed to remove non-owned entries */
+        return 0;
+    }
+
     return virtio_remove_resource(&uuid);
 }
 
@@ -1794,7 +1810,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
         ret = vhost_user_backend_handle_shared_object_add(dev, &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
-        ret = vhost_user_backend_handle_shared_object_remove(&payload.object);
+        ret = vhost_user_backend_handle_shared_object_remove(dev,
+                                                             &payload.object);
         break;
     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
         ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
-- 
2.43.1



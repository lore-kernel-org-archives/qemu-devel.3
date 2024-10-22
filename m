Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11489D2C548
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3EHX-00010U-Ok; Tue, 22 Oct 2024 08:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t3EHU-0000zN-0d
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1t3EHO-0002YU-1f
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729601188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wQSX44ZxeTOsyI9Fy+8H524Grm3ahviaKezsDi1TjT8=;
 b=IcwrDZNAXRRvy9cng1ckZl/Iic1CZ3iuQfHJaffojjW+zcu7c+QyLFTroPqHfBJoASWyd1
 ujT5EddxVhbIuEVtzCQQ6ZMH5FVop8sr/kTregQej8JLwYzQvar66EplSZ2iUNvQVbFGR+
 4I5YnlMNy7frdTLbor2erK0AGrtUZDE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-KXW_soooPvO21flXl6hRPw-1; Tue,
 22 Oct 2024 08:46:27 -0400
X-MC-Unique: KXW_soooPvO21flXl6hRPw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53C2A1944D45
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.129])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 843BA1956088; Tue, 22 Oct 2024 12:46:23 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, berrange@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, dbassey@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v2] vhost-user: fix shared object return values
Date: Tue, 22 Oct 2024 14:46:14 +0200
Message-ID: <20241022124615.585596-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
in the spec that they return 0 for successful
operations, non-zero otherwise. However,
implementation relies on the return types
of the virtio-dmabuf library, with opposite
semantics (true if everything is correct,
false otherwise). Therefore, current
implementation violates the specification.

Revert the logic so that the implementation
of the vhost-user handling methods matches
the specification.

Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce
Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 00561daa06..96c5e6b95f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1607,9 +1607,14 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
     QemuUUID uuid;
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
-    return virtio_add_vhost_device(&uuid, dev);
+    return !virtio_add_vhost_device(&uuid, dev);
 }
 
+/*
+ * Handle VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE backend requests.
+ *
+ * Return: 0 on success, 1 on error.
+ */
 static int
 vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
                                                VhostUserShared *object)
@@ -1623,16 +1628,16 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
         struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
         if (dev != owner) {
             /* Not allowed to remove non-owned entries */
-            return 0;
+            return 1;
         }
         break;
     }
     default:
         /* Not allowed to remove non-owned entries */
-        return 0;
+        return 1;
     }
 
-    return virtio_remove_resource(&uuid);
+    return !virtio_remove_resource(&uuid);
 }
 
 static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
-- 
2.47.0



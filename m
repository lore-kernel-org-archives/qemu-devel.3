Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A6CC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgbN-0003bE-2x; Tue, 28 Jan 2025 03:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgZw-0000ct-7y; Tue, 28 Jan 2025 03:04:12 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgZu-0002Rv-Di; Tue, 28 Jan 2025 03:04:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0BBF9E1B67;
 Tue, 28 Jan 2025 10:57:09 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7C2161A631B;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 1F996520C7; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 33/58] vhost-user: fix shared object return values
Date: Mon, 27 Jan 2025 23:25:19 +0300
Message-Id: <20250127202547.3723716-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Message-Id: <20241022124615.585596-1-aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit eea5aeef84e1b74f515b474d3a86377701f93750)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.39.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C97BC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4jQ-0007nD-FU; Mon, 19 Feb 2024 09:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4jN-0007jc-0f
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4jK-0003rt-4G
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708353289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xWXJ7mtY+Ak3K3k+O+7xgBQ1TPdtLyqqeB0Tb5sew4=;
 b=E25SRJOFOSz9Yc/Hf9vCVUM6kB2ItBon4NsCHGsgKyZ5igE+hcVf7Z7H+Du98Ytjyu7UkN
 XUrrdqRuhXy9p2htr/BW+cMZ6iVdPd8XtHlCvfGA1lKbg/M2GViD7cXkf3OKOSqrB2jbyS
 W5DEmyktLdM5g77ON0sO3MTSUFX1WDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-nvieJVMJM56bkEeiufDX4g-1; Mon, 19 Feb 2024 09:34:46 -0500
X-MC-Unique: nvieJVMJM56bkEeiufDX4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A38B10AFA03;
 Mon, 19 Feb 2024 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7E8820229A7;
 Mon, 19 Feb 2024 14:34:42 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@gmail.com, Albert Esteve <aesteve@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v4 5/5] hw/virtio: rename virtio dmabuf API
Date: Mon, 19 Feb 2024 15:34:23 +0100
Message-ID: <20240219143423.272012-6-aesteve@redhat.com>
In-Reply-To: <20240219143423.272012-1-aesteve@redhat.com>
References: <20240219143423.272012-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Functions in the virtio-dmabuf module
start with 'virtio_*', which is too
generic and may not correctly identify
them as part of the virtio dmabuf API.

Rename all functions to 'virtio_dmabuf_*'
instead to avoid confusion.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/virtio-dmabuf.c        | 14 ++++----
 hw/virtio/vhost-user.c            | 14 ++++----
 include/hw/virtio/virtio-dmabuf.h | 33 +++++++++---------
 tests/unit/test-virtio-dmabuf.c   | 58 +++++++++++++++----------------
 4 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 703b5bd979..4e32af2ad0 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -53,7 +53,7 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
     return result;
 }
 
-bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
+bool virtio_dmabuf_add(QemuUUID *uuid, int udmabuf_fd)
 {
     bool result;
     VirtioSharedObject *vso;
@@ -71,7 +71,7 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
     return result;
 }
 
-bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
+bool virtio_dmabuf_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
 {
     bool result;
     VirtioSharedObject *vso;
@@ -89,7 +89,7 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
     return result;
 }
 
-bool virtio_remove_resource(const QemuUUID *uuid)
+bool virtio_dmabuf_remove_resource(const QemuUUID *uuid)
 {
     bool result;
     WITH_QEMU_LOCK_GUARD(&lock) {
@@ -112,7 +112,7 @@ static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
     return (VirtioSharedObject *) lookup_res;
 }
 
-int virtio_lookup_dmabuf(const QemuUUID *uuid)
+int virtio_dmabuf_lookup(const QemuUUID *uuid)
 {
     VirtioSharedObject *vso = get_shared_object(uuid);
     if (vso == NULL) {
@@ -122,7 +122,7 @@ int virtio_lookup_dmabuf(const QemuUUID *uuid)
     return vso->value.udma_buf;
 }
 
-struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
+struct vhost_dev *virtio_dmabuf_lookup_vhost_device(const QemuUUID *uuid)
 {
     VirtioSharedObject *vso = get_shared_object(uuid);
     if (vso == NULL) {
@@ -132,7 +132,7 @@ struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
     return (struct vhost_dev *) vso->value.dev;
 }
 
-SharedObjectType virtio_object_type(const QemuUUID *uuid)
+SharedObjectType virtio_dmabuf_object_type(const QemuUUID *uuid)
 {
     VirtioSharedObject *vso = get_shared_object(uuid);
     if (vso == NULL) {
@@ -162,7 +162,7 @@ int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev)
     return num_removed;
 }
 
-void virtio_free_resources(void)
+void virtio_dmabuf_free_resources(void)
 {
     WITH_QEMU_LOCK_GUARD(&lock) {
         g_hash_table_destroy(resource_uuids);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 152710d30d..104d7d4e62 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
     QemuUUID uuid;
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
-    return virtio_add_vhost_device(&uuid, dev);
+    return virtio_dmabuf_add_vhost_device(&uuid, dev);
 }
 
 static int
@@ -1617,10 +1617,10 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
     QemuUUID uuid;
 
     memcpy(uuid.data, object->uuid, sizeof(object->uuid));
-    switch (virtio_object_type(&uuid)) {
+    switch (virtio_dmabuf_object_type(&uuid)) {
     case TYPE_VHOST_DEV:
     {
-        struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
+        struct vhost_dev *owner = virtio_dmabuf_lookup_vhost_device(&uuid);
         if (dev != owner) {
             /* Not allowed to remove non-owned entries */
             return 0;
@@ -1632,7 +1632,7 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
         return 0;
     }
 
-    return virtio_remove_resource(&uuid);
+    return virtio_dmabuf_remove_resource(&uuid);
 }
 
 static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
@@ -1710,13 +1710,13 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
     memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
 
     payload->u64 = 0;
-    switch (virtio_object_type(&uuid)) {
+    switch (virtio_dmabuf_object_type(&uuid)) {
     case TYPE_DMABUF:
-        dmabuf_fd = virtio_lookup_dmabuf(&uuid);
+        dmabuf_fd = virtio_dmabuf_lookup(&uuid);
         break;
     case TYPE_VHOST_DEV:
     {
-        struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
+        struct vhost_dev *dev = virtio_dmabuf_lookup_vhost_device(&uuid);
         if (dev == NULL) {
             payload->u64 = -EINVAL;
             break;
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
index 950cd24967..b9ee761a0c 100644
--- a/include/hw/virtio/virtio-dmabuf.h
+++ b/include/hw/virtio/virtio-dmabuf.h
@@ -56,7 +56,7 @@ typedef struct VirtioSharedObject {
 void virtio_dmabuf_init(void);
 
 /**
- * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
+ * virtio_dmabuf_add() - Add a new dma-buf resource to the lookup table
  * @uuid: new resource's UUID
  * @dmabuf_fd: the dma-buf descriptor that will be stored and shared with
  *             other virtio devices. The caller retains ownership over the
@@ -69,11 +69,11 @@ void virtio_dmabuf_init(void);
  * Note that if it finds a repeated UUID, the resource is not inserted in
  * the lookup table.
  */
-bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);
+bool virtio_dmabuf_add(QemuUUID *uuid, int dmabuf_fd);
 
 /**
- * virtio_add_vhost_device() - Add a new exporter vhost device that holds the
- * resource with the associated UUID
+ * virtio_dmabuf_add_vhost_device() - Add a new exporter vhost device that
+ * holds the resource with the associated UUID
  * @uuid: new resource's UUID
  * @dev: the pointer to the vhost device that holds the resource. The caller
  *       retains ownership over the device struct and its lifecycle.
@@ -83,41 +83,42 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int dmabuf_fd);
  * Note that if it finds a repeated UUID, the resource is not inserted in
  * the lookup table.
  */
-bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);
+bool virtio_dmabuf_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev);
 
 /**
- * virtio_remove_resource() - Removes a resource from the lookup table
+ * virtio_dmabuf_remove_resource() - Removes a resource from the lookup table
  * @uuid: resource's UUID
  *
  * Return: true if the UUID has been found and removed from the lookup table.
  */
-bool virtio_remove_resource(const QemuUUID *uuid);
+bool virtio_dmabuf_remove_resource(const QemuUUID *uuid);
 
 /**
- * virtio_lookup_dmabuf() - Looks for a dma-buf resource in the lookup table
+ * virtio_dmabuf_lookup() - Looks for a dma-buf resource in the lookup table
  * @uuid: resource's UUID
  *
  * Return: the dma-buf file descriptor integer, or -1 if the key is not found.
  */
-int virtio_lookup_dmabuf(const QemuUUID *uuid);
+int virtio_dmabuf_lookup(const QemuUUID *uuid);
 
 /**
- * virtio_lookup_vhost_device() - Looks for an exporter vhost device in the
- * lookup table
+ * virtio_dmabuf_lookup_vhost_device() - Looks for an exporter vhost device
+ * in the lookup table
  * @uuid: resource's UUID
  *
  * Return: pointer to the vhost_dev struct, or NULL if the key is not found.
  */
-struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);
+struct vhost_dev *virtio_dmabuf_lookup_vhost_device(const QemuUUID *uuid);
 
 /**
- * virtio_object_type() - Looks for the type of resource in the lookup table
+ * virtio_dmabuf_object_type() - Looks for the type of resource in the
+ * lookup table
  * @uuid: resource's UUID
  *
  * Return: the type of resource associated with the UUID, or TYPE_INVALID if
  * the key is not found.
  */
-SharedObjectType virtio_object_type(const QemuUUID *uuid);
+SharedObjectType virtio_dmabuf_object_type(const QemuUUID *uuid);
 
 /**
  * virtio_dmabuf_vhost_cleanup() - Destroys all entries of the shared
@@ -130,9 +131,9 @@ SharedObjectType virtio_object_type(const QemuUUID *uuid);
 int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev);
 
 /**
- * virtio_free_resources() - Destroys all keys and values of the shared
+ * virtio_dmabuf_free_resources() - Destroys all keys and values of the shared
  * resources lookup table, and frees them
  */
-void virtio_free_resources(void);
+void virtio_dmabuf_free_resources(void);
 
 #endif /* VIRTIO_DMABUF_H */
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
index e5cf7ee19f..a0ff89cd3f 100644
--- a/tests/unit/test-virtio-dmabuf.c
+++ b/tests/unit/test-virtio-dmabuf.c
@@ -32,12 +32,12 @@ static void test_add_remove_resources(void)
         qemu_uuid_generate(&uuid);
         dmabuf_fd = g_random_int_range(3, 500);
         /* Add a new resource */
-        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
+        g_assert(virtio_dmabuf_add(&uuid, dmabuf_fd));
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, dmabuf_fd);
         /* Remove the resource */
-        g_assert(virtio_remove_resource(&uuid));
+        g_assert(virtio_dmabuf_remove_resource(&uuid));
         /* Resource is not found anymore */
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, -1);
     }
 }
 
@@ -50,13 +50,13 @@ static void test_add_remove_dev(void)
     virtio_dmabuf_init();
     for (i = 0; i < 100; ++i) {
         qemu_uuid_generate(&uuid);
-        virtio_add_vhost_device(&uuid, dev);
+        virtio_dmabuf_add_vhost_device(&uuid, dev);
         /* vhost device is found */
-        g_assert(virtio_lookup_vhost_device(&uuid) != NULL);
+        g_assert(virtio_dmabuf_lookup_vhost_device(&uuid) != NULL);
         /* Remove the vhost device */
-        g_assert(virtio_remove_resource(&uuid));
+        g_assert(virtio_dmabuf_remove_resource(&uuid));
         /* vhost device is not found anymore */
-        g_assert(virtio_lookup_vhost_device(&uuid) == NULL);
+        g_assert(virtio_dmabuf_lookup_vhost_device(&uuid) == NULL);
     }
     g_free(dev);
 }
@@ -69,9 +69,9 @@ static void test_remove_invalid_resource(void)
     virtio_dmabuf_init();
     for (i = 0; i < 20; ++i) {
         qemu_uuid_generate(&uuid);
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, -1);
         /* Removing a resource that does not exist returns false */
-        g_assert_false(virtio_remove_resource(&uuid));
+        g_assert_false(virtio_dmabuf_remove_resource(&uuid));
     }
 }
 
@@ -85,25 +85,25 @@ static void test_add_invalid_resource(void)
     for (i = 0; i < 20; ++i) {
         qemu_uuid_generate(&uuid);
         /* Add a new resource with invalid (negative) resource fd */
-        g_assert_false(virtio_add_dmabuf(&uuid, dmabuf_fd));
+        g_assert_false(virtio_dmabuf_add(&uuid, dmabuf_fd));
         /* Resource is not found */
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, -1);
         /* Add a new vhost device with invalid (NULL) pointer */
-        g_assert_false(virtio_add_vhost_device(&uuid, dev));
+        g_assert_false(virtio_dmabuf_add_vhost_device(&uuid, dev));
         /* vhost device is not found */
-        g_assert(virtio_lookup_vhost_device(&uuid) == NULL);
+        g_assert(virtio_dmabuf_lookup_vhost_device(&uuid) == NULL);
     }
 
     for (i = 0; i < 20; ++i) {
         /* Add a valid resource */
         qemu_uuid_generate(&uuid);
         dmabuf_fd = g_random_int_range(3, 500);
-        g_assert(virtio_add_dmabuf(&uuid, dmabuf_fd));
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
+        g_assert(virtio_dmabuf_add(&uuid, dmabuf_fd));
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, dmabuf_fd);
         /* Add a new resource with repeated uuid returns false */
-        g_assert_false(virtio_add_dmabuf(&uuid, alt_dmabuf));
+        g_assert_false(virtio_dmabuf_add(&uuid, alt_dmabuf));
         /* The value for the uuid key is not replaced */
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, dmabuf_fd);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuid), ==, dmabuf_fd);
     }
 }
 
@@ -116,25 +116,25 @@ static void test_cleanup_res(void)
 
     for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
         qemu_uuid_generate(&uuids[i]);
-        virtio_add_vhost_device(&uuids[i], dev);
+        virtio_dmabuf_add_vhost_device(&uuids[i], dev);
         /* vhost device is found */
-        g_assert(virtio_lookup_vhost_device(&uuids[i]) != NULL);
+        g_assert(virtio_dmabuf_lookup_vhost_device(&uuids[i]) != NULL);
     }
     qemu_uuid_generate(&uuid_alt);
-    virtio_add_vhost_device(&uuid_alt, dev_alt);
+    virtio_dmabuf_add_vhost_device(&uuid_alt, dev_alt);
     /* vhost device is found */
-    g_assert(virtio_lookup_vhost_device(&uuid_alt) != NULL);
+    g_assert(virtio_dmabuf_lookup_vhost_device(&uuid_alt) != NULL);
     /* cleanup all dev resources */
     num_removed = virtio_dmabuf_vhost_cleanup(dev);
     g_assert_cmpint(num_removed, ==, ARRAY_SIZE(uuids));
     for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
         /* None of the dev resources is found after free'd */
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, -1);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuids[i]), ==, -1);
     }
     /* uuid_alt is still in the hash table */
-    g_assert(virtio_lookup_vhost_device(&uuid_alt) != NULL);
+    g_assert(virtio_dmabuf_lookup_vhost_device(&uuid_alt) != NULL);
 
-    virtio_free_resources();
+    virtio_dmabuf_free_resources();
     g_free(dev);
     g_free(dev_alt);
 }
@@ -148,13 +148,13 @@ static void test_free_resources(void)
     for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
         qemu_uuid_generate(&uuids[i]);
         dmabuf_fd = g_random_int_range(3, 500);
-        g_assert(virtio_add_dmabuf(&uuids[i], dmabuf_fd));
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, dmabuf_fd);
+        g_assert(virtio_dmabuf_add(&uuids[i], dmabuf_fd));
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuids[i]), ==, dmabuf_fd);
     }
-    virtio_free_resources();
+    virtio_dmabuf_free_resources();
     for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
         /* None of the resources is found after free'd */
-        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, -1);
+        g_assert_cmpint(virtio_dmabuf_lookup(&uuids[i]), ==, -1);
     }
 
 }
-- 
2.43.1



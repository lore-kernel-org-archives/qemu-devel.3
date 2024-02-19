Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5E4C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4jN-0007jb-AX; Mon, 19 Feb 2024 09:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4jG-0007iP-7w
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4jE-0003rJ-6t
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708353283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98yhwqbsidcnwnpY+o364o71w+Bbdr+rkpAcCec0C3k=;
 b=ctil9gSJmVtBHTCW7g9f/wlTBghPEW31/sTeTYGFUFeRnv0STmEUOB08hb1dhgTUe619ee
 FZA8FAP5US5qOiWEkvfiTk1kVTUihpuP4Fvt5URaXHj5buQGIbXr62jC6E9p1ARnBBXBgs
 N0qP2HZYusEtXA6AMG6l2NLmky7UfSE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-qUchfjb8PxKuwrLLrO8_UA-1; Mon,
 19 Feb 2024 09:34:40 -0500
X-MC-Unique: qUchfjb8PxKuwrLLrO8_UA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B68D3830092;
 Mon, 19 Feb 2024 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E799200B2D7;
 Mon, 19 Feb 2024 14:34:37 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@gmail.com, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 3/5] hw/virtio: change dmabuf mutex to QemuMutex
Date: Mon, 19 Feb 2024 15:34:21 +0100
Message-ID: <20240219143423.272012-4-aesteve@redhat.com>
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

Change GMutex by QemuMutex to be able to use
lock contexts with `WITH_QEMU_LOCK_GUARD`.

As the lock needs to be initialised and there
is no central point for initialisation, add
an init public function and call it from
virtio.c, each time a new backend structure
is initialised.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/display/virtio-dmabuf.c        | 55 +++++++++++++++++--------------
 hw/virtio/virtio.c                |  3 ++
 include/hw/virtio/virtio-dmabuf.h |  5 +++
 tests/unit/test-virtio-dmabuf.c   |  5 +++
 4 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 497cb6fa7c..961094a561 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -11,11 +11,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "include/qemu/lockable.h"
 
 #include "hw/virtio/virtio-dmabuf.h"
 
 
-static GMutex lock;
+static QemuMutex lock;
 static GHashTable *resource_uuids;
 
 /*
@@ -27,23 +28,27 @@ static int uuid_equal_func(const void *lhv, const void *rhv)
     return qemu_uuid_is_equal(lhv, rhv);
 }
 
+void virtio_dmabuf_init(void) {
+    qemu_mutex_init(&lock);
+}
+
 static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
 {
     bool result = true;
 
-    g_mutex_lock(&lock);
-    if (resource_uuids == NULL) {
-        resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
-                                               uuid_equal_func,
-                                               NULL,
-                                               g_free);
-    }
-    if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
-        g_hash_table_insert(resource_uuids, uuid, value);
-    } else {
-        result = false;
+    WITH_QEMU_LOCK_GUARD(&lock) {
+        if (resource_uuids == NULL) {
+            resource_uuids = g_hash_table_new_full(qemu_uuid_hash,
+                                                uuid_equal_func,
+                                                NULL,
+                                                g_free);
+        }
+        if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
+            g_hash_table_insert(resource_uuids, uuid, value);
+        } else {
+            result = false;
+        }
     }
-    g_mutex_unlock(&lock);
 
     return result;
 }
@@ -87,9 +92,9 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
 bool virtio_remove_resource(const QemuUUID *uuid)
 {
     bool result;
-    g_mutex_lock(&lock);
-    result = g_hash_table_remove(resource_uuids, uuid);
-    g_mutex_unlock(&lock);
+    WITH_QEMU_LOCK_GUARD(&lock) {
+        result = g_hash_table_remove(resource_uuids, uuid);
+    }
 
     return result;
 }
@@ -98,11 +103,11 @@ static VirtioSharedObject *get_shared_object(const QemuUUID *uuid)
 {
     gpointer lookup_res = NULL;
 
-    g_mutex_lock(&lock);
-    if (resource_uuids != NULL) {
-        lookup_res = g_hash_table_lookup(resource_uuids, uuid);
+    WITH_QEMU_LOCK_GUARD(&lock) {
+        if (resource_uuids != NULL) {
+            lookup_res = g_hash_table_lookup(resource_uuids, uuid);
+        }
     }
-    g_mutex_unlock(&lock);
 
     return (VirtioSharedObject *) lookup_res;
 }
@@ -138,9 +143,9 @@ SharedObjectType virtio_object_type(const QemuUUID *uuid)
 
 void virtio_free_resources(void)
 {
-    g_mutex_lock(&lock);
-    g_hash_table_destroy(resource_uuids);
-    /* Reference count shall be 0 after the implicit unref on destroy */
-    resource_uuids = NULL;
-    g_mutex_unlock(&lock);
+    WITH_QEMU_LOCK_GUARD(&lock) {
+        g_hash_table_destroy(resource_uuids);
+        /* Reference count shall be 0 after the implicit unref on destroy */
+        resource_uuids = NULL;
+    }
 }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d229755eae..88189e7178 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -29,6 +29,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-access.h"
+#include "hw/virtio/virtio-dmabuf.h"
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
 #include "virtio-qmp.h"
@@ -3221,6 +3222,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
     int i;
     int nvectors = k->query_nvectors ? k->query_nvectors(qbus->parent) : 0;
 
+    // Ensure virtio dmabuf table is initialised.
+    virtio_dmabuf_init();
     if (nvectors) {
         vdev->vector_queues =
             g_malloc0(sizeof(*vdev->vector_queues) * nvectors);
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
index 891a43162d..627d84dce9 100644
--- a/include/hw/virtio/virtio-dmabuf.h
+++ b/include/hw/virtio/virtio-dmabuf.h
@@ -50,6 +50,11 @@ typedef struct VirtioSharedObject {
     } value;
 } VirtioSharedObject;
 
+/**
+ * virtio_dmabuf_init() - Initialise virtio dmabuf internal structures.
+ */
+void virtio_dmabuf_init(void);
+
 /**
  * virtio_add_dmabuf() - Add a new dma-buf resource to the lookup table
  * @uuid: new resource's UUID
diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
index a45ec52f42..20213455ee 100644
--- a/tests/unit/test-virtio-dmabuf.c
+++ b/tests/unit/test-virtio-dmabuf.c
@@ -27,6 +27,7 @@ static void test_add_remove_resources(void)
     QemuUUID uuid;
     int i, dmabuf_fd;
 
+    virtio_dmabuf_init();
     for (i = 0; i < 100; ++i) {
         qemu_uuid_generate(&uuid);
         dmabuf_fd = g_random_int_range(3, 500);
@@ -46,6 +47,7 @@ static void test_add_remove_dev(void)
     struct vhost_dev *dev = g_new0(struct vhost_dev, 1);
     int i;
 
+    virtio_dmabuf_init();
     for (i = 0; i < 100; ++i) {
         qemu_uuid_generate(&uuid);
         virtio_add_vhost_device(&uuid, dev);
@@ -64,6 +66,7 @@ static void test_remove_invalid_resource(void)
     QemuUUID uuid;
     int i;
 
+    virtio_dmabuf_init();
     for (i = 0; i < 20; ++i) {
         qemu_uuid_generate(&uuid);
         g_assert_cmpint(virtio_lookup_dmabuf(&uuid), ==, -1);
@@ -78,6 +81,7 @@ static void test_add_invalid_resource(void)
     struct vhost_dev *dev = NULL;
     int i, dmabuf_fd = -2, alt_dmabuf = 2;
 
+    virtio_dmabuf_init();
     for (i = 0; i < 20; ++i) {
         qemu_uuid_generate(&uuid);
         /* Add a new resource with invalid (negative) resource fd */
@@ -108,6 +112,7 @@ static void test_free_resources(void)
     QemuUUID uuids[20];
     int i, dmabuf_fd;
 
+    virtio_dmabuf_init();
     for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
         qemu_uuid_generate(&uuids[i]);
         dmabuf_fd = g_random_int_range(3, 500);
-- 
2.43.1



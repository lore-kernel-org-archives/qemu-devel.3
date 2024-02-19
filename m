Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289B0C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4jK-0007iv-Rs; Mon, 19 Feb 2024 09:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4jE-0007hA-D5
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rc4jB-0003qy-Pu
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708353280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=viv1ei9TE6PclCvoUv4smop7x8HeIq1N/VAQZhMnZNE=;
 b=FrDNwlZZybS8P1emhNZ0B2dZ+B0WXxvckpKmz31naqTNr1KyBbjk0eE23t8XU9aaWtdwPB
 CVPI7TWtMCZuDVIS9yIti/9W8onrjsH9qixj8RIqix3qEntUpfDBAOmcpusVI2SpuxxAAL
 +ptYfK9matYfYUQnIQsbMiEztDRIySs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-HAIu5jTfNNeKbuMEEzIO2Q-1; Mon, 19 Feb 2024 09:34:37 -0500
X-MC-Unique: HAIu5jTfNNeKbuMEEzIO2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06FE685A588;
 Mon, 19 Feb 2024 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.250])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0604F20229A3;
 Mon, 19 Feb 2024 14:34:34 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@gmail.com, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 2/5] hw/virtio: document SharedObject structures
Date: Mon, 19 Feb 2024 15:34:20 +0100
Message-ID: <20240219143423.272012-3-aesteve@redhat.com>
In-Reply-To: <20240219143423.272012-1-aesteve@redhat.com>
References: <20240219143423.272012-1-aesteve@redhat.com>
MIME-Version: 1.0
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

Change VirtioSharedObject value type from
a generic pointer to a union storing the different
supported underlying types, which makes naming
less confusing.

With the update, use the chance to add kdoc
to both the SharedObjectType enum and
VirtioSharedObject struct.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/display/virtio-dmabuf.c        |  8 ++++----
 include/hw/virtio/virtio-dmabuf.h | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 3dba4577ca..497cb6fa7c 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -57,7 +57,7 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
     }
     vso = g_new(VirtioSharedObject, 1);
     vso->type = TYPE_DMABUF;
-    vso->value = GINT_TO_POINTER(udmabuf_fd);
+    vso->value.udma_buf = udmabuf_fd;
     result = virtio_add_resource(uuid, vso);
     if (!result) {
         g_free(vso);
@@ -75,7 +75,7 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
     }
     vso = g_new(VirtioSharedObject, 1);
     vso->type = TYPE_VHOST_DEV;
-    vso->value = dev;
+    vso->value.dev = dev;
     result = virtio_add_resource(uuid, vso);
     if (!result) {
         g_free(vso);
@@ -114,7 +114,7 @@ int virtio_lookup_dmabuf(const QemuUUID *uuid)
         return -1;
     }
     assert(vso->type == TYPE_DMABUF);
-    return GPOINTER_TO_INT(vso->value);
+    return vso->value.udma_buf;
 }
 
 struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
@@ -124,7 +124,7 @@ struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
         return NULL;
     }
     assert(vso->type == TYPE_VHOST_DEV);
-    return (struct vhost_dev *) vso->value;
+    return (struct vhost_dev *) vso->value.dev;
 }
 
 SharedObjectType virtio_object_type(const QemuUUID *uuid)
diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
index 627c3b6db7..891a43162d 100644
--- a/include/hw/virtio/virtio-dmabuf.h
+++ b/include/hw/virtio/virtio-dmabuf.h
@@ -16,15 +16,38 @@
 #include "qemu/uuid.h"
 #include "vhost.h"
 
+/**
+ * SharedObjectType:
+ * 
+ * Identifies the type of the underlying type that the current lookup
+ * table entry is holding.
+ * 
+ * TYPE_INVALID: Invalid entry
+ * TYPE_DMABUF: Entry is a dmabuf file descriptor that can be directly
+ *              shared with the requestor
+ * TYPE_VHOST_DEV: Entry is a pointer to a vhost device that is holding
+ *                 the shared object.
+ */
 typedef enum SharedObjectType {
     TYPE_INVALID = 0,
     TYPE_DMABUF,
     TYPE_VHOST_DEV,
 } SharedObjectType;
 
+/**
+ * VirtioSharedObject:
+ * @type: Shared object type identifier
+ * @value: Union containing to the underlying type
+ * 
+ * The VirtioSharedObject object provides a way to distinguish,
+ * store, and handle the different types supported by the lookup table.
+ */
 typedef struct VirtioSharedObject {
     SharedObjectType type;
-    gpointer value;
+    union {
+        struct vhost_dev *dev;  /* TYPE_VHOST_DEV */
+        int udma_buf;           /* TYPE_DMABUF */
+    } value;
 } VirtioSharedObject;
 
 /**
-- 
2.43.1



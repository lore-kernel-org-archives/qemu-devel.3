Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C18C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3sP-0002IL-1S; Tue, 07 Jul 2026 07:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wh3sK-0002D5-21
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wh3sI-0002sO-6X
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783423321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61wZAldU9pmQB81HUAvBNMJ/a4cqp9X8nZD/50zn2FM=;
 b=TmrOFF4t9KQ1DedssjmmzaEpd3nkZGzFK8iJFrlBDmyjruiwR59/VGaPqoAGA7hAtZr7uj
 0GgF8kR29EpLprDjTHzKj8e/o5ySFpKKSJDXFexo9c8LonaTGfvK3lOVapg3BPVAauKn29
 saSvq9MmvlxnU18ID/NlKqDuIvlkKQM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-k1mFv6jxNYifYCuc-fUcSw-1; Tue,
 07 Jul 2026 07:21:59 -0400
X-MC-Unique: k1mFv6jxNYifYCuc-fUcSw-1
X-Mimecast-MFC-AGG-ID: k1mFv6jxNYifYCuc-fUcSw_1783423319
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F38DB1954AF5
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:21:58 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB699180067C; Tue,  7 Jul 2026 11:21:57 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 2/2] virtio: use g_autoptr guard for shmem map transaction
Date: Tue,  7 Jul 2026 13:21:49 +0200
Message-ID: <20260707112149.2867886-3-aesteve@redhat.com>
In-Reply-To: <20260707112149.2867886-1-aesteve@redhat.com>
References: <20260707112149.2867886-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use g_autoptr(VirtioShmemGuard) to automatically commit the memory
region transaction opened by virtio_add_shmem_map_start(), removing
explicit virtio_add_shmem_map_end() calls on each exit path of
vhost_user_backend_handle_shmem_map(). This also allows the
send_reply_commit label to be folded into send_reply since the two
blocks are now identical.

VirtioShmemGuard is a sentinel type whose non-NULL value triggers
the cleanup function on scope exit via GLib's g_autoptr infrastructure,
similar to those used in main-loop.h and rcu.h.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c     | 21 ++++-----------------
 hw/virtio/virtio.c         |  4 +++-
 include/hw/virtio/virtio.h | 16 ++++++++++++++--
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f6bf9e0ba4..0306b06b48 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1933,6 +1933,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
                                     VhostUserPayload *payload,
                                     int fd)
 {
+    g_autoptr(VirtioShmemGuard) shmem_guard = NULL;
     VirtioSharedMemory *shmem;
     VhostUserMMap *vu_mmap = &payload->mmap;
     VirtioSharedMemoryMapping *existing;
@@ -1977,7 +1978,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         }
     }
 
-    virtio_add_shmem_map_start();
+    shmem_guard = virtio_add_shmem_map_start();
 
     /* Create VirtioSharedMemoryMapping object */
     VirtioSharedMemoryMapping *mapping = virtio_shared_memory_mapping_new(
@@ -1986,7 +1987,7 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
 
     if (!mapping) {
         ret = -EFAULT;
-        goto send_reply_commit;
+        goto send_reply;
     }
 
     /* Add the mapping to the shared memory region */
@@ -1994,22 +1995,8 @@ vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
         error_report("Failed to add shared memory mapping");
         object_unref(OBJECT(mapping));
         ret = -EFAULT;
-        goto send_reply_commit;
-    }
-
-send_reply_commit:
-    /* Send reply and commit after transaction started */
-    if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
-        payload->u64 = !!ret;
-        hdr->size = sizeof(payload->u64);
-        if (!vhost_user_send_resp(ioc, hdr, payload, &local_err)) {
-            error_report_err(local_err);
-            virtio_add_shmem_map_end();
-            return -EFAULT;
-        }
+        goto send_reply;
     }
-    virtio_add_shmem_map_end();
-    return 0;
 
 send_reply:
     if (hdr->flags & VHOST_USER_NEED_REPLY_MASK) {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e604781ffe..1db800fcd7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3226,9 +3226,11 @@ VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
     return mapping;
 }
 
-void virtio_add_shmem_map_start(void)
+VirtioShmemGuard *virtio_add_shmem_map_start(void)
 {
     memory_region_transaction_begin();
+    /* Anything non-NULL causes the cleanup function to be called */
+    return (VirtioShmemGuard *)(uintptr_t)1;
 }
 
 void virtio_add_shmem_map_end(void)
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9935452486..b9e67f789c 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -104,6 +104,8 @@ enum virtio_device_endian {
 #define TYPE_VIRTIO_SHARED_MEMORY_MAPPING "virtio-shared-memory-mapping"
 OBJECT_DECLARE_SIMPLE_TYPE(VirtioSharedMemoryMapping, VIRTIO_SHARED_MEMORY_MAPPING)
 
+typedef void VirtioShmemGuard;
+
 /**
  * VirtioSharedMemoryMapping:
  * @parent: Parent QOM object
@@ -396,17 +398,27 @@ VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
  * Begins a transaction to add a shared memory mapping. Call this before adding
  * a shared memory mapping when the commit must be delayed until after a reply
  * is sent to a vhost-user backend.
+ *
+ * Returns: Non-NULL guard that triggers cleanup on scope exit.
  */
-void virtio_add_shmem_map_start(void);
+VirtioShmemGuard *virtio_add_shmem_map_start(void);
 
 /**
  * virtio_add_shmem_map_end() - End a shmem map transaction
  *
  * Completes the transaction started by virtio_add_shmem_map_start() and makes
- * the mapping visible to the guest.
+ * the mapping visible to the guest. Prefer using g_autoptr(VirtioShmemGuard)
+ * over calling this directly.
  */
 void virtio_add_shmem_map_end(void);
 
+static inline void virtio_shmem_guard_cleanup(VirtioShmemGuard *guard)
+{
+    virtio_add_shmem_map_end();
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(VirtioShmemGuard, virtio_shmem_guard_cleanup)
+
 /**
  * virtio_add_shmem_map() - Add a memory mapping to a shared region
  * @shmem: VirtioSharedMemory region
-- 
2.54.0



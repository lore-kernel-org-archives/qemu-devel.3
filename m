Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B66C4829A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpu1-0006z3-FS; Wed, 07 Feb 2024 16:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXptx-0006tr-6m
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXptu-0007Zi-BM
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tjw2T6WxHBOsk4dS3pmOqgHLyH49hi1syhQPH8PB72s=;
 b=RLTENfFcSm9bDFfmV4wrQNAA98GVk0VIlr+uP+ElZhsh13tkdt/35ml69fw0t1muF1zttA
 5TeZDQNzEXkTx+ukJjh+/vhq8LAddKYiviUGxuozzSf2brPiS+4Hsi7USmmDXqbdgOimvW
 N2kA5Cn+dt5z+A8DZkojFsCzE/sgQHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-VKhv-b85MZiYj-8LSnoMkg-1; Wed, 07 Feb 2024 16:56:10 -0500
X-MC-Unique: VKhv-b85MZiYj-8LSnoMkg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83F1E101FA2A;
 Wed,  7 Feb 2024 21:56:10 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7F20492BC6;
 Wed,  7 Feb 2024 21:56:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/16] virtio-blk: enforce iothread-vq-mapping validation
Date: Wed,  7 Feb 2024 22:55:51 +0100
Message-ID: <20240207215606.206038-2-kwolf@redhat.com>
In-Reply-To: <20240207215606.206038-1-kwolf@redhat.com>
References: <20240207215606.206038-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Hanna Czenczek <hreitz@redhat.com> noticed that the safety of
`vq_aio_context[vq->value] = ctx;` with user-defined vq->value inputs is
not obvious.

The code is structured in validate() + apply() steps so input validation
is there, but it happens way earlier and there is nothing that
guarantees apply() can only be called with validated inputs.

This patch moves the validate() call inside the apply() function so
validation is guaranteed. I also added the bounds checking assertion
that Hanna suggested.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20240206190610.107963-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 183 +++++++++++++++++++++++-------------------
 1 file changed, 102 insertions(+), 81 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 227d83569f..6e3e3a23ee 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1485,68 +1485,6 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
     return 0;
 }
 
-static bool
-validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
-        uint16_t num_queues, Error **errp)
-{
-    g_autofree unsigned long *vqs = bitmap_new(num_queues);
-    g_autoptr(GHashTable) iothreads =
-        g_hash_table_new(g_str_hash, g_str_equal);
-
-    for (IOThreadVirtQueueMappingList *node = list; node; node = node->next) {
-        const char *name = node->value->iothread;
-        uint16List *vq;
-
-        if (!iothread_by_id(name)) {
-            error_setg(errp, "IOThread \"%s\" object does not exist", name);
-            return false;
-        }
-
-        if (!g_hash_table_add(iothreads, (gpointer)name)) {
-            error_setg(errp,
-                    "duplicate IOThread name \"%s\" in iothread-vq-mapping",
-                    name);
-            return false;
-        }
-
-        if (node != list) {
-            if (!!node->value->vqs != !!list->value->vqs) {
-                error_setg(errp, "either all items in iothread-vq-mapping "
-                                 "must have vqs or none of them must have it");
-                return false;
-            }
-        }
-
-        for (vq = node->value->vqs; vq; vq = vq->next) {
-            if (vq->value >= num_queues) {
-                error_setg(errp, "vq index %u for IOThread \"%s\" must be "
-                        "less than num_queues %u in iothread-vq-mapping",
-                        vq->value, name, num_queues);
-                return false;
-            }
-
-            if (test_and_set_bit(vq->value, vqs)) {
-                error_setg(errp, "cannot assign vq %u to IOThread \"%s\" "
-                        "because it is already assigned", vq->value, name);
-                return false;
-            }
-        }
-    }
-
-    if (list->value->vqs) {
-        for (uint16_t i = 0; i < num_queues; i++) {
-            if (!test_bit(i, vqs)) {
-                error_setg(errp,
-                        "missing vq %u IOThread assignment in iothread-vq-mapping",
-                        i);
-                return false;
-            }
-        }
-    }
-
-    return true;
-}
-
 static void virtio_resize_cb(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -1613,15 +1551,95 @@ static const BlockDevOps virtio_block_ops = {
     .drained_end   = virtio_blk_drained_end,
 };
 
-/* Generate vq:AioContext mappings from a validated iothread-vq-mapping list */
-static void
-apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
-                 AioContext **vq_aio_context, uint16_t num_queues)
+static bool
+validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
+        uint16_t num_queues, Error **errp)
+{
+    g_autofree unsigned long *vqs = bitmap_new(num_queues);
+    g_autoptr(GHashTable) iothreads =
+        g_hash_table_new(g_str_hash, g_str_equal);
+
+    for (IOThreadVirtQueueMappingList *node = list; node; node = node->next) {
+        const char *name = node->value->iothread;
+        uint16List *vq;
+
+        if (!iothread_by_id(name)) {
+            error_setg(errp, "IOThread \"%s\" object does not exist", name);
+            return false;
+        }
+
+        if (!g_hash_table_add(iothreads, (gpointer)name)) {
+            error_setg(errp,
+                    "duplicate IOThread name \"%s\" in iothread-vq-mapping",
+                    name);
+            return false;
+        }
+
+        if (node != list) {
+            if (!!node->value->vqs != !!list->value->vqs) {
+                error_setg(errp, "either all items in iothread-vq-mapping "
+                                 "must have vqs or none of them must have it");
+                return false;
+            }
+        }
+
+        for (vq = node->value->vqs; vq; vq = vq->next) {
+            if (vq->value >= num_queues) {
+                error_setg(errp, "vq index %u for IOThread \"%s\" must be "
+                        "less than num_queues %u in iothread-vq-mapping",
+                        vq->value, name, num_queues);
+                return false;
+            }
+
+            if (test_and_set_bit(vq->value, vqs)) {
+                error_setg(errp, "cannot assign vq %u to IOThread \"%s\" "
+                        "because it is already assigned", vq->value, name);
+                return false;
+            }
+        }
+    }
+
+    if (list->value->vqs) {
+        for (uint16_t i = 0; i < num_queues; i++) {
+            if (!test_bit(i, vqs)) {
+                error_setg(errp,
+                        "missing vq %u IOThread assignment in iothread-vq-mapping",
+                        i);
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
+/**
+ * apply_iothread_vq_mapping:
+ * @iothread_vq_mapping_list: The mapping of virtqueues to IOThreads.
+ * @vq_aio_context: The array of AioContext pointers to fill in.
+ * @num_queues: The length of @vq_aio_context.
+ * @errp: If an error occurs, a pointer to the area to store the error.
+ *
+ * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
+ * the iothread-vq-mapping parameter in @iothread_vq_mapping_list.
+ *
+ * Returns: %true on success, %false on failure.
+ **/
+static bool apply_iothread_vq_mapping(
+        IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
+        AioContext **vq_aio_context,
+        uint16_t num_queues,
+        Error **errp)
 {
     IOThreadVirtQueueMappingList *node;
     size_t num_iothreads = 0;
     size_t cur_iothread = 0;
 
+    if (!validate_iothread_vq_mapping_list(iothread_vq_mapping_list,
+                                           num_queues, errp)) {
+        return false;
+    }
+
     for (node = iothread_vq_mapping_list; node; node = node->next) {
         num_iothreads++;
     }
@@ -1638,6 +1656,7 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
 
             /* Explicit vq:IOThread assignment */
             for (vq = node->value->vqs; vq; vq = vq->next) {
+                assert(vq->value < num_queues);
                 vq_aio_context[vq->value] = ctx;
             }
         } else {
@@ -1650,6 +1669,8 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
 
         cur_iothread++;
     }
+
+    return true;
 }
 
 /* Context: BQL held */
@@ -1660,6 +1681,13 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
+    if (conf->iothread && conf->iothread_vq_mapping_list) {
+        error_setg(errp,
+                   "iothread and iothread-vq-mapping properties cannot be set "
+                   "at the same time");
+        return false;
+    }
+
     if (conf->iothread || conf->iothread_vq_mapping_list) {
         if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
             error_setg(errp,
@@ -1685,8 +1713,14 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        apply_vq_mapping(conf->iothread_vq_mapping_list, s->vq_aio_context,
-                         conf->num_queues);
+        if (!apply_iothread_vq_mapping(conf->iothread_vq_mapping_list,
+                                       s->vq_aio_context,
+                                       conf->num_queues,
+                                       errp)) {
+            g_free(s->vq_aio_context);
+            s->vq_aio_context = NULL;
+            return false;
+        }
     } else if (conf->iothread) {
         AioContext *ctx = iothread_get_aio_context(conf->iothread);
         for (unsigned i = 0; i < conf->num_queues; i++) {
@@ -1996,19 +2030,6 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (conf->iothread_vq_mapping_list) {
-        if (conf->iothread) {
-            error_setg(errp, "iothread and iothread-vq-mapping properties "
-                             "cannot be set at the same time");
-            return;
-        }
-
-        if (!validate_iothread_vq_mapping_list(conf->iothread_vq_mapping_list,
-                                               conf->num_queues, errp)) {
-            return;
-        }
-    }
-
     s->config_size = virtio_get_config_size(&virtio_blk_cfg_size_params,
                                             s->host_features);
     virtio_init(vdev, VIRTIO_ID_BLOCK, s->config_size);
-- 
2.43.0



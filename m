Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D37C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDYf-0002um-AS; Wed, 29 Jul 2026 19:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYe-0002tV-Fd
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYc-0008Db-J7
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785367166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYhAW+MmremG0AzEeRTehlTgSHTPIg2EzLiHUHZj2S0=;
 b=Ovb7ig2vzlsfHFC4cHhcAwoivbdi+rAIGymiCz6AMfPRCEuqHe7X+dvkw5jAaR2Td/CMCh
 BFzGoEUYriEClezl0QhFzCUWYKasWqetpjfRQesxizzXn0ECx5fS4F+ATubAaQMoUQh7+d
 GGdYeB+vCu3F72vHUc5My+/h+edwd7g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-Y9ONrybsP3-Wzgu2qa53oQ-1; Wed,
 29 Jul 2026 19:19:22 -0400
X-MC-Unique: Y9ONrybsP3-Wzgu2qa53oQ-1
X-Mimecast-MFC-AGG-ID: Y9ONrybsP3-Wzgu2qa53oQ_1785367161
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 528731956096; Wed, 29 Jul 2026 23:19:21 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 024DD300019F; Wed, 29 Jul 2026 23:19:17 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 3/7] virtio: do not crash QEMU on migration errors
Date: Thu, 30 Jul 2026 01:19:00 +0200
Message-ID: <20260729231904.775331-4-lvivier@redhat.com>
In-Reply-To: <20260729231904.775331-1-lvivier@redhat.com>
References: <20260729231904.775331-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Michael S. Tsirkin" <mst@redhat.com>

Currently virtio-blk, virtio-serial and virtio-scsi all crash on invalid
migration streams because qemu_get_virtqueue_element has no way to
detect and report mapping failures.

Not nice.

Let's propagate mapping errors through qemu_get_virtqueue_element and
fail migration instead.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3888
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[lvivier: use errp rather than qemu_file_set_error() to report error]
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2: new patch from Michael S. Tsirkin
        https://lore.kernel.org/qemu-devel/a0afc9ea82d68f3447c9f58d89c9b46fa074d6c3.1784898250.git.mst@redhat.com/
        Modified to use errp parameter with error_setg() instead of
        qemu_file_set_error() to report errors in virtio-blk,
        virtio-serial, and virtio-scsi

 hw/block/virtio-blk.c       |  4 ++++
 hw/char/virtio-serial-bus.c |  4 ++++
 hw/scsi/virtio-scsi.c       |  4 ++++
 hw/virtio/virtio.c          | 48 +++++++++++++++++++++++++++----------
 include/hw/virtio/virtio.h  |  2 +-
 5 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 352b897c4ae5..ccd6ad404ca0 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1385,6 +1385,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
         }
 
         req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
+        if (!req) {
+            error_setg(errp, "Failed to restore virtio-blk request");
+            return -EINVAL;
+        }
         virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
 
         WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 4a5507e2f755..ecb7c5c7e507 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -764,6 +764,10 @@ static int fetch_active_ports_list(QEMUFile *f, VirtIOSerial *s,
 
             port->elem =
                 qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
+            if (!port->elem) {
+                error_setg(errp, "Failed to restore virtio-serial element");
+                return -EINVAL;
+            }
 
             /*
              *  Port was throttled on source machine.  Let's
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 54667dc4f51d..10eee3a4cff8 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -275,6 +275,10 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq,
     assert(n < vs->conf.num_queues);
     req = qemu_get_virtqueue_element(vdev, f,
                                      sizeof(VirtIOSCSIReq) + vs->cdb_size);
+    if (!req) {
+        error_setg(errp, "Failed to restore virtio-scsi request");
+        return NULL;
+    }
     virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
 
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 64d780b1336e..02f75a5e281b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1680,36 +1680,55 @@ static void virtqueue_undo_map_desc(AddressSpace *as,
     }
 }
 
-static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
+static bool virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
                                 hwaddr *addr, unsigned int num_sg,
                                 bool is_write)
 {
     unsigned int i;
     hwaddr len;
+    DMADirection dir = is_write ? DMA_DIRECTION_FROM_DEVICE :
+                                 DMA_DIRECTION_TO_DEVICE;
 
     for (i = 0; i < num_sg; i++) {
         len = sg[i].iov_len;
-        sg[i].iov_base = dma_memory_map(vdev->dma_as,
-                                        addr[i], &len, is_write ?
-                                        DMA_DIRECTION_FROM_DEVICE :
-                                        DMA_DIRECTION_TO_DEVICE,
-                                        MEMTXATTRS_UNSPECIFIED);
+        sg[i].iov_base = dma_memory_map(vdev->dma_as, addr[i], &len,
+                                        dir, MEMTXATTRS_UNSPECIFIED);
         if (!sg[i].iov_base) {
             error_report("virtio: error trying to map MMIO memory");
-            exit(1);
+            goto err_undo_map;
         }
         if (len != sg[i].iov_len) {
             error_report("virtio: unexpected memory split");
-            exit(1);
+            dma_memory_unmap(vdev->dma_as, sg[i].iov_base, len, dir, 0);
+            goto err_undo_map;
         }
     }
+    return true;
+
+err_undo_map:
+    while (i-- > 0) {
+        dma_memory_unmap(vdev->dma_as, sg[i].iov_base, sg[i].iov_len,
+                         dir, 0);
+    }
+    return false;
 }
 
-void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
+bool virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
 {
-    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num, true);
-    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, elem->out_num,
-                                                                        false);
+    if (!virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr,
+                             elem->in_num, true)) {
+        return false;
+    }
+    if (!virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr,
+                             elem->out_num, false)) {
+        for (unsigned int i = 0; i < elem->in_num; i++) {
+            dma_memory_unmap(vdev->dma_as, elem->in_sg[i].iov_base,
+                             elem->in_sg[i].iov_len,
+                             DMA_DIRECTION_FROM_DEVICE, 0);
+        }
+        return false;
+    }
+    return true;
 }
 
 static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
@@ -2206,7 +2225,10 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
         qemu_get_be32s(f, &elem->ndescs);
     }
 
-    virtqueue_map(vdev, elem);
+    if (!virtqueue_map(vdev, elem)) {
+        g_free(elem);
+        return NULL;
+    }
     return elem;
 }
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index bcb03154e243..d0c63500a58d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -320,7 +320,7 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num);
 void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len, unsigned int idx);
 
-void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
+bool virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
 void *virtqueue_pop(VirtQueue *vq, size_t sz);
 unsigned int virtqueue_drop_all(VirtQueue *vq);
 void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz);
-- 
2.54.0



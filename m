Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17FDC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFaP-0006xq-HU; Fri, 24 Jul 2026 09:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFaI-0006rA-2r
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFaG-0003JS-5A
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kprMw8lVnzE9JWXfGpdV4D7DDo4CJAhBiRehHYcYpq4=;
 b=Lw195JTNq4XAhGBSXFBS9UblZ9hL9Ah0Y3hqrvQl/jO34tSLMrqjPkK0FaKhlFcNg4TV54
 pQZITNtJkcDP1WBWSYTjPO9cBjyCjRNsPlk64VbgqKxpgMxw6VmOpYrqN9feEDTkI6PpqV
 yA0PAMPuTm2qrMJDeOVqqpD9qPYXfrY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-hrXJd7y7MzWOs0sozTbPSg-1; Fri, 24 Jul 2026 09:04:57 -0400
X-MC-Unique: hrXJd7y7MzWOs0sozTbPSg-1
X-Mimecast-MFC-AGG-ID: hrXJd7y7MzWOs0sozTbPSg_1784898296
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4954dcd6131so4676275e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898296; x=1785503096; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kprMw8lVnzE9JWXfGpdV4D7DDo4CJAhBiRehHYcYpq4=;
 b=BXRP7NFZ8wMghTGW2Ya371RFcg1SmI26DFif9bxicaMmGZ0HnHWGxtQOHMULvXnqlE
 Pp5sNVavpsFgdNhrfmK3bOGD0MMBhsJd4iVNn2sIdNO1as+6Jg8dOTiThlbAs7d/BWdQ
 Wmojyg3iCzxtA0stTUyTnqZ1hQVkQjRHKYpUqfxE5jgrsTufAWFRCobAMqbCsy5e+Oh6
 p5qBYqHc0EBV0e5wzskoErR3Rk0uDlLDwx81jAzVyfIdTur3T2d9IN6XjEOG3EnitQoo
 dsGf2tU0UNQ8AbAKSW2KT0R/o7Q9co4n4Iz/WonkHUPZqhlGld4c5+ozYjVR1XUNQVtx
 YdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898296; x=1785503096;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kprMw8lVnzE9JWXfGpdV4D7DDo4CJAhBiRehHYcYpq4=;
 b=Ybl4q+4kgj6sgbPBNw4MckyAA2CwjsNycAaftM0pxYBoDzunYqa64sAc8c1cOSve6X
 IqG91XLl4E5FYyxIiJiW8hS+Ma8xTiOjRbjkVNJqm5Yw2TjnpcEkowPZXMfxwXLMCvYM
 XtZJH39/+jYAV566Adk3uAc37J6XKTKP2h+aClRbfyQH0RbsBcO+gxyOHodzTGErdiMR
 aGu6f8U4mFMAHJKjODGFzVV33Xd3yRgpb88FJl5T+xTPphdKgo2dxbwEUclnwUzWneYS
 4aOP8LOzwb2aag8wTAfXhTIUhXkNAgCuiDBJjjrel024MQFWkmSGU2tTGz83T5+KYjX7
 jAJg==
X-Gm-Message-State: AOJu0YwjtHeQSuzPziED1By59rX5WEOh3Cl/Da/jp6INmsabCwH1WKsH
 KDkZjtKGwoSOjcgq5gfbkBkiH3WNw6wEcRSJqduPUa1iSNjW9MPUfvMBsirD5Q1h3qMGjIBcp1K
 yGjfViJ27PdJ1UzQO2R8+0cIwWICAwdDYg7Amof7iEz6OWz5ERbEi1f5hg2j7E+6NKMpVtTCqmL
 bWi+vV6FE+yyTRRF+OvYl6em+Zw4TRcgY6hA==
X-Gm-Gg: AR+sD10BFg5TqAdmxcsZj4yr7jYP/Zl15b2iw+SivZiPAJx7IWXaGODofGbwGMjeKkt
 rS15fxYSnSv7hqQouo1NbLpxLacT4psft9g4u/Zfvb3YvpWRZcBAjY7UYH2Ix9l107jogUwsClm
 yczOpRFI41ceQ0ZZs4MuIWdfxii/Eey5b5LGLFI2s/1QQ1CKY2oFXHBQbThwWyNtc7owpOJ2gpg
 6M5c31cxFNib3pJnMGrSW3czP7qCmvfpkVNGXRe+yG7vcq2yS7KWMPM0w2l9lw0IOY+vusuEUvf
 aP36hLm5QWkzzdj6e2YqdBBPjtVCIDYePu3bjFscQCj9Gq8Q+1mevupbxDMrC/TBevpa1fGjWiz
 UwcXgRnL0wbK57NJQmHSLpg==
X-Received: by 2002:a05:600c:4f82:b0:495:4a22:d684 with SMTP id
 5b1f17b1804b1-49573ccb03amr72426325e9.10.1784898295720; 
 Fri, 24 Jul 2026 06:04:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4f82:b0:495:4a22:d684 with SMTP id
 5b1f17b1804b1-49573ccb03amr72425635e9.10.1784898295126; 
 Fri, 24 Jul 2026 06:04:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af6a14csm67788585e9.5.2026.07.24.06.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:04:54 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:04:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH 2/3] virtio: do not crash QEMU on migration errors
Message-ID: <a0afc9ea82d68f3447c9f58d89c9b46fa074d6c3.1784898250.git.mst@redhat.com>
References: <3777347521a12252e228e4a6243c75250bf76626.1784898250.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3777347521a12252e228e4a6243c75250bf76626.1784898250.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently virtio-blk, virtio-serial and virtio-scsi all crash on invalid
migration streams because qemu_get_virtqueue_element has no way to
detect and report mapping failures.

Not nice.

Let's propagate mapping errors through qemu_get_virtqueue_element and
fail migration instead.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3888
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h  |  2 +-
 hw/block/virtio-blk.c       |  4 ++++
 hw/char/virtio-serial-bus.c |  4 ++++
 hw/scsi/virtio-scsi.c       |  6 +++++
 hw/virtio/virtio.c          | 48 +++++++++++++++++++++++++++----------
 5 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c99cb19d88..27c5fe3a6b 100644
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
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff..cb6a276a82 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1384,6 +1384,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
         }
 
         req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
+        if (!req) {
+            error_report("Failed to restore virtio-blk request");
+            return -EINVAL;
+        }
         virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
 
         WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c1973f0248..0f56321cc7 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -763,6 +763,10 @@ static int fetch_active_ports_list(QEMUFile *f,
 
             port->elem =
                 qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
+            if (!port->elem) {
+                error_report("Failed to restore virtio-serial element");
+                return -EINVAL;
+            }
 
             /*
              *  Port was throttled on source machine.  Let's
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 53c3c88460..8675afc6e1 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -18,6 +18,7 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "migration/qemu-file-types.h"
+#include "migration/qemu-file.h"
 #include "qemu/defer-call.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
@@ -273,6 +274,11 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     assert(n < vs->conf.num_queues);
     req = qemu_get_virtqueue_element(vdev, f,
                                      sizeof(VirtIOSCSIReq) + vs->cdb_size);
+    if (!req) {
+        error_report("Failed to restore virtio-scsi request");
+        qemu_file_set_error(f, -EINVAL);
+        return NULL;
+    }
     virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
 
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2d33622daf..340bac2607 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1676,36 +1676,55 @@ static void virtqueue_undo_map_desc(AddressSpace *as,
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
@@ -2202,7 +2221,10 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
         qemu_get_be32s(f, &elem->ndescs);
     }
 
-    virtqueue_map(vdev, elem);
+    if (!virtqueue_map(vdev, elem)) {
+        g_free(elem);
+        return NULL;
+    }
     return elem;
 }
 
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798EBC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8h-0001hB-LS; Fri, 11 Sep 2026 05:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8T-0001Wu-3o
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8R-00080I-02
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cY4K5hEbqA2jAPtmBdYZErh868yrTmlvKXQA8mwMwzI=;
 b=J0Hc8pUk4BxRfU9QK82Ox/IkVuKFcTNfRVOjTOCffwZF85/ZE1StLvQVbZPHGBSvYU8w3e
 TnQEr5Hhc7IDD3gbF2bkm4/v0vFLwUTAoTmc631KibqfBtO14bgtZ+YcxrObqMhZAQ/5oX
 YRLq8TXq+zyrwEpWktPkw7REjyoD+uI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-YEVAvbGLNEmJHnoK9AY-jg-1; Fri, 11 Sep 2026 05:01:22 -0400
X-MC-Unique: YEVAvbGLNEmJHnoK9AY-jg-1
X-Mimecast-MFC-AGG-ID: YEVAvbGLNEmJHnoK9AY-jg_1789117281
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e64b80b94so2852425e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117281; x=1789722081; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cY4K5hEbqA2jAPtmBdYZErh868yrTmlvKXQA8mwMwzI=;
 b=VfEq2RRGApK9w49Pc5X3vNlq+DLbib81h7pzKUCn4MrAsnXh3mHcIOUoxdJmJOcWsu
 oiphGifuAmptyEa7xuR/rhnuOis94tooJkHwWpqevfM+ptSJmrgXgr/fjnJOC5VdXvQE
 BCqhQvHDJ6vWbJCukxqj1Si0u/tVGLTJ6bnC6g4mVt9wO9LdVn3Dss5fECiQSUkUpE/B
 +9Nl6ZZkUSMOTSfgb4//M+183UbbkHngJYJdzk2EXLw3v9t15ad82pjcHrUplIxS/uUn
 Emgw7dGYa42eR1xBV5wqbNW5NYgAUUFKGSAzEFIXeXNLUFcC8S2VUKxnvgZvLHWmIoG5
 ZD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117281; x=1789722081;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cY4K5hEbqA2jAPtmBdYZErh868yrTmlvKXQA8mwMwzI=;
 b=mBAll5e5dRed0eSAKSVNKX3CI+LetIWHkwMvKxaQVBPjLPxZ3lCqroxSsUT6q1LQXA
 7TU0+gJNpqVWAVbko8aSflgaWZ3aYEWGINWZ4f3dTNCvQpGmaw1mVs7W9JlAWyx/6y5S
 BfpdME8lZgeqTFuTgWyUtwguyZ9/gQ/ROMHU2t6QOc06rlL6McIltcIPk8EC0YAdh5hK
 tss1HVMO1I6WS9USTbfpE3Z3eOybYgNBI5F3hKp8vOq9EKQJrd2F/5/cqIywWH9rNinT
 vFlAtCu1zFOFA4acg0WXJlDmNBBNnSB8q5owPRBXHZqerk68MfftdWpxUrULOn3dTFuE
 z0TA==
X-Gm-Message-State: AFuF++n1VAlVnLYfmVQaDHDcSGIR9NHCTPlvCqiTDeFMaT7ABVa8750B
 U67Yrx/gzQcb46xaz7xTRGXKAMg/e/BmAxTRanwJXFfMXzyMa4jhLnhaJiLgbdmsfFo4cqDPv7N
 UYnipAbiG5a0wFR44Nb+Sm3odx1cryN6bykyrmOE5+T7JO73zs4sodOSK8kgZ5AYQAC7HbZ1Ozm
 e8z5rogHoTj748omdjVoWJQDLC7Q6uvmjLRQ==
X-Gm-Gg: AYBFou1g2kA2BTHCpFwKTK+bbzn0VU31yxCNpiAWqVFXF35VIHO5qvimjY3RO19yyU9
 tIAZ1vDPRXcIyh4GT6G+P2HoNDDJFfSCAdWXi19H5Gwux0qnEi8VYQEB1mU5YJSU/9zBCS7P4Xt
 WxNI/eORYQ7ZuRhHi2ZTLecBQgxsEaz8yjLOPZ22yRgvH4RId+i2mlrp8CReg9wqmgJ/l4Arm4L
 7cdlqYdbGLQ9XXysuOcOqwONGlCmpN4hBhokCdhSsIdMKeAH4gqseTUeY3MNCcEk3ZiQp9/KrrL
 QRenWYpYq2z0Wg1q0RmrZYATQMFINVIbVu/eFlAp3iyMAXcGXUia9yNkwO07pF+gxfO1dm4gJUI
 ohZ0XTmTkecotuskAozC8zp4=
X-Received: by 2002:a05:600c:b99:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49e619b9d57mr70274255e9.13.1789117280827; 
 Fri, 11 Sep 2026 02:01:20 -0700 (PDT)
X-Received: by 2002:a05:600c:b99:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49e619b9d57mr70272475e9.13.1789117280084; 
 Fri, 11 Sep 2026 02:01:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm238995795e9.6.2026.09.11.02.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:19 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: [PULL v2 01/75] virtio: fix exit(1) on DMA mapping failure during
 migration restore
Message-ID: <5ec2a0b21fe5b8e1419a94a753636088d6b0409b.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When QEMU restores pending virtio requests from a migration stream, it
calls qemu_get_virtqueue_element(), which calls virtqueue_map() and
virtqueue_map_iovec() to re-map the saved DMA fragment addresses into
the destination address space.  If the addresses in the migration stream
are corrupted, and as a result dma_memory_map() returns NULL or a
shorter-than-expected length, virtqueue_map_iovec() calls exit(1),
terminating the destination QEMU process instead of failing the
migration cleanly.

Convert virtqueue_map_iovec() and virtqueue_map() from void to bool.
On failure, virtqueue_map_iovec() unmaps any entries it has already
mapped and returns false; virtqueue_map() similarly cleans up the in_sg
entries if out_sg mapping fails.  qemu_get_virtqueue_element() now
checks the return value, frees the element and returns NULL on failure,
allowing the migration restore path to propagate a clean error.  The
callers in virtio-blk, virtio-serial-bus and virtio-scsi that invoke
qemu_get_virtqueue_element() during load are updated to check for NULL
and return an error code.

Fixes: 3b3b062821 ("virtio: slim down allocation of VirtQueueElements")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3888
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h  |  2 +-
 hw/block/virtio-blk.c       |  4 +++
 hw/char/virtio-serial-bus.c |  4 +++
 hw/scsi/virtio-scsi.c       |  4 +++
 hw/virtio/virtio.c          | 49 +++++++++++++++++++++++++++----------
 5 files changed, 49 insertions(+), 14 deletions(-)

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
index 83a033ce85..81db0bdc91 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -764,6 +764,10 @@ static int fetch_active_ports_list(QEMUFile *f,
 
             port->elem =
                 qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
+            if (!port->elem) {
+                error_report("Failed to restore virtio-serial element");
+                return -EINVAL;
+            }
 
             /*
              *  Port was throttled on source machine.  Let's
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index bf64d1231a..132f833226 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -274,6 +274,10 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     assert(n < vs->conf.num_queues);
     req = qemu_get_virtqueue_element(vdev, f,
                                      sizeof(VirtIOSCSIReq) + vs->cdb_size);
+    if (!req) {
+        error_report("Failed to restore virtio-scsi request");
+        return NULL;
+    }
     virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
 
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index daa5607338..34f1df260b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1680,36 +1680,56 @@ static void virtqueue_undo_map_desc(AddressSpace *as,
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
+        unsigned int i;
+        for (i = 0; i < elem->in_num; i++) {
+            dma_memory_unmap(vdev->dma_as, elem->in_sg[i].iov_base,
+                             elem->in_sg[i].iov_len,
+                             DMA_DIRECTION_FROM_DEVICE, 0);
+        }
+        return false;
+    }
+    return true;
 }
 
 static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
@@ -2206,7 +2226,10 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
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



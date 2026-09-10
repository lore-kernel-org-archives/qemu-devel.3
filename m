Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C4BC88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oug-0001md-1s; Thu, 10 Sep 2026 20:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVp-0006Pr-Aw
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVf-0004hk-SL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cY4K5hEbqA2jAPtmBdYZErh868yrTmlvKXQA8mwMwzI=;
 b=h0yINGtAtaSk4OiKy7QXXbK6RXSkVEUtKuEsgmofVcKlBQ4TrPzABSc+eqPYgnAVhp3RbR
 zi1V1R0ndEKh7YXXsGxYUEqzw8h/ufbXhhTsh+mOGHu5KctgJLmT6X5O7PdaXVJZs0sqsk
 59RPGHemJuGAT4S/POvj+nEvukQofbE=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-zd5N0HjWNc6UdUOzGBhO0g-1; Thu, 10 Sep 2026 16:11:32 -0400
X-MC-Unique: zd5N0HjWNc6UdUOzGBhO0g-1
X-Mimecast-MFC-AGG-ID: zd5N0HjWNc6UdUOzGBhO0g_1789071091
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97e98448895so90019241.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071091; x=1789675891; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cY4K5hEbqA2jAPtmBdYZErh868yrTmlvKXQA8mwMwzI=;
 b=X4YDPJwRzYGmKhWFtXGp/3RY/Ob99MF00y9DDMIO/i1CtJH5D/rMAeMu87rkCShb97
 VJTtfdw2SQrQbgatuex64wiVK7DANaHs+lC4m7DKaZCo7lOHbK6gBON6Qb3FCWSh1M82
 z+31FDV11Z9qkEwhA5jpmiSUfpy9kQQMLyTnlsC0bHOfwSd9up8UkyNZhW98GRnWmVHC
 g2kXVsBEaCr4nn7ky9sx0NYie6hrsDViVzXOMbFnhAhfK0keLJn/4AHk6wmTZW2WeSQx
 D6saosKEpwGEw2xjmlqe0faSojFqhTLZxRabaEb4kBSkGC650LPn0rFQRtxDAZIVGGPl
 eCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071091; x=1789675891;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cY4K5hEbqA2jAPtmBdYZErh868yrTmlvKXQA8mwMwzI=;
 b=spkrRfiIBzZypPyLWu2eVedh7VuoVcwhn2FX1CN+0g9NLxKlHabc72PuSO/D989W0o
 AQGBlCYO4PuitnmHYL8rS96dn+RvF5eZEL4PreC8jDFT733/KryeoZUmFUXg/RCDnJa6
 FG58pC9uGCwuH4zwChzpbTsV/BsJ5M2jCopUrIMzLvtoGAbHSvzxoG2eAVLLc6FgBjNN
 QkdnPtgJKmcbie2oLX60xyx1NSfSG0oQXAe4VhGk+BTJTmUq623QyWMncADU7VZNB75/
 KYMF8MKjnT8d7ds7AVcChQJgzcW8Wz7RrPaZSXFeJ0OxcTVRRQU2P/Ur3qQrE26WzyJ7
 ls9w==
X-Gm-Message-State: AFuF++kUhXZt1B/BEKu52T1KmAg4Ht7dk+taWao7aXrP0bGvmprnvxWk
 ih9fKoCqWTP8S8k8xdsUIKNj+jF99sQrModANA7oKgiXE45dpwapmTmXyi0tSaKwf2XKFGXMZ2f
 l+PTfEBW9WxHRtHXFwW8++Yo28pDaepenA+XEJCkoNEVwvHjEk7s4Y17KPApo1Uqy8NCRb40lsl
 EYvNiuT4b6SimT61SeecwvWhm6AIM0R75S7Q==
X-Gm-Gg: AYBFou0Qs+PRKzbmxSj8t8LMy8xrkymDATQLGog/6j+h6Vjng0KRs3hdB/4vKYwWt/T
 1+/IyfhWysjx6ciL3Cbc5nxCxBSXlCvZs5eG+xp1AJz+hHUzuHoFRkJim37pEyzkZXETXp2guR7
 nND6kdSNXVFelM8lcDoTdXDqZyFS9iHbn17RJqrQwX+cXyc9g9LF8prl74QINK5e16iMHEZ82V1
 nYOWXnZyG6kp/bMuf2qKw5FXzn2/C9IROYicefL3diQ2w13CsOEKuM1DFoQtj5++HT3o/9D3THH
 1dRJJoLGdpNVXLuvD8053iHhJbMkXPg7rQ038Yv4jhY1cjdT6BGEl+D/F2Jqz0jm+oGMAY1sgIL
 0cKCQIss9w+A3fyDkcTEwL14=
X-Received: by 2002:a05:6102:61c5:10b0:78a:8a0:7126 with SMTP id
 ada2fe7eead31-792a93b099fmr1543301137.10.1789071090554; 
 Thu, 10 Sep 2026 13:11:30 -0700 (PDT)
X-Received: by 2002:a05:6102:61c5:10b0:78a:8a0:7126 with SMTP id
 ada2fe7eead31-792a93b099fmr1542650137.10.1789071085157; 
 Thu, 10 Sep 2026 13:11:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7927cbdf17fsm741239137.3.2026.09.10.13.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:24 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: [PULL 01/90] virtio: fix exit(1) on DMA mapping failure during
 migration restore
Message-ID: <5ec2a0b21fe5b8e1419a94a753636088d6b0409b.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



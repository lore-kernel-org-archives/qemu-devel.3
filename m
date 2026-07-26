Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C04C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Pu-0007hA-5m; Sun, 26 Jul 2026 17:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pm-0007XQ-I4
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pk-0004IG-2h
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NB0gTAhWaRC2ka3Avg3SIr2Cz0ho4WQrQW5kY0KQJPw=;
 b=GfrYAZt86+FCan2q9w7gp0HwETrGOttogVIeTz2dtWnrc4oD0NZA9RQ9nWcGC9k/cvAgLq
 MBKUUr/1yelnNmQM6Sym0xWgCYLPRaGrAiGxjwM4WGlmgk8G7BKLcvNojv9v3C2YK/2Ql5
 qYDmeabJzTwXl+TzQIvPat2AY+cuKwA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-08GAehuNPiu_kHkZ6i2J7g-1; Sun, 26 Jul 2026 17:29:38 -0400
X-MC-Unique: 08GAehuNPiu_kHkZ6i2J7g-1
X-Mimecast-MFC-AGG-ID: 08GAehuNPiu_kHkZ6i2J7g_1785101377
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955b84e25eso15077975e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101377; x=1785706177; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NB0gTAhWaRC2ka3Avg3SIr2Cz0ho4WQrQW5kY0KQJPw=;
 b=uOo8hEiRceBacWqzhMDKSnt0+W0b6nF/tMYXXjRELHIJFmlPz90ogT6wGXKW1jsx65
 Hf58pci1mLvFALd5gnJLeBzxnac33rDs2AQcqWmNXYwJmTnTjrLH6KVFxBduPBYyVsxi
 mWunmWHpwuFnGv6opa/uKbpdVaB0NmGmnG28wpzj5sJ+tLE08U/Bw/kJjYHieyVfvbpJ
 VQ0F9qP0x9YJNRS+5rI+hmZesswmEApKNjRaOG8Ql6pZysZAjc6sF+QFVSfEMnMbcDXd
 nczCFvfsG5aZZouXUv5iWZIniclwvlQoRMT04QFG7Q/TtfNSMUAPrvAp1OBgj4e8N6re
 dVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101377; x=1785706177;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NB0gTAhWaRC2ka3Avg3SIr2Cz0ho4WQrQW5kY0KQJPw=;
 b=U2ZQOlIVFYKkhid78VyQ011AOtGUkZqipMEpnmB7FrXidF1TrhtvGHScV5ljuYQnOs
 VeFoYSEIii3+XBaUonpkU0IvIBNh5KxzS2rLbV6C20VhlpvIfkeW9R0fupuIu/7JdHya
 MO6eh3VbSKA0HKc/UGVyd9GtgZjbhyGG+0VQsgW9l5385+EHaoA4noD9XAq5MnK5cM1Q
 LnRy9FojEdvCcnxz2sSdLe73sGpuelLOb0i7f1vvuoxpCh3ipSw451Raf7oEW4G1ainJ
 xekHcx0cBE5FV+REawXEkdk+pSQQsRimn7Q1/79DCMg6zi9UJb6JBreYdYiY1B1clPRm
 Vdqg==
X-Gm-Message-State: AOJu0YxWq4XNTgAqeF+vat0W2uY6alXbygpU5SwwccdAWxF3mCd/f6Z+
 N52Uq5yD2quoLiapR4A6tdGVNTGWryp9yEaA3yMXTu7LZ/cvesqLnYvt2FSaBOlEDEEpEt1lBu8
 FHImAFngBO395Do8M87wUobzUHCwPgQk0y1ZFYDtUd6Rvo/5rlaeWKM/D220r7AM66YY5fBqW1V
 Lbr18Zjh5+yL/Y1hc2ly25U1qXziiYpbFVxQ==
X-Gm-Gg: AR+sD12IUmkHltv35za+tRczOmO6OlIBVJ7kRteqxFZ+ktrKQHRkc1fOme+s+MtSwaS
 AcwPOLjE4O6LcW+iXomUz0QLk5VW7LDTIDzcehj+kNYQLt+XvKHKC9NPCHYnxjrtAqzdrBMiO4I
 J4R/SUwaOYIH4kZlmw8QrtjYgGGPW0SDgKWOS47JNOzdee0Ra/ewQsLxh/skU9V/iF26hnplgDz
 eZ1I4mWU7nExptiy9JGeYNMOnH5S1uIGsGQuwoY2DN+qWs8b4ZiyFrWHfppOrRAiLnANuTufn1/
 tsYYmty1/4Lz+eRXwO6ypjmETaTgQvRrZNsnVOeqrHNfBQD/Txw+5eJJAtn6mLSjXO+Xyf+i+Em
 MtSY2hVg7L2a2RuRbf0fikA==
X-Received: by 2002:a05:600c:4fc6:b0:495:5de0:d87 with SMTP id
 5b1f17b1804b1-496b5735085mr76553985e9.36.1785101376663; 
 Sun, 26 Jul 2026 14:29:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc6:b0:495:5de0:d87 with SMTP id
 5b1f17b1804b1-496b5735085mr76553825e9.36.1785101376118; 
 Sun, 26 Jul 2026 14:29:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4858e28sm185822955e9.2.2026.07.26.14.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:35 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Pankaj Gupta <pagupta@redhat.com>
Subject: [PULL 14/30] virtio-pmem: wait for flush requests on unrealize
Message-ID: <4125e8f3c5dc2833ddfcd993aec1ccd3df6147d7.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

virtio_pmem_flush submits fsync requests to the thread pool and stores a
VirtIOPMEM pointer in each request. If device is deleted e.g. by
hot-unplug, once these complete, done_cb can run after
virtio_pmem_unrealize frees the device, causing a use-after-free.

Track in-flight requests and wait in virtio_pmem_unrealize until
their completions finish before tearing the device down.

Fixes: CVE-2026-63323
Fixes: 5f503cd9f3 ("virtio-pmem: add virtio device")
Cc: David Hildenbrand <david@kernel.org>
Cc: Pankaj Gupta <pagupta@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3938
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <417b6685f37ce818c660ca3c84945992f5c30dcf.1784894206.git.mst@redhat.com>
---
 include/hw/virtio/virtio-pmem.h |  1 +
 hw/virtio/virtio-pmem.c         | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index 9cce600d0b..bb959d10cf 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -32,6 +32,7 @@ struct VirtIOPMEM {
     VirtQueue *rq_vq;
     uint64_t start;
     HostMemoryBackend *memdev;
+    unsigned int inflight;
 };
 
 struct VirtIOPMEMClass {
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index c3b3299c9c..6f7271c140 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -23,6 +23,7 @@
 #include "standard-headers/linux/virtio_pmem.h"
 #include "system/hostmem.h"
 #include "block/thread-pool.h"
+#include "qemu/aio-wait.h"
 #include "trace.h"
 
 typedef struct VirtIODeviceRequest {
@@ -54,14 +55,20 @@ static int worker_cb(void *opaque)
 static void done_cb(void *opaque, int ret)
 {
     VirtIODeviceRequest *req_data = opaque;
+    VirtIOPMEM *pmem = req_data->pmem;
     int len = iov_from_buf(req_data->elem.in_sg, req_data->elem.in_num, 0,
                               &req_data->resp, sizeof(struct virtio_pmem_resp));
 
     /* Callbacks are serialized, so no need to use atomic ops. */
-    virtqueue_push(req_data->pmem->rq_vq, &req_data->elem, len);
-    virtio_notify((VirtIODevice *)req_data->pmem, req_data->pmem->rq_vq);
+    virtqueue_push(pmem->rq_vq, &req_data->elem, len);
+    virtio_notify((VirtIODevice *)pmem, pmem->rq_vq);
     trace_virtio_pmem_response();
     g_free(req_data);
+
+    pmem->inflight--;
+    if (!pmem->inflight) {
+        aio_wait_kick();
+    }
 }
 
 static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
@@ -85,6 +92,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
     req_data->fd   = memory_region_get_fd(&backend->mr);
     req_data->pmem = pmem;
     req_data->vdev = vdev;
+    pmem->inflight++;
     thread_pool_submit_aio(worker_cb, req_data, done_cb, req_data);
 }
 
@@ -122,6 +130,7 @@ static void virtio_pmem_realize(DeviceState *dev, Error **errp)
     host_memory_backend_set_mapped(pmem->memdev, true);
     virtio_init(vdev, VIRTIO_ID_PMEM, sizeof(struct virtio_pmem_config));
     pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
+    pmem->inflight = 1;
 }
 
 static void virtio_pmem_unrealize(DeviceState *dev)
@@ -129,6 +138,10 @@ static void virtio_pmem_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOPMEM *pmem = VIRTIO_PMEM(dev);
 
+    /* Release the device's own reference and wait for in-flight flushes */
+    pmem->inflight--;
+    AIO_WAIT_WHILE(NULL, pmem->inflight > 0);
+
     host_memory_backend_set_mapped(pmem->memdev, false);
     virtio_delete_queue(pmem->rq_vq);
     virtio_cleanup(vdev);
-- 
MST



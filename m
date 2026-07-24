Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07A3C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEWZ-0005ee-Jt; Fri, 24 Jul 2026 07:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEWU-0005dI-2l
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEWR-0007PL-Ps
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784894218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=zzy3nfylajR+8r3jVylPnDgfp3PTi9gGWIf195xAtP0=;
 b=SheUyOzAOubg2oHkSAjqZnv+OJMoDacV06KZCewAKVtHzxGuajEzdS33FBltnAkCkVBaK/
 mxs9vLJfY6JmxY+7IT3cCMnR2k9bjRngrnHfoABf3PHzhU/knKKmMhuGwcSijBvsT27rUz
 hD1YkNDC0GAbS+XpaTym7Gr6+bDTArw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-hUknDqu9NEa8J38IsnqbPA-1; Fri, 24 Jul 2026 07:56:55 -0400
X-MC-Unique: hUknDqu9NEa8J38IsnqbPA-1
X-Mimecast-MFC-AGG-ID: hUknDqu9NEa8J38IsnqbPA_1784894214
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493fa6e28a7so4118115e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784894214; x=1785499014; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zzy3nfylajR+8r3jVylPnDgfp3PTi9gGWIf195xAtP0=;
 b=hK9sc61AV10jcFQRHCSJPs+zFbEtbzh6kzfkFAkWyO4G+aokykEpb6pP9V4L9YJjnh
 K20jk6WTTkip7iu67NKejJb8LyUYJ9xWaSu+TAY5SwD0tBcjfHanzWZ/43/cBYbXC9sa
 M00r1gO5T8R4oQt2FtJPLJNupquqsr/g23od1yxra6UMXrwegKDCGkCol8YLVlbs7UGx
 pWo1IHDX4Sk7ITcHT9mCW/zxZ6Vs1PIDqviTZsiSRcKAusROf0EVJB07MI5FEQ5WfPUJ
 90W5dL0glJO/FibLPl9wNxiY0+SOAc1bGlimpg0p9E5EUc4wQzwB5UtgVusCRp7Abva2
 2QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784894214; x=1785499014;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zzy3nfylajR+8r3jVylPnDgfp3PTi9gGWIf195xAtP0=;
 b=l75cKiFZ/WRbdXsaBnqHSnqJas13LVX35EHEUpfhxQyCseh+GOKRcWVTkTDHjsoxs5
 2LZ/aRYAJS2mrLSy61a+2AzxsgO/66PO0aq3AiHEtK0qQjBd4soMrB/4pNzqA8hG+ZMi
 pl9ljTxzvQeWBXm41nSude2gR2244fBTeyN4QBHnFim2iJF3go0zWLTmindTfmqxM0lw
 QT5R8Z5OS9dL1+xR73URkNy2MQlZ12uN/v5jI97VV1vY70R22sm6sYj+qIZo3h0yQfEQ
 UvmPTSg02jYyJas0sd+0a5vhoAPa7JP7Z4/7nuksDG3OQ9uaWgAYZEyhW68Gwj9YZqo3
 H7eQ==
X-Gm-Message-State: AOJu0YyULvrznfW53qKl+bmZ7lUp+xHdlTM5eg1KF4MOa4kCDHUPSTh6
 qUtdboUS7FWXDVtV8WVZhFx0pUxbYY+WzS0rz2OJnOdJAunIkkNhBG4Bia/QB0sMUhJwDnudqSS
 t8Bas5LK6J30jNUNt1RR/pMVmPYVouB6IXmjBQrV//3JdOCsBt6LLRV0gQjID17pTUyBniaEzPz
 qUizwIIJ4aTbok0SfVRfFkYkXTor673hJ9JQ==
X-Gm-Gg: AR+sD12HGamJK6AHTYNzY3EeU58t1i+PK1ogXbaBYZuBCQotgDWEey0zw7kd+VxbNTA
 C0CFAh8bheMRJpUuMPXIKDTfO6+Ush0wNRXlhNpBODqpRiQ3UMJ1PK+OmTThLnBgvkX2+SrQK5C
 hkPED7cXnSdkYsGJCkMKvd/7nA7l9qH18NO+NEN6Xue+03OUjmXSvjS9onQprocQVSME39jASPf
 tKQnb+DXg1/wQFy+KlUAPIaJ06hnzNyMSA/Fwn5NxwzoZN1ZFudbTBOvZB96v7Wp3Wbs7IZmuOU
 vLSzmhL4Jvf02rKQ0pGtIcHTXJf1EMzIREKAhev6Eivqx/Ha/0zXw1hfAXuGmQgLIorXOl4H6yZ
 VVebU0uM+sOCB5oLaXoCIGQ==
X-Received: by 2002:a05:600c:1f83:b0:495:7952:64df with SMTP id
 5b1f17b1804b1-49579526642mr49952095e9.36.1784894213649; 
 Fri, 24 Jul 2026 04:56:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1f83:b0:495:7952:64df with SMTP id
 5b1f17b1804b1-49579526642mr49951605e9.36.1784894213096; 
 Fri, 24 Jul 2026 04:56:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af5d4d7sm70814815e9.2.2026.07.24.04.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:56:52 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:56:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH] virtio-pmem: wait for flush requests on unrealize
Message-ID: <417b6685f37ce818c660ca3c84945992f5c30dcf.1784894206.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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



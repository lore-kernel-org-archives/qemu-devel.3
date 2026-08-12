Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02724C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8go-0003uR-7y; Wed, 12 Aug 2026 09:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8fi-0002hK-Qn; Wed, 12 Aug 2026 09:07:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8fg-00059s-QQ; Wed, 12 Aug 2026 09:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=2Y4h0q+JwK205uVvWyfY14CVinsvqb37iYjnNMdYWRc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ie/AMG0UHcVVd+MK8jYtyngkjr45qsyc2LnfzCWTsuMRcGZTXTmfRY6bXEbA9ZdrB
 FFui2FZWW3BkJSka5w2Gi08pyeZpHKywG40xIWdjMoAcJ7p6+IPIS69TGTQgBWajSt
 rARf5DIVQ0X7GEy1FLRRhHVBNAiB2eoDc+0UBml7WdswYzjUUS3n6knsRePYgtn8yE
 jm4e+z80pSJOU6g2vpty5wMJODUdNh0YP/LpGl/TfiHJq4uLJwesQeN6v/9CiOyIUV
 K6TdxBSOu9Vqg3b6gSE6JJ7AU+bnuVL9ra284nxG74pT8NaLpToPSToRiA1SyNwAw6
 j+Sxr1MlJHAvg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E0EEE1CA4AC;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 22EBA409B8F;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 407962F8EE; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Pankaj Gupta <pagupta@redhat.com>,
 Jia Jia <physicalmtea@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 045/102] virtio-pmem: wait for flush requests on
 unrealize
Date: Wed, 12 Aug 2026 16:01:20 +0300
Message-ID: <20260812130233.621965-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Michael S. Tsirkin" <mst@redhat.com>

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
Reported-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <417b6685f37ce818c660ca3c84945992f5c30dcf.1784894206.git.mst@redhat.com>
(cherry picked from commit 5cc182ba39a3ca8ec9ba0576de9696be76dc087d)
(Mjt: adjust aio-wait.h include across v10.2.0-154-g12e50722e444
 "block: rename block/aio-wait.h to qemu/aio-wait.h")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 16c7367ab05..392edd093cf 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -24,6 +24,7 @@
 #include "system/hostmem.h"
 #include "block/aio.h"
 #include "block/thread-pool.h"
+#include "block/aio-wait.h"
 #include "trace.h"
 
 typedef struct VirtIODeviceRequest {
@@ -55,14 +56,20 @@ static int worker_cb(void *opaque)
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
@@ -86,6 +93,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
     req_data->fd   = memory_region_get_fd(&backend->mr);
     req_data->pmem = pmem;
     req_data->vdev = vdev;
+    pmem->inflight++;
     thread_pool_submit_aio(worker_cb, req_data, done_cb, req_data);
 }
 
@@ -123,6 +131,7 @@ static void virtio_pmem_realize(DeviceState *dev, Error **errp)
     host_memory_backend_set_mapped(pmem->memdev, true);
     virtio_init(vdev, VIRTIO_ID_PMEM, sizeof(struct virtio_pmem_config));
     pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
+    pmem->inflight = 1;
 }
 
 static void virtio_pmem_unrealize(DeviceState *dev)
@@ -130,6 +139,10 @@ static void virtio_pmem_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOPMEM *pmem = VIRTIO_PMEM(dev);
 
+    /* Release the device's own reference and wait for in-flight flushes */
+    pmem->inflight--;
+    AIO_WAIT_WHILE(NULL, pmem->inflight > 0);
+
     host_memory_backend_set_mapped(pmem->memdev, false);
     virtio_delete_queue(pmem->rq_vq);
     virtio_cleanup(vdev);
diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index fc4fd1f7fe8..fc23f3d95d6 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -32,6 +32,7 @@ struct VirtIOPMEM {
     VirtQueue *rq_vq;
     uint64_t start;
     HostMemoryBackend *memdev;
+    unsigned int inflight;
 };
 
 struct VirtIOPMEMClass {
-- 
2.47.3



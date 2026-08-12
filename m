Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B1CC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8h7-0004o0-O8; Wed, 12 Aug 2026 09:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8gA-00033y-HU; Wed, 12 Aug 2026 09:07:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8g8-0005H5-Ly; Wed, 12 Aug 2026 09:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=KYDusfv8W5vMSJ/hWZiHcqEKSFiEHge1/FKyemTCdpY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f3Q/trCbf9eNLeXvluHhcRsKtp2jQLCLjLOnTWk/rWaHtsEI2mv5K5A9GAud0byL/
 cfBee6fElQTtL3cTW+YnMGoZ2ltN9s2v+PoX4z44J7n8RGlqUWOGAW/z5CYuSlw8AN
 DuhFqoeQqNg0cVCvSG5gayYHEhplvF6By7qFB0waWuwzvtOc6d5YboAx/uEe25CO5C
 oAgI7CrKu0Up2lGzbJ8rABnYATSIWiOHcFX0e6Q22bL2THRaySiFPpCZgR07t/MRqq
 BP1q8+VDS0s/DSLmf3+zKPtDV1S6fy5Ir8TgkZCkzmaOuSDU4Q4G1S/LgYo3ks3Q9G
 XLPTCujk0yVmw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F1BDC1CA4B0;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 33E35409B93;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4ACA42F8F6; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jia Jia <physicalmtea@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 049/102] virtio-iommu: fix OOM due to unbounded
 call_rcu
Date: Wed, 12 Aug 2026 16:01:24 +0300
Message-ID: <20260812130233.621965-49-mjt@tls.msk.ru>
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

Currently, within virtio-iommu, handle_command processes the command vq
without any limits on the number of entries processed.
This can easily and repeatedly enable/disable multiple memory regions.
Within the memory code, this causes an accumulation of an
unbounded number of RCU-deferred FlatViews - each of these
is supposed to be freed with call_rcu, but that never happens
because the main thread never returns to the main loop.

Given FlatView is big, it's easy to have this balloon out to multiple
Gigabytes of memory.

Limit the loop defer any remaining work to a timer.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3930
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <eb46ab360dbe28c29cfa78812a7440dcb7444d59.1784807826.git.mst@redhat.com>
(cherry picked from commit 67550d65b4bfdbcbfee2dae7ae1ebbbccd01dfe5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index b6e7e01ef74..86deff70385 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -994,6 +994,18 @@ static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
     return ret ? ret : virtio_iommu_probe(s, &req, buf);
 }
 
+static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq);
+
+static void virtio_iommu_handle_command_timer(void *opaque)
+{
+    VirtIOIOMMU *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    if (virtio_device_started(vdev, vdev->status) && !vdev->broken) {
+        virtio_iommu_handle_command(vdev, s->req_vq);
+    }
+}
+
 static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
@@ -1004,10 +1016,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
     struct iovec *iov;
     void *buf = NULL;
     size_t sz;
+    unsigned int batch = 0;
 
     for (;;) {
         size_t output_size = sizeof(tail);
 
+        if (++batch > virtio_queue_get_num(vdev, virtio_get_queue_index(vq))) {
+            timer_mod(s->cmd_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
+            break;
+        }
+
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             return;
@@ -1417,6 +1436,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
                              virtio_iommu_handle_command);
     s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
+    s->cmd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
+                                virtio_iommu_handle_command_timer, s);
 
     /*
      * config.bypass is needed to get initial address space early, such as
@@ -1499,6 +1520,7 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
 
     qemu_rec_mutex_destroy(&s->mutex);
 
+    timer_free(s->cmd_timer);
     virtio_delete_queue(s->req_vq);
     virtio_delete_queue(s->event_vq);
     virtio_cleanup(vdev);
@@ -1510,6 +1532,8 @@ static void virtio_iommu_device_reset_exit(Object *obj, ResetType type)
 
     trace_virtio_iommu_device_reset_exit();
 
+    timer_del(s->cmd_timer);
+
     if (s->domains) {
         g_tree_destroy(s->domains);
     }
@@ -1628,6 +1652,11 @@ static int iommu_post_load(void *opaque, int version_id)
      * still correct.
      */
     virtio_iommu_switch_address_space_all(s);
+
+    if (virtio_device_started(VIRTIO_DEVICE(s), VIRTIO_DEVICE(s)->status)) {
+        timer_mod(s->cmd_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
+    }
     return 0;
 }
 
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 3b86050f2cf..1f265540ada 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -65,6 +65,7 @@ struct VirtIOIOMMU {
     GTree *domains;
     QemuRecMutex mutex;
     GTree *endpoints;
+    QEMUTimer *cmd_timer;
     bool boot_bypass;
     Notifier machine_done;
     bool granule_frozen;
-- 
2.47.3



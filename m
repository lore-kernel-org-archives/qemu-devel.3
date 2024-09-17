Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F67BCAC593
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 18:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqckA-0007mQ-NN; Tue, 17 Sep 2024 14:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqchr-0005Vu-GJ; Tue, 17 Sep 2024 14:13:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sqcho-0002yI-Pk; Tue, 17 Sep 2024 14:13:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 647EF8FC07;
 Tue, 17 Sep 2024 21:12:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DF9A613E767;
 Tue, 17 Sep 2024 21:13:14 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 79/82] hw/audio/virtio-sound: fix heap buffer overflow
Date: Tue, 17 Sep 2024 21:12:53 +0300
Message-Id: <20240917181256.634732-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.3-20240917211142@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240917211142@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Volker Rümelin <vr_qemu@t-online.de>

Currently, the guest may write to the device configuration space,
whereas the virtio sound device specification in chapter 5.14.4
clearly states that the fields in the device configuration space
are driver-read-only.

Remove the set_config function from the virtio_snd class.

This also prevents a heap buffer overflow. See QEMU issue #2296.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2296
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20240901130112.8242-1-vr_qemu@t-online.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 7fc6611cad3e9627b23ce83e550b668abba6c886)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index b1870ff224..b8ef572767 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -41,7 +41,6 @@ asc_update_irq(int irq, int a, int b) "set IRQ to %d (A: 0x%x B: 0x%x)"
 
 #virtio-snd.c
 virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint32_t chmaps) "snd %p: get_config jacks=%"PRIu32" streams=%"PRIu32" chmaps=%"PRIu32""
-virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps) "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams from %"PRIu32"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
 virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_features 0x%"PRIx64
 virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 95f55a02f1..3f9b336ad4 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -107,29 +107,6 @@ virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
 
 }
 
-static void
-virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
-{
-    VirtIOSound *s = VIRTIO_SND(vdev);
-    const virtio_snd_config *sndconfig =
-        (const virtio_snd_config *)config;
-
-
-   trace_virtio_snd_set_config(vdev,
-                               s->snd_conf.jacks,
-                               sndconfig->jacks,
-                               s->snd_conf.streams,
-                               sndconfig->streams,
-                               s->snd_conf.chmaps,
-                               sndconfig->chmaps);
-
-    memcpy(&s->snd_conf, sndconfig, sizeof(virtio_snd_config));
-    le32_to_cpus(&s->snd_conf.jacks);
-    le32_to_cpus(&s->snd_conf.streams);
-    le32_to_cpus(&s->snd_conf.chmaps);
-
-}
-
 static void
 virtio_snd_pcm_buffer_free(VirtIOSoundPCMBuffer *buffer)
 {
@@ -1400,7 +1377,6 @@ static void virtio_snd_class_init(ObjectClass *klass, void *data)
     vdc->realize = virtio_snd_realize;
     vdc->unrealize = virtio_snd_unrealize;
     vdc->get_config = virtio_snd_get_config;
-    vdc->set_config = virtio_snd_set_config;
     vdc->get_features = get_features;
     vdc->reset = virtio_snd_reset;
     vdc->legacy_features = 0;
-- 
2.39.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AD2CA101E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 13:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skkCp-0001NT-7d; Sun, 01 Sep 2024 09:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1skkCm-0001Mx-TF
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 09:01:20 -0400
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1skkCk-00005Y-Pw
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 09:01:20 -0400
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
 by mailout12.t-online.de (Postfix) with SMTP id 32F6D16EC1;
 Sun,  1 Sep 2024 15:01:14 +0200 (CEST)
Received: from linpower.localnet ([93.236.144.183]) by fwd84.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1skkCe-09xstV0; Sun, 1 Sep 2024 15:01:13 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id A65B42002C8; Sun,  1 Sep 2024 15:01:12 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/audio/virtio-sound: fix heap buffer overflow
Date: Sun,  1 Sep 2024 15:01:12 +0200
Message-Id: <20240901130112.8242-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1725195673-577FD85B-AD4CCC9B/0/0 CLEAN NORMAL
X-TOI-MSGID: 7681018d-402a-4602-a428-357717625670
Received-SPF: pass client-ip=194.25.134.22;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout12.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, the guest may write to the device configuration space,
whereas the virtio sound device specification in chapter 5.14.4
clearly states that the fields in the device configuration space
are driver-read-only.

Remove the set_config function from the virtio_snd class.

This also prevents a heap buffer overflow. See QEMU issue #2296.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2296
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/trace-events |  1 -
 hw/audio/virtio-snd.c | 24 ------------------------
 2 files changed, 25 deletions(-)

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
index d1cf5eb445..69838181dd 100644
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
2.35.3



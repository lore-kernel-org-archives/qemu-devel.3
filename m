Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC3BC4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbccl-00039c-Os; Sun, 18 Feb 2024 03:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbcci-00037R-5C
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:08 -0500
Received: from mailout11.t-online.de ([194.25.134.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbcce-0006KD-Nj
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:06 -0500
Received: from fwd81.aul.t-online.de (fwd81.aul.t-online.de [10.223.144.107])
 by mailout11.t-online.de (Postfix) with SMTP id 6ADBA1954B;
 Sun, 18 Feb 2024 09:34:02 +0100 (CET)
Received: from linpower.localnet ([79.208.24.6]) by fwd81.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbccZ-3uU6uf0; Sun, 18 Feb 2024 09:33:59 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 69E91200379; Sun, 18 Feb 2024 09:33:51 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 04/11] hw/audio/virtio-sound: allocate an array of streams
Date: Sun, 18 Feb 2024 09:33:44 +0100
Message-Id: <20240218083351.8524-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708245239-E67FB990-C1C31269/0/0 CLEAN NORMAL
X-TOI-MSGID: 50674317-2292-4e79-b6af-13f96e3c069b
Received-SPF: pass client-ip=194.25.134.85;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout11.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It is much easier to migrate an array of structs than individual
structs that are accessed via a pointer to a pointer to an array
of pointers to struct.

For this reason, allocate an array of streams in
virtio_snd_realize() and initialise all stream variables that
are constant at runtime immediately after allocation.

This makes it easier to remove the virtio_snd_set_pcm_params()
and virtio_snd_pcm_prepare() calls in the realisation phase and
to migrate the audio streams of the virtio sound device after
the next few patches.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 37 ++++++++++++++++++++++-------------
 include/hw/audio/virtio-snd.h |  1 +
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 7ed5f3de3e..e5497b6bf6 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -448,12 +448,9 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        stream = g_new0(VirtIOSoundPCMStream, 1);
+        stream = &s->streams[stream_id];
         stream->active = false;
-        stream->id = stream_id;
         stream->pcm = s->pcm;
-        stream->s = s;
-        QSIMPLEQ_INIT(&stream->queue);
 
         /*
          * stream_id >= s->snd_conf.streams was checked before so this is
@@ -463,14 +460,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     }
 
     virtio_snd_get_qemu_audsettings(&as, params);
-    stream->info.direction = stream_id < s->snd_conf.streams / 2 +
-        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
-    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
-    stream->info.features = 0;
-    stream->info.channels_min = 1;
-    stream->info.channels_max = as.nchannels;
-    stream->info.formats = supported_formats;
-    stream->info.rates = supported_rates;
     stream->params = *params;
 
     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
@@ -1040,6 +1029,25 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
+    vsnd->streams = g_new0(VirtIOSoundPCMStream, vsnd->snd_conf.streams);
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
+
+        stream->id = i;
+        stream->s = vsnd;
+        QSIMPLEQ_INIT(&stream->queue);
+        stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
+        stream->info.features = 0;
+        stream->info.formats = supported_formats;
+        stream->info.rates = supported_rates;
+        stream->info.direction =
+            i < vsnd->snd_conf.streams / 2 + (vsnd->snd_conf.streams & 1)
+            ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
+        stream->info.channels_min = 1;
+        stream->info.channels_max = 2;
+    }
+
     vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
     vsnd->pcm->snd = vsnd;
     vsnd->pcm->streams =
@@ -1280,14 +1288,13 @@ static void virtio_snd_unrealize(DeviceState *dev)
     qemu_del_vm_change_state_handler(vsnd->vmstate);
     trace_virtio_snd_unrealize(vsnd);
 
-    if (vsnd->pcm) {
+    if (vsnd->streams) {
         if (vsnd->pcm->streams) {
             for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
                 stream = vsnd->pcm->streams[i];
                 if (stream) {
                     virtio_snd_process_cmdq(stream->s);
                     virtio_snd_pcm_close(stream);
-                    g_free(stream);
                 }
             }
             g_free(vsnd->pcm->streams);
@@ -1295,6 +1302,8 @@ static void virtio_snd_unrealize(DeviceState *dev)
         g_free(vsnd->pcm->pcm_params);
         g_free(vsnd->pcm);
         vsnd->pcm = NULL;
+        g_free(vsnd->streams);
+        vsnd->streams = NULL;
     }
     AUD_remove_card(&vsnd->card);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index a2868067fb..95aef8192a 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -215,6 +215,7 @@ struct VirtIOSound {
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCM *pcm;
+    VirtIOSoundPCMStream *streams;
     QEMUSoundCard card;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-- 
2.35.3



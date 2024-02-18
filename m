Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5F8C5475B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbccr-0003FR-4R; Sun, 18 Feb 2024 03:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbccp-0003BN-TN
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:15 -0500
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbcco-0006MJ-9x
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:15 -0500
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
 by mailout12.t-online.de (Postfix) with SMTP id B15FB21C4;
 Sun, 18 Feb 2024 09:34:12 +0100 (CET)
Received: from linpower.localnet ([79.208.24.6]) by fwd86.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbcci-3Cb9yT0; Sun, 18 Feb 2024 09:34:08 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 761B6200383; Sun, 18 Feb 2024 09:33:51 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 08/11] hw/audio/virtio-sound: introduce
 virtio_snd_pcm_open()
Date: Sun, 18 Feb 2024 09:33:48 +0100
Message-Id: <20240218083351.8524-8-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708245248-2EFFAC95-3A1A2D99/0/0 CLEAN NORMAL
X-TOI-MSGID: fbabedb2-233e-4636-8f5b-6488cc5086d0
Received-SPF: pass client-ip=194.25.134.22;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout12.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Split out the function virtio_snd_pcm_open() from
virtio_snd_pcm_prepare(). A later patch also needs
the new function. There is no functional change.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c | 57 +++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index bbbdd01aa9..a1d14caba0 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -441,6 +441,36 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
     as->endianness = target_words_bigendian() ? 1 : 0;
 }
 
+/*
+ * Open a stream.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
+{
+    virtio_snd_get_qemu_audsettings(&stream->as, &stream->params);
+    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
+    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
+
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        stream->voice.out = AUD_open_out(&stream->s->card,
+                                         stream->voice.out,
+                                         "virtio-sound.out",
+                                         stream,
+                                         virtio_snd_pcm_out_cb,
+                                         &stream->as);
+        AUD_set_volume_out(stream->voice.out, 0, 255, 255);
+    } else {
+        stream->voice.in = AUD_open_in(&stream->s->card,
+                                       stream->voice.in,
+                                       "virtio-sound.in",
+                                       stream,
+                                       virtio_snd_pcm_in_cb,
+                                       &stream->as);
+        AUD_set_volume_in(stream->voice.in, 0, 255, 255);
+    }
+}
+
 /*
  * Close a stream and free all its resources.
  *
@@ -466,8 +496,6 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
  */
 static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 {
-    audsettings as;
-    virtio_snd_pcm_set_params *params;
     VirtIOSoundPCMStream *stream;
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
@@ -484,30 +512,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    params = virtio_snd_pcm_get_params(s, stream_id);
-
-    virtio_snd_get_qemu_audsettings(&as, params);
-    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
-    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
-    stream->as = as;
-
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        stream->voice.out = AUD_open_out(&s->card,
-                                         stream->voice.out,
-                                         "virtio-sound.out",
-                                         stream,
-                                         virtio_snd_pcm_out_cb,
-                                         &as);
-        AUD_set_volume_out(stream->voice.out, 0, 255, 255);
-    } else {
-        stream->voice.in = AUD_open_in(&s->card,
-                                        stream->voice.in,
-                                        "virtio-sound.in",
-                                        stream,
-                                        virtio_snd_pcm_in_cb,
-                                        &as);
-        AUD_set_volume_in(stream->voice.in, 0, 255, 255);
-    }
+    virtio_snd_pcm_open(stream);
 
     stream->state = VSND_PCMSTREAM_STATE_PREPARED;
 
-- 
2.35.3



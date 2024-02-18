Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B02C48BF8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbccv-0003Lf-F9; Sun, 18 Feb 2024 03:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbccu-0003Ka-03
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:20 -0500
Received: from mailout01.t-online.de ([194.25.134.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbccs-0006Ml-HZ
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:19 -0500
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
 by mailout01.t-online.de (Postfix) with SMTP id 0576E3D59C;
 Sun, 18 Feb 2024 09:34:17 +0100 (CET)
Received: from linpower.localnet ([79.208.24.6]) by fwd85.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbccl-0FpxeD0; Sun, 18 Feb 2024 09:34:11 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 79174200384; Sun, 18 Feb 2024 09:33:51 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 09/11] hw/audio/virtio-sound: introduce
 virtio_snd_set_active()
Date: Sun, 18 Feb 2024 09:33:49 +0100
Message-Id: <20240218083351.8524-9-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708245251-87FFD383-EAA26E85/0/0 CLEAN NORMAL
X-TOI-MSGID: 080ee047-0b6c-46d4-a509-a50de5c39b1a
Received-SPF: pass client-ip=194.25.134.80;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout01.t-online.de
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

Split out the function virtio_snd_pcm_set_active() from
virtio_snd_pcm_start_stop(). A later patch also needs this
new funcion. There is no functional change.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index a1d14caba0..06a27ef8d9 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -471,6 +471,21 @@ static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
     }
 }
 
+/*
+ * Activate/deactivate a stream.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ * @active: whether to activate or deactivate the stream
+ */
+static void virtio_snd_pcm_set_active(VirtIOSoundPCMStream *stream, bool active)
+{
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        AUD_set_active_out(stream->voice.out, active);
+    } else {
+        AUD_set_active_in(stream->voice.in, active);
+    }
+}
+
 /*
  * Close a stream and free all its resources.
  *
@@ -606,11 +621,7 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         stream->state = VSND_PCMSTREAM_STATE_STOPPED;
     }
 
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        AUD_set_active_out(stream->voice.out, start);
-    } else {
-        AUD_set_active_in(stream->voice.in, start);
-    }
+    virtio_snd_pcm_set_active(stream, start);
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
-- 
2.35.3



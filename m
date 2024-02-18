Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1A3C54764
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbccl-0003A0-SU; Sun, 18 Feb 2024 03:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbccj-00037h-JX
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:09 -0500
Received: from mailout08.t-online.de ([194.25.134.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbcch-0006KW-SA
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:09 -0500
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
 by mailout08.t-online.de (Postfix) with SMTP id B7955242E2;
 Sun, 18 Feb 2024 09:34:04 +0100 (CET)
Received: from linpower.localnet ([79.208.24.6]) by fwd82.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbccd-4eGTjd0; Sun, 18 Feb 2024 09:34:04 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 6FC1120037B; Sun, 18 Feb 2024 09:33:51 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 06/11] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
Date: Sun, 18 Feb 2024 09:33:46 +0100
Message-Id: <20240218083351.8524-6-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708245244-05180954-48BBF9A1/0/0 CLEAN NORMAL
X-TOI-MSGID: 759785b7-35d8-4f93-9661-6168a6079d41
Received-SPF: pass client-ip=194.25.134.20;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout08.t-online.de
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

Split out virtio_snd_pcm_start_stop(). This is a preparation
for the next patch so that it doesn't become too big.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/trace-events |  3 ++-
 hw/audio/virtio-snd.c | 57 ++++++++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index b1870ff224..7554bfcc60 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -50,7 +50,8 @@ virtio_snd_unrealize(void *snd) "snd %p: unrealize"
 virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PARAMS called for stream %"PRIu32
 virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
 virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO called for stream %"PRIu32
-virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s called for stream %"PRIu32
+virtio_snd_handle_pcm_start(uint32_t stream) "VIRTIO_SND_R_PCM_START called for stream %"PRIu32
+virtio_snd_handle_pcm_stop(uint32_t stream) "VIRTIO_SND_R_PCM_STOP called for stream %"PRIu32
 virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called for stream %"PRIu32
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 2b630ada82..435ce26430 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -533,7 +533,42 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
 }
 
 /*
- * Handles VIRTIO_SND_R_PCM_START.
+ * Starts/Stops a VirtIOSound card stream.
+ * Returns the response status code. (VIRTIO_SND_S_*).
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ * @start: whether to start or stop the stream
+ */
+static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
+                                          uint32_t stream_id,
+                                          bool start)
+{
+    VirtIOSoundPCMStream *stream;
+
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    if (start) {
+        trace_virtio_snd_handle_pcm_start(stream_id);
+    } else {
+        trace_virtio_snd_handle_pcm_stop(stream_id);
+    }
+
+    stream->active = start;
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        AUD_set_active_out(stream->voice.out, start);
+    } else {
+        AUD_set_active_in(stream->voice.in, start);
+    }
+
+    return cpu_to_le32(VIRTIO_SND_S_OK);
+}
+
+/*
+ * Handles VIRTIO_SND_R_PCM_START and VIRTIO_SND_R_PCM_STOP.
  *
  * @s: VirtIOSound device
  * @cmd: The request command queue element from VirtIOSound cmdq field
@@ -543,7 +578,6 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              virtio_snd_ctrl_command *cmd,
                                              bool start)
 {
-    VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_hdr req;
     uint32_t stream_id;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
@@ -561,24 +595,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     }
 
     stream_id = le32_to_cpu(req.stream_id);
-    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
-    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
-            "VIRTIO_SND_R_PCM_STOP", stream_id);
-
-    stream = virtio_snd_pcm_get_stream(s, stream_id);
-    if (stream) {
-        stream->active = start;
-        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            AUD_set_active_out(stream->voice.out, start);
-        } else {
-            AUD_set_active_in(stream->voice.in, start);
-        }
-    } else {
-        error_report("Invalid stream id: %"PRIu32, stream_id);
-        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
-        return;
-    }
-    stream->active = start;
+    cmd->resp.code = virtio_snd_pcm_start_stop(s, stream_id, start);
 }
 
 /*
-- 
2.35.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FC6C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqnmQ-0001db-RD; Mon, 03 Aug 2026 04:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmO-0001cW-Di
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmM-0003fY-Om
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so9355765e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785744728; x=1786349528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aghHjZ96emr+tjbq8TJHZIm2vM8aHDkko7Nbnok0WfY=;
 b=b3jMz873miILrqkNzzykqsnyLI8MQAHWPfA5uraBfRP/2nTd5vTPe7AdSsrQ/VzUy9
 VGRtGOo6LT4InYvWrA4hFPjKGwJxyPt9YOe5jiyGEGWdtKe4EynOglCAQPJoYQgSyepp
 WhKEkns84RtNZH8iRm+cnTpLca+YRCUH7lpq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785744728; x=1786349528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aghHjZ96emr+tjbq8TJHZIm2vM8aHDkko7Nbnok0WfY=;
 b=aFznC3HN53gFKHlKOl9e6a4QZPxjY4M64WLkQglJfdNYHeOhcpelmIv1rAEaKrz6cq
 qONd0661lKiyy291KD51ItqYurYPDNqho3sUsmZEqyx8cyF0HPrCCh8xvMzdBYNgMLo1
 pWNGWAapuwZtx4tM5xsxeSuPw/MnEi04k0HU9VjtOzIS59KQPLNBdX5v+tNv7pIflW8T
 P2L+kmF3DcYnDl89YMQnTHXowUUNAtcHHs2948R+jPI9qg3d2kKe6UJ0iXtLOQ9Csb6g
 OkznAZNbWNaEjKGYEPGLqL3BBO2Bhaeae5L5YFHfUKTsxorLKTVEUIRJjQRhA12z4wO0
 CphA==
X-Gm-Message-State: AOJu0YzlIyzRrzIt28o61WWnPr6UWuSvIjvW195Le37DlDDmqOTDTPgN
 K7BjiXgwtmCYlGBNCxlRMhTqfoxkAO6CFCd/gi3ylZaf4GSK2GXGdf6c32KwbztrK2YwrQ6aNep
 vTluM
X-Gm-Gg: AR+sD11+TjXuH0cl2uEcDAZdrNg1tRzosYoSdmwNZRPBcuq6rQsp9I9zcxViqr1SWUZ
 I4HDXonTcFIdObjx7uEk6NCfiwdme97KsP9Fd7ADXfRrX9p9oq7GLNRYbHTHxe9lAmqUvwvhMVX
 5Kt5t6FfmT+J9gKuF2JhWjv+C1JyfJdYFUxMGJ4h/ODRx6wAP5/70GJoMwPw+RXYPZZxkxpTdK8
 2wh4noHSGTob/SH6DeqvmqAnnMv6eMHjODY9fob16GU6Ns5BoHoJO2Zee3f63y/K1u/EYTvbIFZ
 eSHsBT3qcaSf/dmOAxDRXWxjhLdJ0b6rjXYoIE/3KZj/DrMjVnKvv2NWBNijF7bJKn6qYy8411p
 4E6wEaIrXZl1m/19IZduATobIAJ22lbbB6PKvDbSH3OwzmA27pYbqqe85u2JmBjbHYfRub8jvcg
 XI/m58CXT4XbYBEWIOZ9qR9L9wqHUrfWEquOzMAFuH2wj/j8D+uaqeq4IduIO1iAQ1nLHrl3q+H
 G/nJz5E3NL69cq9hy6Mch099MqsSH9YLo2QlLJec0j1oPxf0a4ZwS6H+zuk
X-Received: by 2002:a05:600c:4e86:b0:493:e460:1f6 with SMTP id
 5b1f17b1804b1-4980c5ec7a1mr168089745e9.0.1785744728114; 
 Mon, 03 Aug 2026 01:12:08 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b98284sm209358435e9.12.2026.08.03.01.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:12:07 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 06/10] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
Date: Mon,  3 Aug 2026 10:11:55 +0200
Message-ID: <20260803081159.91981-7-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803081159.91981-1-alexander@mihalicyn.com>
References: <20260803081159.91981-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Volker Rümelin <vr_qemu@t-online.de>

Split out virtio_snd_pcm_start_stop(). This is a preparation
for the next patch so that it doesn't become too big.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
     and then reimplemented the patch idea
/AM]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
v4:
	- minor formatting change in qemu_log_mask()
	- moved the trace_*() calls at the start of the function
	  (as suggested by Manos Pitsidianakis)
v3:
	- resurrected error_report(..) as suggested by Marc-André Lureau
---
 hw/audio/virtio-snd.c | 58 ++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index f9822fc609a..46026b8cffc 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -520,7 +520,43 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
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
+    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
+                                                   "VIRTIO_SND_R_PCM_STOP",
+                                           stream_id);
+
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid stream id: %"PRIu32 "\n",
+                      __func__, stream_id);
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    stream->active = start;
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        audio_be_set_active_out(s->audio_be, stream->voice.out, start);
+    } else {
+        audio_be_set_active_in(s->audio_be, stream->voice.in, start);
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
@@ -530,7 +566,6 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              virtio_snd_ctrl_command *cmd,
                                              bool start)
 {
-    VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_hdr req;
     uint32_t stream_id;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
@@ -548,24 +583,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
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
-            audio_be_set_active_out(s->audio_be, stream->voice.out, start);
-        } else {
-            audio_be_set_active_in(s->audio_be, stream->voice.in, start);
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
2.47.3



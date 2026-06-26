Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2549CDE00E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5mt-0004ZK-TZ; Fri, 26 Jun 2026 08:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mZ-0004U0-G5
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mV-0002xi-7h
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49249707788so7941045e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477337; x=1783082137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iZSMtc0RgKNXn8BitINnU0mBhe2/PdpCTuCtrafEh0=;
 b=hGCCgk27PVNscs1ZFTB1B3zU9dq3GRqcUiR2237eEUQZwSBD6UmcgNRbBxVf1Ezk2c
 gaQhJF3kh2b8T3mzfjY+5ctA+dQufFUBaT4lV3NBMmngJxlB47E+wvuMdlFA4hcXqE7N
 wibqRXLRsLuTLapDInjnqXBG0zYx58fYr2LQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477337; x=1783082137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8iZSMtc0RgKNXn8BitINnU0mBhe2/PdpCTuCtrafEh0=;
 b=DOR+F1soY+99GANKdXLHIDf8DDg+RxKUTC7nlECQBCP5v69ipEptg2df0EVOyDO394
 SEOTyDTYUwFUkbISbRBFwrFWcY/KiSBZ7CLVIjot50+La5BOuFGp/SHkufyLg8yMoQiY
 ERx5CbhV3vGmQJKvy3F7vFEILpiBbKveQPDh3bWPhEU8N2WaUt3F6TMY3rHrzPk7z2cn
 9qiRvj2vwmNWn2rJapSq7VM1txLJrwFjI+jL32EVqIBQx5NqCKlZD+3O7NCb3KMQoEvG
 w1fsQ9iwhgXfd+ogPFHtTFW5VTRIMC+WJ/rb4SgXXERi2BoCtP+vvU6wwsVbR4jeLFg+
 eMyQ==
X-Gm-Message-State: AOJu0YxVKz8EzeavoyFyeXlb7qEkriRZVh4CHYJK0BvDlZIMdCcmHg7D
 O3RNNymyHrmArE/CiET76U1EVl/exvRTZpP1McbMn4jhJgC0fi0CXx5AwH0BxvSa7soEaGhj08V
 SGoZoOsU=
X-Gm-Gg: AfdE7ckE2PQlcW64kTnmRSWIs5BOmBIhyata6Ujzx4H1kYRDDGV4kN7t+BrTgPX+w0f
 GMHfw1hSKQXdGofGZ7Z/6Rm9GSV67mhLPKR8eeoLmj0FHu5mB/UoVUD/ZcG+ct6jvPjite5xp0q
 XkKwIM6feWF97IyR0bYW/PfCmNewOyyQ5M6BoUX7mhyXz6ii6CPJzYPYYq8r2FL8QlNjwGpuRlS
 CfrUi/sxUkMg+XLTelffe5h5QXSSKemcnpd7l6cM0hf35EHwjw0QT+kZ//aDLwwo6pK7Ir1NFzC
 A6tdv0YzNNDeJ/LiUifIMKaGXW5bHTjgab5b+UWdrugUmg9hY0uWG/yq58fR+NlmAiZTVnmI/4Z
 yQdLN7iBbvTayr2VNsDBuPoZVG3VLXdeoF2j8qYqFqNg9hQoKwpVCwMuhvbAj/1TsgVrS0ai1XJ
 RHHGwow/CPEGhJW6+rUsE5O105G1tpfWfBuKHlkhZE1hI2a42myUHdoS90pRkDk+XnaFxZYg0jQ
 GEkmokurngc+XSvNB86FUo=
X-Received: by 2002:a05:600c:8211:b0:490:b189:212d with SMTP id
 5b1f17b1804b1-4926fc9cc36mr8558515e9.33.1782477336825; 
 Fri, 26 Jun 2026 05:35:36 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200aa896c1ac04cb1b2.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:aa89:6c1a:c04c:b1b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7373757f8f.14.2026.06.26.05.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 05:35:36 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 4/9] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
Date: Fri, 26 Jun 2026 14:35:26 +0200
Message-ID: <20260626123531.132078-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626123531.132078-1-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x336.google.com
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
v3:
	- resurrected error_report(..) as suggested by Marc-André Lureau
---
 hw/audio/trace-events |  3 ++-
 hw/audio/virtio-snd.c | 59 ++++++++++++++++++++++++++++---------------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 30f59215453..75d1fb37bd9 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -53,7 +53,8 @@ virtio_snd_unrealize(void *snd) "snd %p: unrealize"
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
index 8f4421ba844..300ba13ffeb 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -521,7 +521,44 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
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
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "%s: Invalid stream id: %"PRIu32 "\n", __func__, stream_id);
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
@@ -531,7 +568,6 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              virtio_snd_ctrl_command *cmd,
                                              bool start)
 {
-    VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_hdr req;
     uint32_t stream_id;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
@@ -549,24 +585,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
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



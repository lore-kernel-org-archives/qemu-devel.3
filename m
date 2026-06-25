Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649B2CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcglk-0005nH-9H; Thu, 25 Jun 2026 05:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglY-0005lu-S4
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglX-0003k0-5t
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:00 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49249707788so10634795e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782381178; x=1782985978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXkTltMaq7lALkG1TXv2ug72HZtl+VlrvnvFl8WY/bE=;
 b=UcAJK77U5zF2QBeZjKEEkSH+CMYCVytkqLoh+twaCTi4MGeaO2dibZ+7eBpNu1Jb/0
 xDgR0gOaYNtFr0SDcIdqkQgRhFHV85V/GW5YhryJ6KO3dn+rnbmm9UxOCdtrO1QiXtDj
 +P5USd22MgvU+7lF6CGwyF4VI58ZjKXyUXvAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782381178; x=1782985978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gXkTltMaq7lALkG1TXv2ug72HZtl+VlrvnvFl8WY/bE=;
 b=OR9s9wj3uRvV8L7Xpz65JUu1JyrHZ4+Obcgf6BsZDT7BV7W2uMjL1DsJGtO73bSaMn
 OJ+O5134q4NAPGjvrKTL7pkBTP0pAzsGz9+w8GBduGZafUV6XGHUHeaiKhnAPBfMNQtm
 qSP1SvxLq/xOcMHop7/XUiDpI2XivFTIFJpDKLqqSjHl2n3kYQX+aXbqpy6JUPVS/VgS
 NaibtaklrOXgn1pkzqoAD+QeMS9z3wZE4/EG539BLku86pJB1ftJpfDARRTtkn3MyjwQ
 QK39yGEtHqbASiY5vf89iUCg3PN00sWj+80zWdEnts6QzUPW/Ld+U0qfy76BGli6KHnb
 UzZQ==
X-Gm-Message-State: AOJu0YyFwkBw7Nmr3iRxJbi7sgTtmo40/yGYU/vhRn1DjG1sM57mlLcs
 uJgjMMUgHak4kGc2e+zyioF77lBR2I9Z1RL+EHiVGL0aEr81toB6zRygEZVUqu5e9yoIbNv6i9h
 64Cj8e2Z5gA==
X-Gm-Gg: AfdE7cln7cFRTfjFHUIrsDFcuY3io9YpJ+Xa+1yjfFq1AUHt7FVNlOnrSsRgrbg4DIF
 Wb57cp0Tas5Hdf5rVkmdiSZALLizJH/iTrpI0ZhmmgUP6Cn/Tz4ryek1i7c7BCrzYA0qT+JT4nB
 avq4HLhdEx9VA0cJxzeypyesKlsy6kmBnp8qMbTqXTaO3J8hyT+FEg+Hdy+2TcC2qyuwwoKX99i
 QSzlI3upocR+jf+G0gCg7lsJ4VCmq3qr9ppQMWtsvydY5qdyTbni1f0ktorYNBMpPQ50kWrxApU
 S+7CIO52NgIS0vPrRj8pnjjX5mDxEKRs+OSqmQ7Y433eJzMqe04MYL6+XU18LWD/JddnsYDa+CM
 2sRnXkhrr24BEX0C4XhvmoEVcLD/2SHT4aF252gPAIw/hkT9Yl+Y9j9QPX2KdonTXfr3qzxffo2
 Hh+7y3GzelgYl+P2GCdn+RbjKwfaHab28cJNsT1A+sR9WHLw5TLdmgueH4yCKSjSTDKifFHMOtJ
 9w5IYQrUkCP
X-Received: by 2002:a05:600c:46d5:b0:492:324d:e93f with SMTP id
 5b1f17b1804b1-492668aa926mr19806145e9.36.1782381177494; 
 Thu, 25 Jun 2026 02:52:57 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49266102bcfsm53562105e9.15.2026.06.25.02.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:52:56 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 4/9] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
Date: Thu, 25 Jun 2026 11:52:44 +0200
Message-ID: <20260625095250.65073-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625095250.65073-1-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32f.google.com
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
---
 hw/audio/trace-events |  3 ++-
 hw/audio/virtio-snd.c | 57 ++++++++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 21 deletions(-)

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
index 7687261192d..80dc13318af 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -521,7 +521,42 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
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
@@ -531,7 +566,6 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              virtio_snd_ctrl_command *cmd,
                                              bool start)
 {
-    VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_hdr req;
     uint32_t stream_id;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
@@ -549,24 +583,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
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



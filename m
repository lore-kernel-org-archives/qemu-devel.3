Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB04C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T7w-0005fA-DH; Fri, 18 Sep 2026 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7q-0005dA-At
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:14 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7o-0007DG-KU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:14 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso3659685e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716911; x=1790321711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0xxlWberjV/um7rJumsSX31jfpCd1ioF9db9gWnV3gk=;
 b=nwfv+6qZwqyUO4QBPFKdbKdYb/Q1QeBVfcogc3SLH9ElmDk2Fo0jXHMI9cRna1NQTh
 +L2LTEPCNFgNBJH3VbrS3qQvOqsVk1WuIEQe4Uv+jRdk1S1uO0Gs6vDc/6DfdMf2Au2i
 +EupQLe3iSunoR8QOZp/eARorlnpR3iXmtg1OzlHZDFji7N5K1F4mCAxFidtIx41Iv9k
 2snmamQnnsrJY6kQPgrwpXM+GGr5139EOovj5+osQnSZXOmyyeek2jRv3bc/mPDyHPus
 Nep+T0SYhe4EpoHSpL3/UWelTvG1JL5tF0Nme4UGuQBbOqWRlTpqFNF2bBQPg3U/+K18
 8ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716911; x=1790321711;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0xxlWberjV/um7rJumsSX31jfpCd1ioF9db9gWnV3gk=;
 b=QMD3kVnoIn+cCFWujSkFNw+4Sio5wlyozTO6EaLY7s4o4QtFAqQWnRu9CLBAXv1O9H
 0me8K1DUFwcToJWYrNldqEzjhFyhyxD0jK3bBDuupWlCYYTt4S4Pg344X7y7ixzvA09j
 p/TCrJ5C1W1Mi35CWGGxnVxQX5HXJZHwyHjBRNYqp34KbX04ZGLZd7YT8ZqG+QtBLpC/
 Bpjx5pKBzZ3yXQdju+rwe9fnqf3cjRUmgozJAKz3i7dtMQVUSHy+nRf/xKJuSYkhMvkW
 3ZkbkSx+vo1LoOFT9dhq3C/DiSDhEuZPW6XOsTHKZLl3Zc4n2EUzwUDVi2cJXbHjx2Ha
 uisQ==
X-Gm-Message-State: AFuF++kMME0eB37IzvH3TAVbecBXXwSoXgvxO+aBhDIgT32JTyO/Lzoa
 8eqBakh8vL7gSIpSd6JU8aorKvhdFyrSOV59edQub3F4UokVFq/V3GSas/ubtDwPdjGBA9NRofO
 I8Vk/7IQ=
X-Gm-Gg: AYBFou3AxLSnEnPDcKq7hJy3knbarBrtXEFSvEd8bPUuL5UVLGOlbSoTzB6cf6pXMOE
 YeSY77bfr7RokCCgBza+F/czogzNGyhMZyJezhDtQDSlrsSQOl3xoGFi+JJ21Hs4OMof9JVI7LB
 4oTh9Q5MlqfcvRnpRGkEKUQDyvWxHv50VSBqRDh9ocToWr1SOimlmq6FAukNLdbbMwY4eu1kI1D
 zq0D5Wu1okZXBPqtpxDopYH2SG/IS0tTRgMk5vk02GZEBbTwYQUhw23eC5NI/QHAWBeCKU5PKkn
 6d37oOjxregjinHwNuau8MmPkrG2v/Btrx1bRdUH7Z3gwK8arWEYbkKGQYY8GfknysXKR7UwaIP
 +rJL3UdstKCdMT/RwxDEQJmaF3frR9wAauM0yve7myWDH72N67LmGmYTKw4hNcb0yh1sWVIj/8M
 jCq+zLuZxaPDBmYVi5JZmqrT3FePCjp8sE+HKgmvk3Fqm3VEqU0uLLdPyw/ku5gPDL4hhlrcVtV
 6SXca0qqWPcZTxyGCDrTsHT1AsRCkx0NKagDbIDUN4aZWz936I0Ia0zMDsIT6dlaJ2GkOBcgY0w
 z+eAJdLJ9QgEGJmO6VPJhiXrNw42ki390ykVTR7RxtXslc5kfSslwEAK9WnVeruYaV2VBbFkL23
 iorYETaxcYDCv2xsTpo/bWdEnMjTUp4mp9l8=
X-Received: by 2002:a05:600c:6298:b0:49e:73e7:888c with SMTP id
 5b1f17b1804b1-49fc5687acfmr17707205e9.4.1789716911207; 
 Fri, 18 Sep 2026 00:35:11 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm23879825e9.0.2026.09.18.00.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:35:10 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 06/10] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
Date: Fri, 18 Sep 2026 10:34:49 +0300
Message-ID: <20260918073502.3265143-7-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
References: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x10.google.com
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

[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
     and then reimplemented the patch idea
/AM]

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260803081159.91981-7-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 58 ++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index f9822fc609..46026b8cff 100644
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
γαῖα πυρί μιχθήτω



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CA3CDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf9P-0001qI-QZ; Thu, 25 Jun 2026 04:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9H-0001gW-0f
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9F-0007uP-1L
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so4443915e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782374959; x=1782979759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qG3AH3FF5TzTBpF0P1Mgrj/ndCjQ2RUkBwIiaBbWrQU=;
 b=e6gkXd/PJcxnkb66LgHABc5wwZ1ZGH24G9xYUyyxS/e0FI3+OI7e4+4GPE3tBLy5vv
 PoEj9m3aKhweHvCFrtHijO7HL/HlZDziC6489rOIUnU5nU/cpHfT1TtoYpTcHj9+0X9v
 zoWe61paHE1wiGCpJ02hW/e+tfikaeaJLVrE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374959; x=1782979759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qG3AH3FF5TzTBpF0P1Mgrj/ndCjQ2RUkBwIiaBbWrQU=;
 b=li0oENKEjgDI4MOHOtsar450l2gYlongtKdTBHvy7+tg0uT/LB9Zpes+eRoAMtlK0Q
 cvFiNEM5Xl7dZ6iOZ280SDlWT+XHsLwJb5ctTWaNIonzIsdQ4nnmQ5+nBgmAKQpPWVm7
 yadDk5gA8pxRtYaHxCtUgvHhN/tLFACE/b677pM05URF0qxAQrVcblzNmh18XKqeuq/R
 n4/ebTkJMt7BysYYKdo7Sb1dd+oMgRmqNeA+DMTD2nEbkMwiDXWtpafIKSxsEPD284qg
 fLZnL6oyxVeS+A/z5X0GtrDA1M4FhZaLmi/fFNLFsnFhFmWtDLBeyhgMDYyJ63gQsOuF
 BHPA==
X-Gm-Message-State: AOJu0Ywt4qBS5qNJ/OOH2pTGv6yrx5x0k09Dm/X11RpVUhOSh4KHVOUG
 YLQIWYwxFfwCBejFsWMJpPQyZPiOUlKFdbfN0/moTxSr6Oxqz4dlkZrQMskUU6TzLXyUT8c+/VD
 aEiIedFEyZw==
X-Gm-Gg: AfdE7cm/Z1JT5uRx6s609hKLXkg9A5JT5UHkLCAmqqPggOhTWgQfjiES1yuv6wjyDNn
 +qGMYB60MBxAxBZUDhtQ/PS9zcWSzWvgpXxI3U9vZ5x7KNc2jmdah+z57pKfZi2SkH9hWEGTw8e
 A3lEsniNeX3aqrMY3RrTaYSO5F6USN+tyeKxlCgy1VPgGbdyhFfC+ig42sACiq/orXf8RtXZhiM
 00QA9sDs9p4lN+BE4p/zWb5SF0pMkVgtgciu9yE5SAPObpMAeSwWlKxsSv+IpJXGqcf0pEf3t2G
 ItINNfqAl1aN+Y8GrUixRZyoE8p9UPNsREPYNH5IV+SXcLKgbZWyFy1hOw9iJv4b5KmzJM5Nj3p
 FE3Q2N8n3LP+BqaskMvxqx3lMfE0MPf70FbyFrybHi5Xhp+3iinYmzeMaMbF+pQMjUSZI73//E+
 BjK5ivkPG3ck3sQuKZntDWOKDG89yvOMtfDmVLzy0e/TCqbUXmDDalRK+IZt9QG36TcGVgG95iu
 jZue/g4+liL
X-Received: by 2002:a05:6000:981:b0:463:c84f:fcf1 with SMTP id
 ffacd0b85a97d-46a806bc981mr20177838f8f.15.1782374959498; 
 Thu, 25 Jun 2026 01:09:19 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dcbac0c9dsm3086950f8f.19.2026.06.25.01.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:09:18 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 6/9] hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
Date: Thu, 25 Jun 2026 10:09:07 +0200
Message-ID: <20260625080910.30569-7-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625080910.30569-1-alexander@mihalicyn.com>
References: <20260625080910.30569-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32e.google.com
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

Split out the function virtio_snd_pcm_open() from
virtio_snd_pcm_prepare(). A later patch also needs
the new function. There is no functional change.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c | 60 ++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 388a302255a..48a6ca9f09c 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -429,6 +429,38 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
     as->big_endian = false; /* Conforming to VIRTIO 1.0: always little endian. */
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
+        stream->voice.out = audio_be_open_out(stream->s->audio_be,
+                                         stream->voice.out,
+                                         "virtio-sound.out",
+                                         stream,
+                                         virtio_snd_pcm_out_cb,
+                                         &stream->as);
+        audio_be_set_volume_out_lr(stream->s->audio_be,
+                                   stream->voice.out, 0, 255, 255);
+    } else {
+        stream->voice.in = audio_be_open_in(stream->s->audio_be,
+                                        stream->voice.in,
+                                        "virtio-sound.in",
+                                        stream,
+                                        virtio_snd_pcm_in_cb,
+                                        &stream->as);
+        audio_be_set_volume_in_lr(stream->s->audio_be,
+                                  stream->voice.in, 0, 255, 255);
+    }
+}
+
 /*
  * Close a stream and free all its resources.
  *
@@ -455,8 +487,6 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
  */
 static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 {
-    audsettings as;
-    virtio_snd_pcm_set_params *params;
     VirtIOSoundPCMStream *stream;
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
@@ -473,31 +503,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    params = virtio_snd_pcm_get_params(s, stream_id);
-
-    virtio_snd_get_qemu_audsettings(&as, params);
-
-    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
-    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
-    stream->as = as;
-
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        stream->voice.out = audio_be_open_out(s->audio_be,
-                                         stream->voice.out,
-                                         "virtio-sound.out",
-                                         stream,
-                                         virtio_snd_pcm_out_cb,
-                                         &as);
-        audio_be_set_volume_out_lr(s->audio_be, stream->voice.out, 0, 255, 255);
-    } else {
-        stream->voice.in = audio_be_open_in(s->audio_be,
-                                        stream->voice.in,
-                                        "virtio-sound.in",
-                                        stream,
-                                        virtio_snd_pcm_in_cb,
-                                        &as);
-        audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
-    }
+    virtio_snd_pcm_open(stream);
 
     stream->state = VSND_PCMSTREAM_STATE_PREPARED;
 
-- 
2.47.3



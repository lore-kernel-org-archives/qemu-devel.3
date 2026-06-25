Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D5FCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcgll-0005ns-KF; Thu, 25 Jun 2026 05:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglb-0005mI-VE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglZ-0003ka-TV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so20013785e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782381180; x=1782985980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKuIg4zbqYwV4S76dTptYDjrz/DIacx24m9jlVXUL40=;
 b=hSYqJdIpVZehUI0jc5EcuPxAImDERsC+tkJzCh6g91xcrvAZMfpg/kK9Tswu+jeB6f
 /8dGVQ/EshygzAAkXj15LQnT4KO7h0QULOVRMsM1Gi4+WzrPELKcAKlwYF6QEskbag1T
 hN5eeR4UdEtqAX2z7IGtBnF30IlEjv8JdNoIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782381180; x=1782985980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IKuIg4zbqYwV4S76dTptYDjrz/DIacx24m9jlVXUL40=;
 b=cwIkIY5Z/uZEhU9c6XmG4YjVyq+Ulf/bodMcW4ApMnaPpY17CaJvXyMaVIDMFOpTEH
 JYcCyikHHEx0cykvkDEca5yQS68dQ1qMAobbm9FYv/9dPUldBH44GWi1csweQKFvapsG
 GWrywByx6aXWzWQUp4cx/djfaFydnYjbk0GGSjQcCMCB4MT/DrTO90eqIocKk3wVoV4/
 r9k9z6vPTx7c+q0JibONz0KUimO6gTCFu/Y07wWaJr87KB6Zvo+w5uNaSakIVrzD8Sl8
 vYHLoOhVex2tI0s/aTCLEwuW+BDZN73IIIpf3Qm060p4pt/55PZVKFSxXs6LAai9qpJc
 Z9YQ==
X-Gm-Message-State: AOJu0YzK3A0HhYzW1tQuUMXU9k2N/KldpRVGVjab/rItadMbfBWChVrb
 VUXvPuFAajkTOcvg2XoxgcTpjAEwoKNGzpmIOmDQR0iKwdnieMAspd74V2bNLzzVO441TlpM1hp
 di2WqptNABw==
X-Gm-Gg: AfdE7clSskxHtR6A8FJJUXRjEJMUOqN5Y2CXJmpCkGFCL/CqPxq8Ydyd8QhkP9YgPmb
 9UqIFd3Xx+Sqsg7GDqLxxAzY4R9os9OIyJB7eYuX14bMWy4bnzX1avySqUIASWoHb9YkOHaQ4by
 0qac3gIRMUD18FljVpGyYfDlCYtGw0myTGbZMN+YqZqLuM/OAbjBWBnzKrSjCWzbIif17AO3IAw
 RUaCWSa13M+zIFAdQ6I30N/1Tx4FUktghruG9dqw9XymDP3DtSUhSEJHX5Ykf15rzjJCWYzz9E/
 uP1eZ+W6oGw5F6RChuvtq9XUajjr5UeTfEPs14KD4AiN4OeghNkc6cb/3K+xkr/xbI0eqpp9j+w
 2kZ60n7+bY2DRvHLpa12GQ+tqYGDhABJoizwDdmqN5FpeZgAMWM44aU3kFd8pu0x06o8kqVMq3w
 D8bJTFZOc9U+K+dQ1nKDeRTy4gv55DuKX6UBMW4P5JFtJIDkzhaSR+2h2ICvc/YD3EgJB3WHAJT
 yqo7aENdSc2ICNvzirJkt8=
X-Received: by 2002:a05:600c:4e4b:b0:490:b724:5085 with SMTP id
 5b1f17b1804b1-4926689ab05mr23788205e9.33.1782381180409; 
 Thu, 25 Jun 2026 02:53:00 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49266102bcfsm53562105e9.15.2026.06.25.02.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:52:59 -0700 (PDT)
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
Subject: [PATCH v2 6/9] hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
Date: Thu, 25 Jun 2026 11:52:46 +0200
Message-ID: <20260625095250.65073-7-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625095250.65073-1-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32c.google.com
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
[AM: trivial rebase changes]
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



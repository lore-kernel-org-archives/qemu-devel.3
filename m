Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC66C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCG4-0004V3-9A; Mon, 13 Jul 2026 04:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCG0-0004Qf-Cg
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:20 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFy-0003CT-ON
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:20 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so13172805e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783932197; x=1784536997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=grKqIq319Vp7GavJNr9NRlJdcT2STtYLsl9rv45lrJw=;
 b=Qjgnz+XusZxnAoTNS3/l0/BCWuprnl76R4JRu4COlNihGfRDLJ6WjQatPh2QqIikca
 MmfCmKfIhEZiKsUs64lbq8TbHtY/omX7cDWFiKLayPLdfrwocLbUU4QVHYAgpqiqISoK
 orbMCePXPgl/y2Mwzy2umyBIHqlAseJMjN9AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932197; x=1784536997;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=grKqIq319Vp7GavJNr9NRlJdcT2STtYLsl9rv45lrJw=;
 b=fGVI4WpdXSHdo/z5906nw9fQU5F3d4TMF5gqftFEywWZ8e25lqBVMx+vNsKwX0Va+w
 TewfCAbTJTr4qzytDRnwnJzoeyffwv1GNaFSRdmbcxXOOJPCFpV4jejO0oLmCukGO+lL
 Vb19FVFN9li6wD43FKG7Iwn6eENiwG1hdWWvyLJ4wI3og6ZEOFFGtkyfCv+4c2IC5LCb
 s65kzoWIpcJnB8PoZ1TQu2rKlodehnLBCY5spmwTBfLguPHnGq+Ar7JVgxe3ST4DD3x8
 1pTa1HgL+IjMX5TyfEbB+MQTuZn5serRMmxD+z694eGKM7UZDhdSdusLChlRn7n/MBlz
 QPFw==
X-Gm-Message-State: AOJu0Yzq7aaNY8IxFnt9+711dl3iDYgRsFd5Qfg7AftQrE9Cwauzd7YI
 BtHOoX38IUYI3DFzMZNd70PfZ6DTNZanQ+6jYdIksIUCYqa43yNi64JUmUkExawjvcq8EPuDi5W
 xZBh1oGndyQ==
X-Gm-Gg: AfdE7cl+LKPRGKKJ9cQ0lAVM82OXuea5rpm63uOM3I1QXfbwXEc2e9A5l5egKa7ezj2
 z6wqCRjqYEP8V7nvze/t/k0HgP8qd7w2e0uDwn5ccFzp7C+2XwbS6it+hjtvD0QKQHQceU5/RyX
 Z8M/SYa+NCvcwdMhll/W2iWk37OTQmpaOXF4hFwNlk/pEMSRVk04Wzc00ga1Y8AK5WT6Y4USwhE
 s4DKZIQuGe25M9vxHAh8kHr/AvQp5z2FNQyiI/D3KHP9flwm0noDmhjrAEAlBRn/z34L7CbtZRx
 3OVklywQQlUzhjmxt5hroTRDggTIT/1B17e+ykmqCTKw+kKGG5B7fkswZAoi0t7qXZnlNrvLSrk
 ZpteEqc7e+dqeOjAj6HI0z5k6TVWHejAEps9hpuqF/9YSyq+eNzg7Te3mUFrRK26Za1CJbXiDBv
 8g71jIK3umHnCbfTH9kyraF75Z72yJQSnt6Glwosc6WGLdg4dXO6WNaNsaFpAe41nvzYFWCJYL2
 7Mq/1nUZz83
X-Received: by 2002:a05:600c:4ed0:b0:493:b3ba:84b4 with SMTP id
 5b1f17b1804b1-493f882998cmr82963345e9.29.1783932197173; 
 Mon, 13 Jul 2026 01:43:17 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200912ca59176a42017.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:912c:a591:76a4:2017])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm287254815e9.2.2026.07.13.01.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:43:16 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 08/10] hw/audio/virtio-sound: introduce
 virtio_snd_pcm_open()
Date: Mon, 13 Jul 2026 10:43:05 +0200
Message-ID: <20260713084307.79593-9-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713084307.79593-1-alexander@mihalicyn.com>
References: <20260713084307.79593-1-alexander@mihalicyn.com>
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

Split out the function virtio_snd_pcm_open() from
virtio_snd_pcm_prepare(). A later patch also needs
the new function. There is no functional change.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial rebase changes]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 58 ++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 9505e478e91..af50ab4c14a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -428,6 +428,37 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
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
+    stream->info.channels_max = stream->as.nchannels;
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
@@ -453,8 +484,6 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
  */
 static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 {
-    audsettings as;
-    virtio_snd_pcm_set_params *params;
     VirtIOSoundPCMStream *stream;
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
@@ -473,30 +502,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    params = virtio_snd_pcm_get_params(s, stream_id);
-
-    virtio_snd_get_qemu_audsettings(&as, params);
-    stream->info.channels_max = as.nchannels;
-
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
 
     stream->state = VIRTIO_SND_PCM_STATE_PREPARED;
 
-- 
2.47.3



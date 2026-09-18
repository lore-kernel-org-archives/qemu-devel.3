Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AA7C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T7t-0005eD-FF; Fri, 18 Sep 2026 03:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7o-0005ch-Ag
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:12 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7m-0007CP-Hn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:12 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e66390995so2086655e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716909; x=1790321709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ro6q4939JlTOoOj5Xj4n/vp5fXJkovksjsh3vzBpvoY=;
 b=Agb60WNnpYOzanjFUJbee4br2F6sCuyE/T3oNqoh2KOWvkyz8vFGXCnEhX1rFNoVN3
 va02/YJijmncUntAUoRh1f3MdNfyy0+Lc4Nx4LJ7zELBNRbUChqVkTR6wxhcLAQxW8Ah
 XWQZmatwyFjPGo8gaKnluisIYz57JlosfPr85GE/DfZib0ZrTvjVScY4iubZ8nTVGNmj
 UK8AVglszd1VTbIt3eft4C9Gfyu0JRtZI44NZaDgeN0R6olu83yZCBWhda68l3/AkHH3
 BojsRT56s2/PwZX5NlcRYJGL1VrS2S4VjtuXzfDEznD9L42e80cr3G+WUWK9TvtMHiZa
 O2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716909; x=1790321709;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ro6q4939JlTOoOj5Xj4n/vp5fXJkovksjsh3vzBpvoY=;
 b=Kd9775Vjq2wNzXI1GL8ul5ONz7ZJd8I+EuRcMP8O3w9qPzXEbd7B5awDg4A51+oSso
 ZV21h8hBe6St9ygh8xn9C9RnlFBqrdB9a+0J5QpyezLf1czYXVSoa89Eiv7qtkrOtkcD
 LHqI3SvvhVN814l2E8Tbv2Jz5QtLHwpadwtma5MYnqhHeqwwX4dcwb1eveeOfqy4vB/h
 kVrmZjQppjRIVN3nRgfmByS0n2p9GvRG8O1hLNHHrozHza2ynsFDuMZy8T6smaLvPs1C
 sBm9WUrUEJZG0LG3SQOLizAgmjFGjWhObEkuNZQJaXCk18cGP5DdiQ6hCJY/0ArH59Kc
 HRUg==
X-Gm-Message-State: AFuF++nzCnJFUr7yMfI4snYeg7ciaoQGOGs3j0wfOAxrdrMWf0XYoZiS
 AWI1BZeJ9jFqiWPiR6/+PCFqkwArhixkRTKxqbvpkM9fTwsRrkuNRsHEICiWrxhkOjQFCKIsM0m
 +8ntWXhg=
X-Gm-Gg: AYBFou0TxdYdnDFb9SYFj/ylQ52z1DuU/CSg0mabvS6DS69hCXXe8Ldwn7wsRPjUcSX
 0bnuhkQ+XRJcpZ2apA8eCgv0ru9s6xQ8lArk+sDCQoHduxE+HjMx+WOl2saXpFm5T6XkcTs+Awy
 TDLspqj8wU9Wd6mBRInvE3wcEFV81NBQmP/HIwSIVWv/TRKutycOlONx3j8vTQmRcvsKp0FcU3g
 De5WNEOpfUNHpFklREE/8fQYd0FmnPdnvBzFdNZmGNU8CWH4scPtKUdLqf2RinxF3zIwu91FC5h
 K656LNOIVle3ywbdMWYz6B3PNK0WS6efByg8Qiwp9lGn2T4sJ0M5d7lSlfK6TdFkMmyCfpLjW8X
 H+KUm5vV/G+APHY0rnjANfyaSWBDI+H7XyoACV3tFVbsiJ6zAxs0bWGFFYawbtMI7vT4PebJsdJ
 sNqheLyAscUP3tOuwh8BoqZXJ76aY4FSP5dTbKrP12CrUsggsUC7Y6C2aPE6lIaxWH+2WOzQj2K
 nztMDB5z2mvwHOdybYtLh2IP3wqWYPVtLJTcQRQ49U1QoLWMgKDpmXO5XcIhJVrW488pBlX031W
 OUuJB3kyfg2pQ9mPMOo29ef6Fxo51cdLBk6lZWeB6elvU81BzM+AVDZlRX+v4PnJHK+F8Qxa2je
 3W5AgCC3hxdsT5We38jqSK3mQlk2Yj1EZhg==
X-Received: by 2002:a05:600c:3550:b0:49e:7d74:7b7a with SMTP id
 5b1f17b1804b1-49fc56db8f3mr16820525e9.6.1789716909049; 
 Fri, 18 Sep 2026 00:35:09 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm23879825e9.0.2026.09.18.00.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:35:08 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 04/10] hw/audio/virtio-sound: allocate an array of streams
Date: Fri, 18 Sep 2026 10:34:47 +0300
Message-ID: <20260918073502.3265143-5-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
References: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

It is much easier to migrate an array of structs than individual
structs that are accessed via a pointer to a pointer to an array
of pointers to struct.

For this reason, allocate an array of streams in
virtio_snd_realize() and initialise all stream variables that
are constant at runtime immediately after allocation.

This makes it easier to remove the virtio_snd_set_pcm_params()
and virtio_snd_pcm_prepare() calls in the realisation phase and
to migrate the audio streams of the virtio sound device after
the next few patches.

[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
     and then reimplemented the patch idea
/AM]

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260803081159.91981-5-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/audio/virtio-snd.h |  2 +-
 hw/audio/virtio-snd.c         | 33 +++++++++++++++++++++------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 884c475ffd..97ffaae18b 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -136,7 +136,6 @@ struct VirtIOSoundPCM {
 struct VirtIOSoundPCMStream {
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
-    uint32_t id;
     VirtIOSound *s;
     audsettings as;
     union {
@@ -211,6 +210,7 @@ struct VirtIOSound {
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCM pcm;
+    VirtIOSoundPCMStream *streams;
     AudioBackend *audio_be;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index cbf739f8a7..84083be882 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -436,12 +436,9 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        stream = g_new0(VirtIOSoundPCMStream, 1);
+        stream = &s->streams[stream_id];
         stream->active = false;
-        stream->id = stream_id;
-        stream->s = s;
         stream->latency_bytes = 0;
-        QSIMPLEQ_INIT(&stream->queue);
 
         /*
          * stream_id >= s->snd_conf.streams was checked before so this is
@@ -451,14 +448,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     }
 
     virtio_snd_get_qemu_audsettings(&as, params);
-    stream->info.direction = stream_id < s->snd_conf.streams / 2 +
-        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
-    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
-    stream->info.features = 0;
-    stream->info.channels_min = 1;
     stream->info.channels_max = as.nchannels;
-    stream->info.formats = supported_formats;
-    stream->info.rates = supported_rates;
     stream->params = *params;
 
     stream->as = as;
@@ -1056,6 +1046,24 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
+    vsnd->streams = g_new0(VirtIOSoundPCMStream, vsnd->snd_conf.streams);
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
+
+        stream->s = vsnd;
+        QSIMPLEQ_INIT(&stream->queue);
+        stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
+        stream->info.features = 0;
+        stream->info.formats = supported_formats;
+        stream->info.rates = supported_rates;
+        stream->info.direction =
+            i < vsnd->snd_conf.streams / 2 + (vsnd->snd_conf.streams & 1)
+            ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
+        stream->info.channels_min = 1;
+        stream->info.channels_max = 2;
+    }
+
     vsnd->pcm.streams =
         g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
     vsnd->pcm.pcm_params =
@@ -1324,12 +1332,13 @@ static void virtio_snd_unrealize(DeviceState *dev)
             if (stream) {
                 virtio_snd_process_cmdq(stream->s);
                 virtio_snd_pcm_close(stream);
-                g_free(stream);
             }
         }
         g_free(vsnd->pcm.streams);
     }
     g_free(vsnd->pcm.pcm_params);
+    g_free(vsnd->streams);
+    vsnd->streams = NULL;
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
-- 
γαῖα πυρί μιχθήτω



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97F8CDE00E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5mv-0004d7-7W; Fri, 26 Jun 2026 08:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5ma-0004U1-LI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mX-0002zi-5F
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:44 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso8764415e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477339; x=1783082139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlnxYRyUlKwu9KkyaE+v4ep93iJxMvBgMn51OmmZMww=;
 b=UBNK7UmNFxWoEc4zLr2DENvqzHl8ai1AGHlfvHReNlhtVRpowWR4IGo3oHJbntfcXj
 g61NSY02HYtroQ9n3vLSdT7GcSxwHpiJeSAVPapbFeEJbbtCGUXv4EL+3GtMb9p8ugSb
 FPEY5Oi7+uTHqYYC8sQFERKpegZEwLKhNmcoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477339; x=1783082139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OlnxYRyUlKwu9KkyaE+v4ep93iJxMvBgMn51OmmZMww=;
 b=ULOsmlAgzt/NdS1hYTfKO73YlYNuBR6BusWXGZ2ALo2zzbGgVPSPz0A6d5fj0RcNuK
 xUGiLJf4N8o5+mZjJkhqB2186F4+W3f26n747UuBQnMFEyMEksnf1P+YVPJmTJk111u9
 FStsOkB66JwVF8UqJwTgWh0DqeK6ulJQWQsW51pSyfrSL4I9chN4hHZYSuLZLF4QY0E5
 WP4oN/ltgY/Sz2DBeP2QTzdH9c0GNQzf6UoyMh/HWiwb+doLdiE6W3pVUOc5oVg0yC8B
 TiUwGX1tO3unQ2DKxiamdInIjVwnrP7OHLEPyM8CwRzLrT76bLRhojkRT79asWuD1q7W
 P4nA==
X-Gm-Message-State: AOJu0YyKTW4wLrBHRgHRioQ7ZFPs7ooRUxIy68dNBfBElvT76KL4fuOo
 WYxDZaeYXGxONGgE6Gs24dtulsR3aNkIB/qOx9M7m8Y06/QB2rll3IDyu9w8UuUwUmJ7/TZgYBY
 xE5XMwzs=
X-Gm-Gg: AfdE7cnbUTRVsGhBZdqBMHCk+B4Hp7zIhV3GjjJhaI3iFYYXb3pf27GwQTB+xaP4eIm
 xwN6tVkM1pzJzIUJoBKV0uldwLXBZpbzJDDeJP7/fjC/7MNzLzDpBeOi2BAdg1iUu4kAae3bZ5Q
 RMayYTZz7zPcjNdj+0ZNtEn9NGkGgfLfMC6A3Fy47lwxOZQddsT4u6tsm4WY6kwCQcjR6kU7iu8
 /TJ22aZIK8jFEo8noXv0gGpcE/6TqnPmPzmPSvJ9G/zxdgK6p4mIHo7aP8o/t+NfM69iUl6YfyT
 YOqT7TdCPpOfjx528tcSkYh9BQ4jVJs290ceYC4/JT0TCSHbHihdd6NDxNHOlE0UiL9JkhjHXGJ
 56aex1APcYRpMXBsrYzQX/do1RKuvSO4xInWL9z63pAJyGCkVUmbW2i7+SUQy+zgQ1YzghNM6QC
 0hL06UQBiHgUK4dUspylfFDe3cYOfhM/xIsmVLr+RYXJsVOdW5feS9Oyp4zlnEbrfsdhSL1bouk
 u+IFEmVk+lf
X-Received: by 2002:a05:600c:1d9a:b0:492:6df7:942a with SMTP id
 5b1f17b1804b1-4926fc3a62cmr10449145e9.11.1782477339355; 
 Fri, 26 Jun 2026 05:35:39 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200aa896c1ac04cb1b2.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:aa89:6c1a:c04c:b1b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7373757f8f.14.2026.06.26.05.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 05:35:38 -0700 (PDT)
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
Subject: [PATCH v3 7/9] hw/audio/virtio-sound: introduce
 virtio_snd_set_active()
Date: Fri, 26 Jun 2026 14:35:29 +0200
Message-ID: <20260626123531.132078-8-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626123531.132078-1-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
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

Split out the function virtio_snd_pcm_set_active() from
virtio_snd_pcm_start_stop(). A later patch also needs this
new funcion. There is no functional change.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial rebase changes]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/virtio-snd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index d5242a5c761..c9c93bd090a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -461,6 +461,21 @@ static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
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
+        audio_be_set_active_out(stream->s->audio_be, stream->voice.out, active);
+    } else {
+        audio_be_set_active_in(stream->s->audio_be, stream->voice.in, active);
+    }
+}
+
 /*
  * Close a stream and free all its resources.
  *
@@ -598,11 +613,7 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         stream->state = VSND_PCMSTREAM_STATE_STOPPED;
     }
 
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        audio_be_set_active_out(s->audio_be, stream->voice.out, start);
-    } else {
-        audio_be_set_active_in(s->audio_be, stream->voice.in, start);
-    }
+    virtio_snd_pcm_set_active(stream, start);
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
-- 
2.47.3



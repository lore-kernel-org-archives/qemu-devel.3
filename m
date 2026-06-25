Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494D9CDE007
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcglm-0005o1-4O; Thu, 25 Jun 2026 05:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglg-0005mv-BX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:09 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcgle-0003lh-Sh
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso13029785e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782381185; x=1782985985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Un3eHQApgu4sIeZqrs0kysA5i496iAug3k/3dQTUAwQ=;
 b=LXfv5dggcI1bKcSLF2q89/FbDBSp0NdH7AFicfWfHFldnmr6CdB4DozPvZyzsvV5fO
 WDCugKwR2V472jjjXpU699BvZKfyjn2ypG24d1ZbYb4xmu68DIY/3pX3NxDG5MYP99dY
 k4pfIvitEsoEAJvB3L1cHrNBHyMMqhVabHC54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782381185; x=1782985985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Un3eHQApgu4sIeZqrs0kysA5i496iAug3k/3dQTUAwQ=;
 b=sUXyx2mowok2Y3A0+YZpig9lnhhMOYLmSWh9KjIXtlnT3747aj9Dmq19bp6UagfSP3
 MZ9GFtBB1F6OqKXUz+AtFJvpKliKOq+QiAhPrDLKYWsOnQbiVpkgsbsMmN+P4hvAm0Wq
 mfRFkY5gzZQpINs/02zTOGTUC+VbNKtTycIbzE0Id9Grdp41Cer5/m5/9DQwzYoSR3lX
 shK/I7+8a4wliIdQ4uNAVwDyRsJRN44FyV6N8umkeXemxNSN9qLqfKwjlLRD1LTjlDop
 Q8lc1rHR4PucYajRnGSjNtGcdxIkyW8jmq5t7Wy2m4jKR5DRgGsYxlMS7wmHkOAx/Oew
 AUvg==
X-Gm-Message-State: AOJu0Ywfv5CCyfanQ9a/qK/l9j237h0tJ3+eZfMlZQEN7W08pVaXWZYh
 0S3TS5j2HAH4CERUCZON3AC0lMA3ss1HyhyhLxMkuBPXlFiz+TPzulX+3MRUjmLjUev5MZmvdkE
 jy6FNqlsbHw==
X-Gm-Gg: AfdE7ckFPii5BwcmZKA1j10TbLLBh6EhztMmSJkrFljYfXybphY6A38bQj/7q/BXnqy
 E5ytL0BKBT28VXG8XGcFDeI/3UCtjgmmdUxD0SEw9XtA/xqGTqTpass05qj/KDhJCwWVtjdrkz7
 GWNY4x167HojR22KF4cK/o+Gi3j7z5qv3p2Y4l8fvI4oKQHNUrZKW4oQX7bIUYxP5WxwzmCw0qj
 Nd5dzjI+D0BlC3YV1dJsHZI8dZ580GVZtW5vVi5BhVP8DqVV3poZYXYjosXhNwHk6HjuiXTuCPD
 7o5DQj4P6Yy0jvUae30BqtII9mO7BfXrURspFaZnwV1VZwCIrIeS4p0mWjNwDG9FgZ0dKH6eOO9
 LRMRhAY8EvNX4oO/8xf2++BlwafLq3ITde2i24E/YVcBJVDgWOsSUnhJI3NlczxoC5ZZvxDzesB
 5ObI2NSPii4aeoJtyGBFLotDUSjbuqEueqF10z7KP1PwSPWNXIfhR8M5rC1jsQhbREA1mm77GhI
 nBQq9Na6TXlfSgJbcYzg2o=
X-Received: by 2002:a05:600c:8b6d:b0:492:367f:8039 with SMTP id
 5b1f17b1804b1-4926689a1c4mr27465475e9.33.1782381185524; 
 Thu, 25 Jun 2026 02:53:05 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49266102bcfsm53562105e9.15.2026.06.25.02.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:53:04 -0700 (PDT)
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
Subject: [PATCH v2 9/9] hw/audio/virtio-sound: add placeholder for buffer
 write position
Date: Thu, 25 Jun 2026 11:52:49 +0200
Message-ID: <20260625095250.65073-10-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625095250.65073-1-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x330.google.com
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

When a running audio stream is migrated, on average half of a
recording stream buffer is lost or half of a playback stream
buffer is played twice. Add a placeholder for the write position
of the current stream buffer to the migrated data. Additional
program code is required to resolve the above issues. However,
the placeholder makes it possible to add code in a backwards and
forwards compatible way.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c         | 2 ++
 include/hw/audio/virtio-snd.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index b3de8abcb61..cdd384cf4a0 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -81,6 +81,7 @@ static const VMStateDescription vmstate_virtio_snd_stream = {
     .name = "virtio-sound-stream",
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(buf_wpos, VirtIOSoundPCMStream),
         VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
         VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
         VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
@@ -1431,6 +1432,7 @@ static int virtio_snd_post_load(VirtIODevice *vdev)
                 virtio_snd_pcm_set_active(stream, true);
             }
         }
+        stream->buf_wpos = 0;
     }
 
     for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 523c456436b..4c688016c25 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -124,6 +124,8 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_set_params params;
     uint32_t id;
     uint32_t state;
+    /* placeholder: write position in current VirtIOSoundPCMBuffer */
+    uint32_t buf_wpos;
     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
-- 
2.47.3



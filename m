Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4D6C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCFz-0004QZ-FC; Mon, 13 Jul 2026 04:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFx-0004Pr-2G
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFv-0003Bm-II
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493e4cccd8dso12360395e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783932194; x=1784536994; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JUpFAaA/MW806h78l6jk6bGX0Ax9ZtQC7KOXHk9noao=;
 b=PSxrjy0UGqFwxQAf4Bo771jz5tZWFwFZCK4CQ+QV7LZxiYBWFBJOQ3g5lh6lZjnUSh
 SICVyPdgO0YU8g8zXdAmPMFFNRuZNdBFEpEbWxWjLI+gNDCbl/6DxJlAe0amg9DPo0XJ
 Ra05mw0xHHmcDjWMsz5sxWAVZRD2Db5LDcSWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932194; x=1784536994;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JUpFAaA/MW806h78l6jk6bGX0Ax9ZtQC7KOXHk9noao=;
 b=Z7LMZeEzST1GsOcUbvrK5ZbfUGy5Dt0oVl/3j3C7ISUyJe5Euyn1UfDlzUKkFC/q0D
 08ekS0OdswaPuPuU6PGSRAg5QoXg+P3m1Hjn25Git5ZHYkLsjYblySU1LY6vXcAVYwQ2
 VfvgLkoAF0PuFzZG3b6xZQKf34t+3gylakXfZ6WlM2unbRTRUirHaqPH/cUoFubgB8M2
 w+6hMf0WMegtZPchyMNdaasgKdoBssOMhfx+Y5F5wj1Qh9DL5rh2aq2iNxk9+hTj2aBd
 hF5q/BuzSIqvppwU//Ph+829uSuC7U8Ay04dAsww3mu2kl3Qf0yc16hvA9i32bHeVGBa
 LKgg==
X-Gm-Message-State: AOJu0YzwcTloXiUGtvzX9n4ECDPXidRtiws9P817WNM6zfHzQZpWMjJJ
 tXAQyMAPyxKSSOj0/hU4of4HLjBTdi5B1iHsMl0Li87Z0FRo0XDaIWelRLZT2GIxNBEsxhWvnee
 Bm8VLKmDY0w==
X-Gm-Gg: AfdE7ckgrA+iFRAF18U0x5WkPbj0Q0MSi70EgaJ7nwH2GQcMIy6pAOeB2/q4F3oR0WU
 na7bSnPp9WQbUPGrtjYsVlHMus2vqBZZ34AQB41UNbye+zOXvMSy5181LZ7GsQHjIrOgu7C2RGO
 2lsBFFGWvwwhKXEQfRfM0zdmMJRVC3vgjzVYxIZ/mJ9FYYU8jRSx5+kaWxYMdF3MV8wHrJO4ul2
 1+NYlxZDGRFycAK4cZs7NVdz9hdPly0E8ZMRpKzG5LHshniGVHfTkgb7Sb2anZIdefYkJYWvWGY
 sw8+NFSqRQHenK8knE6K5XWSudf3h/s/FwYWG1IAeS479BXgbecSwu1wvnkBa6oL7dP6pbAg5bU
 wtttE8YfxDrep9sXLQg82eSPV1vqL1+yeuj2Q1vOr2Pu3rUfrZVe9miN5OF0gOov4bsTR4wYL9u
 v7MYnRezpnAyiF2k3t1SYeIXlLpZ0Ybm1BzwKBQ4Cn5eMaqTzyCBj1Ba61o9WzJ6LSzokCz0Yx/
 K9b2J7AauMtgJftQq93zp8=
X-Received: by 2002:a05:600c:3b0e:b0:490:c032:ae92 with SMTP id
 5b1f17b1804b1-493f882a31amr74707075e9.33.1783932194097; 
 Mon, 13 Jul 2026 01:43:14 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200912ca59176a42017.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:912c:a591:76a4:2017])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm287254815e9.2.2026.07.13.01.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:43:13 -0700 (PDT)
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
Subject: [PATCH v4 05/10] hw/audio/virtio-sound: free all stream buffers on
 reset
Date: Mon, 13 Jul 2026 10:43:02 +0200
Message-ID: <20260713084307.79593-6-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713084307.79593-1-alexander@mihalicyn.com>
References: <20260713084307.79593-1-alexander@mihalicyn.com>
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

All remaining stream buffers in the stream queues must
be freed after a reset. This is the initial state of the
virtio-sound device.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial variable rename s -> vsnd]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
v4:
	- reduced a scope of loop counter variable in virtio_snd_reset
	  (as suggested by Manos Pitsidianakis)
---
 hw/audio/virtio-snd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index b2b711457bb..d51fc386593 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1352,6 +1352,16 @@ static void virtio_snd_reset(VirtIODevice *vdev)
         QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
         virtio_snd_ctrl_cmd_free(cmd);
     }
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
+        VirtIOSoundPCMBuffer *buffer;
+
+        while ((buffer = QSIMPLEQ_FIRST(&stream->queue))) {
+            QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+            virtio_snd_pcm_buffer_free(buffer);
+        }
+    }
 }
 
 static void virtio_snd_class_init(ObjectClass *klass, const void *data)
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A3FCDE011
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5nG-0004oE-FX; Fri, 26 Jun 2026 08:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mb-0004U3-Kc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:50 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mZ-0002zy-21
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4633193af19so547470f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477340; x=1783082140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDGlfrEOqkPZgC6vgh9JUvXYzJlsK5MIqvHrcnbGKMM=;
 b=O76th5PeVTusjTi14kdZCwGCaa0uy8rcp0HknNMmORkLcYHsMXWnAwG1eRZB75KiOb
 VNTnjWv0BKyUg8uDwpXZ/Weu9HXmLT791+0Ro80fk2lvPwnCqdWnN954Jou840lh+oP2
 KjpGruMY1kCg70zxFIkGwS/I+IszKsAMae28s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477340; x=1783082140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VDGlfrEOqkPZgC6vgh9JUvXYzJlsK5MIqvHrcnbGKMM=;
 b=PoWwDjyVW7pn61uz3M6itbUhNOcViA3boTfr2pFdHYq3tU7OV8VsVnRKKFMPH30/DL
 0UAtuzCKJaQWcW8q3FNzuSa2LijzMQRmiRKWkcfSFvoYt57yFOs4MBXfrdo7hveALXr5
 z3zoaL5SzmN8u1OByYpbrqsnuMptaRaeXBEL8ZBgSPqoTq34OuSD9QbedZyzn05WP2KJ
 flqkLHKfPDcgZrFwKEPGLgM7JNJcws5CEkHqteK4ojcwJfp/mJxfID0a8iG9CQmd1YIW
 MXamzd4hEbzabDJf29YTZENdJ9CItpXbiE0TahM+5XZ3Y/XlUMwp0+T07T+tR1t6z7w+
 eWyw==
X-Gm-Message-State: AOJu0YzSMabDpXaQOTYPkj2YzuTPSK88WEBFs0wweswuCwkoSOAv8vqM
 xKHLcdjq9dwyQxqu8lggLtiXu/8G6s8MDLC3Nqi+L3zMl45hzfDsf1SpqbiUMs9JQBEE/QmLJzw
 9nJm3jL8=
X-Gm-Gg: AfdE7cnb2qkXdX+i6K+aYRP8isNvTEgSqjBOzJ5mkNj38q+9/oX3nM/qwrVYWfj1TLO
 Udl3ugIqOoEcwnEY1MjqOGgNRAzlyxP7kLpBjL01VDMj9evfTv5UJ/kEAH7SVqMWN2KCrobsbv1
 tSlkrIvyZUNcghDbwbjpjIp/yoINV3MKG/oJlEN+Ds3P8tIJUf3FTfCSainbnWRJW/rTz7zbJwK
 SxViB3QRyp0KfAuBiht8SswbksfcakKEFBq33DVzbNJ/4jnQbtOsRRrVaC/6rBBzkuDHd6ZVhw5
 ahDpaiSwA8fIig/QGn+dNblkjxiqRkkS4K33RnHchAf0o2+bxlfs1g64LiU0Eq6YFK16dIFWyG7
 MjZ2j69NbXShHI3vMvae6eePoSUDSC7yCxmTjED+cw8Tl5BqDkXm1dSnSORrjYWMLu6dXvQgDRV
 e2rZZQqoNWJsQvmB/p1WCHevNOWEsvvD/0C9bxABiJ6sENeiI23p/g9BhwYDv0gLckDGWNbcrfi
 WfvJLn/gxGO
X-Received: by 2002:a05:6000:29d6:b0:45e:779a:302c with SMTP id
 ffacd0b85a97d-46fb87d2ec5mr637540f8f.29.1782477340182; 
 Fri, 26 Jun 2026 05:35:40 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200aa896c1ac04cb1b2.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:aa89:6c1a:c04c:b1b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7373757f8f.14.2026.06.26.05.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 05:35:39 -0700 (PDT)
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
Subject: [PATCH v3 8/9] hw/audio/virtio-sound: remove channel positions field
 from VirtIOSoundPCMStream
Date: Fri, 26 Jun 2026 14:35:30 +0200
Message-ID: <20260626123531.132078-9-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626123531.132078-1-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42e.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

This field seems to be useless currently, as we
don't implement VIRTIO_SND_R_CHMAP_INFO.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
v3:
	- this patch was added
---
 hw/audio/virtio-snd.c         | 2 --
 include/hw/audio/virtio-snd.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c9c93bd090a..81ba1e1a277 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -437,8 +437,6 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
 static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
 {
     virtio_snd_get_qemu_audsettings(&stream->as, &stream->params);
-    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
-    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
 
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
         stream->voice.out = audio_be_open_out(stream->s->audio_be,
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 72ef34e0976..85d5d7c8619 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -123,8 +123,6 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
     uint32_t state;
-    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
-    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
     audsettings as;
     union {
-- 
2.47.3



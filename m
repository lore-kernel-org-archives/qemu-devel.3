Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140C2C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqnmJ-0001an-Sk; Mon, 03 Aug 2026 04:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmH-0001aQ-PT
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmG-0003em-CH
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso11322325e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785744723; x=1786349523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H69vIMTc6zbjreaaAW8A21vCRMcF+sLX1oKxSski0YU=;
 b=aGE8NNxQX0c6MUPdi6Hi8N+96p+tlu9MU4oO+pfj2YK/ZoYjVT8i9EOc8oPxwCz7hb
 msvyPI3KkX/ZlEDyoZO0SGnVxjP9uowEjq3LI7UYbcHXcVrgSqIFSRzqLXC520VZd4g6
 G9hl3mmKCavQKIc8B+6nnnnpFAF/2Wa7buiHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785744723; x=1786349523;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H69vIMTc6zbjreaaAW8A21vCRMcF+sLX1oKxSski0YU=;
 b=IIcPxCx+I9Hiuo6MbJBPpU7MU+RYmOqsoYjDn1cbz68D4rpLqK7mZj3Zz2kgazb0ja
 4KjdJigd4CL9WIqpIQiZ5UkyzYZBM4esnbboFIy+HeK9wD/SAzbzTqhDKwS7xlyF4RK4
 HDGJ/twnFlO7NEVkkZTbS+XAXcgnlTPV+/+OnNZ2UOpiQHoRBdVvg5Iiui/BXjhURp//
 Rfly553Z7WROj0SIWCXWLWoP7Wx01NzWBtO+hF35PBxINzmofPEMNGCYwlx7toE1OEcJ
 BBYWcTPWolTslrRUSc+D71OwZ7lPKQgYfTl8J5nmy0UW4a+I2n3YzRuVF3UBeylhzZon
 JvFQ==
X-Gm-Message-State: AOJu0YxbXtWvI2n3Ne+wBAAgmn83S/U7e39XywrTfWt08/XP8e0ccw3r
 DcgZDOFF+JQdnl3jX2mfGWn2IJdsF28xhccybHcqO0FiLZeXG42ExSCzIUZioPECSW+wMg6y2dl
 Tp/bP
X-Gm-Gg: AR+sD13a6+pdT0BgYE8/cE85A5VLJxVBAaedU3yXEpakRmKh5T/1aVW0tsJrdR8azpP
 zejCPF+uC8EcLa5s+3LIBxImCxdSN9bCGDNqY6K1nobyArXeXxnstEJTYsU3zGNLQuF5cfNJYoO
 GlBvcEeGfrW1NwhsReydSQyvoelAmshiBWG92MMLmezlIahk46DeX0yzqycbOWgXmfs+VF7vXA2
 QC8cWwpQErwV4AxnM8i1yBEJiv7o/WjnjP2XU25CRCEAkuc4FGwDayEJj5INDvLVy1Bcr4MLMqv
 wYbtTqJ3lVKcqDeLcUuATc+smm9ludfgV7ky5VVfVgqZgWZ6kM1dofNe2boo4qpGjfK7SiBm/pu
 M4svIJvsUH7TDwS05Ar1Te4SaAaYyKVGf6YyifhVjfhJLgeXY42HrQWB4uj4o/NV2Xn43taGkba
 DvGDAOGptbR/LY6Q5HAqeNWSxfom3DAgbAWi+7SYCDez38aPY0FrkiEgWz/N/ViEm+LBELZpcE1
 Bh4R832YNFac6HKB/utKs8YGy/Vvr342ZCGcZrkjDxoZdWXpkmEd8nUrhY9
X-Received: by 2002:a05:600c:564b:b0:496:c93d:e2f with SMTP id
 5b1f17b1804b1-4980c65e93bmr137863995e9.15.1785744722661; 
 Mon, 03 Aug 2026 01:12:02 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b98284sm209358435e9.12.2026.08.03.01.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:12:01 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 01/10] hw/audio/virtio-sound: remove channel positions
 field from VirtIOSoundPCMStream
Date: Mon,  3 Aug 2026 10:11:50 +0200
Message-ID: <20260803081159.91981-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803081159.91981-1-alexander@mihalicyn.com>
References: <20260803081159.91981-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x335.google.com
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
v4:
	- moved this patch to the beginning of the series
	  (suggested by Manos Pitsidianakis)
v3:
	- this patch was added
---
 hw/audio/virtio-snd.c         | 2 --
 include/hw/audio/virtio-snd.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 694bcebb60f..46d81cc9ec4 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -463,8 +463,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     stream->info.rates = supported_rates;
     stream->params = *params;
 
-    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
-    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
     stream->as = as;
 
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index e28f1be5db9..f8bb5c95b97 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -137,8 +137,6 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
     uint32_t id;
-    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
-    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
     bool flushing;
     audsettings as;
-- 
2.47.3



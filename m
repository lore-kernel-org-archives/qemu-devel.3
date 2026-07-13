Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC69C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCFw-0004PU-Qq; Mon, 13 Jul 2026 04:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFv-0004Ou-17
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFs-0003B7-TO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493b1710405so14387805e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783932190; x=1784536990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KgVJglLfRPcfZ9RgHwLGDt0Bgq9N6mNRsXg9oN3NnKk=;
 b=Q3CBhxI9G2N4/igynj+g38SWKP9ihEWr6irktCr7XMH9xI7uTcY8Eh+vTr5ZLemZhM
 Ezjn4T+R3ywKToCurm7ZCMDv4G5jpM5tUi8OkRvtYU1TVj40LSX644KLSj/wOacbYO+H
 vjNG8Q0vpZkFjiG9rFNmvvZzM4llRX5ZoK9hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932190; x=1784536990;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KgVJglLfRPcfZ9RgHwLGDt0Bgq9N6mNRsXg9oN3NnKk=;
 b=pUJ4NUZ2gAk3ymjSewyc1EJQdgRcwzYRyeAf4x21qpoYdWUmMOwBHHK6yvlX1CiT3t
 7GA7uTThotzR19zhAdjASDtjkxdakIhkJF9trk90P6tiBT0R/w0YlI2IC4NNJRpRgEfH
 qusNbBju4FZ4+4Y0w6Jr5lCtACzUEb3cIQbeS90HRn9PeJWqYK/gvpTqc3YBFXNYo7qK
 xu4wk2srchQFXDHuOfbZmWXTAa2ikU8MDGmTt+GQ5IRAkEDIhFBBE0urPsZTUZrQvxwj
 QZ9BSf9tiLGpvjEt4KyKgsCoF0QrtGvRyvAY7D8EPiI1yKxuGZhAXFttBWYKLO/2UlBz
 Wtjw==
X-Gm-Message-State: AOJu0Yx/QMOHfhbElbn/76MtFqLGoij4OmVW1YSDvyaZl5suC7BCyOPX
 o2TAmcKUAtSY9fIbdt+uK7SrCKsi/E34TQHMXKSGBP0kPgwVbC94cxc9xefaU5nn6/DtaZ22vVV
 VsR0qnEsVqw==
X-Gm-Gg: AfdE7cmSOMEb4otlzWv3vYlcyXSBbcwQepzooBlWJTdhmQOdBNPDtY4aFSIR0Zmg3Ke
 bOMi/GKEBmOxqt/Ts2X8NBSmTjbv48pG3PG1TK9deEcASyNBEzskG9zjpoCcPgeIZclriBRMtry
 0HbwieUKBYZlbtr4NGtHp9Xqr+R88UwvH8r16xZSDqHkjVkqJzloSWMUbl9Rfbpg4rF7+E4KPGy
 6xj4Wmoi64cZWEySungza/4m8/+ulBCju58ohCZkUWESZK+Kms0QCysY4al51k4svnilBXZ3rdP
 2Z9bKIqg9jB7cpKCxSMdBy3WoRJxgmK9KzLRSLyDjFJOMjQVuHgEJlLMFp9Dn0Xxo6/xm+Ji8kj
 /ZDWfzTlhiPmP6Qr2nFoat9lmB8JX/js3dpyny0vjZICb4Dto4LDpjxLyi3VYCgsXQr0wM/u1la
 ykJuZnpxclIQAvzlgHuAV462A0Ua7vKF0pqm86HG5J6o97bLe8URUBkNnzb8Q5zKn6egxav6K4/
 /QtQ58niPvr
X-Received: by 2002:a05:600c:8b05:b0:493:e4cd:def1 with SMTP id
 5b1f17b1804b1-493f87e9ba7mr97459825e9.11.1783932190266; 
 Mon, 13 Jul 2026 01:43:10 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200912ca59176a42017.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:912c:a591:76a4:2017])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm287254815e9.2.2026.07.13.01.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:43:09 -0700 (PDT)
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
Subject: [PATCH v4 01/10] hw/audio/virtio-sound: remove channel positions
 field from VirtIOSoundPCMStream
Date: Mon, 13 Jul 2026 10:42:58 +0200
Message-ID: <20260713084307.79593-2-alexander@mihalicyn.com>
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
index fb5cff38660..82b6dabac89 100644
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



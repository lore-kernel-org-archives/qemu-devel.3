Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A2CCDB466
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf9M-0001i5-IO; Thu, 25 Jun 2026 04:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9I-0001gv-2b
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9G-0007v3-Ho
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-46cbe01d4b6so947861f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782374961; x=1782979761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3oLkQQvmPQBpNbaPrb0k9ibPB5UgzM32tGf27u8O5Wg=;
 b=YN5eHOKs0S6h0iBxUP8EFtMNbi+gIOmWwIaZDxAPsAcBR616sbk37dVD6GPduHS2Sk
 rRuN0/n90IV1WbHNisJd27cGSMhHUgyCO894odOrd9qme06IdhBhUKz/K1l1ddquliR5
 1+tldEyGDlVMS8VOfgxrPNnf7mhJ7PV4YxkeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374961; x=1782979761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3oLkQQvmPQBpNbaPrb0k9ibPB5UgzM32tGf27u8O5Wg=;
 b=GmvtAfscz6MW2Xgk1S7Q8WW3roh//qqZ0Y6M/D9nwbvvn+10lZ8qcCBZYrtH6gW9Aq
 SVr0Jkzcm3GyOnMUkjgkmxA+Zzqyw3b6W77HpSV4EUQr/5OdxM4TodxUoqcBFZMvy/bP
 y/Jp6ZjUcjrHJ5/jka6MrJxUG7cPnEsqq080EsGCkedPuvueZ4i0LVlRAh/8R5cpBkK2
 F9f156Yz5ehZ+hFqngzmxdWAwSxPJY1pzMlib60bdgPdk5/vcZ2ltzdHGX6g/EB1ig8N
 za3lfhsbaEn0a4Y/4a0qmpo8ejNlygQRhT+EPpfHC6uKSjKOLyQtO4TWqwkb/GXkCYB0
 obDw==
X-Gm-Message-State: AOJu0YwyIucE6YW6lS3tj31OFbmUSHypJtZ/gZNlZ5GK956GJ69AlZbN
 jpqEZ7EW0H0RIUz1mgKsNHc/tUU1lPEohy6qpvuqlqXR/5v9wEUslfyFRVYsQHqPOCAaDRzagPJ
 yPr1wXWwDJQ==
X-Gm-Gg: AfdE7clbDAD8Plq9DZQB6OUSyHgjrOKV9fyE5t5HqEKSjXblu3KNIezZKzZqle/jLtY
 /PGsVwathEBInDEPovkmQtm27aTBbJgLk05zb/lBIBXwEGEOJRYtVvWVHNKskEAJWffCYZsH8La
 GnSGndkPu/P+P1R3aAn8ob12oyl2U06+i+uPlMJau7mnTDZVXYsUixGpo/hRxm1UgD2rapublTu
 5VoQhfpUqHkMNFhhlRBvnGc47JRk/7E8SWIGlsvTgbeVlj5ITYAyQyOTNSygNTazr0EoDDVf6Sn
 FhcBcCvK32pvqZTnNlMMip364SfVU2GXhwgO5EGTs1b5O1Brm2CD1kWPCDS761nBMZvUDW3zCf2
 y8s0ZSUaXhPVteLsrwXLy0FXMVYhsQ0BBMUgwlLn2h3c5pgdz3ZYuIiH4mHi6/HQNsCn0DvKhRu
 As6vdSogHlifxOVt+ktPjorbvIzt+rnoFnXbvEl0AAezURFunglYCTV5J6DFULlM3J555QJQ/5w
 wJPMNn/E0FdRrS4MLUCiHo=
X-Received: by 2002:a05:6000:1841:b0:451:3b12:9bca with SMTP id
 ffacd0b85a97d-46dc20763ecmr2130614f8f.25.1782374960701; 
 Thu, 25 Jun 2026 01:09:20 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dcbac0c9dsm3086950f8f.19.2026.06.25.01.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:09:19 -0700 (PDT)
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
Subject: [PATCH 7/9] hw/audio/virtio-sound: introduce virtio_snd_set_active()
Date: Thu, 25 Jun 2026 10:09:08 +0200
Message-ID: <20260625080910.30569-8-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625080910.30569-1-alexander@mihalicyn.com>
References: <20260625080910.30569-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x429.google.com
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
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 48a6ca9f09c..53f9066ab24 100644
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
@@ -597,11 +612,7 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
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



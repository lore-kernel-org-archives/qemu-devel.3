Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBADDC55175
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqnmT-0001eo-R3; Mon, 03 Aug 2026 04:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmQ-0001dW-Eg
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmO-0003gB-Qe
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so16038645e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785744731; x=1786349531; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yk4QU/rg0hF+eFgydaLhp9Xo1khNYSDib0HHocRC0zs=;
 b=GROxNQpI6nO6Kxkc5MoVmDIMNhFR9pXpjh2Yzb+meCqeJZwdzLDxr8/hspNEnfFtVp
 X7lCzliePzh5vi3zp0aq6IoSMFP/4mlINzCHsjNWu6f1jW2n+KStKFjIkS9CN46EJ7zE
 JQX15yEZe7rWTXHxlI3dt9uSBHoSOd4mqo+z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785744731; x=1786349531;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yk4QU/rg0hF+eFgydaLhp9Xo1khNYSDib0HHocRC0zs=;
 b=THQ/QYmNYmzTKAXtSVFqFUEEr7+Or3EohU/Qh+kNe8I8V5MaOj8qTzmGMCrFbX02Au
 1dCKofiHGtGlj7ptnOxBbmyIAG1ghVqO+2w1npiFFGi3emh2nJcCBLwFHh+QuWiuvGuM
 Y/5SAq8scyuCXP/UA5GZ62qsxXrsHIqnSy/stnoV0sgoUcUksLEHRLk6rOhKG6peKqJX
 5YOvr9Jy2I11JrK+mPUzE52v3Z1/fT11kq95ngnEL58wXNWrtvmQSTZKH6OHCeJROjvA
 CXQRP5mJMjqOsphkBm9COPu/+C36RQz0uQWgXE5sZvlZ/GXbaEKUqbC4lBMleDhycwdF
 SjDw==
X-Gm-Message-State: AOJu0YxUXQGiPtlSZ7mV5VJwtovJ0GMcIRFmRUgY7EY05GChhPajaGPt
 ueOAMo7OUHTYYnkuSLVDzBXAWaYYnMsJSVb7s+rG3uaFP87/XcAEV6TtBJ5N3xC21MS0/qrBDJJ
 u1lzb
X-Gm-Gg: AR+sD13Smm/0jQQweo3zZCUMV/ePKJwc9s1kWUnEU4ZLUTqVxrnjoLiBvM6IFRryo+j
 S+anqeOTl/Nm2TxNqmYVOF9LZZQcgQ7E2Vmie3j1fJ636re7dZoaiL2jc61yxaIiAGx6eJlig4y
 SKHoRi5z3LiDu3dHdw7bSCu1WK97+fmySyIVYWdFDi7QGckuxLfU58MLxCmbOWncO+aj9KRJ3Xg
 YUWlMD8cJtQatrzLAQTmYO+c7lPF/8dP2b5W2MOrDKQFd1mG10trSAPU74euoJKXBtxbk/FnL4E
 7AuAKs0P6+d3Q3TXK8Rs6gVo4UOhh+z8jbYVs9auLFRbU9yyG6I51xn1jobpYgPt//ka7sUxcdY
 6Ywp1Hu/57dzx6LRiyo/KxSospNQD5QzuWEd7JqPtHq8EatC2vSlqQG6QVEnaH3OBN7Ch33EdLy
 hXIytLzD9yjcwR5+lf4d72lw2WCi4zaUy0Hl07+jFtBZyz87na53OKt56zIGRRtb4lXP/3t/R2V
 MrIoacFp+BY1JQCIZUNnbCXuDBM/f8O1WMzbWCms6tLFFcJXVRD1nJAbLKK
X-Received: by 2002:a05:600c:4444:b0:496:c249:dd9a with SMTP id
 5b1f17b1804b1-4980c66c931mr167362905e9.3.1785744731432; 
 Mon, 03 Aug 2026 01:12:11 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b98284sm209358435e9.12.2026.08.03.01.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:12:10 -0700 (PDT)
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
Subject: [PATCH v5 09/10] hw/audio/virtio-sound: introduce
 virtio_snd_set_active()
Date: Mon,  3 Aug 2026 10:11:58 +0200
Message-ID: <20260803081159.91981-10-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803081159.91981-1-alexander@mihalicyn.com>
References: <20260803081159.91981-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x329.google.com
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
index 7944d2b3b95..12473862d24 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -460,6 +460,21 @@ static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
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
@@ -606,11 +621,7 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         stream->state = VIRTIO_SND_PCM_STATE_STOPPED;
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6DCCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgT8-0000iu-5M; Fri, 02 Oct 2026 12:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xCgT6-0000ih-M3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:50:44 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1xCgT5-00007U-0n
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:50:44 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b09f6bbe8so1301567f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1790959841; x=1791564641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JasFbHPNBB45q1/FcyhQzW59dQICHUAPzEu2s91JWcI=;
 b=g4TcN2YtybdkdSe8uRx+0vBQxGGnZ36QD1Dx7qv4A0yNfcxwRVNfC/B+DQSdsbK5AQ
 ZYVMrp0/DuU+f+1WdCgalTyB6Qazt8SbIN7C4uY2GlwTTKhQMQnNrt7U8vCIABa6jf1H
 2eJY/kYI6sI6yeBVHl4wwLE2NwCQuaPzI9JGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790959841; x=1791564641;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JasFbHPNBB45q1/FcyhQzW59dQICHUAPzEu2s91JWcI=;
 b=TgCP914ksdILpLhCdItZhx74wDryowGCDqNfc1gOjtYwAez6GZONfaYAzCXBZhi/4L
 Kw1flX4vF05mrLZ0P5ARMtTHyNd07Vi5bzeTYb49X+5B5BwJRSql8p9faJ+7kaIdRp/g
 e3pXki0daB16tm69IVm5ZTp0emZYmAViv2RB0ndF/SLFWPHJf7wVoDrfytQUjfFkviGI
 ooXmxJUAtiZGAbeniI/h/5Vt6ESBxibxtXXPH6yLxk+3c3ZrSYcvxR9pu1r1xFEd9jiX
 nr52CskVHBMk3DjP7FFQ/2erYPjIgRdb7crfmUJ9rwuUhpebOl6DSqQHLZv+X7jroswp
 tSUQ==
X-Gm-Message-State: AFq9FYIjzFHn7EAZJJm0jR6fQJES7xAdjM/sK0/IKv7/0mhyAXYHwTX4
 4QQ6kjAh876fJRo2BsVR4rdtlvPLwey2/CqElAoohfURnaZJpsOqAIbX7BHCk7b+M7iWBAMSD/T
 T91ey
X-Gm-Gg: AYBFou2hD81xzOSUUz6uBC6s4hT2q+KPi8CzXtG0d8FPrVqC5IjLfe3+m1TCUKh1aVV
 xHZeEL4rROOh1n1PiUkcB8DLbhqEDtob+RcZ66Fei2+jxPZEw07ocLoUwr+THcEirhqIBUZBDMT
 Xd7AQNrlFR2YtmF9oGtSB34bYuWzcTCxqMxKm0wtgUUrugsD9p+Ns94a5LhsRvQtZHffcvNIHtk
 CWirKOLJflRJhxqD4B55jRP82uYwIRjSe+nS56nuwtNi66pEbV6ag7+RO08EApRdCqTqtbc2o7m
 WI7JpQcebf3oQKKSF9j6DbAyiekHBe1sSTsseGIKdEifn+un1dfsBiHOhFUL2xc36UyW+mN7vq5
 K7HqqCai9hV14Td5Xd/N6mbTnoMruf/K1VkvFWLHkrdIHal/QYp7sJKz14bMJ+Hi2XbjwQpwScW
 Cb2yQ4jiDFHiTVMv7LDyZuDrwN4NS42rih8xXslfylTC81bbH7C+a9d9HdA1X9AeDYRUjN204k4
 nOskrH7BofEw03y00A5kZAdbhoPrUEL7czxvazIGacu3iCsYXRlpA+c2TlbHDjDVh5G
X-Received: by 2002:a05:6000:612:b0:48a:f603:1b41 with SMTP id
 ffacd0b85a97d-48b1270e6f1mr6362552f8f.17.1790959840767; 
 Fri, 02 Oct 2026 09:50:40 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574eac00045254914ae5cb71.dip0.t-ipconnect.de.
 [2003:cf:574e:ac00:452:5491:4ae5:cb71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380fada5sm6448550f8f.24.2026.10.02.09.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 09:50:40 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] virtio-snd: don't use virtio_snd_pcm_get_stream() in
 virtio_snd_post_load()
Date: Fri,  2 Oct 2026 18:50:39 +0200
Message-ID: <20261002165039.212819-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr2-x0f.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Coverity suspects nullptr-deref, because we don't check a return value
of virtio_snd_pcm_get_stream() call in virtio_snd_post_load().

While, techically this code has no issue it's better to change it and
as Peter has pointed out [1] just follow the same pattern as in other places
of virtio-snd code:
    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
        ...
    }

this way it's perfectly clear that an index is always within the bounds.

Link: https://lore.kernel.org/qemu-devel/CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com [1]
Resolves: Coverity CID 1687010
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 6df7ea0eb0..fb22d79949 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1448,9 +1448,8 @@ static int virtio_snd_post_load(VirtIODevice *vdev)
     uint32_t i;
 
     for (i = 0; i < s->snd_conf.streams; i++) {
-        struct VirtIOSoundPCMStream *stream;
+        VirtIOSoundPCMStream *stream = &s->streams[i];
 
-        stream = virtio_snd_pcm_get_stream(s, i);
         if (virtio_snd_pcm_state_prepared(stream->state)) {
             virtio_snd_pcm_open(stream);
 
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA9FC53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Q5-0007rI-2G; Sun, 26 Jul 2026 17:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Q2-0007p5-U4
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Q1-0004LK-FC
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJ5++lDmKJE8GWzy18k6nmNQiVQ39RoIQiUYRj/hei0=;
 b=UlaacUNCNQOq2h/TgDpL5IiyGxjVvso9sL9RzkzTdVc2sIpE1yf/m6KqRbejG1U4Dci4Ko
 oeZSqXWBZel8Dxvdb1lWmPkRceNlsZ/ecWjvcwJhqoi30XkmMg1juDGhPeF5VuoC/rTcf8
 DYxbhrHBoYcn/q6Ko4mytWPPu1ev3YY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-Pz0T3JcoNJK2j3vEVwNahA-1; Sun, 26 Jul 2026 17:29:55 -0400
X-MC-Unique: Pz0T3JcoNJK2j3vEVwNahA-1
X-Mimecast-MFC-AGG-ID: Pz0T3JcoNJK2j3vEVwNahA_1785101394
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495495ad5ddso11500205e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101394; x=1785706194; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nJ5++lDmKJE8GWzy18k6nmNQiVQ39RoIQiUYRj/hei0=;
 b=htomrWnTfCISuFhMLh5+vRUsP1wjFZSqRkKxH8sXgjWw8/Hc4I6Pus3JeJtzI0zVJy
 5NwPkzZuRdvUqWkLpicv951MhqaZmcyGowHykH9WvHYksjBz/9AFQ7nqX3dLYxdX7X/I
 4clLBV7WeRDxkLb2ypMVRVtN5qSeVQJSzF/vwrEEzFWyIkRHTDGH35PCdKasNRWhNO9x
 fuTl+0fQSpDGL/tTOD/33YGCRvf9RYJ4Q12AMfytmI+cn1N+ouFCQFmM+WHPmmkHd3vV
 YyJEnmPtXvS+8gh/7/lQH3qpRi8N5L1XXUYtqdL8xBV037S0ydc7O9TNSa283Wzxh6kS
 sYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101394; x=1785706194;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nJ5++lDmKJE8GWzy18k6nmNQiVQ39RoIQiUYRj/hei0=;
 b=M8P2AcPwJeb1lJ6+TNIiXEBuTPC6XpGzKm0pvbGvISuS2hM0HzWZi5QVGxHtNyYTb6
 9riQUKLX2U76DTijdThbXhW08kc3YOgpfHWbP36AOOXRgdwNR5lb/8WrCTmadjMGL8Sx
 ERfQBbGRO/oRfL/ah8MWfL+xgN54pB6rf8J06QCTUxd1/U8OlpqWzJWu1hi75nRGpxqO
 m+Dg7JKvbhfSVrwbRRkq9gl5K1NZgWeqLDSaMvu6qkBnQ7rnRAYza9wMy2xIGVC3a7Ix
 lerplycyIYV9ads7xF28iOiw2oeMVC9kQ9wzNGHr5tRkEvmxOUA3teXswGTXooQaDA1V
 Z5lA==
X-Gm-Message-State: AOJu0YyM82LrpiStiHCqWtTtA1L74RZTr98zL0RU9rXF+BR+yZI9RoHE
 +y4hF3UiZcANJNPaYJMAKYhn1eO/4Z4RPClIh5Y6PxZ7P3BZPsfdfrwdS38yfbjWod3NaFVEM2T
 b1Ba0dKHz9+WDuBEFgRAdbZslbXwl+kq5wjt1nZ3qRD/V7fBJrkS+1wapIDifxvm0Ne7JnXhXpw
 1O2pyV1lw19ickg3um6EHEdb5GyrwpMPS7AQ==
X-Gm-Gg: AR+sD10wHVLcGZrhK0jysiWi+JL7AS2GExj1P6LwWotW6SzpMp9HDIV7CWLx58BJgNF
 2QgoLSl8lrzmoo8QQJjRmSazULat3TPx5d+Axn7E/U6dYX8OZ0oyUyTXn3nlqx+WX9haoUdAelB
 +OlglNE5k1zBTdis5TghI/TPHeKY6qHCN5/+eOsnwtvoLvGPXe6dQ5TEQ6aKH6d+OfFSF7POorR
 hbrXymRrPqh6QiXZzZ32XkRQg11ZeNINm9jJpSXiReqOOa+NnBCAy0cUpUcuLr8toeE0Uf2SjUL
 ++uNnyrMOI+hacNYVjG2ywiOf610GBmQlmmDXsi6HwApIgQQh72LWLK+x1ekSmiR5v/WFR1GuNZ
 XHYVCUBQ4+PULeHRHd4Z0nA==
X-Received: by 2002:a05:600c:4f81:b0:493:f528:58ac with SMTP id
 5b1f17b1804b1-496b56f9d75mr90751565e9.21.1785101394129; 
 Sun, 26 Jul 2026 14:29:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4f81:b0:493:f528:58ac with SMTP id
 5b1f17b1804b1-496b56f9d75mr90751295e9.21.1785101393591; 
 Sun, 26 Jul 2026 14:29:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm42071059f8f.16.2026.07.26.14.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:53 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 21/30] virtio-snd: check for overflow before g_malloc0
Message-ID: <068b959b481a54b1cfad74f013624fe8d6c550e5.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Coverity points out one g_malloc0 overflow, but it seems to be a false
positive. Add a check to it regardless to fortify the code, and also add
checks for every other g_malloc0 use.

Resolves: Coverity CID 1547527
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260420-virtio-fixups-v3-2-07aef1eff9d2@linaro.org>
---
 hw/audio/virtio-snd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 93fbcfb43f..694bcebb60 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -850,7 +850,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
-    size_t msg_sz, size;
+    size_t msg_sz, size, tmp;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
@@ -880,6 +880,8 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
             goto tx_err;
         }
+        assert(iov_size(elem->out_sg, elem->out_num) >= msg_sz);
+        size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= vsnd->snd_conf.streams
@@ -892,9 +894,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
+        /* Check for g_malloc0 overflow. */
+        if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
+            goto tx_err;
+        }
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
-
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
             buffer->populated = false;
@@ -932,7 +936,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
-    size_t msg_sz, size;
+    size_t msg_sz, size, tmp;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
@@ -977,6 +981,10 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto rx_err;
         }
         size -= sizeof(virtio_snd_pcm_status);
+        /* Check for g_malloc0 overflow. */
+        if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
+            goto rx_err;
+        }
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
-- 
MST



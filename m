Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51409C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQsE-0000GE-8n; Mon, 27 Jul 2026 15:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsC-0000Ez-Qw
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsB-0000c9-5u
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2g6MMmyPKzZozOuhiPXxtJVxbTcTWv7RFySNngDrOZ4=;
 b=Uhxg2bP9CcIKWKUq3xa26BDKjbRvqdFYe98d7xrKjrPopTSB3e6lLp1DALY1aK6pddgtzF
 /CB8WW4zwL92V7x9gQ3gtijBv63fPugc3eBPPT6HBplJPCn9iEmAIjeUQKEHKdAcws/EGn
 oaXe7PnBpiqy1fK3a23QvtYvYtpDz7g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-RatjD4wBONqPzy4kKVq86A-1; Mon, 27 Jul 2026 15:20:21 -0400
X-MC-Unique: RatjD4wBONqPzy4kKVq86A-1
X-Mimecast-MFC-AGG-ID: RatjD4wBONqPzy4kKVq86A_1785180020
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-496c06ba017so1247675e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180020; x=1785784820; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2g6MMmyPKzZozOuhiPXxtJVxbTcTWv7RFySNngDrOZ4=;
 b=cznLWh7brtaYz9M78iqeOXO/ihnNOxHatsOuKizRgasAnPE6Vcqbh+DwH1u51Nqqcl
 J7JDuZ8VYXf/LBb5BjjF8ccSWviVCTtAmBfblSQ848YIBGO179tjamqIbMslIxx3obJV
 /SuUifMUTrVjn60RyHq+ByXjTWvfYiUo4leFOYzsmmB/AneIMZI5SnTNXGREAQxpOxgx
 0vNgsvJhSK1hiRKefQi5DC5p5nFZYhRzwIqoq677GuDBSY/fJIZFEhYpF/r34C063Uho
 lHO2fL35lYSq7owgtcoF2uBs/TfxVZjIkp46JaIM9lUGg1wmpxYQxM87uJS6jPxfirRw
 CNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180020; x=1785784820;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2g6MMmyPKzZozOuhiPXxtJVxbTcTWv7RFySNngDrOZ4=;
 b=DQZu3dLeeLw2FKF1Yf7iKL4KKQ42YA/qykaCffUTgZcOYUqh+o9s1IY9KzFN8xBf3F
 S0X0DJvaPWGz2f5xkHir1AOZoh/Cy9mkxj6C2wnpXkWiNomUDxGXxfrWwPmbY0a9Qhgm
 w94BE6scWP+bf/IY79EFmVsmk3Aeo87t4qgY2ZJ5DTzROIZlt4iwlQ/JR/ZUxbq2OQxH
 bDjnXiaYfn+Z2eRENWMr6+BqNk55jLZUmej58mITm4zlzd9gRXv3LGR+nQp9NJY2N7SN
 5zbJ9qitUutU1hxJMaMziUqR3MT182f+GEaPkqgM8MJ9tcOHx4reqsg0PqWhIdtC1cbv
 +W1w==
X-Gm-Message-State: AOJu0Yz138OURmazte4ccdbsQyEm5nSps310yJhHW9x7cz2GvnADIoai
 szLZYgZVqZblXe4DEvoihWUEOme8D0L6hJzn/4nPj4bOesyCfitgNaNd+oNNIWrk2SQU2wa0oBd
 faAKdqImBhKVYOOkrLL7ln0LeomNdNXNGMK4NZtCdiaOY7kGextf5xf8qfC3DUbUyeEE+/pIWaD
 aZVp+F65mkXbz6i/4j238/wkKjzy5/b9lIlA==
X-Gm-Gg: AR+sD10TKAk9qaBjOq6/C5RT58lBCoVuECBi2x4ElwJNkGoO6nf+GIrm4PiZIHIw+Xk
 gI4bbuqU1sperJXJL6A2xW0/x55WAWBSfH8hZO7LJy6tq0F9HlCIuevbN3dQC9AQatsKbSl+gVm
 0XKoPjVyyW4W4UALZNOSKIf3wmfSnjzCzvKFzoOrW4wrtRUyBz95jAEHDEkpf9Zb7Nq66fy97Yr
 j7Nd+xVoJTNh5fSFqWzIIMXy/RyxlFzTwen4ghMqLvOSU3/WwEMoVfDGGG194Mim+FHqoKcaxrf
 q+1mPu5ndC8ZIAiQgxBUcdKxArD2XVP0PP0++/UO3tF7wNBR83i4h3os7jz9cR9u2TH+ZzeAPQJ
 e635Rl+YqQHRuWkM4kSla2A==
X-Received: by 2002:a05:600c:350e:b0:495:4f84:7280 with SMTP id
 5b1f17b1804b1-496c5660694mr577295e9.4.1785180019727; 
 Mon, 27 Jul 2026 12:20:19 -0700 (PDT)
X-Received: by 2002:a05:600c:350e:b0:495:4f84:7280 with SMTP id
 5b1f17b1804b1-496c5660694mr576845e9.4.1785180019291; 
 Mon, 27 Jul 2026 12:20:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c444304esm15501925e9.0.2026.07.27.12.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:18 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 19/30] virtio-snd: check rx buffer descriptor size
Message-ID: <bdac94e9cfdff4d9d3c1a6f7cd995e4e4f04d7a9.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

It must be at least sizeof(virtio_snd_pcm_status).

I haven't verified if it's possible to get an underflow, but coverity
points it out in CID 1547527 so add a check.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260420-virtio-fixups-v3-1-07aef1eff9d2@linaro.org>
---
 hw/audio/virtio-snd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fb5cff3866..93fbcfb43f 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -970,12 +970,14 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         }
 
         stream = vsnd->pcm.streams[stream_id];
-        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
+        size = iov_size(elem->in_sg, elem->in_num);
+        if (stream == NULL
+            || stream->info.direction != VIRTIO_SND_D_INPUT
+            || size < sizeof(virtio_snd_pcm_status)) {
             goto rx_err;
         }
+        size -= sizeof(virtio_snd_pcm_status);
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            size = iov_size(elem->in_sg, elem->in_num) -
-                sizeof(virtio_snd_pcm_status);
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
             buffer->vq = vq;
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86777C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Q4-0007qc-G3; Sun, 26 Jul 2026 17:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Q1-0007n3-BM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pz-0004LE-GO
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2g6MMmyPKzZozOuhiPXxtJVxbTcTWv7RFySNngDrOZ4=;
 b=TE0+iSXkuEZA3a1IePHNAVXMNZgQ+uFyzV9OeLIwEfLSv9BdEsjW4839CAfCiyKRH3l3/Z
 lq76lpa+gCcSJ/YdgPA9NbxE3xkTTghBB5a4pQxlfnjprznTd5dWZmcYV7UUTLlyrpIOKA
 RVp1h+LM1OQtPDxLo2/mcAXQTtv03jw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-F6pb_JbxOXWvp5Abp6Bafw-1; Sun, 26 Jul 2026 17:29:53 -0400
X-MC-Unique: F6pb_JbxOXWvp5Abp6Bafw-1
X-Mimecast-MFC-AGG-ID: F6pb_JbxOXWvp5Abp6Bafw_1785101392
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f8158485eso1669242f8f.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101392; x=1785706192; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2g6MMmyPKzZozOuhiPXxtJVxbTcTWv7RFySNngDrOZ4=;
 b=gc/uNyhH1h+N3KvXAAHRHV26tA8DawflWNRn2P1942thaTztJ1F0Obq8SEWPjgcEsT
 pov/6+wP17w3+4DoIhyBjMwQt8MOCtPT0INUnqHxR8fLuCnUySsX3KOncFA+Lg6akT+K
 Q+dNw4ICCyvATIC8h0rUdENpC1gSxSnXF6p7QuHXMP1TvTMZFo5hod1+/WdAPm1pEb31
 2oENO3Yk7jzzoGZ9AxLOo7RtpJ8hqeeJ2ohYsdOJeiqOBjKJnDcbqSvz29qZV3GzrV/S
 E55Ag0jmnot7qYf6/LL/lG/L0qrorbDs7lByl0Ll6XX99/3P8wongEnzkz+qVURfKMWb
 wYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101392; x=1785706192;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2g6MMmyPKzZozOuhiPXxtJVxbTcTWv7RFySNngDrOZ4=;
 b=U9bhJ6smRvnZKtXbjCBUBt5sD9yn16uFAI9Fnu1OZEVJpq1d/3vrOUty91yFXXm6n6
 t1f1DtlS3QRnHQHUk6nCmafB6huoahcr9owLvwJs52LW5IVIedNrjOolPLCHCPWgHC1a
 zJCrJPmzWV1mPHKv7PqqZqmALa1PeIjUParBMnyS7GJrvnGZWh5QbGeL1qGFYVhr7PDO
 PVbv8rteR5i+OTp1f3tWLRxd+dk2waf4hpXNDiF2BbZPeTculWH7RJW3Qqg564VyM6sZ
 1CNxZAfFIEMxyHf9OQmMG3sdCe+dPQi3CiTfz11GQr1W0qbm//w8YmPRZ25WobJuOAUZ
 e64Q==
X-Gm-Message-State: AOJu0YxnrtQLBSfPtuSx8q7mphcy7lKwvpJNR6kKYb0lcyNU4zcujmHt
 GRvWBgguulEw5O4/Pgtol713qcWi5gz0/LPlBC3ONEWXMu/pJ2FEk9oCcj9NWUkxP3+/GaeIQpr
 QoCCwKlFTjLBQ4UlVnvgfu8AUeUwSAqbpxnhNzo9GiuyuLzt+IBc0bm2LWSZNYvdcakYbI8mw2J
 0RPb/m5BozgY/n2t5qrh7anBEnh1D/3urrCw==
X-Gm-Gg: AR+sD11haOUdro0nRa78j7Knfgx3Q4t4gBw271T1tsudB5ABsE5rkv6l5Ij2QPJz17Y
 nzT9MYUl+ZqLA9Be6XsFEtS5JCL+UbC1BwHD9X4ASsjTcQLH8MWGUHWqxTbf6VAtixGuDSpSSEy
 m8pcfTkudKmGpqw0fk5/qaYS2glsY+SQFvRzoqCfi3fV+kvT7T/tjKgr3dHXjykPNAqJHfTaPHL
 NLTjpcFnzthodfWcMiNn8NSoAqKElM3WYGII/gCgMJ/JvEk5f86krgjseswYasXb0KyUK6u1t7D
 gPXDMsh4HlWRin1VPSlKl6wqOmW1DA4M9E8ZGQSQM2i8C4vLhPmVXkAfm1LZe1sKILYIlpRz8sc
 jY/uRDp5WE53IWFlPwJ4bXA==
X-Received: by 2002:a05:6000:2610:b0:47e:4379:a4fd with SMTP id
 ffacd0b85a97d-47f9fc954ffmr7769424f8f.19.1785101392067; 
 Sun, 26 Jul 2026 14:29:52 -0700 (PDT)
X-Received: by 2002:a05:6000:2610:b0:47e:4379:a4fd with SMTP id
 ffacd0b85a97d-47f9fc954ffmr7769397f8f.19.1785101391435; 
 Sun, 26 Jul 2026 14:29:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm43656314f8f.37.2026.07.26.14.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:50 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 20/30] virtio-snd: check rx buffer descriptor size
Message-ID: <13426f6520ab657046efa9c5e547dd5b188348f1.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF78F433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 05:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDFaX-0003U9-F1; Thu, 16 Apr 2026 01:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDFaT-0003Sw-G1
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:48:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDFaR-000177-MB
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:48:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso116479845e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776318502; x=1776923302; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F2jYUyzKmM1Ih+knLVuBivXQ4AWzwy4G2sMPSe8xIm8=;
 b=picWPq9Y6W7sXr/WbLnPVy6Qt3fV1w8v3mUWuWO+hQU4syM3atR8OBS/j6hYKcMPwP
 NV4asLu99uZyrHUHLV2FX0p4cRCeKXhe17vpDfuXN+a03PK0TVOCyeqBHuHXqYfar9Tb
 XjOLMKda2MPjvauGvL3jUnT2Aq2aT7Cble54PZONKOAykUtROixt00+TuSyhx4LXo+rQ
 au36c0nxxHt9SSpOaI4pXECuCHA7pamw3MrlYthSUT03xUd67oDhexiI+BSl3NVXEvRZ
 kAiyYHrN1bMI5V+h7Z11k4BN4tWxK2sl8UxbFVl2c+CoI1/mIGY659TRqUATVMQ4M6A5
 r3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318502; x=1776923302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F2jYUyzKmM1Ih+knLVuBivXQ4AWzwy4G2sMPSe8xIm8=;
 b=flmLaMqW3CfS8OvBniOnAUrz7fNRhrYoxRYPhfhSUVHM/F4+r/7hSOHsBIwOLEJjtQ
 Kv8Stl0uLJaLxHBM2n8kPrvI+CHOlpID4r0E0wjk0HO0Kg6g8/25aywrq9WEW4FSusiB
 KdVwdn7ccYu4shEtRjcicq8VcjyCGDZYcqFn4N/vFm9QeuFm6cV5n8aiHFFXUwH7gvWK
 73uO/WbyzMY2TIoftZ9UWtvhwCWmBKI4EJfU5zP9hdQUB7w96cfVzA+UoRG+Jc5+mQbE
 0byLUz8hX3muZQc2pIHeS/FEmrF3ev059XKsbl7jy5ek23khT1V0IniWd5cu8SUpA96X
 Jugw==
X-Gm-Message-State: AOJu0Yx3ybFiayMPPfTffgwkLKHCa0Tp4wtlspbUeeOeR1jrNbQcQ1fh
 Vb29xjNsxdJVE2BrJew5F56lgfQY3MimRa7TtUQHxww4eYHDbX+bls5e8Fdexn7O2YA=
X-Gm-Gg: AeBDies/OW7oI3Vv8XI8glo1Q1aR5nmpy9XAJ2E5E8sGMkJAIQKPjVj4aU+IRacEIXl
 eZc23GDfHNMkhKX44hDDyXiVNQfRIekY8LoUbXbHC4+HbR1U7EEiQu4wy626Ib90oy5Hkwic1Dg
 yEI+cTY+0PYj84E5vKy2xm6OyRb69QQ8sV5nEdoOsILaLHEujMb1id9m/vwi6OODi/wqO0FjlgE
 RgYu0Q63DVrREbGxBI5pIEhu5JV5NFcRu7IL8XyX+nE0zbsLgLjO+7GQ361CVnHd0zSgjD0swzu
 K/J0TCnY3CSy8lf02HiKu4XfagFRJYWRiMdNs2PuCJmAUlso20q2Ei71m9LntCjBv5+hc8pgWJj
 5NGFFAIFXttDTvBgsEiTBiNXQHFc0gy0ZsimUaQVLL1jkH/k31+vY4AsPNab88+r1xNfQmLhiNl
 MUrE8ZsI2oeQTsbZbQWhqjWVw1gbKVUOlYxklrcgv6gOwAroCqdza4zSiZPc6cCRq3k5epgZXrD
 D/yNaEqH8n4tYjQWk3DXe6drexu4xxzRnzcplD9
X-Received: by 2002:a05:600c:c16d:b0:488:be21:54ae with SMTP id
 5b1f17b1804b1-488d66504bfmr364443315e9.0.1776318501986; 
 Wed, 15 Apr 2026 22:48:21 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818e51sm39201895e9.5.2026.04.15.22.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:48:21 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 16 Apr 2026 08:48:10 +0300
Subject: [PATCH 2/2] virtio-snd: check for overflow before g_malloc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-virtio-fixups-v1-2-ec14e2de0852@linaro.org>
References: <20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org>
In-Reply-To: <20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-stable@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=xDZS3tY6bYSiiCPsg7erlUolIXhnU1SspuDcZfqcF18=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA0SGdpbnlVMURieUVaUC96MUJNL0xsamhLZ25ECjUyNHdIc0NESkFhL2ppNWVn
 d3VKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVCNElnQUt
 DUkIzS2Nkd2YzNEowTVZ4RC85dEd5YlUxVUVSaE5BNWJ2UGJaVEJxYS9tcWM5L3BxVGJDY1REKw
 prQ2xaTFc4VzRvbmU5Nm51K1JzY1Zlc3lTUXFqZTcvVk0xeFkrN2lrUFBwcHhyOHkzeFg0S0JaY
 0I5c3ZhRzJYCnAzZ0l6SWwvU1NtazRFeDRZYjdCSlFHOUpLOGhvVmN3MDk2cWtmL2xqQ3J5VHBn
 Smh2Q1plSWtnMWxmRjdKUnEKWmVYT3V6SUlLNCtHRFl6Q0FvenoyYXhSeEsvcFg1L2JMMk9KYnM
 0VWtQajBXb0xHeFNySnRuYjM1WEJTS3U2ZgpLWGUvNFZ5YzAzZGhWOUxuRFJBeElIOFpQREwwek
 FIbHdZYzc2WkxRUk4relNMTFJaYVR0UDFGOWMvZlFiQVcrCnhLRjhOcVZ2bXF5azh0elIrckxJd
 WRISTNoa0dXWi96S2Z6d2lMRVFOUkdlcDJWeUtXS2tBdld2Ymc0YWhsNGwKa1J5dFdvRzVUUkQx
 a1IxUk5KUVpIcm9HSDZZaVdiaVhpRExzMzg1d29HVGJnZk5SSUx1V29lcWNLNmczYURxbApnMG5
 TcXg1UzUzZjVwdTZLMWJKUkJHa1hqNW9FVldNd1Y5Q3pBT2lRUGxZWXRrRTFDSWY3Wng5VUlMam
 kwOHV3Cm00SkY2ZUUrMXpxckN1bzV5SFJsb0hHMm5KWDJSc3ZDT281Q05iZWEyQ1dkM3VnN2xyd
 0c4dkdBajhYY21rVVEKa3hrNHI2S2t0azVGK3NKRkpYcElSTnQwV3ZKaEJicC8rdWJ2Y2FheGFi
 S3FldVhoU3llYi9jK3kzVkc3b3czNAovdVdqb2JqamVycTlrNlZ0M1FHdm5iV0VYbjkwV3psOFJ
 aUXppRzdGTGtuaU1EaTRlbzhsOWNTelB0endieCtJCmV0UjFZdz09Cj05cDcxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

Coverity points out one g_malloc0 overflow, but it seems to be a false
positive. Add a check to it regardless to fortify the code, and also add
checks for every other g_malloc0 use.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 93fbcfb43f7fdcfd5c164b496015da743822f5eb..a294d267b097249d0171722a5ec131159a5e7027 100644
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
+        if (!g_uint_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
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
+        if (!g_uint_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
+            goto rx_err;
+        }
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;

-- 
2.47.3



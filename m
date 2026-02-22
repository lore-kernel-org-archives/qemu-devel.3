Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20CBC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASI-00086n-Lx; Sun, 22 Feb 2026 09:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARp-0007yp-A1
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARm-0006fu-Fi
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZT1jjcynHlpwnOmhAYl5vZGEqvjYd5WZl8NUZ8Ui4yE=;
 b=jFxi4Tkxfj4L9CSOH43ePGBS/SRR2x7Pz7omAzRjSJxAv41E4DkvoX0HbzrqNL7Cti2GHm
 g/uvhEYnapI5AnFrsGevAFtbHpPsjGqQtEjtg33qGz/q/gxxO4VjrrEfeVo6jiBM/Wmth5
 kXwZQOP2FI+TB9Fk8pBm+6f+/pjv22A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-eywJbfgjMKaVDY3TixESpA-1; Sun, 22 Feb 2026 09:28:32 -0500
X-MC-Unique: eywJbfgjMKaVDY3TixESpA-1
X-Mimecast-MFC-AGG-ID: eywJbfgjMKaVDY3TixESpA_1771770511
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836b7fbf4fso35307805e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770511; x=1772375311; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZT1jjcynHlpwnOmhAYl5vZGEqvjYd5WZl8NUZ8Ui4yE=;
 b=lAi5D7j9a8X9PWNdzpVZ2H1Xd4Tt5akKK1nSmGPGFBs6QvmWW81NHorxMtiefZaMQf
 9Lw/Qjb7AgbmsP3UKkawVlEcMxVCGXoA8APfgwVQLpnpKcRDhRnZbZd0M1RXIbO+AFFA
 qIpj8lFFDYCFTjGdTRNRS2+ZSbKPQNw1diGj80eUWezTmilm3KMvxlVPZncCS7MjNkqz
 05kfO8zTrDDvJxSavmpuIFaI2Q9lIKUC7hD2Nh7y7JmdGwwaX3QYsEyEMZMFBVshVSSv
 0j7c14eBRB4LTnJTPn+ay5dxRre3Xoggrwi239qh6/v8gWEdW8fE4ArxZFEnZG0pFpDW
 O8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770511; x=1772375311;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZT1jjcynHlpwnOmhAYl5vZGEqvjYd5WZl8NUZ8Ui4yE=;
 b=QjGDtSsN0mqJtbYAPkmY40ytVrhkudMocFSsPKeNiU4i/kI0tvNnSyFQoWvMat7rxv
 aJiuoJevY1E9pZvT+wujOyD5SOIg4I2AOn4t8c7Vbfr4yl5xFvo7JuPYS61iBsWDhoWr
 TZRkLDp06KZWSlZQ5JnwXYh0v6YwpYyZdFouIqcqBw6xPRybZhyDe/IADCVe1Txb8olZ
 9RNkrNkm7h3Ig9DN9/9LBkANFSPOVnjMQKCdIbdGFjKCPj/Tg/Ua3ixa3SqQYczQKYSW
 OJb80IGfGSrVfSw9WWRbRQXVEkyNF4qFvaT2POckbINhf6yf5E6T3G3D+KX0AR3LVGw1
 17RA==
X-Gm-Message-State: AOJu0Yz+YYF/yTVAjV+ffhJosEi61nCPjc+qW4C9xbPAMUPKUSwShRZA
 0tKyRNNgim0rYBSnk3ioByHsxN+x5gx11ppjSZpc6Ta3fe3pHuOV8lyVe9YM5v5VBUsHifwJ7Mb
 41nKzHzxyuGnJRN8QxmIupYfYGrq4A1Hi1Xu/lOyYOxVz2DFFe0VfPk7YAqcB9pGA7uvBrjakax
 gxr6ie6CpOm/qUZLW73CEw79L+LcwcTDZaZQ==
X-Gm-Gg: AZuq6aJqtBQmOBqu9POnGLrRePziGGBRpd/6cOYd5mIJF5Ot8SDhL4/5pusCS4Uxlu5
 4amvt8f1zqwP+b5bm9sJYmB+UurW20/4AcSK265n7KzocTw/1TqKfkWhkH1wo0D5ZGr8qDFPmFL
 uUH2xmDSlzlKqBZYqVunIeSxoxkSajUwcmD5tTOLUCD/WxsaOJbPsEfKCJm73BXv7ULAsVjRQEU
 tgjgLuIE4fFAtCrxt/xNGwsMaMUzQ1Eknm0L0VHOm9RHFLVZGvQ5qHwIFMEr8Mxud1YqU90kdcW
 uCsaG80dq/jN0RDISKGBPdTG4x7pfk5Mc2qoo9YMuzBtlwFFK20fwzhAbCGKmXtgVWAgzrDGFe6
 Zzc2i2Z1S9Tkz0TxDayjlkNyxsBlCCXulMA0YGxMaQ7GZSA==
X-Received: by 2002:a05:600c:c8a:b0:47e:e78a:c833 with SMTP id
 5b1f17b1804b1-483a95f8c27mr78576475e9.32.1771770510645; 
 Sun, 22 Feb 2026 06:28:30 -0800 (PST)
X-Received: by 2002:a05:600c:c8a:b0:47e:e78a:c833 with SMTP id
 5b1f17b1804b1-483a95f8c27mr78576215e9.32.1771770510088; 
 Sun, 22 Feb 2026 06:28:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3dfd3d6sm93633665e9.3.2026.02.22.06.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:29 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/33] hw/virtio: Pass VirtIODevice* to virtio_reset()
Message-ID: <843a97fa2c9f42685d714c00a1a812cb886017f5.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

virtio_reset() expects a VirtIODevice pointer, which
is what the single caller - virtio_bus_reset - passes.
Promote the opaque argument to a plain VirtIODevice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260201223929.78790-1-philmd@linaro.org>
---
 hw/virtio/virtio.c         | 3 +--
 include/hw/virtio/virtio.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 77ca54e520..e9d5532952 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3235,9 +3235,8 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
     return ret;
 }
 
-void virtio_reset(void *opaque)
+void virtio_reset(VirtIODevice *vdev)
 {
-    VirtIODevice *vdev = opaque;
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint64_t features[VIRTIO_FEATURES_NU64S];
     int i;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27cd98d2fe..fcaa9b03b4 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -370,7 +370,7 @@ void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
 int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
                                       MemoryRegion *mr, bool assign);
 int virtio_set_status(VirtIODevice *vdev, uint8_t val);
-void virtio_reset(void *opaque);
+void virtio_reset(VirtIODevice *vdev);
 void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_update_irq(VirtIODevice *vdev);
-- 
MST



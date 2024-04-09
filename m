Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB18C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru99O-0001tg-K9; Tue, 09 Apr 2024 06:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru99H-0001c3-MS
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:56:23 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru995-0003C2-52
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:56:17 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e449187fcso3034002a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712660165; x=1713264965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6X/is+z5mVOkZYdPvY4GBR/yTqnpSG/pltprumSeFRE=;
 b=pPXWKsz7IL3u3rwjL5Edr9NebonWc4fRW/JylFnSY+uu3DxkEbTr3MQUk2evi2AIVr
 1VYsVh+Z10NbjxRF6BIA6tgcBM/1Ovl272NgLQk/Fk7/+1DjC6lLxS/D67mHNv10U+3x
 mrSIyj2j0qh970gfST1CMNQqcF7z4xXFD/4SQuCeM/8FRJR5ZXXHgGHefuLFldEmmnid
 EY046JpVnjYlDBWouR/jxj9d1JszVtTqtgJr99OCVtOKreqOnkdSNSPTRuiYPTUsaMqO
 87ImlfIfnK0Gw3s8fKSTsINH4YX3sF1QJ4Oaj9Vn4faAV7PJzObHwwilrMFlSpsLwOu3
 Imqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712660165; x=1713264965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6X/is+z5mVOkZYdPvY4GBR/yTqnpSG/pltprumSeFRE=;
 b=huELxfvbBxIkXcPYiMiMOla5goUU6ujPXckn1Rly2IKbxGHZnq9jOoT2v+mLitia8H
 Kb7eGskmchleL+Swmyszo6d2zTCf+Rw6w2PKCApt4/WtGm3nSWXaukYtDlgcLYEZLr56
 NGHv+RlRR4iGBsIsDN3fKPRuReNrPBV5giBTte6mZmnxq59z0knISjJZbH+4ToN5KxZi
 +HYZUz4exxR3yGQRvIFB31qm50JIlXPWED1NfUQLKpepkd2ruhu2dpF4448lWO4Eh0py
 R70elNfjhk9Am8xFzagoMRzWVjwj+6eoEztYxx7O4i7zcTbDTFTJhgtfIMw1Dds1IN57
 6KZA==
X-Gm-Message-State: AOJu0Yxc+B0F2CPa3uyXLo2dLdZEOFkwMnNAcxZLbb+/f75wG4SsrStR
 qOEHmqeF8B5PujJmUEVx1X3bo+QfZ3ZCcBOuNqTZsIX94fNJ72L3WvJfB/BD7/DId7l8LV82sDJ
 P
X-Google-Smtp-Source: AGHT+IGcFauDh2oj7CDlFa4j3nnpnwtQ9TWRd/JNsJ4zNoqAoE45PuEcnv9w47mvHIvblOsBIuTNNQ==
X-Received: by 2002:a50:bb65:0:b0:56e:34c5:c482 with SMTP id
 y92-20020a50bb65000000b0056e34c5c482mr7134612ede.27.1712660164654; 
 Tue, 09 Apr 2024 03:56:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 a59-20020a509ec1000000b0056bc0c44f02sm5289539edf.96.2024.04.09.03.56.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 03:56:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH-for-9.0 v2 4/4] hw/virtio/virtio-crypto: Protect from DMA
 re-entrancy bugs
Date: Tue,  9 Apr 2024 12:55:37 +0200
Message-ID: <20240409105537.18308-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409105537.18308-1-philmd@linaro.org>
References: <20240409105537.18308-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed.

Fixes: CVE-2024-3446
Cc: qemu-stable@nongnu.org
Suggested-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index fe1313f2ad..bbe8aa4b99 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1080,8 +1080,8 @@ static void virtio_crypto_device_realize(DeviceState *dev, Error **errp)
         vcrypto->vqs[i].dataq =
                  virtio_add_queue(vdev, 1024, virtio_crypto_handle_dataq_bh);
         vcrypto->vqs[i].dataq_bh =
-                 qemu_bh_new_guarded(virtio_crypto_dataq_bh, &vcrypto->vqs[i],
-                                     &dev->mem_reentrancy_guard);
+                 virtio_bh_new_guarded(dev, virtio_crypto_dataq_bh,
+                                       &vcrypto->vqs[i]);
         vcrypto->vqs[i].vcrypto = vcrypto;
     }
 
-- 
2.41.0



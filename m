Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF1DC35FE0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spdjQ-00021o-0S; Sat, 14 Sep 2024 21:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdjL-0001jH-8y
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:07:11 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spdjJ-0004BC-RA
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:07:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2057c6c57b5so20003875ad.1
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726362428; x=1726967228;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kQxCBgxm/ZP4fJCB6KnHjmojyAzDFXk1SCp1ExesX4Y=;
 b=cpzL3AztCvU2enqhlVnGyDshw67BJpJ/79jNcRAR9W6TJNnbvr4BFu1yf7qMQWIzsF
 OS4QEzmAFqtwMVjKlXo+qHA35dhvqyTx8i3bCIxbMJo+SsMa5fAVJpUYvAJtUK7Imvry
 DKbcGlpomT8cjj6ox/fk5oPyBZK53VIwljleJAQkztyepYoWHB4MYsJcOKaunOzl+jKw
 7aj1BAck4aCsFzLiUJHqQS5ripKbb52EBskN2lZn2PzFetSzG2qIHjKVlq48l91K4mwr
 04X1gwWvBK1ywYYRojW3JIGJYWzBCxmQJxsHu5qlyAGybX2Yog1zvPfheMepkX4Q04Kw
 Sr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726362428; x=1726967228;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQxCBgxm/ZP4fJCB6KnHjmojyAzDFXk1SCp1ExesX4Y=;
 b=HcuGwirLguZAYQzZgWKlXRYkCclqOZ3J65f9EmCBfD/CtRrSTD5f5tmGFBX4/AuGeb
 Px1JcEOTnjzM3lPbs/NSh0OSSAGbL4KXMGdvCbpQcRSa+32Zi+cDeXzNbopDpuOf1mf3
 YLYXz+LoamSWfX77Ly/QVrjaGgUm6coV27enOL/IlY8IkTZ/Ou21d82xKYWav0tUmIbZ
 5mAzUONMsqOZnKNVIjDrRZBiuouXOjwppjLefNirDJyIRmVd+E0sNHrAUPPEqylJa9YT
 +/6keZLnBCqPFUOYW1OpiauWji0PHHV6ouxmbytsmHsQMDw+y+W5ws5OFq8RA8vmmCVN
 vF4w==
X-Gm-Message-State: AOJu0Yy/MKYeMveaTEqBNTPz4mhFjTnP4k+L6BbWTLkr92P9+DMY9G3N
 41AMk3hj5avArBWBoKRdQcHgcSax+4mefTbIsexoNZKw52na+tc4LKnLnQItdsy1vnMhs56i9Wk
 NgNs=
X-Google-Smtp-Source: AGHT+IE5KKFfEpJ2xzzxh14vIVXCI4ZOxNxkuiBNxATWFlg3jr0BXvZFV6v5DzGLj3Q1SPriWTyrtA==
X-Received: by 2002:a17:902:d2c8:b0:206:892c:b758 with SMTP id
 d9443c01a7336-2074c5ff323mr250823715ad.13.1726362428486; 
 Sat, 14 Sep 2024 18:07:08 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7db4999f05bsm1765261a12.81.2024.09.14.18.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:07:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:06:45 +0900
Subject: [PATCH 7/7] virtio-net: Fix num_buffers for version 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-queue-v1-7-b49bd49b926d@daynix.com>
References: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
In-Reply-To: <20240915-queue-v1-0-b49bd49b926d@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The specification says the device MUST set num_buffers to 1 if
VIRTIO_NET_F_MRG_RXBUF has not been negotiated.

Fixes: df91055db5c9 ("virtio-net: enable virtio 1.0")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ca4e22344f78..b4a3fb575c7c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1982,6 +1982,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                                     offsetof(typeof(hdr),
                                              virtio_net.hdr.num_buffers),
                                     sizeof(hdr.virtio_net.hdr.num_buffers));
+            } else {
+                hdr.virtio_net.hdr.num_buffers = cpu_to_le16(1);
             }
 
             guest_offset = n->has_vnet_hdr ?

-- 
2.46.0



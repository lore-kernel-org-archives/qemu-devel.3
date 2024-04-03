Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F109CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryWp-0007Sa-09; Wed, 03 Apr 2024 07:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWi-0007Rr-PO
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:32 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWg-0007HP-Nt
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:31 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a2784b2783so1050644a91.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142688; x=1712747488;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v3er1ckfxS8VJoewK2JALUlU7LYlW6SDdjuripGnWgk=;
 b=zTzZfmsiIkhvGg2Vx+BxlVL9ObOo68twroku/0wzX7j2b8j0TCzyKtfHYNh2CAbn6k
 NC5JCuemcmEzR9CsGOVL+DPnhhNxI0n603P7JebYsL4tYd80lBRvOYXU55Z9TmFtIORI
 ln4/IM0cdxiCGSqfNDH35l+Ifw2V2s1RJy2GSWcw+87ga5I7hnPdz5Ds3BtxbX58JlF+
 aQjtobOdJ66rQYxNIvscY8fSUed/eYZ5sdwc5QSwUvU17/cNXbHQjTIc/YT9ARSXHz1Q
 +cjNz68IERL/UQbHLClAmCDow8tXka6kIzqjCjlgf1NRDcEZ8pAUBs971bs5dFUY6sns
 OgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142688; x=1712747488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3er1ckfxS8VJoewK2JALUlU7LYlW6SDdjuripGnWgk=;
 b=U+iognZ1TLTxZn09pFooErCIrBppv+B/6Q+ID94FQGMSr5bYex67dj8R+QJ5EePTSx
 Q5hUT4eimgnSNqiE0Wc+Z/E0lbksZX1ZyH4j0gOlCchpkb9bLU95uBFyOLBaDqA6QiW5
 G/TSInQIc/HfD0VbJ8eeFF5Yg6QWWDy62nQ1sgIfKrssnzG8+oBlKBb7Eg44K4yH2XNW
 IlixVXFYTCHHWgTgRw2eovChwwQO1Cba9PibU36WKmTmr54qCf58kzCf7M9/CL8m98rc
 bOoVjLYdwoh1lnVoiGBT0nyo3jjycKiPmeivltNQGjeMBN4SdzefqZ74ZWgzu2vk3Jsp
 4a/Q==
X-Gm-Message-State: AOJu0YwBAGXWxKZAs6becAPKRFQfE/V8cYfqaOI6SEd+DdGu4Q1SUFu1
 5KS+ib7tyEmGhKk3knstK77XjCmZKEaYgP5q/RPgwapU6H82ZRxK+QN8lmix4vY=
X-Google-Smtp-Source: AGHT+IHRvq3Ui+piFePXh9OkDyG2X1ISH105ocr4xgEEq4ZUn/kS4dE2UUL3GiDdWtMoeaLtJkO+0g==
X-Received: by 2002:a17:90a:5b16:b0:2a0:9c1c:50f4 with SMTP id
 o22-20020a17090a5b1600b002a09c1c50f4mr13304867pji.4.1712142687990; 
 Wed, 03 Apr 2024 04:11:27 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 q36-20020a17090a17a700b002a293a67f53sm1446285pja.29.2024.04.03.04.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:10:56 +0900
Subject: [PATCH v9 08/20] virtio-net: Add only one queue pair when
 realizing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-8-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
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

Multiqueue usage is not negotiated yet when realizing. If more than
one queue is added and the guest never requests to enable multiqueue,
the extra queues will not be deleted when unrealizing and leak.

Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 8ede38aadbbe..e33bdbfd84a5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3759,9 +3759,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
                                     n->net_conf.tx_queue_size);
 
-    for (i = 0; i < n->max_queue_pairs; i++) {
-        virtio_net_add_queue(n, i);
-    }
+    virtio_net_add_queue(n, 0);
 
     n->ctrl_vq = virtio_add_queue(vdev, 64, virtio_net_handle_ctrl);
     qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);

-- 
2.44.0



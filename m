Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F021CC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yXm-0002WN-7O; Sun, 28 Apr 2024 03:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXk-0002Vf-A1
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:48 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXi-0005Tx-8Q
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f3e3d789cdso1649926b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287705; x=1714892505;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xxllqAbYDP7zUXPU0MXdFDfV6gu3m0zIGAyHTf/m3oI=;
 b=KuztX/DvnnRCreJojQBP+9Ejgqx/7x3CfTaAVwxZk9LTmgs0o26qlTVFrXpYUvIrOy
 h3rlJM70aj0iS5csWQ5bOsSVzPmpLy4PODc7amDTJjNconS5cAmrdv1hr0jJQHsAfaF7
 ndrr4vWIQZ6hK7YvZbUM+xkVWionzEWibvo5gRfZL9O3h4RtvFAfAn6+QVSfrKI0pTwV
 Nr204JORDNehMVb6l4H10eQHzIL6CUfuELSUITxgsmpYpwjo4sZ0UuO8ZICasGs0T++z
 rBg1EbijurU7Q0O19BD7GpbUgwYCOZjDx2jT9uBdermRSjcPw3Te/oa/fdXDKGNFm07j
 061Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287705; x=1714892505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxllqAbYDP7zUXPU0MXdFDfV6gu3m0zIGAyHTf/m3oI=;
 b=a+12ZNO7BCM91wWqL8UhyKKV/lwoTMkXM5J9MTdDHHHqWwuVyHtVuogVbUUQdfRDfW
 q9vHjn9BfihUo3mXtoysfSaY2LFbO9VNG+A/AWIiJaROn80AswAsbV7Qa5I/EXimwkNb
 7D/GwBImGfaZ7lF4JjYErXecB8mjock/3Hga25pJkr7+gHLIbbabjB6/aRm/ZOSG33aP
 G/q2EZpMCG2tLUYlfAhulsgA10vQv1sPOMDUKZMOc3mmyFaS9UieKWFONFAd95lfPKR2
 XlCIMSPgVbnHznT9E7NAMjxQ6CHTeG1HUjSYRnLiGiEzFg3YTPuePlvdLpk9bl0PAV2w
 Vbxw==
X-Gm-Message-State: AOJu0Yx/x1uI2HDmL+wj/yDv3gqyosRQOX4TG6Z1JrDGYowDUqMxSxlF
 V/QgPA5726NQLP6JBKR3OWpUQQDNnaSDn/lmDrmX3EudtKJK8WXZRxReleQeut8=
X-Google-Smtp-Source: AGHT+IGpBFyOpBNn+raQW9WJHkTOy9+fYJWLGRhETES7BS7L5bdLbQQ0hiV9XL+vkLNLWj1H2sTEkw==
X-Received: by 2002:a05:6a20:9696:b0:1aa:282e:8dac with SMTP id
 hp22-20020a056a20969600b001aa282e8dacmr9250190pzc.0.1714287704979; 
 Sun, 28 Apr 2024 00:01:44 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 p52-20020a056a0026f400b006ede45680a6sm17212788pfw.59.2024.04.28.00.01.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:01:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:56 +0900
Subject: [PATCH v10 13/18] virtio-net: Always set populate_hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-13-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
In-Reply-To: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

The member is not cleared during reset so may have a stale value.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 61b49e335dea..527aac3a0465 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -651,6 +651,7 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
         n->guest_hdr_len = n->mergeable_rx_bufs ?
             sizeof(struct virtio_net_hdr_mrg_rxbuf) :
             sizeof(struct virtio_net_hdr);
+        n->rss_data.populate_hash = false;
     }
 
     for (i = 0; i < n->max_queue_pairs; i++) {

-- 
2.44.0



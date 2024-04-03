Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B48CD1297
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryXE-0007if-1s; Wed, 03 Apr 2024 07:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryXB-0007iA-SG
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:01 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryX9-0007Ne-0G
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:12:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso634126b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142717; x=1712747517;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4YW7458fOy4xXRrNsgRXqUIuU/Nt7XyxukfmKC665S4=;
 b=pL+V0bqBW+O91ICC/lFXecbuTh4Y2ZMM93qupOlwsixlYVcgcElSwKtOQzwu2Zdtxp
 LnCS/uLqlTVSIIIVsCh0K/Ys6zUyzfzKz8+59teNPp2x79NqMEZRjXDZq+Bobyu+xd4v
 GJKC7P21yvVSY8hoxzbYn0MKxsPk/izkLIQX3InE4Hkckt2MEevdqYe8URDHYnN3uSY+
 gMlxKyaEGdfheFhWG5TaaGl8eWZiSiU4c+uAJXwZtxpB724T/0dCL/IAUdC7ScB9jQmo
 CZI6WVOXNflzRgz92px0ManGnqwUpigvU7fo/CFGBPUUv1gNRUeQAip2ogb/MqJ+sbHi
 Vp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142717; x=1712747517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YW7458fOy4xXRrNsgRXqUIuU/Nt7XyxukfmKC665S4=;
 b=r2QifGSjSdlVi2hTYMtYYy7tcP1muhjCpymDhWtSNri8FEwPFqBztGn3uTFR1nwERS
 UYEgIArp6zH6HZG4O9pN5ci+EC3PL67Q7jFZkQG5yhPl8C+4/KYYq9kowE031i+PNkF5
 xA4xjyGQTdhgBHjzm2MB/rAgxR9e0bf4pPCXeFa8KZtlPcgWWzbWC0C0JuYMKsKfkT9l
 tsNGH0fZshXji2aEyHPIpUeHS5QyPZhuJYUQngMPtlNDIZubxTmOtVoXwzQPUGgfrsjX
 L7NgYAxF/q2TO+cHq/NMVt4xARLtKuEi+56QRQfzhJFm/Eg05QWlUya6sJBlKajSB+Z0
 Xwpg==
X-Gm-Message-State: AOJu0YxfUB5pgzfmh9QB+dEKE2UI53r7806STDIznDHKNPFtwWbStRsH
 N7G+ij4+Wi6F3AO8XsHXE8pVPAa3y7Z8U52qCItTLLNe+vg46DDWTY2kKy09fsU=
X-Google-Smtp-Source: AGHT+IHfzFGa/LTr729ZSQqyz8vrSwAI3M/jXnC2CQFQmJyHhG7owUGHQkSTDOzyvqHeM9pNBNhkpQ==
X-Received: by 2002:a05:6a20:3d03:b0:1a3:b05a:52a5 with SMTP id
 y3-20020a056a203d0300b001a3b05a52a5mr2672031pzi.20.1712142716834; 
 Wed, 03 Apr 2024 04:11:56 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 g1-20020a6544c1000000b005f034b4d123sm9926865pgs.24.2024.04.03.04.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:11:03 +0900
Subject: [PATCH v9 15/20] virtio-net: Always set populate_hash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-15-c6d87e69d38b@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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
index 86929c9e1fad..2de073ce18fd 100644
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



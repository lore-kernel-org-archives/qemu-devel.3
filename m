Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E966CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryWO-0007Mi-91; Wed, 03 Apr 2024 07:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWM-0007M1-P1
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWK-0007Eo-MP
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:10 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ead4093f85so5847698b3a.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142667; x=1712747467;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NVxS/Oa2xUVoG+uaYS6v5q8VYD7ItUUL4UEknvVPtgA=;
 b=f77gez5JLqIFd015RcK7YGjTm65YyIF267fwZ9ZnlSRwVuQLtQlO2dE1lg5XUhCs21
 6oP0Lkd2LcL8En7uTywuRHh/bHfzJCtHBj5wwAaHiwtVAx5Ebr9o6vzpG5xVBX2c8XJm
 P3+mwjfexGNKGIpmX61yXkPRBQbJQgY5eihC4zzUsdCmfvYKUSc8a4B1ZBlxenuI9RS1
 ZCMezE7jRHuld+Dl9ZV4mcnyT3zmieQl0tlINNa0F+youPY/LZKne+OG8Asvx0DQRSvK
 jFolAX0w0euOO5In0S4bjKFJrXRrmx9zYttFe2pYoED8snEyMxHzAmmtQEI+Gg8PvJig
 UkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142667; x=1712747467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVxS/Oa2xUVoG+uaYS6v5q8VYD7ItUUL4UEknvVPtgA=;
 b=BIsOT5ro9S6QI9Lc3xDAiEtlzIPi3/5lEDgjBSNJC4v1NPnb0nESOFX+1rGTVciDU6
 aDAgo/SJwgVIcwsUx9yLWwrWW/1skH0s9vkVzsTTrRqtHdogWcw0KiBNOs+L/9ryx41X
 /cV45anNON0KmWhZdxWKOpjwMNLUe9kfbd1OSGx1a+3HWG7LvH/MbAwwZrYeA0zUhhKJ
 kRRfO/TSFFmUrhNJdA4mmhsJVyRXCWpJ7btMT9v8ATFh3/xQKaS6t6xhoHzQ6trFTEhw
 bISujHROf7sTM579nkyLPVT5zmifLfxLaT0vW5pOeQtuXhUghxd4m9vyfVgFBUtC+CEW
 tAfQ==
X-Gm-Message-State: AOJu0YzGPz65wwWRJkvq+lojO7TW9VRkgx/nwzHoxj0rQRCuOHujOECj
 prQ6RuyTtDQxrSbNhUL79HBbarKMNzSeczEuctjZfHhIZuXCUYhpPkHkSKtxRng=
X-Google-Smtp-Source: AGHT+IH43Kt0i09hHU0s1FKrMQaGb97643mZiKLH1VZ70lrPjwF47Jojn0vjaPtRwQv85Im0irRHRw==
X-Received: by 2002:a05:6a20:85a7:b0:1a3:67cb:f7c4 with SMTP id
 s39-20020a056a2085a700b001a367cbf7c4mr10694389pzd.34.1712142667422; 
 Wed, 03 Apr 2024 04:11:07 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 r1-20020aa78441000000b006e69a142458sm11425541pfn.213.2024.04.03.04.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:10:51 +0900
Subject: [PATCH v9 03/20] net: Move virtio-net header length assertion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-3-c6d87e69d38b@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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

The virtio-net header length assertion should happen for any clients.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/net.c | 5 +++++
 net/tap.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index bd51037ebfb0..db096765f4b2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -56,6 +56,7 @@
 #include "net/filter.h"
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
+#include "standard-headers/linux/virtio_net.h"
 
 /* Net bridge is currently not supported for W32. */
 #if !defined(_WIN32)
@@ -550,6 +551,10 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
         return;
     }
 
+    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
+           len == sizeof(struct virtio_net_hdr) ||
+           len == sizeof(struct virtio_net_hdr_v1_hash));
+
     nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
 }
diff --git a/net/tap.c b/net/tap.c
index c848844955df..49edf6c2b6e1 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -267,9 +267,6 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-    assert(len == sizeof(struct virtio_net_hdr_mrg_rxbuf) ||
-           len == sizeof(struct virtio_net_hdr) ||
-           len == sizeof(struct virtio_net_hdr_v1_hash));
 
     tap_fd_set_vnet_hdr_len(s->fd, len);
     s->host_vnet_hdr_len = len;

-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8FBC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yX8-0002N9-Od; Sun, 28 Apr 2024 03:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yX5-0002LD-4T
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:07 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yX3-0005NG-40
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:01:06 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso2045878a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287664; x=1714892464;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NVxS/Oa2xUVoG+uaYS6v5q8VYD7ItUUL4UEknvVPtgA=;
 b=07TB6WL9lwwuzbFnUcmn0x872bseqVgdsZDiG+mK+HCTUVPlXWAEPAnE8YMfAHbAeB
 zsh3sPw0DOOjLsKVx2yYrvcaX5qTkd9rRclhw13RI5WEIhkVld+MWtL0Epdl1mOCoNcA
 bS41C8do5xDRCkAVv6ZGEX8/+i36CKVz81okggLFuw1crFvxmsWwLe9j97wQF7venU6g
 60p91iW40hMKoQbHp7qoRmMeGnBzmO+hl46VeXo6RmElEbGpfXx8D2RHskLCzzaj3JvY
 FgBm7BjA1WKhVLmWpwbYSQj11eU0x6jrNoL72QKH0zvhHfAe6mAZEpx5837i1Y+9Ft2L
 Fk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287664; x=1714892464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVxS/Oa2xUVoG+uaYS6v5q8VYD7ItUUL4UEknvVPtgA=;
 b=kqSD6SGiKnFcBS79gAcsTiBYkMUlDXqQGrsYUvZEtbAq2FkKDspCInDslMjiLvHcFr
 DG9vokU8KNQLrGtpTqSR+cWz08681YXhZ5GEg3pjCnCYhPSvV7/FxoWxfMogs3ehdwHq
 N04awn5RZ84egG2BFgYU2A+wrjmH/zT7HvF3CEVre0ftdujuOkAFFx7KHpKLz9i0SgyU
 n8+Y1KWHUOXb83PS0W4pLWAyh2gQlHWwUy/Hd+DCQoQDVu+f+13itmYwAdOPARDb82ol
 tME4gAcUEsu/QRz/xfWnVmhg/ix1loFp1kxqXxx+KPHEb/5PJiIs6xHIGPnLougZgEWh
 IWtw==
X-Gm-Message-State: AOJu0YzjBis1ewNxpbJtUk+87/eKbr2cS8F1UWWrZOfRJylNYeOg/xqD
 FucdWhkVvVjgxlTEzH+xRqyyVay/UAamKwHEycdpCLRZnnScdi0cWu/QJOsggEA=
X-Google-Smtp-Source: AGHT+IEBFxqMQeneBSo1O7t8i5mgpDvgtoGipVwaF622u8BrBfRj923G1L+oYGvbvACmWinUt588ZA==
X-Received: by 2002:a17:902:ce8e:b0:1eb:5323:c320 with SMTP id
 f14-20020a170902ce8e00b001eb5323c320mr5426479plg.56.1714287663884; 
 Sun, 28 Apr 2024 00:01:03 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 c7-20020a170903234700b001eb0dd08e40sm3701361plh.133.2024.04.28.00.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:01:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:46 +0900
Subject: [PATCH v10 03/18] net: Move virtio-net header length assertion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-3-73cbaa91aeb6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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



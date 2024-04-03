Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95CECD1294
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryWS-0007OS-9P; Wed, 03 Apr 2024 07:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWQ-0007Nd-0Y
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:14 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWO-0007FK-CO
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e293335cdeso4193615ad.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142671; x=1712747471;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L2AYryVCXzlfd31eRzritJUeblvvcZ9uKewPEGgWmv8=;
 b=XXSRZHsDOnXZ/qMisl/5IrjHtzJSp7gCBed05wOMITY9fWHb8cl99ppKgnLNae+ide
 l9Maf+a6tX6RdjZo0FeLEMBNfLuFT464oVrYCc3aEOPEHng7t8J9EToHzoaubxVEkxNM
 09sO//Jq0E3igp8F50sLI+zDFhbjjzKzu0JLSdKXMUDvfZAvtQ52ecBwTZ+RsiveNy+Z
 ub+YC9B+VWklY5zJOtcbJPLIDHiz0isJnPt+XNoYb3LUguSkuUCBjL/tmPp2w1lsfmpQ
 l5xoKEnXeV5ebL8o7ILiqVVj5giio0dyZuIIorpesc4Rgr1zrH6Pcvg1waxl0dScBOfy
 NGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142671; x=1712747471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2AYryVCXzlfd31eRzritJUeblvvcZ9uKewPEGgWmv8=;
 b=oWNYJ0CeNvYcfil9p+cfFrknO6nqVXT1ByjZnh5IL5G+77XDMQt5DWY1E9197i5s0o
 AZBRbXGNBFBx5ysKcb9lTHGkipv4ntMkseUUt5YbUAO8oY+6Wmq35i2frtedUv960toG
 U2MSneLSydP9Fxbaaz/ntzW9jU5eVnjjliPb6VDJRW9jf2cPSg40j5TNESnFCenmrj6f
 SXkI52oGkbDy19L60VhPXrjDWQYY3ntuhTymTGtwO8qw2gcjhoRG/46pY66Tri9WWQwb
 WDpnCepmB8ChwHZQm/5xuaw66CK0sRWFRMBorsiiEo+GwKlty3UpY3pTgvrESVHjoDhi
 QPUA==
X-Gm-Message-State: AOJu0Yz/n4M+bksmf99BE6YavrDTcgLzgrxE/FzjF636bXqdGxeTkm/b
 H0Ek40Iagupu+/RtnSOhBUxLa0bF0pGVgYk/1A2dbYf3gm3eDm0HrIKEgW+hr6I=
X-Google-Smtp-Source: AGHT+IHx1SdkH+vDRXpVNRbLlcQiT8jDklMYJI6YNc14dMu0Wi7H0bRQ3PIbIZ2eH19huL9NqHTSqg==
X-Received: by 2002:a17:902:c40c:b0:1e0:bc33:d with SMTP id
 k12-20020a170902c40c00b001e0bc33000dmr20691232plk.31.1712142671226; 
 Wed, 03 Apr 2024 04:11:11 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 x15-20020a170902ec8f00b001dc9422891esm12860688plg.30.2024.04.03.04.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:10:52 +0900
Subject: [PATCH v9 04/20] net: Remove receive_raw()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-4-c6d87e69d38b@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

While netmap implements virtio-net header, it does not implement
receive_raw(). Instead of implementing receive_raw for netmap, add
virtio-net headers in the common code and use receive_iov()/receive()
instead. This also fixes the buffer size for the virtio-net header.

Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h |  1 -
 net/net.c         | 18 ++++++++++++------
 net/tap.c         |  1 -
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 6fe5a0aee833..c8f679761bf9 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -72,7 +72,6 @@ typedef struct NetClientInfo {
     NetClientDriver type;
     size_t size;
     NetReceive *receive;
-    NetReceive *receive_raw;
     NetReceiveIOV *receive_iov;
     NetCanReceive *can_receive;
     NetStart *start;
diff --git a/net/net.c b/net/net.c
index db096765f4b2..6938da05e077 100644
--- a/net/net.c
+++ b/net/net.c
@@ -787,11 +787,7 @@ static ssize_t nc_sendv_compat(NetClientState *nc, const struct iovec *iov,
         offset = iov_to_buf(iov, iovcnt, 0, buf, offset);
     }
 
-    if (flags & QEMU_NET_PACKET_FLAG_RAW && nc->info->receive_raw) {
-        ret = nc->info->receive_raw(nc, buffer, offset);
-    } else {
-        ret = nc->info->receive(nc, buffer, offset);
-    }
+    ret = nc->info->receive(nc, buffer, offset);
 
     g_free(buf);
     return ret;
@@ -806,6 +802,8 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
     MemReentrancyGuard *owned_reentrancy_guard;
     NetClientState *nc = opaque;
     int ret;
+    struct virtio_net_hdr_v1_hash vnet_hdr = { };
+    g_autofree struct iovec *iov_copy = NULL;
 
 
     if (nc->link_down) {
@@ -824,7 +822,15 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
         owned_reentrancy_guard->engaged_in_io = true;
     }
 
-    if (nc->info->receive_iov && !(flags & QEMU_NET_PACKET_FLAG_RAW)) {
+    if ((flags & QEMU_NET_PACKET_FLAG_RAW) && nc->vnet_hdr_len) {
+        iov_copy = g_new(struct iovec, iovcnt + 1);
+        iov_copy[0].iov_base = &vnet_hdr;
+        iov_copy[0].iov_len =  nc->vnet_hdr_len;
+        memcpy(&iov_copy[1], iov, iovcnt * sizeof(*iov));
+        iov = iov_copy;
+    }
+
+    if (nc->info->receive_iov) {
         ret = nc->info->receive_iov(nc, iov, iovcnt);
     } else {
         ret = nc_sendv_compat(nc, iov, iovcnt, flags);
diff --git a/net/tap.c b/net/tap.c
index 49edf6c2b6e1..99c59ee46881 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -360,7 +360,6 @@ static NetClientInfo net_tap_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
     .receive = tap_receive,
-    .receive_raw = tap_receive_raw,
     .receive_iov = tap_receive_iov,
     .poll = tap_poll,
     .cleanup = tap_cleanup,

-- 
2.44.0



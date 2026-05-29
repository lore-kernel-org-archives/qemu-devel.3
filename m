Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AD8CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIi-00069W-Vy; Fri, 29 May 2026 00:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIf-00068e-Mv
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpId-0008Cc-8L
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsbGh2yBIgo+8c7UjJ+EVhQzHmVPcUlEdc82aHULM4Q=;
 b=OHK9Bpr4NygyRqIiu1kHAtyCknOT6XVgOd3EBc4Vr/qRp9x8Nj49DLO5RwuFb/2eAu6mVV
 6lUOdhRs3Mmyb71duCl2lv53RV7aPiuHCgBowrKG11JBpqnIFV3vBDT9Dk6jnEEDlbr7uZ
 TL9BKJ6lhXvQkVlVDZq4JlYSFOQV3ak=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-DMFVDu7ZOyatLMoxHZdqBw-1; Fri, 29 May 2026 00:58:20 -0400
X-MC-Unique: DMFVDu7ZOyatLMoxHZdqBw-1
X-Mimecast-MFC-AGG-ID: DMFVDu7ZOyatLMoxHZdqBw_1780030699
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f1820babso59992eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030699; x=1780635499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsbGh2yBIgo+8c7UjJ+EVhQzHmVPcUlEdc82aHULM4Q=;
 b=etxO7bPRc1GIHrVGdchv2O1CRl1yxFglOboRB1zC2/zZjY+QSrSZ4i7fJJvbcDr634
 Gy7L6nsNqaeq1l0TvGMKFLpTt1W/0WQRGk6saH/0t0/uSoVNpJKJ1IjzUhzp/8Js3eqG
 CU6+4Jdl1miKmEP/PbN8hxzpwnxzZsDD4fDSo5hyUS6XJMENpFC+EfQE03fbEcIkif/0
 D+fzWxZLDy7Bm8whtjeXvuLQs6mTWGUZsXlOqT0mZPepVooziPo7xbpeedtA4vmyix73
 mxqyqzYcoFrQrAeccDysR7SnI7sRZ//69iXVFTz3wJtlIc5f7EYsbvLOlyleQUHZBwSP
 0Ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030699; x=1780635499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dsbGh2yBIgo+8c7UjJ+EVhQzHmVPcUlEdc82aHULM4Q=;
 b=SeHIxBjOaw/JppCzSA2N2J0elRRRgQ3xHONrN7Fd2C3z41qTgi6j5AqI9hZA7nY4Kd
 7l2Xy3vDShgNXVFTI+v140ZANruHBTey/vu71AN6KdTF3wEXeCZVlJUj/FDuHpaXEc7/
 h8oYYiZN88d+m6UkD+tgiym0gglbQsTdTTTrzN3ik2iZrmn7qxEr9nFaen27FqmSRup9
 CFNFkUGYq0XWBCDrJn49GkeUmyXeuZBoXUz1/9rjgNuRNTw6zdID65kNffAJyercnRhG
 FARmdGSA2u3Pr3BstTB1yN9pOFpSN8fZioI9wiuk+qCUSC8wA2k/RptdQGgLv9Ew8miW
 qmOg==
X-Gm-Message-State: AOJu0YxWNy0LMUAQoIef2q5xLoxpBNIpHAdhFYOJ5+y9gRds7W9Rcg9D
 iJ9XZt3pRVJNaXk/BzTcvMiWBjWoTb94jGpBHsCESwNH/4aMNA1yIhDvhK8jF3ilxh9h5orxhDJ
 lmZeoHAYg4jnM1oIMwqISbScm5WvUbW46Axfn1shKMFSQWDp+bsckag36OnjFO/6eiP0Y/7sxei
 V5uq3pb081Bxrmwhghi1YJceHB+ySlbTepYlO7BI5G0kU=
X-Gm-Gg: Acq92OEYI7XF0KeYWz8/7DwrxsJkbpSR9CxVzN99ZtzxsXs4sk1gxL4hVa5IOQVShsi
 ZGhyotKHc8DbA/Zv+rE/ms2ewfZHyhxQUzdDWHNb4VsE30PoexskQmgmSSKhPmdHEY9B4sw9hWH
 I3NZ8TMmwa4xPuuvIwmVQX3kCxv5UKfxSbcRimhgbuthd+6/eBXTTAWI3gb0snSPkELnFGlyzah
 g63fkHeFXQ7xYgfZ8dv/IL1Ttz6FoMJ10v+PeV7Y7jUpZXcTI9OLVHjzwIZPw1lNgqB9VYfA0JW
 +u8GOa+9C3RD1DzXkjoO6be9+SilYiUq+1YosgMftCdEVAmSlJmP/YMEoxHt//7zhepXS1o9q7r
 v1MfZjICUpeQ4N/4WyoRrXy14NDfAKE5uL+69dJdj8aWf9vUH1HOe6S4D0JSvV6gFQnP0hAil
X-Received: by 2002:a05:7300:430a:b0:304:dfb2:2274 with SMTP id
 5a478bee46e88-304eb0f8becmr667872eec.28.1780030698983; 
 Thu, 28 May 2026 21:58:18 -0700 (PDT)
X-Received: by 2002:a05:7300:430a:b0:304:dfb2:2274 with SMTP id
 5a478bee46e88-304eb0f8becmr667853eec.28.1780030698312; 
 Thu, 28 May 2026 21:58:18 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.58.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:17 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 10/15] net/tap: fix vhostfds/vhostfd parameters API
Date: Fri, 29 May 2026 12:57:25 +0800
Message-ID: <20260529045730.90322-11-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

There is a bug in the interface: we don't allow vhostfds argument
together with queues. But we allow vhostfd, and try use it for all
queues of multiqueue TAP.

Let's relax the restriction. We already check that number of vhost fds
match queues (or number of fds). So, no matter do vhost fds come from
vhostfds or vhostfd argument. Let's use correct vhost fds for multiqueue
TAP.

To achieve this we move vhost fds parsing to separate function and call
it earlier in net_init_tap(). Then we have vhost fds available (and
already checked) for all further cases.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 63 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index b794f80e34..d5a719150b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -836,11 +836,32 @@ static int tap_parse_fds_and_queues(const NetdevTapOptions *tap, int **fds,
     return queues;
 }
 
+static bool tap_parse_vhost_fds(const NetdevTapOptions *tap, int **vhost_fds,
+                                int queues, Error **errp)
+{
+    if (!(tap->vhostfd || tap->vhostfds)) {
+        *vhost_fds = NULL;
+        return true;
+    }
+
+    if (net_parse_fds(tap->vhostfd ?: tap->vhostfds,
+                      vhost_fds, queues, errp) < 0) {
+        return false;
+    }
+
+    if (!unblock_fds(*vhost_fds, queues, errp)) {
+        net_free_fds(*vhost_fds, queues);
+        return false;
+    }
+
+    return true;
+}
+
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
     const NetdevTapOptions *tap;
-    int fd = -1, vhostfd = -1, vnet_hdr = 0, i = 0, queues;
+    int fd = -1, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
     char ifname[128];
     int *fds = NULL, *vhost_fds = NULL;
@@ -873,30 +894,13 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    if (tap->vhostfds && !tap->fds) {
-        error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
-        return -1;
-    }
-
-    if (tap->vhostfd && tap->fds) {
-        error_setg(errp, "vhostfd= is invalid with fds=");
-        return -1;
-    }
-
     queues = tap_parse_fds_and_queues(tap, &fds, errp);
     if (queues < 0) {
         return -1;
     }
 
-    if (tap->vhostfd) {
-        vhostfd = monitor_fd_param(monitor_cur(), tap->vhostfd, errp);
-        if (vhostfd == -1) {
-            goto fail;
-        }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto fail;
-        }
+    if (!tap_parse_vhost_fds(tap, &vhost_fds, queues, errp)) {
+        goto fail;
     }
 
     if (tap->fd) {
@@ -907,20 +911,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         if (!net_init_tap_one(tap, peer, name, NULL,
                               NULL, NULL,
-                              vhostfd, vnet_hdr, fds[0], errp)) {
+                              vhost_fds ? vhost_fds[0] : -1,
+                              vnet_hdr, fds[0], errp)) {
             goto fail;
         }
     } else if (tap->fds) {
-        if (tap->vhostfds && net_parse_fds(tap->vhostfds, &vhost_fds,
-                                           queues, errp) < 0) {
-            goto fail;
-        }
-
         for (i = 0; i < queues; i++) {
-            if (vhost_fds && !qemu_set_blocking(vhost_fds[i], false, errp)) {
-                goto fail;
-            }
-
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fds[i], errp);
                 if (vnet_hdr < 0) {
@@ -946,7 +942,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         if (!net_init_tap_one(tap, peer, name, ifname,
-                              NULL, NULL, vhostfd,
+                              NULL, NULL,
+                              vhost_fds ? vhost_fds[0] : -1,
                               vnet_hdr, fds[0], errp)) {
             goto fail;
         }
@@ -979,7 +976,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             if (!net_init_tap_one(tap, peer, name, ifname,
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
-                                  vhostfd, vnet_hdr, fd, errp)) {
+                                  vhost_fds ? vhost_fds[i] : -1,
+                                  vnet_hdr, fd, errp)) {
                 goto fail;
             }
         }
@@ -989,7 +987,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
 fail:
     close(fd);
-    close(vhostfd);
     net_free_fds(fds, queues);
     net_free_fds(vhost_fds, queues);
     return -1;
-- 
2.54.0



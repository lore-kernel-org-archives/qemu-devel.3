Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06556CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIf-00068R-IW; Fri, 29 May 2026 00:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpId-00066B-Fz
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIY-00089z-QG
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XsdnJ8QU8/mkgWQMKrIoYbBA3H/ZLUxSs+Qt+5roZpU=;
 b=IXK1SrGXIBN+6hBPZVvq11w1cGfoQas+dnS8xnhe7SDA876oUPnFqf68wzDNh4jCOz5VWJ
 uFV7HOzXeblXsIlVt25csQN1s939tuiJY4WcA0sVhol6Q6I5ec+Lnug8NcUN5MEu9ce4hR
 eL4xgLq1WT/OCrNL1DeBYk3jaLcqZ/8=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-IiTcB876MeGqEEMCP8_kbA-1; Fri, 29 May 2026 00:58:16 -0400
X-MC-Unique: IiTcB876MeGqEEMCP8_kbA-1
X-Mimecast-MFC-AGG-ID: IiTcB876MeGqEEMCP8_kbA_1780030695
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so3940239eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030695; x=1780635495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsdnJ8QU8/mkgWQMKrIoYbBA3H/ZLUxSs+Qt+5roZpU=;
 b=cuixQJAiUlp4UqP0VyeNhiXtdJ3/EGxb6kbfuvn41lu42SklSSbesuTjnVbMtUjFYh
 /IqzMjUGFGojJ8B1uv2qH3UuieVdSsKYJ8ixNdw3yCiOzZjk/0KF5VtJgelxUIh/jjaA
 6fqIMP+ESfWj8yeayDvlyccVUaerbrbVs/ryg5ED8ph2jRZVoOstLIwsyWniqtTjSsER
 HbaU1levNW2MZUNcqP1UYWk4kW397fG/v5YWYdIahoropio/T8vUjjG+SBzLofLdihVN
 XOnRsTiH5vpQHWkzRvP8ovXRVI5sH+g/zGPQElJiPRF/3l5m3sK6UHWl2LjKhrTMp3r+
 BHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030695; x=1780635495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XsdnJ8QU8/mkgWQMKrIoYbBA3H/ZLUxSs+Qt+5roZpU=;
 b=Pnd8Ox94cGbfycMMt+63xVgillQ6v6nFXRRf+mfwNOk1dB621gn1eIGaZy5Z+mKprS
 Zf2G5/YxejfFs5bcpAyqhh7UelvjNfbsYe67aFOiV4cUpr9EkFx1Tl9TaazVrS9n08DM
 nqmwF6LApqYHkC8klJK070BcI1+DuHE/1EzPWmQosupipFuv7VHsCcMb2gMcYcnqC/fL
 s+TKvI9CDWyKugc0439uvfTYtk9MeWM2TXjRGCwbfQy566lMqBGv7yW6j7JIcdVnHrdS
 isR8bD2cOMEqvlPNif3mjgnjl5eF7fl4p9xW1h+tbpgSomWn1sJDQZU5xkS3TDxAI5PP
 xw6Q==
X-Gm-Message-State: AOJu0Yz3PhmU+1wS1jZjnYNWN/s7f8bCN0T+3xGPXMCpqPY8UA7xaT2h
 mK5ibILt9f5sPEev3E38VUA1du+vbOIhsB8cIEbzXoxNsLUIcAsGg+G+JOyE1QTQC042UyvEeuv
 G/mkAB6QXvPOYo4xphC4N/tpNGGuJKOk04zE6uwpbcf/WU79OcDRkcQlV7f2wlPT1W5yuCLxObQ
 av2wQdekLIzWHyPVoeneKA3eAcMOpqeAGXHM9e40g4ZEA=
X-Gm-Gg: Acq92OGNv7I4Ingx50Qc91muRpbYHGM2eMUZ1WfbCMAbd/ejebgGc4nDFEqm/9/vJPW
 P6Z9CgdHVKvi5nECwSnM1wqcHYwsAdhHNvyBQ2bA7XlmMZq9i7O9QJmtXZq/RM6n86NTeEiyoaN
 YkT9TXlu1srLGnk8WrX0Tmklk+uH4TRZKDmVXTXzSn1A3aIeZOWzMQKZCsFy/tVhi/qgPm/QJfH
 aNZGypwlXHZ+lxd4s/H3S3TywQfcMHY3PlPax0AxNH8Rwb4V8wPvKf8ouiZ719Ft3Hh92Oib2Yo
 xOFzE9BHYxtil45kUg91lXSvfcqlr7XQ6jN2jjMmV6ii42t7pvjp+4B87328xGxW3SwT5knhtzQ
 gnOM+PxLd/O5QbwWqBgrNUsRZOPiW7SH6QRBXEDHLGvIn2Ce6pkMgnzrTdtWw5V6nnGGBazkp
X-Received: by 2002:a05:7300:dc88:b0:2ea:4228:ab11 with SMTP id
 5a478bee46e88-304eb05fc0amr739165eec.3.1780030694707; 
 Thu, 28 May 2026 21:58:14 -0700 (PDT)
X-Received: by 2002:a05:7300:dc88:b0:2ea:4228:ab11 with SMTP id
 5a478bee46e88-304eb05fc0amr739149eec.3.1780030694048; 
 Thu, 28 May 2026 21:58:14 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.58.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:13 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 09/15] net/tap: move fds parameters handling to separate
 functions
Date: Fri, 29 May 2026 12:57:24 +0800
Message-ID: <20260529045730.90322-10-jasowang@redhat.com>
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

This significantly simplify the code in net_init_tap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 99 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 34 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2d4630c350..b794f80e34 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -781,6 +781,61 @@ failed:
     return false;
 }
 
+static bool unblock_fds(int *fds, int nfds, Error **errp)
+{
+    for (int i = 0; i < nfds; i++) {
+        if (!qemu_set_blocking(fds[i], false, errp)) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static int tap_parse_fds_and_queues(const NetdevTapOptions *tap, int **fds,
+                                    Error **errp)
+{
+    int queues = 1;
+
+    if (tap->has_queues + !!tap->helper + !!tap->fds + !!tap->fd > 1) {
+        error_setg(errp, "queues=, helper=, fds= and fd= are mutual exclusive");
+        return -1;
+    }
+
+    if (tap->has_queues) {
+        if (tap->queues > INT_MAX) {
+            error_setg(errp, "queues exceeds maximum %d", INT_MAX);
+            return -1;
+        }
+        queues = tap->queues;
+        *fds = NULL;
+    } else if (tap->fd || tap->fds) {
+        queues = net_parse_fds(tap->fd ?: tap->fds, fds,
+                               tap->fd ? 1 : 0, errp);
+        if (!*fds) {
+            return -1;
+        }
+    } else if (tap->helper) {
+        int fd = net_bridge_run_helper(tap->helper,
+                                       tap->br ?: DEFAULT_BRIDGE_INTERFACE,
+                                       errp);
+        if (fd < 0) {
+            return -1;
+        }
+
+        queues = 1;
+        *fds = g_new(int, 1);
+        **fds = fd;
+    }
+
+    if (*fds && !unblock_fds(*fds, queues, errp)) {
+        net_free_fds(*fds, queues);
+        return -1;
+    }
+
+    return queues;
+}
+
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
@@ -792,7 +847,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
-    queues = tap->has_queues ? tap->queues : 1;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -829,10 +883,15 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    queues = tap_parse_fds_and_queues(tap, &fds, errp);
+    if (queues < 0) {
+        return -1;
+    }
+
     if (tap->vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), tap->vhostfd, errp);
         if (vhostfd == -1) {
-            return -1;
+            goto fail;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
@@ -841,41 +900,23 @@ int net_init_tap(const Netdev *netdev, const char *name,
     }
 
     if (tap->fd) {
-        fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
-        if (fd == -1) {
-            goto fail;
-        }
-
-        if (!qemu_set_blocking(fd, false, errp)) {
-            goto fail;
-        }
-
-        vnet_hdr = tap_probe_vnet_hdr(fd, errp);
+        vnet_hdr = tap_probe_vnet_hdr(fds[0], errp);
         if (vnet_hdr < 0) {
             goto fail;
         }
 
         if (!net_init_tap_one(tap, peer, name, NULL,
                               NULL, NULL,
-                              vhostfd, vnet_hdr, fd, errp)) {
+                              vhostfd, vnet_hdr, fds[0], errp)) {
             goto fail;
         }
     } else if (tap->fds) {
-        queues = net_parse_fds(tap->fds, &fds, 0, errp);
-        if (queues < 0) {
-            goto fail;
-        }
-
         if (tap->vhostfds && net_parse_fds(tap->vhostfds, &vhost_fds,
                                            queues, errp) < 0) {
             goto fail;
         }
 
         for (i = 0; i < queues; i++) {
-            if (!qemu_set_blocking(fds[i], false, errp)) {
-                goto fail;
-            }
-
             if (vhost_fds && !qemu_set_blocking(vhost_fds[i], false, errp)) {
                 goto fail;
             }
@@ -899,24 +940,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
             }
         }
     } else if (tap->helper) {
-        fd = net_bridge_run_helper(tap->helper,
-                                   tap->br ?: DEFAULT_BRIDGE_INTERFACE,
-                                   errp);
-        if (fd == -1) {
-            goto fail;
-        }
-
-        if (!qemu_set_blocking(fd, false, errp)) {
-            goto fail;
-        }
-        vnet_hdr = tap_probe_vnet_hdr(fd, errp);
+        vnet_hdr = tap_probe_vnet_hdr(fds[0], errp);
         if (vnet_hdr < 0) {
             goto fail;
         }
 
         if (!net_init_tap_one(tap, peer, name, ifname,
                               NULL, NULL, vhostfd,
-                              vnet_hdr, fd, errp)) {
+                              vnet_hdr, fds[0], errp)) {
             goto fail;
         }
     } else {
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A011CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vs-0001Vi-Cg; Mon, 18 Aug 2025 10:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vo-0001M3-7U
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:07:00 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vm-0002D0-Ca
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0F404807D4;
 Mon, 18 Aug 2025 17:06:53 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-5EGxGFFS; Mon, 18 Aug 2025 17:06:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526012;
 bh=9wuLPwnwcSfjr1aFoafDNTap3QiKA6TtzHXQ+dAcJoo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=klaD5lk5UfDDy9SRPAR/RMSTzkkosuNmwhtRbI2eIpQ0rQQd3s7BWpZsCir0IU0m9
 lsBgCbadCzHZOQFiIF+yDW9sBpya1CWaCfQQXT/xupni8JI39BkCVxokTSsWjuSThP
 m5q25lWzj+mE1UF5MUJLfG5tu/rOkliMsapEbJa8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 16/19] net/tap: introduce net_tap_fd_init_external()
Date: Mon, 18 Aug 2025 17:06:42 +0300
Message-ID: <20250818140645.27904-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add helper that covers logic for initializing fds, given from monitor
or helper.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 90 ++++++++++++++++++++++---------------------------------
 1 file changed, 36 insertions(+), 54 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index ddee655f60..09c1343ccc 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -627,13 +627,40 @@ static bool set_fd_nonblocking(int fd, const char *note, Error **errp)
     return ok;
 }
 
+static int net_tap_fd_init_external(const Netdev *netdev, NetClientState *peer,
+                                    const char *model, const char *name,
+                                    const char *vhostfdname,
+                                    int *pvnet_hdr, int fd, Error **errp)
+{
+    int vnet_hdr;
+
+    if (!set_fd_nonblocking(fd, name, errp)) {
+        return -1;
+    }
+
+    vnet_hdr = tap_probe_vnet_hdr(fd, errp);
+    if (pvnet_hdr) {
+        if (*pvnet_hdr < 0) {
+            *pvnet_hdr = vnet_hdr;
+        } else if (vnet_hdr != *pvnet_hdr) {
+            error_setg(errp,
+                       "vnet_hdr not consistent across given tap fds");
+            return -1;
+        }
+    }
+
+    return net_init_tap_one(netdev, peer, model, name,
+                            NULL, NULL, NULL,
+                            vhostfdname, vnet_hdr, fd, errp);
+}
+
 int net_init_bridge(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp)
 {
     const NetdevTapOptions *tap = NULL;
     const NetdevBridgeOptions *bridge = NULL;
     const char *helper, *br;
-    int fd, vnet_hdr, ret;
+    int fd;
 
     if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
         bridge = &netdev->u.bridge;
@@ -652,26 +679,8 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    if (!set_fd_nonblocking(fd, name, errp)) {
-        return -1;
-    }
-
-    vnet_hdr = tap_probe_vnet_hdr(fd, errp);
-    if (vnet_hdr < 0) {
-        close(fd);
-        return -1;
-    }
-
-    ret = net_init_tap_one(netdev, peer, "bridge", name,
-                           NULL, NULL, NULL,
-                           tap ? tap->vhostfd : NULL,
-                           vnet_hdr, fd, errp);
-    if (ret < 0) {
-        close(fd);
-        return -1;
-    }
-
-    return 0;
+    return net_tap_fd_init_external(netdev, peer, "bridge", name,
+                                    tap ? tap->vhostfd : NULL, NULL, fd, errp);
 }
 
 static int net_tap_open_one(const Netdev *netdev,
@@ -902,20 +911,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        if (!set_fd_nonblocking(fd, tap->fd, errp)) {
-            close(fd);
-            return -1;
-        }
-
-        vnet_hdr = tap_probe_vnet_hdr(fd, errp);
-        if (vnet_hdr < 0) {
-            close(fd);
-            return -1;
-        }
-
-        ret = net_init_tap_one(netdev, peer, "tap", name, NULL,
-                               NULL, NULL,
-                               tap->vhostfd, vnet_hdr, fd, errp);
+        ret = net_tap_fd_init_external(netdev, peer, "tap", name,
+                                       tap->vhostfd, NULL, fd, errp);
         if (ret < 0) {
             return -1;
         }
@@ -941,31 +938,16 @@ int net_init_tap(const Netdev *netdev, const char *name,
             }
         }
 
+        vnet_hdr = -1;
         for (i = 0; i < nfds; i++) {
             fd = monitor_fd_param(monitor_cur(), fds[i], errp);
             if (fd == -1) {
                 return -1;
             }
 
-            if (!set_fd_nonblocking(fd, fds[i], errp)) {
-                return -1;
-            }
-
-            if (i == 0) {
-                vnet_hdr = tap_probe_vnet_hdr(fd, errp);
-                if (vnet_hdr < 0) {
-                    return -1;
-                }
-            } else if (vnet_hdr != tap_probe_vnet_hdr(fd, NULL)) {
-                error_setg(errp,
-                           "vnet_hdr not consistent across given tap fds");
-                return -1;
-            }
-
-            ret = net_init_tap_one(netdev, peer, "tap", name, NULL,
-                                   NULL, NULL,
-                                   vhost_fds ? vhost_fds[i] : NULL,
-                                   vnet_hdr, fd, errp);
+            ret = net_tap_fd_init_external(netdev, peer, "tap", name,
+                                           vhost_fds ? vhost_fds[i] : NULL,
+                                           &vnet_hdr, fd, errp);
             if (ret < 0) {
                 return -1;
             }
-- 
2.48.1



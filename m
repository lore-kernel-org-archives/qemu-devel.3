Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E894BCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmwA-000656-Mc; Wed, 03 Sep 2025 08:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvz-0005xT-3m
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:55 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvv-0000nq-0A
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8631FC01BB;
 Wed, 03 Sep 2025 15:49:45 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-0zA2hjBK; Wed, 03 Sep 2025 15:49:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903785;
 bh=5tatC7ljYxtyqmoxHP3w6VyCrJ5BNS7hYtJhdLBq7P4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=oH1YGUEiv67JxeU9VC9ECVETe0gpIjVz/SAkRX/Ht8Msubq5y91pCp38hSiOF9hZz
 Vl0icL/IZheLG/7WPWnHQjspkhIGfr+BZe1oqHxFtNvrsDHl8jqQyZNxTMVV8fuSQZ
 rExDbE+XPJ2kxDqXYk33MMEegLo23XEo8EAjsoUY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 15/19] net/tap: introduce net_tap_fd_init_external()
Date: Wed,  3 Sep 2025 15:49:29 +0300
Message-ID: <20250903124934.1169899-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
References: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 89 ++++++++++++++++++++++---------------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index faee5cbeb3..4da3f36b31 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -615,13 +615,40 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
     }
 }
 
+static int net_tap_fd_init_external(const Netdev *netdev, NetClientState *peer,
+                                    const char *model, const char *name,
+                                    const char *vhostfdname,
+                                    int *pvnet_hdr, int fd, Error **errp)
+{
+    int vnet_hdr;
+
+    if (!qemu_set_blocking(fd, false, errp)) {
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
@@ -640,25 +667,8 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    if (!qemu_set_blocking(fd, false, errp)) {
-        return -1;
-    }
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
@@ -889,20 +899,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        if (!qemu_set_blocking(fd, false, errp)) {
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
-        return net_init_tap_one(netdev, peer, "tap", name, NULL,
-                                NULL, NULL,
-                                tap->vhostfd, vnet_hdr, fd, errp);
+        return net_tap_fd_init_external(netdev, peer, "tap", name,
+                                        tap->vhostfd, NULL, fd, errp);
     } else if (tap->fds) {
         g_auto(GStrv) fds = NULL;
         g_auto(GStrv) vhost_fds = NULL;
@@ -925,31 +923,16 @@ int net_init_tap(const Netdev *netdev, const char *name,
             }
         }
 
+        vnet_hdr = -1;
         for (i = 0; i < nfds; i++) {
             fd = monitor_fd_param(monitor_cur(), fds[i], errp);
             if (fd == -1) {
                 return -1;
             }
 
-            if (!qemu_set_blocking(fd, false, errp)) {
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



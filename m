Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C88BCA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw5-000638-Og; Wed, 03 Sep 2025 08:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmw0-0005xt-Pt
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:56 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvv-0000nx-1q
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 054F1C01BC;
 Wed, 03 Sep 2025 15:49:46 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-sSI9gNus; Wed, 03 Sep 2025 15:49:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903785;
 bh=Ij82BMCypSjIMbT/HzIhCBD8q/fXCD0qoLK28qqYVDQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=iJ/vv6h28jD3Qslc0XD6kDy9s98be9zjUaXF25hbkqY3s3eOg5E8B96vj1x8gucRB
 84FAIuTjIl+O56bExc6Mvw7M1J+x1+1veKvJToRUQWjev0nxDfMkwKLH0mxGdD//gz
 5jHugKDWDkcDr67o/IyHzfTlK6uY8nk8JV688QPY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 16/19] net/tap: introduce net_tap_from_monitor_fd() helper
Date: Wed,  3 Sep 2025 15:49:30 +0300
Message-ID: <20250903124934.1169899-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
References: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 4da3f36b31..0802da7d58 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -815,6 +815,20 @@ failed:
     return -1;
 }
 
+static int net_tap_from_monitor_fd(const Netdev *netdev, NetClientState *peer,
+                                   const char *name, const char *vhostfdname,
+                                   int *pvnet_hdr, const char *fdname,
+                                   Error **errp)
+{
+    int fd = monitor_fd_param(monitor_cur(), fdname, errp);
+    if (fd == -1) {
+        return -1;
+    }
+
+    return net_tap_fd_init_external(netdev, peer, "tap", name,
+                                    vhostfdname, pvnet_hdr, fd, errp);
+}
+
 static int net_tap_open(const Netdev *netdev,
                         const char *name,
                         NetClientState *peer,
@@ -862,7 +876,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
     const NetdevTapOptions *tap = &netdev->u.tap;
-    int fd, vnet_hdr = 0, i = 0;
+    int vnet_hdr = 0, i = 0;
     int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
@@ -894,13 +908,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
-        if (fd == -1) {
-            return -1;
-        }
-
-        return net_tap_fd_init_external(netdev, peer, "tap", name,
-                                        tap->vhostfd, NULL, fd, errp);
+        return net_tap_from_monitor_fd(netdev, peer, name, tap->vhostfd,
+                                       NULL, tap->fd, errp);
     } else if (tap->fds) {
         g_auto(GStrv) fds = NULL;
         g_auto(GStrv) vhost_fds = NULL;
@@ -925,14 +934,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         vnet_hdr = -1;
         for (i = 0; i < nfds; i++) {
-            fd = monitor_fd_param(monitor_cur(), fds[i], errp);
-            if (fd == -1) {
-                return -1;
-            }
-
-            ret = net_tap_fd_init_external(netdev, peer, "tap", name,
+            ret = net_tap_from_monitor_fd(netdev, peer, name,
                                            vhost_fds ? vhost_fds[i] : NULL,
-                                           &vnet_hdr, fd, errp);
+                                           &vnet_hdr, fds[i], errp);
             if (ret < 0) {
                 return -1;
             }
-- 
2.48.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E58BCA0EE4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqii-0005PG-Tt; Sat, 23 Aug 2025 12:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiT-0005LK-Af
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:42 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiQ-0000JO-TN
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:41 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 27FA9807C5;
 Sat, 23 Aug 2025 19:03:36 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-evJl9Bnt; Sat, 23 Aug 2025 19:03:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965015;
 bh=u6MMfRHcWymyX5t4KhLBfOBvMUevLdthJ5MTH21h/2E=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=UNw6Fo8rwAUhRAC7nwt6J+JUYXgVuamfVpM72CBNkR20ZvTlHbogZ9S6Epszcc67k
 LkMee7F6eCwjVP71me1Rf0JhhQu4KPcBJ9ohf6vnhZwQfk1lzvLEDkvv3XpGkzIuKk
 RzHl9/SKsOlDHSjWgaFyQRvl3TyQqgC+RcA3jQDs=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 17/20] net/tap: introduce net_tap_from_monitor_fd() helper
Date: Sat, 23 Aug 2025 19:03:20 +0300
Message-ID: <20250823160323.20811-18-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823160323.20811-1-vsementsov@yandex-team.ru>
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 8cea6ed87b..2ef1db0ff1 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -827,6 +827,20 @@ failed:
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
@@ -874,7 +888,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
     const NetdevTapOptions *tap = &netdev->u.tap;
-    int fd, vnet_hdr = 0, i = 0;
+    int vnet_hdr = 0, i = 0;
     int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
@@ -906,13 +920,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -937,14 +946,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
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



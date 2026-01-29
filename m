Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05239D73E83
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZcu-0001aX-Tw; Thu, 29 Jan 2026 16:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZcr-0001WF-Po
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:32:29 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZcp-00019N-8R
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:32:29 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id EF0F980808;
 Fri, 30 Jan 2026 00:32:25 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:b74::1:d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IWrbZO5AAOs0-mv83y6pd; Fri, 30 Jan 2026 00:32:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769722345;
 bh=4Sk0u0b1f0O4jSKRi8ub6puWTSawxmhIEilzYfRNx14=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=m2ngTxQEwLAxUox6L14SgGG3eDz3kM/wen+JhjESqahJ/0VjRj0mTBSZvZqtpi092
 qHr9zOXgmk72cw4S7+M1k4WhJFNw7Xg+s7HMuZHiAr0M4ey60nctuBtw/mWW+9c/U5
 8j3DaH76gGDbUNbMU+SE+y7Aaxi9wSzzqCKj2vGo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v2 09/12] net/tap: move fds parameters handling to separate
 functions
Date: Fri, 30 Jan 2026 00:32:11 +0300
Message-ID: <20260129213215.1405459-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
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

This significantly simplify the code in net_init_tap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 99 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 34 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 883572cdda..dbbbe3c500 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -783,6 +783,61 @@ failed:
     return false;
 }
 
+static bool unblock_fds(int *fds, unsigned nfds, Error **errp)
+{
+    for (unsigned i = 0; i < nfds; i++) {
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
+    unsigned queues;
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
@@ -794,7 +849,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
-    queues = tap->has_queues ? tap->queues : 1;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -831,10 +885,15 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -843,41 +902,23 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -901,24 +942,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
2.52.0



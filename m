Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C026103E166
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2p8h-0006nn-RW; Wed, 18 Mar 2026 07:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8C-0006hs-PD
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:10 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8A-0001y5-61
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id EE4F180850;
 Wed, 18 Mar 2026 14:32:03 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:431::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kVLGYB2A1mI0-RqFYmbma; Wed, 18 Mar 2026 14:32:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773833523;
 bh=E5tOE78hjUCdalfZXMlCDxG3777wSJxcMa4cyExRsyk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=uXR7JBPYcznUtPkWgE5+nj2EeE14TEikpEyfTzOsB8A9T1goaU8HSHQ+v7oiaJidI
 ozKOt9BSMbcL78mO8HJnbmgpJ/E7XB/7YyF7if0pNnHuKt5pxESt8bR8Ql6c3O+oT6
 Mv/SA+t5MdXOpmM/SSQwsi/zGeC9kZeXp6/+iTy8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v4 09/13] net/tap: move fds parameters handling to separate
 functions
Date: Wed, 18 Mar 2026 14:31:39 +0300
Message-ID: <20260318113144.15697-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318113144.15697-1-vsementsov@yandex-team.ru>
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
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
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 99 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 34 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2d4630c350b..b794f80e34d 100644
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
2.52.0



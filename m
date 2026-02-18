Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12526E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoAU-0007E2-0J; Wed, 18 Feb 2026 15:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA4-00074Z-3B
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:40 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA1-0007s2-Ub
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:39 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id AFAD3C038E;
 Wed, 18 Feb 2026 23:28:36 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:53d::1:1b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VShB144A8iE0-sDDid53j; Wed, 18 Feb 2026 23:28:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771446516;
 bh=zkwUUASolEhVxvg1YgpDo8GiYqPwUnrSrAAlmje9B6M=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dhPzQxh1YHd2OTyXJMr0kVnQgP9EDal5IpmpkymFU+7SwSiZVomwDmMU0SRi9EiVy
 PHYwmJFWbarXK3o0rY9nfFZzj/GcT2pcn5QfbGdyHYelSYxFl7mjALn6jiyMWrLnJ2
 YeBqhReJO3+CG0f9Mt9bCEYWIeZWTNEpgY+tgM3w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v3 05/12] net/tap: net_init_tap(): common fail label
Date: Wed, 18 Feb 2026 23:28:21 +0300
Message-ID: <20260218202829.1322088-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
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

Add common failure label. This:

- simplifies failure paths in the function
- get rid of unusual free_fail: in the middle of the function
- simplify further refactoring

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 84 ++++++++++++++++++++++++-------------------------------
 1 file changed, 37 insertions(+), 47 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 331a779585..2eb8a2caeb 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -820,10 +820,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
     const NetdevTapOptions *tap;
-    int fd, vnet_hdr = 0, i = 0, queues;
+    int fd = -1, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
     char ifname[128];
-    int ret = 0;
+    char **fds = NULL, **vhost_fds = NULL;
+    int nfds = 0, nvhosts = 0;
+
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
@@ -867,31 +869,24 @@ int net_init_tap(const Netdev *netdev, const char *name,
     if (tap->fd) {
         fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
         if (fd == -1) {
-            return -1;
+            goto fail;
         }
 
         if (!qemu_set_blocking(fd, false, errp)) {
-            close(fd);
-            return -1;
+            goto fail;
         }
 
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
         if (vnet_hdr < 0) {
-            close(fd);
-            return -1;
+            goto fail;
         }
 
         if (!net_init_tap_one(tap, peer, "tap", name, NULL,
                               NULL, NULL,
                               tap->vhostfd, vnet_hdr, fd, errp)) {
-            close(fd);
-            return -1;
+            goto fail;
         }
     } else if (tap->fds) {
-        char **fds;
-        char **vhost_fds;
-        int nfds = 0, nvhosts = 0;
-
         fds = g_new0(char *, MAX_TAP_QUEUES);
         vhost_fds = g_new0(char *, MAX_TAP_QUEUES);
 
@@ -901,77 +896,58 @@ int net_init_tap(const Netdev *netdev, const char *name,
             if (nfds != nvhosts) {
                 error_setg(errp, "The number of fds passed does not match "
                            "the number of vhostfds passed");
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
         }
 
         for (i = 0; i < nfds; i++) {
             fd = monitor_fd_param(monitor_cur(), fds[i], errp);
             if (fd == -1) {
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
 
             if (!qemu_set_blocking(fd, false, errp)) {
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
 
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fd, errp);
                 if (vnet_hdr < 0) {
-                    ret = -1;
-                    goto free_fail;
+                    goto fail;
                 }
             } else if (vnet_hdr != tap_probe_vnet_hdr(fd, NULL)) {
                 error_setg(errp,
                            "vnet_hdr not consistent across given tap fds");
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
 
             if (!net_init_tap_one(tap, peer, "tap", name, ifname,
                                   NULL, NULL,
                                   tap->vhostfds ? vhost_fds[i] : NULL,
                                   vnet_hdr, fd, errp)) {
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
         }
-
-free_fail:
-        for (i = 0; i < nvhosts; i++) {
-            g_free(vhost_fds[i]);
-        }
-        for (i = 0; i < nfds; i++) {
-            g_free(fds[i]);
-        }
-        g_free(fds);
-        g_free(vhost_fds);
-        return ret;
     } else if (tap->helper) {
         fd = net_bridge_run_helper(tap->helper,
                                    tap->br ?: DEFAULT_BRIDGE_INTERFACE,
                                    errp);
         if (fd == -1) {
-            return -1;
+            goto fail;
         }
 
         if (!qemu_set_blocking(fd, false, errp)) {
-            return -1;
+            goto fail;
         }
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
         if (vnet_hdr < 0) {
-            close(fd);
-            return -1;
+            goto fail;
         }
 
         if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
                               NULL, NULL, tap->vhostfd,
                               vnet_hdr, fd, errp)) {
-            close(fd);
-            return -1;
+            goto fail;
         }
     } else {
         g_autofree char *script =
@@ -989,14 +965,13 @@ free_fail:
             fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? NULL : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
-                return -1;
+                goto fail;
             }
 
             if (queues > 1 && i == 0 && !tap->ifname) {
                 if (tap_fd_get_ifname(fd, ifname)) {
                     error_setg(errp, "Fail to get ifname");
-                    close(fd);
-                    return -1;
+                    goto fail;
                 }
             }
 
@@ -1004,13 +979,28 @@ free_fail:
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
                                   tap->vhostfd, vnet_hdr, fd, errp)) {
-                close(fd);
-                return -1;
+                goto fail;
             }
         }
     }
 
     return 0;
+
+fail:
+    close(fd);
+    if (vhost_fds) {
+        for (i = 0; i < nvhosts; i++) {
+            g_free(vhost_fds[i]);
+        }
+        g_free(vhost_fds);
+    }
+    if (fds) {
+        for (i = 0; i < nfds; i++) {
+            g_free(fds[i]);
+        }
+        g_free(fds);
+    }
+    return -1;
 }
 
 int tap_enable(NetClientState *nc)
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A57D73E8C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZcu-0001ac-TK; Thu, 29 Jan 2026 16:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZcq-0001Um-Fx
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:32:28 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZcn-00018u-3r
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:32:28 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id CF51D80800;
 Fri, 30 Jan 2026 00:32:23 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:b74::1:d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IWrbZO5AAOs0-EUcszAX5; Fri, 30 Jan 2026 00:32:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769722343;
 bh=1LHoJ5DJvDzwJvSX0/dnBSGc1kLmBrli5OwBikWNfk8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vw19j9kPGMToa9DKget9PO9allm9Nxtmy0rsAKM5XlJ/FpqP2NW4dBPD3meGmhTWp
 7zv0w2ZpYcYx7vjyj7nuDPyB2g0j3O8gcGSg96lNg8fAxWLkPUi5bWN6/edbUE7gS3
 pwt2b2A7k11QkmRIM/R2QEXrix/L+oLtRBUvdr4Y=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v2 06/12] net/tap: net_init_tap_one() refactor to get vhostfd
 param
Date: Fri, 30 Jan 2026 00:32:08 +0300
Message-ID: <20260129213215.1405459-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
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

Get vhostfd instead of vhostfdname:

- more symmetry with fd param
- prepare to further changes

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2eb8a2caeb..2c5f8e73fe 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -706,11 +706,10 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *model, const char *name,
                              const char *ifname, const char *script,
-                             const char *downscript, const char *vhostfdname,
+                             const char *downscript, int vhostfd,
                              int vnet_hdr, int fd, Error **errp)
 {
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
-    int vhostfd;
     bool sndbuf_required = tap->has_sndbuf;
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
@@ -738,7 +737,7 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     }
 
     if (tap->has_vhost ? tap->vhost :
-        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
+        (vhostfd != -1) || (tap->has_vhostforce && tap->vhostforce)) {
         VhostNetOptions options;
 
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
@@ -749,15 +748,7 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             options.busyloop_timeout = 0;
         }
 
-        if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
-            if (vhostfd == -1) {
-                goto failed;
-            }
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
-                goto failed;
-            }
-        } else {
+        if (vhostfd == -1) {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
                 error_setg_file_open(errp, errno, "/dev/vhost-net");
@@ -820,7 +811,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
     const NetdevTapOptions *tap;
-    int fd = -1, vnet_hdr = 0, i = 0, queues;
+    int fd = -1, vhostfd = -1, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
     char ifname[128];
     char **fds = NULL, **vhost_fds = NULL;
@@ -866,6 +857,17 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    if (tap->vhostfd) {
+        vhostfd = monitor_fd_param(monitor_cur(), tap->vhostfd, errp);
+        if (vhostfd == -1) {
+            return -1;
+        }
+
+        if (!qemu_set_blocking(vhostfd, false, errp)) {
+            goto fail;
+        }
+    }
+
     if (tap->fd) {
         fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
         if (fd == -1) {
@@ -883,7 +885,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         if (!net_init_tap_one(tap, peer, "tap", name, NULL,
                               NULL, NULL,
-                              tap->vhostfd, vnet_hdr, fd, errp)) {
+                              vhostfd, vnet_hdr, fd, errp)) {
             goto fail;
         }
     } else if (tap->fds) {
@@ -910,6 +912,17 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto fail;
             }
 
+            if (tap->vhostfds) {
+                vhostfd = monitor_fd_param(monitor_cur(), vhost_fds[i], errp);
+                if (vhostfd == -1) {
+                    goto fail;
+                }
+
+                if (!qemu_set_blocking(vhostfd, false, errp)) {
+                    goto fail;
+                }
+            }
+
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fd, errp);
                 if (vnet_hdr < 0) {
@@ -923,7 +936,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
             if (!net_init_tap_one(tap, peer, "tap", name, ifname,
                                   NULL, NULL,
-                                  tap->vhostfds ? vhost_fds[i] : NULL,
+                                  vhostfd,
                                   vnet_hdr, fd, errp)) {
                 goto fail;
             }
@@ -945,7 +958,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
-                              NULL, NULL, tap->vhostfd,
+                              NULL, NULL, vhostfd,
                               vnet_hdr, fd, errp)) {
             goto fail;
         }
@@ -978,7 +991,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             if (!net_init_tap_one(tap, peer, "tap", name, ifname,
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
-                                  tap->vhostfd, vnet_hdr, fd, errp)) {
+                                  vhostfd, vnet_hdr, fd, errp)) {
                 goto fail;
             }
         }
@@ -988,6 +1001,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
 fail:
     close(fd);
+    close(vhostfd);
     if (vhost_fds) {
         for (i = 0; i < nvhosts; i++) {
             g_free(vhost_fds[i]);
-- 
2.52.0



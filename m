Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CD6103E166
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2p8b-0006l5-Ho; Wed, 18 Mar 2026 07:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8D-0006hu-2V
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:10 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8A-0001yF-Uv
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4D56C808B6;
 Wed, 18 Mar 2026 14:32:05 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:431::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kVLGYB2A1mI0-9qRFtQHy; Wed, 18 Mar 2026 14:32:04 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773833524;
 bh=fDRiWx7StjplPNhAZ4Pj//bPZgbSiCKeduwVS+rEc4o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=1VGvg+s8YcN69O11foGq3N7Di1VdPAtQebReRzIz2LuoQe4RFZZ6LRvaRfkz+71wd
 8blRjPukjeCUtoXajcnC2elxZ34qiw+gMnyEgFMIWwQznOqTR6xoymC4O0k9ZUGyMa
 u6qQU5BJaZAoPMdmFPz1r6VZRwLZccGQ4xswFbCA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v4 10/13] net/tap: fix vhostfds/vhostfd parameters API
Date: Wed, 18 Mar 2026 14:31:40 +0300
Message-ID: <20260318113144.15697-11-vsementsov@yandex-team.ru>
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
---
 net/tap.c | 63 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index b794f80e34d..d5a719150b4 100644
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
2.52.0



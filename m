Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08856CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw1-0005yJ-Fz; Wed, 03 Sep 2025 08:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvt-0005ut-Fy
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:50 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvp-0000ks-8Z
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1541EC016B;
 Wed, 03 Sep 2025 15:49:38 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-aGP1hrIK; Wed, 03 Sep 2025 15:49:37 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903777;
 bh=JBEuKPIFGUuJUV939QSbdXyh7RXiG0DMIQMNx76sU+Q=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vJXpCEkWpMZd8OP5rSWSE6sc5cvRY7P50aO7mEUY8MOesNgwZ6lxihdPNurkV+YOy
 LHUVtSGgRXnqOUCphj3regLabdlDc/HZMeIZcoAdhNT0a5nwKXN+b0tRJesSts0BtU
 jB3JFgYIG8PFvl4ttgYshKThD2E0Ac7xNVDThF1w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 01/19] net/tap: net_init_tap_one(): add return value
Date: Wed,  3 Sep 2025 15:49:15 +0300
Message-ID: <20250903124934.1169899-2-vsementsov@yandex-team.ru>
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

To avoid error propagation, let's follow common recommendation to
use return value together with errp.

Probably, it would also be good to use bool as a return type
(switching to true/false as success/failure instead of 0/-1). But
seems almost all functions (including a lot of them with errp
argument) have 0/-1 semantics in net/, so making exclusions doesn't
seem good. If we want such a switch, we should update the whole
net/ directory.

Why do we prefer errp-based functions with return value?
In short with additional return value we get:

- less code to handle error
- don't create and set Error object when it's not required
  (when passed errp=NULL)

More details in commit message of e3fe3988d7851cac3
"error: Document Error API usage rules"

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 55 +++++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f37133e301..89feb01756 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -679,11 +679,11 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 
 #define MAX_TAP_QUEUES 1024
 
-static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
-                             const char *model, const char *name,
-                             const char *ifname, const char *script,
-                             const char *downscript, const char *vhostfdname,
-                             int vnet_hdr, int fd, Error **errp)
+static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
+                            const char *model, const char *name,
+                            const char *ifname, const char *script,
+                            const char *downscript, const char *vhostfdname,
+                            int vnet_hdr, int fd, Error **errp)
 {
     Error *err = NULL;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
@@ -761,10 +761,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         goto failed;
     }
 
-    return;
+    return 0;
 
 failed:
     qemu_del_net_client(&s->nc);
+    return -1;
 }
 
 static int get_fds(char *str, char *fds[], int max)
@@ -801,7 +802,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     /* for the no-fd, no-helper case */
     const char *script;
     const char *downscript;
-    Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
     int ret = 0;
@@ -846,12 +846,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "tap", name, NULL,
-                         script, downscript,
-                         vhostfdname, vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
-            close(fd);
+        ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+                               script, downscript,
+                               vhostfdname, vnet_hdr, fd, errp);
+        if (ret < 0) {
             return -1;
         }
     } else if (tap->fds) {
@@ -907,12 +905,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             script, downscript,
-                             tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
+                                   script, downscript,
+                                   tap->vhostfds ? vhost_fds[i] : NULL,
+                                   vnet_hdr, fd, errp);
+            if (ret < 0) {
                 ret = -1;
                 goto free_fail;
             }
@@ -952,11 +949,10 @@ free_fail:
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "bridge", name, ifname,
-                         script, downscript, vhostfdname,
-                         vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        ret = net_init_tap_one(tap, peer, "bridge", name, ifname,
+                               script, downscript, vhostfdname,
+                               vnet_hdr, fd, errp);
+        if (ret < 0) {
             close(fd);
             return -1;
         }
@@ -997,12 +993,11 @@ free_fail:
                 }
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             i >= 1 ? "no" : script,
-                             i >= 1 ? "no" : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
+                                   i >= 1 ? "no" : script,
+                                   i >= 1 ? "no" : downscript,
+                                   vhostfdname, vnet_hdr, fd, errp);
+            if (ret < 0) {
                 close(fd);
                 return -1;
             }
-- 
2.48.1



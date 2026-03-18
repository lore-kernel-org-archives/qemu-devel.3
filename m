Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ACD103E162
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2p8h-0006n7-AH; Wed, 18 Mar 2026 07:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p85-0006gs-5n
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:05 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p82-0001wL-KL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A01808092B;
 Wed, 18 Mar 2026 14:31:55 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:431::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kVLGYB2A1mI0-cCnSANRQ; Wed, 18 Mar 2026 14:31:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773833515;
 bh=52QCXUdXz7q3nmUl8vdRkB0Je5ENVXDMWksBuy+5rqA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=kcN2g/REXZNASFMkHpX869zEdnVt6rl0MyZxzp8saeQxUUqoLcKvqH7V+8ER0fwkS
 gqrHh6b37vDHS/7Dj4/OPhavn0RReL414TL5epTj8TYXLdwMlk+SyCiXzV1dbyjdm0
 NmmwKGu4wEqvGZ+9+crdMfsGsMSAUXIYsmK/gfBk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v4 04/13] net/tap: net_init_tap(): refactor parameter checking
Date: Wed, 18 Mar 2026 14:31:34 +0300
Message-ID: <20260318113144.15697-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318113144.15697-1-vsementsov@yandex-team.ru>
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Move checks to the top of the function to simplify further
refactoring. Merge duplicated checks.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 53 +++++++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 55b8b33ea84..331a779585f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -841,16 +841,30 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    if (tap->fd) {
-        if (tap->ifname || tap->script || tap->downscript ||
-            tap->has_vnet_hdr || tap->helper || tap->has_queues ||
-            tap->fds || tap->vhostfds) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "helper=, queues=, fds=, and vhostfds= "
-                       "are invalid with fd=");
-            return -1;
-        }
+    if (tap->has_queues + !!tap->helper + !!tap->fds + !!tap->fd > 1) {
+        error_setg(errp, "queues=, helper=, fds= and fd= are mutual exclusive");
+        return -1;
+    }
 
+    if ((tap->fd || tap->fds || tap->helper) &&
+        (tap->ifname || tap->script || tap->downscript ||
+         tap->has_vnet_hdr)) {
+        error_setg(errp, "ifname=, script=, downscript=, vnet_hdr= "
+                   "are invalid with fd=/fds=/helper=");
+        return -1;
+    }
+
+    if (tap->vhostfds && !tap->fds) {
+        error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
+        return -1;
+    }
+
+    if (tap->vhostfd && tap->fds) {
+        error_setg(errp, "vhostfd= is invalid with fds=");
+        return -1;
+    }
+
+    if (tap->fd) {
         fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
         if (fd == -1) {
             return -1;
@@ -878,15 +892,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
         char **vhost_fds;
         int nfds = 0, nvhosts = 0;
 
-        if (tap->ifname || tap->script || tap->downscript ||
-            tap->has_vnet_hdr || tap->helper || tap->has_queues ||
-            tap->vhostfd) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "helper=, queues=, and vhostfd= "
-                       "are invalid with fds=");
-            return -1;
-        }
-
         fds = g_new0(char *, MAX_TAP_QUEUES);
         vhost_fds = g_new0(char *, MAX_TAP_QUEUES);
 
@@ -946,13 +951,6 @@ free_fail:
         g_free(vhost_fds);
         return ret;
     } else if (tap->helper) {
-        if (tap->ifname || tap->script || tap->downscript ||
-            tap->has_vnet_hdr || tap->has_queues || tap->vhostfds) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "queues=, and vhostfds= are invalid with helper=");
-            return -1;
-        }
-
         fd = net_bridge_run_helper(tap->helper,
                                    tap->br ?: DEFAULT_BRIDGE_INTERFACE,
                                    errp);
@@ -981,11 +979,6 @@ free_fail:
         g_autofree char *downscript =
             tap_parse_script(tap->downscript, DEFAULT_NETWORK_DOWN_SCRIPT);
 
-        if (tap->vhostfds) {
-            error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
-            return -1;
-        }
-
         if (tap->ifname) {
             pstrcpy(ifname, sizeof ifname, tap->ifname);
         } else {
-- 
2.52.0



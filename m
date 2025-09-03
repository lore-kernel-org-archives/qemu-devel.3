Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831D0CA1014
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw6-00063P-CQ; Wed, 03 Sep 2025 08:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvy-0005x5-SH
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:54 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvu-0000ns-TN
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D8C56C0196;
 Wed, 03 Sep 2025 15:49:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-sQeIegh0; Wed, 03 Sep 2025 15:49:43 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903783;
 bh=FhJML9Otr3dUT6ZxMqz6k3sNazn9e3KFCnS6Z7ENET4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=RWtyCfuoFSF5lHJC64OVQyWEjy1MLSSx5PI/r7qFXjyn8My9j4zL2/EX0wmbd7a51
 HcC1D/bBWj5mOeo0V7qCUJw8DphHujkjNwVrtHLn1BcdAMRdKRU/ry/4rYxzxT1893
 KdEBD7FDhjRWR+g6KmuMsXgp+byZHYIpxbCa2KN0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 12/19] net/tap: net_init_bridge(): support tap
Date: Wed,  3 Sep 2025 15:49:26 +0300
Message-ID: <20250903124934.1169899-13-vsementsov@yandex-team.ru>
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

Support tap in net_init_bridge() and reuse it for corresponding
case in net_init_tap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 47 +++++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 01f9277211..79225fb233 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -618,16 +618,24 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
 int net_init_bridge(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp)
 {
-    const NetdevBridgeOptions *bridge;
+    const NetdevTapOptions *tap = NULL;
+    const NetdevBridgeOptions *bridge = NULL;
     const char *helper, *br;
     int fd, vnet_hdr, ret;
 
-    assert(netdev->type == NET_CLIENT_DRIVER_BRIDGE);
-    bridge = &netdev->u.bridge;
-    helper = bridge->helper;
-    br     = bridge->br ?: DEFAULT_BRIDGE_INTERFACE;
+    if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
+        bridge = &netdev->u.bridge;
+        helper = bridge->helper;
+        br = bridge->br;
+    } else {
+        assert(netdev->type == NET_CLIENT_DRIVER_TAP);
+
+        tap = &netdev->u.tap;
+        helper = tap->helper;
+        br = tap->br;
+    }
 
-    fd = net_bridge_run_helper(helper, br, errp);
+    fd = net_bridge_run_helper(helper, br ?: DEFAULT_BRIDGE_INTERFACE, errp);
     if (fd == -1) {
         return -1;
     }
@@ -643,7 +651,8 @@ int net_init_bridge(const Netdev *netdev, const char *name,
 
     ret = net_init_tap_one(netdev, peer, "bridge", name,
                            NULL, NULL, NULL,
-                           NULL, vnet_hdr, fd, errp);
+                           tap ? tap->vhostfd : NULL,
+                           vnet_hdr, fd, errp);
     if (ret < 0) {
         close(fd);
         return -1;
@@ -897,29 +906,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        fd = net_bridge_run_helper(tap->helper,
-                                   tap->br ?: DEFAULT_BRIDGE_INTERFACE,
-                                   errp);
-        if (fd == -1) {
-            return -1;
-        }
-
-        if (!qemu_set_blocking(fd, false, errp)) {
-            return -1;
-        }
-        vnet_hdr = tap_probe_vnet_hdr(fd, errp);
-        if (vnet_hdr < 0) {
-            close(fd);
-            return -1;
-        }
-
-        ret = net_init_tap_one(netdev, peer, "bridge", name, NULL,
-                               NULL, NULL, tap->vhostfd,
-                               vnet_hdr, fd, errp);
-        if (ret < 0) {
-            close(fd);
-            return -1;
-        }
+        return net_init_bridge(netdev, name, peer, errp);
     } else {
         const char *script = tap->script;
         const char *downscript = tap->downscript;
-- 
2.48.1



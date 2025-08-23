Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59EECA0EED
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqio-0005Ri-1R; Sat, 23 Aug 2025 12:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiS-0005L9-5V
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:42 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiP-0000It-TQ
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:39 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0E72780782;
 Sat, 23 Aug 2025 19:03:34 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-lyk6am5m; Sat, 23 Aug 2025 19:03:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965013;
 bh=9w3QClpqsLPtFcNR/rxasMLiSjbct8d5Q3AT/oDKknU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Ysc3H2Ar4gr8w/BjpRdsbTxt9PF+9mSDTsnrqT5qs+M1ZyP0bkcbziY+nY1ZiI6my
 Pj4U4s9V6h+NmV+ZlQbeT56oMN2un+NiwrKrvveSPoKiRTC1mDmSDZKNIrapZuYji8
 8B8KXY04pagv7U3rsXEMbR/jVsrNSUtVd0KEVPgE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 13/20] net/tap: net_init_bridge(): support tap
Date: Sat, 23 Aug 2025 19:03:16 +0300
Message-ID: <20250823160323.20811-14-vsementsov@yandex-team.ru>
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

Support tap in net_init_bridge() and reuse it for corresponding
case in net_init_tap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 47 +++++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 5acfb128a1..83a1c9250a 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -630,16 +630,24 @@ static bool set_fd_nonblocking(int fd, const char *note, Error **errp)
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
 
-    fd = net_bridge_run_helper(helper, br, errp);
+        tap = &netdev->u.tap;
+        helper = tap->helper;
+        br = tap->br;
+    }
+
+    fd = net_bridge_run_helper(helper, br ?: DEFAULT_BRIDGE_INTERFACE, errp);
     if (fd == -1) {
         return -1;
     }
@@ -656,7 +664,8 @@ int net_init_bridge(const Netdev *netdev, const char *name,
 
     ret = net_init_tap_one(netdev, peer, "bridge", name,
                            NULL, NULL, NULL,
-                           NULL, vnet_hdr, fd, errp);
+                           tap ? tap->vhostfd : NULL,
+                           vnet_hdr, fd, errp);
     if (ret < 0) {
         close(fd);
         return -1;
@@ -910,29 +919,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        fd = net_bridge_run_helper(tap->helper,
-                                   tap->br ?: DEFAULT_BRIDGE_INTERFACE,
-                                   errp);
-        if (fd == -1) {
-            return -1;
-        }
-
-        if (!set_fd_nonblocking(fd, name, errp)) {
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



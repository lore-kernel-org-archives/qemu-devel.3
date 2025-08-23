Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E2FCA0EED
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqio-0005S2-Ne; Sat, 23 Aug 2025 12:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiS-0005LC-Lm
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:42 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiQ-0000J9-ER
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:40 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1857E80748;
 Sat, 23 Aug 2025 19:03:35 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-oJr0zruG; Sat, 23 Aug 2025 19:03:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965014;
 bh=FF4XChV3zYMW5rMxlbeISngoOcWFPoJtBUlCOjXUTV4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=auQU3D/s1h2bQYeAaz/Nzci//TtwKz20KxaXvOW/wXERJn+fAtuYXAoTkRh8TetSA
 KfFOwTstJq1u816DSU+cenBp+uc7gh9RhGfojztD/31pWu6esxKhBTV4noFUbGBWTM
 rlKNJeaJMGu2ziiGhuox8L9QTJ9sL/V622qrLXYo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 15/20] net/tap: introduce net_tap_open()
Date: Sat, 23 Aug 2025 19:03:18 +0300
Message-ID: <20250823160323.20811-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823160323.20811-1-vsementsov@yandex-team.ru>
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
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

Move the latter case of net_init_tap() to a separate function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 96 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 57939ed16f..27642c45a9 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -818,6 +818,49 @@ failed:
     return -1;
 }
 
+static int net_tap_open(const Netdev *netdev,
+                        const char *name,
+                        NetClientState *peer,
+                        Error **errp)
+{
+    const NetdevTapOptions *tap = &netdev->u.tap;
+    const char *script = tap->script;
+    const char *downscript = tap->downscript;
+    int queues = tap->has_queues ? tap->queues : 1;
+    g_autofree char *default_script = NULL;
+    g_autofree char *default_downscript = NULL;
+    char ifname[128];
+    int i, ret;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_TAP);
+
+    if (!script) {
+        script = default_script = get_relocated_path(DEFAULT_NETWORK_SCRIPT);
+    }
+    if (!downscript) {
+        downscript = default_downscript =
+                             get_relocated_path(DEFAULT_NETWORK_DOWN_SCRIPT);
+    }
+
+    if (tap->ifname) {
+        pstrcpy(ifname, sizeof ifname, tap->ifname);
+    } else {
+        ifname[0] = '\0';
+    }
+
+    for (i = 0; i < queues; i++) {
+        ret = net_tap_open_one(netdev, name, peer,
+                               i >= 1 ? "no" : script,
+                               i >= 1 ? "no" : downscript,
+                               ifname, sizeof ifname, queues > 1, errp);
+        if (ret < 0) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
@@ -870,12 +913,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        ret = net_init_tap_one(netdev, peer, "tap", name, NULL,
-                               NULL, NULL,
-                               tap->vhostfd, vnet_hdr, fd, errp);
-        if (ret < 0) {
-            return -1;
-        }
+        return net_init_tap_one(netdev, peer, "tap", name, NULL,
+                                NULL, NULL,
+                                tap->vhostfd, vnet_hdr, fd, errp);
     } else if (tap->fds) {
         g_auto(GStrv) fds = NULL;
         g_auto(GStrv) vhost_fds = NULL;
@@ -927,6 +967,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 return -1;
             }
         }
+
+        return 0;
     } else if (tap->helper) {
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid with helper=");
@@ -934,46 +976,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         return net_init_bridge(netdev, name, peer, errp);
-    } else {
-        const char *script = tap->script;
-        const char *downscript = tap->downscript;
-        int queues = tap->has_queues ? tap->queues : 1;
-        g_autofree char *default_script = NULL;
-        g_autofree char *default_downscript = NULL;
-        char ifname[128];
-
-        if (tap->vhostfds) {
-            error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
-            return -1;
-        }
-
-        if (!script) {
-            script = default_script = get_relocated_path(DEFAULT_NETWORK_SCRIPT);
-        }
-        if (!downscript) {
-            downscript = default_downscript =
-                                 get_relocated_path(DEFAULT_NETWORK_DOWN_SCRIPT);
-        }
-
-        if (tap->ifname) {
-            pstrcpy(ifname, sizeof ifname, tap->ifname);
-        } else {
-            ifname[0] = '\0';
-        }
-
-        for (i = 0; i < queues; i++) {
-            ret = net_tap_open_one(netdev, name, peer,
-                                   i >= 1 ? "no" : script,
-                                   i >= 1 ? "no" : downscript,
-                                   ifname, sizeof ifname, queues > 1, errp);
-            if (ret < 0) {
-                return -1;
-            }
+    }
 
-        }
+    if (tap->vhostfds) {
+        error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
+        return -1;
     }
 
-    return 0;
+    return net_tap_open(netdev, name, peer, errp);
 }
 
 int tap_enable(NetClientState *nc)
-- 
2.48.1



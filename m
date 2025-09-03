Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAF0CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw4-00062i-Lo; Wed, 03 Sep 2025 08:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvy-0005x3-R8
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:54 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvu-0000np-Vj
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E97ECC019D;
 Wed, 03 Sep 2025 15:49:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-cX2qhtHD; Wed, 03 Sep 2025 15:49:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903784;
 bh=Z3yUM0FMk3Vlu3RWBhLTmIiC1wl5j4itBKMOFqDUSyM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=RzCH4qZfEJS2PZv2eCCtKd0Zc/j+14ep4qYSdk/YAWJPGBmWXPWycIkupsxbsgR9U
 aPYl6DKwFhRTCi7Ym85eLgES55xeazboHrVZJpLLY7nYbYuNntkgx0Sv88WqraNzNL
 0D9oTPaXK9hdDbP+zwVfDEA+qlPj4PKTziodLzJU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 14/19] net/tap: introduce net_tap_open()
Date: Wed,  3 Sep 2025 15:49:28 +0300
Message-ID: <20250903124934.1169899-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
References: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the latter case of net_init_tap() to a separate function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 96 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index d2f84586ed..faee5cbeb3 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -805,6 +805,49 @@ failed:
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
@@ -857,12 +900,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -914,6 +954,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 return -1;
             }
         }
+
+        return 0;
     } else if (tap->helper) {
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid with helper=");
@@ -921,46 +963,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
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



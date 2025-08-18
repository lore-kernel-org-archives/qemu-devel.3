Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E138CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vt-0001ai-78; Mon, 18 Aug 2025 10:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vo-0001M2-6T
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:07:00 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vm-0002Cu-Cr
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A0CD7807D2;
 Mon, 18 Aug 2025 17:06:52 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-kDUiWHJ1; Mon, 18 Aug 2025 17:06:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526012;
 bh=HpUvdWzVv8ea0OUfIhmNiXUGLnANMbNVPqLLdDIcsyU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Sn78bW0ykphT4k2yA67GqV81slN3Vvrb0UU6vvB9jyanWAYO7vXom4eES1rlt6ASS
 vFpkzsctl+3Cx/hy3TpYm6w3zlw511gDrp7oPU2Ucurcarz+0tj/plrA0leeEQIQwZ
 H7cdSq68LwlkfH9gzC+hXoB4L2adyJX+SEAAIRAg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 15/19] net/tap: introduce net_tap_open()
Date: Mon, 18 Aug 2025 17:06:41 +0300
Message-ID: <20250818140645.27904-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
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

Move the latter case of net_init_tap() to a separate function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 85 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2cffa880a4..ddee655f60 100644
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
@@ -934,46 +977,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
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



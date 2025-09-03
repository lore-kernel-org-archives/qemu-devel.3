Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A1CCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw6-00063n-R1; Wed, 03 Sep 2025 08:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmw0-0005xr-Pf
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:56 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvv-0000nr-2h
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 66B81C0198;
 Wed, 03 Sep 2025 15:49:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-WTyicmc4; Wed, 03 Sep 2025 15:49:43 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903783;
 bh=FNpEu0vgeT5SARb41mWNwZDzd2rQBSI7dV4BBhJS5lk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Q+QZBCmXtnmeUux2CoIe/HQLcXKws8ND6UbwbuUBRfFJgCHmTF/Uqb8Pz/vtlvZQT
 bM+On/zknyqcc4vU1BFc3SIYc2M3EIrfuS+xip37oliASgIF3TJDAPueKAZUTZl9ZQ
 cMCHYm2S86xbish4dIiCtNvNI4sE+SEqyEdx7XVI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 13/19] net/tap: refactor net_tap_init() into
 net_tap_open_one()
Date: Wed,  3 Sep 2025 15:49:27 +0300
Message-ID: <20250903124934.1169899-14-vsementsov@yandex-team.ru>
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

net_tap_init() is used in one place. Let's move net_init_tap_one()
call to it and simplify outer loop code.

Note: "setup_script" variable renamed to just "script", as it's
"script" in all other places in the file, and moreover, the original
option is "script=" as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 54 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 79225fb233..d2f84586ed 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -661,31 +661,37 @@ int net_init_bridge(const Netdev *netdev, const char *name,
     return 0;
 }
 
-static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
-                        const char *setup_script, char *ifname,
-                        size_t ifname_sz, int mq_required, Error **errp)
+static int net_tap_open_one(const Netdev *netdev,
+                            const char *name, NetClientState *peer,
+                            const char *script, const char *downscript,
+                            char *ifname, size_t ifname_sz,
+                            int mq_required, Error **errp)
 {
+    const NetdevTapOptions *tap = &netdev->u.tap;
     Error *err = NULL;
-    int fd, vnet_hdr_required;
+    int fd, vnet_hdr_required, vnet_hdr;
+    int ret;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_TAP);
 
     if (tap->has_vnet_hdr) {
-        *vnet_hdr = tap->vnet_hdr;
-        vnet_hdr_required = *vnet_hdr;
+        vnet_hdr = tap->vnet_hdr;
+        vnet_hdr_required = vnet_hdr;
     } else {
-        *vnet_hdr = 1;
+        vnet_hdr = 1;
         vnet_hdr_required = 0;
     }
 
-    fd = RETRY_ON_EINTR(tap_open(ifname, ifname_sz, vnet_hdr, vnet_hdr_required,
-                      mq_required, errp));
+    fd = RETRY_ON_EINTR(tap_open(ifname, ifname_sz, &vnet_hdr,
+                                 vnet_hdr_required, mq_required, errp));
     if (fd < 0) {
         return -1;
     }
 
-    if (setup_script &&
-        setup_script[0] != '\0' &&
-        strcmp(setup_script, "no") != 0) {
-        launch_script(setup_script, ifname, fd, &err);
+    if (script &&
+        script[0] != '\0' &&
+        strcmp(script, "no") != 0) {
+        launch_script(script, ifname, fd, &err);
         if (err) {
             error_propagate(errp, err);
             close(fd);
@@ -693,7 +699,15 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
         }
     }
 
-    return fd;
+    ret = net_init_tap_one(netdev, peer, "tap", name, ifname,
+                           script, downscript,
+                           tap->vhostfd, vnet_hdr, fd, errp);
+    if (ret < 0) {
+        close(fd);
+        return -1;
+    }
+
+    return 0;
 }
 
 #define MAX_TAP_QUEUES 1024
@@ -935,20 +949,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         for (i = 0; i < queues; i++) {
-            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
-                              ifname, sizeof ifname, queues > 1, errp);
-            if (fd == -1) {
-                return -1;
-            }
-
-            ret = net_init_tap_one(netdev, peer, "tap", name, ifname,
+            ret = net_tap_open_one(netdev, name, peer,
                                    i >= 1 ? "no" : script,
                                    i >= 1 ? "no" : downscript,
-                                   tap->vhostfd, vnet_hdr, fd, errp);
+                                   ifname, sizeof ifname, queues > 1, errp);
             if (ret < 0) {
-                close(fd);
                 return -1;
             }
+
         }
     }
 
-- 
2.48.1



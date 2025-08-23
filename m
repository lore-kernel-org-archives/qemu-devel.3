Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B86CA0EE4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqir-0005U9-E8; Sat, 23 Aug 2025 12:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqid-0005OZ-A5
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:52 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqia-0000JA-F6
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:49 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 88CAE80792;
 Sat, 23 Aug 2025 19:03:34 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-1FeLE9tn; Sat, 23 Aug 2025 19:03:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965014;
 bh=Eq8zW+TtfILkdauE4l8IVPeyRa7dELn4L/MyVWhIrKo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dUbeVkBIWElxt3ZuZi2sbdoac5uPJoqHBEeQsru/LHBPO71L3r29lxUX6tBqsd6eE
 DpDRA2rxaD7u2p4Dx79FfJbK+3bD4qVDNuxogea/EqyaWFIkF6LuDe6WO+YDKnM/P8
 8DHl1hTxJt10o3UemCKPgmawWFP+HILBAJwuIHT4=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 14/20] net/tap: refactor net_tap_init() into
 net_tap_open_one()
Date: Sat, 23 Aug 2025 19:03:17 +0300
Message-ID: <20250823160323.20811-15-vsementsov@yandex-team.ru>
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

net_tap_init() is used in one place. Let's move net_init_tap_one()
call to it and simplify outer loop code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 54 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 83a1c9250a..57939ed16f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -674,31 +674,37 @@ int net_init_bridge(const Netdev *netdev, const char *name,
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
@@ -706,7 +712,15 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
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
@@ -948,20 +962,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
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



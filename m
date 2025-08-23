Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18720CA0EED
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqio-0005S3-OL; Sat, 23 Aug 2025 12:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiU-0005LN-KP
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:42 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiQ-0000JX-Uf
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:41 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A9BB68076D;
 Sat, 23 Aug 2025 19:03:36 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-jqmGy38K; Sat, 23 Aug 2025 19:03:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965016;
 bh=xd+mUqjsh9xnLT4mVkn+Xb0AoSWyU83DHF8mdQFDWGg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dz9sw+QXuLm70oZ4f7fgAtd1g/4/PluVCFbuHw6EICmcBKnY/rdx/m3dBllkxq1NM
 Wy8r0gbi9ksRyUhTiO5FyukmXNteeMlK4Rml+15XeMm+fW4yNf3Sqa9kbTznaIUM/1
 rOdFpqALOrgf0sydIcnBdzejoAuZYdSxmVni54js=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 18/20] net/tap: split net_tap_setup_vhost() separate
 function
Date: Sat, 23 Aug 2025 19:03:21 +0300
Message-ID: <20250823160323.20811-19-vsementsov@yandex-team.ru>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2ef1db0ff1..f2c0f7fd06 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -93,6 +93,8 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
                             const char *ifname, const char *script,
                             const char *downscript, const char *vhostfdname,
                             int vnet_hdr, int fd, Error **errp);
+static int net_tap_setup_vhost(TAPState *s, const NetdevTapOptions *tap,
+                               const char *vhostfdname, Error **errp);
 
 static void tap_update_fd_handler(TAPState *s)
 {
@@ -742,7 +744,7 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
 {
     const NetdevTapOptions *tap;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
-    int vhostfd;
+    int ret;
 
     if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
         const NetdevBridgeOptions *bridge = &netdev->u.bridge;
@@ -773,9 +775,25 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
         }
     }
 
+    ret = net_tap_setup_vhost(s, tap, vhostfdname, errp);
+    if (ret < 0) {
+        goto failed;
+    }
+
+    return 0;
+
+failed:
+    qemu_del_net_client(&s->nc);
+    return -1;
+}
+
+static int net_tap_setup_vhost(TAPState *s, const NetdevTapOptions *tap,
+                               const char *vhostfdname, Error **errp)
+{
     if (tap->has_vhost ? tap->vhost :
         vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
         VhostNetOptions options;
+        int vhostfd;
 
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
         options.net_backend = &s->nc;
@@ -788,20 +806,20 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
             if (vhostfd == -1) {
-                goto failed;
+                return -1;
             }
             if (!set_fd_nonblocking(vhostfd, vhostfdname, errp)) {
-                goto failed;
+                return -1;
             }
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
                 error_setg_errno(errp, errno,
                                  "tap: open vhost char device failed");
-                goto failed;
+                return -1;
             }
             if (!set_fd_nonblocking(vhostfd, "opened /dev/vhost-net", errp)) {
-                goto failed;
+                return -1;
             }
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
@@ -816,15 +834,11 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
         if (!s->vhost_net) {
             error_setg(errp,
                        "vhost-net requested but could not be initialized");
-            goto failed;
+            return -1;
         }
     }
 
     return 0;
-
-failed:
-    qemu_del_net_client(&s->nc);
-    return -1;
 }
 
 static int net_tap_from_monitor_fd(const Netdev *netdev, NetClientState *peer,
-- 
2.48.1



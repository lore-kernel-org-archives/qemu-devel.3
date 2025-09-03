Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE563CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmwK-0006D8-PP; Wed, 03 Sep 2025 08:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmw6-00063r-Tl
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:50:03 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmw5-0000o6-37
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:50:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3FED8C0162;
 Wed, 03 Sep 2025 15:49:49 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-4jtuwM2G; Wed, 03 Sep 2025 15:49:48 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903788;
 bh=m/hFLQMDX/lCZxfgHLZhE6GJfd+gtZ+BLeDe492dlkM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HrN3koCUAIhNDJ9ll8pRGM+WiLDFo+RDKSupUyzD575dio4khLFlu5qNntIyMPr/g
 0JbVr68pUrJDO/35trAQXhe+Tie1oA5KyozNp77ZFn+7q9biGoF6Us7DUDcNphFjwB
 FZ7JH2PQXGNEiOrp51Q2qqvcHo5g5UdmapTQF4N8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 19/19] net/tap: introduce net_init_tap_fds()
Date: Wed,  3 Sep 2025 15:49:33 +0300
Message-ID: <20250903124934.1169899-20-vsementsov@yandex-team.ru>
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

Final refactoring step for net_init_tap: move fds case to separate
function, so that net_init_tap() becomes straightforward top-level
entry point to tap initialization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 68 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 5ad6f6af85..2530627a9a 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -877,12 +877,48 @@ static int net_tap_open(const Netdev *netdev,
     return 0;
 }
 
+static int net_init_tap_fds(const Netdev *netdev, const char *name,
+                            NetClientState *peer, Error **errp)
+{
+    const NetdevTapOptions *tap = &netdev->u.tap;
+    g_auto(GStrv) fds = NULL;
+    g_auto(GStrv) vhost_fds = NULL;
+    int nfds;
+    int vnet_hdr = 0, i = 0;
+    int ret;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_TAP);
+
+    fds = g_strsplit(tap->fds, ":", MAX_TAP_QUEUES);
+    nfds = g_strv_length(fds);
+
+    if (tap->vhostfds) {
+        vhost_fds = g_strsplit(tap->vhostfds, ":", MAX_TAP_QUEUES);
+        if (nfds != g_strv_length(vhost_fds)) {
+            error_setg(errp, "The number of fds passed does not match "
+                       "the number of vhostfds passed");
+            return -1;
+        }
+    }
+
+    vnet_hdr = -1;
+    for (i = 0; i < nfds; i++) {
+        ret = net_tap_from_monitor_fd(netdev, peer, name,
+                                       vhost_fds ? vhost_fds[i] : NULL,
+                                       &vnet_hdr, fds[i], errp);
+        if (ret < 0) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
     const NetdevTapOptions *tap = &netdev->u.tap;
-    int vnet_hdr = 0, i = 0;
-    int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
 
@@ -916,38 +952,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return net_tap_from_monitor_fd(netdev, peer, name, tap->vhostfd,
                                        NULL, tap->fd, errp);
     } else if (tap->fds) {
-        g_auto(GStrv) fds = NULL;
-        g_auto(GStrv) vhost_fds = NULL;
-        int nfds;
-
         if (tap->helper || tap->vhostfd) {
             error_setg(errp, "helper= and vhostfd= are invalid with fds=");
             return -1;
         }
 
-        fds = g_strsplit(tap->fds, ":", MAX_TAP_QUEUES);
-        nfds = g_strv_length(fds);
-
-        if (tap->vhostfds) {
-            vhost_fds = g_strsplit(tap->vhostfds, ":", MAX_TAP_QUEUES);
-            if (nfds != g_strv_length(vhost_fds)) {
-                error_setg(errp, "The number of fds passed does not match "
-                           "the number of vhostfds passed");
-                return -1;
-            }
-        }
-
-        vnet_hdr = -1;
-        for (i = 0; i < nfds; i++) {
-            ret = net_tap_from_monitor_fd(netdev, peer, name,
-                                           vhost_fds ? vhost_fds[i] : NULL,
-                                           &vnet_hdr, fds[i], errp);
-            if (ret < 0) {
-                return -1;
-            }
-        }
-
-        return 0;
+        return net_init_tap_fds(netdev, name, peer, errp);
     } else if (tap->helper) {
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid with helper=");
-- 
2.48.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E51ACA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw1-0005yH-Dy; Wed, 03 Sep 2025 08:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvw-0005wK-Fp
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:52 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvu-0000nT-ML
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 65FDBC01B7;
 Wed, 03 Sep 2025 15:49:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-HhgGUC9M; Wed, 03 Sep 2025 15:49:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903782;
 bh=V09EVXB3RmUezu8R1HKszNv0Wmt33AxVwbk6HH4OJwY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Z5fW5uKUvTo5Lp0oyH5H8wh5gtJjOLsHaHAkqRroUsCMb0sCqIqeiYssrR1n3wVoC
 Ml8TjnSxYu2rZ6/s6/5jsrk5wLRUJedK7Ux0QNYKCvfYt55zf8sAniuQ5vydZIDcr1
 jMtsfp4wyQ+9P5yKMHg5KSPfLCZL8dkED/JePS0E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 11/19] net/tap: net_init_tap_one(): support bridge
Date: Wed,  3 Sep 2025 15:49:25 +0300
Message-ID: <20250903124934.1169899-12-vsementsov@yandex-team.ru>
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

Use net_init_tap_one() in net_init_bridge() to be able in further
commits use net_init_bridge for "bridge" case of init_tap, as it has
the same first part, but requires tap-related things in
net_init_tap_one.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 7dc8f52831..01f9277211 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -88,6 +88,12 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
+static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
+                            const char *model, const char *name,
+                            const char *ifname, const char *script,
+                            const char *downscript, const char *vhostfdname,
+                            int vnet_hdr, int fd, Error **errp);
+
 static void tap_update_fd_handler(TAPState *s)
 {
     qemu_set_fd_handler(s->fd,
@@ -614,8 +620,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
 {
     const NetdevBridgeOptions *bridge;
     const char *helper, *br;
-    TAPState *s;
-    int fd, vnet_hdr;
+    int fd, vnet_hdr, ret;
 
     assert(netdev->type == NET_CLIENT_DRIVER_BRIDGE);
     bridge = &netdev->u.bridge;
@@ -635,9 +640,14 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         close(fd);
         return -1;
     }
-    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
 
-    qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
+    ret = net_init_tap_one(netdev, peer, "bridge", name,
+                           NULL, NULL, NULL,
+                           NULL, vnet_hdr, fd, errp);
+    if (ret < 0) {
+        close(fd);
+        return -1;
+    }
 
     return 0;
 }
@@ -685,11 +695,19 @@ static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
                             const char *downscript, const char *vhostfdname,
                             int vnet_hdr, int fd, Error **errp)
 {
-    const NetdevTapOptions *tap = &netdev->u.tap;
+    const NetdevTapOptions *tap;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int vhostfd;
 
+    if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
+        const NetdevBridgeOptions *bridge = &netdev->u.bridge;
+        qemu_set_info_str(&s->nc, "helper=%s,br=%s",
+                          bridge->helper, bridge->br);
+        return 0;
+    }
+
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
+    tap = &netdev->u.tap;
 
     if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
         goto failed;
-- 
2.48.1



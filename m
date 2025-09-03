Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357AFCA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmwI-0006Ce-KV; Wed, 03 Sep 2025 08:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvw-0005wZ-SU
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:52 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvu-0000nU-MS
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D033BC0192;
 Wed, 03 Sep 2025 15:49:42 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-EmxUYIwi; Wed, 03 Sep 2025 15:49:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903782;
 bh=AWe/NvzEYfuBKOxLSJ1su4BUutR6kWpN1uG/Rl7YzJ0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=hWkmBEiTFcW3+kOu729uQ1/Is6GRbEXEfMfoCbMYVoebx2mtzEZs8VQfA3RF+gXJq
 LyAqZIlCW4v7Tj6oHLFu9VpwvZu8DAlmwooXMe+rhYW8zfQSvRAjxgooY6D36Ygt8X
 3ji63GOiYpnnvvEB0sb8oopmlLZwDfnBkhbN6QkY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 10/19] net/tap: net_init_tap_one(): refactor to use netdev
 as first arg
Date: Wed,  3 Sep 2025 15:49:24 +0300
Message-ID: <20250903124934.1169899-11-vsementsov@yandex-team.ru>
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

This is needed for further unification of bridge initialization in
net_init_tap() and net_init_bridge().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index c007cd272a..7dc8f52831 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -679,15 +679,18 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 
 #define MAX_TAP_QUEUES 1024
 
-static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
+static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
                             const char *model, const char *name,
                             const char *ifname, const char *script,
                             const char *downscript, const char *vhostfdname,
                             int vnet_hdr, int fd, Error **errp)
 {
+    const NetdevTapOptions *tap = &netdev->u.tap;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int vhostfd;
 
+    assert(netdev->type == NET_CLIENT_DRIVER_TAP);
+
     if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
         goto failed;
     }
@@ -813,7 +816,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+        ret = net_init_tap_one(netdev, peer, "tap", name, NULL,
                                NULL, NULL,
                                tap->vhostfd, vnet_hdr, fd, errp);
         if (ret < 0) {
@@ -862,7 +865,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 return -1;
             }
 
-            ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+            ret = net_init_tap_one(netdev, peer, "tap", name, NULL,
                                    NULL, NULL,
                                    vhost_fds ? vhost_fds[i] : NULL,
                                    vnet_hdr, fd, errp);
@@ -892,7 +895,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        ret = net_init_tap_one(tap, peer, "bridge", name, NULL,
+        ret = net_init_tap_one(netdev, peer, "bridge", name, NULL,
                                NULL, NULL, tap->vhostfd,
                                vnet_hdr, fd, errp);
         if (ret < 0) {
@@ -933,7 +936,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 return -1;
             }
 
-            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
+            ret = net_init_tap_one(netdev, peer, "tap", name, ifname,
                                    i >= 1 ? "no" : script,
                                    i >= 1 ? "no" : downscript,
                                    tap->vhostfd, vnet_hdr, fd, errp);
-- 
2.48.1



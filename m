Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BBDCA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vv-0001ib-SO; Mon, 18 Aug 2025 10:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vm-0001L6-QY
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:58 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vk-0002CD-Tw
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 32710807CD;
 Mon, 18 Aug 2025 17:06:51 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-yZYIlRC5; Mon, 18 Aug 2025 17:06:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526010;
 bh=FV7G9bFav6fly4zXKY/M2EAtJlpqhKHxyw6pyeEvM4o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=uo5PwBjZmvmFFpOXmkDe0ov0QEbLcSZ8Y+0ZvbtIWO8gTa4gD/P/MmE6OtKpJMBRK
 MTjAJh8LpIqVRjIYd1CXdHdwdSKt9q0rul5gr4CpSkjSwP3+XHbqzhfiDMGCjrUaAI
 Q3p5AksTdWeZq/RBdwfBPlYP+eVLuUwT9yg7XST0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 11/19] net/tap: net_init_tap_one(): refactor to use netdev as
 first arg
Date: Mon, 18 Aug 2025 17:06:37 +0300
Message-ID: <20250818140645.27904-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
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

This is needed for further unification of bridge initialization in
net_init_tap() and net_init_bridge().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index eab0a86173..468dae7004 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -692,15 +692,18 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 
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
@@ -826,7 +829,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+        ret = net_init_tap_one(netdev, peer, "tap", name, NULL,
                                NULL, NULL,
                                tap->vhostfd, vnet_hdr, fd, errp);
         if (ret < 0) {
@@ -875,7 +878,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 return -1;
             }
 
-            ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+            ret = net_init_tap_one(netdev, peer, "tap", name, NULL,
                                    NULL, NULL,
                                    vhost_fds ? vhost_fds[i] : NULL,
                                    vnet_hdr, fd, errp);
@@ -905,7 +908,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        ret = net_init_tap_one(tap, peer, "bridge", name, NULL,
+        ret = net_init_tap_one(netdev, peer, "bridge", name, NULL,
                                NULL, NULL, tap->vhostfd,
                                vnet_hdr, fd, errp);
         if (ret < 0) {
@@ -946,7 +949,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 return -1;
             }
 
-            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
+            ret = net_init_tap_one(netdev, peer, "tap", name, ifname,
                                    i >= 1 ? "no" : script,
                                    i >= 1 ? "no" : downscript,
                                    tap->vhostfd, vnet_hdr, fd, errp);
-- 
2.48.1



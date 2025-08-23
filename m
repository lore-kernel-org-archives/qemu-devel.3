Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C92CA0EE4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqif-0005P0-FH; Sat, 23 Aug 2025 12:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiS-0005L7-1J
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:42 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiP-0000Im-Dh
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:39 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0BEA680780;
 Sat, 23 Aug 2025 19:03:33 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-LwUYGfEz; Sat, 23 Aug 2025 19:03:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965012;
 bh=FV7G9bFav6fly4zXKY/M2EAtJlpqhKHxyw6pyeEvM4o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=skgs07ROA6QWivpeEU14GQ6AJUilW5r7GERyur+5WuOJielKgwglpdCVu9V42CG2R
 4lSSzcsTMtcbMpyIBHX2uoLf7istHz1xrk6uw6pC36zc0asZUZ4I6paMJwCNXzjgkp
 3fJLIRhzgxAdEwc0XS9H+tQ04NnedPJHlMEzyZIY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 11/20] net/tap: net_init_tap_one(): refactor to use netdev
 as first arg
Date: Sat, 23 Aug 2025 19:03:14 +0300
Message-ID: <20250823160323.20811-12-vsementsov@yandex-team.ru>
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A3DC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 19:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vidrW-0000RC-Me; Wed, 21 Jan 2026 14:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vidrU-0000Mq-9p
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:27:28 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vidrP-0001l2-UZ
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 14:27:28 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C084880873;
 Wed, 21 Jan 2026 22:27:18 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:d28::1:34])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HRhSvR2A7Os0-r0jItEsN; Wed, 21 Jan 2026 22:27:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769023638;
 bh=NmhRR96cRMuUakqrVMGcg6Cb60iNhe6svQ6MNtKnofk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lJKd+YqvQ3IKb3EyjSWaZh9p/GbG5acRuej0Bu6uZbzaAazG+usp8vszBfPufoXu1
 ZbzsJ6oS7MAQ4Sp6xomnq66e4TISyXUP344ScgVhxOXCXdxRUs1YIn4kpYB03np3hI
 lpkKEVqjqeBYCUeC7fXnxseVAR69EaEKTiRZ/9vQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 1/3] net/tap: net_init_tap_one(): add return value
Date: Wed, 21 Jan 2026 22:27:11 +0300
Message-ID: <20260121192713.133470-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121192713.133470-1-vsementsov@yandex-team.ru>
References: <20260121192713.133470-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Follow common recommendations in include/qapi/error.h of having
a return value together with errp. This allows to avoid error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 3bd81883fd..72464a416d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -703,7 +703,7 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 
 #define MAX_TAP_QUEUES 1024
 
-static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
+static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *model, const char *name,
                              const char *ifname, const char *script,
                              const char *downscript, const char *vhostfdname,
@@ -784,10 +784,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
-    return;
+    return true;
 
 failed:
     qemu_del_net_client(&s->nc);
+    return false;
 }
 
 static int get_fds(char *str, char *fds[], int max)
@@ -822,7 +823,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     const NetdevTapOptions *tap;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
-    Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
     int ret = 0;
@@ -870,11 +870,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "tap", name, NULL,
-                         NULL, NULL,
-                         vhostfdname, vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!net_init_tap_one(tap, peer, "tap", name, NULL,
+                              NULL, NULL,
+                              vhostfdname, vnet_hdr, fd, errp)) {
             close(fd);
             return -1;
         }
@@ -931,12 +929,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             NULL, NULL,
-                             tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+                                  NULL, NULL,
+                                  tap->vhostfds ? vhost_fds[i] : NULL,
+                                  vnet_hdr, fd, errp)) {
                 ret = -1;
                 goto free_fail;
             }
@@ -976,11 +972,9 @@ free_fail:
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "bridge", name, ifname,
-                         NULL, NULL, vhostfdname,
-                         vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
+                              NULL, NULL, vhostfdname,
+                              vnet_hdr, fd, errp)) {
             close(fd);
             return -1;
         }
@@ -1016,12 +1010,10 @@ free_fail:
                 }
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             i >= 1 ? NULL : script,
-                             i >= 1 ? NULL : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+                                  i >= 1 ? NULL : script,
+                                  i >= 1 ? NULL : downscript,
+                                  vhostfdname, vnet_hdr, fd, errp)) {
                 close(fd);
                 return -1;
             }
-- 
2.52.0



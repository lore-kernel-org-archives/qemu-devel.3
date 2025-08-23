Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9783ACA0EED
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqim-0005Qe-JR; Sat, 23 Aug 2025 12:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiU-0005LP-5O
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:42 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqiL-0000Hb-N6
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:41 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D7E1880627;
 Sat, 23 Aug 2025 19:03:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-S66TTie8; Sat, 23 Aug 2025 19:03:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965007;
 bh=q5i+N1SlqWBs6WupKPtmLQX3i9iaALrIqSXj/w8R0Uc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mPBJwF3aquTiBi8wZDHG1dC0M5WpgpyxK+pU7quEFau1//h0Yc6HisID0icY1glRE
 1oAduqvVin2e40UMs/Q9z4lj1vOQZRD94sIXjBYUxBmnnl0Fcg8OyElwCF1PybvEvy
 fo9ui2unjTg0f9aH9OoDiHNSK5fUDWt+Ef4dLvgo=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 01/20] net/tap: net_init_tap_one(): add return value
Date: Sat, 23 Aug 2025 19:03:04 +0300
Message-ID: <20250823160323.20811-2-vsementsov@yandex-team.ru>
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

To avoid error propagation, let's follow common recommendation to
use return value together with errp.

Probably, it would also be good to use bool as a return type
(switching to true/false as success/failure instead of 0/-1). But
seems almost all functions (including a lot of them with errp
argument) have 0/-1 semantics in net/, so making exclusions doesn't
seem good. If we want such a switch, we should update the whole
net/ directory.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 55 +++++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f7df702f97..531ef75e91 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -680,11 +680,11 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 
 #define MAX_TAP_QUEUES 1024
 
-static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
-                             const char *model, const char *name,
-                             const char *ifname, const char *script,
-                             const char *downscript, const char *vhostfdname,
-                             int vnet_hdr, int fd, Error **errp)
+static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
+                            const char *model, const char *name,
+                            const char *ifname, const char *script,
+                            const char *downscript, const char *vhostfdname,
+                            int vnet_hdr, int fd, Error **errp)
 {
     Error *err = NULL;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
@@ -765,10 +765,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         goto failed;
     }
 
-    return;
+    return 0;
 
 failed:
     qemu_del_net_client(&s->nc);
+    return -1;
 }
 
 static int get_fds(char *str, char *fds[], int max)
@@ -805,7 +806,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     /* for the no-fd, no-helper case */
     const char *script;
     const char *downscript;
-    Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
     int ret = 0;
@@ -852,12 +852,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "tap", name, NULL,
-                         script, downscript,
-                         vhostfdname, vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
-            close(fd);
+        ret = net_init_tap_one(tap, peer, "tap", name, NULL,
+                               script, downscript,
+                               vhostfdname, vnet_hdr, fd, errp);
+        if (ret < 0) {
             return -1;
         }
     } else if (tap->fds) {
@@ -915,12 +913,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             script, downscript,
-                             tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
+                                   script, downscript,
+                                   tap->vhostfds ? vhost_fds[i] : NULL,
+                                   vnet_hdr, fd, errp);
+            if (ret < 0) {
                 ret = -1;
                 goto free_fail;
             }
@@ -961,11 +958,10 @@ free_fail:
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "bridge", name, ifname,
-                         script, downscript, vhostfdname,
-                         vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        ret = net_init_tap_one(tap, peer, "bridge", name, ifname,
+                               script, downscript, vhostfdname,
+                               vnet_hdr, fd, errp);
+        if (ret < 0) {
             close(fd);
             return -1;
         }
@@ -1006,12 +1002,11 @@ free_fail:
                 }
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             i >= 1 ? "no" : script,
-                             i >= 1 ? "no" : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            ret = net_init_tap_one(tap, peer, "tap", name, ifname,
+                                   i >= 1 ? "no" : script,
+                                   i >= 1 ? "no" : downscript,
+                                   vhostfdname, vnet_hdr, fd, errp);
+            if (ret < 0) {
                 close(fd);
                 return -1;
             }
-- 
2.48.1



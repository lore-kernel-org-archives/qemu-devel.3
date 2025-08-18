Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D75CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vn-0001Ls-RO; Mon, 18 Aug 2025 10:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vl-0001Jw-4y
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:57 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vh-0002BA-Jv
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 80110807C0;
 Mon, 18 Aug 2025 17:06:49 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-8JerLNma; Mon, 18 Aug 2025 17:06:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526009;
 bh=1Swq7dYJJnBLISq3vORSp+LW7aF5QGfIP3wBCjdR6cY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=FImiNkpP00jxAQX3Ho6qSq84MXpfSn4fqeOjd5kS+O/nlOaRDKoD4X7d1ERQXD9bS
 y9ChI7WsHCufiFPuniRjHzy+DT2ntTGvvAM46+HbeHor2n8LAkdiBdl4RVnWdgQ7ne
 4JHuWHPjNT3upjxgC1s071INV+hGfzIihslk9LDc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 06/19] net/tap: net_init_tap(): refactor parameter checking
Date: Mon, 18 Aug 2025 17:06:32 +0300
Message-ID: <20250818140645.27904-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
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

Unite duplicated checks of different code paths.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 3fe99ef63f..042f9fd01a 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -831,12 +831,17 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    if ((tap->fd || tap->fds || tap->helper) &&
+        (tap->ifname || tap->script || tap->downscript ||
+         tap->has_vnet_hdr || tap->has_queues)) {
+        error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
+                   "queues=, are invalid with fd=/fds=/helper=");
+        return -1;
+    }
+
     if (tap->fd) {
-        if (tap->ifname || tap->script || tap->downscript ||
-            tap->has_vnet_hdr || tap->helper || tap->has_queues ||
-            tap->fds || tap->vhostfds) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "helper=, queues=, fds=, and vhostfds= "
+        if (tap->helper || tap->fds || tap->vhostfds) {
+            error_setg(errp, "helper=, fds=, and vhostfds= "
                        "are invalid with fd=");
             return -1;
         }
@@ -868,12 +873,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
         char **vhost_fds;
         int nfds = 0, nvhosts = 0;
 
-        if (tap->ifname || tap->script || tap->downscript ||
-            tap->has_vnet_hdr || tap->helper || tap->has_queues ||
-            tap->vhostfd) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "helper=, queues=, and vhostfd= "
-                       "are invalid with fds=");
+        if (tap->helper || tap->vhostfd) {
+            error_setg(errp, "helper= and vhostfd= are invalid with fds=");
             return -1;
         }
 
@@ -937,10 +938,8 @@ free_fail:
         g_free(vhost_fds);
         return ret;
     } else if (tap->helper) {
-        if (tap->ifname || tap->script || tap->downscript ||
-            tap->has_vnet_hdr || tap->has_queues || tap->vhostfds) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "queues=, and vhostfds= are invalid with helper=");
+        if (tap->vhostfds) {
+            error_setg(errp, "vhostfds= is invalid with helper=");
             return -1;
         }
 
-- 
2.48.1



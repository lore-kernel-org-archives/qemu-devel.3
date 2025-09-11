Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B34CAC58F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwkVv-0002vy-QZ; Thu, 11 Sep 2025 12:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVt-0002lP-KV
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:13 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVq-0004Ag-97
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A949280795;
 Thu, 11 Sep 2025 19:51:07 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2pOVKM0Fka60-2ccDHXt0; Thu, 11 Sep 2025 19:51:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757609467;
 bh=meCRCih9ZiD5d2tMU7VeKv9KexoM7K/oh14kEeMF7fc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=kUDKmnnLa0nE9af4cmIkdc+eqajtaw9zhca4Uo/6g5L40gwj9FlTCPTRcCPQw9II5
 PdV9rvLG9llPQjALRAREMww7mVZnbo8wbWPWjM4Rkngrjut/I7eF3ensC+qdPqJjJH
 Fphd0fN9DidOIzXr03z2adimiH1c9yCTUnv65pm4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 davydov-max@yandex-team.ru
Subject: [PATCH v4 6/8] net/tap: net_init_tap(): refactor parameter checking
Date: Thu, 11 Sep 2025 19:50:59 +0300
Message-ID: <20250911165101.1637608-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
References: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Unite duplicated checks of different code paths.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 257290f06b..9b0ff70cf2 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -829,12 +829,17 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -867,12 +872,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
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



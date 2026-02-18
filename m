Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE28BE9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoAL-00077C-4V; Wed, 18 Feb 2026 15:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA5-00075A-5v
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:42 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA3-0007sK-Mt
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:40 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3A22EC0390;
 Wed, 18 Feb 2026 23:28:38 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:53d::1:1b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VShB144A8iE0-BTqabyzq; Wed, 18 Feb 2026 23:28:37 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771446517;
 bh=BDiEM5hFQxkhlp+sUNQkEBGuisXIqaX1d5OB08sKy8A=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OeGzIX65okFHOG82icbCPBwoLhXTPft/ODqmFKVSiQP/vMdc6qigxu4CW1xyJV6vR
 b+na6eRXldrDyQlF4mHvI0P9OHJlrGSRXy1Bn3we6qlB4OGPooIgbFxsYlJji5wYhu
 /xcs5RLpQJjmHCwTdaIjnOuhsekgMe+jMgUQJ9pE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v3 07/12] net/tap: net_init_tap_one(): drop model parameter
Date: Wed, 18 Feb 2026 23:28:23 +0300
Message-ID: <20260218202829.1322088-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

It could be simply derived from tap parameter. And this change
simplifies further refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2c5f8e73fe..db3fe380a4 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -704,12 +704,13 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 #define MAX_TAP_QUEUES 1024
 
 static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
-                             const char *model, const char *name,
+                             const char *name,
                              const char *ifname, const char *script,
                              const char *downscript, int vhostfd,
                              int vnet_hdr, int fd, Error **errp)
 {
-    TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
+    TAPState *s = net_tap_fd_init(peer, tap->helper ? "bridge" : "tap",
+                                  name, fd, vnet_hdr);
     bool sndbuf_required = tap->has_sndbuf;
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
@@ -883,7 +884,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             goto fail;
         }
 
-        if (!net_init_tap_one(tap, peer, "tap", name, NULL,
+        if (!net_init_tap_one(tap, peer, name, NULL,
                               NULL, NULL,
                               vhostfd, vnet_hdr, fd, errp)) {
             goto fail;
@@ -934,7 +935,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto fail;
             }
 
-            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+            if (!net_init_tap_one(tap, peer, name, ifname,
                                   NULL, NULL,
                                   vhostfd,
                                   vnet_hdr, fd, errp)) {
@@ -957,7 +958,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             goto fail;
         }
 
-        if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
+        if (!net_init_tap_one(tap, peer, name, ifname,
                               NULL, NULL, vhostfd,
                               vnet_hdr, fd, errp)) {
             goto fail;
@@ -988,7 +989,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 }
             }
 
-            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+            if (!net_init_tap_one(tap, peer, name, ifname,
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
                                   vhostfd, vnet_hdr, fd, errp)) {
-- 
2.52.0



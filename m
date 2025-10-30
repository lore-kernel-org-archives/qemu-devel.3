Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A118CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVhc-0007yA-3D; Thu, 30 Oct 2025 12:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhZ-0007wa-L8
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:41 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEVhR-0003GW-R5
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BD9CF80B32;
 Thu, 30 Oct 2025 19:40:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OeiSuH0Fn4Y0-AyAYyBDw; Thu, 30 Oct 2025 19:40:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761842427;
 bh=1Tyws1RO74DCvOk+3QeBN8VTw3xPjk7rHaoR80rF55k=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=cnxRb9uNUTtdi3GOknzmLP+NEhTfDVVGZBq5sJ3aYP52IlR3jotlH90u6MBAaoc5T
 ozzKmBKMbcHN+z6llKUmZcrzqX0/AFYMDRYrivY3xs+EFLTun9YikgvwXGBhowaNVN
 G6ivBz03Q9zTwKDhAsmjoyQimLO2Q5gV1I209zy8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v9 3/7] net/tap: pass NULL to net_init_tap_one() in cases when
 scripts are NULL
Date: Thu, 30 Oct 2025 19:40:19 +0300
Message-ID: <20251030164023.710048-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030164023.710048-1-vsementsov@yandex-team.ru>
References: <20251030164023.710048-1-vsementsov@yandex-team.ru>
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

Directly pass NULL in cases where we report an error if script or
downscript are set.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f90050c3a0..5c6b9399e0 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -808,8 +808,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     const NetdevTapOptions *tap;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
-    const char *script;
-    const char *downscript;
     Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
@@ -819,8 +817,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     tap = &netdev->u.tap;
     queues = tap->has_queues ? tap->queues : 1;
     vhostfdname = tap->vhostfd;
-    script = tap->script;
-    downscript = tap->downscript;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -861,7 +857,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
-                         script, downscript,
+                         NULL, NULL,
                          vhostfdname, vnet_hdr, fd, &err);
         if (err) {
             error_propagate(errp, err);
@@ -922,7 +918,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             }
 
             net_init_tap_one(tap, peer, "tap", name, ifname,
-                             script, downscript,
+                             NULL, NULL,
                              tap->vhostfds ? vhost_fds[i] : NULL,
                              vnet_hdr, fd, &err);
             if (err) {
@@ -967,7 +963,7 @@ free_fail:
         }
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
-                         script, downscript, vhostfdname,
+                         NULL, NULL, vhostfdname,
                          vnet_hdr, fd, &err);
         if (err) {
             error_propagate(errp, err);
@@ -975,6 +971,8 @@ free_fail:
             return -1;
         }
     } else {
+        const char *script = tap->script;
+        const char *downscript = tap->downscript;
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
         if (tap->vhostfds) {
-- 
2.48.1



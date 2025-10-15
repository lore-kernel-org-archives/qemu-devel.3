Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9A6CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91SM-0005LD-GO; Wed, 15 Oct 2025 09:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91S8-0005Iu-76
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:04 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91Ry-0002zy-3P
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:03 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id ECF4D88A39;
 Wed, 15 Oct 2025 16:21:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-9ko4QUr0; Wed, 15 Oct 2025 16:21:43 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534503;
 bh=qRZTogNTqI/NlvPAmDaFtUT9hXrMy3NPHnhfaXmrOwM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ZPMX/todzycs4H/A9I6tim6eZG/gJxHYaTSOsQ0AuJ5WqwedbqlzxDbG3eoMa+ACm
 YeuGNBG5EZdcikcK5JaUjp5VnOjPAjHQSrRycfH4nkUJU+CThI2Op7gwnuXr9WCB6m
 xOzBx2bNgZDQlBrgZ0lWEpJM4tAMPDcCfRxwjCes=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v8 04/19] net/tap: pass NULL to net_init_tap_one() in cases
 when scripts are NULL
Date: Wed, 15 Oct 2025 16:21:20 +0300
Message-ID: <20251015132136.1083972-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
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
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index b1b64c508d..a05cc7ef64 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -800,8 +800,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     const NetdevTapOptions *tap;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
-    const char *script;
-    const char *downscript;
     Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
@@ -811,8 +809,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     tap = &netdev->u.tap;
     queues = tap->has_queues ? tap->queues : 1;
     vhostfdname = tap->vhostfd;
-    script = tap->script;
-    downscript = tap->downscript;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -853,7 +849,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
-                         script, downscript,
+                         NULL, NULL,
                          vhostfdname, vnet_hdr, fd, &err);
         if (err) {
             error_propagate(errp, err);
@@ -914,7 +910,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             }
 
             net_init_tap_one(tap, peer, "tap", name, ifname,
-                             script, downscript,
+                             NULL, NULL,
                              tap->vhostfds ? vhost_fds[i] : NULL,
                              vnet_hdr, fd, &err);
             if (err) {
@@ -959,7 +955,7 @@ free_fail:
         }
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
-                         script, downscript, vhostfdname,
+                         NULL, NULL, vhostfdname,
                          vnet_hdr, fd, &err);
         if (err) {
             error_propagate(errp, err);
@@ -967,6 +963,8 @@ free_fail:
             return -1;
         }
     } else {
+        const char *script = tap->script;
+        const char *downscript = tap->downscript;
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
         bool vnet_hdr_required = tap->has_vnet_hdr && tap->vnet_hdr;
-- 
2.48.1



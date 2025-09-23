Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E336DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zq3-0002jd-7S; Tue, 23 Sep 2025 06:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpt-0002fc-4m
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:25 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpm-0000t3-Qv
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7ECD5807C9;
 Tue, 23 Sep 2025 13:01:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-W2RIwL7U; Tue, 23 Sep 2025 13:01:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621675;
 bh=FeDOTAGsW1Pcdbg0ZZNDxeOSWxQ+N3Fw7mdS9vL/kGY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=n6SEW6xwVgpop0j6Oqndhu1ZvkPR3OCldJ7z+GyEpKhB1OJxZ9UiVAJKBosB05uvX
 iNQ2APQzFWLi67kHW0FDNUTbL1pxRzMqiD9LAyakgVjd1NT47oARzWtZn1BXqgi1kp
 nKLA0TeWBWxLOrUgi90JGO95Yftt0V8XsvkRdkcU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 04/19] net/tap: pass NULL to net_init_tap_one() in cases
 when scripts are NULL
Date: Tue, 23 Sep 2025 13:00:55 +0300
Message-ID: <20250923100110.70862-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923100110.70862-1-vsementsov@yandex-team.ru>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
---
 net/tap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 506dc9d226..e42c7ca044 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -787,8 +787,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     const NetdevTapOptions *tap;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
-    const char *script;
-    const char *downscript;
     Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
@@ -798,8 +796,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     tap = &netdev->u.tap;
     queues = tap->has_queues ? tap->queues : 1;
     vhostfdname = tap->vhostfd;
-    script = tap->script;
-    downscript = tap->downscript;
 
     /* QEMU hubs do not support multiqueue tap, in this case peer is set.
      * For -netdev, peer is always NULL. */
@@ -840,7 +836,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         net_init_tap_one(tap, peer, "tap", name, NULL,
-                         script, downscript,
+                         NULL, NULL,
                          vhostfdname, vnet_hdr, fd, &err);
         if (err) {
             error_propagate(errp, err);
@@ -901,7 +897,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             }
 
             net_init_tap_one(tap, peer, "tap", name, ifname,
-                             script, downscript,
+                             NULL, NULL,
                              tap->vhostfds ? vhost_fds[i] : NULL,
                              vnet_hdr, fd, &err);
             if (err) {
@@ -946,7 +942,7 @@ free_fail:
         }
 
         net_init_tap_one(tap, peer, "bridge", name, ifname,
-                         script, downscript, vhostfdname,
+                         NULL, NULL, vhostfdname,
                          vnet_hdr, fd, &err);
         if (err) {
             error_propagate(errp, err);
@@ -954,6 +950,8 @@ free_fail:
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



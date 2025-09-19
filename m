Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DDECAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXqs-00069f-AA; Fri, 19 Sep 2025 05:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqb-0005g9-0s
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:11 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqS-0004Ze-Dv
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4901080ED9;
 Fri, 19 Sep 2025 12:55:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntP1fK1GvGk0-Xm8jnOcW; Fri, 19 Sep 2025 12:55:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758275754;
 bh=CGQxVo0F5DM5TI71ogpEMoIKdtU4cMrWeEhuC0QhepU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=d5jTSKPgst2bvxOQadbULtYmK0vnrP49/9luf8Y27NhoL1o69iAascykaC+bZxXum
 bdN2NPrnGrngpvyOq98Jpcu30juyxu7XP0k2ZOOe5+JJXTVFS8cknw+A0Wff7Y7PGw
 F3b/k5j3Me8uIO0tbAawiwRDoyWF4BEcc3YGOUdg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 05/19] net/tap: rework net_tap_init()
Date: Fri, 19 Sep 2025 12:55:31 +0300
Message-ID: <20250919095545.1912042-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
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

In future (to support live-TAP migration with fds passing through
unix socket) we'll want to postpone fd-initialization to the later
point, when QAPI structured parameters are not available. So, let's
now rework the function to interface without "tap" parameter.

Also, rename to net_tap_open(), as it's just a wrapper on tap_open(),
and having net_tap_init() and net_init_tap() functions in one file
is confusing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index e268d79a97..1e5eaae6e7 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -643,20 +643,12 @@ int net_init_bridge(const Netdev *netdev, const char *name,
     return 0;
 }
 
-static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
+static int net_tap_open(int *vnet_hdr, bool vnet_hdr_required,
                         const char *setup_script, char *ifname,
                         size_t ifname_sz, int mq_required, Error **errp)
 {
     Error *err = NULL;
-    int fd, vnet_hdr_required;
-
-    if (tap->has_vnet_hdr) {
-        *vnet_hdr = tap->vnet_hdr;
-        vnet_hdr_required = *vnet_hdr;
-    } else {
-        *vnet_hdr = 1;
-        vnet_hdr_required = 0;
-    }
+    int fd;
 
     fd = RETRY_ON_EINTR(tap_open(ifname, ifname_sz, vnet_hdr, vnet_hdr_required,
                       mq_required, errp));
@@ -973,6 +965,8 @@ free_fail:
     } else {
         g_autofree char *default_script = NULL;
         g_autofree char *default_downscript = NULL;
+        bool vnet_hdr_required = tap->has_vnet_hdr && tap->vnet_hdr;
+
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
             return -1;
@@ -993,7 +987,9 @@ free_fail:
         }
 
         for (i = 0; i < queues; i++) {
-            fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? "no" : script,
+            vnet_hdr = tap->has_vnet_hdr ? tap->vnet_hdr : 1;
+            fd = net_tap_open(&vnet_hdr, vnet_hdr_required,
+                              i >= 1 ? "no" : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
                 return -1;
-- 
2.48.1



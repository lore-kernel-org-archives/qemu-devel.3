Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D18E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoAV-0007Ga-3k; Wed, 18 Feb 2026 15:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA8-00075p-Vu
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:45 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA7-0007tj-Bl
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:44 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2292BC038D;
 Wed, 18 Feb 2026 23:28:42 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:53d::1:1b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VShB144A8iE0-NPmEUsve; Wed, 18 Feb 2026 23:28:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771446521;
 bh=1uN4WvXdRNNARpB5HjLnfN38lT4cspiFjdLpr7Detyk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=m4aUnT4fF6x8KBJBFEJBfsIm8ag45cX0CvMHgP6dNMawhMnCJF4sbJqmhS+PwXB7/
 V5Ok09yGN+/aqRgMxEXiFJoimX3qbzhy2zmK4Kvn442sv/U4ag6TXyprvS1G7kjVxk
 6K0kdFuHf0JFHdZj5XmgLwbGK0qdqs8ZylGw378w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v3 12/12] net/tap: net_init_tap(): relax QEMU hubs check
Date: Wed, 18 Feb 2026 23:28:28 +0300
Message-ID: <20260218202829.1322088-13-vsementsov@yandex-team.ru>
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

queues may be set to 1, as well as fds may contain only one fd.
No reason to block such cases. Let's check exactly number of queues.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2318158adc..1623ddff5f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -868,13 +868,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
 
-    /* QEMU hubs do not support multiqueue tap, in this case peer is set.
-     * For -netdev, peer is always NULL. */
-    if (peer && (tap->has_queues || tap->fds || tap->vhostfds)) {
-        error_setg(errp, "Multiqueue tap cannot be used with hubs");
-        return -1;
-    }
-
     if (tap->has_vhost && !tap->vhost && (tap->vhostfds || tap->vhostfd)) {
         error_setg(errp, "vhostfd(s)= is not valid without vhost");
         return -1;
@@ -898,6 +891,15 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    /*
+     * QEMU hubs do not support multiqueue tap, in this case peer is set.
+     * For -netdev, peer is always NULL.
+     */
+    if (peer && queues > 1) {
+        error_setg(errp, "Multiqueue tap cannot be used with hubs");
+        goto fail;
+    }
+
     if (!tap_parse_vhost_fds(tap, &vhost_fds, queues, errp)) {
         goto fail;
     }
-- 
2.52.0



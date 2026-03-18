Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334DB103E162
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2p8g-0006mu-Ka; Wed, 18 Mar 2026 07:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8G-0006iW-Kg
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:12 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8E-0001yj-Rt
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1777C80931;
 Wed, 18 Mar 2026 14:32:08 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:431::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kVLGYB2A1mI0-gXUsUpeG; Wed, 18 Mar 2026 14:32:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773833527;
 bh=9AgfRYX0N12OlYIt06F0KsC5casw9S0C0w4WHyS+QNw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=gsS6Gb3m1LGlKH6aL5Wal2vgxZ/9kEoC7awbipPY1fc4Y/9om5ohtdp8hMfAHtPKZ
 /G6++ne2E91QC7cSL4WyErtIYweLljUqLOKB9rEVhCvyvrt3NdSorGqcKdAYwVxIol
 gpdS3/TndAUIUYl0aRpdA03IPSPeDbH10tMxAt8M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v4 12/13] net/tap: net_init_tap(): relax QEMU hubs check
Date: Wed, 18 Mar 2026 14:31:42 +0300
Message-ID: <20260318113144.15697-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318113144.15697-1-vsementsov@yandex-team.ru>
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
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
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index c6bf8a70429..e464f62b473 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -869,13 +869,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -899,6 +892,15 @@ int net_init_tap(const Netdev *netdev, const char *name,
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



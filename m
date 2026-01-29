Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F05D73E83
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZcv-0001bj-Kg; Thu, 29 Jan 2026 16:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZcs-0001Wt-Mx
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:32:30 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vlZcr-0001A7-36
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 16:32:30 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C3F5D80825;
 Fri, 30 Jan 2026 00:32:27 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:b74::1:d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IWrbZO5AAOs0-kRxMHty8; Fri, 30 Jan 2026 00:32:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769722347;
 bh=tJU74EzZ7JQor/gV3yKFw+7CycBwudsDBROnC+1h/Os=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=sb5GNQOLsKat7qk3cFFkkJ/SLrtMVhWjGtz+pE9WIM9+1QleASsfm3BbsFYBYgJTq
 x8bo8sFxQYuEkIMXhw/04zM0mJqQi3U3LCZl5k+RhnuU9m1rPbpvGNnzCahUWPU/SQ
 1alG+jNMY+oLNvvEFUv/Xmswo3V26uQfJDzNXLLs=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v2 12/12] net/tap: net_init_tap(): relax QEMU hubs check
Date: Fri, 30 Jan 2026 00:32:14 +0300
Message-ID: <20260129213215.1405459-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
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
---
 net/tap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index c6bea0dcab..288cfedd81 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -870,13 +870,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -900,6 +893,15 @@ int net_init_tap(const Netdev *netdev, const char *name,
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



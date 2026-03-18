Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D96C103E162
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2p8g-0006ms-Ag; Wed, 18 Mar 2026 07:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8F-0006iL-0g
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:12 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p8C-0001yW-7O
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id ABC8E8092A;
 Wed, 18 Mar 2026 14:32:06 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:431::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kVLGYB2A1mI0-VgjVXju5; Wed, 18 Mar 2026 14:32:06 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773833526;
 bh=SCMUEfgwzBo5lqdiV3+5ZE7Kb+6mvaw4LsLNt2Uqqto=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=KRYngMPJ3GK4zTPSXJNv0Ge8CQIPgCeCCRtfbPHKePysyNNiNVVT9MYY8bMcG/641
 k/patQXPOK+oztu53IwIsBFFZYdCd7+9+PTsGZGAdfci0ImU29f9Po+KxbHJPpTL9N
 fB5NkTpowLhOoYDOiDcnMk0fenXLVDV3UseVmbQ0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v4 11/13] net/tap: net_init_tap(): merge fd=,
 fds= and helper= cases into one
Date: Wed, 18 Mar 2026 14:31:41 +0300
Message-ID: <20260318113144.15697-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318113144.15697-1-vsementsov@yandex-team.ru>
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now fd= and helper= cases are just a duplication of fds= case with
queues=1. Let's merge them all.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index d5a719150b4..c6bf8a70429 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -903,19 +903,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         goto fail;
     }
 
-    if (tap->fd) {
-        vnet_hdr = tap_probe_vnet_hdr(fds[0], errp);
-        if (vnet_hdr < 0) {
-            goto fail;
-        }
-
-        if (!net_init_tap_one(tap, peer, name, NULL,
-                              NULL, NULL,
-                              vhost_fds ? vhost_fds[0] : -1,
-                              vnet_hdr, fds[0], errp)) {
-            goto fail;
-        }
-    } else if (tap->fds) {
+    if (fds) {
         for (i = 0; i < queues; i++) {
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fds[i], errp);
@@ -935,18 +923,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto fail;
             }
         }
-    } else if (tap->helper) {
-        vnet_hdr = tap_probe_vnet_hdr(fds[0], errp);
-        if (vnet_hdr < 0) {
-            goto fail;
-        }
-
-        if (!net_init_tap_one(tap, peer, name, ifname,
-                              NULL, NULL,
-                              vhost_fds ? vhost_fds[0] : -1,
-                              vnet_hdr, fds[0], errp)) {
-            goto fail;
-        }
     } else {
         g_autofree char *script =
             tap_parse_script(tap->script, DEFAULT_NETWORK_SCRIPT);
-- 
2.52.0



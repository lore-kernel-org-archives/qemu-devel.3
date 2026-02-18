Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E53E9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoAU-0007GP-EU; Wed, 18 Feb 2026 15:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA8-00075g-5d
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:45 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA6-0007tY-MR
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:43 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6C8E9C038C;
 Wed, 18 Feb 2026 23:28:41 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:53d::1:1b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VShB144A8iE0-4IIiAMgl; Wed, 18 Feb 2026 23:28:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771446521;
 bh=tdVLrrht22AdazOVmFV4FQPo+VPPK0JuvaulnDvvKJQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=MZ3L/2GeHBxmyGcUBxwxqMLfAj9D4dfSYr55jCEKdXgOhPLc8cE6Go17Bs+75DXnF
 Lfa42Wz/7Q3J6ZcU/Y/xivneVsVXzJtKJrFd3brx72CV6yYh4k9ZgrdjfvMia26CEn
 ENJX5pDqyf374TUb9hC0K+UNZAwiIN2Et+yxmSBI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v3 11/12] net/tap: net_init_tap(): merge fd=,
 fds= and helper= cases into one
Date: Wed, 18 Feb 2026 23:28:27 +0300
Message-ID: <20260218202829.1322088-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 net/tap.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 64164643d2..2318158adc 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -902,19 +902,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -934,18 +922,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
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



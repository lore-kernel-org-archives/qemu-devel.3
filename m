Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9295CCA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vp-0001Mg-Jp; Mon, 18 Aug 2025 10:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vm-0001Ki-0v
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:58 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vh-0002BG-Gf
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D0D9E807C1;
 Mon, 18 Aug 2025 17:06:49 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-6aiJhMKd; Mon, 18 Aug 2025 17:06:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526009;
 bh=dzrHb42O8oLXErFY753Ty76lZhfPJm8FI957hSrKvWE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=T+BR+guCTKjushJwdeArJUY7q5ljg0kBCYAGu3Nqp/Iz+LgiFMtFSkrvR+JCBVLho
 3aEMTpUvu4xj/c0IrPUTSbfRADA1I1h1vjPT6bwpUAxcnmTjibLNNwj/wk5GC9ztoI
 2WDGAG5kcu7cYu7u801pckTyQRvZl/Fe/qCVlam8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 07/19] net/tap: net_init_tap(): drop extra variable vhostfdname
Date: Mon, 18 Aug 2025 17:06:33 +0300
Message-ID: <20250818140645.27904-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
Precedence: list
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 042f9fd01a..ade58826c8 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -808,14 +808,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
     /* for the no-fd, no-helper case */
     const char *script;
     const char *downscript;
-    const char *vhostfdname;
     char ifname[128];
     int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
     queues = tap->has_queues ? tap->queues : 1;
-    vhostfdname = tap->vhostfd;
     script = tap->script;
     downscript = tap->downscript;
 
@@ -864,7 +862,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         ret = net_init_tap_one(tap, peer, "tap", name, NULL,
                                script, downscript,
-                               vhostfdname, vnet_hdr, fd, errp);
+                               tap->vhostfd, vnet_hdr, fd, errp);
         if (ret < 0) {
             return -1;
         }
@@ -960,7 +958,7 @@ free_fail:
         }
 
         ret = net_init_tap_one(tap, peer, "bridge", name, ifname,
-                               script, downscript, vhostfdname,
+                               script, downscript, tap->vhostfd,
                                vnet_hdr, fd, errp);
         if (ret < 0) {
             close(fd);
@@ -1006,7 +1004,7 @@ free_fail:
             ret = net_init_tap_one(tap, peer, "tap", name, ifname,
                                    i >= 1 ? "no" : script,
                                    i >= 1 ? "no" : downscript,
-                                   vhostfdname, vnet_hdr, fd, errp);
+                                   tap->vhostfd, vnet_hdr, fd, errp);
             if (ret < 0) {
                 close(fd);
                 return -1;
-- 
2.48.1



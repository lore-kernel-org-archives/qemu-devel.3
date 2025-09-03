Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F14CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmwH-000690-AS; Wed, 03 Sep 2025 08:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvu-0005v9-Us
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:50 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvr-0000l0-5z
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 236CEC017A;
 Wed, 03 Sep 2025 15:49:39 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-hRIIFvm5; Wed, 03 Sep 2025 15:49:38 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903778;
 bh=DXiTub6n46qqRlyBIU99aj/5sFkwYYFFft1ze3TubgU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=jy2ZU4OHG2Ke4hzP/DmU+VbfW0D0QLhbZXsipntkumGN3P8ynpopn+euYSpKeZrkp
 S6Tm/y6Kvrhmev8pv/kYB/YUVkCXsRVeipncUU1ytzSr8G6ZhYzYXo+eA8scqvn6vt
 0uVa+PaihUqa1HnT5qWhihvj7dd35S5Y4Pf2/v5U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 03/19] net/tap: net_init_tap_one(): drop extra error
 propagation
Date: Wed,  3 Sep 2025 15:49:17 +0300
Message-ID: <20250903124934.1169899-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
References: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 9793c7ab40..78ddd3d0cd 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -685,7 +685,6 @@ static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                             const char *downscript, const char *vhostfdname,
                             int vnet_hdr, int fd, Error **errp)
 {
-    Error *err = NULL;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int vhostfd;
 
@@ -721,9 +720,8 @@ static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
 
         if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, &err);
+            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
             if (vhostfd == -1) {
-                error_propagate(errp, err);
                 goto failed;
             }
             if (!qemu_set_blocking(vhostfd, false, errp)) {
-- 
2.48.1



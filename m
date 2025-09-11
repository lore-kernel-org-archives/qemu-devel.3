Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFC8CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwkVu-0002la-CZ; Thu, 11 Sep 2025 12:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVs-0002jM-4U
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:12 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVq-0004AR-49
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 50C418071E;
 Thu, 11 Sep 2025 19:51:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2pOVKM0Fka60-Ufp6dNmx; Thu, 11 Sep 2025 19:51:05 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757609465;
 bh=D73cNTnWcybuDLyY0oDLUZRiSjUAGGTfs8skyWxc7BU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Zjf2a+MZGInMLUkd6zMbzS0Z1JVjln75+baBOK5SiwAnxlbDgcGGlbicQJWeHJmJE
 f1B/6akch44jtZ3YryEy9ZV2r81dSnABsfvDG3nfPO8mZKi/R4ejVvwxE+OzG3XyRt
 EygMWlZ6xcedpDZvfjgOaNzc9mpsmUP9svrpBDuU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 davydov-max@yandex-team.ru
Subject: [PATCH v4 3/8] net/tap: net_init_tap_one(): drop extra error
 propagation
Date: Thu, 11 Sep 2025 19:50:56 +0300
Message-ID: <20250911165101.1637608-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
References: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2ffd8c9907..49d4a29beb 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -686,7 +686,6 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *downscript, const char *vhostfdname,
                              int vnet_hdr, int fd, Error **errp)
 {
-    Error *err = NULL;
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int vhostfd;
 
@@ -728,9 +727,8 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
 
         if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, &err);
+            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
             if (vhostfd == -1) {
-                error_propagate(errp, err);
                 goto failed;
             }
             if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-- 
2.48.1



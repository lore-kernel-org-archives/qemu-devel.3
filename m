Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A24EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDow-0004ku-Sd; Mon, 29 Jun 2026 11:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1weDor-0004jR-6n
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:22:45 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1weDop-0007FT-6t
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 11:22:44 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1b:16:0:640:bc52:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 0B97E8079A;
 Mon, 29 Jun 2026 18:22:39 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:946::1:3])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id cMftTDBgRKo0-KoWdBg26; Mon, 29 Jun 2026 18:22:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1782746558;
 bh=oqkkpCoE5ZGvG4Dcwt9jIJDkcTJAxTQ0oiFktD4+/c4=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=HYyJjuVeAixUwyFcS+caSYSYLCeVdMvCeMG02NaATa1EQ3LoGvwPksp5V98xnDDm1
 wHi6Y5SqjNZQ5XpXzbFB55Wrbb58hsDqrtKW7ScOrQXSIkc1RYtsGhXn/pP82Qxh5/
 sXRRjtWV+X8yakLzYt+Fkh4K3F1VY9AyAtYA2SVU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, peter.maydell@linaro.org
Subject: [PATCH] net/tap: check for fd == -1 on failure path
Date: Mon, 29 Jun 2026 18:22:34 +0300
Message-ID: <20260629152234.847885-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
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
Precedence: list
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

Coverity doesn't like closing invalid fds, let's satisfy it.
We initialize fd to -1 at function start, and don't set it
on some failure paths, so Coverity is right actually.

CID: 160042
Fixes: 11d0e070a6 ("net/tap: net_init_tap(): common fail label")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 57ffb09885..64d6e8e82d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -968,7 +968,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
     return 0;
 
 fail:
-    close(fd);
+    if (fd != -1) {
+        close(fd);
+    }
     net_free_fds(fds, queues);
     net_free_fds(vhost_fds, queues);
     return -1;
-- 
2.43.0



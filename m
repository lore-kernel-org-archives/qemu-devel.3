Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F58CC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 12:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdS3h-0007SZ-TQ; Sat, 27 Jun 2026 08:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wdS3d-0007Rw-5c
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 08:22:49 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wdS3a-0004AT-Ar
 for qemu-devel@nongnu.org; Sat, 27 Jun 2026 08:22:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a25:0:640:ba29:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2B9AC80763;
 Sat, 27 Jun 2026 15:22:39 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:922::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id bMaCBF9i80U0-CzBNUtGl; Sat, 27 Jun 2026 15:22:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1782562958;
 bh=U0eR0zUF+4IeJccba8LOz5mNa6euCYG3wARnp1L+d0w=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=n7qI0GmXjk5J5Nm6CHXuGSXgvS6XsuDfyEvZBrEans0j/dMNnXr7xhUQRrqxoNDSS
 4XXKW8y63vD5eC+mCvrZusbwCe12a7J5ieLszixcB9kL5WA9LdX2GyyUKR2PCjIjjz
 CdSChW9ulohqnn4soOwKCXa2YPDXx/etjcgkmx6c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH] runstate: don't move to prelaunch on reset if postmigrate
Date: Sat, 27 Jun 2026 15:22:34 +0300
Message-ID: <20260627122234.657179-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
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

As comment says, runstate can change in parallel. We check
for FINISH_MIGRATE, but actually migration may proceed up
to POSTMIGRATE.

We should check for POSTMIGRATE as well, otherwise there is
a race, if reset is in progress, and source may finish migration
in PRELAUNCH state, which is unexpected for user.

Seems correct to handle POSTMIGRATE the same way as FINISH_MIGRATE
in this logic, as POSTMIGRATE is continuation for FINISH_MIGRATE.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 system/runstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 18e585be47..cee1aeae05 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -921,7 +921,8 @@ static bool main_loop_should_exit(int *status)
          */
         if (!runstate_check(RUN_STATE_RUNNING) &&
                 !runstate_check(RUN_STATE_INMIGRATE) &&
-                !runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+                !runstate_check(RUN_STATE_FINISH_MIGRATE) &&
+                !runstate_check(RUN_STATE_POSTMIGRATE)) {
             runstate_set(RUN_STATE_PRELAUNCH);
         }
     }
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BAEC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2az6-000398-BB; Fri, 04 Sep 2026 16:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az4-00038a-JN
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:02 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az1-0007wD-IH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:02 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id BAACF8078E;
 Fri, 04 Sep 2026 23:57:54 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rvQjs41YPqM0-buNIuilX; Fri, 04 Sep 2026 23:57:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788555474;
 bh=obUfxhc4vFAow+0ul9iMmZXRbP4zBRL4hPDfuYCs1+Y=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=T8e9Dwn+3UGHeWzG29z2wTMEuPrDsuKp7h6k5oKShwdV8Ibn6w2D6yjuLa2NkygfH
 /Oo7QBR3GlOHoXbcP17CVSriI7CUR3VwdhO0LDpBNCwmFoGniW7EyAPZq8QsMQAlWi
 Uat+KGus3P6ZUrg6hN0VTo04RvuecCriaiT4Na3o=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 2/6] runstate: treat SHUTDOWN_CAUSE_HOST_UI as force_shutdown
Date: Fri,  4 Sep 2026 23:57:45 +0300
Message-ID: <20260904205749.510493-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904205749.510493-1-vsementsov@yandex-team.ru>
References: <20260904205749.510493-1-vsementsov@yandex-team.ru>
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

Like QMP quit and host signals, UI shutdown requests force QEMU to
exit by setting shutdown_action to SHUTDOWN_ACTION_POWEROFF.
Set force_shutdown for these requests as well.

The only consumer of qemu_force_shutdown_requested() is the
vhost-user-blk stop code. When configured to skip synchronization
during forced shutdown, it should do so for UI shutdown requests
just as it does for QMP quit and host signals.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 system/runstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 6bb839b3c0d..1958168e778 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -979,7 +979,8 @@ static void qemu_system_shutdown_request_safe(ShutdownCause reason)
 {
     shutdown_requested = reason;
     if (reason == SHUTDOWN_CAUSE_HOST_QMP_QUIT ||
-        reason == SHUTDOWN_CAUSE_HOST_SIGNAL) {
+        reason == SHUTDOWN_CAUSE_HOST_SIGNAL ||
+        reason == SHUTDOWN_CAUSE_HOST_UI) {
         force_shutdown = true;
     }
     qemu_notify_event();
-- 
2.43.0



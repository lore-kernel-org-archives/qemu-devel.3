Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F98C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2az6-000397-DB; Fri, 04 Sep 2026 16:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az3-00037z-8r
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:01 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az1-0007wQ-7G
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:01 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 2AA4F80A59;
 Fri, 04 Sep 2026 23:57:55 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rvQjs41YPqM0-QOmqgnw5; Fri, 04 Sep 2026 23:57:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788555474;
 bh=EfOJFPjSgVcjOFLAMnKLU9sPtYfAKnhoVr3oXGmPviI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=PxsKuONW5qFDze3rJqfpnB0TZwLiXUIW1MVQOy1D/tPqWiwy8ccn+2545+/4IPfMD
 zlZqCtuuKxcSBwGta9Vh+xM7r4wigBxfWi2psIuF3u7YIECWI0U7zDJI4bJgnpPN11
 iXkdJGr0ZejDCvZWMzHSXkuqcWgbJFfJUx0D6EyA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 3/6] runstate: inline qemu_shutdown_requested()
Date: Fri,  4 Sep 2026 23:57:46 +0300
Message-ID: <20260904205749.510493-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904205749.510493-1-vsementsov@yandex-team.ru>
References: <20260904205749.510493-1-vsementsov@yandex-team.ru>
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

The function has only one caller. Inline it to simplify the
upcoming refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 system/runstate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index 1958168e778..01f936649b4 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -597,11 +597,6 @@ ShutdownCause qemu_reset_requested_get(void)
     return reset_requested;
 }
 
-static int qemu_shutdown_requested(void)
-{
-    return qatomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
-}
-
 static void qemu_kill_report(void)
 {
     if (!qtest_driver() && shutdown_signal) {
@@ -1054,7 +1049,7 @@ static bool main_loop_should_exit(int *status)
     if (qemu_suspend_requested()) {
         qemu_system_suspend();
     }
-    request = qemu_shutdown_requested();
+    request = qatomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
     if (request) {
         qemu_kill_report();
         qemu_system_shutdown(request);
-- 
2.43.0



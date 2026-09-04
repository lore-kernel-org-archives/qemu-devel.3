Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB893C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2az4-00038L-Hh; Fri, 04 Sep 2026 16:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az3-000380-9b
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:01 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az1-0007w7-7t
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:01 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 59F32807B0;
 Fri, 04 Sep 2026 23:57:54 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rvQjs41YPqM0-ei1dEAG6; Fri, 04 Sep 2026 23:57:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788555474;
 bh=bedHR9LEwKO84C89vQwYCYbjLl7t6GtzAgZ2vPETCyQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=E86LoHp/3CN5PuxkJ08KcdQku5K9kV8OihUJNKlg0O++H4ui2hQvuyOzLdWnwYSrE
 tKnuq1kRfh10rpLqbFEO7PFqEvGtLPQn/rlYnRimEtsn3qYp1HEacUGRJA7atrhdti
 Zbg8pvVJaCjWBvFmtEguBPYPIgjn+WQF6tSOKqSM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 1/6] runstate: introduce qemu_system_shutdown_request_safe()
 helper
Date: Fri,  4 Sep 2026 23:57:44 +0300
Message-ID: <20260904205749.510493-2-vsementsov@yandex-team.ru>
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

Extract the signal-safe part of qemu_system_shutdown_request() into
a helper and reuse it in qemu_system_killed().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 system/runstate.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/system/runstate.c b/system/runstate.c
index d3e64d2b625..6bb839b3c0d 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -970,18 +970,34 @@ bool qemu_wakeup_suspend_enabled(void)
     return wakeup_suspend_enabled;
 }
 
+/*
+ * Signal-safe part of qemu_system_shutdown_request(),
+ * only to be called from qemu_system_killed().
+ * Other callers use qemu_system_shutdown_request().
+ */
+static void qemu_system_shutdown_request_safe(ShutdownCause reason)
+{
+    shutdown_requested = reason;
+    if (reason == SHUTDOWN_CAUSE_HOST_QMP_QUIT ||
+        reason == SHUTDOWN_CAUSE_HOST_SIGNAL) {
+        force_shutdown = true;
+    }
+    qemu_notify_event();
+}
+
+void qemu_system_shutdown_request(ShutdownCause reason)
+{
+    trace_qemu_system_shutdown_request(reason);
+    replay_shutdown_request(reason);
+    qemu_system_shutdown_request_safe(reason);
+}
+
 void qemu_system_killed(int signal, pid_t pid)
 {
     shutdown_signal = signal;
     shutdown_pid = pid;
     shutdown_action = SHUTDOWN_ACTION_POWEROFF;
-
-    /* Cannot call qemu_system_shutdown_request directly because
-     * we are in a signal handler.
-     */
-    shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;
-    force_shutdown = true;
-    qemu_notify_event();
+    qemu_system_shutdown_request_safe(SHUTDOWN_CAUSE_HOST_SIGNAL);
 }
 
 void qemu_system_shutdown_request_with_code(ShutdownCause reason,
@@ -991,17 +1007,6 @@ void qemu_system_shutdown_request_with_code(ShutdownCause reason,
     qemu_system_shutdown_request(reason);
 }
 
-void qemu_system_shutdown_request(ShutdownCause reason)
-{
-    trace_qemu_system_shutdown_request(reason);
-    replay_shutdown_request(reason);
-    shutdown_requested = reason;
-    if (reason == SHUTDOWN_CAUSE_HOST_QMP_QUIT) {
-        force_shutdown = true;
-    }
-    qemu_notify_event();
-}
-
 static void qemu_system_powerdown(void)
 {
     qapi_event_send_powerdown();
-- 
2.43.0



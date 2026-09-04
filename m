Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BCDC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2az7-00039f-Vk; Fri, 04 Sep 2026 16:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az4-00038r-TV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:02 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x2az1-0007xv-Au
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:58:02 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:43a8:0:640:574d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 116A28065E;
 Fri, 04 Sep 2026 23:57:58 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:4d::1:17])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rvQjs41YPqM0-bhiDhsXJ; Fri, 04 Sep 2026 23:57:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788555477;
 bh=VCxyERGgPaGRWK8x8tRvFf5jF5AfliI97ZERz5vYK1g=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=beaRtdzNEqO5jfg1/lGWDlBDoTruNqcmu9ij5H3LGDKKq0UZpzv9HN/ryU+SaCZ1Q
 G8iKwa+FApzs+uxXvq5FsPrCV5o/TJFZpGfvsszGXOuqKyWmLe0TF7pTXz80h6P9Lh
 PMyIF4dIY8PNVyD9Eb673PURrVbzElqpDMLPIcZk=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 5/6] runstate: separate forced and regular shutdown requests
Date: Fri,  4 Sep 2026 23:57:48 +0300
Message-ID: <20260904205749.510493-6-vsementsov@yandex-team.ru>
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

QMP quit, host signals and UI shutdown requests force QEMU to exit
by setting shutdown_action to SHUTDOWN_ACTION_POWEROFF.

This can race with guest shutdown processing. With -no-shutdown,
consider the following sequence:

1. Management sends system_powerdown, then sends SIGTERM after
   waiting for the guest to shut down.
2. QEMU starts processing a guest shutdown request.
3. SIGTERM arrives after qemu_kill_report(), while QEMU is sending
   the guest SHUTDOWN event.
4. The signal handler changes shutdown_action to POWEROFF, so QEMU
   exits instead of pausing.

Management receives SHUTDOWN with guest=true, but QEMU exits despite
-no-shutdown, without reporting a host SHUTDOWN event or printing
the signal diagnostic.

Store forced and regular shutdown requests separately, and decide
whether to exit based on the request being processed. Leave
shutdown_action under user control. A forced request arriving while
a regular request is being processed remains pending for the next
main loop iteration.

Keep qemu_shutdown_requested() checking both kinds of requests for
its Xen caller.

There is no need to clear shutdown_force_requested with qatomic_xchg():
processing a forced shutdown request always exits the main loop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 monitor/qmp-cmds.c |  1 -
 system/runstate.c  | 24 ++++++++++++++++--------
 ui/cocoa.m         |  1 -
 ui/sdl2.c          |  2 --
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 7525a88e049..6d0ba75ff16 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -44,7 +44,6 @@ NameInfo *qmp_query_name(Error **errp)
 
 void qmp_quit(Error **errp)
 {
-    shutdown_action = SHUTDOWN_ACTION_POWEROFF;
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP_QUIT);
 }
 
diff --git a/system/runstate.c b/system/runstate.c
index 2b28e2a30e2..5d10ff0df99 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -564,9 +564,9 @@ int vm_stop_force_state(RunState state)
 
 static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
+static ShutdownCause shutdown_force_requested;
 static int shutdown_exit_code = EXIT_SUCCESS;
 static int shutdown_signal;
-static bool force_shutdown;
 static pid_t shutdown_pid;
 static int powerdown_requested;
 static int debug_requested;
@@ -584,12 +584,12 @@ static uint32_t wakeup_reason_mask = ~(1 << QEMU_WAKEUP_REASON_NONE);
 
 bool qemu_shutdown_requested(void)
 {
-    return shutdown_requested;
+    return shutdown_requested || shutdown_force_requested;
 }
 
 bool qemu_force_shutdown_requested(void)
 {
-    return force_shutdown;
+    return shutdown_force_requested;
 }
 
 ShutdownCause qemu_reset_requested_get(void)
@@ -972,11 +972,12 @@ bool qemu_wakeup_suspend_enabled(void)
  */
 static void qemu_system_shutdown_request_safe(ShutdownCause reason)
 {
-    shutdown_requested = reason;
     if (reason == SHUTDOWN_CAUSE_HOST_QMP_QUIT ||
         reason == SHUTDOWN_CAUSE_HOST_SIGNAL ||
         reason == SHUTDOWN_CAUSE_HOST_UI) {
-        force_shutdown = true;
+        shutdown_force_requested = reason;
+    } else {
+        shutdown_requested = reason;
     }
     qemu_notify_event();
 }
@@ -992,7 +993,6 @@ void qemu_system_killed(int signal, pid_t pid)
 {
     shutdown_signal = signal;
     shutdown_pid = pid;
-    shutdown_action = SHUTDOWN_ACTION_POWEROFF;
     qemu_system_shutdown_request_safe(SHUTDOWN_CAUSE_HOST_SIGNAL);
 }
 
@@ -1042,6 +1042,7 @@ static bool main_loop_should_exit(int *status)
 {
     RunState r;
     ShutdownCause request;
+    bool force = false;
 
     if (qemu_debug_requested()) {
         vm_stop(RUN_STATE_DEBUG);
@@ -1049,11 +1050,18 @@ static bool main_loop_should_exit(int *status)
     if (qemu_suspend_requested()) {
         qemu_system_suspend();
     }
-    request = qatomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
+
+    if (shutdown_force_requested) {
+        force = true;
+        request = shutdown_force_requested;
+    } else {
+        request = qatomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
+    }
+
     if (request) {
         qemu_kill_report();
         qemu_system_shutdown(request);
-        if (shutdown_action == SHUTDOWN_ACTION_PAUSE) {
+        if (!force && shutdown_action == SHUTDOWN_ACTION_PAUSE) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
             if (shutdown_exit_code != EXIT_SUCCESS) {
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 3751be37922..5447fb637ad 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1221,7 +1221,6 @@ - (void)applicationWillTerminate:(NSNotification *)aNotification
     COCOA_DEBUG("QemuCocoaAppController: applicationWillTerminate\n");
 
     with_bql(^{
-        shutdown_action = SHUTDOWN_ACTION_POWEROFF;
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
     });
 
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 1c97d23a47c..d647905a379 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -645,7 +645,6 @@ static void handle_windowevent(SDL_Event *ev)
                 allow_close = false;
             }
             if (allow_close) {
-                shutdown_action = SHUTDOWN_ACTION_POWEROFF;
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
             }
         } else {
@@ -692,7 +691,6 @@ void sdl2_poll_events(struct sdl2_console *scon)
                 allow_close = false;
             }
             if (allow_close) {
-                shutdown_action = SHUTDOWN_ACTION_POWEROFF;
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
             }
             break;
-- 
2.43.0



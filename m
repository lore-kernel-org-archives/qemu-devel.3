Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C428CD111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfsh-0004Tb-2z; Thu, 27 Nov 2025 12:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsb-0004Rl-TH
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:05 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOfsW-0001GL-Po
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:34:04 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7213680DF2;
 Thu, 27 Nov 2025 20:33:57 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:834::1:7])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rXiJgL0F7Os0-QM1lMLMF; Thu, 27 Nov 2025 20:33:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764264837;
 bh=6vx3WhUktEBcatqeazVbFbGZoG58FOOHtw8XzeX1II8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ITvSI1GaRss+iwKWRSeTF0cgc/Ff62rOXTEzm04ExAGCGCdNwBVJinS5LSrP5McUX
 AymT//hriMWJ6/Y/GCmYRwg2UEY5luV1y2gIX4LjcM5t32YOcwS/ofSro31Nm9iadL
 0tYkaAcDQpNWj/BLEI061IgFhW1iSvhxWcEvyL4Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: dave@treblig.org,
	armbru@redhat.com
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH 4/5] error: print error_report timestamp when QMP monitor is
 active
Date: Thu, 27 Nov 2025 20:33:51 +0300
Message-ID: <20251127173352.283731-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251127173352.283731-1-vsementsov@yandex-team.ru>
References: <20251127173352.283731-1-vsementsov@yandex-team.ru>
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

We skip printing timestamp when _any_ monitor is active. But
then, in production (where QMP is usually used) we lack timestamps
in logs.

Let's go a bit further, and use same logic to detect HMP monitor
in the whole util/error-report.c like in error_vprintf().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 stubs/monitor-core.c           |  5 +++++
 tests/unit/test-util-sockets.c |  1 +
 util/error-report.c            | 23 ++++++++++++++---------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 1894cdfe1f..275cb0cbfa 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -7,6 +7,11 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
+bool monitor_cur_is_hmp(void)
+{
+    return false;
+}
+
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 {
     return NULL;
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index ee66d727c3..4b7f408902 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -74,6 +74,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 Monitor *monitor_cur(void) { return cur_mon; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
+bool monitor_cur_is_hmp(void) { return false; }
 
 #ifndef _WIN32
 static void test_socket_fd_pass_name_good(void)
diff --git a/util/error-report.c b/util/error-report.c
index 1b17c11de1..7ffbcf2123 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -144,7 +144,7 @@ static void print_loc(void)
     int i;
     const char *const *argp;
 
-    if (!monitor_cur() && g_get_prgname()) {
+    if (!monitor_cur_is_hmp() && g_get_prgname()) {
         error_printf("%s:", g_get_prgname());
         sep = " ";
     }
@@ -188,15 +188,20 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 {
     gchar *timestr;
 
-    if (message_with_timestamp && !monitor_cur()) {
-        timestr = real_time_iso8601();
-        error_printf("%s ", timestr);
-        g_free(timestr);
-    }
+    if (!monitor_cur_is_hmp()) {
+        if (message_with_timestamp) {
+            timestr = real_time_iso8601();
+            error_printf("%s ", timestr);
+            g_free(timestr);
+        }
 
-    /* Only prepend guest name if -msg guest-name and -name guest=... are set */
-    if (error_with_guestname && error_guest_name && !monitor_cur()) {
-        error_printf("%s ", error_guest_name);
+        /*
+         * Only prepend guest name if -msg guest-name and -name guest=...
+         * are set.
+         */
+        if (error_with_guestname && error_guest_name) {
+            error_printf("%s ", error_guest_name);
+        }
     }
 
     print_loc();
-- 
2.48.1



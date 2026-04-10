Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C06CF459EF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBENW-0005BU-K2; Fri, 10 Apr 2026 12:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMk-0004B7-BG
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMi-0006XS-U3
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyf4Cmb2krQY4PLr2vKZ6i/tF7PVhVep/EsPhM+T6+M=;
 b=XaHLJKyj9vPEA83EGkxnFm36Vjzt6UAa/8P0e7TUkqsi//LKVdXjzqTWn/rHB1nwx1bzRH
 pHep0GZGOJ86csjvax08egi6lF3DB8suCFJP2bUwvUCIPhnRauw+qnYk0+ObjjBDWIG8sA
 vtFTZvZJYM5LpVQyrpGUd3hc0YMmkpQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-y6RQM880OuSjuz1ReLMIng-1; Fri,
 10 Apr 2026 12:05:50 -0400
X-MC-Unique: y6RQM880OuSjuz1ReLMIng-1
X-Mimecast-MFC-AGG-ID: y6RQM880OuSjuz1ReLMIng_1775837149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 649A81955E80; Fri, 10 Apr 2026 16:05:49 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17BC419560AB; Fri, 10 Apr 2026 16:05:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 12/17] monitor: drop unused monitor_cur_is_qmp
Date: Fri, 10 Apr 2026 17:04:53 +0100
Message-ID: <20260410160458.3778874-13-berrange@redhat.com>
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The previous patch dropped the only remaining use of
monitor_cur_is_qmp.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/monitor/monitor.h      |  1 -
 monitor/monitor.c              | 10 ----------
 stubs/monitor-core.c           |  5 -----
 tests/unit/test-util-sockets.c |  1 -
 4 files changed, 17 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 7b0bda42c4..f66e465775 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -25,7 +25,6 @@ extern QemuOptsList qemu_mon_opts;
 
 Monitor *monitor_cur(void);
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
-bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 1326069b79..a3e69b3cec 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -131,16 +131,6 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return old_monitor;
 }
 
-/**
- * Is the current monitor, if any, a QMP monitor?
- */
-bool monitor_cur_is_qmp(void)
-{
-    Monitor *cur_mon = monitor_cur();
-
-    return cur_mon && monitor_is_qmp(cur_mon);
-}
-
 /**
  * Is @mon is using readline?
  * Note: not all HMP monitors use readline, e.g., gdbserver has a
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 078a5012e9..a7c32297c9 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -7,11 +7,6 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
-bool monitor_cur_is_qmp(void)
-{
-    return false;
-}
-
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 {
     return NULL;
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index b9f2453e29..ee66d727c3 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -74,7 +74,6 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 Monitor *monitor_cur(void) { return cur_mon; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
-bool monitor_cur_is_qmp(void) { abort(); };
 
 #ifndef _WIN32
 static void test_socket_fd_pass_name_good(void)
-- 
2.53.0



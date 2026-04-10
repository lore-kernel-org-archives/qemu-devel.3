Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7360CF459F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEMh-00047w-9i; Fri, 10 Apr 2026 12:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMN-000407-4G
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMJ-0006PM-DR
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/ymzSVFiDdbZziVAA2OJ+MKr20f95MwjR7x1NCCHUE=;
 b=JHhzcTwDerGki4OsrKoKLT5aCyuWbzzyGNGz3eFYrrwkYr2gWStdhz1MTK7MEz3iK6x+Az
 ZiLzRJ1s7lVEN3OHFsgsFox3H+6NZgpQYNIXigTx8kvtfQHeDjMCeMQ5oONJ4Yl9nN5oBh
 eGNLfDzUUSXsLFLI7U8F7HIlG+nR0es=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-KPtk6W_MM2yZrIw5iqzi9g-1; Fri,
 10 Apr 2026 12:05:24 -0400
X-MC-Unique: KPtk6W_MM2yZrIw5iqzi9g-1
X-Mimecast-MFC-AGG-ID: KPtk6W_MM2yZrIw5iqzi9g_1775837122
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEAFB195608F; Fri, 10 Apr 2026 16:05:22 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4706B19560AB; Fri, 10 Apr 2026 16:05:19 +0000 (UTC)
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
Subject: [PATCH 05/17] monitor: remove 'skip_flush' field
Date: Fri, 10 Apr 2026 17:04:46 +0100
Message-ID: <20260410160458.3778874-6-berrange@redhat.com>
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The 'skip_flush' field is set on the dummy throwaway HMP monitor
object created by QMP's  'human-monitor-command', as an indication
not to try to write data to the chardev. Instead the QMP command
impl will grab the data straight out of the in-memory buffer.

The flag is redundant, however, as the monitor code could instead
simply check the 'fe_is_open' field on the CharFrontend, which
will be false in the same scenarios that 'skip_flush' is true.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp.c              |  2 +-
 monitor/monitor-internal.h |  4 +---
 monitor/monitor.c          | 11 +++++++----
 monitor/qmp-cmds.c         |  2 +-
 monitor/qmp.c              |  2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 614d9a3707..72f8303662 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1539,7 +1539,7 @@ void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
         return;
     }
 
-    monitor_data_init(&mon->parent, false, false, false);
+    monitor_data_init(&mon->parent, false, false);
 
     mon->use_readline = use_readline;
     if (mon->use_readline) {
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 25320928a7..84117805b7 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -102,7 +102,6 @@ struct Monitor {
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool is_qmp;
-    bool skip_flush;
     bool use_io_thread;
 
     char *mon_cpu_path;
@@ -183,8 +182,7 @@ extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
-void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
-                       bool use_io_thread);
+void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread);
 void monitor_data_destroy(Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 7936e2ab22..f7e3708d2f 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -167,7 +167,12 @@ void monitor_flush_locked(Monitor *mon)
     size_t len;
     const char *buf;
 
-    if (mon->skip_flush) {
+    /*
+     * When used by QMP human-monitor-command, no chardev
+     * will be connected, as we want to just collect the
+     * output in the buffer
+     */
+    if (!mon->chr.fe_is_open) {
         return;
     }
 
@@ -621,8 +626,7 @@ static void monitor_iothread_init(void)
     mon_iothread = iothread_create("mon_iothread", &error_abort);
 }
 
-void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
-                       bool use_io_thread)
+void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread)
 {
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
@@ -630,7 +634,6 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
     qemu_mutex_init(&mon->mon_lock);
     mon->is_qmp = is_qmp;
     mon->outbuf = g_string_new(NULL);
-    mon->skip_flush = skip_flush;
     mon->use_io_thread = use_io_thread;
 }
 
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index d0ed241d6a..be2bd985b7 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -168,7 +168,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
 
-    monitor_data_init(&hmp->parent, false, true, false);
+    monitor_data_init(&hmp->parent, false, false);
 
     if (has_cpu_index) {
         int ret = monitor_set_cpu(&hmp->parent, cpu_index);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 36cb078f30..fe2aec9ce9 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -538,7 +538,7 @@ void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
     qemu_chr_fe_set_echo(&mon->parent.chr, true);
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(&mon->parent, true, false,
+    monitor_data_init(&mon->parent, true,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
 
     mon->pretty = pretty;
-- 
2.53.0



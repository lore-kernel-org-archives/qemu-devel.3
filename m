Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10144C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aP-0002fH-6i; Tue, 07 Jul 2026 07:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a7-0002NX-3I
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a2-00084R-Cm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9OZ8j8KAHVon/mNmECvRKG2JI48xanWDelF0v/VCa0=;
 b=EAbhQ/jdb1D2pyXMemMnQxWyLn4H6X22HPHWsxmXPVaSipDFetbpToc/lo5vUnsamMTzQX
 V4eJzpju/KmI7OAzMF/YZCnc0ysrGI0vB4CwnB3bRFDBvWq/3EKe+8zJsC7cFoCq2J6GHw
 A2NmvW2rf18aT+EMeKplbdGVL1VR03c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-tRqQpm_zPuqEPS-6ShQ4VQ-1; Tue,
 07 Jul 2026 07:03:07 -0400
X-MC-Unique: tRqQpm_zPuqEPS-6ShQ4VQ-1
X-Mimecast-MFC-AGG-ID: tRqQpm_zPuqEPS-6ShQ4VQ_1783422187
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8FAD1806C85
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C31319560AD
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD07921E66A7; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 10/35] monitor: remove 'skip_flush' field
Date: Tue,  7 Jul 2026 13:02:35 +0200
Message-ID: <20260707110300.1918153-11-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The 'skip_flush' field is set on the dummy throwaway HMP monitor
object created by QMP's  'human-monitor-command', as an indication
not to try to write data to the chardev. Instead the QMP command
impl will grab the data straight out of the in-memory buffer.

The flag is redundant, however, as the monitor code could instead
simply check the 'fe_is_open' field on the CharFrontend, which
will be false in the same scenarios that 'skip_flush' is true.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-11-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/monitor-internal.h |  4 +---
 monitor/hmp.c              |  2 +-
 monitor/monitor.c          | 11 +++++++----
 monitor/qmp-cmds.c         |  2 +-
 monitor/qmp.c              |  2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 145d52fd71..d34f9be139 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -112,7 +112,6 @@ struct Monitor {
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool is_qmp;
-    bool skip_flush;
     bool use_io_thread;
 
     char *mon_cpu_path;
@@ -194,8 +193,7 @@ extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
 void monitor_complete(Monitor *mon, Error **errp);
-void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
-                       bool use_io_thread);
+void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread);
 void monitor_data_destroy(Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 54fd25f220..5644c9c4f5 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1590,7 +1590,7 @@ void monitor_new_hmp(const char *id, const char *chardev_id,
         return;
     }
 
-    monitor_data_init(&mon->parent_obj, false, false, false);
+    monitor_data_init(&mon->parent_obj, false, false);
 
     if (mon->use_readline) {
         mon->rs = readline_init(monitor_readline_printf,
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 1648946c92..db9243410a 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -190,7 +190,12 @@ void monitor_flush_locked(Monitor *mon)
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
 
@@ -644,8 +649,7 @@ static void monitor_iothread_init(void)
     mon_iothread = iothread_create("mon_iothread", &error_abort);
 }
 
-void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
-                       bool use_io_thread)
+void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread)
 {
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
@@ -653,7 +657,6 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
     qemu_mutex_init(&mon->mon_lock);
     mon->is_qmp = is_qmp;
     mon->outbuf = g_string_new(NULL);
-    mon->skip_flush = skip_flush;
     mon->use_io_thread = use_io_thread;
 }
 
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index bfde769ef0..0d9adad288 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -168,7 +168,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
 
-    monitor_data_init(&hmp->parent_obj, false, true, false);
+    monitor_data_init(&hmp->parent_obj, false, false);
 
     if (has_cpu_index) {
         int ret = monitor_set_cpu(&hmp->parent_obj, cpu_index);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index d7adb9ba8b..b300886f33 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -572,7 +572,7 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(&mon->parent_obj, true, false,
+    monitor_data_init(&mon->parent_obj, true,
                       qemu_chr_has_feature(mon->parent_obj.chr.chr,
                                            QEMU_CHAR_FEATURE_GCONTEXT));
 
-- 
2.54.0



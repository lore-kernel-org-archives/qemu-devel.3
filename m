Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39502CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRYm-00074X-3U; Wed, 24 Jun 2026 13:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRYi-00072w-T4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcRYe-0004Sk-H1
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782322718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNCRpmQPe4ziQs6Lc02SmjnfxERAf1/R3dRNUarE0J4=;
 b=avKJwHN0V807xWE/8XOGxAkbVxlj+3UKi6vK/UNAsLVgV3M6qH26kbhsUi85LJGdmHxXdR
 GVJER1pk4h9DLzbwU/j0zufCmuZG9mHQGik8U/1yv+iL6X3V7Mh5c9QMvZkXQlC2FZWsmW
 v/ZASHs2X0AiAdIXdeYB+wA9x35yJTw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-2qaQZ45DNrKIJGIOi4KYNQ-1; Wed,
 24 Jun 2026 13:38:36 -0400
X-MC-Unique: 2qaQZ45DNrKIJGIOi4KYNQ-1
X-Mimecast-MFC-AGG-ID: 2qaQZ45DNrKIJGIOi4KYNQ_1782322715
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E2F31955E91; Wed, 24 Jun 2026 17:38:35 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.102])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10818180034F; Wed, 24 Jun 2026 17:38:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PATCH v5 09/35] monitor: remove 'skip_flush' field
Date: Wed, 24 Jun 2026 18:37:25 +0100
Message-ID: <20260624173752.2928717-10-berrange@redhat.com>
In-Reply-To: <20260624173752.2928717-1-berrange@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
---
 monitor/hmp.c              |  2 +-
 monitor/monitor-internal.h |  4 +---
 monitor/monitor.c          | 11 +++++++----
 monitor/qmp-cmds.c         |  2 +-
 monitor/qmp.c              |  2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index d5905e2279..516aa25d4c 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1590,7 +1590,7 @@ void monitor_new_hmp(const char *chardev_id, bool use_readline, Error **errp)
         return;
     }
 
-    monitor_data_init(&mon->parent_obj, false, false, false);
+    monitor_data_init(&mon->parent_obj, false, false);
 
     if (mon->use_readline) {
         mon->rs = readline_init(monitor_readline_printf,
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
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 747ca27fd5..e3e5623a4b 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -188,7 +188,12 @@ void monitor_flush_locked(Monitor *mon)
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
 
@@ -642,8 +647,7 @@ static void monitor_iothread_init(void)
     mon_iothread = iothread_create("mon_iothread", &error_abort);
 }
 
-void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
-                       bool use_io_thread)
+void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread)
 {
     if (use_io_thread && !mon_iothread) {
         monitor_iothread_init();
@@ -651,7 +655,6 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
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
index 2a8532ef96..e3318b57db 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -572,7 +572,7 @@ void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(&mon->parent_obj, true, false,
+    monitor_data_init(&mon->parent_obj, true,
                       qemu_chr_has_feature(mon->parent_obj.chr.chr,
                                            QEMU_CHAR_FEATURE_GCONTEXT));
 
-- 
2.54.0



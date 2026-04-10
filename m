Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0314EF459F8
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEN4-0004Mx-7s; Fri, 10 Apr 2026 12:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMh-00049l-U9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMe-0006SK-86
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7R6JEqdH4/J2K18E2ASY9Ki5eEz6FdgTPGXjd4B2lHs=;
 b=Waokd8W3zPuce2CcXTh1MTvCyv8tlVQsMll9p3XRAtDkQcSaqi6aRtZVOg3cOfbEmH20zW
 uhBs7GKhWHLV/jiiI960/p82wHypzR0+Wa557o5NjD/LREKoHvdCMf2viYTSd3uWecxpKN
 9BWm/doc34EQtptmnwTe5ps3wMLcgf0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-ZcLkCasePhKozwq4uqkhvQ-1; Fri,
 10 Apr 2026 12:05:39 -0400
X-MC-Unique: ZcLkCasePhKozwq4uqkhvQ-1
X-Mimecast-MFC-AGG-ID: ZcLkCasePhKozwq4uqkhvQ_1775837138
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BBB41801310; Fri, 10 Apr 2026 16:05:38 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC186195608E; Fri, 10 Apr 2026 16:05:34 +0000 (UTC)
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
Subject: [PATCH 09/17] monitor: use class methods for monitor_accept_input
Date: Fri, 10 Apr 2026 17:04:50 +0100
Message-ID: <20260410160458.3778874-10-berrange@redhat.com>
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This removes the need for using monitor_is_qmp() to check the
subclass type, which is an anti-pattern.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp.c              | 16 ++++++++++++++++
 monitor/monitor-internal.h |  1 +
 monitor/monitor.c          | 12 +++---------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 3fe6f5715a..5f9373a87b 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -52,12 +52,14 @@ static void monitor_hmp_finalize(Object *obj)
 
 int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
+static void monitor_hmp_accept_input(Monitor *mon);
 
 static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
 {
     MonitorClass *moncls = MONITOR_CLASS(cls);
 
     moncls->vprintf = monitor_hmp_vprintf;
+    moncls->accept_input = monitor_hmp_accept_input;
 }
 
 static void monitor_hmp_init(Object *obj)
@@ -70,6 +72,20 @@ int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
     return monitor_puts(mon, buf);
 }
 
+static void monitor_hmp_accept_input(Monitor *mon)
+{
+    qemu_mutex_lock(&mon->mon_lock);
+    if (mon->reset_seen) {
+        MonitorHMP *hmp = MONITOR_HMP(mon);
+        assert(hmp->rs);
+        readline_restart(hmp->rs);
+        qemu_mutex_unlock(&mon->mon_lock);
+        readline_show_prompt(hmp->rs);
+    } else {
+        qemu_mutex_unlock(&mon->mon_lock);
+    }
+}
+
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque)
 {
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 4b5e708f14..7004f5d002 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -99,6 +99,7 @@ struct MonitorClass {
     int (*vprintf)(Monitor *mon, const char *fmt, va_list ap)
         G_GNUC_PRINTF(2, 0);
     void (*emit_event)(Monitor *mon, QAPIEvent event, QDict *qdict);
+    void (*accept_input)(Monitor *mon);
 };
 
 struct Monitor {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 5f55d33476..1326069b79 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -557,16 +557,10 @@ int monitor_suspend(Monitor *mon)
 static void monitor_accept_input(void *opaque)
 {
     Monitor *mon = opaque;
+    MonitorClass *cls = MONITOR_GET_CLASS(mon);
 
-    qemu_mutex_lock(&mon->mon_lock);
-    if (!monitor_is_qmp(mon) && mon->reset_seen) {
-        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent);
-        assert(hmp_mon->rs);
-        readline_restart(hmp_mon->rs);
-        qemu_mutex_unlock(&mon->mon_lock);
-        readline_show_prompt(hmp_mon->rs);
-    } else {
-        qemu_mutex_unlock(&mon->mon_lock);
+    if (cls->accept_input) {
+        cls->accept_input(mon);
     }
 
     qemu_chr_fe_accept_input(&mon->chr);
-- 
2.53.0



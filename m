Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B08C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aP-0002g4-Qg; Tue, 07 Jul 2026 07:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a7-0002Na-7D
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a2-00084P-Cm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJiv7fU5hNnKZxGHQOgjbd6l8LqpO4DxSS/WZcNisWk=;
 b=Z4rDg0qDiNmECvtriMRB8yJBJunA5YM/x9kciiIH2A3oE2qZ9EjJTCEwcl+IjMrEt+P3hw
 jWHnfanVlbDplKWXbqLy0XbGJ518/oD48yzRSr7yxQL4cnLCMckb3k7jxq9gUQMRBfq9t4
 UVRQ9XhczCjVYbeohT2cM2DmaAZtW68=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-8BiyOiIvPm-9a1RFDGMqlQ-1; Tue,
 07 Jul 2026 07:03:07 -0400
X-MC-Unique: 8BiyOiIvPm-9a1RFDGMqlQ-1
X-Mimecast-MFC-AGG-ID: 8BiyOiIvPm-9a1RFDGMqlQ_1783422186
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E6561805C39
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 579033691C
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CDC6821E660B; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 14/35] monitor: use class methods for monitor_accept_input
Date: Tue,  7 Jul 2026 13:02:39 +0200
Message-ID: <20260707110300.1918153-15-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This removes the need for using monitor_is_qmp() to check the
subclass type, which is an anti-pattern.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-15-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/monitor-internal.h |  5 +++++
 monitor/hmp.c              | 16 ++++++++++++++++
 monitor/monitor.c          | 12 +++---------
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 763b5c9625..592f146331 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -116,6 +116,11 @@ struct MonitorClass {
      * notifications back to the client
      */
     void (*emit_event)(Monitor *mon, QAPIEvent event, QDict *qdict);
+    /*
+     * If non-NULL, perform any actions needed to prepare
+     * the monitor to accept further client input
+     */
+    void (*accept_input)(Monitor *mon);
 };
 
 struct Monitor {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index f9252387c4..4636165d0b 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -70,6 +70,7 @@ static void monitor_hmp_set_readline(Object *obj, bool val, Error **errp)
 
 int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
+static void monitor_hmp_accept_input(Monitor *mon);
 
 static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
 {
@@ -80,6 +81,7 @@ static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
                                    monitor_hmp_set_readline);
 
     moncls->vprintf = monitor_hmp_vprintf;
+    moncls->accept_input = monitor_hmp_accept_input;
 }
 
 static void monitor_hmp_init(Object *obj)
@@ -100,6 +102,20 @@ int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
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
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 90cfb59c66..6e63e7a5c7 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -578,16 +578,10 @@ int monitor_suspend(Monitor *mon)
 static void monitor_accept_input(void *opaque)
 {
     Monitor *mon = opaque;
+    MonitorClass *cls = MONITOR_GET_CLASS(mon);
 
-    qemu_mutex_lock(&mon->mon_lock);
-    if (!monitor_is_qmp(mon) && mon->reset_seen) {
-        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent_obj);
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
2.54.0



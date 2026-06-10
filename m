Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A7CCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXI9L-0007g8-9S; Wed, 10 Jun 2026 08:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXI9J-0007Ps-0D
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXI9H-0002Ds-85
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MqUwXLxRrUVzOuBFkRQYnqpeYFwn/YKoi40tF2t2jR4=;
 b=YxbfiYddb86DpmyGIGgTIkHEMUjTfNRr32pKeV9oIPlYZqw82iqH012gFnCL3XVQnxQaD8
 KPQyZ/RhErfscSE918YVhKWmpgQdUIvOnFIENVmTOPtrCQ0YLYOsqSgF6dbQgKM5lhCyt/
 uk2ZRtK95AQSgSAzZFeb++A3bBPwORM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-nJGrUFxFOHmPtaRzvQyMjw-1; Wed,
 10 Jun 2026 08:35:07 -0400
X-MC-Unique: nJGrUFxFOHmPtaRzvQyMjw-1
X-Mimecast-MFC-AGG-ID: nJGrUFxFOHmPtaRzvQyMjw_1781094906
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EC541845420; Wed, 10 Jun 2026 12:35:06 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.112])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDA653652A; Wed, 10 Jun 2026 12:35:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 11/35] monitor: use class methods for monitor_vprintf
Date: Wed, 10 Jun 2026 13:33:51 +0100
Message-ID: <20260610123415.2883603-12-berrange@redhat.com>
In-Reply-To: <20260610123415.2883603-1-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

This removes the need for using monitor_is_qmp() to check the
subclass type, which is an anti-pattern.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp.c              | 13 +++++++++++++
 monitor/monitor-internal.h |  7 +++++++
 monitor/monitor.c          | 11 ++++-------
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 2bb2333da5..08055839a4 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -68,11 +68,18 @@ static void monitor_hmp_set_readline(Object *obj, bool val, Error **errp)
     mon->use_readline = val;
 }
 
+int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
+    G_GNUC_PRINTF(2, 0);
+
 static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
 {
+    MonitorClass *moncls = MONITOR_CLASS(cls);
+
     object_class_property_add_bool(cls, "readline",
                                    monitor_hmp_get_readline,
                                    monitor_hmp_set_readline);
+
+    moncls->vprintf = monitor_hmp_vprintf;
 }
 
 static void monitor_hmp_init(Object *obj)
@@ -87,6 +94,12 @@ static void monitor_hmp_init(Object *obj)
     hmp->use_readline = true;
 }
 
+int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
+{
+    g_autofree char *buf = g_strdup_vprintf(fmt, ap);
+    return monitor_puts(mon, buf);
+}
+
 static void monitor_command_cb(void *opaque, const char *cmdline,
                                void *readline_opaque)
 {
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 6a4c3b0f37..23cef68153 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -104,6 +104,13 @@ typedef struct HMPCommand {
 
 struct MonitorClass {
     ObjectClass parent_class;
+
+    /*
+     * If non-NULL, the monitor is able to print messages
+     * for attention of the client user
+     */
+    int (*vprintf)(Monitor *mon, const char *fmt, va_list ap)
+        G_GNUC_PRINTF(2, 0);
 };
 
 struct Monitor {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index ae36e996e9..1ab04a19fa 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -261,21 +261,18 @@ int monitor_puts(Monitor *mon, const char *str)
 
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
-    char *buf;
-    int n;
+    MonitorClass *moncls;
 
     if (!mon) {
         return -1;
     }
 
-    if (monitor_is_qmp(mon)) {
+    moncls = MONITOR_GET_CLASS(mon);
+    if (!moncls->vprintf) {
         return -1;
     }
 
-    buf = g_strdup_vprintf(fmt, ap);
-    n = monitor_puts(mon, buf);
-    g_free(buf);
-    return n;
+    return moncls->vprintf(mon, fmt, ap);
 }
 
 int monitor_printf(Monitor *mon, const char *fmt, ...)
-- 
2.54.0



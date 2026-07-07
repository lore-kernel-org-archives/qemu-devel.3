Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39CFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aS-0002hT-V8; Tue, 07 Jul 2026 07:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a3-0002KJ-Tt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a2-00084M-Bl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XtxFkPdruGIj7okKQPsnNdZVVTMz2xc0/J3sacM04mk=;
 b=EzJ3aVSe44vTV6KgKn4cud5lzdcmnCp23aSORYH0GgAzeM9RQT79Zb3RX/+rJ9+zBOPSj5
 pvztxGL5RoDtcy33cKAjBiWWABnDVvRoVllY/lqaPoJYXOp5tkkQYPyEEFySc30cPiWpR+
 uYMtJZYKnto4HpVixfCjhK9LV76LZAs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-js9O382tNx-MUcbg7zcUKQ-1; Tue,
 07 Jul 2026 07:03:07 -0400
X-MC-Unique: js9O382tNx-MUcbg7zcUKQ-1
X-Mimecast-MFC-AGG-ID: js9O382tNx-MUcbg7zcUKQ_1783422187
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8FFB1806C8B; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 668F719560B2; Tue,  7 Jul 2026 11:03:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C583421E66B6; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PULL 12/35] monitor: use class methods for monitor_vprintf
Date: Tue,  7 Jul 2026 13:02:37 +0200
Message-ID: <20260707110300.1918153-13-armbru@redhat.com>
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

This removes the need for using monitor_is_qmp() to check the
subclass type, which is an anti-pattern.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-13-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/monitor-internal.h |  7 +++++++
 monitor/hmp.c              | 13 +++++++++++++
 monitor/monitor.c          | 11 ++++-------
 3 files changed, 24 insertions(+), 7 deletions(-)

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
diff --git a/monitor/hmp.c b/monitor/hmp.c
index c03b91782c..f9252387c4 100644
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
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 9fe131983d..0cb0930bf4 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -264,21 +264,18 @@ int monitor_puts(Monitor *mon, const char *str)
 
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



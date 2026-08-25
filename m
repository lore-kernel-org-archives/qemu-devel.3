Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3ACC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywaE-0004Gi-WD; Tue, 25 Aug 2026 15:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywaB-00049w-4J
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywa4-0004Zp-NV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZyJ/smMSnxR8Ex2EKaOlL6B9GMxgiL6O1F1ULR5HLs=;
 b=C98M6t+wCXE8FgsqNQL310NSzBr4gFqlI5X3lk0Skvbmi5H40xolWIcOUBTDBE644PqrZi
 ym4QiZDzq2LF8CAT9hjaw9N6nj9GE4C+1eTmzLqm8Fn9IjHjaSze15UsCTxtOI9SNmz2b/
 RTAlVPnIMO2rEd07qOLPbzoEsbGX4AE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Kind9XcLMQOON9LepLH8vQ-1; Tue,
 25 Aug 2026 15:13:05 -0400
X-MC-Unique: Kind9XcLMQOON9LepLH8vQ-1
X-Mimecast-MFC-AGG-ID: Kind9XcLMQOON9LepLH8vQ_1787685184
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D723018C0FC9; Tue, 25 Aug 2026 19:13:04 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1684A1800765; Tue, 25 Aug 2026 19:13:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:53 +0400
Subject: [PATCH v4 46/49] monitor: move monitor_hmp_print*() functions to hmp.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-46-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4964;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cT8eQSuF4lEc2cg9pW9E3wa9JurJOTD+0OT9/xe0Qew=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiImb0exNL1C3DcxkXg9S3gLpG5myE9u0m/5
 rivhAMKOO6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5bXiD/9Hbss8o+Uw0ylFvu4Py/XQhAuFJDjqcLuz/kQTiQqznutdDeWyL+NL0cssWN6sGj49md3
 +1xbgcyP1exq2bwSm+P/4Ud3QxtUiStIXqes7c1jogataMVsUgoUY2edyEN5MuA0LYwAe1+CEDu
 m5Epx15AeU3KMcwtWK1Ejw92QqmB3E/t6FStHzSqgmBDyrj+9RQGbGL1BE1GSKd1YwIFjPSFdSP
 V8libT7mYCFTCPdO+s8YeEFuPwp7en8G+IXV6bqW1QYxLmMTwqiZH6hfv6glbPqDQWwPxHtZ0YV
 +ltw6edkufbcVFAfffGGHhTTYtK/uclhPaDKcE2N1vuR49Bwu186SrVsHzHTTKfzWNgTaPMfOvT
 MTb++H89ViAzPsWxQEKdcWurPmOnulG+PVsUF8fpJ87hQEORSjcepwd2IVjwlYg9wWSaswzWR13
 7Hdmbmil/cFARCRhvZlXng7BZmncLmdT+Pmz4D/MgGzALGKwZmu7kOMnNNcH/Me1YqMdhprqyMj
 A1Oz9Iq3RLAEZ4KFAqarvhJ2mdTvJyHMvOncnS59wVb4tymtIwNl86X6OwafXbIqpjpWIhESFJ0
 e+Db847gk8mATcZ3w1INFYvXCAmIoJawmgLq8yXGoDQBlloluspcya7klQMNZmDutyXdnnsLujt
 Cv3LMTnn8gfMlvQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Those functions are only used when CONFIG_HMP, compile them out, and add
conditions for the calling code.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/hmp.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/monitor.c   | 49 -------------------------------------------------
 util/error-report.c |  3 ++-
 util/qemu-print.c   |  6 ++++++
 4 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 10bcbe2a33cb..e3fc05f521a8 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1754,3 +1754,52 @@ static int get_monitor_def(MonitorHMP *hmp, int64_t *pval, const char *name)
     }
     return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
 }
+
+int monitor_hmp_vprintf(MonitorHMP *hmp, const char *fmt, va_list ap)
+{
+    g_autofree char *buf = g_strdup_vprintf(fmt, ap);
+
+    if (!hmp) {
+        return -1;
+    }
+
+    return monitor_puts(MONITOR(hmp), buf);
+}
+
+int monitor_hmp_printf(MonitorHMP *hmp, const char *fmt, ...)
+{
+    int ret;
+
+    va_list ap;
+    va_start(ap, fmt);
+    ret = monitor_hmp_vprintf(hmp, fmt, ap);
+    va_end(ap);
+    return ret;
+}
+
+void monitor_hmp_printc(MonitorHMP *hmp, int c)
+{
+    monitor_hmp_printf(hmp, "'");
+    switch (c) {
+    case '\'':
+        monitor_hmp_printf(hmp, "\\'");
+        break;
+    case '\\':
+        monitor_hmp_printf(hmp, "\\\\");
+        break;
+    case '\n':
+        monitor_hmp_printf(hmp, "\\n");
+        break;
+    case '\r':
+        monitor_hmp_printf(hmp, "\\r");
+        break;
+    default:
+        if (c >= 32 && c <= 126) {
+            monitor_hmp_printf(hmp, "%c", c);
+        } else {
+            monitor_hmp_printf(hmp, "\\x%02x", c);
+        }
+        break;
+    }
+    monitor_hmp_printf(hmp, "'");
+}
diff --git a/monitor/monitor.c b/monitor/monitor.c
index da0c8eda86b0..7979cd1cbcfd 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -272,55 +272,6 @@ int monitor_puts(Monitor *mon, const char *str)
     return monitor_puts_locked(mon, str);
 }
 
-int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
-{
-    g_autofree char *buf = g_strdup_vprintf(fmt, ap);
-
-    if (!mon) {
-        return -1;
-    }
-
-    return monitor_puts(MONITOR(mon), buf);
-}
-
-int monitor_hmp_printf(MonitorHMP *mon, const char *fmt, ...)
-{
-    int ret;
-
-    va_list ap;
-    va_start(ap, fmt);
-    ret = monitor_hmp_vprintf(mon, fmt, ap);
-    va_end(ap);
-    return ret;
-}
-
-void monitor_hmp_printc(MonitorHMP *mon, int c)
-{
-    monitor_hmp_printf(mon, "'");
-    switch(c) {
-    case '\'':
-        monitor_hmp_printf(mon, "\\'");
-        break;
-    case '\\':
-        monitor_hmp_printf(mon, "\\\\");
-        break;
-    case '\n':
-        monitor_hmp_printf(mon, "\\n");
-        break;
-    case '\r':
-        monitor_hmp_printf(mon, "\\r");
-        break;
-    default:
-        if (c >= 32 && c <= 126) {
-            monitor_hmp_printf(mon, "%c", c);
-        } else {
-            monitor_hmp_printf(mon, "\\x%02x", c);
-        }
-        break;
-    }
-    monitor_hmp_printf(mon, "'");
-}
-
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
diff --git a/util/error-report.c b/util/error-report.c
index 78ccb6ea608e..111bfe29020b 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -35,10 +35,11 @@ const char *error_guest_name;
 static int G_GNUC_PRINTF(2, 0)
 error_vprintf_mon(MonitorHMP *hmp, const char *fmt, va_list ap)
 {
+#ifdef CONFIG_HMP
     if (hmp) {
         return monitor_hmp_vprintf(hmp, fmt, ap);
     }
-
+#endif
     return vfprintf(stderr, fmt, ap);
 }
 
diff --git a/util/qemu-print.c b/util/qemu-print.c
index 5938f2b6c338..07e48829b226 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -27,10 +27,14 @@ int qemu_vprintf(const char *fmt, va_list ap)
 
     /* for all monitors: QMP & HMP */
     if (cur_mon) {
+#ifdef CONFIG_HMP
         /* don't use monitor_cur_hmp(), to avoid a second lookup */
         MonitorHMP *hmp = (MonitorHMP *)
             object_dynamic_cast(OBJECT(cur_mon), TYPE_MONITOR_HMP);
         return monitor_hmp_vprintf(hmp, fmt, ap);
+#else
+        return -1;
+#endif
     }
     return vprintf(fmt, ap);
 }
@@ -60,10 +64,12 @@ int qemu_printf(const char *fmt, ...)
  */
 int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
 {
+#ifdef CONFIG_HMP
     if (!stream) {
         MonitorHMP *hmp = monitor_cur_hmp();
         return monitor_hmp_vprintf(hmp, fmt, ap);
     }
+#endif
     return vfprintf(stream, fmt, ap);
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8



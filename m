Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676A9C61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Rj-0006en-Id; Fri, 28 Aug 2026 16:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Ri-0006b6-GS
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Rg-00011T-Nf
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ww7blIMBoGp2UeKhBXzhHpBijTwcIavNL5U8fiOt18Y=;
 b=AcT4BHRohpWz4oioDLDkS+IHEv4niVuGUzblGJ+fSnRV7rJGZ7QWOdm5n0Sq6ykxRLI05w
 /53RhQekU2s/yIKthDBV2x7ICP6Pl3BCCmhycq8Q6aAcSH9HGFHoz/ypSrBPvb/N8jlxb/
 JntVlVFLo5EX0RmydFdQUa+ta+QWJug=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-noAAecTANqC-lGElpv0W8Q-1; Fri,
 28 Aug 2026 16:45:00 -0400
X-MC-Unique: noAAecTANqC-lGElpv0W8Q-1
X-Mimecast-MFC-AGG-ID: noAAecTANqC-lGElpv0W8Q_1787949899
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ABFC1944F2C; Fri, 28 Aug 2026 20:44:59 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60D273001D3D; Fri, 28 Aug 2026 20:44:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:26 +0400
Subject: [GIT PULL 47/50] monitor: move monitor_hmp_print*() functions to hmp.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-47-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5242;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hQYL/vHgYNpi41AkLAPE++k6s/L3pPhglmykhJ34LTk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKVulUYZO62aDC2lPHhgYoMVO1yX6uh7ZGeL
 Owexd/agbmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5dCAD/0WeKGVgpNn8UHMSdFCHrP6LIjDnRlaNp11JogOXwvXMlxiaRC9Yg6lbRIAD8587tZmoqv
 2N1Qk3yxJzd/lTrRXxo9C+NjUkwbz/l0q174yxDMeOR6zlQDjxMCu0VAu2YpjhVX1MPfIhH+Swk
 +PuN8JFJlAnokO3IwrjnvuZ7d8VD+IXk7m9URq6bZ49WSWMolTXjyXNDWjfQeyf5KBp5vpYbAEr
 TKZxj8y/TEWVhoCCfMa3CqUnUK3W76okFDu9oxQ5tUUDy+JZqc3x3bUFta1cwu20Qg7i7t1cT9Q
 i5L4g3y8Je5ghXbWonidV6pN47tzIzFk58Y7oL3DawnD/DmCNTk1AaDgyRUajrswrtfZgawMbwD
 yVTwGGvnpBJDJ1y5GV1zG+RpA9uj59s57imrn+SviPfZKiHGHdTkhdRp78ReMRGHWqx0+sY5AfG
 12xUffwSe7TLQ6UCRcdk1ylPvocAXFXKSBouX4fbJfAYsOdfHSqqX0FslxwIiiair6A1ZV0Qghh
 kshElHenLBY7sspU0gtqFUuCc0yTmUtGhYTJDY3PJAmB4m+w1ghilI+Dr3E8gYenWe2W5KAgptw
 yP/PplO3/1DqsYhJM37f7wqEes3hyVyJgTfjydZi/oQkC9fcc3CzEqrYDiqiP8l6e/JVxnYjngY
 GouBdd2rShfnC4Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Those functions are only used when CONFIG_HMP, compile them out, and add
conditions for the calling code.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-47-9227de146347@redhat.com>
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
index 7b22553a8731..44f2339d31fc 100644
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
index 0e3aaa539e78..8932beebfb9f 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -35,10 +35,11 @@ const char *error_guest_name;
 static int G_GNUC_PRINTF(2, 0)
 error_vprintf_hmp(MonitorHMP *hmp, const char *fmt, va_list ap)
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
index 01ed43b5a588..ab09dd8600ec 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -27,6 +27,7 @@ int qemu_vprintf(const char *fmt, va_list ap)
 
     /* for all monitors: QMP & HMP */
     if (cur_mon) {
+#ifdef CONFIG_HMP
         /* don't use monitor_cur_hmp(), to avoid a second lookup */
         MonitorHMP *hmp = (MonitorHMP *)
             object_dynamic_cast(OBJECT(cur_mon), TYPE_MONITOR_HMP);
@@ -34,6 +35,9 @@ int qemu_vprintf(const char *fmt, va_list ap)
             return -1;
         }
         return monitor_hmp_vprintf(hmp, fmt, ap);
+#else
+        return -1;
+#endif
     }
     return vprintf(fmt, ap);
 }
@@ -63,6 +67,7 @@ int qemu_printf(const char *fmt, ...)
  */
 int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
 {
+#ifdef CONFIG_HMP
     if (!stream) {
         MonitorHMP *hmp = monitor_cur_hmp();
         if (!hmp) {
@@ -70,6 +75,7 @@ int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
         }
         return monitor_hmp_vprintf(hmp, fmt, ap);
     }
+#endif
     return vfprintf(stream, fmt, ap);
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8



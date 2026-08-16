Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933ECC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgLH-0001D1-PI; Sun, 16 Aug 2026 15:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgLA-0000mK-5x
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgL8-000080-5j
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJKjhueKFH6fO293pZu/kieeolLZstxWiOEM7pJAUd8=;
 b=E6ZcyvTeesdFmdXw2GlB8N9NBi9bG2qXI2n4mpnnw0S1oet7nHgec3BbDaIzYY86M+AR1H
 jw9Is8PVr2DQqFmKJjUyG1QLKcC7LiyKX0X+OrSJlVEHeukajGH3RknxnaskkdFFs1cv0e
 nF+FihLJvTGlSn/RJfenFHyPTX1YID0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-7vm2xFJlPByihTKfMluXFQ-1; Sun,
 16 Aug 2026 15:15:58 -0400
X-MC-Unique: 7vm2xFJlPByihTKfMluXFQ-1
X-Mimecast-MFC-AGG-ID: 7vm2xFJlPByihTKfMluXFQ_1786907757
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9602E19560AB; Sun, 16 Aug 2026 19:15:57 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E66218005BB; Sun, 16 Aug 2026 19:15:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:13:14 +0400
Subject: [PATCH v3 47/49] monitor: move monitor_hmp_print*() functions to hmp.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-47-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4855;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=f8oQG0VaVSMSlz37NAD46saX6MrPKO3jars6q2wPBXY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqggu1AHKyKuL4Kxhx5QK6x5FYxfRZTZtmyvwBh
 9Hnl7gSF6iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILtQAKCRDa6OEJdZac
 5Z4OD/9t1I00kqSUTmAGYAkmsrbSToRsjr7WkwQ6GrVi/WVBUNkZINshPuCEZtXfX8Gli+VKD4J
 UOUNAnXo+AbjCPfuj309g3O+gQDiUW8LQUujymlemeADbpFGZpIqnMDZDii9etci8uxqDKfMKMV
 v/5AtmOYOnU0AcgF/aMNvLxmMi6H+OfE8sTAtv/lzeW/jwEIiJ2Mrl4gwW52a0JkQf/4fpLMf6l
 SN0UwAaudMT04wrkrQBAwcDjkNgoRKEtDUc4LBMZ71aEJx4Lk9MnCsnSsJSE28pd065cAfp5MRp
 +FhKjWjwTD80YFLuB5SX4fT7uX37sMLRT3pE+7iHclgFTxyfFI3TcRCgKMNQzo6OtT7HgwYBdlB
 ATjldOTfJvhdEm3k2X3lB2Nmvk5ox1Rf/8FARLJPgVPfJLxztKTv2UNyuJ29PZ3QHjRk0CIvE+F
 Ec+CYxtvCoqtNSkbuSO4bG3cS/9cdd1Zl7/USnl9gFbYyRXemUFUw4p5eNguAozX9g7qSnGP6xL
 ANKdb1qyKFATTwTTDHMfIYswdwrqIa/xu52H6YUyKbjNGC2NUlT7IfZccJczm/fWrqO5UMJkUU7
 wvBxeyk/u1r4aFq9W/iQgFuQepjZfOCLQL8XsRUw0Kst0zrnRPs5VC9+Tah1ktqmuQhqLNfUDt8
 5anGIWwpl+Hz2GA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

Those functions are only used when CONFIG_HMP, compile them out, and add
conditions for the calling code.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

# The commit message #2 will be skipped:

# fixup! monitor: move monitor_hmp_print*() functions to hmp.c
---
 monitor/hmp.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/monitor.c   | 49 -------------------------------------------------
 util/error-report.c |  3 ++-
 util/qemu-print.c   |  4 ++++
 4 files changed, 55 insertions(+), 50 deletions(-)

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
index c20e157780fa..68471d8055a1 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -35,12 +35,13 @@ const char *error_guest_name;
 static int G_GNUC_PRINTF(1, 0)
 error_vprintf_mon(const char *fmt, va_list ap)
 {
+#ifdef CONFIG_HMP
     MonitorHMP *hmp = monitor_cur_hmp();
 
     if (hmp) {
         return monitor_hmp_vprintf(hmp, fmt, ap);
     }
-
+#endif
     return vfprintf(stderr, fmt, ap);
 }
 
diff --git a/util/qemu-print.c b/util/qemu-print.c
index aabe670fda01..f4a7ce4c0682 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -21,10 +21,12 @@
  */
 int qemu_vprintf(const char *fmt, va_list ap)
 {
+#ifdef CONFIG_HMP
     MonitorHMP *hmp = monitor_cur_hmp();
     if (hmp) {
         return monitor_hmp_vprintf(hmp, fmt, ap);
     }
+#endif
     return vprintf(fmt, ap);
 }
 
@@ -52,10 +54,12 @@ int qemu_printf(const char *fmt, ...)
  */
 int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
 {
+#ifdef CONFIG_HMP
     if (!stream) {
         MonitorHMP *hmp = monitor_cur_hmp();
         return hmp ? monitor_hmp_vprintf(hmp, fmt, ap) : -1;
     }
+#endif
     return vfprintf(stream, fmt, ap);
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8



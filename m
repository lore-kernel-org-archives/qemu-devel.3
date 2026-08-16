Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B097CC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgKK-000709-Jd; Sun, 16 Aug 2026 15:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKI-0006q1-GY
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKA-00088Y-4R
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NB19nROSaJxVR1WIi0VRBxVHI3bn9DkLC8WJKWPYYhI=;
 b=aAgXuAaXhISbB/mYU6FPrfzghhILsVtb2KEhhOMYbOWGx6tsFOyb7Cdgm1diovMWn/xVzh
 cLWfuZrZB2u9uIFAFpRLV7tBzeEA67jiY54U69t47dalw0WXDHKWp9fYZzlMEHDyZ/4j96
 DYmEUW2oLPJ1BYAb6pLQs/tYakULUeM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-ONbr4ShgPRCqw3syxp-L-g-1; Sun,
 16 Aug 2026 15:15:11 -0400
X-MC-Unique: ONbr4ShgPRCqw3syxp-L-g-1
X-Mimecast-MFC-AGG-ID: ONbr4ShgPRCqw3syxp-L-g_1786907710
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FCAE1956096; Sun, 16 Aug 2026 19:15:10 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B39330001A2; Sun, 16 Aug 2026 19:15:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:13:02 +0400
Subject: [PATCH v3 35/49] error-report: switch to use monitor_cur_hmp()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-35-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5626;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SVuAZWFVpZllbfA7jw/9vK74qQymNkwtSaEg9cSGiHc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguzessuR9HKH3C7U2XQ6Z/xZBcItMvX8FSQD
 7vTCdB2WneJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILswAKCRDa6OEJdZac
 5bJtEAC3kxdoQIpV9okEjJgqw0XRYZfZ5yEfrw3C9pUs9n2tvWWbHT7QvouEJILUrnhPH79pt0Z
 F5PDUIbgyCJ2NtRh8goDq/Zb4zgZH6EA5BUHO7UR9k4eCMmpP6Zzh6I1zuHqvfw1rH4UF6BirsJ
 ItCkyn4cb2RUtz3Z3p5oSwklIl0fdMDKr+3zKH53SUxa0MMVzdgjC3+7RWitNqWa0QojLeuD+WB
 Y1yniMHZ2Fnx6hmpvaWWDiuEsNqZ3ME1gzSzswCtO4ndxtALlgGfxyXuLQW8mtp34TpipSxtSQz
 iQXW65lH9uP7TrY+0kw0F5oys4VE7sr1w14RHUKB+xYR/11Nyy4gQ95Bg/3iB9VhPQY8AASoioL
 TTkGD8GeyVVAwi2rI6pWKGavyN9fQIfnNpkkX8F4ClGyWzUVaTza7ASgGBVnkBFpi+up9hAutzI
 pnJ4pbGaQD4Xr0N/qvBgyUCseePCZ2F1LXpPmY7SsTjX2pOd1FdEO7mdeWGhjxXCUkPC2VDIKj+
 d81ZUufN46IbgXhre8N3SkEqpbSWLbwMxSzvTh+n/tYmJUfR+upc5O9SCwHT2WPoCddURm3LKM2
 HEDZGZcKlJe9DlXfjxcBYJZNgTDOUtt0oUYCepzRiMVez3GjnJB+s3fVPeNZ3q0gRral0/jsp4A
 YtZsTLctv1Iu4nw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Instead of passing a Monitor pointer through error_vprintf_mon() and
error_printf_mon(), call monitor_cur_hmp() directly. This removes the
monitor parameter from the internal helpers and the manual
object_dynamic_cast() in vreport().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/error-report.c | 72 +++++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/util/error-report.c b/util/error-report.c
index aaa15bc79827..70cbd174ffae 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -30,34 +30,31 @@ bool error_with_guestname;
 const char *error_guest_name;
 
 /*
- * Print to the current human monitor if we have one, else to stderr.
+ * Print to the current HMP monitor if we have one, else to stderr.
  */
-static int G_GNUC_PRINTF(2, 0)
-error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
+static int G_GNUC_PRINTF(1, 0)
+error_vprintf_mon(const char *fmt, va_list ap)
 {
-    /*
-     * This will return -1 if 'cur_mon' is NULL, or is QMP.
-     * IOW this will only print if in HMP, otherwise we
-     * fallback to stderr for QMP / no-monitor scenarios.
-     */
-    int ret = monitor_vprintf(cur_mon, fmt, ap);
-    if (ret == -1) {
-        ret = vfprintf(stderr, fmt, ap);
+    MonitorHMP *hmp = monitor_cur_hmp();
+
+    if (hmp) {
+        return monitor_vprintf(MONITOR(hmp), fmt, ap);
     }
-    return ret;
+
+    return vfprintf(stderr, fmt, ap);
 }
 
 /*
- * Print to the current human monitor if we have one, else to stderr.
+ * Print to the current HMP monitor if we have one, else to stderr.
  */
-static int G_GNUC_PRINTF(2, 3)
-error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
+static int G_GNUC_PRINTF(1, 2)
+error_printf_mon(const char *fmt, ...)
 {
     va_list ap;
     int ret;
 
     va_start(ap, fmt);
-    ret = error_vprintf_mon(cur_mon, fmt, ap);
+    ret = error_vprintf_mon(fmt, ap);
     va_end(ap);
     return ret;
 }
@@ -67,7 +64,7 @@ error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
  */
 int error_vprintf(const char *fmt, va_list ap)
 {
-    return error_vprintf_mon(monitor_cur(), fmt, ap);
+    return error_vprintf_mon(fmt, ap);
 }
 
 /*
@@ -79,7 +76,7 @@ int error_printf(const char *fmt, ...)
     int ret;
 
     va_start(ap, fmt);
-    ret = error_vprintf_mon(monitor_cur(), fmt, ap);
+    ret = error_vprintf_mon(fmt, ap);
     va_end(ap);
     return ret;
 }
@@ -183,13 +180,13 @@ void loc_set_file(const char *fname, int lno)
  * Print current location to current HMP monitor if we have one, else
  * to stderr.
  */
-static void print_loc(Monitor *cur)
+static void print_loc(MonitorHMP *hmp)
 {
     const char *sep = "";
     int i;
     const char *const *argp;
 
-    if (!cur && g_get_prgname()) {
+    if (!hmp && g_get_prgname()) {
         fprintf(stderr, "%s:", g_get_prgname());
         sep = " ";
     }
@@ -197,20 +194,20 @@ static void print_loc(Monitor *cur)
     case LOC_CMDLINE:
         argp = cur_loc->ptr;
         for (i = 0; i < cur_loc->num; i++) {
-            error_printf_mon(cur, "%s%s", sep, argp[i]);
+            error_printf_mon("%s%s", sep, argp[i]);
             sep = " ";
         }
-        error_printf_mon(cur, ": ");
+        error_printf_mon(": ");
         break;
     case LOC_FILE:
-        error_printf_mon(cur, "%s:", (const char *)cur_loc->ptr);
+        error_printf_mon("%s:", (const char *)cur_loc->ptr);
         if (cur_loc->num) {
-            error_printf_mon(cur, "%d:", cur_loc->num);
+            error_printf_mon("%d:", cur_loc->num);
         }
-        error_printf_mon(cur, " ");
+        error_printf_mon(" ");
         break;
     default:
-        error_printf_mon(cur, "%s", sep);
+        error_printf_mon("%s", sep);
     }
 }
 
@@ -233,45 +230,44 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 {
     /*
      * When current monitor is QMP, messages must go to stderr
-     * and have prefixes added, so we cast to HMP, leaving 'cur'
+     * and have prefixes added, so we cast to HMP, leaving 'hmp'
      * as NULL in QMP case
      */
-    Monitor *cur = MONITOR(
-        object_dynamic_cast(OBJECT(monitor_cur()), TYPE_MONITOR_HMP));
+    MonitorHMP *hmp = monitor_cur_hmp();
     gchar *timestr;
 
-    if (!cur) {
+    if (!hmp) {
         qemu_flockfile(stderr);
     }
 
-    if (message_with_timestamp && !cur) {
+    if (message_with_timestamp && !hmp) {
         timestr = real_time_iso8601();
         fprintf(stderr, "%s ", timestr);
         g_free(timestr);
     }
 
     /* Only prepend guest name if -msg guest-name and -name guest=... are set */
-    if (error_with_guestname && error_guest_name && !cur) {
+    if (error_with_guestname && error_guest_name && !hmp) {
         fprintf(stderr, "%s ", error_guest_name);
     }
 
-    print_loc(cur);
+    print_loc(hmp);
 
     switch (type) {
     case REPORT_TYPE_ERROR:
         break;
     case REPORT_TYPE_WARNING:
-        error_printf_mon(cur, "warning: ");
+        error_printf_mon("warning: ");
         break;
     case REPORT_TYPE_INFO:
-        error_printf_mon(cur, "info: ");
+        error_printf_mon("info: ");
         break;
     }
 
-    error_vprintf_mon(cur, fmt, ap);
-    error_printf_mon(cur, "\n");
+    error_vprintf_mon(fmt, ap);
+    error_printf_mon("\n");
 
-    if (!cur) {
+    if (!hmp) {
         qemu_funlockfile(stderr);
     }
 }

-- 
2.55.0.543.g5ebe2ebe4ea8



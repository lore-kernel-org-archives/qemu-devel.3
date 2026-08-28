Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A4EC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvNJ-00059N-15; Fri, 28 Aug 2026 08:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvN1-0004VE-SP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvMx-0003Ls-E3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ytc47TlVu0XCstakYrfCHWlDJrDzbQH2i4e8NTtzjs=;
 b=NJH6D1rYnz2chQny8O3innipodaGcqffEm6wB2OtDsp4FfORGU0pEyyWP7iWU0vypoxLAt
 Ipo8QdL9BmvatC18SNpavP+nsLULjLox6qbwTwatXUR9yd25PBWpXejSQbAi+rEjg64R8s
 WeXTvPJ55KgqU203l4LMPAw9fGlTiws=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-jAhWuZZIOdSqGaIUWQyJvA-1; Fri,
 28 Aug 2026 08:07:33 -0400
X-MC-Unique: jAhWuZZIOdSqGaIUWQyJvA-1
X-Mimecast-MFC-AGG-ID: jAhWuZZIOdSqGaIUWQyJvA_1787918852
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B948F193E887; Fri, 28 Aug 2026 12:07:32 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F69F3001D39; Fri, 28 Aug 2026 12:07:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:32 +0400
Subject: [PATCH v5 35/50] error-report: switch to use monitor_cur_hmp()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-35-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5657;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tm0EFvAxIa8HUoanPOs5vgx39w3phJn7mM/DzmSWQ6M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk5XplZ+caJiWtA7fpEv8io+kryNaQkumllc
 7spHiCOdNiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OQAKCRDa6OEJdZac
 5SruD/4qN9i9aHOOD6MUKAkh5+YKdc6PEQw8BWXNsJEta1k+ZDbm8ur/z2DWohDOSebrLq8ocdA
 ao5nL3dDABSvLBMS6ps1bvLBilEyXssfEOTYb65Ns70ahYW/2Mxk8rMKk7NiE3t1vIGK8lY1e6E
 6wpOoK55DKAKugtJIqguztyg4E/P1ID6pWf9NtlB00UoegqZiHZwO6sLw5Iy2/7PBvYhcT5ICvy
 cCCU5EUWMpEGQ/Wqp1pxFwSXA1YYATl2sZzAUDnm4mzJj147sywZHnozt2ZMXcnk3kTIjJr+CjK
 UrM9m/fXi+rYfjMkHIImeSnTy+Myduy1AGXAj2TXWAXvoI3swD2xsxMJxAXosmfKDCNbjwzViFS
 PPLlwsvGOuMzBsN+4nYmEKLazp0U9hJqVxU3AWLupKFhsyxIL+PXr9iDLH/RHTxknCuLr3rjPKs
 mVm54yEETgrgVj9paz5soU4JdOqzFFuf5h01EtBZQxA8CkPwcfI04A0oU0vpy3e9PXPQsS1JdIv
 /xLuc519H7dWF++mUoImuIat21n66uG48ybZyyp7+YQEekT3h88WdJ6pzVZQYEPPgqBau9ecU38
 Oyya5XjislAepdI6Pr17LC7bJwYao7FRimP20V3Ji1Oh5IMCpT8flVNHzcTfNtBhThzybNOyMjq
 wCqaoCb5XjmPbSw==
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

Thread through the current *hmp monitor, a non-NULL pointer is
guaranteed to be a valid HMP monitor. Adjust doc comments.

Rename _mon()->_hmp() for readability.

No behavioral change.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/error-report.c | 69 ++++++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/util/error-report.c b/util/error-report.c
index aaa15bc79827..41694d61cf2d 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -30,34 +30,29 @@ bool error_with_guestname;
 const char *error_guest_name;
 
 /*
- * Print to the current human monitor if we have one, else to stderr.
+ * Print to the @hmp monitor, else to stderr.
  */
 static int G_GNUC_PRINTF(2, 0)
-error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
+error_vprintf_hmp(MonitorHMP *hmp, const char *fmt, va_list ap)
 {
-    /*
-     * This will return -1 if 'cur_mon' is NULL, or is QMP.
-     * IOW this will only print if in HMP, otherwise we
-     * fallback to stderr for QMP / no-monitor scenarios.
-     */
-    int ret = monitor_vprintf(cur_mon, fmt, ap);
-    if (ret == -1) {
-        ret = vfprintf(stderr, fmt, ap);
+    if (hmp) {
+        return monitor_vprintf(MONITOR(hmp), fmt, ap);
     }
-    return ret;
+
+    return vfprintf(stderr, fmt, ap);
 }
 
 /*
- * Print to the current human monitor if we have one, else to stderr.
+ * Print to the @hmp monitor, else to stderr.
  */
 static int G_GNUC_PRINTF(2, 3)
-error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
+error_printf_hmp(MonitorHMP *hmp, const char *fmt, ...)
 {
     va_list ap;
     int ret;
 
     va_start(ap, fmt);
-    ret = error_vprintf_mon(cur_mon, fmt, ap);
+    ret = error_vprintf_hmp(hmp, fmt, ap);
     va_end(ap);
     return ret;
 }
@@ -67,7 +62,7 @@ error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
  */
 int error_vprintf(const char *fmt, va_list ap)
 {
-    return error_vprintf_mon(monitor_cur(), fmt, ap);
+    return error_vprintf_hmp(monitor_cur_hmp(), fmt, ap);
 }
 
 /*
@@ -79,7 +74,7 @@ int error_printf(const char *fmt, ...)
     int ret;
 
     va_start(ap, fmt);
-    ret = error_vprintf_mon(monitor_cur(), fmt, ap);
+    ret = error_vprintf_hmp(monitor_cur_hmp(), fmt, ap);
     va_end(ap);
     return ret;
 }
@@ -183,13 +178,13 @@ void loc_set_file(const char *fname, int lno)
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
@@ -197,20 +192,20 @@ static void print_loc(Monitor *cur)
     case LOC_CMDLINE:
         argp = cur_loc->ptr;
         for (i = 0; i < cur_loc->num; i++) {
-            error_printf_mon(cur, "%s%s", sep, argp[i]);
+            error_printf_hmp(hmp, "%s%s", sep, argp[i]);
             sep = " ";
         }
-        error_printf_mon(cur, ": ");
+        error_printf_hmp(hmp, ": ");
         break;
     case LOC_FILE:
-        error_printf_mon(cur, "%s:", (const char *)cur_loc->ptr);
+        error_printf_hmp(hmp, "%s:", (const char *)cur_loc->ptr);
         if (cur_loc->num) {
-            error_printf_mon(cur, "%d:", cur_loc->num);
+            error_printf_hmp(hmp, "%d:", cur_loc->num);
         }
-        error_printf_mon(cur, " ");
+        error_printf_hmp(hmp, " ");
         break;
     default:
-        error_printf_mon(cur, "%s", sep);
+        error_printf_hmp(hmp, "%s", sep);
     }
 }
 
@@ -231,47 +226,41 @@ char *real_time_iso8601(void)
 G_GNUC_PRINTF(2, 0)
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
-    /*
-     * When current monitor is QMP, messages must go to stderr
-     * and have prefixes added, so we cast to HMP, leaving 'cur'
-     * as NULL in QMP case
-     */
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
+        error_printf_hmp(hmp, "warning: ");
         break;
     case REPORT_TYPE_INFO:
-        error_printf_mon(cur, "info: ");
+        error_printf_hmp(hmp, "info: ");
         break;
     }
 
-    error_vprintf_mon(cur, fmt, ap);
-    error_printf_mon(cur, "\n");
+    error_vprintf_hmp(hmp, fmt, ap);
+    error_printf_hmp(hmp, "\n");
 
-    if (!cur) {
+    if (!hmp) {
         qemu_funlockfile(stderr);
     }
 }

-- 
2.55.0.543.g5ebe2ebe4ea8



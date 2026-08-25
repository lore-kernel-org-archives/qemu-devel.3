Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0728AC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywZe-0001yX-OU; Tue, 25 Aug 2026 15:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZK-00010E-1n
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZI-0004OQ-5f
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSdjd6mopiASN08pKQqD4mIwrYo7RWGLRrStkeh2qZc=;
 b=gaPmv673qgPQGDG3L2lXitg+Q6Rvo92EFJ2F3vFhglrm22Rnywnyr3P3JDnNd05x9LvCzY
 dF6F+e6hUhL7RJoZb9NlT8UCWnJIYhFxKh3liTJtg5cmBFdocnklVWf8sPf+8YnYK3W9qc
 EQOozWbWYohBGMx3EOe64Pfsu2OFA+M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-fdeexbImNa2OgAeFku8_EQ-1; Tue,
 25 Aug 2026 15:12:16 -0400
X-MC-Unique: fdeexbImNa2OgAeFku8_EQ-1
X-Mimecast-MFC-AGG-ID: fdeexbImNa2OgAeFku8_EQ_1787685135
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 289061953954; Tue, 25 Aug 2026 19:12:15 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AB241955F0C; Tue, 25 Aug 2026 19:12:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:41 +0400
Subject: [PATCH v4 34/49] error-report: switch to use monitor_cur_hmp()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-34-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5495;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iFB7RZJyLqpDZoRjp3LCjEYK6SiM3FoDvc+n89o01zM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiIW2fK5AY0BR1457vlxGHOX4IHJrRosTpXA
 whnmQ+jSAKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5blcD/991YI5bBoc+qR8kprAatdkxCxXzUBQta85AHiqbVos777EQ1BMRR2OnItB8TGlT9kzkFh
 1MB/+7TCW5ojBbftbRtY4ZmQQhGN5RcpcvSENGJAhZiZMFj5KXhant/iobS0RgCzS/r5cq3dEEb
 CLOiXaotvu57l3N+C3zyQT5GB4V7Iiok47q0/y16bSlXtUtMdgZp4W7hn2dFicFEa3FzeuwqRmO
 DWDnDMOempJh7q0bnKJdOoKsC5KBkERhHMBHlHqWTj5pbtUNCZmxb5j89VsrMv5lXeg8WUIzzyn
 TESFzwIY4ddSGuMJ1Xjq7oM4HDxvNkKpYu+7ra+lBdnPw7IIeqWjWNJJv7hoxwcyXlm2+NpLWBs
 my+t9w0fJAX8hZ6ALpQG6wTPhzUoYICdescS3r5RN8D7yvtWdN/EgEnB3Eaqnq0Rtj1vQpjDf1t
 aelvLIwFdC9ky5/f6qNiDyEaiZXDxThcYSgIQda8qvv2Io9CreHlYcU2V1lBu/+5Tr/nfG/dtoG
 VGQOMxnqJ4AgFUVUhT3XhB0B9MqntBA7YIm9LTSZ7a4RREEaxVQmOXsgoXj9Ief0btKRMxdT3RN
 Nz8AomzKNXdiWuJrm8Dzkdr6B5Np/WWsfQJrtCow8eUTipk97tak54OkgB5ghSZ2AminoB9+Qxe
 Bp6BGaxI3EWt/EQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

No behavioral change.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/error-report.c | 69 ++++++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/util/error-report.c b/util/error-report.c
index aaa15bc79827..aa278de6646a 100644
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
+error_vprintf_mon(MonitorHMP *hmp, const char *fmt, va_list ap)
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
+error_printf_mon(MonitorHMP *hmp, const char *fmt, ...)
 {
     va_list ap;
     int ret;
 
     va_start(ap, fmt);
-    ret = error_vprintf_mon(cur_mon, fmt, ap);
+    ret = error_vprintf_mon(hmp, fmt, ap);
     va_end(ap);
     return ret;
 }
@@ -67,7 +62,7 @@ error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
  */
 int error_vprintf(const char *fmt, va_list ap)
 {
-    return error_vprintf_mon(monitor_cur(), fmt, ap);
+    return error_vprintf_mon(monitor_cur_hmp(), fmt, ap);
 }
 
 /*
@@ -79,7 +74,7 @@ int error_printf(const char *fmt, ...)
     int ret;
 
     va_start(ap, fmt);
-    ret = error_vprintf_mon(monitor_cur(), fmt, ap);
+    ret = error_vprintf_mon(monitor_cur_hmp(), fmt, ap);
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
+            error_printf_mon(hmp, "%s%s", sep, argp[i]);
             sep = " ";
         }
-        error_printf_mon(cur, ": ");
+        error_printf_mon(hmp, ": ");
         break;
     case LOC_FILE:
-        error_printf_mon(cur, "%s:", (const char *)cur_loc->ptr);
+        error_printf_mon(hmp, "%s:", (const char *)cur_loc->ptr);
         if (cur_loc->num) {
-            error_printf_mon(cur, "%d:", cur_loc->num);
+            error_printf_mon(hmp, "%d:", cur_loc->num);
         }
-        error_printf_mon(cur, " ");
+        error_printf_mon(hmp, " ");
         break;
     default:
-        error_printf_mon(cur, "%s", sep);
+        error_printf_mon(hmp, "%s", sep);
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
+        error_printf_mon(hmp, "warning: ");
         break;
     case REPORT_TYPE_INFO:
-        error_printf_mon(cur, "info: ");
+        error_printf_mon(hmp, "info: ");
         break;
     }
 
-    error_vprintf_mon(cur, fmt, ap);
-    error_printf_mon(cur, "\n");
+    error_vprintf_mon(hmp, fmt, ap);
+    error_printf_mon(hmp, "\n");
 
-    if (!cur) {
+    if (!hmp) {
         qemu_funlockfile(stderr);
     }
 }

-- 
2.55.0.543.g5ebe2ebe4ea8



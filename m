Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D66CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPopB-0000i3-EJ; Wed, 20 May 2026 17:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPop8-0000d2-Qp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPop6-0004TR-Kx
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksXnSdCisvMLT0xEMZ61fb0FZ9ryLVg4k04RdQxqvL8=;
 b=IEtAybG9R6rsRLxba9tnUPckdqJn4uQcNgGr9g9oR/lOl2sZnJsY70dX9i+celv5hdp+XR
 ofPXr8DWDVjbmImXyAFZ0M87u0XH25OBNIteoTsD34OSkAtle7TaTPaWxrI+sGcA0Hv2nd
 DnLjlUajZCo+hbHwsAz6sA5O5c6Ik3A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-LHrLn0iUOkOJMjbRP1QXpQ-1; Wed,
 20 May 2026 17:51:26 -0400
X-MC-Unique: LHrLn0iUOkOJMjbRP1QXpQ-1
X-Mimecast-MFC-AGG-ID: LHrLn0iUOkOJMjbRP1QXpQ_1779313885
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF3021800451
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:51:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CC811800576; Wed, 20 May 2026 21:51:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:14 +0400
Subject: [PATCH 13/40] RFC: qtest: add -qtest-no-ts option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-13-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11485;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Jw4PEMMLKFEptBB8a458urbLVasRzHu9XlHlSMJ5gr0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDl3VwB5oM4WFYW3ncfYuYTwCaqpglPjkYp
 0B+oz7GtpaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5R6hD/4hXbaFQLBKAnYy35yG/i38Btlj00PiknVldwqNK3q8I1lYcX8EwchdnY+KF8cS6yHIOPq
 hu4gTilpsxy9CKLhnmT1OGXzpU/C6DjdHDeesmwuoZrSXDxwUGqyFJhzV017kCl5PnXuWJ/Q0J6
 NhRrCO4bygWMe7ZsYTFrHxrXzjyK5DKsV3ES30qQ8k93tiH/MgVPSt+tdRWbJ9CAo+WQdy3R/WC
 qgvxSAPLFstk6Ue0BVk5zs8QWjzavVeeYvWXeS13lIMNhVOP86oLa9/18GkwJpGVurUrVUB4BJe
 WmehezkAr/J9aeDtWVyeK11RBCpJZcBEcj1NCb6/Ypo2jIe3x/UWwcp2UxbH9Hb052PS931vgGr
 mlwDmZmuEbYAAgedZQ5trnCH51fsujaCqQ6BPHeL9CR32xXK6MkNV/tnmuVqowRfMGydGEyOyau
 erzFGrpGPw7ZnrAqpXgY9OgjKpOdNzAn4X4ax8uFsGzfvV7U3qoLGvVLYFkC7yWcPeZntFh+gLv
 u3yhosHQOgZ7VSWt9HAeR0uKLY0PbvMQC9l4915Y5DX6lLBMAyh0nQwBCMtshnsrQJ447ICjTWj
 qK3XrliYN8m9UZ2XepJT+nufA7ka4BfHMJh6Y93G94F04NDcS2/BSe4D3LHx8P6AScT6rwcexKZ
 p9RAq4c602mD/qg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Add an option to disable printing the timestamp in the reply.

This may help tests that want to compare the output between runs.
It's not use by this series after all, it could be excluded.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/qom.json                                 |  5 ++-
 include/system/qtest.h                        |  3 +-
 system/qtest.c                                | 61 ++++++++++++++++++++++-----
 system/vl.c                                   |  7 ++-
 qemu-options.hx                               |  1 +
 tests/qemu-iotests/iotests.py                 |  4 +-
 tests/qemu-iotests/tests/copy-before-write    |  4 +-
 tests/qemu-iotests/tests/migrate-bitmaps-test |  4 +-
 8 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087c..c7b6c64d157 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -834,11 +834,14 @@
 #
 # @log: the path to a log file
 #
+# @ts: if true, print timestamps in the log.  Default true.
+#
 # Since: 6.0
 ##
 { 'struct': 'QtestProperties',
         'data': { 'chardev': 'str',
-                  '*log': 'str' } }
+                  '*log': 'str',
+                  '*ts': 'bool' } }
 
 ##
 # @RemoteObjectProperties:
diff --git a/include/system/qtest.h b/include/system/qtest.h
index 7f6dc01d147..2fa06409a84 100644
--- a/include/system/qtest.h
+++ b/include/system/qtest.h
@@ -27,7 +27,8 @@ void G_GNUC_PRINTF(2, 3) qtest_sendf(CharFrontend *chr, const char *fmt, ...);
 void qtest_set_command_cb(bool (*pc_cb)(CharFrontend *chr, gchar **words));
 bool qtest_driver(void);
 
-void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
+void qtest_server_init(const char *qtest_chrdev, const char *qtest_log,
+                       bool qtest_no_ts, Error **errp);
 
 void qtest_server_set_send_handler(void (*send)(void *, const char *),
                                  void *opaque);
diff --git a/system/qtest.c b/system/qtest.c
index a79d10d1361..1fb35ae36bc 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -42,6 +42,7 @@ struct QTest {
     Object parent;
 
     bool has_machine_link;
+    bool ts;
     char *chr_name;
     Chardev *chr;
     CharFrontend qtest_chr;
@@ -57,6 +58,7 @@ static GString *inbuf;
 static int irq_levels[MAX_IRQ];
 static GTimer *timer;
 static bool qtest_opened;
+static bool qtest_ts = true;
 static void (*qtest_server_send)(void*, const char*);
 static void *qtest_server_send_opaque;
 
@@ -270,13 +272,17 @@ static int hex2nib(char ch)
     }
 }
 
-static void qtest_log_timestamp(void)
+static void qtest_log_timestamp(const char c)
 {
     if (!qtest_log_fp || !qtest_opened) {
         return;
     }
 
-    fprintf(qtest_log_fp, "[S +" FMT_timeval "] ", g_timer_elapsed(timer, NULL));
+    fprintf(qtest_log_fp, "[%c", c);
+    if (qtest_ts) {
+        fprintf(qtest_log_fp, " +" FMT_timeval, g_timer_elapsed(timer, NULL));
+    }
+    fprintf(qtest_log_fp, "]");
 }
 
 static void G_GNUC_PRINTF(1, 2) qtest_log_send(const char *fmt, ...)
@@ -287,8 +293,8 @@ static void G_GNUC_PRINTF(1, 2) qtest_log_send(const char *fmt, ...)
         return;
     }
 
-    qtest_log_timestamp();
-
+    qtest_log_timestamp('S');
+    fprintf(qtest_log_fp, " ");
     va_start(ap, fmt);
     vfprintf(qtest_log_fp, fmt, ap);
     va_end(ap);
@@ -306,7 +312,10 @@ static void qtest_server_char_be_send(void *opaque, const char *str)
 
 static void qtest_send(CharFrontend *chr, const char *str)
 {
-    qtest_log_timestamp();
+    if (qtest_log_fp) {
+        qtest_log_timestamp('S');
+        fprintf(qtest_log_fp, " ");
+    }
     qtest_server_send(qtest_server_send_opaque, str);
 }
 
@@ -364,7 +373,7 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
     if (qtest_log_fp) {
         int i;
 
-        fprintf(qtest_log_fp, "[R +" FMT_timeval "]", g_timer_elapsed(timer, NULL));
+        qtest_log_timestamp('R');
         for (i = 0; words[i]; i++) {
             fprintf(qtest_log_fp, " %s", words[i]);
         }
@@ -812,7 +821,8 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
         timer = g_timer_new();
         qtest_opened = true;
         if (qtest_log_fp) {
-            fprintf(qtest_log_fp, "[I " FMT_timeval "] OPENED\n", g_timer_elapsed(timer, NULL));
+            qtest_log_timestamp('I');
+            fprintf(qtest_log_fp, " OPENED\n");
         }
         break;
     case CHR_EVENT_CLOSED:
@@ -820,10 +830,11 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
             /* Ignore CLOSED events if we have already closed the log */
             break;
         }
-        qtest_opened = false;
         if (qtest_log_fp) {
-            fprintf(qtest_log_fp, "[I +" FMT_timeval "] CLOSED\n", g_timer_elapsed(timer, NULL));
+            qtest_log_timestamp('I');
+            fprintf(qtest_log_fp, " CLOSED\n");
         }
+        qtest_opened = false;
         g_clear_pointer(&timer, g_timer_destroy);
         break;
     default:
@@ -831,7 +842,8 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **errp)
+void qtest_server_init(const char *qtest_chrdev, const char *qtest_log,
+                       bool no_ts, Error **errp)
 {
     ERRP_GUARD();
     Chardev *chr;
@@ -849,6 +861,9 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
     if (qtest_log) {
         object_property_set_str(qobj, "log", qtest_log, &error_abort);
     }
+    if (no_ts) {
+        object_property_set_bool(qobj, "ts", false, &error_abort);
+    }
     object_property_add_child(qdev_get_machine(), "qtest", qobj);
     user_creatable_complete(USER_CREATABLE(qobj), errp);
     if (*errp) {
@@ -871,6 +886,8 @@ static bool qtest_server_start(QTest *q, Error **errp)
         qtest_log_fp = stderr;
     }
 
+    qtest_ts = q->ts;
+
     if (!qemu_chr_fe_init(&q->qtest_chr, chr, errp)) {
         return false;
     }
@@ -974,6 +991,20 @@ static char *qtest_get_log(Object *obj, Error **errp)
     return g_strdup(q->log);
 }
 
+static bool qtest_get_ts(Object *obj, Error **errp)
+{
+    QTest *q = QTEST(obj);
+
+    return q->ts;
+}
+
+static void qtest_set_ts(Object *obj, bool value, Error **errp)
+{
+    QTest *q = QTEST(obj);
+
+    q->ts = value;
+}
+
 static void qtest_set_chardev(Object *obj, const char *value, Error **errp)
 {
     QTest *q = QTEST(obj);
@@ -1018,6 +1049,8 @@ static void qtest_class_init(ObjectClass *oc, const void *data)
                                   qtest_get_chardev, qtest_set_chardev);
     object_class_property_add_str(oc, "log",
                                   qtest_get_log, qtest_set_log);
+    object_class_property_add_bool(oc, "ts",
+                                   qtest_get_ts, qtest_set_ts);
 }
 
 static void qtest_finalize(Object *obj)
@@ -1029,10 +1062,18 @@ static void qtest_finalize(Object *obj)
     object_unref(q->chr);
 }
 
+static void qtest_init(Object *obj)
+{
+    QTest *q = QTEST(obj);
+
+    q->ts = true;
+}
+
 static const TypeInfo qtest_info = {
     .name = TYPE_QTEST,
     .parent = TYPE_OBJECT,
     .class_init = qtest_class_init,
+    .instance_init = qtest_init,
     .instance_finalize = qtest_finalize,
     .instance_size = sizeof(QTest),
     .interfaces = (const InterfaceInfo[]) {
diff --git a/system/vl.c b/system/vl.c
index f4d55f0addd..4797700abd5 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -193,6 +193,7 @@ static const char *log_file;
 static bool list_data_dirs;
 static const char *qtest_chrdev;
 static const char *qtest_log;
+static bool qtest_no_ts;
 
 static int has_defaults = 1;
 static int default_audio = 1;
@@ -2092,7 +2093,8 @@ static bool object_create_late(const char *type)
 static void qemu_create_late_backends(void)
 {
     if (qtest_chrdev) {
-        qtest_server_init(qtest_chrdev, qtest_log, &error_fatal);
+        qtest_server_init(qtest_chrdev, qtest_log, qtest_no_ts,
+                          &error_fatal);
     }
 
     net_init_clients();
@@ -3596,6 +3598,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_qtest_log:
                 qtest_log = optarg;
                 break;
+            case QEMU_OPTION_qtest_no_ts:
+                qtest_no_ts = true;
+                break;
             case QEMU_OPTION_sandbox:
                 olist = qemu_find_opts("sandbox");
                 if (!olist) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787b..4c1b32713e0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5584,6 +5584,7 @@ ERST
 HXCOMM Internal use
 DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
 DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
+DEF("qtest-no-ts", 0, QEMU_OPTION_qtest_no_ts, "", QEMU_ARCH_ALL)
 
 #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 05274772ce4..5a4d843886d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -712,8 +712,8 @@ def filter_nbd_exports(output: str) -> str:
     return re.sub(r'((min|opt|max) block): [0-9]+', r'\1: XXX', output)
 
 def filter_qtest(output: str) -> str:
-    output = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', output)
-    output = re.sub(r'\n?\[I \+\d+\.\d+\] CLOSED\n?$', '', output)
+    output = re.sub(r'^\[I \+?\d+\.\d+\] OPENED\n', '', output)
+    output = re.sub(r'\n?\[I \+?\d+\.\d+\] CLOSED\n?$', '', output)
     return output
 
 Msg = TypeVar('Msg', Dict[str, Any], List[Any], str)
diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index 236cb8ac374..f86032b1167 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -273,8 +273,8 @@ read 1048576/1048576 bytes at offset 0
 
         self.vm.shutdown()
         log = self.vm.get_log()
-        log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
-        log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
+        log = re.sub(r'^\[I \+?\d+\.\d+\] OPENED\n', '', log)
+        log = re.sub(r'\[I \+?\d+\.\d+\] CLOSED\n?$', '', log)
         log = iotests.filter_qemu_io(log)
         return log
 
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iotests/tests/migrate-bitmaps-test
index 8fb4099201d..eec110757a6 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test
@@ -195,8 +195,8 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             # catch 'Could not reopen qcow2 layer: Bitmap already exists'
             # possible error
             log = self.vm_b.get_log()
-            log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
-            log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
+            log = re.sub(r'^\[I \+?\d+\.\d+\] OPENED\n', '', log)
+            log = re.sub(r'\[I \+?\d+\.\d+\] CLOSED\n?$', '', log)
             self.assertEqual(log, '')
 
             # recreate vm_b, as we don't want -incoming option (this will lead

-- 
2.54.0



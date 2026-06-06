Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672A3CD6E55
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVjPr-0006qd-RJ; Sat, 06 Jun 2026 01:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPo-0006eW-KW
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVjPm-0008RC-Ci
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 01:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780723065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VyZiJ2ahA2S/F2Rs8hb2fk5gvFLJAv/h8MtGmJNquk=;
 b=L1dMWXbhaxLm60jXAH7a9Ryzx3nlV/8O19iMjJQNUrVriluGFbNUAi0cWoQgq3YimEqNxz
 grGVuBzA1XaR3V0jDekRJPpCfMmRlPx7NcBXrOTnjGKn4Qgi5JPbo22D3ZVNG2i087j7+W
 QiEs0kfh25qXuso0gYCOejiKzU587S4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-W4Y3m4VGM9ea7ZdqHqLVjg-1; Sat,
 06 Jun 2026 01:17:43 -0400
X-MC-Unique: W4Y3m4VGM9ea7ZdqHqLVjg-1
X-Mimecast-MFC-AGG-ID: W4Y3m4VGM9ea7ZdqHqLVjg_1780723062
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 345ED19560A3
 for <qemu-devel@nongnu.org>; Sat,  6 Jun 2026 05:17:42 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5F611955BC0; Sat,  6 Jun 2026 05:17:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 06 Jun 2026 09:15:55 +0400
Subject: [GIT PULL v2 23/23] qtest: add "qom-tests" command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260606-qom-tests-v2-23-55832d978a9f@redhat.com>
References: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
In-Reply-To: <20260606-qom-tests-v2-0-55832d978a9f@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=4983;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BgJPBPmH5B6RRCynYwgwnZTtBG1LgQz3rhYtKXyzYDQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqI6z1mCW8lMLQNLJUh6MRBhMGcMMP4ZseNfkhc
 FOn7UvKZRuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiOs9QAKCRDa6OEJdZac
 5bD9D/wOvKwJ6mycP7q3Yt6mad004NMXPD79GQeUydevG0HuImvbRbdZRDGqS/9L9u47b/R5JjV
 u8L5jrDp0y39NdN3Hugah/ufvXG61iUdc9Ah670lCv/+iMHModyLkBQocg5UYv375jcCGXkdJfp
 HXajRHbtrJMyXWt+odvx28cFypEgJwy3kX7hdfOm6zL/kLuYFsd2KcVr6iR09UXsrRq/n+YOqCN
 Tobz0UdZcYnFVX5XKKDp9fu8WTm4OJhDig96JV5AJrwr4VCT6HWnpkouBawq95YwS9H2LUbbILB
 Ul7FyGJjpr7RTbDmtTWn0XcF8e05Dr5rEKwQ9A+3LgHzs2cSU6BnPk58sOEFwFsgiAB+6Pv1UZM
 RMBVmAUlfFHfCXhYhyHZa9IZqlqkfKCUDf225ht2jdgVH16oyZsvHYV/4KIhm5L/i/C0lD2orUJ
 Y00D0iG80++ZbLMlai6P44d26b/D+sqFeBL0g6vI6tfyQq2vv6sLe9oK+QbigXqd8j8wXu1EBmO
 cvArqJfh+P7vH4eVBxbDvnhCklnNMBA3LCo9b/I2t1ZdynIlL1EaQV7GORDqdql8vg+wWgpps0F
 gRAAKYqB2TkRFC+ntRproimCsSWhXEV9/pxF76UprdYtdHJrUWvlHtGnyZv3HfDmU+hOTlPRyNn
 UZwsD/Dajuo6HoQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a new "qom-tests" to exercise basic object lifecycle. Instantiate
all non-abstract objects, get and set properties and unref.

This should quickly find leaks and other related issues that are
eventually triggerable at run-time with QMP qom commands.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/libqtest.h |  8 ++++++++
 system/qtest.c         | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c |  6 ++++++
 tests/qtest/qom-test.c | 12 ++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 950ea2baafa..45217fb8dc0 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -426,6 +426,14 @@ char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
 
 void qtest_module_load(QTestState *s, const char *prefix, const char *libname);
 
+/**
+ * qtest_qom_tests:
+ * @s: #QTestState instance to operate on.
+ *
+ * Run QOM property get/set round-trip tests on all non-abstract types.
+ */
+void qtest_qom_tests(QTestState *s);
+
 /**
  * qtest_get_irq:
  * @s: #QTestState instance to operate on.
diff --git a/system/qtest.c b/system/qtest.c
index d6db057b0a2..fd37bcbfaab 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -31,6 +31,8 @@
 #include "qemu/cutils.h"
 #include "qemu/target-info.h"
 #include "qom/object_interfaces.h"
+#include "qom/qom-qobject.h"
+#include "qobject/qobject.h"
 
 #define MAX_IRQ 256
 
@@ -754,6 +756,50 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         new_ns = qemu_clock_advance_virtual_time(ns);
         qtest_sendf(chr, "%s %"PRIi64"\n",
                     new_ns == ns ? "OK" : "FAIL", new_ns);
+    } else if (strcmp(words[0], "qom-tests") == 0) {
+        GSList *list, *l;
+
+        list = object_class_get_list(NULL, false);
+        for (l = list; l; l = l->next) {
+            ObjectClass *klass = l->data;
+            const char *type_name = object_class_get_name(klass);
+            Object *obj;
+            ObjectPropertyIterator iter;
+            ObjectProperty *prop;
+
+            obj = object_new_with_class(klass);
+            object_property_iter_init(&iter, obj);
+            while ((prop = object_property_iter_next(&iter))) {
+                QObject *value;
+                Error *local_err = NULL;
+
+                value = object_property_get_qobject(obj, prop->name,
+                                                    &local_err);
+                if (local_err) {
+                    error_report("qom-tests: %s.%s: get failed: %s",
+                                 type_name, prop->name,
+                                 error_get_pretty(local_err));
+                    error_free(local_err);
+                    continue;
+                }
+
+                if (prop->set) {
+                    if (!object_property_set_qobject(obj, prop->name, value,
+                                                     &local_err)) {
+                        error_report("qom-tests: %s.%s: set failed: %s",
+                                     type_name, prop->name,
+                                     error_get_pretty(local_err));
+                        error_free(local_err);
+                    }
+                }
+
+                qobject_unref(value);
+            }
+
+            object_unref(obj);
+        }
+        g_slist_free(list);
+        qtest_send(chr, "OK\n");
     } else if (process_command_cb && process_command_cb(chr, words)) {
         /* Command got consumed by the callback handler */
     } else {
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index b1e06ea364e..4e22c66b754 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1137,6 +1137,12 @@ void qtest_module_load(QTestState *s, const char *prefix, const char *libname)
     qtest_rsp(s);
 }
 
+void qtest_qom_tests(QTestState *s)
+{
+    qtest_sendf(s, "qom-tests\n");
+    qtest_rsp(s);
+}
+
 static int64_t qtest_clock_rsp(QTestState *s)
 {
     gchar **words;
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 6421f2d9d9f..cf4c6b5add5 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -227,6 +227,17 @@ static void add_machine_test_case(const char *mname)
     g_free(path);
 }
 
+static void test_qom_qtests(void)
+{
+    QTestState *qts;
+
+    qts = qtest_initf("-machine none");
+
+    qtest_qom_tests(qts);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     char *v_env = getenv("V");
@@ -238,6 +249,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_cb_for_every_machine(add_machine_test_case, g_test_quick());
+    qtest_add_func("qom/qom-qtests", test_qom_qtests);
 
     return g_test_run();
 }

-- 
2.54.0



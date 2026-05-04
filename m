Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50730FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJreS-0002Q9-E4; Mon, 04 May 2026 07:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJreL-0001a0-Js
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJreK-0001WJ-2F
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OR1htZtPy9/ewnuvz0qTtYpMlOdlZO7yT3IR5sS3quc=;
 b=hnR/fSlg9C+LQDwFrLraBI1nOUOAkTSGN/Cy41RfthbbI2Km3RAjhc8FZlGLD+xrYPEs8X
 3uLfxcYwcYajcsuzdOyiXChhfr4zp68qbBn4EfBKE5OLHZDgscpUUUPdHAGQ/pNa7Vu1zC
 AZmZck0Aun5lkVI3HMOJp60wdS/Hxoo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-XtjKbE28NnWnxmF-LCI41A-1; Mon,
 04 May 2026 07:39:42 -0400
X-MC-Unique: XtjKbE28NnWnxmF-LCI41A-1
X-Mimecast-MFC-AGG-ID: XtjKbE28NnWnxmF-LCI41A_1777894781
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 619D2195609F
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:39:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01CB91800480; Mon,  4 May 2026 11:39:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:34 +0400
Subject: [PATCH v2 46/46] qtest: add "qom-tests" command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-46-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4927;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=E9TpC9GWV8bqxBoLpoxzMTuPROZJrQcouJvw3SoAg8M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRuaF0a9jmoWRbNyjGaxuhLUmB4IG74V+4C6
 enXj/Iu1EeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbgAKCRDa6OEJdZac
 5bUmD/0fsu4AwWUA/xzLySW6gtXHT2lYcJtT1dGUy00pPv43BP3Zy+8hqF71RwUQ0kdq+BfMciV
 39OO+Y0hUUl8vjtfO//FsVklsl0pIIHjtSFHEqPBEvsCKz/lXfPSNDtpCpy9S0yRt9r5Qvxe5Td
 0irJWDhspBACxtg6rIwQgs4mW1Ow0KHEOJaUQNj5s947+VYXoqTATNvmLxBLd6GMq49dSpoFCr2
 qyCNfMNdwMZ24QIccLepfGgDmyMmPdypn0R97IuGxN0F0cIo0qmI17croDoNCk2bijXBo7YL4eT
 o9pRRI8uQHzuR4LhuzzEPFamOPhb42cd5HJAzFtW9HBo9gIhqcYe2sAfRW2RTITrFGdGinz+uXe
 5F7h+lDGENiuEHzsYHVAZgkw8TIGn7kQgmkVmr7nuCpoRto5RvyM2TT3IVUsYwWteT30CZV8Q9y
 JtBaBYqDBrpb3U84FnpIj5WSuIVB3T1EVnxidj1ylovGIytWW400b+nO3dZ7/pAlT587wH3KzSG
 kccOTafecCAwZ36+wI80sWikGPo9BMiaifHQehW/2os0LhWoT35VHuPyYxpF9uV1OrKYHE5foB7
 CkVzsCDgQ5pBc1BQXjvgze11jyd74yZJg5On/T1+t6K8y/TqlaLoQNR/UdT8boqOd7VlFLAuk7A
 wgV7IL/rKK9JpLg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/libqtest.h |  8 ++++++++
 system/qtest.c         | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c |  6 ++++++
 tests/qtest/qom-test.c | 12 ++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 9c118c89ca0..02d65ecb65d 100644
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
index a79d10d1361..a44a581a518 100644
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
index 116a8a32583..1d77d003112 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1138,6 +1138,12 @@ void qtest_module_load(QTestState *s, const char *prefix, const char *libname)
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



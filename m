Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEF2C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvLM-00089j-Eb; Fri, 28 Aug 2026 08:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLK-00080u-9U
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLH-0002oD-E8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZsxvA3+Eswlq3875vl2+ihmlePaGHtJpNpgPCJe/j0=;
 b=hSAjxULjH+UqTdnxaBm9IgMcLMgS6hY9BB+AVpHXiwFkOzSPeDMsYJ4F4hqExlJBl5TKbj
 hp5KzwBMru/2KAt0ZpeBNsVpBBNqisqx9YWI+vFjpygdY/9F99+9r+T3xJV6PqZILZURpH
 7gpZ2MOq3xETuRGHFbFb+iXBQiXhpSM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-6eGc8ymSObua9qhrmio2nA-1; Fri,
 28 Aug 2026 08:05:51 -0400
X-MC-Unique: 6eGc8ymSObua9qhrmio2nA-1
X-Mimecast-MFC-AGG-ID: 6eGc8ymSObua9qhrmio2nA_1787918750
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 005BD1944A90; Fri, 28 Aug 2026 12:05:50 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 277A07E0; Fri, 28 Aug 2026 12:05:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:14 +0400
Subject: [PATCH v5 17/50] tests/qtest/device-introspect-test: restrict test
 when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-17-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4822;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0OxhhJkNHotN616ng1iZyyIi93rxsYwoDZxbUKoJOOs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk431GeyeugRakjBS3gn+ws26gzN/CGJk2ZU
 3P+BwPG2piJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5YbhD/9jxjJjQLEUOBqzeNbDReSrUMizm9RqJFYNN0P1Kyc07Lhiql7WwmLpMRLAkLL/x9/6P3T
 CdK52fypVaw23g/7Y/qAknk4xpbfV1BMr7khVg8iaVEixsnQMQ821oQVqz+V86+bhHykpjN46rn
 bJWpADgOAz0RbvoHwad9vLl2zPnRj+BtavRbCsA1fm0zjBw7eDLtI0zPjHG+HDShMh23rr5qW8c
 Q4QM2F0tiIFLAkRT7Gt9ssZTtNf0pnj420cqdqgsgevdFcualOJ+W9I4chmaNEw4M8Pt4wMp1Hq
 dFKgpwEA0DPoo2guImPEN3uLAIWLrN/0HFV+kf5gIMmXFyunHTgB4A0e1Esfy64R5ZWMCBZT5x9
 z/9WRSDiX1q0mDz3CgTmXWZI6lsmE4JCvR5WE8sM2hyC1/vocrjUL4667P07yntzh60gFRgF1xZ
 IR8G40YAMB0Xo5gHUWoKzvtAQaU4vfGkUB0BWPcZq2to8efxuqaRVflqmJbASIggAp4h8Oio0xW
 erobaBwanqMg/jqA9xfr/lO2HWAFTiwk+vBuJhfZyo8BngzsDSDteblyAQ1OQ77/kygVMfII1mx
 Qih1V4aL0W8eRPvWZ0nYJasnSo/w0pFKtbtKfQrsQ6CvWnGDLw+1QANSXmT5Wl3jrOooCpyG3cT
 1QKKtoMWRMRwJEQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Wrap all HMP-dependent code paths in #ifdef CONFIG_HMP.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/device-introspect-test.c | 46 +++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index 1ee441e19a0a..f6eca2c8eb7e 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -11,10 +11,10 @@
  */
 
 /*
- * Covers QMP device-list-properties and HMP device_add help.  We
- * currently don't check that their output makes sense, only that QEMU
- * survives.  Useful since we've had an astounding number of crash
- * bugs around here.
+ * Covers QMP device-list-properties and HMP device_add help (if
+ * CONFIG_HMP).  We currently don't check that the output makes sense,
+ * only that QEMU survives.  Useful since we've had an astounding
+ * number of crash bugs around here.
  */
 
 #include "qemu/osdep.h"
@@ -154,8 +154,6 @@ static char *qom_tree_str(QTestState *qts)
 static void test_one_device(QTestState *qts, const char *type)
 {
     QDict *resp;
-    char *help, *escaped;
-    GRegex *comma;
 
     g_test_message("Testing device '%s'", type);
 
@@ -164,19 +162,21 @@ static void test_one_device(QTestState *qts, const char *type)
                type);
     qobject_unref(resp);
 
-    comma = g_regex_new(",", 0, 0, NULL);
-    escaped = g_regex_replace_literal(comma, type, -1, 0, ",,", 0, NULL);
-    g_regex_unref(comma);
+#ifdef CONFIG_HMP
+    {
+        g_autofree char *escaped = NULL;
+        g_autoptr(GRegex) comma = NULL;
 
-    help = qtest_hmp(qts, "device_add \"%s,help\"", escaped);
-    g_free(help);
-    g_free(escaped);
+        comma = g_regex_new(",", 0, 0, NULL);
+        escaped = g_regex_replace_literal(comma, type, -1, 0, ",,", 0, NULL);
+        g_free(qtest_hmp(qts, "device_add \"%s,help\"", escaped));
+    }
+#endif
 }
 
 static void test_device_intro_list(void)
 {
     QList *types;
-    char *help;
     QTestState *qts;
 
     qts = qtest_init(common_args);
@@ -184,8 +184,11 @@ static void test_device_intro_list(void)
     types = device_type_list(qts, true);
     qobject_unref(types);
 
-    help = qtest_hmp(qts, "device_add help");
-    g_free(help);
+#ifdef CONFIG_HMP
+    {
+        g_free(qtest_hmp(qts, "device_add help"));
+    }
+#endif
 
     qtest_quit(qts);
 }
@@ -251,16 +254,20 @@ static void test_device_intro_none(void)
     QTestState *qts = qtest_init(common_args);
     g_autofree char *qom_tree_start = qom_tree_str(qts);
     g_autofree char *qom_tree_end = NULL;
+#ifdef CONFIG_HMP
     g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
     g_autofree char *qtree_end = NULL;
+#endif
 
     test_one_device(qts, "nonexistent");
 
     /* Make sure that really nothing changed in the trees */
     qom_tree_end = qom_tree_str(qts);
     g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
+#ifdef CONFIG_HMP
     qtree_end = qtest_hmp(qts, "info qtree");
     g_assert_cmpstr(qtree_start, ==, qtree_end);
+#endif
 
     qtest_quit(qts);
 }
@@ -270,16 +277,20 @@ static void test_device_intro_abstract(void)
     QTestState *qts = qtest_init(common_args);
     g_autofree char *qom_tree_start = qom_tree_str(qts);
     g_autofree char *qom_tree_end = NULL;
+#ifdef CONFIG_HMP
     g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
     g_autofree char *qtree_end = NULL;
+#endif
 
     test_one_device(qts, "device");
 
     /* Make sure that really nothing changed in the trees */
     qom_tree_end = qom_tree_str(qts);
     g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
+#ifdef CONFIG_HMP
     qtree_end = qtest_hmp(qts, "info qtree");
     g_assert_cmpstr(qtree_start, ==, qtree_end);
+#endif
 
     qtest_quit(qts);
 }
@@ -292,8 +303,10 @@ static void test_device_intro_concrete(const void *args)
     QTestState *qts = qtest_init(args);
     g_autofree char *qom_tree_start = qom_tree_str(qts);
     g_autofree char *qom_tree_end = NULL;
+#ifdef CONFIG_HMP
     g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
     g_autofree char *qtree_end = NULL;
+#endif
 
     types = device_type_list(qts, false);
 
@@ -311,9 +324,10 @@ static void test_device_intro_concrete(const void *args)
      */
     qom_tree_end = qom_tree_str(qts);
     g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
-
+#ifdef CONFIG_HMP
     qtree_end = qtest_hmp(qts, "info qtree");
     g_assert_cmpstr(qtree_start, ==, qtree_end);
+#endif
 
     qobject_unref(types);
     qtest_quit(qts);

-- 
2.55.0.543.g5ebe2ebe4ea8



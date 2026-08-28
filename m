Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664F8C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Po-0006zt-UG; Fri, 28 Aug 2026 16:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pn-0006yn-DT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pl-0008Mz-O7
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDByVdbOQzj/X5djpv63KJlGsQvNstABsTuLcMC55Y8=;
 b=Emc6zy+GaxPuNwL0UrbrsNan64yExkGpMzwEO44EZbL0PeBXpJ9LYCkLnX7+PARM3ittIQ
 RsqfDWffk6Uuo1vpLLEdDZmcnFLzgUS0VDRfSpWJAqQ3jnvnuZvav8D76pJtLG7d3wEuH1
 N5vBzaTZHhyUaNL394lBiaCm6Qc2Fqg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-wCNyhkRyPeKZ4yMdAfIQMg-1; Fri,
 28 Aug 2026 16:43:01 -0400
X-MC-Unique: wCNyhkRyPeKZ4yMdAfIQMg-1
X-Mimecast-MFC-AGG-ID: wCNyhkRyPeKZ4yMdAfIQMg_1787949780
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D72C190A0BF; Fri, 28 Aug 2026 20:43:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3C8818005AC; Fri, 28 Aug 2026 20:42:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:56 +0400
Subject: [GIT PULL 17/50] tests/qtest/device-introspect-test: restrict test
 when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-17-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4888;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bX1+LSgjrqP6lVsB/sGXy4CiqpBFIviTTy/TUQSFOUI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUMhHHHdaNsRWnytVdMmzuuynUQlWjxjZAI
 7vWpcWcE2eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5XDoD/sF75jCOMrslDIJKX2PWwc7ebZ1VKaAtQLvV1DfEzLzlxD/EpgHClSy0ghhwl9ob9awNUy
 BvRRoyWO2d9r0CrWYOdyqLxiFi9v81EXqZOHbnNz8J7SXxgQljww+VM51iAz9C0XA95zZ4jCUdo
 8mQL6tMN1xlYHAk1THHZ9LfyqGc+PAtN8YmZhLHVFNroaQejWNNArCOgTevX6qJI7b9FkeLIafg
 SHoCeRO3Q4j++qlBL3WHCoyYgDQ3VppmAi9IWS9bwcT7FGYtmhEwYyObg/lwng7yhAlwKduE3ZM
 V+2YZnoWgEqE1/SBZsCQ99KqkFzlNcORJXOEb0NwgBBW0RZ2KB2srRx0wWGQW04ApHAvUj29nGT
 QJAsBmWSc53GEmmjMWoDCx2114rnY7eroUZUYxDqd/ktX3v6pgSird2xehwRNVDDwsIymCs8csK
 ApytJNNWmaIJ6zp/P3pXDvRNqzW16yelrdXMBZbMaiCzgfIW0oboMX2T2VJCjPOqI9dns4UWBQT
 cHr99qKPFXxbXlftkO7aLZVAjnACwQgjmPcVBwbT1D4WJX/VAPcI0tdJ+IDBXuMkmIsXrzsGUBj
 3dmslF2b1IGI11ajVmeicFCgJYHZ1rxy1VmbriCboIVJ0UN0UWEpLDNUeQtqzkUpWwONoALTDNM
 Zw87jeDpnZsxfOw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
Message-ID: <20260828-qemu-no-hmp-v5-17-9227de146347@redhat.com>
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



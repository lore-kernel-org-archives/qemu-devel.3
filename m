Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7539FCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBY0g-0002Mp-Hs; Wed, 22 Oct 2025 08:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXzJ-0001RO-IT
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXzF-0008RD-Lx
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xm0lAR7m+7Yigr6CnsX4IQzn/DIW8aFNZGH/VklZDhY=;
 b=ayOUl1mtvKSjFGqRW9sIrEbjVmw4KVOAnn2e43BE6a+TK18D4ZwVtVLY7wU8+jyYmiMIV8
 HBNGhFjrCQFxYXI1S4eHn6NWtoxpkz+7e0VK4j8x8kMkYhVH3hfPIKIAonjy1ekw6COnZA
 9Hrta34+K2qwtmbHbOeE57RV+xALY04=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-hk3-HJF4OruOW3NPOLI5Ag-1; Wed,
 22 Oct 2025 08:30:34 -0400
X-MC-Unique: hk3-HJF4OruOW3NPOLI5Ag-1
X-Mimecast-MFC-AGG-ID: hk3-HJF4OruOW3NPOLI5Ag_1761136233
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC2471809A04; Wed, 22 Oct 2025 12:30:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13501180058A; Wed, 22 Oct 2025 12:30:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Felix Wu <flwu@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/16] tests/qtest: Add qtest for for ASPEED GPIO gpio-set
 property
Date: Wed, 22 Oct 2025 14:29:51 +0200
Message-ID: <20251022122953.877335-15-clg@redhat.com>
In-Reply-To: <20251022122953.877335-1-clg@redhat.com>
References: <20251022122953.877335-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Felix Wu <flwu@google.com>

 - Added qtests to test gpio-set property for ASPEED.
 - Added function to get uint in qdict.

Signed-off-by: Felix Wu <flwu@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251015011830.1688468-3-lixiaoyan@google.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/qobject/qdict.h        |   1 +
 qobject/qdict.c                |  13 ++++
 tests/qtest/aspeed_gpio-test.c | 105 ++++++++++++++++++++++++++++++---
 3 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/include/qobject/qdict.h b/include/qobject/qdict.h
index 903e6e5462fb..861996f08dd6 100644
--- a/include/qobject/qdict.h
+++ b/include/qobject/qdict.h
@@ -57,6 +57,7 @@ void qdict_put_str(QDict *qdict, const char *key, const char *value);
 
 double qdict_get_double(const QDict *qdict, const char *key);
 int64_t qdict_get_int(const QDict *qdict, const char *key);
+uint64_t qdict_get_uint(const QDict *qdict, const char *key);
 bool qdict_get_bool(const QDict *qdict, const char *key);
 QList *qdict_get_qlist(const QDict *qdict, const char *key);
 QDict *qdict_get_qdict(const QDict *qdict, const char *key);
diff --git a/qobject/qdict.c b/qobject/qdict.c
index a90ac9ae2f89..0dafe6d42179 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -209,6 +209,19 @@ int64_t qdict_get_int(const QDict *qdict, const char *key)
     return qnum_get_int(qobject_to(QNum, qdict_get(qdict, key)));
 }
 
+/**
+ * qdict_get_uint(): Get an unsigned integer mapped by 'key'
+ *
+ * This function assumes that 'key' exists and it stores a
+ * QNum representable as uint.
+ *
+ * Return unsigned integer mapped by 'key'.
+ */
+uint64_t qdict_get_uint(const QDict *qdict, const char *key)
+{
+    return qnum_get_uint(qobject_to(QNum, qdict_get(qdict, key)));
+}
+
 /**
  * qdict_get_bool(): Get a bool mapped by 'key'
  *
diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
index 12675d4cbba9..c2f9ca2298a7 100644
--- a/tests/qtest/aspeed_gpio-test.c
+++ b/tests/qtest/aspeed_gpio-test.c
@@ -27,28 +27,115 @@
 #include "qemu/timer.h"
 #include "qobject/qdict.h"
 #include "libqtest-single.h"
+#include "qemu/typedefs.h"
 
 #define AST2600_GPIO_BASE 0x1E780000
 
 #define GPIO_ABCD_DATA_VALUE 0x000
 #define GPIO_ABCD_DIRECTION  0x004
 
+static uint32_t qtest_qom_get_uint32(QTestState *s, const char *path,
+                                     const char *property)
+{
+    QDict *r;
+
+    uint32_t res;
+    r = qtest_qmp(s, "{ 'execute': 'qom-get', 'arguments': "
+                     "{ 'path': %s, 'property': %s } }", path, property);
+    res = qdict_get_uint(r, "return");
+    qobject_unref(r);
+
+    return res;
+}
+
+static void qtest_qom_set_uint32(QTestState *s, const char *path,
+                                 const char *property, uint32_t value)
+{
+    QDict *r;
+
+    r = qtest_qmp(s, "{ 'execute': 'qom-set', 'arguments': "
+                     "{ 'path': %s, 'property': %s, 'value': %" PRIu32 " } }",
+                     path, property, value);
+    qobject_unref(r);
+}
+
+static const char *resp_get_error(QDict *r, const char* error_key)
+{
+    QDict *qdict;
+
+    g_assert(r);
+
+    qdict = qdict_get_qdict(r, "error");
+    if (qdict) {
+        return qdict_get_str(qdict, error_key);
+    }
+
+    return NULL;
+}
+
+static bool qtest_qom_check_error(QTestState *s, const char *path,
+                                  const char *property, const char *error_msg,
+                                  const char *error_msg_key)
+{
+    QDict *r;
+    bool b;
+
+    r = qtest_qmp(s, "{ 'execute': 'qom-get', 'arguments': "
+                     "{ 'path': %s, 'property': %s } }", path, property);
+    b = g_str_equal(resp_get_error(r, error_msg_key), error_msg);
+    qobject_unref(r);
+
+    return b;
+}
+
 static void test_set_colocated_pins(const void *data)
 {
     QTestState *s = (QTestState *)data;
-
+    const char path[] = "/machine/soc/gpio";
     /*
      * gpioV4-7 occupy bits within a single 32-bit value, so we want to make
      * sure that modifying one doesn't affect the other.
      */
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV4", true);
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV5", false);
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV6", true);
-    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV7", false);
-    g_assert(qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV4"));
-    g_assert(!qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV5"));
-    g_assert(qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV6"));
-    g_assert(!qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV7"));
+    qtest_qom_set_bool(s, path, "gpioV4", true);
+    qtest_qom_set_bool(s, path, "gpioV5", false);
+    qtest_qom_set_bool(s, path, "gpioV6", true);
+    qtest_qom_set_bool(s, path, "gpioV7", false);
+    g_assert(qtest_qom_get_bool(s, path, "gpioV4"));
+    g_assert(!qtest_qom_get_bool(s, path, "gpioV5"));
+    g_assert(qtest_qom_get_bool(s, path, "gpioV6"));
+    g_assert(!qtest_qom_get_bool(s, path, "gpioV7"));
+
+    /*
+     * Testing the gpio-set[%d] properties, using individual gpio boolean
+     * properties to do cross check.
+     * We use gpioR4-7 for test, Setting them to be 0b1010.
+     */
+    qtest_qom_set_uint32(s, path, "gpio-set[4]", 0x0);
+    g_assert(qtest_qom_get_uint32(s, path, "gpio-set[4]") == 0x0);
+    qtest_qom_set_uint32(s, path, "gpio-set[4]", 0xa000);
+    g_assert(qtest_qom_get_uint32(s, path, "gpio-set[4]") == 0xa000);
+
+    g_assert(!qtest_qom_get_bool(s, path, "gpioR4"));
+    g_assert(qtest_qom_get_bool(s, path, "gpioR5"));
+    g_assert(!qtest_qom_get_bool(s, path, "gpioR6"));
+    g_assert(qtest_qom_get_bool(s, path, "gpioR7"));
+
+    /*
+     * Testing the invalid indexing, the response info should contain following
+     * info:
+     * {key: "class", value: "GenericError"}
+     *
+     * For pins, it should follow "gpio%2[A-Z]%1d" or "gpio%3[18A-E]%1d" format.
+     */
+    const char error_msg[] = "GenericError";
+    const char error_msg_key[] = "class";
+
+    g_assert(qtest_qom_check_error(s, path, "gpioR+1", error_msg,
+                                   error_msg_key));
+    g_assert(qtest_qom_check_error(s, path, "gpio-set[99]", error_msg,
+                                   error_msg_key));
+    g_assert(qtest_qom_check_error(s, path, "gpio-set[-3]", error_msg,
+                                   error_msg_key));
 }
 
 static void test_set_input_pins(const void *data)
-- 
2.51.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497F606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSUwi-00005L-Sq; Sun, 15 Nov 2026 02:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwR-0008TZ-RU; Sun, 15 Nov 2026 02:46:23 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwN-0004oD-8J; Sun, 15 Nov 2026 02:46:23 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwDHz59HY_lqhpowBg--.2204S2;
 Sun, 15 Nov 2026 15:46:15 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwFnQ_Y_lqF+j6AA--.34770S5;
 Sun, 15 Nov 2026 15:46:14 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Chao Liu <chao.liu@processmission.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 2/5] tests/qtest: Add raw command response helper
Date: Sun, 15 Nov 2026 15:46:04 +0800
Message-Id: <20261115074607.456045-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
References: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwFnQ_Y_lqF+j6AA--.34770S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWr4tsgAcgAAsa
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAw4DCw4xGry8WF1fGF18Grg_yoW5Jw48pF
 WkA3ZYyr4rJFyxWr43JF1DXF1rWr4xJr4DX3yxAr98JFZrJ34qqrs2yF1jgrn5XaykXrW5
 Cw1qvF15GF1jvFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extract response parsing from qtest_rsp_args() into qtest_rsp_words().
Add qtest_raw_cmd() to send commands and return responses without
requiring an OK status, so callers can inspect ERR and FAIL responses.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.h | 13 +++++++++++++
 tests/qtest/libqtest.c | 27 +++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 20982d3fe8d..9c17da930e1 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -239,6 +239,19 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
 void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
     G_GNUC_PRINTF(2, 3);
 
+/**
+ * qtest_raw_cmd:
+ * @s: #QTestState instance to operate on.
+ * @fmt: raw qtest protocol text to send, formatted like sprintf().
+ *
+ * Sends a raw qtest command and returns the response split on spaces.
+ * The response is not required to start with ``OK``; callers can inspect
+ * ``args[0]`` for ``OK``, ``ERR``, or ``FAIL`` and must free the returned
+ * vector with g_strfreev().
+ */
+gchar **qtest_raw_cmd(QTestState *s, const char *fmt, ...)
+    G_GNUC_PRINTF(2, 3);
+
 /**
  * qtest_socket_server:
  * @socket_path: the UNIX domain socket path
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7f66c1bbb3b..3b2e31240e7 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -752,11 +752,10 @@ static GString *qtest_client_socket_recv_line(QTestState *s)
     return line;
 }
 
-static gchar **qtest_rsp_args(QTestState *s, int expected_args)
+static gchar **qtest_rsp_words(QTestState *s)
 {
     GString *line;
     gchar **words;
-    int i;
 
 redo:
     line = s->ops.recv_line(s);
@@ -788,6 +787,15 @@ redo:
     }
 
     g_assert(words[0] != NULL);
+
+    return words;
+}
+
+static gchar **qtest_rsp_args(QTestState *s, int expected_args)
+{
+    gchar **words = qtest_rsp_words(s);
+    int i;
+
     g_assert_cmpstr(words[0], ==, "OK");
 
     for (i = 0; i < expected_args; i++) {
@@ -797,6 +805,21 @@ redo:
     return words;
 }
 
+gchar **qtest_raw_cmd(QTestState *s, const char *fmt, ...)
+{
+    va_list ap;
+    gchar *str;
+
+    va_start(ap, fmt);
+    str = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    s->ops.send(s, str);
+    g_free(str);
+
+    return qtest_rsp_words(s);
+}
+
 static void qtest_rsp(QTestState *s)
 {
     gchar **words = qtest_rsp_args(s, 0);
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF5EC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuj2Q-0006EN-JC; Thu, 13 Aug 2026 23:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuj2P-0006E2-R0; Thu, 13 Aug 2026 23:56:57 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuj2O-0007t3-Dm; Thu, 13 Aug 2026 23:56:57 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwA3zVEGkn5qdod5Aw--.46816S2; 
 Fri, 14 Aug 2026 11:56:54 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwfXPskX5qW1IjAA--.62931S6;
 Fri, 14 Aug 2026 11:56:34 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 3/5] tests/qtest: Add raw command response helper
Date: Fri, 14 Aug 2026 11:56:26 +0800
Message-Id: <20260814035628.3924513-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814035628.3924513-1-tangtao1634@phytium.com.cn>
References: <20260814035628.3924513-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwfXPskX5qW1IjAA--.62931S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAHBWp+G0sCDAABsI
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kr4UZw1xZFW7Cw47Gw43Awb_yoW8Kw4kpF
 WkA3ZYyr4fJFyxWr43JF1DXF1rWr4fGr4DXrWxAr1DJFW7J3sFqrs2yF1jgrn5XaykWrW5
 Cw4qvF15GF1jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Split raw qtest response tokenization and qtest_raw_cmd() from the
memory attributes helpers so this protocol support can be reviewed
independently.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 tests/qtest/libqtest.c | 27 +++++++++++++++++++++++++--
 tests/qtest/libqtest.h | 13 +++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 453d0dddd09..37aa69e1297 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -746,11 +746,10 @@ static GString *qtest_client_socket_recv_line(QTestState *s)
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
@@ -780,6 +779,15 @@ redo:
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
@@ -789,6 +797,21 @@ redo:
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
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 7c0b239e5b5..715c363de30 100644
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
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CA3CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPor3-0007hd-SJ; Wed, 20 May 2026 17:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqP-0006tb-DY
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqL-0004tZ-8f
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12bX/10Ziyy/6kLw/JdKoHVNUOqJFvEDee/qU/5MXpg=;
 b=XV81I6J+1LGL9IfNaHiowyk4rRs8whedWq3LnzZQ8fQTnUva8k/KiRMrtGCrQno1Gf6OQf
 X/0WtaoYhnuzuZfvix91oOJbEsLAeMD4EfAJ4yvITn4uezup0c7QQ3t5B93OjZyDi/MTZW
 H0hwGRvz2+5Ay0N7sKnxzTpPyikh3Pg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-y7fh2K0VNqSIhQnZJBqE-w-1; Wed,
 20 May 2026 17:52:42 -0400
X-MC-Unique: y7fh2K0VNqSIhQnZJBqE-w-1
X-Mimecast-MFC-AGG-ID: y7fh2K0VNqSIhQnZJBqE-w_1779313962
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F30611956096
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:52:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A45B1956053; Wed, 20 May 2026 21:52:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:27 +0400
Subject: [PATCH 26/40] tests/qtest/netdev-socket: replace HMP with
 x-query-network QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-26-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12748;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TAdPYGTKLkf+slB8VP74dWLo4dpdLt/APwXIDAyeryg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDjyqoFsdI+cfzkI0zVGUI06UV9pRtwj46z
 /eft9c9tHKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5XV5EAC6sVeLJipt6BnbvSYWAqDdxhoOmw3S/l8rR22BiRjEvjiW2eaKUrI2fk8LP5fPFo09OLE
 83rLb+aHJknK/kbDrmzWUMn3jnRiPw7nSkdyEbrdy83KbIiKSHyIRjDoeR45WnmTfnId0AQ6fbF
 HY3T14Fjo98iQCNn1Gj6ImjsKzWAg55e68IwIZ5FrHmApz/FZByB1mEoaELpDWhB5rx2MFAbmLU
 8RVjxjYpi7693FmNegFIoirotBTN2m9tHILStG/qZejsMUjYwoOBF15OC35hP5mmbv+DQ8uQN95
 fAfMbqwwdzTyiNU7DQeZdbxXnzrkT+x17zMlJLUXY40tyXtYGf6Pmry0eexVFdjXqahV2jZxnyp
 H+ZrxQ+0skHEcRMzTh/tOcNUOIgCz0y2wL3bLMyNwLJ+EFR2Qc9BM4l/sSsA/kNFIzFqoCoQfyo
 59hfzUgmM/TH8dP8bigdP36ZQe588vy/ipSeK15ilDEqYaw3cOasRqVppKUxgzhN2nIPVkpCmdz
 AB62PVvUH4KKzkK6c3qMAvLLIdpVp5F9ISB9A0NW9Ws2MioKrCVvl0O5t+M/qG9eGJq1mEQ5JY0
 wpPalR0paq+cclI+pMw9NBUaXcd23wgOU56NaOJqSQE5NGvbmOCcPrU6FoyYEsh9cNgmvRuDXA7
 gTP3c4QhwOGe2GQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace the HMP "info network" text parsing with the structured
x-query-network QMP command. This makes the test assertions more robust
by matching individual fields (info-str) instead of parsing the full HMP
line format.

The EXPECT_STATE macro now takes an explicit netdev id argument to look
up the client by name in the QMP response. The strrchr truncation is
made NULL-safe: if the truncation character is not found, the full
string is compared (and the final g_assert_cmpstr will catch
mismatches).

While at it, fix the pre-existing duplicate "qemu/sockets.h" include,
and reorder includes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/netdev-socket.c | 143 +++++++++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 61 deletions(-)

diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index b731af0ad95..30005c2e001 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -7,33 +7,62 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/sockets.h"
 #include <glib/gstdio.h>
 #include "../unit/socket-helpers.h"
 #include "libqtest.h"
-#include "qobject/qstring.h"
-#include "qemu/sockets.h"
-#include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qemu/sockets.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 
 #define CONNECTION_TIMEOUT    60
 
-#define EXPECT_STATE(q, e, t)                             \
-do {                                                      \
-    char *resp = NULL;                                    \
-    g_test_timer_start();                                 \
-    do {                                                  \
-        g_free(resp);                                     \
-        resp = qtest_hmp(q, "info network");              \
-        if (t) {                                          \
-            strrchr(resp, t)[0] = 0;                      \
-        }                                                 \
-        if (g_str_equal(resp, e)) {                       \
-            break;                                        \
-        }                                                 \
-    } while (g_test_timer_elapsed() < CONNECTION_TIMEOUT); \
-    g_assert_cmpstr(resp, ==, e);                         \
-    g_free(resp);                                         \
+/*
+ * Only checks info-str; type is implicit from the netdev created by each test
+ */
+static char *query_net_info_str(QTestState *q, const char *name)
+{
+    QDict *ret;
+    QList *clients;
+    QListEntry *entry;
+
+    ret = qtest_qmp_assert_success_ref(q, "{'execute': 'x-query-network'}");
+    clients = qdict_get_qlist(ret, "clients");
+    g_assert_nonnull(clients);
+
+    QLIST_FOREACH_ENTRY(clients, entry) {
+        QDict *client = qobject_to(QDict, qlist_entry_obj(entry));
+        if (g_str_equal(qdict_get_str(client, "name"), name)) {
+            char *info = g_strdup(qdict_get_str(client, "info-str"));
+            qobject_unref(ret);
+            return info;
+        }
+    }
+
+    g_assert_not_reached();
+}
+
+#define EXPECT_STATE(q, id, e, t)                           \
+do {                                                        \
+    char *info = NULL;                                      \
+    g_test_timer_start();                                   \
+    do {                                                    \
+        g_free(info);                                       \
+        info = query_net_info_str(q, id);                   \
+        if (t) {                                            \
+            char *p = strrchr(info, t);                     \
+            if (p) {                                        \
+                p[0] = 0;                                   \
+            }                                               \
+        }                                                   \
+        if (g_str_equal(info, e)) {                         \
+            break;                                          \
+        }                                                   \
+    } while (g_test_timer_elapsed() < CONNECTION_TIMEOUT);  \
+    g_assert_cmpstr(info, ==, e);                           \
+    g_free(info);                                           \
 } while (0)
 
 static gchar *tmpdir;
@@ -127,20 +156,19 @@ static void test_stream_inet_ipv4(void)
                        "addr.ipv4=on,addr.ipv6=off,"
                        "addr.host=127.0.0.1,addr.port=%d", port);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
+    EXPECT_STATE(qts0, "st0", "listening", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,server=false,id=st0,addr.type=inet,"
                        "addr.ipv4=on,addr.ipv6=off,"
                        "addr.host=127.0.0.1,addr.port=%d", port);
 
-    expect = g_strdup_printf("st0: index=0,type=stream,tcp:127.0.0.1:%d\r\n",
-                             port);
-    EXPECT_STATE(qts1, expect, 0);
+    expect = g_strdup_printf("tcp:127.0.0.1:%d", port);
+    EXPECT_STATE(qts1, "st0", expect, 0);
     g_free(expect);
 
     /* the port is unknown, check only the address */
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,tcp:127.0.0.1", ':');
+    EXPECT_STATE(qts0, "st0", "tcp:127.0.0.1", ':');
 
     qtest_quit(qts1);
     qtest_quit(qts0);
@@ -200,7 +228,7 @@ static void test_stream_unix_reconnect(void)
                        "-netdev stream,id=st0,server=true,addr.type=unix,"
                        "addr.path=%s", path);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
+    EXPECT_STATE(qts0, "st0", "listening", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,server=false,id=st0,addr.type=unix,"
@@ -250,20 +278,19 @@ static void test_stream_inet_ipv6(void)
                        "addr.ipv4=off,addr.ipv6=on,"
                        "addr.host=::1,addr.port=%d", port);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
+    EXPECT_STATE(qts0, "st0", "listening", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,server=false,id=st0,addr.type=inet,"
                        "addr.ipv4=off,addr.ipv6=on,"
                        "addr.host=::1,addr.port=%d", port);
 
-    expect = g_strdup_printf("st0: index=0,type=stream,tcp:::1:%d\r\n",
-                             port);
-    EXPECT_STATE(qts1, expect, 0);
+    expect = g_strdup_printf("tcp:::1:%d", port);
+    EXPECT_STATE(qts1, "st0", expect, 0);
     g_free(expect);
 
     /* the port is unknown, check only the address */
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,tcp:::1", ':');
+    EXPECT_STATE(qts0, "st0", "tcp:::1", ':');
 
     qtest_quit(qts1);
     qtest_quit(qts0);
@@ -282,16 +309,16 @@ static void test_stream_unix(void)
                        "addr.type=unix,addr.path=%s,",
                        path);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
+    EXPECT_STATE(qts0, "st0", "listening", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,id=st0,server=false,"
                        "addr.type=unix,addr.path=%s",
                        path);
 
-    expect = g_strdup_printf("st0: index=0,type=stream,unix:%s\r\n", path);
-    EXPECT_STATE(qts1, expect, 0);
-    EXPECT_STATE(qts0, expect, 0);
+    expect = g_strdup_printf("unix:%s", path);
+    EXPECT_STATE(qts1, "st0", expect, 0);
+    EXPECT_STATE(qts0, "st0", expect, 0);
     g_free(expect);
     g_free(path);
 
@@ -314,16 +341,16 @@ static void test_stream_unix_abstract(void)
                        "addr.abstract=on",
                        path);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
+    EXPECT_STATE(qts0, "st0", "listening", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,id=st0,server=false,"
                        "addr.type=unix,addr.path=%s,addr.abstract=on",
                        path);
 
-    expect = g_strdup_printf("st0: index=0,type=stream,unix:%s\r\n", path);
-    EXPECT_STATE(qts1, expect, 0);
-    EXPECT_STATE(qts0, expect, 0);
+    expect = g_strdup_printf("unix:%s", path);
+    EXPECT_STATE(qts1, "st0", expect, 0);
+    EXPECT_STATE(qts0, "st0", expect, 0);
     g_free(expect);
     g_free(path);
 
@@ -346,14 +373,14 @@ static void test_stream_fd(void)
                        "-netdev stream,id=st0,addr.type=fd,addr.str=%d",
                        sock[0]);
 
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,unix:\r\n", 0);
+    EXPECT_STATE(qts0, "st0", "unix:", 0);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,id=st0,addr.type=fd,addr.str=%d",
                        sock[1]);
 
-    EXPECT_STATE(qts1, "st0: index=0,type=stream,unix:\r\n", 0);
-    EXPECT_STATE(qts0, "st0: index=0,type=stream,unix:\r\n", 0);
+    EXPECT_STATE(qts1, "st0", "unix:", 0);
+    EXPECT_STATE(qts0, "st0", "unix:", 0);
 
     qtest_quit(qts1);
     qtest_quit(qts0);
@@ -379,10 +406,9 @@ static void test_dgram_inet(void)
                        "remote.type=inet,remote.host=127.0.0.1,remote.port=%d",
                         port[0], port[1]);
 
-    expect = g_strdup_printf("st0: index=0,type=dgram,"
-                             "udp=127.0.0.1:%d/127.0.0.1:%d\r\n",
+    expect = g_strdup_printf("udp=127.0.0.1:%d/127.0.0.1:%d",
                              port[0], port[1]);
-    EXPECT_STATE(qts0, expect, 0);
+    EXPECT_STATE(qts0, "st0", expect, 0);
     g_free(expect);
 
     qts1 = qtest_initf("-nodefaults -M none "
@@ -391,10 +417,9 @@ static void test_dgram_inet(void)
                        "remote.type=inet,remote.host=127.0.0.1,remote.port=%d",
                         port[1], port[0]);
 
-    expect = g_strdup_printf("st0: index=0,type=dgram,"
-                             "udp=127.0.0.1:%d/127.0.0.1:%d\r\n",
+    expect = g_strdup_printf("udp=127.0.0.1:%d/127.0.0.1:%d",
                              port[1], port[0]);
-    EXPECT_STATE(qts1, expect, 0);
+    EXPECT_STATE(qts1, "st0", expect, 0);
     g_free(expect);
 
     qtest_quit(qts1);
@@ -410,7 +435,7 @@ static void test_dgram_mcast(void)
                       "-netdev dgram,id=st0,"
                       "remote.type=inet,remote.host=230.0.0.1,remote.port=1234");
 
-    EXPECT_STATE(qts, "st0: index=0,type=dgram,mcast=230.0.0.1:1234\r\n", 0);
+    EXPECT_STATE(qts, "st0", "mcast=230.0.0.1:1234", 0);
 
     qtest_quit(qts);
 }
@@ -431,9 +456,8 @@ static void test_dgram_unix(void)
                        "remote.type=unix,remote.path=%s",
                        path0, path1);
 
-    expect = g_strdup_printf("st0: index=0,type=dgram,udp=%s:%s\r\n",
-                             path0, path1);
-    EXPECT_STATE(qts0, expect, 0);
+    expect = g_strdup_printf("udp=%s:%s", path0, path1);
+    EXPECT_STATE(qts0, "st0", expect, 0);
     g_free(expect);
 
     qts1 = qtest_initf("-nodefaults -M none "
@@ -441,10 +465,8 @@ static void test_dgram_unix(void)
                        "remote.type=unix,remote.path=%s",
                        path1, path0);
 
-
-    expect = g_strdup_printf("st0: index=0,type=dgram,udp=%s:%s\r\n",
-                             path1, path0);
-    EXPECT_STATE(qts1, expect, 0);
+    expect = g_strdup_printf("udp=%s:%s", path1, path0);
+    EXPECT_STATE(qts1, "st0", expect, 0);
     g_free(expect);
 
     unlink(path0);
@@ -470,17 +492,16 @@ static void test_dgram_fd(void)
                        "-netdev dgram,id=st0,local.type=fd,local.str=%d",
                        sv[0]);
 
-    expect = g_strdup_printf("st0: index=0,type=dgram,fd=%d unix\r\n", sv[0]);
-    EXPECT_STATE(qts0, expect, 0);
+    expect = g_strdup_printf("fd=%d unix", sv[0]);
+    EXPECT_STATE(qts0, "st0", expect, 0);
     g_free(expect);
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev dgram,id=st0,local.type=fd,local.str=%d",
                        sv[1]);
 
-
-    expect = g_strdup_printf("st0: index=0,type=dgram,fd=%d unix\r\n", sv[1]);
-    EXPECT_STATE(qts1, expect, 0);
+    expect = g_strdup_printf("fd=%d unix", sv[1]);
+    EXPECT_STATE(qts1, "st0", expect, 0);
     g_free(expect);
 
     qtest_quit(qts1);

-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C227C54754
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxRu-0008TQ-I7; Fri, 16 May 2025 11:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRt-0008T5-8u
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRr-0002eN-Lv
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747411091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6WuEoBBxDetQlDtLp0lnM1Dtbhxi8WuhpnDOYhag6M=;
 b=hziFCar5lWjSdjE9poW1zjVii4/3+8jHIkkgqD0rV+PoVziOAKL2iMG/0vyPa+/bmTwWKO
 rwyM40hrBB11YIWadlEiBll7BxeVANwq5Y2dVOZ3DviLWJPd6HIirrroVSAV07VbSJabyI
 /vrhcB54akVTfFF4aynP66jP7vY0iNE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-2n8xUhnuOqeoFGeSlqQqrw-1; Fri,
 16 May 2025 11:58:00 -0400
X-MC-Unique: 2n8xUhnuOqeoFGeSlqQqrw-1
X-Mimecast-MFC-AGG-ID: 2n8xUhnuOqeoFGeSlqQqrw_1747411079
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6FFC18004AD; Fri, 16 May 2025 15:57:59 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1FB818003FC; Fri, 16 May 2025 15:57:57 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 5/7] tests/unit/test-util-sockets: Add tests for
 inet_parse()
Date: Fri, 16 May 2025 17:56:57 +0200
Message-ID: <20250516155710.2246148-6-jmarcin@redhat.com>
In-Reply-To: <20250516155710.2246148-1-jmarcin@redhat.com>
References: <20250516155710.2246148-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

Before refactoring the inet_parse() function, this patch adds tests
verifying the inet address parsing works correctly.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 tests/unit/test-util-sockets.c | 161 +++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 4c9dd0b271..60f15a4ddf 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -332,6 +332,144 @@ static void test_socket_unix_abstract(void)
 
 #endif  /* CONFIG_LINUX */
 
+static void inet_parse_test_helper(const char *str, InetSocketAddress *exp_addr, bool success)
+{
+    InetSocketAddress addr;
+    Error *error = NULL;
+
+    int rc = inet_parse(&addr, str, &error);
+
+    if (success) {
+        g_assert_cmpint(rc, ==, 0);
+    } else {
+        g_assert_cmpint(rc, <, 0);
+    }
+    if (exp_addr != NULL) {
+        g_assert_cmpstr(addr.host, ==, exp_addr->host);
+        g_assert_cmpstr(addr.port, ==, exp_addr->port);
+        /* Own members: */
+        g_assert_cmpint(addr.has_numeric, ==, exp_addr->has_numeric);
+        g_assert_cmpint(addr.numeric, ==, exp_addr->numeric);
+        g_assert_cmpint(addr.has_to, ==, exp_addr->has_to);
+        g_assert_cmpint(addr.to, ==, exp_addr->to);
+        g_assert_cmpint(addr.has_ipv4, ==, exp_addr->has_ipv4);
+        g_assert_cmpint(addr.ipv4, ==, exp_addr->ipv4);
+        g_assert_cmpint(addr.has_ipv6, ==, exp_addr->has_ipv6);
+        g_assert_cmpint(addr.ipv6, ==, exp_addr->ipv6);
+        g_assert_cmpint(addr.has_keep_alive, ==, exp_addr->has_keep_alive);
+        g_assert_cmpint(addr.keep_alive, ==, exp_addr->keep_alive);
+#ifdef HAVE_IPPROTO_MPTCP
+        g_assert_cmpint(addr.has_mptcp, ==, exp_addr->has_mptcp);
+        g_assert_cmpint(addr.mptcp, ==, exp_addr->mptcp);
+#endif
+    }
+
+    g_free(addr.host);
+    g_free(addr.port);
+}
+
+static void test_inet_parse_nohost_good(void)
+{
+    char host[] = "";
+    char port[] = "5000";
+    InetSocketAddress exp_addr = {
+        .host = host,
+        .port = port,
+    };
+    inet_parse_test_helper(":5000", &exp_addr, true);
+}
+
+static void test_inet_parse_empty_bad(void)
+{
+    inet_parse_test_helper("", NULL, false);
+}
+
+static void test_inet_parse_only_colon_bad(void)
+{
+    inet_parse_test_helper(":", NULL, false);
+}
+
+static void test_inet_parse_ipv4_good(void)
+{
+    char host[] = "127.0.0.1";
+    char port[] = "5000";
+    InetSocketAddress exp_addr = {
+        .host = host,
+        .port = port,
+    };
+    inet_parse_test_helper("127.0.0.1:5000", &exp_addr, true);
+}
+
+static void test_inet_parse_ipv4_noport_bad(void)
+{
+    inet_parse_test_helper("127.0.0.1", NULL, false);
+}
+
+static void test_inet_parse_ipv6_good(void)
+{
+    char host[] = "::1";
+    char port[] = "5000";
+    InetSocketAddress exp_addr = {
+        .host = host,
+        .port = port,
+    };
+    inet_parse_test_helper("[::1]:5000", &exp_addr, true);
+}
+
+static void test_inet_parse_ipv6_noend_bad(void)
+{
+    inet_parse_test_helper("[::1", NULL, false);
+}
+
+static void test_inet_parse_ipv6_noport_bad(void)
+{
+    inet_parse_test_helper("[::1]:", NULL, false);
+}
+
+static void test_inet_parse_ipv6_empty_bad(void)
+{
+    inet_parse_test_helper("[]:5000", NULL, false);
+}
+
+static void test_inet_parse_hostname_good(void)
+{
+    char host[] = "localhost";
+    char port[] = "5000";
+    InetSocketAddress exp_addr = {
+        .host = host,
+        .port = port,
+    };
+    inet_parse_test_helper("localhost:5000", &exp_addr, true);
+}
+
+static void test_inet_parse_all_options_good(void)
+{
+    char host[] = "::1";
+    char port[] = "5000";
+    InetSocketAddress exp_addr = {
+        .host = host,
+        .port = port,
+        .has_to = true,
+        .to = 5006,
+        .has_ipv4 = true,
+        .ipv4 = false,
+        .has_ipv6 = true,
+        .ipv6 = true,
+        .has_keep_alive = true,
+        .keep_alive = true,
+#ifdef HAVE_IPPROTO_MPTCP
+        .has_mptcp = true,
+        .mptcp = true,
+#endif
+    };
+    inet_parse_test_helper(
+        "[::1]:5000,to=5006,ipv4=off,ipv6=on,keep-alive"
+#ifdef HAVE_IPPROTO_MPTCP
+        ",mptcp"
+#endif
+        , &exp_addr, true);
+}
+
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
@@ -377,6 +515,29 @@ int main(int argc, char **argv)
                     test_socket_unix_abstract);
 #endif
 
+    g_test_add_func("/util/socket/inet-parse/nohost-good",
+                    test_inet_parse_nohost_good);
+    g_test_add_func("/util/socket/inet-parse/empty-bad",
+                    test_inet_parse_empty_bad);
+    g_test_add_func("/util/socket/inet-parse/only-colon-bad",
+                    test_inet_parse_only_colon_bad);
+    g_test_add_func("/util/socket/inet-parse/ipv4-good",
+                    test_inet_parse_ipv4_good);
+    g_test_add_func("/util/socket/inet-parse/ipv4-noport-bad",
+                    test_inet_parse_ipv4_noport_bad);
+    g_test_add_func("/util/socket/inet-parse/ipv6-good",
+                    test_inet_parse_ipv6_good);
+    g_test_add_func("/util/socket/inet-parse/ipv6-noend-bad",
+                    test_inet_parse_ipv6_noend_bad);
+    g_test_add_func("/util/socket/inet-parse/ipv6-noport-bad",
+                    test_inet_parse_ipv6_noport_bad);
+    g_test_add_func("/util/socket/inet-parse/ipv6-empty-bad",
+                    test_inet_parse_ipv6_empty_bad);
+    g_test_add_func("/util/socket/inet-parse/hostname-good",
+                    test_inet_parse_hostname_good);
+    g_test_add_func("/util/socket/inet-parse/all-options-good",
+                    test_inet_parse_all_options_good);
+
 end:
     return g_test_run();
 }
-- 
2.49.0



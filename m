Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B722C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjv6-0000Hf-12; Wed, 21 May 2025 09:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uHjv3-0000EE-BW
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uHjv0-000767-2G
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747835737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcDve3oQvRJolk/sF06L0Z5HFPQUmLIPk/w0wJEutfU=;
 b=ASMknDuZKd/LnRfsb9RI6wY8ExZmMi3X+kiSBGO/hySF1H3iJUbz7O1LthNJZeITDVx2lZ
 Vb1qCKce3bv4qvhqJtyg8RZc8v3a3TUPnAm3iG4fEv/ooqzP+waL/b3dt1Ojw7kdsq7Ufk
 2yjL7dbHEhmxvasMwqGdUY8lQSAJZtI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259--_wsRSRJO-ibg3EK8rQzqA-1; Wed,
 21 May 2025 09:55:26 -0400
X-MC-Unique: -_wsRSRJO-ibg3EK8rQzqA-1
X-Mimecast-MFC-AGG-ID: -_wsRSRJO-ibg3EK8rQzqA_1747835726
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B85D1180036D; Wed, 21 May 2025 13:55:25 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2CC819560AB; Wed, 21 May 2025 13:55:23 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 5/6] util/qemu-sockets: Refactor inet_parse() to use
 QemuOpts
Date: Wed, 21 May 2025 15:52:34 +0200
Message-ID: <20250521135240.3941598-6-jmarcin@redhat.com>
In-Reply-To: <20250521135240.3941598-1-jmarcin@redhat.com>
References: <20250521135240.3941598-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

Currently, the inet address parser cannot handle multiple options where
one is prefixed with the name of the other. For example, with the
'keep-alive-idle' option added, the current parser cannot parse
'127.0.0.1:5000,keep-alive-idle=60,keep-alive' correctly. Instead, it
fails with "error parsing 'keep-alive' flag '-idle=60,keep-alive'".

To resolve these issues, this patch rewrites the inet address parsing
using the QemuOpts parser, which the inet_parse_flag() function tries to
mimic. This new parser supports all previously supported options and on
top of that the 'numeric' flag is now also supported. The only
difference is, the new parser produces an error if an unknown option is
passed, instead of silently ignoring it.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-util-sockets.c | 195 +++++++++++++++++++++++++++++++++
 util/qemu-sockets.c            | 158 +++++++++++++-------------
 2 files changed, 269 insertions(+), 84 deletions(-)

diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 4c9dd0b271..cca609fd90 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -332,6 +332,176 @@ static void test_socket_unix_abstract(void)
 
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
+        .has_numeric = true,
+        .numeric =  true,
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
+        .mptcp = false,
+#endif
+    };
+    inet_parse_test_helper(
+        "[::1]:5000,numeric=on,to=5006,ipv4=off,ipv6=on,keep-alive=on"
+#ifdef HAVE_IPPROTO_MPTCP
+        ",mptcp=off"
+#endif
+        , &exp_addr, true);
+}
+
+static void test_inet_parse_all_implicit_bool_good(void)
+{
+    char host[] = "::1";
+    char port[] = "5000";
+    InetSocketAddress exp_addr = {
+        .host = host,
+        .port = port,
+        .has_numeric = true,
+        .numeric =  true,
+        .has_to = true,
+        .to = 5006,
+        .has_ipv4 = true,
+        .ipv4 = true,
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
+        "[::1]:5000,numeric,to=5006,ipv4,ipv6,keep-alive"
+#ifdef HAVE_IPPROTO_MPTCP
+        ",mptcp"
+#endif
+        , &exp_addr, true);
+}
+
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
@@ -377,6 +547,31 @@ int main(int argc, char **argv)
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
+    g_test_add_func("/util/socket/inet-parse/all-bare-bool-good",
+                    test_inet_parse_all_implicit_bool_good);
+
 end:
     return g_test_run();
 }
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4fbf1ed5bf..403dc26b36 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -30,6 +30,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/cutils.h"
+#include "qemu/option.h"
 #include "trace.h"
 
 #ifndef AI_ADDRCONFIG
@@ -600,115 +601,104 @@ err:
     return -1;
 }
 
-/* compatibility wrapper */
-static int inet_parse_flag(const char *flagname, const char *optstr, bool *val,
-                           Error **errp)
-{
-    char *end;
-    size_t len;
-
-    end = strstr(optstr, ",");
-    if (end) {
-        if (end[1] == ',') { /* Reject 'ipv6=on,,foo' */
-            error_setg(errp, "error parsing '%s' flag '%s'", flagname, optstr);
-            return -1;
-        }
-        len = end - optstr;
-    } else {
-        len = strlen(optstr);
-    }
-    if (len == 0 || (len == 3 && strncmp(optstr, "=on", len) == 0)) {
-        *val = true;
-    } else if (len == 4 && strncmp(optstr, "=off", len) == 0) {
-        *val = false;
-    } else {
-        error_setg(errp, "error parsing '%s' flag '%s'", flagname, optstr);
-        return -1;
-    }
-    return 0;
-}
+static QemuOptsList inet_opts = {
+    .name = "InetSocketAddress",
+    .head = QTAILQ_HEAD_INITIALIZER(inet_opts.head),
+    .implied_opt_name = "addr",
+    .desc = {
+        {
+            .name = "addr",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "numeric",
+            .type = QEMU_OPT_BOOL,
+        },
+        {
+            .name = "to",
+            .type = QEMU_OPT_NUMBER,
+        },
+        {
+            .name = "ipv4",
+            .type = QEMU_OPT_BOOL,
+        },
+        {
+            .name = "ipv6",
+            .type = QEMU_OPT_BOOL,
+        },
+        {
+            .name = "keep-alive",
+            .type = QEMU_OPT_BOOL,
+        },
+#ifdef HAVE_IPPROTO_MPTCP
+        {
+            .name = "mptcp",
+            .type = QEMU_OPT_BOOL,
+        },
+#endif
+        { /* end of list */ }
+    },
+};
 
 int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
 {
-    const char *optstr, *h;
-    char host[65];
-    char port[33];
-    int to;
-    int pos;
-    char *begin;
-
+    QemuOpts *opts = qemu_opts_parse(&inet_opts, str, true, errp);
+    if (!opts) {
+        return -1;
+    }
     memset(addr, 0, sizeof(*addr));
 
     /* parse address */
-    if (str[0] == ':') {
-        /* no host given */
-        host[0] = '\0';
-        if (sscanf(str, ":%32[^,]%n", port, &pos) != 1) {
-            error_setg(errp, "error parsing port in address '%s'", str);
-            return -1;
-        }
-    } else if (str[0] == '[') {
+    const char *addr_str = qemu_opt_get(opts, "addr");
+    if (!addr_str) {
+        error_setg(errp, "error parsing address ''");
+        return -1;
+    }
+    if (str[0] == '[') {
         /* IPv6 addr */
-        if (sscanf(str, "[%64[^]]]:%32[^,]%n", host, port, &pos) != 2) {
-            error_setg(errp, "error parsing IPv6 address '%s'", str);
+        const char *ip_end = strstr(addr_str, "]:");
+        if (!ip_end || ip_end - addr_str < 2 || strlen(ip_end) < 3) {
+            error_setg(errp, "error parsing IPv6 address '%s'", addr_str);
             return -1;
         }
+        addr->host = g_strndup(addr_str + 1, ip_end - addr_str - 1);
+        addr->port = g_strdup(ip_end + 2);
     } else {
-        /* hostname or IPv4 addr */
-        if (sscanf(str, "%64[^:]:%32[^,]%n", host, port, &pos) != 2) {
-            error_setg(errp, "error parsing address '%s'", str);
+        /* no host, hostname or IPv4 addr */
+        const char *port = strchr(addr_str, ':');
+        if (!port || strlen(port) < 2) {
+            error_setg(errp, "error parsing address '%s'", addr_str);
             return -1;
         }
+        addr->host = g_strndup(addr_str, port - addr_str);
+        addr->port = g_strdup(port + 1);
     }
 
-    addr->host = g_strdup(host);
-    addr->port = g_strdup(port);
-
     /* parse options */
-    optstr = str + pos;
-    h = strstr(optstr, ",to=");
-    if (h) {
-        h += 4;
-        if (sscanf(h, "%d%n", &to, &pos) != 1 ||
-            (h[pos] != '\0' && h[pos] != ',')) {
-            error_setg(errp, "error parsing to= argument");
-            return -1;
-        }
+    if (qemu_opt_find(opts, "numeric")) {
+        addr->has_numeric = true,
+        addr->numeric = qemu_opt_get_bool(opts, "numeric", false);
+    }
+    if (qemu_opt_find(opts, "to")) {
         addr->has_to = true;
-        addr->to = to;
+        addr->to = qemu_opt_get_number(opts, "to", 0);
     }
-    begin = strstr(optstr, ",ipv4");
-    if (begin) {
-        if (inet_parse_flag("ipv4", begin + 5, &addr->ipv4, errp) < 0) {
-            return -1;
-        }
+    if (qemu_opt_find(opts, "ipv4")) {
         addr->has_ipv4 = true;
+        addr->ipv4 = qemu_opt_get_bool(opts, "ipv4", false);
     }
-    begin = strstr(optstr, ",ipv6");
-    if (begin) {
-        if (inet_parse_flag("ipv6", begin + 5, &addr->ipv6, errp) < 0) {
-            return -1;
-        }
+    if (qemu_opt_find(opts, "ipv6")) {
         addr->has_ipv6 = true;
+        addr->ipv6 = qemu_opt_get_bool(opts, "ipv6", false);
     }
-    begin = strstr(optstr, ",keep-alive");
-    if (begin) {
-        if (inet_parse_flag("keep-alive", begin + strlen(",keep-alive"),
-                            &addr->keep_alive, errp) < 0)
-        {
-            return -1;
-        }
+    if (qemu_opt_find(opts, "keep-alive")) {
         addr->has_keep_alive = true;
+        addr->keep_alive = qemu_opt_get_bool(opts, "keep-alive", false);
     }
 #ifdef HAVE_IPPROTO_MPTCP
-    begin = strstr(optstr, ",mptcp");
-    if (begin) {
-        if (inet_parse_flag("mptcp", begin + strlen(",mptcp"),
-                            &addr->mptcp, errp) < 0)
-        {
-            return -1;
-        }
+    if (qemu_opt_find(opts, "mptcp")) {
         addr->has_mptcp = true;
+        addr->mptcp = qemu_opt_get_bool(opts, "mptcp", 0);
     }
 #endif
     return 0;
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42ADC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxRt-0008TK-EJ; Fri, 16 May 2025 11:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRr-0008Sr-Tl
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRq-0002eJ-21
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747411089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63fxX36W1DeMEqkQnncf19Px4ERiPQlpA84N7Wfc39A=;
 b=FGG+saCEhSc3GUnSk5q4PeA9FXTN0UIEXwsDQxL/CBYa+P7/X9NzeED7ymljRcsAhfKFbm
 SqeTLZa5oz6N1SLJOKNtq72+vCebq9Gsg8UqdYpbWDkk/teaM/ZGGBlTRhI7ptZPxytFgD
 igftn67rkYWbY+I0KSz77Ug8HE7kwBA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-zGmYJnFHP8ygtXyzssrZtw-1; Fri,
 16 May 2025 11:58:08 -0400
X-MC-Unique: zGmYJnFHP8ygtXyzssrZtw-1
X-Mimecast-MFC-AGG-ID: zGmYJnFHP8ygtXyzssrZtw_1747411087
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 367B71800EC8; Fri, 16 May 2025 15:58:07 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A68218003FC; Fri, 16 May 2025 15:58:05 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 6/7] util/qemu-sockets: Refactor inet_parse() to use
 QemuOpts
Date: Fri, 16 May 2025 17:56:58 +0200
Message-ID: <20250516155710.2246148-7-jmarcin@redhat.com>
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
---
 tests/unit/test-util-sockets.c |   4 +-
 util/qemu-sockets.c            | 158 +++++++++++++++------------------
 2 files changed, 77 insertions(+), 85 deletions(-)

diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 60f15a4ddf..77d0767b9b 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -449,6 +449,8 @@ static void test_inet_parse_all_options_good(void)
     InetSocketAddress exp_addr = {
         .host = host,
         .port = port,
+        .has_numeric = true,
+        .numeric =  true,
         .has_to = true,
         .to = 5006,
         .has_ipv4 = true,
@@ -463,7 +465,7 @@ static void test_inet_parse_all_options_good(void)
 #endif
     };
     inet_parse_test_helper(
-        "[::1]:5000,to=5006,ipv4=off,ipv6=on,keep-alive"
+        "[::1]:5000,numeric,to=5006,ipv4=off,ipv6=on,keep-alive"
 #ifdef HAVE_IPPROTO_MPTCP
         ",mptcp"
 #endif
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



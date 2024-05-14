Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E4FC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rdL-0005Eu-FH; Tue, 14 May 2024 08:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rdJ-0005EJ-4P
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rdG-0005Fv-Cd
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715691109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCQfuj2vSD4sNRjVMsOcltspQz6+MjT5QyzED//iZkQ=;
 b=BsKb1kW67n7aDrv/YzHX2JWZ0TWwYq88Fmwk0m1cs8ixd1NsZ9xsAd/rqEwO8U/cxihA4J
 00vZ8TGOoA+ZXej+5agJw2kl9pjUz6RqETRtHMRYjZt5caTzMgFYI/MBR8arq9NiXOanbH
 a4jftOsbKOem+yMeBU/cpS9HBYgJTuM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-0jt_2_sWPuCBquGBVY_KSQ-1; Tue,
 14 May 2024 08:51:31 -0400
X-MC-Unique: 0jt_2_sWPuCBquGBVY_KSQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5060929AA397;
 Tue, 14 May 2024 12:51:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69A45400EBE;
 Tue, 14 May 2024 12:51:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/11] block/nbd: Use URI parsing code from glib
Date: Tue, 14 May 2024 14:51:16 +0200
Message-ID: <20240514125119.284638-9-thuth@redhat.com>
In-Reply-To: <20240514125119.284638-1-thuth@redhat.com>
References: <20240514125119.284638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since version 2.66, glib has useful URI parsing functions, too.
Use those instead of the QEMU-internal ones to be finally able
to get rid of the latter. The g_uri_get_host() also takes care
of removing the square brackets from IPv6 addresses, so we can
drop that part of the QEMU code now, too.

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240418101056.302103-11-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/nbd.c | 76 ++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index ef05f7cdfd..589d28af83 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -31,7 +31,6 @@
 #include "qemu/osdep.h"
 
 #include "trace.h"
-#include "qemu/uri.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
@@ -1514,30 +1513,31 @@ static void nbd_client_close(BlockDriverState *bs)
 
 static int nbd_parse_uri(const char *filename, QDict *options)
 {
-    URI *uri;
+    g_autoptr(GUri) uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
+    g_autoptr(GHashTable) qp = NULL;
     const char *p;
-    QueryParams *qp = NULL;
-    int ret = 0;
+    int qp_n;
     bool is_unix;
+    const char *uri_scheme, *uri_query, *uri_server;
+    int uri_port;
 
-    uri = uri_parse(filename);
     if (!uri) {
         return -EINVAL;
     }
 
     /* transport */
-    if (!g_strcmp0(uri->scheme, "nbd")) {
+    uri_scheme = g_uri_get_scheme(uri);
+    if (!g_strcmp0(uri_scheme, "nbd")) {
         is_unix = false;
-    } else if (!g_strcmp0(uri->scheme, "nbd+tcp")) {
+    } else if (!g_strcmp0(uri_scheme, "nbd+tcp")) {
         is_unix = false;
-    } else if (!g_strcmp0(uri->scheme, "nbd+unix")) {
+    } else if (!g_strcmp0(uri_scheme, "nbd+unix")) {
         is_unix = true;
     } else {
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
-    p = uri->path ? uri->path : "";
+    p = g_uri_get_path(uri) ?: "";
     if (p[0] == '/') {
         p++;
     }
@@ -1545,52 +1545,50 @@ static int nbd_parse_uri(const char *filename, QDict *options)
         qdict_put_str(options, "export", p);
     }
 
-    qp = query_params_parse(uri->query);
-    if (qp->n > 1 || (is_unix && !qp->n) || (!is_unix && qp->n)) {
-        ret = -EINVAL;
-        goto out;
+    uri_query = g_uri_get_query(uri);
+    if (uri_query) {
+        qp = g_uri_parse_params(uri_query, -1, "&", G_URI_PARAMS_NONE, NULL);
+        if (!qp) {
+            return -EINVAL;
+        }
+        qp_n = g_hash_table_size(qp);
+        if (qp_n > 1 || (is_unix && !qp_n) || (!is_unix && qp_n)) {
+            return -EINVAL;
+        }
+     }
+
+    uri_server = g_uri_get_host(uri);
+    if (uri_server && !uri_server[0]) {
+        uri_server = NULL;
     }
+    uri_port = g_uri_get_port(uri);
 
     if (is_unix) {
         /* nbd+unix:///export?socket=path */
-        if (uri->server || uri->port || strcmp(qp->p[0].name, "socket")) {
-            ret = -EINVAL;
-            goto out;
+        const char *uri_socket = g_hash_table_lookup(qp, "socket");
+        if (uri_server || uri_port != -1 || !uri_socket) {
+            return -EINVAL;
         }
         qdict_put_str(options, "server.type", "unix");
-        qdict_put_str(options, "server.path", qp->p[0].value);
+        qdict_put_str(options, "server.path", uri_socket);
     } else {
-        QString *host;
         char *port_str;
 
         /* nbd[+tcp]://host[:port]/export */
-        if (!uri->server) {
-            ret = -EINVAL;
-            goto out;
-        }
-
-        /* strip braces from literal IPv6 address */
-        if (uri->server[0] == '[') {
-            host = qstring_from_substr(uri->server, 1,
-                                       strlen(uri->server) - 1);
-        } else {
-            host = qstring_from_str(uri->server);
+        if (!uri_server) {
+            return -EINVAL;
         }
 
         qdict_put_str(options, "server.type", "inet");
-        qdict_put(options, "server.host", host);
+        qdict_put_str(options, "server.host", uri_server);
 
-        port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
+        port_str = g_strdup_printf("%d", uri_port > 0 ? uri_port
+                                                      : NBD_DEFAULT_PORT);
         qdict_put_str(options, "server.port", port_str);
         g_free(port_str);
     }
 
-out:
-    if (qp) {
-        query_params_free(qp);
-    }
-    uri_free(uri);
-    return ret;
+    return 0;
 }
 
 static bool nbd_has_filename_options_conflict(QDict *options, Error **errp)
-- 
2.45.0



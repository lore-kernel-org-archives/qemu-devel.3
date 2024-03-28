Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B803C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqPE-0004Ns-V6; Thu, 28 Mar 2024 10:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpqPC-0004JB-TQ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rpqPB-0004RT-5V
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711634816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yB8tI5IT+BaEhv+XsYrzMuoYNTEs+U+d75tB8UncSU=;
 b=jWh4tiED9ylYLdt8B8c0ZwuV2MUr2uBE59/t39QPKAc5UUPG9MK10fQBELqXr+MAFKI/tL
 3EAKYz+Nyhof9N8Z9uAKhpSdEhsuAPp/iBHOY1KykcKqCZZ5+274czy44bQ2mSNk9fPeVg
 Rc/9M+BdniYxHy92JUhy8LxQF/ul8RU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-zmAJMaL7MaK_LMoOc3p-dw-1; Thu,
 28 Mar 2024 10:06:51 -0400
X-MC-Unique: zmAJMaL7MaK_LMoOc3p-dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E98B31C54074;
 Thu, 28 Mar 2024 14:06:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA59240C6CB5;
 Thu, 28 Mar 2024 14:06:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH for-9.1 5/9] block/gluster: Use URI parsing code from glib
Date: Thu, 28 Mar 2024 15:06:02 +0100
Message-ID: <20240328140607.2433889-6-thuth@redhat.com>
In-Reply-To: <20240328140607.2433889-1-thuth@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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
to get rid of the latter.

Cc: integration@gluster.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/gluster.c | 63 +++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index cc74af06dc..f4cb95360e 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -17,7 +17,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qemu/uri.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -289,9 +288,9 @@ static void glfs_clear_preopened(glfs_t *fs)
     }
 }
 
-static int parse_volume_options(BlockdevOptionsGluster *gconf, char *path)
+static int parse_volume_options(BlockdevOptionsGluster *gconf, const char *path)
 {
-    char *p, *q;
+    const char *p, *q;
 
     if (!path) {
         return -EINVAL;
@@ -350,12 +349,15 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
                                   const char *filename)
 {
     SocketAddress *gsconf;
-    URI *uri;
-    QueryParams *qp = NULL;
+    GUri *uri;
+    GHashTable *qp = NULL;
+    int qp_n;
     bool is_unix = false;
     int ret = 0;
+    const char *uri_scheme, *uri_query, *uri_server;
+    int uri_port;
 
-    uri = uri_parse(filename);
+    uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
     if (!uri) {
         return -EINVAL;
     }
@@ -364,14 +366,15 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
     QAPI_LIST_PREPEND(gconf->server, gsconf);
 
     /* transport */
-    if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
+    uri_scheme = g_uri_get_scheme(uri);
+    if (!uri_scheme || !strcmp(uri_scheme, "gluster")) {
         gsconf->type = SOCKET_ADDRESS_TYPE_INET;
-    } else if (!strcmp(uri->scheme, "gluster+tcp")) {
+    } else if (!strcmp(uri_scheme, "gluster+tcp")) {
         gsconf->type = SOCKET_ADDRESS_TYPE_INET;
-    } else if (!strcmp(uri->scheme, "gluster+unix")) {
+    } else if (!strcmp(uri_scheme, "gluster+unix")) {
         gsconf->type = SOCKET_ADDRESS_TYPE_UNIX;
         is_unix = true;
-    } else if (!strcmp(uri->scheme, "gluster+rdma")) {
+    } else if (!strcmp(uri_scheme, "gluster+rdma")) {
         gsconf->type = SOCKET_ADDRESS_TYPE_INET;
         warn_report("rdma feature is not supported, falling back to tcp");
     } else {
@@ -379,31 +382,39 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
         goto out;
     }
 
-    ret = parse_volume_options(gconf, uri->path);
+    ret = parse_volume_options(gconf, g_uri_get_path(uri));
     if (ret < 0) {
         goto out;
     }
 
-    qp = query_params_parse(uri->query);
-    if (qp->n > 1 || (is_unix && !qp->n) || (!is_unix && qp->n)) {
-        ret = -EINVAL;
-        goto out;
-    }
-
-    if (is_unix) {
-        if (uri->server || uri->port) {
+    uri_query = g_uri_get_query(uri);
+    if (uri_query) {
+        qp = g_uri_parse_params(uri_query, -1, "&", G_URI_PARAMS_NONE, NULL);
+        if (!qp) {
+            ret = -EINVAL;
+            goto out;
+        }
+        qp_n = g_hash_table_size(qp);
+        if (qp_n > 1 || (is_unix && !qp_n) || (!is_unix && qp_n)) {
             ret = -EINVAL;
             goto out;
         }
-        if (strcmp(qp->p[0].name, "socket")) {
+    }
+
+    uri_server = g_uri_get_host(uri);
+    uri_port = g_uri_get_port(uri);
+
+    if (is_unix) {
+        char *uri_socket = g_hash_table_lookup(qp, "socket");
+        if (uri_server || uri_port != -1 || !uri_socket) {
             ret = -EINVAL;
             goto out;
         }
-        gsconf->u.q_unix.path = g_strdup(qp->p[0].value);
+        gsconf->u.q_unix.path = g_strdup(uri_socket);
     } else {
-        gsconf->u.inet.host = g_strdup(uri->server ? uri->server : "localhost");
-        if (uri->port) {
-            gsconf->u.inet.port = g_strdup_printf("%d", uri->port);
+        gsconf->u.inet.host = g_strdup(uri_server ? uri_server : "localhost");
+        if (uri_port != -1) {
+            gsconf->u.inet.port = g_strdup_printf("%d", uri_port);
         } else {
             gsconf->u.inet.port = g_strdup_printf("%d", GLUSTER_DEFAULT_PORT);
         }
@@ -411,9 +422,9 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
 
 out:
     if (qp) {
-        query_params_free(qp);
+        g_hash_table_destroy(qp);
     }
-    uri_free(uri);
+    g_uri_unref(uri);
     return ret;
 }
 
-- 
2.44.0



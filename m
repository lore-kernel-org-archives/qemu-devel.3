Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D581AC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rdB-0005Cb-2M; Tue, 14 May 2024 08:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rd5-0005B9-Nz
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rd3-0005Ed-Un
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715691096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wncgA4v8L8vkEvBErE0b06OP0v4pfM0Il4czkDZATqU=;
 b=Qjmg5M426BjGfWT4aOjZX/o0ADQ9MPblPlMb/szOWoVBtWO0/o6BtuMu/6WxCTKx9Xwg8F
 h40guBAQIGOMy1Pl7GWOqHgFC4teqjnDEkpukcC/bkXBn5ieI2xG0o2MWWn01WvTjl34XF
 gLqHiQk8gWuy4+VQMtrlaPDwpXh1PH4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-3r7aq70GOuWG6dgsH1AKuA-1; Tue, 14 May 2024 08:51:30 -0400
X-MC-Unique: 3r7aq70GOuWG6dgsH1AKuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07538185A780;
 Tue, 14 May 2024 12:51:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42B03400EAC;
 Tue, 14 May 2024 12:51:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/11] block/gluster: Use URI parsing code from glib
Date: Tue, 14 May 2024 14:51:15 +0200
Message-ID: <20240514125119.284638-8-thuth@redhat.com>
In-Reply-To: <20240514125119.284638-1-thuth@redhat.com>
References: <20240514125119.284638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
to get rid of the latter.

Since g_uri_get_path() returns a const pointer, we also need to
tweak the parameter of parse_volume_options() (where we use the
result of g_uri_get_path() as input).

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240418101056.302103-10-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/gluster.c | 69 ++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 4253c8db5e..d0999903df 100644
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
@@ -349,13 +348,13 @@ static int parse_volume_options(BlockdevOptionsGluster *gconf, char *path)
 static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
                                   const char *filename)
 {
+    g_autoptr(GUri) uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
+    g_autoptr(GHashTable) qp = NULL;
     SocketAddress *gsconf;
-    URI *uri;
-    QueryParams *qp = NULL;
     bool is_unix = false;
-    int ret = 0;
+    const char *uri_scheme, *uri_query, *uri_server;
+    int uri_port, ret;
 
-    uri = uri_parse(filename);
     if (!uri) {
         return -EINVAL;
     }
@@ -364,54 +363,54 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
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
     } else {
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
-    ret = parse_volume_options(gconf, uri->path);
+    ret = parse_volume_options(gconf, g_uri_get_path(uri));
     if (ret < 0) {
-        goto out;
+        return ret;
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
+        ret = g_hash_table_size(qp);
+        if (ret > 1 || (is_unix && !ret) || (!is_unix && ret)) {
+            return -EINVAL;
+        }
     }
 
+    uri_server = g_uri_get_host(uri);
+    uri_port = g_uri_get_port(uri);
+
     if (is_unix) {
-        if (uri->server || uri->port) {
-            ret = -EINVAL;
-            goto out;
-        }
-        if (strcmp(qp->p[0].name, "socket")) {
-            ret = -EINVAL;
-            goto out;
+        char *uri_socket = g_hash_table_lookup(qp, "socket");
+        if (uri_server || uri_port != -1 || !uri_socket) {
+            return -EINVAL;
         }
-        gsconf->u.q_unix.path = g_strdup(qp->p[0].value);
+        gsconf->u.q_unix.path = g_strdup(uri_socket);
     } else {
-        gsconf->u.inet.host = g_strdup(uri->server ? uri->server : "localhost");
-        if (uri->port) {
-            gsconf->u.inet.port = g_strdup_printf("%d", uri->port);
+        gsconf->u.inet.host = g_strdup(uri_server ? uri_server : "localhost");
+        if (uri_port > 0) {
+            gsconf->u.inet.port = g_strdup_printf("%d", uri_port);
         } else {
             gsconf->u.inet.port = g_strdup_printf("%d", GLUSTER_DEFAULT_PORT);
         }
     }
 
-out:
-    if (qp) {
-        query_params_free(qp);
-    }
-    uri_free(uri);
-    return ret;
+    return 0;
 }
 
 static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
-- 
2.45.0



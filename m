Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547F9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 13:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvGu4-0003Bs-1H; Fri, 12 Apr 2024 09:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvGu0-00039k-Uc
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvGtz-0007Ee-53
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712928310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EX4Uerm0eo5Kmx5JIUK0JJzWYqOJJrmeNb+2wE1NvaU=;
 b=dNUbxddcPtuBMuPT9jGjc6iHk58+xZbUA4oGsVNN/f1hEhLF0OIGQx0TyFQApYZbzIIL4m
 i8fEuXVjAxgVKNO/rBwIbPAnYEHmoWykwDhEcIWdX6Wbh5bfdzKicqQPZHGa6fzHKm2Krw
 x2vvzxVgLE1VBcZ5P/BgZxkYV35mcNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-FxEHK-C4Opajgpb3bJ9r2g-1; Fri, 12 Apr 2024 09:25:07 -0400
X-MC-Unique: FxEHK-C4Opajgpb3bJ9r2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9B521044572;
 Fri, 12 Apr 2024 13:25:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C77032166B31;
 Fri, 12 Apr 2024 13:25:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 12/13] block/ssh: Use URI parsing code from glib
Date: Fri, 12 Apr 2024 15:24:14 +0200
Message-ID: <20240412132415.282354-13-thuth@redhat.com>
In-Reply-To: <20240412132415.282354-1-thuth@redhat.com>
References: <20240412132415.282354-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
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

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/ssh.c | 75 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 2748253d4a..18ae565e55 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -37,7 +37,6 @@
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
-#include "qemu/uri.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
@@ -181,65 +180,71 @@ static void sftp_error_trace(BDRVSSHState *s, const char *op)
 
 static int parse_uri(const char *filename, QDict *options, Error **errp)
 {
-    URI *uri = NULL;
-    QueryParams *qp;
+    g_autoptr(GUri) uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
+    const char *uri_host, *uri_path, *uri_user, *uri_query;
     char *port_str;
-    int i;
+    int port;
+    g_autoptr(GError) gerror = NULL;
+    char *qp_name, *qp_value;
+    GUriParamsIter qp;
 
-    uri = uri_parse(filename);
     if (!uri) {
         return -EINVAL;
     }
 
-    if (g_strcmp0(uri->scheme, "ssh") != 0) {
+    if (g_strcmp0(g_uri_get_scheme(uri), "ssh") != 0) {
         error_setg(errp, "URI scheme must be 'ssh'");
-        goto err;
+        return -EINVAL;
     }
 
-    if (!uri->server || strcmp(uri->server, "") == 0) {
+    uri_host = g_uri_get_host(uri);
+    if (!uri_host || g_str_equal(uri_host, "")) {
         error_setg(errp, "missing hostname in URI");
-        goto err;
+        return -EINVAL;
     }
 
-    if (!uri->path || strcmp(uri->path, "") == 0) {
+    uri_path = g_uri_get_path(uri);
+    if (!uri_path || g_str_equal(uri_path, "")) {
         error_setg(errp, "missing remote path in URI");
-        goto err;
-    }
-
-    qp = query_params_parse(uri->query);
-    if (!qp) {
-        error_setg(errp, "could not parse query parameters");
-        goto err;
+        return -EINVAL;
     }
 
-    if(uri->user && strcmp(uri->user, "") != 0) {
-        qdict_put_str(options, "user", uri->user);
+    uri_user = g_uri_get_user(uri);
+    if (uri_user && !g_str_equal(uri_user, "")) {
+        qdict_put_str(options, "user", uri_user);
     }
 
-    qdict_put_str(options, "server.host", uri->server);
+    qdict_put_str(options, "server.host", uri_host);
 
-    port_str = g_strdup_printf("%d", uri->port ?: 22);
+    port = g_uri_get_port(uri);
+    port_str = g_strdup_printf("%d", port > 0 ? port : 22);
     qdict_put_str(options, "server.port", port_str);
     g_free(port_str);
 
-    qdict_put_str(options, "path", uri->path);
-
-    /* Pick out any query parameters that we understand, and ignore
-     * the rest.
-     */
-    for (i = 0; i < qp->n; ++i) {
-        if (strcmp(qp->p[i].name, "host_key_check") == 0) {
-            qdict_put_str(options, "host_key_check", qp->p[i].value);
+    qdict_put_str(options, "path", uri_path);
+
+    uri_query = g_uri_get_query(uri);
+    if (uri_query) {
+        g_uri_params_iter_init(&qp, uri_query, -1, "&", G_URI_PARAMS_NONE);
+        while (g_uri_params_iter_next(&qp, &qp_name, &qp_value, &gerror)) {
+            if (!qp_name || !qp_value || gerror) {
+                warn_report("Failed to parse SSH URI parameters '%s'.",
+                            uri_query);
+                break;
+            }
+            /*
+             * Pick out the query parameters that we understand, and ignore
+             * (or rather warn about) the rest.
+             */
+            if (g_str_equal(qp_name, "host_key_check")) {
+                qdict_put_str(options, "host_key_check", qp_value);
+            } else {
+                warn_report("Unsupported parameter '%s' in URI.", qp_name);
+            }
         }
     }
 
-    query_params_free(qp);
-    uri_free(uri);
     return 0;
-
- err:
-    uri_free(uri);
-    return -EINVAL;
 }
 
 static bool ssh_has_filename_options_conflict(QDict *options, Error **errp)
-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A189DC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rdB-0005Cc-5n; Tue, 14 May 2024 08:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rd5-0005BA-OL
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rd3-0005Eb-A1
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715691096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F8dKPRh3tTFaxqIfiPPuISRlRC9y16vPm22SPlSQefY=;
 b=clmhuP/OiefCsypL/N31U1Co6YdbVZyKJusy860+GvAFGBv96EmsoyK4B+B1wL+6HTyo1f
 ZSEToAOAvAWkNo2uPbKMAk4CyjyR2E6gHSTYtZ/FYAaq6Y4epWiQKps5m/DmqdpUkU3vj/
 39QInOxq6wjsVSr5PGTN+2u7HRfZh34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-zAMKEySLO5WmZfjmgXl4EQ-1; Tue, 14 May 2024 08:51:33 -0400
X-MC-Unique: zAMKEySLO5WmZfjmgXl4EQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8A298016FA;
 Tue, 14 May 2024 12:51:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 438C6400EAC;
 Tue, 14 May 2024 12:51:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/11] block/nfs: Use URI parsing code from glib
Date: Tue, 14 May 2024 14:51:17 +0200
Message-ID: <20240514125119.284638-10-thuth@redhat.com>
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
to get rid of the latter.

While we're at it, slightly rephrase one of the error messages:
Use "Invalid value..." instead of "Illegal value..." since the
latter rather sounds like the users were breaking a law here.

Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240418101056.302103-12-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/nfs.c | 110 ++++++++++++++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 56 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index f737e19cd3..60240a8733 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -38,7 +38,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "qemu/uri.h"
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
 #include "qapi/qapi-visit-block-core.h"
@@ -79,77 +78,76 @@ typedef struct NFSRPC {
 
 static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
 {
-    URI *uri = NULL;
-    QueryParams *qp = NULL;
-    int ret = -EINVAL, i;
+    g_autoptr(GUri) uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
+    GUriParamsIter qp;
+    const char *uri_server, *uri_path, *uri_query;
+    char *qp_name, *qp_value;
+    GError *gerror = NULL;
 
-    uri = uri_parse(filename);
     if (!uri) {
         error_setg(errp, "Invalid URI specified");
-        goto out;
+        return -EINVAL;
     }
-    if (g_strcmp0(uri->scheme, "nfs") != 0) {
+    if (!g_str_equal(g_uri_get_scheme(uri), "nfs")) {
         error_setg(errp, "URI scheme must be 'nfs'");
-        goto out;
+        return -EINVAL;
     }
 
-    if (!uri->server) {
+    uri_server = g_uri_get_host(uri);
+    if (!uri_server || !uri_server[0]) {
         error_setg(errp, "missing hostname in URI");
-        goto out;
+        return -EINVAL;
     }
 
-    if (!uri->path) {
+    uri_path = g_uri_get_path(uri);
+    if (!uri_path || !uri_path[0]) {
         error_setg(errp, "missing file path in URI");
-        goto out;
-    }
-
-    qp = query_params_parse(uri->query);
-    if (!qp) {
-        error_setg(errp, "could not parse query parameters");
-        goto out;
+        return -EINVAL;
     }
 
-    qdict_put_str(options, "server.host", uri->server);
+    qdict_put_str(options, "server.host", uri_server);
     qdict_put_str(options, "server.type", "inet");
-    qdict_put_str(options, "path", uri->path);
-
-    for (i = 0; i < qp->n; i++) {
-        uint64_t val;
-        if (!qp->p[i].value) {
-            error_setg(errp, "Value for NFS parameter expected: %s",
-                       qp->p[i].name);
-            goto out;
-        }
-        if (parse_uint_full(qp->p[i].value, 0, &val)) {
-            error_setg(errp, "Illegal value for NFS parameter: %s",
-                       qp->p[i].name);
-            goto out;
-        }
-        if (!strcmp(qp->p[i].name, "uid")) {
-            qdict_put_str(options, "user", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "gid")) {
-            qdict_put_str(options, "group", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {
-            qdict_put_str(options, "tcp-syn-count", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "readahead")) {
-            qdict_put_str(options, "readahead-size", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "pagecache")) {
-            qdict_put_str(options, "page-cache-size", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "debug")) {
-            qdict_put_str(options, "debug", qp->p[i].value);
-        } else {
-            error_setg(errp, "Unknown NFS parameter name: %s",
-                       qp->p[i].name);
-            goto out;
+    qdict_put_str(options, "path", uri_path);
+
+    uri_query = g_uri_get_query(uri);
+    if (uri_query) {
+        g_uri_params_iter_init(&qp, uri_query, -1, "&", G_URI_PARAMS_NONE);
+        while (g_uri_params_iter_next(&qp, &qp_name, &qp_value, &gerror)) {
+            uint64_t val;
+            if (!qp_name || gerror) {
+                error_setg(errp, "Failed to parse NFS parameter");
+                return -EINVAL;
+            }
+            if (!qp_value) {
+                error_setg(errp, "Value for NFS parameter expected: %s",
+                           qp_name);
+                return -EINVAL;
+            }
+            if (parse_uint_full(qp_value, 0, &val)) {
+                error_setg(errp, "Invalid value for NFS parameter: %s",
+                           qp_name);
+                return -EINVAL;
+            }
+            if (g_str_equal(qp_name, "uid")) {
+                qdict_put_str(options, "user", qp_value);
+            } else if (g_str_equal(qp_name, "gid")) {
+                qdict_put_str(options, "group", qp_value);
+            } else if (g_str_equal(qp_name, "tcp-syncnt")) {
+                qdict_put_str(options, "tcp-syn-count", qp_value);
+            } else if (g_str_equal(qp_name, "readahead")) {
+                qdict_put_str(options, "readahead-size", qp_value);
+            } else if (g_str_equal(qp_name, "pagecache")) {
+                qdict_put_str(options, "page-cache-size", qp_value);
+            } else if (g_str_equal(qp_name, "debug")) {
+                qdict_put_str(options, "debug", qp_value);
+            } else {
+                error_setg(errp, "Unknown NFS parameter name: %s", qp_name);
+                return -EINVAL;
+            }
         }
     }
-    ret = 0;
-out:
-    if (qp) {
-        query_params_free(qp);
-    }
-    uri_free(uri);
-    return ret;
+
+    return 0;
 }
 
 static bool nfs_has_filename_options_conflict(QDict *options, Error **errp)
-- 
2.45.0



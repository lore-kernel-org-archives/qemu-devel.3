Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15512606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NONwIPeO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc1z-00088S-6t; Sun, 01 Nov 2026 15:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzt-00055b-OH
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzi-0007Eq-9P
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAac/l1KwmkzTW2jlMu4iQVrlvI/OwkdwDrVyptuG7k=;
 b=NONwIPeOcLYAKRtpar5stZEvA9eKksBfmMVZelR+E1kXNq4YSN8ryIGV6/lFQkPi6jT3FQ
 e2kD2wfIWmWj1Whxu4Gb/JHUu7MIOoZCQiluiXozUFkKMDxHOjCEAo76BUnXvRSI0M0C2a
 ndhcMOCEgonBVBQ+lAeCF4xr2Nw4Ykw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-0WltvZ2ZOn-iTNkQkjJAoA-1; Sun,
 01 Nov 2026 15:17:32 -0500
X-MC-Unique: 0WltvZ2ZOn-iTNkQkjJAoA-1
X-Mimecast-MFC-AGG-ID: 0WltvZ2ZOn-iTNkQkjJAoA_1793564251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CB531954AC2
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13C3430002CB
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A00D321E66BB; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 56/56] tests/qmp-cmd-test: assert qapi-type resolves in
 query-qmp-schema
Date: Sun,  1 Nov 2026 21:17:17 +0100
Message-ID: <20261101201717.3911097-57-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

For every QOM type returned by qom-list-types, call qom-list-properties
and verify that each property's qapi-type value (when present) maps to
a valid entry in the query-qmp-schema introspection output.

The test is gated behind g_test_slow() since it iterates all registered
QOM types.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/qmp-cmd-test.c | 55 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 279a8f5614..acb7b0dd6a 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-introspect.h"
 #include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qapi/qobject-input-visitor.h"
 
 const char common_args[] = "-nodefaults -machine none";
@@ -131,6 +132,8 @@ typedef struct {
     GHashTable *hash;
 } QmpSchema;
 
+static QmpSchema schema;
+
 static void qmp_schema_init(QmpSchema *schema)
 {
     QDict *resp;
@@ -343,9 +346,56 @@ static void test_object_add_failure_modes(void)
     qtest_quit(qts);
 }
 
+static void test_qapi_type(void)
+{
+    QTestState *qts;
+    g_autoptr(QDict) resp = NULL;
+    QList *types;
+    QListEntry *type_entry, *prop_entry;
+
+    qts = qtest_init(common_args);
+
+    resp = qtest_qmp(qts,
+                     "{ 'execute': 'qom-list-types',"
+                     "  'arguments': { 'abstract': true } }");
+    g_assert(qdict_haskey(resp, "return"));
+    types = qdict_get_qlist(resp, "return");
+
+    QLIST_FOREACH_ENTRY(types, type_entry) {
+        QDict *type = qobject_to(QDict, qlist_entry_obj(type_entry));
+        const char *name = qdict_get_str(type, "name");
+        g_autoptr(QDict) props_resp = NULL;
+        QList *props;
+
+        props_resp = qtest_qmp(qts,
+                               "{ 'execute': 'qom-list-properties',"
+                               "  'arguments': { 'typename': %s } }",
+                               name);
+        if (!qdict_haskey(props_resp, "return")) {
+            continue;
+        }
+        props = qdict_get_qlist(props_resp, "return");
+
+        QLIST_FOREACH_ENTRY(props, prop_entry) {
+            QDict *prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
+            const char *qapi_type = qdict_get_try_str(prop, "qapi-type");
+            const char *propname = qdict_get_str(prop, "name");
+            const char *ty = qdict_get_str(prop, "type");
+
+            if (qapi_type) {
+                g_assert_nonnull(qmp_schema_lookup(&schema, qapi_type));
+            } else if (!g_str_has_prefix(ty, "child<") &&
+                       !g_str_has_prefix(ty, "link<")) {
+                g_test_message("%s.%s %s has no associated qapi-type",
+                               name, propname, ty);
+            }
+        }
+    }
+    qtest_quit(qts);
+}
+
 int main(int argc, char *argv[])
 {
-    QmpSchema schema;
     int ret;
 
     g_test_init(&argc, &argv, NULL);
@@ -355,6 +405,9 @@ int main(int argc, char *argv[])
 
     qtest_add_func("qmp/object-add-failure-modes",
                    test_object_add_failure_modes);
+    if (g_test_slow()) {
+        qtest_add_func("qmp/qapi-type", test_qapi_type);
+    }
 
     ret = g_test_run();
 
-- 
2.55.0



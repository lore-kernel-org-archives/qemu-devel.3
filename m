Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4537EC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Jh-0007pw-8A; Fri, 11 Sep 2026 12:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JV-0007Sh-AH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JT-0007MA-Qb
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNt+NcdfdrXTDAde4gaKYFts/kwAUEfykTyytEmPajw=;
 b=dJnSntP4qG7KHJEe0QNPHKm1aYbamlpSTcjDs7Upj/GKRCjLc0EYnql9hM5PqX/9Tr5hdl
 n+1b1rY2pj6jjmrmUw20WujU5mBK+r91zO8pc7ZCIjv4K1EkZiPJQZ0GJ0Ey9qkIZEcvKY
 Swjh7+kdAwCULLlAXG4dAbevUmq3syo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-mS_ymASiOxG4TozqyYTo9w-1; Fri,
 11 Sep 2026 12:41:15 -0400
X-MC-Unique: mS_ymASiOxG4TozqyYTo9w-1
X-Mimecast-MFC-AGG-ID: mS_ymASiOxG4TozqyYTo9w_1789144874
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 829A21954B1D; Fri, 11 Sep 2026 16:41:14 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AB321956095; Fri, 11 Sep 2026 16:41:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:35 +0400
Subject: [PATCH v5 61/62] tests/qmp-cmd-test: assert qapi-type resolves in
 query-qmp-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-61-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3468;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mt67E9MU0ECVhSiFdrQC3amyYOINAVoLsnaOA5PKLXU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC290ksNehAvUIb0yu2n0PORNwr9iKo5JGHO0
 6wvVXKm/rGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtvQAKCRDa6OEJdZac
 5RoDD/4qn5abF2P4cfEX2NoZhxPC6npkfqLqAwUKqZ3OQWgGNgR5rztWDyTscEjf+ToIl2Ro+We
 VV02RAa9djGnTGw577SJBo8ZDs2RiaY1HJTn/fkUunF/Kd7jaCoMdUTrhnuSq+4MF5Nb+aBqIdz
 TgcAXDlOdKMG4PPo9hoquAHi2+T0utWkMALFNSHo9O93hY37bTP8KeCfpVrf9uMvol/06Eu/j0a
 JShvckY6xzciLe5on7ZUCHQRYCq9JjvO7klaNACD4ZTFE/hVtfFUAEav9Xq9BI7UuZNMqusgM2P
 MfFnZiUNO+sw69qFiLkdADb9Q7l26AbEi5KET0XBgFBbwV+doJx22eKIz8fCZ+KXlnY34W/uGzu
 KmMA5bBX/WxoErl6ud0/VnInIN/LFfbortlNKwexinXTmpDnwCog6tBDAkq8UGGr7aQi9Q5RZ0+
 oV7H6u/FGxi9t71fzRB35abGWRf7wV9ZmdRKD5NvvcCazqq9ge6PcJo5jbH74KRz+bYx8/B19wa
 1++bKDJoQBvhGOpCPM/lYsq0Lj25h/bG6cKtVKJXIhaFRfsEeGBIrQHG999Jq5f40yhrxyJCMie
 xO0GiWHS2lGSw5LaQ29YxFj1bAdSLVitkuJLbuFQyIJ/zmSg7GaXt0gd4hTJ7yp4c76I9xmLwCa
 3QgNlvpVp+v37cA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For every QOM type returned by qom-list-types, call qom-list-properties
and verify that each property's qapi-type value (when present) maps to
a valid entry in the query-qmp-schema introspection output.

The test is gated behind g_test_slow() since it iterates all registered
QOM types.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/qmp-cmd-test.c | 55 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 279a8f5614e9..acb7b0dd6a9f 100644
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
2.55.0.543.g5ebe2ebe4ea8



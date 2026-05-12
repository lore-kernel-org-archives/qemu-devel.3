Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD649CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 12:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMmH8-0001EP-Cq; Tue, 12 May 2026 08:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMmFj-0000Ny-Rv
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMmFg-0002Gc-49
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778589019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3N69S2HP6DOOioem4NT1ph8aNy2Ra92PkRUQ7BLnR8=;
 b=PYMOb1vG3fRcRVBOKxq9YII11EtplZw9LP5vNUuTfQBUOZ1lILn2xAiuHtd9GWwyJiiZbz
 0mrJ8dZUFS0qjrz/O1yAvwGLMxxNv9RuP1LT4kQMegvujrNJuVOswWa8+3Sln7Ai1jo7Xy
 p3Dgr0EBuzMxAJidQO6e4rC3oSLDyYU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-dKk3vkpxONGt5b4tkTeQuQ-1; Tue,
 12 May 2026 08:30:17 -0400
X-MC-Unique: dKk3vkpxONGt5b4tkTeQuQ-1
X-Mimecast-MFC-AGG-ID: dKk3vkpxONGt5b4tkTeQuQ_1778589016
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD10E1800283; Tue, 12 May 2026 12:30:16 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.244])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BA6930001BE; Tue, 12 May 2026 12:30:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 06/10] qom: move object_set_prop_keyval into object.c
Date: Tue, 12 May 2026 13:29:54 +0100
Message-ID: <20260512122958.788097-7-berrange@redhat.com>
In-Reply-To: <20260512122958.788097-1-berrange@redhat.com>
References: <20260512122958.788097-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This matches the location of the object_set_props and object_set_propv
methods, since this method is not inherently tied to the user creatable
interface. As part of this, object_set_props_from_qdict is also exposed
as a public API since it is still called from object_interfaces.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h    | 47 +++++++++++++++++++++++++++--------------
 qom/object.c            | 36 +++++++++++++++++++++++++++++++
 qom/object_interfaces.c | 36 -------------------------------
 3 files changed, 67 insertions(+), 52 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 20a04cc4a9..1b2b2702fc 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -748,6 +748,37 @@ bool object_set_props(Object *obj, Error **errp, ...) G_GNUC_NULL_TERMINATED;
  */
 bool object_set_propv(Object *obj, va_list vargs, Error **errp);
 
+/**
+ * object_set_props_from_qdict:
+ * @obj: a QOM object
+ * @qdict: a dictionary with the properties to be set
+ * @v: a visitor to iterate over @dict
+ * @errp: pointer to error object
+ *
+ * For each key in the dictionary, set the corresponding
+ * property in @obj.
+ *
+ * Returns: %true on success, %false on error.
+ */
+bool object_set_props_from_qdict(Object *obj, const QDict *qdict,
+                                 Visitor *v, Error **errp);
+
+/**
+ * object_set_props_from_keyval:
+ * @obj: a QOM object
+ * @qdict: a dictionary with the properties to be set
+ * @from_json: true if leaf values of @qdict are typed, false if they
+ * are strings
+ * @errp: pointer to error object
+ *
+ * For each key in the dictionary, parse the value string if needed,
+ * then set the corresponding property in @obj.
+ *
+ * Returns: %true on success, %false on error.
+ */
+bool object_set_props_from_keyval(Object *obj, const QDict *qdict,
+                                  bool from_json, Error **errp);
+
 /**
  * object_initialize:
  * @obj: A pointer to the memory to be used for the object.
@@ -914,22 +945,6 @@ type_init(do_qemu_init_ ## type_array)
  */
 bool type_print_class_properties(const char *type);
 
-/**
- * object_set_props_from_keyval:
- * @obj: a QOM object
- * @qdict: a dictionary with the properties to be set
- * @from_json: true if leaf values of @qdict are typed, false if they
- * are strings
- * @errp: pointer to error object
- *
- * For each key in the dictionary, parse the value string if needed,
- * then set the corresponding property in @obj.
- *
- * Returns: %true on success, %false on error.
- */
-bool object_set_props_from_keyval(Object *obj, const QDict *qdict,
-                                  bool from_json, Error **errp);
-
 /**
  * object_class_dynamic_cast_assert:
  * @klass: The #ObjectClass to attempt to cast.
diff --git a/qom/object.c b/qom/object.c
index 608c9c0ac7..d8083dc318 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -23,6 +23,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
+#include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qemu/id.h"
 #include "qapi/qmp/qerror.h"
@@ -847,6 +848,41 @@ bool object_set_propv(Object *obj,
     return true;
 }
 
+bool object_set_props_from_qdict(Object *obj, const QDict *qdict,
+                                 Visitor *v, Error **errp)
+{
+    ERRP_GUARD();
+    const QDictEntry *e;
+
+    if (!visit_start_struct(v, NULL, NULL, 0, errp)) {
+        return false;
+    }
+    for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
+        if (!object_property_set(obj, e->key, v, errp)) {
+            goto out;
+        }
+    }
+    visit_check_struct(v, errp);
+out:
+    visit_end_struct(v, NULL);
+
+    return *errp == NULL;
+}
+
+bool object_set_props_from_keyval(Object *obj, const QDict *qdict,
+                                  bool from_json, Error **errp)
+{
+    bool ret;
+    Visitor *v;
+    if (from_json) {
+        v = qobject_input_visitor_new(QOBJECT(qdict));
+    } else {
+        v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    }
+    ret = object_set_props_from_qdict(obj, qdict, v, errp);
+    visit_free(v);
+    return ret;
+}
 
 Object *object_dynamic_cast(Object *obj, const char *typename)
 {
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 50736b80c8..e0a3cd8d0f 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -44,42 +44,6 @@ bool user_creatable_can_be_deleted(UserCreatable *uc)
     }
 }
 
-static bool object_set_props_from_qdict(Object *obj, const QDict *qdict,
-                                        Visitor *v, Error **errp)
-{
-    ERRP_GUARD();
-    const QDictEntry *e;
-
-    if (!visit_start_struct(v, NULL, NULL, 0, errp)) {
-        return false;
-    }
-    for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
-        if (!object_property_set(obj, e->key, v, errp)) {
-            goto out;
-        }
-    }
-    visit_check_struct(v, errp);
-out:
-    visit_end_struct(v, NULL);
-
-    return *errp == NULL;
-}
-
-bool object_set_props_from_keyval(Object *obj, const QDict *qdict,
-                                  bool from_json, Error **errp)
-{
-    bool ret;
-    Visitor *v;
-    if (from_json) {
-        v = qobject_input_visitor_new(QOBJECT(qdict));
-    } else {
-        v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    }
-    ret = object_set_props_from_qdict(obj, qdict, v, errp);
-    visit_free(v);
-    return ret;
-}
-
 Object *user_creatable_add_type(const char *type, const char *id,
                                 const QDict *qdict,
                                 Visitor *v, Error **errp)
-- 
2.54.0



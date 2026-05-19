Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBE5CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJyS-0001gQ-3j; Tue, 19 May 2026 08:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJxG-00088Y-9f
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJxD-0001AI-5W
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779195226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26FOAWe6CEIbzXUqveh6ti2zrWxtCUNKJmgkkPmlgVE=;
 b=Yt7ABCCVP3qIrm9ZrWzeckt4wGj/yxb11JFt5csg6LM3cKOqvZhBjYUJ1/qu79Ud7PV2mR
 r4L9vhYr6XNyt1AiD62wkRZDAY35ginR0PwpU/WwRjaVuN4w7YIGKofqlbuzCZYgVOp1+I
 sjvNXCXe6tIneE/e+xThsOYZeBLbeqY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659--l0UuWMyOLSGhVqFMCFhGw-1; Tue,
 19 May 2026 08:53:43 -0400
X-MC-Unique: -l0UuWMyOLSGhVqFMCFhGw-1
X-Mimecast-MFC-AGG-ID: -l0UuWMyOLSGhVqFMCFhGw_1779195221
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B964C1955DEA; Tue, 19 May 2026 12:53:41 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CDD1180056E; Tue, 19 May 2026 12:53:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 26/28] qom: fix ability to create objects without a parent
Date: Tue, 19 May 2026 13:51:50 +0100
Message-ID: <20260519125153.1015315-27-berrange@redhat.com>
In-Reply-To: <20260519125153.1015315-1-berrange@redhat.com>
References: <20260519125153.1015315-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

object_new_with_propv allowed id/parent to be optional, in which case
the caller was expected to own the returned object. Unfortunately a
trailing object_unref() meant that the returned object was already
freed.

It is confusing to have a single method with two different ownership
scenarios for the returned object.

Make id/parent mandatory in object_new_with_propv once more, and add
a new object_new_with_propv_parentless that does not accept id/parent
at all and lets the caller own the returned reference.

The helper method has abstracted the way properties are represented
and set in order to facilitate the subsequent commit.

Unit tests are added to address the root cause that allowed the bug
to slip through in commit 6134d752.

Fixes: 6134d7522e5 ("qom: don't require user creatable objects to be registered")
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h            | 47 ++++++++++++++++++
 qom/object.c                    | 74 +++++++++++++++++++++++----
 tests/unit/check-qom-proplist.c | 88 ++++++++++++++++++++++++++++-----
 3 files changed, 187 insertions(+), 22 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index fb1cd92d97..11f55613fc 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -719,6 +719,53 @@ Object *object_new_with_props_from_qdict(const char *typename,
                                          Visitor *v,
                                          Error **errp);
 
+/**
+ * object_new_with_props_parentless:
+ * @typename:  The name of the type of the object to instantiate.
+ * @errp: pointer to error object
+ * @...: list of property names and values
+ *
+ * Behaviour as object_new_with_props(), except the object
+ * will not be added to any parent and thus the caller will
+ * own the returned instance. The caller must call
+ * object_unref when it is no longer required.
+ */
+Object *object_new_with_props_parentless(const char *typename,
+                                         Error **errp,
+                                         ...) G_GNUC_NULL_TERMINATED;
+
+/**
+ * object_new_with_propv_parentless:
+ * @typename:  The name of the type of the object to instantiate.
+ * @vargs: list of property names and values
+ * @errp: pointer to error object
+ *
+ * Behaviour as object_new_with_propv(), except the object
+ * will not be added to any parent and thus the caller will
+ * own the returned instance. The caller must call
+ * object_unref when it is no longer required.
+ */
+Object *object_new_with_propv_parentless(const char *typename,
+                                         va_list vargs,
+                                         Error **errp);
+
+/**
+ * object_new_with_props_from_qdict_parentless:
+ * @typename:  The name of the type of the object to instantiate.
+ * @props: dictionary of property names and values
+ * @v: visitor to iterate over @props
+ * @errp: pointer to error object
+ *
+ * Behaviour as object_new_with_props_from_qdict(), except the
+ * object will not be added to any parent and thus the caller
+ * will own the returned instance. The caller must call
+ * object_unref when it is no longer required.
+ */
+Object *object_new_with_props_from_qdict_parentless(const char *typename,
+                                                    const QDict *props,
+                                                    Visitor *v,
+                                                    Error **errp);
+
 /**
  * object_set_props:
  * @obj: the object instance to set properties on
diff --git a/qom/object.c b/qom/object.c
index a11f559445..5a7ac457c1 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -740,6 +740,8 @@ Object *object_new_with_props(const char *typename,
     va_list vargs;
     Object *obj;
 
+    assert(parent != NULL);
+    assert(id != NULL);
     va_start(vargs, errp);
     obj = object_new_with_propv(typename, parent, id, vargs, errp);
     va_end(vargs);
@@ -757,10 +759,14 @@ object_new_with_props_helper(const char *typename,
                                               Error **errp),
                              Error **errp)
 {
+    ERRP_GUARD();
     Object *obj;
     ObjectClass *klass;
     UserCreatable *uc;
 
+    assert((id != NULL && parent != NULL) ||
+           (id == NULL && parent == NULL));
+
     if (id != NULL && !id_wellformed(id)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identifier");
         error_append_hint(errp, "Identifiers consist of letters, digits, "
@@ -785,7 +791,10 @@ object_new_with_props_helper(const char *typename,
     }
 
     if (id != NULL) {
-        object_property_add_child(parent, id, obj);
+        object_property_try_add_child(parent, id, obj, errp);
+        if (*errp) {
+            goto error;
+        }
     }
 
     uc = (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
@@ -798,7 +807,6 @@ object_new_with_props_helper(const char *typename,
         }
     }
 
-    object_unref(obj);
     return obj;
 
  error:
@@ -826,7 +834,8 @@ Object *object_new_with_propv(const char *typename,
 {
     Object *obj;
     struct ObjectNewVargsData data;
-
+    assert(parent != NULL);
+    assert(id != NULL);
     va_copy(data.vargs, vargs);
     obj = object_new_with_props_helper(typename,
                                        parent,
@@ -835,6 +844,9 @@ Object *object_new_with_propv(const char *typename,
                                        object_new_with_propv_setter,
                                        errp);
     va_end(data.vargs);
+    if (obj) {
+        object_unref(obj);
+    }
     return obj;
 }
 
@@ -859,12 +871,56 @@ Object *object_new_with_props_from_qdict(const char *typename,
                                          Error **errp)
 {
     struct ObjectNewQDictData data = { props, v };
-    return object_new_with_props_helper(typename,
-                                        parent,
-                                        id,
-                                        &data,
-                                        object_new_with_qdict_setter,
-                                        errp);
+    Object *obj;
+    assert(parent != NULL);
+    assert(id != NULL);
+    obj = object_new_with_props_helper(typename,
+                                       parent,
+                                       id,
+                                       &data,
+                                       object_new_with_qdict_setter,
+                                       errp);
+    if (obj) {
+        object_unref(obj);
+    }
+    return obj;
+}
+
+Object *object_new_with_props_parentless(const char *typename,
+                                         Error **errp,
+                                         ...)
+{
+    va_list vargs;
+    Object *obj;
+
+    va_start(vargs, errp);
+    obj = object_new_with_propv_parentless(typename, vargs, errp);
+    va_end(vargs);
+
+    return obj;
+}
+
+Object *object_new_with_propv_parentless(const char *typename,
+                                         va_list vargs,
+                                         Error **errp)
+{
+    Object *ret;
+    struct ObjectNewVargsData data;
+    va_copy(data.vargs, vargs);
+    ret = object_new_with_props_helper(typename, NULL, NULL, &data,
+                                       object_new_with_propv_setter, errp);
+    va_end(data.vargs);
+    return ret;
+}
+
+Object *object_new_with_props_from_qdict_parentless(const char *typename,
+                                                    const QDict *props,
+                                                    Visitor *v,
+                                                    Error **errp)
+{
+    struct ObjectNewQDictData data = { props, v };
+    return object_new_with_props_helper(typename, NULL, NULL, &data,
+                                        object_new_with_qdict_setter, errp);
 }
 
 bool object_set_props(Object *obj,
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 7f31735459..954c898ce1 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -336,7 +336,7 @@ static QemuOptsList qemu_object_opts = {
 };
 
 
-static void test_dummy_createv(void)
+static void test_dummy_createv_tree(void)
 {
     Error *err = NULL;
     Object *parent = object_get_objects_root();
@@ -351,6 +351,7 @@ static void test_dummy_createv(void)
                               NULL));
 
     g_assert(err == NULL);
+    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
     g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
     g_assert(dobj->bv == true);
     g_assert(dobj->av == DUMMY_PLATYPUS);
@@ -362,9 +363,30 @@ static void test_dummy_createv(void)
 }
 
 
-static Object *new_helper(Error **errp,
-                          Object *parent,
-                          ...)
+static void test_dummy_createv_parentless(void)
+{
+    Error *err = NULL;
+    DummyObject *dobj = DUMMY_OBJECT(
+        object_new_with_props_parentless(TYPE_DUMMY,
+                                         &err,
+                                         "bv", "yes",
+                                         "sv", "Hiss hiss hiss",
+                                         "av", "platypus",
+                                         NULL));
+
+    g_assert(err == NULL);
+    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
+    g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
+    g_assert(dobj->bv == true);
+    g_assert(dobj->av == DUMMY_PLATYPUS);
+
+    object_unref(OBJECT(dobj));
+}
+
+
+static Object *new_helper_tree(Error **errp,
+                               Object *parent,
+                               ...)
 {
     va_list vargs;
     Object *obj;
@@ -379,19 +401,20 @@ static Object *new_helper(Error **errp,
     return obj;
 }
 
-static void test_dummy_createlist(void)
+static void test_dummy_createlist_tree(void)
 {
     Error *err = NULL;
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
-        new_helper(&err,
-                   parent,
-                   "bv", "yes",
-                   "sv", "Hiss hiss hiss",
-                   "av", "platypus",
-                   NULL));
+        new_helper_tree(&err,
+                        parent,
+                        "bv", "yes",
+                        "sv", "Hiss hiss hiss",
+                        "av", "platypus",
+                        NULL));
 
     g_assert(err == NULL);
+    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
     g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
     g_assert(dobj->bv == true);
     g_assert(dobj->av == DUMMY_PLATYPUS);
@@ -402,6 +425,39 @@ static void test_dummy_createlist(void)
     object_unparent(OBJECT(dobj));
 }
 
+static Object *new_helper_parentless(Error **errp,
+                                     ...)
+{
+    va_list vargs;
+    Object *obj;
+
+    va_start(vargs, errp);
+    obj = object_new_with_propv_parentless(TYPE_DUMMY,
+                                           vargs,
+                                           errp);
+    va_end(vargs);
+    return obj;
+}
+
+static void test_dummy_createlist_parentless(void)
+{
+    Error *err = NULL;
+    DummyObject *dobj = DUMMY_OBJECT(
+        new_helper_parentless(&err,
+                              "bv", "yes",
+                              "sv", "Hiss hiss hiss",
+                              "av", "platypus",
+                              NULL));
+
+    g_assert(err == NULL);
+    g_assert_cmpint(dobj->parent_obj.ref, ==, 1);
+    g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
+    g_assert(dobj->bv == true);
+    g_assert(dobj->av == DUMMY_PLATYPUS);
+
+    object_unref(OBJECT(dobj));
+}
+
 static bool test_create_obj(QDict *qdict, Error **errp)
 {
     Visitor *v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
@@ -658,8 +714,14 @@ int main(int argc, char **argv)
     type_register_static(&dummy_bus_info);
     type_register_static(&dummy_backend_info);
 
-    g_test_add_func("/qom/proplist/createlist", test_dummy_createlist);
-    g_test_add_func("/qom/proplist/createv", test_dummy_createv);
+    g_test_add_func("/qom/proplist/createlist/tree",
+                    test_dummy_createlist_tree);
+    g_test_add_func("/qom/proplist/createlist/parentless",
+                    test_dummy_createlist_parentless);
+    g_test_add_func("/qom/proplist/createv/tree",
+                    test_dummy_createv_tree);
+    g_test_add_func("/qom/proplist/createv/parentless",
+                    test_dummy_createv_parentless);
     g_test_add_func("/qom/proplist/createcmdline", test_dummy_createcmdl);
     g_test_add_func("/qom/proplist/badenum", test_dummy_badenum);
     g_test_add_func("/qom/proplist/getenum", test_dummy_getenum);
-- 
2.54.0



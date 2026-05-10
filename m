Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F15CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4UR-0001jH-2L; Sun, 10 May 2026 09:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4TW-00013l-CD
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4TS-0004pZ-NI
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5G459n7lWCR6RHTw6ZXPgMDR6fRbZNSZklrPlvbvRh8=;
 b=V+Pnwu9uA8zda3lqyzcOUx1eqPooSdXdrHr3cKBSRPpDzd0dgsP1NnW4eUM3Xwzin40feS
 blYeFDo0uDXRw9LdvfxSKEE0UcWjHuyi03FA17ewNGLC2tvpWBm7p9hKVQGBf3hnMSUve7
 wQhF8ITtUAW0n2vk6Tzi57HoPasz5Q0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-lcI3LTA7MImIj7vmDntVAQ-1; Sun,
 10 May 2026 09:45:36 -0400
X-MC-Unique: lcI3LTA7MImIj7vmDntVAQ-1
X-Mimecast-MFC-AGG-ID: lcI3LTA7MImIj7vmDntVAQ_1778420735
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 399A7195608A
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:45:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EEDD19560A2; Sun, 10 May 2026 13:45:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:08 +0400
Subject: [PATCH 11/54] tests: update check-qom-proplist for QAPI-aware
 property registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-11-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5561;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AYySB4whkyxqj4vvcpXqAD8zNJIJd16aWiD3AOenPUQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItul/Y9cbWxeV5ZWNEHQbbJvzyQcNQbi63gc
 PWIINSZXzuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbgAKCRDa6OEJdZac
 5YT2EACrLs2+Z/izomzenr8vm/CVB2rjnJW8oO3Btpqu5NU3B9XzTn9NHoFD3I1H5/XEZKGyVVo
 8jNoKLerfoQpdZgAPRIM3COVPNyhslw8GXrGQ9EQNPHuFDzmVMaYG/8PDnqbIaVXKFglqvedC7A
 JeYuIQgRdWIMkuuCFcsZZVPeU77Ak1/c9+3oQmYTDEsXPMhBJeKQwIYbVl3YJuXY8NDslhvzNEG
 ys/MNeRne1Qopv6dlSEh3Ah3SvUDprXfMkP7lyhheNWlSKEQ1HMgbELnM5qAK5FkUB25/VH0Lyq
 l0vuKQgEZMY2lsXtA7oA11/PisqH9sxOmSj9bShn9TgCJTiTJxVEFHJkStj/gocMA9kw3ahW0YK
 iKsKLRgVw/Th1y5yrz5U3mHwUazeA1ilaKAscIHvJ4hFCwvLwkhUD+dmqCwYxC8qtH+RTTJZ4nV
 aCzH++N+RfyCIwb2wCdnfSw7+azNRTyrMXHZ3+R9p45JnkhHI60heMd+vkmLAIpRDBxoDsi9SN1
 0tzOAblNq4nus9wI2gpF4q0XbY0luCzaZMi6FW8+UEIIPn94J20VJfmQrPgrpCjI3GB0Rxc1wlA
 jbZGtVPCP4EABnM/Mt5J5VqPZ59KOjhdQOLNWdBu1ldQhiCNf8Eok2enFEUsGTwF6R79siOF59E
 2bPTVUMo52wRz+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Migrate the dummy object's string and enum properties from the legacy
object_class_property_add_str/enum() helpers to the new QAPI-aware
object_class_property_add_qapi/qapi_enum() registration.

Add test cases verifying that the qapi_type metadata is correctly
populated on properties registered through the new API, and that it
remains NULL for properties using the old-style registration.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/unit/check-qom-proplist.c | 94 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index ee3c6fb32b1..7f10befe687 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "qapi/qapi-type-info.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qobject/qdict.h"
 #include "qobject/qobject.h"
@@ -108,22 +109,21 @@ static int dummy_get_av(Object *obj,
 }
 
 
-static void dummy_set_sv(Object *obj,
-                         const char *value,
-                         Error **errp)
+static void dummy_set_sv(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
 {
     DummyObject *dobj = DUMMY_OBJECT(obj);
 
-    g_free(dobj->sv);
-    dobj->sv = g_strdup(value);
+    g_clear_pointer(&dobj->sv, g_free);
+    visit_type_str(v, name, &dobj->sv, errp);
 }
 
-static char *dummy_get_sv(Object *obj,
-                          Error **errp)
+static void dummy_get_sv(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
 {
     DummyObject *dobj = DUMMY_OBJECT(obj);
 
-    return g_strdup(dobj->sv);
+    visit_type_str(v, name, &dobj->sv, errp);
 }
 
 
@@ -135,16 +135,28 @@ static void dummy_init(Object *obj)
 }
 
 
+static const QAPITypeInfo dummy_animal_qapi_type_info = {
+    .name = "DummyAnimal",
+    .schema_name = "DummyAnimalSchema",
+    .lookup = &dummy_animal_map,
+};
+
+static const QAPITypeInfo dummy_str_qapi_type_info = {
+    .name = "str",
+    .schema_name = "StrSchema",
+};
+
 static void dummy_class_init(ObjectClass *cls, const void *data)
 {
-    object_class_property_add_str(cls, "sv",
-                                  dummy_get_sv,
-                                  dummy_set_sv);
-    object_class_property_add_enum(cls, "av",
-                                   "DummyAnimal",
-                                   &dummy_animal_map,
-                                   dummy_get_av,
-                                   dummy_set_av);
+    object_class_property_add_qapi(cls, "sv", &dummy_str_qapi_type_info,
+                                   dummy_get_sv, dummy_set_sv,
+                                   NULL, NULL);
+    object_class_property_add_qapi_enum(cls, QAPI_ENUM_PROP(
+        .name = "av",
+        .qapi_type = &dummy_animal_qapi_type_info,
+        .get = dummy_get_av,
+        .set = dummy_set_av,
+    ));
 }
 
 
@@ -648,6 +660,54 @@ static void test_qom_partial_path(void)
     object_unparent(cont1);
 }
 
+static void test_dummy_qapi_enum(void)
+{
+    ObjectProperty *prop;
+    Object *parent = object_get_objects_root();
+    DummyObject *dobj = DUMMY_OBJECT(
+        object_new_with_props(TYPE_DUMMY,
+                              parent,
+                              "dummy0",
+                              &error_abort,
+                              "av", "platypus",
+                              NULL));
+
+    g_assert(dobj->av == DUMMY_PLATYPUS);
+
+    prop = object_property_find(OBJECT(dobj), "av");
+    g_assert(prop);
+    g_assert(prop->qapi_type == &dummy_animal_qapi_type_info);
+    g_assert_cmpstr(prop->qapi_type->name, ==, "DummyAnimal");
+    g_assert_cmpstr(prop->qapi_type->schema_name, ==, "DummyAnimalSchema");
+    g_assert(prop->qapi_type->lookup == &dummy_animal_map);
+
+    object_unparent(OBJECT(dobj));
+}
+
+static void test_dummy_qapi_prop(void)
+{
+    ObjectProperty *prop;
+    Object *parent = object_get_objects_root();
+    DummyObject *dobj = DUMMY_OBJECT(
+        object_new_with_props(TYPE_DUMMY,
+                              parent,
+                              "dummy0",
+                              &error_abort,
+                              "sv", "hello",
+                              NULL));
+
+    g_assert_cmpstr(dobj->sv, ==, "hello");
+
+    prop = object_property_find(OBJECT(dobj), "sv");
+    g_assert(prop);
+    g_assert(prop->qapi_type == &dummy_str_qapi_type_info);
+    g_assert_cmpstr(prop->qapi_type->name, ==, "str");
+    g_assert_cmpstr(prop->qapi_type->schema_name, ==, "StrSchema");
+    g_assert(prop->qapi_type->lookup == NULL);
+
+    object_unparent(OBJECT(dobj));
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -666,6 +726,8 @@ int main(int argc, char **argv)
     g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
     g_test_add_func("/qom/proplist/class_iterator", test_dummy_class_iterator);
     g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
+    g_test_add_func("/qom/proplist/qapi_enum", test_dummy_qapi_enum);
+    g_test_add_func("/qom/proplist/qapi_prop", test_dummy_qapi_prop);
     g_test_add_func("/qom/resolve/partial", test_qom_partial_path);
 
     return g_test_run();

-- 
2.54.0



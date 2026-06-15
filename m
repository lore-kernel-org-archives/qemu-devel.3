Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CA7CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE54-0004Ah-NU; Mon, 15 Jun 2026 16:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4z-0003vV-WB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4y-0002J9-Eg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIJ8wiYX4hBouo8bMRvFFBAm62qqOG8BUT4dNTuI/gk=;
 b=R8CX9eET2v6gPH+Wt8v82kr45Gw/1hbYb4JiJbutPvbhpfDAnDM/QOohBoxKEpMNEid8YA
 /lVRuYpOOkD6MZAofQl+LF+rgTkILqYnrbuB+ZOXFVPuDM3C1owpy0JSSH+EVlQxGI4JFA
 HLJgQTDwXWG8jS21NigBAEbGl9HU4RA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-CI8rW7muNGm6n6lViQkP-A-1; Mon,
 15 Jun 2026 16:38:42 -0400
X-MC-Unique: CI8rW7muNGm6n6lViQkP-A-1
X-Mimecast-MFC-AGG-ID: CI8rW7muNGm6n6lViQkP-A_1781555921
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC83F19560AD; Mon, 15 Jun 2026 20:38:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70D49195419D; Mon, 15 Jun 2026 20:38:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:37 +0400
Subject: [PATCH v2 11/53] tests: update check-qom-proplist for QAPI-aware
 property registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-11-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5561;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oM1MtOJQd4L/PsvmfXXNV0ZRzHil2m7HqwwICsFzsrU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKODpWcZSTD47f4q2AkSejXiGdjWTLiqkXYg
 AldVQnyztOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5d/2EACk9Lsytp4SJP/mO/XV5ABHAzIh4/uS/ETwSm/jLZQ3z7OTb73rwp0tJs6oV/wwzPop4GX
 vhgkVEqrNCeAd8qXt0xOz537hPvjFnGsOk5JAoeOhWznhmc8cWY5NoLCVI6k4EzNblZ22y/nM2I
 JXwNd/gstteqwkt5FUOHJSDlBAyiqvrjIeEX+f/QHbZ4uePc8BagV8Bky6Ys+J1x7i/K4ut1n1v
 Z10XJcbfqu2JJOxdjJw0wwrZjWE+ecpPEFs8/L8lSMiUALTuP6mxphGnbFa8YFYD34C6y5AjZFb
 1ZI7aYphYJGX7MxNqOKDSlkTXE/QTutcLbPOUq6iEz0apRdBmwnJsqvYVfZK9KHBSArJ1L63kHm
 +ebBzPAXX+cs39ZAHZwy/Ga8arw7//SLFtju35fhvU8li1x16u6bw/fBvGQuEQA+ig6gtw8+QZ2
 SIgv4R0cXN0Kq04KuiSyWVQIg9qADqPqJke+SRUUsbdPNpQpPFs44+1jrqz8p1uavQxvt96Dy5T
 Vr79FT5ujmSdGK1fFwkLFvhCTsyqNzCkFz1F0a000/CSn/GRDi96xb7n8eULOFoM49ybpl1N+jz
 IwSULj0XKE7TxzcRJoU3WnoOz12FFW1Z3xfHAVmI0dI5Naj5BuhrwSc2lUlpn7+G5KESuGpSYtQ
 r0SMpJS0UDfr5nw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 89de92b7d91..b053237f0b2 100644
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
 
 
@@ -703,6 +715,54 @@ static void test_qom_partial_path(void)
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
@@ -727,6 +787,8 @@ int main(int argc, char **argv)
     g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
     g_test_add_func("/qom/proplist/class_iterator", test_dummy_class_iterator);
     g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
+    g_test_add_func("/qom/proplist/qapi_enum", test_dummy_qapi_enum);
+    g_test_add_func("/qom/proplist/qapi_prop", test_dummy_qapi_prop);
     g_test_add_func("/qom/resolve/partial", test_qom_partial_path);
 
     return g_test_run();

-- 
2.54.0



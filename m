Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8500BC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHoK-0007Ri-S8; Tue, 18 Aug 2026 07:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHoI-0007Qx-KD
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHoH-0005TX-0r
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNYgOyjpFTHomWvYcWcSOyR0E+fcnEjS4LB5n8XH++I=;
 b=I0BHUTQHyzQ7nhfZSnDKGrU4B12tuDwNr+trBRqpJtiKcfL4LHPCO5Kn4YWLnYDuLhPb0z
 swJo2uCb3M47MlaK1s5l1mCodfNJR+v8EMEo6mKXk5JJ5IIxDev3B2NZy6S3zmvp23S8/9
 P9xs42c7eiR2269p46f0b9O0senLexc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-plEIMmryOcm8zjg2XbHelQ-1; Tue,
 18 Aug 2026 07:16:46 -0400
X-MC-Unique: plEIMmryOcm8zjg2XbHelQ-1
X-Mimecast-MFC-AGG-ID: plEIMmryOcm8zjg2XbHelQ_1787051805
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DB121956041; Tue, 18 Aug 2026 11:16:45 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D98E530002EA; Tue, 18 Aug 2026 11:16:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:40 +0400
Subject: [PATCH v3 13/74] tests: update check-qom-proplist for QAPI-aware
 property registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-13-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5370;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=q2n1PS8TB3xj4XT1NZQ4agWLWhftpKvEUnO0GIyvQS8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD23iHQ55OOHCltD6utioO3bVy6BLBD1QeO+/
 Zciswu3IteJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9twAKCRDa6OEJdZac
 5S4sD/9Xwow+RYxX4gfgFROZ8QHaAKpVy/XtsvFpQ5riR4bfXREX9gW5FJRegaCXUKUMkAhOzwt
 sO+RmqCIMhTAUNdKJAY8az/2pixz7YGEKcRupAnbi1gUWpxZ/oq5Q4URh6XrCoj1qYl3FT2bfdA
 97n3KjriQ4MC1p4RzdqaW2Ad+brutttci5w+bvbqumY5rCoXVlqI4xj0E8BLuQbXaoGY/9iQchB
 qyg8HGXYzDwJNSP5Imawf6B70bNK1H/s8VMM6SrtAeTMMs8n4/PnIEBByPhotmWHNowFEIxwocr
 b9JP1uCFxhRHQ8reVAcJjTR6yp9VIJWaguSU6zR2ntDqSmmYUqhUQIZUH4Xxjl4L9I3wn7LYHkL
 8cgxcmhnkpshQR5y0IGJzGKkmLnyu9O9ebc5BCHjvCDhzqAmnLbYv9yowtBzUSsPQwa+43f+L/D
 NBl4s3zqQj6uUGuG667p4KQ3fgHkJjfq6f4CjE8/QzmMGHjkGeWc68zLKWtYMlLsgQt10BrfWEW
 8kJ9spa/FY2mHtf4sj5aDNlH2J8GF+1mDPANj23aQ8z0IebLLoTQwuDRIt6S1eHz/HtqN6mMR+N
 /oU5oNJ6/7BbVv3AhelfMs7VwrNWiONF4cNJC6XShTruBiIryOswrOPzKMbPPPkT1sL1dyo/QWA
 ykovDcc+nI+M7SQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 tests/unit/check-qom-proplist.c | 93 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 89de92b7d91f..69155e720751 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -108,22 +108,21 @@ static int dummy_get_av(Object *obj,
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
 
 
@@ -135,16 +134,28 @@ static void dummy_init(Object *obj)
 }
 
 
+static const QAPITypeInfo dummy_animal_qapi_type_info = {
+    .name = "DummyAnimal",
+    .masked_name = "DummyAnimalSchema",
+    .lookup = &dummy_animal_map,
+};
+
+static const QAPITypeInfo dummy_str_qapi_type_info = {
+    .name = "str",
+    .masked_name = "StrSchema",
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
 
 
@@ -703,6 +714,54 @@ static void test_qom_partial_path(void)
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
+    g_assert_cmpstr(prop->qapi_type->masked_name, ==, "DummyAnimalSchema");
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
+    g_assert_cmpstr(prop->qapi_type->masked_name, ==, "StrSchema");
+    g_assert(prop->qapi_type->lookup == NULL);
+
+    object_unparent(OBJECT(dobj));
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -727,6 +786,8 @@ int main(int argc, char **argv)
     g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
     g_test_add_func("/qom/proplist/class_iterator", test_dummy_class_iterator);
     g_test_add_func("/qom/proplist/delchild", test_dummy_delchild);
+    g_test_add_func("/qom/proplist/qapi_enum", test_dummy_qapi_enum);
+    g_test_add_func("/qom/proplist/qapi_prop", test_dummy_qapi_prop);
     g_test_add_func("/qom/resolve/partial", test_qom_partial_path);
 
     return g_test_run();

-- 
2.55.0.543.g5ebe2ebe4ea8



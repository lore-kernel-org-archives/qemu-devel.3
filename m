Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40F7CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoDe-0002O9-08; Mon, 19 Oct 2026 10:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDJ-0002Ca-EG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDG-0005Ys-83
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gE74ym71MtLujBClC1IqS0YjVMeyOfif/2X51OHcNXk=;
 b=DoI1Dctk9cTvEiTAn/Udxdo41cIKUgThT8IjsuzK6wB72ful4imOlJCakinZb92I78rGOf
 2nRWbf0FFLqnNmGkZPxCDi2zYF9yt/Ej2ih8aw5bndBZQpRLMLzsRFH6WjC9ILgEwP8RDl
 VoTxx4qAxPPbo5EezZJc8x6mR+soHo4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-Zf6KKr0tPraCsnd0SXtXFg-1; Mon,
 19 Oct 2026 14:19:39 +0000
X-MC-Unique: Zf6KKr0tPraCsnd0SXtXFg-1
X-Mimecast-MFC-AGG-ID: Zf6KKr0tPraCsnd0SXtXFg_1792419578
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B93D1954AC8; Mon, 19 Oct 2026 14:19:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0A201955E76; Mon, 19 Oct 2026 14:19:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC02821E6896; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 18/65] tests: update check-qom-proplist for QAPI-aware
 property registration
Date: Mon, 19 Oct 2026 16:18:42 +0200
Message-ID: <20261019141929.1594337-19-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Migrate the dummy object's string and enum properties from the legacy
object_class_property_add_str/enum() helpers to the new QAPI-aware
object_class_property_add_qapi/qapi_enum() registration.

Add test cases verifying that the qapi_type metadata is correctly
populated on properties registered through the new API, and that it
remains NULL for properties using the old-style registration.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/unit/check-qom-proplist.c | 93 +++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 89de92b7d9..69155e7207 100644
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
2.55.0



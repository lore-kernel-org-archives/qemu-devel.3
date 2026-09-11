Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1870EC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Gq-0007w5-7Y; Fri, 11 Sep 2026 12:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Gm-0007S7-AL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Gk-0006RY-4T
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=girJTupFSeQuIQp5Q8w9m8sFCIToXcJFLfuB706GG7E=;
 b=LSpRSTZFZhwN8Razb2upcZ4844wpth5zs/LWW6SDxWlzyEOJ+JQN5dnMFQ0gOMZ6cF9iCh
 Fx/Zy/Do5OteOdA6/pnlcQNe3yaBjSGFCKR11axRkSoB8dCo3qTok3a00kOD5eP11FDE0E
 /iOv0dmHCjpGVwF55gjoKVF593SUmq0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-byi2ymW_MYqk5gXI4gYRhg-1; Fri,
 11 Sep 2026 12:38:26 -0400
X-MC-Unique: byi2ymW_MYqk5gXI4gYRhg-1
X-Mimecast-MFC-AGG-ID: byi2ymW_MYqk5gXI4gYRhg_1789144705
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09F79180136D; Fri, 11 Sep 2026 16:38:25 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E872195608F; Fri, 11 Sep 2026 16:38:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:50 +0400
Subject: [PATCH v5 16/62] qom: remove old enum property registration API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-16-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7293;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=u/jtz0VEJPO7qFKfQaHWT67kjziwn5hqQAMBuiinxLc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC235NXrVI5PFtuw3fyzZHuoBD+xNcmd7gRmN
 HjtMdkouhKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQttwAKCRDa6OEJdZac
 5WhCD/9laL7Zsu0rOfdc4C3/AeTKE/BIONjPzdtIgh5WGY0Jf7atKmgxuTuquSIGjP+UO5htxFN
 cS9Pyezk53fMiiQm9srUBAccsHBdWYy9EFWJH++Ful72LXmhOx156A/jNvd5puVX6Znp6M9hGti
 UpiapstNL5gyDO+sRWL+hY+oZLBtjAkHeXlzX/OE47nr/I3L8EMRsJu/yCLbAcOfc9iDC9ve2d0
 YBsNMVP5ECkIo0eoL9BOXswkQ0Dx9zQgk99wyrmSLVN5THMFiULDtnfRuox6ThLLd899NnW+8o3
 xTGd7PgxzToyrExnUfkRrpwTfhEcjs1MvHGzgonK3dJbd+I8eQPJ9YnFpdwsRgQfdv4/iDwR3u3
 o0Zy2BfWHK1wGZ0AP6KrfatLOzTcw/+1L2q8C2iudOizfzFbarhGZwis/FVkiXtHFGlh/nZ1ike
 K7jIA+zS/s074M9SFg9mk0bUY9bUkU9KjyBSXum4UCkOATteL3Oh111ogvq5nQ4IFWzPdVQJx2Z
 U6d8Fk1nKQMlnUtYdtbCWVgHeyzS/62Yc801lP9agEBzUP2/wAdDZFeFKC2lcDxo830+NhHnVNh
 Z6m44WSMGEotPFXt16rKpOqjALfQEekWSffuIld9tQsluGezDZKq4ViKbW7N/dlyaQtOkM4Nrc3
 5i2UdH3jr2BuW3g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that all callers use object_class_property_add_qapi_enum(), remove
the legacy object_property_add_enum() and object_class_property_add_enum()
functions along with their EnumProperty struct and property_get_enum /
property_set_enum helpers.

Simplify object_property_get_enum() to assert on qapi_type rather than
falling back to the old EnumProperty opaque data.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 45 ++--------------------------
 qom/object.c         | 82 ++--------------------------------------------------
 2 files changed, 4 insertions(+), 123 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index c9a5fe4934d0..6d84bbb25bb5 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1663,12 +1663,12 @@ char *object_get_canonical_path(const Object *obj);
  *   because it was ambiguous, or %NULL. Set to %false on success.
  *
  * There are two types of supported paths--absolute paths and partial paths.
- * 
+ *
  * Absolute paths are derived from the root object and can follow child<> or
  * link<> properties.  Since they can follow link<> properties, they can be
  * arbitrarily long.  Absolute paths look like absolute filenames and are
  * prefixed with a leading slash.
- * 
+ *
  * Partial paths look like relative filenames.  They do not begin with a
  * prefix.  The matching rules for partial paths are subtle but designed to make
  * specifying objects easy.  At each level of the composition tree, the partial
@@ -1952,47 +1952,6 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
                                     bool (*get)(Object *, Error **),
                                     void (*set)(Object *, bool, Error **));
 
-/**
- * object_property_add_enum:
- * @obj: the object to add a property to
- * @name: the name of the property
- * @typename: the name of the enum data type
- * @lookup: enum value namelookup table
- * @get: the getter or %NULL if the property is write-only.
- * @set: the setter or %NULL if the property is read-only
- *
- * Add an enum property using getters/setters.  This function will add a
- * property of type '@typename'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_property_add_enum(Object *obj, const char *name,
-                              const char *typename,
-                              const QEnumLookup *lookup,
-                              int (*get)(Object *, Error **),
-                              void (*set)(Object *, int, Error **));
-
-/**
- * object_class_property_add_enum:
- * @klass: the object class to add a property to
- * @name: the name of the property
- * @typename: the name of the enum data type
- * @lookup: enum value namelookup table
- * @get: the getter or %NULL if the property is write-only.
- * @set: the setter or %NULL if the property is read-only
- *
- * Add an enum property using getters/setters.  This function will add a
- * property of type '@typename'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
-                                    const char *name,
-                                    const char *typename,
-                                    const QEnumLookup *lookup,
-                                    int (*get)(Object *, Error **),
-                                    void (*set)(Object *, int, Error **));
-
 /**
  * struct QapiEnumProp - Descriptor for a QOM property backed by a QAPI enum type
  *
diff --git a/qom/object.c b/qom/object.c
index 2d3bd2ae327d..8e6ca25dc49d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1764,12 +1764,6 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
     return retval;
 }
 
-typedef struct EnumProperty {
-    const QEnumLookup *lookup;
-    int (*get)(Object *, Error **);
-    void (*set)(Object *, int, Error **);
-} EnumProperty;
-
 int object_property_get_enum(Object *obj, const char *name,
                              const char *typename, Error **errp)
 {
@@ -1793,12 +1787,8 @@ int object_property_get_enum(Object *obj, const char *name,
         return -1;
     }
 
-    if (prop->qapi_type) {
-        ret = qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
-    } else {
-        EnumProperty *enumprop = prop->opaque;
-        ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
-    }
+    assert(prop->qapi_type);
+    ret = qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
     g_free(str);
 
     return ret;
@@ -2533,74 +2523,6 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
                                      prop);
 }
 
-static void property_get_enum(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    EnumProperty *prop = opaque;
-    int value;
-    Error *err = NULL;
-
-    value = prop->get(obj, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    visit_type_enum(v, name, &value, prop->lookup, errp);
-}
-
-static void property_set_enum(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    EnumProperty *prop = opaque;
-    int value;
-
-    if (!visit_type_enum(v, name, &value, prop->lookup, errp)) {
-        return;
-    }
-    prop->set(obj, value, errp);
-}
-
-ObjectProperty *
-object_property_add_enum(Object *obj, const char *name,
-                         const char *typename,
-                         const QEnumLookup *lookup,
-                         int (*get)(Object *, Error **),
-                         void (*set)(Object *, int, Error **))
-{
-    EnumProperty *prop = g_malloc(sizeof(*prop));
-
-    prop->lookup = lookup;
-    prop->get = get;
-    prop->set = set;
-
-    return object_property_add(obj, name, typename,
-                               get ? property_get_enum : NULL,
-                               set ? property_set_enum : NULL,
-                               property_release_data,
-                               prop);
-}
-
-ObjectProperty *
-object_class_property_add_enum(ObjectClass *klass, const char *name,
-                                    const char *typename,
-                                    const QEnumLookup *lookup,
-                                    int (*get)(Object *, Error **),
-                                    void (*set)(Object *, int, Error **))
-{
-    EnumProperty *prop = g_malloc(sizeof(*prop));
-
-    prop->lookup = lookup;
-    prop->get = get;
-    prop->set = set;
-
-    return object_class_property_add(klass, name, typename,
-                                     get ? property_get_enum : NULL,
-                                     set ? property_set_enum : NULL,
-                                     NULL,
-                                     prop);
-}
-
 static void get_qapi_enum(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {

-- 
2.55.0.543.g5ebe2ebe4ea8



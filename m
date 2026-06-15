Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA8FCD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE5F-0004pq-5L; Mon, 15 Jun 2026 16:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5B-0004fu-LH
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE59-0002Jr-RF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9QlbbdOYQCcI2YItnjsPTMcvIqr508sLt5xiZsAmv0=;
 b=gdzUuJI/mtypg5KbaDAdbtBULDoehOvBVdHzwXdeVYmLLamnCZgolOBDLodWQiES/DJT5J
 XDQKAmCEk/rMPUlUiw4mNTgzE5VHrEWOXSGLJm/t1LrYPqS/+09QPisJmXtehbnNtzmHx7
 JBd183x/KJdarXL1kV5W08DOeC9zGB4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-kVxluq7RMziJBQvXuUzaag-1; Mon,
 15 Jun 2026 16:38:53 -0400
X-MC-Unique: kVxluq7RMziJBQvXuUzaag-1
X-Mimecast-MFC-AGG-ID: kVxluq7RMziJBQvXuUzaag_1781555932
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23E891956067; Mon, 15 Jun 2026 20:38:52 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DACCD3008B37; Mon, 15 Jun 2026 20:38:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:39 +0400
Subject: [PATCH v2 13/53] qom: remove old enum property registration API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-13-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7006;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jvt2N7853ZAZdS40i/AdDe2545eEYC74FdiyRnRc2PA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKOzZ+oO1HlwgWeqiacob07aAtnrjDcqXGFW
 Po6hFA/GBeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5TDhD/9n9xC3KdQFl6cbUFi7P6LpfNqmPqyrOFS5y0lFAZJ7qO+pJr2rTrDv38gl4MYyvq8mNUo
 ThNZdI4Peka/yqpbSWbpgk6u7PDCrjQNpLlfwurDoWanJ9V5AVtJzKwK5CdIjfggIB7jyRIgENE
 zA92tR/ax0XitOfBt1/L1sBtM8jjOSsqrwa9KS+Cqt1PhsVL8TxLKeY4VZwSg6IRsX5oJJRgVER
 uNc7QJ5OhktBnoj+ADG2uAecfuRZlQyVJyuE7w/aDxGKvAomuE/yn9aRcUb0Td5/RtgdWomrrqC
 FVDzjeIIUeXAw+QqLHc/6J00k67+YagH7R05lyujZCoP5f7jUKYBZmHtDsPgseopYC+/xQxXc3N
 8zRfodBNLXklxZqVOVvdkDAK8PSjfEA4ZIk7mx9QrSq9h9LjRVY4uxdwtvmVM7hSNOOvnX0cHDt
 BZKPFai7wtbPOEipZmuURL0iRMzH402OaM74J/fgyZ7oHrsIekEexnVO2JPUj0CNzYJo7p4atSk
 UPPWeRZMqcg2j+yZJNaPR3GtuWBKJGEZ//lJ8eUpMm8ZekzQ2PtOpG3IW0EkpxKzxpQxFriJF4z
 3PK2+JCTPS84JoMzRGOEHC91RUfM8tYvLOOvlXZ730oPXTtUmIHB4t1ayWKsRkzsCc/04MITSdp
 i0QzHs2h9JMxg/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Now that all callers use object_class_property_add_qapi_enum(), remove
the legacy object_property_add_enum() and object_class_property_add_enum()
functions along with their EnumProperty struct and property_get_enum /
property_set_enum helpers.

Simplify object_property_get_enum() to assert on qapi_type rather than
falling back to the old EnumProperty opaque data.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 31 ++-----------------
 qom/object.c         | 84 ++--------------------------------------------------
 2 files changed, 5 insertions(+), 110 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index ebfdbff9a94..0b2089bb9ac 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1660,12 +1660,12 @@ char *object_get_canonical_path(const Object *obj);
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
@@ -1897,33 +1897,6 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
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
index e5e2f09a0a2..1a3e224ea2c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1219,7 +1219,7 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
         return;
     }
 
-    if (data->implements_type && 
+    if (data->implements_type &&
         !object_class_dynamic_cast(k, data->implements_type)) {
         return;
     }
@@ -1773,12 +1773,6 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
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
@@ -1802,12 +1796,8 @@ int object_property_get_enum(Object *obj, const char *name,
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
@@ -2542,74 +2532,6 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
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
2.54.0



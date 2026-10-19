Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A95CCF2E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoFz-0005rc-9y; Mon, 19 Oct 2026 10:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDS-0002FT-5i
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDM-0005cZ-85
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJR38aRH3MxL+Wkcj+00TS0fVfAYzFQS/BNNPmQZWFM=;
 b=iQ048+SHBi7AfUTGwCdMbPJeMvnTMt7v+5dKssutUy5bOHx1bP/9ECL3kglPPZAvng9q/8
 1PeHTxma5HIvYxEv14PF/zfs4wzGdApBu8mzgN/yibQ0ZR0cpsw/nHqF1U7rDSqTgKiWpj
 jzV9mMoeNC5GKxWUek74c8ip59SbGD0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-Op_QxPG5MEmZvQeiPFwYrw-1; Mon,
 19 Oct 2026 14:19:45 +0000
X-MC-Unique: Op_QxPG5MEmZvQeiPFwYrw-1
X-Mimecast-MFC-AGG-ID: Op_QxPG5MEmZvQeiPFwYrw_1792419583
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C79111800749; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BF5718004D2; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A252021E662B; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 63/65] qom: remove old enum property registration API
Date: Mon, 19 Oct 2026 16:19:27 +0200
Message-ID: <20261019141929.1594337-64-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that all callers use object_class_property_add_qapi_enum(), remove
the legacy object_property_add_enum() and object_class_property_add_enum()
functions along with their EnumProperty struct and property_get_enum /
property_set_enum helpers.

Simplify object_property_get_enum() to assert on qapi_type rather than
falling back to the old EnumProperty opaque data.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h | 45 ++----------------------
 qom/object.c         | 82 ++------------------------------------------
 2 files changed, 4 insertions(+), 123 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index ca6653094a..45999a03ed 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1676,12 +1676,12 @@ char *object_get_canonical_path(const Object *obj);
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
@@ -1965,47 +1965,6 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
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
  * struct QapiEnumProp: Descriptor for a property backed by a QAPI enum type
  *
diff --git a/qom/object.c b/qom/object.c
index 9ad07273f5..90adadb80d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1774,12 +1774,6 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
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
@@ -1803,12 +1797,8 @@ int object_property_get_enum(Object *obj, const char *name,
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
@@ -2543,74 +2533,6 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
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
2.55.0



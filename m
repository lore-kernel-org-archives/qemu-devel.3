Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79DFCCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoE5-0002cC-3D; Mon, 19 Oct 2026 10:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDY-0002Jq-Ra
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDS-0005fv-Cx
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4HZ9bdfbZ+qkB7s8sHA5El26M+zzgxNFMKDHvdhnEY=;
 b=VOCkmAgpnPv/8l5cIuMxSLQgnF2Z8TYHVbjgzDgiODnQvwbG3g0/Ascd8lsH8DZfpcH4Dm
 FjvpXOegxJisiDVQWD9JJxE9uQcxrm2+7RM2QUW1ozwjeoPDQoKHQTsuYU8NiiiC4MSDm2
 d5TpyID+GN9nE8zJX1XFzaKBQETGx6Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-wGP1CLU9PheFvwFDrDCmXA-1; Mon,
 19 Oct 2026 14:19:46 +0000
X-MC-Unique: wGP1CLU9PheFvwFDrDCmXA-1
X-Mimecast-MFC-AGG-ID: wGP1CLU9PheFvwFDrDCmXA_1792419583
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C74A119541A0; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C2711800643; Mon, 19 Oct 2026 14:19:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F38D21E6617; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 59/65] qdev: introduce typed array PropertyInfos
Date: Mon, 19 Oct 2026 16:19:23 +0200
Message-ID: <20261019141929.1594337-60-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Add element_info and element_size fields to PropertyInfo, and extend
qdev_prop_qapi_type() to derive QAPI types for array properties via
element_info->qapi_type->list.

Add typed list PropertyInfo definitions that replace the generic
qdev_prop_array. Each typed list PropertyInfo knows its element type
at compile time through the element_info and element_size fields,
which allows the QAPI type to be derived automatically.

Infrastructure changes:
- Add prop_array_info() and prop_array_elem_size() helpers that
  prefer the new element_info/element_size fields with fallback to
  the old arrayinfo/arrayfieldsize fields for compatibility
- Make get_prop_array, set_prop_array, release_prop_array, and
  default_prop_array non-static so they can be used by
  DEFINE_PROP_ARRAY_INFO in other translation units
- Add DEFINE_PROP_ARRAY_INFO macro in qdev-prop-internal.h

The array of links needs special care for its "full type name" to follow
the "link<TYPE>List" pattern used by link properties ("link<TYPE>").

The old qdev_prop_array and DEFINE_PROP_ARRAY macro are preserved
for compatibility; they will be replaced in the next patch.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-prop-internal.h             |  21 +++++
 include/hw/core/qdev-properties-system.h |   2 +
 include/hw/core/qdev-properties.h        |   8 ++
 hw/core/qdev-properties-system.c         |   5 ++
 hw/core/qdev-properties.c                | 104 ++++++++++++++++++-----
 5 files changed, 119 insertions(+), 21 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index c190b7b88c..40fa4bc63f 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -27,4 +27,25 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp);
 
+void get_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp);
+void set_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp);
+void release_prop_array(Object *obj, const char *name, void *opaque);
+void default_prop_array(ObjectProperty *op, const Property *prop);
+
+/*
+ * Note: .qapi_type is derived from element_info->qapi_type->list by
+ * qdev_prop_qapi_type()
+ */
+#define DEFINE_PROP_ARRAY_INFO(_elem_prop_info, _elem_type) \
+    {                                                       \
+        .element_info = &(_elem_prop_info),                 \
+        .element_size = sizeof(_elem_type),                 \
+        .get = get_prop_array,                              \
+        .set = set_prop_array,                              \
+        .release = release_prop_array,                      \
+        .set_default_value = default_prop_array,            \
+    }
+
 #endif
diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
index 2cbea16d61..819dce7d5e 100644
--- a/include/hw/core/qdev-properties-system.h
+++ b/include/hw/core/qdev-properties-system.h
@@ -23,6 +23,8 @@ extern const PropertyInfo qdev_prop_fdc_drive_type;
 extern const PropertyInfo qdev_prop_drive;
 extern const PropertyInfo qdev_prop_drive_iothread;
 extern const PropertyInfo qdev_prop_netdev;
+extern const PropertyInfo qdev_prop_netdev_list;
+extern const PropertyInfo qdev_prop_reserved_region_list;
 extern const PropertyInfo qdev_prop_pci_devfn;
 extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 1ea2ba66bb..0c06717007 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -35,6 +35,8 @@ struct PropertyInfo {
     const char *description;
     const QEnumLookup *enum_table;
     const QAPITypeInfo *qapi_type;
+    const struct PropertyInfo *element_info;
+    int element_size;
     bool realized_set_allowed; /* allow setting property on realized device */
     char *(*print)(Object *obj, const Property *prop);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
@@ -75,7 +77,13 @@ extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_size32;
 extern const PropertyInfo qdev_prop_array;
+extern const PropertyInfo qdev_prop_uint8_list;
+extern const PropertyInfo qdev_prop_uint16_list;
+extern const PropertyInfo qdev_prop_uint32_list;
+extern const PropertyInfo qdev_prop_uint64_list;
+extern const PropertyInfo qdev_prop_string_list;
 extern const PropertyInfo qdev_prop_link;
+extern const PropertyInfo qdev_prop_link_list;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
         .name      = (_name),                                    \
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8819a9a0b7..ad4a00f776 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -484,6 +484,8 @@ const PropertyInfo qdev_prop_netdev = {
     .set   = set_netdev,
 };
 
+const PropertyInfo qdev_prop_netdev_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_netdev, NICPeers);
 
 /* --- audiodev --- */
 static void get_audiodev(Object *obj, Visitor *v, const char* name,
@@ -822,6 +824,9 @@ const PropertyInfo qdev_prop_reserved_region = {
     .set   = set_reserved_region,
 };
 
+const PropertyInfo qdev_prop_reserved_region_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_reserved_region, ReservedRegion);
+
 /* --- pci address --- */
 
 /*
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a9abc646d5..bace12b10e 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -666,6 +666,22 @@ struct ArrayElementList {
     void *value;
 };
 
+static const PropertyInfo *prop_array_info(const Property *prop)
+{
+    if (prop->info->element_info) {
+        return prop->info->element_info;
+    }
+    return prop->arrayinfo;
+}
+
+static int prop_array_elem_size(const Property *prop)
+{
+    if (prop->info->element_size) {
+        return prop->info->element_size;
+    }
+    return prop->arrayfieldsize;
+}
+
 /*
  * Given an array property @parent_prop in @obj, return a Property for a
  * specific element of the array. Arrays are backed by an uint32_t length field
@@ -675,7 +691,7 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
                                 const char *name, char *elem)
 {
     return (Property) {
-        .info = parent_prop->arrayinfo,
+        .info = prop_array_info(parent_prop),
         .name = name,
         /*
          * This ugly piece of pointer arithmetic sets up the offset so
@@ -693,19 +709,21 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
  * underlying element's property release hook for each element and free the
  * property array.
  */
-static void release_prop_array(Object *obj, const char *name, void *opaque)
+void release_prop_array(Object *obj, const char *name, void *opaque)
 {
     const Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
     char *elem = *arrayptr;
     int i;
+    const PropertyInfo *elem_info = prop_array_info(prop);
+    int elem_size = prop_array_elem_size(prop);
 
-    if (prop->arrayinfo->release) {
+    if (elem_info->release) {
         for (i = 0; i < *alenptr; i++) {
             Property elem_prop = array_elem_prop(obj, prop, name, elem);
-            prop->arrayinfo->release(obj, NULL, &elem_prop);
-            elem += prop->arrayfieldsize;
+            elem_info->release(obj, NULL, &elem_prop);
+            elem += elem_size;
         }
     }
 
@@ -719,8 +737,8 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
  * (a pointer to which is stored in the additional field described by
  * prop->arrayoffset).
  */
-static void set_prop_array(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
+void set_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp)
 {
     ERRP_GUARD();
     const Property *prop = opaque;
@@ -728,6 +746,8 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
     void **arrayptr = (void *)obj + prop->arrayoffset;
     ArrayElementList *list, *elem, *next;
     const size_t size = sizeof(*list);
+    const PropertyInfo *elem_info = prop_array_info(prop);
+    int elem_size = prop_array_elem_size(prop);
     char *elemptr;
     bool ok = true;
 
@@ -746,9 +766,9 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
     while (elem) {
         Property elem_prop;
 
-        elem->value = g_malloc0(prop->arrayfieldsize);
+        elem->value = g_malloc0(elem_size);
         elem_prop = array_elem_prop(obj, prop, name, elem->value);
-        prop->arrayinfo->set(obj, v, NULL, &elem_prop, errp);
+        elem_info->set(obj, v, NULL, &elem_prop, errp);
         if (*errp) {
             ok = false;
             goto out_obj;
@@ -770,8 +790,8 @@ out_obj:
         for (elem = list; elem; elem = next) {
             Property elem_prop = array_elem_prop(obj, prop, name,
                                                  elem->value);
-            if (prop->arrayinfo->release) {
-                prop->arrayinfo->release(obj, NULL, &elem_prop);
+            if (elem_info->release) {
+                elem_info->release(obj, NULL, &elem_prop);
             }
             next = elem->next;
             g_free(elem->value);
@@ -784,19 +804,19 @@ out_obj:
      * Now that we know how big the array has to be, move the data over to a
      * linear array and free the temporary list.
      */
-    *arrayptr = g_malloc_n(*alenptr, prop->arrayfieldsize);
+    *arrayptr = g_malloc_n(*alenptr, elem_size);
     elemptr = *arrayptr;
     for (elem = list; elem; elem = next) {
-        memcpy(elemptr, elem->value, prop->arrayfieldsize);
-        elemptr += prop->arrayfieldsize;
+        memcpy(elemptr, elem->value, elem_size);
+        elemptr += elem_size;
         next = elem->next;
         g_free(elem->value);
         g_free(elem);
     }
 }
 
-static void get_prop_array(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
+void get_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp)
 {
     ERRP_GUARD();
     const Property *prop = opaque;
@@ -806,6 +826,8 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     ArrayElementList *list = NULL, *elem;
     ArrayElementList **tail = &list;
     const size_t size = sizeof(*list);
+    const PropertyInfo *elem_info = prop_array_info(prop);
+    int elem_size = prop_array_elem_size(prop);
     int i;
     bool ok;
 
@@ -813,7 +835,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     for (i = 0; i < *alenptr; i++) {
         elem = g_new0(ArrayElementList, 1);
         elem->value = elemptr;
-        elemptr += prop->arrayfieldsize;
+        elemptr += elem_size;
 
         *tail = elem;
         tail = &elem->next;
@@ -826,7 +848,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     elem = list;
     while (elem) {
         Property elem_prop = array_elem_prop(obj, prop, name, elem->value);
-        prop->arrayinfo->get(obj, v, NULL, &elem_prop, errp);
+        elem_info->get(obj, v, NULL, &elem_prop, errp);
         if (*errp) {
             goto out_obj;
         }
@@ -848,7 +870,7 @@ out_obj:
     }
 }
 
-static void default_prop_array(ObjectProperty *op, const Property *prop)
+void default_prop_array(ObjectProperty *op, const Property *prop)
 {
     object_property_set_default_list(op);
 }
@@ -861,6 +883,39 @@ const PropertyInfo qdev_prop_array = {
     .set_default_value = default_prop_array,
 };
 
+const PropertyInfo qdev_prop_uint8_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint8, uint8_t);
+const PropertyInfo qdev_prop_uint16_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint16, uint16_t);
+const PropertyInfo qdev_prop_uint32_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint32, uint32_t);
+const PropertyInfo qdev_prop_uint64_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint64, uint64_t);
+const PropertyInfo qdev_prop_string_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_string, char *);
+
+static ObjectProperty *create_link_list_property(ObjectClass *oc,
+                                                  const char *name,
+                                                  const Property *prop)
+{
+    g_autofree char *full_type = g_strdup_printf("link<%s>List",
+                                                 prop->link_type);
+
+    return object_class_property_add(oc, name, full_type,
+                                     get_prop_array, set_prop_array,
+                                     release_prop_array, (Property *)prop);
+}
+
+const PropertyInfo qdev_prop_link_list = {
+    .element_info = &qdev_prop_link,
+    .element_size = sizeof(void *),
+    .create = create_link_list_property,
+    .get = get_prop_array,
+    .set = set_prop_array,
+    .release = release_prop_array,
+    .set_default_value = default_prop_array,
+};
+
 /* --- public helpers --- */
 
 static const Property *qdev_prop_walk(DeviceClass *cls, const char *name)
@@ -1159,8 +1214,15 @@ const PropertyInfo qdev_prop_link = {
 
 static const QAPITypeInfo *qdev_prop_qapi_type(const Property *prop)
 {
-    /* this will be later extended to cope with QAPI array properties */
-    return prop->info->qapi_type;
+    if (prop->info->qapi_type) {
+        return prop->info->qapi_type;
+    }
+    if (prop->info->element_info) {
+        assert(prop->info->element_info->qapi_type);
+        assert(prop->info->element_info->qapi_type->list);
+        return prop->info->element_info->qapi_type->list;
+    }
+    return NULL;
 }
 
 void qdev_property_add_static(DeviceState *dev, const Property *prop)
-- 
2.55.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34D606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZPfiYit
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOufb-0003DU-38; Thu, 05 Nov 2026 05:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOuf7-0002tV-C8
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:25:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOuf3-0004AO-L8
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793874337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1eLTW+BeIuppTSYbW47mArP5MpKXOHXYwrHJZnASBqQ=;
 b=CZPfiYitU2+A4UswnBmGVbqvIVBWvYiVYz9sLrUpa6RMCs0KUdQSxT54css9HHKTWrLGO7
 3rAT4sa45R6198mTC5eNiHSn/eoQ0WDU+sKcWjcK9m0K2Kwyzf8+Zvz5+GMMfOWWGj2Gqs
 mhTVI5jLp3Amt+G3YpC4JgP4DKAOQNA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-L86ol1DwNyu3-FT8IenpYw-1; Thu,
 05 Nov 2026 05:25:34 -0500
X-MC-Unique: L86ol1DwNyu3-FT8IenpYw-1
X-Mimecast-MFC-AGG-ID: L86ol1DwNyu3-FT8IenpYw_1793874334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17F42195605A
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 10:25:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9141C195608B
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 10:25:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01A8721E692D; Thu, 05 Nov 2026 11:25:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 1/3] qdev: Convert array properties to QAPI-aware
 registration
Date: Thu,  5 Nov 2026 11:25:28 +0100
Message-ID: <20261105102530.1848823-2-armbru@redhat.com>
In-Reply-To: <20261105102530.1848823-1-armbru@redhat.com>
References: <20261105102530.1848823-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add element_info and element_size fields to PropertyInfo.

Add typed array PropertyInfo definitions. Each one knows its element
type at compile time through the new element_info and element_size
fields of PropertyInfo.

Update DEFINE_PROP_ARRAY() to use them instead of the generic
qdev_prop_array.

Use PropertyInfo fields element_info and element_size instead of
Property fields arrayinfo and arrayfieldsize.  Remove arrayinfo and
arrayfieldsize.

Infrastructure changes:
- Make get_prop_array, set_prop_array, release_prop_array, and
  default_prop_array non-static so they can be used by
  DEFINE_PROP_ARRAY_INFO in other translation units
- Add DEFINE_PROP_ARRAY_INFO macro in qdev-prop-internal.h

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-prop-internal.h             | 19 +++++++
 hw/display/apple-gfx.h                   |  1 +
 include/hw/core/qdev-properties-system.h |  2 +
 include/hw/core/qdev-properties.h        | 23 +++++----
 hw/core/qdev-properties-system.c         |  6 +++
 hw/core/qdev-properties.c                | 64 ++++++++++++++----------
 hw/display/apple-gfx.m                   |  6 +++
 7 files changed, 85 insertions(+), 36 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index d7b77844fe..4f89964c8f 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -25,4 +25,23 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp);
 
+void get_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp);
+void set_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp);
+void release_prop_array(Object *obj, const char *name, void *opaque);
+void default_prop_array(ObjectProperty *op, const Property *prop);
+
+#define DEFINE_PROP_ARRAY_INFO(_prop_info, _c_type, _type_info) \
+    {                                                           \
+        .type = "list",                                         \
+        .qapi_type = (_type_info),                              \
+        .element_info = &(_prop_info),                          \
+        .element_size = sizeof(_c_type),                        \
+        .get = get_prop_array,                                  \
+        .set = set_prop_array,                                  \
+        .release = release_prop_array,                          \
+        .set_default_value = default_prop_array,                \
+    }
+
 #endif
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 3197bd853d..652f158223 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -69,6 +69,7 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
                                        MemoryRegion **mapping_in_region);
 
 extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
+extern const PropertyInfo qdev_prop_apple_gfx_display_mode_array;
 
 #endif
 
diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
index 2cbea16d61..b20039ae55 100644
--- a/include/hw/core/qdev-properties-system.h
+++ b/include/hw/core/qdev-properties-system.h
@@ -23,6 +23,8 @@ extern const PropertyInfo qdev_prop_fdc_drive_type;
 extern const PropertyInfo qdev_prop_drive;
 extern const PropertyInfo qdev_prop_drive_iothread;
 extern const PropertyInfo qdev_prop_netdev;
+extern const PropertyInfo qdev_prop_netdev_array;
+extern const PropertyInfo qdev_prop_reserved_region_array;
 extern const PropertyInfo qdev_prop_pci_devfn;
 extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index a57291a5a1..36a448be20 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -23,9 +23,7 @@ struct Property {
         int64_t i;
         uint64_t u;
     } defval;
-    const PropertyInfo *arrayinfo;
     int          arrayoffset;
-    int          arrayfieldsize;
     uint8_t      bitnr;
     bool         set_default;
 };
@@ -34,6 +32,8 @@ struct PropertyInfo {
     const char *type;
     const char *description;
     const QAPITypeInfo *qapi_type;
+    const struct PropertyInfo *element_info;
+    size_t element_size;
     bool realized_set_allowed; /* allow setting property on realized device */
     char *(*print)(Object *obj, const Property *prop);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
@@ -73,8 +73,13 @@ extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_size32;
-extern const PropertyInfo qdev_prop_array;
+extern const PropertyInfo qdev_prop_uint8_array;
+extern const PropertyInfo qdev_prop_uint16_array;
+extern const PropertyInfo qdev_prop_uint32_array;
+extern const PropertyInfo qdev_prop_uint64_array;
+extern const PropertyInfo qdev_prop_string_array;
 extern const PropertyInfo qdev_prop_link;
+extern const PropertyInfo qdev_prop_link_array;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
         .name      = (_name),                                    \
@@ -141,7 +146,9 @@ extern const PropertyInfo qdev_prop_link;
  * @_field: uint32_t field in @_state to hold the array length
  * @_arrayfield: field in @_state (of type '@_arraytype *') which
  *               will point to the array
- * @_arrayprop: PropertyInfo defining what property the array elements have
+ * @_arrayprop: PropertyInfo for the array elements (e.g. qdev_prop_uint32);
+ *              a corresponding array PropertyInfo named @_arrayprop##_array
+ *              must exist
  * @_arraytype: C type of the array elements
  *
  * Define device properties for a variable-length array _name.  The array is
@@ -158,11 +165,9 @@ extern const PropertyInfo qdev_prop_link;
  */
 #define DEFINE_PROP_ARRAY(_name, _state, _field,                        \
                           _arrayfield, _arrayprop, _arraytype)          \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
+    DEFINE_PROP(_name, _state, _field, _arrayprop##_array, uint32_t,    \
                 .set_default = true,                                    \
                 .defval.u = 0,                                          \
-                .arrayinfo = &(_arrayprop),                             \
-                .arrayfieldsize = sizeof(_arraytype),                   \
                 .arrayoffset = offsetof(_state, _arrayfield))
 
 #define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
@@ -187,11 +192,9 @@ extern const PropertyInfo qdev_prop_link;
  */
 #define DEFINE_PROP_LINK_ARRAY(_name, _state, _field, _arrayfield,      \
                                _linktype, _arraytype)                   \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_link_array, uint32_t,  \
                 .set_default = true,                                    \
                 .defval.u = 0,                                          \
-                .arrayinfo = &qdev_prop_link,                           \
-                .arrayfieldsize = sizeof(_arraytype),                   \
                 .arrayoffset = offsetof(_state, _arrayfield),           \
                 .link_type = _linktype)
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 4d605c2056..923afa5cf3 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -489,6 +489,8 @@ const PropertyInfo qdev_prop_netdev = {
     .set   = set_netdev,
 };
 
+const PropertyInfo qdev_prop_netdev_array =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_netdev, NICPeers, &strList_type_info);
 
 /* --- audiodev --- */
 static void get_audiodev(Object *obj, Visitor *v, const char* name,
@@ -840,6 +842,10 @@ const PropertyInfo qdev_prop_reserved_region = {
     .set   = set_reserved_region,
 };
 
+const PropertyInfo qdev_prop_reserved_region_array =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_reserved_region, ReservedRegion,
+                           &strList_type_info);
+
 /* --- pci address --- */
 
 /*
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index e2ea894595..7152ba0d0a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -681,7 +681,7 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
                                 const char *name, char *elem)
 {
     return (Property) {
-        .info = parent_prop->arrayinfo,
+        .info = parent_prop->info->element_info,
         .name = name,
         /*
          * This ugly piece of pointer arithmetic sets up the offset so
@@ -699,19 +699,21 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
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
+    const PropertyInfo *elem_info = prop->info->element_info;
+    size_t elem_size = prop->info->element_size;
 
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
 
@@ -725,8 +727,8 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
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
@@ -734,6 +736,8 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
     void **arrayptr = (void *)obj + prop->arrayoffset;
     ArrayElementList *list, *elem, *next;
     const size_t size = sizeof(*list);
+    const PropertyInfo *elem_info = prop->info->element_info;
+    size_t elem_size = prop->info->element_size;
     char *elemptr;
     bool ok = true;
 
@@ -752,9 +756,9 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
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
@@ -776,8 +780,8 @@ out_obj:
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
@@ -790,19 +794,19 @@ out_obj:
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
@@ -812,6 +816,8 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     ArrayElementList *list = NULL, *elem;
     ArrayElementList **tail = &list;
     const size_t size = sizeof(*list);
+    const PropertyInfo *elem_info = prop->info->element_info;
+    size_t elem_size = prop->info->element_size;
     int i;
     bool ok;
 
@@ -819,7 +825,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     for (i = 0; i < *alenptr; i++) {
         elem = g_new0(ArrayElementList, 1);
         elem->value = elemptr;
-        elemptr += prop->arrayfieldsize;
+        elemptr += elem_size;
 
         *tail = elem;
         tail = &elem->next;
@@ -832,7 +838,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     elem = list;
     while (elem) {
         Property elem_prop = array_elem_prop(obj, prop, name, elem->value);
-        prop->arrayinfo->get(obj, v, NULL, &elem_prop, errp);
+        elem_info->get(obj, v, NULL, &elem_prop, errp);
         if (*errp) {
             goto out_obj;
         }
@@ -854,18 +860,24 @@ out_obj:
     }
 }
 
-static void default_prop_array(ObjectProperty *op, const Property *prop)
+void default_prop_array(ObjectProperty *op, const Property *prop)
 {
     object_property_set_default_list(op);
 }
 
-const PropertyInfo qdev_prop_array = {
-    .type = "list",
-    .get = get_prop_array,
-    .set = set_prop_array,
-    .release = release_prop_array,
-    .set_default_value = default_prop_array,
-};
+const PropertyInfo qdev_prop_uint8_array =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint8, uint8_t, &uint8List_type_info);
+const PropertyInfo qdev_prop_uint16_array =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint16, uint16_t, &uint16List_type_info);
+const PropertyInfo qdev_prop_uint32_array =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint32, uint32_t, &uint32List_type_info);
+const PropertyInfo qdev_prop_uint64_array =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_uint64, uint64_t, &uint64List_type_info);
+const PropertyInfo qdev_prop_string_array =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_string, char *, &strList_type_info);
+
+const PropertyInfo qdev_prop_link_array =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_link, void *, &strList_type_info);
 
 /* --- public helpers --- */
 
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 4db80f0b10..0e91a5adce 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -16,6 +16,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qapi/qapi-builtin-type-infos.h"
+#include "hw/core/qdev-prop-internal.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "qemu/aio-wait.h"
@@ -880,3 +881,8 @@ static void apple_gfx_set_display_mode(Object *obj, Visitor *v,
     .get   = apple_gfx_get_display_mode,
     .set   = apple_gfx_set_display_mode,
 };
+
+const PropertyInfo qdev_prop_apple_gfx_display_mode_array =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_apple_gfx_display_mode,
+                           AppleGFXDisplayMode,
+                           &strList_type_info);
-- 
2.55.0



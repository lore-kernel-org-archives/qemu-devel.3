Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6293CCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE8K-0000Ur-6q; Mon, 15 Jun 2026 16:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8I-0000M9-K4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8G-0003FA-6b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8WtDrdFUR6gHhtA1AsiQ6rqVgnAFi31Hz+IUc2WR7PA=;
 b=Quud0vqMH/8SjgGq490ynJtXtwD+YNlfj/j+FI7MvtMHb+hg4iC8VPDNWxE9yyzqIyus+6
 SSl6AByecJDuAm8/WtE9h9VHDYvxoU29/wH6sKNEl9AOLYeV40MaOHXHTJR0IJr/QM5qnF
 KTxjW0El5w2yu7AnL2maMz6ANT2Iyrc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261--oGBrSpWNpGIArSFrP0V4g-1; Mon,
 15 Jun 2026 16:42:03 -0400
X-MC-Unique: -oGBrSpWNpGIArSFrP0V4g-1
X-Mimecast-MFC-AGG-ID: -oGBrSpWNpGIArSFrP0V4g_1781556122
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2521E19560B7; Mon, 15 Jun 2026 20:42:02 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52E7019541B2; Mon, 15 Jun 2026 20:41:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:15 +0400
Subject: [PATCH v2 49/53] qdev: introduce typed array PropertyInfos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-49-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14525;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3/AgzK+h7ESeYZoIrVzUByl4EpxsZ83pmJfX++jxz0k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKQpXuSwpBKgaFW2dGzPGDxvZ5pl9dQuzYH8
 wvVLcweqjyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBikAAKCRDa6OEJdZac
 5et9D/9xUWL3HdQEc0LWzzNVFzUth7QhuJB1CcN/ChKGWCpe89OMR2XNehpRJZm3OcN4ZizvPpK
 rOVI7J8UnKxqSBa8UAmluUswP0h5VlU1v1OicI/ptifl5RSVDvSCC5/uTFUlb1MUM6m08dUeMoh
 cWWpkDH0LF1ZnWXtcPLeHQzNKMWeVaVDQjrUeiFLo//RRJJWUScK9lXa0mC2vhei77RWaTMvbrF
 IWIYg1ppr8zqCrZWYYdi21Jy8/YqiP6eCm73aYuC6nA5YeH/Y9wmzz66zOnmWVKXhsgX+MX2ezC
 BJmsRIKGjTR614XNPs+AEhjMLvEW6GyZwgVBpM4hM/Xc3BxnriUiX5MA3j6hn4T6ul8nDDY5RFD
 gYpiuxZyU9FK/TIBPHpH55zUNnnTFinSK4LSJpCSATmBCIOlA5VLulifqYhq/ZrPvJ34ZEB/fHG
 3aEZS5ceVNRI4pJz+p/yknNpbs1Nwko6Ajf0uDXRcbtquKAKGLQa3LrWJ3IdmNqFCBkm52dJ9yX
 Hg5SKVPo+iLcvGjCq9WggYaI9KzmQSD0e4+12xsK0UOLDBs1t1APsFKN+WNRijK7GqLLllVsNFc
 uQO0UFt8yQCwbUufcIGgD81GFlpS4zotcDyPJadQwWZ47HpDo0g1g+1CiJaEyj8y58LkJinqHIL
 yrs9MbqibZl/+jA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
---
 hw/core/qdev-prop-internal.h             |  18 ++++++
 include/hw/core/qdev-properties-system.h |   2 +
 include/hw/core/qdev-properties.h        |   8 +++
 hw/core/qdev-properties-system.c         |   5 ++
 hw/core/qdev-properties.c                | 103 ++++++++++++++++++++++++-------
 5 files changed, 115 insertions(+), 21 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index c190b7b88cf..b9d9812346d 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -27,4 +27,22 @@ void qdev_propinfo_get_int32(Object *obj, Visitor *v, const char *name,
 void qdev_propinfo_get_size32(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp);
 
+void get_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp);
+void set_prop_array(Object *obj, Visitor *v, const char *name,
+                    void *opaque, Error **errp);
+void release_prop_array(Object *obj, const char *name, void *opaque);
+void default_prop_array(ObjectProperty *op, const Property *prop);
+
+/* .qapi_type is derived from element_info->qapi_type->list by qdev_prop_qapi_type() */
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
index 2cbea16d615..819dce7d5e5 100644
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
index 1ea2ba66bb3..0c067170079 100644
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
index 12be7b80a59..81f37ec44b2 100644
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
index c2980c36afa..a9ca8e4a03d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -665,6 +665,22 @@ struct ArrayElementList {
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
@@ -674,7 +690,7 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
                                 const char *name, char *elem)
 {
     return (Property) {
-        .info = parent_prop->arrayinfo,
+        .info = prop_array_info(parent_prop),
         .name = name,
         /*
          * This ugly piece of pointer arithmetic sets up the offset so
@@ -692,19 +708,21 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
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
 
@@ -718,8 +736,8 @@ static void release_prop_array(Object *obj, const char *name, void *opaque)
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
@@ -727,6 +745,8 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
     void **arrayptr = (void *)obj + prop->arrayoffset;
     ArrayElementList *list, *elem, *next;
     const size_t size = sizeof(*list);
+    const PropertyInfo *elem_info = prop_array_info(prop);
+    int elem_size = prop_array_elem_size(prop);
     char *elemptr;
     bool ok = true;
 
@@ -745,9 +765,9 @@ static void set_prop_array(Object *obj, Visitor *v, const char *name,
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
@@ -769,8 +789,8 @@ out_obj:
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
@@ -783,19 +803,19 @@ out_obj:
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
@@ -805,6 +825,8 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     ArrayElementList *list = NULL, *elem;
     ArrayElementList **tail = &list;
     const size_t size = sizeof(*list);
+    const PropertyInfo *elem_info = prop_array_info(prop);
+    int elem_size = prop_array_elem_size(prop);
     int i;
     bool ok;
 
@@ -812,7 +834,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     for (i = 0; i < *alenptr; i++) {
         elem = g_new0(ArrayElementList, 1);
         elem->value = elemptr;
-        elemptr += prop->arrayfieldsize;
+        elemptr += elem_size;
 
         *tail = elem;
         tail = &elem->next;
@@ -825,7 +847,7 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     elem = list;
     while (elem) {
         Property elem_prop = array_elem_prop(obj, prop, name, elem->value);
-        prop->arrayinfo->get(obj, v, NULL, &elem_prop, errp);
+        elem_info->get(obj, v, NULL, &elem_prop, errp);
         if (*errp) {
             goto out_obj;
         }
@@ -847,7 +869,7 @@ out_obj:
     }
 }
 
-static void default_prop_array(ObjectProperty *op, const Property *prop)
+void default_prop_array(ObjectProperty *op, const Property *prop)
 {
     object_property_set_default_list(op);
 }
@@ -860,6 +882,38 @@ const PropertyInfo qdev_prop_array = {
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
+    g_autofree char *full_type = g_strdup_printf("link<%s>List", prop->link_type);
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
@@ -1158,8 +1212,15 @@ const PropertyInfo qdev_prop_link = {
 
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
2.54.0



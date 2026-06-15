Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7800BCD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE8U-0001Iy-6Y; Mon, 15 Jun 2026 16:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8S-0001CT-AR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE8Q-0003HG-F7
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilsylrs01yNLIo+fywZHDpLolI7Hfnqi73bGfbNipbQ=;
 b=AXIiEmoT1+iMOq1WmZgdGywQphHIv9fyRIVhSJcfpX5iA1xiJNwcLWS/I0dNdEZFORrViD
 3ZWkxf/RqCHSFr+pbh9gpfxgeg9emGgvTgs6qyUiXsHHcZyToWmUSKHOkGgHppCM0scZrM
 B6wlnptFu0c+neOnZXjyzMKcnfvpkks=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-n2NlV0--M5OYbkybH27wpg-1; Mon,
 15 Jun 2026 16:42:14 -0400
X-MC-Unique: n2NlV0--M5OYbkybH27wpg-1
X-Mimecast-MFC-AGG-ID: n2NlV0--M5OYbkybH27wpg_1781556133
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10614180064B; Mon, 15 Jun 2026 20:42:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4EC53008B37; Mon, 15 Jun 2026 20:42:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:38:17 +0400
Subject: [PATCH v2 51/53] qdev: remove deprecated PropertyInfo.type and
 .enum_table fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-51-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5580;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hZy2Pabp/CPjyH6vbOTPzfXaX5flh/lxJzHVmVPyE08=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKQSnxwHIOtsP4U0/6wcMpoOVKfwMpClgnQm
 TwqWlPfAUqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBikAAKCRDa6OEJdZac
 5TfXD/9bA8d6pprxPDcZrehm//j7jmh+Fc8l7kMe2LKmw6+UJoIN9O6Q6g6sI49GUU96nxF0dvk
 V9KtDKAEhjeK0MIMC2fQ8L3ZrbDpq1Z4SUuLgoQ4W86Tt0CPo/eFgXdVOZ+Fih110pbWq9MMM6Q
 uIWGIRrYYTlxA/sip7Kxl+8oUiFQ8WkmvAYaU3WhNHaxWGwiVv1YMSZr5VT0oVVfb5TBswo9/1N
 ad19dpOFuhNl9YKcuqcoRc/DxmWifJq/nC8LT/6Iw65rUk5OnPQH5BPrm4dEOJuljnK06EgxZK5
 fay+xKXnCP5y69o3BVrlU+v9AoMY3YTqZ8Uv67OuZ42tiY7etTItLvx3chCqCcIPBFpmrFoFjAO
 9HBm5rvKUTGAyn2YM4lNw7+iAzovzbqZCNXjzDMSiDEt3HnH/aDVqFVI+fg8/bzQDsD/GhvtMnX
 CYkme0FJfVADZy2PPCoIcn/z5rYwYabuB7VGkhOeJ5VLd0KBoAhYjkd3bZceYBL7YryIvfDtfRf
 pyrevmLXmuMm9VSS1qmPng/VwbmRUTGQXMUCEfIvy9bnJUyQ2DHfK+DrAA0PitP5fXQw4wnUGJi
 vjTNnJDuNJ4l+7kimdTj38PqXyOQ5jSejvx28vAPqxtZOsFNMjpHE7T2sol2pZiRJq7USGNhMqY
 eGqir4Dfof/3DYg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Now that all PropertyInfo definitions use .qapi_type, remove the
legacy .type (string) and .enum_table fields from PropertyInfo, and
the .arrayinfo/.arrayfieldsize fields from Property.

Remove fallback branches in qdev_property_add_static() and
qdev_class_add_property() that used object_property_add() with
prop->info->type: these always use the QAPI-aware registration
path now. Simplify qdev_propinfo_enum_lookup(), prop_array_info()
and prop_array_elem_size() to use the new fields directly.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/core/qdev-properties.h |  4 ---
 hw/core/qdev-properties.c         | 58 ++++++++++++---------------------------
 2 files changed, 17 insertions(+), 45 deletions(-)

diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 39f95ce7a3c..2267e734d1f 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -23,17 +23,13 @@ struct Property {
         int64_t i;
         uint64_t u;
     } defval;
-    const PropertyInfo *arrayinfo;
     int          arrayoffset;
-    int          arrayfieldsize;
     uint8_t      bitnr;
     bool         set_default;
 };
 
 struct PropertyInfo {
-    const char *type;
     const char *description;
-    const QEnumLookup *enum_table;
     const QAPITypeInfo *qapi_type;
     const struct PropertyInfo *element_info;
     int element_size;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index b5a9eb97e7d..585982f60f5 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -103,11 +103,8 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
 
 const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
 {
-    if (info->qapi_type) {
-        assert(info->qapi_type->lookup);
-        return info->qapi_type->lookup;
-    }
-    return info->enum_table;
+    assert(info->qapi_type->lookup);
+    return info->qapi_type->lookup;
 }
 
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
@@ -667,18 +664,12 @@ struct ArrayElementList {
 
 static const PropertyInfo *prop_array_info(const Property *prop)
 {
-    if (prop->info->element_info) {
-        return prop->info->element_info;
-    }
-    return prop->arrayinfo;
+    return prop->info->element_info;
 }
 
 static int prop_array_elem_size(const Property *prop)
 {
-    if (prop->info->element_size) {
-        return prop->info->element_size;
-    }
-    return prop->arrayfieldsize;
+    return prop->info->element_size;
 }
 
 /*
@@ -1222,20 +1213,13 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
     const QAPITypeInfo *qapi_type = qdev_prop_qapi_type(prop);
 
     assert(!prop->info->create);
+    assert(qapi_type);
 
-    if (qapi_type) {
-        op = object_property_add_qapi(obj, prop->name, qapi_type,
-                                      field_prop_getter(prop->info),
-                                      field_prop_setter(prop->info),
-                                      prop->info->release,
-                                      (Property *)prop);
-    } else {
-        op = object_property_add(obj, prop->name, prop->info->type,
-                                 field_prop_getter(prop->info),
-                                 field_prop_setter(prop->info),
-                                 prop->info->release,
-                                 (Property *)prop);
-    }
+    op = object_property_add_qapi(obj, prop->name, qapi_type,
+                                  field_prop_getter(prop->info),
+                                  field_prop_setter(prop->info),
+                                  prop->info->release,
+                                  (Property *)prop);
 
     object_property_set_description(obj, prop->name,
                                     prop->info->description);
@@ -1259,21 +1243,13 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
     } else {
         const QAPITypeInfo *qapi_type = qdev_prop_qapi_type(prop);
 
-        if (qapi_type) {
-            op = object_class_property_add_qapi(oc,
-                                               name, qapi_type,
-                                               field_prop_getter(prop->info),
-                                               field_prop_setter(prop->info),
-                                               prop->info->release,
-                                               (Property *)prop);
-        } else {
-            op = object_class_property_add(oc,
-                                           name, prop->info->type,
-                                           field_prop_getter(prop->info),
-                                           field_prop_setter(prop->info),
-                                           prop->info->release,
-                                           (Property *)prop);
-        }
+        assert(qapi_type);
+        op = object_class_property_add_qapi(oc,
+                                            name, qapi_type,
+                                            field_prop_getter(prop->info),
+                                            field_prop_setter(prop->info),
+                                            prop->info->release,
+                                            (Property *)prop);
     }
     if (prop->set_default) {
         prop->info->set_default_value(op, prop);

-- 
2.54.0



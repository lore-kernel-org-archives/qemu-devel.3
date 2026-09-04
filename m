Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8D3C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a7t-0006cZ-Me; Fri, 04 Sep 2026 16:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a7U-00061r-QU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a7S-0000DP-19
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tH/IVOUnn1QB2ho+AwTZr7qddaicqiut7xSXNWVfk8U=;
 b=F8TtXVnhaTRpVN0e6TtMMMaBhpnlojSKKTvcws1PEhHndCOEzUo/cIohribRF34ayPT6NT
 71K2DY/Ms7Clm1alt4Do9hleHVtgBC+7rVx8C0RxG6f9bH/s+BYRtC3ge5IQrGMu84zgns
 h+hi4oC7bqOZe2MEkjdgzzB9PPYA00U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-UHVf062TPJuNIIQRh2mAag-1; Fri,
 04 Sep 2026 16:02:32 -0400
X-MC-Unique: UHVf062TPJuNIIQRh2mAag-1
X-Mimecast-MFC-AGG-ID: UHVf062TPJuNIIQRh2mAag_1788552151
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C160A18E9B1F; Fri,  4 Sep 2026 20:02:31 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3C9818005B5; Fri,  4 Sep 2026 20:02:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:53 +0400
Subject: [PATCH v4 70/75] qdev: remove deprecated PropertyInfo.type and
 .enum_table fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-70-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5602;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sOu4pogNVK6NpFHufCV3RH9LgNGQmgLKUI48lJjnLyQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLMr+EwLnOJjiAHSzm4lrIYnyqlBb9/L0Vnl
 tTWOT6TUeWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsizAAKCRDa6OEJdZac
 5cG4EACJzsHtimlbtQRn+yJERxc8B29iQRQA+DemmUH97j9WKahTa3/LgQ2qdb63f4IPycdrA1R
 TjIW+ucVRpWzfW112IWvFTnRGnA8uPu2tDyqdbdwUNj+Isv7L0z3yRWHbZqF0Ta4pXhxd7Gqaih
 kuvOkTM4K1cugEbMDVNl1TcYDU+WgPk3zscyiMAEBh/I50Lp1PK6kr7nf6ILF/hsIC2eWlx44Zd
 QpXihtxgutdKA/2JTCjiwXyZ5TqTueFlQdzRerwmCSD2AI8I8SfHCpFgvr//R01ePEQsMT+INmd
 HNXDNAdxdlaTV2i3J8rvHL15zfCMKOpBfryU5TY7/GPeyGnIcMoorjEONPS3J1/yFPWb1gZXgyf
 2FhgL/Hpt7yoNUfkxifZgJ0pvCoxpp+o/Ejksy7LiiyX3GErhi4DMDigdzpYtHf5gne4Mky34Ao
 8oOGlCA9WRRhERWxxSZ10vgRLm45EuQynnZBWGN+EGytF1P5ErwLwD8Wqdih9NBfGcFdbZrnOoh
 w0qSXgTCDoqeFht1+Bbkt0125W9GVkfbf0EzG2Yk4X55Qeoq1WbCRY5DaSOd7Aw6MjnZnL0zrLl
 cxQHER3VrOoxmDk/3GUbFszJE5w92d40MfBG1wEgGjm7gYaN5ESDwwmcV+tacB1ZVW8ycXtjF0t
 LgAqxesiJ8TixDw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
 hw/core/qdev-properties.c         | 58 ++++++++++++---------------------------
 include/hw/core/qdev-properties.h |  4 ---
 2 files changed, 17 insertions(+), 45 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index b5a9eb97e7dd..585982f60f5a 100644
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
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 39f95ce7a3c6..2267e734d1fd 100644
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

-- 
2.55.0.543.g5ebe2ebe4ea8



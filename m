Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EA606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YMgRhlT5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc25-0000ci-2V; Sun, 01 Nov 2026 15:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzr-00051k-5N
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzg-0007DC-1C
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZpiKhqNzVyATfqxqIeSxPHElC8txIX3dvwQKhHu1Ws=;
 b=YMgRhlT51GdzZziF1sTg261AVNJ8+4VPHzRut//bMSH84wKkYXRXSlZCAOb2AsaE1tdVak
 D5Da068fLMZdQkTzLUd7HZBv8QfLaj6MIicO5f6TOkSl4mZtUjNPpWSbzRC7VPv5y9ih4Q
 jm2rtfvwflc05Nffxuju8nhPFtt0ABQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-1o_eFy5HM9Wbwh6seFBC9A-1; Sun,
 01 Nov 2026 15:17:30 -0500
X-MC-Unique: 1o_eFy5HM9Wbwh6seFBC9A-1
X-Mimecast-MFC-AGG-ID: 1o_eFy5HM9Wbwh6seFBC9A_1793564249
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FC9718005B9
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4F4E18004D2
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 71F0321E683C; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 46/56] qdev: add qapi_type field to PropertyInfo with
 fallback registration
Date: Sun,  1 Nov 2026 21:17:07 +0100
Message-ID: <20261101201717.3911097-47-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a qapi_type field to PropertyInfo to prepare for the transition
from string-based type metadata to QAPI type-info.

Update qdev_property_add_static() and qdev_class_add_property() to
pass qapi_type instead of NULL to object_property_add() and
object_class_property_add().

Update the shared enum accessor functions to prefer .qapi_type->lookup
over .enum_table via a new qdev_propinfo_enum_lookup() helper.

No PropertyInfo definitions are changed, all .qapi_type fields default
to NULL, so this patch is no-op for now.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/core/qdev-properties.h |  1 +
 hw/core/qdev-properties.c         | 26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index eba5436e53..1ea2ba66bb 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -34,6 +34,7 @@ struct PropertyInfo {
     const char *type;
     const char *description;
     const QEnumLookup *enum_table;
+    const QAPITypeInfo *qapi_type;
     bool realized_set_allowed; /* allow setting property on realized device */
     char *(*print)(Object *obj, const Property *prop);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 61dca80c95..71580c04e4 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -99,13 +99,22 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
     return info->set ? field_prop_set : NULL;
 }
 
+static const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
+{
+    if (info->qapi_type) {
+        assert(info->qapi_type->lookup);
+        return info->qapi_type->lookup;
+    }
+    return info->enum_table;
+}
+
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
+    visit_type_enum(v, name, ptr, qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
@@ -114,14 +123,15 @@ void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
     const Property *prop = opaque;
     int *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
+    visit_type_enum(v, name, ptr, qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 void qdev_propinfo_set_default_value_enum(ObjectProperty *op,
                                           const Property *prop)
 {
     object_property_set_default_str(op,
-        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
+        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info),
+                         prop->defval.i));
 }
 
 /* Bit */
@@ -941,8 +951,8 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
 
     prop = qdev_prop_find(dev, name);
     object_property_set_str(OBJECT(dev), name,
-                            qapi_enum_lookup(prop->info->enum_table, value),
-                            &error_abort);
+        qapi_enum_lookup(qdev_propinfo_enum_lookup(prop->info), value),
+        &error_abort);
 }
 
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
@@ -1150,7 +1160,8 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
 
     assert(!prop->info->create);
 
-    op = object_property_add(obj, prop->name, prop->info->type, NULL,
+    op = object_property_add(obj, prop->name, prop->info->type,
+                             prop->info->qapi_type,
                              field_prop_getter(prop->info),
                              field_prop_setter(prop->info),
                              prop->info->release,
@@ -1176,7 +1187,8 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
     if (prop->info->create) {
         op = prop->info->create(oc, name, prop);
     } else {
-        op = object_class_property_add(oc, name, prop->info->type, NULL,
+        op = object_class_property_add(oc, name, prop->info->type,
+                                       prop->info->qapi_type,
                                        field_prop_getter(prop->info),
                                        field_prop_setter(prop->info),
                                        prop->info->release,
-- 
2.55.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE00606A5B0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YjQoU9j6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDo-0003WK-Fv; Mon, 02 Nov 2026 09:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDM-0003Hq-D3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDB-0008VC-Lc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QvzSIEH1srLwW53dLgFhqYUSaCf7VH0jrbE9wvfxGU0=;
 b=YjQoU9j6/hYj/I8913rKOhvTT0nyBzQSKQUjGFgWL+ciSPKLhxY8uEY8xGBpDRAc06Ex1c
 5Lq7qN6iot//lHBYV5GwYx+UWs66WlIJ7xvVpV5c9h6gPj6HkYQOMthHO2ecs/bS0pdXrW
 W8q3vHg73VJtI6Niz6FzCupSLaTFOoE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-XCfqmgJ_OZOHVtQDFZxidA-1; Mon,
 02 Nov 2026 09:40:34 -0500
X-MC-Unique: XCfqmgJ_OZOHVtQDFZxidA-1
X-Mimecast-MFC-AGG-ID: XCfqmgJ_OZOHVtQDFZxidA_1793630433
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6763719541AA; Mon,  2 Nov 2026 14:40:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3ED91956087; Mon,  2 Nov 2026 14:40:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0989C21E662D; Mon, 02 Nov 2026 15:40:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 64/74] qdev: convert core PropertyInfo definitions to use
 qapi_type
Date: Mon,  2 Nov 2026 15:40:08 +0100
Message-ID: <20261102144018.3212223-65-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a .qapi_type pointer on all core PropertyInfo definitions in
qdev-properties.c. Remove .enum_table from enum definitions, since the
lookup is now accessed through .qapi_type->lookup via the
qdev_propinfo_enum_lookup() fallback helper.

It's strange to use type &size_type_info for both u32 (prop_size32)
and u64 (prop_size).

Link property are actually strings. The "full type name" is set when
the property is added, as "link<TYPE>".

Array properties are left for later.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-48-armbru@redhat.com>
---
 hw/core/qdev-properties.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 71580c04e4..f891fc78ae 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -12,6 +12,8 @@
 #include "qdev-prop-internal.h"
 #include "qom/compat-properties.h"
 #include "qom/qom-qobject.h"
+#include "qapi/qapi-builtin-type-infos.h"
+#include "qapi/qapi-type-infos-common.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -182,6 +184,7 @@ static void set_default_value_bool(ObjectProperty *op, const Property *prop)
 
 const PropertyInfo qdev_prop_bit = {
     .type  = "bool",
+    .qapi_type = &bool_type_info,
     .description = "on/off",
     .get   = prop_get_bit,
     .set   = prop_set_bit,
@@ -232,6 +235,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_bit64 = {
     .type  = "bool",
+    .qapi_type = &bool_type_info,
     .description = "on/off",
     .get   = prop_get_bit64,
     .set   = prop_set_bit64,
@@ -294,8 +298,8 @@ static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
 
 const PropertyInfo qdev_prop_on_off_auto_bit64 = {
     .type = "OnOffAuto",
+    .qapi_type = &OnOffAuto_type_info,
     .description = "on/off/auto",
-    .enum_table = &OnOffAuto_lookup,
     .get = prop_get_on_off_auto_bit64,
     .set = prop_set_on_off_auto_bit64,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -323,6 +327,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_bool = {
     .type  = "bool",
+    .qapi_type = &bool_type_info,
     .description = "on/off",
     .get   = get_bool,
     .set   = set_bool,
@@ -363,6 +368,7 @@ void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
 
 const PropertyInfo qdev_prop_uint8 = {
     .type  = "uint8",
+    .qapi_type = &uint8_type_info,
     .get   = get_uint8,
     .set   = set_uint8,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -390,6 +396,7 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_uint16 = {
     .type  = "uint16",
+    .qapi_type = &uint16_type_info,
     .get   = get_uint16,
     .set   = set_uint16,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -435,6 +442,7 @@ static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_uint32 = {
     .type  = "uint32",
+    .qapi_type = &uint32_type_info,
     .get   = get_uint32,
     .set   = set_uint32,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -442,6 +450,7 @@ const PropertyInfo qdev_prop_uint32 = {
 
 const PropertyInfo qdev_prop_int32 = {
     .type  = "int32",
+    .qapi_type = &int32_type_info,
     .get   = qdev_propinfo_get_int32,
     .set   = set_int32,
     .set_default_value = qdev_propinfo_set_default_value_int,
@@ -487,6 +496,7 @@ static void set_int64(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_uint64 = {
     .type  = "uint64",
+    .qapi_type = &uint64_type_info,
     .get   = get_uint64,
     .set   = set_uint64,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -494,6 +504,7 @@ const PropertyInfo qdev_prop_uint64 = {
 
 const PropertyInfo qdev_prop_int64 = {
     .type  = "int64",
+    .qapi_type = &int64_type_info,
     .get   = get_int64,
     .set   = set_int64,
     .set_default_value = qdev_propinfo_set_default_value_int,
@@ -516,6 +527,7 @@ static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_uint64_checkmask = {
     .type  = "uint64",
+    .qapi_type = &uint64_type_info,
     .get   = get_uint64,
     .set   = set_uint64_checkmask,
 };
@@ -552,6 +564,11 @@ static void set_usize(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_usize = {
     .type  = "usize",
+#if HOST_LONG_BITS == 32
+    .qapi_type = &uint32_type_info,
+#else
+    .qapi_type = &uint64_type_info,
+#endif
     .get   = get_usize,
     .set   = set_usize,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -596,6 +613,7 @@ static void set_string(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_string = {
     .type  = "str",
+    .qapi_type = &str_type_info,
     .release = release_string,
     .get   = get_string,
     .set   = set_string,
@@ -605,8 +623,8 @@ const PropertyInfo qdev_prop_string = {
 
 const PropertyInfo qdev_prop_on_off_auto = {
     .type = "OnOffAuto",
+    .qapi_type = &OnOffAuto_type_info,
     .description = "on/off/auto",
-    .enum_table = &OnOffAuto_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -648,6 +666,7 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_size32 = {
     .type  = "size",
+    .qapi_type = &size_type_info,
     .get = qdev_propinfo_get_size32,
     .set = set_size32,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -1061,6 +1080,7 @@ static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_size = {
     .type  = "size",
+    .qapi_type = &size_type_info,
     .get = get_size,
     .set = set_size,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -1143,6 +1163,7 @@ static void set_link(Object *obj, Visitor *v, const char *name, void *opaque,
 
 const PropertyInfo qdev_prop_link = {
     .type = "link",
+    .qapi_type = &str_type_info,
     .create = create_link_property,
     /*
      * Since we have a create method, the get and set are used
-- 
2.55.0



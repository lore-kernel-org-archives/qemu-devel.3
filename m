Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1202C79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a6x-0002z6-5v; Fri, 04 Sep 2026 16:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6u-0002bN-5d
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a6r-00006U-UZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yIwJWaK8tsYw5DkqRZdnqVq9NraRNdS/e77Jdg6JGkY=;
 b=dPhcRL6RRd2CJJqrPFg9kezi2Onk5Bk3hX0ULuC291sLSXFca7LXKL5ynkNgve7XPdfEuV
 SiIx3wQI1zgILOJqyv4LB/oANX62EMZ5OnnH8pGr2PeI03OY+nS/6N6qWZnrAeKCZF3i0q
 YaCw/CC7QSJxHtOyo07jUfReMwrjNys=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-oG_2gKlxOgSM1344dDVQrQ-1; Fri,
 04 Sep 2026 16:01:57 -0400
X-MC-Unique: oG_2gKlxOgSM1344dDVQrQ-1
X-Mimecast-MFC-AGG-ID: oG_2gKlxOgSM1344dDVQrQ_1788552116
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C9121893EC1; Fri,  4 Sep 2026 20:01:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0B0E1800765; Fri,  4 Sep 2026 20:01:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:44 +0400
Subject: [PATCH v4 61/75] qdev: convert core PropertyInfo definitions to
 use qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-61-a985f168e938@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6905;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uKd4YrvBJdVeN8+KEVzpNUXVhpVCSGsiMFoSt6/JX4Q=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqbIsuh7Ju5muX9ldCS5SZAMeY/5SkkNa6XnOG7nu1RgZbmk
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqmyLLAAoJENro4Ql1lpzl5oQQAK3h
 KG2kTBvHbhD3c/kvJW9tW1X9icv8U/hGXXMrAYfYOYTZP7xWrOgz3g3jTfGBL4FnazNQsyz8nSN
 WGetZgMrzcgxELrHpO4+cUj1qw5VJeGSlOeeHbqxr4Yo0OPgy56kmOK+/PGbyVYV3BF2GSRSqEa
 29Or8hK7HAWSyLgWzKs2GURQda1EzwRCNDkJUYTEkFlMVLq0SikTH3Op214g5FyInY5XxCWQA7z
 IrxP4v8oVxdZh8D2dZ5FIcMinF594dDJVwYFctuhWo0yMhry83aUQzYOTN+/uTYnqZq3KssfpAI
 Ucc1ZlFy9ALGziZcM0pwDsp5dAcgI0wvT1gfNW+Ncs+CE42iODCy4RZD933YzX5o4JgnpkWI0pr
 tGtZXmatDjgl/9tt76GJfaFr1B8tcsGClJ9i2TSeNpiHqjjo5VJsktGpgtjNuP6ybIPxmBFoOzk
 hFFuaKOjEyGxllDaSFGv8WpHGwLWKC2AAK6J4iXc8k6Tg9MHPi4Wk4mQwAHeOV5eZBUubT4Sph3
 AynZrRGGjR6haTtAxFPZMrhzreduT9OhTrvSOVY9XCp836TFgYg2S8NJad4iVdx33ajfZR+ykwA
 EXu/SvXH5sVf7iaLVhD/wSP+dBUSCUamWcCOrKYDengxB72Q1NARln3PG9lolv/xhG5umxtNuzP
 +daTy
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Replace .type string with .qapi_type pointer on all core PropertyInfo
definitions in qdev-properties.c. Remove .enum_table from enum
definitions, since the lookup is now accessed through .qapi_type->lookup
via the qdev_propinfo_enum_lookup() fallback helper.

Note that qdev_prop_usize now reports "uint32" or "uint64" depending on
the host. If usize is worth preserving, it should be added as a QAPI
builtin type. Or perhaps we should simply use "size" everywhere (u64)?

It's also strange to use type "size" for both u32 (prop_size32) and u64
(prop_size).

Link property are actually strings. The "full type name" is set when
the property is added, as "link<TYPE>".

Array property will be refactored in a subsequent patch.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index b3d5abd5053c..e924b040687b 100644
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
@@ -180,7 +182,7 @@ static void set_default_value_bool(ObjectProperty *op, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_bit = {
-    .type  = "bool",
+    .qapi_type = &bool_type_info,
     .description = "on/off",
     .get   = prop_get_bit,
     .set   = prop_set_bit,
@@ -230,7 +232,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_bit64 = {
-    .type  = "bool",
+    .qapi_type = &bool_type_info,
     .description = "on/off",
     .get   = prop_get_bit64,
     .set   = prop_set_bit64,
@@ -292,9 +294,8 @@ static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
 }
 
 const PropertyInfo qdev_prop_on_off_auto_bit64 = {
-    .type = "OnOffAuto",
+    .qapi_type = &OnOffAuto_type_info,
     .description = "on/off/auto",
-    .enum_table = &OnOffAuto_lookup,
     .get = prop_get_on_off_auto_bit64,
     .set = prop_set_on_off_auto_bit64,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -321,7 +322,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_bool = {
-    .type  = "bool",
+    .qapi_type = &bool_type_info,
     .description = "on/off",
     .get   = get_bool,
     .set   = set_bool,
@@ -361,7 +362,7 @@ void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
 }
 
 const PropertyInfo qdev_prop_uint8 = {
-    .type  = "uint8",
+    .qapi_type = &uint8_type_info,
     .get   = get_uint8,
     .set   = set_uint8,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -388,7 +389,7 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_uint16 = {
-    .type  = "uint16",
+    .qapi_type = &uint16_type_info,
     .get   = get_uint16,
     .set   = set_uint16,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -433,14 +434,14 @@ static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_uint32 = {
-    .type  = "uint32",
+    .qapi_type = &uint32_type_info,
     .get   = get_uint32,
     .set   = set_uint32,
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 const PropertyInfo qdev_prop_int32 = {
-    .type  = "int32",
+    .qapi_type = &int32_type_info,
     .get   = qdev_propinfo_get_int32,
     .set   = set_int32,
     .set_default_value = qdev_propinfo_set_default_value_int,
@@ -485,14 +486,14 @@ static void set_int64(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_uint64 = {
-    .type  = "uint64",
+    .qapi_type = &uint64_type_info,
     .get   = get_uint64,
     .set   = set_uint64,
     .set_default_value = qdev_propinfo_set_default_value_uint,
 };
 
 const PropertyInfo qdev_prop_int64 = {
-    .type  = "int64",
+    .qapi_type = &int64_type_info,
     .get   = get_int64,
     .set   = set_int64,
     .set_default_value = qdev_propinfo_set_default_value_int,
@@ -514,7 +515,7 @@ static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_uint64_checkmask = {
-    .type  = "uint64",
+    .qapi_type = &uint64_type_info,
     .get   = get_uint64,
     .set   = set_uint64_checkmask,
 };
@@ -550,7 +551,11 @@ static void set_usize(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_usize = {
-    .type  = "usize",
+#if HOST_LONG_BITS == 32
+    .qapi_type = &uint32_type_info,
+#else
+    .qapi_type = &uint64_type_info,
+#endif
     .get   = get_usize,
     .set   = set_usize,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -594,7 +599,7 @@ static void set_string(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_string = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .release = release_string,
     .get   = get_string,
     .set   = set_string,
@@ -603,9 +608,8 @@ const PropertyInfo qdev_prop_string = {
 /* --- on/off/auto --- */
 
 const PropertyInfo qdev_prop_on_off_auto = {
-    .type = "OnOffAuto",
+    .qapi_type = &OnOffAuto_type_info,
     .description = "on/off/auto",
-    .enum_table = &OnOffAuto_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -646,7 +650,7 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_size32 = {
-    .type  = "size",
+    .qapi_type = &size_type_info,
     .get = qdev_propinfo_get_size32,
     .set = set_size32,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -1059,7 +1063,7 @@ static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_size = {
-    .type  = "size",
+    .qapi_type = &size_type_info,
     .get = get_size,
     .set = set_size,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -1141,7 +1145,7 @@ static void set_link(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_link = {
-    .type = "link",
+    .qapi_type = &str_type_info,
     .create = create_link_property,
     /*
      * Since we have a create method, the get and set are used

-- 
2.55.0.543.g5ebe2ebe4ea8



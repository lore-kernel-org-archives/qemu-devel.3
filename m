Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46600CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoEU-00030y-UA; Mon, 19 Oct 2026 10:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDP-0002Ev-6e
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDJ-0005ar-7Y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRQ7uxi+jjdY4N8M+T+YsWsLWHLIjQRtm/nIN7FHw3I=;
 b=apJo/RP7+TkyFHPDuiIzovxzwCZuQP58ZGV0jK9M+paq309Sv6zY35W3VxaKycnr9iFmWW
 cIRqQkCh41eb7NrcKOZPJgQmC02YZ6ghvbY3IyjGP3utzvaG9yvoN8AkJJeG4u2ASTi+W3
 1P0aScEyq+yFmO+tRt0xgT2uhjPrdkY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-xy31gDh4ODSmkj8tT7vnOw-1; Mon,
 19 Oct 2026 14:19:42 +0000
X-MC-Unique: xy31gDh4ODSmkj8tT7vnOw-1
X-Mimecast-MFC-AGG-ID: xy31gDh4ODSmkj8tT7vnOw_1792419581
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86C24180065E; Mon, 19 Oct 2026 14:19:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F27CD1803A51; Mon, 19 Oct 2026 14:19:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7214121E66D6; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 53/65] qdev: convert core PropertyInfo definitions to use
 qapi_type
Date: Mon, 19 Oct 2026 16:19:17 +0200
Message-ID: <20261019141929.1594337-54-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties.c | 42 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ee50fbb9f5..abdb380cb9 100644
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
@@ -181,7 +183,7 @@ static void set_default_value_bool(ObjectProperty *op, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_bit = {
-    .type  = "bool",
+    .qapi_type = &bool_type_info,
     .description = "on/off",
     .get   = prop_get_bit,
     .set   = prop_set_bit,
@@ -231,7 +233,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_bit64 = {
-    .type  = "bool",
+    .qapi_type = &bool_type_info,
     .description = "on/off",
     .get   = prop_get_bit64,
     .set   = prop_set_bit64,
@@ -293,9 +295,8 @@ static void prop_set_on_off_auto_bit64(Object *obj, Visitor *v,
 }
 
 const PropertyInfo qdev_prop_on_off_auto_bit64 = {
-    .type = "OnOffAuto",
+    .qapi_type = &OnOffAuto_type_info,
     .description = "on/off/auto",
-    .enum_table = &OnOffAuto_lookup,
     .get = prop_get_on_off_auto_bit64,
     .set = prop_set_on_off_auto_bit64,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -322,7 +323,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_bool = {
-    .type  = "bool",
+    .qapi_type = &bool_type_info,
     .description = "on/off",
     .get   = get_bool,
     .set   = set_bool,
@@ -362,7 +363,7 @@ void qdev_propinfo_set_default_value_uint(ObjectProperty *op,
 }
 
 const PropertyInfo qdev_prop_uint8 = {
-    .type  = "uint8",
+    .qapi_type = &uint8_type_info,
     .get   = get_uint8,
     .set   = set_uint8,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -389,7 +390,7 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_uint16 = {
-    .type  = "uint16",
+    .qapi_type = &uint16_type_info,
     .get   = get_uint16,
     .set   = set_uint16,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -434,14 +435,14 @@ static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
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
@@ -486,14 +487,14 @@ static void set_int64(Object *obj, Visitor *v, const char *name,
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
@@ -515,7 +516,7 @@ static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_uint64_checkmask = {
-    .type  = "uint64",
+    .qapi_type = &uint64_type_info,
     .get   = get_uint64,
     .set   = set_uint64_checkmask,
 };
@@ -551,7 +552,11 @@ static void set_usize(Object *obj, Visitor *v, const char *name, void *opaque,
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
@@ -595,7 +600,7 @@ static void set_string(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_string = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .release = release_string,
     .get   = get_string,
     .set   = set_string,
@@ -604,9 +609,8 @@ const PropertyInfo qdev_prop_string = {
 /* --- on/off/auto --- */
 
 const PropertyInfo qdev_prop_on_off_auto = {
-    .type = "OnOffAuto",
+    .qapi_type = &OnOffAuto_type_info,
     .description = "on/off/auto",
-    .enum_table = &OnOffAuto_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -647,7 +651,7 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_size32 = {
-    .type  = "size",
+    .qapi_type = &size_type_info,
     .get = qdev_propinfo_get_size32,
     .set = set_size32,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -1060,7 +1064,7 @@ static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_size = {
-    .type  = "size",
+    .qapi_type = &size_type_info,
     .get = get_size,
     .set = set_size,
     .set_default_value = qdev_propinfo_set_default_value_uint,
@@ -1142,7 +1146,7 @@ static void set_link(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_link = {
-    .type = "link",
+    .qapi_type = &str_type_info,
     .create = create_link_property,
     /*
      * Since we have a create method, the get and set are used
-- 
2.55.0



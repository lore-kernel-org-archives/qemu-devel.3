Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A573CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4aD-00062f-NI; Sun, 10 May 2026 09:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4ZU-0005dp-Sa
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4ZT-0006EI-2B
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJ6YVk9irKlQOlbGHeKV4DjlzShkLcal/Hj1rNSds4s=;
 b=VG6rr5TQ0KI+qIE934jJSsHcmA/YGF5xuWNVhCzG01tu7pYiVShfhqOGzCbGlqO+p5++dL
 wmlM2wwAp9EuW9G0sDa8KfW8jspeKcTKN8iXRkevGfoO6g0JXp+5rMbSySWvD9EtBKKLt1
 JKkbHpe4VAH9e1KA6WlQgJHTNAI77sM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-ZD3JaHjEPPyjCYLUJNL5Hg-1; Sun,
 10 May 2026 09:51:48 -0400
X-MC-Unique: ZD3JaHjEPPyjCYLUJNL5Hg-1
X-Mimecast-MFC-AGG-ID: ZD3JaHjEPPyjCYLUJNL5Hg_1778421107
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73D511800578
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:51:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CF7618004A3; Sun, 10 May 2026 13:51:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:40 +0400
Subject: [PATCH 43/54] qdev: convert core PropertyInfo definitions to use
 qapi_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-43-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6552;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tcRQLOx7yH29wX/F2qmEq+1s28yNGkCzWFTucYIoVMM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItwxDBt9ZRgPYXy9dOLsX0R6XCl/1H60ezbL
 q66mzp9/GqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcAAKCRDa6OEJdZac
 5anMD/oDYyVz4/I34R7whghXrq0QbYAMbgRkpX8zP8MR0/z1CHmGfnyucXhJrm96PtuTeBHYcYk
 AqAr0UmCnh4/eyRbOInaB+vKUaYHmAQiLhD1YPLI7HRNHrwu0/ZxB2N89HzlhvVSjjcUZfEs2hQ
 rdweMnplJffhiaWUKdpziLKOU1o+RP+JFqDMN0iOPcKtZEtjo6G/YLMkqdYRjb2ieK4ShgUio08
 ap0zuER8ofWR8Xb/NjMsXaI4/1ZYvkKCEM+VrpaNhf/I9OV3fd0AFWVmtWJeCoVSBnJ9xvDlSbm
 xKLtIaFd40tVDpx2teo1efQlchOM2APuvTJ+rkz2KvD4jqccOfOx29mBOiABroSJlRsCYOdSo0D
 b7DdqcdKxUdUhuN81VXwaAHOKP2b82PNzC9poSYT71vLyZuHe97294e4tfHp177Bx9kBf669pVh
 osekbExNiPfjLnbCcmaNyq5iyye0wLF44X+jEQREPpMd2CYCeNNCsVB6lxgTdXKv88nxjILUN6c
 Mzg9Hazqzk4DZrvtnwpWnmRX0eU8Fpg18nA6Elmmq/BbiYMXJepu0et/G4LCeBM5xn8NBKIQOxZ
 ciNhwnFxPm3G1gT/cIjjqq2GYbNTLpkwnNKBIZQ/q6MFp3qDDUU6AqBPhwDhumrBKCQO4kfFHFC
 c1lhkHM5k/SROJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The qdev_prop_link and qdev_prop_array definitions are unchanged:
link uses .create for registration, and array will be refactored in
a subsequent patch.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index eb7caa32557..7e562518184 100644
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
@@ -1052,7 +1056,7 @@ static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
 }
 
 const PropertyInfo qdev_prop_size = {
-    .type  = "size",
+    .qapi_type = &size_type_info,
     .get = get_size,
     .set = set_size,
     .set_default_value = qdev_propinfo_set_default_value_uint,

-- 
2.54.0



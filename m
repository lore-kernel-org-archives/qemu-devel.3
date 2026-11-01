Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEB606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JqlNCAHl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc2H-00023A-Aq; Sun, 01 Nov 2026 15:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzu-00056V-BV
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzi-0007Eh-9y
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SU3JdHDRj00b7QAn8XE2AHEA/tfKdUQioGH0BgnkAwU=;
 b=JqlNCAHlTMxLIqXcrg5kUSOUZtcyFQjWRIpSjYfLLinVs5FJG/gkSp7R78jUkFZrzVi2RJ
 MdIqxKOxBgngyZbDyaF05PphWx1bqUik5aplpIVtamqWsXeT5EvZGrZPo0WpO2X4XMqQ5I
 9j9eUNoOP2zQr0nQYTAyAYbh0yhWCIw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-eqr5OyBYPpy9UDUtCww7iA-1; Sun,
 01 Nov 2026 15:17:30 -0500
X-MC-Unique: eqr5OyBYPpy9UDUtCww7iA-1
X-Mimecast-MFC-AGG-ID: eqr5OyBYPpy9UDUtCww7iA_1793564249
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24B8719560B7; Sun,  1 Nov 2026 20:17:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BE89767; Sun,  1 Nov 2026 20:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B16021E6833; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v8 41/56] qom: replace object_property_add_tm with StructTm
 QAPI type
Date: Sun,  1 Nov 2026 21:17:02 +0100
Message-ID: <20261101201717.3911097-42-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Define a StructTm QAPI struct in common.json matching the existing
"struct tm" property wire format (tm_year, tm_mon, tm_mday, tm_hour,
tm_min, tm_sec as int32).

Convert the two callers (mc146818rtc and spapr_rtc) to pass its
QAPITypeInfo to object_class_property_add() / object_property_add(),
and use a standard ObjectPropertyAccessor that populates a StructTm
and calls the generated visitor.

Remove object_property_add_tm(), object_class_property_add_tm(),
the TMProperty type, and the property_get_tm() helper from
qom/object.c, along with their declarations in object.h.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/common.json     | 27 +++++++++++++++++
 qapi/pragma.json     |  1 +
 include/qom/object.h | 29 ------------------
 hw/ppc/spapr_rtc.c   | 25 ++++++++++++++--
 hw/rtc/mc146818rtc.c | 23 +++++++++++++--
 qom/object.c         | 70 --------------------------------------------
 6 files changed, 70 insertions(+), 105 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 1352e664b2..68b649ecf2 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -218,3 +218,30 @@
 ##
 { 'enum': 'EndianMode',
   'data': [ 'unspecified', 'little', 'big' ] }
+
+##
+# @StructTm:
+#     Broken-down time.  Field semantics match C ``struct tm``.
+#
+# @tm_year: years since 1900
+#
+# @tm_mon: months since January (0-11)
+#
+# @tm_mday: day of the month (1-31)
+#
+# @tm_hour: hours since midnight (0-23)
+#
+# @tm_min: minutes after the hour (0-59)
+#
+# @tm_sec: seconds after the minute (0-59, 60-61 for leap seconds)
+#
+# Since: 11.2
+##
+{ 'struct': 'StructTm',
+  'data': {
+    'tm_year': 'int32',
+    'tm_mon': 'int32',
+    'tm_mday': 'int32',
+    'tm_hour': 'int32',
+    'tm_min': 'int32',
+    'tm_sec': 'int32' } }
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 342cedc42e..9be2819a46 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -109,6 +109,7 @@
         'QKeyCode',                 # send-key, input-sent-event
         'QapiErrorClass',           # QMP error replies
         'SshHostKeyCheckMode',      # blockdev-add, -blockdev
+        'StructTm',                 # qom-get of RTC date property
         'SysEmuTarget',             # query-cpu-fast, query-target
         'UuidInfo',                 # query-uuid
         'VncClientInfo',            # query-vnc, query-vnc-servers, ...
diff --git a/include/qom/object.h b/include/qom/object.h
index e9a67017fa..d1699964fa 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2027,35 +2027,6 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **));
 
-/**
- * object_property_add_tm:
- * @obj: the object to add a property to
- * @name: the name of the property
- * @get: the getter or NULL if the property is write-only.
- *
- * Add a read-only struct tm valued property using a getter function.
- * This function will add a property of type 'struct tm'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_property_add_tm(Object *obj, const char *name,
-                            void (*get)(Object *, struct tm *, Error **));
-
-/**
- * object_class_property_add_tm:
- * @klass: the object class to add a property to
- * @name: the name of the property
- * @get: the getter or NULL if the property is write-only.
- *
- * Add a read-only struct tm valued property using a getter function.
- * This function will add a property of type 'struct tm'.
- *
- * Returns: The newly added property on success, or %NULL on failure.
- */
-ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
-                            const char *name,
-                            void (*get)(Object *, struct tm *, Error **));
-
 typedef enum {
     /* Automatically add a getter to the property */
     OBJ_PROP_FLAG_READ = 1 << 0,
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 1f7d2d8f89..10d4cddb42 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -33,6 +33,9 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-type-infos-common.h"
+#include "qapi/qapi-visit-common.h"
+#include "qapi/visitor.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 
@@ -131,9 +134,23 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, SpaprMachineState *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
 
-static void spapr_rtc_qom_date(Object *obj, struct tm *current_tm, Error **errp)
+static void spapr_rtc_qom_date(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
 {
-    spapr_rtc_read(SPAPR_RTC(obj), current_tm, NULL);
+    struct tm value;
+    StructTm tm, *tmp = &tm;
+
+    spapr_rtc_read(SPAPR_RTC(obj), &value, NULL);
+
+    tm = (StructTm) {
+        .tm_year = value.tm_year,
+        .tm_mon = value.tm_mon,
+        .tm_mday = value.tm_mday,
+        .tm_hour = value.tm_hour,
+        .tm_min = value.tm_min,
+        .tm_sec = value.tm_sec,
+    };
+    visit_type_StructTm(v, name, &tmp, errp);
 }
 
 static void spapr_rtc_realize(DeviceState *dev, Error **errp)
@@ -150,7 +167,9 @@ static void spapr_rtc_realize(DeviceState *dev, Error **errp)
     rtc_ns = qemu_clock_get_ns(rtc_clock);
     rtc->ns_offset = host_s * NANOSECONDS_PER_SECOND - rtc_ns;
 
-    object_property_add_tm(OBJECT(rtc), "date", spapr_rtc_qom_date);
+    object_property_add(OBJECT(rtc), "date", "struct tm",
+                        &StructTm_type_info,
+                        spapr_rtc_qom_date, NULL, NULL, NULL);
 }
 
 static const VMStateDescription vmstate_spapr_rtc = {
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index ba396435d1..835684abce 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -42,6 +42,8 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-type-infos-common.h"
+#include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 
@@ -854,12 +856,25 @@ static const MemoryRegionOps cmos_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void rtc_get_date(Object *obj, struct tm *current_tm, Error **errp)
+static void rtc_get_date(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
 {
     MC146818RtcState *s = MC146818_RTC(obj);
+    struct tm value;
+    StructTm tm, *tmp = &tm;
 
     rtc_update_time(s);
-    rtc_get_time(s, current_tm);
+    rtc_get_time(s, &value);
+
+    tm = (StructTm) {
+        .tm_year = value.tm_year,
+        .tm_mon = value.tm_mon,
+        .tm_mday = value.tm_mday,
+        .tm_hour = value.tm_hour,
+        .tm_min = value.tm_min,
+        .tm_sec = value.tm_sec,
+    };
+    visit_type_StructTm(v, name, &tmp, errp);
 }
 
 static void rtc_realizefn(DeviceState *dev, Error **errp)
@@ -1019,7 +1034,9 @@ static void rtc_class_initfn(ObjectClass *klass, const void *data)
     device_class_set_props(dc, mc146818rtc_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 
-    object_class_property_add_tm(klass, "date", rtc_get_date);
+    object_class_property_add(klass, "date", "struct tm",
+                              &StructTm_type_info,
+                              rtc_get_date, NULL, NULL, NULL);
 }
 
 static const TypeInfo mc146818rtc_info = {
diff --git a/qom/object.c b/qom/object.c
index 39d26a17c6..637459c2b1 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2613,76 +2613,6 @@ int object_property_get_enum(Object *obj, const char *name,
     return ret;
 }
 
-typedef struct TMProperty {
-    void (*get)(Object *, struct tm *, Error **);
-} TMProperty;
-
-static void property_get_tm(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    TMProperty *prop = opaque;
-    Error *err = NULL;
-    struct tm value;
-
-    prop->get(obj, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    if (!visit_start_struct(v, name, NULL, 0, errp)) {
-        return;
-    }
-    if (!visit_type_int32(v, "tm_year", &value.tm_year, errp)) {
-        goto out_end;
-    }
-    if (!visit_type_int32(v, "tm_mon", &value.tm_mon, errp)) {
-        goto out_end;
-    }
-    if (!visit_type_int32(v, "tm_mday", &value.tm_mday, errp)) {
-        goto out_end;
-    }
-    if (!visit_type_int32(v, "tm_hour", &value.tm_hour, errp)) {
-        goto out_end;
-    }
-    if (!visit_type_int32(v, "tm_min", &value.tm_min, errp)) {
-        goto out_end;
-    }
-    if (!visit_type_int32(v, "tm_sec", &value.tm_sec, errp)) {
-        goto out_end;
-    }
-    visit_check_struct(v, errp);
-out_end:
-    visit_end_struct(v, NULL);
-}
-
-ObjectProperty *
-object_property_add_tm(Object *obj, const char *name,
-                       void (*get)(Object *, struct tm *, Error **))
-{
-    TMProperty *prop = g_malloc0(sizeof(*prop));
-
-    prop->get = get;
-
-    return object_property_add(obj, name, "struct tm", NULL,
-                               get ? property_get_tm : NULL, NULL,
-                               property_release_data,
-                               prop);
-}
-
-ObjectProperty *
-object_class_property_add_tm(ObjectClass *klass, const char *name,
-                             void (*get)(Object *, struct tm *, Error **))
-{
-    TMProperty *prop = g_malloc0(sizeof(*prop));
-
-    prop->get = get;
-
-    return object_class_property_add(klass, name, "struct tm", NULL,
-                                     get ? property_get_tm : NULL,
-                                     NULL, NULL, prop);
-}
-
 static char *object_get_type(Object *obj, Error **errp)
 {
     return g_strdup(object_get_typename(obj));
-- 
2.55.0



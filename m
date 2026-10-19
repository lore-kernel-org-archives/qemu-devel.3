Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1E2CCF2EC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoE5-0002cF-Fy; Mon, 19 Oct 2026 10:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDW-0002Ic-PL
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDQ-0005f3-NP
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uOaJWDCvobQmFwH6FUwwVVmDz7JZRhBYQdVh+2c5PI=;
 b=hPNJlxRAmTH1FsvkvGeTct6MTzbg0jyjqNBlNsfwMlocmi7GiT8Uu/KGJANPIOYGWBWIBj
 PkF+a5Tzh7wD0BAgi+R8SbkUCsJiApTSuO2GY2hhvANhVY5Myk8avTR+pmffqq4hQm0Qc6
 j1jBY9LtgtW86KecNGI5AKELHNCRpNw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-pluDNGRmO8mNIETpfn4JnA-1; Mon,
 19 Oct 2026 14:19:42 +0000
X-MC-Unique: pluDNGRmO8mNIETpfn4JnA-1
X-Mimecast-MFC-AGG-ID: pluDNGRmO8mNIETpfn4JnA_1792419581
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1977F180061F; Mon, 19 Oct 2026 14:19:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B65D30000E3; Mon, 19 Oct 2026 14:19:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41A3A21E6833; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 43/65] qom: replace object_property_add_tm with StructTm
 QAPI type
Date: Mon, 19 Oct 2026 16:19:07 +0200
Message-ID: <20261019141929.1594337-44-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Define a StructTm QAPI struct in common.json matching the existing
"struct tm" property wire format (tm_year, tm_mon, tm_mday, tm_hour,
tm_min, tm_sec as int32).

Convert the two callers (mc146818rtc and spapr_rtc) to use
object_property_add_qapi() with a standard ObjectPropertyAccessor
that populates a StructTm and calls the generated visitor.

Remove object_property_add_tm(), object_class_property_add_tm(),
the TMProperty type, and the property_get_tm() helper from
qom/object.c, along with their declarations in object.h.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/common.json     | 28 ++++++++++++++++++
 qapi/pragma.json     |  1 +
 include/qom/object.h | 29 -------------------
 hw/ppc/spapr_rtc.c   | 18 ++++++++++--
 hw/rtc/mc146818rtc.c | 16 ++++++++--
 qom/object.c         | 69 --------------------------------------------
 6 files changed, 57 insertions(+), 104 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 1352e664b2..222037ea0b 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -218,3 +218,31 @@
 ##
 { 'enum': 'EndianMode',
   'data': [ 'unspecified', 'little', 'big' ] }
+
+##
+# @StructTm:
+#
+# Broken-down time.  Field semantics match C ``struct tm``.
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
index ce9375f37a..ca6653094a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2135,35 +2135,6 @@ object_class_property_add_qapi(ObjectClass *klass,
                                ObjectPropertyRelease *release,
                                void *opaque);
 
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
index 1f7d2d8f89..a4a2b3237e 100644
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
 
@@ -131,9 +134,17 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, SpaprMachineState *spapr,
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
+    tm = (StructTm) { value.tm_year, value.tm_mon, value.tm_mday,
+                      value.tm_hour, value.tm_min, value.tm_sec };
+    visit_type_StructTm(v, name, &tmp, errp);
 }
 
 static void spapr_rtc_realize(DeviceState *dev, Error **errp)
@@ -150,7 +161,8 @@ static void spapr_rtc_realize(DeviceState *dev, Error **errp)
     rtc_ns = qemu_clock_get_ns(rtc_clock);
     rtc->ns_offset = host_s * NANOSECONDS_PER_SECOND - rtc_ns;
 
-    object_property_add_tm(OBJECT(rtc), "date", spapr_rtc_qom_date);
+    object_property_add_qapi(OBJECT(rtc), "date", &StructTm_type_info,
+                             spapr_rtc_qom_date, NULL, NULL, NULL);
 }
 
 static const VMStateDescription vmstate_spapr_rtc = {
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index ba396435d1..328dd038f1 100644
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
 
@@ -854,12 +856,19 @@ static const MemoryRegionOps cmos_ops = {
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
+    tm = (StructTm) { value.tm_year, value.tm_mon, value.tm_mday,
+                      value.tm_hour, value.tm_min, value.tm_sec };
+    visit_type_StructTm(v, name, &tmp, errp);
 }
 
 static void rtc_realizefn(DeviceState *dev, Error **errp)
@@ -1019,7 +1028,8 @@ static void rtc_class_initfn(ObjectClass *klass, const void *data)
     device_class_set_props(dc, mc146818rtc_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 
-    object_class_property_add_tm(klass, "date", rtc_get_date);
+    object_class_property_add_qapi(klass, "date", &StructTm_type_info,
+                                   rtc_get_date, NULL, NULL, NULL);
 }
 
 static const TypeInfo mc146818rtc_info = {
diff --git a/qom/object.c b/qom/object.c
index 1b23dd5f1a..9ad07273f5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2720,75 +2720,6 @@ object_class_property_add_qapi(ObjectClass *klass, const char *name,
     return prop;
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
-    return object_property_add(obj, name, "struct tm",
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
-    return object_class_property_add(klass, name, "struct tm",
-                                     get ? property_get_tm : NULL,
-                                     NULL, NULL, prop);
-}
 
 static char *object_get_type(Object *obj, Error **errp)
 {
-- 
2.55.0



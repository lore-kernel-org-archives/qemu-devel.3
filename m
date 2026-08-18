Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D08C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHwL-0005fQ-Kt; Tue, 18 Aug 2026 07:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHwF-0005N7-D9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHwC-0007PC-WE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a97ESGSAB+LtBGl3FtsUreZlvYs5zsUazQpPMiETlic=;
 b=Uu+I6hc/wcCfjjS85B5/l9USznJkODLX6UvQFESEYz5Cl4uhBT1vjype31+FN7SBdEMCWV
 UCjoAeXXmGFPoG4+AujGbJp72f1ekPI7sa5o7S+btZGVJEjPjoc48IqZIVS+X/pyMTG9i0
 VnuxlYwQhFHvIBHvuHktn7xbLk/ytu8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-DU68lctEOHiGighbdHHRrA-1; Tue,
 18 Aug 2026 07:24:57 -0400
X-MC-Unique: DU68lctEOHiGighbdHHRrA-1
X-Mimecast-MFC-AGG-ID: DU68lctEOHiGighbdHHRrA_1787052295
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C529718001E6; Tue, 18 Aug 2026 11:24:55 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9BEEC423; Tue, 18 Aug 2026 11:24:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:11:17 +0400
Subject: [PATCH v3 50/74] qom: replace object_property_add_tm with StructTm
 QAPI type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-50-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, 
 qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=9797;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tPMgw++FP90dtkmxKsUhd+GjqMKYCwj6bdRmikAYVpY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD276+IBV6gJKDXq7McSfEBvIXClDQKD2f6Ox
 blAStM9+4SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uwAKCRDa6OEJdZac
 5bl+D/9JRjbSDlU+ng/Je9buvfCyvSNDC0u59KPxGvmtdfNw4DP3mH6jGlQtod8smzleCNuv8OD
 IhiexdW4wP1iZF2lBTmw6NyuNwfRvGOm8flPhblyi0ix28cGmlVZ3wq0S6+GqygcRvGDHGbai4y
 pjS+1kEK0Flnr4cl9hDEWHIpeIQq5n+rS1P4OgaeT+Fu7T9hj3B+tRw3841Wdl61dJwOiZVgBKB
 g/9ICwUYjDRhb0cMj51+k7FsrjYQh7d/gNN4Ie9NqDBYwNTeJi0yAhW2s8ERvfoFnmneZjEno5D
 Abd/OXpBuyoCreHNup8++qD97PXjq2hvvLLIszuwkSbIqnIzJaDBJx2GOj13VEMkgAZ5n1C5WaS
 6Yf3sPWwXPEwsd+dTAaqdoHMdAJVeXXz1KRTf+zui5xdQWpRVRvL3eEDRq8HqaTAFCsp+W2t+P5
 cWBDHhKVMnfos1/63rw3VO71QmU15G92m9v2EOzdwVRQdLooEaHAZm8LHKCVC5DeLmO84ml/iSJ
 Fb+GxkxuywuRH4rjF3NuDvXZmKN5Fz3+kbthf8VQYKuLQa70J6l3vIkHdtX7PmrfB39FXxvgpQT
 /ukZPQ85ANhS/6/AXkF4kcMzySxqkxUHHjk/eep06qaDuvrXWJjQLbKQDTEIpM8950Fke4VWlGi
 w8j1rdhCaoM/0Zw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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
---
 hw/ppc/spapr_rtc.c   | 18 +++++++++++---
 hw/rtc/mc146818rtc.c | 16 +++++++++---
 include/qom/object.h | 29 ----------------------
 qapi/common.json     | 28 +++++++++++++++++++++
 qapi/pragma.json     |  1 +
 qom/object.c         | 69 ----------------------------------------------------
 6 files changed, 57 insertions(+), 104 deletions(-)

diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 1f7d2d8f898b..a4a2b3237e26 100644
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
index ba396435d1af..328dd038f167 100644
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
diff --git a/include/qom/object.h b/include/qom/object.h
index 70217eba1473..db4972294e39 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2049,35 +2049,6 @@ object_class_property_add_qapi(ObjectClass *klass,
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
diff --git a/qapi/common.json b/qapi/common.json
index af7e3d618a7c..928ba0ba2c63 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -228,3 +228,31 @@
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
index 24aebbe8f5fc..8283149693d8 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -108,6 +108,7 @@
         'QKeyCode',                 # send-key, input-sent-event
         'QapiErrorClass',           # QMP error replies
         'SshHostKeyCheckMode',      # blockdev-add, -blockdev
+        'StructTm',                 # qom-get of RTC date property
         'SysEmuTarget',             # query-cpu-fast, query-target
         'UuidInfo',                 # query-uuid
         'VncClientInfo',            # query-vnc, query-vnc-servers, ...
diff --git a/qom/object.c b/qom/object.c
index 65e640d1b7d1..4d7c9181fb6e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2628,75 +2628,6 @@ object_class_property_add_qapi(ObjectClass *klass, const char *name,
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
2.55.0.543.g5ebe2ebe4ea8



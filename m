Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9537CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4YG-0003L6-JT; Sun, 10 May 2026 09:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Y9-00033i-0P
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Y6-00060Y-3N
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3O9/3drz3R7uunb+d8pvw9xVjRomqq7ZrcXLbUuSZE=;
 b=ZQmLMHpZQs6u0opvJj+tECfKHdmaFSIzWZq1FdEIItJrlPHCGdOeowXsPqRiFE1G1zSCmf
 NiFIss3SQ/2ItpcB93B0poLHIiZl2kZ7qZ+b49+oInw9sgqBCEmCeZs2EUDfoLKwf7ycDT
 szs1TIEXRTblqr6IZU2J6vBNrGZuMi8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-hUIZZxbJP7ynlgCqYDKHhQ-1; Sun,
 10 May 2026 09:50:24 -0400
X-MC-Unique: hUIZZxbJP7ynlgCqYDKHhQ-1
X-Mimecast-MFC-AGG-ID: hUIZZxbJP7ynlgCqYDKHhQ_1778421023
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49FA819560B5
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:50:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A5751955D84; Sun, 10 May 2026 13:50:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:33 +0400
Subject: [PATCH 36/54] qom: replace object_property_add_tm with StructTm
 QAPI type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-36-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9338;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GX+Xf9BfFJQFmSKbKE+cmji4y84REBZZ59VJBVcv79U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItwL5z1CpLdG1rxG5x5w4bOBQ8l1NXYohDE8
 gHUypJrTNWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcAAKCRDa6OEJdZac
 5Uc0EACVBn3rqweptO1+vzN2EPV00NRk47Jj3KgETJzTAGE0JyYhXod/BDP339Rh0q9mADWYz/+
 +1ttqXYSmcATgmSM8cPqxAQWBgSDP9napRXSPhYYqymeRniyzxYe9glAogmqfCEQWqlz/qtD87d
 08pxY0jIVdewSqyYz7Fe7FkWYNPT1q0loMxuoB13rujsnXHJjZzKLXQx4TvC5wlPI61ffU0iSyp
 1khZ4f7YGwUM8uzY28M+TLYURnVhIKijssbz6BaJS0OlasGV6F9lxh/kPf2jSCLfjT0tTH9bPuu
 dCGyFuRF5zbkLf+sZw4P2sEpeqCHMAZrpJINHqa7LMEyc+FnH+FVt0YIfrTrJIvuHRfJFMdTU8+
 wuuh9P7DEDvaqDHuso/ebthOu+TJ2r0DILbkQqmad+yN7+h1JrRbYaWcJsiJoPbVw9dd5iFBAH+
 je0JdzkW4xwFWISPAt7SaIRFqk77ngMOllolh6nBuxEqTvphJ5k1pBAq9HEctVLPVWdS8GSkL0E
 T+pKFevVat5SsfWX7OSbu928zzjO9fqJVP4eQButkp02V2l34DbwxwC9SOuQvW/eNLA607I+07T
 USxNT3nO9VYVv7gPp49ru3l1LPP9ipQeifYMuDZcICvq7DTYbCPI1fKuh7xfw11+F/4qYn8B99P
 HUqA2FCP0lsAbqA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
 qapi/common.json     | 28 +++++++++++++++++++++
 qapi/pragma.json     |  1 +
 include/qom/object.h | 18 --------------
 hw/ppc/spapr_rtc.c   | 18 +++++++++++---
 hw/rtc/mc146818rtc.c | 16 +++++++++---
 qom/object.c         | 69 ----------------------------------------------------
 6 files changed, 57 insertions(+), 93 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index af7e3d618a7..68b29126cbc 100644
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
+# Since: 11.1
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
index 24aebbe8f5f..8283149693d 100644
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
diff --git a/include/qom/object.h b/include/qom/object.h
index 14238e4b844..d0134a94281 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1893,24 +1893,6 @@ object_class_property_add_qapi(ObjectClass *klass,
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
-ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
-                            const char *name,
-                            void (*get)(Object *, struct tm *, Error **));
-
 typedef enum {
     /* Automatically add a getter to the property */
     OBJ_PROP_FLAG_READ = 1 << 0,
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 1f7d2d8f898..a4a2b3237e2 100644
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
index ccbb2797169..e130cb4eaf7 100644
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
 
@@ -855,12 +857,19 @@ static const MemoryRegionOps cmos_ops = {
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
@@ -921,7 +930,8 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
     memory_region_add_coalescing(&s->coalesced_io, 0, 1);
 
-    object_property_add_tm(OBJECT(s), "date", rtc_get_date);
+    object_property_add_qapi(OBJECT(s), "date", &StructTm_type_info,
+                             rtc_get_date, NULL, NULL, NULL);
 
     qdev_init_gpio_out(dev, &s->irq, 1);
 }
diff --git a/qom/object.c b/qom/object.c
index 7f4d301cd86..1e6c3a9f91d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2463,75 +2463,6 @@ object_class_property_add_qapi(ObjectClass *klass, const char *name,
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
2.54.0



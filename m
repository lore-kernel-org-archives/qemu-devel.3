Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E201C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54H0-00011n-Gu; Fri, 11 Sep 2026 12:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Gx-0000hw-RV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Gw-0006UF-2f
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giWvSJES9Am74xj7Gxo9BvxGBNVPmhOKyYmXMRbmmxg=;
 b=aVqeB2diw2rzAOnDSFsQ0FNt3+kWMp8ueOBcqIYgt2PQunzna2wrKk/e2miFxfubJ1hO1I
 DKdaj48x2YVpJcstcZSpdR70+u+A1jmavGtSV2iLmYblUrRmVp30RAYEnWjMBwb1cmipL4
 HAwF7Uxh+7+WVKAXmB6SmOS6XADf6gs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-NaiUyuNMOx-W-oSMfMAgng-1; Fri,
 11 Sep 2026 12:38:38 -0400
X-MC-Unique: NaiUyuNMOx-W-oSMfMAgng-1
X-Mimecast-MFC-AGG-ID: NaiUyuNMOx-W-oSMfMAgng_1789144717
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1513D195E932; Fri, 11 Sep 2026 16:38:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0D0B195608F; Fri, 11 Sep 2026 16:38:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:53 +0400
Subject: [PATCH v5 19/62] microvm: convert OnOffAuto properties to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-19-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergio Lopez <slp@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5502;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SY82PLEWc9Gc3m055Lm7iyiVVRaR86gDnyc0DsDmtbo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC24WftGCp2T4gKr2VIY9phdtk9Ofhdyvc1VL
 c/Ek0BsnmCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuAAKCRDa6OEJdZac
 5fWzD/45/E5brGeVdcIfctfrMjO1GCp1aVJThD5UhMGVHPl18bv+otp8ZrI3VXxSRZvf7mo6Dx5
 6uP7dbX2Nkp7FcpplfNW3ozlw7dPFt4dhI6QYQkjAOJeV6BQ/Oxn2W9vhxSPnN4/67NLknepLM/
 SujBkTx9IsIsS42j8uzLrdONvCjggK9cVrOsQxe3uj2u3fqIaBw5Ze1aPekMl6vCYNIRPpSUnrj
 8aYlyAeb0x0qFpKaSUcLNYUQKpBhF7GUuDewp3NKbCzV3mik9/yYNIs6M1e5CDnC3vLrTPsLajj
 e/4LgNYlDOCLTcj/b3xEk/XlNoI+7YiE6E8WyHtZKCobIi1eB1THom8LVrkUWWJpOhojt1CQwO4
 DsKF42W0ohvo+nM6LgKopoP9/N3OFNUwSC8aChkOHU7N0ms2sHPGLGNJTO5DPV4kjiIUsjffych
 6UuPAny1Q2Mj4K9ZgWaM6ZNUE3xl+x0yJr3m5VIG0XRPiGPm6eFDqMfoNsmXOx5KK22UL2DptJN
 ipNJy3oe6va08z4QURPcBmqf2iS3lAJGirNz/RTaUqIg4KFB/RvXWKRPHq86Y9jK2S6qBsWJBod
 3sggAwB20jNYvAwKsrLrlkaSQbrRFyGk6KBvfcApn5EuduA+uPmiBnNjUvU5fzn4rsOMSAaLHPz
 svFiUzFi7F/RmvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Convert the rtc, pcie, and ioapic2 OnOffAuto properties from
manual visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/microvm.c | 80 +++++++++++++++++++++++--------------------------------
 1 file changed, 34 insertions(+), 46 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e7adab7d2ef7..3366f3b933f8 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -21,7 +21,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "system/system.h"
 #include "system/cpus.h"
 #include "system/numa.h"
@@ -519,55 +519,40 @@ static void microvm_machine_reset(MachineState *machine, ResetType type)
     }
 }
 
-static void microvm_machine_get_rtc(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+static int microvm_machine_get_rtc(Object *obj, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-    OnOffAuto rtc = mms->rtc;
-
-    visit_type_OnOffAuto(v, name, &rtc, errp);
+    return mms->rtc;
 }
 
-static void microvm_machine_set_rtc(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+static void microvm_machine_set_rtc(Object *obj, int value, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &mms->rtc, errp);
+    mms->rtc = value;
 }
 
-static void microvm_machine_get_pcie(Object *obj, Visitor *v, const char *name,
-                                     void *opaque, Error **errp)
+static int microvm_machine_get_pcie(Object *obj, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-    OnOffAuto pcie = mms->pcie;
-
-    visit_type_OnOffAuto(v, name, &pcie, errp);
+    return mms->pcie;
 }
 
-static void microvm_machine_set_pcie(Object *obj, Visitor *v, const char *name,
-                                     void *opaque, Error **errp)
+static void microvm_machine_set_pcie(Object *obj, int value, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &mms->pcie, errp);
+    mms->pcie = value;
 }
 
-static void microvm_machine_get_ioapic2(Object *obj, Visitor *v, const char *name,
-                                        void *opaque, Error **errp)
+static int microvm_machine_get_ioapic2(Object *obj, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-    OnOffAuto ioapic2 = mms->ioapic2;
-
-    visit_type_OnOffAuto(v, name, &ioapic2, errp);
+    return mms->ioapic2;
 }
 
-static void microvm_machine_set_ioapic2(Object *obj, Visitor *v, const char *name,
-                                        void *opaque, Error **errp)
+static void microvm_machine_set_ioapic2(Object *obj, int value, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &mms->ioapic2, errp);
+    mms->ioapic2 = value;
 }
 
 static bool microvm_machine_get_isa_serial(Object *obj, Error **errp)
@@ -673,26 +658,29 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
 
-    object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
-                              microvm_machine_get_rtc,
-                              microvm_machine_set_rtc,
-                              NULL, NULL);
-    object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
-        "Enable MC146818 RTC");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = MICROVM_MACHINE_RTC,
+        .description = "Enable MC146818 RTC",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = microvm_machine_get_rtc,
+        .set = microvm_machine_set_rtc,
+    ));
 
-    object_class_property_add(oc, MICROVM_MACHINE_PCIE, "OnOffAuto",
-                              microvm_machine_get_pcie,
-                              microvm_machine_set_pcie,
-                              NULL, NULL);
-    object_class_property_set_description(oc, MICROVM_MACHINE_PCIE,
-        "Enable PCIe");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = MICROVM_MACHINE_PCIE,
+        .description = "Enable PCIe",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = microvm_machine_get_pcie,
+        .set = microvm_machine_set_pcie,
+    ));
 
-    object_class_property_add(oc, MICROVM_MACHINE_IOAPIC2, "OnOffAuto",
-                              microvm_machine_get_ioapic2,
-                              microvm_machine_set_ioapic2,
-                              NULL, NULL);
-    object_class_property_set_description(oc, MICROVM_MACHINE_IOAPIC2,
-        "Enable second IO-APIC");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = MICROVM_MACHINE_IOAPIC2,
+        .description = "Enable second IO-APIC",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = microvm_machine_get_ioapic2,
+        .set = microvm_machine_set_ioapic2,
+    ));
 
     object_class_property_add_bool(oc, MICROVM_MACHINE_ISA_SERIAL,
                                    microvm_machine_get_isa_serial,

-- 
2.55.0.543.g5ebe2ebe4ea8



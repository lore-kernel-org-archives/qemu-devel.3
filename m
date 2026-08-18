Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87127C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHpK-0000k5-Ag; Tue, 18 Aug 2026 07:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHpH-0000bC-DM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHpF-0005k5-N4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giWvSJES9Am74xj7Gxo9BvxGBNVPmhOKyYmXMRbmmxg=;
 b=anKjU00geoBvO7N7kB2J9uF6dQGJiFbgTI1zrDErPYg1AkV1v86UlrmcYaIbtHEQJPoccj
 WqpSgk9y3nAix/BcM+r9tMmmeSHGta1i+pfb3PcpbgMqFx8cLBHxjBjEPNnFyQ7sGjnZE9
 5ynEbt5I3ZEJ0VoV2fX2KUosMtw7ITk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-BuvvfWZnOU-70v5x8OuBVg-1; Tue,
 18 Aug 2026 07:17:43 -0400
X-MC-Unique: BuvvfWZnOU-70v5x8OuBVg-1
X-Mimecast-MFC-AGG-ID: BuvvfWZnOU-70v5x8OuBVg_1787051862
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7620A18002C0; Tue, 18 Aug 2026 11:17:42 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 078DD30002E9; Tue, 18 Aug 2026 11:17:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:45 +0400
Subject: [PATCH v3 18/74] microvm: convert OnOffAuto properties to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-18-24b8bbbe3d86@redhat.com>
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
 Sergio Lopez <slp@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5502;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SY82PLEWc9Gc3m055Lm7iyiVVRaR86gDnyc0DsDmtbo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD24lF3n+bDfhXTRTlvqbOKZYj5AwxoumeN16
 8X5sT66X9OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uAAKCRDa6OEJdZac
 5ZSzD/0RlcM3fREvQYoAswtU194WHHOdSCi9GmjaeDVBcW//dbotYsYueqHpHmbAEhEJXU759Kx
 hL8Dh9qvqvd91ozYCgosXeZPMZvInDIB78p4EFLkcNrRc/s8WA0yEvYFas0EynASXW2jljFCOzl
 CfL3QTpElkYKWrmw/atQ0Q5x941V+FfHRZ7ZXgfkfUTmtVHbOFoui8lPYacq1RH5y9wDjnFsoZP
 mjDUyLvra9DZUUPNtkwbe+eaR311k+mxcBPJ2yucIvZJ8PsJZU5gtAXpki0YK0ENk+PNy/X7q4f
 512AklyiwWo0jK/BuViI/mho0bfXPG4GgFiHJ/2UH06oEwLB00m6rsYGs3vSCdalOhLwxCF6T3j
 OwZ+fxE6VCdeM7wIZIEDd6T2H/vyv6TNF+bXtZfkrE2eDVTcQoxkQlIPru2r9X6QnrQx20KpWYJ
 sRuy5IP16eVOuU8eHkhJhZM/26BuvZCVgHqHTgq/dsrMQBXfXNiGINN0AHsCZePebot/wRGHzfb
 IV/nxx68TarB3Sg54lq3AhkvAqYJxo51yFHkhv8zOKoggono4LbYoJbWt5V6Cp/utWDQYvJMCCg
 QSaNFfVsecf06GvkB7lzXxny0AYh12dDUIS4QJScH/+L43Xqp04zEtq1noJMhn0Y5V4vIL3JNL0
 /3pTow2G446y3QQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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



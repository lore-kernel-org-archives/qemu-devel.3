Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CA5CCF2ED
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoEX-0003Da-8T; Mon, 19 Oct 2026 10:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDO-0002Eq-UR
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDJ-0005al-4B
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VC/6XNX6A0pipOH7kJd7/2QU6o0+QG4LKuFePa7g8eI=;
 b=dXmj0P3tdoz2tZ8LPX0gTcBEGn0UkxXfU+qRf0Ew5CRqofJpxAQL8r45T5hVtmkqA3kFwk
 Y7yjItHeU+BTRmw45cK0whQgQe4NCN47ptxxiH7gjkvpPWOQAmWwTEvFcUE1HO8c1zMury
 49JBM7RU/Q+ZHf1Db8GTR4wX4rdy4ac=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-6awV43zjPae6LStvUlyEeg-1; Mon,
 19 Oct 2026 14:19:39 +0000
X-MC-Unique: 6awV43zjPae6LStvUlyEeg-1
X-Mimecast-MFC-AGG-ID: 6awV43zjPae6LStvUlyEeg_1792419578
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7424B1955E77; Mon, 19 Oct 2026 14:19:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE1141955F24; Mon, 19 Oct 2026 14:19:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CFD1D21E689A; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 22/65] microvm: convert OnOffAuto properties to QAPI-aware
 registration
Date: Mon, 19 Oct 2026 16:18:46 +0200
Message-ID: <20261019141929.1594337-23-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Convert the rtc, pcie, and ioapic2 OnOffAuto properties from
manual visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/microvm.c | 80 ++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 46 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a49de33749..1d1ca172bf 100644
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
2.55.0



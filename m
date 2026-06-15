Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97357CD98E6
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE5Y-0005uI-VX; Mon, 15 Jun 2026 16:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5W-0005a7-EN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5U-0002W6-An
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MkfTv3kRX7qWXQEIqqM6kAHVI9kM5hc75Db7cJOP9Q=;
 b=MgOAsHs9Ri1F4ZThnvD+6aNoG70Bdr2sP6weDwuPsNy/ANPR8FvsuVuGEBZVChRz4tpqVt
 IJLGunvvJskG+NEj4M4pULoDK9HeOXgwqDGoVN+xk7y4nAq9MQY6G7VBJSJsEmExUpeU+2
 FS7ROBbjDgVL/5uTxRWZWRVT7Y2sr2I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-vwMJ7qsYNkqTKUkEnvOkqA-1; Mon,
 15 Jun 2026 16:39:14 -0400
X-MC-Unique: vwMJ7qsYNkqTKUkEnvOkqA-1
X-Mimecast-MFC-AGG-ID: vwMJ7qsYNkqTKUkEnvOkqA_1781555953
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0903419560B8; Mon, 15 Jun 2026 20:39:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B84D13008B37; Mon, 15 Jun 2026 20:39:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:43 +0400
Subject: [PATCH v2 17/53] microvm: convert OnOffAuto properties to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-17-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5488;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NinzCqv4VpD3pzSuuYsNjRHolWxLn5IZPLOPaiH19nQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKOWKGv+g8zBh/hdFekgfmytlEODzS1jwj+M
 GkmXZo5gHiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5e4QD/wOw9vy4XzonyFo6CpYzOsQlj3p4kBFmFreHzE7Xp/DVwZNbLXG526CgMzru4SO9/LZzFM
 zqwS0e+a+tLK7jRKQ5UXlnul7jH0dcbTrQkmlKvQbCiFCYNv/GFiYTZDMTDuwSX5G7sfBrkzILi
 B11OkAbP9Dl9AJvfmf8dlYtDhGT4AhABDelecKaUf3YdtX0STnYvxzoZYHo/EmXCZSxoUxULw9R
 fV/jYIvpS2cR4psQs10N+biLeneGRiu/O9rbyjq4egVWEiY3oUJd6L1a9nnB2vvxWo7FiZ+ruTL
 eYObnVrkkpOreQzcdTCPmtqjCLkac8+G9JjuW5a97yj1MUuHc3bCoyHtLb4uXI43jRxyGzRXN+z
 tzt0IucviQRpxmUwbXmfXisaNGWKLqP6RUwEiQDyk3n6yjic13ZfAzVi1XKimBSqeHEUfQWperg
 zI69hFi9iGBS1klvzgTCTwb09/wCM7smp/+EiKgZjTtv1GuDsCJFKXfNWrsXJGQcNdURhftAP+r
 36f+klApByrO+CUYKMF/UjfHD/lptX5praAWObR5ZNmfpPNh5pZsXfULV7u7zp5zl0sLViwiK6l
 h0I+OudeYObIFsiP6kMEb4iTqEXk3cyoIgiHzh/RLfUF98b4CALnplvM6NxNs/N+zRPh/in/3Yb
 UgGtNurNIE8GLUQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
 hw/i386/microvm.c | 84 ++++++++++++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 48 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 779741ec76e..f09d7d8f905 100644
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
@@ -520,55 +520,40 @@ static void microvm_machine_reset(MachineState *machine, ResetType type)
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
@@ -674,26 +659,29 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
 
-    object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
-                              microvm_machine_get_rtc,
-                              microvm_machine_set_rtc,
-                              NULL, NULL);
-    object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
-        "Enable MC146818 RTC");
-
-    object_class_property_add(oc, MICROVM_MACHINE_PCIE, "OnOffAuto",
-                              microvm_machine_get_pcie,
-                              microvm_machine_set_pcie,
-                              NULL, NULL);
-    object_class_property_set_description(oc, MICROVM_MACHINE_PCIE,
-        "Enable PCIe");
-
-    object_class_property_add(oc, MICROVM_MACHINE_IOAPIC2, "OnOffAuto",
-                              microvm_machine_get_ioapic2,
-                              microvm_machine_set_ioapic2,
-                              NULL, NULL);
-    object_class_property_set_description(oc, MICROVM_MACHINE_IOAPIC2,
-        "Enable second IO-APIC");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = MICROVM_MACHINE_RTC,
+        .description = "Enable MC146818 RTC",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = microvm_machine_get_rtc,
+        .set = microvm_machine_set_rtc,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = MICROVM_MACHINE_PCIE,
+        .description = "Enable PCIe",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = microvm_machine_get_pcie,
+        .set = microvm_machine_set_pcie,
+    ));
+
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
2.54.0



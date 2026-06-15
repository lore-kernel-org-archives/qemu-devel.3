Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091C0CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE5W-0005Vs-2W; Mon, 15 Jun 2026 16:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5T-0005B3-Ob
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5P-0002UF-HN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZAvsi/ypZkY9bYTYXMYdE8m2fARyesQx7GcFiTarqNA=;
 b=XxShItWue2wbeRwHkfEVEfmwufgWMEtSefZsBZ3smsgG4WY0hd+DjDyuAM6OxQ90/NAXcn
 vqcQBvRizTAXsrBk6s7iTHSPJC829zQPMoTj4MwS8XGfmE6TzogIuHUMICwypA6jLPwT9a
 IcA7XbcrRW84rgors2xRwnQYvmgVvm8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-JBfSN67hNjeGkI0b95f1GA-1; Mon,
 15 Jun 2026 16:39:08 -0400
X-MC-Unique: JBfSN67hNjeGkI0b95f1GA-1
X-Mimecast-MFC-AGG-ID: JBfSN67hNjeGkI0b95f1GA_1781555947
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A71EC1800BD4; Mon, 15 Jun 2026 20:39:07 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6ADB7175F; Mon, 15 Jun 2026 20:39:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:42 +0400
Subject: [PATCH v2 16/53] x86: convert OnOffAuto properties to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-16-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6517;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MImBeImgefjPchPWxiBRSQZBA7NyEy4h07IQTQ8DlSo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKOyrOWScdv2qWk4mNlKRWkBHdQlYcFmiL7H
 m60RMf5hD+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5VK0EACF3YmwkmiHWe8191gB5cJXjaGtT7wWFmTkLh9eNrK1cbV2vV7xZMA1ksJiNF93Meb1b5x
 a0a3QPb3QOImfLzS1e0hTnkN7mEkLYA2kQ/81pY1cSWWROsnzKQx6B+USc/oEj24Js4qkZAOxl7
 CzxFtrt02bamSSf4lko3Cp7COj5rMgdUgkqcdMP/6TJxNUP/EWI6U0IEbh9jTkGhAJJASkyZmJQ
 Erb7kmcsSM5jfUw/7BJgKvg80q6Xaw8G1MOAT7SkSn0Fwvt0+EPqPJ2pIZV3zGrbZUkibisHQvJ
 mCJ7FUt82Wpm4WeGOVSJdpzDblmRsseYMbKfpQH2TvAEl1hhwFTKJCPBMu0g09xV500WU9+YU8P
 y2xBnYgouEQ0AIZAhBICtw1pklanCaF+aEFMLk2BkwDVCap42dpC4kXm2ekOa+2kJ2IIZCGVj7g
 MbbteUVTEuRcrUoz7c1HBoyBD8GG1cSAMeVNhHvcox0AMaKUfAR2c+Fg+OmGqCfUMtGPtTgNYkX
 qd45DazxOsQ2b9FHIf41E+hUjKlv4QkPE4DBorOR9o9p0igvVcmbElQ6tH5iMpYgf+pC7jsgV8b
 Wj10jEEXU7MLRbChoYPJfCQYexEO7Nn8MINoGDl1dFlrUqY7V1pHDUtY/4+GGz5UhW55i49enas
 ZpiBLhAO+POs+XA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Convert the smm, acpi, pit, and pic OnOffAuto properties from
manual visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/x86.c | 110 +++++++++++++++++++++++++---------------------------------
 1 file changed, 48 insertions(+), 62 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index dc7f0d56b01..155763b1c98 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -24,7 +24,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "system/qtest.h"
@@ -188,21 +188,16 @@ bool x86_machine_is_smm_enabled(const X86MachineState *x86ms)
     return false;
 }
 
-static void x86_machine_get_smm(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static int x86_machine_get_smm(Object *obj, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-    OnOffAuto smm = x86ms->smm;
-
-    visit_type_OnOffAuto(v, name, &smm, errp);
+    return x86ms->smm;
 }
 
-static void x86_machine_set_smm(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static void x86_machine_set_smm(Object *obj, int value, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &x86ms->smm, errp);
+    x86ms->smm = value;
 }
 
 bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms)
@@ -213,55 +208,40 @@ bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms)
     return true;
 }
 
-static void x86_machine_get_acpi(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
+static int x86_machine_get_acpi(Object *obj, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-    OnOffAuto acpi = x86ms->acpi;
-
-    visit_type_OnOffAuto(v, name, &acpi, errp);
+    return x86ms->acpi;
 }
 
-static void x86_machine_set_acpi(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
+static void x86_machine_set_acpi(Object *obj, int value, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &x86ms->acpi, errp);
+    x86ms->acpi = value;
 }
 
-static void x86_machine_get_pit(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+static int x86_machine_get_pit(Object *obj, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-    OnOffAuto pit = x86ms->pit;
-
-    visit_type_OnOffAuto(v, name, &pit, errp);
+    return x86ms->pit;
 }
 
-static void x86_machine_set_pit(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+static void x86_machine_set_pit(Object *obj, int value, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &x86ms->pit, errp);
+    x86ms->pit = value;
 }
 
-static void x86_machine_get_pic(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
+static int x86_machine_get_pic(Object *obj, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-    OnOffAuto pic = x86ms->pic;
-
-    visit_type_OnOffAuto(v, name, &pic, errp);
+    return x86ms->pic;
 }
 
-static void x86_machine_set_pic(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
+static void x86_machine_set_pic(Object *obj, int value, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &x86ms->pic, errp);
+    x86ms->pic = value;
 }
 
 static char *x86_machine_get_oem_id(Object *obj, Error **errp)
@@ -391,31 +371,37 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     mc->kvm_type = x86_kvm_type;
     nc->nmi_monitor_handler = x86_nmi;
 
-    object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
-        x86_machine_get_smm, x86_machine_set_smm,
-        NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_SMM,
-        "Enable SMM");
-
-    object_class_property_add(oc, X86_MACHINE_ACPI, "OnOffAuto",
-        x86_machine_get_acpi, x86_machine_set_acpi,
-        NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_ACPI,
-        "Enable ACPI");
-
-    object_class_property_add(oc, X86_MACHINE_PIT, "OnOffAuto",
-                              x86_machine_get_pit,
-                              x86_machine_set_pit,
-                              NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_PIT,
-        "Enable i8254 PIT");
-
-    object_class_property_add(oc, X86_MACHINE_PIC, "OnOffAuto",
-                              x86_machine_get_pic,
-                              x86_machine_set_pic,
-                              NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_PIC,
-        "Enable i8259 PIC");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_SMM,
+        .description = "Enable SMM",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_smm,
+        .set = x86_machine_set_smm,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_ACPI,
+        .description = "Enable ACPI",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_acpi,
+        .set = x86_machine_set_acpi,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_PIT,
+        .description = "Enable i8254 PIT",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_pit,
+        .set = x86_machine_set_pit,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_PIC,
+        .description = "Enable i8259 PIC",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_pic,
+        .set = x86_machine_set_pic,
+    ));
 
     object_class_property_add_str(oc, X86_MACHINE_OEM_ID,
                                   x86_machine_get_oem_id,

-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35A6CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4V4-0003hI-7W; Sun, 10 May 2026 09:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Ue-0003Gb-Gr
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Ub-0004wi-5i
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8rs449LfDTxHtjHkOxpL0qIgNKWl9rdFoq/MMZVE5w=;
 b=JZIc1GKWK0G0t2/lNucmKXhbKh4+YW3+JR+v0m9atJ3Md70JeqqxMxq+vh8W+km82SgxQy
 xVzaQHjuaiDA0KeL/muS2zpczo8qqMQiA2C527OyUX4WHUZuQcmFnk4qMO3fr4DBQ36wNV
 q1zzl5aQmmHpZ1N0fVQkdLiGuNpM2mE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-WgN0zaiDPeCuJ1F3zn7s2g-1; Sun,
 10 May 2026 09:46:46 -0400
X-MC-Unique: WgN0zaiDPeCuJ1F3zn7s2g-1
X-Mimecast-MFC-AGG-ID: WgN0zaiDPeCuJ1F3zn7s2g_1778420805
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86C6319541BA
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:46:45 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C4F71803A8E; Sun, 10 May 2026 13:46:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:13 +0400
Subject: [PATCH 16/54] x86: convert OnOffAuto properties to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-16-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6517;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NrLhEHoFQXaokeIgTjPY6OWSe2IOgXlTauMOsYsWoy0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItvZBhDFWizmhqdg64Gyy1zoOkye6L8zfVdV
 mu5YgLCDAmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbwAKCRDa6OEJdZac
 5Qu/D/0XtlTz2Z8AItbe1ATDSHyeUtI/Q+ko0YmnfzBiKsS2iPhUdRANAcb/RzEXuLTjxYJahT/
 o7/Aznn669tIWkSVjTJoDAiN79VsiJa9GxC3sv0+z9xhEwBjUlgpENdLfF4OcyQXuk0XxSiHfm+
 vMEz2XHkLCoEJo4X50179xMGzeQfJ4HVIcNaCOvS46iRq/t/mDB9WzpufxCdITEEapxwIBFq4/X
 fI5+WwnrLyAFeNWwKak08/oWL3O3CcT2AUzo/Q+aHJX3nU4ivX6OXfbrLxp+v5gEFfyMrNnDko3
 v8MFsURGg1D6njTQywzqM4FItwgK7tPNEndQuG0rkFh8HMUJivT4plGZN9Q9nrtKRZkH2KyI3WP
 3qMJpggc8f0pcedPm1Z273+Zv2hue/Lhc3khkM/fIIH3BZEL6qHKi0IGopGl7p0PU6ic3H0ab7Q
 v/lT3Sokls3EUZszTYnHAHbmhURR4ZVCSqv0SPP8vMuS3yx0RFJOEQza2Oh5/MSVXZgudNRu9j7
 wc+CRhezD3BDr66UwWNXJdgOxyGToq5ztpkIem3KDC0e8JdRIt4RIY+kB5vlXHO1yXHfSXbA7Hc
 7LUUW6OqOPqE65rJUmQ/+mF3OpowmQYJw7Vk2CGfYvVUH22VDI90kHx5X00tl2ZhjSJlhR/YF9/
 BCYEUDqnwtyaTIw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
index 01872cba073..b76926a00bd 100644
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
@@ -383,31 +363,37 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
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



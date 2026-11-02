Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3C606F23E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mu7rvipO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDl-0003VA-2i; Mon, 02 Nov 2026 09:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDH-0003Fw-Mb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD8-0008T7-GC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVuYcWmKfdlgdHae1obuFE5GyNIhgeaSOB43f6Vq4z0=;
 b=Mu7rvipOuQU59Wkfgnx+v9ycl+uDF1GLO+ysnENFT7u0HokawseqLrDeGpB5lPeW/lqhdq
 XxdOM5Q3J1vFrSktTfBCZDv/vsQXUDTJsl+u8+bu43CzRAGBAwJR7ssQOs1FThBJa3GOQg
 ShXpwSNB10ON4N50bDmsY5Ty2FwyclE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-MPXdLsR6OYuzT4dImICJ0g-1; Mon,
 02 Nov 2026 09:40:31 -0500
X-MC-Unique: MPXdLsR6OYuzT4dImICJ0g-1
X-Mimecast-MFC-AGG-ID: MPXdLsR6OYuzT4dImICJ0g_1793630430
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24C7919539A9; Mon,  2 Nov 2026 14:40:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A193830001A2; Mon,  2 Nov 2026 14:40:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A05F21E681E; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 37/74] x86: convert OnOffAuto properties to QAPI-aware
 registration
Date: Mon,  2 Nov 2026 15:39:41 +0100
Message-ID: <20261102144018.3212223-38-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Convert the smm, acpi, pit, and pic OnOffAuto properties from manual
visitor-based callbacks to object_class_property_add_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-21-armbru@redhat.com>
---
 hw/i386/x86.c | 84 ++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 1b7740a97e..3416df13ab 100644
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
@@ -391,29 +371,31 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     mc->kvm_type = x86_kvm_type;
     nc->raise_nmi = x86_nmi;
 
-    object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto", NULL,
-                              x86_machine_get_smm, x86_machine_set_smm,
-                              NULL, NULL);
+    object_class_property_add_enum(oc, X86_MACHINE_SMM, "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   x86_machine_get_smm,
+                                   x86_machine_set_smm);
     object_class_property_set_description(oc, X86_MACHINE_SMM,
         "Enable SMM");
 
-    object_class_property_add(oc, X86_MACHINE_ACPI, "OnOffAuto", NULL,
-                              x86_machine_get_acpi, x86_machine_set_acpi,
-                              NULL, NULL);
+    object_class_property_add_enum(oc, X86_MACHINE_ACPI, "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   x86_machine_get_acpi,
+                                   x86_machine_set_acpi);
     object_class_property_set_description(oc, X86_MACHINE_ACPI,
         "Enable ACPI");
 
-    object_class_property_add(oc, X86_MACHINE_PIT, "OnOffAuto", NULL,
-                              x86_machine_get_pit,
-                              x86_machine_set_pit,
-                              NULL, NULL);
+    object_class_property_add_enum(oc, X86_MACHINE_PIT, "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   x86_machine_get_pit,
+                                   x86_machine_set_pit);
     object_class_property_set_description(oc, X86_MACHINE_PIT,
         "Enable i8254 PIT");
 
-    object_class_property_add(oc, X86_MACHINE_PIC, "OnOffAuto", NULL,
-                              x86_machine_get_pic,
-                              x86_machine_set_pic,
-                              NULL, NULL);
+    object_class_property_add_enum(oc, X86_MACHINE_PIC, "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   x86_machine_get_pic,
+                                   x86_machine_set_pic);
     object_class_property_set_description(oc, X86_MACHINE_PIC,
         "Enable i8259 PIC");
 
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85BCC5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHpF-0000Rc-7p; Tue, 18 Aug 2026 07:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHpB-0000Eo-LI
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHp9-0005ie-LG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VscR/iIW0mIAkyA8JHrPI5JG+q0xz3TzuUhYEBv6Obk=;
 b=XWcJWlDss3cxDaHIw8EatbXnLKjjMRFLZXmcmS5YtQLjSmaENUaYXxFuMxPfVUBM975Tex
 x+rajYKNDlAFFoCXyze0NrNUqU/vhUzhoRenwXhnfG3R9gAZG2RwsyTkyhjpqSnab2qq1O
 +u9DQeDlwp8e4d4laLCkYHoWtZFC6DY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-JWRvrGG-Naax3gnfxT95Sw-1; Tue,
 18 Aug 2026 07:17:38 -0400
X-MC-Unique: JWRvrGG-Naax3gnfxT95Sw-1
X-Mimecast-MFC-AGG-ID: JWRvrGG-Naax3gnfxT95Sw_1787051857
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 031AD1955DEA; Tue, 18 Aug 2026 11:17:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9158430002E9; Tue, 18 Aug 2026 11:17:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:44 +0400
Subject: [PATCH v3 17/74] x86: convert OnOffAuto properties to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-17-24b8bbbe3d86@redhat.com>
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
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6518;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SgZyvSyb89GMp5FbVLfodHDTHOL+fqH6tT2LZO1GJws=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD24WWzVM6qFkskaUHqxWUevhNu6Nfv9IjUnw
 Z75J9He1PyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uAAKCRDa6OEJdZac
 5YTMD/4+OIeuy9cG1MwBjbIRBqgCt8XZRAYwF6YFrUNllb3Af//TfpYLfTXS85JMYOABw1YIKUk
 ytBT3RXdzx4R43wbtOzuOPZEqFOEvELRPhr8K6gbAUWpuVaqfXtvCzAZdCVC/BN4/90ieBsryBs
 K+STZx8PZQrI5HMVSwaeRlo4EhFJpLXxGjgYvHUvFUhY41ByOr2AX3L3tF4pMx5K7Pd2x4re2mx
 mR8nwmdbgfN5/+d++9kgPid1QAjeXxmN9oHPKwrKYwSXkFM/GGRI8lUIagU+7Kd/nCvKrFxzxT/
 W2AfVByUzdENZniZOi2hbF/z8XJF1EC5Q3gxyW9b0wxwLQldW+sLxXot5++7PTj5qm+/lGrD3jL
 YpHSsEwz3oRmGOguJ2vxybpZfCW+b1pzvURDAi3tSlcU+lPITTaHjMiFA/HzF2PxdHO868uWA0M
 pXSHM+pwp8OfL6jhuz1UagvLHOy64W9GS3T9J8DkTedZLkxwVd7FcrFMvnySQyEmLSJjoOjIitL
 IlNB23Wmjz7GzfqVym+CQHxXvkJOuNZ/lVZOPM++4aZK22YDAUfIZ0uGB6xkvz0fW7Am3n6ZO6k
 a7z1iYS4yI3yAi0veCFJ2At6rJd9pU2JV3wxuiF8hfYfj/Tib1iBo67PhMEX7OXQZXVSAaExeko
 ZiS93wi57WfHSfA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Convert the smm, acpi, pit, and pic OnOffAuto properties from
manual visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/x86.c | 104 +++++++++++++++++++++++++---------------------------------
 1 file changed, 45 insertions(+), 59 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f8ba3244e221..63f297a10532 100644
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
     nc->raise_nmi = x86_nmi;
 
-    object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
-        x86_machine_get_smm, x86_machine_set_smm,
-        NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_SMM,
-        "Enable SMM");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_SMM,
+        .description = "Enable SMM",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_smm,
+        .set = x86_machine_set_smm,
+    ));
 
-    object_class_property_add(oc, X86_MACHINE_ACPI, "OnOffAuto",
-        x86_machine_get_acpi, x86_machine_set_acpi,
-        NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_ACPI,
-        "Enable ACPI");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_ACPI,
+        .description = "Enable ACPI",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_acpi,
+        .set = x86_machine_set_acpi,
+    ));
 
-    object_class_property_add(oc, X86_MACHINE_PIT, "OnOffAuto",
-                              x86_machine_get_pit,
-                              x86_machine_set_pit,
-                              NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_PIT,
-        "Enable i8254 PIT");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_PIT,
+        .description = "Enable i8254 PIT",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_pit,
+        .set = x86_machine_set_pit,
+    ));
 
-    object_class_property_add(oc, X86_MACHINE_PIC, "OnOffAuto",
-                              x86_machine_get_pic,
-                              x86_machine_set_pic,
-                              NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_PIC,
-        "Enable i8259 PIC");
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
2.55.0.543.g5ebe2ebe4ea8



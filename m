Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B54C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54H7-0001g4-HX; Fri, 11 Sep 2026 12:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54H5-0001Uc-7t
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54H3-0006Xq-Md
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lpC35gmliS0QhA1JkmfqWaHkZxlzKVeH5o0OEMIMN4=;
 b=YQUkmIbwQuxBr9+icPZtPuSw/EAnRS+Zo+LYojFkTfsjnEFiMLhvIoX6GBjeyG9fxjdio6
 Q6LGZav2hwTSDhEzmiGxW1wO6VG2ThgR4iLxJ2S3LXfDLou4usLV/l7etxQ9u1I0NYJYRG
 ynGAD0wukVuo5uCHUSpN33asS+Z+p+8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-tA0paACZNHGTUu7cEE-MrQ-1; Fri,
 11 Sep 2026 12:38:45 -0400
X-MC-Unique: tA0paACZNHGTUu7cEE-MrQ-1
X-Mimecast-MFC-AGG-ID: tA0paACZNHGTUu7cEE-MrQ_1789144724
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 858EA195E912; Fri, 11 Sep 2026 16:38:44 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A625195608F; Fri, 11 Sep 2026 16:38:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:55 +0400
Subject: [PATCH v5 21/62] arm/virt: convert OnOffAuto acpi property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-21-7732a55b7760@redhat.com>
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
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VEvZEB5tSbvTYsPJm20+OtQi7DOxjCPx8lu+wm1r8Ps=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC24UsnAuXMKLk9QqxMhFfDZx6P7EDZ2q31rJ
 YpiU4FS9ACJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuAAKCRDa6OEJdZac
 5e1mEAC0JDvHGC4iKIE2gEKffiCT+w/oGHcOeoR0nAmPMkzBVH8mrHBDsdjGYds0LqnUQahr2SP
 ZySlmdjhpr93sTz3lVi7hdaiHbcnYZGyJjxOMP8i5ztapvZj/7OJ3ralgxZZVsLY5sEYrhHftyt
 5RI3M+wZ1sdId94jVa5jc9CSgxiATt6e0nqGt9td8sFUMPbqBDWx0RRpCGzK4J2VEXkbwVunSaQ
 7X+Tknuw+2+FgosXSpKZQVRosmj2aZnYyIM5+EFwRWwTOSYwyinwS1CKujuphIh6Hk7YpDklPwM
 C212Up8eNyJa71YRq2MjLdGBkGVoUGcGuCenULFsr3DUkKlZmtkDzzZ5RLpB/CPOXbrk+bJTppJ
 eccS90oyOlrKB8McAzZv5NNlEABYeTbpMZwN0RvycfV55uX0nXH/1kK+oCF/nnL9sNqTfXNaYGn
 jdS5jGALkOyyJRE34cvSlnBYj5eryG6QUZaK94lJRMLK570wXKkhSY/P3w0QJslCt+sTh54gl7s
 LVYMB4+mTQ4FiCTkvJaRb1XRV21OCOvfyFv+n798VSe/N8ram3wh2TS6Fce/CRaCRjnLMFcu2aa
 5SCXEnqMVBrqHdNwzYLjOxSE0YOeuw9wrpSC8UPH07wzwXinmny7/BsdZSVVx3c9eGRDqQYNZ2g
 OoyMHrtGLnouABw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Convert the acpi OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/virt.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0871a35e11f7..872920b6482b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -73,7 +73,7 @@
 #include "whpx_arm.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qobject/qlist.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
@@ -3567,21 +3567,16 @@ bool virt_is_acpi_enabled(const VirtMachineState *vms)
     return true;
 }
 
-static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static int virt_get_acpi(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
-    OnOffAuto acpi = vms->acpi;
-
-    visit_type_OnOffAuto(v, name, &acpi, errp);
+    return vms->acpi;
 }
 
-static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static void virt_set_acpi(Object *obj, int value, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &vms->acpi, errp);
+    vms->acpi = value;
 }
 
 static bool virt_get_ras(Object *obj, Error **errp)
@@ -4208,11 +4203,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "mach-virt.ram";
     mc->default_nic = "virtio-net-pci";
 
-    object_class_property_add(oc, "acpi", "OnOffAuto",
-        virt_get_acpi, virt_set_acpi,
-        NULL, NULL);
-    object_class_property_set_description(oc, "acpi",
-        "Enable ACPI");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "acpi",
+        .description = "Enable ACPI",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_acpi,
+        .set = virt_set_acpi,
+    ));
     object_class_property_add_bool(oc, "secure", virt_get_secure,
                                    virt_set_secure);
     object_class_property_set_description(oc, "secure",

-- 
2.55.0.543.g5ebe2ebe4ea8



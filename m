Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6174AC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a4U-0008UR-KQ; Fri, 04 Sep 2026 15:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4T-0008N9-2F
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a4R-0007xY-Jh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lpC35gmliS0QhA1JkmfqWaHkZxlzKVeH5o0OEMIMN4=;
 b=UXGlrL9XretG80OIp3Fg0diw0TOlmqhCBJI4wgaIAppZ8yMYB4RlcI0z3uXHIFuZGvGD/X
 Po+yybNLy4VkUYOdTLfiVxJBaW0IRyujwYou6FKlDUTUio/KDix0BgqwU5V4iRbiSdM/ma
 zg1K1vwGZ8rXUUQ14RoFROd9ffWmWRs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-8i0tEDf3N3qKvRcq5y3OyQ-1; Fri,
 04 Sep 2026 15:59:26 -0400
X-MC-Unique: 8i0tEDf3N3qKvRcq5y3OyQ-1
X-Mimecast-MFC-AGG-ID: 8i0tEDf3N3qKvRcq5y3OyQ_1788551965
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EB6A1956047; Fri,  4 Sep 2026 19:59:25 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 672A91955F0D; Fri,  4 Sep 2026 19:59:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:04 +0400
Subject: [PATCH v4 21/75] arm/virt: convert OnOffAuto acpi property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-21-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLJ/fLQRfE/vroLpHvG+0f9Rk8Szia1Mg+uW
 ZLOi25zyV+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyQAKCRDa6OEJdZac
 5YbUEACRdNG2sNnnT77kOmUNszO4+GO37PX+dBHqqej/DTyrIzYP8fDRaHHwKm+qjnHcqvqzmda
 mjvh+fWtIOdhNerJTtVC7E2NSIXG3y+AECQ32jMjDoopNdEUki4VJ0IEh2D92V/l6Q3zZGkD6GN
 JVReXOOzmU7N1aV3H4+WA8+ziCauJBF7MvnLnGPoSgFmKqQCuVe3YX0RNEcIrKCXZGlT4zpUlI1
 v6aHwYRrRWsX87YO4QdImbgSU+eczpb1mcMv0EsCWvUkO+dPmsrr4mKZb1Dxr79cOrIyRTi/tg6
 +sKfv1QLYwDcVNdD+EuMN+S3ikPiaSLMCs/HXq64AAOtURFh8bp7xLDQicd3anKHEsadbJJHeeO
 j2jVXAZNiZZvPVhbs1DdXiCmW1Y+wj2AUJMZLrbEwCyY2pKBBENvauF4fy2PeQN1rh3gHycW3jI
 7x86VBZfJqIFarR5eXENAry6tqQlvXSSnFF6sQM7B684u6fFCyezb30oZnEYMAPqjw/OVW2nIlo
 3oYXw259aJkf7H8mJceWAdjKPna3pk07no9eKfHUeG0OyTCxv+JJf7ENDdMpxEkOkUxct6wCb8O
 oCeNZWLHpvLni667VW+brsc0enr7VaHfj2lTnReHvYcCLWb0oebQw/XFSspZj/BMZNbK7NQg1eu
 LD3FQL1hDq0f1gA==
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



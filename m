Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDED0CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4W1-0004Xf-Ap; Sun, 10 May 2026 09:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4V4-0003rj-M5
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4V3-00057R-88
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB75Ye8pK8wFpuDAX3oRKzLaJhiRW6tuCzi7k6hh/tM=;
 b=UY1uPPyAsr/ZnKIbaqMidtRw4LFH6ue/to61gVORBaUS39PU/hiNNthJckxjL33ofSVkhW
 XINev3KLuja/VxRxKBO1VcCuGIuqjKwwhclS8HJfuDhOaoG33Zef1ihr1A3BOYZAvaPITj
 GmomasMMBtO6gisRV8QXAD/ZDO29ohc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-4SrzJpIuPEqFHUivYtFupA-1; Sun,
 10 May 2026 09:47:15 -0400
X-MC-Unique: 4SrzJpIuPEqFHUivYtFupA-1
X-Mimecast-MFC-AGG-ID: 4SrzJpIuPEqFHUivYtFupA_1778420834
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F1B819560B5
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:47:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AECB91800352; Sun, 10 May 2026 13:47:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:16 +0400
Subject: [PATCH 19/54] arm/virt: convert OnOffAuto acpi property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-19-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+lggsc9y2Az4imzVXGrupIXX34Zn6fwQfsIsTkLWaqU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItv/ORAVjleBbyoJEMfhlailgCifol3Nfsdd
 Y9b1l/2UH+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbwAKCRDa6OEJdZac
 5TFDD/4rBYOZEpZnRwaZtifRoQB3a4EVahAhpbxywgMP7WTUP+K5nF8xwaR0xsqjTOctMD9/0Vs
 yjvDaFg0YOUAHzj6gx1kwzsvxhmMqcIjRdfQ+dGuC055WDSawKsRz/0jnqThQh/15niAmIf97HS
 MrIZPUKn61KP8PfTayCqppyoFHaojbUBuOszn20n82tDtldx3FlL25WK8ZImAcoensnzIq8Mjzv
 Q57ujMqQjsDN4UWfSrkZEmS4rAxY+r5eJfB/CfvOEqOgH8F+YWoSg+PAEA0B7e2TDFnz8mrOTte
 SwSVJ3LKzKyVf7qbwHWBtkLhcsarwOrAG7pmX5F7+yEppuckxAHNkQniJcAOrXABGRKs04lWn6U
 srK2+KZdEDGHDNXrvOJfoOa487GLVk3GBRkClTURnFx4Tx5/172GIDol+fJvpVE5xtXaz++GiFX
 w49XIGkhoFalTdRREaj6h7bjMCqZCLiim5+pMp0M5bZZ3+m7cNS77EV+uH82zfYX2k1o4Enx6X6
 SyX7Ok4FlmCLM2rgSziKHviQ0U4qCdRvPt8PMcme/8856zcTxKN8Q2kY7Hd0qIJ38rp+0sXE5MV
 hbZyBpUn+cCNVp9UWZdk+8y7EWhgdnRvxO0aJm1eNbqCa9Ay0Z2N8LnzXRtbLoBonBlvZkbzN3t
 7CxiukqCWq+zVCg==
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

Convert the acpi OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/virt.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fe19030886b..e4c75cb1bae 100644
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
@@ -3267,21 +3267,16 @@ bool virt_is_acpi_enabled(const VirtMachineState *vms)
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
@@ -3868,11 +3863,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
2.54.0



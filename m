Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CE6076718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IHdQACXu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtEE-0004Bn-G4; Mon, 02 Nov 2026 09:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDD-0003DT-Er
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD8-0008St-DZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nbZ5E9fHzmmAnJIvysDy2BShswB9qDp+uq7No+2dE0=;
 b=IHdQACXu1sbTz4DKnNakLfmgagJNyG+w2/bzWRjv9U2IYgPVfLnIFFMOAQJ3rXcj/tuT0e
 kU5j/Wm83nuTLw1oNC0uqgEFSXIvaj8U7E0riPKyDZnSSfOK6TndkYTAyTSIo0GmH08fVW
 Tj4MmCf0keBf0RXOgOU8QrplPCeOrEo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-3jJBa1a4MruLgM66V1Ui6A-1; Mon,
 02 Nov 2026 09:40:31 -0500
X-MC-Unique: 3jJBa1a4MruLgM66V1Ui6A-1
X-Mimecast-MFC-AGG-ID: 3jJBa1a4MruLgM66V1Ui6A_1793630430
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2624E195BDCA; Mon,  2 Nov 2026 14:40:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5CFF1800347; Mon,  2 Nov 2026 14:40:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9AA3C21E6832; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/74] riscv/virt: convert OnOffAuto properties to QAPI-aware
 registration
Date: Mon,  2 Nov 2026 15:39:45 +0100
Message-ID: <20261102144018.3212223-42-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Convert the acpi and iommu-sys OnOffAuto properties from manual
visitor-based callbacks to object_class_property_add_enum().

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-25-armbru@redhat.com>
---
 hw/riscv/virt.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 65f4c67bff..31fecdc964 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -58,7 +58,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
 
@@ -1055,38 +1055,28 @@ bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
     return s->iommu_sys == ON_OFF_AUTO_ON;
 }
 
-static void virt_get_iommu_sys(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static int virt_get_iommu_sys(Object *obj, Error **errp)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
-    OnOffAuto iommu_sys = s->iommu_sys;
-
-    visit_type_OnOffAuto(v, name, &iommu_sys, errp);
+    return s->iommu_sys;
 }
 
-static void virt_set_iommu_sys(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static void virt_set_iommu_sys(Object *obj, int value, Error **errp)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &s->iommu_sys, errp);
+    s->iommu_sys = value;
 }
 
-static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static int virt_get_acpi(Object *obj, Error **errp)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
-    OnOffAuto acpi = s->acpi;
-
-    visit_type_OnOffAuto(v, name, &acpi, errp);
+    return s->acpi;
 }
 
-static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static void virt_set_acpi(Object *obj, int value, Error **errp)
 {
     RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &s->acpi, errp);
+    s->acpi = value;
 }
 
 static const HotplugHandler *
@@ -1184,15 +1174,15 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
         object_class_property_set_description(oc, "aia-guests", str);
     }
 
-    object_class_property_add(oc, "acpi", "OnOffAuto", NULL,
-                              virt_get_acpi, virt_set_acpi,
-                              NULL, NULL);
+    object_class_property_add_enum(oc, "acpi", "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   virt_get_acpi, virt_set_acpi);
     object_class_property_set_description(oc, "acpi",
                                           "Enable ACPI");
 
-    object_class_property_add(oc, "iommu-sys", "OnOffAuto", NULL,
-                              virt_get_iommu_sys, virt_set_iommu_sys,
-                              NULL, NULL);
+    object_class_property_add_enum(oc,  "iommu-sys", "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
+                                   virt_get_iommu_sys, virt_set_iommu_sys);
     object_class_property_set_description(oc, "iommu-sys",
                                           "Enable IOMMU platform device");
 }
-- 
2.55.0



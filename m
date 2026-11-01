Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13F606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=doiveBNM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc1H-0006La-0X; Sun, 01 Nov 2026 15:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzg-0004ra-PF
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzd-0007AV-32
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvV5cI3E2ha6ruHv165a0fCyfphNnmtO2pq8RN/esRE=;
 b=doiveBNMaDuQDFmTH0crUzaU5lC3o1vwmglC9zjfLwbROi23EY9b9YO5A9cHqesmY9ZvnR
 a3EuaeIppyxXvzd4x8keP9y/XxGl7UgytZ6pCQdxepNqVxxXmkBUHDVyu5zjjNQxys6X1o
 gdL2XE1pog8RCGeV7ZrM9wraPrNQH9w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-8dV_e344NZSQEOk1rLs9Kg-1; Sun,
 01 Nov 2026 15:17:26 -0500
X-MC-Unique: 8dV_e344NZSQEOk1rLs9Kg-1
X-Mimecast-MFC-AGG-ID: 8dV_e344NZSQEOk1rLs9Kg_1793564246
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBEFF1955F6E; Sun,  1 Nov 2026 20:17:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96F1718004D2; Sun,  1 Nov 2026 20:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0AD0E21E689C; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 24/56] riscv/virt: convert OnOffAuto properties to
 QAPI-aware registration
Date: Sun,  1 Nov 2026 21:16:45 +0100
Message-ID: <20261101201717.3911097-25-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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



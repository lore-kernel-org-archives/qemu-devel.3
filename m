Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B5ECD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE5n-0007f0-Qj; Mon, 15 Jun 2026 16:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5n-0007dP-2X
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE5l-0002bk-Gb
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OKcE1tBHE4ezXS8ORt03lDrgoDt2tSDBjHLWw4GEYY=;
 b=ck55HigGm0v4fRF+A+NB0HvKcSrWHNuZiw2KWBQFS6U5Tdtc42e8+YhgcEEPtWwuOL9lsE
 6ZiKqTJB9YRq+neP6MpG5vS2pip+5GjHqzurSfKHUg82RPbTSkA7w/emOAQPHDBVkgJWoU
 hiOYRP3Xm+qn0ulpx/f8pARXzZeHi2k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-hTf2mXObMT6iUVqBTlDaHw-1; Mon,
 15 Jun 2026 16:39:29 -0400
X-MC-Unique: hTf2mXObMT6iUVqBTlDaHw-1
X-Mimecast-MFC-AGG-ID: hTf2mXObMT6iUVqBTlDaHw_1781555968
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 816301956064; Mon, 15 Jun 2026 20:39:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DB53195419D; Mon, 15 Jun 2026 20:39:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:46 +0400
Subject: [PATCH v2 20/53] riscv/virt: convert OnOffAuto properties to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-20-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3914;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uR6kVLaM8mSy4Bf8TP3PcRSxK9XSaw4JpV1OTvl+FF8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKOQoEmnkfmdqaO1WnJgBgY8UJ3zTVPnL623
 BH5BMw+yuKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5dSvD/sFGSRNCCuj8HGW+KNshZRRsxN4UUpZdRSXswfYulHI6MLg0mHAEwrSdBkqdBA4vaGlORT
 Aor/0Ikcnfw+5g0+N5D9GBoLSjqXPHS3/cc1qpt/zXxbvSBLDQdZMw+JK9yTSwg71ETDP8p3r8r
 Ei6/c16dFjJc8U6Vfxsi/JUBEBiBaidn213My1C6qu/zbcv4iZ9NPFJs7hqYM9jWOqlxJeV78Tl
 CwoMaDy1/IRvPUZggXfmOWC2jV5gk0AAgugybCNrr0/eTFAdZtMPwBKDbyQfHFEog+xaGiaryjy
 JDWagg7XDB0L0I306iWFgpBdYto2u5svQvVLf81F+mhJQAxPl7qt7itHUCgxCfI+armrLybBWOE
 OUW6/zZiz0amU8qDxa+J6IHIdwbtjvwi/7CdSJeXYjczMkOvEvqLyoPq5+XFxmtjUuzkbHseVrL
 Dv6xV2v6J2rISHAgjQYkaMLSUMFu/UuWJvYMKBGspDGbSM6s9/DCbU3KSIfOtpDKohxJbdzu+Xp
 w10gkSvn3ErYYn0qcJoPqJUwoTvKTyQ74L1NAaDlZF/KVWL/u/EfU6pJ5xfI5/kUoQzhEU2lpVH
 wGgZrog2BBSSACYU7Vc8nkQFjJYlO7mz2VxKa+7iYx4HjTl/yH1l1zAxGD4MJaJ35AQeC1u+gDQ
 341bKhorK+RCguA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Convert the acpi and iommu-sys OnOffAuto properties from manual
visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/riscv/virt.c | 54 ++++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ce64eaaef7d..65c3e27ec85 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -56,7 +56,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
 
@@ -1846,21 +1846,16 @@ bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
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
 
 bool virt_is_acpi_enabled(RISCVVirtState *s)
@@ -1868,21 +1863,16 @@ bool virt_is_acpi_enabled(RISCVVirtState *s)
     return s->acpi != ON_OFF_AUTO_OFF;
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
 
 static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
@@ -1980,17 +1970,21 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
         object_class_property_set_description(oc, "aia-guests", str);
     }
 
-    object_class_property_add(oc, "acpi", "OnOffAuto",
-                              virt_get_acpi, virt_set_acpi,
-                              NULL, NULL);
-    object_class_property_set_description(oc, "acpi",
-                                          "Enable ACPI");
-
-    object_class_property_add(oc, "iommu-sys", "OnOffAuto",
-                              virt_get_iommu_sys, virt_set_iommu_sys,
-                              NULL, NULL);
-    object_class_property_set_description(oc, "iommu-sys",
-                                          "Enable IOMMU platform device");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "acpi",
+        .description = "Enable ACPI",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_acpi,
+        .set = virt_set_acpi,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "iommu-sys",
+        .description = "Enable IOMMU platform device",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_iommu_sys,
+        .set = virt_set_iommu_sys,
+    ));
 }
 
 static const TypeInfo virt_machine_typeinfo = {

-- 
2.54.0



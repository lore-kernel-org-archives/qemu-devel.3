Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A42C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHpf-0001pw-BT; Tue, 18 Aug 2026 07:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHpd-0001mm-S8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHpc-0005mM-BV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1p0wsYe7wILmnAsGR4qYZN8ofy2xkguhRxrrZLXdfA=;
 b=ZEHC5X0vjn/zNS6JuMDmZR559EztGwt3hg8t9maKCMwIxR7cpCK8Sue4XvAS8+Xd6N8pZB
 mYqjPI9cUPUK7vRmyxCT7zZ/Rhnz+xopsaigABg81Qh6aSCAhRvbmeli8Qc2IBjc+2qlLH
 +8viuNHyzPaRbefpBPUCpIOOuZhwBp8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-RQMl-zzHPIirTArsAxtdhA-1; Tue,
 18 Aug 2026 07:18:10 -0400
X-MC-Unique: RQMl-zzHPIirTArsAxtdhA-1
X-Mimecast-MFC-AGG-ID: RQMl-zzHPIirTArsAxtdhA_1787051888
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 611611955BC5; Tue, 18 Aug 2026 11:18:08 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 940371800347; Tue, 18 Aug 2026 11:18:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:48 +0400
Subject: [PATCH v3 21/74] riscv/virt: convert OnOffAuto properties to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-21-24b8bbbe3d86@redhat.com>
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
 Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3984;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mvmbn+YpXxLPFQ3gkFotdxJS6BhWegqsWmBOu8ZuxEc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD241ugGadiTWVsKPuYJyMR+D5sEhA/L1YZO7
 48fe9Xz5i6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uAAKCRDa6OEJdZac
 5X8GD/45sKv79Nk2Swc6iLiavySW+TwiLBWgPevmhGT4anAWpfHIWKjcjldirlK1xjeyGKi9ZK8
 nOodKsBHqpZmdx9yLuFQJRjWqze5M8D9p04M4cFtxY7b9RH8JhNmcRok+9iw+b1ubGMi4NmOFF1
 WHxfC5wQ21WbObyvURB24rEw/5ETVdCCNz72W2f90wfs1yqmbpekDRrVoz92LpCHRkhaOisXM7M
 MMq5I+HT+bPYaK1NUkd7OxpyvSNvCqckEbkilsIw7+YtabxPGeD6KdnK9MGrK7EiNWn3GG3CxXf
 EpFjNhVjo1/ZSFs9tUa29pGxsH3PRrmhvLppqC8hH353ypjGHoXmoqfT16jyJA3M4Fy6JmEMT79
 m1vKFoqPlMBtyFZ6fNh2CsysfF/Saeu7XfPL932DaryzcAp61J4W9ZokoId0BNwYSOVpZZl2beS
 G0L76IyCoLi0KCyfK8IARQVjZug6J8pyAPXs1bmiA8MV2e1iZc7mEyNcBBqWbObHoVd05nuR/EB
 dEQ7RCCZ5p54JQWDXJRekKFw3PgSBKsnaUnOGZrJdu5NPWbO0gXbX+Nxs7g4i5eq4quAndNv8x8
 YmDC4D/6Nd2PD6fG3F4AQP0ohuHshotwnpXOv9rYy9py6/e5Nf8ZsGuky2l9NVSTyZ5X6TH5XhD
 6iHb32Z5VRB1fFA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Convert the acpi and iommu-sys OnOffAuto properties from manual
visitor-based callbacks to property_add_qapi_enum().

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/riscv/virt.c | 52 +++++++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 51bac47a91d8..5ebce4a3efc9 100644
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
 
@@ -1635,21 +1635,16 @@ bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
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
@@ -1657,21 +1652,16 @@ bool virt_is_acpi_enabled(RISCVVirtState *s)
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
@@ -1769,17 +1759,21 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
         object_class_property_set_description(oc, "aia-guests", str);
     }
 
-    object_class_property_add(oc, "acpi", "OnOffAuto",
-                              virt_get_acpi, virt_set_acpi,
-                              NULL, NULL);
-    object_class_property_set_description(oc, "acpi",
-                                          "Enable ACPI");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "acpi",
+        .description = "Enable ACPI",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_acpi,
+        .set = virt_set_acpi,
+    ));
 
-    object_class_property_add(oc, "iommu-sys", "OnOffAuto",
-                              virt_get_iommu_sys, virt_set_iommu_sys,
-                              NULL, NULL);
-    object_class_property_set_description(oc, "iommu-sys",
-                                          "Enable IOMMU platform device");
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
2.55.0.543.g5ebe2ebe4ea8



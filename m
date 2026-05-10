Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3749ECD37BC
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4WB-0004qx-Af; Sun, 10 May 2026 09:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4VG-00040T-5s
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4VE-000588-JJ
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZT3Yl01MVKTtVMyH6IlztVF9/tm42DD2dHPy90kCxU=;
 b=US9J8GWcoYn7ghsynkPTV26TXfy/ZAM/3kZgGrXeRwCIr7NuhCeLBJW+DJqbCi43Jnvcwo
 kdS8D3j6uebEdeTTwjhQXHKfxJH6U/4OZyJmOtCoLE7TeOKGLK1bNK1aUCvT6EyliKODqU
 2ZiJ06Do0rSPKVVmYT2BQBLRLuTNHDw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-JNq9szX_M9CYP0ryj8Z9ew-1; Sun,
 10 May 2026 09:47:26 -0400
X-MC-Unique: JNq9szX_M9CYP0ryj8Z9ew-1
X-Mimecast-MFC-AGG-ID: JNq9szX_M9CYP0ryj8Z9ew_1778420845
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4E761956088
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:47:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8319C1955D84; Sun, 10 May 2026 13:47:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:17 +0400
Subject: [PATCH 20/54] riscv/virt: convert OnOffAuto properties to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-20-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3914;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Xq10Utl/I4ulIkL29AFDE/OGEVdWosO49c5rxOXmNQA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItvLi1gh8Rkaxvp/d+zOqhV3XaTRyn2EXOM5
 zR72TL5+7yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbwAKCRDa6OEJdZac
 5QvND/0XT7xMhWk4QjM7h6Rrv8s16PEKD71fTUuR99dmerJdQ1DEPXn7xCIX0mtzZzqg75z/sNT
 2mLPOrGYmu44A/J1rV7Ho8NhXrVb5GrH/O1d9vhYm5D+PY2vpO4L31JOO/xUnaTu/ioINY9XX8I
 XEisFALAQim0he1aSb/Ip+j5I+GXxpFj1DTNHOSXqq5ik0aPcuW4hgueIfy7y64K4Sm+f4kMnOZ
 Epf9i1c6U/tYmYCcUUUQNv2mxyi93ZNh1kS8NanSbjgXjtS35QWi7LIoP4QuikV1F2c/bnyuXrN
 3dSBx6n1Gz3RLenvFwPR6LPQEl27QZ71MH93Sa5UEkG2+aOixBgFW0Lt0d24IG9PX7sNNIkcXdZ
 GBIQBfsM1M5oJM/ia8yeJp36VfiZKeiKWd7A8vQcetv4welPEQZFMXaZJnhfeSQaiGBw7Qmt6Hc
 /iD+bkifoj61tTDoLyJJ/yBJONKgDMGD2E9yoFrNHtg25A67qfwy75qC5+rj7TKbi+psbhgby5X
 rrYU5CL8rmo/4P4K8r3+nwv513RHGnIB5DsTTzynYkc5Mf8CV7uVh8LF7bcSIQbPTDDrf2nHzQi
 3h1vXt8OG7ISQOQi+9swzMfQx5pLFHSMgz70vh/TfdZGViDB1E1lCD15MvRgbKd7Ct/joAyR7Iq
 nQwyMWof0WtTkdg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Convert the acpi and iommu-sys OnOffAuto properties from manual
visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/riscv/virt.c | 54 ++++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a1c323e66df..5148044df95 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -55,7 +55,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
 #include "hw/acpi/aml-build.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
 
@@ -1832,21 +1832,16 @@ bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
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
@@ -1854,21 +1849,16 @@ bool virt_is_acpi_enabled(RISCVVirtState *s)
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
@@ -1966,17 +1956,21 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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



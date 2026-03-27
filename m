Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D729210F285E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6B3E-0006fb-MZ; Fri, 27 Mar 2026 13:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w6B3B-0006cy-KN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w6B39-0007zP-CR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774632766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pN4OiFiCaqsGj9lyQmbZVPazjyuFfOnaBFT4eYnbIuU=;
 b=fRPBNdCRQkSWX3ddSOy0xy1XlgUhkB7H7jHbp2bC9gaU+wPE6xB+tIyJHgJVOhDejR6I+G
 B0RZ31CiV1bS3m5Yts4Ys6AeyekIcrfUAqKz7Ta77A8Z5+De8JoX+dRSFVfg6B8iuCBizG
 4RTvpM30IQbf3U7oh28JcH/q69+8esA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-SDElpmZlPJeI79AtHzENaA-1; Fri,
 27 Mar 2026 13:32:44 -0400
X-MC-Unique: SDElpmZlPJeI79AtHzENaA-1
X-Mimecast-MFC-AGG-ID: SDElpmZlPJeI79AtHzENaA_1774632763
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B62C3195608E; Fri, 27 Mar 2026 17:32:42 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.bengluru.csb (unknown [10.74.88.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C4C53000223; Fri, 27 Mar 2026 17:32:36 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, pierrick.bouvier@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, mohamed@unpredictable.fr, philmd@linaro.org,
 Mohammadfaiz Bawa <mbawa@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 3/3] hw/tpm: add PPI support to tpm-tis-device for ARM64
 virt
Date: Fri, 27 Mar 2026 23:02:09 +0530
Message-ID: <20260327173209.148180-4-mbawa@redhat.com>
In-Reply-To: <20260327173209.148180-1-mbawa@redhat.com>
References: <20260327173209.148180-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add PPI memory region and ACPI _STA, _DSM to tpm-tis-sysbus so
Windows 11 ARM64 guests no longer log Event ID 15 errors from
tpm.sys on every boot.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 hw/arm/virt-acpi-build.c |  9 ++++++++-
 hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 591cfc993c..5b5ac551f8 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -240,7 +240,8 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
     Aml *dev = aml_device("TPM0");
     aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
     aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
 
     Aml *crs = aml_resource_template();
     aml_append(crs,
@@ -248,6 +249,12 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
                                   (uint32_t)memory_region_size(sbdev_mr),
                                   AML_READ_WRITE));
     aml_append(dev, aml_name_decl("_CRS", crs));
+
+    hwaddr ppi_base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
+    if (ppi_base != -1) {
+        ppi_base += pbus_base;
+        tpm_build_ppi_acpi(TPM_IF(sbdev), dev, ppi_base);
+    }
     aml_append(scope, dev);
 }
 #endif
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index dd30344d5a..6bec30c36f 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -30,6 +30,7 @@
 #include "hw/core/sysbus.h"
 #include "tpm_tis.h"
 #include "qom/object.h"
+#include "qemu/memalign.h"
 
 struct TPMStateSysBus {
     /*< private >*/
@@ -99,6 +100,7 @@ static void tpm_tis_sysbus_initfn(Object *obj)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
     TPMState *s = &sbdev->state;
+    size_t host_page_size = qemu_real_host_page_size();
 
     memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
                           s, "tpm-tis-mmio",
@@ -106,6 +108,12 @@ static void tpm_tis_sysbus_initfn(Object *obj)
 
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    s->ppi.buf = qemu_memalign(host_page_size,
+                                ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
+    memory_region_init_ram_device_ptr(&s->ppi.ram, obj, "tpm-ppi",
+                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
 }
 
 static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
@@ -122,6 +130,8 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+
+    vmstate_register_ram(&s->ppi.ram, dev);
 }
 
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
@@ -132,6 +142,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, tpm_tis_sysbus_properties);
     dc->vmsd  = &vmstate_tpm_tis_sysbus;
     tc->model = TPM_MODEL_TPM_TIS;
+    tc->ppi_enabled = true;
     dc->realize = tpm_tis_sysbus_realizefn;
     device_class_set_legacy_reset(dc, tpm_tis_sysbus_reset);
     tc->request_completed = tpm_tis_sysbus_request_completed;
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E49CF532D4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 07:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4vub-00081R-UB; Tue, 24 Mar 2026 03:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w4vub-00080n-5N
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w4vuY-00079G-4e
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774336245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7kTtWTqiU66ByIc066QVeOHhPP2iNJIpp12BVMpRzwM=;
 b=KnpMlvRJM76XsPBogta/XwyOwwqrP2bO5b+phIcc4Lk6Hf99m/XXp3HexiwfJnbTVvRfNW
 JodNFLmFT/GHVZIwyuyNwcOWmB8EdFQjhU1Pz0yo7BPekFXpzdWYnyx0rDSt5yipfx2MAp
 IslCTnAzejbOevYeONTpk2JfZiGjEAQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-J4W5DqhDPXCucHZ2GbxA0g-1; Tue,
 24 Mar 2026 03:10:41 -0400
X-MC-Unique: J4W5DqhDPXCucHZ2GbxA0g-1
X-Mimecast-MFC-AGG-ID: J4W5DqhDPXCucHZ2GbxA0g_1774336240
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58863180047F; Tue, 24 Mar 2026 07:10:40 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.bengluru.csb (unknown [10.74.88.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3248219560B1; Tue, 24 Mar 2026 07:10:35 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohammadfaiz Bawa <mbawa@redhat.com>
Subject: [PATCH 3/3] hw/tpm: add PPI support to tpm-tis-device for ARM64 virt
Date: Tue, 24 Mar 2026 12:40:03 +0530
Message-ID: <20260324-tpm-tis-sysbus-ppi-v1-3-e59175210954@redhat.com>
In-Reply-To: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 docs/specs/tpm.rst       |  8 +++++---
 hw/arm/virt-acpi-build.c |  9 ++++++++-
 hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 63cc0b68cd79d64138d4dd05ae158430c6a74643..ba2b0d726745fdf8ebc4c73c9c42e1ff8047a9db 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -201,9 +201,11 @@ address dynamically at device plug time. The ACPI ``_DSM`` method
 and PPI operation regions reference this dynamically resolved
 address.
 
-PPI is enabled by default and can be controlled with the ``ppi``
-property (e.g. ``-device tpm-tis-device,tpmdev=tpm0,ppi=on``).
-Without PPI support, guest operating systems such as Windows 11
+PPI is controlled by the ``ppi`` property (default ``on``)::
+
+    -device tpm-tis-device,tpmdev=tpm0,ppi=on
+
+Without PPI, guest operating systems such as Windows 11
 ARM64 will log errors when attempting to query TPM Physical
 Presence capabilities via the ACPI ``_DSM`` method.
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 719d2f994e65f976f6e754259d0b4f1336f82f13..27a7389a33df221a9dfb0cde1bc35b3ab62e56be 100644
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
index e9372e7316305fe1a4d415a712ab516e0fd5f073..f8b63dd4607cacb319e27ea83e421ec5bdc1cb0f 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -30,6 +30,7 @@
 #include "hw/core/sysbus.h"
 #include "tpm_tis.h"
 #include "qom/object.h"
+#include "qemu/memalign.h"
 
 struct TPMStateSysBus {
     /*< private >*/
@@ -93,12 +94,14 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
 static const Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
+    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
 };
 
 static void tpm_tis_sysbus_initfn(Object *obj)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
     TPMState *s = &sbdev->state;
+    size_t host_page_size = qemu_real_host_page_size();
 
     memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
                           s, "tpm-tis-mmio",
@@ -106,6 +109,12 @@ static void tpm_tis_sysbus_initfn(Object *obj)
 
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
@@ -122,6 +131,8 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+
+    vmstate_register_ram(&s->ppi.ram, dev);
 }
 
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)

-- 
2.53.0



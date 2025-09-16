Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE06CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya61-0005aT-NW; Tue, 16 Sep 2025 14:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya51-0003EQ-ET
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:06 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4w-0001dl-0M
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso1222f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046004; x=1758650804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5YcFNgyROtM6LDiO+7+a0MCY/01CFYioeqjwFM/jXlQ=;
 b=GSvv1hQQnOR2B9/CisNNFnYYz6EGVYfwuSKYOBxeN9EImT2BYbZH8g5Hvat58SBqiU
 9I/QQ5IyI2JwH5T1xNTc5AYO176zis9zijWJAWLIywx2+zejaqtjdBK+X02FsSREk8/m
 KMdFwYonjKN5uLxZWcaCaAQcPvz1yWjBzffZftEZkGz5nPJktJaufXbyp98WTRwm9lBa
 CMNkI0rWglndcq3Ozgj0RfOhPgXyJpVUDaby6XwYFlSh/uWPd8xPvLdl3AwthKyIwv9u
 5iKmVBo4HcyRFvOn66d/wpFA/otpbQXfvVbp6zpvOv5jblCSfPMgT2D14oJzLlOLKhGz
 whYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046004; x=1758650804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YcFNgyROtM6LDiO+7+a0MCY/01CFYioeqjwFM/jXlQ=;
 b=uahcZ62rw3P4dxktloOk7V6nTFJvUVDvP1D3pEIfAsA9y+pB3TSytRLdqSn2n71r7x
 P9+lkWGDt78I+mJaQcCTDLMU0GDkDu5d55d0BtWsUYdoqtrbspZLfARqGV3YiZ2/Zwr/
 wbxXwfyXY/LCMQGYsHBuTULvOemwG+mD5OkyZlfSdo/eQ3rmeOzVTJFmOgKbUfAzksxT
 bDXJOcaNIVUqp10+ZrZL+NYRUHG1f8NkzNj9QVq+t7sWRJfk88o4PZPkeQ5tAY/DixHD
 NVCIZfqRdl+IVKj2B+p5ZXmmJkAUNTsw5Gx/sNNmNkH09u/Gzxuyef1S3K6MWWRi8HVX
 9Miw==
X-Gm-Message-State: AOJu0Yz7YEBbxDnmelK1EtFMUa/AZRdGtIxFK7r8yBprrXcdIaKCHBjv
 LZHqCOkn/UCK8JHwVrHzrQuetZxnQ2GSk9sQ5QmoOJPGaUIjBt3jN+hFS6fJF7m6aOk6aOdVCTY
 8Sqyf
X-Gm-Gg: ASbGncuHjiUSYKJS1du5902nZXvL/TEJBx3pOyGQBtxKtSHxVIE1P4U05+ODlXQ1bPc
 NT/RbOaTJn1sCBnlO73A0V+UWrPmaNPxKV8rglV5YqOG30aXp0uKn6Ipb0WFC9igIn1dK0hx1gK
 Tq6s3b7IVvjTNsVt3SoJDMj2GojgzuSLupJt7IqEfQxUm2D070TFxEs2jFSKNOpQ+i9ivNdpe8H
 q7Lu8mTHEX3jUSd9e2inISlkLlE86UBNII3KgYrIcf3aZcml8v30jtPhxEiT2HhcjlMAFHUyZUk
 v+45LYlBFdBpdIqjd7/exrPf2vUUa3EfD0ajPq/KDomcKr32MqJb9SYKrB71LzMKUZ+rGqV4B2V
 +iblEtGite1/NmZKQHZKUtnQR9IpN
X-Google-Smtp-Source: AGHT+IFocP3qVImHygfvnonGl76zqfDSo6eaQxW1Uikh6fABTfgMOgweweinPxXU5aeQSqxcCzhvXg==
X-Received: by 2002:a05:6000:2084:b0:3d3:b30:4cf2 with SMTP id
 ffacd0b85a97d-3ec9ec52f99mr2751336f8f.19.1758046004359; 
 Tue, 16 Sep 2025 11:06:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/36] hw/arm/virt-acpi-build: Update IORT for multiple smmuv3
 devices
Date: Tue, 16 Sep 2025 19:06:01 +0100
Message-ID: <20250916180611.1481266-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shameer Kolothum <skolothumtho@nvidia.com>

With the soon to be introduced user-creatable SMMUv3 devices for
virt, it is possible to have multiple SMMUv3 devices associated
with different PCIe root complexes.

Update IORT nodes accordingly.

An example IORT Id mappings for a Qemu virt machine with two
PCIe Root Complexes each assocaited with a SMMUv3 will
be something like below,

  -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
  ...

  +--------------------+           +--------------------+
  |   Root Complex 0   |           |   Root Complex 1   |
  |                    |           |                    |
  |  Requestor IDs     |           |  Requestor IDs     |
  |  0x0000 - 0x00FF   |           |  0x0100 - 0x01FF   |
  +---------+----------+           +---------+----------+
            |                               |
            |                               |
            |       Stream ID Mapping       |
            v                               v
  +--------------------+          +--------------------+
  |    SMMUv3 Node 0   |          |    SMMUv3 Node 1   |
  |                    |          |                    |
  | Stream IDs 0x0000- |          | Stream IDs 0x0100- |
  | 0x00FF mapped from |          | 0x01FF mapped from |
  | RC0 Requestor IDs  |          | RC1 Requestor IDs  |
  +--------------------+          +--------------------+
            |                                |
            |                                |
            +----------------+---------------+
                             |
                             |Device ID Mapping
                             v
              +----------------------------+
              |       ITS Node 0           |
              |                            |
              | Device IDs:                |
              | 0x0000 - 0x00FF (from RC0) |
              | 0x0100 - 0x01FF (from RC1) |
              | 0x0200 - 0xFFFF (No SMMU)  |
              +----------------------------+

Tested-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Message-id: 20250829082543.7680-4-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bef4fabe56f..96830f7c4ec 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -45,6 +45,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/hmat.h"
+#include "hw/arm/smmuv3.h"
 #include "hw/cxl/cxl.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
@@ -338,6 +339,67 @@ static int populate_smmuv3_legacy_dev(GArray *sdev_blob)
     return sdev.rc_smmu_idmaps->len;
 }
 
+static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
+{
+    AcpiIortSMMUv3Dev *sdev_a = (AcpiIortSMMUv3Dev *)a;
+    AcpiIortSMMUv3Dev *sdev_b = (AcpiIortSMMUv3Dev *)b;
+    AcpiIortIdMapping *map_a = &g_array_index(sdev_a->rc_smmu_idmaps,
+                                              AcpiIortIdMapping, 0);
+    AcpiIortIdMapping *map_b = &g_array_index(sdev_b->rc_smmu_idmaps,
+                                              AcpiIortIdMapping, 0);
+    return map_a->input_base - map_b->input_base;
+}
+
+static int iort_smmuv3_devices(Object *obj, void *opaque)
+{
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    GArray *sdev_blob = opaque;
+    AcpiIortIdMapping idmap;
+    PlatformBusDevice *pbus;
+    AcpiIortSMMUv3Dev sdev;
+    int min_bus, max_bus;
+    SysBusDevice *sbdev;
+    PCIBus *bus;
+
+    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
+        return 0;
+    }
+
+    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
+    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    sbdev = SYS_BUS_DEVICE(obj);
+    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
+    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
+    sdev.irq += ARM_SPI_BASE;
+
+    pci_bus_range(bus, &min_bus, &max_bus);
+    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
+    idmap.input_base = min_bus << 8,
+    idmap.id_count = (max_bus - min_bus + 1) << 8,
+    g_array_append_val(sdev.rc_smmu_idmaps, idmap);
+    g_array_append_val(sdev_blob, sdev);
+    return 0;
+}
+
+/*
+ * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
+ * return the total number of idmaps.
+ */
+static int populate_smmuv3_dev(GArray *sdev_blob)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   iort_smmuv3_devices, sdev_blob);
+    /* Sort the smmuv3 devices(if any) by smmu idmap input_base */
+    g_array_sort(sdev_blob, smmuv3_dev_idmap_compare);
+    /*
+     * Since each SMMUv3 dev is assocaited with specific host bridge,
+     * total number of idmaps equals to total number of smmuv3 devices.
+     */
+    return sdev_blob->len;
+}
+
 /* Compute ID ranges (RIDs) from RC that are directed to the ITS Group node */
 static void create_rc_its_idmaps(GArray *its_idmaps, GArray *smmuv3_devs)
 {
@@ -401,6 +463,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     if (vms->legacy_smmuv3_present) {
         rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
+    } else {
+        rc_smmu_idmaps_len = populate_smmuv3_dev(smmuv3_devs);
     }
 
     num_smmus = smmuv3_devs->len;
-- 
2.43.0



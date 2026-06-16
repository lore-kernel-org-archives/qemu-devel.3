Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F78CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAS-0006he-To; Tue, 16 Jun 2026 15:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7z-0004V5-EU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7t-0000yD-LD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso45362235e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636824; x=1782241624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pxe9Q4e15SUoztJVYM/EMV71jX5dkOv1tCM4I7rpjrE=;
 b=hh3LJUPXnmI+2My+tO3jm0b2PVsjsXo1+RFKBnhzKPJGXbUCnvkhf8SV+l9FPGhNHR
 tQBzJmu+DoqD3k9b5vMdL0KRytMdJSQRTLhT7lzJTZ80KNFQeB7QfaqWKmM5rKTYw8kU
 67mg6NNLK1Xw8MYlLFDz7JhyyD/Zu0dspL5r7BsLWJ80913vCJkBao9tuoX3qTzZZj0+
 ucdkScMrLuhNpBMQGKCgIoowTLFqXsAQ0Nn+B7BTjaclL3iQJD+AylMOrocCWfVSJ9tg
 a3Eaw+sF54NCDcu6isCxYaBhD0Ngi/MHm5tHWZX/7QeBQ+oV2R+DBXwr3z+QzmyEsKdz
 CnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636824; x=1782241624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pxe9Q4e15SUoztJVYM/EMV71jX5dkOv1tCM4I7rpjrE=;
 b=sHTRnY4YpIj39YLPJvb1CoqYCg5zgf8EksqTretbAW/x9ErtYIkdU9MgI8gfAgh08m
 W3D0AWatlHqGCADCHdo79GJJcGC582oIRZnZLPcgdcTwKHHvoNESH7J+DILyoyjQSlsJ
 Na7+C9FZJ9m66prDfDoM9jK0PbGBd0iI0VV2HKMnzVo3kZ7NHhvp0/jBKhIj1psuyXB2
 psxvTXFMEyelza1TWV4zyA4g4hujuWcYBG42i0d+OwbMKiUnJeA+w2LitHg0zFUcKUsa
 s5SXGKevPK46jlAeAcrAccw3v4zzlsM/w0RBDKasp5+IGDbP1yQdvUuoS5W8Hc6g23lG
 Ncsw==
X-Gm-Message-State: AOJu0YzKx0FxSyccwPBqKZHeGpa7g0/ksgYFqWRmW8LRqhwQfiCwpJw7
 BbM4e2d1IlaQ1K3xlU2d+c9P0tWcXmvEQqlwhg10FU7QJ3tevj7NNVKEuBPMuvT7CrEfFnmsmUC
 RHScB
X-Gm-Gg: Acq92OEiqWr5TYtmMVVfpCl6fbh8RisTauByGc+x8PQOFlcFj9XqxOH5wzur5g3ecOl
 7trpm4sH+aa0EG1x6JajjZIyE2S9t8e0K6ReOWVmcmwcwFzkXbt1K9WrXntxerEQAo3rhmbpHOu
 r7Rd83t1ehTPyFgoM6aEvs7nBowGGw+zJHqYNiJAPMD5acVe+cSUVHoiKU31YQhDy0B8OVeB7GV
 t6SIaMnQXaCyDUT75W/gfiNaPVO+jOGfYfH+A178T8UEaYazKWyUpNidYj5l/mz7QDhX2YOCrnZ
 fIsxDu4iXvX2kYow1N8ilIg3c9y9frrFJtgfKduREV6mSOVIy49rmNi1OwUEMUSkORokfMTK9Xw
 vXiqjoSUnZY6BxbcJArJA2bo+Sv/hir5LzTRYWSmTtATFfRp1l5uIl7kCpsDFUVitzm9sUvOtVT
 STWWvxZ/nRyhkvpBBqQGx2xV9bX6C8TDe54cz1WCzY8o+lqTe8lin5fnKf+kKnNdi0yZ5QCFQ1K
 /dgeRhIiDRiavHwnUBNICZxaygX98hT
X-Received: by 2002:a05:600c:c094:b0:490:b642:ce2c with SMTP id
 5b1f17b1804b1-492333af1b4mr11247535e9.14.1781636824066; 
 Tue, 16 Jun 2026 12:07:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/61] hw/arm/virt: Use stored SMMUv3 device list for IORT build
Date: Tue, 16 Jun 2026 20:05:56 +0100
Message-ID: <20260616190639.3462006-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Introduce a GPtrArray in VirtMachineState to track all SMMUv3 devices
created on the virt machine, and use it when building the IORT table
instead of relying on object_child_foreach_recursive() walks of the
object tree.

This avoids recursive object traversal and provides a foundation for
subsequent patches that need direct access to SMMUv3 instances for
CMDQV-related handling.

No functional change. No bios-tables qtest failures observed.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-10-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 70 ++++++++++++++++++----------------------
 hw/arm/virt.c            |  3 ++
 include/hw/arm/virt.h    |  1 +
 3 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3f285ff6c7..b00f3477ca 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -392,49 +392,41 @@ static int smmuv3_dev_idmap_compare(gconstpointer a, gconstpointer b)
     return map_a->input_base - map_b->input_base;
 }
 
-static int iort_smmuv3_devices(Object *obj, void *opaque)
-{
-    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
-    AcpiIortSMMUv3Dev sdev = {0};
-    GArray *sdev_blob = opaque;
-    AcpiIortIdMapping idmap;
-    PlatformBusDevice *pbus;
-    int min_bus, max_bus;
-    SysBusDevice *sbdev;
-    PCIBus *bus;
-
-    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
-        return 0;
-    }
-
-    bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
-    sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
-    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
-    sbdev = SYS_BUS_DEVICE(obj);
-    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
-    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
-    sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
-    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
-    sdev.irq += ARM_SPI_BASE;
-
-    pci_bus_range(bus, &min_bus, &max_bus);
-    sdev.rc_smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
-    idmap.input_base = min_bus << 8,
-    idmap.id_count = (max_bus - min_bus + 1) << 8,
-    g_array_append_val(sdev.rc_smmu_idmaps, idmap);
-    g_array_append_val(sdev_blob, sdev);
-    return 0;
-}
-
 /*
  * Populate the struct AcpiIortSMMUv3Dev for all SMMUv3 devices and
  * return the total number of idmaps.
  */
-static int populate_smmuv3_dev(GArray *sdev_blob)
+static int populate_smmuv3_dev(VirtMachineState *vms, GArray *sdev_blob)
 {
-    object_child_foreach_recursive(object_get_root(),
-                                   iort_smmuv3_devices, sdev_blob);
+    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
+        Object *obj = OBJECT(g_ptr_array_index(vms->smmuv3_devices, i));
+        AcpiIortSMMUv3Dev sdev = {0};
+        AcpiIortIdMapping idmap;
+        PlatformBusDevice *pbus;
+        int min_bus, max_bus;
+        SysBusDevice *sbdev;
+        PCIBus *bus;
+
+        bus = PCI_BUS(object_property_get_link(obj, "primary-bus",
+                                               &error_abort));
+        sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
+        sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
+        pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+        sbdev = SYS_BUS_DEVICE(obj);
+        sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+        sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
+        sdev.irq = platform_bus_get_irqn(pbus, sbdev, 0);
+        sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
+        sdev.irq += ARM_SPI_BASE;
+
+        pci_bus_range(bus, &min_bus, &max_bus);
+        sdev.rc_smmu_idmaps = g_array_new(false, true,
+                                          sizeof(AcpiIortIdMapping));
+        idmap.input_base = min_bus << 8;
+        idmap.id_count = (max_bus - min_bus + 1) << 8;
+        g_array_append_val(sdev.rc_smmu_idmaps, idmap);
+        g_array_append_val(sdev_blob, sdev);
+    }
     /* Sort the smmuv3 devices(if any) by smmu idmap input_base */
     g_array_sort(sdev_blob, smmuv3_dev_idmap_compare);
     /*
@@ -568,7 +560,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     if (vms->legacy_smmuv3_present) {
         rc_smmu_idmaps_len = populate_smmuv3_legacy_dev(smmuv3_devs);
     } else {
-        rc_smmu_idmaps_len = populate_smmuv3_dev(smmuv3_devs);
+        rc_smmu_idmaps_len = populate_smmuv3_dev(vms, smmuv3_devs);
     }
 
     num_smmus = smmuv3_devs->len;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b090233893..ac0606fe87 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3865,6 +3865,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
             }
 
             create_smmuv3_dev_dtb(vms, dev, bus, errp);
+            g_ptr_array_add(vms->smmuv3_devices, dev);
         }
     }
 
@@ -4319,6 +4320,8 @@ static void virt_instance_init(Object *obj)
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
+
+    vms->smmuv3_devices = g_ptr_array_new_with_free_func(NULL);
 }
 
 static void virt_instance_finalize(Object *obj)
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 3ba33b4bd2..171d44c644 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -207,6 +207,7 @@ struct VirtMachineState {
     MemoryRegion *sysmem;
     MemoryRegion *secure_sysmem;
     bool pci_preserve_config;
+    GPtrArray *smmuv3_devices;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.43.0



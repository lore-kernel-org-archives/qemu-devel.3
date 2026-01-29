Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243BFD6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUav-000122-Uh; Thu, 29 Jan 2026 11:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaj-0000Tp-Or
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:01 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUag-0006jW-GG
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:57 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so9717495e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702993; x=1770307793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2hNnnuhJoXReHjv7HZ5YnfAyWFTMSOC7KF6TZhhOyb4=;
 b=HeCn81qocPHnD9gnNV9SGdjvWHAVrOFHAJWG2KMi4yBN5SAs3cNYk2nDmupTiWFmU5
 qZ+jBnJBJh8KUHEgs4l8+/bTg1N1ySkcDJhHyO4qOaO5FP/23v28bJNzt95YwQCquWn1
 Jf8Pvf2djdKuomoc0pxJjqbKnsNEJclIBMzsP6K0YFlzpwkK4ht/BHg9JtOjikLYzYoN
 8ahkMOuzFsw7B5lj7yOyr+RMGBEE/Go6GRuueoF50DqOwGRlhA6Ykg4XSN0n2OX5Cy4g
 7+3qtdM/2U61LMGJnuUsY5doewY8mhP/6xbcZHdvIxbhDvH9kCknnM9bET9AMaUP6AX4
 7Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702993; x=1770307793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2hNnnuhJoXReHjv7HZ5YnfAyWFTMSOC7KF6TZhhOyb4=;
 b=eKAb51/vmbYJnC7wcRECgQWTofGUDmvY7Mw+uYRHvTUsSWpLwExDBzQKpl5tOYsT+I
 pRIZp0iZw55IqLi947WUbPCCr4kvIwX96MaLeGmwNYIBt/+P8yTJlX5BrkyrQ5zc9TX8
 FfbO61QgW5XzXTK9q1v4AxiTSp38xOu5VnNvenuAU8Rqz1sZ74I9KAE82W4gn52M9KUs
 8oQI0OswGZqeAS0YMWPJFFwmi9m3WbQTpm2TSOg12kvM5gw8tTOfAGuT6RErfGLyNk2D
 razqhYLo0WAD/8Ure96TCgUdlCCiCWsA8wWdyVXbcdnXEKuSIXSRjR94Ef+Y94bHxa11
 q7mQ==
X-Gm-Message-State: AOJu0YwihYtYCzcWcR3IZqX9Hr4CV9BHhx/EiX9/hag+uXAQtDXFEze7
 WSrVRSIwQUVFhsWp9hidzt1nIigrkAmaKVgnDj0ORLZODU5M2Cx7N9Ui+3ylyRZXyS4ExIi0tGA
 qT24uifU=
X-Gm-Gg: AZuq6aILNfJp57OuKU942m1y/BBH7agmF7y30IbN5mY/5KZ/BCfkAYujXYpzTzmM2fm
 KmFpKFzn+D/wAY6bV0/Ip1joZpko63BF6Gbvga5cyd/a69Q24g9tOgMnMINaT4jRVysWLmCIzY6
 9wx95mEj/OvvvJE1HXMi/W0/IFyd3Er2PNPXYRzASC2NlobKB9xF/bvGMQwz4bHMBBUSo/gA2v/
 rCXezVXIuSyQLyq5aT79OZo7IuUIE2EA6Ad9+p8QiBuHOKS5WesnkarwB9q5othd3zcS2/3nPHc
 Dg9W4GawJPS3anVNLzMsqTsNz6ZLF6ZvplUgn4fo3/POY5ZXKUe3Sya2+qWfNDK557Kz4IXIyZ1
 mMhrr711tQ3Bnaez5bKkd0TPvcisi/alcE2m+9sJIQ9qwV2gbEGi7TjzDdB/n+ATI6sMdiIG8XA
 eT2rd6CSf8TNvqSPgmQtkO6Dkue86qB7y2gnP8qLKV
X-Received: by 2002:a05:600c:2dc8:b0:47e:e452:ec12 with SMTP id
 5b1f17b1804b1-4808493b38cmr28293355e9.15.1769702992837; 
 Thu, 29 Jan 2026 08:09:52 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/43] hw/arm/smmuv3: Add accel property for SMMUv3 device
Date: Thu, 29 Jan 2026 16:09:02 +0000
Message-ID: <20260129160917.1415092-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Add an "accel" property to enable SMMUv3 accelerator mode.

Accelerator mode relies on IORT RMR entries for MSI support and is
therefore not supported when booting with a device tree.

In this mode, the host SMMUv3 operates in nested translation
(Stage-1 + Stage-2), with the guest owning the Stage-1 page tables.
Expose only Stage-1 to the guest to ensure it uses the correct page
table format

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-29-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c          | 32 ++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c |  4 +---
 hw/arm/virt.c            | 22 +++++++++++++---------
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2be056d792..8ca1d4ad35 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1916,6 +1916,29 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     smmuv3_accel_reset(s);
 }
 
+static bool smmu_validate_property(SMMUv3State *s, Error **errp)
+{
+#ifndef CONFIG_ARM_SMMUV3_ACCEL
+    if (s->accel) {
+        error_setg(errp, "accel=on support not compiled in");
+        return false;
+    }
+#endif
+
+    if (!s->accel) {
+        return true;
+    }
+
+    /* If no stage specified, SMMUv3 defaults to stage 1 */
+    if (s->stage && strcmp(s->stage, "1")) {
+        error_setg(errp,
+                   "Only stage1 is supported for SMMUv3 with accel=on");
+        return false;
+    }
+
+    return true;
+}
+
 static void smmu_realize(DeviceState *d, Error **errp)
 {
     SMMUState *sys = ARM_SMMU(d);
@@ -1924,6 +1947,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
     Error *local_err = NULL;
 
+    if (!smmu_validate_property(s, errp)) {
+        return;
+    }
+
     if (s->accel) {
         smmuv3_accel_init(s);
         error_setg(&s->migration_blocker, "Migration not supported with SMMUv3 "
@@ -2029,6 +2056,7 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
 };
@@ -2052,6 +2080,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, smmuv3_properties);
     dc->hotpluggable = false;
     dc->user_creatable = true;
+
+    object_class_property_set_description(klass, "accel",
+        "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
+        "configured in nested mode for vfio-pci dev assignment");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4ae4cbc6cd..3126aca42c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -400,9 +400,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
     }
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
-    if (object_property_find(obj, "accel")) {
-        sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    }
+    sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 899b02e1f7..390845c503 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1491,8 +1491,8 @@ static void create_smmuv3_dt_bindings(const VirtMachineState *vms, hwaddr base,
     g_free(node);
 }
 
-static void create_smmuv3_dev_dtb(VirtMachineState *vms,
-                                  DeviceState *dev, PCIBus *bus)
+static void create_smmuv3_dev_dtb(VirtMachineState *vms, DeviceState *dev,
+                                  PCIBus *bus, Error **errp)
 {
     PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
@@ -1500,10 +1500,15 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
     hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
     MachineState *ms = MACHINE(vms);
 
-    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms)) &&
-        strcmp("pcie.0", bus->qbus.name)) {
-        warn_report("SMMUv3 device only supported with pcie.0 for DT");
-        return;
+    if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms))) {
+        if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+            error_setg(errp, "SMMUv3 with accel=on not supported for DT");
+            return;
+        }
+        if (strcmp("pcie.0", bus->qbus.name)) {
+            warn_report("SMMUv3 device only supported with pcie.0 for DT");
+            return;
+        }
     }
     base += vms->memmap[VIRT_PLATFORM_BUS].base;
     irq += vms->irqmap[VIRT_PLATFORM_BUS];
@@ -3061,8 +3066,7 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
             object_property_set_link(OBJECT(dev), "secure-memory",
                                      OBJECT(vms->secure_sysmem), NULL);
         }
-        if (object_property_find(OBJECT(dev), "accel") &&
-            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+        if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
             hwaddr db_start = 0;
 
             if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
@@ -3117,7 +3121,7 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                 return;
             }
 
-            create_smmuv3_dev_dtb(vms, dev, bus);
+            create_smmuv3_dev_dtb(vms, dev, bus, errp);
         }
     }
 
-- 
2.43.0



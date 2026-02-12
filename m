Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C649BEE3694
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvF-0005i0-7h; Thu, 12 Feb 2026 09:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXut-0005ND-R0
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuF-0005pg-Jp
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZdsYzHGBqsRtffyKG+WZutAT5K1mgYEx62Q5cTRUDo=;
 b=cI9X/Neeere2OsYVBldcfIYviHHbLJNPoH3R5eS+z9ORczPigRmGRkj/+toLGhbNCdgkL+
 Yr9XZqt1JTZSbMh3tWxx5zl5IBY4zGvmy/xcDZKJm3oYZYMK48n0YNk7dF8wd9WPFSNsM/
 3aaSFzTLns1Pl5uQELwQkG5t3eO1MF4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-jhoLP9MMO2SnXL9POFImGA-1; Thu, 12 Feb 2026 09:42:57 -0500
X-MC-Unique: jhoLP9MMO2SnXL9POFImGA-1
X-Mimecast-MFC-AGG-ID: jhoLP9MMO2SnXL9POFImGA_1770907376
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4803e8b6007so29523435e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907375; x=1771512175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZdsYzHGBqsRtffyKG+WZutAT5K1mgYEx62Q5cTRUDo=;
 b=jg807gEdYjxB1udcOufxEKPcgwLZJoH9fhMRzNhGQLi6cjqfSPTEKPWIJrfcxIRopf
 j/aH5187wb31TSgRChN4+KZKaalIC7+PxoaL/Ug9glytEJLgeFKOSZSCAeJLTNOzxo5P
 qLoP77jojWjA7aq5zmhY2XXEOZ1RcsMPCHLXYNwXVNWNX5iQGMuGy5NGmt6ibFmhKfD0
 i2LmsK8jKAtbgAcZtxNFF+93C/X0LHgUXam3IR0N3dUON92T2zaIIqVUWkQilrVZlZXK
 xJihDKITQvuW/J36TQrVTszyQzH8EWALqIrUedV64Klt06OqHo+LiIfe4SkQixY3rl2k
 vP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907375; x=1771512175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ZdsYzHGBqsRtffyKG+WZutAT5K1mgYEx62Q5cTRUDo=;
 b=Nk/mgJ4J/BIP1iYLGBAuh91esvZBbcU8zW9fowpyu42oQcoKigmZy0osNDDwLETTcN
 OrN+QCcub3L8tmWS5Ysp0G3tNypz9wV2me8COKmotDX6m7LybPUyR+siRFmtle1J6Vov
 cMAIZmJ9iwlcEDBhSAp9hKgttb5uX4BA8EntWrWYlUJrh8vkuomgryOBhkH7bjNiNFra
 n94dIELRAWqGbzlAQmD0myAoXQjNgea0aBtxCaTu16vkoa9qE6/8Z6Aqlf/fIphdCRxW
 nNeEHB7jiN2aEoo1027I1gjcGpHLl4HRH/UWAcOJpaNA7qWyKLWpVn8/0L8XU+JIh5z5
 k5DQ==
X-Gm-Message-State: AOJu0YxDiYnLEH1RPgTSSQKzFLN7e0V+9GqpvpxviOQa1Jqp7TBKb3nA
 9QY5hb3gUuxdkwMrbuEaOC+OCjOGhunbMI1Mz5stsIo8GzudO2jNz+faw/dDtZ6WOpkrN80RRFe
 js6uPCymTlXcApWKy/K5JbUTlc8TPJX9rJrCOR6PqrcJ+j3qRlu3dgJyUHILQdUqzc7n6Ap62Uq
 jw3/Yqe6SfMzVKNnX0JY+GVFlsC/GR4TY1/VDqx9Kj
X-Gm-Gg: AZuq6aLFPnFRWOh0DYfmJwHjci4bwtrKBtJw54H2DDu5xe3WZ00AREHnfAERsmwiwVq
 EcfNIOcMk4iEV0wM+yoshozdp69YYk7vqJMdPtBSOF1WZHA8in2+GrFvcB912L4+rSwY/IH2guP
 JNc5e+3H+qGdyTHSG8BDfYdcYCHNwL8BBNeRyU+w4iTGzM3dtlclwC5xG7v7Bz9zdr7RLsbIYnT
 5YhFwdgZyTxFz3iH2j1s2xYo4XHmcPEvtNWE873Jb3QMjRIHOzrw830L69m+4gq2myFYqIJrNSL
 DvihGpi63J+6o+/YJ12OOTzSq2qm0puZJAkZOaPAvQnxiJH3ixEggFm4ZH9Mg+jGVMWR644AGwm
 0GWwZCGrNLjydB2wMsfwztKjmfZC6KqtOBx4ac/Askjj150MR2oIu3DJju5+kCov5G4Q3sriXJx
 4kxf4G1FHYstvLmoSvQnWAC8rXvmDlGuSKuKQ6p1Ce6B61Ale5rX4=
X-Received: by 2002:a05:600d:486:10b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-4836a8db4f0mr26095115e9.5.1770907375085; 
 Thu, 12 Feb 2026 06:42:55 -0800 (PST)
X-Received: by 2002:a05:600d:486:10b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-4836a8db4f0mr26094485e9.5.1770907374464; 
 Thu, 12 Feb 2026 06:42:54 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836e39045asm5676405e9.9.2026.02.12.06.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:42:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/41] hw/i386/pc: Remove PCMachineClass::legacy_cpu_hotplug
 field
Date: Thu, 12 Feb 2026 15:42:07 +0100
Message-ID: <20260212144244.22579-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Now all PC & Q35 machiens are using modern hotplug from the beginning,
and all legacy_cpu_hotplug flags keep false during runtime.

So it's safe to remove legacy_cpu_hotplug flags and related properties,
with unused gpe_cpu field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/r/20260108033051.777361-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/acpi/ich9.h  |  2 --
 include/hw/acpi/piix4.h |  2 --
 include/hw/i386/pc.h    |  3 ---
 hw/acpi/ich9.c          | 40 ++++------------------------------------
 hw/acpi/piix4.c         | 40 ++++------------------------------------
 hw/i386/acpi-build.c    |  4 +---
 6 files changed, 9 insertions(+), 82 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 245fe08dc24..6a21472eb32 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -53,8 +53,6 @@ typedef struct ICH9LPCPMRegs {
     uint32_t pm_io_base;
     Notifier powerdown_notifier;
 
-    bool cpu_hotplug_legacy;
-    AcpiCpuHotplug gpe_cpu;
     CPUHotplugState cpuhp_state;
 
     bool keep_pci_slot_hpc;
diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
index eb1c122d806..e075f0cbeaf 100644
--- a/include/hw/acpi/piix4.h
+++ b/include/hw/acpi/piix4.h
@@ -63,8 +63,6 @@ struct PIIX4PMState {
     uint8_t disable_s4;
     uint8_t s4_val;
 
-    bool cpu_hotplug_legacy;
-    AcpiCpuHotplug gpe_cpu;
     CPUHotplugState cpuhp_state;
 
     MemHotplugState acpi_memory_hotplug;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 1890c61a387..7f8cf94138a 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -110,9 +110,6 @@ struct PCMachineClass {
     bool enforce_amd_1tb_hole;
     bool isa_bios_alias;
 
-    /* generate legacy CPU hotplug AML */
-    bool legacy_cpu_hotplug;
-
     /* use PVH to load kernels that support this feature */
     bool pvh_enabled;
 
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 54590129c69..f254f387971 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -339,26 +339,6 @@ static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static bool ich9_pm_get_cpu_hotplug_legacy(Object *obj, Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    return s->pm.cpu_hotplug_legacy;
-}
-
-static void ich9_pm_set_cpu_hotplug_legacy(Object *obj, bool value,
-                                           Error **errp)
-{
-    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
-
-    assert(!value);
-    if (s->pm.cpu_hotplug_legacy && value == false) {
-        acpi_switch_to_modern_cphp(&s->pm.gpe_cpu, &s->pm.cpuhp_state,
-                                   ICH9_CPU_HOTPLUG_IO_BASE);
-    }
-    s->pm.cpu_hotplug_legacy = value;
-}
-
 static bool ich9_pm_get_enable_tco(Object *obj, Error **errp)
 {
     ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
@@ -403,7 +383,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
     pm->acpi_memory_hotplug.is_enabled = true;
-    pm->cpu_hotplug_legacy = false;
     pm->disable_s3 = 0;
     pm->disable_s4 = 0;
     pm->s4_val = 2;
@@ -422,9 +401,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                         NULL, NULL, pm);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
-    object_property_add_bool(obj, "cpu-hotplug-legacy",
-                             ich9_pm_get_cpu_hotplug_legacy,
-                             ich9_pm_set_cpu_hotplug_legacy);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
                                   &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
@@ -477,11 +453,7 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 dev, errp);
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        if (lpc->pm.cpu_hotplug_legacy) {
-            legacy_acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.gpe_cpu, dev, errp);
-        } else {
-            acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
-        }
+        acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
                                   dev, errp);
@@ -500,8 +472,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         acpi_memory_unplug_request_cb(hotplug_dev,
                                       &lpc->pm.acpi_memory_hotplug, dev,
                                       errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
-               !lpc->pm.cpu_hotplug_legacy) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         uint64_t negotiated = lpc->smi_negotiated_features;
 
         if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
@@ -533,8 +504,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_cb(&lpc->pm.acpi_memory_hotplug, dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
-               !lpc->pm.cpu_hotplug_legacy) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         acpi_cpu_unplug_cb(&lpc->pm.cpuhp_state, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
@@ -556,7 +526,5 @@ void ich9_pm_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
     ICH9LPCState *s = ICH9_LPC_DEVICE(adev);
 
     acpi_memory_ospm_status(&s->pm.acpi_memory_hotplug, list);
-    if (!s->pm.cpu_hotplug_legacy) {
-        acpi_cpu_ospm_status(&s->pm.cpuhp_state, list);
-    }
+    acpi_cpu_ospm_status(&s->pm.cpuhp_state, list);
 }
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 0eda692084d..05f9d6372a9 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -336,11 +336,7 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        if (s->cpu_hotplug_legacy) {
-            legacy_acpi_cpu_plug_cb(hotplug_dev, &s->gpe_cpu, dev, errp);
-        } else {
-            acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
-        }
+        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
     } else {
         g_assert_not_reached();
     }
@@ -358,8 +354,7 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_unplug_request_cb(hotplug_dev, &s->acpi_pci_hotplug,
                                             dev, errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
-               !s->cpu_hotplug_legacy) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
@@ -378,8 +373,7 @@ static void piix4_device_unplug_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
                                     errp);
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
-               !s->cpu_hotplug_legacy) {
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for not supported device"
@@ -523,26 +517,6 @@ static const MemoryRegionOps piix4_gpe_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-
-static bool piix4_get_cpu_hotplug_legacy(Object *obj, Error **errp)
-{
-    PIIX4PMState *s = PIIX4_PM(obj);
-
-    return s->cpu_hotplug_legacy;
-}
-
-static void piix4_set_cpu_hotplug_legacy(Object *obj, bool value, Error **errp)
-{
-    PIIX4PMState *s = PIIX4_PM(obj);
-
-    assert(!value);
-    if (s->cpu_hotplug_legacy && value == false) {
-        acpi_switch_to_modern_cphp(&s->gpe_cpu, &s->cpuhp_state,
-                                   PIIX4_CPU_HOTPLUG_IO_BASE);
-    }
-    s->cpu_hotplug_legacy = value;
-}
-
 static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
                                            PCIBus *bus, PIIX4PMState *s)
 {
@@ -558,10 +532,6 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
         qbus_set_hotplug_handler(BUS(pci_get_bus(PCI_DEVICE(s))), OBJECT(s));
     }
 
-    s->cpu_hotplug_legacy = false;
-    object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
-                             piix4_get_cpu_hotplug_legacy,
-                             piix4_set_cpu_hotplug_legacy);
     cpu_hotplug_hw_init(parent, OBJECT(s), &s->cpuhp_state,
                         PIIX4_CPU_HOTPLUG_IO_BASE);
 
@@ -576,9 +546,7 @@ static void piix4_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
     PIIX4PMState *s = PIIX4_PM(adev);
 
     acpi_memory_ospm_status(&s->acpi_memory_hotplug, list);
-    if (!s->cpu_hotplug_legacy) {
-        acpi_cpu_ospm_status(&s->cpuhp_state, list);
-    }
+    acpi_cpu_ospm_status(&s->cpuhp_state, list);
 }
 
 static void piix4_send_gpe(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index cdd72cbcaa0..22bd497c9be 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -960,9 +960,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     }
     aml_append(dsdt, scope);
 
-    if (pcmc->legacy_cpu_hotplug) {
-        build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
-    } else {
+    {
         CPUHotplugFeatures opts = {
             .acpi_1_compatible = true,
             .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
-- 
2.52.0



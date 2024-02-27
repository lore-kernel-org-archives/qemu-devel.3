Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9ECC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2t-0004MO-P4; Tue, 27 Feb 2024 03:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2r-0004EV-Tm
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:37 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2g-0008O6-BZ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:37 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso894565f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023343; x=1709628143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Gdk5QbogljYxnMuj3DzgKa5vdSTLOp9WH/RDQu3ZVU=;
 b=VpRCVtEscIS96Co0fLlEeURNAIJYOqGC3Yx9gAc5NFdw3nXQ69owarEjh3zXxg9tA9
 GY+glaUfwhVRNr6N48bpPXbdxyMkQPsgnqED+ZI/JsLHL9uh70n6Bp07d7ED44gRpIte
 sefy0OwYO6EGXMrRGiMTdkDPb9FJBiyyEmCex2laF6eUAmR7TMrwuOghwdnmoolvcpEe
 SlfBrR7gcy9qr7BrpMRbISO6yAUQs0vPuiQNfxNC5+VF1O1AZc/Xjx5Kefh03C/HKfBS
 4DXOgsoKzlGSaklKPg0vVbO4a8DkjFLDalQsSDy0NZXe8BBad3H3KgubR/uy1fhFA0FT
 k4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023343; x=1709628143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Gdk5QbogljYxnMuj3DzgKa5vdSTLOp9WH/RDQu3ZVU=;
 b=eHw4xMw2qf1pNTusLwOePwcG2ARo4deylaZxwOMeA+t2u8B7GwjKOYf4kVqmXy54i/
 QWDtQZCBUbSfOur7YKSf+5WFYmu6slMHfXXdeUibwjafvURag0oqnjQo0A+3nqle9XQ3
 hNErw+K3wDeCYud0sxk7aIeeMTiM4/MLbhN0HIJWFd6cjpp6oRcRD/aT7oXGZCxFwaKY
 ekGZv/n3qsXuJXDrCnfrh5jM2R/U5B7RskazC27vvWXtlXG4dtXnNZfaCu3Tm25qGmwl
 jW3UdZEnnvm3YPC3vXGGWShJ5985ptlwWiB0jROQyGPieEI+7GCquMNcEiJlWkesGYiv
 XXBw==
X-Gm-Message-State: AOJu0YyOVLb6jiW/rNZ3m2Cz5CAjkXCAn05sZXlwYbu+QHbrBEWeMXQO
 meT6zE/xCVdgdr1JmvzZVSDg0Bo2JwTifD4lbEaiybuTskbIzlp7du79UFGnCpyKKjmi0fAewFN
 z
X-Google-Smtp-Source: AGHT+IE+hlwWU1hQR2h4tvI0lGSghQ/k/PAA7uWOG5PDlEMAAvsUSm0LVXo5toBFpldpRMN0L1fagg==
X-Received: by 2002:a5d:440f:0:b0:33d:1974:4ae8 with SMTP id
 z15-20020a5d440f000000b0033d19744ae8mr6733729wrq.16.1709023342825; 
 Tue, 27 Feb 2024 00:42:22 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 bs19-20020a056000071300b0033df49c9d00sm398994wrb.17.2024.02.27.00.42.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:42:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>
Subject: [PULL 24/30] hw/i386/pc: Rename "bus" attribute to "pcibus"
Date: Tue, 27 Feb 2024 09:39:40 +0100
Message-ID: <20240227083948.5427-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The attribute is of type PCIBus; reflect that in the name. It will also make the
next change more intuitive.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240224135851.100361-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h     | 2 +-
 hw/i386/acpi-build.c     | 2 +-
 hw/i386/amd_iommu.c      | 2 +-
 hw/i386/intel_iommu.c    | 2 +-
 hw/i386/kvm/xen_evtchn.c | 2 +-
 hw/i386/pc.c             | 8 ++++----
 hw/i386/pc_piix.c        | 6 +++---
 hw/i386/pc_q35.c         | 2 +-
 hw/i386/x86-iommu.c      | 2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e88468131a..27834043c3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -31,7 +31,7 @@ typedef struct PCMachineState {
     Notifier machine_done;
 
     /* Pointers to devices and objects: */
-    PCIBus *bus;
+    PCIBus *pcibus;
     I2CBus *smbus;
     PFlashCFI01 *flash[2];
     ISADevice *pcspk;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 896ff87519..15242b9096 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1546,7 +1546,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     }
 
     crs_range_set_init(&crs_range_set);
-    bus = PC_MACHINE(machine)->bus;
+    bus = PC_MACHINE(machine)->pcibus;
     if (bus) {
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7329553ad3..6d4fde72f9 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1584,7 +1584,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     PCMachineState *pcms = PC_MACHINE(ms);
     X86MachineState *x86ms = X86_MACHINE(ms);
-    PCIBus *bus = pcms->bus;
+    PCIBus *bus = pcms->pcibus;
 
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cf933189d3..cc8e59674e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4183,7 +4183,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     PCMachineState *pcms = PC_MACHINE(ms);
     X86MachineState *x86ms = X86_MACHINE(ms);
-    PCIBus *bus = pcms->bus;
+    PCIBus *bus = pcms->pcibus;
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 0171ef6d59..a5052c0ea3 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -371,7 +371,7 @@ static int set_callback_pci_intx(XenEvtchnState *s, uint64_t param)
         return 0;
     }
 
-    pdev = pci_find_device(pcms->bus, bus, devfn);
+    pdev = pci_find_device(pcms->pcibus, bus, devfn);
     if (!pdev) {
         return 0;
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8eb684a49..353edeb2ea 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -675,7 +675,7 @@ void pc_machine_done(Notifier *notifier, void *data)
                                         PCMachineState, machine_done);
     X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    cxl_hook_up_pxb_registers(pcms->bus, &pcms->cxl_devices_state,
+    cxl_hook_up_pxb_registers(pcms->pcibus, &pcms->cxl_devices_state,
                               &error_fatal);
 
     if (pcms->cxl_devices_state.is_enabled) {
@@ -685,7 +685,7 @@ void pc_machine_done(Notifier *notifier, void *data)
     /* set the number of CPUs */
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
-    fw_cfg_add_extra_pci_roots(pcms->bus, x86ms->fw_cfg);
+    fw_cfg_add_extra_pci_roots(pcms->pcibus, x86ms->fw_cfg);
 
     acpi_setup();
     if (x86ms->fw_cfg) {
@@ -1250,8 +1250,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         xen_evtchn_create(IOAPIC_NUM_PINS, gsi);
         xen_gnttab_create();
         xen_xenstore_create();
-        if (pcms->bus) {
-            pci_create_simple(pcms->bus, -1, "xen-platform");
+        if (pcms->pcibus) {
+            pci_create_simple(pcms->pcibus, -1, "xen-platform");
         }
         xen_bus_init();
         xen_be_init();
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7724396ead..3393b93007 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -216,7 +216,7 @@ static void pc_init1(MachineState *machine,
         pci_bus_map_irqs(pci_bus,
                          xen_enabled() ? xen_pci_slot_get_pirq
                                        : pc_pci_slot_get_pirq);
-        pcms->bus = pci_bus;
+        pcms->pcibus = pci_bus;
 
         hole64_size = object_property_get_uint(phb,
                                                PCI_HOST_PROP_PCI_HOLE64_SIZE,
@@ -480,8 +480,8 @@ static void pc_xen_hvm_init(MachineState *machine)
     }
 
     pc_xen_hvm_init_pci(machine);
-    xen_igd_reserve_slot(pcms->bus);
-    pci_create_simple(pcms->bus, -1, "xen-platform");
+    xen_igd_reserve_slot(pcms->pcibus);
+    pci_create_simple(pcms->pcibus, -1, "xen-platform");
 }
 #endif
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 3c80f37ead..549c0bc041 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -218,7 +218,7 @@ static void pc_q35_init(MachineState *machine)
 
     /* pci */
     host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
-    pcms->bus = host_bus;
+    pcms->pcibus = host_bus;
 
     /* irq lines */
     gsi_state = pc_gsi_create(&x86ms->gsi, true);
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 726e9e1d16..60af896225 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -101,7 +101,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
     QLIST_INIT(&x86_iommu->iec_notifiers);
     bool irq_all_kernel = kvm_irqchip_in_kernel() && !kvm_irqchip_is_split();
 
-    if (!pcms || !pcms->bus) {
+    if (!pcms || !pcms->pcibus) {
         error_setg(errp, "Machine-type '%s' not supported by IOMMU",
                    mc->name);
         return;
-- 
2.41.0



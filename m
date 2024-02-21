Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6732FC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctyd-0004vB-5S; Wed, 21 Feb 2024 16:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyZ-0004g0-MB
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:59 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyS-00010W-F6
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:59 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41270d0b919so15994525e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550270; x=1709155070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gLsl7BBn0DZO5gyuGErugwjfhowG19+Smg3Lb3vokg=;
 b=TClTjH7ZuuBhe/WiafLP2jCKPn0aWHcprJZwk2PIGA/ChzLNVNAERvtGZ/5tVbOFnu
 nDTBywWk1Bk7kM12w7dG2rLxe3G33/UfFN98/onneTG1Frqd292x6mBCQmHY7PS651e7
 F6g8iSeC7hOyqcmdld3UMXb0WayASWB69VtOEAZo3eEmBGNIWUjWriaD4V64IGJyJeb3
 47Yt1D7RWr1N+6mLRjxANj0qJQDb7hj115FeeDacb2dLTOdwVQB38j1kLazwd+QzbTCz
 hUQ61wxJZiisRHoV2tE/NR2O8awvzEW4A23dQ2uuoLgOQbj0LAWDscKRvCeHBulAqgFw
 9CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550270; x=1709155070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gLsl7BBn0DZO5gyuGErugwjfhowG19+Smg3Lb3vokg=;
 b=OzYm3hRxA7agyxS1XRgxOsxJ/AQRu5nH/8k+HXpY/7SQ0h+8L2ivx6HsNMm1OFBQEl
 pn0Esy02PFOD3Wovp2AQll/UoPLoqibCTjNON2bWf3YjnevGsaBSeNwxdKj4+5C1k4RT
 cQ3BS9j+YDJ1nxeFqHs6WowUC2f/mXfYba4ONHV6L/LOSE8NkON+PEQhpZLqKot5UTsg
 FVRge9sVp6Tkey+T2wnpEJropq0snTaFIgPiGT3KLPjCMs327Y97KOXvh3fwrzPvJ6Lp
 jnu7uSRsEK+AvQvO9Dah6j5vBgtBGNR2n5EPWuNdBEywHl9MJ0dgQPdIjoXCrJ50329H
 8iXg==
X-Gm-Message-State: AOJu0Yz1IkKCU3FP8EYvNuFFMzGqF2UJXjj6LSgmvL2lgI6t4Hpr3Qa8
 f4iVBlLr3TPgB2yY+xZJqUUjIrvS2J1uMVTcoBPRZwlSm9Gpu9USmCP2fWjfi9IIn3WADvuZU7x
 Q/gI=
X-Google-Smtp-Source: AGHT+IGX4rvXEuavkGqkWXNFkw5ZZCD8SgJj7cvop787hNC+npyHML2KT0YeuupGteRL1xYNijqafw==
X-Received: by 2002:a05:6000:1561:b0:33d:804f:5ea3 with SMTP id
 1-20020a056000156100b0033d804f5ea3mr1934709wrz.69.1708550270472; 
 Wed, 21 Feb 2024 13:17:50 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a5d51c1000000b0033b1c321070sm17958745wrv.31.2024.02.21.13.17.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:17:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 09/25] hw/i386/pc: Store pointers to IDE buses in PCMachineState
Date: Wed, 21 Feb 2024 22:16:09 +0100
Message-ID: <20240221211626.48190-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Add the two IDE bus BusState pointers to the set we keep in PCMachineState.
This allows us to avoid passing them to pc_cmos_init(), and also will
allow a refactoring of how we call pc_cmos_init_late().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMD: Do not zero-init pcms->idebus[] again]
Message-ID: <20240220160622.114437-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  4 +++-
 hw/i386/pc.c         |  5 ++---
 hw/i386/pc_piix.c    | 12 ++++--------
 hw/i386/pc_q35.c     |  9 +++------
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 02a0deedd3..cf2fa60868 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -17,6 +17,8 @@
 
 #define HPET_INTCAP "hpet-intcap"
 
+#define MAX_IDE_BUS 2
+
 /**
  * PCMachineState:
  * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
@@ -37,6 +39,7 @@ typedef struct PCMachineState {
     PFlashCFI01 *flash[2];
     ISADevice *pcspk;
     DeviceState *iommu;
+    BusState *idebus[MAX_IDE_BUS];
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
@@ -182,7 +185,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                           bool create_fdctrl,
                           uint32_t hpet_irqs);
 void pc_cmos_init(PCMachineState *pcms,
-                  BusState *ide0, BusState *ide1,
                   ISADevice *s);
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9cbc59665f..3e9ca6295f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -574,7 +574,6 @@ static void pc_cmos_init_late(void *opaque)
 }
 
 void pc_cmos_init(PCMachineState *pcms,
-                  BusState *idebus0, BusState *idebus1,
                   ISADevice *rtc)
 {
     int val;
@@ -634,8 +633,8 @@ void pc_cmos_init(PCMachineState *pcms,
 
     /* hard drives and FDC */
     arg.rtc_state = s;
-    arg.idebus[0] = idebus0;
-    arg.idebus[1] = idebus1;
+    arg.idebus[0] = pcms->idebus[0];
+    arg.idebus[1] = pcms->idebus[1];
     qemu_register_reset(pc_cmos_init_late, &arg);
 }
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9064511507..bea096f569 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -68,7 +68,6 @@
 #include "kvm/kvm-cpu.h"
 #include "target/i386/cpu.h"
 
-#define MAX_IDE_BUS 2
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
 #ifdef CONFIG_IDE_ISA
@@ -114,7 +113,6 @@ static void pc_init1(MachineState *machine,
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
-    BusState *idebus[MAX_IDE_BUS];
     ISADevice *rtc_state;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
@@ -299,8 +297,8 @@ static void pc_init1(MachineState *machine,
         piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
         dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
         pci_ide_create_devs(PCI_DEVICE(dev));
-        idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        idebus[1] = qdev_get_child_bus(dev, "ide.1");
+        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
     } else {
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
@@ -312,8 +310,6 @@ static void pc_init1(MachineState *machine,
 
         i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
-        idebus[0] = NULL;
-        idebus[1] = NULL;
     }
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
@@ -358,12 +354,12 @@ static void pc_init1(MachineState *machine,
              * second one.
              */
             busname[4] = '0' + i;
-            idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
+            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
         }
     }
 #endif
 
-    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
+    pc_cmos_init(pcms, rtc_state);
 
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d346fa3b1d..0e9bd27a6e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -126,7 +126,6 @@ static void pc_q35_init(MachineState *machine)
     PCIBus *host_bus;
     PCIDevice *lpc;
     DeviceState *lpc_dev;
-    BusState *idebus[MAX_SATA_PORTS];
     ISADevice *rtc_state;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
@@ -300,13 +299,11 @@ static void pc_q35_init(MachineState *machine)
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
         ich9 = ICH9_AHCI(pdev);
-        idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
-        idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
+        pcms->idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
+        pcms->idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
         g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
         ide_drive_get(hd, ich9->ahci.ports);
         ahci_ide_create_devs(&ich9->ahci, hd);
-    } else {
-        idebus[0] = idebus[1] = NULL;
     }
 
     if (machine_usb(machine)) {
@@ -327,7 +324,7 @@ static void pc_q35_init(MachineState *machine)
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
-    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
+    pc_cmos_init(pcms, rtc_state);
 
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, host_bus);
-- 
2.41.0



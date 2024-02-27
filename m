Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F962C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret34-0005Pu-8X; Tue, 27 Feb 2024 03:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret31-0005AM-C8
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:47 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2x-0008SS-EW
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:47 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33da51fd636so2399277f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023361; x=1709628161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxCElssAJQElNOBysOkvX3JvR87QOEk2FLy7QknFoAM=;
 b=VQ1Mkk1Cj7SDrEYNCK4co8bU44HBS3UTI1F3lBj8WG854/q2G2+oDSOkXB5UTyLobB
 2pVtPBq1KqmILs1cJ/0TQatYNgfdvnHOnUeBls84TJaBZljdfvtehnaSgReX+lDTdjNn
 5XcOb7Fn8wkcKGKmNnrPTA7k1O3eLsWGzEwsHt38jp/SaFG2Hr2/rGA1bI6abH/geVlk
 7GeREy4TTF4htOmYT0z2Lp5VPPkDKJQ6BhATsUtOnPtWF6YFg4T2iiBPmz84bQTXh6la
 QIqk015TePbaeBf+5C4K2YJtz4B09Q9MwJRKe6grSXeOU8vysTr5HRKu+ftTyUgCSovN
 SOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023361; x=1709628161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxCElssAJQElNOBysOkvX3JvR87QOEk2FLy7QknFoAM=;
 b=W8ijPpyfb6paiJl9YpimjbLGnuqPlG3dkDSYx/V3ghJhK8nsDPpat9wa1UJDcItTxr
 4ncH11Rm0U/8c0AntAYqHgxGxOF9YuH88pfORiohoaw43Ai+FHd8c/naiy9Y2KCPVIha
 QdX5Pqn367PqEmzIkMVtASsVCHR9bsWDrldiilVWaUPT7kQMNxlxlshET7/ISxKdYcPG
 7omAK/K/pFu9YSZ6MUC7tEspkRjSrSLWEfCTGB17fS5Jcjppbr6NYy1uGT+06Y5vfD4C
 cRtObs5v9uyTL/YVby8KC+y3/ttwHDvdFuSP0PWFMLCjfpwlbKbP6LAXGQeZS4llqy+7
 bhIg==
X-Gm-Message-State: AOJu0YwDWUFoMEreabCpEJZpO+0GThwArcojP3NoDyC+aHOPed5eLe0f
 kEb4dPudqZEWdGXEOPsOV3xW9+U4CplV4dy/btPBxb4i5l4Nk8S7ltO04LuaXLuU1XCk/L2mfPj
 C
X-Google-Smtp-Source: AGHT+IHtHtoWlYY1DI0MsRQqR9n+hgloKf0qD4fCrdPD+MlI2PncENG9lttaUS2YvcQk9cf6lkihGw==
X-Received: by 2002:adf:f10a:0:b0:33d:afc6:3ba6 with SMTP id
 r10-20020adff10a000000b0033dafc63ba6mr7099097wro.34.1709023361722; 
 Tue, 27 Feb 2024 00:42:41 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 r29-20020adfa15d000000b0033de7a30b4fsm2031402wrr.26.2024.02.27.00.42.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:42:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 27/30] hw/i386/pc: Populate RTC attribute directly
Date: Tue, 27 Feb 2024 09:39:43 +0100
Message-ID: <20240227083948.5427-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Both the piix and the q35 machines introduce an rtc_state variable and defer the
initialization of the X86MachineState::rtc attribute to pc_cmos_init(). Resolve
this complication which makes pc_cmos_init() do what it says on the tin.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-ID: <20240224135851.100361-6-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c      |  8 --------
 hw/i386/pc_piix.c | 15 +++++++--------
 hw/i386/pc_q35.c  |  7 +++----
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a80f809b83..880e95de26 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -611,14 +611,6 @@ void pc_cmos_init(PCMachineState *pcms,
     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
 
-    object_property_add_link(OBJECT(pcms), "rtc_state",
-                             TYPE_ISA_DEVICE,
-                             (Object **)&x86ms->rtc,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
-                             &error_abort);
-
     set_boot_dev(s, MACHINE(pcms)->boot_config.order, &error_fatal);
 
     val = 0;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 49d5d48db9..ce6aad758d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -112,7 +112,6 @@ static void pc_init1(MachineState *machine,
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
-    ISADevice *rtc_state;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
@@ -276,8 +275,8 @@ static void pc_init1(MachineState *machine,
         }
 
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                             "rtc"));
+        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                              "rtc"));
         piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
         dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
         pci_ide_create_devs(PCI_DEVICE(dev));
@@ -288,9 +287,9 @@ static void pc_init1(MachineState *machine,
                               &error_abort);
         isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        rtc_state = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
-        isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
+        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
 
         i8257_dma_init(OBJECT(machine), isa_bus, 0);
         pcms->hpet_enabled = false;
@@ -316,7 +315,7 @@ static void pc_init1(MachineState *machine,
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, true,
                          0x4);
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
@@ -343,7 +342,7 @@ static void pc_init1(MachineState *machine,
     }
 #endif
 
-    pc_cmos_init(pcms, rtc_state);
+    pc_cmos_init(pcms, x86ms->rtc);
 
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9e4b8f79c2..45a4102e75 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -125,7 +125,6 @@ static void pc_q35_init(MachineState *machine)
     Object *phb;
     PCIDevice *lpc;
     DeviceState *lpc_dev;
-    ISADevice *rtc_state;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     MemoryRegion *pci_memory = g_new(MemoryRegion, 1);
@@ -232,7 +231,7 @@ static void pc_q35_init(MachineState *machine)
     }
     pci_realize_and_unref(lpc, pcms->pcibus, &error_fatal);
 
-    rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
     object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              TYPE_HOTPLUG_HANDLER,
@@ -274,7 +273,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, !mc->no_floppy,
                          0xff0104);
 
     if (pcms->sata_enabled) {
@@ -312,7 +311,7 @@ static void pc_q35_init(MachineState *machine)
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
     }
 
-    pc_cmos_init(pcms, rtc_state);
+    pc_cmos_init(pcms, x86ms->rtc);
 
     /* the rest devices to which pci devfn is automatically assigned */
     pc_vga_init(isa_bus, pcms->pcibus);
-- 
2.41.0



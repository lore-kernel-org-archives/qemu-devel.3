Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B150C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD7G-0002nb-WD; Sat, 18 Jul 2026 18:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD7D-0002kj-Ep; Sat, 18 Jul 2026 18:02:35 -0400
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.162.73.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD78-0005Lv-KX; Sat, 18 Jul 2026 18:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412150; x=1815948150;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0u9gmpcOrnZEhlEebyDthVhM8N8q3vJLhUgo8TVhGvY=;
 b=ATIO25A5Ueeat/leXjvhSU2ce+4A0FQcPuB6ptyJEZVkjEUgj/f2lWxQ
 4LnknFLiZRz2MPyN4mk7kyZarPSU+Xxfoceq4kycTv9oSaF1jR2OCqj8f
 7klMH0FvZin67UO6hAJnPDtV1ZefLu6lfOKGfrm4fvs68kke9zsxypcm8
 WNOmeR2q11FGJ1lKiA8IC88dHyzuBcmdFaNnjgq4AyQLUXcW4U7TwWJNV
 sqCEIvb9XfNZ+ebP74FJ8Y/u0RhGUdIovaMIIlh7mkqPvD5YA5M2NrcPH
 J6jTNrz/C3PNFn1HVZWP5nVFjaZ7M6dMvomN3Y7tSzus44ivDDnpbt5l6 A==;
X-CSE-ConnectionGUID: lgwv+xyrT5yL06fW6hKtZA==
X-CSE-MsgGUID: nZM7qut7RsC7HEeOIH4SPw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23716379"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:02:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:3123]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.177:2525]
 with esmtp (Farcaster)
 id d81a8b4c-c010-49aa-ab9a-87b59a5d15d0; Sat, 18 Jul 2026 22:02:26 +0000 (UTC)
X-Farcaster-Flow-ID: d81a8b4c-c010-49aa-ab9a-87b59a5d15d0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:02:26 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:02:16 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 091/137] hw/misc-boards: Give memory regions an
 explicit owner
Date: Sat, 18 Jul 2026 21:36:06 +0000
Message-ID: <20260718213652.37673-92-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.162.73.231;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

memory_region_init*() takes an @owner argument that becomes the
QOM parent of the MemoryRegion object. When NULL is passed the
region is silently reparented under /machine/unattached, hiding
its lifetime owner.

Convert trivial owner==NULL sites in board init functions and
device realize functions across small subdirectories. The owner
is the enclosing machine or device in every case:

  hw/hexagon    OBJECT(machine|ms|vms)  virt, hexagon_dsp
  hw/hppa       parent, OBJECT(machine)
  hw/ipmi       OBJECT(ii)              IPMIInterface implementations
  hw/loongarch  OBJECT(machine)
  hw/microblaze OBJECT(machine)
  hw/or1k       OBJECT(machine)
  hw/pci-host   OBJECT(dev)             bonito realize
  hw/rtc        OBJECT(dev)             ls7a realize
  hw/sparc      OBJECT(machine)
  hw/sparc64    OBJECT(machine)
  hw/vmapple    OBJECT(vms)
  hw/xen        OBJECT(s)               xen-pvh-common ram init

No functional change: memory_region_do_init() would have parented
these under /machine/unattached; they now sit under their creator.

RAMBlock idstrs are unchanged: the owners added here are Machine
or SysBus devices, and memory_region_register_ram() maps both to
dev=NULL for qemu_ram_set_idstr().

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/hexagon/hexagon_dsp.c                 |  4 ++--
 hw/hexagon/virt.c                        |  8 ++++----
 hw/hppa/machine.c                        |  6 +++---
 hw/ipmi/ipmi_bt.c                        |  2 +-
 hw/ipmi/ipmi_kcs.c                       |  2 +-
 hw/loongarch/virt.c                      |  4 ++--
 hw/microblaze/petalogix_ml605_mmu.c      |  4 ++--
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  4 ++--
 hw/microblaze/xlnx-zynqmp-pmu.c          |  4 ++--
 hw/or1k/or1k-sim.c                       |  2 +-
 hw/or1k/virt.c                           |  2 +-
 hw/pci-host/bonito.c                     |  4 ++--
 hw/rtc/ls7a_rtc.c                        |  2 +-
 hw/sparc/leon3.c                         |  2 +-
 hw/sparc64/niagara.c                     | 13 +++++++------
 hw/vmapple/vmapple.c                     |  2 +-
 hw/xen/xen-pvh-common.c                  | 12 ++++++------
 17 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index ccd9a06f51..53dfe6741e 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -122,12 +122,12 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
 
     address_space = get_system_memory();
 
-    memory_region_init_rom(&hms->cfgtable_rom, NULL, "config_table.rom",
+    memory_region_init_rom(&hms->cfgtable_rom, OBJECT(machine), "config_table.rom",
                            sizeof(m_cfg->cfgtable), &error_fatal);
     memory_region_add_subregion(address_space, m_cfg->cfgbase,
                                 &hms->cfgtable_rom);
 
-    memory_region_init_ram(&hms->ram, NULL, "ddr.ram",
+    memory_region_init_ram(&hms->ram, OBJECT(machine), "ddr.ram",
                            machine->ram_size, &error_fatal);
     memory_region_add_subregion(address_space, 0x0, &hms->ram);
 
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index 0619f06c41..fb23cda19f 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -74,7 +74,7 @@ static void fdt_add_hvx(HexagonVirtMachineState *vms,
     const MachineState *ms = MACHINE(vms);
     uint32_t vtcm_size_bytes = m_cfg->cfgtable.vtcm_size_kb * 1024;
     if (vtcm_size_bytes > 0) {
-        memory_region_init_ram(&vms->vtcm, NULL, "vtcm.ram", vtcm_size_bytes,
+        memory_region_init_ram(&vms->vtcm, OBJECT(vms), "vtcm.ram", vtcm_size_bytes,
                                &error_fatal);
         memory_region_add_subregion(vms->sys, m_cfg->cfgtable.vtcm_base << 16,
                                     &vms->vtcm);
@@ -250,18 +250,18 @@ static void virt_init(MachineState *ms)
     vms->apb_clk = clock_new(OBJECT(ms), "apb-pclk");
     clock_set_hz(vms->apb_clk, 24000000);
 
-    memory_region_init_ram(&vms->parent_obj.ram, NULL, "ddr.ram",
+    memory_region_init_ram(&vms->parent_obj.ram, OBJECT(ms), "ddr.ram",
                            ms->ram_size, &error_fatal);
     memory_region_add_subregion(vms->sys, 0x0, &vms->parent_obj.ram);
 
     if (m_cfg->l2tcm_size) {
-        memory_region_init_ram(&vms->tcm, NULL, "tcm.ram", m_cfg->l2tcm_size,
+        memory_region_init_ram(&vms->tcm, OBJECT(ms), "tcm.ram", m_cfg->l2tcm_size,
                                &error_fatal);
         memory_region_add_subregion(vms->sys, m_cfg->cfgtable.l2tcm_base << 16,
                                     &vms->tcm);
     }
 
-    memory_region_init_rom(&vms->parent_obj.cfgtable_rom, NULL,
+    memory_region_init_rom(&vms->parent_obj.cfgtable_rom, OBJECT(ms),
                            "config_table.rom", sizeof(m_cfg->cfgtable),
                            &error_fatal);
     memory_region_add_subregion(vms->sys, m_cfg->cfgbase,
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 4fcb3e5e37..233cf6318b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -104,7 +104,7 @@ static ISABus *hppa_isa_bus(Object *parent, hwaddr addr)
     MemoryRegion *isa_region;
 
     isa_region = g_new(MemoryRegion, 1);
-    memory_region_init_io(isa_region, NULL, &hppa_pci_ignore_ops,
+    memory_region_init_io(isa_region, parent, &hppa_pci_ignore_ops,
                           NULL, "isa-io", 0x800);
     memory_region_add_subregion(get_system_memory(), addr, isa_region);
 
@@ -337,7 +337,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
          */
         cflush_name = g_strdup_printf("cpu%u-T600-cacheflush", i);
         cflush = g_new(MemoryRegion, 1);
-        memory_region_init_io(cflush, NULL, &hppa_pci_ignore_ops,
+        memory_region_init_io(cflush, OBJECT(machine), &hppa_pci_ignore_ops,
                               NULL, cflush_name, 4);
         memory_region_add_subregion(addr_space,
                               translate(NULL, CPU_HPA + i * 0x1000 + 0x500),
@@ -498,7 +498,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     }
 
     rom_region = g_new(MemoryRegion, 1);
-    memory_region_init_ram(rom_region, NULL, "firmware",
+    memory_region_init_ram(rom_region, OBJECT(machine), "firmware",
                            (FIRMWARE_END - FIRMWARE_START), &error_fatal);
     memory_region_add_subregion(addr_space,
                                 translate(NULL, FIRMWARE_START), rom_region);
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index e01d02fe52..173e2e52c6 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -361,7 +361,7 @@ static void ipmi_bt_init(IPMIInterface *ii, unsigned int min_size, Error **errp)
     ib->size_mask = min_size - 1;
     ib->io_length = 3;
 
-    memory_region_init_io(&ib->io, NULL, &ipmi_bt_io_ops, ii, "ipmi-bt",
+    memory_region_init_io(&ib->io, OBJECT(ii), &ipmi_bt_io_ops, ii, "ipmi-bt",
                           min_size);
 }
 
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index d5cfe6c068..9bd678e725 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -339,7 +339,7 @@ static void ipmi_kcs_init(IPMIInterface *ii, unsigned int min_size,
     }
     ik->size_mask = min_size - 1;
     ik->io_length = 2;
-    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-kcs",
+    memory_region_init_io(&ik->io, OBJECT(ii), &ipmi_kcs_io_ops, ii, "ipmi-kcs",
                           min_size);
 }
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 24d8dc6e57..09c39140bd 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -966,13 +966,13 @@ static void virt_init(MachineState *machine)
         size = VIRT_LOWMEM_SIZE;
     }
 
-    memory_region_init_alias(&lvms->lowmem, NULL, "loongarch.lowram",
+    memory_region_init_alias(&lvms->lowmem, OBJECT(machine), "loongarch.lowram",
                               machine->ram, base, size);
     memory_region_add_subregion(address_space_mem, base, &lvms->lowmem);
     base += size;
     if (ram_size - size) {
         base = VIRT_HIGHMEM_BASE;
-        memory_region_init_alias(&lvms->highmem, NULL, "loongarch.highram",
+        memory_region_init_alias(&lvms->highmem, OBJECT(machine), "loongarch.highram",
                 machine->ram, VIRT_LOWMEM_BASE + size, ram_size - size);
         memory_region_add_subregion(address_space_mem, base, &lvms->highmem);
         base += ram_size - size;
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 1dc34dc247..26470b0251 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -94,11 +94,11 @@ petalogix_ml605_init(MachineState *machine)
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-    memory_region_init_ram(phys_lmb_bram, NULL, "petalogix_ml605.lmb_bram",
+    memory_region_init_ram(phys_lmb_bram, OBJECT(machine), "petalogix_ml605.lmb_bram",
                            LMB_BRAM_SIZE, &error_fatal);
     memory_region_add_subregion(address_space_mem, 0x00000000, phys_lmb_bram);
 
-    memory_region_init_ram(phys_ram, NULL, "petalogix_ml605.ram", ram_size,
+    memory_region_init_ram(phys_ram, OBJECT(machine), "petalogix_ml605.ram", ram_size,
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, MEMORY_BASEADDR, phys_ram);
 
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 6986eb7732..83bf325b2b 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -92,12 +92,12 @@ petalogix_s3adsp1800_init(MachineState *machine)
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-    memory_region_init_ram(phys_lmb_bram, NULL,
+    memory_region_init_ram(phys_lmb_bram, OBJECT(machine),
                            "petalogix_s3adsp1800.lmb_bram", LMB_BRAM_SIZE,
                            &error_fatal);
     memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
 
-    memory_region_init_ram(phys_ram, NULL, "petalogix_s3adsp1800.ram",
+    memory_region_init_ram(phys_ram, OBJECT(machine), "petalogix_s3adsp1800.ram",
                            ram_size, &error_fatal);
     memory_region_add_subregion(sysmem, ddr_base, phys_ram);
 
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 00154236bf..cf9314f86c 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -155,13 +155,13 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
     MemoryRegion *pmu_ram = g_new(MemoryRegion, 1);
 
     /* Create the ROM */
-    memory_region_init_rom(pmu_rom, NULL, "xlnx-zynqmp-pmu.rom",
+    memory_region_init_rom(pmu_rom, OBJECT(machine), "xlnx-zynqmp-pmu.rom",
                            XLNX_ZYNQMP_PMU_ROM_SIZE, &error_fatal);
     memory_region_add_subregion(address_space_mem, XLNX_ZYNQMP_PMU_ROM_ADDR,
                                 pmu_rom);
 
     /* Create the RAM */
-    memory_region_init_ram(pmu_ram, NULL, "xlnx-zynqmp-pmu.ram",
+    memory_region_init_ram(pmu_ram, OBJECT(machine), "xlnx-zynqmp-pmu.ram",
                            machine->ram_size, &error_fatal);
     memory_region_add_subregion(address_space_mem, XLNX_ZYNQMP_PMU_RAM_ADDR,
                                 pmu_ram);
diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
index 293970f156..ca2852fa87 100644
--- a/hw/or1k/or1k-sim.c
+++ b/hw/or1k/or1k-sim.c
@@ -312,7 +312,7 @@ static void openrisc_sim_init(MachineState *machine)
     }
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
+    memory_region_init_ram(ram, OBJECT(machine), "openrisc.ram", ram_size, &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
     openrisc_create_fdt(state, or1ksim_memmap, smp_cpus, machine->ram_size,
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index c0e0e3c48b..8cd520b320 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -498,7 +498,7 @@ static void openrisc_virt_init(MachineState *machine)
     }
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
+    memory_region_init_ram(ram, OBJECT(machine), "openrisc.ram", ram_size, &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
     openrisc_create_fdt(state, virt_memmap, smp_cpus, machine->ram_size,
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 7b4259c0e7..48135a7fc0 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -639,7 +639,7 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
     for (size_t i = 0; i < 3; i++) {
         char *name = g_strdup_printf("pci.lomem%zu", i);
 
-        memory_region_init_alias(&pcimem_lo_alias[i], NULL, name,
+        memory_region_init_alias(&pcimem_lo_alias[i], OBJECT(dev), name,
                                  &bs->pci_mem, i * 64 * MiB, 64 * MiB);
         memory_region_add_subregion(get_system_memory(),
                                     BONITO_PCILO_BASE + i * 64 * MiB,
@@ -713,7 +713,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
     create_unimplemented_device(OBJECT(dev), "IOCS[3]", BONITO_DEV_BASE + 3 * 256 * KiB,
                                 256 * KiB);
 
-    memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
+    memory_region_init_alias(pcimem_alias, OBJECT(dev), "pci.mem.alias",
                              &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
     memory_region_add_subregion(host_mem, BONITO_PCIHI_BASE, pcimem_alias);
     create_unimplemented_device(OBJECT(dev), "PCI_2",
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index 158c815505..77206b6636 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -388,7 +388,7 @@ static void ls7a_rtc_realize(DeviceState *dev, Error **errp)
     int i;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     LS7ARtcState *d = LS7A_RTC(sbd);
-    memory_region_init_io(&d->iomem, NULL, &ls7a_rtc_ops,
+    memory_region_init_io(&d->iomem, OBJECT(dev), &ls7a_rtc_ops,
                          (void *)d, "ls7a_rtc", 0x100);
 
     sysbus_init_irq(sbd, &d->irq);
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index a96ccca8e3..f9ef2758e1 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -345,7 +345,7 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate BIOS */
     prom_size = 8 * MiB;
-    memory_region_init_rom(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
+    memory_region_init_rom(prom, OBJECT(machine), "Leon3.bios", prom_size, &error_fatal);
     memory_region_add_subregion(address_space_mem, LEON3_PROM_OFFSET, prom);
 
     /* Load boot prom */
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 8fb9937127..58384e80da 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -106,23 +106,23 @@ static void niagara_init(MachineState *machine)
     /* init CPUs */
     sparc64_cpu_devinit(machine->cpu_type, NIAGARA_PROM_BASE);
     /* set up devices */
-    memory_region_init_ram(&s->hv_ram, NULL, "sun4v-hv.ram",
+    memory_region_init_ram(&s->hv_ram, OBJECT(machine), "sun4v-hv.ram",
                            NIAGARA_HV_RAM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram);
 
     memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
                                 machine->ram);
 
-    memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVRAM_SIZE,
+    memory_region_init_ram(&s->nvram, OBJECT(machine), "sun4v.nvram", NIAGARA_NVRAM_SIZE,
                            &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_NVRAM_BASE, &s->nvram);
-    memory_region_init_ram(&s->md_rom, NULL, "sun4v-md.rom",
+    memory_region_init_ram(&s->md_rom, OBJECT(machine), "sun4v-md.rom",
                            NIAGARA_MD_ROM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_MD_ROM_BASE, &s->md_rom);
-    memory_region_init_ram(&s->hv_rom, NULL, "sun4v-hv.rom",
+    memory_region_init_ram(&s->hv_rom, OBJECT(machine), "sun4v-hv.rom",
                            NIAGARA_HV_ROM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_ROM_BASE, &s->hv_rom);
-    memory_region_init_ram(&s->prom, NULL, "sun4v.prom", PROM_SIZE_MAX,
+    memory_region_init_ram(&s->prom, OBJECT(machine), "sun4v.prom", PROM_SIZE_MAX,
                            &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
 
@@ -140,7 +140,8 @@ static void niagara_init(MachineState *machine)
         BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
         int size = blk_getlength(blk);
         if (size > 0) {
-            memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram", size,
+            memory_region_init_ram(&s->vdisk_ram, OBJECT(machine), "sun4v_vdisk.ram",
+                                   size,
                                    &error_fatal);
             memory_region_add_subregion(get_system_memory(),
                                         NIAGARA_VDISK_BASE, &s->vdisk_ram);
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 67e499b74a..cea7e3d2f4 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -357,7 +357,7 @@ static void vmapple_firmware_init(VMAppleMachineState *vms,
         exit(1);
     }
 
-    memory_region_init_ram(&vms->fw_mr, NULL, "firmware", size, &error_fatal);
+    memory_region_init_ram(&vms->fw_mr, OBJECT(vms), "firmware", size, &error_fatal);
     image_size = load_image_mr(fname, &vms->fw_mr);
 
     g_free(fname);
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index dae523f723..1047aabd57 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -109,12 +109,12 @@ static void xen_pvh_init_ram(XenPVHMachineState *s,
     }
 
     if (s->cfg.mapcache) {
-        memory_region_init_ram(&xen_memory, NULL, "xen.ram",
+        memory_region_init_ram(&xen_memory, OBJECT(s), "xen.ram",
                                block_len, &error_fatal);
-        memory_region_init_alias(&s->ram.low, NULL, "xen.ram.lo", &xen_memory,
+        memory_region_init_alias(&s->ram.low, OBJECT(s), "xen.ram.lo", &xen_memory,
                                  s->cfg.ram_low.base, ram_size[0]);
         if (ram_size[1] > 0) {
-            memory_region_init_alias(&s->ram.high, NULL, "xen.ram.hi",
+            memory_region_init_alias(&s->ram.high, OBJECT(s), "xen.ram.hi",
                                      &xen_memory,
                                      s->cfg.ram_high.base, ram_size[1]);
         }
@@ -122,11 +122,11 @@ static void xen_pvh_init_ram(XenPVHMachineState *s,
         void *p;
 
         p = xen_map_guest_ram(s, s->cfg.ram_low.base, ram_size[0]);
-        memory_region_init_ram_ptr(&s->ram.low, NULL, "xen.ram.lo",
+        memory_region_init_ram_ptr(&s->ram.low, OBJECT(s), "xen.ram.lo",
                                    ram_size[0], p);
         if (ram_size[1] > 0) {
             p = xen_map_guest_ram(s, s->cfg.ram_high.base, ram_size[1]);
-            memory_region_init_ram_ptr(&s->ram.high, NULL, "xen.ram.hi",
+            memory_region_init_ram_ptr(&s->ram.high, OBJECT(s), "xen.ram.hi",
                                        ram_size[1], p);
         }
     }
@@ -140,7 +140,7 @@ static void xen_pvh_init_ram(XenPVHMachineState *s,
     /* Grants are only supported when the mapcache is on.  */
     if (s->cfg.mapcache) {
         /* Setup support for grants.  */
-        memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
+        memory_region_init_ram(&xen_grants, OBJECT(s), "xen.grants", block_len,
                 &error_fatal);
         memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
     }
-- 
2.47.1



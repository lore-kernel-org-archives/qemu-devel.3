Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7264C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD81-0004UY-Jd; Sat, 18 Jul 2026 18:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD7z-0004Nh-Uw; Sat, 18 Jul 2026 18:03:23 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD7x-0005Oi-Cj; Sat, 18 Jul 2026 18:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412201; x=1815948201;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GUPIqPSnXHKhYCW3HrZXJz3x53LLkXFzMUY1lGWJWaw=;
 b=Rg5VkZenK75v0LPua6hxS7wtLSmOASm409CGZIIG9r0L3AhgQByMrtn3
 KITY4CRF066FCTqyNzuTxBK2LE+SQfgcI7PBiGua1QwxlheMnazLSgXBs
 ZnwY5ncZ1Z/sLBamRKVLqHY5+60xkmeho8JUgZ1UmOWkTZmcbxkMeZyPT
 YB4QEzxRB69J39+DRLha3nO2nyHp+VmcjtzP1lo/PjbXPZKLT+2I169Bh
 yMJy2sfeuPm/URDBSsBsZnF1UT4rbv5SQu6NHuAOol4lFOrQelyROPwGu
 0ZsKd0MZ3K3455xn7ai4gcO4CcZ+75T1fK2G7tdlbTRPOtFCRkt7+MLhS A==;
X-CSE-ConnectionGUID: RJ3rqSGCRPuIPF+narQkSw==
X-CSE-MsgGUID: IfLEB6trS7e8BmKpDub51A==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23725542"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:03:17 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:18393]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.250:2525]
 with esmtp (Farcaster)
 id 60eec9b7-fa67-4dec-97bd-27f06aa3c6b8; Sat, 18 Jul 2026 22:03:17 +0000 (UTC)
X-Farcaster-Flow-ID: 60eec9b7-fa67-4dec-97bd-27f06aa3c6b8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:03:16 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:03:07 +0000
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
Subject: [RFC PATCH v2 094/137] hw/i386: Give memory regions an explicit owner
Date: Sat, 18 Jul 2026 21:36:09 +0000
Message-ID: <20260718213652.37673-95-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=50.112.246.219;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert memory_region_init*() calls that pass NULL owner to pass
the enclosing PC/x86/microvm machine or device instead.

Thread X86MachineState through x86_isa_bios_init() so the isa-bios
alias is owned by the machine that creates it.

No functional change intended.

RAMBlock idstrs are unchanged: the owners added here are Machine
or SysBus devices, and memory_region_register_ram() maps both to
dev=NULL for qemu_ram_set_idstr().

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/i386/microvm.c          |  4 ++--
 hw/i386/pc.c               |  8 ++++----
 hw/i386/pc_piix.c          |  2 +-
 hw/i386/pc_q35.c           |  2 +-
 hw/i386/pc_sysfw.c         |  6 +++---
 hw/i386/x86-common.c       | 11 ++++++-----
 hw/i386/xen/xen-hvm.c      |  8 ++++----
 hw/i386/xen/xen_pvdevice.c |  2 +-
 include/hw/i386/x86.h      |  3 ++-
 9 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index aa0e1ef155..751e3962fa 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -305,7 +305,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     }
 
     ram_below_4g = g_malloc(sizeof(*ram_below_4g));
-    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
+    memory_region_init_alias(ram_below_4g, OBJECT(mms), "ram-below-4g", machine->ram,
                              0, x86ms->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
 
@@ -313,7 +313,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
 
     if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g = g_malloc(sizeof(*ram_above_4g));
-        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
+        memory_region_init_alias(ram_above_4g, OBJECT(mms), "ram-above-4g",
                                  machine->ram,
                                  x86ms->below_4g_mem_size,
                                  x86ms->above_4g_mem_size);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e505391985..8057058ff0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -795,13 +795,13 @@ void pc_memory_init(PCMachineState *pcms,
      * done for backwards compatibility with older qemus.
      */
     ram_below_4g = g_malloc(sizeof(*ram_below_4g));
-    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
+    memory_region_init_alias(ram_below_4g, OBJECT(pcms), "ram-below-4g", machine->ram,
                              0, x86ms->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
     e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
     if (x86ms->above_4g_mem_size > 0) {
         ram_above_4g = g_malloc(sizeof(*ram_above_4g));
-        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
+        memory_region_init_alias(ram_above_4g, OBJECT(pcms), "ram-above-4g",
                                  machine->ram,
                                  x86ms->below_4g_mem_size,
                                  x86ms->above_4g_mem_size);
@@ -871,10 +871,10 @@ void pc_memory_init(PCMachineState *pcms,
     if (!is_tdx_vm()) {
         option_rom_mr = g_malloc(sizeof(*option_rom_mr));
         if (machine_require_guest_memfd(machine)) {
-            memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
+            memory_region_init_ram_guest_memfd(option_rom_mr, OBJECT(pcms), "pc.rom",
                                             PC_ROM_SIZE, &error_fatal);
         } else {
-            memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
+            memory_region_init_ram(option_rom_mr, OBJECT(pcms), "pc.rom", PC_ROM_SIZE,
                                 &error_fatal);
             if (pcmc->pci_enabled) {
                 memory_region_set_readonly(option_rom_mr, true);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c9e6c61734..0b8d7d88b9 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -191,7 +191,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     }
 
     pci_memory = g_new(MemoryRegion, 1);
-    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    memory_region_init(pci_memory, OBJECT(machine), "pci", UINT64_MAX);
 
     phb = OBJECT(qdev_new(OBJECT(machine), "i440fx", TYPE_I440FX_PCI_HOST_BRIDGE));
     object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 62625abed8..b2cdca8ade 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -208,7 +208,7 @@ static void pc_q35_init(MachineState *machine)
                                                &error_abort);
 
     /* allocate ram and load rom/bios */
-    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    memory_region_init(pci_memory, OBJECT(machine), "pci", UINT64_MAX);
     pc_memory_init(pcms, system_memory, pci_memory, pci_hole64_size);
 
     object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 02d75e2838..b536fca60f 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -52,10 +52,10 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * KiB);
     if (machine_require_guest_memfd(MACHINE(pcms))) {
-        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
+        memory_region_init_ram_guest_memfd(isa_bios, OBJECT(pcms), "isa-bios",
                                            isa_bios_size, &error_fatal);
     } else {
-        memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
+        memory_region_init_ram(isa_bios, OBJECT(pcms), "isa-bios", isa_bios_size,
                                &error_fatal);
     }
     memory_region_add_subregion_overlap(rom_memory,
@@ -189,7 +189,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
             if (pcmc->isa_bios_alias) {
-                x86_isa_bios_init(&x86ms->isa_bios, rom_memory, flash_mem,
+                x86_isa_bios_init(x86ms, &x86ms->isa_bios, rom_memory, flash_mem,
                                   true);
             } else {
                 pc_isa_bios_init(pcms, &x86ms->isa_bios, rom_memory, flash_mem);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 73a53fbf3f..151a67ee5f 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -993,13 +993,14 @@ void x86_load_linux(X86MachineState *x86ms,
     nb_option_roms++;
 }
 
-void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
+void x86_isa_bios_init(X86MachineState *x86ms, MemoryRegion *isa_bios,
+                       MemoryRegion *isa_memory,
                        MemoryRegion *bios, bool read_only)
 {
     uint64_t bios_size = memory_region_size(bios);
     uint64_t isa_bios_size = MIN(bios_size, 128 * KiB);
 
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+    memory_region_init_alias(isa_bios, OBJECT(x86ms), "isa-bios", bios,
                              bios_size - isa_bios_size, isa_bios_size);
     memory_region_add_subregion_overlap(isa_memory, 1 * MiB - isa_bios_size,
                                         isa_bios, 1);
@@ -1036,13 +1037,13 @@ static void load_bios_from_file(X86MachineState *x86ms, const char *bios_name,
 
     /* BIOS load */
     if (machine_require_guest_memfd(MACHINE(x86ms))) {
-        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
+        memory_region_init_ram_guest_memfd(&x86ms->bios, OBJECT(x86ms), "pc.bios",
                                            bios_size, &error_fatal);
         if (is_tdx_vm()) {
             tdx_set_tdvf_region(&x86ms->bios);
         }
     } else {
-        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
+        memory_region_init_ram(&x86ms->bios, OBJECT(x86ms), "pc.bios",
                                bios_size, &error_fatal);
     }
     if (sev_enabled() || is_tdx_vm()) {
@@ -1107,7 +1108,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
 
     if (!machine_require_guest_memfd(MACHINE(x86ms))) {
         /* map the last 128KB of the BIOS in ISA space */
-        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
+        x86_isa_bios_init(x86ms, &x86ms->isa_bios, rom_memory, &x86ms->bios,
                           !isapc_ram_fw);
     }
 
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d3ce082e07..01d851ce3e 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -156,11 +156,11 @@ static void xen_ram_init(PCMachineState *pcms,
          */
         block_len = (4 * GiB) + x86ms->above_4g_mem_size;
     }
-    memory_region_init_ram(&xen_memory, NULL, "xen.ram", block_len,
+    memory_region_init_ram(&xen_memory, OBJECT(pcms), "xen.ram", block_len,
                            &error_fatal);
     *ram_memory_p = &xen_memory;
 
-    memory_region_init_alias(&ram_640k, NULL, "xen.ram.640k",
+    memory_region_init_alias(&ram_640k, OBJECT(pcms), "xen.ram.640k",
                              &xen_memory, 0, 0xa0000);
     memory_region_add_subregion(sysmem, 0, &ram_640k);
     /* Skip of the VGA IO memory space, it will be registered later by the VGA
@@ -169,12 +169,12 @@ static void xen_ram_init(PCMachineState *pcms,
      * The area between 0xc0000 and 0x100000 will be used by SeaBIOS to load
      * the Options ROM, so it is registered here as RAM.
      */
-    memory_region_init_alias(&ram_lo, NULL, "xen.ram.lo",
+    memory_region_init_alias(&ram_lo, OBJECT(pcms), "xen.ram.lo",
                              &xen_memory, 0xc0000,
                              x86ms->below_4g_mem_size - 0xc0000);
     memory_region_add_subregion(sysmem, 0xc0000, &ram_lo);
     if (x86ms->above_4g_mem_size > 0) {
-        memory_region_init_alias(&ram_hi, NULL, "xen.ram.hi",
+        memory_region_init_alias(&ram_hi, OBJECT(pcms), "xen.ram.hi",
                                  &xen_memory, 0x100000000ULL,
                                  x86ms->above_4g_mem_size);
         memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index fab26a06af..6c255aeae1 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -108,7 +108,7 @@ static void xen_pv_realize(PCIDevice *pci_dev, Error **errp)
 
     pci_conf[PCI_INTERRUPT_PIN] = 1;
 
-    memory_region_init_io(&d->mmio, NULL, &xen_pv_mmio_ops, d,
+    memory_region_init_io(&d->mmio, OBJECT(pci_dev), &xen_pv_mmio_ops, d,
                           "mmio", d->size);
 
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_MEM_PREFETCH,
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 61d6ec1755..9d5d7694d4 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -121,7 +121,8 @@ void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
 void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                        DeviceState *dev, Error **errp);
 
-void x86_isa_bios_init(MemoryRegion *isa_bios, MemoryRegion *isa_memory,
+void x86_isa_bios_init(X86MachineState *x86ms, MemoryRegion *isa_bios,
+                       MemoryRegion *isa_memory,
                        MemoryRegion *bios, bool read_only);
 void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
                        MemoryRegion *rom_memory, bool isapc_ram_fw);
-- 
2.47.1



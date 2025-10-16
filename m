Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D948CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 19:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Tdj-0002P6-3D; Thu, 16 Oct 2025 15:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9Tdh-0002Oc-A4; Thu, 16 Oct 2025 15:27:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9TdY-0008Rd-CI; Thu, 16 Oct 2025 15:27:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 62AD55972EE;
 Thu, 16 Oct 2025 21:27:38 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ABpCZyLnFSxo; Thu, 16 Oct 2025 21:27:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4F2395972EC; Thu, 16 Oct 2025 21:27:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4CB395972E8;
 Thu, 16 Oct 2025 21:27:36 +0200 (CEST)
Date: Thu, 16 Oct 2025 21:27:36 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Vishal Chourasia <vishalc@linux.ibm.com>
cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com, 
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 5/5] hw/ppc: Pass errp to load_image_targphys() and report
 errors
In-Reply-To: <20251016173502.1261674-8-vishalc@linux.ibm.com>
Message-ID: <2b8acd7a-59eb-bc0c-13c2-de650afe28cc@eik.bme.hu>
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
 <20251016173502.1261674-8-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 16 Oct 2025, Vishal Chourasia wrote:
> Pass errp to load_image_targphys() calls in ppc machine initialization
> to capture detailed error information when loading firmware, kernel,
> and initrd images.
>
> Use error_reportf_err() instead of error_report() to print the
> underlying error details along with context about which image failed
> to load.
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
> hw/ppc/amigaone.c      | 11 ++++++-----
> hw/ppc/e500.c          | 13 +++++++------
> hw/ppc/mac_newworld.c  | 17 +++++++++--------
> hw/ppc/mac_oldworld.c  | 17 +++++++++--------
> hw/ppc/pegasos2.c      | 11 ++++++-----
> hw/ppc/pnv.c           | 18 ++++++++++--------
> hw/ppc/ppc440_bamboo.c |  7 ++++---
> hw/ppc/prep.c          | 17 +++++++++--------
> hw/ppc/sam460ex.c      |  7 ++++---
> hw/ppc/spapr.c         | 11 ++++++-----
> hw/ppc/virtex_ml507.c  |  9 +++++----
> 11 files changed, 75 insertions(+), 63 deletions(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 5c5acc9872..33a4066fa0 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -276,6 +276,7 @@ static void amigaone_init(MachineState *machine)
>     DriveInfo *di;
>     hwaddr loadaddr;
>     struct boot_info *bi = NULL;
> +    Error *errp = NULL;
>
>     /* init CPU */
>     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> @@ -324,9 +325,9 @@ static void amigaone_init(MachineState *machine)
>             error_report("Could not find firmware '%s'", machine->firmware);
>             exit(1);
>         }
> -        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, NULL);
> +        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, &errp);
>         if (sz <= 0 || sz > PROM_SIZE) {
> -            error_report("Could not load firmware '%s'", filename);
> +            error_reportf_err(errp, "Could not load firmware '%s': ", filename);
>             exit(1);
>         }
>     }
> @@ -413,10 +414,10 @@ static void amigaone_init(MachineState *machine)
>         loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
>         loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
>         sz = load_image_targphys(machine->initrd_filename, loadaddr,
> -                                 bi->bd_info - loadaddr, NULL);
> +                                 bi->bd_info - loadaddr, &errp);
>         if (sz <= 0) {
> -            error_report("Could not load initrd '%s'",
> -                         machine->initrd_filename);
> +            error_reportf_err(errp, "Could not load initrd '%s': ",
> +                              machine->initrd_filename);
>             exit(1);
>         }
>         bi->initrd_start = loadaddr;
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 30937a4a92..009d80da39 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -932,6 +932,7 @@ void ppce500_init(MachineState *machine)
>     MemoryRegion *ccsr_addr_space;
>     SysBusDevice *s;
>     I2CBus *i2c;
> +    Error *errp = NULL;
>
>     irqs = g_new0(IrqLines, smp_cpus);
>     for (i = 0; i < smp_cpus; i++) {
> @@ -1227,10 +1228,10 @@ void ppce500_init(MachineState *machine)
>         kernel_base = cur_base;
>         kernel_size = load_image_targphys(machine->kernel_filename,
>                                           cur_base,
> -                                          machine->ram_size - cur_base, NULL);
> +                                          machine->ram_size - cur_base, &errp);
>         if (kernel_size < 0) {
> -            error_report("could not load kernel '%s'",
> -                         machine->kernel_filename);
> +            error_reportf_err(errp, "could not load kernel '%s': ",
> +                              machine->kernel_filename);
>             exit(1);
>         }
>
> @@ -1242,11 +1243,11 @@ void ppce500_init(MachineState *machine)
>         initrd_base = (cur_base + INITRD_LOAD_PAD) & ~INITRD_PAD_MASK;
>         initrd_size = load_image_targphys(machine->initrd_filename, initrd_base,
>                                           machine->ram_size - initrd_base,
> -                                          NULL);
> +                                          &errp);
>
>         if (initrd_size < 0) {
> -            error_report("could not load initial ram disk '%s'",
> -                         machine->initrd_filename);
> +            error_reportf_err(errp, "could not load initial ram disk '%s': ",
> +                              machine->initrd_filename);
>             exit(1);
>         }
>
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 728525759c..d26cbcb0df 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -156,6 +156,7 @@ static void ppc_core99_init(MachineState *machine)
>     DeviceState *uninorth_internal_dev = NULL, *uninorth_agp_dev = NULL;
>     hwaddr nvram_addr = 0xFFF04000;
>     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
> +    Error *errp = NULL;
>
>     /* init CPUs */
>     for (i = 0; i < machine->smp.cpus; i++) {
> @@ -189,12 +190,12 @@ static void ppc_core99_init(MachineState *machine)
>         if (bios_size <= 0) {
>             /* or load binary ROM image */
>             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
> -                    NULL);
> +                                            &errp);
>         }
>         g_free(filename);
>     }
>     if (bios_size < 0 || bios_size > PROM_SIZE) {
> -        error_report("could not load PowerPC bios '%s'", bios_name);
> +        error_reportf_err(errp, "could not load PowerPC bios '%s': ", bios_name);
>         exit(1);
>     }
>
> @@ -212,11 +213,11 @@ static void ppc_core99_init(MachineState *machine)
>             kernel_size = load_image_targphys(machine->kernel_filename,
>                                               kernel_base,
>                                               machine->ram_size - kernel_base,
> -                                              NULL);
> +                                              &errp);
>         }
>         if (kernel_size < 0) {
> -            error_report("could not load kernel '%s'",
> -                         machine->kernel_filename);
> +            error_reportf_err(errp, "could not load kernel '%s': ",
> +                              machine->kernel_filename);
>             exit(1);
>         }
>         /* load initrd */
> @@ -225,10 +226,10 @@ static void ppc_core99_init(MachineState *machine)
>             initrd_size = load_image_targphys(machine->initrd_filename,
>                                               initrd_base,
>                                               machine->ram_size - initrd_base,
> -                                              NULL);
> +                                              &errp);
>             if (initrd_size < 0) {
> -                error_report("could not load initial ram disk '%s'",
> -                             machine->initrd_filename);
> +                error_reportf_err(errp, "could not load initial ram disk '%s': ",
> +                                  machine->initrd_filename);
>                 exit(1);
>             }
>             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index a067a191cd..4dbe74bfd2 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -108,6 +108,7 @@ static void ppc_heathrow_init(MachineState *machine)
>     DriveInfo *dinfo, *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>     void *fw_cfg;
>     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
> +    Error *errp = NULL;
>
>     /* init CPUs */
>     for (i = 0; i < machine->smp.cpus; i++) {
> @@ -144,13 +145,13 @@ static void ppc_heathrow_init(MachineState *machine)
>         if (bios_size <= 0) {
>             /* or if could not load ELF try loading a binary ROM image */
>             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
> -                    NULL);
> +                                            &errp);
>             bios_addr = PROM_BASE;
>         }
>         g_free(filename);
>     }
>     if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > PROM_SIZE) {
> -        error_report("could not load PowerPC bios '%s'", bios_name);
> +        error_reportf_err(errp, "could not load PowerPC bios '%s': ", bios_name);
>         exit(1);
>     }
>
> @@ -168,11 +169,11 @@ static void ppc_heathrow_init(MachineState *machine)
>             kernel_size = load_image_targphys(machine->kernel_filename,
>                                               kernel_base,
>                                               machine->ram_size - kernel_base,
> -                                              NULL);
> +                                              &errp);
>         }
>         if (kernel_size < 0) {
> -            error_report("could not load kernel '%s'",
> -                         machine->kernel_filename);
> +            error_reportf_err(errp, "could not load kernel '%s': ",
> +                              machine->kernel_filename);
>             exit(1);
>         }
>         /* load initrd */
> @@ -182,10 +183,10 @@ static void ppc_heathrow_init(MachineState *machine)
>             initrd_size = load_image_targphys(machine->initrd_filename,
>                                               initrd_base,
>                                               machine->ram_size - initrd_base,
> -                                              NULL);
> +                                              &errp);
>             if (initrd_size < 0) {
> -                error_report("could not load initial ram disk '%s'",
> -                             machine->initrd_filename);
> +                error_reportf_err(errp, "could not load initial ram disk '%s': ",
> +                                  machine->initrd_filename);
>                 exit(1);
>             }
>             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 7fa14fd0e6..d4703f79da 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -129,6 +129,7 @@ static void pegasos2_init(MachineState *machine)
>     int i;
>     ssize_t sz;
>     uint8_t *spd_data;
> +    Error *errp = NULL;
>
>     /* init CPU */
>     pm->cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> @@ -164,10 +165,10 @@ static void pegasos2_init(MachineState *machine)
>                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
>     if (sz <= 0) {
>         sz = load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PROM_SIZE,
> -                NULL);
> +                                 &errp);
>     }
>     if (sz <= 0 || sz > PROM_SIZE) {
> -        error_report("Could not load firmware '%s'", filename);
> +        error_reportf_err(errp, "Could not load firmware '%s': ", filename);

We can get here with *errp == NULL if load_elf did not fail but tried to 
load a too large image. Is that a problem? It's the same in prep.c. Mac 
machines also try different formats but those only check for size < 0 so 
maybe not a problem there.

>         exit(1);
>     }
>     g_free(filename);
> @@ -260,10 +261,10 @@ static void pegasos2_init(MachineState *machine)
>         pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
>         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
>         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
> -                                 machine->ram_size - pm->initrd_addr, NULL);
> +                                 machine->ram_size - pm->initrd_addr, &errp);
>         if (sz <= 0) {
> -            error_report("Could not load initrd '%s'",
> -                         machine->initrd_filename);
> +            error_reportf_err(errp, "Could not load initrd '%s': ",
> +                              machine->initrd_filename);
>             exit(1);
>         }
>         pm->initrd_size = sz;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index a3e5203970..88668a700e 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1015,6 +1015,7 @@ static void pnv_init(MachineState *machine)
>     char *chip_typename;
>     DriveInfo *pnor;
>     DeviceState *dev;
> +    Error *errp = NULL;
>
>     if (kvm_enabled()) {
>         error_report("machine %s does not support the KVM accelerator",
> @@ -1069,9 +1070,10 @@ static void pnv_init(MachineState *machine)
>     }
>
>     fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
> -                                    NULL);
> +                                    &errp);
>     if (fw_size < 0) {
> -        error_report("Could not load OPAL firmware '%s'", fw_filename);
> +        error_reportf_err(errp, "Could not load OPAL firmware '%s': ",
> +                          fw_filename);
>         exit(1);
>     }
>     g_free(fw_filename);
> @@ -1082,10 +1084,10 @@ static void pnv_init(MachineState *machine)
>
>         kernel_size = load_image_targphys(machine->kernel_filename,
>                                           KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
> -                                          NULL);
> +                                          &errp);
>         if (kernel_size < 0) {
> -            error_report("Could not load kernel '%s'",
> -                         machine->kernel_filename);
> +            error_reportf_err(errp, "Could not load kernel '%s': ",
> +                              machine->kernel_filename);
>             exit(1);
>         }
>     }
> @@ -1094,10 +1096,10 @@ static void pnv_init(MachineState *machine)
>     if (machine->initrd_filename) {
>         pnv->initrd_base = INITRD_LOAD_ADDR;
>         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
> -                                  pnv->initrd_base, INITRD_MAX_SIZE, NULL);
> +                                  pnv->initrd_base, INITRD_MAX_SIZE, &errp);
>         if (pnv->initrd_size < 0) {
> -            error_report("Could not load initial ram disk '%s'",
> -                         machine->initrd_filename);
> +            error_reportf_err(errp, "Could not load initial ram disk '%s': ",
> +                              machine->initrd_filename);
>             exit(1);
>         }
>     }
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 7c66912c10..9e55e56ee0 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -141,6 +141,7 @@ static void bamboo_init(MachineState *machine)
>     DeviceState *uicdev;
>     SysBusDevice *uicsbd;
>     int success;
> +    Error *errp = NULL;
>
>     if (kvm_enabled()) {
>         error_report("machine %s does not support the KVM accelerator",
> @@ -243,11 +244,11 @@ static void bamboo_init(MachineState *machine)
>     if (initrd_filename) {
>         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
>                                           machine->ram_size - RAMDISK_ADDR,
> -                                          NULL);
> +                                          &errp);
>
>         if (initrd_size < 0) {
> -            error_report("could not load ram disk '%s' at %x",
> -                         initrd_filename, RAMDISK_ADDR);
> +            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
> +                              initrd_filename, RAMDISK_ADDR);
>             exit(1);
>         }
>     }
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index edd3da7102..f8cf6dc16e 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -250,6 +250,7 @@ static void ibm_40p_init(MachineState *machine)
>     uint32_t kernel_base = 0, initrd_base = 0;
>     long kernel_size = 0, initrd_size = 0;
>     char boot_device;
> +    Error *errp = NULL;
>
>     if (kvm_enabled()) {
>         error_report("machine %s does not support the KVM accelerator",
> @@ -280,10 +281,10 @@ static void ibm_40p_init(MachineState *machine)
>     bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
>                          ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
>     if (bios_size < 0) {
> -        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, NULL);
> +        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, &errp);
>     }
>     if (bios_size < 0 || bios_size > BIOS_SIZE) {
> -        error_report("Could not load bios image '%s'", filename);
> +        error_reportf_err(errp, "Could not load bios image '%s': ", filename);
>         return;
>     }
>     g_free(filename);
> @@ -381,10 +382,10 @@ static void ibm_40p_init(MachineState *machine)
>         kernel_size = load_image_targphys(machine->kernel_filename,
>                                           kernel_base,
>                                           machine->ram_size - kernel_base,
> -                                          NULL);
> +                                          &errp);
>         if (kernel_size < 0) {
> -            error_report("could not load kernel '%s'",
> -                         machine->kernel_filename);
> +            error_reportf_err(errp, "could not load kernel '%s': ",
> +                              machine->kernel_filename);
>             exit(1);
>         }
>         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
> @@ -395,10 +396,10 @@ static void ibm_40p_init(MachineState *machine)
>             initrd_size = load_image_targphys(machine->initrd_filename,
>                                               initrd_base,
>                                               machine->ram_size - initrd_base,
> -                                              NULL);
> +                                              &errp);
>             if (initrd_size < 0) {
> -                error_report("could not load initial ram disk '%s'",
> -                             machine->initrd_filename);
> +                error_reportf_err(errp, "could not load initial ram disk '%s': ",
> +                                  machine->initrd_filename);
>                 exit(1);
>             }
>             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_base);
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 68d3eacbff..a5cb8e0738 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -262,6 +262,7 @@ static void sam460ex_init(MachineState *machine)
>     struct boot_info *boot_info;
>     uint8_t *spd_data;
>     int success;
> +    Error *errp = NULL;
>
>     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
>     env = &cpu->env;
> @@ -495,10 +496,10 @@ static void sam460ex_init(MachineState *machine)
>         initrd_size = load_image_targphys(machine->initrd_filename,
>                                           RAMDISK_ADDR,
>                                           machine->ram_size - RAMDISK_ADDR,
> -                                          NULL);
> +                                          &errp);
>         if (initrd_size < 0) {
> -            error_report("could not load ram disk '%s' at %x",
> -                    machine->initrd_filename, RAMDISK_ADDR);
> +            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
> +                              machine->initrd_filename, RAMDISK_ADDR);
>             exit(1);
>         }
>     }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9e17b5a31d..0be542c888 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2824,9 +2824,10 @@ static void spapr_machine_init(MachineState *machine)
>         error_report("Could not find LPAR firmware '%s'", bios_name);
>         exit(1);
>     }
> -    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, NULL);
> +    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, &errp);
>     if (fw_size <= 0) {
> -        error_report("Could not load LPAR firmware '%s'", filename);
> +        error_reportf_err(errp, "Could not load LPAR firmware '%s': ",
> +                          filename);
>         exit(1);
>     }
>
> @@ -3090,10 +3091,10 @@ static void spapr_machine_init(MachineState *machine)
>                                                      spapr->initrd_base,
>                                                      load_limit
>                                                      - spapr->initrd_base,
> -                                                     NULL);
> +                                                     &errp);
>             if (spapr->initrd_size < 0) {
> -                error_report("could not load initial ram disk '%s'",
> -                             initrd_filename);
> +                error_reportf_err(errp, "could not load initial ram disk '%s': ",
> +                                  initrd_filename);
>                 exit(1);
>             }
>         }
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 00d9ab7509..a7d3de62fa 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -195,6 +195,7 @@ static void virtex_init(MachineState *machine)
>     qemu_irq irq[32], cpu_irq;
>     int kernel_size;
>     int i;
> +    Error *errp = NULL;
>
>     /* init CPUs */
>     cpu = ppc440_init_xilinx(machine->cpu_type, 400000000);
> @@ -253,7 +254,7 @@ static void virtex_init(MachineState *machine)
>             /* If we failed loading ELF's try a raw image.  */
>             kernel_size = load_image_targphys(kernel_filename,
>                                               boot_offset,
> -                                              machine->ram_size, NULL);
> +                                              machine->ram_size, &errp);

What checks and reports errp? Was something left out here?

Regards,
BALATON Zoltan

>             boot_info.bootstrap_pc = boot_offset;
>             high = boot_info.bootstrap_pc + kernel_size + 8192;
>         }
> @@ -265,11 +266,11 @@ static void virtex_init(MachineState *machine)
>             initrd_base = high = ROUND_UP(high, 4);
>             initrd_size = load_image_targphys(machine->initrd_filename,
>                                               high, machine->ram_size - high,
> -                                              NULL);
> +                                              &errp);
>
>             if (initrd_size < 0) {
> -                error_report("couldn't load ram disk '%s'",
> -                             machine->initrd_filename);
> +                error_reportf_err(errp, "couldn't load ram disk '%s': ",
> +                                  machine->initrd_filename);
>                 exit(1);
>             }
>             high = ROUND_UP(high + initrd_size, 4);
>


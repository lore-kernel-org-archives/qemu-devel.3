Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9CACCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 19:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9qKU-0001WQ-In; Fri, 17 Oct 2025 15:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9qKS-0001Vd-IS; Fri, 17 Oct 2025 15:41:32 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9qKP-0001ul-5k; Fri, 17 Oct 2025 15:41:32 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 04DE35972EE;
 Fri, 17 Oct 2025 21:41:26 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id d1mxmMHHFg17; Fri, 17 Oct 2025 21:41:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E38B05972E9; Fri, 17 Oct 2025 21:41:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E0ED659703F;
 Fri, 17 Oct 2025 21:41:23 +0200 (CEST)
Date: Fri, 17 Oct 2025 21:41:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Vishal Chourasia <vishalc@linux.ibm.com>
cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com, 
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com, 
 hpoussin@reactos.org
Subject: Re: [Patch v4 5/5] hw/ppc: Pass errp to load_image_targphys() and
 report errors
In-Reply-To: <20251017182426.1423403-2-vishalc@linux.ibm.com>
Message-ID: <76c10ae5-a249-2f0e-a10b-053863210764@eik.bme.hu>
References: <20251017181250.1421446-2-vishalc@linux.ibm.com>
 <20251017182426.1423403-2-vishalc@linux.ibm.com>
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

On Fri, 17 Oct 2025, Vishal Chourasia wrote:
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
> hw/ppc/amigaone.c      | 15 ++++++++-------
> hw/ppc/e500.c          | 17 +++++++++--------
> hw/ppc/mac_newworld.c  | 26 ++++++++++++++++----------
> hw/ppc/mac_oldworld.c  | 26 ++++++++++++++++----------
> hw/ppc/pegasos2.c      | 17 +++++++++++------
> hw/ppc/pnv.c           | 31 ++++++++++++++-----------------
> hw/ppc/ppc440_bamboo.c |  9 +++++----
> hw/ppc/prep.c          | 25 +++++++++++++++----------
> hw/ppc/sam460ex.c      |  9 +++++----
> hw/ppc/spapr.c         | 15 ++++++++-------
> hw/ppc/virtex_ml507.c  | 17 +++++++++++------
> 11 files changed, 118 insertions(+), 89 deletions(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 5c5acc9872..bd14bed243 100644
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
> -        if (sz <= 0 || sz > PROM_SIZE) {
> -            error_report("Could not load firmware '%s'", filename);
> +        sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE, &errp);
> +        if (errp) {
> +            error_reportf_err(errp, "Could not load firmware '%s': ", filename);
>             exit(1);
>         }
>     }
> @@ -413,10 +414,10 @@ static void amigaone_init(MachineState *machine)
>         loadaddr = ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
>         loadaddr = MAX(loadaddr, INITRD_MIN_ADDR);
>         sz = load_image_targphys(machine->initrd_filename, loadaddr,
> -                                 bi->bd_info - loadaddr, NULL);
> -        if (sz <= 0) {
> -            error_report("Could not load initrd '%s'",
> -                         machine->initrd_filename);
> +                                 bi->bd_info - loadaddr, &errp);
> +        if (errp) {
> +            error_reportf_err(errp, "Could not load initrd '%s': ",
> +                              machine->initrd_filename);
>             exit(1);
>         }
>         bi->initrd_start = loadaddr;
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 30937a4a92..48e238f3a4 100644
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
> -        if (kernel_size < 0) {
> -            error_report("could not load kernel '%s'",
> -                         machine->kernel_filename);
> +                                          machine->ram_size - cur_base, &errp);
> +        if (errp) {
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
> -        if (initrd_size < 0) {
> -            error_report("could not load initial ram disk '%s'",
> -                         machine->initrd_filename);
> +        if (errp) {
> +            error_reportf_err(errp, "could not load initial ram disk '%s': ",
> +                              machine->initrd_filename);
>             exit(1);
>         }
>
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 004efc6b97..00d1b490d4 100644
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
> @@ -189,12 +190,17 @@ static void ppc_core99_init(MachineState *machine)
>         if (bios_size <= 0) {
>             /* or load binary ROM image */
>             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
> -                                            NULL);
> +                                            &errp);
>         }
>         g_free(filename);
>     }
>     if (bios_size < 0 || bios_size > PROM_SIZE) {
> -        error_report("could not load PowerPC bios '%s'", bios_name);
> +        if (!errp) {
> +            error_setg(&errp, ": exceeds max supported file size %lu",

The starting colon looks odd. What is this appended to? If not the name of 
the file then "exceeds" also looks wrong, if it's the text in 
error_reportf_err below then that already ends in a colon. Also either 
don't convert to megabytes or add that to text after the number to make it 
clear what measurement unit it is.

Regards,
BALATON Zoltan

> +                       PROM_SIZE / MiB);
> +        }
> +        error_reportf_err(errp, "could not load PowerPC bios '%s': ",
> +                          bios_name);
>         exit(1);
>     }
>
> @@ -212,11 +218,11 @@ static void ppc_core99_init(MachineState *machine)
>             kernel_size = load_image_targphys(machine->kernel_filename,
>                                               kernel_base,
>                                               machine->ram_size - kernel_base,
> -                                              NULL);
> +                                              &errp);
>         }
> -        if (kernel_size < 0) {
> -            error_report("could not load kernel '%s'",
> -                         machine->kernel_filename);
> +        if (errp) {
> +            error_reportf_err(errp, "could not load kernel '%s': ",
> +                              machine->kernel_filename);
>             exit(1);
>         }
>         /* load initrd */
> @@ -225,10 +231,10 @@ static void ppc_core99_init(MachineState *machine)
>             initrd_size = load_image_targphys(machine->initrd_filename,
>                                               initrd_base,
>                                               machine->ram_size - initrd_base,
> -                                              NULL);
> -            if (initrd_size < 0) {
> -                error_report("could not load initial ram disk '%s'",
> -                             machine->initrd_filename);
> +                                              &errp);
> +            if (errp) {
> +                error_reportf_err(errp, "couldn't load initial ram disk '%s': ",
> +                                  machine->initrd_filename);
>                 exit(1);
>             }
>             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index c7e44d49b0..2af74e13ef 100644
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
> @@ -144,13 +145,18 @@ static void ppc_heathrow_init(MachineState *machine)
>         if (bios_size <= 0) {
>             /* or if could not load ELF try loading a binary ROM image */
>             bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
> -                                            NULL);
> +                                            &errp);
>             bios_addr = PROM_BASE;
>         }
>         g_free(filename);
>     }
>     if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > PROM_SIZE) {
> -        error_report("could not load PowerPC bios '%s'", bios_name);
> +        if (!errp) {
> +            error_setg(&errp, ": exceeds max supported file size (%" PRIu64 " MiB)",
> +                       PROM_SIZE / MiB);
> +        }
> +        error_reportf_err(errp, "could not load PowerPC bios '%s': ",
> +                          bios_name);
>         exit(1);
>     }
>
> @@ -168,11 +174,11 @@ static void ppc_heathrow_init(MachineState *machine)
>             kernel_size = load_image_targphys(machine->kernel_filename,
>                                               kernel_base,
>                                               machine->ram_size - kernel_base,
> -                                              NULL);
> +                                              &errp);
>         }
> -        if (kernel_size < 0) {
> -            error_report("could not load kernel '%s'",
> -                         machine->kernel_filename);
> +        if (errp) {
> +            error_reportf_err(errp, "could not load kernel '%s': ",
> +                              machine->kernel_filename);
>             exit(1);
>         }
>         /* load initrd */
> @@ -182,10 +188,10 @@ static void ppc_heathrow_init(MachineState *machine)
>             initrd_size = load_image_targphys(machine->initrd_filename,
>                                               initrd_base,
>                                               machine->ram_size - initrd_base,
> -                                              NULL);
> -            if (initrd_size < 0) {
> -                error_report("could not load initial ram disk '%s'",
> -                             machine->initrd_filename);
> +                                              &errp);
> +            if (errp) {
> +                error_reportf_err(errp, "couldn't load initial ram disk '%s': ",
> +                                  machine->initrd_filename);
>                 exit(1);
>             }
>             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index 1f754df0e2..72d6e7117f 100644
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
> @@ -164,10 +165,14 @@ static void pegasos2_init(MachineState *machine)
>                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
>     if (sz <= 0) {
>         sz = load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PROM_SIZE,
> -                                 NULL);
> +                                 &errp);
>     }
>     if (sz <= 0 || sz > PROM_SIZE) {
> -        error_report("Could not load firmware '%s'", filename);
> +        if (!errp) {
> +            error_setg(&errp, ": exceeds max supported file size %lu",
> +                       PROM_SIZE / MiB);
> +        }
> +        error_reportf_err(errp, "Could not load firmware '%s': ", filename);
>         exit(1);
>     }
>     g_free(filename);
> @@ -260,10 +265,10 @@ static void pegasos2_init(MachineState *machine)
>         pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
>         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
>         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
> -                                 machine->ram_size - pm->initrd_addr, NULL);
> -        if (sz <= 0) {
> -            error_report("Could not load initrd '%s'",
> -                         machine->initrd_filename);
> +                                 machine->ram_size - pm->initrd_addr, &errp);
> +        if (errp) {
> +            error_reportf_err(errp, "Could not load initrd '%s': ",
> +                              machine->initrd_filename);
>             exit(1);
>         }
>         pm->initrd_size = sz;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 1c0dadda87..f5224537d3 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1009,12 +1009,12 @@ static void pnv_init(MachineState *machine)
>     PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(machine);
>     int max_smt_threads = pmc->max_smt_threads;
>     char *fw_filename;
> -    long fw_size;
>     uint64_t chip_ram_start = 0;
>     int i;
>     char *chip_typename;
>     DriveInfo *pnor;
>     DeviceState *dev;
> +    Error *errp = NULL;
>
>     if (kvm_enabled()) {
>         error_report("machine %s does not support the KVM accelerator",
> @@ -1068,24 +1068,21 @@ static void pnv_init(MachineState *machine)
>         exit(1);
>     }
>
> -    fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
> -                                  NULL);
> -    if (fw_size < 0) {
> -        error_report("Could not load OPAL firmware '%s'", fw_filename);
> +    if (load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
> +                                  &errp) < 0) {
> +        error_reportf_err(errp, "Could not load OPAL firmware '%s': ",
> +                          fw_filename);
>         exit(1);
>     }
>     g_free(fw_filename);
>
>     /* load kernel */
>     if (machine->kernel_filename) {
> -        long kernel_size;
> -
> -        kernel_size = load_image_targphys(machine->kernel_filename,
> -                                          KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
> -                                          NULL);
> -        if (kernel_size < 0) {
> -            error_report("Could not load kernel '%s'",
> -                         machine->kernel_filename);
> +        if (load_image_targphys(machine->kernel_filename,
> +                                KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
> +                                &errp) < 0) {
> +            error_reportf_err(errp, "Could not load kernel '%s': ",
> +                              machine->kernel_filename);
>             exit(1);
>         }
>     }
> @@ -1095,10 +1092,10 @@ static void pnv_init(MachineState *machine)
>         pnv->initrd_base = INITRD_LOAD_ADDR;
>         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
>                                                pnv->initrd_base,
> -                                               INITRD_MAX_SIZE, NULL);
> -        if (pnv->initrd_size < 0) {
> -            error_report("Could not load initial ram disk '%s'",
> -                         machine->initrd_filename);
> +                                               INITRD_MAX_SIZE, &errp);
> +        if (errp) {
> +            error_reportf_err(errp, "Could not load initial ram disk '%s': ",
> +                              machine->initrd_filename);
>             exit(1);
>         }
>     }
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 7c66912c10..64b5d9a4c4 100644
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
> -        if (initrd_size < 0) {
> -            error_report("could not load ram disk '%s' at %x",
> -                         initrd_filename, RAMDISK_ADDR);
> +        if (errp) {
> +            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
> +                              initrd_filename, RAMDISK_ADDR);
>             exit(1);
>         }
>     }
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index edd3da7102..43972d5f8d 100644
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
> @@ -280,10 +281,14 @@ static void ibm_40p_init(MachineState *machine)
>     bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
>                          ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
>     if (bios_size < 0) {
> -        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, NULL);
> +        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, &errp);
>     }
>     if (bios_size < 0 || bios_size > BIOS_SIZE) {
> -        error_report("Could not load bios image '%s'", filename);
> +        if (!errp) {
> +            error_setg(&errp, ": exceeds max supported file size %lu",
> +                       BIOS_SIZE / MiB);
> +        }
> +        error_reportf_err(errp, "Could not load bios image '%s': ", filename);
>         return;
>     }
>     g_free(filename);
> @@ -381,10 +386,10 @@ static void ibm_40p_init(MachineState *machine)
>         kernel_size = load_image_targphys(machine->kernel_filename,
>                                           kernel_base,
>                                           machine->ram_size - kernel_base,
> -                                          NULL);
> -        if (kernel_size < 0) {
> -            error_report("could not load kernel '%s'",
> -                         machine->kernel_filename);
> +                                          &errp);
> +        if (errp) {
> +            error_reportf_err(errp, "could not load kernel '%s': ",
> +                              machine->kernel_filename);
>             exit(1);
>         }
>         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
> @@ -395,10 +400,10 @@ static void ibm_40p_init(MachineState *machine)
>             initrd_size = load_image_targphys(machine->initrd_filename,
>                                               initrd_base,
>                                               machine->ram_size - initrd_base,
> -                                              NULL);
> -            if (initrd_size < 0) {
> -                error_report("could not load initial ram disk '%s'",
> -                             machine->initrd_filename);
> +                                              &errp);
> +            if (errp) {
> +                error_reportf_err(errp, "couldn't load initial ram disk '%s': ",
> +                                  machine->initrd_filename);
>                 exit(1);
>             }
>             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_base);
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 68d3eacbff..9102bfb6d1 100644
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
> -        if (initrd_size < 0) {
> -            error_report("could not load ram disk '%s' at %x",
> -                    machine->initrd_filename, RAMDISK_ADDR);
> +                                          &errp);
> +        if (errp) {
> +            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
> +                              machine->initrd_filename, RAMDISK_ADDR);
>             exit(1);
>         }
>     }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e51540a5ad..18d73868ed 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2824,9 +2824,10 @@ static void spapr_machine_init(MachineState *machine)
>         error_report("Could not find LPAR firmware '%s'", bios_name);
>         exit(1);
>     }
> -    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, NULL);
> -    if (fw_size <= 0) {
> -        error_report("Could not load LPAR firmware '%s'", filename);
> +    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, &errp);
> +    if (errp) {
> +        error_reportf_err(errp, "Could not load LPAR firmware '%s': ",
> +                          filename);
>         exit(1);
>     }
>
> @@ -3089,10 +3090,10 @@ static void spapr_machine_init(MachineState *machine)
>             spapr->initrd_size = load_image_targphys(initrd_filename,
>                                                 spapr->initrd_base,
>                                                 load_limit - spapr->initrd_base,
> -                                                NULL);
> -            if (spapr->initrd_size < 0) {
> -                error_report("could not load initial ram disk '%s'",
> -                             initrd_filename);
> +                                                &errp);
> +            if (errp) {
> +                error_reportf_err(errp, "couldn't load initial ram disk '%s': ",
> +                                  initrd_filename);
>                 exit(1);
>             }
>         }
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 00d9ab7509..e1b658bcda 100644
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
> @@ -253,7 +254,12 @@ static void virtex_init(MachineState *machine)
>             /* If we failed loading ELF's try a raw image.  */
>             kernel_size = load_image_targphys(kernel_filename,
>                                               boot_offset,
> -                                              machine->ram_size, NULL);
> +                                              machine->ram_size, &errp);
> +            if (errp) {
> +                error_reportf_err(errp, "couldn't load kernel '%s': ",
> +                                  kernel_filename);
> +                exit(1);
> +            }
>             boot_info.bootstrap_pc = boot_offset;
>             high = boot_info.bootstrap_pc + kernel_size + 8192;
>         }
> @@ -265,11 +271,10 @@ static void virtex_init(MachineState *machine)
>             initrd_base = high = ROUND_UP(high, 4);
>             initrd_size = load_image_targphys(machine->initrd_filename,
>                                               high, machine->ram_size - high,
> -                                              NULL);
> -
> -            if (initrd_size < 0) {
> -                error_report("couldn't load ram disk '%s'",
> -                             machine->initrd_filename);
> +                                              &errp);
> +            if (errp) {
> +                error_reportf_err(errp, "couldn't load ram disk '%s': ",
> +                                  machine->initrd_filename);
>                 exit(1);
>             }
>             high = ROUND_UP(high + initrd_size, 4);
>


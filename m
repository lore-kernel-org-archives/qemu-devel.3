Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ABCC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wenLf-0002qf-WF; Wed, 01 Jul 2026 01:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wenLe-0002q9-7s
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:18:58 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wenLb-0005Sw-8M
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 01:18:58 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664a04eb233so15885d50.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782883133; cv=none;
 d=google.com; s=arc-20260327;
 b=I7F7oqoBbsckOGMhvLKB6gB8MlbFBtNkPVitmePJN3teAKHPh/K6jqwBPO6aV3/ITa
 wZ+l+LNQHnkw7rg4/8DTZbum3pPX110AhdVDDvYpFJZXd+tUcjQ17UMqu7TvwcMbmWfQ
 SDTH0DQMlx5x4HJ8QryKoXhrzDX2kgqKo2BZy0vi2x0tIkCXlvAK4epjOSM/Sa49/oOl
 D6zDsP4wEAIkzobOR7Rpvma1fl/wPkqpwpcnyv7tKFGgLPsZtyKVLB0XexQD5K9usaJV
 SeLoNPvI6CgD5YBYUyGbzCb7mzLNpGe6tDK2YIDm4u1vkD1NJTVYkt2eyNxT0Km8tX1m
 OjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IFDTGp1h0mUNnNu3rWFBhwna4uvridks/7C7mt1DZ5g=;
 fh=IkB06zlptLNwZWqZZYeXbjXkoD1LHThvp6kPB9WHEGU=;
 b=pQcfwNqpw1ub1FYzXtXYiUd08n6NA0Hx3Hl0VrJTN8EG7kejOAzEifEQjzh/KK989/
 m4GthYqebZLZjvpWzIgrCuYFfsa7JADBORO0xS66AztMI/jxjZ5dPXnp7SXLC80+/zad
 40Q5DZ9j3M2LNMJAkHLc42Yh/+1PkPWHoumnccGoN7qaOqFUEOACbdNoCOuV986eKwLQ
 3PUnoD24wBfvoJIFADV3rG7KSAErYnZqGnJDe84WaVsH3v/jYvUgq7XGlxxXsgJ8zSqf
 rM0Yh2h4HRpaoAvs3z4ala+PUaqdsAI/JZbD23u7IBv36YCh/PtDmqz0vQ39vHLH/+xJ
 a50Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1782883133; x=1783487933; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IFDTGp1h0mUNnNu3rWFBhwna4uvridks/7C7mt1DZ5g=;
 b=ZS6fagQxPR9Bdv9OYYxTQqy2I+GarvR25uLWUVMlL4IjduLlThAgoquLaQrqHcwkJi
 5mH+QoQu334h74Eo0VgVOPhAyFz7iImrGakDfGjP50zpc5tGhw0HDBhofX2e2a6Qx1TA
 A18m7uKAA0HJY6vKW81fjXD8oE+byfF+1Y+SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782883133; x=1783487933;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IFDTGp1h0mUNnNu3rWFBhwna4uvridks/7C7mt1DZ5g=;
 b=DQH9DoCInf18XpkEeOH8zASzqArguto7bXJLRbjIjEeGkfXO/vXIvoUQ1WKFIZYWb3
 hs52blxbocVwcuBz0c0vQqnRUbgHSD+bKq3RhIqmMss32NzCZKcBfAvtI+DC2xwPIlvF
 uuOdcyLpXKy6oAIp3WNwh3kquAWgegESznsYdiNRjfMVeEKjmPgOhCX1ncIE2oZ0ajGc
 wRGSyQ860BkaN0X01bWpe1d5l8Aai+eGFdweYeJEcU2J+FrNKuLGFTgVF+5wJf5s779K
 1rMwerVGPHWreoHnRXvkz8ZOTBSDk+xJFv1eLXLihpzj4b01Y5CkbjZS7wIOWlbgO9wq
 zjfg==
X-Gm-Message-State: AOJu0YxaxYBJbNSzERAxtdcTN8eSq/abIyjEmZiFjh0+FElJOxMYGKiM
 L0B+DCWOUpAIPnCExR5DJWKK7M1EyZbvcoYoxnxBzNaQ5KAZNFbNgOQZhW2Ti75fTHAwX6ZHkNq
 lxEkwWYmWGknT7YIOgbSzGJV/keE4wu0=
X-Gm-Gg: AfdE7cmKOZrWunUbBLq5MVdhP+a7f6D8tBoQXAYjsj78mIaRX410z6Nt4cUdgrzwzRF
 kB8k7FyDRNGhkDn87oIU7f/jgeshHEIEPUaIdAPJTO5pWSGxzW/60UYHG1CNNe0QawpIcer3dND
 a9xVSUc+I65Dm+HMxnNSpuuQGDd9ddeQh8gWyMimpWrluarvwJAXqGCYo7IpfMCinln8ULp34Km
 cq894xWqrKRv4upkaNyJmJ6b+tHNpbXMzD7FxyluMzqKJp8ggeYSbfr7Ric46iMnoOAPbrnrH3n
 nGoiQpxrMK2OYO/JGmSqPkmoO1tvtH3wTLa6yI809vlTT2oWI/sLjXnz8Vny9NtKcrAE4jFGZLl
 L05mcjzI7FN4UGw==
X-Received: by 2002:a05:690e:4854:20b0:662:f405:5d41 with SMTP id
 956f58d0204a3-66521a8cb8emr104988d50.33.1782883133330; Tue, 30 Jun 2026
 22:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260610214133.1882563-4-daniel.barboza@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Jul 2026 14:48:42 +0930
X-Gm-Features: AVVi8Cd5EnZPcXWMbYJYLSCq7vE818NkRFavbvCiofl11Ol575xjOaYGKi0_UmY
Message-ID: <CACPK8XdnC-nzm3brVYSOPZT3Y6T+67dLsZNDsqJt0mO7=etHsA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] hw/riscv: server platform reference machine
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com, uwu@icenowy.me, 
 Fei Wu <wu.fei9@sanechips.com.cn>, Paolo Bonzini <pbonzini@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 11 Jun 2026 at 07:11, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> From: Fei Wu <wu.fei9@sanechips.com.cn>
>
> The RISC-V Server Platform specification [1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
>
> The main features included in this emulation are:
>
> - Based on riscv virt machine type;
> - A new memory map as close as virt machine as possible;
> - An always present IOMMU platform device (riscv-iommu-sys) that uses
>   IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
> - AIA;
> - PCIe AHCI;
> - PCIe NIC;
> - No virtio device;
> - No fw_cfg device;
> - No ACPI table provided;
> - Only minimal device tree nodes.

I like the separation of the device tree generation from the machine
that the loongarch board has. See hw/loongarch/virt-fdt-build.c.

I've left a few comments below that my not be relevant any more. I
know you're in the process of re-working this machine, so please
ignore if you've already changed things.

> new file mode 100644
> index 0000000000..7e626c6eb7
> --- /dev/null
> +++ b/hw/riscv/server_platform_ref.c

> +enum {
> +    RVSERVER_UART0_IRQ = 10,
> +    RVSERVER_RTC_IRQ = 11,
> +    RVSERVER_PCIE_IRQ = 0x20, /* 32 to 35 */
> +    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */

Use decimal? Or go all hex, but decimal makes it easier to confirm
your comments make sense.

> +};
> +
> +/*
> + * The server soc reference machine physical address space used by some of the
> + * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
> + * of CPUs, and number of IMSIC guest files.
> + *
> + * Various limits defined by RVSERVER_SOCKETS_MAX_BITS, RVSERVER_CPUS_MAX_BITS,
> + * and RVSERVER_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization of
> + * server reference machine physical address space.
> + */
> +
> +#define RVSERVER_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
> +#if RVSERVER_IMSIC_GROUP_MAX_SIZE < \
> +    IMSIC_GROUP_SIZE(RVSERVER_CPUS_MAX_BITS, RVSERVER_IRQCHIP_MAX_GUESTS_BITS)
> +#error "Can't accomodate single IMSIC group in address space"
> +#endif
> +
> +#define RVSERVER_IMSIC_MAX_SIZE            (RVSERVER_SOCKETS_MAX * \
> +                                        RVSERVER_IMSIC_GROUP_MAX_SIZE)
> +#if 0x4000000 < RVSERVER_IMSIC_MAX_SIZE
> +#error "Can't accomodate all IMSIC groups in address space"
> +#endif

Could we avoid cut/pasting this and make them common helpers?

(Some of these are refactored out in the Atlantis series)

> +
> +static const MemMapEntry rvserver_ref_memmap[] = {
> +    [RVSERVER_DEBUG] =          {        0x0,         0x100 },
> +    [RVSERVER_MROM] =           {     0x1000,        0xf000 },
> +    [RVSERVER_RESET_SYSCON] =   {   0x100000,        0x1000 },

Will a real server have a syscon?

> +
> +static void rvserver_flash_map(PFlashCFI01 *flash,
> +                               hwaddr base, hwaddr size,
> +                               MemoryRegion *sysmem)
> +{
> +    DeviceState *dev = DEVICE(flash);
> +
> +    assert(QEMU_IS_ALIGNED(size, RVSERVER_FLASH_SECTOR_SIZE));
> +    assert(size / RVSERVER_FLASH_SECTOR_SIZE <= UINT32_MAX);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / RVSERVER_FLASH_SECTOR_SIZE);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    memory_region_add_subregion(sysmem, base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
> +                                                       0));
> +}
> +
> +static void rvserver_flash_maps(RISCVServerRefMachineState *s,
> +                                MemoryRegion *sysmem)
> +{
> +    hwaddr flashsize = rvserver_ref_memmap[RVSERVER_FLASH].size / 2;
> +    hwaddr flashbase = rvserver_ref_memmap[RVSERVER_FLASH].base;
> +
> +    rvserver_flash_map(s->flash[0], flashbase, flashsize, sysmem);
> +    rvserver_flash_map(s->flash[1], flashbase + flashsize, flashsize, sysmem);

IIRC the arm virt board has two flashes; one for secure and the other
for non-secure stuff. Does this board need that? Could it just have
one flash?


> +static void create_fdt_rtc(RISCVServerRefMachineState *s,
> +                           const MemMapEntry *memmap,
> +                           uint32_t irq_mmio_phandle)
> +{
> +    g_autofree char *name = NULL;
> +    MachineState *ms = MACHINE(s);
> +
> +    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
> +                           memmap[RVSERVER_RTC].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "google,goldfish-rtc");

Would an i2c attached device be more realistic for a server platform?

> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSERVER_RTC].base, 0x0, memmap[RVSERVER_RTC].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
> +                          irq_mmio_phandle);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
> +                           RVSERVER_RTC_IRQ, 0x4);
> +}

> +static void create_fdt(RISCVServerRefMachineState *s,
> +                       const MemMapEntry *memmap)
> +{
> +    MachineState *ms = MACHINE(s);
> +    uint8_t rng_seed[32];
> +
> +    ms->fdt = create_device_tree(&s->fdt_size);
> +    if (!ms->fdt) {
> +        error_report("create_device_tree() failed");
> +        exit(1);
> +    }
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/", "model", "qemu,riscv-server-ref");

This is the name. "Daniel's Awesome RISC-V Server Reference Platform"

OpenSBI prints it:
  Platform Name               : Daniel's Awesome RISC-V Server
Reference Platform

As does Linux:
  [    0.000000] Machine model:  Daniel's Awesome RISC-V Server
Reference Platform

> +    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "riscv-server-ref");

and this is the comaptible; "qemu,riscv-server-ref".

> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
> +
> +    /*
> +     * This versioning scheme is for informing platform fw only. It is neither:
> +     * - A QEMU versioned machine type; a given version of QEMU will emulate
> +     *   a given version of the platform.
> +     * - A reflection of level of server platform support provided.
> +     *
> +     * machine-version-major: updated when changes breaking fw compatibility
> +     *                        are introduced.
> +     * machine-version-minor: updated when features are added that don't break
> +     *                        fw compatibility.
> +     *
> +     * It's the same as the scheme in arm sbsa-ref.
> +     */
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-major", 0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-minor", 0);

Sounds like something that should go in the compatible string.

> +
> +    qemu_fdt_add_subnode(ms->fdt, "/chosen");
> +
> +    /* Pass seed to RNG */
> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));

This is overwritten in qemu_fdt_randomize_seeds (via riscv_load_fdt)
as long as the node is present.

> +    qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
> +                     rng_seed, sizeof(rng_seed));

> +
> +static bool rvserver_aclint_allowed(void)
> +{
> +    return tcg_enabled() || qtest_enabled();
> +}
> +
> +static void rvserver_ref_machine_init(MachineState *machine)
> +{
> +    const MemMapEntry *memmap = rvserver_ref_memmap;
> +    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(machine);
> +    MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> +    MemoryRegion *reset_syscon_io = g_new(MemoryRegion, 1);
> +    DeviceState *mmio_irqchip, *pcie_irqchip, *iommu_sys;
> +    int i, base_hartid, hart_count;
> +    int socket_count = riscv_socket_count(machine);
> +
> +    /* Check socket count limit */
> +    if (RVSERVER_SOCKETS_MAX < socket_count) {
> +        error_report("number of sockets/nodes should be less than %d",
> +            RVSERVER_SOCKETS_MAX);
> +        exit(1);
> +    }
> +
> +    if (!rvserver_aclint_allowed()) {
> +        error_report("'aclint' is only available with TCG acceleration");

Is this machine designed to be run as a kvm guest? If not, we can drop
this code.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567C1CFA749
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 04:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swaKr-0004Wu-1S; Fri, 04 Oct 2024 00:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swaKo-0004VM-OI
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 00:54:34 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swaKk-0000Tr-OF
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 00:54:34 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7db238d07b3so1326269a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728017669; x=1728622469;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DoR2y/BEvLT3Wyv3j1v06A4YEajosbQwcuh7HkXlVfA=;
 b=YdlMaoXOfhDhRMveFSgSndiycfUES0FAejtrsLrMCrGqxfHQR102Q3iqIz/zrNM3TZ
 E++Cy4ccXhT104UUGpDH0wCwsC3uqkXTf5y9EUT2H53jn1QLJk9kAQrLElPvRq7WzmNa
 X66CGi6lAzEEnffGCXm6rAxFSFDC4onrYCdD9Hc/x5AqjrQu2Ox0HgLK/p3ad85jKM/f
 DOilsVzgx8qwVCUkC+ZtYslFQO1bLWDpW5xefTs3rdn9+Vx/rpgzwojDoueSc0hLnLwU
 wITeM2draeN11yRP+YjyqPzlzXXPvKN7vcspM/87F7t4opDbKSyQhB51j619N2lknHz/
 zvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728017669; x=1728622469;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DoR2y/BEvLT3Wyv3j1v06A4YEajosbQwcuh7HkXlVfA=;
 b=NpJzNj7zmbbi9PsFV4TzMwTL8CSGwAaJKjQQtSJkrNNnOmsBluOj8igRxKextP11GN
 7tdiI/F5M9eOaVBXJMGSuyyUQ36WHP2CrnGPUhZqkwlhWVL/UMZES2a5L7tNgLXYsKkl
 BfcF1YjJR6vqkg80QGnExUerS1qwANVSKEWFBFPKvMRj0Z+l0td85/zYurbmbWZ5ymFQ
 GULrcBZMUDg7O3OfejfCRWUAk+UBNymR8QZ2yvlss/dpv2/2iEF3tOtASrUysGrXXqrZ
 HbMdvNr24PZ9n9xbC+bwjcbGT+Wn9iUuZpX9nYmSgYdI8QaJsLxR56ezOXIsbxS1P5gJ
 QfJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ldtBKy1GgeTJ17MhE9kks+KGWJccw4hsSjCmSsFZ9tbrKrix9cDbUg/AH8x2U30zzweThROaPE9d@nongnu.org
X-Gm-Message-State: AOJu0YyyMwu6pm3sYeE/WCoA/0einp7rA65jMDKQrytodls+lzs8F8Fo
 VVWhi0nxLd3edDut2pos8R1G6KBR17dObOqbyB3eLFl0SvA6d/2GjccaBJGZQZc=
X-Google-Smtp-Source: AGHT+IHASOGzClK5goJshwtBC0gmGavzKCYkQnoJLfvEDmkYY65neI4WKgQGuaQSbyF9cVZd05X7fw==
X-Received: by 2002:a17:90b:3891:b0:2d8:9506:5dfd with SMTP id
 98e67ed59e1d1-2e1e636770fmr1825027a91.35.1728017668683; 
 Thu, 03 Oct 2024 21:54:28 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e85d2425sm501765a91.18.2024.10.03.21.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 21:54:28 -0700 (PDT)
Message-ID: <3d8bbf34-70bf-48a0-8a91-7f82d7963ceb@daynix.com>
Date: Fri, 4 Oct 2024 13:54:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] gpex: Allow more than 4 legacy IRQs
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-10-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240928085727.56883-10-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Some boards such as vmapple don't do real legacy PCI IRQ swizzling.
> Instead, they just keep allocating more board IRQ lines for each new
> legacy IRQ. Let's support that mode by giving instantiators a new
> "nr_irqs" property they can use to support more than 4 legacy IRQ lines.
> In this mode, GPEX will export more IRQ lines, one for each device.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/arm/sbsa-ref.c          |  2 +-
>   hw/arm/virt.c              |  2 +-
>   hw/i386/microvm.c          |  2 +-
>   hw/loongarch/virt.c        |  2 +-
>   hw/mips/loongson3_virt.c   |  2 +-
>   hw/openrisc/virt.c         | 12 ++++++------
>   hw/pci-host/gpex.c         | 36 +++++++++++++++++++++++++++++++-----
>   hw/riscv/virt.c            | 12 ++++++------
>   hw/xtensa/virt.c           |  2 +-
>   include/hw/pci-host/gpex.h |  7 +++----
>   10 files changed, 52 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index e3195d54497..7e7322486c2 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -673,7 +673,7 @@ static void create_pcie(SBSAMachineState *sms)
>       /* Map IO port space */
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
>   
> -    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>                              qdev_get_gpio_in(sms->gic, irq + i));
>           gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 8b2b991d978..bd3b17be2ea 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1547,7 +1547,7 @@ static void create_pcie(VirtMachineState *vms)
>       /* Map IO port space */
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
>   
> -    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>                              qdev_get_gpio_in(vms->gic, irq + i));
>           gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 40edcee7af2..216a169c413 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -139,7 +139,7 @@ static void create_gpex(MicrovmMachineState *mms)
>                                       mms->gpex.mmio64.base, mmio64_alias);
>       }
>   
> -    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>                              x86ms->gsi[mms->gpex.irq + i]);
>       }
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 75980b6e3c7..8eb7277a8d1 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -703,7 +703,7 @@ static void virt_devices_init(DeviceState *pch_pic,
>       memory_region_add_subregion(get_system_memory(), VIRT_PCI_IO_BASE,
>                                   pio_alias);
>   
> -    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>           sysbus_connect_irq(d, i,
>                              qdev_get_gpio_in(pch_pic, 16 + i));
>           gpex_set_irq_num(GPEX_HOST(gpex_dev), i, 16 + i);
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 2067b4fecb5..acafd73129d 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -458,7 +458,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
>                                   virt_memmap[VIRT_PCIE_PIO].base, s->pio_alias);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, virt_memmap[VIRT_PCIE_PIO].base);
>   
> -    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>           irq = qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
>           gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
> diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
> index f8a68a6a6b1..16a5676c4bb 100644
> --- a/hw/openrisc/virt.c
> +++ b/hw/openrisc/virt.c
> @@ -318,7 +318,7 @@ static void create_pcie_irq_map(void *fdt, char *nodename, int irq_base,
>   {
>       int pin, dev;
>       uint32_t irq_map_stride = 0;
> -    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS * 6] = {};
> +    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS * 6] = {};
>       uint32_t *irq_map = full_irq_map;
>   
>       /*
> @@ -330,11 +330,11 @@ static void create_pcie_irq_map(void *fdt, char *nodename, int irq_base,
>        * possible slot) seeing the interrupt-map-mask will allow the table
>        * to wrap to any number of devices.
>        */
> -    for (dev = 0; dev < GPEX_NUM_IRQS; dev++) {
> +    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
>           int devfn = dev << 3;
>   
> -        for (pin = 0; pin < GPEX_NUM_IRQS; pin++) {
> -            int irq_nr = irq_base + ((pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
> +        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
> +            int irq_nr = irq_base + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
>               int i = 0;
>   
>               /* Fill PCI address cells */
> @@ -357,7 +357,7 @@ static void create_pcie_irq_map(void *fdt, char *nodename, int irq_base,
>       }
>   
>       qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> -                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> +                     PCI_NUM_PINS * PCI_NUM_PINS *
>                        irq_map_stride * sizeof(uint32_t));
>   
>       qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> @@ -409,7 +409,7 @@ static void openrisc_virt_pcie_init(OR1KVirtState *state,
>       memory_region_add_subregion(get_system_memory(), pio_base, alias);
>   
>       /* Connect IRQ lines. */
> -    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>           pcie_irq = get_per_cpu_irq(cpus, num_cpus, irq_base + i);
>   
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pcie_irq);
> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
> index e9cf455bf52..4aca0a95771 100644
> --- a/hw/pci-host/gpex.c
> +++ b/hw/pci-host/gpex.c
> @@ -32,6 +32,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "hw/irq.h"
> +#include "hw/pci/pci_bus.h"
>   #include "hw/pci-host/gpex.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
> @@ -50,7 +51,7 @@ static void gpex_set_irq(void *opaque, int irq_num, int level)
>   
>   int gpex_set_irq_num(GPEXHost *s, int index, int gsi)
>   {
> -    if (index >= GPEX_NUM_IRQS) {
> +    if (index >= s->nr_irqs) {
>           return -EINVAL;
>       }
>   
> @@ -74,14 +75,29 @@ static PCIINTxRoute gpex_route_intx_pin_to_irq(void *opaque, int pin)
>       return route;
>   }
>   
> +static int gpex_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin)
> +{
> +    PCIBus *bus = pci_device_root_bus(pci_dev);
> +
> +    return (PCI_SLOT(pci_dev->devfn) + pin) % bus->nirq;
> +}
> +
>   static void gpex_host_realize(DeviceState *dev, Error **errp)
>   {
>       PCIHostState *pci = PCI_HOST_BRIDGE(dev);
>       GPEXHost *s = GPEX_HOST(dev);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>       PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
> +    pci_map_irq_fn map_irq_fn = pci_swizzle_map_irq_fn;
>       int i;
>   
> +    s->irq = g_malloc0(s->nr_irqs * sizeof(*s->irq));
> +    s->irq_num = g_malloc0(s->nr_irqs * sizeof(*s->irq_num));

Use g_malloc0_n(). I also prefer to have one array of struct instead of 
allocating two arrays to save the number of allocations.

> +
> +    if (s->nr_irqs != PCI_NUM_PINS) {

I see little utlity with this conditional. There is no behavioral 
difference in these functions when s->nr_irqs == PCI_NUM_PINS. The 
nr_irqs property will not make sense if there is.

> +        map_irq_fn = gpex_swizzle_map_irq_fn;
> +    }
> +
>       pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
>       sysbus_init_mmio(sbd, &pex->mmio);
>   
> @@ -128,19 +144,27 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
>           sysbus_init_mmio(sbd, &s->io_ioport);
>       }
>   
> -    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +    for (i = 0; i < s->nr_irqs; i++) {
>           sysbus_init_irq(sbd, &s->irq[i]);
>           s->irq_num[i] = -1;
>       }
>   
> -    pci->bus = pci_register_root_bus(dev, "pcie.0", gpex_set_irq,
> -                                     pci_swizzle_map_irq_fn, s, &s->io_mmio,
> -                                     &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
> +    pci->bus = pci_register_root_bus(dev, "pcie.0", gpex_set_irq, map_irq_fn,
> +                                     s, &s->io_mmio, &s->io_ioport, 0,
> +                                     s->nr_irqs, TYPE_PCIE_BUS);
>   
>       pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
>       qdev_realize(DEVICE(&s->gpex_root), BUS(pci->bus), &error_fatal);
>   }
>   
> +static void gpex_host_unrealize(DeviceState *dev)
> +{
> +    GPEXHost *s = GPEX_HOST(dev);
> +
> +    g_free(s->irq);
> +    g_free(s->irq_num);
> +}
> +
>   static const char *gpex_host_root_bus_path(PCIHostState *host_bridge,
>                                             PCIBus *rootbus)
>   {
> @@ -166,6 +190,7 @@ static Property gpex_host_properties[] = {
>                          gpex_cfg.mmio64.base, 0),
>       DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MMIO_SIZE, GPEXHost,
>                        gpex_cfg.mmio64.size, 0),
> +    DEFINE_PROP_UINT32("nr-irqs", GPEXHost, nr_irqs, PCI_NUM_PINS),

UINT32 is too big for the number of IRQs. I find code in many places use 
int for IRQ, which will break for a too big value.

Any IRQ value before swizzling fits in UINT8 so let's use it.

>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -176,6 +201,7 @@ static void gpex_host_class_init(ObjectClass *klass, void *data)
>   
>       hc->root_bus_path = gpex_host_root_bus_path;
>       dc->realize = gpex_host_realize;
> +    dc->unrealize = gpex_host_unrealize;
>       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>       dc->fw_name = "pci";
>       device_class_set_props(dc, gpex_host_properties);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cef41c150aa..6c3ed4b3d9c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -167,7 +167,7 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
>   {
>       int pin, dev;
>       uint32_t irq_map_stride = 0;
> -    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> +    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
>                             FDT_MAX_INT_MAP_WIDTH] = {};
>       uint32_t *irq_map = full_irq_map;
>   
> @@ -179,11 +179,11 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
>        * possible slot) seeing the interrupt-map-mask will allow the table
>        * to wrap to any number of devices.
>        */
> -    for (dev = 0; dev < GPEX_NUM_IRQS; dev++) {
> +    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
>           int devfn = dev * 0x8;
>   
> -        for (pin = 0; pin < GPEX_NUM_IRQS; pin++) {
> -            int irq_nr = PCIE_IRQ + ((pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
> +        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
> +            int irq_nr = PCIE_IRQ + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
>               int i = 0;
>   
>               /* Fill PCI address cells */
> @@ -209,7 +209,7 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
>       }
>   
>       qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> -                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> +                     PCI_NUM_PINS * PCI_NUM_PINS *
>                        irq_map_stride * sizeof(uint32_t));
>   
>       qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> @@ -1157,7 +1157,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>   
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
>   
> -    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>           irq = qdev_get_gpio_in(irqchip, PCIE_IRQ + i);
>   
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
> index 5310a888613..8f5c2009d29 100644
> --- a/hw/xtensa/virt.c
> +++ b/hw/xtensa/virt.c
> @@ -93,7 +93,7 @@ static void create_pcie(MachineState *ms, CPUXtensaState *env, int irq_base,
>       /* Connect IRQ lines. */
>       extints = xtensa_get_extints(env);
>   
> -    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>           void *q = extints[irq_base + i];
>   
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, q);
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index dce883573ba..8f87a3872cb 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -32,8 +32,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(GPEXHost, GPEX_HOST)
>   #define TYPE_GPEX_ROOT_DEVICE "gpex-root"
>   OBJECT_DECLARE_SIMPLE_TYPE(GPEXRootState, GPEX_ROOT_DEVICE)
>   
> -#define GPEX_NUM_IRQS 4
> -
>   struct GPEXRootState {
>       /*< private >*/
>       PCIDevice parent_obj;
> @@ -60,8 +58,9 @@ struct GPEXHost {
>       MemoryRegion io_mmio;
>       MemoryRegion io_ioport_window;
>       MemoryRegion io_mmio_window;
> -    qemu_irq irq[GPEX_NUM_IRQS];
> -    int irq_num[GPEX_NUM_IRQS];
> +    uint32_t nr_irqs;
> +    qemu_irq *irq;
> +    int *irq_num;
>   
>       bool allow_unmapped_accesses;
>   



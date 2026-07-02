Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AEEC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfIe5-0000V2-Ij; Thu, 02 Jul 2026 10:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIe1-0000UW-ST
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:44:02 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfIdz-0006w3-0w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:44:01 -0400
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-37dedd62b90so785894a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 07:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783003437; x=1783608237; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RLOtfSGUblu0N3KdaMUJZVLEUlaMk09G5r1IgsC7M1w=;
 b=eZEe68ebBtAUtm030xn1OdfDum/cVAvNSh48SWquZ5FaRryekauWeZ2RWIkb6uB8tw
 5qDaN6BFLVJ3PchwBPkynVHhfFOSYvST0FgFzBQhehykCaOrjLTr350sbBes/JxHXQaz
 m1jNkioBio48tXCDEpcx3P15MHI4T/kMeQkdt9V9B/Km1sFbC/R3OcD2pu3r/5Qadk7b
 /mLLr2udfRWmcLnk7yY6JFfXkMFnff2hMAHNOuaTrUEz8mn/3v1WYHY6ChSSoaW+K9eM
 BI/bjfWPUdMOSvZ0Crqg2y5zp0aGAlK9cYPcCnVzcfYDr68qnr6b2hLq22njlsyFlT84
 +IMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783003437; x=1783608237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RLOtfSGUblu0N3KdaMUJZVLEUlaMk09G5r1IgsC7M1w=;
 b=LraLL7c51krqE2oHkI8HiViA3Ebxkcgth9WrNr6n1Ydo2SoU3ghV7f37dJrVmQQoZX
 JGrZgtuT/tCNZEs/Ul6/FrWJMmdJhWJ5Zuuv5aa4FpGKjPeE7VFm2LHgZ+Z+uypCnfG3
 t8o+XnMNFByNOaGarRPuXDeKuM/BaDF99+DGgzf4EbTNAwXcOmvNpmCRmHeOwDcO0XqN
 X+c7OgOEZcDoKrZAv1sFVK0EyQrfTQaEuGYSq9SdWS6Yo1RUL6XxtpNLE7ROZXjbprAl
 ah/bFYuaae5+JDh55LKvwdD2HgFoahQ+ilWiVFqeg7/5oZopsw5cOOSC63dH7hoNHQiD
 u2Ow==
X-Gm-Message-State: AOJu0YzgqKAca/+W4+SGGhATR5dfxtxqwCeaDBZ0Z1Sc/nCpvkOgOpVd
 XDeqs2M2hT2+eWKlu7PeVeoyO9L3sWfY7h7OxZJMkR1PXtJFIOQZAhJNx7Kvo8gPJ38k/g==
X-Gm-Gg: AfdE7ckaAWSJEAQXK026sKWxpOjFsrmy54cuBXYE42AfUosQs8zKeYwl63yGw2cjZ38
 05Me9ktWZcRKUeLLVF6nwzouLbgPMix11GD0wV7ul7NoCqrHQ3zdmHZMvjotALAc9ZimmgIGh2L
 wCGArDtUxeLHN9rASouRouSpMNOQvY8OJsRKoOeSwJM+Jf1xValY4RBmiW6xl3jESv0687LpS4y
 +YWNGCcEulwa9WfHvNRE5LrsYClEn+rTvzcYhj9E80QzQqTpDhxBzFztdJYUReKtNoBfDAbmuGo
 +ha6Xzt7Z2fCIfXiRKSOJZxNaY8HYoeqowWHrbaDzYliEh73b8kp0TMFp2TN6HwlaAxvmT8xYjY
 cRWDJ+9jUGIH5/8pngJHtGZHqfzj8xOl28j95CVaApqDkyuHAJTGjULqn2opU1IOEoXhCb5oEb6
 ZX3ZDhMsL9aikySgh97thlul7A7hfMM7DAE3DPPgyvlhBoyQixPaZyvJthYV8=
X-Received: by 2002:a17:90b:394e:b0:37f:a913:1554 with SMTP id
 98e67ed59e1d1-3811236e007mr193745a91.16.1783003436504; 
 Thu, 02 Jul 2026 07:43:56 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f1595e912sm7318882eec.31.2026.07.02.07.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:43:56 -0700 (PDT)
Date: Thu, 2 Jul 2026 22:43:53 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 andrew.jones@oss.qualcomm.com, 
 leif.lindholm@oss.qualcomm.com, uwu@icenowy.me,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v8 5/7] hw/riscv/server_platform_ref.c: add platform bus
 and TPM support
Message-ID: <akZ5GxYDiDv2_5yr@ChaodeMacBook-Pro.local>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-6-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610214133.1882563-6-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj1-x1043.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 10, 2026 at 06:41:31PM +0800, Daniel Henrique Barboza wrote:
> The RISC-V Server Platform spec requires a TPM device.  TPM devices in
> QEMU comes usually in two flavors: emulated or passthrough.  A
> passthrough device requires a host TPM device that the QEMU process can
> borrow and it's usually coupled with KVM acceleration.
> 
> To use the TPM emulator we'll need help from an external TPM emulator
> called swtpm.  More info can be found in [1].  For our purposes this is
> a process that, if running Ubuntu, can be installed via 'swtpm' package.
> We'll go back to it shortly.
> 
> For now, adding support for the emulated TPM device 'tpm-tis' (other TPM
> flavors might work as well, 'tpm-tis' is the one tested with this work)
> requires a platform bus.  Adding a platform bus will open the door for
> more devices to be added in the board.  This is ok - a reference board
> isn't a restricted board and users are free to add devices at their
> leisure.
> 
> Here's how to use tpm-tis with the riscv-server-ref board after applying
> this patch:
> 
> - in a separated shell/term run 'swtpm' (--log is optional):
> 
> $ mkdir /tmp/mytpm1
> $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
> 	--ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
> 	--tpm2 \
> 	--log level=20
> 
> Then start QEMU with:
> 
> $ qemu-system-riscv64 -M riscv-server-ref (...) \
> 	-chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
> 	-tpmdev emulator,id=tpm0,chardev=chrtpm\
> 	-device tpm-tis-device,tpmdev=tpm0
> 
> [1] https://qemu-project.gitlab.io/qemu/specs/tpm.html
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  hw/riscv/Kconfig               |  1 +
>  hw/riscv/server_platform_ref.c | 92 +++++++++++++++++++++++++++++++++-
>  2 files changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 1807c423ff..d3912cbb1e 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -73,6 +73,7 @@ config RISCV_SERVER_PLATFORM_REF
>      bool
>      default y
>      depends on RISCV64
> +    imply TPM_TIS_SYSBUS
>      select RISCV_NUMA
>      select GOLDFISH_RTC
>      select PCI
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> index 7e626c6eb7..790d9861f3 100644
> --- a/hw/riscv/server_platform_ref.c
> +++ b/hw/riscv/server_platform_ref.c
> @@ -14,6 +14,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/core/boards.h"
> +#include "hw/core/platform-bus.h"
>  #include "hw/core/loader.h"
>  #include "hw/core/sysbus.h"
>  #include "hw/core/qdev-properties.h"
> @@ -39,6 +40,7 @@
>  #include "system/runstate.h"
>  #include "system/system.h"
>  #include "system/tcg.h"
> +#include "system/tpm.h"
>  #include "system/qtest.h"
>  #include "target/riscv/cpu.h"
>  #include "target/riscv/pmu.h"
> @@ -72,6 +74,8 @@
>  #define SYSCON_RESET     0x1
>  #define SYSCON_POWEROFF  0x2
>  
> +#define RVSERVER_PLATFORM_BUS_NUM_IRQS 8
> +
>  #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
>  OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
>  
> @@ -88,6 +92,8 @@ struct RISCVServerRefMachineState {
>      int fdt_size;
>      int aia_guests;
>      const MemMapEntry *memmap;
> +
> +    DeviceState *platform_bus_dev;
>  };
>  
>  enum {
> @@ -106,6 +112,7 @@ enum {
>      RVSERVER_DRAM,
>      RVSERVER_PCIE_MMIO,
>      RVSERVER_PCIE_PIO,
> +    RVSERVER_PLATFORM_BUS,
>      RVSERVER_PCIE_ECAM,
>      RVSERVER_PCIE_MMIO_HIGH
>  };
> @@ -114,7 +121,8 @@ enum {
>      RVSERVER_UART0_IRQ = 10,
>      RVSERVER_RTC_IRQ = 11,
>      RVSERVER_PCIE_IRQ = 0x20, /* 32 to 35 */
> -    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
> +    IOMMU_SYS_IRQ = 0x24, /* 36 to 39 */
> +    RVSERVER_PLATFORM_BUS_IRQ = 40, /* 40 to 48 */
>  };
>  
>  /*
> @@ -147,6 +155,7 @@ static const MemMapEntry rvserver_ref_memmap[] = {
>      [RVSERVER_IOMMU_SYS] =      {   0x102000,        0x1000 },
>      [RVSERVER_ACLINT] =         {  0x2000000,       0x10000 },
>      [RVSERVER_PCIE_PIO] =       {  0x3000000,       0x10000 },
> +    [RVSERVER_PLATFORM_BUS] =   {  0x4000000,     0x2000000 },
>      [RVSERVER_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
>      [RVSERVER_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
>      [RVSERVER_UART0] =          { 0x10000000,         0x100 },
> @@ -214,6 +223,34 @@ static void rvserver_flash_maps(RISCVServerRefMachineState *s,
>      rvserver_flash_map(s->flash[1], flashbase + flashsize, flashsize, sysmem);
>  }
>  
> +static void create_platform_bus(RISCVServerRefMachineState *s,
> +                                DeviceState *irqchip)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *sysbus;
> +    int i;
> +    MemoryRegion *sysmem = get_system_memory();
> +
> +    dev = qdev_new(TYPE_PLATFORM_BUS_DEVICE);
> +    dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
> +    qdev_prop_set_uint32(dev, "num_irqs", RVSERVER_PLATFORM_BUS_NUM_IRQS);
> +    qdev_prop_set_uint32(dev, "mmio_size",
> +                         s->memmap[RVSERVER_PLATFORM_BUS].size);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    s->platform_bus_dev = dev;
> +
> +    sysbus = SYS_BUS_DEVICE(dev);
> +    for (i = 0; i < RVSERVER_PLATFORM_BUS_NUM_IRQS; i++) {
> +        int irq = RVSERVER_PLATFORM_BUS_IRQ + i;
> +        sysbus_connect_irq(sysbus, i, qdev_get_gpio_in(irqchip, irq));
> +    }
> +
> +    memory_region_add_subregion(sysmem,
> +                                s->memmap[RVSERVER_PLATFORM_BUS].base,
> +                                sysbus_mmio_get_region(sysbus, 0));
> +}
> +
>  static void create_pcie_irq_map(RISCVServerRefMachineState *s,
>                                  void *fdt, char *nodename,
>                                  uint32_t irqchip_phandle)
> @@ -585,6 +622,16 @@ static void create_fdt_socket_aplic(RISCVServerRefMachineState *s,
>                           aplic_s_phandle, 0,
>                           false, num_harts);
>  
> +    if (socket == 0) {
> +        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
> +        MachineState *ms = MACHINE(s);
> +
> +        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
> +                                       s->memmap[RVSERVER_PLATFORM_BUS].base,
> +                                       s->memmap[RVSERVER_PLATFORM_BUS].size,
> +                                       RVSERVER_PLATFORM_BUS_IRQ);
> +    }
> +
>      aplic_phandles[socket] = aplic_s_phandle;
>  }
>  
> @@ -1265,6 +1312,8 @@ static void rvserver_ref_machine_init(MachineState *machine)
>  
>      gpex_pcie_init(system_memory, pcie_irqchip, s);
>  
> +    create_platform_bus(s, mmio_irqchip);
> +
>      serial_mm_init(system_memory, memmap[RVSERVER_UART0].base,
>          0, qdev_get_gpio_in(mmio_irqchip, RVSERVER_UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
> @@ -1341,10 +1390,38 @@ static void rvserver_ref_set_aia_guests(Object *obj, const char *val,
>      }
>  }
>  
> +static HotplugHandler *rvserver_machine_get_hotplug_handler(MachineState *ms,
> +                                                            DeviceState *dev)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
> +    if (device_is_dynamic_sysbus(mc, dev)) {
> +        return HOTPLUG_HANDLER(ms);
> +    }
> +
> +    return NULL;
> +}
> +
> +static void rvserver_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> +                                            DeviceState *dev, Error **errp)
> +{
> +    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(hotplug_dev);
> +
> +    if (s->platform_bus_dev) {
> +        MachineClass *mc = MACHINE_GET_CLASS(s);
> +
> +        if (device_is_dynamic_sysbus(mc, dev)) {
> +            platform_bus_link_device(PLATFORM_BUS_DEVICE(s->platform_bus_dev),
> +                                     SYS_BUS_DEVICE(dev));
> +        }
> +    }
> +}
> +
>  static void rvserver_ref_machine_class_init(ObjectClass *oc, const void *data)
>  {
>      char str[128];
>      MachineClass *mc = MACHINE_CLASS(oc);
> +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>      static const char * const valid_cpu_types[] = {
>          TYPE_RISCV_CPU_RVSERVER_REF,
>      };
> @@ -1370,6 +1447,13 @@ static void rvserver_ref_machine_class_init(ObjectClass *oc, const void *data)
>      sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid value "
>                   "should be between 0 and %d.", RVSERVER_IRQCHIP_MAX_GUESTS);
>      object_class_property_set_description(oc, "aia-guests", str);
> +
> +    assert(!mc->get_hotplug_handler);
> +    mc->get_hotplug_handler = rvserver_machine_get_hotplug_handler;
> +    hc->plug = rvserver_machine_device_plug_cb;
> +#ifdef CONFIG_TPM
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
> +#endif
>  }
>  
>  static const TypeInfo rvserver_ref_typeinfo = {
> @@ -1378,7 +1462,11 @@ static const TypeInfo rvserver_ref_typeinfo = {
>      .class_init = rvserver_ref_machine_class_init,
>      .instance_init = rvserver_ref_machine_instance_init,
>      .instance_size = sizeof(RISCVServerRefMachineState),
> -    .interfaces = riscv64_machine_interfaces,
> +    .interfaces = (const InterfaceInfo[]) {
> +         { TYPE_HOTPLUG_HANDLER },
> +         { TYPE_TARGET_RISCV64_MACHINE },
> +         { }
> +    },
>  };
>  
>  static void rvserver_ref_init_register_types(void)
> -- 
> 2.43.0
> 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10249CD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 01:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZIGa-0004nZ-7M; Mon, 15 Jun 2026 21:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZIGU-0004n9-NN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:06:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZIGI-000317-TX
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 21:06:45 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso8920392a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 18:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781572000; cv=none;
 d=google.com; s=arc-20240605;
 b=SBkTHp/dlHcAeiI5feWf4Zu8JefezdSCukJatuqrKuTLufKRgOosmmf+pSQTlMMw6u
 dEFh3o+iI/jgN/hYYICJyGBzHPB499GVB31v7ce/iPP/24D2A6N2U2zRCqlpj6TpUTNl
 T/fHIR5ddSSoWh2Ayr1KJQaZ8H2jaMlSZDWecxszJz2mv1YNNjawdiKPrkdILCdE1qLe
 /er72pWDn1pH/bA+FHVPOFQzeYMZVanR1yWCueVbSRX4Aoj4gZBPnCP1Gf5MScHA8Gut
 vCBO8yoBdzyLxJNyioTlTwV9IRG7jxa6R1uDWWI7A2tPKdpTT9t+32Mh9bOSeSjasYXm
 TZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qn1JeK+g4d5ZLwUIG3X/l/PegD7yci8nTbPHtI8iseQ=;
 fh=HZFwJyHHyPPBlSNmxMKNPezp6ZugQve0ZOWpI5vp97Y=;
 b=aeGkpR9R4Ebcv0mV3YmQobdyJ9WIoSrJ2tUzHZ6iZ0BS28WmeshMsitCfmOlykypyA
 Yu3J0dgUB/51WwmAYCQICViXVGJ2VFJXX/HelQweQjMjfhqmCtM5KY47yDF1t7jrIHFO
 6hI2wBhOd90WULXN6AFwBbP/oIbHnifXEB44bqwUF+zDnflXrXUs1Jv1fwfLg3I4PIur
 kwoHL5fPlAaIxUf8eu+s+Z7DDh11cOkH9wL/rUQ4jSTK7c7ru5FiSzFLyRvz5pTnOzIj
 fe5RMzA1TaICE7Zagw1y63PDWovSYVGW6MAfxH+u0L+VlohNU3TtU/Kq2mCsbSzOTbZO
 HAAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781572000; x=1782176800; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qn1JeK+g4d5ZLwUIG3X/l/PegD7yci8nTbPHtI8iseQ=;
 b=DK0idRnJW1tqiQqXHErmKvFxECymeBOosOsdQaDhsofqDshN7IbDJZ1jatFe06NJ7+
 p59IYz+D/r/jILHkupj95/VA0v72OjG1ikhcy7WM8ETSl89OQxoQ16/R5UBOb67pohx5
 MPIsofIVsvLTTsk64M4BTC8ZhfJhRh4ZYexEVyK2tAeOiTgMKk7QfCR9NofrUxD/uwWz
 xkrLh3msBlIpGsWOZMnOGfyunsnmzFzzWKZNiRNNeB3coz9zXFnw8FQN3Azdv+8yqBdB
 QHFqzL5cqdD8yEGE3m74rQ6ibHXCCetD1yffzJRNzynvW9Nb7mQawFMiB+XVY76eoeQM
 3ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781572000; x=1782176800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qn1JeK+g4d5ZLwUIG3X/l/PegD7yci8nTbPHtI8iseQ=;
 b=pMToS/k1ThWC350OfFHCoGk9n09b1SamisOg9cb08q2YVQTM9Qxnn8XUWhOnb8zLjS
 KXLNUwsIGDqEZBd87VRLfZHA8hHPKOEk5CcxLszgUJeKdrjRiwwCrf7+sZ3oXtYOiQT6
 egVOWGU87HaKgQpEBaUdWgWySh4RJjZBXLKMt6QPDoZZML9Gx35qa11ucQVvtUmfX/8w
 Hhw36U/gAABOkRkttj6gMuLtrE/59Gbn1sfEexW/dYTkDMxQlL5NErsF5V/HGZO4wWpe
 ZOcoNRbLAW2DUwLv3gvuL/Hf5DZkgOuI1K6FhpSM1+D+pI0XORoLcKJPw0Xh6kjEoEKW
 4Fvw==
X-Gm-Message-State: AOJu0Yzee35Wlmi66S2HF6sdyecU/jpOIiPKTggumftotE3rvhiVcSWJ
 z4FU913Bw2Dc+zJinzInYjNDCywiFrnRY3hN8FmVpcJFC5m4tfAqKd5gOn3ngpF4TcFu0t0ivjo
 uYIOMTvTtfQljbzKNn4BVAByXWTwUpkc=
X-Gm-Gg: Acq92OE43s8bgdfKkCguUOUGOuwrGiexbDMmgec+atOpgr2wMGOqtFwkFAxe/IJsw2N
 p3zefwcmNu1xNHBQ1dQCUdvxOIaAErX69JiOXc+33FA0KZJJrrwpjU2gkH8NgrCNo0FreGRvZ/B
 CaPsNAXPEf2cV6XX2dvRPuKoOl2PSjGdSJEHRU7WdU+tAb2L3OmT6DAegPJSXjNzHIfHZs2w7q9
 YTYPfyi17Ndntf6ih/4LlKu1SZZk3NyzqXGsCEDpE+AR+MTFpEcEhFw+abKGdwb/Go5xEzUti07
 CIAssvW74nZHzLC+/xQSvyqlXDp4S3PX3lBuc8aLfa2y+T3i
X-Received: by 2002:aa7:d999:0:b0:688:e4c6:fd1c with SMTP id
 4fb4d7f45d1cf-695081c7909mr565246a12.8.1781572000206; Mon, 15 Jun 2026
 18:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-6-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260610214133.1882563-6-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 11:06:13 +1000
X-Gm-Features: AVVi8CcbA5RBXx1o5xTMY8w84qsIHBe0Tb24b-JlG4CBRd-whGpq8zi3vd9eiII
Message-ID: <CAKmqyKMe=HSGka718yM-wDtyyDxJdixG1rXzRVX036d-sQFRQw@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] hw/riscv/server_platform_ref.c: add platform bus
 and TPM support
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com, uwu@icenowy.me, 
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jun 11, 2026 at 7:44=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
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
> $ swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
>         --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
>         --tpm2 \
>         --log level=3D20
>
> Then start QEMU with:
>
> $ qemu-system-riscv64 -M riscv-server-ref (...) \
>         -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
>         -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm\
>         -device tpm-tis-device,tpmdev=3Dtpm0
>
> [1] https://qemu-project.gitlab.io/qemu/specs/tpm.html
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_re=
f.c
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
>  #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-re=
f")
>  OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_=
MACHINE)
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
>      RVSERVER_UART0_IRQ =3D 10,
>      RVSERVER_RTC_IRQ =3D 11,
>      RVSERVER_PCIE_IRQ =3D 0x20, /* 32 to 35 */
> -    IOMMU_SYS_IRQ =3D 0x24 /* 36 to 39 */
> +    IOMMU_SYS_IRQ =3D 0x24, /* 36 to 39 */
> +    RVSERVER_PLATFORM_BUS_IRQ =3D 40, /* 40 to 48 */
>  };
>
>  /*
> @@ -147,6 +155,7 @@ static const MemMapEntry rvserver_ref_memmap[] =3D {
>      [RVSERVER_IOMMU_SYS] =3D      {   0x102000,        0x1000 },
>      [RVSERVER_ACLINT] =3D         {  0x2000000,       0x10000 },
>      [RVSERVER_PCIE_PIO] =3D       {  0x3000000,       0x10000 },
> +    [RVSERVER_PLATFORM_BUS] =3D   {  0x4000000,     0x2000000 },
>      [RVSERVER_APLIC_M] =3D        {  0xc000000, APLIC_SIZE(RVSERVER_CPUS=
_MAX) },
>      [RVSERVER_APLIC_S] =3D        {  0xd000000, APLIC_SIZE(RVSERVER_CPUS=
_MAX) },
>      [RVSERVER_UART0] =3D          { 0x10000000,         0x100 },
> @@ -214,6 +223,34 @@ static void rvserver_flash_maps(RISCVServerRefMachin=
eState *s,
>      rvserver_flash_map(s->flash[1], flashbase + flashsize, flashsize, sy=
smem);
>  }
>
> +static void create_platform_bus(RISCVServerRefMachineState *s,
> +                                DeviceState *irqchip)
> +{
> +    DeviceState *dev;
> +    SysBusDevice *sysbus;
> +    int i;
> +    MemoryRegion *sysmem =3D get_system_memory();
> +
> +    dev =3D qdev_new(TYPE_PLATFORM_BUS_DEVICE);
> +    dev->id =3D g_strdup(TYPE_PLATFORM_BUS_DEVICE);
> +    qdev_prop_set_uint32(dev, "num_irqs", RVSERVER_PLATFORM_BUS_NUM_IRQS=
);
> +    qdev_prop_set_uint32(dev, "mmio_size",
> +                         s->memmap[RVSERVER_PLATFORM_BUS].size);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    s->platform_bus_dev =3D dev;
> +
> +    sysbus =3D SYS_BUS_DEVICE(dev);
> +    for (i =3D 0; i < RVSERVER_PLATFORM_BUS_NUM_IRQS; i++) {
> +        int irq =3D RVSERVER_PLATFORM_BUS_IRQ + i;
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
> @@ -585,6 +622,16 @@ static void create_fdt_socket_aplic(RISCVServerRefMa=
chineState *s,
>                           aplic_s_phandle, 0,
>                           false, num_harts);
>
> +    if (socket =3D=3D 0) {
> +        g_autofree char *aplic_name =3D fdt_get_aplic_nodename(aplic_add=
r);
> +        MachineState *ms =3D MACHINE(s);
> +
> +        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
> +                                       s->memmap[RVSERVER_PLATFORM_BUS].=
base,
> +                                       s->memmap[RVSERVER_PLATFORM_BUS].=
size,
> +                                       RVSERVER_PLATFORM_BUS_IRQ);
> +    }
> +
>      aplic_phandles[socket] =3D aplic_s_phandle;
>  }
>
> @@ -1265,6 +1312,8 @@ static void rvserver_ref_machine_init(MachineState =
*machine)
>
>      gpex_pcie_init(system_memory, pcie_irqchip, s);
>
> +    create_platform_bus(s, mmio_irqchip);
> +
>      serial_mm_init(system_memory, memmap[RVSERVER_UART0].base,
>          0, qdev_get_gpio_in(mmio_irqchip, RVSERVER_UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
> @@ -1341,10 +1390,38 @@ static void rvserver_ref_set_aia_guests(Object *o=
bj, const char *val,
>      }
>  }
>
> +static HotplugHandler *rvserver_machine_get_hotplug_handler(MachineState=
 *ms,
> +                                                            DeviceState =
*dev)
> +{
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> +
> +    if (device_is_dynamic_sysbus(mc, dev)) {
> +        return HOTPLUG_HANDLER(ms);
> +    }
> +
> +    return NULL;
> +}
> +
> +static void rvserver_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> +                                            DeviceState *dev, Error **er=
rp)
> +{
> +    RISCVServerRefMachineState *s =3D RISCV_SERVER_REF_MACHINE(hotplug_d=
ev);
> +
> +    if (s->platform_bus_dev) {
> +        MachineClass *mc =3D MACHINE_GET_CLASS(s);
> +
> +        if (device_is_dynamic_sysbus(mc, dev)) {
> +            platform_bus_link_device(PLATFORM_BUS_DEVICE(s->platform_bus=
_dev),
> +                                     SYS_BUS_DEVICE(dev));
> +        }
> +    }
> +}
> +
>  static void rvserver_ref_machine_class_init(ObjectClass *oc, const void =
*data)
>  {
>      char str[128];
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
>      static const char * const valid_cpu_types[] =3D {
>          TYPE_RISCV_CPU_RVSERVER_REF,
>      };
> @@ -1370,6 +1447,13 @@ static void rvserver_ref_machine_class_init(Object=
Class *oc, const void *data)
>      sprintf(str, "Set number of guest MMIO pages for AIA IMSIC. Valid va=
lue "
>                   "should be between 0 and %d.", RVSERVER_IRQCHIP_MAX_GUE=
STS);
>      object_class_property_set_description(oc, "aia-guests", str);
> +
> +    assert(!mc->get_hotplug_handler);
> +    mc->get_hotplug_handler =3D rvserver_machine_get_hotplug_handler;
> +    hc->plug =3D rvserver_machine_device_plug_cb;
> +#ifdef CONFIG_TPM
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
> +#endif
>  }
>
>  static const TypeInfo rvserver_ref_typeinfo =3D {
> @@ -1378,7 +1462,11 @@ static const TypeInfo rvserver_ref_typeinfo =3D {
>      .class_init =3D rvserver_ref_machine_class_init,
>      .instance_init =3D rvserver_ref_machine_instance_init,
>      .instance_size =3D sizeof(RISCVServerRefMachineState),
> -    .interfaces =3D riscv64_machine_interfaces,
> +    .interfaces =3D (const InterfaceInfo[]) {
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
>


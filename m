Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B148CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 01:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4UZB-0004yj-EU; Thu, 02 Oct 2025 21:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4UZ8-0004xy-EB
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:26:34 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4UYm-00072R-BT
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:26:32 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b3d50882cc2so338173666b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 18:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759454763; x=1760059563; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/zC5TIK3S7iq04RpUYXiJfO/OyeaO+wflpBEUkxAgs=;
 b=CbgIwRYj3iz15Gn8+RbuLuTlbMIQppBPAMHvwcoM715U/w2806UDzRvkjYZEWTk7yP
 RTmJaSpk0PjAB/ECYRU/+oxFgNFvwEtbSJpUVhGBKDidk6emD16XVORBesgYBXTce09l
 a3SBSmLPy4KluRz8/3DkS9cWUFBZaiAnh0Ljyjso+KISK777jbcPxAkFubB1/tSxaZ8h
 +a8awf7Y1jMPENgZAqiaQb1ETLf0iBBkNHQHXcidIqt4b47Gd+Tub2BHdsz3HBfURSkP
 muqi7pBc9stBwhreZcVpFNS5zY2loxn/aBC/4R47Sf3rhpzpqaxm1yQgJgzjVQrmGi+I
 aEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759454763; x=1760059563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/zC5TIK3S7iq04RpUYXiJfO/OyeaO+wflpBEUkxAgs=;
 b=owH8/vcf4c5Txa/c9Lg0oPxzDJ5sKpk1cmfgxp1On2suhzkV2BfQSjBM2BX5zGZzgi
 NolpahALJqoMCWqRZr7RjocHcpKx0+MX/CljWQtY1pAuR1uRJQo8SQIQFOoCpLQZDS7C
 5bZYuuJommMXM+TQrFXshY/8KzSe2Vx5+uytTAnXY8lewpOvls8sp0MOSp/Gli9mC7GJ
 SeKy0J4Ff3yCgAJ07HOQb53Il656dn6LOYUDbbd8RMWvVOhacLoFeNsxLIre9vwPRhXS
 ZwfJJKmXCxPzihmhCkSul5SnAAaN+5DF75a1Ei4zPg1b9uEjg2cWDfodCcKVzgeX0Sgb
 hvzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkGX9cqYP8gJhakwnrVyP2Jd6uhIZTZGZQ9vWa6pB9X1IVxUMU6jbvG/mcNJuPiwz2dvoUlUwqoabl@nongnu.org
X-Gm-Message-State: AOJu0YzbGRl9s8725/glB2rdxV7xZMMEBIH8qx4hISQdiq1t5sypQMfo
 RccPHhiETVat5oGHbiDK+4rX2uiB8mNjNa4mIiTUSJJWcLFzJwJlTdLrpwOV7e0qy1MbsSQ8IzE
 5Nmm2XxiunvTMDfuUZk2RbPnLraQkWsc=
X-Gm-Gg: ASbGnctJ+Seb46qyIRnahiOgHbiSCkKsxZ8G0u9jO0vw3dA4FLYDcvzqiGmwvBl1O4D
 89bbWsYdNE+FBcRLsdQlaNOyrlMUz/tmiVOEJ4phyAZbOlTefsraL5ztQ3v38+MDBAVwY8lpHFc
 mU5KjEhBZaZzvSsQ+z7CNGrrNF69u/OoelRo9yOMe7k6AdDM8SqAqMDvgoaMaryWDCBQso6i9J5
 1VDIWeyQlw+A0rvH7Z/PqA48WBD9ThY85whBi90RVAL/rC+ID+LmcZpVpibzQ==
X-Google-Smtp-Source: AGHT+IGiB2GGG1CBiPrVXlgk0M1rTpPEZiMLIvsfl7otIVstC3JsEP65XovX12VaIywNM12SL/IV67ASJXozT6IZnnk=
X-Received: by 2002:a17:907:7283:b0:b40:cfe9:ed41 with SMTP id
 a640c23a62f3a-b49c47abc02mr153579666b.34.1759454763146; Thu, 02 Oct 2025
 18:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn>
In-Reply-To: <20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 11:25:36 +1000
X-Gm-Features: AS18NWBNnXym9J1QvJP6KzhJbtz91lnlWihZQT-iPn-Rd_rNGHF84skm57ErZ9o
Message-ID: <CAKmqyKOx52d-XBMus8XDZw3HBUba2bzsrABOj84u3TfJVw-pQw@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] hw/riscv/virt: Add acpi ged and powerdown
 support
To: liu.xuemei1@zte.com.cn
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 sunilvl@ventanamicro.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 23, 2025 at 1:39=E2=80=AFPM <liu.xuemei1@zte.com.cn> wrote:
>
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> This adds powerdown support by implementing the ACPI GED.
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Co-authored-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
> Changes in v3:
> - Added missing param to virt_is_acpi_enabled
> - Fixed failure of bios-tables-test
>
>  hw/riscv/Kconfig                  |   1 +
>  hw/riscv/virt-acpi-build.c        |  10 +++++++++
>  hw/riscv/virt.c                   |  35 ++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h           |   4 ++++
>  tests/data/acpi/riscv64/virt/DSDT | Bin 3538 -> 3681 bytes
>  5 files changed, 50 insertions(+)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fc9c35bd98..f89a6e3672 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV_VIRT
>      select PLATFORM_BUS
>      select ACPI
>      select ACPI_PCI
> +    select ACPI_HW_REDUCED
>
>  config SHAKTI_C
>      bool
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index ee1416d264..93f22f9c1a 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -27,6 +27,7 @@
>  #include "hw/acpi/acpi-defs.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "hw/acpi/pci.h"
>  #include "hw/acpi/utils.h"
>  #include "hw/intc/riscv_aclint.h"
> @@ -498,6 +499,15 @@ static void build_dsdt(GArray *table_data,
>          acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURC=
ES * 2);
>      }
>
> +    if (s->acpi_ged) {
> +        build_ged_aml(scope, "\\_SB."GED_DEVICE,
> +                      HOTPLUG_HANDLER(s->acpi_ged),
> +                      ACPI_GED_IRQ, AML_SYSTEM_MEMORY,
> +                      s->memmap[VIRT_ACPI_GED].base);
> +    }
> +
> +    acpi_dsdt_add_power_button(scope);
> +
>      aml_append(dsdt, scope);
>
>      /* copy AML table into ACPI tables blob and patch header there */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 47e573f85a..5bb1504498 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -51,10 +51,12 @@
>  #include "system/kvm.h"
>  #include "system/tpm.h"
>  #include "system/qtest.h"
> +#include "system/runstate.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/uefi/var-service-api.h"
> @@ -95,6 +97,7 @@ static const MemMapEntry virt_memmap[] =3D {
>      [VIRT_UART0] =3D        { 0x10000000,         0x100 },
>      [VIRT_VIRTIO] =3D       { 0x10001000,        0x1000 },
>      [VIRT_FW_CFG] =3D       { 0x10100000,          0x18 },
> +    [VIRT_ACPI_GED] =3D     { 0x10101000, ACPI_GED_EVT_SEL_LEN },
>      [VIRT_FLASH] =3D        { 0x20000000,     0x4000000 },
>      [VIRT_IMSIC_M] =3D      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>      [VIRT_IMSIC_S] =3D      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -1270,6 +1273,22 @@ static inline DeviceState *gpex_pcie_init(MemoryRe=
gion *sys_mem,
>      return dev;
>  }
>
> +static DeviceState *create_acpi_ged(RISCVVirtState *s, DeviceState *irqc=
hip)
> +{
> +    DeviceState *dev;
> +    uint32_t event =3D ACPI_GED_PWR_DOWN_EVT;
> +
> +    dev =3D qdev_new(TYPE_ACPI_GED);
> +    qdev_prop_set_uint32(dev, "ged-event", event);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, s->memmap[VIRT_ACPI_GED].bas=
e);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                       qdev_get_gpio_in(irqchip, ACPI_GED_IRQ));
> +
> +    return dev;
> +}
> +
>  static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>  {
>      FWCfgState *fw_cfg;
> @@ -1428,6 +1447,14 @@ static void virt_build_smbios(RISCVVirtState *s)
>      }
>  }
>
> +static void virt_powerdown_req(Notifier *notifier, void *opaque)
> +{
> +    RISCVVirtState *s;
> +
> +    s =3D container_of(notifier, RISCVVirtState, powerdown_notifier);
> +    acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
> +}
> +
>  static void virt_machine_done(Notifier *notifier, void *data)
>  {
>      RISCVVirtState *s =3D container_of(notifier, RISCVVirtState,
> @@ -1701,6 +1728,11 @@ static void virt_machine_init(MachineState *machin=
e)
>
>      create_platform_bus(s, mmio_irqchip);
>
> +    /* acpi ged */
> +    if (virt_is_acpi_enabled(s)) {
> +        s->acpi_ged =3D create_acpi_ged(s, mmio_irqchip);
> +    }
> +
>      serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
>          0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
> @@ -1742,6 +1774,9 @@ static void virt_machine_init(MachineState *machine=
)
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal=
);
>      }
>
> +    s->powerdown_notifier.notify =3D virt_powerdown_req;
> +    qemu_register_powerdown_notifier(&s->powerdown_notifier);
> +
>      s->machine_done.notify =3D virt_machine_done;
>      qemu_add_machine_init_done_notifier(&s->machine_done);
>  }
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 7b4c2c8b7d..9422b45d0c 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -47,6 +47,8 @@ struct RISCVVirtState {
>
>      /*< public >*/
>      Notifier machine_done;
> +    Notifier powerdown_notifier;
> +    DeviceState *acpi_ged;
>      DeviceState *platform_bus_dev;
>      RISCVHartArrayState soc[VIRT_SOCKETS_MAX];
>      DeviceState *irqchip[VIRT_SOCKETS_MAX];
> @@ -88,9 +90,11 @@ enum {
>      VIRT_PLATFORM_BUS,
>      VIRT_PCIE_ECAM,
>      VIRT_IOMMU_SYS,
> +    VIRT_ACPI_GED,
>  };
>
>  enum {
> +    ACPI_GED_IRQ =3D 9,
>      UART0_IRQ =3D 10,
>      RTC_IRQ =3D 11,
>      VIRTIO_IRQ =3D 1, /* 1 to 8 */
> diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/=
virt/DSDT
> index 527f239dab13a00ad42e5a70b8dc2b89f12aa84a..caeb46842ad39f7b5f8a8e1d9=
9befd58a268340a 100644
> GIT binary patch
> delta 170
> zcmca4{ZNL>CD<h-k&l6a>Gwn~X(pe?8`W3y)<-uvvB&7e2Rp^PySl`4#Cv$U@H#pN
> zcp4ZO8Z&UjhXT1k2_VZkC|Hn>i@TGJftit$fq|itA-cge$km;Jhe1F<fQu!%ksHKy
> zb`5s*Q4o=3DhcMS{SEC6v576?qPPT*o<;9_bE2oG}NYKU%<1TjFC3ApeE_yrg^8#qHO
> GV*mhKP$?$>
>
> delta 25
> hcmaDTb4i-ZCD<k85-$S-lgdOcX(r!W8`W3y0sv*E2bcf=3D

This fails checkpatch:

ERROR: Do not add expected files together with tests, follow
instructions in tests/qtest/bios-tables-test.c. Files

 tests/data/acpi/riscv64/virt/DSDT

and

 include/hw/riscv/virt.h
 hw/riscv/virt-acpi-build.c
 hw/riscv/virt.c
 hw/riscv/Kconfig

found in the same patch

total: 1 errors, 0 warnings, 123 lines checked

Alistair

>
> --
> 2.27.0
>


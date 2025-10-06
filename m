Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8EECAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 11:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5jme-0006zI-4J; Mon, 06 Oct 2025 07:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v5jmb-0006yu-Vf
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 07:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v5jmR-0002cB-R2
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 07:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759751600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxoMU4sd3D6OC/zsvebL1USJT7cTXQk7tFCbOd63z/s=;
 b=ZamJh+qyOywWRCc4X/VQuqu+FPWsYr1Cj7AytvZ4T+Zc0rdyLQF+thSxfd/O9SRDZQyPLp
 XPRJLT3FWU3AvCSwknMAbRQPxQTdjliu6pMn02w7OsM4mlxg6eK3itwptykCHr+JqN2edm
 rzpF6y/qzsPBdCfDQmmk/1EmavnN+zg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-j_jC7CgrM52Miejq156Dqw-1; Mon, 06 Oct 2025 07:53:19 -0400
X-MC-Unique: j_jC7CgrM52Miejq156Dqw-1
X-Mimecast-MFC-AGG-ID: j_jC7CgrM52Miejq156Dqw_1759751598
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3af78819so22337075e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 04:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759751598; x=1760356398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxoMU4sd3D6OC/zsvebL1USJT7cTXQk7tFCbOd63z/s=;
 b=chgItGOd0okd//jcoNlSBSI746Zz7GrEK4UVSHcUozVJifJMUk5bHegdYQnwykicLR
 FMHSaBuqTxt/Xh31nBGixwdlW6Aw0pR5mmaSCFqGWGEzgV9Wtt10Gi+Aia7OPpdT9qJJ
 I8lxGlZoQVKYQBSe46fJe3udV2noZIddlEoY/r5Bunsj8LuGoNDldrhRtbaUL8fIevIX
 IN5XydDs8SMHaj29E6wKHq3XW/VpHIQlQEN0JWquo+s9CnMU04OYxAYo7vFH9RHaJN0X
 H9K0ZJA3OWIBYduA3qKR69JqMT5i4gdZ2PzXvdVSm+HmZohcnzfTkCZ0VLYSRldBjazS
 sr3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc2WE8EYr/dlfuyBR4K5qdiHXQvalzsg5AIhPI5PTB7jD/Oga/JWn+TfawEsRZgigoOCgIRJ0FKOpX@nongnu.org
X-Gm-Message-State: AOJu0YwnRcjylIrD/OPugWt7h1HkTqlDYOLJ0TlNIbuZzJIHxQuHW4BC
 Tu7J3F9sJGfHciaEIGjxDX/XT9wvpoIDevz4stpquQScu0CbZ7PAqgVIMU6MwH/KWn0Rabmr7FY
 UdTcn6T6Iyotw8tNxdyIpaNV1inIjy1OgRF4xAWEU/sBg5hOJ76oSRyoo
X-Gm-Gg: ASbGnctuwbwBgh6khDkNG2n9OzCAfMXLuWQYGA+3q7CSlYaBGnuA1lHVP9kPT1seLTy
 rr5sM7f/5GvXZjtgqx9WCwEknlOtzB/lJs5SsqpD64KPGASdRxCmcOfjx0nKSCnVAiog6Uz2dUm
 buD0/fAZes4GqZgnujYpHfgKW5FtwKCXPTkbBbdBFP4WIAOUdt4fQ+aU6sKY2ytvF8TGcxZx5uc
 tADR3TKwWik0U6S3ySXac1PuvC3QqCFxIAphw8XpDCz9Qy8NpBp8DIitaVTcQXPU1vugA2naxvY
 A7oayHAKhZMuabWC+O+1A+c6v7eos9yVXpEP
X-Received: by 2002:a05:600c:4f93:b0:46e:5cb5:20df with SMTP id
 5b1f17b1804b1-46e7110f0famr111380455e9.16.1759751598437; 
 Mon, 06 Oct 2025 04:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH/NFmRfZolzulEQzqxxLEjz9NdvRVaFXMv2vIjxLQperjiCty5Om1wpwZjyHjooMXUr62Vw==
X-Received: by 2002:a05:600c:4f93:b0:46e:5cb5:20df with SMTP id
 5b1f17b1804b1-46e7110f0famr111380055e9.16.1759751598044; 
 Mon, 06 Oct 2025 04:53:18 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b8507sm253506785e9.3.2025.10.06.04.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 04:53:17 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:53:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: <liu.xuemei1@zte.com.cn>
Cc: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <sunilvl@ventanamicro.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v3 RESEND] hw/riscv/virt: Add acpi ged and powerdown
 support
Message-ID: <20251006135314.74aa696c@fedora>
In-Reply-To: <20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn>
References: <20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 23 Jul 2025 11:37:39 +0800 (CST)
<liu.xuemei1@zte.com.cn> wrote:

> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>=20
> This adds powerdown support by implementing the ACPI GED.
>=20
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Co-authored-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

not counting test case update
  Acked-by: Igor Mammedov <imammedo@redhat.com>

However split out test parts of this patch up
(read comment at the beginning of tests/qtest/bios-tables-test.c,
no how to do that)

> ---
> Changes in v3:
> - Added missing param to virt_is_acpi_enabled
> - Fixed failure of bios-tables-test
>=20
>  hw/riscv/Kconfig                  |   1 +
>  hw/riscv/virt-acpi-build.c        |  10 +++++++++
>  hw/riscv/virt.c                   |  35 ++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h           |   4 ++++
>  tests/data/acpi/riscv64/virt/DSDT | Bin 3538 -> 3681 bytes
>  5 files changed, 50 insertions(+)
>=20
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fc9c35bd98..f89a6e3672 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV_VIRT
>      select PLATFORM_BUS
>      select ACPI
>      select ACPI_PCI
> +    select ACPI_HW_REDUCED
>=20
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
>=20
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
>=20
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
>=20
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
>=20
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
>=20
>      create_platform_bus(s, mmio_irqchip);
>=20
> +    /* acpi ged */
> +    if (virt_is_acpi_enabled(s)) {
> +        s->acpi_ged =3D create_acpi_ged(s, mmio_irqchip);
> +    }
> +
>      serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
>          0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
> @@ -1742,6 +1774,9 @@ static void virt_machine_init(MachineState *machine)
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal=
);
>      }
>=20
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
>=20
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
>=20
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
> zcp4ZO8Z&UjhXT1k2_VZkC|Hn>i@TGJftit$fq|itA-cge$km;Jhe1F<fQu!%ksHKy =20
> zb`5s*Q4o=3DhcMS{SEC6v576?qPPT*o<;9_bE2oG}NYKU%<1TjFC3ApeE_yrg^8#qHO
> GV*mhKP$?$> =20
>=20
> delta 25
> hcmaDTb4i-ZCD<k85-$S-lgdOcX(r!W8`W3y0sv*E2bcf=3D
>=20



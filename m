Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00EDEE20AA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMjl-0002Cj-Vh; Fri, 06 Feb 2026 09:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voMjk-0002Ba-3X
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voMji-0002JY-41
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770387785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GUZOc9sUELE2R2A87iudQr2VueiG04ykfs8t8XQTyg=;
 b=JMCpnCRqdCnBdZy1SKjCoXC/5WKgCH+BzAZxYbJjQe0AMuFHyMHLAlEA5ih50YeZj1Jjzc
 iT3dvIc/Z6UfOCFH6PWfu9YGbysNwAufcBjUgGHUJDRHjCAFby9xgDQ3tJ842RC5UN+bHO
 6nxcgl2WHKQqoNQjOkJnOvuMEuezuRs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-PP-HfFinMNG3VBhK5rVgSA-1; Fri, 06 Feb 2026 09:23:03 -0500
X-MC-Unique: PP-HfFinMNG3VBhK5rVgSA-1
X-Mimecast-MFC-AGG-ID: PP-HfFinMNG3VBhK5rVgSA_1770387782
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435ab9ed85dso495807f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 06:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770387782; x=1770992582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GUZOc9sUELE2R2A87iudQr2VueiG04ykfs8t8XQTyg=;
 b=pVy/QIJwwx3BWE4i/fam6+ZHegazB1llbXui5btXUIk0khmO8owF+BT8qi9Zj9K4/r
 jlzdhcqrItol6Rqie2RoRpy/QcwzkIOPMMvMVCVY1V+CzpBn9DzLD5l16SiBA+N/TtGH
 Fk0Ak82sSjqAc3XWvJwwM+ELQCriQNBA3JlAymwidwEZyWRaFEYXCq4a+3B9dClrLIBG
 uBCqt9EfDb+XJ73OGg7DzTDjYoQdcyq49t/cNl8PkXRlHedgs97ME2FC+SjOKzzy3imd
 cwc7mi3Dhouk20S+UK0aqjsQk1bhkxlZ97uZbLw3lW6npeUfrwR4rhB+PJRr9iXbA5lN
 NNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770387782; x=1770992582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+GUZOc9sUELE2R2A87iudQr2VueiG04ykfs8t8XQTyg=;
 b=mUoLd1YXosgCTsro9IRUlX85J1vionhWe68G3Qb4wQ2yci7P1gYfZ7wLUZKwRBYG5I
 ONHbGO+Im/n/bEqXqvClQOuf6NejTo/m/hJ5238sS5qOR9gXpMiKDeQp0Ia/Nu1GFHtY
 0/EYFRYceyMT9k9c6mFNuGfPWkabHIuoS51syiAK6js908asbQYtzHjNmmfyNE/Rujlw
 YRH/qDlnunDQXF6VCyVn61QG/jaTUgKv1n2wJnqEgEFbdIc3FHtYprlMxANqJ5izWY+C
 mLE9HlJsHczpIIvzWXyYq1COfWyXR5A6FRz3s0QHd4YGAQwyUVHyb34OUdURNPmXpo0F
 +ESQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYEyqqUn1ILr0QfgVF94Fn3KbE9EIapqdztsIPHVMjdw9s7RmUc6VlB/6Nut4Mm+WGXipzx8T00v5D@nongnu.org
X-Gm-Message-State: AOJu0YxvxulW5pIDLtmxw5q+9QzL10Y4iS1nzDAxeJMYGzo5ClxsCryc
 gSo1lgLciLyHA29+skZErMvxlOh2dvQIMViDqpW8N5aXWFXBGJNJE3xeDao6jIZAa1xmvU5RIRJ
 KYBmSDbVdJrSWB+N+Y9cULUS6qDQZmm2CWrS+MzHJXJ+4/HveU47y7d5S
X-Gm-Gg: AZuq6aIHoK++pGZ7ycMPpU9Hvm9jRj6MkifilxLzP3v2WUt2o4JLaARloTs01yTUCrV
 UgmOmCLh83T9ECbH/ogjHFcCJhkz01Cio9RM726h+8FZEZDU9WfVrZFStpnWUo9HAuxm5yXVxdc
 j5VdFO63nG3CTmjz4sG6Pdtl0i+lDrttfZEoo3CtlQvHSEhQ8Y4g34gCCIKH0AgmnC31f/rtMIr
 qezrtr0HqI+RdvFjHF8poIymeR4OHRBcfUffHnW/VcZx1lgZe7iNY910FleLerDdGBRRumqk6vH
 B8ObbWqBvpsIPOc4/GdPP9O/uIHCwQZuX5b/8eX1UB/M3DIY4VYb2NALmQaNoPI9NGK+vw==
X-Received: by 2002:a05:6000:40e1:b0:435:a8e7:62de with SMTP id
 ffacd0b85a97d-4362938f7e2mr4462532f8f.58.1770387782326; 
 Fri, 06 Feb 2026 06:23:02 -0800 (PST)
X-Received: by 2002:a05:6000:40e1:b0:435:a8e7:62de with SMTP id
 ffacd0b85a97d-4362938f7e2mr4462487f8f.58.1770387781849; 
 Fri, 06 Feb 2026 06:23:01 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629745f7asm5630011f8f.33.2026.02.06.06.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 06:23:01 -0800 (PST)
Date: Fri, 6 Feb 2026 15:22:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: <liu.xuemei1@zte.com.cn>
Cc: <alistair.francis@wdc.com>, <dbarboza@ventanamicro.com>,
 <sunilvl@ventanamicro.com>, <anisinha@redhat.com>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v5 2/4] hw/riscv/virt: Add acpi ged support
Message-ID: <20260206152258.4ed0b84e@imammedo>
In-Reply-To: <20260204182349717JK25oWZ6r2DzYQ6XTSj1D@zte.com.cn>
References: <20260204182041057hohVHgmaAJborE1DrghXH@zte.com.cn>
 <20260204182349717JK25oWZ6r2DzYQ6XTSj1D@zte.com.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 4 Feb 2026 18:23:49 +0800 (CST)
<liu.xuemei1@zte.com.cn> wrote:

> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>=20
> This patch adds ACPI Generic Event Device (GED) support to
> the RISC-V virt machine.
>=20
> Co-authored-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
>  hw/riscv/Kconfig           |  1 +
>  hw/riscv/virt-acpi-build.c |  8 ++++++++
>  hw/riscv/virt.c            | 23 +++++++++++++++++++++++
>  include/hw/riscv/virt.h    |  3 +++
>  4 files changed, 35 insertions(+)
>=20
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 0222c93f87..3dad43669f 100644
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
> index f1406cb683..07d1024316 100644
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
> @@ -498,6 +499,13 @@ static void build_dsdt(GArray *table_data,
>          acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURC=
ES * 2);
>      }
>=20
> +    if (s->acpi_ged) {
is this check necessary?
You probably won't get here at all if acpi is not enabled
and in hunk below you always create GED if acpi is enabled

other than that LGTM

> +        build_ged_aml(scope, "\\_SB."GED_DEVICE,
> +                      HOTPLUG_HANDLER(s->acpi_ged),
> +                      ACPI_GED_IRQ, AML_SYSTEM_MEMORY,
> +                      s->memmap[VIRT_ACPI_GED].base);
> +    }
> +
>      aml_append(dsdt, scope);
>=20
>      /* copy AML table into ACPI tables blob and patch header there */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index bd8608ea5b..1d7011b952 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -55,6 +55,7 @@
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/uefi/var-service-api.h"
> @@ -95,6 +96,7 @@ static const MemMapEntry virt_memmap[] =3D {
>      [VIRT_UART0] =3D        { 0x10000000,         0x100 },
>      [VIRT_VIRTIO] =3D       { 0x10001000,        0x1000 },
>      [VIRT_FW_CFG] =3D       { 0x10100000,          0x18 },
> +    [VIRT_ACPI_GED] =3D     { 0x10101000, ACPI_GED_EVT_SEL_LEN },
>      [VIRT_FLASH] =3D        { 0x20000000,     0x4000000 },
>      [VIRT_IMSIC_M] =3D      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
>      [VIRT_IMSIC_S] =3D      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
> @@ -1270,6 +1272,22 @@ static inline DeviceState *gpex_pcie_init(MemoryRe=
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
> @@ -1702,6 +1720,11 @@ static void virt_machine_init(MachineState *machin=
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
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 18a2a323a3..9ea0b3b7b6 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -47,6 +47,7 @@ struct RISCVVirtState {
>=20
>      /*< public >*/
>      Notifier machine_done;
> +    DeviceState *acpi_ged;
>      DeviceState *platform_bus_dev;
>      RISCVHartArrayState soc[VIRT_SOCKETS_MAX];
>      DeviceState *irqchip[VIRT_SOCKETS_MAX];
> @@ -88,9 +89,11 @@ enum {
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



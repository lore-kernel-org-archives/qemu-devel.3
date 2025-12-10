Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43583D3C54A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKeq-0002sj-QP; Wed, 10 Dec 2025 08:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTKem-0002qK-Di
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:55:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vTKej-0004OH-Up
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765374900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4R0iKQGpwib0pmuNwV8atoRBNmK9CM6toW/bqsmaMLw=;
 b=NTFppzCbJxjoF2X7oz1L/Kf3CqxtRy40NHP7iXvWrCDzrfpLKhviEgH42C6uSO/F1k27w6
 XH1BU6iGZXXbtRAWhmYix65yEh/5Oy/zqChPZ13BW6pwyMbdrLsAdORJE/A8bcMKw7CFYL
 cklKngV7lUqbvlTtdybBYTJmPCG7QsU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682--wKFnpCrNdeT7lNIHqxk3A-1; Wed, 10 Dec 2025 08:54:59 -0500
X-MC-Unique: -wKFnpCrNdeT7lNIHqxk3A-1
X-Mimecast-MFC-AGG-ID: -wKFnpCrNdeT7lNIHqxk3A_1765374898
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b5556d80bso5030037f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765374898; x=1765979698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4R0iKQGpwib0pmuNwV8atoRBNmK9CM6toW/bqsmaMLw=;
 b=qHTP2nZaLmOa1c9SYCnXFK9fGQ06HTiWd8wk+QEH/UdIR5usN9hNq698pRA99kP1Hc
 OaffKkI+KpVxO0aJgDpBkC6yhDGZEGmq620r+dqY9SJnRSKpnjuDavzkBtmplR97rGx0
 WyqCZOBCmgQTLGrIofHzThTLCJS5pHt4CiU0l8cJpKMvzK2KWZLPOUFbKHI+uoHN9yVn
 Ma41/lSF0A9u/w9PAs4moNMAyFuE0w65AIH/RndBIEoHX4szha5q7TU9iv9RAaauOD5Q
 pV7csAfxlN09eU4AfJPVSurZ2YhNKf/RDKktYD82Hdlu2zNHw0cjCDd54hIQ+VOrdlI/
 lcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765374898; x=1765979698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4R0iKQGpwib0pmuNwV8atoRBNmK9CM6toW/bqsmaMLw=;
 b=Y4XfAZWk0ryJHCHS+79QSYq4/e5FZUuS7qtx0v8VksGI/W+1fUWL9WVjWRHXIIOqIi
 7QmnYbVRdlSmwrXCd/Q+kRtDxSgyiU+Tx3H4ai8WzAF3LWSm8CqS0CJ1ySLUw9WSmlrq
 O+JN3Qntz/yUCA10n+H6zpgyG8+ZBEFFj2a23KNZMAX7KkC6xWeDvDv2e/AoYjb4ZpGc
 ZlvyZRXjKp8NQLaeEs+P//C+6xDSWnVhdmzlX/XuBvaVEqh1Ah4RPdy4wHh8b7wH9Am7
 O5LkwiojvBFOXtD78/vlAmozhDQezbpGAR/CrSKOGFvW0ic+LNK5TX6b/6S7+9h7utSz
 eQZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn0p+si+75d+EDe3tW1zHcrZSCwOZg8bCVOHkk6KMc4R3fwAgpTXI1SZ/LCdgfLUiRG0NGV4bBKFI7@nongnu.org
X-Gm-Message-State: AOJu0YzvjemCb73nGaS0s2iCRG04luT8pOxkijLCx+Y8YrtS3P+3WZN6
 rWLqOI8Mvprrl/3kiZEbTi/FK/ELnbLpOycKRdpdlMooonVGYLyaLiddCkQnpfpj7ZOUPX6gARE
 9EdFyQrWjIP3vAQW3xAPTMy0YOijcTUhKkZ4Dec687MRflJHxq7hXt42t
X-Gm-Gg: AY/fxX5xBBbB/+wzH1iJF1kQ+vlO3fIKCgPr0d3i1Y1JP150pY6OJZ9SdkJ9PvIDRN7
 cR1wEHkJNmhwhKJ9EaYfhpgynigtj1yPuI4d8F6kLKi03+5VoBHqVSI6dDq0Ql1ndR4iGqp8YlC
 z+agAWo9FqKwxnNneudpARyYQ+IwZ30t0VrkoLnxOsTi6rOmh8o/mgdTwR0gp9AWphtv6Uk7PqS
 bGpXrD5sCKO+m5xcCxwd90DHL4I9Lm3SjlXKc3P3Cj2u+trRvFruq+i+rnrivIsautkPSqXozhZ
 mSbiRg5FrV9DRtR/2NS4bF7jnrm9pYJqEv7fsFlu+yHwmw38yWFOWsaxhJDvHl09Mhpjbg==
X-Received: by 2002:a05:6000:40dd:b0:42f:9faa:50bf with SMTP id
 ffacd0b85a97d-42fa39d3d16mr3142496f8f.23.1765374897682; 
 Wed, 10 Dec 2025 05:54:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrjYKEEu66msw5XX28Z2vKoxmPrsaZ1MIJyNXhc0Sv5PCTy8++7oBns9sbl3qCLX9zyQ4uWA==
X-Received: by 2002:a05:6000:40dd:b0:42f:9faa:50bf with SMTP id
 ffacd0b85a97d-42fa39d3d16mr3142447f8f.23.1765374897187; 
 Wed, 10 Dec 2025 05:54:57 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm36549463f8f.3.2025.12.10.05.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:54:56 -0800 (PST)
Date: Wed, 10 Dec 2025 14:54:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: <liu.xuemei1@zte.com.cn>
Cc: <alistair.francis@wdc.com>, <dbarboza@ventanamicro.com>,
 <sunilvl@ventanamicro.com>, <anisinha@redhat.com>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v4 RESEND 1/2] hw/riscv/virt: Add acpi ged and powerdown
 support
Message-ID: <20251210145455.7c0093cc@imammedo>
In-Reply-To: <20251113093022673gxIvC2wmdHDBY2Sq0_AUm@zte.com.cn>
References: <2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn>
 <20251113093022673gxIvC2wmdHDBY2Sq0_AUm@zte.com.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 13 Nov 2025 09:30:22 +0800 (CST)
<liu.xuemei1@zte.com.cn> wrote:

> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>=20
> This adds powerdown support by implementing the ACPI GED.
>=20
> Co-authored-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
>  hw/riscv/Kconfig                            |  1 +
>  hw/riscv/virt-acpi-build.c                  | 10 ++++++
>  hw/riscv/virt.c                             | 35 +++++++++++++++++++++
>  include/hw/riscv/virt.h                     |  4 +++
>  tests/qtest/bios-tables-test-allowed-diff.h |  1 +
>  5 files changed, 51 insertions(+)
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
> index f1406cb683..64fd8aa426 100644
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

I suggest splitting patch on adding GED 1st and only then adding power butt=
on on top of it

> +
>      aml_append(dsdt, scope);
>=20
>      /* copy AML table into ACPI tables blob and patch header there */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 17909206c7..a853184105 100644
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

Can acpi_ged be NULL at this point? /in the next hunk I see it being a cond=
itional/=20

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


> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..8e85fcdee9 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/DSDT",

I'd split it out in a separate whitelist patch like we usually do elsewhere.



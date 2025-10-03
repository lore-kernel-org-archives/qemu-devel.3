Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FB7CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 01:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4URj-0002JE-Ie; Thu, 02 Oct 2025 21:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4URg-0002Iu-VD
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:18:52 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4URX-00057L-2i
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 21:18:52 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-62fca01f0d9so3367403a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 18:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759454309; x=1760059109; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgoOsYcjLPO1y5KGHbBQjfl76W/8XXJKWx0UoOFzido=;
 b=H462shA/Ut3FCPG1dR+mJXZEcv/SwPTNrHlkYd20AjaL6qnbpImVQZzBlhqSi23+H2
 TSbUQdRsprTKfySxmk8wFN8IRznbgn8oz5dUZuZTqcpdb21ulcJ+uYpGo+ff/HSVThhm
 WeiwKOm+P5XiGZsiLeTqCsKrfGWpBRxTKK4eUXbR27CWmGT368/Z7xLHm5xKVD5Jfh/j
 VOL+BHxCzCmtTg0hJRA2Hv7detv+km/QPvAyxKj5IjuP+Cpjv28Aq+I1WsvV+Dpbo3FP
 5bpNR+gEcwZ7jNSh94TxTwL1q5LcsqDmpwwdcMxuUgW/8BgfBxKrJbPgR3wgEFIBn82z
 4ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759454309; x=1760059109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgoOsYcjLPO1y5KGHbBQjfl76W/8XXJKWx0UoOFzido=;
 b=bvBVr6QT42vpL+VXCLwU3sQUe5qNr82mXd9WRRF3LQ55wlxVMJU3WeK72BzeF9CBwa
 lFjwXWch5Xad7O/zQTlpzb+5xzagINFn1oRuM4eyevS/QaYAs719YEKAohkt+oHpHZFv
 vAvSXqULhWdpair5C2FjTwLb4vi5qb2KnYeU61oKgllOOBGFyXotkqfk9YYnwQvMTOO+
 oDMGPDrt2iyqMf/ofP30Qixgg87KUcRxOhkxCDTSVvSS1Fv7PNu1yfNPC7MWE2IK25oa
 lRzTlcpzPzUml3KHhClkI+DuEGLhl2oB9DSqwcO9vVnb+ijTk7Wpo0j0Tg2Fny2a0w2B
 WncA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMsJRJ9FqSCqE9qEIaRadj0cIfwZPjroNjI0GwwTik4zQrkDWit4zPywbq6eGClaHGsp11t9Xj4YuK@nongnu.org
X-Gm-Message-State: AOJu0YwtlyuP2dFPUkHCOp7x63RlR51/tTPK/Inwd05+EBS+p7kNBRZk
 ZWdz+go+P43EYri1DNpVuOCJuhcPH3oKxVYGNwd1RU/5TA7HjKl2rbrmFIiIj4xy4gGhaidkQEA
 SEAX18DG6zOyNUPN+0cbsingMb7wKFFM=
X-Gm-Gg: ASbGncuPeeNOiRcKlMcNxqFIcjZPkcEUqFllX0qJyQj0J6katdIiCAQZC676K7dEIAp
 2uvYzVEdqppHeaRfZnTlfnh4wW+aS8eaikHqJgaRia4yw0EN6KzUEwStUobmgI4YmU7OQHDfvG0
 DvaHHyScPBzeHAY6qi/gvQcnGQrcz/lNQPDqWC7Ao5tp8ZLLTS1z6DEPuzejanpugaMRiSEVAHb
 dYod16J1yWNnA9r/r+hfdqzVJHevWsRlXzVU5IG+HJleSMKnhY92ym+W2MgAA==
X-Google-Smtp-Source: AGHT+IF+zK5mHFI23v7Brrs8zwZyuTbIKUv0zvl+XpfRfDjzsnZ0CMyCOgUC/43mr2C6Se0sM5KeSVtHRvl6/NHDCCc=
X-Received: by 2002:a17:907:a893:b0:b3c:4ebc:85e5 with SMTP id
 a640c23a62f3a-b49c525b3c2mr140579366b.59.1759454308610; Thu, 02 Oct 2025
 18:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn>
In-Reply-To: <20250723113739751COZ5PkRzx6aXEuKzsHhm_@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 11:18:02 +1000
X-Gm-Features: AS18NWBNPae5B--RmlbFX7SWBEJy89SZpz9ScYVkYQK0ePemk_dIo2Bw25BawH8
Message-ID: <CAKmqyKOD1d+Me5Wk5RJbMCxJXk_bUCa2hOtnXZ_NW_YO-SdpSw@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] hw/riscv/virt: Add acpi ged and powerdown
 support
To: liu.xuemei1@zte.com.cn
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 sunilvl@ventanamicro.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
>
> --
> 2.27.0
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CE7CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYz5a-0006Yr-Q5; Mon, 15 Jun 2026 00:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYz5Y-0006Y7-GS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:38:20 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYz5W-0001ps-Ie
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:38:20 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6914a658115so3497429a12.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 21:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781498297; cv=none;
 d=google.com; s=arc-20240605;
 b=DoDL2xCe7vOGrMDMBK4qOjlu7jm0TF23RApQJjzK2ZTJQnU8dwsahU69UfQjZb6XPU
 yZwYFRrGET1kGhMkSCm5VvZwq6477aDtPhoOXXSHrK5G/HRcIPORS7R4h6s9dGVASGQm
 AEpH7bdJ0/oIwuDDvEUJKY9YgRM5bwZ4DSkNDGFTIgYMWh9OjOstp46lg5Y7S9HyE0B3
 NK2VJaJvVHVUXzTvbLUujMpmEgxxTTj+9HNqUzXKNcu8tRjHn5dlYhP1F16c4KByehOp
 DkDdSfwJGTqBHSV/XQqctJTvHcc8W7q/H6x+mPDWFDYW/ff9mBhB5GiQ+2DC1ZLle9Xk
 E4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UHHocfIwghjQPf3BDUbsHBTDdrhPB3353zMnFaxCtTM=;
 fh=pKtTuofzHa3mVOP6H/6EcVZmG3A5pvezIxk9vnWVxH8=;
 b=k5HAeLYbZDcZ+S0+Nt/nTS5NB7xQPRLWk8oYfpRqYB+bAc2/ihoQ24KLw0pXXYvZ45
 kXvkCQkzkS6PKOYx/iyJflws7V82OI7aNrt57p/qDW3/8Dvwx++PWq4IYoFS8+u9vkYj
 4bT6C8TqX0cKy81+gx7nC4OHJWZALY36fv8lYHm1PmzeSV0tZSVECt0xhEkX8//WYaAm
 /B2ixIsmp4y6fLC+W0TdqkleEEsAdm+Usf3SAGQa25ACaFmucuPLa9htIO1loj4i1KF/
 a2lsMetLigmbwz82/plZcQAmFE3PNCye4M6h0mWr5f9zfvITbXIxGMk7moaQ0BLMIWJD
 Scxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781498297; x=1782103097; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHHocfIwghjQPf3BDUbsHBTDdrhPB3353zMnFaxCtTM=;
 b=BIlrrxNRdsXa7PRwrPJlCugqwQbCJ9tyWulHl1ZuMadgZ/dZjJ1bSdyKm42uHSK+mr
 OhRhjuT7hU9A4SNXWJzc1SO/QU6VH2/G1aCCLD/UeyiUPNSKyiPutIborMoLemHj4nJQ
 i0BWSFQ05cZScH9801nHumul8IdreGdHM8PxT7iCuVLeTY5MZMlTkvPS3ByGN6i3YuN/
 Flp05jq/mPwpzsSC7PH156cL7OZ2AmvYZ14k3QgjGbnVhMWn24aBmlENdGBMW1wc1UV4
 BDojHJ+K/yH96Fdh4lw+G482BmVgWFQpzONXHK1NzHFqNJ89Oq+xc6c7uVe8FGL10W0H
 2FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781498297; x=1782103097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UHHocfIwghjQPf3BDUbsHBTDdrhPB3353zMnFaxCtTM=;
 b=TW5CvXVXTbHrn/e4WL+7jNx4w4MbsuB8wN1+5F61mzXNaJJ2TvURZKT7jzG1CM+jbu
 3B/l4+GOMysOwcSW3jxXA8Pni5ibL/+WNkao9uzp/ME+ZIsoD1MK3zI3QhezFX/TS++D
 YspFPX045Q9G4QQJIFAN39+Vlv/qgUy34iERXnuzfEVbD7dm7PABxpimwBWdvT1FicYa
 8aUYpdgKsuO5kSo5y5uQfXf2netV4awKs2LYMTmN6FLAWmmuXpbssfeKDA1y5OBcCGUR
 rL2balVHfxMnPTFc1gHAjvANoqEZ4jDjMFgVomCBsTF1OFTJUo9WS503wzzFI2wvnrLN
 oi8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GLQPTk/pkp9z2LLLqo3JXOfos5uc7teL9JPbxtdldjPkztheNfs62XWxW0D1LBDQtD2AzDBOoNT0b@nongnu.org
X-Gm-Message-State: AOJu0YzXXnEz8HMUpunMPxr+A4l91/4HRxZlifTgpj61+Kq9S8lPjozP
 TE2Qd9JxMx7mRas0L30hmVZzkfK5VNT7G/ee5itgV+CAucpPb809ULO7Zudq1yriv7bpG0VmGWB
 ql1nY3ODy8rauygtY0GL/mtgBnqU4Qr8=
X-Gm-Gg: Acq92OHWd6oeGV9fdv9nGWkHYzWJhr/ueP2/M/D5DmY2Bi35mWv2hTThpaWLzkxFMkK
 /YMeGqxCyc8wWjS+NoDmbqMWaHH8BsMXdcED/z13eJJ/+G01xkHFZI32d9YrJaNTXuttHmQVhB4
 iCLBeTXL/7FsKrSLO78vT8dlFlD/R7GRMK9xJLfckbTlg8bn/3SHTdfHf8ZdF/49uG3KoNOJRFr
 sf171Rt0Jiv2DTc54bYlaGhEl2FetygIGM9O9Cii5tHBx+2FPgCN32dk017YK5PxtTx+/2RxPui
 36Y+PF3tJHCBOSNAOQjIBNAWn8ktbf2SH2YgOw==
X-Received: by 2002:a05:6402:26d1:b0:67c:a6d1:c48b with SMTP id
 4fb4d7f45d1cf-693784f79a5mr5504493a12.11.1781498296759; Sun, 14 Jun 2026
 21:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-5-joel@jms.id.au>
In-Reply-To: <20260603065859.592063-5-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 14:37:48 +1000
X-Gm-Features: AVVi8CcoSD_Fo9RonYKuiwvdDGbhdoRyhx-VL4FKY2GJWUo8F6g5p8-QrhCxDXU
Message-ID: <CAKmqyKP0z6kFPk1keN9qazXFokHXLWSs=J3c3GoGfrb5pN+_cA@mail.gmail.com>
Subject: Re: [PATCH v8 04/12] hw/riscv/aia: Provide number of irq sources
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Wed, Jun 3, 2026 at 5:02=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote:
>
> Instead of hard coding the number of IRQ sources used by the APLIC pass
> it in as a parameter. This allows other machines to configure this as
> required.
>
> The maximum number of sources is 1023.
>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/aia.h             |  3 +--
>  include/hw/riscv/virt.h    |  1 +
>  hw/riscv/aia.c             |  8 ++++++--
>  hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
>  hw/riscv/virt.c            |  2 ++
>  5 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index dbb833340276..5ad0a902be0d 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -11,11 +11,10 @@
>
>  #include "exec/hwaddr.h"
>
> -#define VIRT_IRQCHIP_NUM_SOURCES 96
> -
>  uint32_t imsic_num_bits(uint32_t count);
>
>  DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             uint16_t num_sources,
>                               const MemMapEntry *aplic_m,
>                               const MemMapEntry *aplic_s,
>                               const MemMapEntry *imsic_m,
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index ad858deb76ad..36a2def41096 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -64,6 +64,7 @@ struct RISCVVirtState {
>      struct GPEXHost *gpex_host;
>      OnOffAuto iommu_sys;
>      uint16_t pci_iommu_bdf;
> +    uint16_t num_sources;
>  };
>
>  enum {
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index c724612a50a5..82ea9d48ea75 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
>  }
>
>  DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             uint16_t num_sources,
>                               const MemMapEntry *aplic_m,
>                               const MemMapEntry *aplic_s,
>                               const MemMapEntry *imsic_m,
> @@ -38,6 +39,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia_gue=
sts,
>      DeviceState *aplic_s_dev =3D NULL;
>      DeviceState *aplic_m_dev =3D NULL;
>
> +    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits *=
/
> +    g_assert(num_sources <=3D 1023);
> +
>      if (msimode) {
>          if (!kvm_enabled()) {
>              /* Per-socket M-level IMSICs */
> @@ -66,7 +70,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_gue=
sts,
>                                       aplic_m->size,
>                                       (msimode) ? 0 : base_hartid,
>                                       (msimode) ? 0 : hart_count,
> -                                     VIRT_IRQCHIP_NUM_SOURCES,
> +                                     num_sources,
>                                       num_prio_bits,
>                                       msimode, true, NULL);
>      }
> @@ -77,7 +81,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_gue=
sts,
>                                   aplic_s->size,
>                                   (msimode) ? 0 : base_hartid,
>                                   (msimode) ? 0 : hart_count,
> -                                 VIRT_IRQCHIP_NUM_SOURCES,
> +                                 num_sources,
>                                   num_prio_bits,
>                                   msimode, false, aplic_m_dev);
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index e3da87492408..db3ea4f03ac3 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -146,6 +146,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtS=
tate *s)
>  }
>
>  static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
> +                                     uint16_t num_sources,
>                                       uint64_t mmio_base, uint64_t mmio_s=
ize,
>                                       const char *hid)
>  {
> @@ -153,9 +154,12 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uin=
t8_t socket_count,
>      uint32_t gsi_base;
>      uint8_t  socket;
>
> +    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits *=
/
> +    g_assert(num_sources <=3D 1023);
> +
>      for (socket =3D 0; socket < socket_count; socket++) {
>          plic_aplic_addr =3D mmio_base + mmio_size * socket;
> -        gsi_base =3D VIRT_IRQCHIP_NUM_SOURCES * socket;
> +        gsi_base =3D num_sources * socket;
>          Aml *dev =3D aml_device("IC%.02X", socket);
>          aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
>          aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> @@ -474,10 +478,13 @@ static void build_dsdt(GArray *table_data,
>      socket_count =3D riscv_socket_count(ms);
>
>      if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> -        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].=
base,
> -                                 memmap[VIRT_PLIC].size, "RSCV0001");
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
> +                                 memmap[VIRT_PLIC].base,
> +                                 memmap[VIRT_PLIC].size,
> +                                 "RSCV0001");
>      } else {
> -        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_=
S].base,
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
> +                                 memmap[VIRT_APLIC_S].base,
>                                   memmap[VIRT_APLIC_S].size, "RSCV0002");
>      }
>
> @@ -494,15 +501,15 @@ static void build_dsdt(GArray *table_data,
>      } else if (socket_count =3D=3D 2) {
>          virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                               memmap[VIRT_VIRTIO].size,
> -                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
> +                             VIRTIO_IRQ + s->num_sources, 0,
>                               VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURC=
ES);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources);
>      } else {
>          virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                               memmap[VIRT_VIRTIO].size,
> -                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
> +                             VIRTIO_IRQ + s->num_sources, 0,
>                               VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURC=
ES * 2);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
>      }
>
>      aml_append(dsdt, scope);
> @@ -581,7 +588,7 @@ static void build_madt(GArray *table_data,
>          for (socket =3D 0; socket < riscv_socket_count(ms); socket++) {
>              aplic_addr =3D s->memmap[VIRT_APLIC_S].base +
>                               s->memmap[VIRT_APLIC_S].size * socket;
> -            gsi_base =3D VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            gsi_base =3D s->num_sources * socket;
>              build_append_int_noprefix(table_data, 0x1A, 1);    /* Type *=
/
>              build_append_int_noprefix(table_data, 36, 1);      /* Length=
 */
>              build_append_int_noprefix(table_data, 1, 1);       /* Versio=
n */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 614220a0ce66..4cd941a6aac6 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1549,6 +1549,7 @@ static void virt_machine_init(MachineState *machine=
)
>          } else {
>              s->irqchip[i] =3D riscv_create_aia(s->aia_type =3D=3D VIRT_A=
IA_TYPE_APLIC_IMSIC,
>                                               s->aia_guests,
> +                                             s->num_sources,
>                                               &s->memmap[VIRT_APLIC_M],
>                                               &s->memmap[VIRT_APLIC_S],
>                                               &s->memmap[VIRT_IMSIC_M],
> @@ -1705,6 +1706,7 @@ static void virt_machine_instance_init(Object *obj)
>      s->oem_table_id =3D g_strndup(ACPI_BUILD_APPNAME8, 8);
>      s->acpi =3D ON_OFF_AUTO_AUTO;
>      s->iommu_sys =3D ON_OFF_AUTO_AUTO;
> +    s->num_sources =3D VIRT_IRQCHIP_NUM_SOURCES;
>  }
>
>  static char *virt_get_aia_guests(Object *obj, Error **errp)
> --
> 2.47.3
>
>


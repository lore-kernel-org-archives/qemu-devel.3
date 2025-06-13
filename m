Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABBBC61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 11:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ31u-0005Io-8p; Fri, 13 Jun 2025 07:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ31q-0005Hg-U2
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 07:57:02 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ31m-0006mT-N5
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 07:57:02 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-70e5599b795so19341877b3.3
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749815816; x=1750420616; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vzaVIA9d+9s2Fziqj284tT6vvw/UIzD8MC8G8RTWz4=;
 b=Yq/IObmIahVO5N0QfCZGyjmvLXelc/bl+mALdwYAIYIQCa4/TYB0OitxMtdGXhX693
 /EMGLdS1GPyH7iKykHwsybxl46j6zxxqDoToQkj3QubE89trk3zEPxC4cysVIOWR1I/2
 D4AGOh28xzOL5aNwoqUzbfMkFptPj4jpfNPtOi98S20f0z8qO1+yULEKqiGp7ZmK1+BC
 q4ClELrTUYAhhYKFnESzrJqqpOMXFGdXMzBWZpTCnDFS0qNpE4b+NIJ6+rh6Uh6p0SV7
 KGCdaLogpAeRyoMz/HAx4D9fNeR28IIu7K28d8V3752gGtk8UtXp6ePLEn2HCDBnokXv
 LTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749815816; x=1750420616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vzaVIA9d+9s2Fziqj284tT6vvw/UIzD8MC8G8RTWz4=;
 b=JOGaQsqNt4qscsCnTQOilHN7AHTqakYjSae2L7eQbzI1PA1+IbvWZvl3EhZKQdtuae
 BauqaHn3Q2pUoRaqANUbvcbWMI+rKDN33Yb3LTOnRYFp3fSBMz3rCi2/HBOPGY/4RsV/
 qNY5nHO3biZvKSqGe2PtbOtIUI745hPAYeIxQCTZkPQNTfgCdEvVV7Eenu0/MQrXPQxp
 iK8eMKp1+USgJa8GR2ggypLN9INxhIUSfm15YBuCrUd52aeoGnvRXnqwC4EK+6NpuK3E
 aCRMUUVU9nrHF0jGG/Yl1wf8QX0NuzRwPkCKrCyU9nxmjvu5YhTxk+j03f1KZLhmLioA
 Bf5A==
X-Gm-Message-State: AOJu0Yy8kN2Ri3Ptz/k4RWVGnX/UaGXm2t4d29HSWZM/V6doE/ANPZCy
 ebudJvIyF52eJLvHQXk3RA5kDCdkIGXPophTtxUtZPm3i7h9yvatu2WobiBzMVfcpu/5YuSd7St
 uAFzCChxkT1cpL/wV188BMfsI3XSNQvfBje0agCik6g==
X-Gm-Gg: ASbGncvPqPaVt8CClzIeN8AHuHITQdAA6cZKwW4krSupRL0xCSJ49qr1kY6Fc4P3KLp
 6a50iqrQz8Y9pWY+r7fjBDPZ+Z0PxSfIkRe7Ek4Mm2WF5fFjyJ+x+eqHR8yR62iEDyWPQZc2d3+
 ZIErW8fZmbloOjvHvAmUVvw1NBgMFBWDshDCy9lpwFOTyE
X-Google-Smtp-Source: AGHT+IEOxX2AqqREHOhnSU56nUClVP+8hsHDw07qoVBqXeysujv/jeYDPVMDblMr+rGeAwbSVh7rStYF8g4D9OIt9iQ=
X-Received: by 2002:a05:690c:9684:b0:70f:8835:b767 with SMTP id
 00721157ae682-711636073femr36791167b3.5.1749815815922; Fri, 13 Jun 2025
 04:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250526085523.809003-1-chigot@adacore.com>
 <20250526085523.809003-4-chigot@adacore.com>
In-Reply-To: <20250526085523.809003-4-chigot@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 12:56:44 +0100
X-Gm-Features: AX0GCFubLDIpLL61bX_PZfKCL9rvgqpfC95cCKckZ_c2I88PqVyQH_kvIBGcSVs
Message-ID: <CAFEAcA_OLNWNMVe8wxCkg4JUkEvNP3ga_YpSnhYXHkD-criYEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/arm/xlnx-zynqmp: wire a second GIC for the
 Cortex-R5
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 26 May 2025 at 09:55, Cl=C3=A9ment Chigot <chigot@adacore.com> wrot=
e:
>
> From: Frederic Konrad <konrad.frederic@yahoo.fr>
>
> This wires a second GIC for the Cortex-R5, all the IRQs are split when th=
ere
> is an RPU instanciated.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

Some review of this from the Xilinx folks would be helpful.

> ---
>  hw/arm/xlnx-zynqmp.c         | 88 +++++++++++++++++++++++++++++++++---
>  include/hw/arm/xlnx-zynqmp.h |  6 +++
>  2 files changed, 87 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index ec96a46eec..be33669f87 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -26,8 +26,6 @@
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
>
> -#define GIC_NUM_SPI_INTR 160
> -
>  #define ARM_PHYS_TIMER_PPI  30
>  #define ARM_VIRT_TIMER_PPI  27
>  #define ARM_HYP_TIMER_PPI   26
> @@ -206,7 +204,7 @@ static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_regi=
ons[] =3D {
>
>  static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
>  {
> -    return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
> +    return XLXN_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_in=
dex;

Typo in your new constant name: should be XLNX_.

>  }
>
>  static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
> @@ -377,6 +375,8 @@ static void xlnx_zynqmp_init(Object *obj)
>      XlnxZynqMPState *s =3D XLNX_ZYNQMP(obj);
>      int i;
>      int num_apus =3D MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
> +    int num_rpus =3D MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
> +                       XLNX_ZYNQMP_NUM_RPU_CPUS);

This is kind of a complicated expression that we use twice, and
I think it would be worth abstracting out into a function.

>      object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
>                              TYPE_CPU_CLUSTER);
> @@ -390,6 +390,12 @@ static void xlnx_zynqmp_init(Object *obj)
>
>      object_initialize_child(obj, "gic", &s->gic, gic_class_name());
>
> +    if (num_rpus > 0) {
> +        /* Do not create the rpu_gic in case we don't have rpus..  */

stray ".." at end. Also I would say "if", rather than "in case".

> +        object_initialize_child(obj, "rpu_gic", &s->rpu_gic,
> +                                gic_class_name());
> +    }
> +
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
>          object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_=
GEM);
>          object_initialize_child(obj, "gem-irq-orgate[*]",
> @@ -439,6 +445,13 @@ static void xlnx_zynqmp_init(Object *obj)
>      object_initialize_child(obj, "qspi-irq-orgate",
>                              &s->qspi_irq_orgate, TYPE_OR_IRQ);
>
> +    for (i =3D 0; i < ARRAY_SIZE(s->splitter); i++) {
> +        g_autofree char *name =3D g_strdup_printf("irq-splitter%d", i);
> +        object_initialize_child(obj, name, &s->splitter[i], TYPE_SPLIT_I=
RQ);
> +    }

We don't need the splitters unless num_rpus > 0, so I think
it would be neater not to create/realize/use them.

> +
> +
> +
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
>          object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_USB_DWC3=
);
>      }
> @@ -452,10 +465,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>      uint8_t i;
>      uint64_t ram_size;
>      int num_apus =3D MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
> +    int num_rpus =3D MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
> +                       XLNX_ZYNQMP_NUM_RPU_CPUS);
>      const char *boot_cpu =3D s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
>      ram_addr_t ddr_low_size, ddr_high_size;
> -    qemu_irq gic_spi[GIC_NUM_SPI_INTR];
> +    qemu_irq gic_spi[XLXN_ZYNQMP_GIC_NUM_SPI_INTR];
>      Error *err =3D NULL;
> +    DeviceState *splitter;

I think you can put this variable declaration inside the
loop where it is used, so it has a much smaller scope.

>      ram_size =3D memory_region_size(s->ddr_ram);
>
> @@ -502,13 +518,21 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>          g_free(ocm_name);
>      }
>
> -    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + =
32);
> +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", XLXN_ZYNQMP_GIC_NUM=
_SPI_INTR + 32);
>      qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
>      qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
>      qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->sec=
ure);
>      qdev_prop_set_bit(DEVICE(&s->gic),
>                        "has-virtualization-extensions", s->virt);
>
> +    if (num_rpus > 0) {
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-irq",
> +                             XLXN_ZYNQMP_GIC_NUM_SPI_INTR + 32);
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "revision", 1);
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-cpu", num_rpus);
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "first-cpu-index", 4);
> +    }
> +
>      qdev_realize(DEVICE(&s->apu_cluster), NULL, &error_fatal);
>
>      /* Realize APUs before realizing the GIC. KVM requires this.  */

> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index c137ac59e8..a69953650d 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -42,6 +42,7 @@
>  #include "hw/misc/xlnx-zynqmp-crf.h"
>  #include "hw/timer/cadence_ttc.h"
>  #include "hw/usb/hcd-dwc3.h"
> +#include "hw/core/split-irq.h"
>
>  #define TYPE_XLNX_ZYNQMP "xlnx-zynqmp"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
> @@ -87,12 +88,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQ=
MP)
>                                    XLNX_ZYNQMP_MAX_HIGH_RAM_SIZE)
>
>  #define XLNX_ZYNQMP_NUM_TTC 4
> +#define XLXN_ZYNQMP_GIC_NUM_SPI_INTR 160
>
>  /*
>   * Unimplemented mmio regions needed to boot some images.
>   */
>  #define XLNX_ZYNQMP_NUM_UNIMP_AREAS 1
>
> +

Stray extra whitespace change.

>  struct XlnxZynqMPState {
>      /*< private >*/
>      DeviceState parent_obj;
> @@ -105,6 +108,9 @@ struct XlnxZynqMPState {
>      GICState gic;
>      MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQMP_GIC_ALIASES=
];
>
> +    GICState rpu_gic;
> +    SplitIRQ splitter[XLXN_ZYNQMP_GIC_NUM_SPI_INTR];
> +
>      MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];
>
>      MemoryRegion *ddr_ram;

thanks
-- PMM


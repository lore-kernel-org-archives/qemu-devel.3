Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8BBCA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTqw-0003k1-Hz; Mon, 25 Aug 2025 05:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uqTqt-0003jZ-31
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:50:59 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uqTqp-0001af-DD
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:50:58 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-afcb7a2befdso599013566b.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1756115448; x=1756720248; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTzZDSfvElTZseXIR8MM/DMpaP2+xfkCPM86dY+vOS0=;
 b=lIXhTRMLUEkhrUizGM09w/7toqTIJe50d78iV1Xdm9iCIu0HXnBfxiAvpXY4XOXOYc
 obeTJSl3B23n7PuFgSppgcPybOaCa5Bo5fn6y3vBfx/eqZ73QIBpf6I2nIs/UGnJV+g7
 bVRT/FHIL167FJzm9fpRbg+8BbdwDVT5XUQvqXZ+Y6xeMQP8toCD3W/p/XAIJzZBVmeu
 36Ei9mporf6Sbusqjv1GTgmeoXTmd3TVe4s9euiJ3uL0ZU1nZ+0um2p8GfHeEaywP6f9
 Le1/BTJBJifN4buL8Ua+Hs/e86/oDWI9tV7e5ScNstumS1yamsNWebdKz7t5bKNDLNfo
 UsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756115448; x=1756720248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTzZDSfvElTZseXIR8MM/DMpaP2+xfkCPM86dY+vOS0=;
 b=j+SRJWI3YCrJueh+ZzcsFb4OvSVooCcGUxIgWuSkcEbgzxegQMVmVro7OF7eAOnZwU
 CQPFt42zHjOmqp+CSs6j915BnuzwBKZki5P6Q1WTijxQ9zrgiERXN2tr1RNfAL+8bILI
 CuFbGTyOrAC0K9rMDmsByqrDYDuZvxZVON5lcjwN1130Df7B/bX1j+wg76njICZrFP6y
 T78wDwyyvImFT8INw57dvbrFozpP4VzM00wptHTBYWDmpeNKpIS3E8WuORE/Je6KjS4M
 xf6AFppzbiqrT6silgp0ng7YL73ORGvR1AfSXtIFaIczd4BolYC33zy15c56hYTP9mw8
 M1NQ==
X-Gm-Message-State: AOJu0YwRfuAEN/oONJnvnooVVbup19dDr1kNNy1c2lGlGiDg4i9C18xo
 xNjQjKBeKnKP7C3U+eX0LoSuUoqa6hJ2N5GxKD+5LNqwxjf+rskylK4Pay/3rlCGrtmQ+mtqVSH
 ExdLQ16SaFG5Xj1bL3Npy4Nc3f4/Xx1mNsPjqDVu5WZil+Lv2VA4=
X-Gm-Gg: ASbGncuy8OGblHq5R0VhiaHP2RojgETMFuSUoUw88BpN7WujkTU9HQGEJd7XJAF5vD5
 AG2JydnmWPckln4CX+JUAKnMPIib5/xOG0IhOtRJoXof/FsAidNWSsRVKgDAD0SJ9fM1lJHciSe
 k02e+901QC7KGApjPofQH4a1ujKNVk4E7p71IvqI20ezFa1/HfcYj2TOrQtGHVIRuUqzMfk1o5a
 ZtdYnvWfm1xEcTW7w==
X-Google-Smtp-Source: AGHT+IHCWK06OrJw6Q6+JjStBnC23ZHghBM/uph9btWs21wx5sDv/OVzA+ZNPEjV+31ujJ+43S6hEoR8lILJdj7nlDM=
X-Received: by 2002:a17:907:1c93:b0:af9:d80f:645d with SMTP id
 a640c23a62f3a-afe29793340mr1021068366b.57.1756115448389; Mon, 25 Aug 2025
 02:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250613134208.1509436-1-chigot@adacore.com>
 <20250613134208.1509436-4-chigot@adacore.com>
In-Reply-To: <20250613134208.1509436-4-chigot@adacore.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 25 Aug 2025 11:50:37 +0200
X-Gm-Features: Ac12FXxevwTcoOSjbYEzC9Z1i5XOGMkkG8mSUYEuWlriD3GgccpklTuD5WC9OKY
Message-ID: <CAJ307EhL53SPK4q4sd1FWQ_EKAksrRGPuMrJVn+Z-TOouevpWQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/arm/xlnx-zynqmp: wire a second GIC for the
 Cortex-R5
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 13, 2025 at 3:42=E2=80=AFPM Cl=C3=A9ment Chigot <chigot@adacore=
.com> wrote:
>
> From: Frederic Konrad <konrad.frederic@yahoo.fr>
>
> This wires a second GIC for the Cortex-R5, all the IRQs are split when th=
ere
> is an RPU instanciated.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

Gentle ping here (just realized this patch hasn't been merged as I thought.=
..)

TIA,
Cl=C3=A9ment

> ---
>  hw/arm/xlnx-zynqmp.c         | 103 +++++++++++++++++++++++++++++++----
>  include/hw/arm/xlnx-zynqmp.h |   5 ++
>  2 files changed, 98 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index ec96a46eec..ffed6e5126 100644
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
> @@ -206,17 +204,26 @@ static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_re=
gions[] =3D {
>
>  static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
>  {
> -    return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
> +    return XLNX_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_in=
dex;
> +}
> +
> +static unsigned int xlnx_zynqmp_get_rpu_number(MachineState *ms)
> +{
> +    /*
> +     * RPUs will be created only if "-smp" is higher than the maximum
> +     * of APUs. Round it up to 0 to avoid dealing with negative values.
> +     */
> +    return MAX(0, MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
> +                      XLNX_ZYNQMP_NUM_RPU_CPUS));
>  }
>
>  static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
>                                     const char *boot_cpu, Error **errp)
>  {
>      int i;
> -    int num_rpus =3D MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
> -                       XLNX_ZYNQMP_NUM_RPU_CPUS);
> +    int num_rpus =3D xlnx_zynqmp_get_rpu_number(ms);
>
> -    if (num_rpus <=3D 0) {
> +    if (!num_rpus) {
>          /* Don't create rpu-cluster object if there's nothing to put in =
it */
>          return;
>      }
> @@ -377,6 +384,7 @@ static void xlnx_zynqmp_init(Object *obj)
>      XlnxZynqMPState *s =3D XLNX_ZYNQMP(obj);
>      int i;
>      int num_apus =3D MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
> +    int num_rpus =3D xlnx_zynqmp_get_rpu_number(ms);
>
>      object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
>                              TYPE_CPU_CLUSTER);
> @@ -390,6 +398,12 @@ static void xlnx_zynqmp_init(Object *obj)
>
>      object_initialize_child(obj, "gic", &s->gic, gic_class_name());
>
> +    if (num_rpus) {
> +        /* Do not create the rpu_gic if we don't have rpus */
> +        object_initialize_child(obj, "rpu_gic", &s->rpu_gic,
> +                                gic_class_name());
> +    }
> +
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
>          object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_=
GEM);
>          object_initialize_child(obj, "gem-irq-orgate[*]",
> @@ -439,6 +453,15 @@ static void xlnx_zynqmp_init(Object *obj)
>      object_initialize_child(obj, "qspi-irq-orgate",
>                              &s->qspi_irq_orgate, TYPE_OR_IRQ);
>
> +    if (num_rpus) {
> +        for (i =3D 0; i < ARRAY_SIZE(s->splitter); i++) {
> +            g_autofree char *name =3D g_strdup_printf("irq-splitter%d", =
i);
> +            object_initialize_child(obj, name, &s->splitter[i], TYPE_SPL=
IT_IRQ);
> +        }
> +    }
> +
> +
> +
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
>          object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_USB_DWC3=
);
>      }
> @@ -452,9 +475,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Er=
ror **errp)
>      uint8_t i;
>      uint64_t ram_size;
>      int num_apus =3D MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
> +    int num_rpus =3D xlnx_zynqmp_get_rpu_number(ms);
>      const char *boot_cpu =3D s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
>      ram_addr_t ddr_low_size, ddr_high_size;
> -    qemu_irq gic_spi[GIC_NUM_SPI_INTR];
> +    qemu_irq gic_spi[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
>      Error *err =3D NULL;
>
>      ram_size =3D memory_region_size(s->ddr_ram);
> @@ -502,13 +526,22 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>          g_free(ocm_name);
>      }
>
> -    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + =
32);
> +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq",
> +                         XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
>      qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
>      qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
>      qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->sec=
ure);
>      qdev_prop_set_bit(DEVICE(&s->gic),
>                        "has-virtualization-extensions", s->virt);
>
> +    if (num_rpus) {
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-irq",
> +                             XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "revision", 1);
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-cpu", num_rpus);
> +        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "first-cpu-index", 4);
> +    }
> +
>      qdev_realize(DEVICE(&s->apu_cluster), NULL, &error_fatal);
>
>      /* Realize APUs before realizing the GIC. KVM requires this.  */
> @@ -608,13 +641,63 @@ static void xlnx_zynqmp_realize(DeviceState *dev, E=
rror **errp)
>          return;
>      }
>
> +    if (num_rpus) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->rpu_gic), errp)) {
> +            return;
> +        }
> +
> +        for (i =3D 0; i < num_rpus; i++) {
> +            qemu_irq irq;
> +
> +            sysbus_mmio_map(SYS_BUS_DEVICE(&s->rpu_gic), i + 1,
> +                            GIC_BASE_ADDR + i * 0x1000);
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_IRQ));
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus=
,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_FIQ));
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus=
 * 2,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_VIRQ));
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus=
 * 3,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_VFIQ));
> +            irq =3D qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i, ARM_PHYS_TIMER_P=
PI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_PHYS, i=
rq);
> +            irq =3D qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i, ARM_VIRT_TIMER_P=
PI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_VIRT, i=
rq);
> +            irq =3D qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i, ARM_HYP_TIMER_PP=
I));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_HYP, ir=
q);
> +            irq =3D qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i, ARM_SEC_TIMER_PP=
I));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_SEC, ir=
q);
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->rpu_gic), 0, GIC_BASE_ADDR);
> +    }
> +
>      if (!s->boot_cpu_ptr) {
>          error_setg(errp, "ZynqMP Boot cpu %s not found", boot_cpu);
>          return;
>      }
>
> -    for (i =3D 0; i < GIC_NUM_SPI_INTR; i++) {
> -        gic_spi[i] =3D qdev_get_gpio_in(DEVICE(&s->gic), i);
> +    for (i =3D 0; i < XLNX_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
> +        if (num_rpus) {
> +            DeviceState *splitter =3D DEVICE(&s->splitter[i]);
> +            qdev_prop_set_uint16(splitter, "num-lines", 2);
> +            qdev_realize(splitter, NULL, &error_abort);
> +            gic_spi[i] =3D qdev_get_gpio_in(splitter, 0);
> +            qdev_connect_gpio_out(splitter, 0,
> +                                  qdev_get_gpio_in(DEVICE(&s->gic), i));
> +            qdev_connect_gpio_out(splitter, 1,
> +                                  qdev_get_gpio_in(DEVICE(&s->rpu_gic), =
i));
> +        } else {
> +            gic_spi[i] =3D qdev_get_gpio_in(DEVICE(&s->gic), i);
> +        }
>      }
>
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index c137ac59e8..0ae00e10f6 100644
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
> @@ -87,6 +88,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP=
)
>                                    XLNX_ZYNQMP_MAX_HIGH_RAM_SIZE)
>
>  #define XLNX_ZYNQMP_NUM_TTC 4
> +#define XLNX_ZYNQMP_GIC_NUM_SPI_INTR 160
>
>  /*
>   * Unimplemented mmio regions needed to boot some images.
> @@ -105,6 +107,9 @@ struct XlnxZynqMPState {
>      GICState gic;
>      MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQMP_GIC_ALIASES=
];
>
> +    GICState rpu_gic;
> +    SplitIRQ splitter[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
> +
>      MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];
>
>      MemoryRegion *ddr_ram;
> --
> 2.34.1
>


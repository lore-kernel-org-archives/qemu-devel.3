Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3A0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 01:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2JTG-0006t4-93; Fri, 26 Sep 2025 21:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v2JT9-0006s8-Po
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 21:11:24 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v2JSy-0006TW-4s
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 21:11:23 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-631df7b2dffso5809985a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758935464; x=1759540264; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oYoARuN/V0DMoFMSA+cVjdRfSmeQHqGUfJLtzWbvR50=;
 b=OAXBog5vXgwGcIAmNYhv8S6xufjKwPDy1qKccMfPgh3LgcBVZriBYKql2GFXtYTFxD
 5Ig/tqY7BQb97RblG84W+VZKNLR6Pj9aMg0AS3YHraer+VGzJVVaqqaHgT72oGCFBnUH
 dn5G9LeUaTWRKPch1qtQDg4Ojqoo8JYjVNtPofZzJ7B/v6L7LoqfUwkBEASH7/nh2wEH
 b+ZdkYvTkxWoZcPe0qFQp0vfDm7wjG7DRYmyA1s5J7H30atr3LU/9FeaHu1WV/W8gfpu
 YU4gd3qiznpC50M7fDaN6VuRrjoaxvgePFFnBmO/E/v5iG2Jt5sJg0pZKFGcVOcRfhGG
 2IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758935464; x=1759540264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oYoARuN/V0DMoFMSA+cVjdRfSmeQHqGUfJLtzWbvR50=;
 b=phnpNRN+f+XkgjajwcrguPvr6wgpUmsJGn6Dxq8Pa2fHUEwgMKJtBO/odS3Yyi8uHs
 GULd96UwWwiEopvE28fll1KB6N1ASUXVokRlVIWfGJNqppZ2SqIsvGX6HssAXb68s8iq
 4tKnt9Ismsveht1qWIVBN2ajQQJaXR+d/aEDlfrrh4pNYsXtBKdkGq6xW71OMfZ25Drv
 fl5gdOEMPjw/2P5gQaeSMVXB1XKODt6SfIgc/g8DknWSouoeKoyndk6sL7QiFrVNdBJW
 +rM9Lf1WgZzRC+VwBUAHmErVbIBAWbuHEe0snYQEwNA0R9jaIpS9hBg7pkVEBq3SVyZA
 4mUQ==
X-Gm-Message-State: AOJu0YzKKDTfDSfgDDkjFEYhUvAyEU3G1u2UxZeA3NUrZ51GCC8s3bCP
 YVR08j3AL2UX27RL+PLNIBGJ8xm9cu8KworxWMFY1GrfrLDzuxRB5OGUMT9Xvhi++YLYH/oLxJY
 g7kF0q9udONzCQof4mwcxtKw9yf1UZgM=
X-Gm-Gg: ASbGncsDIEYqzRqhLydXIzda11GNgTsRL+cbz2E4tGilDKbZO2i22fGE1hqWD6VcB0S
 qZBsbBm+xJv50CzCGIMMFor7SASuTufscvLv+G5UInjuCN7CarE5iZD9eueM3UnlERZXUh0vsfJ
 gN3SmjWrHKposZfwHqbbpvBjpM0JjLWrfzzawI1pVbHhs9w0Ehwe3D5yBlW0ks17KBSJEmok/lk
 OydzS2JKE4k4B4HxA==
X-Google-Smtp-Source: AGHT+IGoCkZD17HNnSCjBIZX3AUIsELykK+U3hGJvOpOasU1Qvm9o28DzhB7YJVPCNBnsN9je7kTIPTXgRU7k3oPaAU=
X-Received: by 2002:a05:6402:46cc:b0:62f:9091:ff30 with SMTP id
 4fb4d7f45d1cf-634ce7925e6mr1342733a12.3.1758935464194; Fri, 26 Sep 2025
 18:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250915085914.526890-1-chigot@adacore.com>
In-Reply-To: <20250915085914.526890-1-chigot@adacore.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 26 Sep 2025 19:10:15 -0600
X-Gm-Features: AS18NWDsqHPWWpz72dGq0eNqKVHC8ThIasODR7dLoEJWt6-Y-Ouz6ffbKQV9Wpw
Message-ID: <CAJy5ezoBhFphtU27ytu_aRGue21wE=x+Z_MWmrinuXG=UDrJ9Q@mail.gmail.com>
Subject: Re: [RESEND PATCH] hw/arm/xlnx-zynqmp: wire a second GIC for the
 Cortex-R5
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: multipart/alternative; boundary="00000000000086b6a0063fbe13b0"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000086b6a0063fbe13b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 2:59=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adacore=
.com> wrote:

> From: Frederic Konrad <konrad.frederic@yahoo.fr>
>
> This wires a second GIC for the Cortex-R5, all the IRQs are split when
> there
> is an RPU instanciated.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>
>
Hi!

It looks like this patch is changing multiple things, perhaps we should
split it? See inline comments.
Besides that, this looks good to me!



> ---
>
> Originally, this patch was member of a wider series. Other patches have
> been merged since thus submit it back as a standalone patch.
>  https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg02328.html
>
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
>

Could be a separate patch to use XLNX_ZYNQMP_GIC_NUM_SPI_INTR instead of
GIC_NUM_SPI_INTR?



> -
>  #define ARM_PHYS_TIMER_PPI  30
>  #define ARM_VIRT_TIMER_PPI  27
>  #define ARM_HYP_TIMER_PPI   26
> @@ -206,17 +204,26 @@ static const XlnxZynqMPGICRegion
> xlnx_zynqmp_gic_regions[] =3D {
>
>  static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
>  {
> -    return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
> +    return XLNX_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL +
> ppi_index;
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
>


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
>          /* Don't create rpu-cluster object if there's nothing to put in
> it */
>          return;
>      }
>

This change looks good to me but it is also a bit unrelated to wiring up a
second GIC.



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
>          object_initialize_child(obj, "gem[*]", &s->gem[i],
> TYPE_CADENCE_GEM);
>          object_initialize_child(obj, "gem-irq-orgate[*]",
> @@ -439,6 +453,15 @@ static void xlnx_zynqmp_init(Object *obj)
>      object_initialize_child(obj, "qspi-irq-orgate",
>                              &s->qspi_irq_orgate, TYPE_OR_IRQ);
>
> +    if (num_rpus) {
> +        for (i =3D 0; i < ARRAY_SIZE(s->splitter); i++) {
> +            g_autofree char *name =3D g_strdup_printf("irq-splitter%d", =
i);
> +            object_initialize_child(obj, name, &s->splitter[i],
> TYPE_SPLIT_IRQ);
> +        }
> +    }
> +
> +
> +
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
>          object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_USB_DWC3=
);
>      }
> @@ -452,9 +475,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev,
> Error **errp)
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
> @@ -502,13 +526,22 @@ static void xlnx_zynqmp_realize(DeviceState *dev,
> Error **errp)
>          g_free(ocm_name);
>      }
>
> -    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR +
> 32);
> +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq",
> +                         XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
>      qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
>      qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
>      qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions",
> s->secure);
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
> @@ -608,13 +641,63 @@ static void xlnx_zynqmp_realize(DeviceState *dev,
> Error **errp)
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
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus
> * 2,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_VIRQ));
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus
> * 3,
> +                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
> +                                                ARM_CPU_VFIQ));
> +            irq =3D qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i,
> ARM_PHYS_TIMER_PPI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_PHYS,
> irq);
> +            irq =3D qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i,
> ARM_VIRT_TIMER_PPI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_VIRT,
> irq);
> +            irq =3D qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i,
> ARM_HYP_TIMER_PPI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_HYP,
> irq);
> +            irq =3D qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> +                                   arm_gic_ppi_index(i,
> ARM_SEC_TIMER_PPI));
> +            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_SEC,
> irq);
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
> +                                  qdev_get_gpio_in(DEVICE(&s->rpu_gic),
> i));
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
>

--00000000000086b6a0063fbe13b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 15,=
 2025 at 2:59=E2=80=AFAM Cl=C3=A9ment Chigot &lt;<a href=3D"mailto:chigot@a=
dacore.com">chigot@adacore.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">From: Frederic Konrad &lt;<a href=3D"mailto:k=
onrad.frederic@yahoo.fr" target=3D"_blank">konrad.frederic@yahoo.fr</a>&gt;=
<br>
<br>
This wires a second GIC for the Cortex-R5, all the IRQs are split when ther=
e<br>
is an RPU instanciated.<br>
<br>
Signed-off-by: Cl=C3=A9ment Chigot &lt;<a href=3D"mailto:chigot@adacore.com=
" target=3D"_blank">chigot@adacore.com</a>&gt;<br>
<br></blockquote><div><br></div><div>Hi!</div><div><br></div><div>It looks =
like this patch is changing multiple things, perhaps we should split it? Se=
e inline comments.</div><div>Besides that, this looks good to me!</div><div=
><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
---<br>
<br>
Originally, this patch was member of a wider series. Other patches have<br>
been merged since thus submit it back as a standalone patch.<br>
=C2=A0<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg0=
2328.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archi=
ve/html/qemu-devel/2025-06/msg02328.html</a><br>
<br>
---<br>
=C2=A0hw/arm/xlnx-zynqmp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 103 +++++++++=
++++++++++++++++++++++----<br>
=C2=A0include/hw/arm/xlnx-zynqmp.h |=C2=A0 =C2=A05 ++<br>
=C2=A02 files changed, 98 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c<br>
index ec96a46eec..ffed6e5126 100644<br>
--- a/hw/arm/xlnx-zynqmp.c<br>
+++ b/hw/arm/xlnx-zynqmp.c<br>
@@ -26,8 +26,6 @@<br>
=C2=A0#include &quot;target/arm/cpu-qom.h&quot;<br>
=C2=A0#include &quot;target/arm/gtimer.h&quot;<br>
<br>
-#define GIC_NUM_SPI_INTR 160<br></blockquote><div><br></div><div>Could be =
a separate patch to use XLNX_ZYNQMP_GIC_NUM_SPI_INTR instead of GIC_NUM_SPI=
_INTR?</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
-<br>
=C2=A0#define ARM_PHYS_TIMER_PPI=C2=A0 30<br>
=C2=A0#define ARM_VIRT_TIMER_PPI=C2=A0 27<br>
=C2=A0#define ARM_HYP_TIMER_PPI=C2=A0 =C2=A026<br>
@@ -206,17 +204,26 @@ static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_regi=
ons[] =3D {<br>
<br>
=C2=A0static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;=
<br>
+=C2=A0 =C2=A0 return XLNX_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL =
+ ppi_index;<br>
+}<br>
+<br>
+static unsigned int xlnx_zynqmp_get_rpu_number(MachineState *ms)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* RPUs will be created only if &quot;-smp&quot; is hig=
her than the maximum<br>
+=C2=A0 =C2=A0 =C2=A0* of APUs. Round it up to 0 to avoid dealing with nega=
tive values.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 return MAX(0, MIN((int)(ms-&gt;smp.cpus - XLNX_ZYNQMP_NUM_AP=
U_CPUS),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 XLNX_ZYNQMP_NUM_RPU_CPUS));<br></blockquote><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState =
*s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *boot_cpu, =
Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
-=C2=A0 =C2=A0 int num_rpus =3D MIN((int)(ms-&gt;smp.cpus - XLNX_ZYNQMP_NUM=
_APU_CPUS),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0XLNX_ZYNQMP_NUM_RPU_CPUS);<br>
+=C2=A0 =C2=A0 int num_rpus =3D xlnx_zynqmp_get_rpu_number(ms);<br>
<br>
-=C2=A0 =C2=A0 if (num_rpus &lt;=3D 0) {<br>
+=C2=A0 =C2=A0 if (!num_rpus) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Don&#39;t create rpu-cluster object if=
 there&#39;s nothing to put in it */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>This change looks=
 good to me but it is also a bit unrelated to wiring up a second GIC.</div>=
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
@@ -377,6 +384,7 @@ static void xlnx_zynqmp_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0XlnxZynqMPState *s =3D XLNX_ZYNQMP(obj);<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0int num_apus =3D MIN(ms-&gt;smp.cpus, XLNX_ZYNQMP_NUM_A=
PU_CPUS);<br>
+=C2=A0 =C2=A0 int num_rpus =3D xlnx_zynqmp_get_rpu_number(ms);<br>
<br>
=C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;apu-cluster&quot;, &=
amp;s-&gt;apu_cluster,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_CPU_CLUSTER);<br>
@@ -390,6 +398,12 @@ static void xlnx_zynqmp_init(Object *obj)<br>
<br>
=C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;gic&quot;, &amp;s-&g=
t;gic, gic_class_name());<br>
<br>
+=C2=A0 =C2=A0 if (num_rpus) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Do not create the rpu_gic if we don&#39;t h=
ave rpus */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(obj, &quot;rpu_gic&quo=
t;, &amp;s-&gt;rpu_gic,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gic_class_name());<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; XLNX_ZYNQMP_NUM_GEMS; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;gem[*]=
&quot;, &amp;s-&gt;gem[i], TYPE_CADENCE_GEM);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;gem-ir=
q-orgate[*]&quot;,<br>
@@ -439,6 +453,15 @@ static void xlnx_zynqmp_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;qspi-irq-orgate&quot=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;qspi_irq_orgate, TYPE_OR_IRQ);<br=
>
<br>
+=C2=A0 =C2=A0 if (num_rpus) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(s-&gt;splitter=
); i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *name =3D g_strd=
up_printf(&quot;irq-splitter%d&quot;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize_child(obj, nam=
e, &amp;s-&gt;splitter[i], TYPE_SPLIT_IRQ);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+<br>
+<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; XLNX_ZYNQMP_NUM_USB; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;usb[*]=
&quot;, &amp;s-&gt;usb[i], TYPE_USB_DWC3);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -452,9 +475,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0uint8_t i;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t ram_size;<br>
=C2=A0 =C2=A0 =C2=A0int num_apus =3D MIN(ms-&gt;smp.cpus, XLNX_ZYNQMP_NUM_A=
PU_CPUS);<br>
+=C2=A0 =C2=A0 int num_rpus =3D xlnx_zynqmp_get_rpu_number(ms);<br>
=C2=A0 =C2=A0 =C2=A0const char *boot_cpu =3D s-&gt;boot_cpu ? s-&gt;boot_cp=
u : &quot;apu-cpu[0]&quot;;<br>
=C2=A0 =C2=A0 =C2=A0ram_addr_t ddr_low_size, ddr_high_size;<br>
-=C2=A0 =C2=A0 qemu_irq gic_spi[GIC_NUM_SPI_INTR];<br>
+=C2=A0 =C2=A0 qemu_irq gic_spi[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];<br>
=C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0ram_size =3D memory_region_size(s-&gt;ddr_ram);<br>
@@ -502,13 +526,22 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(ocm_name);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;num-irq&q=
uot;, GIC_NUM_SPI_INTR + 32);<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;num-irq&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;revi=
sion&quot;, 2);<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_uint32(DEVICE(&amp;s-&gt;gic), &quot;num-=
cpu&quot;, num_apus);<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_bit(DEVICE(&amp;s-&gt;gic), &quot;has-sec=
urity-extensions&quot;, s-&gt;secure);<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_bit(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;has-virtualization-extensions&quot;, s-&gt;virt);<br>
<br>
+=C2=A0 =C2=A0 if (num_rpus) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;rpu_gic=
), &quot;num-irq&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;rpu_gic=
), &quot;revision&quot;, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;rpu_gic=
), &quot;num-cpu&quot;, num_rpus);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(&amp;s-&gt;rpu_gic=
), &quot;first-cpu-index&quot;, 4);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qdev_realize(DEVICE(&amp;s-&gt;apu_cluster), NULL, &amp=
;error_fatal);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Realize APUs before realizing the GIC. KVM requires =
this.=C2=A0 */<br>
@@ -608,13 +641,63 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (num_rpus) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;=
rpu_gic), errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; num_rpus; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq irq;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&=
amp;s-&gt;rpu_gic), i + 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 GIC_BASE_ADDR + i * 0x1000);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVIC=
E(&amp;s-&gt;rpu_gic), i,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;rp=
u_cpu[i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ARM_CPU_IRQ));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVIC=
E(&amp;s-&gt;rpu_gic), i + num_rpus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;rp=
u_cpu[i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ARM_CPU_FIQ));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVIC=
E(&amp;s-&gt;rpu_gic), i + num_rpus * 2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;rp=
u_cpu[i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ARM_CPU_VIRQ));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVIC=
E(&amp;s-&gt;rpu_gic), i + num_rpus * 3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;rp=
u_cpu[i]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ARM_CPU_VFIQ));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq =3D qdev_get_gpio_in(DEVICE(=
&amp;s-&gt;rpu_gic),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arm_gic_ppi_index(i, AR=
M_PHYS_TIMER_PPI));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(DEVICE(&am=
p;s-&gt;rpu_cpu[i]), GTIMER_PHYS, irq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq =3D qdev_get_gpio_in(DEVICE(=
&amp;s-&gt;rpu_gic),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arm_gic_ppi_index(i, AR=
M_VIRT_TIMER_PPI));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(DEVICE(&am=
p;s-&gt;rpu_cpu[i]), GTIMER_VIRT, irq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq =3D qdev_get_gpio_in(DEVICE(=
&amp;s-&gt;rpu_gic),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arm_gic_ppi_index(i, AR=
M_HYP_TIMER_PPI));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(DEVICE(&am=
p;s-&gt;rpu_cpu[i]), GTIMER_HYP, irq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq =3D qdev_get_gpio_in(DEVICE(=
&amp;s-&gt;rpu_gic),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arm_gic_ppi_index(i, AR=
M_SEC_TIMER_PPI));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(DEVICE(&am=
p;s-&gt;rpu_cpu[i]), GTIMER_SEC, irq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;rpu_=
gic), 0, GIC_BASE_ADDR);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!s-&gt;boot_cpu_ptr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;ZynqMP Boot cpu %s=
 not found&quot;, boot_cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; GIC_NUM_SPI_INTR; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gic_spi[i] =3D qdev_get_gpio_in(DEVICE(&amp;s-=
&gt;gic), i);<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; XLNX_ZYNQMP_GIC_NUM_SPI_INTR; i++) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (num_rpus) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DeviceState *splitter =3D DEVICE=
(&amp;s-&gt;splitter[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint16(splitter, &=
quot;num-lines&quot;, 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_realize(splitter, NULL, &am=
p;error_abort);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gic_spi[i] =3D qdev_get_gpio_in(=
splitter, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(splitter, =
0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;=
s-&gt;gic), i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_connect_gpio_out(splitter, =
1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;=
s-&gt;rpu_gic), i));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gic_spi[i] =3D qdev_get_gpio_in(=
DEVICE(&amp;s-&gt;gic), i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; XLNX_ZYNQMP_NUM_GEMS; i++) {<br>
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h<br=
>
index c137ac59e8..0ae00e10f6 100644<br>
--- a/include/hw/arm/xlnx-zynqmp.h<br>
+++ b/include/hw/arm/xlnx-zynqmp.h<br>
@@ -42,6 +42,7 @@<br>
=C2=A0#include &quot;hw/misc/xlnx-zynqmp-crf.h&quot;<br>
=C2=A0#include &quot;hw/timer/cadence_ttc.h&quot;<br>
=C2=A0#include &quot;hw/usb/hcd-dwc3.h&quot;<br>
+#include &quot;hw/core/split-irq.h&quot;<br>
<br>
=C2=A0#define TYPE_XLNX_ZYNQMP &quot;xlnx-zynqmp&quot;<br>
=C2=A0OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)<br>
@@ -87,6 +88,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0XLNX_ZYNQMP_MAX_HIGH_RA=
M_SIZE)<br>
<br>
=C2=A0#define XLNX_ZYNQMP_NUM_TTC 4<br>
+#define XLNX_ZYNQMP_GIC_NUM_SPI_INTR 160<br>
<br>
=C2=A0/*<br>
=C2=A0 * Unimplemented mmio regions needed to boot some images.<br>
@@ -105,6 +107,9 @@ struct XlnxZynqMPState {<br>
=C2=A0 =C2=A0 =C2=A0GICState gic;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQM=
P_GIC_ALIASES];<br>
<br>
+=C2=A0 =C2=A0 GICState rpu_gic;<br>
+=C2=A0 =C2=A0 SplitIRQ splitter[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];<br>
+<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];<br>
<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *ddr_ram;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--00000000000086b6a0063fbe13b0--


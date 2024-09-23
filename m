Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409ACCF9C69
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 11:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssh8y-0002uk-W9; Mon, 23 Sep 2024 07:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ssh8u-0002dk-It
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 07:22:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1ssh8d-00044Z-19
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 07:22:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71788bfe60eso3368521b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1727090512; x=1727695312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEm6YOkcrV+96ZDfSXg4SU50pbZJe60mjhSLf5RNopM=;
 b=YZZHppAky0QCxVKaRLm2x8Dfw3tORTuyoUlHRPwsc2JoQ57SQvJGD2YpveGeg1afC/
 427e9fsX+wtW5zuNs+/dAtvIvPhxFdGpFhOsu7QuYuz8GU5nZiFroa5Py5UFctQZmm3x
 QsFfC2PGX5ddj5kvIsWHBzBVBbkZzZ7VfSHZWuIrd8YQnthvo4SYS50O4r5QYnX+h0Cl
 ffWvzDwKCA6vC0AiiLTGBV/vPErPVrbf4dLkHGtT8TmysbAGpDUaYxab5q+n7SUeW6jC
 8tKcqgRQIQAIGAh7rWhie77R6nDXyEP6eCmcidTkDuE+jeKvrm16Kpc68vYZIo9egSOX
 CxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727090512; x=1727695312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEm6YOkcrV+96ZDfSXg4SU50pbZJe60mjhSLf5RNopM=;
 b=w3lL0Uxa6WKBwhKmKbCutq5nYPRnJkZwL8/K043nyA1AJUd2i217hOz53slbq3+WSf
 rIB6aweJlZeelEdPH8ivqEKrvxBiVkPVwHpZLRQuEe90xEjSZoSjbQ1qD9lMBRqLA6fF
 jBGyKDTS0u1YZ4TFw3NZJSyQ4wGySNQdVhtPTqyeamCulqsc1LIYzjvRmUJ4/rq6nQ4L
 rkpqh3t8oxL/fBQfxaC5hiMTIY8+E9jIab4I/6HwHK+BvbvWY45KL6UKo7QTDRnHV3XE
 Y792EGBt78XEnX6WljCffh36Hh/Y7EW9b+5DRLis9IkTcze5OAIKp7VXpqmMcQnh2qCu
 aW1w==
X-Gm-Message-State: AOJu0YwAB9GzTyHmK7lQ+JlSzcRQCGun46lT7GAPNS3cUGCJdiPTehr5
 XzPdaa93gS8StAUMl57lJXt26Y+kDS6YI2RVdWgj3QTzQzrMwtFvp/YShy++JWwNjvs6teeILQd
 0qVKU8K5Yo7ibmezxfid4l4NzITDWgXyHq2YuOYz4T2MuFQc=
X-Google-Smtp-Source: AGHT+IF19lxzuzVm/zEvqEG01G9XNxmnmZtjiUZmf+pXwnyB0pMjCIJwO2+WrWg68073BxnKIp43OWwuLkIsPQo2vwo=
X-Received: by 2002:a05:6a20:9f49:b0:1cc:bb1f:1d4 with SMTP id
 adf61e73a8af0-1d30a79aa35mr16692511637.0.1727090512265; Mon, 23 Sep 2024
 04:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240921164322.1883-1-me@nikitashushura.com>
 <20240921164322.1883-2-me@nikitashushura.com>
In-Reply-To: <20240921164322.1883-2-me@nikitashushura.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 23 Sep 2024 13:21:41 +0200
Message-ID: <CAJ307Ein29d3VLq65khY0kswSy7MH+0_ugd6yjzV5tMcvK4xJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/sparc/leon3: add second uart with extended
 interrupt usage
To: me@nikitashushura.com
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=chigot@adacore.com; helo=mail-pf1-x432.google.com
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

On Sat, Sep 21, 2024 at 6:43=E2=80=AFPM Nikita Shushura <me@nikitashushura.=
com> wrote:
>
> Signed-off-by: Nikita Shushura <me@nikitashushura.com>

Mostly OK just a few comments.

> ---
>  hw/sparc/leon3.c | 63 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 17 deletions(-)
>
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 6aaa04cb19..c559854e5e 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -54,10 +54,14 @@
>  #define LEON3_PROM_OFFSET    (0x00000000)
>  #define LEON3_RAM_OFFSET     (0x40000000)
>
> -#define MAX_CPUS  4
> +#define MAX_CPUS  (4)
> +#define LEON3_EIRQ (12)
>
> -#define LEON3_UART_OFFSET  (0x80000100)
> -#define LEON3_UART_IRQ     (3)
> +#define LEON3_UART0_OFFSET  (0x80000100)
> +#define LEON3_UART0_IRQ     (2)
> +
> +#define LEON3_UART1_OFFSET  (0x80100100)
> +#define LEON3_UART1_IRQ     (17)
>
>  #define LEON3_IRQMP_OFFSET (0x80000200)
>
> @@ -65,7 +69,8 @@
>  #define LEON3_TIMER_IRQ    (6)
>  #define LEON3_TIMER_COUNT  (2)
>
> -#define LEON3_APB_PNP_OFFSET (0x800FF000)
> +#define LEON3_APB1_PNP_OFFSET (0x800FF000)
> +#define LEON3_APB2_PNP_OFFSET (0x801FF000)
>  #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
>
>  typedef struct ResetData {
> @@ -122,7 +127,8 @@ static void write_bootloader(void *ptr, hwaddr kernel=
_addr)
>
>      /* Initialize the UARTs                                        */
>      /* *UART_CONTROL =3D UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
> -    p =3D gen_store_u32(p, 0x80000108, 3);
> +    p =3D gen_store_u32(p, LEON3_UART0_OFFSET + 0x8, 3);
> +    p =3D gen_store_u32(p, LEON3_UART1_OFFSET + 0x8, 3);
>
>      /* Initialize the TIMER 0                                      */
>      /* *GPTIMER_SCALER_RELOAD =3D 40 - 1;                            */
> @@ -271,7 +277,8 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>      DeviceState *dev, *irqmpdev;
>      int i;
>      AHBPnp *ahb_pnp;
> -    APBPnp *apb_pnp;
> +    APBPnp *apb1_pnp;
> +    APBPnp *apb2_pnp;
>
>      reset_info =3D g_malloc0(sizeof(ResetData));
>
> @@ -298,10 +305,19 @@ static void leon3_generic_hw_init(MachineState *mac=
hine)
>                              GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
>                              GRLIB_CPU_AREA);
>
> -    apb_pnp =3D GRLIB_APB_PNP(qdev_new(TYPE_GRLIB_APB_PNP));
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(apb_pnp), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
> -    grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
> +    /* Initialize APB1 */
> +    apb1_pnp =3D GRLIB_APB_PNP(qdev_new(TYPE_GRLIB_APB_PNP));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(apb1_pnp), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(apb1_pnp), 0, LEON3_APB1_PNP_OFFSET);
> +    grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB1_PNP_OFFSET, 0xFFF,
> +                            GRLIB_VENDOR_GAISLER, GRLIB_APBMST_DEV,
> +                            GRLIB_AHB_SLAVE, GRLIB_AHBMEM_AREA);
> +
> +    /* Initialize APB2 */
> +    apb2_pnp =3D GRLIB_APB_PNP(qdev_new(TYPE_GRLIB_APB_PNP));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(apb2_pnp), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(apb2_pnp), 0, LEON3_APB2_PNP_OFFSET);
> +    grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB2_PNP_OFFSET, 0xFFF,
>                              GRLIB_VENDOR_GAISLER, GRLIB_APBMST_DEV,
>                              GRLIB_AHB_SLAVE, GRLIB_AHBMEM_AREA);

You could embed that within a loop.

> @@ -309,6 +325,8 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>      irqmpdev =3D qdev_new(TYPE_GRLIB_IRQMP);
>      object_property_set_int(OBJECT(irqmpdev), "ncpus", machine->smp.cpus=
,
>                              &error_fatal);
> +    /*object_property_set_int(OBJECT(irqmpdev), "eirq", LEON3_EIRQ,*/
> +    /*                        &error_fatal);*/

Why is this commented ?

>      sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
>
>      for (i =3D 0; i < machine->smp.cpus; i++) {
> @@ -325,7 +343,7 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>      }
>
>      sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
> -    grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
> +    grlib_apb_pnp_add_entry(apb1_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
>                              GRLIB_VENDOR_GAISLER, GRLIB_IRQMP_DEV,
>                              2, 0, GRLIB_APBIO_AREA);
>
> @@ -417,20 +435,31 @@ static void leon3_generic_hw_init(MachineState *mac=
hine)
>                             qdev_get_gpio_in(irqmpdev, LEON3_TIMER_IRQ + =
i));
>      }
>
> -    grlib_apb_pnp_add_entry(apb_pnp, LEON3_TIMER_OFFSET, 0xFFF,
> +    grlib_apb_pnp_add_entry(apb1_pnp, LEON3_TIMER_OFFSET, 0xFFF,
>                              GRLIB_VENDOR_GAISLER, GRLIB_GPTIMER_DEV,
>                              0, LEON3_TIMER_IRQ, GRLIB_APBIO_AREA);
>
> -    /* Allocate uart */
> +    /* Allocate UART0 */
>      dev =3D qdev_new(TYPE_GRLIB_APB_UART);
>      qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART0_OFFSET);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                       qdev_get_gpio_in(irqmpdev, LEON3_UART0_IRQ));
> +    grlib_apb_pnp_add_entry(apb1_pnp, LEON3_UART0_OFFSET, 0xFFF,
> +                            GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1,
> +                            LEON3_UART0_IRQ, GRLIB_APBIO_AREA);
> +
> +    /* Allocate UART1 */
> +    dev =3D qdev_new(TYPE_GRLIB_APB_UART);
> +    qdev_prop_set_chr(dev, "chrdev", serial_hd(1));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART1_OFFSET);
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> -                       qdev_get_gpio_in(irqmpdev, LEON3_UART_IRQ));
> -    grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
> +                       qdev_get_gpio_in(irqmpdev, LEON3_UART1_IRQ));
> +    grlib_apb_pnp_add_entry(apb1_pnp, LEON3_UART1_OFFSET, 0xFFF,

Should this be apb2 here ?
Moreover, this is pretty similar to UART0. Thus, this would be better
to include within a loop with just a few adjustments for UART0. This
would also have the benefits to ease adding other UARTs, at some
point.


>                              GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1,
> -                            LEON3_UART_IRQ, GRLIB_APBIO_AREA);
> +                            LEON3_UART1_IRQ, GRLIB_APBIO_AREA);
>  }
>
>  static void leon3_generic_machine_init(MachineClass *mc)
> --
> 2.46.1
>
>


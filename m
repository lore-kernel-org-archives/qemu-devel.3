Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29D3C47258
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 00:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVKpT-00047Y-Ul; Wed, 31 Jan 2024 19:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKpP-00046o-72; Wed, 31 Jan 2024 19:21:15 -0500
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKpN-0006Lh-Gh; Wed, 31 Jan 2024 19:21:14 -0500
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-46b3df03e7cso157060137.0; 
 Wed, 31 Jan 2024 16:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706746872; x=1707351672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79Ttd3mOSUIyK4D+yE71u+2QVa52FBAjhkOyB7Wwheo=;
 b=Y5g6UMDY4FNnTALaM+GySRuZA0dkMdft27Kgqlb66+f9wUHuvtxTU0WH3U3jC/O7KM
 dccKXxe61HW2+5s+TvjPUBW2kzPsupGk8hA40EtOiwJfhFVX/OsymnmUcU32Yoy3G9GX
 O9tB3DCKDeNoQQi3HFZ2WTtWhTXTnqcyiQ/iCSSudljRkJxJ6eHApAtKWV1HhpmhHC1k
 y4Gq6tstL3tk1qPHjLXNVS5gnYyuoy/02zTUwWU2xbmpwlodBzOw3bmP3d7QUqxqtV6V
 K1wo/R9IEf0LPs/itg+FakH7quYCRFYtQUhBuVl5jcdAMaC6VhITfLx0T3xvsgfsRaq6
 PrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706746872; x=1707351672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79Ttd3mOSUIyK4D+yE71u+2QVa52FBAjhkOyB7Wwheo=;
 b=nG91y9YMncSSCG6+UkK8kl+fexLvXn3uIGDE/iSRESXfs9Bq22hqE4nPVtKyqySOke
 Iz8cqq6cUJfOwG1tpZoFVWm8/8L268HIREz+a6LgJehxAs/te4pV53lEUEnKJyQmdEZK
 GZ7wbOST9wr3Wfv1Z/9IEYV7m7NuQ4D1OekHK+ldf8dUw7hjtNDBRZzPlyuKjcEh+WPg
 CkAst4nkEoKI2hoyAcdO5liU5DfIr3Dp52x9lDCShPKyhAscqRv4GE6ukzag0eSz4RZ2
 1C2Uais2DhcvExNQfbZfHJugrHHVY8qzvB2xJVbyt5sHE2/ElRtWVHoEVjMaaSvjVSbH
 4isA==
X-Gm-Message-State: AOJu0Yz2tMSc7KtvvdqnSELmGtpCUqM7eJJK7DdW7McuMU7vC2sthaIh
 B3deg3KDvC4kZSCuJFHj6ZbxDQt63NJ4fx4VyyUFs8BS0hbkwiwGot5aTQ17r8+w4PKyWE9K5i9
 o0Qnvk5CeerTqRzXIh8gNAcnpMIvVfFgP
X-Google-Smtp-Source: AGHT+IG7fq2ZcCQFPaSwdA8XZ67XYyQgHVbWjNerOVyPH+aN0DLYjPSZCBxMuagoK+fSg3K7Q9e4HXrQOoafbYYGmpI=
X-Received: by 2002:a67:e8cd:0:b0:46b:22b4:a64e with SMTP id
 y13-20020a67e8cd000000b0046b22b4a64emr3114733vsn.11.1706746872107; Wed, 31
 Jan 2024 16:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20240130160656.113112-1-arnaud.minier@telecom-paris.fr>
 <20240130160656.113112-8-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240130160656.113112-8-arnaud.minier@telecom-paris.fr>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Feb 2024 10:20:46 +1000
Message-ID: <CAKmqyKPPUBr=zPrEwwHwZpWNPE_WToyE-ppHwKnRLcpJjc=Gww@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] STM32L4x5: Use the RCC Sysclk
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 3:21=E2=80=AFAM Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Now that we can generate reliable clock frequencies from the RCC, remove
> the hacky definition of the sysclk in the b_l475e_iot01a initialisation
> code and use the correct RCC clock.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/b-l475e-iot01a.c        | 10 +---------
>  hw/arm/stm32l4x5_soc.c         | 33 ++++-----------------------------
>  include/hw/arm/stm32l4x5_soc.h |  3 ---
>  3 files changed, 5 insertions(+), 41 deletions(-)
>
> diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
> index 6ecde2db15..d862aa43fc 100644
> --- a/hw/arm/b-l475e-iot01a.c
> +++ b/hw/arm/b-l475e-iot01a.c
> @@ -26,27 +26,19 @@
>  #include "qapi/error.h"
>  #include "hw/boards.h"
>  #include "hw/qdev-properties.h"
> -#include "hw/qdev-clock.h"
>  #include "qemu/error-report.h"
>  #include "hw/arm/stm32l4x5_soc.h"
>  #include "hw/arm/boot.h"
>
> -/* Main SYSCLK frequency in Hz (80MHz) */
> -#define MAIN_SYSCLK_FREQ_HZ 80000000ULL
> +/* B-L475E-IOT01A implementation is derived from netduinoplus2 */
>
>  static void b_l475e_iot01a_init(MachineState *machine)
>  {
>      const Stm32l4x5SocClass *sc;
>      DeviceState *dev;
> -    Clock *sysclk;
> -
> -    /* This clock doesn't need migration because it is fixed-frequency *=
/
> -    sysclk =3D clock_new(OBJECT(machine), "SYSCLK");
> -    clock_set_hz(sysclk, MAIN_SYSCLK_FREQ_HZ);
>
>      dev =3D qdev_new(TYPE_STM32L4X5XG_SOC);
>      object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
> -    qdev_connect_clock_in(dev, "sysclk", sysclk);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
>      sc =3D STM32L4X5_SOC_GET_CLASS(dev);
> diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
> index d5c04b446d..347a5377e5 100644
> --- a/hw/arm/stm32l4x5_soc.c
> +++ b/hw/arm/stm32l4x5_soc.c
> @@ -85,9 +85,6 @@ static void stm32l4x5_soc_initfn(Object *obj)
>      object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
>      object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SY=
SCFG);
>      object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32L4X5_RCC);
> -
> -    s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
> -    s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
>  }
>
>  static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
> @@ -99,30 +96,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc=
, Error **errp)
>      DeviceState *armv7m;
>      SysBusDevice *busdev;
>
> -    /*
> -     * We use s->refclk internally and only define it with qdev_init_clo=
ck_in()
> -     * so it is correctly parented and not leaked on an init/deinit; it =
is not
> -     * intended as an externally exposed clock.
> -     */
> -    if (clock_has_source(s->refclk)) {
> -        error_setg(errp, "refclk clock must not be wired up by the board=
 code");
> -        return;
> -    }
> -
> -    if (!clock_has_source(s->sysclk)) {
> -        error_setg(errp, "sysclk clock must be wired up by the board cod=
e");
> -        return;
> -    }
> -
> -    /*
> -     * TODO: ideally we should model the SoC RCC and its ability to
> -     * change the sysclk frequency and define different sysclk sources.
> -     */
> -
> -    /* The refclk always runs at frequency HCLK / 8 */
> -    clock_set_mul_div(s->refclk, 8, 1);
> -    clock_set_source(s->refclk, s->sysclk);
> -
>      if (!memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
>                                  sc->flash_size, errp)) {
>          return;
> @@ -152,8 +125,10 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
>      qdev_prop_set_uint32(armv7m, "num-prio-bits", 4);
>      qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m=
4"));
>      qdev_prop_set_bit(armv7m, "enable-bitband", true);
> -    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
> -    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
> +    qdev_connect_clock_in(armv7m, "cpuclk",
> +        qdev_get_clock_out(DEVICE(&(s->rcc)), "cortex-fclk-out"));
> +    qdev_connect_clock_in(armv7m, "refclk",
> +        qdev_get_clock_out(DEVICE(&(s->rcc)), "cortex-refclk-out"));
>      object_property_set_link(OBJECT(&s->armv7m), "memory",
>                               OBJECT(system_memory), &error_abort);
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
> diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
> index e480fcc976..1f71298b45 100644
> --- a/include/hw/arm/stm32l4x5_soc.h
> +++ b/include/hw/arm/stm32l4x5_soc.h
> @@ -50,9 +50,6 @@ struct Stm32l4x5SocState {
>      MemoryRegion sram2;
>      MemoryRegion flash;
>      MemoryRegion flash_alias;
> -
> -    Clock *sysclk;
> -    Clock *refclk;
>  };
>
>  struct Stm32l4x5SocClass {
> --
> 2.34.1
>
>


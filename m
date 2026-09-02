Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71698C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1iAL-0006tj-M2; Wed, 02 Sep 2026 06:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1iA8-0006sB-FD
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:25:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1iA3-0007ke-Jv
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:25:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-482e067e908so800756f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788344737; x=1788949537; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ffBTpLGG+jmedZEiqbsmZCBB7bqoWValss6FtSJuQ8I=;
 b=OCftSDWKB2PQjH8ePnHFkl051jlxweCqD7fZlcwWPyw4/uDRYSywQszG4wwm7TA0Z4
 SZyO8eOFQmbi+wyqYhw9riOnt0cieLy95m+7jG5dhud7ARQYKXxurSNSOu3rYLq/5E+8
 y1VM3GUdfk99mOZbMF0OPmossUR25RKqMThvRKB23RIrPvpO+UGbBSEfRHRdRXv624ZE
 L+J174oDpaFhLovYHlt1m09aJYAjU2oxKxGj6jgw1SiG63jBwemqajfumxAAR52M5Dce
 ZsUCcQ80qFYeVcj9c/6AxOkPZ+f3BtRoRiIajfro+PSUM4T0mmWLir0/Vdv7CdEkDwqj
 GQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788344737; x=1788949537;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ffBTpLGG+jmedZEiqbsmZCBB7bqoWValss6FtSJuQ8I=;
 b=nYlR4ImUi0JjwZz0AU1Xl09/LqIHzggCwZaa/R3+HRVzhwDfCLZSlx2vC//JUytQIU
 GayOdcuR8avc4uhzeTknpneyEDfFklcK15VLaG6AcvICod0B/yfa0t8ixtri6/8/c/Q8
 Z9wY7BV1B3yrH1iC1d+2OPsMKbfBDzz7RZ+zMO0yHgEaChZjTFs8bawoY0O4U9me1tZy
 A7EwP1nO8Vu8UKLTifJQ9pWplrLXxyowW8/DKG8nOnTq6BSLYFbswIwMzbYNq0dsKS7I
 wVH6Jgg6ICdjC85cQY2KtyG8k0AOEjDkdnDNaREIGxV9ugUjgBEs9trBywUU0mke4yhZ
 mGpA==
X-Gm-Message-State: AFuF++mjHeknYOErWQ3utYXFh7958vU5l1qtzAsKlUfeHR/XFOW0b82l
 oL+NBYxDTxTn4a3iHS6gMhJEuQOdxiMS3/gIzFLkv0Fe54sJp8LaISN70uIv/A9VrUY=
X-Gm-Gg: AYBFou149O2Sn1l16rG7XNVV3DzCmiXwcQx7xB73ziriIFu+PAuZzrGh+efBiN9mjP5
 1J7fwexj/RD6NpUAqw9qN6soArvbX0RsZU97AVtiVf6ez4iw9H9AWNDiCdpFPbylpD14imyVxEC
 ZvSb8RGT4rDOZxBtdn4KK9q4ZQ5Yzmh52VyEsDHBgK8MOipw5CCbydGHaUbJwQMfSL+a0pKuVq+
 vT5I+Fd9SiGHtYCdBS1ZTmheC+tfFABFPGm5r/oESXSLiwF3Rw1X+I1iAC5SOLR5P/8mKpznEUA
 b3Kd7uu7czTjRn5Fv600xxN4BaQF4cYtDQsCYulR0IbjlzPem+QXx5if3HPjBKB0gQIMRUe9ejS
 C8+KzCYz+NMxAeevX/rZLPGeIeFG8mcojz7Yxoxm/u864fqD0INzeUF3KjBggyjX76rs0zB+hkf
 lx+z6IArw/6bJ9Fiy7VPiN6ycxLeSm4fQgvvFSphYLErsrZSiPdf5j4pEg/tZM
X-Received: by 2002:a05:6000:260a:b0:482:ea99:6166 with SMTP id
 ffacd0b85a97d-48488df7809mr7096223f8f.7.1788344736737; 
 Wed, 02 Sep 2026 03:25:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e800cfsm5253035f8f.12.2026.09.02.03.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 03:25:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 796D15F85F;
 Wed, 02 Sep 2026 11:25:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Fabiano Rosas
 <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH RFC v2 08/30] hw/misc: add RP2040 crystal and ring
 oscillators
In-Reply-To: <20260829234308.33725-9-gilles.grimaud@univ-lille.fr> (Gilles
 Grimaud's message of "Sun, 30 Aug 2026 01:42:42 +0200")
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-9-gilles.grimaud@univ-lille.fr>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 02 Sep 2026 11:25:34 +0100
Message-ID: <875x0orlup.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Gilles Grimaud <gilles.grimaud@univ-lille.fr> writes:

> From: gilles grimaud <gilles.grimaud@univ-lille.fr>
>
> Model the RP2040 XOSC and ROSC register blocks and expose their clock out=
puts. Use virtual time for the ROSC COUNT register and provide either QEMU =
guest entropy or a machine-selectable deterministic seed for RANDOMBIT. Add=
 qtests for the ROSC register behavior and deterministic stream.
>
> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  hw/arm/Kconfig                 |   2 +
>  hw/arm/raspi_pico.c            |  56 +++++
>  hw/arm/rp2040.c                |  14 +-
>  hw/misc/Kconfig                |   6 +
>  hw/misc/meson.build            |   2 +
>  hw/misc/rp2040_rosc.c          | 430 +++++++++++++++++++++++++++++++++
>  hw/misc/rp2040_xosc.c          | 237 ++++++++++++++++++
>  include/hw/arm/rp2040.h        |   4 +
>  include/hw/misc/rp2040_rosc.h  |  42 ++++
>  include/hw/misc/rp2040_xosc.h  |  33 +++
>  tests/qtest/meson.build        |   1 +
>  tests/qtest/rp2040-rosc-test.c | 146 +++++++++++
>  12 files changed, 971 insertions(+), 2 deletions(-)
>  create mode 100644 hw/misc/rp2040_rosc.c
>  create mode 100644 hw/misc/rp2040_xosc.c
>  create mode 100644 include/hw/misc/rp2040_rosc.h
>  create mode 100644 include/hw/misc/rp2040_xosc.h
>  create mode 100644 tests/qtest/rp2040-rosc-test.c
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 89c479ab6d..b55a75fd5a 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -379,10 +379,12 @@ config RP2040
>      select ARM_V7M
>      select PL011
>      select RP2040_NYI
> +    select RP2040_ROSC
>      select RP2040_SYSCFG
>      select RP2040_SYSINFO
>      select RP2040_TBMAN
>      select RP2040_VREG
> +    select RP2040_XOSC
>      select UNIMP
>=20=20
>  config STM32F100_SOC
> diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
> index 2bb7d4e511..2a65176dc6 100644
> --- a/hw/arm/raspi_pico.c
> +++ b/hw/arm/raspi_pico.c
> @@ -14,6 +14,7 @@
>  #include "hw/arm/rp2040.h"
>  #include "hw/core/boards.h"
>  #include "hw/core/qdev-properties.h"
> +#include "qemu/cutils.h"
>  #include "system/address-spaces.h"
>  #include "system/system.h"
>  #include "qom/object.h"
> @@ -28,8 +29,43 @@ struct RaspiPicoMachineState {
>=20=20
>      RP2040State soc;
>      MemoryRegion flash;
> +    char *rosc_random_seed;
> +    uint64_t rosc_random_seed_value;
> +    bool rosc_random_seed_set;
>  };
>=20=20
> +static char *raspi_pico_get_rosc_random_seed(Object *obj, Error **errp)
> +{
> +    RaspiPicoMachineState *s =3D RASPI_PICO_MACHINE(obj);
> +
> +    return g_strdup(s->rosc_random_seed ?: "");
> +}
> +
> +static void raspi_pico_set_rosc_random_seed(Object *obj, const char *val=
ue,
> +                                            Error **errp)
> +{
> +    RaspiPicoMachineState *s =3D RASPI_PICO_MACHINE(obj);
> +    uint64_t seed;
> +
> +    if (!value || !*value) {
> +        g_free(s->rosc_random_seed);
> +        s->rosc_random_seed =3D NULL;
> +        s->rosc_random_seed_value =3D 0;
> +        s->rosc_random_seed_set =3D false;
> +        return;
> +    }
> +
> +    if (qemu_strtou64(value, NULL, 0, &seed) < 0) {
> +        error_setg(errp, "invalid ROSC random seed '%s'", value);
> +        return;
> +    }
> +
> +    g_free(s->rosc_random_seed);
> +    s->rosc_random_seed =3D g_strdup(value);

Why do you need to keep the string if it is simply a representation of a
uint64_t?

> +    s->rosc_random_seed_value =3D seed;
> +    s->rosc_random_seed_set =3D true;

This never gets looked at.

> +}
> +
>  static void raspi_pico_init(MachineState *machine)
>  {
>      RaspiPicoMachineState *s =3D RASPI_PICO_MACHINE(machine);
> @@ -38,6 +74,10 @@ static void raspi_pico_init(MachineState *machine)
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RP2040=
);
>      qdev_prop_set_chr(DEVICE(&s->soc), "serial0", serial_hd(0));
>      qdev_prop_set_chr(DEVICE(&s->soc), "serial1", serial_hd(1));
> +    qdev_prop_set_uint64(DEVICE(&s->soc.rosc), "random-seed",
> +                         s->rosc_random_seed_value);
> +    qdev_prop_set_bit(DEVICE(&s->soc.rosc), "random-seed-set",
> +                      s->rosc_random_seed_set);
>      if (machine->firmware) {
>          qdev_prop_set_string(DEVICE(&s->soc), "bootrom-file",
>                               machine->firmware);
> @@ -55,6 +95,13 @@ static void raspi_pico_init(MachineState *machine)
>                         RP2040_XIP_BASE, PICO_FLASH_SIZE);
>  }
>=20=20
> +static void raspi_pico_machine_finalize(Object *obj)
> +{
> +    RaspiPicoMachineState *s =3D RASPI_PICO_MACHINE(obj);
> +
> +    g_free(s->rosc_random_seed);
> +}
> +
>  static void raspi_pico_machine_class_init(ObjectClass *oc, const void *d=
ata)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -68,6 +115,14 @@ static void raspi_pico_machine_class_init(ObjectClass=
 *oc, const void *data)
>      mc->no_parallel =3D 1;
>      mc->no_floppy =3D 1;
>      mc->no_cdrom =3D 1;
> +
> +    object_class_property_add_str(oc, "rosc-random-seed",
> +                                  raspi_pico_get_rosc_random_seed,
> +                                  raspi_pico_set_rosc_random_seed);
> +    object_class_property_set_description(oc, "rosc-random-seed",
> +                                          "Use a deterministic seed for =
the "
> +                                          "ROSC RANDOMBIT stream; if uns=
et, "
> +                                          "QEMU guest entropy is used");
>  }
>=20=20
>  static const TypeInfo raspi_pico_machine_info =3D {
> @@ -75,6 +130,7 @@ static const TypeInfo raspi_pico_machine_info =3D {
>      .parent =3D TYPE_MACHINE,
>      .instance_size =3D sizeof(RaspiPicoMachineState),
>      .class_init =3D raspi_pico_machine_class_init,
> +    .instance_finalize =3D raspi_pico_machine_finalize,
>      .interfaces =3D arm_machine_interfaces,
>  };
>=20=20
> diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
> index f2a6613aa3..889decded0 100644
> --- a/hw/arm/rp2040.c
> +++ b/hw/arm/rp2040.c
> @@ -57,7 +57,6 @@ static const struct {
>      { "rp2040.ioqspi",   0x40018000, 0x4000 },
>      { "rp2040.padsbank0", 0x4001c000, 0x4000 },
>      { "rp2040.padsqspi", 0x40020000, 0x4000 },
> -    { "rp2040.xosc",     0x40024000, 0x4000 },
>      { "rp2040.pll_sys",  0x40028000, 0x4000 },
>      { "rp2040.pll_usb",  0x4002c000, 0x4000 },
>      { "rp2040.busctrl",  0x40030000, 0x4000 },
> @@ -72,7 +71,6 @@ static const struct {
>      { "rp2040.timer",    0x40054000, 0x4000 },
>      { "rp2040.watchdog", 0x40058000, 0x4000 },
>      { "rp2040.rtc",      0x4005c000, 0x4000 },
> -    { "rp2040.rosc",     0x40060000, 0x4000 },
>      { "rp2040.dma",      0x50000000, 0x1000 },
>      { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
>      { "rp2040.usbctrl_regs",  0x50110000, 0x10000 },
> @@ -177,8 +175,10 @@ static void rp2040_soc_init(Object *obj)
>=20=20
>      object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCF=
G);
>      object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYS=
INFO);
> +    object_initialize_child(obj, "rosc", &s->rosc, TYPE_RP2040_ROSC);
>      object_initialize_child(obj, "tbman", &s->tbman, TYPE_RP2040_TBMAN);
>      object_initialize_child(obj, "vreg", &s->vreg, TYPE_RP2040_VREG);
> +    object_initialize_child(obj, "xosc", &s->xosc, TYPE_RP2040_XOSC);
>=20=20
>      s->irq =3D qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
>      s->sysclk =3D clock_new(obj, "sysclk");
> @@ -325,6 +325,11 @@ static void rp2040_soc_realize(DeviceState *dev, Err=
or **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, RP2040_SYSINFO_BASE);
>      rp2040_syscfg_update(s);
>=20=20
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rosc), errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rosc), 0, RP2040_ROSC_BASE);
> +
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->tbman), errp)) {
>          return;
>      }
> @@ -335,6 +340,11 @@ static void rp2040_soc_realize(DeviceState *dev, Err=
or **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->vreg), 0, RP2040_VREG_BASE);
>=20=20
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xosc), errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xosc), 0, RP2040_XOSC_BASE);
> +
>      for (i =3D 0; i < ARRAY_SIZE(s->uart); i++) {
>          qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
>          if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 597559186f..8f0860139f 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -104,6 +104,9 @@ config FSL_IMX8MP_CCM
>  config RP2040_NYI
>      bool
>=20=20
> +config RP2040_ROSC
> +    bool
> +
>  config RP2040_SYSCFG
>      bool
>=20=20
> @@ -116,6 +119,9 @@ config RP2040_TBMAN
>  config RP2040_VREG
>      bool
>=20=20
> +config RP2040_XOSC
> +    bool
> +
>  config STM32_RCC
>      bool
>=20=20
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 9191b16360..7ad307beee 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -99,10 +99,12 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>    'bcm2835_powermgt.c',
>  ))
>  system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
> +system_ss.add(when: 'CONFIG_RP2040_ROSC', if_true: files('rp2040_rosc.c'=
))
>  system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: files('rp2040_syscf=
g.c'))
>  system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: files('rp2040_sysi=
nfo.c'))
>  system_ss.add(when: 'CONFIG_RP2040_TBMAN', if_true: files('rp2040_tbman.=
c'))
>  system_ss.add(when: 'CONFIG_RP2040_VREG', if_true: files('rp2040_vreg.c'=
))
> +system_ss.add(when: 'CONFIG_RP2040_XOSC', if_true: files('rp2040_xosc.c'=
))
>  system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>  system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
>  system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-d=
drc.c'))
> diff --git a/hw/misc/rp2040_rosc.c b/hw/misc/rp2040_rosc.c
> new file mode 100644
> index 0000000000..dcb340ec57
> --- /dev/null
> +++ b/hw/misc/rp2040_rosc.c
> @@ -0,0 +1,430 @@
> +/*
> + * RP2040 ring oscillator emulation
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/misc/rp2040_nyi.h"
> +#include "hw/misc/rp2040_rosc.h"
> +#include "migration/vmstate.h"
> +#include "qemu/guest-random.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/timer.h"
> +
> +#define ROSC_NOMINAL_HZ        6500000
> +
> +#define ROSC_CTRL              0x00
> +#define ROSC_FREQA             0x04
> +#define ROSC_FREQB             0x08
> +#define ROSC_DORMANT           0x0c
> +#define ROSC_DIV               0x10
> +#define ROSC_PHASE             0x14
> +#define ROSC_STATUS            0x18
> +#define ROSC_RANDOMBIT         0x1c
> +#define ROSC_COUNT             0x20
> +
> +#define ROSC_ENABLE_DISABLE    0xd1e
> +#define ROSC_ENABLE_ENABLE     0xfab
> +#define ROSC_FREQ_RANGE_LOW    0xfa4
> +#define ROSC_FREQ_RANGE_MEDIUM 0xfa5
> +#define ROSC_FREQ_RANGE_HIGH   0xfa7
> +#define ROSC_FREQ_RANGE_TOOHIGH 0xfa6
> +#define ROSC_DORMANT_VALUE     0x636f6d61
> +#define ROSC_WAKE_VALUE        0x77616b65
> +#define ROSC_FREQ_PASSWD       0x9696
> +#define ROSC_DIV_PASS          0xaa0
> +#define ROSC_PHASE_PASSWD      0xaa
> +
> +#define ROSC_STATUS_STABLE     BIT(31)
> +#define ROSC_STATUS_BADWRITE   BIT(24)
> +#define ROSC_STATUS_DIV_RUNNING BIT(16)
> +#define ROSC_STATUS_ENABLED    BIT(12)
> +
> +#define ATOMIC_ALIAS_MASK      0x3000
> +#define ATOMIC_XOR             0x1000
> +#define ATOMIC_SET             0x2000
> +#define ATOMIC_CLR             0x3000
> +
> +static uint32_t rp2040_rosc_apply_alias(uint32_t old, uint32_t value,
> +                                        hwaddr alias)
> +{
> +    switch (alias) {
> +    case ATOMIC_XOR:
> +        return old ^ value;
> +    case ATOMIC_SET:
> +        return old | value;
> +    case ATOMIC_CLR:
> +        return old & ~value;
> +    default:
> +        return value;
> +    }
> +}
> +
> +static bool rp2040_rosc_valid_range(uint32_t range)
> +{
> +    return range =3D=3D ROSC_FREQ_RANGE_LOW || range =3D=3D ROSC_FREQ_RA=
NGE_MEDIUM ||
> +           range =3D=3D ROSC_FREQ_RANGE_HIGH || range =3D=3D ROSC_FREQ_R=
ANGE_TOOHIGH;
> +}
> +
> +static bool rp2040_rosc_enabled(RP2040RoscState *s)
> +{
> +    return extract32(s->ctrl, 12, 12) !=3D ROSC_ENABLE_DISABLE;
> +}
> +
> +static bool rp2040_rosc_running(RP2040RoscState *s)
> +{
> +    return rp2040_rosc_enabled(s) && s->dormant =3D=3D ROSC_WAKE_VALUE;
> +}
> +
> +static uint32_t rp2040_rosc_divisor(RP2040RoscState *s)
> +{
> +    uint32_t encoded =3D s->div & 0xfff;
> +    uint32_t div;
> +
> +    if (encoded < ROSC_DIV_PASS) {
> +        return 31;
> +    }
> +
> +    div =3D encoded - ROSC_DIV_PASS;
> +    if (div =3D=3D 0) {
> +        return 32;
> +    }
> +    if (div > 31) {
> +        return 31;
> +    }
> +    return div;
> +}
> +
> +static uint32_t rp2040_rosc_hz(RP2040RoscState *s)
> +{
> +    if (!rp2040_rosc_running(s)) {
> +        return 0;
> +    }
> +
> +    return ROSC_NOMINAL_HZ / rp2040_rosc_divisor(s);
> +}
> +
> +static void rp2040_rosc_update_clock(RP2040RoscState *s)
> +{
> +    clock_update_hz(s->clk, rp2040_rosc_hz(s));
> +}
> +
> +static uint32_t rp2040_rosc_count_read(RP2040RoscState *s)
> +{
> +    uint64_t elapsed_ns;
> +    uint64_t elapsed_ticks;
> +
> +    if (!s->count || !rp2040_rosc_running(s)) {
> +        return s->count;
> +    }
> +
> +    elapsed_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->count_star=
t_ns;
> +    elapsed_ticks =3D elapsed_ns * ROSC_NOMINAL_HZ / NANOSECONDS_PER_SEC=
OND;
> +    if (elapsed_ticks >=3D s->count) {
> +        s->count =3D 0;
> +    } else {
> +        s->count -=3D elapsed_ticks;
> +        s->count_start_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    }
> +
> +    return s->count;
> +}
> +
> +static uint32_t rp2040_rosc_status(RP2040RoscState *s)
> +{
> +    uint32_t value =3D 0;
> +
> +    if (rp2040_rosc_enabled(s)) {
> +        value |=3D ROSC_STATUS_ENABLED;
> +        if (s->dormant =3D=3D ROSC_WAKE_VALUE) {
> +            value |=3D ROSC_STATUS_STABLE | ROSC_STATUS_DIV_RUNNING;
> +        }
> +    }
> +    if (s->badwrite) {
> +        value |=3D ROSC_STATUS_BADWRITE;
> +    }
> +
> +    return value;
> +}
> +
> +static uint32_t rp2040_rosc_random_bit(RP2040RoscState *s)
> +{
> +    uint64_t x;
> +    uint32_t bit;
> +
> +    if (!rp2040_rosc_running(s)) {
> +        return 0;
> +    }
> +
> +    if (!s->random_seed_set) {
> +        if (!s->random_pool_bits) {
> +            qemu_guest_getrandom_nofail(&s->random_pool,
> +                                        sizeof(s->random_pool));
> +            s->random_pool_bits =3D 64;
> +        }
> +
> +        bit =3D s->random_pool & 1;
> +        s->random_pool >>=3D 1;
> +        s->random_pool_bits--;
> +        return bit;
> +    }
> +
> +    x =3D s->random_prng_state;
> +    x ^=3D x >> 12;
> +    x ^=3D x << 25;
> +    x ^=3D x >> 27;
> +    s->random_prng_state =3D x;
> +    return (x * 0x2545f4914f6cdd1dull) >> 63;
> +}
> +
> +static uint64_t rp2040_rosc_read(void *opaque, hwaddr addr, unsigned siz=
e)
> +{
> +    RP2040RoscState *s =3D opaque;
> +    hwaddr offset =3D addr & 0xfff;
> +    uint64_t value;
> +
> +    switch (offset) {
> +    case ROSC_CTRL:
> +        value =3D s->ctrl;
> +        break;
> +    case ROSC_FREQA:
> +        value =3D s->freqa;
> +        break;
> +    case ROSC_FREQB:
> +        value =3D s->freqb;
> +        break;
> +    case ROSC_DORMANT:
> +        value =3D s->dormant;
> +        break;
> +    case ROSC_DIV:
> +        value =3D s->div;
> +        break;
> +    case ROSC_PHASE:
> +        value =3D s->phase;
> +        break;
> +    case ROSC_STATUS:
> +        value =3D rp2040_rosc_status(s);
> +        break;
> +    case ROSC_RANDOMBIT:
> +        value =3D rp2040_rosc_random_bit(s);
> +        break;
> +    case ROSC_COUNT:
> +        value =3D rp2040_rosc_count_read(s);
> +        break;
> +    default:
> +        value =3D 0;
> +        rp2040_log_unimplemented_read("rosc", size,
> +                                      RP2040_ROSC_BASE + addr, offset,
> +                                      value);
> +        break;
> +    }
> +
> +    return value;
> +}
> +
> +static void rp2040_rosc_write_ctrl(RP2040RoscState *s, uint32_t value)
> +{
> +    uint32_t enable =3D extract32(value, 12, 12);
> +    uint32_t range =3D extract32(value, 0, 12);
> +
> +    if (enable !=3D ROSC_ENABLE_DISABLE && enable !=3D ROSC_ENABLE_ENABL=
E) {
> +        s->badwrite =3D true;
> +        value =3D deposit32(value, 12, 12, ROSC_ENABLE_ENABLE);
> +    }
> +    if (!rp2040_rosc_valid_range(range)) {
> +        s->badwrite =3D true;
> +        value =3D deposit32(value, 0, 12, ROSC_FREQ_RANGE_LOW);
> +    }
> +
> +    s->ctrl =3D value & 0x00ffffff;
> +    rp2040_rosc_update_clock(s);
> +}
> +
> +static void rp2040_rosc_write_freq(RP2040RoscState *s, uint32_t *reg,
> +                                   uint32_t value)
> +{
> +    if (extract32(value, 16, 16) !=3D ROSC_FREQ_PASSWD) {
> +        s->badwrite =3D true;
> +        *reg =3D 0;
> +        return;
> +    }
> +
> +    *reg =3D value & 0x96967777;
> +}
> +
> +static void rp2040_rosc_write_div(RP2040RoscState *s, uint32_t value)
> +{
> +    if ((value & 0xfff) < ROSC_DIV_PASS) {
> +        s->badwrite =3D true;
> +        value =3D ROSC_DIV_PASS + 31;
> +    }
> +
> +    s->div =3D value & 0xfff;
> +    rp2040_rosc_update_clock(s);
> +}
> +
> +static void rp2040_rosc_write_phase(RP2040RoscState *s, uint32_t value)
> +{
> +    if (extract32(value, 4, 8) !=3D ROSC_PHASE_PASSWD) {
> +        s->badwrite =3D true;
> +        value =3D 0;
> +    }
> +
> +    s->phase =3D value & 0x00000fff;
> +}
> +
> +static void rp2040_rosc_write(void *opaque, hwaddr addr,
> +                              uint64_t value64, unsigned size)
> +{
> +    RP2040RoscState *s =3D opaque;
> +    hwaddr alias =3D addr & ATOMIC_ALIAS_MASK;
> +    hwaddr offset =3D addr & 0xfff;
> +    uint32_t value =3D value64;
> +
> +    switch (offset) {
> +    case ROSC_CTRL:
> +        rp2040_rosc_write_ctrl(s, rp2040_rosc_apply_alias(s->ctrl, value,
> +                                                          alias));
> +        break;
> +    case ROSC_FREQA:
> +        rp2040_rosc_write_freq(s, &s->freqa,
> +                               rp2040_rosc_apply_alias(s->freqa, value,
> +                                                       alias));
> +        break;
> +    case ROSC_FREQB:
> +        rp2040_rosc_write_freq(s, &s->freqb,
> +                               rp2040_rosc_apply_alias(s->freqb, value,
> +                                                       alias));
> +        break;
> +    case ROSC_DORMANT:
> +        s->dormant =3D value =3D=3D ROSC_DORMANT_VALUE ? value : ROSC_WA=
KE_VALUE;
> +        if (value !=3D ROSC_DORMANT_VALUE && value !=3D ROSC_WAKE_VALUE)=
 {
> +            s->badwrite =3D true;
> +        }
> +        rp2040_rosc_update_clock(s);
> +        break;
> +    case ROSC_DIV:
> +        rp2040_rosc_write_div(s, rp2040_rosc_apply_alias(s->div, value,
> +                                                         alias));
> +        break;
> +    case ROSC_PHASE:
> +        rp2040_rosc_write_phase(s, rp2040_rosc_apply_alias(s->phase, val=
ue,
> +                                                           alias));
> +        break;
> +    case ROSC_STATUS:
> +        if (value & ROSC_STATUS_BADWRITE) {
> +            s->badwrite =3D false;
> +        }
> +        break;
> +    case ROSC_COUNT:
> +        s->count =3D value & 0xff;
> +        s->count_start_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        break;
> +    default:
> +        rp2040_log_unimplemented_write("rosc", size,
> +                                       RP2040_ROSC_BASE + addr, offset,
> +                                       value64);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps rp2040_rosc_ops =3D {
> +    .read =3D rp2040_rosc_read,
> +    .write =3D rp2040_rosc_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void rp2040_rosc_reset(DeviceState *dev)
> +{
> +    RP2040RoscState *s =3D RP2040_ROSC(dev);
> +
> +    s->ctrl =3D (ROSC_ENABLE_ENABLE << 12) | ROSC_FREQ_RANGE_LOW;
> +    s->freqa =3D 0;
> +    s->freqb =3D 0;
> +    s->dormant =3D ROSC_WAKE_VALUE;
> +    s->div =3D ROSC_DIV_PASS + 16;
> +    s->phase =3D 0x00000aa8;
> +    s->count =3D 0;
> +    s->count_start_ns =3D 0;
> +    s->random_pool =3D 0;
> +    s->random_pool_bits =3D 0;
> +    s->random_prng_state =3D s->random_seed;
> +    if (!s->random_prng_state) {
> +        s->random_prng_state =3D 0x9e3779b97f4a7c15ull;
> +    }
> +    s->badwrite =3D false;
> +
> +    rp2040_rosc_update_clock(s);
> +}
> +
> +static void rp2040_rosc_init(Object *obj)
> +{
> +    RP2040RoscState *s =3D RP2040_ROSC(obj);
> +    DeviceState *dev =3D DEVICE(obj);
> +
> +    s->clk =3D qdev_init_clock_out(dev, "clk");
> +    memory_region_init_io(&s->iomem, obj, &rp2040_rosc_ops, s,
> +                          "rp2040.rosc", RP2040_ROSC_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +}
> +
> +static const VMStateDescription rp2040_rosc_vmstate =3D {
> +    .name =3D TYPE_RP2040_ROSC,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT32(ctrl, RP2040RoscState),
> +        VMSTATE_UINT32(freqa, RP2040RoscState),
> +        VMSTATE_UINT32(freqb, RP2040RoscState),
> +        VMSTATE_UINT32(dormant, RP2040RoscState),
> +        VMSTATE_UINT32(div, RP2040RoscState),
> +        VMSTATE_UINT32(phase, RP2040RoscState),
> +        VMSTATE_UINT32(count, RP2040RoscState),
> +        VMSTATE_INT64(count_start_ns, RP2040RoscState),
> +        VMSTATE_UINT64(random_pool, RP2040RoscState),
> +        VMSTATE_UINT64(random_prng_state, RP2040RoscState),
> +        VMSTATE_UINT64(random_seed, RP2040RoscState),
> +        VMSTATE_UINT8(random_pool_bits, RP2040RoscState),
> +        VMSTATE_BOOL(random_seed_set, RP2040RoscState),
> +        VMSTATE_BOOL(badwrite, RP2040RoscState),
> +        VMSTATE_CLOCK(clk, RP2040RoscState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const Property rp2040_rosc_properties[] =3D {
> +    DEFINE_PROP_UINT64("random-seed", RP2040RoscState, random_seed, 0),
> +    DEFINE_PROP_BOOL("random-seed-set", RP2040RoscState, random_seed_set,
> +                     false),
> +};
> +
> +static void rp2040_rosc_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    device_class_set_legacy_reset(dc, rp2040_rosc_reset);
> +    dc->vmsd =3D &rp2040_rosc_vmstate;
> +    device_class_set_props(dc, rp2040_rosc_properties);
> +}
> +
> +static const TypeInfo rp2040_rosc_info =3D {
> +    .name          =3D TYPE_RP2040_ROSC,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RP2040RoscState),
> +    .instance_init =3D rp2040_rosc_init,
> +    .class_init    =3D rp2040_rosc_class_init,
> +};
> +
> +static void rp2040_rosc_register_types(void)
> +{
> +    type_register_static(&rp2040_rosc_info);
> +}
> +type_init(rp2040_rosc_register_types)
> diff --git a/hw/misc/rp2040_xosc.c b/hw/misc/rp2040_xosc.c
> new file mode 100644
> index 0000000000..a8340ca0c9
> --- /dev/null
> +++ b/hw/misc/rp2040_xosc.c
> @@ -0,0 +1,237 @@
> +/*
> + * RP2040 crystal oscillator emulation
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/misc/rp2040_nyi.h"
> +#include "hw/misc/rp2040_xosc.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +#define XOSC_HZ             12000000
> +
> +#define XOSC_CTRL           0x00
> +#define XOSC_STATUS         0x04
> +#define XOSC_DORMANT        0x08
> +#define XOSC_STARTUP        0x0c
> +#define XOSC_COUNT          0x1c
> +
> +#define XOSC_ENABLE_DISABLE 0xd1e
> +#define XOSC_ENABLE_ENABLE  0xfab
> +#define XOSC_FREQ_1_15MHZ   0xaa0
> +#define XOSC_DORMANT_VALUE  0x636f6d61
> +#define XOSC_WAKE_VALUE     0x77616b65
> +
> +#define XOSC_STATUS_STABLE  BIT(31)
> +#define XOSC_STATUS_BADWRITE BIT(24)
> +#define XOSC_STATUS_ENABLED BIT(12)
> +
> +#define ATOMIC_ALIAS_MASK    0x3000
> +#define ATOMIC_XOR           0x1000
> +#define ATOMIC_SET           0x2000
> +#define ATOMIC_CLR           0x3000
> +
> +static bool rp2040_xosc_enabled(RP2040XoscState *s)
> +{
> +    return extract32(s->ctrl, 12, 12) !=3D XOSC_ENABLE_DISABLE;
> +}
> +
> +static void rp2040_xosc_update_clock(RP2040XoscState *s)
> +{
> +    clock_update_hz(s->clk, rp2040_xosc_enabled(s) ? XOSC_HZ : 0);
> +}
> +
> +static uint32_t rp2040_xosc_status(RP2040XoscState *s)
> +{
> +    uint32_t value =3D 0;
> +
> +    if (rp2040_xosc_enabled(s)) {
> +        value |=3D XOSC_STATUS_ENABLED;
> +        if (s->dormant =3D=3D XOSC_WAKE_VALUE) {
> +            value |=3D XOSC_STATUS_STABLE;
> +        }
> +    }
> +    if (s->badwrite) {
> +        value |=3D XOSC_STATUS_BADWRITE;
> +    }
> +
> +    return value;
> +}
> +
> +static uint64_t rp2040_xosc_read(void *opaque, hwaddr addr, unsigned siz=
e)
> +{
> +    RP2040XoscState *s =3D opaque;
> +    hwaddr offset =3D addr & 0xfff;
> +    uint64_t value;
> +
> +    switch (offset) {
> +    case XOSC_CTRL:
> +        value =3D s->ctrl;
> +        break;
> +    case XOSC_STATUS:
> +        value =3D rp2040_xosc_status(s);
> +        break;
> +    case XOSC_DORMANT:
> +        value =3D s->dormant;
> +        break;
> +    case XOSC_STARTUP:
> +        value =3D s->startup;
> +        break;
> +    case XOSC_COUNT:
> +        value =3D 0;
> +        break;
> +    default:
> +        value =3D 0;
> +        rp2040_log_unimplemented_read("xosc", size,
> +                                      RP2040_XOSC_BASE + addr, offset,
> +                                      value);
> +        break;
> +    }
> +
> +    return value;
> +}
> +
> +static uint32_t rp2040_xosc_apply_alias(uint32_t old, uint32_t value,
> +                                        hwaddr alias)
> +{
> +    switch (alias) {
> +    case ATOMIC_XOR:
> +        return old ^ value;
> +    case ATOMIC_SET:
> +        return old | value;
> +    case ATOMIC_CLR:
> +        return old & ~value;
> +    default:
> +        return value;
> +    }
> +}
> +
> +static void rp2040_xosc_write_ctrl(RP2040XoscState *s, uint32_t value)
> +{
> +    uint32_t enable =3D extract32(value, 12, 12);
> +    uint32_t freq_range =3D extract32(value, 0, 12);
> +
> +    if (freq_range !=3D XOSC_FREQ_1_15MHZ ||
> +        (enable !=3D XOSC_ENABLE_DISABLE && enable !=3D XOSC_ENABLE_ENAB=
LE)) {
> +        s->badwrite =3D true;
> +    }
> +
> +    if (enable !=3D XOSC_ENABLE_DISABLE && enable !=3D XOSC_ENABLE_ENABL=
E) {
> +        value =3D deposit32(value, 12, 12, XOSC_ENABLE_ENABLE);
> +    }
> +    value =3D deposit32(value, 0, 12, XOSC_FREQ_1_15MHZ);
> +
> +    s->ctrl =3D value;
> +    rp2040_xosc_update_clock(s);
> +}
> +
> +static void rp2040_xosc_write(void *opaque, hwaddr addr,
> +                              uint64_t value64, unsigned size)
> +{
> +    RP2040XoscState *s =3D opaque;
> +    hwaddr alias =3D addr & ATOMIC_ALIAS_MASK;
> +    hwaddr offset =3D addr & 0xfff;
> +    uint32_t value =3D value64;
> +
> +    switch (offset) {
> +    case XOSC_CTRL:
> +        rp2040_xosc_write_ctrl(s, rp2040_xosc_apply_alias(s->ctrl, value,
> +                                                          alias));
> +        break;
> +    case XOSC_STATUS:
> +        if (value & XOSC_STATUS_BADWRITE) {
> +            s->badwrite =3D false;
> +        }
> +        break;
> +    case XOSC_DORMANT:
> +        s->dormant =3D value =3D=3D XOSC_DORMANT_VALUE ? value : XOSC_WA=
KE_VALUE;
> +        rp2040_xosc_update_clock(s);
> +        break;
> +    case XOSC_STARTUP:
> +        s->startup =3D value & 0x00103fff;
> +        break;
> +    case XOSC_COUNT:
> +        s->count =3D 0;
> +        break;
> +    default:
> +        rp2040_log_unimplemented_write("xosc", size,
> +                                       RP2040_XOSC_BASE + addr, offset,
> +                                       value64);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps rp2040_xosc_ops =3D {
> +    .read =3D rp2040_xosc_read,
> +    .write =3D rp2040_xosc_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void rp2040_xosc_reset(DeviceState *dev)
> +{
> +    RP2040XoscState *s =3D RP2040_XOSC(dev);
> +
> +    s->ctrl =3D (XOSC_ENABLE_DISABLE << 12) | XOSC_FREQ_1_15MHZ;
> +    s->dormant =3D XOSC_WAKE_VALUE;
> +    s->startup =3D 0x000000c4;
> +    s->count =3D 0;
> +    s->badwrite =3D false;
> +
> +    rp2040_xosc_update_clock(s);
> +}
> +
> +static void rp2040_xosc_init(Object *obj)
> +{
> +    RP2040XoscState *s =3D RP2040_XOSC(obj);
> +    DeviceState *dev =3D DEVICE(obj);
> +
> +    s->clk =3D qdev_init_clock_out(dev, "clk");
> +    memory_region_init_io(&s->iomem, obj, &rp2040_xosc_ops, s,
> +                          "rp2040.xosc", RP2040_XOSC_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
> +}
> +
> +static const VMStateDescription rp2040_xosc_vmstate =3D {
> +    .name =3D TYPE_RP2040_XOSC,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT32(ctrl, RP2040XoscState),
> +        VMSTATE_UINT32(dormant, RP2040XoscState),
> +        VMSTATE_UINT32(startup, RP2040XoscState),
> +        VMSTATE_UINT32(count, RP2040XoscState),
> +        VMSTATE_BOOL(badwrite, RP2040XoscState),
> +        VMSTATE_CLOCK(clk, RP2040XoscState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void rp2040_xosc_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    device_class_set_legacy_reset(dc, rp2040_xosc_reset);
> +    dc->vmsd =3D &rp2040_xosc_vmstate;
> +}
> +
> +static const TypeInfo rp2040_xosc_info =3D {
> +    .name          =3D TYPE_RP2040_XOSC,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RP2040XoscState),
> +    .instance_init =3D rp2040_xosc_init,
> +    .class_init    =3D rp2040_xosc_class_init,
> +};
> +
> +static void rp2040_xosc_register_types(void)
> +{
> +    type_register_static(&rp2040_xosc_info);
> +}
> +type_init(rp2040_xosc_register_types)
> diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
> index 86037dd0d7..47a8cb2236 100644
> --- a/include/hw/arm/rp2040.h
> +++ b/include/hw/arm/rp2040.h
> @@ -13,10 +13,12 @@
>  #include "hw/char/pl011.h"
>  #include "hw/core/clock.h"
>  #include "hw/core/sysbus.h"
> +#include "hw/misc/rp2040_rosc.h"
>  #include "hw/misc/rp2040_syscfg.h"
>  #include "hw/misc/rp2040_sysinfo.h"
>  #include "hw/misc/rp2040_tbman.h"
>  #include "hw/misc/rp2040_vreg.h"
> +#include "hw/misc/rp2040_xosc.h"
>  #include "qom/object.h"
>=20=20
>  #define TYPE_RP2040 "rp2040"
> @@ -40,8 +42,10 @@ struct RP2040State {
>      PL011State uart[2];
>      RP2040SysCfgState syscfg;
>      RP2040SysInfoState sysinfo;
> +    RP2040RoscState rosc;
>      RP2040TbmanState tbman;
>      RP2040VregState vreg;
> +    RP2040XoscState xosc;
>=20=20
>      MemoryRegion *board_memory;
>      MemoryRegion rom;
> diff --git a/include/hw/misc/rp2040_rosc.h b/include/hw/misc/rp2040_rosc.h
> new file mode 100644
> index 0000000000..6377704e22
> --- /dev/null
> +++ b/include/hw/misc/rp2040_rosc.h
> @@ -0,0 +1,42 @@
> +/*
> + * RP2040 ring oscillator emulation
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_RP2040_ROSC_H
> +#define HW_MISC_RP2040_ROSC_H
> +
> +#include "hw/core/clock.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RP2040_ROSC "rp2040-rosc"
> +OBJECT_DECLARE_SIMPLE_TYPE(RP2040RoscState, RP2040_ROSC)
> +
> +#define RP2040_ROSC_BASE 0x40060000
> +#define RP2040_ROSC_SIZE 0x4000
> +
> +struct RP2040RoscState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    Clock *clk;
> +
> +    uint32_t ctrl;
> +    uint32_t freqa;
> +    uint32_t freqb;
> +    uint32_t dormant;
> +    uint32_t div;
> +    uint32_t phase;
> +    uint32_t count;
> +    int64_t count_start_ns;
> +    uint64_t random_pool;
> +    uint64_t random_prng_state;
> +    uint64_t random_seed;
> +    uint8_t random_pool_bits;
> +    bool random_seed_set;
> +    bool badwrite;
> +};
> +
> +#endif
> diff --git a/include/hw/misc/rp2040_xosc.h b/include/hw/misc/rp2040_xosc.h
> new file mode 100644
> index 0000000000..7b9ef62d22
> --- /dev/null
> +++ b/include/hw/misc/rp2040_xosc.h
> @@ -0,0 +1,33 @@
> +/*
> + * RP2040 crystal oscillator emulation
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_MISC_RP2040_XOSC_H
> +#define HW_MISC_RP2040_XOSC_H
> +
> +#include "hw/core/clock.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RP2040_XOSC "rp2040-xosc"
> +OBJECT_DECLARE_SIMPLE_TYPE(RP2040XoscState, RP2040_XOSC)
> +
> +#define RP2040_XOSC_BASE 0x40024000
> +#define RP2040_XOSC_SIZE 0x4000
> +
> +struct RP2040XoscState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    Clock *clk;
> +
> +    uint32_t ctrl;
> +    uint32_t dormant;
> +    uint32_t startup;
> +    uint32_t count;
> +    bool badwrite;
> +};
> +
> +#endif
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 8916f68bad..441f6f294a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -256,6 +256,7 @@ qtests_arm =3D \
>    (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] =
: []) + \
>    (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : [=
]) + \
>    (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-sy=
scfg-test',
> +                                                       'rp2040-rosc-test=
',
>                                                         'rp2040-tbman-tes=
t',
>                                                         'rp2040-vreg-test=
'] : []) + \
>    (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5=
 : []) + \
> diff --git a/tests/qtest/rp2040-rosc-test.c b/tests/qtest/rp2040-rosc-tes=
t.c
> new file mode 100644
> index 0000000000..2f1fb96022
> --- /dev/null
> +++ b/tests/qtest/rp2040-rosc-test.c
> @@ -0,0 +1,146 @@
> +/*
> + * QTest testcase for the RP2040 ring oscillator block.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qemu/bitops.h"
> +
> +#define ROSC_BASE              0x40060000
> +#define ROSC_CTRL              0x00
> +#define ROSC_FREQA             0x04
> +#define ROSC_DORMANT           0x0c
> +#define ROSC_DIV               0x10
> +#define ROSC_PHASE             0x14
> +#define ROSC_STATUS            0x18
> +#define ROSC_RANDOMBIT         0x1c
> +#define ROSC_COUNT             0x20
> +
> +#define ROSC_ENABLE_ENABLE     0xfab
> +#define ROSC_ENABLE_DISABLE    0xd1e
> +#define ROSC_FREQ_RANGE_LOW    0xfa4
> +#define ROSC_WAKE_VALUE        0x77616b65
> +#define ROSC_STATUS_STABLE     BIT(31)
> +#define ROSC_STATUS_BADWRITE   BIT(24)
> +#define ROSC_STATUS_DIV_RUNNING BIT(16)
> +#define ROSC_STATUS_ENABLED    BIT(12)
> +#define ROSC_STATUS_RUNNING \
> +    (ROSC_STATUS_STABLE | ROSC_STATUS_DIV_RUNNING | ROSC_STATUS_ENABLED)
> +
> +static QTestState *rp2040_start(void)
> +{
> +    return qtest_init("-machine raspi-pico");
> +}
> +
> +static uint32_t read_random_bits(QTestState *qts, unsigned count)
> +{
> +    uint32_t value =3D 0;
> +    unsigned i;
> +
> +    for (i =3D 0; i < count; i++) {
> +        value |=3D (qtest_readl(qts, ROSC_BASE + ROSC_RANDOMBIT) & BIT(0=
)) << i;
> +    }
> +
> +    return value;
> +}
> +
> +static void test_rosc_reset_values(void)
> +{
> +    QTestState *qts =3D rp2040_start();
> +
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_CTRL), =3D=3D,
> +                    (ROSC_ENABLE_ENABLE << 12) | ROSC_FREQ_RANGE_LOW);
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_DORMANT), =3D=3D,
> +                    ROSC_WAKE_VALUE);
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_DIV), =3D=3D, 0x00=
000ab0);
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_STATUS), =3D=3D,
> +                    ROSC_STATUS_RUNNING);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_rosc_badwrite_and_clear(void)
> +{
> +    QTestState *qts =3D rp2040_start();
> +
> +    qtest_writel(qts, ROSC_BASE + ROSC_FREQA, 0x00007777);
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_FREQA), =3D=3D, 0);
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_STATUS) &
> +                    ROSC_STATUS_BADWRITE, =3D=3D, ROSC_STATUS_BADWRITE);
> +
> +    qtest_writel(qts, ROSC_BASE + ROSC_STATUS, ROSC_STATUS_BADWRITE);
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_STATUS) &
> +                    ROSC_STATUS_BADWRITE, =3D=3D, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_rosc_count_reaches_zero(void)
> +{
> +    QTestState *qts =3D rp2040_start();
> +    int i;
> +
> +    qtest_writel(qts, ROSC_BASE + ROSC_COUNT, 1);
> +    for (i =3D 0; i < 16 && qtest_readl(qts, ROSC_BASE + ROSC_COUNT); i+=
+) {
> +        qtest_clock_step(qts, 1000);
> +    }
> +
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_COUNT), =3D=3D, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_rosc_misc_values(void)
> +{
> +    QTestState *qts =3D rp2040_start();
> +
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_RANDOMBIT) & ~BIT(=
0),
> +                    =3D=3D, 0);
> +    qtest_writel(qts, ROSC_BASE + ROSC_DIV, 0xaa1);
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_DIV), =3D=3D, 0xaa=
1);
> +    qtest_writel(qts, ROSC_BASE + ROSC_PHASE, 0xaa8);
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_PHASE), =3D=3D, 0x=
aa8);
> +
> +    qtest_writel(qts, ROSC_BASE + ROSC_CTRL,
> +                 (ROSC_ENABLE_DISABLE << 12) | ROSC_FREQ_RANGE_LOW);
> +    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_STATUS) &
> +                    ROSC_STATUS_ENABLED, =3D=3D, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_rosc_seeded_randombit(void)
> +{
> +    QTestState *qts_a;
> +    QTestState *qts_b;
> +    uint32_t bits_a;
> +    uint32_t bits_b;
> +
> +    qts_a =3D qtest_init("-machine raspi-pico,rosc-random-seed=3D0x1234"=
);
> +    bits_a =3D read_random_bits(qts_a, 32);
> +    qtest_quit(qts_a);
> +
> +    qts_b =3D qtest_init("-machine raspi-pico,rosc-random-seed=3D0x1234"=
);
> +    bits_b =3D read_random_bits(qts_b, 32);
> +    qtest_quit(qts_b);
> +
> +    g_assert_cmphex(bits_a, =3D=3D, bits_b);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/rp2040-rosc/reset-values", test_rosc_reset_values);
> +    qtest_add_func("/rp2040-rosc/badwrite-and-clear",
> +                   test_rosc_badwrite_and_clear);
> +    qtest_add_func("/rp2040-rosc/count-reaches-zero",
> +                   test_rosc_count_reaches_zero);
> +    qtest_add_func("/rp2040-rosc/misc-values", test_rosc_misc_values);
> +    qtest_add_func("/rp2040-rosc/seeded-randombit",
> +                   test_rosc_seeded_randombit);
> +
> +    return g_test_run();
> +}

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBE2D3E783
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 23:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTTBB-0006Eh-7s; Wed, 10 Dec 2025 18:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vTTB9-0006EM-Ed
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:01:03 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vTTB7-0006Xb-GL
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:01:03 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4ee243b98caso70861cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 15:01:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765407660; cv=none;
 d=google.com; s=arc-20240605;
 b=EFnBAkl6m0/Asrs1clogti6DrdD0H/WCz8CZbMK8Y/pgThlKH/p1ejYISYuzUi8ldY
 pIQ/VVmVPaVIBW6a3hTLGs6gctguk/3+8WsqoDpQFHDiZcLidplCBVLEC4rmui1y+gV8
 R+OS+ADBpr4nctlt+B20Qzs3pnIstNGmMAtyNa5zwjGQ5Y9pIU+ibe22lY//JkFzpePl
 UylYmjmZtIcccO7pZpcbske4PKkO8c8oWZfkskWi6ytkR4wwwXY/mROkra5p1YDKCfYn
 TCuPm2hd2a3i17KG9Z9wOr8lUbwJSDdgUD8uH0kYLrl4SiymDUN/TQxnlt4fuxs9pyrK
 yc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6OA7cpNAJ5AsM4oZAvpZYDOS5IeEq/217eSPSbDvfB8=;
 fh=7xWSA3tkJC3K0osMI6A+ktwuGnKWS/HAYP8ypOStPZU=;
 b=NLu9eosdBZYTipcBTqVxrhH5i+LoKu6FNfH8rzfxZT0G4rkbSnTzniKXUBSU8RIy/Y
 4m/HpFq6Pfpjg1s+Haxr8PLNoNaBgyomvIw7HVF3pFFAe7bmiUSBtn97mbukqEyGSXt4
 bs0YBiWme0KbEtbbdPVDl1tbt8wDxINWrAfUnL5HxwTbdKe310k5BTUw4CuciHI6BYJM
 7HR40NbLmpC/G6LeKZVsBmb800v4B1rd2KAdTcUONMwIlMr/+BTLbXiwyVurkVn5WbFP
 18nz4WPdFej/qImB9Uu9ZgcXhfncT0aPpA9S/VT3SctJ7vwSoFBZmyKAH9x/k37z3F66
 O/jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765407660; x=1766012460; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OA7cpNAJ5AsM4oZAvpZYDOS5IeEq/217eSPSbDvfB8=;
 b=ZkoaDFGUATwInNyzS0EPY2upj9sFDxB4fFAhlGi3HOVmcOrWdls5bbmkIl09koYv8i
 bEXUQXuuNs89ceCL25urIJkgMjyVDTElM+cDOkM5TPct5X1LnkTVKHagsL7ku6phpgkk
 WJ0As8Hf44Okx6kblFl81I0j1XQoxYjeB9qyPpQkTrsiFwSonWgqPooCrMWKoIKRhV1F
 ZwbqVSUxdoM+Y8ABXRQfLQFbt6o86zEd6uufqmW7mZZ5lwRIvpvkn+1V0Gz0uooOxeoV
 c16RA78YIFGn65y7oKbuG4LZj4acZgJvMtUFvc9f+HqnFqE+atdtqCaZyYEpY9om1PW7
 QEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765407660; x=1766012460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6OA7cpNAJ5AsM4oZAvpZYDOS5IeEq/217eSPSbDvfB8=;
 b=rje0iazRM7gU35sd37qMOJtgtATsRy/tlabIucl9hLKxeh6vUIVpkQjTRp2YJeHcbW
 0XjtRWgrWi7q+xzwMKVwsmZZnnht07weTVIFQmfeQB8rLXv4lDw3duI5L/wikrdq5Wo7
 yGtb51lmVVO3yEXAOAGCo1Lp5Ndv9uCr+9n+1QaxWT/kVKInTrXYGRMJ/VPLyg5MEUVd
 x488sUZ6axIOtLwGF2SfyO+F+m76YjKD0Y8aGgKTeutWAcn0Zzl+A7cUH6oI9JJsYUEK
 frk5TvgWDNZkBCHQYCnB8Iw9iw+Ro4R69L078pzfmFaC1tnWIFOVFbZZH/ZLs/u03ZdS
 thYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAjJ8wvZoCE5FjCd4Dogd4FcprooC0oUoqVGChu4n4hQ2dYYP3Cj+C72BMy6coKY4uvP8DDh97Rucr@nongnu.org
X-Gm-Message-State: AOJu0YznJrBdQuiXWRcySiqAkgBld4OAw+Z1l8KSrkY/WRt17xs2chZk
 g7OedrKkhebia24cqI5kWuXFYGk84os4cq2lQKzQJuPat4kHHNgXDCLpnixvu+yUHeT1en5bs5j
 JRJyssNKkbCQbw8V5RJaBsBgKrWUumKAcBaKixPwb
X-Gm-Gg: ASbGncveg3ag8NmMub/NcCg/jD1iZNI/fh3P6sU+c6FsRgteOXUK91qtikRoLwyk3wJ
 6t84YIF9Q8yok/zT24qh1Kbkp8uLVNWNa6peR2J8/9TlaiosFrRBEEfDE56lcxAk6UPmkUl78It
 rPwmNATUVK6BKnFONFNPhJmUR4w+iEQNAYTp9pam4Dk4N83Uq0UzL8CZseJ+PAQIz7OVnXO16Ef
 0bpvG4F3v+jc/92Tzr6/JZvWjvhJsXuB8llriSsPAGU/GvgeVlyXU4XTgGUUx5MS0syQeaZWq41
 O6mobeq6V6dgD7YsjIoejE0FF8tNi9lmYBj1hAQ=
X-Google-Smtp-Source: AGHT+IG+iu8K8ihKFYKbtvYLhgeBPYOli2KpONWb6A632WvXNwxK9326Y2QhttR0FfbaTEaedxee5lMQrfHaAdIEDjk=
X-Received: by 2002:ac8:5801:0:b0:4e8:b245:fba0 with SMTP id
 d75a77b69052e-4f1bd931902mr4000021cf.14.1765407659899; Wed, 10 Dec 2025
 15:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-4-kane_chen@aspeedtech.com>
In-Reply-To: <20251208074436.1871180-4-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 10 Dec 2025 15:00:48 -0800
X-Gm-Features: AQt7F2pRlKYRopB_YP_Y7LE1qTwil4w-mCXpupXuD2uXlmtHjF2Nf5waGkT8UQs
Message-ID: <CA+QoejUEHANyAgbZ7YhH+KuHLMthVurjUje1qPvNtavKr1b=Jg@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] hw/misc: Add basic Aspeed PWM model
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Sun, Dec 7, 2025 at 11:48=E2=80=AFPM Kane Chen via <qemu-devel@nongnu.or=
g> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Add an initial PWM model for Aspeed SoCs, including device state,
> register definitions, and basic initialization as a sysbus device.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  include/hw/arm/aspeed_soc.h  |   3 +-
>  include/hw/misc/aspeed_pwm.h |  31 +++++++++
>  hw/misc/aspeed_pwm.c         | 121 +++++++++++++++++++++++++++++++++++

checkpatch.pl complains that the new files don't fall under any of the
existing MAINTAINERS clauses. Should we add a new one/update an
existing one for this?

>  hw/misc/meson.build          |   1 +
>  hw/misc/trace-events         |   4 ++
>  5 files changed, 159 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/misc/aspeed_pwm.h
>  create mode 100644 hw/misc/aspeed_pwm.c
>
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index bca10c387b..5b0680f319 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -28,6 +28,7 @@
>  #include "hw/misc/aspeed_hace.h"
>  #include "hw/misc/aspeed_sbc.h"
>  #include "hw/misc/aspeed_sli.h"
> +#include "hw/misc/aspeed_pwm.h"
>  #include "hw/watchdog/wdt_aspeed.h"
>  #include "hw/net/ftgmac100.h"
>  #include "target/arm/cpu.h"
> @@ -108,7 +109,7 @@ struct AspeedSoCState {
>      UnimplementedDeviceState video;
>      UnimplementedDeviceState emmc_boot_controller;
>      UnimplementedDeviceState dpmcu;
> -    UnimplementedDeviceState pwm;
> +    AspeedPWMState pwm;

Should this be moved up so the UnimplementedDeviceStates are all at
the bottom without interruption?

>      UnimplementedDeviceState espi;
>      UnimplementedDeviceState udc;
>      UnimplementedDeviceState ltpi;
> diff --git a/include/hw/misc/aspeed_pwm.h b/include/hw/misc/aspeed_pwm.h
> new file mode 100644
> index 0000000000..13dc3ea45b
> --- /dev/null
> +++ b/include/hw/misc/aspeed_pwm.h
> @@ -0,0 +1,31 @@
> +/*
> + * ASPEED PWM Controller
> + *
> + * Copyright (C) 2017-2021 IBM Corp.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#ifndef ASPEED_PWM_H
> +#define ASPEED_PWM_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_ASPEED_PWM "aspeed.pwm"
> +#define ASPEED_PWM(obj) OBJECT_CHECK(AspeedPWMState, (obj), TYPE_ASPEED_=
PWM)
> +
> +#define ASPEED_PWM_NR_REGS (0x10C >> 2)
> +
> +typedef struct AspeedPWMState {
> +    /* <private> */
> +    SysBusDevice parent;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +
> +    uint32_t regs[ASPEED_PWM_NR_REGS];
> +} AspeedPWMState;
> +
> +#endif /* _ASPEED_PWM_H_ */
> diff --git a/hw/misc/aspeed_pwm.c b/hw/misc/aspeed_pwm.c
> new file mode 100644
> index 0000000000..de209274af
> --- /dev/null
> +++ b/hw/misc/aspeed_pwm.c
> @@ -0,0 +1,121 @@
> +/*
> + * ASPEED PWM Controller
> + *
> + * Copyright (C) 2017-2021 IBM Corp.
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "hw/misc/aspeed_pwm.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +
> +#include "trace.h"
> +
> +static uint64_t aspeed_pwm_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    AspeedPWMState *s =3D ASPEED_PWM(opaque);
> +    uint64_t val =3D 0;
> +
> +    addr >>=3D 2;
> +
> +    if (addr >=3D ASPEED_PWM_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx=
 "\n",
> +                      __func__, addr << 2);
> +    } else {
> +        val =3D s->regs[addr];
> +    }
> +
> +    trace_aspeed_pwm_read(addr << 2, val);
> +
> +    return val;
> +}
> +
> +static void aspeed_pwm_write(void *opaque, hwaddr addr, uint64_t data,
> +                              unsigned int size)
> +{
> +    AspeedPWMState *s =3D ASPEED_PWM(opaque);
> +
> +    trace_aspeed_pwm_write(addr, data);
> +
> +    addr >>=3D 2;
> +
> +    if (addr >=3D ASPEED_PWM_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRI=
x "\n",
> +                      __func__, addr << 2);
> +        return;
> +    }
> +
> +    s->regs[addr] =3D data;
> +}
> +
> +static const MemoryRegionOps aspeed_pwm_ops =3D {
> +    .read =3D aspeed_pwm_read,
> +    .write =3D aspeed_pwm_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void aspeed_pwm_reset(DeviceState *dev)
> +{
> +    struct AspeedPWMState *s =3D ASPEED_PWM(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +}
> +
> +static void aspeed_pwm_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedPWMState *s =3D ASPEED_PWM(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_pwm_ops, s,
> +            TYPE_ASPEED_PWM, 0x1000);
> +
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static const VMStateDescription vmstate_aspeed_pwm =3D {
> +    .name =3D TYPE_ASPEED_PWM,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AspeedPWMState, ASPEED_PWM_NR_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
> +static void aspeed_pwm_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D aspeed_pwm_realize;
> +    device_class_set_legacy_reset(dc, aspeed_pwm_reset);
> +    dc->desc =3D "Aspeed PWM Controller";
> +    dc->vmsd =3D &vmstate_aspeed_pwm;
> +}
> +
> +static const TypeInfo aspeed_pwm_info =3D {
> +    .name =3D TYPE_ASPEED_PWM,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(AspeedPWMState),
> +    .class_init =3D aspeed_pwm_class_init,
> +};
> +
> +static void aspeed_pwm_register_types(void)
> +{
> +    type_register_static(&aspeed_pwm_info);
> +}
> +
> +type_init(aspeed_pwm_register_types);
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 45b16e7797..7afe1d0009 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: fil=
es(
>    'aspeed_i3c.c',
>    'aspeed_lpc.c',
>    'aspeed_ltpi.c',
> +  'aspeed_pwm.c',
>    'aspeed_scu.c',
>    'aspeed_sbc.c',
>    'aspeed_sdmc.c',
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index eeb9243898..f7870babba 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -299,6 +299,10 @@ aspeed_i3c_write(uint64_t offset, uint64_t data) "I3=
C write: offset 0x%" PRIx64
>  aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data=
) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
>  aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t dat=
a) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
>
> +# aspeed_pwm.c
> +aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRIx6=
4 " data 0x%" PRIx64
> +aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" PRI=
x64 " data 0x%" PRIx64
> +
>  # aspeed_sdmc.c
>  aspeed_sdmc_write(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data:=
 0x%" PRIx64
>  aspeed_sdmc_read(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " data: =
0x%" PRIx64
> --
> 2.43.0
>
>


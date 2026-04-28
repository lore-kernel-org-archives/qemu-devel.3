Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E05FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHjKR-0001Tc-9m; Tue, 28 Apr 2026 10:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHjKP-0001TI-Nm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:22:21 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHjKN-0004S6-Qd
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:22:21 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-650775f427eso12255809d50.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 07:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386138; cv=none;
 d=google.com; s=arc-20240605;
 b=CWj7X+Vdr4ErmodaJboE+HeXE7qzqWdkH3GorJoif0Fi2E8NuXJozKCN+Si0VP1Fuf
 ePXAVCML1nLLpNaBzmg7aDCTG4kSiiKeI/aDScbxvO47dJaIX+FOPG4nN026no4P+FEo
 VD2lAm31KfHb8AANY3Lg9wufhESco8HPxsYvrl31ucnHxBc7RWvSs80Z2oBvAKLs4nNM
 KoTWendvRZIwFn4CkTyVqxaawRGAxH42v+Ys9BBRGTzQDMBdah+z3CeFnfpajI2iLBSE
 UhhN4mGR5j4zRydsN1uLdKoxihbZx7baSimIDzzCZDUFBkXT9UeTs50IiHnA396r9xzu
 psOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aySjJyo+kR82fcBjq9UcAaKH0IJu3J23vCc1uC+6tq0=;
 fh=wLXGM5nkLZg0LtSHNNFRmNNOFyQIDOo4SxiANPv/71U=;
 b=OTHJ47jMJZFzmSuK1c3I4W/6BHv9hgnxTVukOD1iSqqdCduW7ST5ELorCPfcPUbz24
 g8YAVtKCrTTNkl2FOYC/WXAcWCaecJzLxavCv69puq5aS21JaK8ATPBoIaF0EcVbc9QU
 jJNMfD9EP8jP05ikjWZmowEH/BoeGA9Dn5U1g8iqczGJGhLf6IAvbQGCGOcFPhMxhGuQ
 8ccJLTV0AfVkeqwtfAoxCb1UpURsd7tIEOZNqLAhR3j9E+OHDAdxT87SH0Tx6IhuivOA
 xsyMiA/D4R9Uhe0p+MYoZhA2R6TzhxSnEEyX7zJGudU+sbDw1jB3srWxoeIn3EdVC0IQ
 6YQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777386138; x=1777990938; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aySjJyo+kR82fcBjq9UcAaKH0IJu3J23vCc1uC+6tq0=;
 b=pCme3aZ6bTExMSp0yjwSEyjmVSMd+up53kz/6OqCwEKRuCmtxsuiHhcFkufACrIypC
 f8vgrCObnzkAwuHzQXolkOrVMcV3aVoAtE5N9Fg/Ha2iFnWE8DSmECthJSXPxsVmgMcx
 hIhpFMdPmZHz/GC7CNZ2tnKKwdQMVVczpAQYny0ewsNYQ1WIbPP1aUtNPtAV/YAo1fpi
 0clZjXEzXq0PphAJYVP4IUwQtKRIpBMru3o4OTEYliPK2PFUPtX9YZMB+s4FKIGXInV+
 U0SteEFYaPNclSzPRAP9iLeBw6JXjoOLcOpbkOqmm5sY05AIr3xByfBTt3BxTBn02/Qv
 pyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777386138; x=1777990938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aySjJyo+kR82fcBjq9UcAaKH0IJu3J23vCc1uC+6tq0=;
 b=c60vMr9cdVkbTIzGYO5wG3g5/Fv4/kWyGCTtxoe5dX9rJwDtYPr2FLOJpfwCJ5v+AS
 GaUZhNiuPLlkVXB6VtQT1ozXOwne3Fguj/9NAPihtJeC3EiKnqiubLnxMBpJ2GnoWmEe
 Teeojh2DenOSFTiyyuiScQgWgHFRxzxVJxJhL3rscfZnXFkHcMezWCt1P3aGFrQi8+Ih
 uyTTHfQ2P1dfAaBlB/rzHv2CaVsekKF5Yy1cAjWXgTU1Vvc3Yo1j1po7/u1WJC151e3R
 Z1A7OICrQ8HKY+UE1JEsbYBWKPNCqBT2cztE0fQ3r++kCHxnJbIlkUybI7DaNmV7yDl9
 X9lA==
X-Gm-Message-State: AOJu0YzvJ5S71vFzshuBWJO+DnuczeiCdZ205P8Z6Fb5HMCB5PAotlrR
 h5KdZQE1DAAUrFkRhoXjfXCkaI25NfVpVIozGTfJNgTJloKFwWs94foZ4bbdVQci3krWI+EX2rp
 BBSd52487j6Mou97b9radk408BGoN+ONTGHhZfE3KfA==
X-Gm-Gg: AeBDiesccV3xjXNDuw15P9P5RADatEScIkddTlcSiqpSG7xY2TwFKSBojWaRIy5Esv/
 /aahP5OSigkZXxfKWlUMtA6mdUm9cP1wcYWjfkUkKNJDPWVBwmrwOA5RWt6GpM1qYijWVjQ1bI+
 gezh8bSKyHDWCY1Y+tqI7hXTC0J8wat5nKg2+luN51qt4u0jIrcYSbWPU68TMsplx0lE9M0RQNy
 hYBH38QwALZdmTev6EBsmU+7m5Gv3p00s6LmyoXeC8uSdGXKYbgfax2V4qOtMxNxfYKAsiYJXA5
 G2LGF2NOp3pGzSAAA0tj6N2qAGhF/ozbpCy0L3cuuri2iUCsDN3J9o/stODk11LB5YhTuUnZm+G
 Qyw==
X-Received: by 2002:a53:ac8b:0:b0:64e:ebb4:1bca with SMTP id
 956f58d0204a3-65beeda0d70mr2952457d50.27.1777386137704; Tue, 28 Apr 2026
 07:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260421162856.298260-1-alexander.hansen@9elements.com>
In-Reply-To: <20260421162856.298260-1-alexander.hansen@9elements.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 15:22:06 +0100
X-Gm-Features: AVHnY4IC4DATJrFzrr6MdobgcDTQLzyOIALkElX_Q6F-B6i22_HURNr7nZ4CiiI
Message-ID: <CAFEAcA9yh2mxoKeyrB0iABSve+Tx6NyEn91KNv9Th9oCiJUFfQ@mail.gmail.com>
Subject: Re: [PATCH] hw/sensor: MAX31790 support
To: Alexander Hansen <alexander.hansen@9elements.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 21 Apr 2026 at 17:30, Alexander Hansen
<alexander.hansen@9elements.com> wrote:
>
> Product: [1]
> Datasheet: [2]
>
> MAX31790 Support:
> - fan inputs are reading
> - tach reading propertional to pwm setting from linux driver
> - fans do not show any fault
> - 6 PWM registers influence 6 TACH registers
>
> There is intentional stub behavior in some places and various functions
> of the device are currently unsupported.

Hi; thanks for this patch.

From our conversation on IRC: you say you want this as part of
modelling the aspeed yosemite4 board. (I've cc'd Cedric as aspeed
maintainer). For upstream QEMU we generally prefer new device
models to be sent as part of the patch series that adds the
board they're part of, so that they have a use upstream.

The code itself looks mostly in good shape; I have a few
first-pass comments below.

> MAX31790 currently unsupported:
> - slave address restriction
> - fan dynamics
> - spin-up configuration
> - fault state / failure possibility
> - rate-of-change control
> - tach mode
> - mixed layouts where number of fans !=3D number of tachs
> - see Figure 5.9 in [2] for example of mixed layout
>
> Anyone could expand it in the future for more accurate emulation.


> Tested: on yosemite 4 qemu
>
> ```

Commit messages aren't markdown, they're plain text.

The commit message also ideally ought to give the rationale
for implementing the device (though this is a bit less
necessary when it's part of a larger series adding board
support).

> root@yosemite4:~# ls /sys/class/hwmon/hwmon2/
> device      fan2_fault   fan3_target  fan5_fault   fan6_target  pwm2     =
    pwm5
> fan1_enable  fan2_input   fan4_enable  fan5_input   name        pwm2_enab=
le  pwm5_enable
> fan1_fault   fan2_target  fan4_fault   fan5_target  of_node     pwm3     =
    pwm6
> fan1_input   fan3_enable  fan4_input   fan6_enable  power       pwm3_enab=
le  pwm6_enable
> fan1_target  fan3_fault   fan4_target  fan6_fault   pwm1        pwm4     =
    subsystem
> fan2_enable  fan3_input   fan5_enable  fan6_input   pwm1_enable  pwm4_ena=
ble  uevent
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_input
> 4551
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_enable
> 1
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_fault
> 0
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_target
> 2048
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/pwm1
> 178
> root@yosemite4:~# cat /sys/class/hwmon/hwmon2/name
> max31790
> ```
>
> Trace output:
> ```
> max31790_realize i2c_addr: 0x20
> max31790_realize i2c_addr: 0x2f
> max31790_realize i2c_addr: 0x20
> max31790_realize i2c_addr: 0x2f
> max31790_event i2c_addr: 0x20, event: 0x01
> max31790_send i2c_addr: 0x20, data: 0x02
> max31790_event i2c_addr: 0x20, event: 0x00
> max31790_recv i2c_addr: 0x20, reg_addr: 0x02
> max31790_recv_return i2c_addr: 0x20, returns: 0x08
> ...
> ```
>
> References:
> [1] https://www.analog.com/en/products/MAX31790.html
> [2] https://www.analog.com/media/en/technical-documentation/data-sheets/M=
AX31790.pdf
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> CC: qemu-arm@nongnu.org
> CC: qemu-devel@nongnu.org
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> ---

> +++ b/hw/sensor/max31790.c
> @@ -0,0 +1,499 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Maxim MAX31790 PMBus 6-Channel Fan Controller
> + *
> + * Datasheet:
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/M=
AX31790.pdf
> + *
> + * Copyright(c) 2022 Qualcomm Innovation Center, Inc. All rights reserve=
d.

Copyright doesn't seem to match your email address, and the
date is very old: is this code that's been in a downstream
fork that you've picked up?

> + */


> +static void max31790_realize(DeviceState *dev, Error **errp)
> +{
> +    MAX31790State *s =3D MAX31790(dev);
> +
> +    trace_max31790_realize(s->i2c.address);
> +
> +    for (int i =3D 0; i < MAX31790_NUM_FANS; i++) {
> +        /* POR-State 0b 0XX0 0000 */
> +        s->fan_config[i] =3D 0b00000000;
> +
> +        /* same as POR-State */
> +        s->tach_target[i] =3D 0b0011110000000000;
> +
> +        /* same as POR-State */
> +        s->fan_dynamics[i] =3D 0b01001100;
> +
> +        s->pwm[i] =3D 0;

Reset should be in a reset method, not realize.

> +    }
> +
> +    for (int i =3D 0; i < MAX31790_NUM_TACHS; i++) {
> +        max31790_set_rpm(s, i, 0x4444);
> +    }
> +}

thanks
-- PMM


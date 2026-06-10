Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B96ACD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHuP-0005DX-QO; Wed, 10 Jun 2026 08:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wXHuN-0005DA-RZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:19:47 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.hansen@9elements.com>)
 id 1wXHuG-0003qR-Jx
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:19:47 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bef1e6423e7so773309166b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 05:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781093977; cv=none;
 d=google.com; s=arc-20240605;
 b=QXLrZ/xQoRbejwd/0e6suwuFBcpxqcnDV+01+Hyv+Jqm/CFqBCI0aVc7s5WIKX3/Ht
 NSoqKWaWcZKO5ciZ5nt+ekMPaM5yI1puwMYrwz6hk++sW9NypGFJ3qz3znC9e9kLlMyi
 f51RUKoTy1eA4aPZHtNP4u9xyHDJtKXJF+Ikj19ZSGwn7co8V/plMtLoDNPF1sGwngVm
 Ni2kwWzQFkRBSzuEzOuwClGHAdIdCoBuPZMz9eeztRS78JVj9x6KZBY4vK6DGHdrQSsU
 ZSvsY0DSI+FUBdAKWFxA4Mc43HI1DG4e313R3Wxy0fCcxRW1AqUPQftBNJ4UW1uZ+QBf
 SZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0U3c2O9xGWe6eB6GmOngCtISuAMmG9rEzewXi3SV1m8=;
 fh=bYU+d4JFK9nZHmzOXgYD7bUjbxL2TIi0fu6TNxrn2ug=;
 b=lwsbuJzOxmiqFFksRJplrn094fvqUxZjLDeXGkYPDP9/nqvqe4jwAW3nXVNhUID63z
 COnk24OvbDoNvrTyzsEnE3dSodLlxRI2ZDwMloeYXgIblOCQOqqp9Qk6huA8ciKvx0UL
 A8022ks3JUmswhvWrCN1LQy5wqYgM0raTPmbGbWG0xtUvFbJhI+WPKSPMx7g7F+6CZTW
 pYcY9/5sJDxb0W/LvladSn8kqwdNTrJoAluS+AXOaSDGHR++Z848gdWtPsmCjIczPw6q
 DskdpNSBH5UsvKbXYPTucrx5ZNEmX4DlOoj+ERLhMK0+geeRH+Lk9g4t48VnEDN9PJ8Y
 gtTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1781093977; x=1781698777; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0U3c2O9xGWe6eB6GmOngCtISuAMmG9rEzewXi3SV1m8=;
 b=QVhWK5ZOW3LD8MH5G70hM/xWNC/p4MzK1eXRcQ53rMC1e1WUn7Bz4Wg4ix0KNE85cN
 TLYAQXcMpMbknVtlli7NYqmiR841hrLV6uhskhgxTj9yfGcGsSJ97DpC08SVh+TiljpI
 IY9imL+hJpw2igBqhtqHckUn9jriphsP5lalCVCbiGMsRGmbRLNS5vd60lX6JadV8inc
 2nh2Yfi+xcz1l3Cv42Qf7zQMe16dza82q5CznhzRBZhv/j53s6sXTiChgbimkIAhpYl3
 uLo9dkxaDeIWlvm2baT7Ft8vVrHuRcw9X/Jd3PAGuiXoge/2czAWrb3bVORmQkJLjJdI
 PHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781093977; x=1781698777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0U3c2O9xGWe6eB6GmOngCtISuAMmG9rEzewXi3SV1m8=;
 b=ZD5yt0rAsBnBQgr2gqg0C9CVVrRrS2pRF1PWZFK6AGiOEGz+/PFDGUyP756nFwOvhq
 j19FuCc/wjwDOkla0a58kuawzAC+i4rcwqf2Ki+uQOqAXf/NTYl2x47JqQzUQ97/NVTm
 kmQMubhkFd292iigvhUgIkuaFu8CZBzih8mOsRGDzX5ze5kbsGz8KhT0vGUT0Crdf3F3
 uWaHls2LSaAFqLYQA0fSab2+RMPyie57+4ON17WoBy+lBIsxb2hBhhnDqxLvRx6om41k
 lpvSyb/Ha9NkTjPqhJFJ0pR/jr0qXDLwZUQ1kcArrGm0RRwPJtutBfPhjsyWzmDMQoYV
 ztGg==
X-Gm-Message-State: AOJu0YwRi7RQg4bqiP5FPlto7sjNJVczbtyLD5FpEUQyIfllErvjggCz
 BwlgfMklYLdSHg+idVBol19Knfbmk4qORAEu8sH9f+T8pU52M4PTdp74A+JqwNvCVeC5IIowL8i
 eLA8K7Lt8/kfvOUZhVmVEaM7MVmQ54I8RdBv/HHIoqw==
X-Gm-Gg: Acq92OEnjqFYw4P45+rlkyeCmY14oswTDGhBwXVF/ihc8KYXNrGiFVudJNjn/61c8qa
 sj9AdEdJCA1qJCU9ehDXTPlSb8CTjL4AGjKwX3v5ybI8YPllCRZf8wOJwlK3Wd28iieI0EMZfoE
 nTN3ik02dp3mWTedROm9GMmfI7yxPDmoiDXJC171iieCEmR6NfeBd1f9d0IyGcgpeo43PR7PX73
 ZogLYs179uNuXq1Jp5LPLYnG9PxdL8F1/FOIRYB5EiEeMRsuVeIp4BFPAi1i/GSyG+njudhnHTO
 u2X31dAQz4+b+pEwFUBsenbL8rY0
X-Received: by 2002:a17:907:75f7:b0:bee:a25:b977 with SMTP id
 a640c23a62f3a-bf3745dce08mr880212966b.45.1781093977219; Wed, 10 Jun 2026
 05:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260529124237.94087-1-alexander.hansen@9elements.com>
 <20260529124237.94087-4-alexander.hansen@9elements.com>
 <b011384e-cedf-4803-b07b-c41615ff5e0b@kaod.org>
In-Reply-To: <b011384e-cedf-4803-b07b-c41615ff5e0b@kaod.org>
From: Alexander Hansen <alexander.hansen@9elements.com>
Date: Wed, 10 Jun 2026 14:19:24 +0200
X-Gm-Features: AVVi8Cem1vJ7hq4emNXgCIIT8MXdqIPSze7pTGeZ09StowTrN7_WpOP6P8-CJzU
Message-ID: <CAEr1sMtNt3hz8DDYLQs90kEV87ULssNLKLLO_+P-0jxHGxUQSQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] hw/sensor: MAX31790 support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Titus Rwantare <titusr@google.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>
Content-Type: multipart/alternative; boundary="000000000000d2f5090653e541f7"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alexander.hansen@9elements.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000d2f5090653e541f7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

> How does the 0x4444 value relates to the one used in the tests ?

There is something in the image which is writing the pwm, if you look at
the traces
it should be more obvious in the next patchset (v6, not yet sent)

max31790_pwm_write i2c_addr: 0x2f, index: 5, value: 0xb200
max31790_rpm_write i2c_addr: 0x2f, index: 5, value: 0x1c34
max31790_tach_count_reg i2c_addr: 0x2f, index: 5, value: 0x0440
max31790_send i2c_addr: 0x2f, data: 0x80
max31790_pwm_write i2c_addr: 0x2f, index: 5, value: 0xb280
max31790_rpm_write i2c_addr: 0x2f, index: 5, value: 0x1c48
max31790_tach_count_reg i2c_addr: 0x2f, index: 5, value: 0x0420

Looking then at the latest fan dynamics read from the driver

max31790_fan_dynamics_read i2c_addr: 0x20, channel: 0, value: 0x0000
max31790_recv_return i2c_addr: 0x20, reg_addr: 0x08, returns: 0x00

and plugging that into the equation

>>> (60 * 1 * 8192) / (0x0420 >> 4)
7447.272727272727

we get the value found in the test. The fan dynamics are wrong because the
reset was not being called.
Should be fixed in the next patchset. The newly added traces should make
things clearer and the functional test will also have a comment
going through an example calculation.

Am Mo., 1. Juni 2026 um 11:17 Uhr schrieb C=C3=A9dric Le Goater <clg@kaod.o=
rg>:

> On 5/29/26 14:37, Alexander Hansen wrote:
> > Product: [1]
> > Datasheet: [2]
> >
> > MAX31790 Support:
> > - fan inputs are reading
> > - tach reading propertional to pwm setting from linux driver
> > - fans do not show any fault
> > - 6 PWM registers influence 6 TACH registers
> >
> > There is intentional stub behavior in some places and various functions
> > of the device are currently unsupported.
> >
> > MAX31790 currently unsupported:
> > - slave address restriction
> > - fan dynamics
> > - spin-up configuration
> > - fault state / failure possibility
> > - rate-of-change control
> > - tach mode
> > - mixed layouts where number of fans !=3D number of tachs
> > - see Figure 5.9 in [2] for example of mixed layout
> >
> > Anyone could expand it in the future for more accurate emulation.
> >
> > The reason for adding this device is to support Yosemite V4 emulation.
> >
> > Tested: on yosemite 4 qemu
> >
> > root@yosemite4:~# ls /sys/class/hwmon/hwmon2/
> > device            fan2_fault   fan3_target  fan5_fault   fan6_target
> pwm2         pwm5
> > fan1_enable  fan2_input   fan4_enable  fan5_input   name
> pwm2_enable  pwm5_enable
> > fan1_fault   fan2_target  fan4_fault   fan5_target  of_node   pwm3
>    pwm6
> > fan1_input   fan3_enable  fan4_input   fan6_enable  power
>  pwm3_enable  pwm6_enable
> > fan1_target  fan3_fault   fan4_target  fan6_fault   pwm1      pwm4
>    subsystem
> > fan2_enable  fan3_input   fan5_enable  fan6_input   pwm1_enable
> pwm4_enable  uevent
> > root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_input
> > 4551
> > root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_enable
> > 1
> > root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_fault
> > 0
> > root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_target
> > 2048
> > root@yosemite4:~# cat /sys/class/hwmon/hwmon2/pwm1
> > 178
> > root@yosemite4:~# cat /sys/class/hwmon/hwmon2/name
> > max31790
> >
> > Trace output:
> > max31790_realize i2c_addr: 0x20
> > max31790_realize i2c_addr: 0x2f
> > max31790_realize i2c_addr: 0x20
> > max31790_realize i2c_addr: 0x2f
> > max31790_event i2c_addr: 0x20, event: 0x01
> > max31790_send i2c_addr: 0x20, data: 0x02
> > max31790_event i2c_addr: 0x20, event: 0x00
> > max31790_recv i2c_addr: 0x20, reg_addr: 0x02
> > max31790_recv_return i2c_addr: 0x20, returns: 0x08
> > ...
> >
> > References:
> > [1] https://www.analog.com/en/products/MAX31790.html
> > [2]
> https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31=
790.pdf
> >
> > Cc: Titus Rwantare <titusr@google.com>
> > Cc: "C=C3=A9dric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> > Cc: qemu-arm@nongnu.org
> > Cc: qemu-devel@nongnu.org
> > Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> > ---
> >   MAINTAINERS                              |   1 +
> >   hw/arm/aspeed_ast2600_fby4.c             |   4 +-
> >   hw/sensor/max31790.c                     | 537 ++++++++++++++++++++++=
+
> >   hw/arm/Kconfig                           |   1 +
> >   hw/sensor/Kconfig                        |   4 +
> >   hw/sensor/meson.build                    |   1 +
> >   hw/sensor/trace-events                   |  11 +
> >   tests/functional/arm/test_aspeed_fby4.py |  26 ++
> >   8 files changed, 583 insertions(+), 2 deletions(-)
> >   create mode 100644 hw/sensor/max31790.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index cd5c4831e2..2a0dbd1cc4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3987,6 +3987,7 @@ S: Maintained
> >   F: hw/i2c/pmbus_device.c
> >   F: hw/sensor/adm1272.c
> >   F: hw/sensor/isl_pmbus_vr.c
> > +F: hw/sensor/max31790.c
> >   F: hw/sensor/max34451.c
> >   F: include/hw/i2c/pmbus_device.h
> >   F: include/hw/sensor/isl_pmbus_vr.h
> > diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4.=
c
> > index 89fb0ac2fd..1f391022a2 100644
> > --- a/hw/arm/aspeed_ast2600_fby4.c
> > +++ b/hw/arm/aspeed_ast2600_fby4.c
> > @@ -164,7 +164,7 @@ static void fby4_i2c_init_fanboard(I2CSlave
> *fan_mux, size_t eepromSize)
> >           /* TODO */
> >
> >           /* maxim,max31790 @ 0x20   (pwm) */
> > -        /* TODO */
> > +        i2c_slave_create_simple(bus, "max31790", 0x20);
> >
> >           /*
> >            * ti,tca6424 @ 0x22       (gpio)
> > @@ -182,7 +182,7 @@ static void fby4_i2c_init_fanboard(I2CSlave
> *fan_mux, size_t eepromSize)
> >            */
> >
> >           /* maxim,max31790 @ 0x2f   (pwm) */
> > -        /* TODO */
> > +        i2c_slave_create_simple(bus, "max31790", 0x2f);
> >
> >           /* maxim,max11615 @ 0x33   (adc) */
> >           /* TODO */
> > diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c
> > new file mode 100644
> > index 0000000000..b0430ea094
> > --- /dev/null
> > +++ b/hw/sensor/max31790.c
> > @@ -0,0 +1,537 @@
> > +/*
> > + * Maxim MAX31790 PMBus 6-Channel Fan Controller
> > + *
> > + * Datasheet:
> > + *
> https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31=
790.pdf
> > + *
> > + * Copyright 2026 9elements
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "hw/i2c/i2c.h"
> > +#include "qapi/error.h"
> > +#include "qapi/visitor.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/module.h"
> > +#include "qom/object.h"
> > +#include "trace.h"
> > +
> > +#define TYPE_MAX31790 "max31790"
> > +
> > +#define MAX31790_NUM_FANS 6
> > +#define MAX31790_NUM_TACHS 12
> > +
> > +#define MAX31790_REG_GLOBAL_CONFIG 0x00
> > +#define MAX31790_REG_PWM_FREQ 0x01
> > +
> > +/* 0x02 to 0x07: N =3D 0 .. 5 */
> > +#define MAX31790_REG_FAN_CONFIG(N) (0x02 + N)
> > +
> > +/* 0x08 to 0x0d: N =3D 0 .. 5 */
> > +#define MAX31790_REG_FAN_DYNAMICS(N) (0x08 + N)
> > +
> > +#define MAX31790_REG_FAN_FAULT_STATUS_2 0x10
> > +#define MAX31790_REG_FAN_FAULT_STATUS_1 0x11
> > +#define MAX31790_REG_FAN_FAULT_MASK_2 0x12
> > +#define MAX31790_REG_FAN_FAULT_MASK_1 0x13
> > +#define MAX31790_REG_FAILED_FAN_OPT 0x14
> > +
> > +/* 0x18 to 0x2f: N =3D 0 .. 11 */
> > +#define MAX31790_REG_TACH_COUNT_MSB(N) (0x18 + 2 * N)
> > +#define MAX31790_REG_TACH_COUNT_LSB(N) (0x19 + 2 * N)
> > +
> > +/* 0x30 to 0x3b: N =3D 0 .. 5 */
> > +#define MAX31790_REG_PWM_DUTY_CYCLE_MSB(N) (0x30 + 2 * N)
> > +#define MAX31790_REG_PWM_DUTY_CYCLE_LSB(N) (0x31 + 2 * N)
> > +
> > +/* .. reserved registers ... */
> > +
> > +/* 0x40 to 0x4b: N =3D 0 .. 5 */
> > +#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(N) (0x40 + 2 * N)
> > +#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(N) (0x41 + 2 * N)
> > +
> > +/* ... 'User Byte' registers ... */
> > +
> > +/* 0x50 to 0x5b: N =3D 0 .. 5 */
> > +#define MAX31790_REG_TACH_TARGET_COUNT_MSB(N) (0x50 + 2 * N)
> > +#define MAX31790_REG_TACH_TARGET_COUNT_LSB(N) (0x51 + 2 * N)
> > +
> > +struct MAX31790State {
> > +    I2CSlave i2c;
> > +
> > +    uint8_t fan_config[MAX31790_NUM_FANS];
> > +    uint8_t fan_dynamics[MAX31790_NUM_FANS];
> > +
> > +    uint16_t pwm[MAX31790_NUM_FANS];
> > +    uint16_t tach_target[MAX31790_NUM_FANS];
> > +
> > +    /*
> > +     * Fan speed is measured by counting the number of internal 8192Hz
> > +     * (fTOSC/4) clock cycles that take place during a select-
> > +     * able number of tachometer periods. The number of clock
> > +     * cycles counted (11-bit value) is stored in the associated
> > +     * TACH Count registers and the desired number of cycles
> > +     * is stored in the TACH Target Count registers.
> > +    */
> > +    uint16_t tach_count[MAX31790_NUM_TACHS];
> > +
> > +    /* command buffer */
> > +    uint8_t len;
> > +    uint8_t buf[2];
> > +
> > +    /* output buffer */
> > +    uint8_t outlen;
> > +    uint8_t outbuf[2];
> > +
> > +    /* selected register for read/write operation */
> > +    uint8_t pointer;
> > +};
> > +
> > +struct MAX31790Class {
> > +    I2CSlaveClass parent_class;
> > +};
> > +
> > +OBJECT_DECLARE_TYPE(MAX31790State, MAX31790Class, MAX31790)
> > +
> > +static void max31790_read(MAX31790State *s)
> > +{
> > +    size_t index =3D 0;
> > +    uint8_t out0 =3D 0;
> > +    uint8_t out1 =3D 0;
> > +
> > +    switch (s->pointer) {
> > +    case MAX31790_REG_FAN_CONFIG(0):
> > +    case MAX31790_REG_FAN_CONFIG(1):
> > +    case MAX31790_REG_FAN_CONFIG(2):
> > +    case MAX31790_REG_FAN_CONFIG(3):
> > +    case MAX31790_REG_FAN_CONFIG(4):
> > +    case MAX31790_REG_FAN_CONFIG(5):
> > +        out0 =3D s->fan_config[s->pointer - MAX31790_REG_FAN_CONFIG(0)=
];
> > +        break;
> > +    case MAX31790_REG_FAN_DYNAMICS(0):
> > +    case MAX31790_REG_FAN_DYNAMICS(1):
> > +    case MAX31790_REG_FAN_DYNAMICS(2):
> > +    case MAX31790_REG_FAN_DYNAMICS(3):
> > +    case MAX31790_REG_FAN_DYNAMICS(4):
> > +    case MAX31790_REG_FAN_DYNAMICS(5):
> > +        out0 =3D s->fan_dynamics[s->pointer -
> MAX31790_REG_FAN_DYNAMICS(0)];
> > +        break;
> > +    case MAX31790_REG_FAN_FAULT_STATUS_1:
> > +    case MAX31790_REG_FAN_FAULT_STATUS_2:
> > +        /* we do not have any fan fault */
> > +        out0 =3D 0x00;
> > +        out1 =3D 0x00;
> > +        break;
> > +    case MAX31790_REG_TACH_COUNT_MSB(0):
> > +    case MAX31790_REG_TACH_COUNT_MSB(1):
> > +    case MAX31790_REG_TACH_COUNT_MSB(2):
> > +    case MAX31790_REG_TACH_COUNT_MSB(3):
> > +    case MAX31790_REG_TACH_COUNT_MSB(4):
> > +    case MAX31790_REG_TACH_COUNT_MSB(5):
> > +    case MAX31790_REG_TACH_COUNT_MSB(6):
> > +    case MAX31790_REG_TACH_COUNT_MSB(7):
> > +    case MAX31790_REG_TACH_COUNT_MSB(8):
> > +    case MAX31790_REG_TACH_COUNT_MSB(9):
> > +    case MAX31790_REG_TACH_COUNT_MSB(10):
> > +    case MAX31790_REG_TACH_COUNT_MSB(11):
> > +        index =3D (s->pointer - MAX31790_REG_TACH_COUNT_MSB(0)) / 2;
> > +        out0 =3D (s->tach_count[index] >> 8) & 0xff;
> > +        out1 =3D s->tach_count[index] & 0xff;
> > +        break;
> > +
> > +    case MAX31790_REG_TACH_COUNT_LSB(0):
> > +    case MAX31790_REG_TACH_COUNT_LSB(1):
> > +    case MAX31790_REG_TACH_COUNT_LSB(2):
> > +    case MAX31790_REG_TACH_COUNT_LSB(3):
> > +    case MAX31790_REG_TACH_COUNT_LSB(4):
> > +    case MAX31790_REG_TACH_COUNT_LSB(5):
> > +    case MAX31790_REG_TACH_COUNT_LSB(6):
> > +    case MAX31790_REG_TACH_COUNT_LSB(7):
> > +    case MAX31790_REG_TACH_COUNT_LSB(8):
> > +    case MAX31790_REG_TACH_COUNT_LSB(9):
> > +    case MAX31790_REG_TACH_COUNT_LSB(10):
> > +    case MAX31790_REG_TACH_COUNT_LSB(11):
> > +        index =3D (s->pointer - MAX31790_REG_TACH_COUNT_LSB(0)) / 2;
> > +        out0 =3D s->tach_count[index] & 0xff;
> > +        break;
> > +
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(0):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(1):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(2):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(3):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(4):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_MSB(5):
> > +        index =3D (s->pointer - MAX31790_REG_PWM_DUTY_CYCLE_MSB(0)) / =
2;
> > +        out0 =3D (s->pwm[index] >> 8) & 0xff;
> > +        out1 =3D s->pwm[index] & 0xff;
> > +        break;
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(0):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(1):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(2):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(3):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(4):
> > +    case MAX31790_REG_PWM_DUTY_CYCLE_LSB(5):
> > +        index =3D (s->pointer - MAX31790_REG_PWM_DUTY_CYCLE_LSB(0)) / =
2;
> > +        out0 =3D s->pwm[index] & 0xff;
> > +        break;
> > +
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
> > +        index =3D (s->pointer -
> MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0)) / 2;
> > +        out0 =3D (s->pwm[index] >> 8) & 0xff;
> > +        out1 =3D s->pwm[index] & 0xff;
> > +        break;
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(1):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(2):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(3):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(4):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):
> > +        index =3D (s->pointer -
> MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0)) / 2;
> > +        out0 =3D s->pwm[index] & 0xff;
> > +        break;
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
> > +        index =3D (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_MSB(0))=
 /
> 2;
> > +        out0 =3D (s->tach_target[index] >> 8) & 0xff;
> > +        out1 =3D s->tach_target[index] & 0xff;
> > +        break;
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(0):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(1):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(2):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(3):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(4):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
> > +        index =3D (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_LSB(0))=
 /
> 2;
> > +        out0 =3D s->tach_target[index] & 0xff;
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "%s: read of register %d\n", __func__=
,
> > +                      s->pointer);
> > +        break;
> > +    }
> > +
> > +    s->outbuf[0] =3D out0;
> > +    s->outbuf[1] =3D out1;
> > +}
> > +
> > +static uint8_t max31790_get_speed_range(MAX31790State *s, size_t index=
)
> > +{
> > +    const uint16_t value =3D (s->fan_dynamics[index] >> 5);
> > +    return (value > 5) ? 32 : 1 << value;
> > +}
> > +
> > +static void max31790_set_rpm(MAX31790State *s, size_t index, uint16_t
> rpm)
> > +{
> > +    trace_max31790_rpm_write(s->i2c.address, index, rpm);
> > +
> > +    /*
> > +     * (see page 11) NP =3D number of tachometer pulses per revolution=
.
> > +     * Most general-purpose brushless DC fans produce two tachometer
> > +     * pulses per revolution.
> > +     */
> > +    const uint64_t sr =3D max31790_get_speed_range(s, index);
> > +
> > +    /* page 11: tach_count =3D 60 * SR * 8192 / (NP * RPM) */
> > +
> > +    /* prevent division by 0 */
> > +    rpm =3D (rpm =3D=3D 0) ? 1 : rpm;
> > +
> > +    /* simplified, assuming NP =3D 2 */
> > +    uint64_t tach_count =3D  (245760ULL * sr) / (uint64_t)rpm;
> > +
> > +    /* datasheet: lowest 5 bits are 0 */
> > +    s->tach_count[index] =3D tach_count << 5;
>
> Hmm, this is assigning a uint16_t from a uint64_t. There could be issues.
>
> > +
> > +    trace_max31790_tach_count_reg(s->i2c.address, index,
> s->tach_count[index]);
> > +}
> > +
> > +static void max31790_pwm_write(MAX31790State *s, size_t index, uint16_=
t
> value)
> > +{
> > +    trace_max31790_pwm_write(s->i2c.address, index, value);
> > +
> > +    s->pwm[index] =3D value;
> > +
> > +    /* last 7 bits in register are 0 , 9 bits remaining */
> > +    const uint16_t pwm_real =3D s->pwm[index] >> 7;
> > +
> > +    /* maximum value will be 511 */
> > +
> > +    /*
> > +     * This formula has magic values which model the relationship
> > +     * of PWM input to a fan. Not derived from datasheet.
> > +     */
> > +    max31790_set_rpm(s, index, 100 + pwm_real * 20);
> > +}
> > +
> > +static void max31790_write_2_byte(MAX31790State *s)
> > +{
> > +    size_t index =3D 0;
> > +    const uint8_t value0 =3D s->buf[0];
> > +    const uint8_t value1 =3D s->buf[1];
> > +
> > +    switch (s->pointer) {
> > +    case MAX31790_REG_FAN_CONFIG(0):
> > +    case MAX31790_REG_FAN_CONFIG(1):
> > +    case MAX31790_REG_FAN_CONFIG(2):
> > +    case MAX31790_REG_FAN_CONFIG(3):
> > +    case MAX31790_REG_FAN_CONFIG(4):
> > +    case MAX31790_REG_FAN_CONFIG(5):
> > +        break; /* handled by one byte write */
> > +    case MAX31790_REG_FAN_DYNAMICS(0):
> > +    case MAX31790_REG_FAN_DYNAMICS(1):
> > +    case MAX31790_REG_FAN_DYNAMICS(2):
> > +    case MAX31790_REG_FAN_DYNAMICS(3):
> > +    case MAX31790_REG_FAN_DYNAMICS(4):
> > +    case MAX31790_REG_FAN_DYNAMICS(5):
> > +        break; /* handled by one byte write */
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
> > +        index =3D (s->pointer -
> MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0)) / 2;
> > +        max31790_pwm_write(s, index, value0 << 8 | value1);
> > +        break;
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
> > +        index =3D (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_MSB(0))=
 /
> 2;
> > +        s->tach_target[index] =3D (value0 << 8) | value1;
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "%s: write to register %d\n", __func_=
_,
> > +                      s->pointer);
> > +        break;
> > +    }
> > +}
> > +
> > +static void max31790_write_1_byte(MAX31790State *s)
> > +{
> > +    size_t index =3D 0;
> > +    uint16_t pwm =3D 0;
> > +    const uint8_t value =3D s->buf[0];
> > +
> > +    switch (s->pointer) {
> > +    case MAX31790_REG_FAN_CONFIG(0):
> > +    case MAX31790_REG_FAN_CONFIG(1):
> > +    case MAX31790_REG_FAN_CONFIG(2):
> > +    case MAX31790_REG_FAN_CONFIG(3):
> > +    case MAX31790_REG_FAN_CONFIG(4):
> > +    case MAX31790_REG_FAN_CONFIG(5):
> > +        s->fan_config[s->pointer - MAX31790_REG_FAN_CONFIG(0)] =3D val=
ue;
> > +        break;
> > +    case MAX31790_REG_FAN_DYNAMICS(0):
> > +    case MAX31790_REG_FAN_DYNAMICS(1):
> > +    case MAX31790_REG_FAN_DYNAMICS(2):
> > +    case MAX31790_REG_FAN_DYNAMICS(3):
> > +    case MAX31790_REG_FAN_DYNAMICS(4):
> > +    case MAX31790_REG_FAN_DYNAMICS(5):
> > +        s->fan_dynamics[s->pointer - MAX31790_REG_FAN_DYNAMICS(0)] =3D
> value;
> > +        break;
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):
> > +        index =3D (s->pointer -
> MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0)) / 2;
> > +        pwm =3D (value << 8) | (s->pwm[index] & 0x00ff);
> > +        max31790_pwm_write(s, index, pwm);
> > +        break;
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(1):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(2):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(3):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(4):
> > +    case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):
> > +        index =3D (s->pointer -
> MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0)) / 2;
> > +        pwm =3D (s->pwm[index] & 0xff00) | (value & 0x00ff);
> > +        max31790_pwm_write(s, index, pwm);
> > +        break;
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):
> > +        index =3D (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_MSB(0))=
 /
> 2;
> > +        s->tach_target[index] =3D (s->tach_target[index] & 0x00ff) |
> (value << 8);
> > +        break;
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(0):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(1):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(2):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(3):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(4):
> > +    case MAX31790_REG_TACH_TARGET_COUNT_LSB(5):
> > +        index =3D (s->pointer - MAX31790_REG_TACH_TARGET_COUNT_LSB(0))=
 /
> 2;
> > +        s->tach_target[index] =3D (s->tach_target[index] & 0xff00) |
> value;
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "%s: write to register %d\n", __func_=
_,
> > +                      s->pointer);
> > +        break;
> > +    }
> > +}
> > +
> > +static int max31790_send(I2CSlave *i2c, uint8_t data)
> > +{
> > +    MAX31790State *s =3D MAX31790(i2c);
> > +
> > +    trace_max31790_send(s->i2c.address, data);
> > +
> > +    if (s->len =3D=3D 0) {
> > +        /* first byte is the register pointer for a read / write
> operation */
> > +        s->pointer =3D data;
> > +        s->len++;
> > +        return 0;
> > +    }
> > +
> > +    if (s->len > 2) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: write too many bytes\n",
> __func__);
> > +        return 1; /* NAK */
> > +    }
> > +
> > +    /* second / third byte is the data to write */
> > +    s->buf[s->len - 1] =3D data;
> > +    s->len++;
> > +
> > +    if (s->len =3D=3D 2) {
> > +        max31790_write_1_byte(s);
> > +    } else if (s->len =3D=3D 3) {
> > +        max31790_write_2_byte(s);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static uint8_t max31790_recv(I2CSlave *i2c)
> > +{
> > +    MAX31790State *s =3D MAX31790(i2c);
> > +    trace_max31790_recv(s->i2c.address, s->pointer);
> > +
> > +    max31790_read(s);
> > +    s->len =3D 0;
> > +
> > +    if (s->outlen >=3D 2) {
> > +        /* error */
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: guest over read\n",
> __func__);
> > +        s->outlen =3D 0;
> > +    }
> > +
> > +    const uint8_t data =3D s->outbuf[s->outlen++];
> > +
> > +    trace_max31790_recv_return(s->i2c.address, data);
> > +    return data;
> > +}
> > +
> > +static int max31790_event(I2CSlave *i2c, enum i2c_event event)
> > +{
> > +    MAX31790State *s =3D MAX31790(i2c);
> > +
> > +    trace_max31790_event(s->i2c.address, event);
> > +
> > +    switch (event) {
> > +    case I2C_START_RECV:
> > +        s->outlen =3D 0;
> > +        break;
> > +    case I2C_START_SEND:
> > +        s->len =3D 0;
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_max31790 =3D {
> > +    .name =3D TYPE_MAX31790,
> > +    .version_id =3D 0,
> > +    .minimum_version_id =3D 0,
> > +    .fields =3D
> > +        (const VMStateField[]){
> > +            VMSTATE_UINT8(len, MAX31790State),
> > +            VMSTATE_UINT8_ARRAY(fan_config, MAX31790State,
> MAX31790_NUM_FANS),
> > +            VMSTATE_UINT8_ARRAY(fan_dynamics, MAX31790State,
> MAX31790_NUM_FANS),
> > +            VMSTATE_UINT16_ARRAY(pwm, MAX31790State, MAX31790_NUM_FANS=
),
> > +            VMSTATE_UINT16_ARRAY(tach_target, MAX31790State,
> MAX31790_NUM_FANS),
> > +            VMSTATE_UINT16_ARRAY(tach_count, MAX31790State,
> MAX31790_NUM_TACHS),
> > +            VMSTATE_UINT8_ARRAY(buf, MAX31790State, 2),
> > +            VMSTATE_UINT8(outlen, MAX31790State),
> > +            VMSTATE_UINT8_ARRAY(outbuf, MAX31790State, 2),
> > +            VMSTATE_UINT8(pointer, MAX31790State),
> > +            VMSTATE_I2C_SLAVE(i2c, MAX31790State),
> VMSTATE_END_OF_LIST() }
> > +};
> > +
> > +static void max31790_reset(DeviceState *dev)
> > +{
> > +    MAX31790State *s =3D MAX31790(dev);
> > +
> > +    for (int i =3D 0; i < MAX31790_NUM_FANS; i++) {
> > +        /* POR-State 0b 0XX0 0000 */
> > +        s->fan_config[i] =3D 0b00000000;
> > +
> > +        /* same as POR-State */
> > +        s->tach_target[i] =3D 0b0011110000000000;
>
> tach_target[] array size is  MAX31790_NUM_TACHS =3D 12. The loop uses
> MAX31790_NUM_FANS =3D 6
>
>
>
> > +
> > +        /* same as POR-State */
> > +        s->fan_dynamics[i] =3D 0b01001100;
> > +    }
> > +
> > +    /* this will set both pwm and tach count */
> > +    for (int i =3D 0; i < MAX31790_NUM_TACHS; i++) {
>
>
> pwm[] array size is MAX31790_NUM_FANS =3D 6. The loop uses
> MAX31790_NUM_TACHS =3D 12. this is an out-of-bounds write.
> > +        max31790_pwm_write(s, i, 0x4444);
>
> How does the 0x4444 value relates to the one used in the tests ?
>
> > +    }
> > +}
> > +
> > +static void max31790_realize(DeviceState *dev, Error **errp)
> > +{
> > +    MAX31790State *s =3D MAX31790(dev);
> > +
> > +    trace_max31790_realize(s->i2c.address);
> > +}
> > +
> > +static void max31790_class_init(ObjectClass *klass, const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> > +
> > +    dc->realize =3D max31790_realize;
> > +    dc->desc =3D "Maxim MAX31790 6-Channel Fan Controller";
> > +    dc->vmsd =3D &vmstate_max31790;
> > +    dc->legacy_reset =3D max31790_reset;
> > +    k->event =3D max31790_event;
> > +    k->recv =3D max31790_recv;
> > +    k->send =3D max31790_send;
> > +}
> > +
> > +static const TypeInfo max31790_info =3D {
> > +    .name =3D TYPE_MAX31790,
> > +    .parent =3D TYPE_I2C_SLAVE,
> > +    .instance_size =3D sizeof(MAX31790State),
> > +    .class_size =3D sizeof(MAX31790Class),
> > +    .class_init =3D max31790_class_init,
> > +};
> > +
> > +static void max31790_register_types(void)
> > +{
> > +    type_register_static(&max31790_info);
> > +}
> > +
> > +type_init(max31790_register_types)
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index 5b198402d5..99864eb878 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -552,6 +552,7 @@ config ASPEED_SOC
> >       select LED
> >       select PMBUS
> >       select MAX31785
> > +    select MAX31790
> >       select FSI_APB2OPB_ASPEED
> >       select AT24C
> >       select PCI_EXPRESS
> > diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig
> > index bc6331b4ab..767f198e92 100644
> > --- a/hw/sensor/Kconfig
> > +++ b/hw/sensor/Kconfig
> > @@ -43,3 +43,7 @@ config ISL_PMBUS_VR
> >   config MAX31785
> >       bool
> >       depends on PMBUS
> > +
> > +config MAX31790
> > +    bool
> > +    depends on I2C
> > diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build
> > index 420fdc3359..4987c3b253 100644
> > --- a/hw/sensor/meson.build
> > +++ b/hw/sensor/meson.build
> > @@ -8,3 +8,4 @@ system_ss.add(when: 'CONFIG_MAX34451', if_true:
> files('max34451.c'))
> >   system_ss.add(when: 'CONFIG_LSM303DLHC_MAG', if_true:
> files('lsm303dlhc_mag.c'))
> >   system_ss.add(when: 'CONFIG_ISL_PMBUS_VR', if_true:
> files('isl_pmbus_vr.c'))
> >   system_ss.add(when: 'CONFIG_MAX31785', if_true: files('max31785.c'))
> > +system_ss.add(when: 'CONFIG_MAX31790', if_true: files('max31790.c'))
> > diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
> > index a3fe54fa6d..0bde02e676 100644
> > --- a/hw/sensor/trace-events
> > +++ b/hw/sensor/trace-events
> > @@ -4,3 +4,14 @@
> >   tmp105_read(uint8_t dev, uint8_t addr) "device: 0x%02x, addr: 0x%02x"
> >   tmp105_write(uint8_t dev, uint8_t addr) "device: 0x%02x, addr 0x%02x"
> >   tmp105_write_shutdown(uint8_t dev) "device: 0x%02x"
> > +
> > +# max31790.c
> > +max31790_send(uint8_t i2c_addr, uint8_t send) "i2c_addr: 0x%02x, data:
> 0x%02x"
> > +max31790_recv(uint8_t i2c_addr, uint8_t reg_addr) "i2c_addr: 0x%02x,
> reg_addr: 0x%02x"
> > +max31790_recv_return(uint8_t i2c_addr, uint8_t data) "i2c_addr: 0x%02x=
,
> returns: 0x%02x"
> > +max31790_event(uint8_t i2c_addr, uint8_t event) "i2c_addr: 0x%02x,
> event: 0x%02x"
> > +max31790_realize(uint8_t i2c_addr) "i2c_addr: 0x%02x"
> > +max31790_pwm_write(uint8_t i2c_addr, size_t index, uint16_t value)
> "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
> > +max31790_rpm_write(uint8_t i2c_addr, size_t index, uint16_t value)
> "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
> > +max31790_tach_count_reg(uint8_t i2c_addr, size_t index, uint16_t value=
)
> "i2c_addr: 0x%02x, index: %zu, value: 0x%04x"
> > +
> > diff --git a/tests/functional/arm/test_aspeed_fby4.py
> b/tests/functional/arm/test_aspeed_fby4.py
> > index a521834f79..dc2437a533 100755
> > --- a/tests/functional/arm/test_aspeed_fby4.py
> > +++ b/tests/functional/arm/test_aspeed_fby4.py
> > @@ -8,6 +8,8 @@
> >   from qemu_test import wait_for_console_pattern
> >   from aspeed import AspeedTest
> >
>
> Drop the extra newline
>
> > +from qemu_test import wait_for_console_pattern
> > +from qemu_test import exec_command_and_wait_for_pattern
>
> redundant import.
>
> >
> >   class YosemiteV4Machine(AspeedTest):
> >
> > @@ -34,6 +36,30 @@ def do_test_arm_aspeed_openbmc_no_network(self,
> machine, image, uboot,
> >           # different from the other machines.
> >           self.wait_for_console_pattern('yosemite4 login:')
> >
> > +        # perform login
> > +        exec_command_and_wait_for_pattern(self,
> > +                                          "root", "Password:");
> > +
> > +        exec_command_and_wait_for_pattern(self, "0penBmc", "#");
> > +
> > +        # MAX31790 test
> > +        exec_command_and_wait_for_pattern(self,
> > +            "cat /sys/class/hwmon/hwmon2/name", "max31790");
> > +        exec_command_and_wait_for_pattern(self,
> > +            "cat /sys/class/hwmon/hwmon2/fan1_input", "7447");
> > +        exec_command_and_wait_for_pattern(self,
> > +            "cat /sys/class/hwmon/hwmon2/fan1_enable", "1");
> > +        exec_command_and_wait_for_pattern(self,
> > +            "cat /sys/class/hwmon/hwmon2/fan1_fault", "0");
> > +        exec_command_and_wait_for_pattern(self,
> > +            "echo 1 > /sys/class/hwmon/hwmon2/pwm1", "root@yosemite4")=
;
> > +        exec_command_and_wait_for_pattern(self,
> > +            "cat /sys/class/hwmon/hwmon2/fan1_input", "140");
> > +        exec_command_and_wait_for_pattern(self,
> > +            "echo 255 > /sys/class/hwmon/hwmon2/pwm1", "root@yosemite4
> ");
> > +        exec_command_and_wait_for_pattern(self,
> > +            "cat /sys/class/hwmon/hwmon2/fan1_input", "10685");
> > +
> >       def test_arm_ast2600_yosemitev4_openbmc(self):
> >           image_path =3D self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
> >
>
>

--000000000000d2f5090653e541f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Cedric,<br><br>&gt; How does the 0x4444 value rela=
tes to the one used in the tests ?<br><br>There is something in the image w=
hich is writing the pwm, if you look at the traces<br>it should be more obv=
ious in the next patchset (v6, not yet sent)<br><br>max31790_pwm_write i2c_=
addr: 0x2f, index: 5, value: 0xb200<br>max31790_rpm_write i2c_addr: 0x2f, i=
ndex: 5, value: 0x1c34<br>max31790_tach_count_reg i2c_addr: 0x2f, index: 5,=
 value: 0x0440<br>max31790_send i2c_addr: 0x2f, data: 0x80<br>max31790_pwm_=
write i2c_addr: 0x2f, index: 5, value: 0xb280<br>max31790_rpm_write i2c_add=
r: 0x2f, index: 5, value: 0x1c48<br>max31790_tach_count_reg i2c_addr: 0x2f,=
 index: 5, value: 0x0420<br><br>Looking then at the latest fan dynamics rea=
d from the driver<br><br>max31790_fan_dynamics_read i2c_addr: 0x20, channel=
: 0, value: 0x0000<br>max31790_recv_return i2c_addr: 0x20, reg_addr: 0x08, =
returns: 0x00<br><br>and plugging that into the equation<br><br>&gt;&gt;&gt=
; (60 * 1 * 8192) / (0x0420 &gt;&gt; 4)<br>7447.272727272727<br><br>we get =
the value found in the test. The fan dynamics are wrong because the reset w=
as not being called.<br>Should be fixed in the next patchset. The newly add=
ed traces should make things clearer and the functional test will also have=
 a comment<br></div><div>going through an example calculation.</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">Am Mo., 1. Juni 2026 um 11:17=C2=A0Uhr schrieb C=C3=A9dric Le Goat=
er &lt;<a href=3D"mailto:clg@kaod.org">clg@kaod.org</a>&gt;:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 5/29/26 14:37, Alexander Ha=
nsen wrote:<br>
&gt; Product: [1]<br>
&gt; Datasheet: [2]<br>
&gt; <br>
&gt; MAX31790 Support:<br>
&gt; - fan inputs are reading<br>
&gt; - tach reading propertional to pwm setting from linux driver<br>
&gt; - fans do not show any fault<br>
&gt; - 6 PWM registers influence 6 TACH registers<br>
&gt; <br>
&gt; There is intentional stub behavior in some places and various function=
s<br>
&gt; of the device are currently unsupported.<br>
&gt; <br>
&gt; MAX31790 currently unsupported:<br>
&gt; - slave address restriction<br>
&gt; - fan dynamics<br>
&gt; - spin-up configuration<br>
&gt; - fault state / failure possibility<br>
&gt; - rate-of-change control<br>
&gt; - tach mode<br>
&gt; - mixed layouts where number of fans !=3D number of tachs<br>
&gt; - see Figure 5.9 in [2] for example of mixed layout<br>
&gt; <br>
&gt; Anyone could expand it in the future for more accurate emulation.<br>
&gt; <br>
&gt; The reason for adding this device is to support Yosemite V4 emulation.=
<br>
&gt; <br>
&gt; Tested: on yosemite 4 qemu<br>
&gt; <br>
&gt; root@yosemite4:~# ls /sys/class/hwmon/hwmon2/<br>
&gt; device=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fan2_fault=C2=A0 =C2=
=A0fan3_target=C2=A0 fan5_fault=C2=A0 =C2=A0fan6_target=C2=A0 pwm2=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pwm5<br>
&gt; fan1_enable=C2=A0 fan2_input=C2=A0 =C2=A0fan4_enable=C2=A0 fan5_input=
=C2=A0 =C2=A0name=C2=A0 =C2=A0 =C2=A0 pwm2_enable=C2=A0 pwm5_enable<br>
&gt; fan1_fault=C2=A0 =C2=A0fan2_target=C2=A0 fan4_fault=C2=A0 =C2=A0fan5_t=
arget=C2=A0 of_node=C2=A0 =C2=A0pwm3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pwm6<=
br>
&gt; fan1_input=C2=A0 =C2=A0fan3_enable=C2=A0 fan4_input=C2=A0 =C2=A0fan6_e=
nable=C2=A0 power=C2=A0 =C2=A0 =C2=A0pwm3_enable=C2=A0 pwm6_enable<br>
&gt; fan1_target=C2=A0 fan3_fault=C2=A0 =C2=A0fan4_target=C2=A0 fan6_fault=
=C2=A0 =C2=A0pwm1=C2=A0 =C2=A0 =C2=A0 pwm4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0subsystem<br>
&gt; fan2_enable=C2=A0 fan3_input=C2=A0 =C2=A0fan5_enable=C2=A0 fan6_input=
=C2=A0 =C2=A0pwm1_enable=C2=A0 pwm4_enable=C2=A0 uevent<br>
&gt; root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_input<br>
&gt; 4551<br>
&gt; root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_enable<br>
&gt; 1<br>
&gt; root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_fault<br>
&gt; 0<br>
&gt; root@yosemite4:~# cat /sys/class/hwmon/hwmon2/fan1_target<br>
&gt; 2048<br>
&gt; root@yosemite4:~# cat /sys/class/hwmon/hwmon2/pwm1<br>
&gt; 178<br>
&gt; root@yosemite4:~# cat /sys/class/hwmon/hwmon2/name<br>
&gt; max31790<br>
&gt; <br>
&gt; Trace output:<br>
&gt; max31790_realize i2c_addr: 0x20<br>
&gt; max31790_realize i2c_addr: 0x2f<br>
&gt; max31790_realize i2c_addr: 0x20<br>
&gt; max31790_realize i2c_addr: 0x2f<br>
&gt; max31790_event i2c_addr: 0x20, event: 0x01<br>
&gt; max31790_send i2c_addr: 0x20, data: 0x02<br>
&gt; max31790_event i2c_addr: 0x20, event: 0x00<br>
&gt; max31790_recv i2c_addr: 0x20, reg_addr: 0x02<br>
&gt; max31790_recv_return i2c_addr: 0x20, returns: 0x08<br>
&gt; ...<br>
&gt; <br>
&gt; References:<br>
&gt; [1] <a href=3D"https://www.analog.com/en/products/MAX31790.html" rel=
=3D"noreferrer" target=3D"_blank">https://www.analog.com/en/products/MAX317=
90.html</a><br>
&gt; [2] <a href=3D"https://www.analog.com/media/en/technical-documentation=
/data-sheets/MAX31790.pdf" rel=3D"noreferrer" target=3D"_blank">https://www=
.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf</a><b=
r>
&gt; <br>
&gt; Cc: Titus Rwantare &lt;<a href=3D"mailto:titusr@google.com" target=3D"=
_blank">titusr@google.com</a>&gt;<br>
&gt; Cc: &quot;C=C3=A9dric Le Goater&quot; &lt;<a href=3D"mailto:clg@kaod.o=
rg" target=3D"_blank">clg@kaod.org</a>&gt; (maintainer:ASPEED BMCs)<br>
&gt; Cc: Jonathan Cameron &lt;<a href=3D"mailto:jonathan.cameron@huawei.com=
" target=3D"_blank">jonathan.cameron@huawei.com</a>&gt;<br>
&gt; Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D=
"_blank">pbonzini@redhat.com</a>&gt;<br>
&gt; Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" targ=
et=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; Cc: &quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"mailto:phil=
md@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank">qemu-arm@=
nongnu.org</a><br>
&gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-de=
vel@nongnu.org</a><br>
&gt; Signed-off-by: Alexander Hansen &lt;<a href=3D"mailto:alexander.hansen=
@9elements.com" target=3D"_blank">alexander.hansen@9elements.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
 +<br>
&gt;=C2=A0 =C2=A0hw/arm/aspeed_ast2600_fby4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 =C2=A0hw/sensor/max31790.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 537 +++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br=
>
&gt;=C2=A0 =C2=A0hw/sensor/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0hw/sensor/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/sensor/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 11 +<br>
&gt;=C2=A0 =C2=A0tests/functional/arm/test_aspeed_fby4.py |=C2=A0 26 ++<br>
&gt;=C2=A0 =C2=A08 files changed, 583 insertions(+), 2 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/sensor/max31790.c<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index cd5c4831e2..2a0dbd1cc4 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -3987,6 +3987,7 @@ S: Maintained<br>
&gt;=C2=A0 =C2=A0F: hw/i2c/pmbus_device.c<br>
&gt;=C2=A0 =C2=A0F: hw/sensor/adm1272.c<br>
&gt;=C2=A0 =C2=A0F: hw/sensor/isl_pmbus_vr.c<br>
&gt; +F: hw/sensor/max31790.c<br>
&gt;=C2=A0 =C2=A0F: hw/sensor/max34451.c<br>
&gt;=C2=A0 =C2=A0F: include/hw/i2c/pmbus_device.h<br>
&gt;=C2=A0 =C2=A0F: include/hw/sensor/isl_pmbus_vr.h<br>
&gt; diff --git a/hw/arm/aspeed_ast2600_fby4.c b/hw/arm/aspeed_ast2600_fby4=
.c<br>
&gt; index 89fb0ac2fd..1f391022a2 100644<br>
&gt; --- a/hw/arm/aspeed_ast2600_fby4.c<br>
&gt; +++ b/hw/arm/aspeed_ast2600_fby4.c<br>
&gt; @@ -164,7 +164,7 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_m=
ux, size_t eepromSize)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* maxim,max31790 @ 0x20=C2=A0=
 =C2=A0(pwm) */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_create_simple(bus, &quot;max317=
90&quot;, 0x20);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * ti,tca6424 @ 0x22=C2=A0 =C2=
=A0 =C2=A0 =C2=A0(gpio)<br>
&gt; @@ -182,7 +182,7 @@ static void fby4_i2c_init_fanboard(I2CSlave *fan_m=
ux, size_t eepromSize)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* maxim,max31790 @ 0x2f=C2=A0=
 =C2=A0(pwm) */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c_slave_create_simple(bus, &quot;max317=
90&quot;, 0x2f);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* maxim,max11615 @ 0x33=C2=A0=
 =C2=A0(adc) */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO */<br>
&gt; diff --git a/hw/sensor/max31790.c b/hw/sensor/max31790.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..b0430ea094<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/sensor/max31790.c<br>
&gt; @@ -0,0 +1,537 @@<br>
&gt; +/*<br>
&gt; + * Maxim MAX31790 PMBus 6-Channel Fan Controller<br>
&gt; + *<br>
&gt; + * Datasheet:<br>
&gt; + * <a href=3D"https://www.analog.com/media/en/technical-documentation=
/data-sheets/MAX31790.pdf" rel=3D"noreferrer" target=3D"_blank">https://www=
.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf</a><b=
r>
&gt; + *<br>
&gt; + * Copyright 2026 9elements<br>
&gt; + *<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;hw/i2c/i2c.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qapi/visitor.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +<br>
&gt; +#define TYPE_MAX31790 &quot;max31790&quot;<br>
&gt; +<br>
&gt; +#define MAX31790_NUM_FANS 6<br>
&gt; +#define MAX31790_NUM_TACHS 12<br>
&gt; +<br>
&gt; +#define MAX31790_REG_GLOBAL_CONFIG 0x00<br>
&gt; +#define MAX31790_REG_PWM_FREQ 0x01<br>
&gt; +<br>
&gt; +/* 0x02 to 0x07: N =3D 0 .. 5 */<br>
&gt; +#define MAX31790_REG_FAN_CONFIG(N) (0x02 + N)<br>
&gt; +<br>
&gt; +/* 0x08 to 0x0d: N =3D 0 .. 5 */<br>
&gt; +#define MAX31790_REG_FAN_DYNAMICS(N) (0x08 + N)<br>
&gt; +<br>
&gt; +#define MAX31790_REG_FAN_FAULT_STATUS_2 0x10<br>
&gt; +#define MAX31790_REG_FAN_FAULT_STATUS_1 0x11<br>
&gt; +#define MAX31790_REG_FAN_FAULT_MASK_2 0x12<br>
&gt; +#define MAX31790_REG_FAN_FAULT_MASK_1 0x13<br>
&gt; +#define MAX31790_REG_FAILED_FAN_OPT 0x14<br>
&gt; +<br>
&gt; +/* 0x18 to 0x2f: N =3D 0 .. 11 */<br>
&gt; +#define MAX31790_REG_TACH_COUNT_MSB(N) (0x18 + 2 * N)<br>
&gt; +#define MAX31790_REG_TACH_COUNT_LSB(N) (0x19 + 2 * N)<br>
&gt; +<br>
&gt; +/* 0x30 to 0x3b: N =3D 0 .. 5 */<br>
&gt; +#define MAX31790_REG_PWM_DUTY_CYCLE_MSB(N) (0x30 + 2 * N)<br>
&gt; +#define MAX31790_REG_PWM_DUTY_CYCLE_LSB(N) (0x31 + 2 * N)<br>
&gt; +<br>
&gt; +/* .. reserved registers ... */<br>
&gt; +<br>
&gt; +/* 0x40 to 0x4b: N =3D 0 .. 5 */<br>
&gt; +#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(N) (0x40 + 2 * N)<br>
&gt; +#define MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(N) (0x41 + 2 * N)<br>
&gt; +<br>
&gt; +/* ... &#39;User Byte&#39; registers ... */<br>
&gt; +<br>
&gt; +/* 0x50 to 0x5b: N =3D 0 .. 5 */<br>
&gt; +#define MAX31790_REG_TACH_TARGET_COUNT_MSB(N) (0x50 + 2 * N)<br>
&gt; +#define MAX31790_REG_TACH_TARGET_COUNT_LSB(N) (0x51 + 2 * N)<br>
&gt; +<br>
&gt; +struct MAX31790State {<br>
&gt; +=C2=A0 =C2=A0 I2CSlave i2c;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint8_t fan_config[MAX31790_NUM_FANS];<br>
&gt; +=C2=A0 =C2=A0 uint8_t fan_dynamics[MAX31790_NUM_FANS];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint16_t pwm[MAX31790_NUM_FANS];<br>
&gt; +=C2=A0 =C2=A0 uint16_t tach_target[MAX31790_NUM_FANS];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Fan speed is measured by counting the number of=
 internal 8192Hz<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* (fTOSC/4) clock cycles that take place during a=
 select-<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* able number of tachometer periods. The number o=
f clock<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* cycles counted (11-bit value) is stored in the =
associated<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* TACH Count registers and the desired number of =
cycles<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* is stored in the TACH Target Count registers.<b=
r>
&gt; +=C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 uint16_t tach_count[MAX31790_NUM_TACHS];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* command buffer */<br>
&gt; +=C2=A0 =C2=A0 uint8_t len;<br>
&gt; +=C2=A0 =C2=A0 uint8_t buf[2];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* output buffer */<br>
&gt; +=C2=A0 =C2=A0 uint8_t outlen;<br>
&gt; +=C2=A0 =C2=A0 uint8_t outbuf[2];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* selected register for read/write operation */<br>
&gt; +=C2=A0 =C2=A0 uint8_t pointer;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct MAX31790Class {<br>
&gt; +=C2=A0 =C2=A0 I2CSlaveClass parent_class;<br>
&gt; +};<br>
&gt; +<br>
&gt; +OBJECT_DECLARE_TYPE(MAX31790State, MAX31790Class, MAX31790)<br>
&gt; +<br>
&gt; +static void max31790_read(MAX31790State *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t index =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint8_t out0 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint8_t out1 =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (s-&gt;pointer) {<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D s-&gt;fan_config[s-&gt;pointer -=
 MAX31790_REG_FAN_CONFIG(0)];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D s-&gt;fan_dynamics[s-&gt;pointer=
 - MAX31790_REG_FAN_DYNAMICS(0)];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_FAULT_STATUS_1:<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_FAULT_STATUS_2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* we do not have any fan fault */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D 0x00;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out1 =3D 0x00;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(5):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(6):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(7):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(8):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(9):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(10):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_MSB(11):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_T=
ACH_COUNT_MSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D (s-&gt;tach_count[index] &gt;&gt=
; 8) &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out1 =3D s-&gt;tach_count[index] &amp; 0x=
ff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(5):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(6):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(7):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(8):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(9):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(10):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_COUNT_LSB(11):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_T=
ACH_COUNT_LSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D s-&gt;tach_count[index] &amp; 0x=
ff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_MSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_MSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_MSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_MSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_MSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_MSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_P=
WM_DUTY_CYCLE_MSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D (s-&gt;pwm[index] &gt;&gt; 8) &a=
mp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out1 =3D s-&gt;pwm[index] &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_LSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_LSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_LSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_LSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_LSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_DUTY_CYCLE_LSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_P=
WM_DUTY_CYCLE_LSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D s-&gt;pwm[index] &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_P=
WM_TARGET_DUTY_CYCLE_MSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D (s-&gt;pwm[index] &gt;&gt; 8) &a=
mp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out1 =3D s-&gt;pwm[index] &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_P=
WM_TARGET_DUTY_CYCLE_LSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D s-&gt;pwm[index] &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_T=
ACH_TARGET_COUNT_MSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D (s-&gt;tach_target[index] &gt;&g=
t; 8) &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out1 =3D s-&gt;tach_target[index] &amp; 0=
xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_T=
ACH_TARGET_COUNT_LSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out0 =3D s-&gt;tach_target[index] &amp; 0=
xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: read o=
f register %d\n&quot;, __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 s-&gt;pointer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;outbuf[0] =3D out0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;outbuf[1] =3D out1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint8_t max31790_get_speed_range(MAX31790State *s, size_t inde=
x)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const uint16_t value =3D (s-&gt;fan_dynamics[index] &gt=
;&gt; 5);<br>
&gt; +=C2=A0 =C2=A0 return (value &gt; 5) ? 32 : 1 &lt;&lt; value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void max31790_set_rpm(MAX31790State *s, size_t index, uint16_t=
 rpm)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 trace_max31790_rpm_write(s-&gt;i2c.address, index, rpm)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* (see page 11) NP =3D number of tachometer pulse=
s per revolution.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Most general-purpose brushless DC fans produce =
two tachometer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* pulses per revolution.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 const uint64_t sr =3D max31790_get_speed_range(s, index=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* page 11: tach_count =3D 60 * SR * 8192 / (NP * RPM) =
*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* prevent division by 0 */<br>
&gt; +=C2=A0 =C2=A0 rpm =3D (rpm =3D=3D 0) ? 1 : rpm;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* simplified, assuming NP =3D 2 */<br>
&gt; +=C2=A0 =C2=A0 uint64_t tach_count =3D=C2=A0 (245760ULL * sr) / (uint6=
4_t)rpm;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* datasheet: lowest 5 bits are 0 */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tach_count[index] =3D tach_count &lt;&lt; 5;<br>
<br>
Hmm, this is assigning a uint16_t from a uint64_t. There could be issues.<b=
r>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_max31790_tach_count_reg(s-&gt;i2c.address, index,=
 s-&gt;tach_count[index]);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void max31790_pwm_write(MAX31790State *s, size_t index, uint16=
_t value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 trace_max31790_pwm_write(s-&gt;i2c.address, index, valu=
e);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pwm[index] =3D value;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* last 7 bits in register are 0 , 9 bits remaining */<=
br>
&gt; +=C2=A0 =C2=A0 const uint16_t pwm_real =3D s-&gt;pwm[index] &gt;&gt; 7=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* maximum value will be 511 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* This formula has magic values which model the r=
elationship<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* of PWM input to a fan. Not derived from datashe=
et.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 max31790_set_rpm(s, index, 100 + pwm_real * 20);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void max31790_write_2_byte(MAX31790State *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t index =3D 0;<br>
&gt; +=C2=A0 =C2=A0 const uint8_t value0 =3D s-&gt;buf[0];<br>
&gt; +=C2=A0 =C2=A0 const uint8_t value1 =3D s-&gt;buf[1];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (s-&gt;pointer) {<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break; /* handled by one byte write */<br=
>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break; /* handled by one byte write */<br=
>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_P=
WM_TARGET_DUTY_CYCLE_MSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 max31790_pwm_write(s, index, value0 &lt;&=
lt; 8 | value1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_T=
ACH_TARGET_COUNT_MSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tach_target[index] =3D (value0 &lt;=
&lt; 8) | value1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: write =
to register %d\n&quot;, __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 s-&gt;pointer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void max31790_write_1_byte(MAX31790State *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t index =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint16_t pwm =3D 0;<br>
&gt; +=C2=A0 =C2=A0 const uint8_t value =3D s-&gt;buf[0];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (s-&gt;pointer) {<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_CONFIG(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;fan_config[s-&gt;pointer - MAX31790=
_REG_FAN_CONFIG(0)] =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_FAN_DYNAMICS(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;fan_dynamics[s-&gt;pointer - MAX317=
90_REG_FAN_DYNAMICS(0)] =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_MSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_P=
WM_TARGET_DUTY_CYCLE_MSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwm =3D (value &lt;&lt; 8) | (s-&gt;pwm[i=
ndex] &amp; 0x00ff);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 max31790_pwm_write(s, index, pwm);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_PWM_TARGET_DUTY_CYCLE_LSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_P=
WM_TARGET_DUTY_CYCLE_LSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwm =3D (s-&gt;pwm[index] &amp; 0xff00) |=
 (value &amp; 0x00ff);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 max31790_pwm_write(s, index, pwm);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_MSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_T=
ACH_TARGET_COUNT_MSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tach_target[index] =3D (s-&gt;tach_=
target[index] &amp; 0x00ff) | (value &lt;&lt; 8);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(0):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(1):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(2):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(3):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(4):<br>
&gt; +=C2=A0 =C2=A0 case MAX31790_REG_TACH_TARGET_COUNT_LSB(5):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D (s-&gt;pointer - MAX31790_REG_T=
ACH_TARGET_COUNT_LSB(0)) / 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tach_target[index] =3D (s-&gt;tach_=
target[index] &amp; 0xff00) | value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: write =
to register %d\n&quot;, __func__,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 s-&gt;pointer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int max31790_send(I2CSlave *i2c, uint8_t data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MAX31790State *s =3D MAX31790(i2c);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_max31790_send(s-&gt;i2c.address, data);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;len =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* first byte is the register pointer for=
 a read / write operation */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;pointer =3D data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;len++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;len &gt; 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
write too many bytes\n&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1; /* NAK */<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* second / third byte is the data to write */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;buf[s-&gt;len - 1] =3D data;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;len++;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;len =3D=3D 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 max31790_write_1_byte(s);<br>
&gt; +=C2=A0 =C2=A0 } else if (s-&gt;len =3D=3D 3) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 max31790_write_2_byte(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint8_t max31790_recv(I2CSlave *i2c)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MAX31790State *s =3D MAX31790(i2c);<br>
&gt; +=C2=A0 =C2=A0 trace_max31790_recv(s-&gt;i2c.address, s-&gt;pointer);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 max31790_read(s);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;len =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;outlen &gt;=3D 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* error */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
guest over read\n&quot;, __func__);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;outlen =3D 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 const uint8_t data =3D s-&gt;outbuf[s-&gt;outlen++];<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_max31790_recv_return(s-&gt;i2c.address, data);<br=
>
&gt; +=C2=A0 =C2=A0 return data;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int max31790_event(I2CSlave *i2c, enum i2c_event event)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MAX31790State *s =3D MAX31790(i2c);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_max31790_event(s-&gt;i2c.address, event);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (event) {<br>
&gt; +=C2=A0 =C2=A0 case I2C_START_RECV:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;outlen =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case I2C_START_SEND:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription vmstate_max31790 =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_MAX31790,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 0,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 0,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (const VMStateField[]){<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(len, MAX31790=
State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(fan_con=
fig, MAX31790State, MAX31790_NUM_FANS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(fan_dyn=
amics, MAX31790State, MAX31790_NUM_FANS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16_ARRAY(pwm, M=
AX31790State, MAX31790_NUM_FANS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16_ARRAY(tach_t=
arget, MAX31790State, MAX31790_NUM_FANS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16_ARRAY(tach_c=
ount, MAX31790State, MAX31790_NUM_TACHS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(buf, MA=
X31790State, 2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(outlen, MAX31=
790State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8_ARRAY(outbuf,=
 MAX31790State, 2),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(pointer, MAX3=
1790State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_I2C_SLAVE(i2c, MAX3=
1790State), VMSTATE_END_OF_LIST() }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void max31790_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MAX31790State *s =3D MAX31790(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; MAX31790_NUM_FANS; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* POR-State 0b 0XX0 0000 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;fan_config[i] =3D 0b00000000;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* same as POR-State */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tach_target[i] =3D 0b00111100000000=
00;<br>
<br>
tach_target[] array size is=C2=A0 MAX31790_NUM_TACHS =3D 12. The loop uses<=
br>
MAX31790_NUM_FANS =3D 6<br>
<br>
<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* same as POR-State */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;fan_dynamics[i] =3D 0b01001100;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* this will set both pwm and tach count */<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; MAX31790_NUM_TACHS; i++) {<br>
<br>
<br>
pwm[] array size is MAX31790_NUM_FANS =3D 6. The loop uses<br>
MAX31790_NUM_TACHS =3D 12. this is an out-of-bounds write.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 max31790_pwm_write(s, i, 0x4444);<br>
<br>
How does the 0x4444 value relates to the one used in the tests ?<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void max31790_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MAX31790State *s =3D MAX31790(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_max31790_realize(s-&gt;i2c.address);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void max31790_class_init(ObjectClass *klass, const void *data)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D max31790_realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;desc =3D &quot;Maxim MAX31790 6-Channel Fan Cont=
roller&quot;;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_max31790;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;legacy_reset =3D max31790_reset;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;event =3D max31790_event;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;recv =3D max31790_recv;<br>
&gt; +=C2=A0 =C2=A0 k-&gt;send =3D max31790_send;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo max31790_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_MAX31790,<br>
&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_I2C_SLAVE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(MAX31790State),<br>
&gt; +=C2=A0 =C2=A0 .class_size =3D sizeof(MAX31790Class),<br>
&gt; +=C2=A0 =C2=A0 .class_init =3D max31790_class_init,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void max31790_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;max31790_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(max31790_register_types)<br>
&gt; diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
&gt; index 5b198402d5..99864eb878 100644<br>
&gt; --- a/hw/arm/Kconfig<br>
&gt; +++ b/hw/arm/Kconfig<br>
&gt; @@ -552,6 +552,7 @@ config ASPEED_SOC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select LED<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PMBUS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select MAX31785<br>
&gt; +=C2=A0 =C2=A0 select MAX31790<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select FSI_APB2OPB_ASPEED<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select AT24C<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PCI_EXPRESS<br>
&gt; diff --git a/hw/sensor/Kconfig b/hw/sensor/Kconfig<br>
&gt; index bc6331b4ab..767f198e92 100644<br>
&gt; --- a/hw/sensor/Kconfig<br>
&gt; +++ b/hw/sensor/Kconfig<br>
&gt; @@ -43,3 +43,7 @@ config ISL_PMBUS_VR<br>
&gt;=C2=A0 =C2=A0config MAX31785<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on PMBUS<br>
&gt; +<br>
&gt; +config MAX31790<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +=C2=A0 =C2=A0 depends on I2C<br>
&gt; diff --git a/hw/sensor/meson.build b/hw/sensor/meson.build<br>
&gt; index 420fdc3359..4987c3b253 100644<br>
&gt; --- a/hw/sensor/meson.build<br>
&gt; +++ b/hw/sensor/meson.build<br>
&gt; @@ -8,3 +8,4 @@ system_ss.add(when: &#39;CONFIG_MAX34451&#39;, if_true=
: files(&#39;max34451.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_LSM303DLHC_MAG&#39;, if_tr=
ue: files(&#39;lsm303dlhc_mag.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_ISL_PMBUS_VR&#39;, if_true=
: files(&#39;isl_pmbus_vr.c&#39;))<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_MAX31785&#39;, if_true: fi=
les(&#39;max31785.c&#39;))<br>
&gt; +system_ss.add(when: &#39;CONFIG_MAX31790&#39;, if_true: files(&#39;ma=
x31790.c&#39;))<br>
&gt; diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events<br>
&gt; index a3fe54fa6d..0bde02e676 100644<br>
&gt; --- a/hw/sensor/trace-events<br>
&gt; +++ b/hw/sensor/trace-events<br>
&gt; @@ -4,3 +4,14 @@<br>
&gt;=C2=A0 =C2=A0tmp105_read(uint8_t dev, uint8_t addr) &quot;device: 0x%02=
x, addr: 0x%02x&quot;<br>
&gt;=C2=A0 =C2=A0tmp105_write(uint8_t dev, uint8_t addr) &quot;device: 0x%0=
2x, addr 0x%02x&quot;<br>
&gt;=C2=A0 =C2=A0tmp105_write_shutdown(uint8_t dev) &quot;device: 0x%02x&qu=
ot;<br>
&gt; +<br>
&gt; +# max31790.c<br>
&gt; +max31790_send(uint8_t i2c_addr, uint8_t send) &quot;i2c_addr: 0x%02x,=
 data: 0x%02x&quot;<br>
&gt; +max31790_recv(uint8_t i2c_addr, uint8_t reg_addr) &quot;i2c_addr: 0x%=
02x, reg_addr: 0x%02x&quot;<br>
&gt; +max31790_recv_return(uint8_t i2c_addr, uint8_t data) &quot;i2c_addr: =
0x%02x, returns: 0x%02x&quot;<br>
&gt; +max31790_event(uint8_t i2c_addr, uint8_t event) &quot;i2c_addr: 0x%02=
x, event: 0x%02x&quot;<br>
&gt; +max31790_realize(uint8_t i2c_addr) &quot;i2c_addr: 0x%02x&quot;<br>
&gt; +max31790_pwm_write(uint8_t i2c_addr, size_t index, uint16_t value) &q=
uot;i2c_addr: 0x%02x, index: %zu, value: 0x%04x&quot;<br>
&gt; +max31790_rpm_write(uint8_t i2c_addr, size_t index, uint16_t value) &q=
uot;i2c_addr: 0x%02x, index: %zu, value: 0x%04x&quot;<br>
&gt; +max31790_tach_count_reg(uint8_t i2c_addr, size_t index, uint16_t valu=
e) &quot;i2c_addr: 0x%02x, index: %zu, value: 0x%04x&quot;<br>
&gt; +<br>
&gt; diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/function=
al/arm/test_aspeed_fby4.py<br>
&gt; index a521834f79..dc2437a533 100755<br>
&gt; --- a/tests/functional/arm/test_aspeed_fby4.py<br>
&gt; +++ b/tests/functional/arm/test_aspeed_fby4.py<br>
&gt; @@ -8,6 +8,8 @@<br>
&gt;=C2=A0 =C2=A0from qemu_test import wait_for_console_pattern<br>
&gt;=C2=A0 =C2=A0from aspeed import AspeedTest<br>
&gt;=C2=A0 =C2=A0<br>
<br>
Drop the extra newline<br>
<br>
&gt; +from qemu_test import wait_for_console_pattern<br>
&gt; +from qemu_test import exec_command_and_wait_for_pattern<br>
<br>
redundant import.<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0class YosemiteV4Machine(AspeedTest):<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -34,6 +36,30 @@ def do_test_arm_aspeed_openbmc_no_network(self, mac=
hine, image, uboot,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# different from the other mac=
hines.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_for_console_pattern(=
&#39;yosemite4 login:&#39;)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # perform login<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;root&quot;, &quot;Password:&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self, &=
quot;0penBmc&quot;, &quot;#&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # MAX31790 test<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cat /sys/class/hwmon/=
hwmon2/name&quot;, &quot;max31790&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cat /sys/class/hwmon/=
hwmon2/fan1_input&quot;, &quot;7447&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cat /sys/class/hwmon/=
hwmon2/fan1_enable&quot;, &quot;1&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cat /sys/class/hwmon/=
hwmon2/fan1_fault&quot;, &quot;0&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;echo 1 &gt; /sys/clas=
s/hwmon/hwmon2/pwm1&quot;, &quot;root@yosemite4&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cat /sys/class/hwmon/=
hwmon2/fan1_input&quot;, &quot;140&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;echo 255 &gt; /sys/cl=
ass/hwmon/hwmon2/pwm1&quot;, &quot;root@yosemite4&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_command_and_wait_for_pattern(self,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cat /sys/class/hwmon/=
hwmon2/fan1_input&quot;, &quot;10685&quot;);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_arm_ast2600_yosemitev4_openbmc(self=
):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0image_path =3D self.uncompress=
(self.ASSET_YOSEMITE_V4_FLASH)<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div></div>

--000000000000d2f5090653e541f7--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0008C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1rK-0007u4-1x; Tue, 11 Mar 2025 11:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1ts1rH-0007td-ON
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:49:31 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1ts1rD-0003W3-C4
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:49:31 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2bcca6aae0bso3807669fac.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista.com; s=google; t=1741708164; x=1742312964; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMkKO7lQctPh0fmKdB96NorrH4IhFqqMxyHqDBUCVn0=;
 b=id11lOjW7ZyqQLczg39uq0HuhiS9w1QduMVMHPEqLYQQvwFGzEswIROuYFg6dSs5Wg
 GYVWyoBrLIQcA//jYF/OLv3bKlTCIUW8WVIQ64wBhCLErgEesExndQIS6AQmRG9ftNFC
 7jFlSVd6K9BiDcFkzbJVmXmcLOj6XsVnQ7/aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741708164; x=1742312964;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sMkKO7lQctPh0fmKdB96NorrH4IhFqqMxyHqDBUCVn0=;
 b=RQwVN+Ncfh1J+eyaMXmo0KVBwUtJ9EM0XeJwBZ/vd28Vm9Nuu6tWITZ0SKHhbWHSYc
 jBJufaXaUPbW4uJJ51VeMcM0794YQbhslekyAXghl6tWrlhN4DqeanoDPX2EPuW2To0o
 2gvm2LgIPIYiWY9v2P/QbLUOID2bWzomy8dVDnB5dET6oHzy2PbTPoghzvmMAJkb6Vst
 BLXYt8pbdywnB5OV+PheUIMUjnYzJcle0Qrbyz15KUVMXaR8FMlPxdMf6sQiRkNZB0ns
 4pybdo2o2+GdF1s4K/Ey1K1edjuRt5ny50+6SdEW/RB6L9v1fO2G2EFpGAJf6I9NRdjf
 Mo5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBb1IerToGQ6iWMIV5F5u/aAM02v98SigCYjzGB6g8iULYLRpMenOkgtzmvE0b86gZha+p9qQGNuBp@nongnu.org
X-Gm-Message-State: AOJu0YxqO/qC1jLXbaOXy6eEGU7b4SQRvs4QOCqQrMHkaXWDbUHa3Kdh
 pxDcSLIrdlIBY5CFylMCMBA1q8K0cGh2lfn6rdaDQ/zYILd0KDNWP3LGBXLIt7k=
X-Gm-Gg: ASbGncsyerI/i9wlxg57OyyHv93HYM+ZY5xnuCjc9+jBzulopt5UD7n7d1R265pS2tV
 HmC0oYyl48JjQl3ZaCpspbCjBMwqp4jr/BYRPil7DYHagQmq9jx8MfNWxKm0bDwN9kD3GgcZMB+
 aoMqtvSUCTo7rJBZX+u/Vy4gsaj2I2dh6NRfKRUK92FQT2jShznlF6hBaZvRFd4KqWThLWk4SEU
 MJ/FTIQ4MLO4RwrCi43yZQOIHXiXtf5xmp/ed+QTdQRaUAEV7zJJcFyTkw5EWpGnc+FjqN8I0WV
 6LH7vCdXjb0WYuzyAZgFolgKQyfoq7WSf77+Bfk/2Lb1LRocAQ==
X-Google-Smtp-Source: AGHT+IGtvAGEhQKVQE61Nmb7TVLXnnd/rI6DV4ofHBhZbdReAQ64+KtTNjhDAEXspxzAp2Z1GwGqew==
X-Received: by 2002:a05:6871:e082:b0:2c2:2d0f:40a3 with SMTP id
 586e51a60fabf-2c2612f7582mr10423751fac.31.1741708164053; 
 Tue, 11 Mar 2025 08:49:24 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:4e56:397e:6a88:169])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72b7c8e98dasm1383669a34.56.2025.03.11.08.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:49:22 -0700 (PDT)
Date: Tue, 11 Mar 2025 10:49:19 -0500
From: Corey Minyard <cminyard@mvista.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 18/18] hw/rtc: Add Ricoh RS5C372 RTC emulation
Message-ID: <Z9BbfyNSPBkH-gaf@mail.minyard.net>
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-19-shentey@gmail.com>
 <77E3F57E-95D0-4E2F-838E-5E0334651349@gmail.com>
 <1FBD5091-2221-4815-85CB-D98BE4F6EA72@gmail.com>
 <F2594DA2-F703-4F82-B07F-2D665329E1CF@gmail.com>
 <fa40fbaa-df39-40e4-8845-fd516df10b41@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="Jat1ixbgLK/8tm3M"
Content-Disposition: inline
In-Reply-To: <fa40fbaa-df39-40e4-8845-fd516df10b41@linaro.org>
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=cminyard@mvista.com; helo=mail-oa1-x2b.google.com
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
Reply-To: cminyard@mvista.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--Jat1ixbgLK/8tm3M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 10:20:03AM +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/3/25 08:34, Bernhard Beschow wrote:
> >=20
> >=20
> > Am 7. M=C3=A4rz 2025 19:18:34 UTC schrieb Bernhard Beschow <shentey@gma=
il.com>:
> > >=20
> > >=20
> > > Am 4. M=C3=A4rz 2025 18:53:10 UTC schrieb Bernhard Beschow <shentey@g=
mail.com>:
> > > >=20
> > > >=20
> > > > Am 23. Februar 2025 11:47:08 UTC schrieb Bernhard Beschow <shentey@=
gmail.com>:
> > > > > The implementation just allows Linux to determine date and time.
> > > > >=20
> > > > > Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> > > > > ---
> > > > > MAINTAINERS                |   2 +
> > > > > hw/rtc/rs5c372.c           | 236 ++++++++++++++++++++++++++++++++=
+++++
> > > > > tests/qtest/rs5c372-test.c |  43 +++++++
> > > > > hw/rtc/Kconfig             |   5 +
> > > > > hw/rtc/meson.build         |   1 +
> > > > > hw/rtc/trace-events        |   4 +
> > > > > tests/qtest/meson.build    |   1 +
> > > > > 7 files changed, 292 insertions(+)
> > > > > create mode 100644 hw/rtc/rs5c372.c
> > > > > create mode 100644 tests/qtest/rs5c372-test.c
> > > >=20
> > > > Ping for just this patch. I'd like to have it merged for 10.0.
> > >=20
> > > Ping^2 -- just few days left before soft freeze.
> >=20
> > Last ping before the freeze
> >=20
> > It would really be nice to have this device model in 10.0 since this wo=
uld allow me to use upstream QEMU.
>=20
> Apparently I2C maintainer wasn't Cc'ed (now is):
>=20
>   Corey Minyard <cminyard@mvista.com> (maintainer:I2C and SMBus)
>=20
> At a glance patch LGTM, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Well, it's fairly hard to read this way :-).  But this looks good.  My
only comment is on:

>>>> +#define NVRAM_SIZE 0x10
>>>> +
>>>> +/* Flags definitions */
>>>> +#define SECONDS_CH 0x80
>>>> +#define HOURS_PM   0x20
>>>> +#define CTRL2_24   0x20

Those are fairly generic names; when I see things like that I worry
about conflicting with other generic names that might come into an
include later.  Not a huge deal, though.

Acked-by: Corey Minyard <cminyard@mvista.com>

>=20
> >=20
> > Thanks,
> > Bernhard
> >=20
> > >=20
> > > AFAICS no open issues and I'd really like to have this RTC merged for=
 10.0. What is holding it back?
> > >=20
> > > Best regards,
> > > Bernhard
> > >=20
> > > >=20
> > > > Thanks,
> > > > Bernhard
> > > >=20
> > > > >=20
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 489e426d85..2552cfd65c 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -828,10 +828,12 @@ F: hw/arm/imx8mp-evk.c
> > > > > F: hw/arm/fsl-imx8mp.c
> > > > > F: hw/misc/imx8mp_*.c
> > > > > F: hw/pci-host/fsl_imx8m_phy.c
> > > > > +F: hw/rtc/rs5c372.c
> > > > > F: include/hw/arm/fsl-imx8mp.h
> > > > > F: include/hw/misc/imx8mp_*.h
> > > > > F: include/hw/pci-host/fsl_imx8m_phy.h
> > > > > F: pc-bios/imx8mp*
> > > > > +F: tests/qtest/rs5c372-test.c
> > > > > F: docs/system/arm/imx8mp-evk.rst
> > > > >=20
> > > > > MPS2 / MPS3
> > > > > diff --git a/hw/rtc/rs5c372.c b/hw/rtc/rs5c372.c
> > > > > new file mode 100644
> > > > > index 0000000000..5542f74085
> > > > > --- /dev/null
> > > > > +++ b/hw/rtc/rs5c372.c
> > > > > @@ -0,0 +1,236 @@
> > > > > +/*
> > > > > + * Ricoh RS5C372, R222x I2C RTC
> > > > > + *
> > > > > + * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
> > > > > + *
> > > > > + * Based on hw/rtc/ds1338.c
> > > > > + *
> > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > + */
> > > > > +
> > > > > +#include "qemu/osdep.h"
> > > > > +#include "hw/i2c/i2c.h"
> > > > > +#include "hw/qdev-properties.h"
> > > > > +#include "hw/resettable.h"
> > > > > +#include "migration/vmstate.h"
> > > > > +#include "qemu/bcd.h"
> > > > > +#include "qom/object.h"
> > > > > +#include "system/rtc.h"
> > > > > +#include "trace.h"
> > > > > +
> > > > > +#define NVRAM_SIZE 0x10
> > > > > +
> > > > > +/* Flags definitions */
> > > > > +#define SECONDS_CH 0x80
> > > > > +#define HOURS_PM   0x20
> > > > > +#define CTRL2_24   0x20
> > > > > +
> > > > > +#define TYPE_RS5C372 "rs5c372"
> > > > > +OBJECT_DECLARE_SIMPLE_TYPE(RS5C372State, RS5C372)
> > > > > +
> > > > > +struct RS5C372State {
> > > > > +    I2CSlave parent_obj;
> > > > > +
> > > > > +    int64_t offset;
> > > > > +    uint8_t wday_offset;
> > > > > +    uint8_t nvram[NVRAM_SIZE];
> > > > > +    uint8_t ptr;
> > > > > +    uint8_t tx_format;
> > > > > +    bool addr_byte;
> > > > > +};
> > > > > +
> > > > > +static void capture_current_time(RS5C372State *s)
> > > > > +{
> > > > > +    /*
> > > > > +     * Capture the current time into the secondary registers whi=
ch will be
> > > > > +     * actually read by the data transfer operation.
> > > > > +     */
> > > > > +    struct tm now;
> > > > > +    qemu_get_timedate(&now, s->offset);
> > > > > +    s->nvram[0] =3D to_bcd(now.tm_sec);
> > > > > +    s->nvram[1] =3D to_bcd(now.tm_min);
> > > > > +    if (s->nvram[0xf] & CTRL2_24) {
> > > > > +        s->nvram[2] =3D to_bcd(now.tm_hour);
> > > > > +    } else {
> > > > > +        int tmp =3D now.tm_hour;
> > > > > +        if (tmp % 12 =3D=3D 0) {
> > > > > +            tmp +=3D 12;
> > > > > +        }
> > > > > +        if (tmp <=3D 12) {
> > > > > +            s->nvram[2] =3D to_bcd(tmp);
> > > > > +        } else {
> > > > > +            s->nvram[2] =3D HOURS_PM | to_bcd(tmp - 12);
> > > > > +        }
> > > > > +    }
> > > > > +    s->nvram[3] =3D (now.tm_wday + s->wday_offset) % 7 + 1;
> > > > > +    s->nvram[4] =3D to_bcd(now.tm_mday);
> > > > > +    s->nvram[5] =3D to_bcd(now.tm_mon + 1);
> > > > > +    s->nvram[6] =3D to_bcd(now.tm_year - 100);
> > > > > +}
> > > > > +
> > > > > +static void inc_regptr(RS5C372State *s)
> > > > > +{
> > > > > +    s->ptr =3D (s->ptr + 1) & (NVRAM_SIZE - 1);
> > > > > +}
> > > > > +
> > > > > +static int rs5c372_event(I2CSlave *i2c, enum i2c_event event)
> > > > > +{
> > > > > +    RS5C372State *s =3D RS5C372(i2c);
> > > > > +
> > > > > +    switch (event) {
> > > > > +    case I2C_START_RECV:
> > > > > +        /*
> > > > > +         * In h/w, capture happens on any START condition, not j=
ust a
> > > > > +         * START_RECV, but there is no need to actually capture =
on
> > > > > +         * START_SEND, because the guest can't get at that data
> > > > > +         * without going through a START_RECV which would overwr=
ite it.
> > > > > +         */
> > > > > +        capture_current_time(s);
> > > > > +        s->ptr =3D 0xf;
> > > > > +        break;
> > > > > +    case I2C_START_SEND:
> > > > > +        s->addr_byte =3D true;
> > > > > +        break;
> > > > > +    default:
> > > > > +        break;
> > > > > +    }
> > > > > +
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > > +static uint8_t rs5c372_recv(I2CSlave *i2c)
> > > > > +{
> > > > > +    RS5C372State *s =3D RS5C372(i2c);
> > > > > +    uint8_t res;
> > > > > +
> > > > > +    res  =3D s->nvram[s->ptr];
> > > > > +
> > > > > +    trace_rs5c372_recv(s->ptr, res);
> > > > > +
> > > > > +    inc_regptr(s);
> > > > > +    return res;
> > > > > +}
> > > > > +
> > > > > +static int rs5c372_send(I2CSlave *i2c, uint8_t data)
> > > > > +{
> > > > > +    RS5C372State *s =3D RS5C372(i2c);
> > > > > +
> > > > > +    if (s->addr_byte) {
> > > > > +        s->ptr =3D data >> 4;
> > > > > +        s->tx_format =3D data & 0xf;
> > > > > +        s->addr_byte =3D false;
> > > > > +        return 0;
> > > > > +    }
> > > > > +
> > > > > +    trace_rs5c372_send(s->ptr, data);
> > > > > +
> > > > > +    if (s->ptr < 7) {
> > > > > +        /* Time register. */
> > > > > +        struct tm now;
> > > > > +        qemu_get_timedate(&now, s->offset);
> > > > > +        switch (s->ptr) {
> > > > > +        case 0:
> > > > > +            now.tm_sec =3D from_bcd(data & 0x7f);
> > > > > +            break;
> > > > > +        case 1:
> > > > > +            now.tm_min =3D from_bcd(data & 0x7f);
> > > > > +            break;
> > > > > +        case 2:
> > > > > +            if (s->nvram[0xf] & CTRL2_24) {
> > > > > +                now.tm_hour =3D from_bcd(data & 0x3f);
> > > > > +            } else {
> > > > > +                int tmp =3D from_bcd(data & (HOURS_PM - 1));
> > > > > +                if (data & HOURS_PM) {
> > > > > +                    tmp +=3D 12;
> > > > > +                }
> > > > > +                if (tmp % 12 =3D=3D 0) {
> > > > > +                    tmp -=3D 12;
> > > > > +                }
> > > > > +                now.tm_hour =3D tmp;
> > > > > +            }
> > > > > +            break;
> > > > > +        case 3:
> > > > > +            {
> > > > > +                /*
> > > > > +                 * The day field is supposed to contain a value =
in the range
> > > > > +                 * 1-7. Otherwise behavior is undefined.
> > > > > +                 */
> > > > > +                int user_wday =3D (data & 7) - 1;
> > > > > +                s->wday_offset =3D (user_wday - now.tm_wday + 7)=
 % 7;
> > > > > +            }
> > > > > +            break;
> > > > > +        case 4:
> > > > > +            now.tm_mday =3D from_bcd(data & 0x3f);
> > > > > +            break;
> > > > > +        case 5:
> > > > > +            now.tm_mon =3D from_bcd(data & 0x1f) - 1;
> > > > > +            break;
> > > > > +        case 6:
> > > > > +            now.tm_year =3D from_bcd(data) + 100;
> > > > > +            break;
> > > > > +        }
> > > > > +        s->offset =3D qemu_timedate_diff(&now);
> > > > > +    } else {
> > > > > +        s->nvram[s->ptr] =3D data;
> > > > > +    }
> > > > > +    inc_regptr(s);
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > > +static void rs5c372_reset_hold(Object *obj, ResetType type)
> > > > > +{
> > > > > +    RS5C372State *s =3D RS5C372(obj);
> > > > > +
> > > > > +    /* The clock is running and synchronized with the host */
> > > > > +    s->offset =3D 0;
> > > > > +    s->wday_offset =3D 0;
> > > > > +    memset(s->nvram, 0, NVRAM_SIZE);
> > > > > +    s->ptr =3D 0;
> > > > > +    s->addr_byte =3D false;
> > > > > +}
> > > > > +
> > > > > +static const VMStateDescription rs5c372_vmstate =3D {
> > > > > +    .name =3D "rs5c372",
> > > > > +    .version_id =3D 1,
> > > > > +    .minimum_version_id =3D 1,
> > > > > +    .fields =3D (const VMStateField[]) {
> > > > > +        VMSTATE_I2C_SLAVE(parent_obj, RS5C372State),
> > > > > +        VMSTATE_INT64(offset, RS5C372State),
> > > > > +        VMSTATE_UINT8_V(wday_offset, RS5C372State, 2),
> > > > > +        VMSTATE_UINT8_ARRAY(nvram, RS5C372State, NVRAM_SIZE),
> > > > > +        VMSTATE_UINT8(ptr, RS5C372State),
> > > > > +        VMSTATE_UINT8(tx_format, RS5C372State),
> > > > > +        VMSTATE_BOOL(addr_byte, RS5C372State),
> > > > > +        VMSTATE_END_OF_LIST()
> > > > > +    }
> > > > > +};
> > > > > +
> > > > > +static void rs5c372_init(Object *obj)
> > > > > +{
> > > > > +    qdev_prop_set_uint8(DEVICE(obj), "address", 0x32);
> > > > > +}
> > > > > +
> > > > > +static void rs5c372_class_init(ObjectClass *klass, void *data)
> > > > > +{
> > > > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > > > +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> > > > > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > > > > +
> > > > > +    k->event =3D rs5c372_event;
> > > > > +    k->recv =3D rs5c372_recv;
> > > > > +    k->send =3D rs5c372_send;
> > > > > +    dc->vmsd =3D &rs5c372_vmstate;
> > > > > +    rc->phases.hold =3D rs5c372_reset_hold;
> > > > > +}
> > > > > +
> > > > > +static const TypeInfo rs5c372_types[] =3D {
> > > > > +    {
> > > > > +        .name          =3D TYPE_RS5C372,
> > > > > +        .parent        =3D TYPE_I2C_SLAVE,
> > > > > +        .instance_size =3D sizeof(RS5C372State),
> > > > > +        .instance_init =3D rs5c372_init,
> > > > > +        .class_init    =3D rs5c372_class_init,
> > > > > +    },
> > > > > +};
> > > > > +
> > > > > +DEFINE_TYPES(rs5c372_types)
> > > > > diff --git a/tests/qtest/rs5c372-test.c b/tests/qtest/rs5c372-tes=
t.c
> > > > > new file mode 100644
> > > > > index 0000000000..0f6a9b68b9
> > > > > --- /dev/null
> > > > > +++ b/tests/qtest/rs5c372-test.c
> > > > > @@ -0,0 +1,43 @@
> > > > > +/*
> > > > > + * QTest testcase for the RS5C372 RTC
> > > > > + *
> > > > > + * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
> > > > > + *
> > > > > + * Based on ds1338-test.c
> > > > > + *
> > > > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > > > + */
> > > > > +
> > > > > +#include "qemu/osdep.h"
> > > > > +#include "qemu/bcd.h"
> > > > > +#include "libqos/i2c.h"
> > > > > +
> > > > > +#define RS5C372_ADDR 0x32
> > > > > +
> > > > > +static void rs5c372_read_date(void *obj, void *data, QGuestAlloc=
ator *alloc)
> > > > > +{
> > > > > +    QI2CDevice *i2cdev =3D obj;
> > > > > +
> > > > > +    uint8_t resp[0x10];
> > > > > +    time_t now =3D time(NULL);
> > > > > +    struct tm *utc =3D gmtime(&now);
> > > > > +
> > > > > +    i2c_read_block(i2cdev, 0, resp, sizeof(resp));
> > > > > +
> > > > > +    /* check retrieved time against local time */
> > > > > +    g_assert_cmpuint(from_bcd(resp[5]), =3D=3D , utc->tm_mday);
> > > > > +    g_assert_cmpuint(from_bcd(resp[6]), =3D=3D , 1 + utc->tm_mon=
);
> > > > > +    g_assert_cmpuint(2000 + from_bcd(resp[7]), =3D=3D , 1900 + u=
tc->tm_year);
> > > > > +}
> > > > > +
> > > > > +static void rs5c372_register_nodes(void)
> > > > > +{
> > > > > +    QOSGraphEdgeOptions opts =3D { };
> > > > > +    add_qi2c_address(&opts, &(QI2CAddress) { RS5C372_ADDR });
> > > > > +
> > > > > +    qos_node_create_driver("rs5c372", i2c_device_create);
> > > > > +    qos_node_consumes("rs5c372", "i2c-bus", &opts);
> > > > > +    qos_add_test("read_date", "rs5c372", rs5c372_read_date, NULL=
);
> > > > > +}
> > > > > +
> > > > > +libqos_init(rs5c372_register_nodes);
> > > > > diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> > > > > index 2fe04ec1d0..315b0e4ecc 100644
> > > > > --- a/hw/rtc/Kconfig
> > > > > +++ b/hw/rtc/Kconfig
> > > > > @@ -26,3 +26,8 @@ config GOLDFISH_RTC
> > > > >=20
> > > > > config LS7A_RTC
> > > > >      bool
> > > > > +
> > > > > +config RS5C372_RTC
> > > > > +    bool
> > > > > +    depends on I2C
> > > > > +    default y if I2C_DEVICES
> > > > > diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
> > > > > index 8ecc2d792c..6c87864dc0 100644
> > > > > --- a/hw/rtc/meson.build
> > > > > +++ b/hw/rtc/meson.build
> > > > > @@ -13,3 +13,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_RTC', if_t=
rue: files('goldfish_rtc.c'))
> > > > > system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c=
'))
> > > > > system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwin=
ner-rtc.c'))
> > > > > system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc14681=
8rtc.c'))
> > > > > +system_ss.add(when: 'CONFIG_RS5C372_RTC', if_true: files('rs5c37=
2.c'))
> > > > > diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> > > > > index 8012afe102..b9f2852d35 100644
> > > > > --- a/hw/rtc/trace-events
> > > > > +++ b/hw/rtc/trace-events
> > > > > @@ -35,3 +35,7 @@ m48txx_nvram_mem_write(uint32_t addr, uint32_t =
value) "mem write addr:0x%04x val
> > > > > # goldfish_rtc.c
> > > > > goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRI=
x64 " value 0x%08" PRIx64
> > > > > goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PR=
Ix64 " value 0x%08" PRIx64
> > > > > +
> > > > > +# rs5c372.c
> > > > > +rs5c372_recv(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] -> 0=
x%02" PRIx8
> > > > > +rs5c372_send(uint32_t addr, uint8_t value) "[0x%" PRIx32 "] <- 0=
x%02" PRIx8
> > > > > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > > > > index 8a6243382a..9e5380ba7a 100644
> > > > > --- a/tests/qtest/meson.build
> > > > > +++ b/tests/qtest/meson.build
> > > > > @@ -298,6 +298,7 @@ qos_test_ss.add(
> > > > >    'pca9552-test.c',
> > > > >    'pci-test.c',
> > > > >    'pcnet-test.c',
> > > > > +  'rs5c372-test.c',
> > > > >    'sdhci-test.c',
> > > > >    'spapr-phb-test.c',
> > > > >    'tmp105-test.c',
>=20

--Jat1ixbgLK/8tm3M
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIINIQYJKoZIhvcNAQcCoIINEjCCDQ4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggpVMIIFXzCCBEegAwIBAgIQD/rh8xorQzw9muFtZDtYizANBgkqhkiG9w0BAQsFADBl
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGln
aWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgRzIwHhcNMTkw
OTIzMTIyNTMyWhcNMzQwOTIzMTIyNTMyWjBqMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGln
aUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSkwJwYDVQQDEyBEaWdpQ2Vy
dCBBc3N1cmVkIElEIENsaWVudCBDQSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAOqxRa06rLwKBvrDb/qQ8RtXfeKA9o0A42oZbLF4GYr4Xdt9JE8r3PJRIOUZD1U3mEln
4S/aZoS54Q+5Ecs3q2GGT/Z82VeAPLeGvJoT0LS5t/zXeUcbMuDFWgyj33kiesnuusnOWvpI
SoxN+oBH4oo0+oUiHI65mMjMAlb93x6sabh9kKvHQvHC4x2u7wYv5+NXjnbOhJS/1NjGq+ug
LMXeldFMz0O5qFIDpn3aQGU0htyJQ2SZyxEqlUrgunsrYj9wgfW7XuhAi2j0y5d9oMT0SuVe
KFFnQhTEk5B3fq+OBOW0AU2JdW1r929UtRbAr8RpLt05WI2G2RNVVlHYaU0CAwEAAaOCAgQw
ggIAMB0GA1UdDgQWBBSlYiBQ3LtbV5etI4814lRsqX75TjAfBgNVHSMEGDAWgBTOw0q5mVXy
uNtgv6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwTAYDVR0lBEUwQwYIKwYBBQUHAwIGCCsG
AQUFBwMEBgorBgEEAYI3CgMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMMBgkqhkiG9y8BAQUw
EgYDVR0TAQH/BAgwBgEB/wIBADA0BggrBgEFBQcBAQQoMCYwJAYIKwYBBQUHMAGGGGh0dHA6
Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vY3JsMy5kaWdp
Y2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290RzIuY3JsMIHOBgNVHSAEgcYwgcMwgcAG
BFUdIAAwgbcwKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYoG
CCsGAQUFBwICMH4MfEFueSB1c2Ugb2YgdGhpcyBDZXJ0aWZpY2F0ZSBjb25zdGl0dXRlcyBh
Y2NlcHRhbmNlIG9mIHRoZSBSZWx5aW5nIFBhcnR5IEFncmVlbWVudCBsb2NhdGVkIGF0IGh0
dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9ycGEtdWEwDQYJKoZIhvcNAQELBQADggEBAHZrbCQC
o3MAIqR0kekGYrC70EAGRDRq11COufNEXhcpv3YH6BMhUoVinPPNgfo5HPrZAFrLK/KPXYdJ
dgkASGsINabAfY2ljUaJwKlpIewwjS6KuGEn59MgidaAUPh6lbetIoRsLhCqCzAnX1aL99fj
CMf4NMWLUC8TqotnnrKNuw4JSjx4fcQs+U5T1bbgnyDx+8ybONuIEDvinHdKDu2VjoECzez2
y/1IVTPlh57zBfjHJQFqLWzHdou8M+ucdJtr2swXII6s3nkq4pfEn7KnbzMS9quFSuyOGILc
g/3qVwaHNLM5R+8nB5gPI5+u5Uh56w1i+9Ds1pjYAiTHdeUwggTuMIID1qADAgECAhAImztE
U4o9odkEsuVgiJc8MA0GCSqGSIb3DQEBCwUAMGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lD
ZXJ0IEFzc3VyZWQgSUQgQ2xpZW50IENBIEcyMB4XDTI0MDUwMzAwMDAwMFoXDTI2MDUwNjIz
NTk1OVowQjEcMBoGA1UEAwwTY21pbnlhcmRAbXZpc3RhLmNvbTEiMCAGCSqGSIb3DQEJARYT
Y21pbnlhcmRAbXZpc3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJm1
ZE9brEiQnF7EKiV+aYzHyqPFJ+z1wwdJ4wvNiwUCgXJejBxFj04Z7A62Yx6Sp59vfjbo05eA
IOyaLOFp3vbMBQAe8Qe4XrFv7wPcKZxwS+sgCuBvNs4NVGKYGjiKZW8WPq9ZcEl5BM8BLMrl
rchAUHJJcMdcEJUsed6rIB//EtnGOe74/vR1Tz3sN1WzC1Wa9COvcbLgVvWC/o4WysUfC9+f
9/5JzAiib7U7S/iRigkmEahibZgYKB7y6F1v9hxUwHxfa7GtJ8cv6LtRcPLhAO86GgXMfpgq
k3fxzQu8uwACpINbmQNLcRzg6mHFDYRK3mFp4puUnHO5EUJ8RgUCAwEAAaOCAbYwggGyMB8G
A1UdIwQYMBaAFKViIFDcu1tXl60jjzXiVGypfvlOMB0GA1UdDgQWBBQiHrUOKuj1vJe3OXAz
gOP5Qbl2FTAeBgNVHREEFzAVgRNjbWlueWFyZEBtdmlzdGEuY29tMBQGA1UdIAQNMAswCQYH
Z4EMAQUBATAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MIGLBgNVHR8EgYMwgYAwPqA8oDqGOGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2Vy
dEFzc3VyZWRJRENsaWVudENBRzIuY3JsMD6gPKA6hjhodHRwOi8vY3JsNC5kaWdpY2VydC5j
b20vRGlnaUNlcnRBc3N1cmVkSURDbGllbnRDQUcyLmNybDB9BggrBgEFBQcBAQRxMG8wJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDov
L2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEQ2xpZW50Q0FHMi5jcnQw
DQYJKoZIhvcNAQELBQADggEBADkBdRyx41eUGmsYXBXt3WCsYeDr26rJL7lbx2PvqaZyRCJm
J9CN2TljF0YHsXSPU+un1RfUlYz+PtcNFIqNuSf3N5fGU0bEpSzXozd/nZ32yWFLkd5CzYyN
F1xrpbyP2a87jKM0uqEHXZFl7NPiAfEchjFCddciHTOXjN66L+kJ/ZsOoNJLG8yFN401EGew
Nk8z/hJjWqR7DG0/YWn9h7jQ5SmqkqyhLwTO9s6KoByacWuKpKWSc/DaOuWmROlROrOA1hD8
0sKqC6jGeLxNpiYzSwBy8qKF0weZdhcHUeO1HOm1csrvWl1UghnlR7SLir3bb5LiesTVvSuR
Q3aDywAxggKQMIICjAIBATB+MGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lDZXJ0IEFzc3Vy
ZWQgSUQgQ2xpZW50IENBIEcyAhAImztEU4o9odkEsuVgiJc8MA0GCWCGSAFlAwQCAQUAoIHk
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMxMTE1NDkx
OVowLwYJKoZIhvcNAQkEMSIEID/l4BqlLJNkiLTdARtzC7ZpvW9XEYBJkvLC2Hu0Vs/VMHkG
CSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAF1UD2M3zvSYlJIIn/6piB0KLqsSUFWL
l4t171loNxnglVODI+vCzZbz7llpHXAr5MHZm8JUGOibw6cyOGiq+eFufJUDt3MpE30xGmwa
W7goZx5n5PHfJGgtP+mzMk3gLdEd0fkmZctHy0Yd/WIP61vGFCEte2z0X8qN/Qgm58e1AJ6g
3QP4dw6cuBhbDPVkKjkcxxor8pkF+mRx1lKO+oSqZXj4cpwRJKUaft8liJiCxkbdEfL0vcFA
rnSqdtRv2GkxfWtnWvG57xODTH38I62N0PD9+CKuqB3CVftaX4H6k6l28rrBA4qxsCqe7QP/
vJUdnAxTq4Iri1SW7BKP+nc=

--Jat1ixbgLK/8tm3M--


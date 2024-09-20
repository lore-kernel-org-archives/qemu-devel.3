Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CB0CF9C60
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 18:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srhyE-0006a3-P5; Fri, 20 Sep 2024 14:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1srhyD-0006YX-4b
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 14:03:05 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1srhyA-0002jy-TU
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 14:03:04 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53661d95508so2257e87.1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726855380; x=1727460180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bofBxwt9eQWNhPNybPCc/0fu7JZxDxx/ho7OkhckqN8=;
 b=RMGq2p/t+1ePGVrvwvO/TpBeRDJJjc5PT5+7N7rVK6FB11LiOt4AYs5rwZa7FusuP0
 6odKdu3lyj7KXqhGj8znxDOCvPcA1VMiPkbM91xMEjGQSlSAOfoM1jttM53SiTE3Z7fr
 wH0bMzuoNDFKP2jj6lLpdBsUm6JND1Ayh2tc3xUPwgVdMPX5/Hm8PtZHUaKZLh39vq2l
 vT4l0VlbgW6BNuCZ8zvXuVb1FF26ZjHo3stZ/fJxEC3fX/QOMstzgrrVqTBNgrgS93yz
 xq4UQgP5s0QfIo5E+KdPQEW8SLH0k17qi/xPflVj+Mmq5rzSmtf+S/GcCcuNp+IFGduw
 oVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726855380; x=1727460180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bofBxwt9eQWNhPNybPCc/0fu7JZxDxx/ho7OkhckqN8=;
 b=e0X47WD+JzUzHrY3rgSi3BQtE/uHZO+Mf5pS6tKl8BQfzKCbq9d7jUqzxWN1vWxUCh
 jp2TZHYSre7Hn6dASPuek5cIMTSvqRvfyavAZdBNGSD0v521t8FZxvd+x5n29KRdVuOk
 ZQnC7vhDrjxyu4taQ7IDo7xv3+c+oAS3gEMHHq/KPpcmTLy7OL2MK0dd876occc9dQMJ
 ilqM94ezMt5PcPNKDlU8HKuBvMpqhN6wrOwXNUd99m0E/oQeqEdqTDTFLLSdNAlP43Db
 VpPk+CjYZuMzYa/AkQ189T5LP9jyDhGMwH9ZMCbxAzhxSBuCG53FoxRXMEhggbWgsZSB
 bZ0w==
X-Gm-Message-State: AOJu0YzAQXBHz5e3dh1WD3vyUxkWnLy4xod4/1xD8LqDyn+AZnjxcTQl
 3SGU0DoqDvOWGzveYuTaByJ2mJ2h9uljgWpFYCC4FU8Qmld2O5swqbig/fvsaGFPIWs1tel7xP9
 shqFdVrNNR3Hsgh1COr/IwBIOv5mR7I3mzuGs
X-Google-Smtp-Source: AGHT+IGJ1ETV5ZC91844XrR8qZ1tJ6gNM0bRQSbVmChqwtlkTGAVdGOE/OfumrQG1VuV36WsNiIXhSKXPXq9xbbz0pY=
X-Received: by 2002:a05:6512:3f1d:b0:535:68b2:9589 with SMTP id
 2adb3069b0e04-5374adc4e10mr23251e87.2.1726855379576; Fri, 20 Sep 2024
 11:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
 <20240918192254.3136903-9-tavip@google.com>
 <Zus1YzMOZD1ppO-2@mail.minyard.net>
 <CAGWr4cSvq+WnUQO3-8jyasQPhKGQCvzOYqRm5W8vRdhW9iU=xw@mail.gmail.com>
 <ZutGsQglLtK7MtRB@mail.minyard.net>
 <CAFEAcA_ZUkz8xv_PP27nD_eRL18v0cU6A7K+K57b8ML-9pmodQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_ZUkz8xv_PP27nD_eRL18v0cU6A7K+K57b8ML-9pmodQ@mail.gmail.com>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 20 Sep 2024 11:02:46 -0700
Message-ID: <CAGWr4cScq6+KQi2aJWtgSUSt+j28wXsxP240FfzTrCAFGRV14g@mail.gmail.com>
Subject: Re: [PATCH 08/25] hw/i2c: add support for flexcomm i2c
To: corey@minyard.net
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=tavip@google.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 19, 2024 at 2:36=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 18 Sept 2024 at 22:31, Corey Minyard <corey@minyard.net> wrote:
> > Generally it's frowned upon to have a ton of extra stuff that's not
> > used.  I would think some is ok, like defining bits in registers that
> > aren't used yet, but I have no idea how all the enums below here
> > actually tie into anything.  I'm guessing these are just bitmasks into
> > registers, but really, it's a lot easier to read if you have something
> > like:
> >
> > /*
> >  * The I2C Master function enable. When disabled, the Master
> >  * configuration settings are not changed, but the Master function is
> >  * internally reset.
> >  */
> > #define FLEXCOMM_I2C_CFG_MSTEN (1 << 4)
>
> The FIELD macro already gives you that:
>   FIELD(FLEXCOMM_I2C_CFG, MSTEN, startbit, len);
> will define an R_FLEXCOMM_I2C_CFG_MSTEN_MASK (which is
> (1 << startbit) for the 'len =3D=3D 1' case).
>
> You can also set and read a 1 bit field the same as
> any other, with the FIELD_DP32/FIELD_EX32 macros, so
> you don't often need to directly use the MASK macro:
>   s->cfg =3D FIELD_DP32(s->cfg, CFG, MSTEN, 1);
> and
>   if (FIELD_EX32(s->cfg, CFG, MSTEN)) {
>      ...
>   }
>
> The FIELD() macros are a bit unwieldy sometimes but the
> advantage over ad-hoc #defines is that they're consistent
> for every field in every register.
>
> I agree that providing enums for the possible values for 1-bit
> fields is a bit superfluous.
>

I went ahead and removed those 1-bit enum values and added support to
filter register/fields when generating the code. Also converted the
enums to defines to make these a little bit more compact as I don't
think we have any advantage over the enums?

So with the following invocation:

  run_target('svd-flexcomm-i2c', command: svd_gen_header +
    [ '-i', rt595, '-o', '@SOURCE_ROOT@/include/hw/arm/svd/flexcomm_i2c.h',
      '-p', 'I2C0', '-t', 'FLEXCOMM_I2C',
      '--fields', 'CFG TIMEOUT:TOMIN MSTCTL MSTDAT
STAT:MSTPENDING,MSTSTATE INT*:MSTPENDING* SLV*:'])

I am getting the below generated file. Note that the register info is
generated for all registers because this information is used to
initialize the reset values, mask writes appropriately in registers
and trace register access.

Please let me know if this looks good or if there are any other tweaks
I could make.

/*
 * Copyright 2016-2023 NXP SPDX-License-Identifier: BSD-3-Clause
 *
 * Automatically generated by svd-gen-header.py from MIMXRT595S_cm33.xml
 */
#pragma once

#include "hw/register.h"

/* I2C Bus Interface */
#define FLEXCOMM_I2C_REGS_NO (1024)

/* Configuration Register */
REG32(FLEXCOMM_I2C_CFG, 0x800);
/* Master Enable */
FIELD(FLEXCOMM_I2C_CFG, MSTEN, 0, 1);
/* Slave Enable */
FIELD(FLEXCOMM_I2C_CFG, SLVEN, 1, 1);
/* Monitor Enable */
FIELD(FLEXCOMM_I2C_CFG, MONEN, 2, 1);
/* I2C bus Time-out Enable */
FIELD(FLEXCOMM_I2C_CFG, TIMEOUTEN, 3, 1);
/* Monitor function Clock Stretching */
FIELD(FLEXCOMM_I2C_CFG, MONCLKSTR, 4, 1);
/* High Speed mode Capable enable */
FIELD(FLEXCOMM_I2C_CFG, HSCAPABLE, 5, 1);

/* Status Register */
REG32(FLEXCOMM_I2C_STAT, 0x804);
/* Master Pending */
FIELD(FLEXCOMM_I2C_STAT, MSTPENDING, 0, 1);
/* Master State code */
FIELD(FLEXCOMM_I2C_STAT, MSTSTATE, 1, 3);
/* Idle. The Master function is available to be used for a new transaction.=
 */
#define FLEXCOMM_I2C_STAT_MSTSTATE_IDLE 0
/*
 * Receive ready. Received data is available (in Master Receiver mode). Add=
ress
 * plus Read was previously sent and Acknowledged by a slave.
 */
#define FLEXCOMM_I2C_STAT_MSTSTATE_RECEIVE_READY 1
/*
 * Transmit ready. Data can be transmitted (in Master Transmitter mode).
 * Address plus Write was previously sent and Acknowledged by a slave.
 */
#define FLEXCOMM_I2C_STAT_MSTSTATE_TRANSMIT_READY 2
/* NACK Address. Slave NACKed address. */
#define FLEXCOMM_I2C_STAT_MSTSTATE_NACK_ADDRESS 3
/* NACK Data. Slave NACKed transmitted data. */
#define FLEXCOMM_I2C_STAT_MSTSTATE_NACK_DATA 4

/* Interrupt Enable Set Register */
REG32(FLEXCOMM_I2C_INTENSET, 0x808);
/* Master Pending interrupt Enable */
FIELD(FLEXCOMM_I2C_INTENSET, MSTPENDINGEN, 0, 1);

/* Interrupt Enable Clear Register */
REG32(FLEXCOMM_I2C_INTENCLR, 0x80C);
/* Master Pending interrupt clear */
FIELD(FLEXCOMM_I2C_INTENCLR, MSTPENDINGCLR, 0, 1);

/* Time-out Register */
REG32(FLEXCOMM_I2C_TIMEOUT, 0x810);
/* Time-out time value, the bottom 4 bits */
FIELD(FLEXCOMM_I2C_TIMEOUT, TOMIN, 0, 4);

/* Interrupt Status Register */
REG32(FLEXCOMM_I2C_INTSTAT, 0x818);
/* Master Pending */
FIELD(FLEXCOMM_I2C_INTSTAT, MSTPENDING, 0, 1);

/* Master Control Register */
REG32(FLEXCOMM_I2C_MSTCTL, 0x820);
/* Master Continue(write-only) */
FIELD(FLEXCOMM_I2C_MSTCTL, MSTCONTINUE, 0, 1);
/* Master Start control(write-only) */
FIELD(FLEXCOMM_I2C_MSTCTL, MSTSTART, 1, 1);
/* Master Stop control(write-only) */
FIELD(FLEXCOMM_I2C_MSTCTL, MSTSTOP, 2, 1);
/* Master DMA enable */
FIELD(FLEXCOMM_I2C_MSTCTL, MSTDMA, 3, 1);

/* Master Data Register */
REG32(FLEXCOMM_I2C_MSTDAT, 0x828);
/* Master function data register */
FIELD(FLEXCOMM_I2C_MSTDAT, DATA, 0, 8);

/* Slave Control Register */
REG32(FLEXCOMM_I2C_SLVCTL, 0x840);

/* Slave Data Register */
REG32(FLEXCOMM_I2C_SLVDAT, 0x844);

/* Slave Address Register */
REG32(FLEXCOMM_I2C_SLVADR0, 0x848);

/* Slave Address Register */
REG32(FLEXCOMM_I2C_SLVADR1, 0x84C);

/* Slave Address Register */
REG32(FLEXCOMM_I2C_SLVADR2, 0x850);

/* Slave Address Register */
REG32(FLEXCOMM_I2C_SLVADR3, 0x854);

/* Slave Qualification for Address 0 Register */
REG32(FLEXCOMM_I2C_SLVQUAL0, 0x858);


#define FLEXCOMM_I2C_REGISTER_ACCESS_INFO_ARRAY(_name) \
    struct RegisterAccessInfo _name[FLEXCOMM_I2C_REGS_NO] =3D { \
        [0 ... FLEXCOMM_I2C_REGS_NO - 1] =3D { \
            .name =3D "", \
            .addr =3D -1, \
        }, \
        [0x200] =3D { \
            .name =3D "CFG", \
            .addr =3D 0x800, \
            .ro =3D 0xFFFFFFC0, \
            .reset =3D 0x0, \
        }, \
        [0x201] =3D { \
            .name =3D "STAT", \
            .addr =3D 0x804, \
            .ro =3D 0xFCF57FAF, \
            .reset =3D 0x801, \
        }, \
        [0x202] =3D { \
            .name =3D "INTENSET", \
            .addr =3D 0x808, \
            .ro =3D 0xFCF476AE, \
            .reset =3D 0x0, \
        }, \
        [0x203] =3D { \
            .name =3D "INTENCLR", \
            .addr =3D 0x80C, \
            .ro =3D 0xFCF476AE, \
            .reset =3D 0x0, \
        }, \
        [0x204] =3D { \
            .name =3D "TIMEOUT", \
            .addr =3D 0x810, \
            .ro =3D 0xFFFF0000, \
            .reset =3D 0xFFFF, \
        }, \
        [0x205] =3D { \
            .name =3D "CLKDIV", \
            .addr =3D 0x814, \
            .ro =3D 0xFFFF0000, \
            .reset =3D 0x0, \
        }, \
        [0x206] =3D { \
            .name =3D "INTSTAT", \
            .addr =3D 0x818, \
            .ro =3D 0xFFFFFFFF, \
            .reset =3D 0x801, \
        }, \
        [0x208] =3D { \
            .name =3D "MSTCTL", \
            .addr =3D 0x820, \
            .ro =3D 0xFFFFFFF0, \
            .reset =3D 0x0, \
        }, \
        [0x209] =3D { \
            .name =3D "MSTTIME", \
            .addr =3D 0x824, \
            .ro =3D 0xFFFFFF88, \
            .reset =3D 0x77, \
        }, \
        [0x20A] =3D { \
            .name =3D "MSTDAT", \
            .addr =3D 0x828, \
            .ro =3D 0xFFFFFF00, \
            .reset =3D 0x0, \
        }, \
        [0x210] =3D { \
            .name =3D "SLVCTL", \
            .addr =3D 0x840, \
            .ro =3D 0xFFFFFCF4, \
            .reset =3D 0x0, \
        }, \
        [0x211] =3D { \
            .name =3D "SLVDAT", \
            .addr =3D 0x844, \
            .ro =3D 0xFFFFFF00, \
            .reset =3D 0x0, \
        }, \
        [0x212] =3D { \
            .name =3D "SLVADR0", \
            .addr =3D 0x848, \
            .ro =3D 0xFFFF7F00, \
            .reset =3D 0x1, \
        }, \
        [0x213] =3D { \
            .name =3D "SLVADR1", \
            .addr =3D 0x84C, \
            .ro =3D 0xFFFF7F00, \
            .reset =3D 0x1, \
        }, \
        [0x214] =3D { \
            .name =3D "SLVADR2", \
            .addr =3D 0x850, \
            .ro =3D 0xFFFF7F00, \
            .reset =3D 0x1, \
        }, \
        [0x215] =3D { \
            .name =3D "SLVADR3", \
            .addr =3D 0x854, \
            .ro =3D 0xFFFF7F00, \
            .reset =3D 0x1, \
        }, \
        [0x216] =3D { \
            .name =3D "SLVQUAL0", \
            .addr =3D 0x858, \
            .ro =3D 0xFFFFFF00, \
            .reset =3D 0x0, \
        }, \
        [0x220] =3D { \
            .name =3D "MONRXDAT", \
            .addr =3D 0x880, \
            .ro =3D 0xFFFFFFFF, \
            .reset =3D 0x0, \
        }, \
        [0x3FF] =3D { \
            .name =3D "ID", \
            .addr =3D 0xFFC, \
            .ro =3D 0xFFFFFFFF, \
            .reset =3D 0xE0301300, \
        }, \
    }


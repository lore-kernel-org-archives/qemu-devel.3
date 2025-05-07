Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E8AC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 08:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCaQI-0007tk-Fl; Wed, 07 May 2025 04:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uCaQG-0007sq-A1; Wed, 07 May 2025 04:46:36 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1uCaQE-0000RG-E4; Wed, 07 May 2025 04:46:36 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2d09d495c6cso1769755fac.3; 
 Wed, 07 May 2025 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746607592; x=1747212392; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnn2Vq4mb6y5HITMbTlLn96B2uBq2q4paLMypMJGpAI=;
 b=AE6isCGbsg1L9CwgCY4MGfBC4vH4MvE/8OhHcy5t1NROBQaSsReCx3Dx3U0gtDiXNX
 aqfANSvk263TkczPNDbJiUfkctungTfSihz6tLuVYtuBWVaomXBmbMCFgosqg57KKxTE
 3MNcuzJe68vjwwKb+k0UwWv+ZNJ29WT+jAncU4gM8YOILqzSrIoOqRx+md0n5+zis9Qu
 7VsAfc0wsdB7XmEjJhZroxSc7pOKu0KsUcyh+djsH6Tq1jKRNkpF9oq1vTctQfNPdu0t
 Kxxeze33MYHZ6yzQr2nFHk7rDqVAKKnNIgnZZE1qOv6nGIcXdy+OrMLSk5O01w94XNit
 7LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746607592; x=1747212392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnn2Vq4mb6y5HITMbTlLn96B2uBq2q4paLMypMJGpAI=;
 b=wm4cvwWouPo1OuyvohGZVbMwUV0XTbr2Xc0YwwGAfN2VnSbvYySvCu3izP/lup3wyd
 E1darD7wnWuSDhwuU0s+pEQUGYQsgenUhQsRjBHhOkScwW8GXisnKK7gr4aOW5cZzXbY
 RNi/6L3Bn31TA36VnEWJauDt//Ekb9Ub2sNomSWQM3Snhl+Dbggq8BIafijubXT4NUQl
 r4SN1BwnjJgg6ueGdE//0DyEQfsNjRwo9MNp8UOXOQeyZxK9tfg9brUvPhYV2+AVrWMm
 w0HAvgcUO6tGoKImPRFIjBZ9Rto6Rbhw9fNFGTEAa+r2d21ceM1Hik25loVeWaUvyhS6
 DAuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtFwGMj0Uj5DHbJQvqrz9j+GsXY17p1uRHhN1+sVPNSOe7xWsRP+tXsJYW3gxQrqIS/eveAPF3eyUj/Q==@nongnu.org,
 AJvYcCWoYDWPIxKPR4l8PNQwI4dDH7U9Z5pHkpQ7uI5m0LfJyddf2fo+WkqUn/2AXd6rZwmAztPJarpKMQ==@nongnu.org
X-Gm-Message-State: AOJu0Yzt8ZpkQ8bhv03OTcvfogHfOF1GtlaDuBZSa6UbBQURlABg2Z+t
 NKuguCr6JkyLn3bD0D9M/R7vKPfFC8Hcbws5eFjkbfyIFkkLnKtKopOQzhLzE1rDkNZ+NgsqE06
 XjALlEOcPelyojpqSKAnqTwIHC/8=
X-Gm-Gg: ASbGncsHAbgT0lU2oLuXTtuTaSH1DV0gf5vkZ0V5ek4Dq7x0InuCa8DczwYLGCt243r
 YAagiZgeQl3Ot2C4l7Zm/a8529I0/b8AW16kMgF4f26ujoaWg9LXxdEZTr9BKKiS/dbw6Y0HxYY
 8O3BwrZEZ+5sCMhjZq7m/Qc+s=
X-Google-Smtp-Source: AGHT+IFQOgpNB0obkG03QTu6CpAJ72MJxAg4BcfIqz65PWg0WgIkd+q/+b2Zw14fjBkLTDg7RnGSMMYr3h+RHIUQ9Qo=
X-Received: by 2002:a05:6870:891c:b0:2bd:456c:92a with SMTP id
 586e51a60fabf-2db5be369e8mr1380426fac.10.1746607591769; Wed, 07 May 2025
 01:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250418091208.1888768-1-timlee660101@gmail.com>
 <CAFEAcA_O1B7oXbK3RHLvSJHZaMSM-aVG_CD9Y7dH0OpAs7sibg@mail.gmail.com>
In-Reply-To: <CAFEAcA_O1B7oXbK3RHLvSJHZaMSM-aVG_CD9Y7dH0OpAs7sibg@mail.gmail.com>
From: Tim Lee <timlee660101@gmail.com>
Date: Wed, 7 May 2025 16:46:20 +0800
X-Gm-Features: ATxdqUGRxlYMsQyce2DuWwyKelYvna9Ur6BlQScs3BxuI_DWfa36HhgIuXTXtk8
Message-ID: <CAJG6D+hbqbLqQhqGA0sb4ngkuvC00ex7iR3p9UP-kWatoCGqUA@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Add qtest for NPCM8XX PSPI module
To: Peter Maydell <peter.maydell@linaro.org>
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 wuhaotsh@google.com, kfting@nuvoton.com, chli30@nuvoton.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=timlee660101@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Peter,
Thanks for your suggestion. Those changes will be included in v2.

Peter Maydell <peter.maydell@linaro.org> =E6=96=BC 2025=E5=B9=B45=E6=9C=886=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:52=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Fri, 18 Apr 2025 at 10:12, Tim Lee <timlee660101@gmail.com> wrote:
> >
> > - Created qtest to check initialization of registers in PSPI Module
> > - Implemented test into Build File
> >
> > Tested:
> > ./build/tests/qtest/npcm8xx-pspi_test
> >
> > Signed-off-by: Tim Lee <timlee660101@gmail.com>
> > ---
> >  MAINTAINERS                     |   1 +
> >  tests/qtest/meson.build         |   3 +
> >  tests/qtest/npcm8xx_pspi-test.c | 104 ++++++++++++++++++++++++++++++++
> >  3 files changed, 108 insertions(+)
> >  create mode 100644 tests/qtest/npcm8xx_pspi-test.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d54b5578f8..0162f59bf7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -892,6 +892,7 @@ F: hw/sensor/adm1266.c
> >  F: include/hw/*/npcm*
> >  F: tests/qtest/npcm*
> >  F: tests/qtest/adm1266-test.c
> > +F: tests/qtest/npcm8xx_pspi-test.c
>
> This file is already matched as being in this section by the
> wildcard two lines earlier.

MAINTAINERS file keep no change.
>
> >  F: pc-bios/npcm7xx_bootrom.bin
> >  F: pc-bios/npcm8xx_bootrom.bin
> >  F: roms/vbootrom
>
> > diff --git a/tests/qtest/npcm8xx_pspi-test.c b/tests/qtest/npcm8xx_pspi=
-test.c
> > new file mode 100644
> > index 0000000000..107bce681f
> > --- /dev/null
> > +++ b/tests/qtest/npcm8xx_pspi-test.c
> > @@ -0,0 +1,104 @@
> > +#include "qemu/osdep.h"
> > +#include "libqtest.h"
> > +#include "qemu/module.h"
>
> Every source file needs to start with the usual brief
> comment giving its copyright/license information (and we
> like that to include an SPDX-license-Identifier these days
> for new source files).
>

Add comment for copyright/license information.
> > +
> > +#define DATA_OFFSET 0x00
> > +#define CTL_SPIEN   0x01
> > +#define CTL_OFFSET  0x02
> > +#define CTL_MOD     0x04
> > +
> > +typedef struct PSPI {
> > +    uint64_t base_addr;
> > +} PSPI;
> > +
> > +PSPI pspi_defs =3D {
> > +    .base_addr  =3D 0xf0201000
> > +};
> > +
> > +static uint16_t pspi_read_data(QTestState *qts, const PSPI *pspi)
> > +{
> > +    return qtest_readw(qts, pspi->base_addr + DATA_OFFSET);
> > +}
> > +
> > +static void pspi_write_data(QTestState *qts, const PSPI *pspi, uint16_=
t value)
> > +{
> > +    qtest_writew(qts, pspi->base_addr + DATA_OFFSET, value);
> > +}
> > +
> > +static uint32_t pspi_read_ctl(QTestState *qts, const PSPI *pspi)
> > +{
> > +    return qtest_readl(qts, pspi->base_addr + CTL_OFFSET);
> > +}
> > +
> > +static void pspi_write_ctl(QTestState *qts, const PSPI *pspi, uint32_t=
 value)
> > +{
> > +    qtest_writel(qts, pspi->base_addr + CTL_OFFSET, value);
> > +}
>
> If I'm reading the implementation correctly, it makes both
> the DATA and CTL registers 16 bits, but this code has the
> data register 16 bits and the control register 32 bits.
> Which is correct ?
>

Yes, you are right! DATA and CLT registers both use 16 bits.
> > +/* Check PSPI can be reset to default value */
> > +static void test_init(gconstpointer pspi_p)
> > +{
> > +    const PSPI *pspi =3D pspi_p;
> > +
> > +    QTestState *qts =3D qtest_init("-machine npcm845-evb");
> > +    pspi_write_ctl(qts, pspi, CTL_SPIEN);
> > +    g_assert_cmphex(pspi_read_ctl(qts, pspi), =3D=3D, CTL_SPIEN);
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +/* Check PSPI can be r/w data register */
> > +static void test_data(gconstpointer pspi_p)
> > +{
> > +    const PSPI *pspi =3D pspi_p;
> > +    uint16_t test =3D 0x1234;
> > +    uint16_t output;
> > +
> > +    QTestState *qts =3D qtest_init("-machine npcm845-evb");
> > +
> > +    /* Write to data register */
> > +    pspi_write_data(qts, pspi, test);
> > +    printf("Wrote 0x%x to data register\n", test);
>
> Don't put printf()s in test cases, please. The test
> output is supposed to be TAP test protocol format, and
> the printfs insert random junk into that.
>
> If you need to output some kind of message, you can use
> g_test_message(), but for simple stuff like this I don't think
> the printfs are really adding anything, because the test is
> so short.
>

Remove printf() in test cases.
> > +
> > +    /* Read from data register */
> > +    output =3D pspi_read_data(qts, pspi);
> > +    printf("Read 0x%x from data register\n", output);
>
> Can we assert something useful here about what we read
> (e.g. that it's the same as what we wrote) ?
>

Currently, I just write test data to data register then read data from
it and verify it.
> > +
> > +    qtest_quit(qts);
> > +}
>
> thanks
> -- PMM



--=20
Best regards,
Tim Lee


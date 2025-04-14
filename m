Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5C8C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 21:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4R8K-0001y8-FK; Mon, 14 Apr 2025 17:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u4R8I-0001xJ-DY
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 17:14:22 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u4R8G-0006sl-Hz
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 17:14:22 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4774611d40bso81481cf.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744665258; x=1745270058; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyXYy0TxsCzGQDwyZDZ/T8g1YF2uIjz5iZRVQWLX5GM=;
 b=JVludzGXiWwsPzDF+hndNV1y82NBslRYqW0ssx12DTbgA82Osi9C9ucoyqVSnseyaT
 WX29kezmn5vOBxKcYVaU4cYaSVpScuy6R4DTyK8Vm5ozvuCBOJSCKiUgJdZ54CwaELB7
 pHU30MIpAbhrbXN+nLiULhIJA7kBzUXxHXKqxYMS214VNhy5IFBNUsaOagaU4Fk0x8P4
 kShSJiP98pZuiBqdJSolxopJCpKy3RIN3J4N5AP3BFQ7Wce5tHauYVkR6X8MEvdrINbF
 CmufPsn4lsnnN9Y50h7n+Ol7jpzhP+sLV1dB2EYzCn6DLPV55QD2MaDVIf2hrg2fL/PG
 c71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744665258; x=1745270058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyXYy0TxsCzGQDwyZDZ/T8g1YF2uIjz5iZRVQWLX5GM=;
 b=cBnya5gOT5mWMG7FBp06ycFo9B7JfrGUiPUwEfciJrCuniNPU39aWwPEcJxRBqzKcq
 d8Q9VMDU0/32blvD0wOgajjcwD+WaqfTU3cQ9DmjymRu9cLMVXCKuyAE4FzJlG80dAl9
 sjR2Q2xJHi4kzB6sCmbFZy5E1pThPf5r1RYxCi3ZXI9H0QVw+/NkCYz6prwO7NA11Q6e
 b8693+jG3Sc3FzoJVBikMf7IQ7QgYR7JMlT9W/I1cmXLDzmcJHV9Q14jsCazYI+UoCKi
 0GU+mbkzm+l/L6faXYa4z+PvJPXvucjlGCdtBOeK5XaMazXhoECVbB06FXe/KkD7ixO+
 +7BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe/0qWcYYgFpJl220Ni/DI5X1gsEIevozReo2QT8dke1cvQiSKwECWIEE5PIFk3ciQk1JfC3BonrIi@nongnu.org
X-Gm-Message-State: AOJu0YwC3QZJ1BfIeCJ4q5yrBQG1XK/ONhENGnJ90mBxa2IVk9eiJ1Kg
 1NeND6jyLZiTR3Wth5PbRfBwianCDKnOWDqrM986zlw6jTNiMWW8zUbkCOg1Epxigou7FFKc1dc
 Fs2vrNADaSzoYKcEV7G6xwxL0ml66Vz8WLGSr
X-Gm-Gg: ASbGnct1hUCw/EXIY9QuBAUPWI+JdVclPChDblQMRDwIASMpFFv+W26gyA1yK0tR8U/
 55OdAsVnVsstxa2Jyv2D5V63l+y6UzqOt+XFqMT5K4evlAvJ9+1HB6chosmVqjGfvEDy9yIzc4n
 5NTgwaDlZKcafS7ZEBOqLhI+lJN5XTHMyApvijBlWi9zYZyO60bE6X
X-Google-Smtp-Source: AGHT+IH8Nh4lRyNukmGqxQbSKXgzqAuEfvp8xDer+F64Ft1mEDOHLpD0IKaoGXjmfUbazzZIJRY07l+SWrKg4p/Y+Y8=
X-Received: by 2002:ac8:5e54:0:b0:476:f4e9:314e with SMTP id
 d75a77b69052e-47a6df7fe61mr531301cf.25.1744665258085; Mon, 14 Apr 2025
 14:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250410023856.500258-1-jamin_lin@aspeedtech.com>
 <20250410023856.500258-8-jamin_lin@aspeedtech.com>
 <860fbb39-feec-4c1d-b05f-aea7889a698f@kaod.org>
 <SI2PR06MB5041C73D934E10DEC9B66805FCB32@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041C73D934E10DEC9B66805FCB32@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 14 Apr 2025 14:14:06 -0700
X-Gm-Features: ATxdqUHbeBVHksXcaxozRloooei0x9lQC3xo_LIKfTeKeXH-RM-PTknDsIO8uWQ
Message-ID: <CA+QoejUvnwZBqS6nJBi5y=g1-r+f=9SnDD4SQOL3kxqeMbS_cw@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -178
X-Spam_score: -17.9
X-Spam_bar: -----------------
X-Spam_report: (-17.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.268,
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

Hi Jamin and Cedric,

On Sun, Apr 13, 2025 at 8:17=E2=80=AFPM Jamin Lin <jamin_lin@aspeedtech.com=
> wrote:
>
> Hi Cedric,
>
> > Subject: Re: [PATCH v2 07/10] hw/arm/aspeed: Add support for loading
> > vbootrom image via "-bios"
> >
> > On 4/10/25 04:38, Jamin Lin wrote:
> > > Introduce "aspeed_load_vbootrom()" to support loading a virtual boot
> > > ROM image into the vbootrom memory region, using the "-bios"
> > command-line option.
> > >
> > > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > > ---
> > >   hw/arm/aspeed.c | 32 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 32 insertions(+)
> > >
> > > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c index
> > > b70a120e62..2811868c1a 100644
> > > --- a/hw/arm/aspeed.c
> > > +++ b/hw/arm/aspeed.c
> > > @@ -27,6 +27,7 @@
> > >   #include "system/reset.h"
> > >   #include "hw/loader.h"
> > >   #include "qemu/error-report.h"
> > > +#include "qemu/datadir.h"
> > >   #include "qemu/units.h"
> > >   #include "hw/qdev-clock.h"
> > >   #include "system/system.h"
> > > @@ -305,6 +306,32 @@ static void
> > aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
> > >                      rom_size, &error_abort);
> > >   }
> > >
> > > +/*
> > > + * This function locates the vbootrom image file specified via the
> > > +command line
> > > + * using the -bios option. It loads the specified image into the
> > > +vbootrom
> > > + * memory region and handles errors if the file cannot be found or l=
oaded.
> > > + */
> > > +static void aspeed_load_vbootrom(MachineState *machine, uint64_t
> > > +rom_size)
> >
> > please add an 'Error **' parameter and let the caller decide to exit.
> >
>
> Will add.
>
> > > +{
> > > +    AspeedMachineState *bmc =3D ASPEED_MACHINE(machine);
> > > +    const char *bios_name =3D machine->firmware;
> > > +    g_autofree char *filename =3D NULL;
> > > +    AspeedSoCState *soc =3D bmc->soc;
> > > +    int ret;
> > > +
> > > +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> >
> > What if the user didn't provide any -bios command line option ?
> >
>
>
> Will update to support both vbootrom and loader.

For this case, could we have something like the npcm8xx_board.c where we
have a default bootrom and override it with -bios? That would also fix the
qtest issues with the ast2700 qtests which fail with this patchset.

>
> > > +    if (!filename) {
> > > +        error_report("Could not find vbootrom image '%s'", bios_name=
);
> > > +        exit(1);
> > > +    }
> > > +
> > > +    ret =3D load_image_mr(filename, &soc->vbootrom);
> > > +    if (ret < 0) {
> > > +        error_report("Failed to load vbootrom image '%s'", filename)=
;
> > > +        exit(1);
> > > +    }
> > > +}
> > > +
> > >   void aspeed_board_init_flashes(AspeedSMCState *s, const char
> > *flashtype,
> > >                                         unsigned int count, int
> > unit0)
> > >   {
> > > @@ -483,6 +510,11 @@ static void aspeed_machine_init(MachineState
> > *machine)
> > >           }
> > >       }
> > >
> > > +    if (amc->vbootrom) {
> > > +        rom_size =3D memory_region_size(&bmc->soc->vbootrom);> +
> > aspeed_load_vbootrom(machine, rom_size);
> > > +    }
> > > +
> >
> > Even without a vbootrom file, the machine could boot with '-device load=
er'
> > options. We should preserve this way of booting an ast2700-evb machine.
> >
>
> Will support both loader and vbootrom.
> Thanks for review and suggestion.
>
> Jamin
> >
> > Thanks,
> >
> > C.
> >
> >
> >
> >
> > >       arm_load_kernel(ARM_CPU(first_cpu), machine,
> > &aspeed_board_binfo);
> > >   }
> > >
>

Also, tested against our custom machine + custom bmc image and the
bootrom itself works.
I think it might just need that default set.

Tested-By: Nabih Estefan <nabihestefan@google.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83C6C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 16:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ipZ-0004hm-Nh; Tue, 15 Apr 2025 12:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u4ipP-0004fE-Qw
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 12:08:06 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1u4ipH-0003Nc-AW
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 12:08:02 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-47681dba807so252851cf.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744733272; x=1745338072; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67Seyv2EQ0eH3fvOgQj/T82RXsQkB/pngLiaqKyBV0I=;
 b=H/izhTIFFMqgloOKyebQ6GlCeQXdHfH4zMyBc+4yUkl5mg1+mCYaaTRxhyhKgVwwGs
 Op/D1uNIDIxc9HAuyJ4lBoVGOGAKz3PUkewUzAhuekaXDLWdAn1nzce8CHA0Q7ZOKhK+
 a1PL9hNpRkM+Y3UrRLu+rDFYvESpFbMOA9tAdL7dxSc2C6mt6+6wWv2VImiYK4/ZGLOk
 mssv/JGldLUHvuX+nV1ZPmHW4KNZhtjLZ/mhp88dOZgfcSejCjXQI3Io0dcodYHAxABp
 pIXXEWgMRRd8oeDm5nHYiTYuJf8fSYXOFd3sTPwfWLhkUlqPBJ9VJxlwXbj2MNOzvhcF
 iO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744733272; x=1745338072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=67Seyv2EQ0eH3fvOgQj/T82RXsQkB/pngLiaqKyBV0I=;
 b=AVnwoDMnufSlZQqU0W6PsetqWieXxEPWmTxAfHMZ41HAot4sdFzhM2eCEYvTBYyLg1
 trKuJ532vtQFQlWrFeEWKdD/ISp6abhktwbPtvj8nu9Xz2D9mw99r/z7Ch/lZdmfbrXx
 kzOQqbqC8m4bBpyokPj3I21mHslX494H6fraeyPcqyQMDO1xvv18a6m2rFnNldjsulGX
 2JaNFPFrReIQAp8aAMvXVRmDx+1wA4WWhlcpF/KN+ScPAUH1IUnTnF1YLCFcNuD6fVv6
 Y9K1usdl/L3OZ4g2cujhYlPXX94CF0bDgiwhshi6QOa9Kd8/SIFxRxI9qqhG5IayfNqq
 T67w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq7AzrDZa9QkSvzeXj+nfRy2Ymdmlc/fgZ/v2dYcuV2yRK4HqO5lD9vXENED+fJ4hLAXpiflHycMqP@nongnu.org
X-Gm-Message-State: AOJu0YzL8Pl7PhNsX1ryeOTOeq7wymNb4LLs5qBb9b5EkrRegrXrfOgW
 J8rWBAeKzCMWb2xU5W/yeM3I50aOpG0WHhixnYx7XX5/3LCyAArMkn8u5f2xOeyJjg83FIqwtNm
 8uySY7gxtWfaUdc/OlPirEG6inai112rPu1DU
X-Gm-Gg: ASbGncsLiNOvsU0ld/8ILwzT3sUvO6IpcVslkpfqheskerWdj5/2E2IZS3v5zFl70yP
 nYG3Ufwr+jknFyvSHsa63lOWuC3ZRegwRwRTB0J9jjNtO9icOjPwb3r+eZ1P36JvmWQUvbL4TEG
 6hj+oibcPAnIsqQdn73wtBDnjsSoxh06mRd+Fp0CS1sNfD+GDEM3Xa
X-Google-Smtp-Source: AGHT+IHLXbIlE2rpVA1qdj9HHrbJPDFOSDtuSkXOi+z2wLlgPRnzWPf+xR8fFJnnHG5vbo8IQngl0n4ZXS/uSyaN5kI=
X-Received: by 2002:ac8:5801:0:b0:477:1f86:178c with SMTP id
 d75a77b69052e-47a6df06376mr4380841cf.26.1744733271903; Tue, 15 Apr 2025
 09:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250410023856.500258-1-jamin_lin@aspeedtech.com>
 <20250410023856.500258-8-jamin_lin@aspeedtech.com>
 <860fbb39-feec-4c1d-b05f-aea7889a698f@kaod.org>
 <SI2PR06MB5041C73D934E10DEC9B66805FCB32@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CA+QoejUvnwZBqS6nJBi5y=g1-r+f=9SnDD4SQOL3kxqeMbS_cw@mail.gmail.com>
 <SI2PR06MB50413B875162D6ADD2F182ECFCB22@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB50413B875162D6ADD2F182ECFCB22@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Tue, 15 Apr 2025 09:07:40 -0700
X-Gm-Features: ATxdqUEDZ5sbYGTAI86OPcyf-gBj1X5yKajDTplXBh0qjAyehNVapIKvkzq136A
Message-ID: <CA+QoejWEn-B8E_QC-hAM87j_5TQXMYZRgDNUvq5qUTYUr9VQ-Q@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82c.google.com
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

Hi Jamin,


On Tue, Apr 15, 2025 at 2:35=E2=80=AFAM Jamin Lin <jamin_lin@aspeedtech.com=
> wrote:
>
> Hi Nabih,
>
> > <qemu-arm@nongnu.org>; Troy Lee <troy_lee@aspeedtech.com>
> > Subject: Re: [PATCH v2 07/10] hw/arm/aspeed: Add support for loading
> > vbootrom image via "-bios"
> >
> > Hi Jamin and Cedric,
> >
> > On Sun, Apr 13, 2025 at 8:17=E2=80=AFPM Jamin Lin <jamin_lin@aspeedtech=
.com>
> > wrote:
> > >
> > > Hi Cedric,
> > >
> > > > Subject: Re: [PATCH v2 07/10] hw/arm/aspeed: Add support for loadin=
g
> > > > vbootrom image via "-bios"
> > > >
> > > > On 4/10/25 04:38, Jamin Lin wrote:
> > > > > Introduce "aspeed_load_vbootrom()" to support loading a virtual
> > > > > boot ROM image into the vbootrom memory region, using the "-bios"
> > > > command-line option.
> > > > >
> > > > > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > > > > ---
> > > > >   hw/arm/aspeed.c | 32 ++++++++++++++++++++++++++++++++
> > > > >   1 file changed, 32 insertions(+)
> > > > >
> > > > > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c index
> > > > > b70a120e62..2811868c1a 100644
> > > > > --- a/hw/arm/aspeed.c
> > > > > +++ b/hw/arm/aspeed.c
> > > > > @@ -27,6 +27,7 @@
> > > > >   #include "system/reset.h"
> > > > >   #include "hw/loader.h"
> > > > >   #include "qemu/error-report.h"
> > > > > +#include "qemu/datadir.h"
> > > > >   #include "qemu/units.h"
> > > > >   #include "hw/qdev-clock.h"
> > > > >   #include "system/system.h"
> > > > > @@ -305,6 +306,32 @@ static void
> > > > aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
> > > > >                      rom_size, &error_abort);
> > > > >   }
> > > > >
> > > > > +/*
> > > > > + * This function locates the vbootrom image file specified via
> > > > > +the command line
> > > > > + * using the -bios option. It loads the specified image into the
> > > > > +vbootrom
> > > > > + * memory region and handles errors if the file cannot be found =
or
> > loaded.
> > > > > + */
> > > > > +static void aspeed_load_vbootrom(MachineState *machine, uint64_t
> > > > > +rom_size)
> > > >
> > > > please add an 'Error **' parameter and let the caller decide to exi=
t.
> > > >
> > >
> > > Will add.
> > >
> > > > > +{
> > > > > +    AspeedMachineState *bmc =3D ASPEED_MACHINE(machine);
> > > > > +    const char *bios_name =3D machine->firmware;
> > > > > +    g_autofree char *filename =3D NULL;
> > > > > +    AspeedSoCState *soc =3D bmc->soc;
> > > > > +    int ret;
> > > > > +
> > > > > +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> > > >
> > > > What if the user didn't provide any -bios command line option ?
> > > >
> > >
> > >
> > > Will update to support both vbootrom and loader.
> >
> > For this case, could we have something like the npcm8xx_board.c where w=
e
> > have a default bootrom and override it with -bios? That would also fix =
the qtest
> > issues with the ast2700 qtests which fail with this patchset.
> >
> Do you mean that if the user does not specify "-bios", we should still lo=
ad a default vbootrom image into the vbootrom memory region?
> We can verify whether -bios was provided by checking if machine->firmware=
 is NULL.
> It seems that if the user doesn't provide -bios, NPCM QEMU will look for =
a default vbootrom image in the current working directory =E2=80=94 is that=
 correct?
> https://github.com/qemu/qemu/blob/master/hw/arm/npcm8xx_boards.c#L37

Yeah. IIUC the default functionality should be to use a vbootrom to
boot with the AST27X0 so
if there is no bootrom declared we should default to the one you
created. for the NPCM one, if
we don't provide bios it will default to the one in pc-bios since it's
supposed to be the base true version.
I think it makes sense to do the same thing in ast2700. If we really
find use in supporting attaching the
loader binaries separately we could add a flag that skip the vbootrom,
but I don't see much use in that
since the information that would change is in the "image-bmc".

>
> ```
> const char *bios_name =3D machine->firmware ?: npcm8xx_default_bootrom;
> ```
> Could you let me know which qtest(s) failed, so I can run them and verify=
 everything before sending out the v3 patch?

qemu:qtest+qtest-aarch64 / qtest-aarch64/ast2700-gpio-test
qemu:qtest+qtest-aarch64 / qtest-aarch64/ast2700-smc-test

They both fail with " qemu-system-aarch64: Could not find vbootrom
image '(null)' " so setting the default
bootrom should fix this.

>
> Thanks-Jamin
>
> > >
> > > > > +    if (!filename) {
> > > > > +        error_report("Could not find vbootrom image '%s'",
> > bios_name);
> > > > > +        exit(1);
> > > > > +    }
> > > > > +
> > > > > +    ret =3D load_image_mr(filename, &soc->vbootrom);
> > > > > +    if (ret < 0) {
> > > > > +        error_report("Failed to load vbootrom image '%s'", filen=
ame);
> > > > > +        exit(1);
> > > > > +    }
> > > > > +}
> > > > > +
> > > > >   void aspeed_board_init_flashes(AspeedSMCState *s, const char
> > > > *flashtype,
> > > > >                                         unsigned int count, int
> > > > unit0)
> > > > >   {
> > > > > @@ -483,6 +510,11 @@ static void aspeed_machine_init(MachineState
> > > > *machine)
> > > > >           }
> > > > >       }
> > > > >
> > > > > +    if (amc->vbootrom) {
> > > > > +        rom_size =3D memory_region_size(&bmc->soc->vbootrom);> +
> > > > aspeed_load_vbootrom(machine, rom_size);
> > > > > +    }
> > > > > +
> > > >
> > > > Even without a vbootrom file, the machine could boot with '-device =
loader'
> > > > options. We should preserve this way of booting an ast2700-evb mach=
ine.
> > > >
> > >
> > > Will support both loader and vbootrom.
> > > Thanks for review and suggestion.
> > >
> > > Jamin
> > > >
> > > > Thanks,
> > > >
> > > > C.
> > > >
> > > >
> > > >
> > > >
> > > > >       arm_load_kernel(ARM_CPU(first_cpu), machine,
> > > > &aspeed_board_binfo);
> > > > >   }
> > > > >
> > >
> >
> > Also, tested against our custom machine + custom bmc image and the boot=
rom
> > itself works.
> > I think it might just need that default set.
> >
> > Tested-By: Nabih Estefan <nabihestefan@google.com>

Thanks,
Nabih


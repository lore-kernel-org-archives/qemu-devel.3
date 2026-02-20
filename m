Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C4EC5518F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 10:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtNS7-0007I2-Py; Fri, 20 Feb 2026 05:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vtNRw-0007Gi-Le
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 05:09:29 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vtNRr-0000Ib-Vt
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 05:09:27 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aae4d2d215so4220245ad.2
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 02:09:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771582160; cv=none;
 d=google.com; s=arc-20240605;
 b=ImGKlrUSAaws1yzPN76RideIbylnkTwBwBRCvIlD7957AuwB7D8tMPBI7xuJkP3zHA
 VFZG2qv4qdPraBnsdXopMYXA+HUNWvEDxj6aq7+03ZwgxCcnfM/deKgbw+MNopZ7GYu2
 UuTLwnr4sdTwU9u7wPRMiVCumtOCRrR94mcc1lO1PrHMnoyXgZNKoamSxdn9WDpQeTXQ
 Zi1zYSX5Qppwnphx1MKjdrtNFQaiSYrZojVsKur/b9O0CMgzKwK0+AotpIk7lZywKs1z
 D1HnDobTX2nDL1gkubjcoQ4u/xLJWKGK+vfh3Ti5O3ZYaflDoPOp7xiVBKnqZGwN5+A2
 eRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ese2sL9v/f9W32K3UxAWYt0Ncs+9G53kUmczWW+usy4=;
 fh=l7jCX4xjXU5APOXwjPqqxx9z9GrrG3/k+zsKo3BLjeU=;
 b=DWFqi1OUd9ImxEWtIXyTSNVKEDV4k8BQz8VX3ycogDfX0UIxPllUhWw8b0nhOfppxi
 8xjQ9rLz/RBiTYz1o63H8ctuPefs1JDB42sUWb6v9iEnJuDNvGqet4SIBmmfWk/mdSzJ
 YafxWrj5FS3CgFCMWZeFhm4ZN4uiJc5Ow0x9HtmrslhOAxYAfrQrz3H0FP2nN9thtoJh
 +KdEmsqeD1+ZzQuZ6glmMTUewFHy+Zy+ov/g1Ei46R5N5wqxDYNxDjleKAh9axENCrER
 sjJ947jlvdbGEdqW7oCRjlNmf8RdZyXf7i1tbH35Rwl64rFEXLWwwL/ZywfJHP3iFI3o
 EdtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771582160; x=1772186960; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ese2sL9v/f9W32K3UxAWYt0Ncs+9G53kUmczWW+usy4=;
 b=UJ1gDs3HbUl/6R7iG7oulfDvWV5spCLOQ8Ir9xtoCb7+qEj3DKC8CH9XA8weSIE0rB
 f/F8DGHQrMSbBWyxfFQokJMMfquqs29Qgi+xPuVMQoXP/AqvpeyVxNqklh6u1n+g04TV
 KcNV3UHAS7eAs68rni3TLXy/S4D1PDW3WB0gQuYsFRX+TDX8igMDyHuNjde1DK33R4PI
 3S9Nl4yOJNBPN5MWd+s9T437rkVwYmwQlvmzPgn1u3bv41tb1fqJao6yu79p19tvw8JE
 FWdj97K3tE0UPynk9AHaob7ewJ2d7lcgKRN9t2XN0WDNrroJOX00yKwi1gnfixtE5bYG
 xy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771582160; x=1772186960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ese2sL9v/f9W32K3UxAWYt0Ncs+9G53kUmczWW+usy4=;
 b=iNnx2trGi9grIaBjAFgiyf/F3JyGFWqj0D1Xk1aCsD16OIvIh3hXGynCC0FuMgWAcj
 WVTVItW0x33jxx6Bexrc360M+CJIgQPagHFzshAdZITRRSuCVN1K0SnvhQfJZOcxbAhh
 kqrPljA+0BstE7c7EqBF43xqZB+jmPopqKr48OB1PxIr9ABhJOWArVFknBcm8rjQPuEr
 umKIl7+Axe9tA7DV4w9vlhCi5nCzbKNj6gVsgnHeffg9Is+mcmJ2upgmPiWYs8DgkT32
 1kw1rVHqZH+RA5rnh7MwZnPCv6/fRTum/j3JYH4Do8nI/jyOc8E1cvEXorXut5JZ4DWU
 slwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE7PuuPGgSVZaK3VfCkQCLWC0hkZjFhH1mHeAZyEwda5b/NZ9vxjsfGtNbeXTtE8qodmeOp6OJh3L+@nongnu.org
X-Gm-Message-State: AOJu0YyydSbIGacXULicLuv39T33EHuulZ3+AMZs3e8WTA74R0WCjk3R
 ZemVNtrMAOlCHMUQC1QlvJS8K0DXdNk15Xlgqb+SomodtAC7C1MVw5wLjIZhN+1RObBijKk0O7E
 uQU85BVW7+9MsRfdvr8j92tNtkOiXjBI=
X-Gm-Gg: AZuq6aK8Oe3SxxlxbXwuZv8Kajym0iVjjnEB7SoKjBFE8xd4l8/lAoSD8ywfUWEW1AE
 OpjQuQJSSvYD0s3vEeMnvPqtemWL+rGlUIdUpC9S3mD8JTPOLx4Phbc6VZdHJvJI9HCmRP2DQ2E
 Hw4FX0z78kCvpcaDNDcmR409dV43T1UrcBC5wB+ynOYWYBgnKHxkB3vznr8yTSuG2bGEvNmv5Zu
 Xtr5ZJPTtGsWWKdTL0pJFoHey9uDaWOJWsVPT3Y6oAHwYz0NAhKkfgEAvJhU+VK/ay55T0DjVrl
 Om7LT/j8CHKJgWJDTo9ZJVRGsm+wHntgpbT5psfOsA==
X-Received: by 2002:a17:903:1a03:b0:2aa:f7a2:2598 with SMTP id
 d9443c01a7336-2ab4d001c8bmr190704795ad.5.1771582160057; Fri, 20 Feb 2026
 02:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
 <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
 <CAFEAcA8xsFeCAnvna4+mFQuZCx8gNEJX5BbFzTYkr6rcaX43Lw@mail.gmail.com>
 <b780d16f-82ba-43e2-b189-ba70594c7d7a@redhat.com>
In-Reply-To: <b780d16f-82ba-43e2-b189-ba70594c7d7a@redhat.com>
From: Joel Bueno <buenocalvachejoel@gmail.com>
Date: Fri, 20 Feb 2026 11:09:08 +0100
X-Gm-Features: AaiRm51f9xPvqvMipYI--yA5vOV2Y6LAPYa_tycv0tpzQ70MyQ4ta0SCdy-vopQ
Message-ID: <CAPDLHD6ecMFX-Ls0inPM6kDrWXAKLiqf+jLXbUiFDgVGjBCruA@mail.gmail.com>
Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 Marcin Krzeminski <marcin.krzeminski@nokia.com>
Content-Type: multipart/alternative; boundary="000000000000573971064b3e9d35"
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=buenocalvachejoel@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000573971064b3e9d35
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi C=C3=A9dric, thanks for the detailed response and your time; I should've=
 run
the tests prior to the submission; apologies for the oversight!

I've been eyeing the aspeed_smc.c file and it seems to "inflate" the dummy
clock phases:

static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
{
    const AspeedSMCState *s =3D fl->controller;
    uint32_t r_ctrl0 =3D s->regs[s->r_ctrl0 + fl->cs];
    uint32_t dummy_high =3D (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
    uint32_t dummy_low =3D (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
    uint32_t dummies =3D ((dummy_high << 2) | dummy_low) * 8;

    if (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA) {
        dummies /=3D 2;
    }

    return dummies;
}

As you can see, it basically multiplies the number of "dummies" (Which is
gathered by obtaining the full value of the register) by 8.
That is, in turn, used on "aspeed_smc_flash_setup" (Only
if aspeed_smc_flash_mode(fl) =3D=3D CTRL_FREADMODE) to decide how much dumm=
y
data to push with "ssi_transfer()".

It's a bit confusing for me to compare what the actual Winbond datasheet we
have (Also cross-referenced similar product's datasheets just in case)
expects in terms of needed_bytes (Which, as per datasheet, would be just 1,
matching what, for instance, SST ones have; for reference).

The Designware SPI controller QEMU device we have sends a single byte (8
cycles in SPI) to the flash (Again, matching both Designware's and
Winbond's datasheet).

Would it be interesting to have a second set of patch series trying to
address the inconsistencies (Whilst addressing aspeed too) and making the
Winbond model with what SST currently does in terms of "naming" convention?

Thanks again for everyone's time.


El vie, 20 feb 2026 a las 9:56, C=C3=A9dric Le Goater (<clg@redhat.com>)
escribi=C3=B3:

> Hello,
>
> +Marcin,
>
> On 2/19/26 21:01, Peter Maydell wrote:
> > On Wed, 7 Jan 2026 at 11:30, Joel Bueno <buenocalvachejoel@gmail.com>
> wrote:
> >>
> >> Is there any feedback on this patch series?
> >
> > Which board model(s) does this affect? You might have
> > some luck cc'ing their maintainers.
> AFAIR (10y ago ...), the dummy cycles in m25p80 are modeled as
> extra "dummy bytes" consumed before data phase begins. So,
> in QEMU : 8 cycles =3D 1 dummy byte.
>
> There could be bugs in this area, but this case was supposedly
> fixed by commit 3830c7a460b8 ("m25p80: Fix WINBOND fast read
> command handling") and given the number of QEMU boards booting
> from a Winbond flash device :
>
>    tests/functional/aarch64/test_aspeed_ast2700a1.py:
> self.vm.set_machine('ast2700a1-evb,fmc-model=3Dw25q512jv')
>    tests/functional/aarch64/test_aspeed_ast2700a2.py:
> self.vm.set_machine('ast2700a2-evb,fmc-model=3Dw25q512jv')
>    hw/arm/aspeed_ast10x0_evb.c:    amc->fmc_model =3D "w25q80bl";
>    hw/arm/aspeed_ast10x0_evb.c:    amc->spi_model =3D "w25q256";
>    hw/arm/aspeed_ast10x0_evb.c:    amc->fmc_model =3D "w25q80bl";
>    hw/arm/aspeed_ast10x0_evb.c:    amc->spi_model =3D "w25q02jvm";
>    hw/arm/aspeed_ast2600_bletchley.c:    amc->fmc_model =3D "w25q01jvq";
>    hw/arm/aspeed_ast2600_catalina.c:    amc->fmc_model =3D "w25q01jvq";
>    hw/arm/aspeed_ast2600_evb.c:    amc->fmc_model =3D "w25q512jv";
>    hw/arm/aspeed_ast2600_evb.c:    amc->spi_model =3D "w25q512jv";
>    hw/arm/aspeed_ast27x0_evb.c:    amc->fmc_model =3D "w25q01jvq";
>    hw/arm/aspeed_ast27x0_evb.c:    amc->spi_model =3D "w25q512jv";
>    hw/arm/aspeed_ast27x0_evb.c:    amc->fmc_model =3D "w25q01jvq";
>    hw/arm/aspeed_ast27x0_evb.c:    amc->spi_model =3D "w25q512jv";
>    hw/arm/aspeed_ast27x0-fc.c:#define AST2700FC_FMC_MODEL "w25q01jvq"
>    hw/arm/aspeed_ast27x0-fc.c:#define AST2700FC_SPI_MODEL "w25q512jv"
>    hw/arm/npcm7xx_boards.c:    npcm7xx_connect_flash(&soc->fiu[0], 0,
> "w25q256", drive_get(IF_MTD, 0, 0));
>    hw/arm/npcm8xx_boards.c:    npcm8xx_connect_flash(&soc->fiu[0], 0,
> "w25q256", drive_get(IF_MTD, 0, 0));
>
> I doubt this change is correct or the issue is more complex
> than it seems. Please try to run the functional tests, all
> ast2600 machines seem to fail to boot with this patch.
>
>
> Thanks,
>
> C.
>
>
> For the records, fast read commands are used in the tests. See below.
>
>    [0x406c0641] : The second byte '6c' is the SPI operation.
>
>
> aarch64/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/c=
onsole.log:2026-02-11
> 13:22:45,545: [    0.510414] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/c=
onsole.log:2026-02-11
> 13:22:45,713: [    0.650635] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_ev=
b_sdk_v11_00/console.log:2026-02-13
> 11:49:30,173: [    1.517517] spi-aspeed-smc 14000000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_ev=
b_sdk_v11_00/console.log:2026-02-13
> 11:49:30,320: [    1.608993] spi-aspeed-smc 14000000.spi: CE1 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_ev=
b_sdk_v11_00/console.log:2026-02-13
> 11:49:30,346: [    1.625580] spi-aspeed-smc 14010000.spi: CE0 read
> buswidth: 2 [0x203c0641]
> aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_ev=
b_ioexp_v11_00/console.log:2026-02-13
> 15:50:03,329: [    4.852499] spi-aspeed-smc 14000000.spi: CE0 read
> buswidth: 4 [0x406c0041]
> aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_ev=
b_ioexp_v11_00/console.log:2026-02-13
> 15:50:03,850: [    5.178221] spi-aspeed-smc 14010000.spi: CE0 read
> buswidth: 1 [0x000c0041]
> aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_ev=
b_sdk_v11_00/console.log:2026-02-13
> 11:49:31,247: [    1.275618] spi-aspeed-smc 14000000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_ev=
b_sdk_v11_00/console.log:2026-02-13
> 11:49:31,369: [    1.352064] spi-aspeed-smc 14000000.spi: CE1 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_ev=
b_sdk_v11_00/console.log:2026-02-13
> 11:49:31,385: [    1.361942] spi-aspeed-smc 14010000.spi: CE0 read
> buswidth: 2 [0x203c0641]
> aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_io=
exp_v11_00/console.log:2026-02-10
> 16:47:50,922: [    3.123120] spi-aspeed-smc 14000000.spi: CE0 read
> buswidth: 4 [0x406c0041]
> aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_io=
exp_v11_00/console.log:2026-02-10
> 16:47:51,224: [    3.312014] spi-aspeed-smc 14010000.spi: CE0 read
> buswidth: 1 [0x000c0041]
> aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sd=
k_v11_00/console.log:2026-02-10
> 16:49:00,279: [    1.264763] spi-aspeed-smc 14000000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sd=
k_v11_00/console.log:2026-02-10
> 16:49:00,408: [    1.345588] spi-aspeed-smc 14000000.spi: CE1 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sd=
k_v11_00/console.log:2026-02-10
> 16:49:00,424: [    1.355559] spi-aspeed-smc 14010000.spi: CE0 read
> buswidth: 2 [0x203c0641]
> aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sd=
k_vbootrom_v11_00/console.log:2026-02-13
> 11:49:40,859: [    1.568162] spi-aspeed-smc 14000000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sd=
k_vbootrom_v11_00/console.log:2026-02-13
> 11:49:41,032: [    1.676511] spi-aspeed-smc 14000000.spi: CE1 read
> buswidth: 4 [0x406c0641]
> aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sd=
k_vbootrom_v11_00/console.log:2026-02-13
> 11:49:41,069: [    1.699459] spi-aspeed-smc 14010000.spi: CE0 read
> buswidth: 2 [0x203c0641]
> arm/test_aspeed_ast2500_buildroot.AST2500Machine.test_arm_ast2500_evb_bui=
ldroot/console.log:2026-02-13
> 15:50:25,370: [    1.333537] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth:2 [0x203b0641]
> arm/test_aspeed_ast2500_buildroot.AST2500Machine.test_arm_ast2500_evb_bui=
ldroot/console.log:2026-02-13
> 15:50:25,659: [    1.625199] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth:2 [0x203c0041]
> arm/test_aspeed_ast2500_sdk.AST2500Machine.test_arm_ast2500_evb_sdk/conso=
le.log:2026-02-13
> 15:50:22,593: [    1.287417] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth: 2 [0x203b0641]
> arm/test_aspeed_ast2500_sdk.AST2500Machine.test_arm_ast2500_evb_sdk/conso=
le.log:2026-02-13
> 15:50:23,319: [    2.013603] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth: 2 [0x203c0741]
> arm/test_aspeed_ast2600_buildroot.AST2600Machine.test_arm_ast2600_evb_bui=
ldroot/console.log:2026-02-13
> 15:50:35,593: [    2.848343] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth:4 [0x406c0641]
> arm/test_aspeed_ast2600_buildroot.AST2600Machine.test_arm_ast2600_evb_bui=
ldroot/console.log:2026-02-13
> 15:50:35,876: [    3.086504] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth:4 [0x406c0041]
> arm/test_aspeed_ast2600_buildroot_tpm.AST2600Machine.test_arm_ast2600_evb=
_buildroot_tpm/console.log:2026-02-13
> 15:51:11,310: [    1.769397] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth:4 [0x406c0641]
> arm/test_aspeed_ast2600_buildroot_tpm.AST2600Machine.test_arm_ast2600_evb=
_buildroot_tpm/console.log:2026-02-13
> 15:51:11,400: [    1.844341] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth:4 [0x406c0041]
> arm/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/conso=
le.log:2026-02-13
> 15:50:31,578: [    4.177582] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> arm/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/conso=
le.log:2026-02-13
> 15:50:32,052: [    4.571849] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> arm/test_aspeed_ast2600_sdk_otp.AST2600Machine.test_arm_ast2600_otp_block=
dev_device/console.log:2026-02-13
> 15:50:27,134: [    2.312565] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> arm/test_aspeed_ast2600_sdk_otp.AST2600Machine.test_arm_ast2600_otp_block=
dev_device/console.log:2026-02-13
> 15:50:27,533: [    2.644716] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth: 4 [0x406c0641]
> arm/test_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_ope=
nbmc/console.log:2026-02-13
> 15:50:39,306: [    2.488488] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth:2 [0x203c0641]
> arm/test_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_ope=
nbmc/console.log:2026-02-13
> 15:50:46,183: [    8.220262] spi-aspeed-smc 1e620000.spi: CE1 read
> buswidth:2 [0x203c0041]
> arm/test_aspeed_catalina.CatalinaMachine.test_arm_ast2600_catalina_openbm=
c/console.log:2026-02-13
> 15:50:34,667: [    1.470919] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth:2 [0x203c0641]
> arm/test_aspeed_catalina.CatalinaMachine.test_arm_ast2600_catalina_openbm=
c/console.log:2026-02-13
> 15:50:41,745: [    7.369080] spi-aspeed-smc 1e620000.spi: CE1 read
> buswidth:2 [0x203c0041]
> arm/test_aspeed_gb200nvl_bmc.GB200Machine.test_arm_aspeed_gb200_openbmc/c=
onsole.log:2026-02-13
> 15:50:22,255: [    1.277601] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth:4 [0x406c0641]
> arm/test_aspeed_gb200nvl_bmc.GB200Machine.test_arm_aspeed_gb200_openbmc/c=
onsole.log:2026-02-13
> 15:50:22,589: [    1.558898] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth:4 [0x406c0041]
> arm/test_aspeed_palmetto.PalmettoMachine.test_arm_ast2400_palmetto_openbm=
c/console.log:2026-02-13
> 15:50:31,164: [    0.840722] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth:2 [0x203b0641]
> arm/test_aspeed_palmetto.PalmettoMachine.test_arm_ast2400_palmetto_openbm=
c/console.log:2026-02-13
> 15:50:31,405: [    1.082523] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth:2 [0x203c2041]
> arm/test_aspeed_romulus.RomulusMachine.test_arm_ast2500_romulus_openbmc/c=
onsole.log:2026-02-13
> 15:50:35,622: [    1.281889] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth:2 [0x203b0641]
> arm/test_aspeed_romulus.RomulusMachine.test_arm_ast2500_romulus_openbmc/c=
onsole.log:2026-02-13
> 15:50:35,832: [    1.491569] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth:2 [0x203c0041]
> arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspo=
on_openbmc/console.log:2026-02-13
> 15:50:44,149: [    0.885126] spi-aspeed-smc 1e620000.spi: CE0 read
> buswidth:2 [0x203c0641]
> arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspo=
on_openbmc/console.log:2026-02-13
> 15:50:44,193: [    0.932894] spi-aspeed-smc 1e620000.spi: CE1 read
> buswidth:2 [0x203c0041]
> arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspo=
on_openbmc/console.log:2026-02-13
> 15:50:44,242: [    0.982561] spi-aspeed-smc 1e630000.spi: CE0 read
> buswidth:2 [0x203c0041]
>
>

--000000000000573971064b3e9d35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Hi C=C3=A9dric, thanks for the detailed response and your time;=
 I should&#39;ve run the tests prior to the submission; apologies for the o=
versight!<br><br></div><div class=3D"gmail_default" style=3D"font-family:ve=
rdana,sans-serif">I&#39;ve been eyeing the aspeed_smc.c file and it seems t=
o &quot;inflate&quot; the dummy clock phases:<br><br></div><div class=3D"gm=
ail_default" style=3D"font-family:verdana,sans-serif">static int aspeed_smc=
_flash_dummies(const AspeedSMCFlash *fl)<br>{<br>=C2=A0 =C2=A0 const Aspeed=
SMCState *s =3D fl-&gt;controller;<br>=C2=A0 =C2=A0 uint32_t r_ctrl0 =3D s-=
&gt;regs[s-&gt;r_ctrl0 + fl-&gt;cs];<br>=C2=A0 =C2=A0 uint32_t dummy_high =
=3D (r_ctrl0 &gt;&gt; CTRL_DUMMY_HIGH_SHIFT) &amp; 0x1;<br>=C2=A0 =C2=A0 ui=
nt32_t dummy_low =3D (r_ctrl0 &gt;&gt; CTRL_DUMMY_LOW_SHIFT) &amp; 0x3;<br>=
=C2=A0 =C2=A0 uint32_t dummies =3D ((dummy_high &lt;&lt; 2) | dummy_low) * =
8;<br><br>=C2=A0 =C2=A0 if (r_ctrl0 &amp; CTRL_IO_DUAL_ADDR_DATA) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dummies /=3D 2;<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =
=C2=A0 return dummies;<br>}</div><div class=3D"gmail_default" style=3D"font=
-family:verdana,sans-serif"><br></div><div class=3D"gmail_default" style=3D=
"font-family:verdana,sans-serif">As you can see, it basically multiplies th=
e number of &quot;dummies&quot; (Which is gathered by obtaining the full va=
lue of the register) by 8.</div><div class=3D"gmail_default" style=3D"font-=
family:verdana,sans-serif">That is, in turn, used on &quot;aspeed_smc_flash=
_setup&quot; (Only if=C2=A0aspeed_smc_flash_mode(fl) =3D=3D CTRL_FREADMODE)=
 to decide how much dummy data to push with &quot;ssi_transfer()&quot;.</di=
v><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><br=
></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif=
">It&#39;s a bit confusing for me to compare what the actual Winbond datash=
eet we have (Also cross-referenced similar product&#39;s datasheets just in=
 case) expects in terms of needed_bytes (Which, as per datasheet, would be =
just 1, matching what, for instance, SST ones have; for reference).</div><d=
iv class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><br></d=
iv><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">Th=
e Designware SPI controller QEMU device we have sends a single byte (8 cycl=
es in SPI) to the flash (Again, matching both Designware&#39;s and Winbond&=
#39;s datasheet).</div><div class=3D"gmail_default" style=3D"font-family:ve=
rdana,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:verdana,sans-serif">Would it be interesting to have a second set of patc=
h series trying to address the inconsistencies (Whilst addressing aspeed to=
o) and making the Winbond model with what SST currently does in terms of &q=
uot;naming&quot; convention?</div><div class=3D"gmail_default" style=3D"fon=
t-family:verdana,sans-serif"><br></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif">Thanks again for everyone&#39;s time.</=
div><br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">El vie, 20 feb 2026 a las 9:56, C=C3=A9dric L=
e Goater (&lt;<a href=3D"mailto:clg@redhat.com">clg@redhat.com</a>&gt;) esc=
ribi=C3=B3:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hell=
o,<br>
<br>
+Marcin,<br>
<br>
On 2/19/26 21:01, Peter Maydell wrote:<br>
&gt; On Wed, 7 Jan 2026 at 11:30, Joel Bueno &lt;<a href=3D"mailto:buenocal=
vachejoel@gmail.com" target=3D"_blank">buenocalvachejoel@gmail.com</a>&gt; =
wrote:<br>
&gt;&gt;<br>
&gt;&gt; Is there any feedback on this patch series?<br>
&gt; <br>
&gt; Which board model(s) does this affect? You might have<br>
&gt; some luck cc&#39;ing their maintainers.<br>
AFAIR (10y ago ...), the dummy cycles in m25p80 are modeled as<br>
extra &quot;dummy bytes&quot; consumed before data phase begins. So,<br>
in QEMU : 8 cycles =3D 1 dummy byte.<br>
<br>
There could be bugs in this area, but this case was supposedly<br>
fixed by commit 3830c7a460b8 (&quot;m25p80: Fix WINBOND fast read<br>
command handling&quot;) and given the number of QEMU boards booting<br>
from a Winbond flash device :<br>
<br>
=C2=A0 =C2=A0tests/functional/aarch64/test_aspeed_ast2700a1.py:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;ast2700a1-evb,fmc-model=3Dw25q51=
2jv&#39;)<br>
=C2=A0 =C2=A0tests/functional/aarch64/test_aspeed_ast2700a2.py:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 self.vm.set_machine(&#39;ast2700a2-evb,fmc-model=3Dw25q51=
2jv&#39;)<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast10x0_evb.c:=C2=A0 =C2=A0 amc-&gt;fmc_model =
=3D &quot;w25q80bl&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast10x0_evb.c:=C2=A0 =C2=A0 amc-&gt;spi_model =
=3D &quot;w25q256&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast10x0_evb.c:=C2=A0 =C2=A0 amc-&gt;fmc_model =
=3D &quot;w25q80bl&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast10x0_evb.c:=C2=A0 =C2=A0 amc-&gt;spi_model =
=3D &quot;w25q02jvm&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast2600_bletchley.c:=C2=A0 =C2=A0 amc-&gt;fmc_mo=
del =3D &quot;w25q01jvq&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast2600_catalina.c:=C2=A0 =C2=A0 amc-&gt;fmc_mod=
el =3D &quot;w25q01jvq&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast2600_evb.c:=C2=A0 =C2=A0 amc-&gt;fmc_model =
=3D &quot;w25q512jv&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast2600_evb.c:=C2=A0 =C2=A0 amc-&gt;spi_model =
=3D &quot;w25q512jv&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast27x0_evb.c:=C2=A0 =C2=A0 amc-&gt;fmc_model =
=3D &quot;w25q01jvq&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast27x0_evb.c:=C2=A0 =C2=A0 amc-&gt;spi_model =
=3D &quot;w25q512jv&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast27x0_evb.c:=C2=A0 =C2=A0 amc-&gt;fmc_model =
=3D &quot;w25q01jvq&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast27x0_evb.c:=C2=A0 =C2=A0 amc-&gt;spi_model =
=3D &quot;w25q512jv&quot;;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast27x0-fc.c:#define AST2700FC_FMC_MODEL &quot;w=
25q01jvq&quot;<br>
=C2=A0 =C2=A0hw/arm/aspeed_ast27x0-fc.c:#define AST2700FC_SPI_MODEL &quot;w=
25q512jv&quot;<br>
=C2=A0 =C2=A0hw/arm/npcm7xx_boards.c:=C2=A0 =C2=A0 npcm7xx_connect_flash(&a=
mp;soc-&gt;fiu[0], 0, &quot;w25q256&quot;, drive_get(IF_MTD, 0, 0));<br>
=C2=A0 =C2=A0hw/arm/npcm8xx_boards.c:=C2=A0 =C2=A0 npcm8xx_connect_flash(&a=
mp;soc-&gt;fiu[0], 0, &quot;w25q256&quot;, drive_get(IF_MTD, 0, 0));<br>
<br>
I doubt this change is correct or the issue is more complex<br>
than it seems. Please try to run the functional tests, all<br>
ast2600 machines seem to fail to boot with this patch.<br>
<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
For the records, fast read commands are used in the tests. See below.<br>
<br>
=C2=A0 =C2=A0[0x406c0641] : The second byte &#39;6c&#39; is the SPI operati=
on.<br>
<br>
<br>
aarch64/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/con=
sole.log:2026-02-11 13:22:45,545: [=C2=A0 =C2=A0 0.510414] spi-aspeed-smc 1=
e620000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/con=
sole.log:2026-02-11 13:22:45,713: [=C2=A0 =C2=A0 0.650635] spi-aspeed-smc 1=
e630000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_evb_=
sdk_v11_00/console.log:2026-02-13 11:49:30,173: [=C2=A0 =C2=A0 1.517517] sp=
i-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_evb_=
sdk_v11_00/console.log:2026-02-13 11:49:30,320: [=C2=A0 =C2=A0 1.608993] sp=
i-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2700a1.AST2x00MachineSDK.test_aarch64_ast2700a1_evb_=
sdk_v11_00/console.log:2026-02-13 11:49:30,346: [=C2=A0 =C2=A0 1.625580] sp=
i-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]<br>
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_=
ioexp_v11_00/console.log:2026-02-13 15:50:03,329: [=C2=A0 =C2=A0 4.852499] =
spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0041]<br>
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_=
ioexp_v11_00/console.log:2026-02-13 15:50:03,850: [=C2=A0 =C2=A0 5.178221] =
spi-aspeed-smc 14010000.spi: CE0 read buswidth: 1 [0x000c0041]<br>
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_=
sdk_v11_00/console.log:2026-02-13 11:49:31,247: [=C2=A0 =C2=A0 1.275618] sp=
i-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_=
sdk_v11_00/console.log:2026-02-13 11:49:31,369: [=C2=A0 =C2=A0 1.352064] sp=
i-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2700a2.AST2x00MachineSDK.test_aarch64_ast2700a2_evb_=
sdk_v11_00/console.log:2026-02-13 11:49:31,385: [=C2=A0 =C2=A0 1.361942] sp=
i-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]<br>
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_ioex=
p_v11_00/console.log:2026-02-10 16:47:50,922: [=C2=A0 =C2=A0 3.123120] spi-=
aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0041]<br>
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_ioex=
p_v11_00/console.log:2026-02-10 16:47:51,224: [=C2=A0 =C2=A0 3.312014] spi-=
aspeed-smc 14010000.spi: CE0 read buswidth: 1 [0x000c0041]<br>
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_=
v11_00/console.log:2026-02-10 16:49:00,279: [=C2=A0 =C2=A0 1.264763] spi-as=
peed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_=
v11_00/console.log:2026-02-10 16:49:00,408: [=C2=A0 =C2=A0 1.345588] spi-as=
peed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2700.AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_=
v11_00/console.log:2026-02-10 16:49:00,424: [=C2=A0 =C2=A0 1.355559] spi-as=
peed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]<br>
aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sdk_=
vbootrom_v11_00/console.log:2026-02-13 11:49:40,859: [=C2=A0 =C2=A0 1.56816=
2] spi-aspeed-smc 14000000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sdk_=
vbootrom_v11_00/console.log:2026-02-13 11:49:41,032: [=C2=A0 =C2=A0 1.67651=
1] spi-aspeed-smc 14000000.spi: CE1 read buswidth: 4 [0x406c0641]<br>
aarch64/test_aspeed_ast2700fc.AST2x00MachineSDK.test_aarch64_ast2700fc_sdk_=
vbootrom_v11_00/console.log:2026-02-13 11:49:41,069: [=C2=A0 =C2=A0 1.69945=
9] spi-aspeed-smc 14010000.spi: CE0 read buswidth: 2 [0x203c0641]<br>
arm/test_aspeed_ast2500_buildroot.AST2500Machine.test_arm_ast2500_evb_build=
root/console.log:2026-02-13 15:50:25,370: [=C2=A0 =C2=A0 1.333537] spi-aspe=
ed-smc 1e620000.spi: CE0 read buswidth:2 [0x203b0641]<br>
arm/test_aspeed_ast2500_buildroot.AST2500Machine.test_arm_ast2500_evb_build=
root/console.log:2026-02-13 15:50:25,659: [=C2=A0 =C2=A0 1.625199] spi-aspe=
ed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c0041]<br>
arm/test_aspeed_ast2500_sdk.AST2500Machine.test_arm_ast2500_evb_sdk/console=
.log:2026-02-13 15:50:22,593: [=C2=A0 =C2=A0 1.287417] spi-aspeed-smc 1e620=
000.spi: CE0 read buswidth: 2 [0x203b0641]<br>
arm/test_aspeed_ast2500_sdk.AST2500Machine.test_arm_ast2500_evb_sdk/console=
.log:2026-02-13 15:50:23,319: [=C2=A0 =C2=A0 2.013603] spi-aspeed-smc 1e630=
000.spi: CE0 read buswidth: 2 [0x203c0741]<br>
arm/test_aspeed_ast2600_buildroot.AST2600Machine.test_arm_ast2600_evb_build=
root/console.log:2026-02-13 15:50:35,593: [=C2=A0 =C2=A0 2.848343] spi-aspe=
ed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0641]<br>
arm/test_aspeed_ast2600_buildroot.AST2600Machine.test_arm_ast2600_evb_build=
root/console.log:2026-02-13 15:50:35,876: [=C2=A0 =C2=A0 3.086504] spi-aspe=
ed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0041]<br>
arm/test_aspeed_ast2600_buildroot_tpm.AST2600Machine.test_arm_ast2600_evb_b=
uildroot_tpm/console.log:2026-02-13 15:51:11,310: [=C2=A0 =C2=A0 1.769397] =
spi-aspeed-smc 1e620000.spi: CE0 read buswidth:4 [0x406c0641]<br>
arm/test_aspeed_ast2600_buildroot_tpm.AST2600Machine.test_arm_ast2600_evb_b=
uildroot_tpm/console.log:2026-02-13 15:51:11,400: [=C2=A0 =C2=A0 1.844341] =
spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0041]<br>
arm/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console=
.log:2026-02-13 15:50:31,578: [=C2=A0 =C2=A0 4.177582] spi-aspeed-smc 1e620=
000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
arm/test_aspeed_ast2600_sdk.AST2600Machine.test_arm_ast2600_evb_sdk/console=
.log:2026-02-13 15:50:32,052: [=C2=A0 =C2=A0 4.571849] spi-aspeed-smc 1e630=
000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
arm/test_aspeed_ast2600_sdk_otp.AST2600Machine.test_arm_ast2600_otp_blockde=
v_device/console.log:2026-02-13 15:50:27,134: [=C2=A0 =C2=A0 2.312565] spi-=
aspeed-smc 1e620000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
arm/test_aspeed_ast2600_sdk_otp.AST2600Machine.test_arm_ast2600_otp_blockde=
v_device/console.log:2026-02-13 15:50:27,533: [=C2=A0 =C2=A0 2.644716] spi-=
aspeed-smc 1e630000.spi: CE0 read buswidth: 4 [0x406c0641]<br>
arm/test_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_openb=
mc/console.log:2026-02-13 15:50:39,306: [=C2=A0 =C2=A0 2.488488] spi-aspeed=
-smc 1e620000.spi: CE0 read buswidth:2 [0x203c0641]<br>
arm/test_aspeed_bletchley.BletchleyMachine.test_arm_ast2600_bletchley_openb=
mc/console.log:2026-02-13 15:50:46,183: [=C2=A0 =C2=A0 8.220262] spi-aspeed=
-smc 1e620000.spi: CE1 read buswidth:2 [0x203c0041]<br>
arm/test_aspeed_catalina.CatalinaMachine.test_arm_ast2600_catalina_openbmc/=
console.log:2026-02-13 15:50:34,667: [=C2=A0 =C2=A0 1.470919] spi-aspeed-sm=
c 1e620000.spi: CE0 read buswidth:2 [0x203c0641]<br>
arm/test_aspeed_catalina.CatalinaMachine.test_arm_ast2600_catalina_openbmc/=
console.log:2026-02-13 15:50:41,745: [=C2=A0 =C2=A0 7.369080] spi-aspeed-sm=
c 1e620000.spi: CE1 read buswidth:2 [0x203c0041]<br>
arm/test_aspeed_gb200nvl_bmc.GB200Machine.test_arm_aspeed_gb200_openbmc/con=
sole.log:2026-02-13 15:50:22,255: [=C2=A0 =C2=A0 1.277601] spi-aspeed-smc 1=
e620000.spi: CE0 read buswidth:4 [0x406c0641]<br>
arm/test_aspeed_gb200nvl_bmc.GB200Machine.test_arm_aspeed_gb200_openbmc/con=
sole.log:2026-02-13 15:50:22,589: [=C2=A0 =C2=A0 1.558898] spi-aspeed-smc 1=
e630000.spi: CE0 read buswidth:4 [0x406c0041]<br>
arm/test_aspeed_palmetto.PalmettoMachine.test_arm_ast2400_palmetto_openbmc/=
console.log:2026-02-13 15:50:31,164: [=C2=A0 =C2=A0 0.840722] spi-aspeed-sm=
c 1e620000.spi: CE0 read buswidth:2 [0x203b0641]<br>
arm/test_aspeed_palmetto.PalmettoMachine.test_arm_ast2400_palmetto_openbmc/=
console.log:2026-02-13 15:50:31,405: [=C2=A0 =C2=A0 1.082523] spi-aspeed-sm=
c 1e630000.spi: CE0 read buswidth:2 [0x203c2041]<br>
arm/test_aspeed_romulus.RomulusMachine.test_arm_ast2500_romulus_openbmc/con=
sole.log:2026-02-13 15:50:35,622: [=C2=A0 =C2=A0 1.281889] spi-aspeed-smc 1=
e620000.spi: CE0 read buswidth:2 [0x203b0641]<br>
arm/test_aspeed_romulus.RomulusMachine.test_arm_ast2500_romulus_openbmc/con=
sole.log:2026-02-13 15:50:35,832: [=C2=A0 =C2=A0 1.491569] spi-aspeed-smc 1=
e630000.spi: CE0 read buswidth:2 [0x203c0041]<br>
arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspoon=
_openbmc/console.log:2026-02-13 15:50:44,149: [=C2=A0 =C2=A0 0.885126] spi-=
aspeed-smc 1e620000.spi: CE0 read buswidth:2 [0x203c0641]<br>
arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspoon=
_openbmc/console.log:2026-02-13 15:50:44,193: [=C2=A0 =C2=A0 0.932894] spi-=
aspeed-smc 1e620000.spi: CE1 read buswidth:2 [0x203c0041]<br>
arm/test_aspeed_witherspoon.WitherspoonMachine.test_arm_ast2500_witherspoon=
_openbmc/console.log:2026-02-13 15:50:44,242: [=C2=A0 =C2=A0 0.982561] spi-=
aspeed-smc 1e630000.spi: CE0 read buswidth:2 [0x203c0041]<br>
<br>
</blockquote></div>

--000000000000573971064b3e9d35--


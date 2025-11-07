Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F93BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 18:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHRDe-0003CH-Or; Fri, 07 Nov 2025 13:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vHRCK-0002fF-Fi
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 13:28:32 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vHRCI-0004Ww-ML
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 13:28:32 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-43337f526dbso9105ab.0
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 10:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1762540108; x=1763144908; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uO5g1jU0AlZUCCAZkhlWxfxPSBtSAw5OnO86ze8xJFo=;
 b=gRtBXv5VFeWGVcRsxsRg5h6qoZSuNK4fhen+nN60usnQGIefumJv8lNUVhD7f+qReW
 alcM6GqFamBlmzI0AKrcRBO8KA/lP+cFn3SAyrNgs90ZbH7vpA/+wh3wKOVnrYm8k6Z4
 JqYza9VMGHJdSQrPycVE7JFm1bWN+Iu96kCWIXDtnIRjzCO8qfied2W+nPRdFKGfXdwP
 A7v/lkAoXhxSzDyoPIhJgkoTRWRptNWxHoGshGAzASeVQGD5fXlCKF2IAFeblXG/TxdA
 3qsAVaEiHmyk2/ztOvr4JqG62G/xraa0GFsRFPdnjF8akMVJyki1tuj3n43/7hhJxHub
 7GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762540108; x=1763144908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uO5g1jU0AlZUCCAZkhlWxfxPSBtSAw5OnO86ze8xJFo=;
 b=l9TXFqZa/BV2Y+i+VmFCaqRbIl5nsYFeDmpBx+bW/Wd4k4rJLlHQPjOfoyeQ7Rh5eE
 IjiYvlxoOdWRTKsMhy5I40FdjRnoyGjUZ97Ps8bQwDIjuV39hdKjw5tspQ9p7KnYFbK/
 ZTzlmHPw8pqxntfut8t2HK88nH5rTKyk1GRDlLdrhEFsApUlVzyYFF4V2eWfhmFczMlJ
 PRFnHWBK9Axm5fbxXIIa7jJxHJEFlEeavj34RHiym6x6QNf2MVRvJ6UN59GnApLToWhB
 GvmLKlA6oXwI4GhLM2NVvy5fTgylbV1XeQ3AXh2VjNKgWpCU7ddbf6W/AOM0Fd1v/1Yd
 x6pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBxOKmw59czg6Xu8IxPqfa/f6RmC2etrBt1DxJZ9hJr0NCZZw6y2nKvg1Ontqh2fhRqLFrtbuyyXDS@nongnu.org
X-Gm-Message-State: AOJu0Yx2HEV+kqj/V35Yd6um+5SHgji2oFjC50DzVySS62ZTTMUMokG6
 z6Q5U055SiQ035BZ3XaAbP7UktKVCdbUKHNgrqySRVKg0w+3Ons0wB+OhCEsYLKAazN5ubrkHec
 f+rF51M2eckAbuhWaCBP6/BXZL3b2ScXqZSoNdQJ6
X-Gm-Gg: ASbGnctmceQSawdgQ8AM87fRFsLXx9Fg4Q3zs75+IhM6vNhtUEYRFhlWAuVX+CzPPmL
 eKN2q8QefBAAUU9jQsSrgxfHkook7EX7/xKnLyufu6iPnMRqtCkSqebG3Kz5okudog0fRaWk9Q8
 JG/vAxy4v6ZNvr3qjNnOH4+zOmmVkGanotNAXkQiSupKmuWh2InYj4D0fXX8nh4jZ+LoxSmv7+q
 8qL1E6Q0ap+zxYucFLZVZK2kQAoXFq66iFsFpIGEy7r4zGurlJDrdk8gr0vad1JHdnL6JLMaUSZ
 4jZSZgU7dH1xOIvA6XJ+tUa1dQ==
X-Google-Smtp-Source: AGHT+IG7BAvNKMSggrFvGNI1abet3JbYEQYFaIj2adAOV3o8lmSyWvmYGgEjZszJUHKRihhitHy0qQdQz+reEYCvT60=
X-Received: by 2002:a05:6e02:1d98:b0:430:ccfa:1620 with SMTP id
 e9e14a558f8ab-433689a957bmr217225ab.12.1762540107984; Fri, 07 Nov 2025
 10:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20251104233742.2147367-1-nabihestefan@google.com>
 <TYPPR06MB820663370307D783EA2AF733FCC5A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <SEZPR06MB76199F82F5B0D106C85E3080F7C5A@SEZPR06MB7619.apcprd06.prod.outlook.com>
In-Reply-To: <SEZPR06MB76199F82F5B0D106C85E3080F7C5A@SEZPR06MB7619.apcprd06.prod.outlook.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Fri, 7 Nov 2025 10:28:16 -0800
X-Gm-Features: AWmQ_bnqy8553CEXuTyX5lQw9FXv3NVP_WbfVTTbcnAS8_dVE7ietSKVHPmhI3I
Message-ID: <CA+QoejVLkP6g43PJYpJacqVcNB+VRkQwSa3HYQbA1zJxT1d9Cw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/ast27x0: Fix typo in LTPI address
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 "leetroy@gmail.com" <leetroy@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=nabihestefan@google.com; helo=mail-il1-x133.google.com
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

Given that 10.2 is closed for features, but not for bug fixes: should
we try and land this in 10.1, and get the LTPI patches in for 11.0?

Thanks,
Nabih

Nabih Estefan (he/him) |  Software Engineer |
nabihestefan@google.com |  857-308-9574



On Tue, Nov 4, 2025 at 5:27=E2=80=AFPM Kane Chen <kane_chen@aspeedtech.com>=
 wrote:
>
> Hi Nabih,
>
> I will submit another patch for the LTPI controller soon, and I'll also f=
ix this typo there.
> If there are no further concerns, could we leave this change as is?
>
> Best Regards,
> Kane
> > -----Original Message-----
> > From: Jamin Lin <jamin_lin@aspeedtech.com>
> > Sent: Wednesday, November 5, 2025 9:11 AM
> > To: Nabih Estefan <nabihestefan@google.com>; qemu-devel@nongnu.org;
> > Kane Chen <kane_chen@aspeedtech.com>
> > Cc: clg@kaod.org; peter.maydell@linaro.org; Steven Lee
> > <steven_lee@aspeedtech.com>; leetroy@gmail.com; qemu-arm@nongnu.org
> > Subject: RE: [PATCH] hw/arm/ast27x0: Fix typo in LTPI address
> >
> > + Kane
> >
> > Hi Kane,
> >
> > Could you please help to review it?
> > Thanks-Jamin
> >
> > > Subject: [PATCH] hw/arm/ast27x0: Fix typo in LTPI address
> > >
> > > The address for LTPI has one more 0 that it should, bug introduced in
> > > commit 91064bea6b2d747a981cb3bd2904e56f443e6c67.
> > >
> > > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> > > ---
> > >  hw/arm/aspeed_ast27x0.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c index
> > > c484bcd4e2..1e6f469538 100644
> > > --- a/hw/arm/aspeed_ast27x0.c
> > > +++ b/hw/arm/aspeed_ast27x0.c
> > > @@ -87,11 +87,11 @@ static const hwaddr
> > aspeed_soc_ast2700_memmap[] =3D
> > > {
> > >      [ASPEED_DEV_UART11]    =3D  0x14C33A00,
> > >      [ASPEED_DEV_UART12]    =3D  0x14C33B00,
> > >      [ASPEED_DEV_WDT]       =3D  0x14C37000,
> > > +    [ASPEED_DEV_LTPI]      =3D  0x30000000,
> > >      [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,
> > >      [ASPEED_DEV_PCIE_MMIO1] =3D 0x80000000,
> > >      [ASPEED_DEV_PCIE_MMIO2] =3D 0xA0000000,
> > >      [ASPEED_DEV_SPI_BOOT]  =3D  0x100000000,
> > > -    [ASPEED_DEV_LTPI]      =3D  0x300000000,
> > >      [ASPEED_DEV_SDRAM]     =3D  0x400000000,
> > >  };
> > >
> > > --
> > > 2.51.2.1006.ga50a493c49-goog
>


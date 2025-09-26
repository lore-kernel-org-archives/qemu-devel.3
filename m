Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BC7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 21:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2GJg-0004ht-GS; Fri, 26 Sep 2025 17:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixiaoyan@google.com>)
 id 1v2GJc-0004hO-VY
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 17:49:21 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lixiaoyan@google.com>)
 id 1v2GJQ-0000rY-2f
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 17:49:20 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-62fa84c6916so3432a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 14:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758923340; x=1759528140; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0YOQH1ol7r7OQB7qdsyqB7C9IdyT80BjoHAoKtgCFPc=;
 b=hbGZnylt85JfVSfXIJcAQ3IB2lVUjTCx/nfka6LgFfKQYHJ5X26Ovo+5Q8mrFZguv/
 imR/Zgifa28B3Kq5DouXUd5dBeJM/n45kXrp2sXIkoC6+Ne4xBYsQ21/5QlnbX2cNXkP
 ynm2TByCDPjepXV9sSJy51Uwa9tsbrgy8sREe1vXnJcnZHINvftmFsXne6FX5IgC/UDN
 g088KPYh7AW9aXrvbv5zAlt2MDVu+rYWuy58XPR/NT97qooU6GRbgXlRUf2SWjJgMTiH
 DmWli/3zOlqoaa02ZeBZif72GKO8jWpFYUQLd9U7Zq/V2PwjVy8lgpuCsAunhMYswZ69
 h/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758923340; x=1759528140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0YOQH1ol7r7OQB7qdsyqB7C9IdyT80BjoHAoKtgCFPc=;
 b=gUoOrXfvpX3+T4236d1xPoTZfrMQLjZrvYPMFzeU705QfPpSp6Q79BUfk2nFvpQUtp
 6LD6YM8ziCNF0560kWROIX4keyNyJ8Y6sbp6usaV2zpGDOJDB/0p+wE3xdYW2iCn7t3+
 PHdk7ejv546TEEJBCqn68RkjMx4LDtVFAs5aVsEnNjpnk6r6naCKuGKgerTZ4LDU7UcK
 Elt0UXILGHXzNYOkJQyGqiB08fAZCkH4NobyOy3VwoHxT+w/RQfF3m5vrCEjNVeO4TiH
 JemE3lSyTCVimJJNJJ1nUfmMeINS4orHLHYeIniK+fftMbe/XOzSVGbYCoNRJTtm/r8R
 tUKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAr+sS3r7Q9/44/ii/EGnG39Bro6hwV3Cx3YNHzE/vsQOif5iEO1Zy/5wzzHdnGPa5/Nq5Nd63hepH@nongnu.org
X-Gm-Message-State: AOJu0YwCH/x8U2IlLFsw81xxnlRvuPZwe6ojOdKZjyIwd2hjtfh0kYeQ
 dbAtdVlkKP/ws8V8AvCoGP7Q+KQXTAdzZ46rwQmcSNKF5l3ARpNbkDUJUii69g7jKqG8dP1Y5vv
 nYzgg+fz2Nos76i3VNht4vY2perBjIKH2zVBG5/rN
X-Gm-Gg: ASbGncs7q88Y5NT/L9p/doDYxiDhE8p/r87UN8mKGJMdceQCKl6b+3EktoKg0h+shvK
 PHGwjjhy7zrw0G8yDVMqrzoGhtFI0N8bFJiQUwBfQdKlpRZLcBgk8hfOMcvwV9E5lxQD69VCk3H
 NMHWcdYU3GiEprzdVb/LoCFECgyVgSGju6SE9RcTNmrfXSL8RS/gb/ZhkVapdPkrt7L6hFnBFe7
 Ktp7eiWBq+5uCDrj0OlnoDcdVr7yNWmljaKMl62kCKD16pa0s3dMohDDw==
X-Google-Smtp-Source: AGHT+IEmPPcZtaPtymcprODMivqiTM9vnUx8lUpfKoyXip8yeVhDMEVVcOvfXAApjNh0+usP9pC7JOoaCESrsULmnD0=
X-Received: by 2002:a05:6402:6d5:b0:633:2321:a07b with SMTP id
 4fb4d7f45d1cf-634b60424c7mr125037a12.0.1758923339716; Fri, 26 Sep 2025
 14:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250925005832.3708492-1-lixiaoyan@google.com>
 <20250925005832.3708492-4-lixiaoyan@google.com>
 <1a755fbf-e6d6-4f80-b35d-29fcb3f587d3@linaro.org>
In-Reply-To: <1a755fbf-e6d6-4f80-b35d-29fcb3f587d3@linaro.org>
From: Coco Li <lixiaoyan@google.com>
Date: Fri, 26 Sep 2025 14:48:47 -0700
X-Gm-Features: AS18NWD4a8yEo_18Lu7kQUn4ii3v8Jr1mHfOE9Jx1wSs8zAxrXE_lWkPvTU_BJU
Message-ID: <CADjXwji8M6RsmPtf6Duw+8WcesZD3qSZ9_cR-oiX+dzJ_w7Z9g@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] hw/arm/npcm8xx.c: Add all IRQ ENUMs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, clg@kaod.org, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, flwu@google.com, andrew@codeconstruct.com.au, 
 Hao Wu <wuhaotsh@google.com>
Content-Type: multipart/alternative; boundary="000000000000da5000063fbb40f3"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=lixiaoyan@google.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -165
X-Spam_score: -16.6
X-Spam_bar: ----------------
X-Spam_report: (-16.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

--000000000000da5000063fbb40f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phil,

Thanks for the review!
It looks like IRQ mapping enums on other boards also generally do not have
line breaks, is it ok if I keep it like this for consistency sake?

Best,
Coco

On Wed, Sep 24, 2025 at 6:08=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi,
>
> On 25/9/25 02:58, Coco Li wrote:
> > In the process of implementing serial gpio and adding the corresponding
> > ENUMs, also complete the list for npcm8xx.
> >
> > Signed-off-by: Coco Li <lixiaoyan@google.com>
> > Reviewed-by: Hao Wu <wuhaotsh@google.com>
> > ---
> >   hw/arm/npcm8xx.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
> > index a276fea698..10887d07fa 100644
> > --- a/hw/arm/npcm8xx.c
> > +++ b/hw/arm/npcm8xx.c
> > @@ -92,8 +92,14 @@ enum NPCM8xxInterrupt {
> >       NPCM8XX_GMAC2_IRQ,
> >       NPCM8XX_GMAC3_IRQ,
> >       NPCM8XX_GMAC4_IRQ,
> > -    NPCM8XX_MMC_IRQ             =3D 26,
> > +    NPCM8XX_ESPI_IRQ,
> > +    NPCM8XX_SIOX0_IRQ,
> > +    NPCM8XX_SIOX1_IRQ,
> > +    NPCM8XX_MC_IRQ              =3D 25,
> > +    NPCM8XX_MMC_IRQ,
> >       NPCM8XX_PSPI_IRQ            =3D 28,
> > +    NPCM8XX_VDMA_IRQ,
> > +    NPCM8XX_MCTP_IRQ,
> >       NPCM8XX_TIMER0_IRQ          =3D 32,   /* Timer Module 0 */
> >       NPCM8XX_TIMER1_IRQ,
> >       NPCM8XX_TIMER2_IRQ,
> > @@ -116,6 +122,14 @@ enum NPCM8xxInterrupt {
> >       NPCM8XX_OHCI1_IRQ,
> >       NPCM8XX_EHCI2_IRQ,
> >       NPCM8XX_OHCI2_IRQ,
> > +    NPCM8XX_SPI1_IRQ            =3D 82,
> > +    NPCM8XX_RNG_IRQ             =3D 84,
> > +    NPCM8XX_SPI0_IRQ            =3D 85,
> > +    NPCM8XX_SPI3_IRQ            =3D 87,
> > +    NPCM8XX_GDMA0_IRQ           =3D 88,
> > +    NPCM8XX_GDMA1_IRQ,
> > +    NPCM8XX_GDMA2_IRQ,
> > +    NPCM8XX_OTP_IRQ             =3D 92,
> >       NPCM8XX_PWM0_IRQ            =3D 93,   /* PWM module 0 */
> >       NPCM8XX_PWM1_IRQ,                   /* PWM module 1 */
> >       NPCM8XX_MFT0_IRQ            =3D 96,   /* MFT module 0 */
> > @@ -128,6 +142,11 @@ enum NPCM8xxInterrupt {
> >       NPCM8XX_MFT7_IRQ,                   /* MFT module 7 */
> >       NPCM8XX_PCI_MBOX1_IRQ       =3D 105,
> >       NPCM8XX_PCI_MBOX2_IRQ,
> > +    NPCM8XX_GPIO231_IRQ         =3D 108,
> > +    NPCM8XX_GPIO233_IRQ,
> > +    NPCM8XX_GPIO234_IRQ,
> > +    NPCM8XX_GPIO93_IRQ,
> > +    NPCM8XX_GPIO94_IRQ,
> >       NPCM8XX_GPIO0_IRQ           =3D 116,
> >       NPCM8XX_GPIO1_IRQ,
> >       NPCM8XX_GPIO2_IRQ,
> > @@ -163,6 +182,12 @@ enum NPCM8xxInterrupt {
> >       NPCM8XX_SMBUS24_IRQ,
> >       NPCM8XX_SMBUS25_IRQ,
> >       NPCM8XX_SMBUS26_IRQ,
> > +    NPCM8XX_FLM0_IRQ            =3D 160,
> > +    NPCM8XX_FLM1_IRQ,
> > +    NPCM8XX_FLM2_IRQ,
> > +    NPCM8XX_FLM3_IRQ,
>
> Minor style comment, maybe worth adding a new line when the
> following enum is not contiguous.
>
> Regards,
>
> Phil.
>
> > +    NPCM8XX_JMT1_IRQ            =3D 188,
> > +    NPCM8XX_JMT2_IRQ,
> >       NPCM8XX_UART0_IRQ           =3D 192,
> >       NPCM8XX_UART1_IRQ,
> >       NPCM8XX_UART2_IRQ,
> > @@ -170,6 +195,22 @@ enum NPCM8xxInterrupt {
> >       NPCM8XX_UART4_IRQ,
> >       NPCM8XX_UART5_IRQ,
> >       NPCM8XX_UART6_IRQ,
> > +    NPCM8XX_I3C0_IRQ            =3D 224,
> > +    NPCM8XX_I3C1_IRQ,
> > +    NPCM8XX_I3C2_IRQ,
> > +    NPCM8XX_I3C3_IRQ,
> > +    NPCM8XX_I3C4_IRQ,
> > +    NPCM8XX_I3C5_IRQ,
> > +    NPCM8XX_A35INTERR_IRQ       =3D 240,
> > +    NPCM8XX_A35EXTERR_IRQ,
> > +    NPCM8XX_PMU0_IRQ,
> > +    NPCM8XX_PMU1_IRQ,
> > +    NPCM8XX_PMU2_IRQ,
> > +    NPCM8XX_PMU3_IRQ,
> > +    NPCM8XX_CTI0_IRQ,
> > +    NPCM8XX_CTI1_IRQ,
> > +    NPCM8XX_CTI2_IRQ,
> > +    NPCM8XX_CTI3_IRQ,
> >   };
> >
> >   /* Total number of GIC interrupts, including internal Cortex-A35
> interrupts. */
>
>

--000000000000da5000063fbb40f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Phil,<div><br></div><div>Thanks for the review!=C2=A0</=
div><div>It looks like IRQ mapping enums on other boards also generally do =
not have line breaks, is it ok if I keep it like this for consistency sake?=
</div><div><br></div><div>Best,</div><div>Coco</div></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Wed, Sep 24, 2025 at 6:08=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 25/9/25 02:58, Coco Li wrote:<br>
&gt; In the process of implementing serial gpio and adding the correspondin=
g<br>
&gt; ENUMs, also complete the list for npcm8xx.<br>
&gt; <br>
&gt; Signed-off-by: Coco Li &lt;<a href=3D"mailto:lixiaoyan@google.com" tar=
get=3D"_blank">lixiaoyan@google.com</a>&gt;<br>
&gt; Reviewed-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com" target=
=3D"_blank">wuhaotsh@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/npcm8xx.c | 43 ++++++++++++++++++++++++++++++++++++=
++++++-<br>
&gt;=C2=A0 =C2=A01 file changed, 42 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c<br>
&gt; index a276fea698..10887d07fa 100644<br>
&gt; --- a/hw/arm/npcm8xx.c<br>
&gt; +++ b/hw/arm/npcm8xx.c<br>
&gt; @@ -92,8 +92,14 @@ enum NPCM8xxInterrupt {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_GMAC2_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_GMAC3_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_GMAC4_IRQ,<br>
&gt; -=C2=A0 =C2=A0 NPCM8XX_MMC_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 26,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_ESPI_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_SIOX0_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_SIOX1_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_MC_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D 25,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_MMC_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_PSPI_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D 28,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_VDMA_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_MCTP_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_TIMER0_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 32,=C2=A0 =C2=A0/* Timer Module 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_TIMER1_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_TIMER2_IRQ,<br>
&gt; @@ -116,6 +122,14 @@ enum NPCM8xxInterrupt {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_OHCI1_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_EHCI2_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_OHCI2_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_SPI1_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 82,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_RNG_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 84,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_SPI0_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 85,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_SPI3_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 87,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_GDMA0_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D 88,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_GDMA1_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_GDMA2_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_OTP_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 92,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_PWM0_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D 93,=C2=A0 =C2=A0/* PWM module 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_PWM1_IRQ,=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* PWM module 1 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_MFT0_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D 96,=C2=A0 =C2=A0/* MFT module 0 */<br>
&gt; @@ -128,6 +142,11 @@ enum NPCM8xxInterrupt {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_MFT7_IRQ,=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* MFT module 7 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_PCI_MBOX1_IRQ=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 105,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_PCI_MBOX2_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_GPIO231_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 108,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_GPIO233_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_GPIO234_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_GPIO93_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_GPIO94_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_GPIO0_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0=3D 116,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_GPIO1_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_GPIO2_IRQ,<br>
&gt; @@ -163,6 +182,12 @@ enum NPCM8xxInterrupt {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_SMBUS24_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_SMBUS25_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_SMBUS26_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_FLM0_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 160,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_FLM1_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_FLM2_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_FLM3_IRQ,<br>
<br>
Minor style comment, maybe worth adding a new line when the<br>
following enum is not contiguous.<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_JMT1_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 188,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_JMT2_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_UART0_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0=3D 192,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_UART1_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_UART2_IRQ,<br>
&gt; @@ -170,6 +195,22 @@ enum NPCM8xxInterrupt {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_UART4_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_UART5_IRQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM8XX_UART6_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_I3C0_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 224,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_I3C1_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_I3C2_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_I3C3_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_I3C4_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_I3C5_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_A35INTERR_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 240=
,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_A35EXTERR_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_PMU0_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_PMU1_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_PMU2_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_PMU3_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_CTI0_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_CTI1_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_CTI2_IRQ,<br>
&gt; +=C2=A0 =C2=A0 NPCM8XX_CTI3_IRQ,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* Total number of GIC interrupts, including internal Cort=
ex-A35 interrupts. */<br>
<br>
</blockquote></div>

--000000000000da5000063fbb40f3--


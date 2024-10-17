Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DF4D374A1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RVB-0004Tw-S7; Thu, 17 Oct 2024 10:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1RV8-0004Tf-Aq
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:29:18 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1RV6-0003Q9-Md
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:29:18 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso1630110a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729175354; x=1729780154; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eFOX/syYZtwFsFH68uKcljYWd2x+NpIGFddXxltWQT4=;
 b=WHED6oxLn4Xhi3XTN40wkTNSqR9gDD/RwNRGYDH2lpjbH5oEuF1Ti5wQqcWHE+ECO2
 8G9rmv3KAtRti9XOqAr0IqAxqiKSiRby93Eza+XR+dsH4AmUeBIRHnDGenTj1RIVpHRq
 kU7SHTw1s6OC3zLv7f522cwQI5XCSCJhiitrgVN9kz7Jhd+zbgjGfMVk7OMRjurndxkY
 weHBhRhbjWL68hJHfxYf9uXC0Zn7XDAiNIDgoJjjUSxOQLbUdIBLqXCHYPhfGoc2e31l
 o+DowfALngPNNQzsawAJtbELSS3SUfgq4Q1mT+CH7uI3O2jF8RWwHiPCon7mYgjPbYVG
 wKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729175354; x=1729780154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eFOX/syYZtwFsFH68uKcljYWd2x+NpIGFddXxltWQT4=;
 b=rzG5UnPwgrbnA8cdMMYoLrpqLWjr7+VtOSPWnZjA2HS2KmzWS1NTGMYDUgRYVstvTN
 nc4kITlJB9X+il9GyhqoFbWBMIUWGovn13BadKTjOlqw1grqTHw535HbSHGoviOaOdpF
 ZUVlFcsO7aPiAkhLsrRaBpMnkyoNb6i7oF2svqVKXigDUwX7a4UKR32RFCcHNsAdYvMd
 lccWXs7/iMCy96HET6ffg/ZlTFmEDxiKK0jVA4W8+LCl5oi9NTtKCwOczwh+3cCIbhAA
 jMNKkHdI3/8mYIRsNCwJ8qfgNM6XTD3OFjcKS7QyDDz5nB0F/RWDhOuBfmIdYT+2jqpz
 gKIw==
X-Gm-Message-State: AOJu0Yy/cdB9s3RxLrfJcT6H49Aa32iJeY44uEOayD7+c0GegyAdxXKn
 bTWMl4GByZ0TQh60GEq/+udk+YpZbd+aq2ynUH+1kZpXmReG2F+AS+2sZekblvNA2PCiQXreHg7
 ML1LgV330reu/pYrmfgmwEmErBtIJk9tKxy7OWQ==
X-Google-Smtp-Source: AGHT+IFqQu5BsSjDaJ/Qq2jP0g37QIiFZ+q2FqbzPIoawFDWDK8RWGYsqGRH1uGeI2eeHFRw4RA6TDGSNtdAqvaKfg0=
X-Received: by 2002:a05:6402:4404:b0:5c8:d9b8:9325 with SMTP id
 4fb4d7f45d1cf-5c9a5a1c1aamr4631517a12.5.1729175354260; Thu, 17 Oct 2024
 07:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
 <CAFEAcA95QmpcsrgCj5uE-Ng8ahNir3MuVEHWBCvjb3UwBbOFRA@mail.gmail.com>
 <ec0e8a75-c59f-41b3-b559-43c057fca8fd@roeck-us.net>
 <CAFEAcA9AZS1dGaLG85zZE8U0d7AcrLgKXNbhxkCoP+PLmbFn2g@mail.gmail.com>
 <cf7c8f57-22d5-4a40-bd87-0f15f5457d48@roeck-us.net>
 <CAFEAcA98=2OdT9ykg5ibDuVLtSXuq4g0PLmSbxkYmt1SyKe9iQ@mail.gmail.com>
 <c354e331-39c4-4520-9a69-b62a8ecdddbc@roeck-us.net>
In-Reply-To: <c354e331-39c4-4520-9a69-b62a8ecdddbc@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2024 15:29:02 +0100
Message-ID: <CAFEAcA-NreDmpCoFgrTJ5dEto5jQbjRg1eCfqg9Ns8VwQ9-Qzw@mail.gmail.com>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>, 
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 17 Oct 2024 at 15:12, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/17/24 05:42, Peter Maydell wrote:
> > On Tue, 15 Oct 2024 at 19:12, Guenter Roeck <linux@roeck-us.net> wrote:
> >> Please let me know if https://github.com/groeck/linux-test-downloads.git
> >> meets your needs. For now I added 'collie'. I'll add more after it is
> >> in a state that is useful for you.
> >
> > Yes, that's great, exactly what we need. I've put together a QEMU
> > 'functional test' case that downloads the collie rootfs and image
> > and checks that they boot. (I'll send the patches for that out
> > in a bit.)
> >
> > (I've coded the test case to pull the binaries for a specific
> > git revision of that repo rather than always-from-head, so
> > we're testing always the same thing against head-of-QEMU.)
> >
>
> Sounds good. I now also added information for sx1, so you should
> be able to use that as well. Please let me know if you need any
> others.

I think sx1 and collie are all we need currently.

By the way, it looks to me like QEMU has a regression
somewhere where we can't boot that sx1 test for the SD
card version -- it hangs during kernel boot waiting for
the MMC card. (An elderly QEMU binary I have boots OK.)
I'm looking into what's happened there.

-- PMM


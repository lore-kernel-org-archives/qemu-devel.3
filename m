Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BC8ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snehV-0007WM-Tf; Mon, 09 Sep 2024 09:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snehU-0007U2-4D
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:45:04 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snehS-0008CD-DT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:45:03 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5bf01bdaff0so4643735a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725889500; x=1726494300; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xn+xmoYP5US6IfexkDCT57DCA13gg0SPirYcMV2icSY=;
 b=BdWBEJViVGohwNXAG45uUKICbDo6+xgeXFodAWIAsKKYN2rONMreRH3Es5v9zLXJUh
 EtlzOLj4fgX8GtKa0aE/+ZRc7AMidpYwnJpjJ65bjyR17aqfxYhgH6oNqaiIBtDGjDeI
 wJCb90CAAIp/Y+bAgYCgFtysemJY0GIxUiVedC07sG8ejT9+RvIuiuH2EmOkaeBJuQmh
 Gtz9gtSyObvxUlEyeeqMClGzWSzY8PW5LicNq4bg2CmGRcdQNpgFU6cyGHxHuYC7gkPV
 5yMl0JKvBg7WuXbxTFcCfZjwvDI+MnBDzqXm8Q5sfhCOZobiBedwRDpAEJs0CzOr4aPM
 yTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889500; x=1726494300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xn+xmoYP5US6IfexkDCT57DCA13gg0SPirYcMV2icSY=;
 b=YLpJOTjG5SMH4YOXBIaf7wP7HswYnw0yl00EAQWnTZ/LWLjOUQXMOh76g0k/S+GwFm
 d7BckJ1dmQDcjetCJtNpLgzc/KXXcnRI7mFedn/RI3cAKrZ2oTF6z6W88JDJP1uzBGC7
 rxqr7CG4xzwxr5XXJkHLZEKyLLAVymM3BMImt77dH8oQbZ/f3rvVLhSOBlobxtuZRsH7
 qvKRypskGuzRzORmNewanF0GhvC2IHbDS7lYdXH0n0J9Xnr+WxiOZr0swLO9e/kKoJ15
 ZgAWiEWrKW87FwyuBgsjEX5KAEP+2gD67EG4HRSZ4XDX+G1CoNMdeVg9BLqVSn78Bbzu
 bpoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbcvp2ti9faSFL4Qc2Kwje3hlKH9j5mIJ+onSO7dSUY0cMzaO8USNNIjm0fggS52vPig9uoe5BYC2y@nongnu.org
X-Gm-Message-State: AOJu0YzCaQLPbiQ3b+caCZnKoQE7krZ/pH/m69NTz2bdckrObRUBt6nM
 MF3MOeckGXwlz4vEWaMiS/Dybv3GQE+Uv3njHEGPeswSstIOg2OleSLmcvooU++wMmcmGr5oj7H
 CNCr6pmdQhxi2DzOA1ffog3TAVpuv1EOzDgEDnw==
X-Google-Smtp-Source: AGHT+IGUqPUd0TvT6mdDqXTJpb2MDfETwiKXx+ew9lxaQY1qD9TYiy+w1/cX9RCmujrr/uXt/q0wfPuGAbW5CpXBfN4=
X-Received: by 2002:a05:6402:380b:b0:5c2:43bd:8ce8 with SMTP id
 4fb4d7f45d1cf-5c3eac0970dmr4957569a12.21.1725889500412; Mon, 09 Sep 2024
 06:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
In-Reply-To: <fabedae0-d748-4a9d-b802-14d15f3cd44a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 14:44:49 +0100
Message-ID: <CAFEAcA9z9Mf52pOVCHv_Y1hvPPWt7Me5CDcxYS_cXvj7OFDuSw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 9 Sept 2024 at 14:41, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> On 3/9/24 18:06, Peter Maydell wrote:
> > This patchset removes the various Arm machines which we deprecated
> > for the 9.0 release and are therefore allowed to remove for the 9.2
> > release:
> >   akita, borzoi, cheetah, connex, mainstone, n800, n810,
> >   spitz, terrier, tosa, verdex, z2
>
> > The series includes removal of some code which while not strictly
> > specific to these machines was in practice used only by them:
> >   * the OneNAND flash memory device
> >   * the PCMCIA subsystem
> >   * the MUSB USB2.0 OTG USB controller chip (hcd-musb)
>
> > thanks
> > -- PMM
> >
> > Peter Maydell (53):
> >    hw/input: Drop ADS7846 device
> >    hw/adc: Remove MAX111X device
> >    hw/gpio: Remove MAX7310 device
> >    hw/input: Remove tsc2005 touchscreen controller
> >    hw/input: Remove tsc210x device
> >    hw/rtc: Remove twl92230 device
> >    hw/input: Remove lm832x device
> >    hw/usb: Remove tusb6010 USB controller
> >    hw/usb: Remove MUSB USB host controller
>
> Some of these devices are user-creatable and only rely on a bus
> (not a particular removed machine), so could potentially be used
> on other maintained machines which expose a similar bus.

Which ones in particular? Almost all of them are sysbus.
At least one of them that I looked at (lm832x) is an I2C
device but it also requires the board to wire up a GPIO line
and to call a specific C function to inject key events, so it's
not actually generally usable.

> We don't have in-tree (tests/) examples, but I wonder if it is OK
> to remove them without first explicitly deprecating them in
> docs/about/deprecated.rst. I wouldn't surprise users when 9.2 is
> release. Maybe this isn't an issue, but I prefer to mention it
> now to be sure.

I think this is unlikely to be a problem, but if you have
a specific device you think might be a problem we can
look at whether it seems likely (e.g. whether a web search
turns up users using it in odd ways).

thanks
-- PMM


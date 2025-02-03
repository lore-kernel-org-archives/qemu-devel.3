Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67055C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texi5-0005aQ-AA; Mon, 03 Feb 2025 09:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1texhT-0004so-33
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:45:24 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1texhQ-000328-US
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:45:22 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e5afeb2acecso880573276.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593919; x=1739198719; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRQby+/AMmtw/cfXqrX1L291GtS4VEHF49TlvBYGG8w=;
 b=ZSY7K040iYlxniqNDu9F0l0aX1kiF8gAuN3LVarejXnhph5DRSd0I+wpw/IufdAQaD
 u6NLHhJOXrsj1OxsUeAmUf7sa0j0IoOKsfzDUvHY16HEXgzxZ2ocqsIdeFvCceS2kQGB
 h3nr0kww69DO+bdGvlCKZPpvy+LuIca/IEhlr7ciNxts+63jpumnS4sNMpbN7/1frD8l
 8RuuX4nn2c7Q01azGuVnlWqhpjtwUG8gNh4URJ6W7dojSlOQWD/8WXcNkQDr2psHsftv
 LYV7IPtRXUTQtWgGqUQQ5rwmwmWIkn6V6xU4CG1y7DpNKErPin6typW5RiDQ/XvHksgH
 bXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593919; x=1739198719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRQby+/AMmtw/cfXqrX1L291GtS4VEHF49TlvBYGG8w=;
 b=W3iReSzlic7rS1ZdorluafxnW9MzaE4PtIPRe2nyvqCHWKtQmT5c5bTNszWYnXCwsx
 dznlIrgcl0BrWmUO3xpuFbRyo01nkT6O3ONWm+iFRVZK1XqhFlnZ8y7t6PQyZ4jJtRNe
 SAHuDR6rKsELW0qzaO1mqlTsKVQUbZP3D0Ltgrl5FZZPQ6Gmiyvi1p8k8zcWG59r2SRe
 RBkSKlPHSxMQLYzMe8MmdpEr2o76JppDwCR+YnSOOhR4YjnMvYWZayJBZJzkcxjM8Ota
 Ji+JuQ4jAnyt2nnwH5G2JbSd8CFIaQTHcJ8FRHj0cPDpaIm/e/GjwGIPSScIRvPr7RAf
 jmig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHAIp+mC5o/BeKJt8gCzBeZ+RPn04kDGB4D1FG9jmyc+b0/hYTjfq2r7S2gA2duM1/LNZ7SolGp1eR@nongnu.org
X-Gm-Message-State: AOJu0YzCT0T55ju26ZZiwkdsaGUFbtjNnPc6e5xIp1BP1J1F5uumut59
 0DZsbNPD3uhiA3QFhV2RfbCsXv0zlq2JZFlv9j1FPrdYTDikO28oaYQRikqnaNz6ptUO0Rjn3h1
 LxfKtQMA6ogImC2COcdMKXEbtAyM+py8gy8ErXw==
X-Gm-Gg: ASbGncuccocX6A3tWVVDMMtrVkEWQghbSYPIVNUWq2bMkhp2+NQMgpR4wiKRu+VD6fE
 WmBys2fPdMLZp8wVxrQAMJfM1Kb6THxPXrDxsIBPzbVb5tr5WlQ0CX1BKe9nL6x4b9+ksewATpQ
 ==
X-Google-Smtp-Source: AGHT+IFaVV4uQcgTS6i69pIZpKQ17Zxnp+3d1624oclFGgWbbcJSVQB2qUm3ITxk3QIZOKBaR3ZLqN+FnFfRO//WQts=
X-Received: by 2002:a25:dcd1:0:b0:e58:16b0:3798 with SMTP id
 3f1490d57ef6-e5ac89567ccmr10460254276.24.1738593917962; Mon, 03 Feb 2025
 06:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20250201091528.1177-1-philmd@linaro.org>
 <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
 <CAFEAcA_mBXO20NhYRHJCgkB0h8uYQQhBMdwVW376R4u-qh51nA@mail.gmail.com>
 <87ed0fayoy.fsf@draig.linaro.org> <Z6DTsdf35ApQ0qLU@redhat.com>
In-Reply-To: <Z6DTsdf35ApQ0qLU@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2025 14:45:06 +0000
X-Gm-Features: AWEUYZmacHCS6PQYUkMX9OKHszLEzvKRz95YjA1VR1GyKmgnZeVAvxybu0jIWXw
Message-ID: <CAFEAcA8Qigt1EBVgz1D4hon0x4ukLZbZ-jS_KB+ZBH0yi+QCXw@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of DRAM
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Jared Mauch <jared+home@puck.nether.net>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Mon, 3 Feb 2025 at 14:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Mon, Feb 03, 2025 at 02:29:49PM +0000, Alex Benn=C3=A9e wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > On Sat, 1 Feb 2025 at 12:57, BALATON Zoltan <balaton@eik.bme.hu> wrot=
e:
> > >>
> > >> On Sat, 1 Feb 2025, Philippe Mathieu-Daud=C3=A9 wrote:
> > >> > - Deprecate the 'raspi4b' machine name, renaming it as
> > >> >  'raspi4b-1g' on 32-bit hosts, 'raspi4b-2g' otherwise.
> > >> > - Add the 'raspi4b-4g' and 'raspi4b-8g' machines, with
> > >> >  respectively 4GB and 8GB of DRAM.
> > >>
> > >> IMHO (meaning you can ignore it, just my opinion) if the only differ=
ence
> > >> is the memory size -machine raspi4b -memory 4g would be better user
> > >> experience than having a lot of different machines.
> > >
> > > Yes, I think I agree. We have a way for users to specify
> > > how much memory they want, and I think it makes more sense
> > > to use that than to have lots of different machine types.
> >
> > I guess for the Pi we should validate the -memory supplied is on of the
> > supported grid of devices rather than an arbitrary value?
>
> If the user wants to create a rpi4 with 6 GB RAM why should we stop
> them ? It is their choice if they want to precisely replicate RAM
> size from a physical model, or use something different when virtualized.

The board revision code (reported to the guest via the emulated
firmware interface) only supports reporting 256MB, 512MB,
1GB, 2GB, 4GB or 8GB:

https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#new-s=
tyle-revision-codes

For Arm embedded boards we mostly tend to "restrict the user
to what you can actually do", except for older boards where
we tended not to write any kind of sanity checking on CPU
type, memory size, etc.

thanks
-- PMM


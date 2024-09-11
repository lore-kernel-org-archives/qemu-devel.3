Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E99EE498F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soKaj-0003yU-KB; Wed, 11 Sep 2024 06:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soKai-0003xs-Bk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:28:52 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soKag-0002lz-K9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:28:52 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f74e468aa8so72244921fa.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 03:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726050528; x=1726655328; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMUvTCShnhCZhPeLUmkQlKcx1xx2tO/9HwdR6vQk400=;
 b=m6pJrmMokMhgUt9p6ZDV5Fej8w24o0lWwMSLkFJ0mA0vPCCG2bOP95LqRcb+gl/AyD
 wL8CY2AIDGOQkScQUyij+v6/xholH4Jdm5GbAPFcJi0t2kC6gKjM/ZeU1X0KI8z5q+Z/
 tZfiR+/OOb3txUGTehqkU0iJn575rdeFnEGR1nri3yeqo+PmaNSwxz1B3Wsdm/X0uOY4
 dHTzWXJwe2FDe5EZ3MXwx96kxipvRV6we9PbXW0lI76/27YVD2dnMM0GiNIVfPCjbqL9
 NN3qQq5G/mOSPz3Ex/LjYUuedlyAJ3WO8Xv80/EM4kzyvSF8z5YQGXaEgEF/p1LKUoRM
 U/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726050528; x=1726655328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMUvTCShnhCZhPeLUmkQlKcx1xx2tO/9HwdR6vQk400=;
 b=rB1rsgcNFeLDbbjtnFdJ6Ks4rs7CGaa4G7UQb19V1QmcpGEdgrG3FX9VunYc8THUmy
 2lEHzQTR5mfZdGCbZEtuysnx1bgZEgKi/4JE0RuWEibWySeO9Q0Mgbi6a1gdSN9LOt0k
 nxwM0OW6tUvDwek5+XL3cyeoMEfbO2wpuOnhe1RXJ576jKo0xyrdjPIThthNbrR/qxQ1
 Z31yiSYj9eWxcVjUc+21KC6NPPZUUq9mXxYxgtf6MKFVHejV28Evx8A1CdSwHceIDjmg
 ocVdcqhwfaSMu89FxrzcDgopHRb8y5m/fWGtZy2ZKXm1+lB2f3UKE6ew6idGN4/zLfy8
 P91Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZN6EUdxFLraEvNzmNzv/Anc/bji17+aAOUlOqkVlx1ivL7cN02nUcWryyfwM3lcNMdIAmdbWi5qDY@nongnu.org
X-Gm-Message-State: AOJu0YzOwQv7BZKXkq4QXJsKQGieIecUu9UGvDOHRPCDiV455IW6HdTP
 Jngky17M2lycllOFPottJWQst+BkZ3vHeyOn/xBNXwBVt4COBZRziMj+MWXYgnbYBt0osstE+ec
 crQbarQXugECcIjtnq5CQB94OaMU+wkvZgJ/h1Q==
X-Google-Smtp-Source: AGHT+IFg2Ikm6IZ6LGaNiDoYGCbZm9fkNHFhVhVYxKScfWh329K0A7Bc5cKWtvlwTDT6bbmHqhRbEOeprhTCDU/GK5g=
X-Received: by 2002:a2e:a596:0:b0:2f3:fa99:4bab with SMTP id
 38308e7fff4ca-2f75230d237mr112391461fa.15.1726050527845; Wed, 11 Sep 2024
 03:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240902061944.526873-1-satur9nine@gmail.com>
 <CAFEAcA9wP7f_yPYNJmaTDe1bB8cPifErAGpjtsNPKsR0s_65Sg@mail.gmail.com>
 <667c28a5-3c00-4de2-b37e-566dc7ffca14@linaro.org>
 <CAFEAcA9GHEGrar3Mcf09Hrrmz6mWeQhD0Z7KEvxr3RxYSyFeEQ@mail.gmail.com>
 <7ced0b1a-8548-44af-b108-23ef296e0b2b@gmail.com>
In-Reply-To: <7ced0b1a-8548-44af-b108-23ef296e0b2b@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2024 11:28:37 +0100
Message-ID: <CAFEAcA-LoJUh4rXYtPnvQTwFhXhx8RHyzVh7sfMMvje98L2k+g@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Fix ACK and min access size
To: Jacob Abrams <satur9nine@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 11 Sept 2024 at 07:27, Jacob Abrams <satur9nine@gmail.com> wrote:
> On 9/10/24 02:34, Peter Maydell wrote:
> > If we make the .impl and .valid changes, then the result is
> > that we permit 16 bit writes to come through to the read
> > and write functions. Since we don't make any changes to
> > those functions to specially handle size =3D=3D 2, you get the
> > effects of the existing code. If the 16 bit write is aligned
> > to a 4-aligned register offset it will match one of the A_*
> > cases, and will write 16-bit-value-zero-extended to it.
> > If the 16 bit write isn't to a 4-aligned offset it will fall
> > into the "default" case and be logged as a GUEST_ERROR.
> >
> > Did I miss some aspect of what the behaviour change is?

> Ah I see your point now regarding the zero extension writes. Basically yo=
u are saying this patch will have the effect that a 16-bit write to one of =
the USART registers such as USART_RTOR via an ARM instruction like STRH wou=
ld not be handled correctly because value to be written will be zero extend=
ed to 32-bits before being written.

> I do believe this is a valid problem. I will test the behavior on my STM3=
2L476 and report back the real HW behavior and I suspect the result would b=
e STRH write to such registers is allowed and unwritten bits are preserved =
and not overwritten with zeros.

Yeah, the datasheet doesn't say here and so checking the h/w
behaviour would be helpful.

> I submitted a new patch for just TEACK fix already and will report back o=
n the real HW test result later and adjust 16-bit read/write code as needed=
 to behave properly.
>
> I have also submitted a question to my STM contact regarding the referenc=
e manual and assuming the answer is yes it is in error I will add comments =
explaining that to my next patch for the 16-bit read/write handling.

Would certainly be interesting to see what STM say.
(If the answer is that some of these cases are invalid
guest behaviour then we have the option of rather than
following the in-practice h/w behaviour exactly instead
doing something easy and logging it as a guest-error.)

thanks
-- PMM


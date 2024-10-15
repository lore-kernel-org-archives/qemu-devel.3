Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1118D1D88D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 17:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0lSe-0007N3-Cz; Tue, 15 Oct 2024 13:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0lSc-0007Md-DV
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 13:35:54 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0lSa-0006dQ-Nl
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 13:35:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so181280a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 10:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729013751; x=1729618551; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jWY7XzWZH9AEdLY2aHr1NP7a4yQuvuQNlf2nfUtAu00=;
 b=qKYsJFmv8M6P/0g9djO6a5HXJiXsQJJXW5sJLuww8CSRjHusVCsEKGiFK61WvM40Ty
 0+3EQcEkv1rb042G1utQnlYsUoST4nG1HbOmSsN/ECeT3JBnQR3XqjZV9GpWKP8e9Wht
 gPxtaAvYluzLLOfi2RPcEPhSlxLpvy0uDQcwDBDyPrv1j7RqJueV4vDr6WcnBTbfFfqO
 m+hcbW9FjDoODHAJWfYHMs6ajz5/GP4/axf1x4aDtmVIRABZYOXUeQi8rD8f49EEcfKA
 2NI6IngRlg+JfU6HXb+KoBhWwBYpNE4JCQJChiGM/Bj27DoiUK6aBAXdAjOl+PdR0f8+
 yH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729013751; x=1729618551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jWY7XzWZH9AEdLY2aHr1NP7a4yQuvuQNlf2nfUtAu00=;
 b=v8lKMsNEn8ssIFrgPttUNjbR100hYOuVp9pfaasZo2k16ivA7JkAYrObQ6U5aQNgfk
 855wHlMpNmM6NIuan2NM5eiPU+9qjGC+VzHO9fNS0qM40oK/AeREY+ksaNek4rVLppNq
 tMGf5+EHLHgd+EXkd2bvqYYvsfzoVVhms6mMi5uP7liey9Fd9c6M64DjTQz8VzALw1mN
 nj5qe+crdyJoaXG5qyRAfpIjgI9vXp6JoXvB8AmXlJRtUO90pA9CxrAf3VWUe8+gF9Fp
 uiz6tAjmsRCC6VPs5H737q3FS2oceVGm1kfZLIo3hdnlywTcUKoas/WLOK0jd2owV3kM
 +/xQ==
X-Gm-Message-State: AOJu0YzyteakQvyCqWCT4PeAv0B0MbQgpu+ibW13r7AWoAYyopYwDxkx
 NAUoAKvirFGcRTdnXvMgxggpUpU8oIbyIRoJVDx6xVHOc32T1/sPI53NFn3QFMohyVT0QiP+5gG
 5eHBi/ylgCjo4eFJ2idgFyr7TXTZgWDQcVgl4DA==
X-Google-Smtp-Source: AGHT+IEwOscD4AxH6rXdp/SCilbhWkxkH8QjeLSkRYuXom/e1ACud+CjgcontHRzLvnUZ4SnfePVMISzzJwPKeQIf1g=
X-Received: by 2002:a05:6402:13c9:b0:5c9:46a7:527 with SMTP id
 4fb4d7f45d1cf-5c94759070dmr13772080a12.17.1729013750498; Tue, 15 Oct 2024
 10:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <CAFEAcA-bqOM4Ptws-tsEwo2HDZ6YSX1Y+xGkR0WueRD_dUd0+Q@mail.gmail.com>
 <7bd858a2-9983-4ddf-8749-09c9b2e261f9@roeck-us.net>
 <CAFEAcA_-eTfF8tVaLk4yLgWMSA1+KjPBYyS3EjMQNC+59hT0Aw@mail.gmail.com>
 <CAFEAcA95QmpcsrgCj5uE-Ng8ahNir3MuVEHWBCvjb3UwBbOFRA@mail.gmail.com>
 <ec0e8a75-c59f-41b3-b559-43c057fca8fd@roeck-us.net>
In-Reply-To: <ec0e8a75-c59f-41b3-b559-43c057fca8fd@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 18:35:38 +0100
Message-ID: <CAFEAcA9AZS1dGaLG85zZE8U0d7AcrLgKXNbhxkCoP+PLmbFn2g@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 15 Oct 2024 at 18:30, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 10/15/24 10:13, Peter Maydell wrote:
> > On Fri, 8 Mar 2024 at 15:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> Thanks to everybody for your input on this thread. My
> >> proposal is to drop from QEMU:
> >>   * all the PXA2xx machines
> >>   * all the OMAP2 machines
> >>   * the cheetah OMAP1 machine
> >>
> >> leaving (at least for now) sx1, sx1-v1, collie.
> >
> > This has now gone through. I'm now looking for test images
> > for these remaining boards, so we can keep them from breaking
> > when we do refactoring and code cleanup/modernization.
> > Specifically, I'm looking for:
> >   * QEMU command line
> >   * all the binary blobs that go with it (hosted somewhere that
> >     doesn't mind when our CI downloads all the images to run
> >     its tests...)
> >   * ideally, exercising the SD card interface if present
> >
> > Could the people who are still using/testing these boards
> > help here ?
> >
>
> You'll find everything at https://github.com/groeck/linux-build-test.git,
> but give me a couple of days and I'll create explicit information.

Yeah, I had a look at that but could only find the rootfs
and got a bit lost trying to figure out what the QEMU
commandline would end up being :-)

> Is it ok if I create a github repository specifically for this purpose,
> or does it have to be direct file downloads ?

A github repo should be OK -- I'm pretty sure we can download
from there (e.g. we already download some rootfs images from
your linux-build-test github repo).

> Note that my tests only boot from sd card for sx1. I also don't have
> tests for sx1-v1, only for sx1. I don't recall if I ever tried sx1-v1.

Looking at the QEMU machine model code they don't differ
much -- sx1-v1 has a bit less flash, and that's about it.

thanks
-- PMM


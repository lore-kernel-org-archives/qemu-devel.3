Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAD0CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmGy-0007wl-MQ; Tue, 28 Oct 2025 12:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDmGw-0007vO-Q1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:10:10 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDmGr-0000AI-Fq
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:10:10 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78485c4146bso68402647b3.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761667802; x=1762272602; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9ZHRIMFILeDoUiwpfNy+ePpTc4uTSo2+a8pn42yp2k=;
 b=iYs8ngWR0b1EUwReIkLe9juP0hVbpTz0DOXI/yIorzha917TaBImagalW1cs9qBZzm
 2/R4a//heKzMkoqggJKHqO/dHyMoFrqLlMqmutSNqxotiwdarp4CUNXsr/3RmIwJdxDn
 u9V4hc4WwMwNGe0aEgkbFMhFoEjtT+YUvlEzl2Jfm1hfW+ZK2j54xOvAPgDSw4yc7AgJ
 jWQwiA00rVAeGQDEAaa2/nSyooykNJm0Dtqp+YZBklLeFTdCT2TbRopffD2fFeB/fY5b
 wViX18cp77cVALRVSvmePnLCNQoG2u+b8SfHJN4uKAqY1st4S8mMqVlaGP3UMQmEYDek
 9BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761667802; x=1762272602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9ZHRIMFILeDoUiwpfNy+ePpTc4uTSo2+a8pn42yp2k=;
 b=OCDqWGR2IO2NWt2tr+RYmdMTx9asGv6RFVQzOvab1ugROw6+nCh7n2hlyT6Kxdlz2X
 MBuSEOFpoPyHw7YzqBlvKgqzfg/4sXEY+twiarbtnJiXUeBuonD4as1jc/yZ6DRR4ctJ
 AaORKqx5FvnEr9ok92Ee7R9Y7e5c6cLNzNzOz/+yqriw9/x6G5AMmvRGKFGWWYegV+Bz
 QNWKwV9TsRrGEV4wRC3xooa6qO+PIRmGxiCplNIfHV1KRHN3cWqnHItsIDlwRTmAkNqk
 gi5k+6kAnPkAl/kZEQhNuIfp7qmwT8OZryQFlEgA3mJdnijYXya95h5dUfeF8Ui6fEya
 LgNw==
X-Gm-Message-State: AOJu0YyuhIeLlx0cl1t7qm84SC4cdRl/xHAoblNwGSOAJIu5OeEzNpYQ
 EBoI5I8JiQWAkxUUch8Wuf8NgdPgbmI6n8qSJnDXpGsYrhP96nQ1xlDL4rKi/4wxO0M9SMOX7AE
 oTBLxaRq2KkZjzOvotXeuQuSR2Sr4mdIyreyRKainFw==
X-Gm-Gg: ASbGnctIIFLGW7WzmZorMQrN5yFgT5tOZWXaR8Az6hh1SLZHnymrEJhWpqacY465KW4
 wbaWgVZ9dJaUOfxermKtkwKjAeNUxOFu2n1izMof6v9hBo0tx4YY6sZR0fCXa5vglCwA5ZT7+xO
 G8Gz1ISxB2yCb71aef0L+X5JsGYpPGpvVLAhTy+rr4ZUYPO4Pzd9XpJ/wATmJCMAtqDTMlTJfKM
 0u2dpePQNEEG5bsmLDW8jmUKYwMSBz3FYf4FgodMtguRkJRMfNT7GV6/Mm/Iw==
X-Google-Smtp-Source: AGHT+IH/aoobYfdlAS7tajjgRZ/JvSo1ft5Kd4OAaN2GLjwq1iSa+ULvF/rHvDduGe/yDzVz1s4Fxs/gFG1cWsHzZGs=
X-Received: by 2002:a05:690c:3388:b0:780:d2cc:3c2d with SMTP id
 00721157ae682-78617e4be5emr37809467b3.1.1761667801979; Tue, 28 Oct 2025
 09:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <CAFEAcA9Rvvymu7oS0pPx00v9SdXzwr27vy1VmnZmwQ7ayZK+yQ@mail.gmail.com>
 <2F14E49B-D152-470C-A87C-525853EB8ED5@gmail.com>
In-Reply-To: <2F14E49B-D152-470C-A87C-525853EB8ED5@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 16:09:50 +0000
X-Gm-Features: AWmQ_bkCiTiH_nxLkQFcKmhdwK831S0y0xjg3NKwJVODTTx27brGsecw6nAun08
Message-ID: <CAFEAcA9RBxs3C068BRgzKCqFxQh2K5rmXwyiph4_imOiy7JxLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 28 Oct 2025 at 14:41, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 28. Oktober 2025 12:46:34 UTC schrieb Peter Maydell <peter.maydell@lin=
aro.org>:
> >On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail.com> wrote=
:
> >>
> >> Allows the imx8mp-evk machine to be run with KVM acceleration as a gue=
st.
> >>
> >> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >> ---
> >>  docs/system/arm/imx8mp-evk.rst |  7 +++++++
> >>  hw/arm/fsl-imx8mp.c            | 33 ++++++++++++++++++++++++++++-----
> >>  hw/arm/imx8mp-evk.c            | 11 +++++++++++
> >>  hw/arm/Kconfig                 |  3 ++-
> >>  hw/arm/meson.build             |  2 +-
> >>  5 files changed, 49 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-e=
vk.rst
> >> index b2f7d29ade..1399820163 100644
> >> --- a/docs/system/arm/imx8mp-evk.rst
> >> +++ b/docs/system/arm/imx8mp-evk.rst
> >> @@ -60,3 +60,10 @@ Now that everything is prepared the machine can be =
started as follows:
> >>        -dtb imx8mp-evk.dtb \
> >>        -append "root=3D/dev/mmcblk2p2" \
> >>        -drive file=3Dsdcard.img,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmcb=
lk2
> >> +
> >> +
> >> +KVM Virtualization
> >> +------------------
> >> +
> >> +To enable hardware-assisted acceleration via KVM, append
> >> +``-accel kvm -cpu host`` to the command line.
> >
> >Coming back to this now we've resolved the "does this put
> >things inside our security-promises that we don't want"
> >question...
> >
> >I think we should be a bit clearer in the documentation
> >about what tradeoffs the user is making here when they select
> >KVM. Specifically:
> >
> > * we should note that this is intended only to improve
> >   performance, and is not covered by QEMU's security policy
>
> Sure, I'll add it.
>
> > * we should say that you will not get a Cortex-A53, so any
> >   guest code with tight dependencies on the host CPU type
> >   might not work correctly
>
> Ack. I'd also hardcode the CPU type to host since asking for a Cortex-A53=
 always failed on me with KVM.

Yes, this is the right thing (at least until some distant
day when we add support for having KVM give the guest a vcpu
that looks like a particular cpu type). The 'cortex-a53'
cpu type with KVM will only work if the host happens to be
that, which isn't very useful for most people.

> > * we should say that the guest will only be able to run
> >   at EL1, and (unlike TCG) there is no EL2 or EL3
>
> Real U-Boot calls back into the on-chip ROM which isn't implemented yet. =
Furthermore, there are some unimplemented USDHC extensions which prevent co=
mplete loading of binaries into RAM by U-Boot (similar limitation exists fo=
r e500 boards). Therefore the board documentation only advertises direct ke=
rnel boot. AFAIU EL2 and EL3 aren't usable there anyway. Correct? Do we nee=
d to mention this limitation regardless?

I think it's worth mentioning anyway -- not every EL3
payload is necessarily u-boot.

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EA5CDE018
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtkd-0003Eh-Cl; Fri, 14 Nov 2025 08:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtjW-0001Cd-ER
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:21:01 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtjU-0002vy-O6
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:20:58 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63bc1aeb427so1717355d50.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763126455; x=1763731255; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrNpysS5iPmrz38YudoYz05NZLKPiHOdqavnyuAT4ic=;
 b=xCnlT6yhRAx4OTcYb1qrfcMQoFII/wlvw0VC8a8sDXPZdqRTSYsolLKVt82pPnSR1B
 aCieLAvNGlToaUG6uzC0n1FNCGlZn7NIgoDKmZWg7YIsFCjMbCePK13mXeP6Zg1vkirj
 eTXOk0LzOinDpxJKi+NmMI6Hu5iIGWSPCKOgTtnn68WR24O9YDfxpd7GyA3iFaTvfvZ6
 MnkD5jMPCQ1bIlqMF58ECGt/Ezd6CbwkEKnzwfNTmyVZlP91OmIkzzAHkx64R0jDKC1S
 F6+rkUw9ytahfHzUZTuH3EDfbmyU4mTS7F6JoO538bEgPs0dszsoLlqH0kBdbAyXyrBH
 gktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763126455; x=1763731255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SrNpysS5iPmrz38YudoYz05NZLKPiHOdqavnyuAT4ic=;
 b=IM5UHlvRyDl1+DPO4rE3y9q7Pcgpif8WXnfUmxDmv9n59Hevg/Bsgb/J3RzP45Uy2N
 rDvGzZthFOr6onhJ1YMoVSe9UIv6OwbAFIhAYCXqXlu9AlQzCabkVbSC9hQYZt9fzuEZ
 aLOFUPMjBXiPNC2Ietph7UYO9xcDxyWmOumCBSyrTEVlBKw+r6hcySk5CEgGnjqcrAWg
 4XV4GHmW/uO5LQKyju8+FQwn4c2HBZcW7g+VEITCA32hoKRrmUQl5q908CewmbL9e4Y/
 ENCqRU9xfDlyPKV9ryexM5a7PWFtPh70GcQg7bKE1uiDfCOyHLh1+BnHcalH5wjGOu68
 pvZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYhR1/2rBBESiml50it9YTpU1vLSD8yzKg8yOx2Y8Bqbw04kWjweqzsTUljEp7ySCwXT+sLhOgvvKT@nongnu.org
X-Gm-Message-State: AOJu0YywDXGYIkMQ+/0WxtJ9ZOHZ+uwtXaoIc0kRup1bo39leBnTh7Gh
 rPNImECbtq6oNMZ3dwV04gzwsl1yvCaUKEfCjTeO/k98SmQYCZU7+fPaqyH7X5ASIP/3ICrBwli
 vd/VNwwIMzQ7ErpsAY/d8YKPKSrfQ4mc8F1qSjHoxzRD58aD+V+ywOks=
X-Gm-Gg: ASbGnctmOZ1RZvC4IQH2iiPO89GraXo/a6yV+dd3EzRaCixecJJiTKzWyeEp5VDzxQc
 gn7xqvTPdTfqvyWmHmEObADoq8lg1J6fWY8eYW+ckzMitnzqbCHtcoc37iJLrQEZ6t4MSZI0f2k
 YR08JZtRzKWi1oYhniYqWaAwZAgSEszqvJrqcJZ9d+3Gx6ld4/JRMwQ/TbSB9dwuyAruf0HT8+p
 2F6Q2emt3rP/B33kCsREzOIBug4n6qtwkn3B8fA+4bbp87Y3zgBHlMvyzbxhfICNREwJxeplWvy
 dYAOXBM=
X-Google-Smtp-Source: AGHT+IEZvp7ogq2k4+3cAXrGsKtv/kY6iQ1vRk/qU0LrH1sOi1uFs5rxj2Lpe2EmBb3mxQ8Oftpcp89PCGit6NslwcA=
X-Received: by 2002:a05:690e:240c:b0:63f:ba88:e8f9 with SMTP id
 956f58d0204a3-641e75e62f4mr1986404d50.41.1763126455421; Fri, 14 Nov 2025
 05:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20251107154116.1396769-1-peter.maydell@linaro.org>
 <e3530b1c-6f5f-48d0-ab5e-da94e59c275a@linaro.org>
In-Reply-To: <e3530b1c-6f5f-48d0-ab5e-da94e59c275a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 13:20:44 +0000
X-Gm-Features: AWmQ_blUBXMjCT9mOgBIwS7Rfmq0QQ_KIoHgIVAoP3qC70c3rAK0Z4xi_II4upw
Message-ID: <CAFEAcA-CfPPBORHu4mZUzK=A9Y8cJJ3H508PYykGz3ggPYTxvQ@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/lm4549: Don't try to open a zero-frequency audio
 voice
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Sun, 9 Nov 2025 at 10:46, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 7/11/25 16:41, Peter Maydell wrote:
> > If the guest incorrectly programs the lm4549 audio chip with a zero
> > frequency, we will pass this to AUD_open_out(), which will complain:
> >
> >     A bug was just triggered in AUD_open_out
> >     Save all your work and restart without audio
> >     I am sorry
> >     Context:
> >     audio: frequency=3D0 nchannels=3D2 fmt=3DS16 endianness=3Dlittle
> >
> > The datasheet doesn't say what we should do here, only that the valid
> > range for the freqency is 8000 to 48000 Hz; we choose to log the
> > guest error and ignore an attempt to change the DAC rate to something
> > outside the valid range.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/410
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This bug has been around for so long and is a weird edge case whose
> > only effect is to print a debug message, so it doesn't really seem
> > worth cc'ing stable on.
> > ---
> >   hw/audio/lm4549.c | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
>
> With s/8000/4000/ in description:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Applied to target-arm.next with that commit message fix, thanks.

-- PMM


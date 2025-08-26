Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16897CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 18:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqyIl-00047u-4H; Tue, 26 Aug 2025 14:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uqyIj-00047Y-Kl; Tue, 26 Aug 2025 14:21:45 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uqyIg-0004fZ-JQ; Tue, 26 Aug 2025 14:21:45 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61c5270f981so4416497a12.2; 
 Tue, 26 Aug 2025 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756232499; x=1756837299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ak5p7YQw73EnJqPQvyCS4IUMpK5Ceg2v1au1VsvdBd8=;
 b=NX45xjjw0fZozMhfBkcAnm23RxKyMvbUm5hW+lyjlZJ/Q8+XeZHOpKBA9hSdjga9nu
 U8pzwFbUIX7/+/rjtfJ4Nf5CxG1x9Hnt8G6h3PcIxUE+n7kqoL68GAd2qe4RNpGW9iF+
 PLA3ik2eBna7B8k1YB3lanVih7LfqYcB7IZO4KUxrYABJi7YOYy/CHdHGyCJY3kSTLeh
 K5AGzBpPoFIsDhstIHYpZtsuMwwVStWXduFmjQtkvIP++Mj2hIY6C5gKJjZY+n3EOuS7
 ZRLFTdHtu6OwMPOtT6Q8QB2AaY/T8Sh2xFhH3AsSYIhcnAaJuBfpdp5gxs7Ulr1IYiV+
 LMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756232499; x=1756837299;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ak5p7YQw73EnJqPQvyCS4IUMpK5Ceg2v1au1VsvdBd8=;
 b=ldqCuCcoRgP0yCZVfInDZLv8kH4YTycJUFqnGDYJ1syUutkj02FWAZHEbDL8+blzh+
 5hKUPnfjRY+qdt7I9m1V3dvM9+Q2nSRzUS6DkaLSpEKFf3CYuBlI/YcXc16yqGhRURge
 e4YO5Q12f+STrOK+DRa1KYP28VlJs8qkort0p0v7vDNNpyTcB4ULlg5YWKb5amBJxiRU
 aHcfNIkTtm0EebrFp5EluZBlpJutYqHriYZGjEcmKFgxiSs2pQD3hQRgixFGpHM9Bnhe
 86/2Aj0ARnjPYSd1JplDi44/gQJGXgy0u0d0JW9eVXATXBbv3F4tSJhbLpEVG/wGQ4Cd
 biLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtJAAWf11Uz4RCpKIxpEb+1Gk1fTztuxavGMn4jzY4NU2E31G3tFhVzYMqTEvf+TZ0dOi/UWZAtA==@nongnu.org
X-Gm-Message-State: AOJu0Yz2HyqXJFo87xOItH9/XtusjINYmnmJdYY5bhK2FpBJ4bbJoDOE
 9sHcfrEAbUgz+9dH0hMKEnZQR9bVFuCjKfNhzzbgaviGulYZ86ooKCk7
X-Gm-Gg: ASbGncsm9zZV6loNjk4bDQbXRfEhQnwh9L56PY38sz5bZKdSxJf4X7gM80sFCE02J68
 Sj1WBssUaQzq4/ycc/JZn1tsD0/v5eNVRvPFMBetHAC/odHwdLRmpOA3r3cnXMpEupKI7MHKtQ5
 jcPN5+HuPz3w/MZ4avESLJWMjSXrRyoSzmbtf2h+XQlybaKD4ZNCvgmr3G/1goeLzucb6nfQyAB
 2OUlCfZn9hD+69qvLw+DYicyDvf9aiPc4YgP4dSevr2A22wEPyRNkxnlPid9AdwI9bw2Y54YrU7
 U1UpRmUc9BwZCFktgJx46PAeaWZgYMVgdtCoMOm5oQ9Zxwhu+el82WLx/Wc/yODTGRPTYiTZ5EO
 NF3tIo7XSuC6j9Esi1dRs/zLbEAzef+t4Q4lmKsApNs3oYZJiA0fD18h//TE9E5DSZaRkZlS223
 0HYiSGqTI/ra1EIqeIVzk=
X-Google-Smtp-Source: AGHT+IFqrWPS3zSkmQdt/zwKDMbyjBwOA0tMaSu1S/1547l/LjBHx3HcXje7h9/61bUTXRF1qFiiJQ==
X-Received: by 2002:a05:6402:a0cb:b0:61a:967f:55f9 with SMTP id
 4fb4d7f45d1cf-61c1b492cb4mr14542133a12.10.1756232498800; 
 Tue, 26 Aug 2025 11:21:38 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf05a000e5c4d6ea65f2c795.dip0.t-ipconnect.de.
 [2003:fa:af05:a000:e5c4:d6ea:65f2:c795])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61c3174f77fsm7444225a12.56.2025.08.26.11.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 11:21:38 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:21:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] hw/arm/imx8mp-evk: Add KVM support
In-Reply-To: <CAFEAcA-0843-YZMDqTDhiJgF223UrAcb8cQL5-ns12o8VHaT_g@mail.gmail.com>
References: <20250629204851.1778-1-shentey@gmail.com>
 <20250629204851.1778-3-shentey@gmail.com>
 <CAFEAcA-HaQwySM1j7Cy_R1z0fM1D9ykiBiMKLYNVYF+Tm_mrPA@mail.gmail.com>
 <78B2535C-38D8-4612-8958-49AC28482A8D@gmail.com>
 <CAFEAcA9b+1xx+Esnt80Ny1gWBOsh-QYYxuP6PwiPk-B20xv0Dw@mail.gmail.com>
 <3DA254A8-76AC-4214-8C65-D3B3FFF55FF9@gmail.com>
 <CAFEAcA-0843-YZMDqTDhiJgF223UrAcb8cQL5-ns12o8VHaT_g@mail.gmail.com>
Message-ID: <DE8FB6B8-E173-46B5-B269-29848494B99A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 26=2E August 2025 09:21:25 UTC schrieb Peter Maydell <peter=2Emaydell@l=
inaro=2Eorg>:
>On Tue, 8 Jul 2025 at 17:36, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>>
>>
>> Am 30=2E Juni 2025 21:03:06 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>> >On Mon, 30 Jun 2025 at 21:22, Bernhard Beschow <shentey@gmail=2Ecom> w=
rote:
>> >>
>> >>
>> >>
>> >> Am 30=2E Juni 2025 09:09:31 UTC schrieb Peter Maydell <peter=2Emayde=
ll@linaro=2Eorg>:
>> >> >On Sun, 29 Jun 2025 at 21:49, Bernhard Beschow <shentey@gmail=2Ecom=
> wrote:
>> >> >>
>> >> >> Allows the imx8mp-evk machine to be run with KVM acceleration as =
a guest=2E
>> >> >>
>> >> >> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> >> >> ---
>> >> >>  docs/system/arm/imx8mp-evk=2Erst |  7 +++++++
>> >> >>  hw/arm/fsl-imx8mp=2Ec            | 33 ++++++++++++++++++++++++++=
++-----
>> >> >>  hw/arm/imx8mp-evk=2Ec            | 11 +++++++++++
>> >> >>  hw/arm/Kconfig                 |  3 ++-
>> >> >>  hw/arm/meson=2Ebuild             |  2 +-
>> >> >>  5 files changed, 49 insertions(+), 7 deletions(-)
>> >> >
>> >> >This puts a lot of IMX device models onto our security boundary,
>> >> >which makes me a bit nervous -- that's a lot of code which
>> >> >wasn't really written or reviewed carefully to ensure it
>> >> >can't be exploited by a malicious guest=2E
>> >>
>> >> Hi Peter,
>> >>
>> >> Does KVM increase the attack surface compared to TCG?
>> >
>> >Yes, because our security policy says that TCG is not considered
>> >a security boundary, whereas KVM is:
>> >
>> >https://qemu-project=2Egitlab=2Eio/qemu/system/security=2Ehtml
>> >
>> >(It would move from "non-virtualization use case" to
>> >"virtualization use case"=2E)
>>
>> Thanks, that document nails my question=2E
>>
>> If KVM requires the imx devices to be inside the security boundary, wha=
t needs to be done to lift them there?
>
>Code audit, fuzzing, commitments to maintenance=2E Basically
>I would strongly prefer not to=2E

I agree that this is asking for a bit too much, especially volunteers=2E T=
hese requirements also seem very related to maintenance status "supported"=
=2E Can we find a way for lowering the bar for KVM support?

Best regards,
Bernhard

>
>-- PMM


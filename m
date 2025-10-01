Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6810BCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 11:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3v0w-0002BU-NT; Wed, 01 Oct 2025 07:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3v0u-00028s-R8
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:28:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3v0j-0000Rx-Lu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:28:51 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so1152080766b.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1759318114; x=1759922914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AiCDIFaqJwQY91D+SMGBe0Fmhmk+CzAIEWNjJfnJzwM=;
 b=QiVpvDRRqt3p+8sORwAc/Ll3+0fn1X0gbjx91EU4Z0M96cAn1i+NMAkGQtHaFpd2d1
 am4oN3YJkYfspp9IF6CLSbgriEEWiXwEnNzCJNJCM9mPqm39e/7QHIxRc/MgiBYC+QaL
 gCdnyN8v5SrcPnfjuGbL4kKc0VSZ2lOkLvzj4khr14DaIGgmbSgirtIsoZcHeyxeZ2hw
 vFO9sNdK3mr1TXC5VQ2fCm2+raMq64laQCZ5eR5oYGiRj/xp56UzbwccKFlhKkXz/07a
 hDZ2SLCofCczWMnev05eb3RSKMfVkPm2NoXJ6LRypftmd//RUzmAFBzBpBceho/W8K8p
 LEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759318114; x=1759922914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AiCDIFaqJwQY91D+SMGBe0Fmhmk+CzAIEWNjJfnJzwM=;
 b=ThzfYrqt5FbOoX6CocITCjsP1EMekPTlbhrviPvXJ0denGCGIqGOFSO5cUml/TwhrL
 eonHD0XokbGeximDS1JRO4CcQoG1uf7AxDWFLND4+JIt6mQu9Kn68kB6Y0s2sJNQ8uOw
 ZkT5sB/4xauVm8lccQZ+IyflAtYQ/wHVEKN0DN/2QOyZh0wr8OOPmLjIoQaNBtF/4Z7f
 7nl3dtdiPp6YCSqseA28YB9ZnX7NEUwLZAQs4sK2n5zACyR+jPj9wBkS0KLBiyL8M8DD
 0w8gVEAXU2TNKvgRoLjItnGMoF/s0r1/TJlnPgh38Piap8Lwp1DjFKN/2dl5Iv+cWrP2
 WHfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1+4faI0isSbmMoKnMLzlKVv3+Lq3WUsYZiqkbmaN8HD8HOV5byVptvnn3rIZp9QH1DWBd8FBO8qai@nongnu.org
X-Gm-Message-State: AOJu0Yy8wJ3FYkFgvsa9iQlhr5089zjoONmN+KAPPfUh8Fh1JLsFlW3w
 CCj9wmcDCrWXOQj8RW6EsPGqLt9ReAq/bdupAbJoeqqd3EOd9mKDXvSbeZdNGBfakICLF5my9Dl
 BAS0FR3DlrW10wGAOxJWshiOC5dym1zbn7SXMldD9LzUBoT7vBrM=
X-Gm-Gg: ASbGncvqMU4CzbUrMZOUg9e8Sor6Km7Vr4ZXruo2wX9B5jI+DplxipWkFL/2xJZhJRI
 ukhMJpK0eCD2kZ58wgfwtxiOsGiB4z+kUqbwKAOHLVdzkRXsKN2n6t99rB3JIjLaSAJoqcWVNXm
 fNBxrDg4TH8o+ZujnYIHowbzgtblrkBPR3K2Nj2Lm/ucgfjml9MhwJxH+g1D3+ljZVRHGdz4W65
 /bZa0HaH5nqXUXSYs4ap/9FvFfLPVg=
X-Google-Smtp-Source: AGHT+IEVZFz71EDPKG7bXi26C61tMgFMUVyXT0m8qosD37F3cHMoOp9wjK90woVU/i8ePWgmN6XegusZC5Z4Qrub9vc=
X-Received: by 2002:a17:907:9709:b0:b45:592f:74ac with SMTP id
 a640c23a62f3a-b46e4791098mr386721966b.38.1759318113821; Wed, 01 Oct 2025
 04:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ307Eg67ri0=-ocEr-q=Y9+OY-9XKGFb5AYh59-X8szH+3Ryg@mail.gmail.com>
 <CAFEAcA8MBFd45meJ5baOAacRTwnb+9VAUB_tMYsg3OQvXKcBgw@mail.gmail.com>
In-Reply-To: <CAFEAcA8MBFd45meJ5baOAacRTwnb+9VAUB_tMYsg3OQvXKcBgw@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 1 Oct 2025 13:28:22 +0200
X-Gm-Features: AS18NWBrkRepFd-7u2_A_VLmgYLi4SqE8-th1OuEilT58d1-658Do-0NjCH2AD0
Message-ID: <CAJ307EjniiV_4eWY5=iu502DKvPi2wXQ+5MiaTRKTAm17b-FNA@mail.gmail.com>
Subject: Re: [QUESTION] aarch64=off with TCG
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x633.google.com
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

On Wed, Oct 1, 2025 at 11:50=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 1 Oct 2025 at 09:55, Cl=C3=A9ment Chigot <chigot@adacore.com> wro=
te:
> > I'm wondering if the check [1] preventing "aarch64=3Doff" without KMV i=
s
> > still valid nowadays and if yes, if anyone has ideas about what are
> > the remaining blockers ?
>
> I did have a look at this a while back. A lot of it was "audit
> the code to make sure it's not relying on an assumption we will
> now be breaking", which I think I did most of. Some of the
> preliminary patches I already upstreamed (e.g. the elimination of
> the TYPE_AARCH64_CPU subclass). My TODO list from my notes is
> down to basically enforcing that the user doesn't select invalid
> option combinations:
>
>  * forbid weird prop configs like aarch64=3Doff,sve=3Don if we don't alre=
ady
>  * forbid -cpu max,aarch64=3Doff for usermode
>  * forbid -cpu whatever,aarch64=3Doff when it doesn't implement AArch32
>    at the relevant EL
>
> so my "allow aarch64=3Doff" patch is a bit more complicated than
> just removing the check because it tries to enforce at least
> some of those.
>
> I also have some local patches which make an AArch64 CPU with
> aarch64=3Doff manually zero out all the aa64_ ID reg values, so
> that feature checks on an aa64_foo feature don't pass. This
> lets us avoid having to go through and manually add extra
> "if AARCH64 && ..." clauses to all those feature checks.
> I need to rebase those and look at whether they're ready to
> send out.
>
> Other than that, I think it's mostly testing.

> I'll see if I can do that rebase and at least send it out as
> an RFC patchset.

Alright thanks a lot for all those details. No urgency at all though,
I was just wondering if executing 32 bit ARM on cortex-a53 was
feasible within QEMU.

Thanks,
Cl=C3=A9ment

> thanks
> -- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B283BCDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcJnQ-00041A-RF; Wed, 24 Jun 2026 05:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wcJnK-0003yY-1A
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:21:18 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wcJnI-0001ta-2G
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:21:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-46019edc13dso466094f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 02:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782292874; cv=none;
 d=google.com; s=arc-20240605;
 b=bBP0YbDh9eB3hQpSlgokosI5vQmdzFXl73hW9D4RbgNeYNHNeK6t6bq3Bwi2siTTTJ
 DaPU6ZGz5OeH6xL8eVskzUkzWP222sqb28Npy/nrmNEHgWY70QgF69oBxvcUl020gjD/
 8+clS6pH7hDePDcp+dgKmIqnn6WIAt/UJ5cxD+iK7XUphFQ6CG+JlHucRPauASAc/Gtw
 ZqvKiyGAbIztBOT0RZPtFh8dbsED3qHHoQDN7ABA7YWz/XGCiQQtDlxTuDi18/A6KAQN
 oI5cO9mIQMRDef9aiVgIAs17Tpq/YLBwk7f2wfiAlxvAH621+BrNCUecCIqM33MnnqI5
 in2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oazNTK33wp6q70zzk54P9FvHaEaedaLWoYT+92mLYcI=;
 fh=JXLUuAidyE+9xijR77KVUTMo+KNTWjCyIblE5Sciczc=;
 b=ST6wvzkjj9Jz1I9OjFFT7dlJcDCrHilWrhTncfx/bunTsjP5mylEYdGH9CHHn2wfeU
 G/q63PEpif5Q5lHY6UcEIkA6aGzdeZe5gU/fPeABTI6kAZjKMhgUBZLnz2ieLtkqKmxc
 REk3GT3rpc/JQrrtumT2v5W5xWivsV3S+fOy78JymUDsfAvhVDeqthtvuDf2/I5holx/
 Q9k44f5yDYYR/QH1fooqRCjGQx4YYNOSctO/8tTOYRPqgRpKYdcexJenRIN6IwJk7Kwr
 ZAFbdlL3ZfGGF8li4ZULu8AGY1+pdrBB9BcheYsHv64u6UR8UFC4UiczEeBxUVkgmaOL
 iXcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782292874; x=1782897674; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oazNTK33wp6q70zzk54P9FvHaEaedaLWoYT+92mLYcI=;
 b=EoDSd2W1rA04Ksh9k3B2l7tL+YSPntpPPa28zhM2H6inoVPHKabtHUdDeAsAhnYPK9
 hf0+AvUOoNAgTf/vSazPqFoCc2vyOYiZFfKbZ3/fMNoaLxXClDYKwyIyFdAQCxHhMNFe
 L2g7bxyVlRujQFXx823YYOwYFejSGMmmsOXrwxVwiVw4x22H/GSqGIyonUJVvTdHp/1E
 OD7ZtpJbvSthByVKwpQvWqDm3SDVOLXvXGndXV3gDmWHqaZIiRNGQ4YyaJ13bG80HJ5H
 ggsAPT8kfop7IzuBkvk83gBEREbPsYWo5hMxUfIJm82fnumRiGAZP/PYlGacWiMYKozu
 JWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782292874; x=1782897674;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oazNTK33wp6q70zzk54P9FvHaEaedaLWoYT+92mLYcI=;
 b=SsvCjAq1rBzYdz69c8QeSm7279D6YtfUp60lwEyfArcbesa+UC25A8Yefwmfu2/Be6
 NV0znmRHg33EZG/Yb1FCuhvaZvWwqcshNpohMDzFREkP5twuCGOtHsa8uaA9KP3kKCPc
 3lJGQIwiA/OAF5tzlI3CeidDQWUyVGwjFeiATV/jFbK8/rTJvpemNjfwzTdaR0ZIz44d
 x3aUyK3e8IjJKGiQBWgIhOvsURfvKHz6Zp6LXH3hXxaV/LbokJrljnY8II2MKyTJxGYZ
 DKbProD3jkxZkugb/m6/J3bLq93/zA4qoqlnedXpqAw8sGKtko/zRFqdVKuq7Px2tVa1
 gRRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RryPDqqknK4ERS+3TaRX9hiB/DJYLhwBAeyNHq3EzDv/0E2LYlvEyH6W1YEDkhvV5ibAyeBY8RdFiDo@nongnu.org
X-Gm-Message-State: AOJu0YwJnhKRhujevJOm0vvQf+OZhkf9xzJJ0Rzhtc6vUnXSVE+b5zht
 Csuo3ay2NTzBSR+37CBsCqdGULjHRk+jzTO25/DPiWfr+oiBtW0IsaayaZ1q1xQ4Z40hkgQeN9r
 lBj0/b5kv4VQ+gptfo4WgAOpeLiFxbQE=
X-Gm-Gg: AfdE7clw+pbQAt+74lehp3YF/+x4PhXjJj/359Blx1f8bnMj7lZoJIUAA9kOiJFZ4Jl
 BO++KmG1O3GBhCRJeoFpqAiEBNWlB3NTcHHPukYU35njEAekDulnVsA7lcid0vrHVC0cka5mbVm
 Ltmg7tT+e2vuTy+4NG7uCbBzHa8wWiXaQAC1Rpj4/etokGFAf79y7RtABMh15eTm3FotdOH9pHT
 OjPvFPM8FBzFZwMcioxS1lKeNJhDCUemlYuUFdwdn/25WP6G0CPU9EYvX53EmiKTHMB+5paWuk=
X-Received: by 2002:a05:6000:2006:b0:45e:f8d0:d22c with SMTP id
 ffacd0b85a97d-46adabe36fcmr10004783f8f.25.1782292874054; Wed, 24 Jun 2026
 02:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260623205839.1294-1-linisha232@gmail.com>
 <ajuD4L_ZDEg8TI2R@redhat.com>
 <CAFEAcA9GSZXV5z=KDMLvM7enC1EqHwBt--=YOYb8HW6m=EHnqQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9GSZXV5z=KDMLvM7enC1EqHwBt--=YOYb8HW6m=EHnqQ@mail.gmail.com>
From: linisha <linisha232@gmail.com>
Date: Wed, 24 Jun 2026 14:51:02 +0530
X-Gm-Features: AVVi8CdL8KKGtN_rDDs_jeUw1XOu84x1-kwjc2Xwi3tTtW-aijhjl4BNAIcBnHE
Message-ID: <CAGKMO+WE6jf3nx6no3d0qPqiYu+gQC3vOZ_avV+aMrxTsQW6Xw@mail.gmail.com>
Subject: Re: [PATCH] docs/system: clarify pflash0 and pflash1 are virt-only
 options
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com, 
 mjt@tls.msk.ru, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=linisha232@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel, Peter,

Thank you both for taking the time to review and explain. I understand
now that pflash0 and pflash1 do work on x86 pc/q35 =E2=80=94 the underlying
issue is that help cannot introspect alias properties created at
machine construction.

The deeper code fix to address that is beyond my current scope as a
new contributor. Please disregard this patch =E2=80=94 I'd like to withdraw
it. I'll work on a v2 that focuses only on the documentation
improvement Peter suggested =E2=80=94 adding a general note about
cross-architecture and cross-machine-type differences near the start
of the introduction text, rather than pflash-specific wording.

I'll send v2 once I've drafted appropriate wording.

Thanks again for the patient guidance.

Best regards,
Linisha


On Wed, Jun 24, 2026 at 2:18=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 24 Jun 2026 at 08:15, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > On Wed, Jun 24, 2026 at 02:28:39AM +0530, Linisha wrote:
> > > The pflash0 and pflash1 machine options shown in the Aarch64 virt exa=
mple are only available for virt machine types on Arm, RISC-V, and LoongArc=
h architectures. Add a note to clarify this for users who may try these opt=
ions on x86 machines and be confused when they are not available.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3254
> > > Signed-off-by: Linisha <linisha232@gmail.com>
> > > ---
> > >  docs/system/introduction.rst | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/docs/system/introduction.rst b/docs/system/introduction.=
rst
> > > index bec7291e47..0c400aefb6 100644
> > > --- a/docs/system/introduction.rst
> > > +++ b/docs/system/introduction.rst
> > > @@ -158,6 +158,12 @@ virtualisation so we can use KVM inside the emul=
ated guest. As the
> > >  ``virt`` machine comes with some built in pflash devices we give the=
m
> > >  names so we can override the defaults later.
> > >
> > > +.. note::
> > > +   The ``pflash0`` and ``pflash1`` machine options are specific to t=
he
> > > +   ``virt`` machine type on Arm, RISC-V, and LoongArch architectures=
.
> > > +   They are not available on x86 machines, which use ``-bios`` or
> > > +   ``-pflash`` for firmware instead.
> >
> > No this is wrong.
> >
> > The pflash0 and pflash1 properties apply to x86 pc & q35 machines too.
> >
> > -pflash is a legacy syntax which remaps to pflash0 and pflash1 internal=
ly,
> > but also applies to other machines which don't use the new pflash0/pfla=
sh1
> > properties.
>
> I think it is probably worth having something in the intro text that
> makes the point that for QEMU all architectures and machines are
> potentially different, and that options and command lines that work
> on for example an x86 PC machine will not necessarily work on
> an Arm machine, and so on. But we should do that as a kind of
> general warning somewhere near the start.
>
> The bug report notes that "./build/x86/qemu-system-x86_64 -M pc,help"
> does not list the pflash0 and pflash1 options. I think this is
> because we set these up as alias properties on the actual flash
> device object in pc_pflash_create(), so they don't exist as class
> properties that "help" can introspect on.
>
> -- PMM


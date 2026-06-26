Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BCDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBUJ-0002n4-J5; Fri, 26 Jun 2026 14:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdBUI-0002mu-5J
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:41:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdBUG-0002Ci-4G
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:41:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-46e4764ca48so1177400f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782499270; cv=none;
 d=google.com; s=arc-20260327;
 b=gJVpJP0ZpzrOlxTd9o2JM4VtA74wdNHl2vS+3DoXB/9CmZNtHBiTKK1pPmq49oCXri
 2+Ii7qJoOhNtLYn/ZTznWmQnS7kJ1FRtUGfdG+8dyGSLytqRnyZH+ZjtFaDO2oOsuGbn
 WjR4Wtonao6d3OJdZNpOWX+DgEu7fCtGVO7/8nVK81fXBvQIPwj1oAtIY0a1BJl6wZ3o
 u/kmvfBC2RaCWaBBWY8ouYhDrW2SS6fXmVZ+C6oY+HZSlv0VZ/Pa9d2yPIna4KPxBZ7m
 6IWbz1Tq2Ey9tcWMcHVP+1UTeyGmBT3YkS99YNpsRUBydWAcu2CrctWylW4B7o8afEkH
 pnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/LeUqTMJS1kiMr9bEKxgIbK1sp00CFOMPDSDD1afFcQ=;
 fh=BNKbJlGvtgl8FWXL/pUPQTsTja38AQEjX3jVqov4anc=;
 b=YtqBqWd66wytPriMQ3HdPU1Ss0mGNphYSm0eJdhcNqOhRiwK14BD4uDuVXCiR0SG//
 ETeUJdLoYwbU9bG3n/+fvu2iorTpGe7IhWwC+v7Wah2ij1i0J7tCs7h+75XNEAUidooa
 kZNsAxTldz6Scuz0mv5iCxp3szSXYt2/GqP6YWZyeAkUbqaspPlyfDNNNaAW2hu7LvsW
 9TCw7hcF1nRMTY7wvgUm58XNs19ZGj6rBfe3aZsfBFB4SpntX/MmfipgTKFkDB/wRsSE
 LUvU3nQVD/SEH9Xu0p2sE+36+c7neNXrD0gyh+IOtOdnvpfTMOq7u0P12h23ZrToe6Lt
 llEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782499270; x=1783104070; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LeUqTMJS1kiMr9bEKxgIbK1sp00CFOMPDSDD1afFcQ=;
 b=ET+4w+xV50prnPgfQheSgIXMzBITuFsWLazw0CsW6m1WfdM/rrqvCHZQl+k+DQgh3U
 TwvO3yu59iIGcY7yVo0riuA8vtxJ2P0PnUBq94MSeLpNaqxuK6/FVBypms3OE1emCD2Y
 oHAAhFAfKdWg6wk4laSwCykVtuuumskKp9zdev0UuAylQIxBwTINRt9vD0wOeIL27ilt
 hAM+93Y1t0A3ESwWbPCkQ/LT1i24YOUKpqvBLPliH/LsENs3Eud7ZDT2zUNtxQAbvH63
 07xALVp9HRgZom7IfVe4Z30oY5bm+CxpW6n0PHcll6yZmh7Ya6jzUefqqmhS+Xl//fD9
 J8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499270; x=1783104070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/LeUqTMJS1kiMr9bEKxgIbK1sp00CFOMPDSDD1afFcQ=;
 b=WGeBrRDePriSaBovgz8c0OMWbSrQ4jFQdEXC/oBlRrI92Xt3GKaTJka74t3TvVum3R
 lpXtyLNMuJlfUC13a8fz1DwXhhFzluap9nHnCK1u+NdnFStwqzYgkLDgUD5lXGvRGz4E
 6cPpvzllRDlnVOQ78m9vq/XnovQlx42KbAAydmvJzW6Nko0jurJhK3CUuuJfeJKPJryW
 WqrkK25Y7V69BSEvuNB9WKIdfhgb7RuGUGNEAz5CEvdE5v5rTzzwz86sorrzolrNetyu
 r8vlaOyr+TWQ9ajLP2DRGKAI0X2o/Sy/m/TQq+q35GUQWxIRTmjmT1zQ7Wlb2FiCO7s4
 wmHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rre6TqV9Drz/x1isT5Vh1dlQDaWlxpwVIw7MtGanRN7vrEhl5oqT/TyjR/uHznD0aT/c8D5usmoLuI0@nongnu.org
X-Gm-Message-State: AOJu0YxpW9PLnA+pNHW0bTDW7WLuW4SEH8b388KtRR99UVnh/56GRdUr
 WBJne68FXQD7m57VBdfPSGnq6pKOytTnNQRzgrRBHgKeXBOf6fC5FraWOsYRtaVSjIaNUJFZtfW
 7a3rE1moLfjWTYec/FSH7/3JjWbs4Isw=
X-Gm-Gg: AfdE7clkwtO0X1zW0Q1oTyZoA5g/W+rPsJluuqbBHKJ0KEv0sHKPCRW5lwyfmcyAXAH
 omfqWcJcQGS1cOOBoSasuNOclNFFA6VMKbuoDHET8V2+kD6ylici8bqUZ4D/3qFP0EoFN2h/Oef
 miDesz9ol9ZqaSKXCJ4VJyz7K/5QZ7S2sMBqvbY8SlY0f6uRnCYQ2NmzCgPBrM9Faj7rARkUDGy
 P3Y6TwZWXTaK5ZWpS2gmMMcEP6JleCS81nip6G3tRwfNpdh98dMHQ3erhcL0JR+WwEnYGRsF6g=
X-Received: by 2002:a05:6000:60c:b0:460:38ee:9469 with SMTP id
 ffacd0b85a97d-46dbfca2635mr13547075f8f.7.1782499270294; Fri, 26 Jun 2026
 11:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260623205839.1294-1-linisha232@gmail.com>
 <20260625192121.1887-1-linisha232@gmail.com>
 <aj5P0n03aKv93uci@redhat.com>
 <9d695c7f-bb02-44bd-8e1c-f8bdbf3bbbf7@oss.qualcomm.com>
 <CAGKMO+VCZ_3cPWx000N_+REsEK+gQg8RCWJcx7YEchUcy20V-Q@mail.gmail.com>
 <c0292d61-3915-416f-a6e1-d8498dcd42e9@oss.qualcomm.com>
 <CAGKMO+XpdeOQwqqp6sq+q2gbGBkH-inBU0B49buohQ6OWhOxUA@mail.gmail.com>
In-Reply-To: <CAGKMO+XpdeOQwqqp6sq+q2gbGBkH-inBU0B49buohQ6OWhOxUA@mail.gmail.com>
From: linisha <linisha232@gmail.com>
Date: Sat, 27 Jun 2026 00:10:57 +0530
X-Gm-Features: AVVi8Cct7PUI_6Qp2KYZrnrPR-zY0pjpz27ptYfS1JtlgYy_KVvtGDUn0ym9SB0
Message-ID: <CAGKMO+XRcM86qk_X3qaWeYjvxnHWj-jsyWC-FoBLkYBemHJgtA@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=linisha232@gmail.com; helo=mail-wr1-x431.google.com
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

Hi Pierrick,

Quick correction to my last reply =E2=80=94 I checked again more carefully =
and
get_maintainer.pl -f docs/ still says "No maintainers found" on my
tree (origin/master), even after git pull. It only lists recent
contributors. So whatever change adds you to MAINTAINERS isn't in my
tree yet =E2=80=94 could you point me to the commit/branch?

Apologies for the confusion.

Best regards,
Linisha

On Sat, Jun 27, 2026 at 12:08=E2=80=AFAM linisha <linisha232@gmail.com> wro=
te:
>
> Hi Pierrick,
>
> You're right =E2=80=94 my tree was outdated. I just ran git pull and now
> scripts/get_maintainer.pl -f docs/ does show you as maintainer for
> General Documentation. Sorry for the miss; I'll make sure to pull and
> re-check maintainers before sending future versions.
>
> Best regards,
> Linisha
>
> On Fri, Jun 26, 2026 at 11:58=E2=80=AFPM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >
> > On 6/26/2026 10:44 AM, linisha wrote:
> > > Hi Daniel, Pierrick,
> > >
> > > Thank you, Daniel, for the Reviewed-by tag and the wrapping feedback.
> > >
> > > Pierrick =E2=80=94 I didn't intentionally remove anyone. I used
> > > scripts/get_maintainer.pl -f docs/ which returned Peter Maydell,
> > > Philippe Mathieu-Daud=C3=A9, Richard Henderson, Alex Benn=C3=A9e, and=
 C=C3=A9dric Le
> > > Goater, and I picked CCs from that list along with people who
> > > responded to v1. You weren't in the script's output, so I didn't know
> > > to include you. Apologies for the miss =E2=80=94 I'll CC you on any f=
uture v3.
> > >
> >
> > Thanks for your answer.
> >
> > Just to dig this further, is your tree up to date?
> >
> > When running it on my side (from upstream/master), I get:
> > $ scripts/get_maintainer.pl -f docs/
> > Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:Genera=
l
> > Documenta...)
> > qemu-devel@nongnu.org (open list:All patches CC here)
> >
> > > Daniel =E2=80=94 I'll send a v3 with the commit message body properly
> > > line-wrapped to 76 characters. Let me know if there are other changes
> > > you'd like at the same time.
> > >
> > > Best regards, Linisha
> > >
> > > On Fri, Jun 26, 2026 at 9:09=E2=80=AFPM Pierrick Bouvier
> > > <pierrick.bouvier@oss.qualcomm.com> wrote:
> > >>
> > >> On 6/26/2026 3:09 AM, Daniel P. Berrang=C3=A9 wrote:
> > >>> CC Pierrick as docs maintainer.
> > >>>
> > >>
> > >> Thanks Daniel.
> > >>
> > >> I wonder how I was not in original recipients for this patch.
> > >> @Linisha: did you explicitly set list of recipients, or remove some =
people?
> > >>
> > >>> On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
> > >>>> Add a note near the start of the introduction explaining that QEMU=
 options, properties, and command lines may differ between target architect=
ures and machine types. This helps prevent confusion when examples shown fo=
r one architecture do not work for another, such as the pflash0/pflash1 opt=
ions visible in -machine help on some machines but not others.
> > >>>
> > >>> Please ensure commit messages are line wrapped.
> > >>>
> > >>>>
> > >>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > >>>>
> > >>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> > >>>> Signed-off-by: Linisha <linisha232@gmail.com>
> > >>>> ---
> > >>>>
> > >>>> v2: Take a different approach based on review feedback from Daniel
> > >>>>     Berrang=C3=A9 and Peter Maydell. Instead of incorrectly claimi=
ng
> > >>>>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q3=
5
> > >>>>     machines too), add a general note near the start of the introd=
uction
> > >>>>     about how options, properties, and command lines may differ be=
tween
> > >>>>     target architectures and machine types.
> > >>>>
> > >>>>
> > >>>>  docs/system/introduction.rst | 9 +++++++++
> > >>>>  1 file changed, 9 insertions(+)
> > >>>>
> > >>>> diff --git a/docs/system/introduction.rst b/docs/system/introducti=
on.rst
> > >>>> index bec7291e47..8d9ef61d26 100644
> > >>>> --- a/docs/system/introduction.rst
> > >>>> +++ b/docs/system/introduction.rst
> > >>>> @@ -1,6 +1,15 @@
> > >>>>  Introduction
> > >>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >>>>
> > >>>> +.. note::
> > >>>> +   QEMU supports many different target CPU architectures and many
> > >>>> +   different machine types for each architecture. Options, proper=
ties,
> > >>>> +   and command lines that work for one architecture or machine ty=
pe
> > >>>> +   will not necessarily work on another. The examples shown in th=
is
> > >>>> +   manual are specific to the architecture and machine type being
> > >>>> +   demonstrated. When in doubt, consult the documentation for you=
r
> > >>>> +   specific target architecture and machine type.
> > >>>> +
> > >>>
> > >>> Not convinced many people will read this, but I gues it doesn't
> > >>> hurt.
> > >>>
> > >>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > >>>
> > >>>
> > >>>>  .. _Accelerators:
> > >>>>
> > >>>>  Virtualisation Accelerators
> > >>>> --
> > >>>> 2.47.0.windows.1
> > >>>>
> > >>>
> > >>> With regards,
> > >>> Daniel
> > >>
> >


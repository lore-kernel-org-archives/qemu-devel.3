Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13194E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 16:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vskid-0006QH-W6; Wed, 18 Feb 2026 11:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vskib-0006Pl-Ak
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:48:05 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vskiZ-0006JJ-Oc
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:48:05 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79801df3e21so332497b3.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 08:48:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771433282; cv=none;
 d=google.com; s=arc-20240605;
 b=jTNCjGnI0Ng02/dROu8F6bFcJBbKtSIUuH0ra8MmSDL+I50cYyWVq8qk6ALMThGZIx
 5Tyd8oaC1buFLS6A+77UQGyEZ2bzGtwemR4eA6ZPaxL/4gJHymVRFX+ddu5NMG/0H5Ch
 7MGbPV5pYbGvsZKydGlglWWtB+WxfKgXwpHVIGrUi6614xveXvXRbcTq8tnhloJDl0YN
 WqDQX5kB2vSoVSyboNHUNEOzUTnZCZOTYPuNmRNPmv5+Qdlm6PCjUZFfQZWwob4cj7NY
 kd7TjUO0nsRrSkMZBJ44v6qUt1qdIXx/C1XiG5T3tW7A2AKxn0JAkfzoWn8mrqlB1bvJ
 5bLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h/6lOK/rFrPD2mVDn5mvqiGOz14H3B+b06DqAHmV2dk=;
 fh=Ti9glq3poPBzlmIlQRhlHs6lyHZ8l9vVoDFCW3h9tPA=;
 b=C3IG6EXj7+6NoIXaums3ZVz2ZtEHFYuNqh/ao99Xshsey1Zdr0HCVsObpbqhOw63NX
 U/NBYSSMZ9nvggdRWXp+DHHe7JpYsXEi5qSmNjJ+WedV6J0uL5HeP2DMM8FM/WNRjAdI
 pBrLBRxCsE4RA0ID2rUJcga6FPDY+gotDfmndLRw0N93FmtqbDcCIprXtZ7SXj+bPdaO
 eatm4EqihB8QJjpRAMQFmvH/wpOEmdS5zpLVm0SwWMYw1NFYjNcDrsTzDB9W9/J1Iy8P
 H8ZLn4HZ4b3hPwJcdvohKrXrutK3Eq4sVeJCxMvGKO2QGJ6IDIwfqxG7OD7NvUX9To8D
 GePQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771433282; x=1772038082; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/6lOK/rFrPD2mVDn5mvqiGOz14H3B+b06DqAHmV2dk=;
 b=t3eYGCx5AaDjsAXk+Gtp9iGUbYH3axxQLIL+tLpg3I2PiurZF1o9dE3//671BjmeNI
 Y4//FAb3g+ZmDb0z6aMUITsEptDO0A5vY3RAIxt1n47rCsASkpaeZm2wnXsOLCHcXSHt
 2FdXPsnpsVZQ/jCdxJ7qdC0nefvhsM7cgOZTcDbdB+DIeKk7qzA7wRwi2B47PXqmpj8/
 4jBMkzAJxaAmLkA2U/LDPjOYXWJBvTav4BWn2A7y9MZu2W53bwnEcLK5TCGN4Yj5N73F
 PJij5u913nU1s/7vZD1qwWyJ2I3cgPRBXCcGZv5ovEzseXGOwdjaumXo4Z215yOZQyqT
 R8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771433282; x=1772038082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h/6lOK/rFrPD2mVDn5mvqiGOz14H3B+b06DqAHmV2dk=;
 b=NNXnlZQyGXjclHGlpYerCiFoCn8o8O7gd4rZ2Mfqrz7WrLK26lafExxfnhvGF3m94y
 PZhXli4Ln5Z/K284O5fZYvN5oB9Am/z/pMn+Nh4N84cuUen183Xs64RUF5kPvuP8HsPE
 VxWH0BtgWHY+Cb0Ny7oTZM71T93XAyW5bbMsonH7Ukj5n3CLSdSZcYQ+z4xPiLBdeA0X
 sSP5qfL9sCxs9HYr/cb03cmaC+4kW8yagsPnKpd5qMrbqrek3+G9UtqWznDDXCvlH42C
 BYgGdCdRYSgPlmg9NJ/gaLXgZuvBV+jMCmIR/lcSx4aUJxns2n4iceqN5JEcU0dWFbm7
 y/fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJt+NWmlhVbtTwdLY7ac8E7m30s3u7/yMsxJcQmP0NMWNqKi7pnjD4fSmckUb9umlTku9dNQU/jAEc@nongnu.org
X-Gm-Message-State: AOJu0Yxp8KHHCpYFeo2FoyN0nTS8EhkALxTo7zYl2cuU/Awa9cmDCu2u
 /0d3cZ3Ajid3nSTzNugjSDz61rHgjEf7Mm3bJzvvoqOycNc5rcucDv/thzgUwypVkfKPnvJ410R
 2HeRmJPb5pt6aJVaYPEfx5u7xzSBBuY9yvH3Mydlxhw==
X-Gm-Gg: AZuq6aLEKY+WqOdEgFAbs+5EdfJ6YZk2IGtmV1l1STdYiZXtcO/2Xbsr9A1j5oeBmk0
 eCVQJIH4vN3yDs3Qzd3OEShhRQnzriwAfoyJhLKEWwn37Fso3hndrWCDynK4PaM4NE/tM3YIlB6
 nDNgJmZB65pUfwMVc3IwRrl5AeQ0JsvPNuKi99s7TF1kl/1GR+w1neBy6M3i2p1xRNdKWq5n0vM
 g6T2T4Jl1cUOYUVDH4DiddnN2RI+Vp18uLi1ZkhawiBBQ8lYwl7x07BhsnrIwP/zqmmEIpqKajT
 bBUEP0zLW0iRobzztyd+O2euUzQJu03ofjFzVMsr9Et1uIPUUrdTbhRDD8KpuxhbhzZuTFuFo6n
 ecQ==
X-Received: by 2002:a05:690e:b46:b0:64a:e35b:b431 with SMTP id
 956f58d0204a3-64c21b7fc2amr11677381d50.83.1771433281516; Wed, 18 Feb 2026
 08:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_BJdifU=58m7ObeAe_ZByE6M-Zkg0cU70wP10+gpUkNg@mail.gmail.com>
 <385d1a8e-c202-4d72-a24a-1e49478278b4@yodel.dev>
 <28c7b18c-c998-4392-a1f2-9b287d7545c5@linaro.org>
In-Reply-To: <28c7b18c-c998-4392-a1f2-9b287d7545c5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Feb 2026 16:47:50 +0000
X-Gm-Features: AZwV_Qjc8ndofthR_pO2ebL15tmj24JcGaLTOKArHepD5_HgFB2mgRsQY0m8U-k
Message-ID: <CAFEAcA9Aha1TtTZZuCONmPP+baRxr=VE49mFk4zXwvM9O4p8gQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 17 Feb 2026 at 21:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 17/2/26 20:12, Yodel Eldar wrote:
> > +Philippe
> >
> > Hi,
> >
> > On 17/02/2026 03:21, Peter Maydell wrote:
> >> On Tue, 17 Feb 2026 at 06:35, Akihiko Odaki
> >> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>>
> >>> alpha_cpu_realizefn() did not properly call cpu_reset(), which
> >>> corrupted icount. Add the missing function call to fix icount.
> >>>
> >>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> ---
> >
> > So, the real culprit was hiding in plain sight in Alpha-specific code
> > all along? Congrats on finding it!
> >
> >>>   target/alpha/cpu.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> >>> index 1780db7d1e29..74281ebdb367 100644
> >>> --- a/target/alpha/cpu.c
> >>> +++ b/target/alpha/cpu.c
> >>> @@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev,
> >>> Error **errp)
> >>>       }
> >>>
> >>>       qemu_init_vcpu(cs);
> >>> +    cpu_reset(cs);
> >>>
> >>>       acc->parent_realize(dev, errp);
> >>>   }
> >>
> >> Realize functions shouldn't call reset on themselves.
> >> For CPU objects it is currently the responsibility of the
> >> board code to arrange that the CPU objects get reset.

> > I think the following addresses Peter's remarks; it passed 100
> > repetitions of the Alpha replay test after reapplying the reverted
> > commit:
> >
> > diff --git hw/alpha/dp264.c hw/alpha/dp264.c
> > index 5e64528431..091ffc0085 100644
> > --- hw/alpha/dp264.c
> > +++ hw/alpha/dp264.c
> > @@ -68,5 +68,7 @@ static void clipper_init(MachineState *machine)
> >       memset(cpus, 0, sizeof(cpus));
> >       for (i =3D 0; i < smp_cpus; ++i) {
> > -        cpus[i] =3D ALPHA_CPU(cpu_create(machine->cpu_type));
> > +        CPUState *cpu =3D cpu_create(machine->cpu_type);
> > +        cpu_reset(cpu);
> > +        cpus[i] =3D ALPHA_CPU(cpu);
>
> Hmm this pattern is used a lot (creating CPUs in board_init without
> manually calling cpu_reset). If this is the simplest fix, maybe
> we could add a cpu_create_resetted() helper and use it where
> appropriate (i.e. not where qemu_register_reset is then called).

Resetting the CPU either in realize or else in the machine
after create causes it to get reset once on startup. But
it doesn't do anything to cause it to be reset when the
user (or the guest) triggers a system reset. If the board
arranges for the CPUs to be reset during system reset then
that also works for the initial startup case.

Reset is unfortunately a bit of a mess: I have periodically
thought about it but still don't have an overview of what
exactly it ought to be doing, let alone a plan (e.g. should
we cascade reset via the QOM tree? or do we need a separate
reset infrastructure that defaults to the QOM tree but that
SoC objects can override if they have more complex reset
requirements? How does this interact with bus-reset (which is
definitely a thing for some buses? And once we've decided what
we want, how do we get from where we are right now to there
without breaking things and ideally without having another
of the long-drawn-out never-completed API transitions we're so
good at?)

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCCEC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmar-0001Ku-SN; Mon, 20 Jul 2026 07:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wlmap-0001G4-Uu
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:55:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wlmao-0003r9-33
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:55:31 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cace91f112so101488715ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784548528; cv=none;
 d=google.com; s=arc-20260327;
 b=qwbjaD/9RdBvxY9CW+WwvvOR1gUTwIgvDkkPqq6b4clUi0Hw7NYFV5e2pO229hU8CA
 oMbq/+YcG75KwWCbUn8g9VqX/EcNu+flt9Ev/3wHnY02GL3PVMyYpKm137Bx/0TRycvU
 0OU8Re4jDmQghaMaHRjd5ixEOp7muU4xJFoxC08gKYVQyYOAQxAO3Kxc3uYyDKRHplCa
 PUELoNtBkuC534CzNVK0Jm6Kcc+mm/TQdrW3hkYAuNaNUW0eoeQQbJqb4ha+M2X2szRL
 SXrD9Z7JFR2G/difeXCQQr2U2rRUm8AxYmiAg7XFxbAKZuUQtcuZA5lbvl4g6HeyYcO2
 dwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/HOMO/kRAjHNYQuR0NBKH7El7Z3ZlEBLqN9W6owBWLQ=;
 fh=F+NSniKl06h6iGvcE7M3xhUYwoWPV7GKmOQQSwIWIBg=;
 b=EiJG0+SWy5EEFghEH/ff3JPuhM7ktrwmLe+B8/zhCIlvTliwK7WSdEJQXTGtMX6jeS
 oqvZ4KP9V/gq1pNLq6P2LD/OEVncLRtiFQsduFTrdbrjemOkCsA49okgJOywK8eoi45h
 Q3/IVJ3fQ5E7OkW+uPbGWPSMNtP84bdwnjoFfcQGqnei0t64ypplj5coZyQo+pb2N5Ru
 2ASan7td9z0AeGuFsuYGLst3zq1TSK78kunhMX55UN1Czj5R1aD7YjB7be1pUwJQaKjY
 Htpd9+lBWldivIb8b07jZdMQ1/EdeI7LYVyunpTdQm2feZzV9fijYUWImIlAyP7rfj+l
 bSSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784548528; x=1785153328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/HOMO/kRAjHNYQuR0NBKH7El7Z3ZlEBLqN9W6owBWLQ=;
 b=c4UqFBkQ+O715lxriRvQi0kgP2CrriV5FnX27oeGX4EmN5xBY3niqfhu0TkGRXez6P
 yOMZSkF3zui0AVq1vOEpC6B0yUGSx8ecjTKlk2dZp8NTajKVvpdRPDzeMhRfPJN8VYku
 eS1M3KCaXWAwii2fLxZt6m3u4a71fWhoRYBIaMZZUOhiztPx6btfJWXpy+mBNWeHLUfD
 /IK71KSm2hetwKPovUZsRdcMhkMp4zAjnw+zKgwOg021rU4hU5H5Ldfc5STBz9o/4CS+
 rTV5PvE9OU1LwCnIJX3ZmEIgQiZi/bq3iiYkmrAJsCSjFDMnJW1WZB/+6oBYUUniGkMi
 ESpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784548528; x=1785153328;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/HOMO/kRAjHNYQuR0NBKH7El7Z3ZlEBLqN9W6owBWLQ=;
 b=cLPuz/clWKFAthbxmpACykKsXRgnwpteDl0r56lbyYA9dfc7q2NW5PcH3TeHS3XLCJ
 Qmr2GHvyDnLvgb7P3W2AY7j84mhB/pa3wUpU+Oed/BXgCpW0IzI5afNFharQ/mlMSom/
 B26HIYpYhPtYqjxkUJp9WHW7dJQiHm0vvlCejNwFYLZOLWOOzhgPbX6PDzBVAQAQtBfr
 gDMnXl68wf0vIDvF7migLPfiW4TIHYHKmONIhg3RdMQ9ogydbSVpz0/tT4Dzl/HKcVs+
 Y7Z+Vps9cmPw7H2ViWwnGurLMXskMQpMVR8AIZsVqiyiT5w7fmuByA7xWdlPVOIJbW1e
 CeWw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyfwJG8cEGUl3wZB3RWYvmR8BnS9Uamh/OdpzVg7m2xQEn9INI95GWInUXUHatr5dA5yrTlMYNCo7t@nongnu.org
X-Gm-Message-State: AOJu0Yx0GhEDEZ1rDDP/4+j6P3SN0r8nvIzIv/qMrG8sJ8UYy27cp2Lz
 7+DKpLEcj7ljI/QCvjtgRjHZnmTSRfkRrDDAjVuwY6eFSBRWPpW4cx64e8k6n5hLpabQuJi/gPw
 KibP30YBsEXtozFYDfzNkVnaRIV9RH80=
X-Gm-Gg: AfdE7cnGNSSNMrKr2OeR+CUZ6OWN5B8h0xE6pk6UxXgBaQ/xrOtcoej+jdfTD246nGg
 R/GP3Ti0QqRL+3NFvucCGgsuPD3Y9HkCLx/auymRBl6kUhXvnA8oiPfzo/GyvK26+5fw16tG0w6
 7eNLDHSVKndje/ojd/2lopY9sFFnBdKQiJSJ/j0lshtDgfdZtQP6HhyZ/kOOVQUemna7kfhFz/z
 53p4FFNx8uugPK8t7mY1FCvB/q5EMYrorczcMC59IlgrFnQLQH8MUpUHTKgLzCIN0BImUEv5WZe
 2dbW+R3LG9S0PeEHZdjMNzBRKxeZ
X-Received: by 2002:a05:6a21:a44:b0:3c3:a9ad:a755 with SMTP id
 adf61e73a8af0-3c3ad677c2emr14389357637.7.1784548528389; Mon, 20 Jul 2026
 04:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <87o6gge6b0.fsf@pond.sub.org>
 <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
 <87zf00cn7m.fsf@pond.sub.org> <ak-i1dNY_RrGNHAM@redhat.com>
 <CAFEAcA_=rz22ZqPr77REQa5BJRZVuEkriq-gJ9xGg4E46JPUxQ@mail.gmail.com>
 <CAJ+F1C+BiqriKhDO-vY15z5iQECVarJN-NoemiaW3w93c3EpNg@mail.gmail.com>
 <ak-p56pwFPq9omMz@redhat.com>
 <CAMxuvaz=7RxVDjDsR8LeMxAgk-u46ZsKGshsAGKXxMykj7M=FA@mail.gmail.com>
 <ak_FOBO0sPYrM4XR@redhat.com> <87wlupvrdg.fsf@pond.sub.org>
In-Reply-To: <87wlupvrdg.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Jul 2026 15:55:16 +0400
X-Gm-Features: AUfX_myX0XHeeViMOIiNp6DJrPPpCYjeUpW4Y9ZK2CbF_9Y8xxc1VQSPQSEM4vE
Message-ID: <CAJ+F1C+Xsf4zbFfQJ23ANMR8MsVhdFmvDcnu5_MbFpvME3nCwg@mail.gmail.com>
Subject: Re: A few Machines crash when "no default audio driver available"
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-arm@nongnu.org, 
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, 
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Jul 20, 2026 at 3:21=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > On Thu, Jul 09, 2026 at 07:31:31PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi
> >>
> >> On Thu, Jul 9, 2026 at 6:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> >> >
> >> > On Thu, Jul 09, 2026 at 05:54:30PM +0400, Marc-Andr=C3=A9 Lureau wro=
te:
> >> > > Hi
> >> > >
> >> > > On Thu, Jul 9, 2026 at 5:44=E2=80=AFPM Peter Maydell <peter.maydel=
l@linaro.org> wrote:
> >> > > >
> >> > > > On Thu, 9 Jul 2026 at 14:32, Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> >> > > > >
> >> > > > > On Thu, Jul 09, 2026 at 03:22:05PM +0200, Markus Armbruster wr=
ote:
> >> > > > > > Cc: mainainters for "Overall Audio backends"
> >> > > > > > Peter Maydell <peter.maydell@linaro.org> writes:
> >> > > > > >
> >> > > > > > > On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@red=
hat.com> wrote:
> >> > > > > > >>
> >> > > > > > >> I stumbled over ARM machine musicpal, PPC machines pegaso=
s1, pegasos2,
> >> > > > > > >> and MIPS machine fuloong2e crashes.
> >> > > > > > >>
> >> > > > > > >> I run them like this:
> >> > > > > > >>
> >> > > > > > >> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display=
 none -monitor stdio
> >> > > > > > >
> >> > > > > > >> Died when device_set_realized() tried to propagate a "no =
default audio
> >> > > > > > >> driver available" error to &error_abort.
> >> > > > > > >
> >> > > > > > > Is this something we want to have be a possibility the dev=
ices
> >> > > > > > > have to cope with? Can we have the "ignores all audio data=
"
> >> > > > > > > backend be always available instead?
> >> > > > > >
> >> > > > > > There's plenty of precedence for /dev/null-like backends.
> >> > > > > >
> >> > > > > > > Otherwise every audio device needs to cope with "there is =
no
> >> > > > > > > audio backend available" and implement "do nothing with th=
e
> >> > > > > > > audio data" itself.
> >> > > > > >
> >> > > > > > Yes.
> >> > > > >
> >> > > > > We've got a bit of tension between "no defaults" and "builtin =
audio
> >> > > > > devices" here.
> >> > > > >
> >> > > > > Cnosider if I had instead done
> >> > > > >
> >> > > > >   qemu-system-x86_64 -M pc -device ac97 -nodefaults
> >> > > > >
> >> > > > > It is not unreasonable to expect to see an error because you a=
sked
> >> > > > > explicitly for 'ac97'  and forgot to wire up the required audi=
o
> >> > > > > backend, and asked to NOT have any defaults.
>
> Even then, a crash is unequivocally wrong.  Fatal error would be
> defensible.
>
> >> > > > > But with your 'musicpal' machine example, you never asked for =
the
> >> > > > > frontend device, so you should be forgiven for also not asking
> >> > > > > for a audio backend.
>
> Indeed.
>
> >> > > > Ah, so this is because of -nodefaults, not because QEMU was
> >> > > > somehow built with no audio backends in it.
>
> Yes.
>
> There are more ways to end up with no audio backend.
>
> >> > > > > If we guarantee a /dev/null audio backend always exists, we he=
lp
> >> > > > > the second case but degrade the first case
> >> > > >
> >> > > > As a possible analogy, for network devices we just warn in
> >> > > > the analogous "device created but no backend wired up":
> >> > > >
> >> > > >  ./build/x86/qemu-system-x86_64 -nodefaults -device e1000 -displ=
ay none
> >> > > > qemu-system-x86_64: warning: nic e1000.0 has no peer
> >> > > >
> >> > > > and the effective behaviour is that output packets are dropped.
>
> When a network device lacks a backend, we make it behave as if it's not
> connected to anything, and also tell the user that this is the case.
> Makes sense, especially for onboard devices: the user may not care for
> such an onboard device, and can't remove it.
>
> When an audio device lacks a backend, could we make it behave as if it's
> not connected to anything?
>
> Longwinded way to say ...
>
> >> > > > We could make audio devices do that (which would be basically
> >> > > > equivalent to "if we need an audio backend and we don't have
> >> > > > one, warn and create the null backend").
>
> ... yes, please.
>
> >> > > Note that we don't have a real "null" backend. The "none" backend =
does
> >> > > mixing/resampling/volume before dropping the audio (its parent is
> >> > > MIXENG_BACKEND). I think it would be worth to add (so one day we c=
an
> >> > > compile qemu without the whole audio/ engine)
> >> >
> >> > Rather than adding "null" backend, IMHO, we should make "none" do
> >> > what its name suggests, by removing the MIGENG_BACKEND from it.
> >> >
> >>
> >> It's a bit more complicated, the "none" backend can be used by vnc
> >> (not spice or dbus), and we have the now-deprecated HMP wavcapture
> >> command.
> >
> > Oh right because VNC used the capture APIs to receive the audio.
> > It should probably have had an explicit "vnc" audio backend like
> > spice did :-(
>
> Is this fixable?
>

Yes, that's not so trivial though.. (mostly because compatibility with
existing behaviour/cli etc)

> "Certain audio commands only work when you actually have an audio
> backend" would be perfectly reasonable, wouldn'it ?
>
> >> Note, the new "qemu-vnc" server does not mix/resample audio at this
> >> point, it takes the first audio stream instead.
> >
> >>
> >> Fwiw, a "null" audio backend would still need to process audio data at
> >> a correct pace.
>
> I'm dense today: why?

-audio is emulating a real DAC/ADC that consumes bytes in real-time.
If you just do >/dev/null, the audio clock will be too fast, and most
apps playing video will likely just play as quickly as they can...
This is just the small part we need to keep emulating right depending
on the audio stream format


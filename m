Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F18AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqj9-00063M-HK; Thu, 09 Jul 2026 11:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1whqj8-00063D-QQ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1whqj6-0002mq-Eg
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783611107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaHc/CL/aWA9MSr7n7QV5ZOO0n5A8cbT703vXzhZfrc=;
 b=F/RZHCsM0G6JRKWpv+/cqdgklngVmVPiwASq8rENdXP8e0Qhz7a25Ghm8LLoVqVOaecwH+
 uUHEI9EA63NtQPzV56vTI+DDjYAa86zDOQskpK2FrCcPtDhum62Bah4FlPt2C700L10s76
 qwV8Bmy0RH5jkmEPOP0Ng9mrfEVx+gQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Hy1JHF7RNLuYviK-kJuyfg-1; Thu, 09 Jul 2026 11:31:44 -0400
X-MC-Unique: Hy1JHF7RNLuYviK-kJuyfg-1
X-Mimecast-MFC-AGG-ID: Hy1JHF7RNLuYviK-kJuyfg_1783611104
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38c7e2730d6so14597a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783611104; cv=none;
 d=google.com; s=arc-20260327;
 b=dBEEsP6iKkC2iBaWNfqO/L+CNGCRar+pk3ew06Uk572SwDAS0dFR1CPqS8RmLK7Q61
 SpavTFwnggGaRGUVpjQwg2OhMFtPbP0yyjmwWk/UYLhbR+x6APZabPbc/HdzN1eaD4jz
 65yG9ygRNETuJ0CdRwczvJiZxCXbcKY6yi7xOApYscPwW8xja17btE00G0rO4v1uwSV2
 D7DL/JLCOkzNqj2YWx+73Vjgswk0Ije/p/w7Fnp7G5szQ+ibLJSefYfxajl5XzdUKXM8
 GxeOfzliMvqG+nKxjtEI51y05Xial4vCrYIfplHkfsLV1x/kl18QyGY67AU4QtyUjggJ
 cwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jaHc/CL/aWA9MSr7n7QV5ZOO0n5A8cbT703vXzhZfrc=;
 fh=UWD75sp2TJHN80Xjb9k4vM/QLHw+Gh5yjDJnxeGXHPg=;
 b=cgMIp8VUeL4DxWI9FBVc0HIMK9Hl77ghf1BDj0+natbPuBXTR6Q2eZo5nCGAu65qXT
 rmvrduXjUaiQpdHLKezWHzjMrIMBVuRO6Mc1XyeaiX2wo9U2xjeCGWXyu3Zlqo5nIJ5Z
 48VVpFL8XS+ey/xgqqPn0M/LHddx6p90/mExV2MMMY5ey+DtPzxqHrm8y4ElDPZ//Kj+
 s7CE6BXATTRmS4J2SIbPuqkK7ZlI3TBd5RZxlyGsjzWB/dHCNI1R0szRc2y+/fjsWRDb
 rVR2gOOFXyXS12j3S/xGgRIT0tZqejcmn7yyM4nEVODX9YMTXPobm0EIMAoSBSvXSgOq
 /RWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783611104; x=1784215904; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jaHc/CL/aWA9MSr7n7QV5ZOO0n5A8cbT703vXzhZfrc=;
 b=Z6HTXIPX+aXS7DvZ0gWrwf7sRNQHf2o4HIQZwKHdZDqXs+/L9tgcikUAts+frXKuEK
 ZoZHUfJtHB7DER+Wgz3f6Q0WXLV6hlGuS4TM+q0qQUdNo4kR6rSKLn6Kzad4Idntg0jb
 cORHqXid+gJlntwZOGISLb0XYAyVvKP6CXieQwUddXklvX4/B2vjp2fcAzHU2HTjy5Mr
 udjO39rDzMrVKuDytgQvsGaSWosVGlfn/phVjXmPdIH1tpAd1r53PiriLs1cnvRMCE4R
 zdtV/onfatHAafkK2X+CcGdZXPXcUbodWcS4AmicAN6XehNP8nFSFLq8G3CBquLknL/P
 fz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783611104; x=1784215904;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jaHc/CL/aWA9MSr7n7QV5ZOO0n5A8cbT703vXzhZfrc=;
 b=LAJuzdXYEY0dBl3ZKrfTs+yp4mz/u4BGRUz+o/ybYVdeRtivjPxQzMCA+aGoao9hLt
 hxKge/uF89m92In/VTg5xJErEvhhQt3TL0Bk1YA60qpBlN+MM5QiqrkrA373rgPDGbxU
 AM1ioDfAv8Cn+DCJ4s3g8WbjYbUORmDnaAkuao6ZJzDarsjqUv4t5lf6xlrN5sOecgsv
 CDZaFmAav1eLIlfi+qU1urDTe0pGgZdmrQFSrSYhv6qmTWafOB8jl4M2JGT9ZvM1wBt0
 Wy4uSIwc30cBhYTNJRndq8H+jMKw0avjaYACmbPlEqOiBHo/w9xgdz6TnvORjVGrxMMf
 tXHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrpo9pB/IiHzQ1hlsKTaatvgRQvOZTyKFAian0IYF+ESAMH9Gy1BMjnqcoEffPCxoSy4uZDlMQvgaEE@nongnu.org
X-Gm-Message-State: AOJu0YzROLMFJxA9MFkZCs941Xe2k4ETkW2xrMLwe++Rf1eXlb7QfjzA
 neQBfIIp7+trjK69aGZ0XmRrQG3pWiX8CieSB2TyRHq66yNhWsI4mesSBmDrVXHklmVpwlG/9kP
 YTjjwU3CviDShFF0RGrzg0IskBZXFNobUJEfxOlZkd1ZGb8GpsckpaUoaCv5yRm8f5fR0un/OC6
 ZdIhWa5JyGcBwBqSfl9drDwpc7JrnV7LE=
X-Gm-Gg: AfdE7cmllkkTyGDGAOPwu5JySw2Utlx4AKPsVGIyFb3oOBM4wd+v4iYBxAe0sVtRliX
 KrmXoejhnsn1pHRzr3oeQzm2gQ8/8shq0/8tUCC7oHY3N2PaPEAe864tc9LpXpmXoUCINjkDI+B
 ZRSisGBFUjRvRAPVsmERmTLafHB62n5UlCfhTgAptRWMTwKThrLp7B6PkNt9s5FqZ8olr3nJ0Yl
 TlV7ytfwth5WD8ldu1tBZFVuutA4YCQl7C+A3IMAZLh2qLgFIA5BHNwd/Wsx0LQUDIQfwmkhit/
 ZNNeCjwwl0jX
X-Received: by 2002:a17:90b:56d0:b0:37f:9ce1:735e with SMTP id
 98e67ed59e1d1-38941bce343mr7939349a91.31.1783611103481; 
 Thu, 09 Jul 2026 08:31:43 -0700 (PDT)
X-Received: by 2002:a17:90b:56d0:b0:37f:9ce1:735e with SMTP id
 98e67ed59e1d1-38941bce343mr7939293a91.31.1783611102929; Thu, 09 Jul 2026
 08:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <87o6gge6b0.fsf@pond.sub.org>
 <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
 <87zf00cn7m.fsf@pond.sub.org> <ak-i1dNY_RrGNHAM@redhat.com>
 <CAFEAcA_=rz22ZqPr77REQa5BJRZVuEkriq-gJ9xGg4E46JPUxQ@mail.gmail.com>
 <CAJ+F1C+BiqriKhDO-vY15z5iQECVarJN-NoemiaW3w93c3EpNg@mail.gmail.com>
 <ak-p56pwFPq9omMz@redhat.com>
In-Reply-To: <ak-p56pwFPq9omMz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 9 Jul 2026 19:31:31 +0400
X-Gm-Features: AVVi8CeFWLriYLnYysDmaMlaOx-gjGYYrarF3-SlGWFQd0loV4v9ra_NrWaY3jg
Message-ID: <CAMxuvaz=7RxVDjDsR8LeMxAgk-u46ZsKGshsAGKXxMykj7M=FA@mail.gmail.com>
Subject: Re: A few Machines crash when "no default audio driver available"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-arm@nongnu.org, 
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, 
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 9, 2026 at 6:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Jul 09, 2026 at 05:54:30PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Jul 9, 2026 at 5:44=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> > >
> > > On Thu, 9 Jul 2026 at 14:32, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> > > >
> > > > On Thu, Jul 09, 2026 at 03:22:05PM +0200, Markus Armbruster wrote:
> > > > > Cc: mainainters for "Overall Audio backends"
> > > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > >
> > > > > > On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@redhat.c=
om> wrote:
> > > > > >>
> > > > > >> I stumbled over ARM machine musicpal, PPC machines pegasos1, p=
egasos2,
> > > > > >> and MIPS machine fuloong2e crashes.
> > > > > >>
> > > > > >> I run them like this:
> > > > > >>
> > > > > >> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display none=
 -monitor stdio
> > > > > >
> > > > > >> Died when device_set_realized() tried to propagate a "no defau=
lt audio
> > > > > >> driver available" error to &error_abort.
> > > > > >
> > > > > > Is this something we want to have be a possibility the devices
> > > > > > have to cope with? Can we have the "ignores all audio data"
> > > > > > backend be always available instead?
> > > > >
> > > > > There's plenty of precedence for /dev/null-like backends.
> > > > >
> > > > > > Otherwise every audio device needs to cope with "there is no
> > > > > > audio backend available" and implement "do nothing with the
> > > > > > audio data" itself.
> > > > >
> > > > > Yes.
> > > >
> > > > We've got a bit of tension between "no defaults" and "builtin audio
> > > > devices" here.
> > > >
> > > > Cnosider if I had instead done
> > > >
> > > >   qemu-system-x86_64 -M pc -device ac97 -nodefaults
> > > >
> > > > It is not unreasonable to expect to see an error because you asked
> > > > explicitly for 'ac97'  and forgot to wire up the required audio
> > > > backend, and asked to NOT have any defaults.
> > > >
> > > > But with your 'musicpal' machine example, you never asked for the
> > > > frontend device, so you should be forgiven for also not asking
> > > > for a audio backend.
> > >
> > > Ah, so this is because of -nodefaults, not because QEMU was
> > > somehow built with no audio backends in it.
> > >
> > > > If we guarantee a /dev/null audio backend always exists, we help
> > > > the second case but degrade the first case
> > >
> > > As a possible analogy, for network devices we just warn in
> > > the analogous "device created but no backend wired up":
> > >
> > >  ./build/x86/qemu-system-x86_64 -nodefaults -device e1000 -display no=
ne
> > > qemu-system-x86_64: warning: nic e1000.0 has no peer
> > >
> > > and the effective behaviour is that output packets are dropped.
> > >
> > > We could make audio devices do that (which would be basically
> > > equivalent to "if we need an audio backend and we don't have
> > > one, warn and create the null backend").
> > >
> >
> > Note that we don't have a real "null" backend. The "none" backend does
> > mixing/resampling/volume before dropping the audio (its parent is
> > MIXENG_BACKEND). I think it would be worth to add (so one day we can
> > compile qemu without the whole audio/ engine)
>
> Rather than adding "null" backend, IMHO, we should make "none" do
> what its name suggests, by removing the MIGENG_BACKEND from it.
>

It's a bit more complicated, the "none" backend can be used by vnc
(not spice or dbus), and we have the now-deprecated HMP wavcapture
command.

Note, the new "qemu-vnc" server does not mix/resample audio at this
point, it takes the first audio stream instead.

Fwiw, a "null" audio backend would still need to process audio data at
a correct pace.



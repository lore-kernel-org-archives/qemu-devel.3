Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD32E7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 09:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXGqh-0000LZ-KQ; Mon, 13 Jan 2025 04:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tXGqF-0008Mc-6H
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 04:34:39 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tXGqC-0004wv-Rm
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 04:34:38 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-467a8d2d7f1so33292241cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 01:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736760875; x=1737365675; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFSfU5aMlgezsmwRHiwD4/rPhSe5E0ICveqF3maUUt4=;
 b=Q9rdiiOLFhFIpgY32Dwl6cl/ZcFGUSziHDDfos+DvAJrSfmMVS9+wGPt6OJpugCu3O
 3v5Jogp+7d+wjOzZo9jzUy0FdOOneWJT9m3ox4f9llRtn3TmSswuKhUnrTdtXaSwGucV
 oFVzfz7BDoBnkUVsyUXHqbtzFdewYLcHY+f3emWRQTc5XvZcV0n1IpDiI6aOA2LoO6Z0
 3FOZoWilmhBYBXBsfG5TzUBxUyBMB3fr0W9LDhei76j8J3yXH+2fEU7NHcdDVAUGToSI
 5wR746b18jA38H8p2O03nsgnTiUvLfM/AtTHH1xEqZHKThSwr9RtYYm9JWCptLlM3W8X
 osdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736760875; x=1737365675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFSfU5aMlgezsmwRHiwD4/rPhSe5E0ICveqF3maUUt4=;
 b=OnZloRP/sZOfF4XNiVHWc8Ydh9Jyz7YgGBSjRVLvAHqqPhHj/qSKM3D2wHle9V9YR+
 fEoH/ehhXHMAlIvYBdjpnp5JmZilNUHTLayzU29Xq5DTVR/4liLsc0GTsZQzKmv3uFKu
 N3kpedcxNVrv1ZC5VGWAJyqpBnSRrT1FXoGyKr0hes01zPp7z2iKo5jsDWnJ+nvV7dw9
 ZL08tlR/uKFzF5O8U78d0ZnWJVVVgNCfHajZu5iq5978pCwnoLKzCHxLBIrAJ6Fl4STw
 xX3mq8HBJVjf7agz9WDWOp1o8JNqIqxkclcPYtT4b/X1YcVtWDl76CHDJ+wyF4mlAm/k
 e+GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzadm8AgZrk1r74yMAOA9EBnMe3OkFj5RjMVfBTTapITCwqWqjB0AaGLg6pSCxTbIY0BXDz1PNEtgM@nongnu.org
X-Gm-Message-State: AOJu0Yw9YgNikldsK2RWkXHFCKG2FLtsOs585Savp/q3GyBYBVL3Trys
 HHHvDzradjf4Pg6UW9j2/kXyaATcm87Z6Pp9EyU/Q3mhIT9jDkvhMvtOQPynjt1elhce8iwl50Y
 S73Yh9XJsMUHwQxmHwTaQQKlMMSA=
X-Gm-Gg: ASbGncsm5RXd6SKILPXQY+LvzhjcRiCwH74nRo3mHRXPD+Z8yh3DHcOmTrqEyhlhGls
 LYGEk9CbOWRejb8xLsv1FgkBe+ou8mOD+55R9
X-Google-Smtp-Source: AGHT+IEAihpJsT68ZHBki0W+xVLFwBZbAVVfcAASVV2k0p2rBcGBv/dcS3awFPaBrhC5LtG0uiLy5dGH/V62adzGa2Y=
X-Received: by 2002:a05:622a:6203:b0:46c:71f6:7aa5 with SMTP id
 d75a77b69052e-46c71f67d9cmr325616321cf.41.1736760875126; Mon, 13 Jan 2025
 01:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20241223132355.1417356-1-r.peniaev@gmail.com>
 <20241223132355.1417356-7-r.peniaev@gmail.com>
 <CAMxuvaxFGXDYpwPfqTUZuBVY4iF_BCm6jwOM=quUBn98hYPt=g@mail.gmail.com>
 <CACZ9PQVe1Axq6Lp_acaQuXpih2hwAU_7jz-NywyYBQ88hxt1og@mail.gmail.com>
 <CAMxuvaxzd41bRxa4=zNMdpe420W-w_GAmOjYJsYTMs1+jqdMdw@mail.gmail.com>
 <CACZ9PQW-RJHvkDzBO1T9YDAPX_6zcEuK3kQAEukybBL0PZEB5g@mail.gmail.com>
 <Z4AQQp_Kes-IRoK3@redhat.com>
 <CACZ9PQV8pfNq46cPcpv7NZ7cx2bEnuhBToa-DEg9oaLHFuGzHg@mail.gmail.com>
 <Z4DhFtc9UgcKQHuh@redhat.com>
 <CACZ9PQUCK+Zrk9rGktVsgNH7BYNTVjEOoVgcYnb=w6YyoqQRSA@mail.gmail.com>
In-Reply-To: <CACZ9PQUCK+Zrk9rGktVsgNH7BYNTVjEOoVgcYnb=w6YyoqQRSA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 Jan 2025 13:34:23 +0400
X-Gm-Features: AbW1kvZPGddhmMVL6Y5qs8772AwSVyAc_7PrWgm6EXTSTOgXC-hpsi4DCNri4IM
Message-ID: <CAJ+F1CKCuj5okrGjLoC9T0zN3gMWCMk+Yt65wwAeo89fi8Tw2w@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, "Bonzini, Paolo" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

Hi

On Fri, Jan 10, 2025 at 7:39=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:
>
> On Fri, Jan 10, 2025 at 9:58=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
> >
> > On Fri, Jan 10, 2025 at 09:43:52AM +0100, Roman Penyaev wrote:
> > > On Thu, Jan 9, 2025 at 7:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 01:56:40PM +0100, Roman Penyaev wrote:
> > > > > Hi,
> > > > >
> > > > > On Tue, Jan 7, 2025 at 3:57=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > > > > <marcandre.lureau@redhat.com> wrote:
> > > > > > Whether we talk about multiplexing front-end or back-end, the i=
ssues
> > > > > > are similar. In general, mixing input will create issues. Teein=
g
> > > > > > output is less problematic, except to handle the buffering...
> > > > >
> > > > > I understand your concerns. What exact issues do you have in mind=
?
> > > > > Are these issues related to the input buffer handling, so technic=
al issues?
> > > > > Or issues with usability?
> > > >
> > > > While the design / impl technically allows for concurrent input to =
be
> > > > sent to the frontend, from multiple backends, in practice I don't t=
hink
> > > > we need to be particularly concerned about it.
> > > >
> > > > I don't see this as being a way for multiple different users to int=
eract
> > > > concurrently. Rather I'd see 1 user of the VM just deciding to swit=
ch
> > > > from one backend to the other on the fly. IOW, although technically
> > > > possible, the user will only be leveraging one at a time to send in=
put.
> > > >
> > > > We very definitely do need all backends to receive output from the =
guest
> > > > concurrently too, as you'd want the historical output context to be
> > > > visible on whatever backend you choose to use at any given point in=
 time.
> > > >
> > > > If a user decides to be crazy and send input from multiple backends
> > > > concurrently, then they get to keep the mess.
> > > >
> > > > > > > Do you think we need to artificially introduce multiplexing l=
ogic to be fully
> > > > > > > compliant with multiplexer naming? It's not hard to do, repea=
ting
> > > > > > > `mux_proc_byte()` from `mux-fe`. In my use-case, I'll still n=
eed to disable
> > > > > > > multiplexing in favor of 'mixing', for example with the 'mixe=
r=3Don' option,
> > > > > > > i.e. '-chardev mux-be,mixer=3Don,...`. Or do you think it sho=
uld be some
> > > > > > > completely different beast, something like mixer chardev?
> > > > > >
> > > > > > I think it would be saner to have the muxer be selectors: only =
work
> > > > > > with one selected be or fe. Otherwise, we can run into various =
issues.
> > > > >
> > > > > In multiplexing (not mixing) for the use-case that I am describin=
g, there is one
> > > > > serious drawback: as soon as you switch the "focus" to another in=
put device
> > > > > (for example from vnc to socket chardev), you will not be able to=
 s]witch back
> > > > > from the same input console - the input now works on another devi=
ce. This looks
> > > > > strange and does not add convenience to the final user. Perhaps, =
for a case
> > > > > other than console, this would be reasonable, but for console inp=
ut -
> > > > > I would like
> > > > > to keep the mixer option: the front-end receives input from both =
back-ends.
> > > >
> > > > Agreed, I think this is desirable. If you did the exclusive access =
mode,
> > > > it'd complicate things as you now need a way to switch between acti=
ve
> > > > backends, while also reducing the usefulness of it.
> > > >
> > > > The main thing I'm not a fan of here is the naming 'mux-fe', as I t=
hink we
> > > > should have something distinct from current 'mux', to reduce confus=
ion
> > > > when we're talking about it.
> > >
> > > The idea to have mux-fe and mux-be (current implementation) was born =
to
> > > distinguish what exactly we multiplex: front-ends or back-ends.
> > >
> > > As Mark-Andre rightly noted, input from back-end devices is not multi=
plexed,
> > > but rather mixed.
> > >
> > > >
> > > > How about 'overlay' or 'replicator' ?
> > >
> > > Overlay for me has a strong association with the filesystem concept. =
This
> > > would work for me if combined back-end inputs function by layering on=
e
> > > on top of another, with potentially higher-priority inputs overriding
> > > lower-priority ones. It implies a hierarchical or layered merging app=
roach.
> > > Not quite well describes a simple mixing strategy.
> > >
> > > Replicator - this can be a good name from front-end device point of v=
iew:
> > > suggests a mechanism for distributing the same input (front-end) to d=
ifferent
> > > destinations (back-ends).
> > >
> > > Two more: what about 'aggregator' or even 'hub' ?
> >
> > Yes, those are ok
> >
> > > Also 'mixer'? So we have '-chardev mux' and '-chardev mix' (try not t=
o get
> > > confused :)
> >
> > AFAIR, users would not use '-chardev mux', but instead set 'mux=3Don' o=
n the
> > real chardev backend.
>
> Yeah, right, I forgot about this peculiarity.
>
> If Mark-Andre or anyone else has no objections, I'll drop all changes
> to the original front-end 'mux' (I tried to make all names and variables =
reflect
> the 'front-end' nature to reduce confusion with the back-end mux) and wil=
l
> resend modified series introducing a new 'hub' chardev. I will keep the
> possibility to send input from several back-ends to a single front-end, a=
s
> in the current implementation.
>

Based on the above discussion, I am okay with this plan.
thanks


--=20
Marc-Andr=C3=A9 Lureau


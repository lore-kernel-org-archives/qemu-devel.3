Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84233E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWH5n-0006Sa-Ad; Fri, 10 Jan 2025 10:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tWH5j-0006S7-Ph
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:38:31 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tWH5h-0006qk-0W
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:38:31 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3011c7b39c7so19042791fa.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736523506; x=1737128306; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcLzuB08WFUXmXKsZVnRTH31fg4LP0XCNrtrZpsL2X4=;
 b=fHvXAphdPe5J86N0nFHxt6rJmDjB2s7rQFo9jQ2sV075Qc9FJCtmPY/NvgWZB8hYPR
 /AJqqMvYbWm8Fz0q9GAhTJvIJ0GmRvejyntC9QO+37gGWU16kzJEQH4nJReg6PlyX3EZ
 eyY2MPgIUdeKjBUhI6JvFlLs+sCRW27+PG11ritYhwbUgtr5ok1psf1Zgrq3FpRFwXpy
 X27MQRkcxjZFC1M6WjpJK5du8SKmL6WdJPKSPbgMfQH2xkE3A7Ak0W1EhoOeD8LQJYFx
 LBtDCtUC3M8ZDtMguvbWBN3BfM5p9ZGV19k+G2Uos7g8cdXQPbiqUhCgc0oBHb3x167X
 p2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736523506; x=1737128306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcLzuB08WFUXmXKsZVnRTH31fg4LP0XCNrtrZpsL2X4=;
 b=cBvpgMVLmiryanaAoa/dQI6OlUMmGvYa+3ajSCq7h8dFkZnTXca81C0/NomFzmB662
 zt0oRm7cEdybZpHTtkko152SB11s/j8K6uKi7IPkV/GoJW92UTs9PWaCTZv+xXQ+qZAq
 r6sjMrOoF7/CsGgDuPO9sZKQqw8Eql6sXjvZSWteQ1mTmacVqDCt32ic9aV0mUk2DOB+
 avM/k0cpuUpYp9rRVv72Tbx/w4qWweF3pPL+6+HtXvndqZBsQekAu7MwkYGhLyAjQzcB
 aqqGu8+8vKzuouXx/ZqyvCoes9AT75raqKeQ82X1k32jHppn/x61Z8kmHY7Ekqd2AK8A
 UzjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+l+oSt7ztaxDsWGMySV9W8fir+7zwXZk5+DkiXDIHpcKkDoSa29uXaZ3cibzYAvdn4m3HD42qmcpQ@nongnu.org
X-Gm-Message-State: AOJu0YwnXxY53kzCOtaFsFmwcfjzepamy/AitlJaJf0kwXbw3/3+Eppe
 Kuo+xtmY/kLK5DV7c4lRkzjwCiJ47PMb3oeX06ESEYyPowD4Vd5cYBUcERTaF5coGP1924AD4RI
 7F/xY8fb3+56MtVZ3y9UfzB2so9/jtW5e
X-Gm-Gg: ASbGnctpc5kmkkMnUvVYMGxEggTBhFiMRtnYTAd6Cnv3mwN8Hxzsi7gpbAh/vm7wLIX
 R7NxaqONIJRf7/QnGe7sRZl4WfTKUBV6dZ3miLuMWCdSSbBqYAWt25vRyEmKAqyT0HGZjIA==
X-Google-Smtp-Source: AGHT+IFXBpyudbxFpuL8jZzbTYODK34TPd6cZk/0wXBDo3eDsy34pQLebsN7Xciti6CBjao/9VzrTX4UvYZ5hRfv2Xs=
X-Received: by 2002:a05:651c:b13:b0:302:3021:9b03 with SMTP id
 38308e7fff4ca-305f4560750mr35845181fa.17.1736523506096; Fri, 10 Jan 2025
 07:38:26 -0800 (PST)
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
In-Reply-To: <Z4DhFtc9UgcKQHuh@redhat.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Fri, 10 Jan 2025 16:38:15 +0100
X-Gm-Features: AbW1kvb4J_dJgXhQ-TIS9SeIU-94dEjM6XGY3IRGVltjQ28nUVm0ZanRXdqjW3g
Message-ID: <CACZ9PQUCK+Zrk9rGktVsgNH7BYNTVjEOoVgcYnb=w6YyoqQRSA@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, "Bonzini, Paolo" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22a.google.com
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

On Fri, Jan 10, 2025 at 9:58=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Jan 10, 2025 at 09:43:52AM +0100, Roman Penyaev wrote:
> > On Thu, Jan 9, 2025 at 7:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > >
> > > On Thu, Jan 09, 2025 at 01:56:40PM +0100, Roman Penyaev wrote:
> > > > Hi,
> > > >
> > > > On Tue, Jan 7, 2025 at 3:57=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > > > <marcandre.lureau@redhat.com> wrote:
> > > > > Whether we talk about multiplexing front-end or back-end, the iss=
ues
> > > > > are similar. In general, mixing input will create issues. Teeing
> > > > > output is less problematic, except to handle the buffering...
> > > >
> > > > I understand your concerns. What exact issues do you have in mind?
> > > > Are these issues related to the input buffer handling, so technical=
 issues?
> > > > Or issues with usability?
> > >
> > > While the design / impl technically allows for concurrent input to be
> > > sent to the frontend, from multiple backends, in practice I don't thi=
nk
> > > we need to be particularly concerned about it.
> > >
> > > I don't see this as being a way for multiple different users to inter=
act
> > > concurrently. Rather I'd see 1 user of the VM just deciding to switch
> > > from one backend to the other on the fly. IOW, although technically
> > > possible, the user will only be leveraging one at a time to send inpu=
t.
> > >
> > > We very definitely do need all backends to receive output from the gu=
est
> > > concurrently too, as you'd want the historical output context to be
> > > visible on whatever backend you choose to use at any given point in t=
ime.
> > >
> > > If a user decides to be crazy and send input from multiple backends
> > > concurrently, then they get to keep the mess.
> > >
> > > > > > Do you think we need to artificially introduce multiplexing log=
ic to be fully
> > > > > > compliant with multiplexer naming? It's not hard to do, repeati=
ng
> > > > > > `mux_proc_byte()` from `mux-fe`. In my use-case, I'll still nee=
d to disable
> > > > > > multiplexing in favor of 'mixing', for example with the 'mixer=
=3Don' option,
> > > > > > i.e. '-chardev mux-be,mixer=3Don,...`. Or do you think it shoul=
d be some
> > > > > > completely different beast, something like mixer chardev?
> > > > >
> > > > > I think it would be saner to have the muxer be selectors: only wo=
rk
> > > > > with one selected be or fe. Otherwise, we can run into various is=
sues.
> > > >
> > > > In multiplexing (not mixing) for the use-case that I am describing,=
 there is one
> > > > serious drawback: as soon as you switch the "focus" to another inpu=
t device
> > > > (for example from vnc to socket chardev), you will not be able to s=
]witch back
> > > > from the same input console - the input now works on another device=
. This looks
> > > > strange and does not add convenience to the final user. Perhaps, fo=
r a case
> > > > other than console, this would be reasonable, but for console input=
 -
> > > > I would like
> > > > to keep the mixer option: the front-end receives input from both ba=
ck-ends.
> > >
> > > Agreed, I think this is desirable. If you did the exclusive access mo=
de,
> > > it'd complicate things as you now need a way to switch between active
> > > backends, while also reducing the usefulness of it.
> > >
> > > The main thing I'm not a fan of here is the naming 'mux-fe', as I thi=
nk we
> > > should have something distinct from current 'mux', to reduce confusio=
n
> > > when we're talking about it.
> >
> > The idea to have mux-fe and mux-be (current implementation) was born to
> > distinguish what exactly we multiplex: front-ends or back-ends.
> >
> > As Mark-Andre rightly noted, input from back-end devices is not multipl=
exed,
> > but rather mixed.
> >
> > >
> > > How about 'overlay' or 'replicator' ?
> >
> > Overlay for me has a strong association with the filesystem concept. Th=
is
> > would work for me if combined back-end inputs function by layering one
> > on top of another, with potentially higher-priority inputs overriding
> > lower-priority ones. It implies a hierarchical or layered merging appro=
ach.
> > Not quite well describes a simple mixing strategy.
> >
> > Replicator - this can be a good name from front-end device point of vie=
w:
> > suggests a mechanism for distributing the same input (front-end) to dif=
ferent
> > destinations (back-ends).
> >
> > Two more: what about 'aggregator' or even 'hub' ?
>
> Yes, those are ok
>
> > Also 'mixer'? So we have '-chardev mux' and '-chardev mix' (try not to =
get
> > confused :)
>
> AFAIR, users would not use '-chardev mux', but instead set 'mux=3Don' on =
the
> real chardev backend.

Yeah, right, I forgot about this peculiarity.

If Mark-Andre or anyone else has no objections, I'll drop all changes
to the original front-end 'mux' (I tried to make all names and variables re=
flect
the 'front-end' nature to reduce confusion with the back-end mux) and will
resend modified series introducing a new 'hub' chardev. I will keep the
possibility to send input from several back-ends to a single front-end, as
in the current implementation.

--
Roman


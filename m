Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC03C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7ee-0008EO-JW; Tue, 24 Jun 2025 13:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uU7eT-0008Cm-Tc
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:41:49 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uU7eP-0001Jy-Go
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:41:44 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7494999de5cso262989b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1750786900; x=1751391700;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aA8ih3bAHdJTnR1IUhY/sl71KMFw0RsevXDXGItG9as=;
 b=GChvEuIsaETS0ftKUieX0jKG7/RNzSIb3nYnPp3auSdgD3+00TBTwjSBFbb4Ja1SAK
 9zMw5RSyOJHLU8iCfg3v2D6NZkz6AqTacQpJ5szDJnKX0rdslT5IwQsbOuFNUlzdT2t0
 ww9xZ5B7mmT31PxNK1BSbq84ZixfEVtUuYxBTwOAAdAVCX/egcdntYGC1Y/ruFWNZqKU
 FpqClmVlBSSrjAOSkgY7jW2xRWd4dCJWscI/WF3C32oRK7s6z7+ZuoWzh80z5bOHPr0i
 yzdxVTDAfjs3IbYHVrNZ5LzoOmPKk9XF0BihbA0tWJKDVAmxZb/nj+jY/AXI6f4Mvarm
 amuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750786900; x=1751391700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aA8ih3bAHdJTnR1IUhY/sl71KMFw0RsevXDXGItG9as=;
 b=fG3yA44HiIyZzl/y9tkSQXQnX9RAewvFQCwxlw71I0g3zX5tYCgGERSxJzXgIqgRDx
 0KBU1lrL1HSvX9vTm+b79TJYRa9kSHIwjU02CI61Ruthdqa4ykqMaa7iZKpDq1R4rcM8
 DH1B7DLSLwnL1YIAPIVXpex6pjfzoklwyZ3tTtISQzDN/Qt5ipU/TnE5ARHQTZHWRQC7
 cYOTxhBVZYljHYeJxQeooSKaFuGOixoeyeh1ywYu4e7DHNpmxcTfjLvqfOvHA9BXtUp9
 b4W5QoM2dq69MxF13wJ59gGqzsEuElUu8WTGaWYu4DSCmk15V7Q6A24cCLCzdNDD6anK
 RnMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURi1Kdk1TDh5N2ZhtFXb6J1ZtRJG4LRl/avRcskLCyd8SZH/X2s9YHMSSjziU7htE+ERrCSf5+R9sW@nongnu.org
X-Gm-Message-State: AOJu0YyLg0fW8KLTPQRfRAvZbvWnQsuNmPZCbwQ/G8OkEs/1Iz4yVJdi
 iX4/lcTI9TknVUarSJAyOO5SJLh8uR8jCOEMxqbYkiShgQWvko3mMMh/21ZLcplYmAMX5ZAIUUI
 9WRgjJ7F5NxylWlpGFHzJK1UvIzW1a8MTRmAN43swMA==
X-Gm-Gg: ASbGnctACLf1OUkNK9kYMJWl3PK0V5zJEnMTaK0X+elA7O2Fjaci56MzgmOzmaD5lJ9
 zruh/LopdPGeW3Ym0Be2EQ+UsMJzcM86aFt8jYZiAAZq4HaeYyFcbjwxN4xxuNknQfWZVVneXTk
 PkjIJFeHyA90P7EOvwfAp/kFZgqdOhDUD8AZyxQHrebvOE
X-Google-Smtp-Source: AGHT+IETZUAi3+DnNozCpNwKVrU7kEZ7rxnsg1FPAYCPKKfCHgDDSdGAkN0X6SLvZl/3tUzbbDgabX0G7H+097B3jIw=
X-Received: by 2002:a17:90b:2590:b0:313:20d2:c99b with SMTP id
 98e67ed59e1d1-3159d647127mr28596543a91.9.1750786899589; Tue, 24 Jun 2025
 10:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
 <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
 <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
 <CANCZdfq6+R=VgyYdcdJCmDBTCgLSxDJuqd8h=ehb5F+v-HPT+g@mail.gmail.com>
 <CAJSP0QWSVhAYBtxKV+WDubmif2m=jxTYd-BK=d7ExZXWUNUYXA@mail.gmail.com>
In-Reply-To: <CAJSP0QWSVhAYBtxKV+WDubmif2m=jxTYd-BK=d7ExZXWUNUYXA@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 24 Jun 2025 11:41:28 -0600
X-Gm-Features: AX0GCFtMWAW2_eHl3v0MdJ-bRUHJR4z_y5BJyj3ZrEBLkIb_5qEoxgjfw_El7mI
Message-ID: <CANCZdfqTKUMLbrT9HEXa-O7pyHqfcMWMmYx7iCq=ZU_ewgCaag@mail.gmail.com>
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 24, 2025 at 11:16=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Tue, Jun 24, 2025 at 12:28=E2=80=AFPM Warner Losh <imp@bsdimp.com> wro=
te:
> >
> > On Tue, Jun 24, 2025 at 10:02=E2=80=AFAM Thomas Huth <thuth@redhat.com>=
 wrote:
> > >
> > > On 22/06/2025 03.46, Warner Losh wrote:
> > > >
> > > >
> > > > On Sat, Jun 21, 2025, 6:01=E2=80=AFPM Stefan Hajnoczi <stefanha@gma=
il.com
> > > > <mailto:stefanha@gmail.com>> wrote:
> > > >
> > > >     On Sat, Jun 21, 2025 at 7:59=E2=80=AFPM Stefan Hajnoczi <stefan=
ha@gmail.com
> > > >     <mailto:stefanha@gmail.com>> wrote:
> > > >
> > > >     (I forgot to CC qemu-devel)
> > > >
> > > >      >
> > > >      > Hi,
> > > >      > This might only be temporary, but the CI is getting HTTP 404=
 Not Found
> > > >      > for the following URL:
> > > >      > https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAG=
ES/14.1/
> > > >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso <https://
> > > >     download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1/
> > > >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso>
> > > >      >
> > > >      > https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848
> > > >     <https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848>
> > > >      >
> > > >      > Stefan
> > > >
> > > >
> > > > Time to bump the version to 14.3.
> > >
> > > Hmm, while we're used to refresh the CI images for the *host* environ=
ments,
> > > it's rather ugly to see images for the *guests* of the functional tes=
ts
> > > disappear. Maybe we should rather remove that test if the URL is not =
stable?
> >
> > Yes. Most of our images have a shelf life of about a year to 18 months.=
 And QEMU
> > should be testing all the 'supported' FreeBSD images, just like for
> > other projects.
> > The question becomes how can we, the FreeBSD Project, remove the fricti=
on that's
> > here now because we timeout / move the older images as they pass out of=
 support.
> >
> > We've also just shifted to a more frequent release cadence, so the
> > releases have gone
> > from living for  18-24 months down to just 12. We just released
> > FreeBSD 14.3, and 14.1
> > is only a year old. So what's the best way of dealing with this? We
> > could have a 14-latest
> > but the md5 would change...
> >
> > So I'm open to making a change, but I need help crafting something
> > that will work, since
> > I'm not clever enough to suggest something here.
>
> A test run should be repeatable. If a test passes on a given qemu.git
> commit then it should continue to pass when run again. Using -latest
> breaks this property, so let's avoid it.
>
> Ideas:
> 1. FreeBSD provides convenient permanent URLs.
> 2. QEMU uses a permanent FreeBSD ISO mirror URL instead. Need to find
> a mirror that is fast and reliable.
> 3. Someone agrees to regularly update the URL in QEMU's test suite so
> that breakage isn't exposed. IMO the least desirable solution because
> an old copy of the test will start failing after 12 months.

So there's two issues at play.

FreeBSD does maintain all our archival releases forever. They never change.
But, we don't have permanent links to them today. We start with one URL and
then migrate to a second one when they transition from supported to unsuppo=
rted.
We do this, in part, to make sure people upgrade. So in effect, this breaka=
ge
means that our notion is "working" in the sense that the FreeBSD project's =
goals
of making people "keep up to date."

This does, I realize, clash with the views that QEMU wants to have some sta=
ble
way to test images over time, even if the upstream's notion of supported or=
 not
changes.

One easy idea might be to 'prestage' the 'legacy' releases when they
are supported
on the 'legacy' server so that tests can be written with the legacy
path so that these
tests always work, now and in the future.

So, this is terrible from a FreeBSD point of view. We'd like it if
qemu always tested
all of our releases, as well as snapshots of the tip of the spear.
There's got to be some
way to have some shared responsibility that we can automate. FreeBSD could =
test
the most recent release of qemu against a bunch of images in our CI
cluster. But we
don't actually have a CI cluster we could put that into (our focus is
just a little different)
today. Ideally, your (3) above would happen as we rotate in new
versions and out old
versions of FreeBSD. But honestly, I'm the person (or one of the
people) that should
be keeping his eye on the ball, but we see how well that has worked
out. So the question
becomes is this a management failure (eg, someone/something needs to prompt=
 me
or others in the FreeBSD project to update it via reminders, release
checklists, etc)?
Or is it something that can fixed by automations somehow? I don't know...

Warner


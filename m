Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937A0C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 21:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUB8u-0002Bx-9E; Tue, 24 Jun 2025 17:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uUB8t-0002Bj-4j; Tue, 24 Jun 2025 17:25:23 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uUB8q-0007d8-VY; Tue, 24 Jun 2025 17:25:22 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae0b2ead33cso54416466b.0; 
 Tue, 24 Jun 2025 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750800319; x=1751405119; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arzMsKmBKr+DDHtgxOcCvkS5vdxEuoyKWO+dCCoShyw=;
 b=ZRd88aMRg8HNSbQFfHdpkXulhRKJFIyzp8W8TC+utDEG4yGFo4yySr8nTix4IMJX/F
 UFbCrFo8xYLUXR6RKb6nURbh7aVT39wtu0qmY/tibksWjrpdlt+GzLBfnnE6tT5ugsd7
 9KAaqew8QiIp59tWKIBVGmH4yQIUyhFV3Vb+nO33ksOgREQ968Jd4GK3XUNHoxxhDp4+
 nr+sDEPQZABmhsjzxwDxX9suW+4Q48pgcvzWPJ+8QcfmvtSN9HeAFt5NeEL16he/JuUA
 +NqyBQ1Nd7RZ4J/phC28gxmAMpbBlfsOo2it87nh7utMu2JwXS3Tiu6fZfquUW4/8PzY
 7CsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750800319; x=1751405119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arzMsKmBKr+DDHtgxOcCvkS5vdxEuoyKWO+dCCoShyw=;
 b=v1BQDaInvh/FbRFnEhNI2sMsenGWVqVufPyTU8pY3gnoeZ1Kq+DQUF0v3baNn3AbMM
 4gkVNu3OKUlNAWsJfDSGzIaUbsvcXK5wOgmfWw6iqgtSJ5g1JEUMmx8egIP6/6wvk08+
 GoQ8JPGeWqOgSEEKoto0skS9GuK6wej+C3TaehvBH+Fj9FsW4lRkocLrXfIc1kTwShcd
 Uy+pYVYWsqzHW+wduphmpl4a+/+QC5Dw4NX2xErku6JE6yOMpkD4KWxWOWSCWB4eKe/f
 fgoAB+XXwBkwIrnlr7xeMnhEiHzl0QZNU2rYbr2T8soe4zLjUF7A5fPf9aA9oBikPYPw
 VLUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQqtMZ1UIDUyfxRzK6YWC+ZHnM+tQASZJXroWDx6JiRoqAwEGgRcmIbk9DD2/2fxidUPPGwDxQww==@nongnu.org,
 AJvYcCWkQ5M7fYAWQt4WmZEhX+zhsuSWD1lr+nkbFVzVfu3fVPYObn7Hazna7qMQHQyjqYNq2nJZ7aav9NOeCw==@nongnu.org
X-Gm-Message-State: AOJu0YxJv5a9e5ZAtSwxfRsm1oOqsrcNl1vbyyqrQqfHXsuqOxHGg1Er
 CPkXCfpjO/l3M4zbnIB2DgK/RDp0PNvT/bmo1Zo1FFtB5YTWgRaNI/TsljFrc5WI4z6k/v0e/zn
 ihiOy9n3El8Hg/t4nRO85nYfUR8fChto=
X-Gm-Gg: ASbGncv2lWGgRdLEpdHNq9nk4x40uFsjzH1w7nQmDfwDuSbzKxOf476i5Jd7snlkpP8
 sIRfTkfrztv7wgKcm6OCp9PYVo4JBtint1x5y5vDYx9216g10T/EUvwd5uJisv0c+prOAVnGDcr
 yRPbCzdu1hECmezhI5V2xVXLg+kKCzsTvYs0nONFw1+3fzMpkYUjtM
X-Google-Smtp-Source: AGHT+IFPvojq7WQpa0dQgzTXe/5wdnsdEwl1geoBBE+e1lGKia994mkSW/DXD5jiBhWD3c8kE+QJwTkcwQMdPyFrkgc=
X-Received: by 2002:a17:906:4c2:b0:ad5:7048:5177 with SMTP id
 a640c23a62f3a-ae0a7442b51mr342490566b.23.1750800318496; Tue, 24 Jun 2025
 14:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
 <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
 <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
 <CANCZdfq6+R=VgyYdcdJCmDBTCgLSxDJuqd8h=ehb5F+v-HPT+g@mail.gmail.com>
 <CAJSP0QWSVhAYBtxKV+WDubmif2m=jxTYd-BK=d7ExZXWUNUYXA@mail.gmail.com>
 <CANCZdfqTKUMLbrT9HEXa-O7pyHqfcMWMmYx7iCq=ZU_ewgCaag@mail.gmail.com>
In-Reply-To: <CANCZdfqTKUMLbrT9HEXa-O7pyHqfcMWMmYx7iCq=ZU_ewgCaag@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 24 Jun 2025 17:25:05 -0400
X-Gm-Features: Ac12FXxxsIz4bRQ-6IbXZL6FIe1mWAFzKo5edNsvzZzUjVQmtJnuXAGScxkiGZ0
Message-ID: <CAJSP0QUKx+eLjF5J2+JGrry_x-jx1p5HStCOTfOgQg+3nOpSeg@mail.gmail.com>
Subject: Re: FreeBSD 14.1 aarch64 iso URL is down
To: Warner Losh <imp@bsdimp.com>
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x630.google.com
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

On Tue, Jun 24, 2025 at 1:41=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:
>
> On Tue, Jun 24, 2025 at 11:16=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
> >
> > On Tue, Jun 24, 2025 at 12:28=E2=80=AFPM Warner Losh <imp@bsdimp.com> w=
rote:
> > >
> > > On Tue, Jun 24, 2025 at 10:02=E2=80=AFAM Thomas Huth <thuth@redhat.co=
m> wrote:
> > > >
> > > > On 22/06/2025 03.46, Warner Losh wrote:
> > > > >
> > > > >
> > > > > On Sat, Jun 21, 2025, 6:01=E2=80=AFPM Stefan Hajnoczi <stefanha@g=
mail.com
> > > > > <mailto:stefanha@gmail.com>> wrote:
> > > > >
> > > > >     On Sat, Jun 21, 2025 at 7:59=E2=80=AFPM Stefan Hajnoczi <stef=
anha@gmail.com
> > > > >     <mailto:stefanha@gmail.com>> wrote:
> > > > >
> > > > >     (I forgot to CC qemu-devel)
> > > > >
> > > > >      >
> > > > >      > Hi,
> > > > >      > This might only be temporary, but the CI is getting HTTP 4=
04 Not Found
> > > > >      > for the following URL:
> > > > >      > https://download.freebsd.org/releases/arm64/aarch64/ISO-IM=
AGES/14.1/
> > > > >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso <https://
> > > > >     download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1/
> > > > >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso>
> > > > >      >
> > > > >      > https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L8=
48
> > > > >     <https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L848=
>
> > > > >      >
> > > > >      > Stefan
> > > > >
> > > > >
> > > > > Time to bump the version to 14.3.
> > > >
> > > > Hmm, while we're used to refresh the CI images for the *host* envir=
onments,
> > > > it's rather ugly to see images for the *guests* of the functional t=
ests
> > > > disappear. Maybe we should rather remove that test if the URL is no=
t stable?
> > >
> > > Yes. Most of our images have a shelf life of about a year to 18 month=
s. And QEMU
> > > should be testing all the 'supported' FreeBSD images, just like for
> > > other projects.
> > > The question becomes how can we, the FreeBSD Project, remove the fric=
tion that's
> > > here now because we timeout / move the older images as they pass out =
of support.
> > >
> > > We've also just shifted to a more frequent release cadence, so the
> > > releases have gone
> > > from living for  18-24 months down to just 12. We just released
> > > FreeBSD 14.3, and 14.1
> > > is only a year old. So what's the best way of dealing with this? We
> > > could have a 14-latest
> > > but the md5 would change...
> > >
> > > So I'm open to making a change, but I need help crafting something
> > > that will work, since
> > > I'm not clever enough to suggest something here.
> >
> > A test run should be repeatable. If a test passes on a given qemu.git
> > commit then it should continue to pass when run again. Using -latest
> > breaks this property, so let's avoid it.
> >
> > Ideas:
> > 1. FreeBSD provides convenient permanent URLs.
> > 2. QEMU uses a permanent FreeBSD ISO mirror URL instead. Need to find
> > a mirror that is fast and reliable.
> > 3. Someone agrees to regularly update the URL in QEMU's test suite so
> > that breakage isn't exposed. IMO the least desirable solution because
> > an old copy of the test will start failing after 12 months.
>
> So there's two issues at play.
>
> FreeBSD does maintain all our archival releases forever. They never chang=
e.
> But, we don't have permanent links to them today. We start with one URL a=
nd
> then migrate to a second one when they transition from supported to unsup=
ported.
> We do this, in part, to make sure people upgrade. So in effect, this brea=
kage
> means that our notion is "working" in the sense that the FreeBSD project'=
s goals
> of making people "keep up to date."
>
> This does, I realize, clash with the views that QEMU wants to have some s=
table
> way to test images over time, even if the upstream's notion of supported =
or not
> changes.
>
> One easy idea might be to 'prestage' the 'legacy' releases when they
> are supported
> on the 'legacy' server so that tests can be written with the legacy
> path so that these
> tests always work, now and in the future.
>
> So, this is terrible from a FreeBSD point of view. We'd like it if
> qemu always tested
> all of our releases, as well as snapshots of the tip of the spear.
> There's got to be some
> way to have some shared responsibility that we can automate. FreeBSD coul=
d test
> the most recent release of qemu against a bunch of images in our CI
> cluster. But we
> don't actually have a CI cluster we could put that into (our focus is
> just a little different)
> today. Ideally, your (3) above would happen as we rotate in new
> versions and out old
> versions of FreeBSD. But honestly, I'm the person (or one of the
> people) that should
> be keeping his eye on the ball, but we see how well that has worked
> out. So the question
> becomes is this a management failure (eg, someone/something needs to prom=
pt me
> or others in the FreeBSD project to update it via reminders, release
> checklists, etc)?
> Or is it something that can fixed by automations somehow? I don't know...

How about doing both:
1. Making the "legacy" URL available immediately so that anything that
needs a permalink can use it (but they will explicitly specify the
word "legacy" in the URL, which is a hint that it's not the latest and
greatest release).
2. You set up a calendar reminder to send a patch updating QEMU's test
suite to the latest FreeBSD release every 12 months. A shell script
could perform the steps of updating the URL, committing the change,
and sending a patch email.

That way FreeBSD's latest release will be tested in a timely manner
and a snapshot of the QEMU test suite will still pass after 12 months.

What do you think?

Stefan


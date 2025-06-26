Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE4BC7EE2A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 02:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUck0-0002CE-L4; Wed, 25 Jun 2025 22:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uUcjy-0002Bq-E0
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 22:53:30 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1uUcjw-0004TI-4G
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 22:53:30 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-311bd8ce7e4so447309a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1750906406; x=1751511206;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pd7gQU02/eUMO/FWcviDgB2rgYxBhvlWrBs9tS43uE=;
 b=uUnT3bPRXYmJpHXYXCJp13M6MP90mcqFo4z+ZSnImNZxZx3zycP11cLRnL1VRZYKBn
 uZxd3OOvoNKsWfWLACGdmHFALAzHq8uN9S2SkIOzmRZTjpc4sxHXpDaOTGZqjSSFFaZf
 2xSTKwhlCgNGEotPqvFLgYDAzZ0P/9CHYm46kFMtj7+Kr6a8OxOZPamQkxgaKuUtL0ut
 ieaR0k9HjZE+97IDffdrg6PW0YM8XQSLmI6KJYE2smSIp2DT5yGORXoxjqqHx6SRbsHp
 5a4cD6m49fsM5rI5zTFTLcckgaOV2+XAQR7952YULghX0T/Bpo0k1P9zA3UmgzkcC6ar
 fCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750906406; x=1751511206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1pd7gQU02/eUMO/FWcviDgB2rgYxBhvlWrBs9tS43uE=;
 b=nsFkxFFkrTfTH6AaLvQje3xuJUZulrvvSwbjipqsbK/GPOCUORjlon2kaEO0Dbv3hc
 gR/bsxDWMMw26oo9TxAaJX7GWMBVm7WZeTN0+Ics9bAb5PW16piia6+YPJgMq8MpNUy0
 +e7ts8wHzmGU6NprPeuGYgm2o+Ft9R1K6jLeuEhSZF6uURieOgBBeeWdVvvyxBk5Blyf
 ZIuJWzqfAFTR3d3B0jbUXyruFg0Z5XDtWonVLiy9Kfoo/G+9+mQCi/Y2zt59G7R6UA0B
 5UZQxcJ4M+GxrYy1RakYYHS6s45GhmrvJgKAbMRd1k2W+LESeHLOBPJ3c6kPKR1dWIN1
 lyxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyn7EKyBqSGbOJq/GXvKZPlERK0ydEcwbGx4+ziUgms2h8YvqY0BNfuWbLH44eyenspvjvNHcSQ8gC@nongnu.org
X-Gm-Message-State: AOJu0YwuE/nmwy4F1glZAX5hgi0o+lyHZtUJHslz7CiVuFz2E1hlJr5h
 EVU2u45Yw7mKdCx4tmW9RXdevKu5yrag2noOa3prKr/w9CtAKRvzaPKSHyH7+MljWk6SCIZbYyK
 ySa8kzNrJfzxabHAxGvXboi8RqBgv4uPNT34oTf28IOc0AsuwROePK3M=
X-Gm-Gg: ASbGncu+UCFHF5wCZTW/GsG84ju8ckZ+NhsgZeQH1XGnUapzBY2GSKKA4dzwWYtAL9z
 7MXZGGGdUCDyK8BLaRzuzqIJWiVnivpxtJOCSmlfoBfw43dVyK/NX7AolrAsdBIU7p6coCSaJ98
 0jes69vEK0gbGhvjEt6b5UimJEfA+WnX67yhd9FcinuKU=
X-Google-Smtp-Source: AGHT+IFEXKOCuS9GTnN6Hry6FNLMjkBJxwJiidhejjEnxBGQ3lPyLn+LDELvvRIvL6/PDJl8YchL3Y6xBTDsIXbzr64=
X-Received: by 2002:a17:90b:5707:b0:313:2206:adf1 with SMTP id
 98e67ed59e1d1-315f26133e5mr7636362a91.4.1750906405579; Wed, 25 Jun 2025
 19:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU=v_jN5oBDBefg0mB=Qv3SvD4ZdJzz2LT-cu5ZL7pK0Q@mail.gmail.com>
 <CAJSP0QXe1L2P24oUrABO1eUzn1JFc=BJWEfakrQ5u3Ek5LkfKg@mail.gmail.com>
 <CANCZdfqfFNAYcF3BEDucyR3YN1PXwyEmzE5LPcJCyshCXwhe6Q@mail.gmail.com>
 <9bac4585-255a-4805-b24d-b3b75d2ca9c3@redhat.com>
 <CANCZdfq6+R=VgyYdcdJCmDBTCgLSxDJuqd8h=ehb5F+v-HPT+g@mail.gmail.com>
 <CAJSP0QWSVhAYBtxKV+WDubmif2m=jxTYd-BK=d7ExZXWUNUYXA@mail.gmail.com>
 <CANCZdfqTKUMLbrT9HEXa-O7pyHqfcMWMmYx7iCq=ZU_ewgCaag@mail.gmail.com>
 <CAJSP0QUKx+eLjF5J2+JGrry_x-jx1p5HStCOTfOgQg+3nOpSeg@mail.gmail.com>
In-Reply-To: <CAJSP0QUKx+eLjF5J2+JGrry_x-jx1p5HStCOTfOgQg+3nOpSeg@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 25 Jun 2025 20:53:14 -0600
X-Gm-Features: Ac12FXxQqZbm_l_n8pCeg-vAdTKaVVPtONuJ5Th_afPUkHcwpix4byxCKyQm6-g
Message-ID: <CANCZdfrxE=GScjtcd87cd-fgRf3uk87T=Ow718cFrB24=iC8iQ@mail.gmail.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1034.google.com
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

On Tue, Jun 24, 2025 at 3:25=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Tue, Jun 24, 2025 at 1:41=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrot=
e:
> >
> > On Tue, Jun 24, 2025 at 11:16=E2=80=AFAM Stefan Hajnoczi <stefanha@gmai=
l.com> wrote:
> > >
> > > On Tue, Jun 24, 2025 at 12:28=E2=80=AFPM Warner Losh <imp@bsdimp.com>=
 wrote:
> > > >
> > > > On Tue, Jun 24, 2025 at 10:02=E2=80=AFAM Thomas Huth <thuth@redhat.=
com> wrote:
> > > > >
> > > > > On 22/06/2025 03.46, Warner Losh wrote:
> > > > > >
> > > > > >
> > > > > > On Sat, Jun 21, 2025, 6:01=E2=80=AFPM Stefan Hajnoczi <stefanha=
@gmail.com
> > > > > > <mailto:stefanha@gmail.com>> wrote:
> > > > > >
> > > > > >     On Sat, Jun 21, 2025 at 7:59=E2=80=AFPM Stefan Hajnoczi <st=
efanha@gmail.com
> > > > > >     <mailto:stefanha@gmail.com>> wrote:
> > > > > >
> > > > > >     (I forgot to CC qemu-devel)
> > > > > >
> > > > > >      >
> > > > > >      > Hi,
> > > > > >      > This might only be temporary, but the CI is getting HTTP=
 404 Not Found
> > > > > >      > for the following URL:
> > > > > >      > https://download.freebsd.org/releases/arm64/aarch64/ISO-=
IMAGES/14.1/
> > > > > >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso <https://
> > > > > >     download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/14.1=
/
> > > > > >     FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso>
> > > > > >      >
> > > > > >      > https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#=
L848
> > > > > >     <https://gitlab.com/qemu-project/qemu/-/jobs/10424901718#L8=
48>
> > > > > >      >
> > > > > >      > Stefan
> > > > > >
> > > > > >
> > > > > > Time to bump the version to 14.3.
> > > > >
> > > > > Hmm, while we're used to refresh the CI images for the *host* env=
ironments,
> > > > > it's rather ugly to see images for the *guests* of the functional=
 tests
> > > > > disappear. Maybe we should rather remove that test if the URL is =
not stable?
> > > >
> > > > Yes. Most of our images have a shelf life of about a year to 18 mon=
ths. And QEMU
> > > > should be testing all the 'supported' FreeBSD images, just like for
> > > > other projects.
> > > > The question becomes how can we, the FreeBSD Project, remove the fr=
iction that's
> > > > here now because we timeout / move the older images as they pass ou=
t of support.
> > > >
> > > > We've also just shifted to a more frequent release cadence, so the
> > > > releases have gone
> > > > from living for  18-24 months down to just 12. We just released
> > > > FreeBSD 14.3, and 14.1
> > > > is only a year old. So what's the best way of dealing with this? We
> > > > could have a 14-latest
> > > > but the md5 would change...
> > > >
> > > > So I'm open to making a change, but I need help crafting something
> > > > that will work, since
> > > > I'm not clever enough to suggest something here.
> > >
> > > A test run should be repeatable. If a test passes on a given qemu.git
> > > commit then it should continue to pass when run again. Using -latest
> > > breaks this property, so let's avoid it.
> > >
> > > Ideas:
> > > 1. FreeBSD provides convenient permanent URLs.
> > > 2. QEMU uses a permanent FreeBSD ISO mirror URL instead. Need to find
> > > a mirror that is fast and reliable.
> > > 3. Someone agrees to regularly update the URL in QEMU's test suite so
> > > that breakage isn't exposed. IMO the least desirable solution because
> > > an old copy of the test will start failing after 12 months.
> >
> > So there's two issues at play.
> >
> > FreeBSD does maintain all our archival releases forever. They never cha=
nge.
> > But, we don't have permanent links to them today. We start with one URL=
 and
> > then migrate to a second one when they transition from supported to uns=
upported.
> > We do this, in part, to make sure people upgrade. So in effect, this br=
eakage
> > means that our notion is "working" in the sense that the FreeBSD projec=
t's goals
> > of making people "keep up to date."
> >
> > This does, I realize, clash with the views that QEMU wants to have some=
 stable
> > way to test images over time, even if the upstream's notion of supporte=
d or not
> > changes.
> >
> > One easy idea might be to 'prestage' the 'legacy' releases when they
> > are supported
> > on the 'legacy' server so that tests can be written with the legacy
> > path so that these
> > tests always work, now and in the future.
> >
> > So, this is terrible from a FreeBSD point of view. We'd like it if
> > qemu always tested
> > all of our releases, as well as snapshots of the tip of the spear.
> > There's got to be some
> > way to have some shared responsibility that we can automate. FreeBSD co=
uld test
> > the most recent release of qemu against a bunch of images in our CI
> > cluster. But we
> > don't actually have a CI cluster we could put that into (our focus is
> > just a little different)
> > today. Ideally, your (3) above would happen as we rotate in new
> > versions and out old
> > versions of FreeBSD. But honestly, I'm the person (or one of the
> > people) that should
> > be keeping his eye on the ball, but we see how well that has worked
> > out. So the question
> > becomes is this a management failure (eg, someone/something needs to pr=
ompt me
> > or others in the FreeBSD project to update it via reminders, release
> > checklists, etc)?
> > Or is it something that can fixed by automations somehow? I don't know.=
..
>
> How about doing both:
> 1. Making the "legacy" URL available immediately so that anything that
> needs a permalink can use it (but they will explicitly specify the
> word "legacy" in the URL, which is a hint that it's not the latest and
> greatest release).
> 2. You set up a calendar reminder to send a patch updating QEMU's test
> suite to the latest FreeBSD release every 12 months. A shell script
> could perform the steps of updating the URL, committing the change,
> and sending a patch email.
>
> That way FreeBSD's latest release will be tested in a timely manner
> and a snapshot of the QEMU test suite will still pass after 12 months.
>
> What do you think?

So, ideally, we could try two URLs.  The "download" path has the full
CDN that we operate behind it. It's the least load on our
infrastructure. However, if that fails, the "archive" path will have
the same images. The "archive" path could be used all the time if the
two URL strategy can't be used. The downloads will be slower, but the
images are already transferred to the archive machine (not cdn) about
a week or so after the release. If the load is going to be super low,
this would be acceptable (and I suspect that it would be since we
cache these images). This would allow older releases to keep working
(once we transition to either the two or one url strategies), and all
the other nice features having the same tests today and 4 years from
now, should we ever need to test that, say for regressions. What's the
anticipated load, measured in downloads per day say, this testing
generates?

As for the second one, I've added reminders as well as a request to
our release team to ask me if I've done it a month after the release.
We'll see how well that works out since the update takes minutes.

Speaking of which, has someone done the update? I'm a bit behind on my
qemu stuff and haven't been paying attention.

Warner


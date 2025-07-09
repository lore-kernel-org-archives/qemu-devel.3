Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C0CC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZhW-00058F-Ib; Wed, 09 Jul 2025 14:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uZZhQ-00053O-Ui
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uZZhN-0000wJ-Li
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752086355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9cA7UrxHRb8dgs+ImmGOLxuh7QQcV2hDCXD94JP/Hs=;
 b=AUPHmYtPpKcjaJfyZZIpxMe1wZ47ZygI/0gE9kagVSQiaU6jYWS/bLaGoioNxAvCdB0zUU
 U3UgO68MXPPKgE+WiqCe8f06983Xb0CouRjJcJH48mH4XK2+DqWvTlKJEua+lj48H9jWhb
 eVX2W72JHVq3ZMbQuDDfqzl8ISgTAag=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-0aQEhaVmMzaWUzkJR7I_Og-1; Wed, 09 Jul 2025 14:39:13 -0400
X-MC-Unique: 0aQEhaVmMzaWUzkJR7I_Og-1
X-Mimecast-MFC-AGG-ID: 0aQEhaVmMzaWUzkJR7I_Og_1752086353
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31220ecc586so189355a91.2
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 11:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752086353; x=1752691153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9cA7UrxHRb8dgs+ImmGOLxuh7QQcV2hDCXD94JP/Hs=;
 b=ElG1KFLelWVfjft+EywzU0BQlFp00du1XNQSSak5yrqzT5PfCBIoIENltcRH6tkb9u
 AsQT9GS7MxUrdisc2+yKgVOpXsF1H159A/pTdz1UUQjwJYTsxDhNw6plxJwIFNh4R25j
 XT/xiKdRxfx2C37k1QS70w6xUyBPkrL6PqqwqSPJ3O06kMXzJkE48ocWoo3gCFOKBdVl
 d0Z7ImRTFlxOx4w2FDv/tf+B9PO4fRxE8hcgySiv9nhCmHoC47OArlXLiC9O1Y+I3eIS
 FcmAAREbrfez/W5lZYgXYA07N2uRZKWlx9hjXy2lGKrh/1NUba5sVv3tHyLGlipxPQQr
 5lLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGMCVC0qtpiPbWGzgWNb7V8llAocUN6UYzNbrSgizvFbfzxCuz7IEM5riDQnaP1X56qCuMFL/aMFeL@nongnu.org
X-Gm-Message-State: AOJu0Yx032RNanLEFvdC3fvFXq9o/EYR7pKdfVMCZLC3ZjsrUo63zscy
 PKlGKm3eGJ0P9ZpyahBh6/NyHeULR5z1n3yK5QA0ZzRdcP4xTdoMvHtYg8o7weH6jq+lMnEbyfV
 SIyDGusBT6hj1FjwKvBAtEakWkfzbgEqJj/lR1IhO57E+IKxYhv6HtAuAkwHkDeErjvMZp9kU30
 Bjo03MEAVN6GAedIJEBPJJ2coQdEnWaaU=
X-Gm-Gg: ASbGncs/cliv2Cp1pxOK41BsqslOjLSFtli1NBWvOWaJmluHG1kd6bjRY8fab+Stozy
 5+kB3TiY+atwGK0WnLLPMDB1K0MiOww9wqr1TMcRCfyoy5QcaoFa+P9Dm1xKrvcgk0EZyRvtzt5
 Un7Dz2sn3LDYkE8fjSZw+lHXLzVF1FbKkrJ6o=
X-Received: by 2002:a17:90b:1b08:b0:315:aa28:9501 with SMTP id
 98e67ed59e1d1-31c2fddc381mr6175187a91.24.1752086352457; 
 Wed, 09 Jul 2025 11:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOTGKBnOGiCSrzlGgKkGId+ePAMdNstg+JGnmXD+ooSJ5h6cmnOthYDdvxlLCaQ/rhopxfKr9PwA2Hwekrp1Q=
X-Received: by 2002:a17:90b:1b08:b0:315:aa28:9501 with SMTP id
 98e67ed59e1d1-31c2fddc381mr6175147a91.24.1752086351929; Wed, 09 Jul 2025
 11:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
 <87qzz9myd0.fsf@pond.sub.org>
 <CABgObfaqauR5SDe67ueAg9-VvJBxM5+LqrYTF3CYjjzzmY8d+w@mail.gmail.com>
 <aGuPI4w505EoScGK@redhat.com>
In-Reply-To: <aGuPI4w505EoScGK@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 9 Jul 2025 14:39:00 -0400
X-Gm-Features: Ac12FXzh1YBWSV0D1XCB36lobxLhndYW9w-A2F8dBN0rWDqxoppYqNkukp5ZhJQ
Message-ID: <CAFn=p-ZoBPsM9UGJiog6684+jrCy61tGauF-osskMACXV9Nfpg@mail.gmail.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 7, 2025 at 5:11=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Jul 02, 2025 at 03:24:09PM -0400, Paolo Bonzini wrote:
> > Il mar 24 giu 2025, 02:45 Markus Armbruster <armbru@redhat.com> ha scri=
tto:
> >
> > > > ... I think I value this a bit higher than Markus, but not really
> > > because of offline builds.  Rather, keeping the "accepted" key lower =
(i.e.
> > > supporting the packaged sphinx on a wide range of distros) makes it e=
asier
> > > to bump the "installed" key when needed, as in this failure to run 5.=
3.0
> > > under Python 3.13.
> > >
> > > Showing my ignorance again...  I don't understand how keeping "accept=
ed"
> > > lower helps.
> > >
> >
> > Because it makes it easier to use distro Python. If distro Python is
> > <accepted, configure's will try to use the "installed" version. If that
> > version in turn is too new for distro Python, you're screwed. So you wa=
nt
> > to be as conservative as needed for accepted, but not more.
> >
> > Regarding fool or pioneer: for sure we're extraordinarily kind towards
> > distros. To some extent we have to do that because of 1) the possible
> > competition of other VMMs that completely ignore distros (e.g. because =
they
> > just use cargo)=E2=80=94packaging is an area where C still has an edge =
and we want
> > to keep that edge 2) we're an infrastructure component that can't just =
tell
> > users to grab a flatpak.
> >
> > The distro policy (mostly conceived by Dan) has served us well, with on=
ly
> > small adjustments needed to have newish version of Meson/Rust(*), and
> > non-prehistoric versions of Python. I don't see a need to change it, si=
nce
> > at this point we have the tools needed to manage the complexity.
>
> Note that much of the commentary about distros versions has been in
> relation to the distro packagers, but that was not my only target
> in writing the distro policy. It was equally aimed at contributors
> using such distros, as well as 3rd party vendors building solutions
> on top of designated distro versions

It's not that I ignore such cases, it's just that distro packagers
have the more difficult to accommodate use case, so I tend to focus in
on that when discussing pros/cons of various policies. If I
accommodate that use case, I accommodate everyone else necessarily, I
believe. It's just a heuristic and not a truth, but so far a useful
one.

>
> You can say contributors should just pick newer containers for their
> build env, or manually download newer deps, or have QEMU build fancy
> scripts to auto-download newer deps. All of those options have a cost
> to them, as compared to using what is already present in the distro.

You are right. However, the mkvenv configuration tool we pioneered has
been largely un-noticed by contributors and appears to "just work" for
the last several years. I believe that cost has been *largely*
amortized by yours truly, and I have spared almost every other
contributor from paying it.

The fancy scripts we have do in fact bend over backward to use
distro-standard packages whenever at all possible, falling back to
vendored packages and only reaching out to the internet when it
*absolutely has to*. I think this has served us perfectly well and
quite nearly invisibly (to everyone else except me, anyway.)

So, more or less: your concern is something I share, but I think I
have it satisfactorily addressed - hence my seeming overfocus on
distro packagers.

>
> In terms of 3rd party vendors, they can have similar roles to a distro
> vendor, but are more likely to package up newer QEMU versions to run
> on pre-existing distros.

Yes. I think they are also usually more willing and able to bend the
rules of the base platform, though. I don't want to break platform
support for things like documentation and tests *needlessly*, but the
frequent changes to Python packaging subsystems do rather often
present a difficulty when it comes to supporting both "EOL" versions
of Python while simultaneously supporting the bleeding edge.

I seek to develop and codify a suitable compromise for these
situations as they continue to arise and, in all likelihood, will not
stop cropping up once per year or so.

As Markus puts it: If a distro (or a third party vendor of a distro)
wants to backport bleeding edge packages to a stable platform, they
must also be willing at times to backport build dependencies. I think
that's a reasonable view, though not license to go wild ignoring older
platforms. In my case, it's only Python packages from over five years
ago that present a difficulty - which is not exactly bleeding edge
stuff.

(Of course, my personal wish is that the Python ecosystem wasn't quite
so aggressive about deprecating things, but I just simply do not
control that, nor the weather...)

>
> A further goal of the support policy was to provide a mechanism to
> eliminate exactly these kind of mail threads. Before we had the policy,
> every single time someone wanted to bump the min version of any dep
> we would have debates over whether it was OK or not, there was always
> someone who wanted the old version of the distro forever.  Defining
> the policy has allowed us to unconditionally bump the min versions of
> our times on a usually reasonable timeframe, without needing to engage
> in debate. We can just point people to our support policy when they
> complained that they really wanted old versions X, Y, & Z.

I agree, that is indeed the nice thing about the policy.

... And it's why I would like to codify our behavior around the
exemptions we make for e.g. requiring newer Python on platforms like
OpenSUSE Leap 15.6, and quite possibly soon, CentOS Stream 9. It will
eliminate the need to have this discussion every time.

>
> Every time we make an exception to the policy, we undermine the benefits
> we obtain from it, taking us back the old world where our min versions
> were an inconsistent & arbitrary set, with little clear understanding
> of when we would change, either by maintainers or users.

I agree again!

I would like to codify something like this for our support policy:

"On otherwise supported build platforms, QEMU *may* require a Python
interpreter that is considered actively maintained, which is usually a
version released within the last five years. When platforms that ship,
by default, an EOL Python interpreter also offer an optional package
for a newer, actively maintained Python interpreter, QEMU may require
this repository package for configuring and building QEMU."

(Simpler language: I am trying to say that Platforms like OpenSUSE
that have an ancient Python by default but also ship newer optional
versions may require one of those newer, optional versions to build
QEMU. On platforms that do NOT offer a newer Python version, I am
suggesting that I will be shit-out-of-luck. I think this is a pretty
mild compromise, all told.)

"On these platforms, unit tests and documentation may possibly require
non-distribution packaged versions of Python dependencies such as
Sphinx in order to run using the more modern Python interpreter."

(Simpler language: Platforms like OpenSUSE do not package Sphinx for
those newer, optional Python interpreters and the user will either
need to allow access to PyPI for configure to load what it needs just
in time, or make preparations to load those packages in advance. This
is the most unfortunate truth of our workaround for OpenSUSE, but I am
not aware of any way to mitigate it. The core build will still work,
but we may indeed lose access to documentation and unit tests from
time to time using only the platform repositories in these situations.
I think this is a graceful degradation, but it is one I fight to avoid
at all costs. It seems to be a necessary evil at times.

OpenSUSE Leap has a Python that is too old to reasonably support, but
they offer an optional modern version that can be loaded instead. In
that event, it is possible the user may need PyPI packages to run
tests and build documentation. To my knowledge, OpenSUSE Leap 15.6 is
currently our only supported platform where this exception need occur,
but it is very possible that a similar exception may arise for CentOS
Stream 9/RHEL9 in the not-so-distant future when Python 3.9 is EOL and
other packages start aggressively dropping support for it.)

I'd like to re-iterate that my motivation here is not to stop
supporting EOL python versions "just because they are EOL", but rather
instead because the tooling and libraries surrounding Python
aggressively drop support for those versions once they become EOL.
That is, 3.9 is not difficult to support until e.g. Python 3.14 comes
out and setuptools, pip, and sphinx begin targeting 3.14 at the
expense of 3.9 and there is an increased burden of hacks and
workarounds required to target 3.9-3.14 inclusive.

As it stands, I have no plans or motivation to discontinue support for
3.9, but based on prior EOL events (3.6, 3.7, and 3.8) there is
inevitably some incompatibility for which dropping support is usually
the easiest path forward. I am just thinking ahead, currently.

Basically, I would like to promise I will "do my best" to support the
"base platforms as-is", but recognize that an exception for Python is
occasionally required, and, to prevent future discussions like this
(essentially yearly, now) would like to codify the precise nature of
that exemption and what degradation we consider an acceptable loss in
those cases. Namely, core build support is easier to maintain using
only distro packages, but unit testing and documentation are
occasionally a bit more difficult.

I would love to adhere to the policy as written as immutable law, but
it has created genuine friction and non-trivial cost on my end in the
past - I only want to convey that "I think it's a good policy!" and "I
have tried to follow it as gospel!" but raise the issue that it's
quite hard to do in some cases and we do need exemptions for things
like OpenSUSE that are communicated clearly.



>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>



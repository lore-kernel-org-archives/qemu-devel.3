Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA42D1CDBD
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 02:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQyuQ-0004iK-31; Wed, 03 Dec 2025 21:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vQyuO-0004ho-KV
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 21:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vQyuM-0006ku-VX
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 21:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764814645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5h26uYhuUJkU0C6aknTbeDlBhztvf9Z6T7MeKO/g10=;
 b=SYJZwaoi6GBq382qYby8WJCwAiH/V6W9z0VlpegAZHX6tBR9+hdV0ndH/LdZa+9JrJA2QP
 zMNxOp3RzI26Y+jw4vt3eM7L1KJQ3qNb5i5N1vLE1apvLgN94B9bgEFuP6KLiQwlXzxphh
 B06+jLMCBgRQys4fPwxawBl3Ma5g2r0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-PDQoHi3nPNaPgsuxORztHw-1; Wed, 03 Dec 2025 21:17:23 -0500
X-MC-Unique: PDQoHi3nPNaPgsuxORztHw-1
X-Mimecast-MFC-AGG-ID: PDQoHi3nPNaPgsuxORztHw_1764814643
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-78933e02c1bso11617017b3.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 18:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764814643; x=1765419443; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5h26uYhuUJkU0C6aknTbeDlBhztvf9Z6T7MeKO/g10=;
 b=Aif4LQzmEvzIxj8ByN0zNSL9yg08+oTDzVJ+tu/q3C7RtXWdFuKFEC0K69uXb3ffdQ
 /nN5Ei50PimmWWjqoa8ZzwKMej7kw3X1CFu2lrEhWBBNO1q4vV21SOCoicSMfuVyedW6
 v95HvRHTaaOortVr0HpJ+W0ASppDwP2Bsg/c5T5fkiaUUFjX92I7Sz3ttGtVc0XJBPWz
 OTMYFMhFdjGaUnO60dSpHa4UPkHlu0QsCX3K1C14qKcMiTVvcFqE9N7PAevpzvxN3l6j
 8c5LmfKVRg/qioE0JYfXiHgAK4Fsn0MeRh8VvE+4RnLPrSKzO/CnNqyg519oFapd+dBp
 H5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764814643; x=1765419443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N5h26uYhuUJkU0C6aknTbeDlBhztvf9Z6T7MeKO/g10=;
 b=XMmGidG5QrJnJ4OSGRo57c0Yx00+loVBsOM89FligaOMuvDXS0eVVZcXf4Dt/FcBWl
 HCMebFi+t1w0HyBObNwdq2idnVlre+E1Q9D0JXGC5Oamu+5Xk9B4moVdYh37RhQYWEVp
 cUeE08+uMu3TWKg6Ps/4GMUUElyMw/rzN87P3i9JAB3lc0dO3XXoZl3EUNqrrGs6/8Tz
 83CTZHuHio1igVUpKPg+lsSmM/oInrYWQsJYa8qHCRYD26afYTJaOtga3+jH32pn6psg
 sMpSqxXB5NyavDEFhktgTGyyCL/GDaAEMEqidfVDn3kKOdsx26IkbvqM/b12SmxDzJcr
 bi8A==
X-Gm-Message-State: AOJu0Yxwp1vH7uVbxJoVM2vfJhBd8aatLX1JQTgWgI/4gfsjs+kXyNYi
 lpJ5puv8xDzeX01FA/U4/afgWWqRoODuLsUMyLCRUN7gi5CdX9hsfnhuQifCTjzYD7qPE93AR9N
 X+02pjsmLn9+vhgIfov1Ior21UwvN+JpyD1zU3SyzfQvg2VS4G6AC90VX1AiTQghEGE3t02srNw
 c/C16eMEea/0sQCrPtfkZTEgQS4OjHygI=
X-Gm-Gg: ASbGncuEDUaRFqlUgQVopj2ZkEnvUomjvWokdqtXaVH1hGTvcOr4VjXZn6Ez3bcuo6H
 ZqTNsKNEPKaaC3zYFRsfOzM/jjaQqEkbtkabet1UJoXsvEnxZPX9EKF1Bgf/7Zh8Y+jIaDDwx6l
 /lep8oAzFipEBB2xIog7xseU/K77xqLJ4TncHV3LSsO2cO8vofFv8Z3EmSSdRgBR0N6jRtJX6Zp
 9kLvPBVj8RS6g7qZUbF8sxYxg==
X-Received: by 2002:a05:690c:550c:10b0:787:d09e:88fa with SMTP id
 00721157ae682-78c1722b31bmr11443047b3.21.1764814643237; 
 Wed, 03 Dec 2025 18:17:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSgMHbZh3mwATU6O1t5wrUFZL2l5K0kms0oUEfazqlQgra6PjahwPnYysp1kaFsy6/lONAvOE5WfaDS5OjTfQ=
X-Received: by 2002:a05:690c:550c:10b0:787:d09e:88fa with SMTP id
 00721157ae682-78c1722b31bmr11442867b3.21.1764814642929; Wed, 03 Dec 2025
 18:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20251125040045.461148-1-jsnow@redhat.com>
 <20251125040045.461148-11-jsnow@redhat.com>
 <fada9d5d-a2f7-4ebb-92ed-3f3a8627316f@redhat.com>
 <CAFn=p-axAi5zewtfkDFxEpNADs-RH3Jbuoj0sGu7oBkgKLrN0A@mail.gmail.com>
In-Reply-To: <CAFn=p-axAi5zewtfkDFxEpNADs-RH3Jbuoj0sGu7oBkgKLrN0A@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 3 Dec 2025 21:17:12 -0500
X-Gm-Features: AWmQ_blQpqNitRbpXC56_7bTVb6lzTeHCwhciaoxvXad97MgvCHpHM2Niuyxj5I
Message-ID: <CAFn=p-bH0m2zLshKEW=Rz8damfucBmT-ZtCN9YLKjsDfnnga9Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] tests: conditionally run "make check-venv"
 during build phase
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Dec 3, 2025 at 8:30=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> On Wed, Nov 26, 2025 at 3:16=E2=80=AFAM Thomas Huth <thuth@redhat.com> wr=
ote:
> >
> > On 25/11/2025 05.00, John Snow wrote:
> > > Some tests need test dependencies, some tests don't. Instead of runni=
ng
> > > "make check" manually, use a CI variable for the template that allows=
 us
> > > to front-load the testing dependencies without needing to incur anoth=
er
> > > re-configure command.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   .gitlab-ci.d/buildtest-template.yml | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/build=
test-template.yml
> > > index d866cb12bb1..cfa123d3a10 100644
> > > --- a/.gitlab-ci.d/buildtest-template.yml
> > > +++ b/.gitlab-ci.d/buildtest-template.yml
> > > @@ -32,6 +32,10 @@
> > >         then
> > >           pyvenv/bin/meson configure . -Dbackend_max_links=3D"$LD_JOB=
S" ;
> > >         fi || exit 1;
> > > +    - if test -n "$SETUP_CHECK_VENV";
> > > +      then
> > > +        make check-venv;
> > > +      fi;
> > I'm not sure, but I think this is likely not quite working as you inten=
ded
> > it. The above code hunk is added to native_build_job_template, i.e. it'=
s
> > executed for the build-* jobs, but in the next patch, you only set the
> > environment variable on the crash-test-* jobs. I don't think that the
> > environment variables propagate backward from a later job to an earlier=
 one.
> >
> > Looking at the output of another build job, e.g. build-system-alpine:
> >
> >   https://gitlab.com/thuth/qemu/-/jobs/12211712932#L2156
> >
> > ... it looks like pygdbmi is now also always installed there, i.e. some=
thing
> > else triggers "check-venv" on all build jobs now, and that's why you we=
re
> > able to drop the "check-venv" in the crash-test-* jobs in the next patc=
h
> > now. No clue what's causing this now, but IMHO it should be fine if we =
just
> > unconditionally do "check-venv" in all build jobs anyway (we also need =
the
> > venv in a bunch of other test jobs anyway), so I'd rather do the "make
> > check-venv" in this patch unconditionally here, and drop the next patch=
 that
> > sets SETUP_CHECK_VENV in the crash-test jobs. WDYT?
> >
> >   Thomas
> >
>
> Yeah, it wasn't working. Oops, and good catch.
>
> I moved "make check-venv" into the build-system-debian/fedora phases
> instead and that works like I expect.
>
> However, the pygdbmi bit is still confusing. Apparently both of the
> new ensuregroup targets get installed with "make check-build", even
> though they aren't used for building anything. I'm trying to sift
> through the make system interplay to figure out why it's part of that
> target...

It's something to do with mtest2make, I think, adding the func test /
precache deps to the "check-build" target in Makefile.mtest - but I'm
not exactly sure where to make the incision here or what consequences
it might have.

I notice that the python test dependencies seem to get added here
regardless of if they are defined for the tests themselves, or for the
precache targets. Odd.

I think I need to consult with Paolo.



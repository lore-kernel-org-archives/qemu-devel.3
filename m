Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0E8D3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3yH-0000tL-5h; Tue, 09 Dec 2025 15:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vT3yE-0000sE-Qt
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vT3yC-0001IE-PC
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765310758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRGZXAeMQr5xJdTS2DMGGaafTDAdNTLf/yvbW0X0cl4=;
 b=NhtPRsvesF6ZH+o+02zgok/MSf5nUnVoFZcvV+rco07RqUhZld7OIZiAS5eK5kj+yLL2Si
 gaOy+m7dHod9Gt5c7oGLObMyisDCRSFCWGp9nzQOHtRod8aEdJ7Am+6IiLT7n8fvMTwLmj
 YzuulkxIS6YX5opk9bKVQZklGHEd2Eg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478--h3_Y9PBO12sr8pvHcz07w-1; Tue, 09 Dec 2025 15:05:55 -0500
X-MC-Unique: -h3_Y9PBO12sr8pvHcz07w-1
X-Mimecast-MFC-AGG-ID: -h3_Y9PBO12sr8pvHcz07w_1765310754
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63e35e48a1aso7542234d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765310754; x=1765915554; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRGZXAeMQr5xJdTS2DMGGaafTDAdNTLf/yvbW0X0cl4=;
 b=clPrdJUQN7GgoeaaCJw0SDmkMOHqoVG7WYk7258rU/sAYWz3r01gv6zmbLm4LNsSPX
 A8nZwC9aDgXUdh938mSTePbkBB7bsvU7oFYvvlNslhbDyKVVweS4mGAGElXD8l4ay/z0
 0uRgiCBgEEMzpUZjqlYygNERtZUvaFYUyQ2VO13Hit2IcgEX+9NINpTt5NYpqA+KWvpx
 jLw1Vw9p9hhn2ZpNdyl7ygPyKRj1OfuULf5MBkmvWqw/0NrBz0d+Na1pn8rMC8u4gbNS
 Hq3+sTGOSISoVEDHh4bum7Y6cWMpsU++ReO6zthaGDhdIu+KjJR4IMwhvdWHsuCQup4l
 vggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310754; x=1765915554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qRGZXAeMQr5xJdTS2DMGGaafTDAdNTLf/yvbW0X0cl4=;
 b=L6hkVn3W0XJNhGgzsDtir/k6SPTbBoPkHVRM7OKUQrcq9i140F2+tZNmaCn0OYDAQd
 kSvH8WuXbS3EMtDXDQa44bQeICVVytWIyK0a39rTH7JyXW+2yeHoIXlsSj6/ISJeDk2j
 6hM2zZfuwWrOPnCHeq3g8XiYb1LR9R6tod5VmipsWXmjQykH7oJROSPCNAeeBxC2EKi5
 g43kowSXkIfN8bKBr/pVWb/yPArDvSIgnp+xKK9qc1Dk9lqfW3yU0FQOldNHIZnQz2vv
 SmwwHJ9W5C9xwpId6SUDzTKJkCWgl4fFOZw5k0OZfYefelidU6/Z6Gx9Vw6iM8cqt+Mr
 k9Yw==
X-Gm-Message-State: AOJu0YzUPmYT/71OsV10DrYCWfxjRdgb5LizmwMsc4AmU2J0cSTut06J
 jjCoy/j9ufge9rsumtfx8U+HKULnRZtZSGoGgI9zfHRnw3FUovZCls41E+1FIIEXC5ltSn14WYe
 BFCUSde1kfKCT9y4d0Kp91ZoE90Nh5JRU/08SEaIKu/LOevSCNvD1aZq7p9XcTjiKTKry1eg1wv
 iQh4jsNDnKdNfXDCAWg3lk5omkkR5l10k=
X-Gm-Gg: AY/fxX5+2HVLUwTOEKHe/ft5/g2A8rTSYr71L0D+bSB1MTngQhGGWxWfHe3j6r8mdLF
 pjWMqNo0hLWkqiR7Fo+zb2EU20WErG4UQmkj4FVjUaEC+YvvSRgEKWb9LQKoG6ljEc8IWW5xpav
 dnz/as1rEph7BzKXmQs9NmbIhCbgRbqFpXnKy6DXysKasYv6cCltz2QcqpRNzWUn4pVPkochLUN
 WqLAIBXHTtVMjIkpiSrRmZ0Jw==
X-Received: by 2002:a05:690e:dcd:b0:644:4986:4558 with SMTP id
 956f58d0204a3-6446eafb6c8mr98360d50.58.1765310754401; 
 Tue, 09 Dec 2025 12:05:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtuAedOQVMUaSED+cfnQPNIPB0OGcOX4qJ9RWRiEx0UVYBsefZ7KOGQ1S+3T7UPF2U1HcaFKRH0oitKn8wVso=
X-Received: by 2002:a05:690e:dcd:b0:644:4986:4558 with SMTP id
 956f58d0204a3-6446eafb6c8mr98345d50.58.1765310753911; Tue, 09 Dec 2025
 12:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20251205060058.1503170-1-jsnow@redhat.com>
 <aThVvP5vwfjVa-ka@redhat.com>
 <CAFn=p-aw1+BDuB1znFBdq_Z+V_qiuO-Vh69UZsS7LZKWZpPTuw@mail.gmail.com>
 <aTh8cnASuApmT9Xx@redhat.com>
In-Reply-To: <aTh8cnASuApmT9Xx@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Dec 2025 15:05:43 -0500
X-Gm-Features: AQt7F2roloGedo33IlA3TgSkOMpkO2Vq5BBJQL5mViGG-XeaFU215hrc4EWtQ84
Message-ID: <CAFn=p-ZXsHpht=Yz=b6rs4As5OMCpGfqCw68C5Z3OwQg3N-7kg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] python: drop qemu.qmp from qemu.git tree
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Dec 9, 2025 at 2:46=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Dec 09, 2025 at 12:23:21PM -0500, John Snow wrote:
> > On Tue, Dec 9, 2025, 12:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com>
> > wrote:
> >
> > > On Fri, Dec 05, 2025 at 01:00:42AM -0500, John Snow wrote:
> > > > Hello!
> > > >
> > > > This series drops the in-tree version of our python-qemu-qmp packag=
e
> > > > ("qemu.qmp") in favor of the version hosted on PyPI, whose reposito=
ry is
> > > > located at https://gitlab.com/qemu-project/python-qemu-qmp.
> > > >
> > > > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2197613036
> > > >        (FreeBSD isn't my fault...!)
> > > >
> > > > The major effects of this patch series are:
> > > >
> > > > 1. qemu.qmp will be installed from PyPI or vendored packages instea=
d of
> > > >    being utilized directly from the qemu.git tree.
> > >
> > > This is not getting installed in enough scenarios IMHO.
> > >
> >
> > It's hard to trigger an install when you don't use the build system,
>
> Well I am using the build system in the same way that I've always
> used it with QEMU. IOW, the benchmark for this is the current way
> things work with the python stuff in tree. The ideal would be to
> match that behaviour with no workflow changes needed, if it is
> practical to achieve that without major downsides.

I know, but if we add out-of-tree things, there's some fundamental
things that change - we need to load that dependency somewhere,
somewhen.

>
> > though... If you bypass make/meson/ninja entirely I'm not really sure w=
hat
> > I can do to bootstrap the test deps.
>
> Can we just do it unconditionally in configure / meson ? These aren't
> big files to download, and we're already dealing other python stuff
> for the build, and git submodules, and rust crates. Pulling in qemu.qmp
> doesn't feel like it is a burden to do by default ?

I definitely could, and I think it would be rather convenient; I only
have some minor concerns about it:

- We don't promise tests on all platforms that we promise builds on.
We have definitely broken this in the past. It might work currently,
but it's a line I want to be aware we are crossing. It may necessitate
python3-wheel and python3-setuptools just to build in this case.
That's probably not an issue on workstations, but it's more bricks on
the wall that are actually not truly needed until you run tests (or
prepare to run tests).

- Configure will get slower by default. I can install the core test
deps by default if people don't mind the additional delay time. It
might be something like 2-4 seconds, depending. If you don't care, I
don't.

- Things like functional tests are still going to require some kind of
environment prep for all the extra stuff they require, I don't think
it's reasonable to preload all of that stuff at configure time, and we
never have. "make check-functional" is sufficient to pull those deps
in, but if there are ways to engage the functional tests manually that
people are using, I think another preparation step is unavoidable
there.

So, in addition to the "pyrun" wrapper I mailed in a separate reply
(which I think is a good idea anyway, regardless of what direction we
go here), I see two main paths that address your issues in differing
amounts:

(1) make configure prepare the test deps *by default*, adding a flag
like --without-test-deps to disable it, or

(2) Continue not prepping the test deps, but allow --with-test-deps to
pre-load them.

More or less the same solution, just with different defaults. I'm
fairly ambivalent, my only personal "habit" here is "I am really
reluctant to touch configure unless there is a strong consensus around
it because I dislike having to make arguments at that level."

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



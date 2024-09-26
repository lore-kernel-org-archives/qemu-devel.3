Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62647CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 14:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stpOs-0000pE-DS; Thu, 26 Sep 2024 10:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stpOo-0000oT-UM
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 10:23:18 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stpOl-0005vw-Cc
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 10:23:18 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c87ab540b3so989102a12.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727360593; x=1727965393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ftCoObNAYrk2K0yJSVIVH9YWTyUMoEBpxFIBghbTipQ=;
 b=vpMkhZzOoHgFHxFKMTmDu9UIqjjbNFOaiNG2WWWJUW8CXzFGVF2vz6Q9tma0lTFN0F
 Y5x3qnmH0I4/0D/A1TVGN3K2PcuN4b3/L/3omdgonGMtsgkg1Scgl9ZFmxdhVfZliw0y
 EICo1BtD5kYG920/H13DYWYU2NNNTa1/Q4pC0fYM9ilNJYt0QJI42AkWaW5k6JwIzgPf
 AxWg9fEG1s02jlr1fFUwrkaVysRDRZLvc9eLUHs27ALo9+OIqBAqIZzaXspRNJ9WcHkD
 koAEZZdad1DclG4sMrYAZbQQrEGKMQuFv/B+25xkIyNIAXEJXD+5m8afMTZ2vlZKmigV
 8mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727360593; x=1727965393;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftCoObNAYrk2K0yJSVIVH9YWTyUMoEBpxFIBghbTipQ=;
 b=XSjOz66YZEh6ZrIv+krlnmsPq4SFOrhBICCchCvVn03QpAQ+J5tbXB/nwyuvYek2DT
 vXVGWtPaE3XGvDkqeR4jksPLnqaAa0MXONcwiNZgMRg7OqOfZHpeSE3z/Cy9rjvBh132
 pudNQ5A7ycxWNB9/T0DXxJNj/HN+2gFK8WDMddn5ys5PXSmGTvjDUVvfDxPlueqatG04
 tYYhil9coUooVeC8F5JcaC5/N3jgjnuQBXDMEQrAwMF0E7G8D0EhXVS1fAevjPEtPkLq
 gKsfEOhlsHa38sbiDQB9Ijh/Y/OvvbwzH6+B3YW6HqUECEjybscHJmD+icHazE+gmEla
 yfCQ==
X-Gm-Message-State: AOJu0YwcGjbV9VwfJZ2tQ5t/zR2DAhd93Bogqq6DNHg0mxZm1ScbPKeP
 M22rrQ/qaEFW4umjCMWD32vy/IFACb5fq95qwPiP5YnBGbSZ5CMeiakIJhKzUVc=
X-Google-Smtp-Source: AGHT+IE18JUQAwnmhfT/LZVwx6xT6tSsu6Bs3RKgri19NV5qz/wS9IMJuJv708Iw3BO1uyNDzboA4w==
X-Received: by 2002:a17:907:36c6:b0:a8a:7884:c491 with SMTP id
 a640c23a62f3a-a93b15f9342mr356573366b.17.1727360593123; 
 Thu, 26 Sep 2024 07:23:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2948fc7sm2934466b.137.2024.09.26.07.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 07:23:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B1175F782;
 Thu, 26 Sep 2024 15:23:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Hanna Reitz
 <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org, Michael Tokarev <mjt@tls.msk.ru>,
 ncopa@alpinelinux.org, bofh@freebsd.org, emulation@freebsd.org,
 virtualization@gentoo.org, dilfridge@gentoo.org, hi@alyssa.is,
 edolstra+nixpkgs@gmail.com, brad@comstyle.com, Daniel P . =?utf-8?Q?Berra?=
 =?utf-8?Q?ng=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>
Subject: Rust BoF and maintainer minutes and planning the roadmap to Rust
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 26 Sep 2024 15:23:11 +0100
Message-ID: <871q16fq9c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi,

We discussed the topic of Rust for QEMU at KVM Forum over the weekend.
Aside from its mention in the QEMU Status update we also held a BoF on
Sunday evening and had a smaller discussion amongst some of the
maintainers on Monday lunchtime. I'm going to try and summarise points
from all of those here. As these groups were self selecting the
intention is for this thread to gather feedback from developers and
packagers who weren't present as well as a chance for others to add to
anything I've missed from my notes.

Road map and statement of intention
-----------------------------------

One of the points that came up in reference to other projects is that
making our intentions clear was important. Are we treating the
introduction of Rust as an experiment to be analysed further down the
road or the start of a "planned" migration to the language?

As QEMU is widely packaged it will be important to have a clear road map
so distros can plan for Rust's inclusion. We also want them to feedback
on technical choices before they are baked in to make the process as
smooth as possible.

The topic of moving the implementation of QEMU to another language has
been discussed amongst developers for a long time. Previous discussions
about migrating to C++ never got very far and the general feeling was
that any migration should be to something that offers tangible benefits
other than being a "slightly better C".

While Go has also been touted as a potential language it seems Rust has
the growing mind share and over the years is seeing growing production
usage. There are already a number of QEMU-adjacent projects such as
virtiofs and rust-vmm which are delivering production grade binaries
that indicate it is a good fit for QEMU itself.

During the various conversations I didn't hear anyone speak against the
proposed migration although some concerns where raised about review and
knowledge gaps.

One output from this discussion should be a clear statement that we are
going forward with this work and the road map. A rough roadmap might
look like:

  - 9.2   --enable-rust is available and developers can build with it.
          rust devices have -x-device or -rust-device CLI flags for
          runtime selection.

  - 10.x  rust devices feature complete and migration compatible, enabled
          by default when rust compiler detected. No CLI selection
          required as legacy portions won't be built. Any partial
          conversions should be behind --enable-prototype-rust configure
          flag.

  - 11.x  distros have enough infrastructure to build on supported
          platforms. Rust becomes a mandatory dependency, old C versions
          of converted code removed from build.

  - xx.y  QEMU becomes a pure native rust program and all C is expunged.
          We may never get to this point.

We should publish the intention and the road map prominently although it
was unclear if a blog post would be the best place vs expanding a
section in the developers manual. Perhaps both make sense with a blog
post for the statement of intent and rough timeline and the developer
manual being expanded with any new rules and standards to follow?

There was some concern about the missing gaps in the support matrix
especially as we support a number of "legacy" TCG backends. While *-user
support is more insulated from the effects of rust conversions due to
its relatively low set of dependencies it will still be a problem if we
convert the core CPU QOM classes to rust.

Some of this is made simpler if we deprecate 32 bit host support?

In theory if LLVM supports the architecture we should be able to
generate binaries with a rust compiler although we may not have all
tools available on that host.

What are candidates for conversion?
-----------------------------------

One area of discussion was what areas of the code base are likely to be
converted. This will give maintainers some idea of what to expect over
the next few cycles as we move ahead.

Manos' initial patch series [1] adds a pl011 serial device and there is
an intention to add a pflash device model to exercise the block layer.
It was suggested other device models such as a network card and watchdog
device would also be worth doing a conversion for to exercise other
common backends.

While device models are a good candidate for early conversion as they
interact with un-trusted guest data there are other areas that might
also benefit from conversion.

Hanna and Stefan were keen to see more use of Rust in the block layer.
Hanna cautioned that it was hard to find a reasonable starting point for
the conversion. Originally she had started with the core sub-system but
it quickly ran into thousands of lines of code which would be hard to
get well reviewed before switching for such a crucial sub-system. Maybe
this is an ordering problem and it would make more sense to start with
individual block drivers first and work up from there.

Alex mentioned softfloat could make a good candidate for conversion as
while the rewrite had made things easier to follow and extend there were
still some C macro tricks employed to get code re-use. It would depend
on if Rust's macro and trait system allows more of the common logic to
be kept together.

The qboot firmware for MicroVM's was also mentioned as a potential
candidate.

Markus asked when will QAPI need rust bindings? As it is the route for
the public API into QEMU it is spread widely across the code base. While
the hand written serialisation code can likely be replaced with Rust's
serde crate it will need to interface to the internal APIs of both rust
and C modules.

Another potential area for conversion was the VirtIO device and
vhost-user code which could expect to re-use a lot of the crates from
the rust-vmm project. However this did bring up the point of maintainer
buy in. Stefan brought up the example of the simpletrace rewrite which
while it may have brought some advantages he felt he was unable to take
as a maintainer as he was not familiar with Rust at that point.

Developer Expertise and Language policies
-----------------------------------------

One issue that came up is how we handle adequately reviewing code when
most of the maintainers are experienced C coders but might not know much
about Rust. While we want to avoid the situation of developers vetoing
conversion there should be communication ahead of any serious work to
avoid rust contributions coming out of the blue. If a maintainer feels
they cannot maintain a bunch of unfamiliar rust code the submitter
should be prepared to find people willing to become a maintainers as
unmaintained drive-by submissions are not useful for the long term
health of the project.

With relative inexperience there was a concern we could inadvertently
introduce technical debt in the code base (C-like Rust vs Rusty rust).
What can we do to mitigate that issue?

Of the ~16 people at the Rust BoF about 11 had written production rust
code and a further 3 where rust curious. Those that attended the BoF
where likely the majority of Rust experts in the community. This implies
what reviewers we have in the community will be thinly spread out.

We make heavy use of GLib throughout the code base and while new Rust
code should use native structures for arrays and the like there are
places when Glib structures are passed across API boundaries. Should we
consider updating APIs as we go or live with a degree of thunking until
we have a better idea where the pain points are?

How will this affect QEMU's declared security boundaries? Do we need to
develop a policy on the use of unsafe{} sections in the code and how we
interact with the wider C code?

One of the promises of Rust is its support for inline unit test
integration although there was a little confusion about how this works
in practice. Are separate test binaries created with just the code under
test or is there a unit testable build of QEMU itself? Does this still
work with mixed C and Rust code?

It was suggested creating a qemu-rust mailing list that all patches that
touch or introduce rust could Cc. This would help those willing to
review rust find patches without having to wade through the qemu-devel
firehose.

Dependencies and Packaging concerns
-----------------------------------

Finally there is the topic of dependencies and how that affects
packaging. One of the benefits of Rust is a large library of crates for
common dependencies. Typically the management of those crates is handled
by the cargo build tool and projects tend to regularly update their
dependencies to stay current with the state of the art. However this
cargo driven approach is at odds with a lot of distros desire to package
a single version of a library and manage its updates during the stable
lifetime of a distro. Some distros do allow exceptions for "vendoring"
dependencies as part of the build but it is generally discouraged.

Another challenge is updating versions of crates can often lead to
additional transitive (indirect) dependencies which then need to be
checked if they are supported by our distro matrix.

The s390-tools maintainer spoke about their experience and how important
it was to engage proactively with distro maintainers (part of the reason
a chunk are Cc'd in this email). When there was common source shared
amongst the tools they published to crates.io to make it easier for
distros to ingest the packages.

The general consensus seemed to be we should be fairly conservative
about adding new crate dependencies while the Rust ecosystem in distros
matures. While we should support rustup/cargo installed tools so
developers can build and test on existing LTS distros we should be
aiming to build QEMU without downloading any additional packages. There
may be some flexibility for build-only dependencies (c.f. our pyenv) but
runtime dependencies should be served by the distro itself.

Final notes
-----------

From my point of view the contributors to all these sessions seemed
pretty positive about the benefits of bringing Rust into the project
while expressing some concerns about managing community expertise during
the migration. While a self selecting group there were no indications we
should be investigating other languages and a general feeling Rust
fitted well with the sorts of tasks QEMU has to manage.

As such I welcome all constructive feedback on this thread as we consult
with community and the many downstream consumers of the QEMU project. By
developing a clear plan of action I hope we can make the proposed
migration a successful one that will benefit the project in the years to
come.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

[1] https://patchew.org/QEMU/20240910-rust-pl011-v10-0-85a89ee33c40@linaro.=
org/


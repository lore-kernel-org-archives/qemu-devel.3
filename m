Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBAECEACD5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveJP-00010x-Qy; Tue, 01 Oct 2024 10:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sveJI-0000zd-Cz
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sveJF-0007Gr-JK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727794621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqjxzWUx2cpB3IcVGrLw8Ms0rQ4rDBn82EkV3iJ+HPc=;
 b=gsRstdTj4nDNQ2+DjZEi7QVoS7gmy4pINTvFyUGbuLPRf2M658fVn7/lmTDxuXF0F/5Tfl
 nD0urTKcedg5LkXQ7umJ4zZHNP812UgvnavswQs7kYeJ4mFa7lnTAPSaOW/aDLdl5fYI29
 K0T0uKccnPkvIj00uvU4PdeEVPTjbWw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-Jmzy_mvlPAauo3erxFRSvQ-1; Tue,
 01 Oct 2024 02:30:32 -0400
X-MC-Unique: Jmzy_mvlPAauo3erxFRSvQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73E621944CEE; Tue,  1 Oct 2024 06:30:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA9C3195419F; Tue,  1 Oct 2024 06:30:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C524221E6A28; Tue,  1 Oct 2024 08:30:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 Berrange <berrange@redhat.com>
Subject: Re: Minimum sphinx version?
In-Reply-To: <CAFn=p-bfv=uRCGzODQDyK4mO1ct-7tG3REfN9pm0o=n2GBGKug@mail.gmail.com>
 (John Snow's message of "Mon, 30 Sep 2024 13:16:42 -0400")
References: <CAFn=p-bfv=uRCGzODQDyK4mO1ct-7tG3REfN9pm0o=n2GBGKug@mail.gmail.com>
Date: Tue, 01 Oct 2024 08:30:27 +0200
Message-ID: <87zfnocp30.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Hi, following up from my KVM forum talk (
> https://www.youtube.com/watch?v=GGbz3WwvqLw ) I wanted to ask about what
> version of Sphinx we could use as a minimum version to help ease the burden
> of modernizing our QMP docs without a long backwards compatibility tail
> (and hundreds of lines of compatibility goop to make it happen.)

Let me add some perspective...

Current docs/sphinx/qapidoc.py is 370 SLOC.  In my experience, it
resists improvement pretty hard, by Sphinx throwing impenetrable stack
traces at the slightest provocation.

Your replacement, which generated *much* superior rendered documentation
is how much, not counting compatibility goop?

The compatibility goop adds how much?

As far as I know, the replacement proper is nice, maintainable code,
while the goop is, well, goop.  Anything breaks there, we run for the
hills and wait for the John Snow cavalry to save the day.

> First, some necessary background on the current state of our Python
> environment and build system:
>
> Paolo and I worked on a Python virtual environment tied to the QEMU build
> system (python/scripts/mkvenv.py) which performs various setup actions
> necessary to instantiate python *stuff* to ensure the build works and is
> always using the correct, configured Python interpreter.
>
> Currently, configure will invoke mkvenv in such a fashion that it prefers
> any local packages you have installed: notably, meson, sphinx, and
> sphinx-rtd-theme if you already have them installed from your distro's
> repository will be used *if they use the version of python you specified to
> configure* (or they match the version that configure guessed if you didn't
> specify one.)
>
> For meson, if you don't meet the minimum version, we will install a version
> for you from our vendored whl files in the repository/tarball.
>
> For sphinx, if you don't meet the minimum version and you have specified
> --enable-docs, we'll install a version from the internet, from PyPI. If you
> did not specify --enable-docs, we disable docs.

Double-checking I understand what you wrote:

* We support Python 3.8 and later.

  3.8 was released in 2019, upstream full support ended in 2021, and
  security fixes are about to end.

  docs/about/build-platforms.rst claims 3.7.  I'll fix it.

* We support Meson 1.1.0 and later.

  If the system doesn't provide, we fall back to bundled Meson 1.2.3.

* We support Sphinx 3.4.3 or later.

  If the system doesn't provide, we pull one from PyPI with
  --enable-docs, else disable docs.  Which version do we pull?

  There's a check for >=1.7.0 in docs/meson.build.  Could that go?

* We support sphinx-rtd-theme.

  Does it come with Sphinx?

> We did it this way because:
> - It's *really fast* if you already have the dependencies you need
> - meson is easy to vendor as a .whl because it's pure python, has *zero*
> dependencies, and it's absolutely required for the build.
> - docs are not *required* to build QEMU
> - We went out of our way to ensure that QEMU could be built in an offline,
> isolated environment on all of our supported platforms.

Loaded question, but I know you can answer this better than I could: how
common is it to support a wide range of versions for Python tools?

> That being said:
>
> The current reality is that Sphinx 3.4.3 is our minimum because RHEL 9
> offers that as the distro package and I have not dared bump our version
> beyond that for fear of disrupting our ability to build docs on RHEL 9
> without internet.
>
> What I'd like to ask is: How adamant are we that we can build docs on older
> platforms? Do we consider it part of our platform promise? Can we bump
> Sphinx to a slightly newer version at the expense of offline doc builds for
> RHEL 9?
>
> To reiterate: interactive developer builds from git or source tarballs
> would continue to work (and be able to build docs just fine) so long as
> --enable-docs is passed, but will require an internet connection to set up
> the python environment with a new-enough sphinx. RHEL 9 rpm builds of
> bleeding edge QEMU may be cut off from building docs in isolated RPMBUILD
> environments unless that repository backports a newer sphinx that can be
> identified as a dependency in the specfile.
>
> How much of a problem do we consider that to be?
>
> CCing the usual suspects.
>
> --js



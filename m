Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45283C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYeZ-0001UR-Ma; Tue, 17 Jun 2025 11:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRYLO-0006Bx-1E
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRVWD-0002Da-K5
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 08:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750163660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VUhaNXnFBIIRi+RHB5CXO/kMQ0DnPMkle+LXwlTRRkw=;
 b=gx3aaJQ0kDSmCy5gISYgWUU3uJUd/hfJy3d5lfnbTWZ90A1tB1fNOwYTjp1pXfPPvKRQJo
 FPcpyWj8DGGh/YddmGYODxQ6ldkFg4VC2IL6TEwh3dgDDcAWCULixZmWQg7DiI3/C/6dBX
 aI2s/jw/OsLfK9etEUxhFb9SI1ZwDkI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-m-cmb4a0OtiP-HpZtUmD2Q-1; Tue,
 17 Jun 2025 08:34:19 -0400
X-MC-Unique: m-cmb4a0OtiP-HpZtUmD2Q-1
X-Mimecast-MFC-AGG-ID: m-cmb4a0OtiP-HpZtUmD2Q_1750163658
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45D101800286; Tue, 17 Jun 2025 12:34:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82FB918002B7; Tue, 17 Jun 2025 12:34:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D4E4A21E6A27; Tue, 17 Jun 2025 14:34:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Daniel =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
In-Reply-To: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 (John Snow's message of "Thu, 5 Jun 2025 15:35:04 -0400")
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
Date: Tue, 17 Jun 2025 14:34:14 +0200
Message-ID: <87sejytum1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Hi, I've long been a little confused about the specifics of our build
> platform guarantee and how it applies to documentation and testing.

"Guarantee" feels too strong.  See below.

> My *current* understanding is that our build platform guarantee applies to
> both unit tests and building documentation, but that this requirement may
> not be as absolute as I imagine it.
>
> The way I have endeavored to manage the Python tooling in our tree so far
> is to preserve, without fail, our ability to perform fully offline builds
> on all supported platforms (provided that the right distro repo packages
> are available).

Relevant part of docs/about/build-platforms.rst:

    Some build dependencies may follow less conservative rules:

    Python runtime
      Distributions with long-term support often provide multiple versions
      of the Python runtime.  While QEMU will initially aim to support the
      distribution's default runtime, it may later increase its minimum version
      to any newer python that is available as an option from the vendor.
      In this case, it will be necessary to use the ``--python`` command line
      option of the ``configure`` script to point QEMU to a supported
      version of the Python runtime.

      As of QEMU |version|, the minimum supported version of Python is 3.9.

    Python build dependencies
      Some of QEMU's build dependencies are written in Python.  Usually these
      are only packaged by distributions for the default Python runtime.
      If QEMU bumps its minimum Python version and a non-default runtime is
      required, it may be necessary to fetch python modules from the Python
      Package Index (PyPI) via ``pip``, in order to build QEMU.

We "initially aim to support the distribution's default runtime".  Once
we don't, fetching from PyPI "may be necessary".  This seems to imply
that such fetching will be necessary when we use the default runtime.

I read "aim" as "make an effort".  This isn't exactly a "guarantee".
It's much, much weaker than "to preserve, without fail, our ability to
perform fully offline builds on all supported platforms".

Keeping fully offline builds working is certainly desirable, but not
regardless of cost.

>                 The Python virtual environment created at configure time
> bends over backwards to use system packages *whenever possible*, and the
> list of exceptions - notably Meson itself - uses vendored packages only in
> very specific cases where it is possible to vendor such packages. Fetching
> packages from PyPI is generally offered only as a convenience for developer
> workstations to, in general, save developers from having to know anything
> about Python. (I think I've done a good job there, to be honest!)

You have: few people have noticed your work.

> (Notably: Meson is pure python and has no dependencies, so it is possible
> to vendor it for offline builds. Tools like Sphinx, however, have many
> dependencies and are not so easily vendored. Thus, we have created a
> tenuous arrangement where we are allowed to use versions of Meson that
> otherwise would break our build platform guarantee.)
>
> Lately, we've had some issues with the wide range of Sphinx versions we
> support presenting various cross-platform difficulties. In particular,
> Akihiko Odaki has sent patches to bump our Sphinx version to at least
> 6.2.1, because platforms with Python 3.13.1 can no longer run Sphinx 3.x at
> all, so having that be our "default install version" causes issues on newer
> platforms.
>
> However, if we take as iron-clad our commitment to the build platform
> promise -- *and* guarantee offline/tarball builds as well -- then Debian 12

I do not think such a commitment exists; see my reading of
build-platforms.rst above.

Even if it did, treating it as iron-clad would be foolish.  We need to
consider cost vs. reward, always.

> (as an example) only offers Sphinx 5.3.0 and not newer unless we allow
> internet access to fetch Sphinx 6.2.1. This is not a problem for developer
> workstations at all, but I am unclear on what problems this may cause for
> tarball releases and downstream offline/isolated/reproducible builds, if
> any.
>
> In this case, we can (probably) "fix" the issue by continuing to allow
> older Sphinx while preferring a newer Sphinx version when it is missing,
> but then we lose the ability to make code cleanups and drop a lot of
> back-compat crud. If memory serves, there were other issues recently where
> older versions of Sphinx behaved differently from newer versions, causing
> intermittent failures that were hard to track down.
>
> What I'd like to know is: what precisely are our options in this scenario?
> Do we consider it acceptable for some platforms to be unable to build docs
> offline? How highly do we value the ability to locally build docs for any
> given release?

I believe the value of fully offline builds goes down as the build
platform ages.

Initially, the distribution will (hopefully!) want to package the then
current version of QEMU.  We want to make that easy.  Enabling fully
offline builds are part of that.

Perhaps the distribution later wants to package / build newer versions
of QEMU fully offline on the now aged release.  I'd expect this to
happen less and less as the distribution ages.  Making it easy is still
desirable, but worth less and less trouble to us.

> Before I throw my weight behind any given option, I just want to know what
> we consider our non-negotiable obligations to be.

In my opinion: none.  We should consider the tradeoffs, and make
pragmatic decisions.



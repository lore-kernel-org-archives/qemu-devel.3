Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93730D3C92C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 16:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTN0c-0001qJ-Vh; Wed, 10 Dec 2025 11:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTN0b-0001pV-06
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:25:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTN0X-0000HY-V6
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765383940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59eVtMWu7QnN9xK4Q37hVQ++bnbFUrz+YvFnEy4aGWo=;
 b=PlpZesmejHNcT9NriqimFjPZNw/uZclI9QmgFndSRsV3/OQXgLXa+7gsGOzqTbkEPdvSAN
 88gCsNfcqiIugRirwp45Zn+bAkExfZtKRii7OkKCR6z9/g6la+8+olZ91xoTUnphQqIWP7
 uvWfrhi/63lrqcnVN6xJoGeE0GrhWkA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-zQXexPLqOKq5O4IW4_m8uw-1; Wed,
 10 Dec 2025 11:25:37 -0500
X-MC-Unique: zQXexPLqOKq5O4IW4_m8uw-1
X-Mimecast-MFC-AGG-ID: zQXexPLqOKq5O4IW4_m8uw_1765383936
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37C7418001D1; Wed, 10 Dec 2025 16:25:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C0C419560AD; Wed, 10 Dec 2025 16:25:30 +0000 (UTC)
Date: Wed, 10 Dec 2025 16:25:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/15] python: drop qemu.qmp from qemu.git tree
Message-ID: <aTme9SHngGqLUXZv@redhat.com>
References: <20251205060058.1503170-1-jsnow@redhat.com>
 <aThVvP5vwfjVa-ka@redhat.com>
 <CAFn=p-aw1+BDuB1znFBdq_Z+V_qiuO-Vh69UZsS7LZKWZpPTuw@mail.gmail.com>
 <aTh8cnASuApmT9Xx@redhat.com>
 <CAFn=p-ZXsHpht=Yz=b6rs4As5OMCpGfqCw68C5Z3OwQg3N-7kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-ZXsHpht=Yz=b6rs4As5OMCpGfqCw68C5Z3OwQg3N-7kg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Dec 09, 2025 at 03:05:43PM -0500, John Snow wrote:
> On Tue, Dec 9, 2025 at 2:46 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Dec 09, 2025 at 12:23:21PM -0500, John Snow wrote:
> > > On Tue, Dec 9, 2025, 12:00 PM Daniel P. Berrangé <berrange@redhat.com>
> > > wrote:
> > >
> > > > On Fri, Dec 05, 2025 at 01:00:42AM -0500, John Snow wrote:
> > > > > Hello!
> > > > >
> > > > > This series drops the in-tree version of our python-qemu-qmp package
> > > > > ("qemu.qmp") in favor of the version hosted on PyPI, whose repository is
> > > > > located at https://gitlab.com/qemu-project/python-qemu-qmp.
> > > > >
> > > > > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2197613036
> > > > >        (FreeBSD isn't my fault...!)
> > > > >
> > > > > The major effects of this patch series are:
> > > > >
> > > > > 1. qemu.qmp will be installed from PyPI or vendored packages instead of
> > > > >    being utilized directly from the qemu.git tree.
> > > >
> > > > This is not getting installed in enough scenarios IMHO.
> > > >
> > >
> > > It's hard to trigger an install when you don't use the build system,
> >
> > Well I am using the build system in the same way that I've always
> > used it with QEMU. IOW, the benchmark for this is the current way
> > things work with the python stuff in tree. The ideal would be to
> > match that behaviour with no workflow changes needed, if it is
> > practical to achieve that without major downsides.
> 
> I know, but if we add out-of-tree things, there's some fundamental
> things that change - we need to load that dependency somewhere,
> somewhen.

Yep, there's a tradeoff, so we have to figure out what's practical
to achieve.

> > > though... If you bypass make/meson/ninja entirely I'm not really sure what
> > > I can do to bootstrap the test deps.
> >
> > Can we just do it unconditionally in configure / meson ? These aren't
> > big files to download, and we're already dealing other python stuff
> > for the build, and git submodules, and rust crates. Pulling in qemu.qmp
> > doesn't feel like it is a burden to do by default ?
> 
> I definitely could, and I think it would be rather convenient; I only
> have some minor concerns about it:
> 
> - We don't promise tests on all platforms that we promise builds on.
> We have definitely broken this in the past. It might work currently,
> but it's a line I want to be aware we are crossing. It may necessitate
> python3-wheel and python3-setuptools just to build in this case.
> That's probably not an issue on workstations, but it's more bricks on
> the wall that are actually not truly needed until you run tests (or
> prepare to run tests).

We should focus on doing what's optimal for platforms where
tests do work, since they're inherantly our most important
platforms. If we proactively fetch python deps for tests that
happen to be broken on a platform already, I'm not too fussed
about that, as long as we don't break things more than they
are already broken.


> - Configure will get slower by default. I can install the core test
> deps by default if people don't mind the additional delay time. It
> might be something like 2-4 seconds, depending. If you don't care, I
> don't.

IIUC,  'pip' will have a local cache of downloads somewhere under
$HOME, so presumably when we install deps, we're only going to have
a download hit the very first time on a machine, or when the needed
versions change ? If we're mostly just copying files out of the
local cache, the time overhead should remain fairly minimal most of
the time.

We have precedent for downloading stuff at configure stage from
the Rust deps and git submodules. Those Rust deps are used for
built code rather than tests, but if we did need some rust deps
only for tests, presumably they'd still be done in configure ?

> - Things like functional tests are still going to require some kind of
> environment prep for all the extra stuff they require, I don't think
> it's reasonable to preload all of that stuff at configure time, and we
> never have. "make check-functional" is sufficient to pull those deps
> in, but if there are ways to engage the functional tests manually that
> people are using, I think another preparation step is unavoidable
> there.

I'd we interested to know how much overhead loading the functional
test deps actually is ?

As a conceptual point beyond this series, I've always tended to expect
that a "configure" script (or equivalent) is responsible for validating
the host OS pre-requisites and/or fetching neede pre-requisites.

Anything after that (whether builds or tests) would then (mostly) work
from stuff that was already acquired by configure.

This lets devs see upfront if there are any problems with their host,
instead of the host problems being hit later where the errors are
mixed in with build logs.

With functional tests we of course don't want to download the assets
upfront as that's GB's of data. I would tend towards suggesting that
any python deps should be fetched upfront at the configure stage
though, unless we see an unacceptable time hit from that.

> So, in addition to the "pyrun" wrapper I mailed in a separate reply
> (which I think is a good idea anyway, regardless of what direction we
> go here), I see two main paths that address your issues in differing
> amounts:

I sent that as a formal proposal here:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg01351.html

For the functional test example illustrated there though, we would
preferrably want the functional test deps fetched upfront.

> (1) make configure prepare the test deps *by default*, adding a flag
> like --without-test-deps to disable it, or

Note, this is not just about test deps. The qemu python code is used by
other misc QEMU developer tools, such as the qmp-shell command. I'm
considering the python deps as more like "QEMU build env pre-requisites",
which is what pushed me towards believeing they should be fetched by
default

> (2) Continue not prepping the test deps, but allow --with-test-deps to
> pre-load them.
> 
> More or less the same solution, just with different defaults. I'm
> fairly ambivalent, my only personal "habit" here is "I am really
> reluctant to touch configure unless there is a strong consensus around
> it because I dislike having to make arguments at that level."


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



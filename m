Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D99C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 06:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUg1E-0004JG-MT; Thu, 26 Jun 2025 02:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUg1C-0004Ix-R7
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUg19-0000Gb-BX
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750919004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsucTw3XSzj7ba2Q5egV/ESlo5emHDv2cj2LQyRh6mg=;
 b=Qh6VqzjcQDZyZXSmeT99LZFw5ZWbvD/zCRamqeebjmdAPTy2FzHa4pUHuDmJAGTdfx+qrg
 E4kVulz9qvmUwvYEsmD7uN58NSNw9zY+64HyI4tgd+PLgfkSeGh1iP7U4IDSsXUaWHl/gp
 5fpbHRsXepSk12fWiYcWoLPcp7Np+40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-oluSlUrdPiSNTaJa1RHsrA-1; Thu,
 26 Jun 2025 02:23:20 -0400
X-MC-Unique: oluSlUrdPiSNTaJa1RHsrA-1
X-Mimecast-MFC-AGG-ID: oluSlUrdPiSNTaJa1RHsrA_1750918999
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B486180029E; Thu, 26 Jun 2025 06:23:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE79918003FC; Thu, 26 Jun 2025 06:23:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3ADC621E6A27; Thu, 26 Jun 2025 08:23:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Daniel =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
In-Reply-To: <CAFn=p-Y1bN+VE+hLCVP-E7HcjOgO1QPQ6PUJWz91mcXEC75j=Q@mail.gmail.com>
 (John Snow's message of "Wed, 25 Jun 2025 16:42:26 -0400")
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
 <87qzz9myd0.fsf@pond.sub.org>
 <CAFn=p-Y1bN+VE+hLCVP-E7HcjOgO1QPQ6PUJWz91mcXEC75j=Q@mail.gmail.com>
Date: Thu, 26 Jun 2025 08:23:16 +0200
Message-ID: <87o6ubyqaz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Jun 24, 2025 at 2:45=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>> > On 6/5/25 21:35, John Snow wrote:
>> >> However, if we take as iron-clad our commitment to the build platform
>> promise -- *and* guarantee offline/tarball builds as well -- then Debian=
 12
>> (as an example) only offers Sphinx 5.3.0 and not newer unless we allow
>> internet access to fetch Sphinx 6.2.1. This is not a problem for develop=
er
>> workstations at all, but I am unclear on what problems this may cause for
>> tarball releases and downstream offline/isolated/ reproducible builds, if
>> any.
>> >> In this case, we can (probably) "fix" the issue by continuing to allow
>> older Sphinx while preferring a newer Sphinx version when it is missing,
>> but then we lose the ability to make code cleanups and drop a lot of
>> back-compat crud. If memory serves, there were other issues recently whe=
re
>> older versions of Sphinx behaved differently from newer versions, causing
>> intermittent failures that were hard to track down.
>> >
>> > The *ideal* solution would be to:
>> >
>> > - accept: 4.3.2 or newer, which is what Ubuntu 22.04 has
>> >
>> > - install: 6.2.1, which is what supports Python 3.13
>>
>> I guess this relates to pythondeps.toml line
>>
>>     sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D "5.3.0", canary=
 =3D
>> "sphinx-build" }
>>
>> I further guess "accepted" means "reject anything older", and
>> "installed" means "preferred version".
>
> Yes. Accepted is what we'll tolerate if it's already installed, "installe=
d"
> is what we will prefer to install.

Thanks!

>> > This lets all supported distros build documentation if they use the
>> > default Python runtime.  It would still require a couple hacks in
>> > compat.py: SOURCE_LOCATION_FIX and nested_parse_with_titles().
>> >
>> > I am not sure however whether to count the latter, for two reasons.
>> > First, it has this:
>> >
>> >     # necessary so that the child nodes get the right source/line set
>> >     content_node.document =3D directive.state.document
>> >
>> > so it is not a pure compatibility hack.  Second, and opposite, current=
ly
>> > none of the uses of nested_parse_with_titles() go through compat.py's
>> > version, therefore it probably can be removed altogether.
>> >
>> > That leaves only SOURCE_LOCATION_FIX.
>> >
>> > As an aside, if the compat.py hacks survive, I would add comments to
>> > document which distros need the hacks.
>> >
>> >> What I'd like to know is: what precisely are our options in this
>> >> scenario? Do we consider it acceptable for some platforms to be unabl=
e to
>> >> build docs offline?
>> >
>> > Certainly for platforms not using the default Python runtime, which
>> > right now is only SLES.  For others...
>> >
>> >> How highly do we value the ability to locally build docs for any given
>> >> release?
>>
>> Purely offline, or not?
>
>
> Purely offline is my concern as it is the requirement I least understand.
>
> For developer builds from the git tree, it doesn't matter: you have PyPI,
> and we have mkvenv.py to set up an environment we are confident will work
> for the purposes of building QEMU and running tests.

Yes, things should work regardless of what we choose for "accepted" and
"installed": if what the host got is "accepted", we use it, else we put
"installed" in the environment.

> For package builds in foreign lands, I grow less certain ...
>
> I know Fedora and RHEL et al build in a strictly isolated environment whe=
re
> we *cannot* pull PyPI packages.

This makes sense.

>                                 For Fedora this is generally less of a
> problem as the distro repository usually has bleeding edge packages for us
> to use. mkvenv.py still runs in RPM builds, it just happens to not need
> anything it doesn't already have, so it succeeds.
>
> For RHEL it's slightly less of a concern as the version of QEMU packaged
> tends to also be old, so the dependencies needed by that version should be
> matched well by what's available in that distro repo.
>
> Where I am less certain is for various "streams" or "modules" or whatever
> for e.g. RHEL that may package newer versions of QEMU but may not have
> other bleeding edge requirements. I am also entirely unfamiliar with the
> release cadence of Debian, Ubuntu, OpenSUSE, etc. I am concerned
> (hypothetically) about cases where Python3.9 is available as an optional
> package, but newer versions of e.g. Sphinx are not.
>
> Is that a problem? Do we care?

If you want to package $software, you get to package its dependencies.
Simple as that.

Widening the version range of our dependencies can make this a bit
easier.

For a distribution's .0, current stable versions get packaged.  We
better make this as easy as we can.  So the version range needs to
include "current stable".  But why wouldn't it include that ever?

Later on, a wider version range can enable "uneven" upgrades: upgrading
to a new QEMU without also upgrading certain dependencies.

How valuable is this for us?  The answer should inform our choice of
version range.  Extending the range further back can be costly, and it
better be worth it.

I'm rather skeptical here.  Feels like a lot of angst about what
distributions might possibly want to do, with precious little evidence
for what they actually do.  Show me distribution package upgrades
(uneven or not) we enabled by keeping our version range wide, and I'll
reconsider.

> In theory, it could affect not just documentation building but unit tests
> as well, depending on where and how we "break" our promise.
>
> I suspect I won't really be able to figure out if it's an issue or not
> until I just "yeehaw!" and do it and see who chirps, but I don't actually
> like operating in such a cavalier manner as a maintainer ...
>
>
>>
>> > ... I think I value this a bit higher than Markus, but not really
>> > because of offline builds.  Rather, keeping the "accepted" key lower (=
i.e.
>> > supporting the packaged sphinx on a wide range of distros) makes it ea=
sier
>> > to bump the "installed" key when needed, as in this failure to run 5.3=
.0
>> > under Python 3.13.
>>
>> Showing my ignorance again...  I don't understand how keeping "accepted"
>> lower helps.
>>
>> > This time there was a version that works on both the oldest and newest
>> > Python that we support, but there may not always be one because sphinx=
 is
>> > all too happy at dropping support for EOL'd versions of Python.
>>
>> Pretty strong hint we shouldn't try to support EOL'd versions of Python
>> either.
>>
>
> This is the problem I keep running into, generally. Our build platform
> promise generally includes platforms that use EOL versions of Python by
> default - which is not a problem in and of itself, however when combined
> with our support for bleeding edge platforms, it becomes difficult to
> support both an EOL'd version of Python *and* the latest releases, as they
> are quite aggressive in dropping support for deprecated features and
> libraries on the newer end.
>
> Add to that the difficulty of keeping the linters and type checkers happy
> across such a wide matrix, and it becomes burdensome to keep things
> humming. In general my impression is that linters, doc systems, type
> systems etc are designed to be run under strictly pinned versions, not
> "whatever the user happens to have available", which is at stark odds with
> how we manage our build, doc and test system environment today.

For development aids like linters and type checkers, graceful
degradation can make sense.  They must work for developers (who we can
expect to use a reasonably current development environment).  I can't
see why they wouldn't work in a similarly current packaging environment
(i.e. offline), and that's nice.  But I'd loathe to invest much in
keeping development aids work in a non-current environment, especially
not offline.

> I do not know what the "solution" to that contrast is, but I do get the "=
we
> are doing something wrong" feeling a lot when managing our stack. I am
> proud it works as well as it does and across such a diverse host of
> platforms, but I get the sense we're one of the few or only projects out
> there doing it like this.

Bob is driving on the highway listening to the radio.  Suddenly the
music stops for an announcement: there's a wrong-way driver on the
highway!  "One?", Bob exclaims, "*hundreds* of them!"

When nobody else does what we try to do, we might be pioneers, or we
might be fools.

> I would be as content as anyone else if Python didn't have such an
> aggressive deprecation window and didn't *frequently* break the packaging
> environment.

We got to play the hand we're dealt.

>> > Paolo
>> >
>> >> Before I throw my weight behind any given option, I just want to know
>> >> what we consider our non-negotiable obligations to be.
>> >>
>> >> Thanks,
>> >> --js



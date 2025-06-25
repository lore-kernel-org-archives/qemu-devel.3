Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD6DC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 20:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUWxC-0000Om-1r; Wed, 25 Jun 2025 16:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUWxA-0000O4-DW
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uUWx8-0003v8-3S
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 16:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750884161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xmct1woZVFoogO0wy9op2klNyI9+Uxxp7xwCy7ut5WE=;
 b=G6leH+j83boIjBcGGNdhktSzemKy16vX7B2KYIOkOmMwyaUF22A4JfR4iFrkO3ZpkujR3t
 Ib0DjQr1Zhz7ToDj9mduX/Dra4X+FWQqwvAqIu05+FTzOekEdrus3ZwM6PwAJe5RI01MNU
 MtuoMde//N59WZTXRfTxHDRelxBpYJk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-6SiEmKGKO-2BuekLwHayvQ-1; Wed, 25 Jun 2025 16:42:39 -0400
X-MC-Unique: 6SiEmKGKO-2BuekLwHayvQ-1
X-Mimecast-MFC-AGG-ID: 6SiEmKGKO-2BuekLwHayvQ_1750884159
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31215090074so335473a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 13:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750884158; x=1751488958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmct1woZVFoogO0wy9op2klNyI9+Uxxp7xwCy7ut5WE=;
 b=rHfCGn5SqUSXWHsRLZbO/xX+cO5ijd1LDYw0p9xLGAEp8vcXZpP9T66g+WnAQ4+ugY
 LznjwdSywjiKw8g9MM1+lwXx17/SFWoQPhOo+Hj/D9Dg1v2d5noJaqAcNGjRs4x44cvs
 yqdLFftLEUoDy4dFfmYcZ1Tm2LfgZT6L8jIxp19VDDKSIHNmrTW8HK2vgp3lHCcs6DaB
 bu6bPlNRFRSHXGwKxHxBbcHp6fYUh04kQz9VyRr0qdiR19P4vicJKRk6Ip14XKf3jGRZ
 YTSESoKuY7adRQq/jSU/jQbPF2pirsfY29cQ2PnwWK7yByTzz7v00Upl2CwM2/ik9OoZ
 Gyyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrjjjgtESFTXjL9AGIhe+C8v0vocCq9KYlqMSduAUhrADjmiUM4jgVLkFX/iw/O3Kw/3SgYevRqlou@nongnu.org
X-Gm-Message-State: AOJu0YzCqHwKWq6+ZAHz6RB85B28ACGoM7HehqIZAU3cfbAFVPbMeWC8
 yhUjSwF0pbI+eICoXbj09Gb9gjf2zjRVqAPncKV9io+a8Hyypy1ZXiKhvYqQbmXX9nPCpA/F8ik
 1AS3P5RsDLRjmoxSpi2Chjm0OFuKVvPKmXCivJ3f9c1q1TRhPt8HAGLyimxq1DH9tjL5vvIlN6T
 KProYtKUPAYxvTsVHSIhOizJVzjpFAL00=
X-Gm-Gg: ASbGncsP1AgQ2rE+IKOIa0BrxyDmpOCpO2g1r1XA6SbSNpkNhk4oQYG73CTqz3ug+xY
 oVhKVqiMSZqG4JEhvFP3S7K0PeFWBxat+Txrtn40yxswSyu5K5/EddqFnNxH9H1Itnf3k9xUFas
 dY
X-Received: by 2002:a17:90b:2550:b0:313:28f1:fc33 with SMTP id
 98e67ed59e1d1-315f2623c4bmr6940333a91.10.1750884158422; 
 Wed, 25 Jun 2025 13:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxnU1OkG07uF5sJZaE1Ex8NPcNA1pdEYC6UEaoWVouekk6OyCVluxySWpG8gOUFzWuElMZWOifi8hhnOkSuYg=
X-Received: by 2002:a17:90b:2550:b0:313:28f1:fc33 with SMTP id
 98e67ed59e1d1-315f2623c4bmr6940306a91.10.1750884157974; Wed, 25 Jun 2025
 13:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
 <87qzz9myd0.fsf@pond.sub.org>
In-Reply-To: <87qzz9myd0.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 25 Jun 2025 16:42:26 -0400
X-Gm-Features: AX0GCFviEy7Z2VB-J1hNzmwfaN5HVnwk_BZcinIDZ-koEkA1nT93GaqszQyv8pA
Message-ID: <CAFn=p-Y1bN+VE+hLCVP-E7HcjOgO1QPQ6PUJWz91mcXEC75j=Q@mail.gmail.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000478d3606386b7c94"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000478d3606386b7c94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 2:45=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On 6/5/25 21:35, John Snow wrote:
> >> However, if we take as iron-clad our commitment to the build platform
> promise -- *and* guarantee offline/tarball builds as well -- then Debian =
12
> (as an example) only offers Sphinx 5.3.0 and not newer unless we allow
> internet access to fetch Sphinx 6.2.1. This is not a problem for develope=
r
> workstations at all, but I am unclear on what problems this may cause for
> tarball releases and downstream offline/isolated/ reproducible builds, if
> any.
> >> In this case, we can (probably) "fix" the issue by continuing to allow
> older Sphinx while preferring a newer Sphinx version when it is missing,
> but then we lose the ability to make code cleanups and drop a lot of
> back-compat crud. If memory serves, there were other issues recently wher=
e
> older versions of Sphinx behaved differently from newer versions, causing
> intermittent failures that were hard to track down.
> >
> > The *ideal* solution would be to:
> >
> > - accept: 4.3.2 or newer, which is what Ubuntu 22.04 has
> >
> > - install: 6.2.1, which is what supports Python 3.13
>
> I guess this relates to pythondeps.toml line
>
>     sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D "5.3.0", canary =
=3D
> "sphinx-build" }
>
> I further guess "accepted" means "reject anything older", and
> "installed" means "preferred version".
>

Yes. Accepted is what we'll tolerate if it's already installed, "installed"
is what we will prefer to install.


>
> > This lets all supported distros build documentation if they use the
> default Python runtime.  It would still require a couple hacks in
> compat.py: SOURCE_LOCATION_FIX and nested_parse_with_titles().
> >
> > I am not sure however whether to count the latter, for two reasons.
> First, it has this:
> >
> >     # necessary so that the child nodes get the right source/line set
> >     content_node.document =3D directive.state.document
> >
> > so it is not a pure compatibility hack.  Second, and opposite, currentl=
y
> none of the uses of nested_parse_with_titles() go through compat.py's
> version, therefore it probably can be removed altogether.
> >
> > That leaves only SOURCE_LOCATION_FIX.
> >
> > As an aside, if the compat.py hacks survive, I would add comments to
> document which distros need the hacks.
> >
> >> What I'd like to know is: what precisely are our options in this
> scenario? Do we consider it acceptable for some platforms to be unable to
> build docs offline?
> >
> > Certainly for platforms not using the default Python runtime, which
> right now is only SLES.  For others...
> >
> >> How highly do we value the ability to locally build docs for any given
> release?
>
> Purely offline, or not?


Purely offline is my concern as it is the requirement I least understand.

For developer builds from the git tree, it doesn't matter: you have PyPI,
and we have mkvenv.py to set up an environment we are confident will work
for the purposes of building QEMU and running tests.

For package builds in foreign lands, I grow less certain ...

I know Fedora and RHEL et al build in a strictly isolated environment where
we *cannot* pull PyPI packages. For Fedora this is generally less of a
problem as the distro repository usually has bleeding edge packages for us
to use. mkvenv.py still runs in RPM builds, it just happens to not need
anything it doesn't already have, so it succeeds.

For RHEL it's slightly less of a concern as the version of QEMU packaged
tends to also be old, so the dependencies needed by that version should be
matched well by what's available in that distro repo.

Where I am less certain is for various "streams" or "modules" or whatever
for e.g. RHEL that may package newer versions of QEMU but may not have
other bleeding edge requirements. I am also entirely unfamiliar with the
release cadence of Debian, Ubuntu, OpenSUSE, etc. I am concerned
(hypothetically) about cases where Python3.9 is available as an optional
package, but newer versions of e.g. Sphinx are not.

Is that a problem? Do we care?

In theory, it could affect not just documentation building but unit tests
as well, depending on where and how we "break" our promise.

I suspect I won't really be able to figure out if it's an issue or not
until I just "yeehaw!" and do it and see who chirps, but I don't actually
like operating in such a cavalier manner as a maintainer ...


>
> > ... I think I value this a bit higher than Markus, but not really
> because of offline builds.  Rather, keeping the "accepted" key lower (i.e=
.
> supporting the packaged sphinx on a wide range of distros) makes it easie=
r
> to bump the "installed" key when needed, as in this failure to run 5.3.0
> under Python 3.13.
>
> Showing my ignorance again...  I don't understand how keeping "accepted"
> lower helps.
>
> > This time there was a version that works on both the oldest and newest
> Python that we support, but there may not always be one because sphinx is
> all too happy at dropping support for EOL'd versions of Python.
>
> Pretty strong hint we shouldn't try to support EOL'd versions of Python
> either.
>

This is the problem I keep running into, generally. Our build platform
promise generally includes platforms that use EOL versions of Python by
default - which is not a problem in and of itself, however when combined
with our support for bleeding edge platforms, it becomes difficult to
support both an EOL'd version of Python *and* the latest releases, as they
are quite aggressive in dropping support for deprecated features and
libraries on the newer end.

Add to that the difficulty of keeping the linters and type checkers happy
across such a wide matrix, and it becomes burdensome to keep things
humming. In general my impression is that linters, doc systems, type
systems etc are designed to be run under strictly pinned versions, not
"whatever the user happens to have available", which is at stark odds with
how we manage our build, doc and test system environment today.

I do not know what the "solution" to that contrast is, but I do get the "we
are doing something wrong" feeling a lot when managing our stack. I am
proud it works as well as it does and across such a diverse host of
platforms, but I get the sense we're one of the few or only projects out
there doing it like this.

I would be as content as anyone else if Python didn't have such an
aggressive deprecation window and didn't *frequently* break the packaging
environment.


>
> > Paolo
> >
> >> Before I throw my weight behind any given option, I just want to know
> what we consider our non-negotiable obligations to be.
> >> Thanks,
> >> --js
>
>

--000000000000478d3606386b7c94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 24,=
 2025 at 2:45=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redh=
at.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; On 6/5/25 21:35, John Snow wrote:<br>
&gt;&gt; However, if we take as iron-clad our commitment to the build platf=
orm promise -- *and* guarantee offline/tarball builds as well -- then Debia=
n 12 (as an example) only offers Sphinx 5.3.0 and not newer unless we allow=
 internet access to fetch Sphinx 6.2.1. This is not a problem for developer=
 workstations at all, but I am unclear on what problems this may cause for =
tarball releases and downstream offline/isolated/ reproducible builds, if a=
ny.<br>
&gt;&gt; In this case, we can (probably) &quot;fix&quot; the issue by conti=
nuing to allow older Sphinx while preferring a newer Sphinx version when it=
 is missing, but then we lose the ability to make code cleanups and drop a =
lot of back-compat crud. If memory serves, there were other issues recently=
 where older versions of Sphinx behaved differently from newer versions, ca=
using intermittent failures that were hard to track down.<br>
&gt;<br>
&gt; The *ideal* solution would be to:<br>
&gt;<br>
&gt; - accept: 4.3.2 or newer, which is what Ubuntu 22.04 has<br>
&gt;<br>
&gt; - install: 6.2.1, which is what supports Python 3.13<br>
<br>
I guess this relates to pythondeps.toml line<br>
<br>
=C2=A0 =C2=A0 sphinx =3D { accepted =3D &quot;&gt;=3D3.4.3&quot;, installed=
 =3D &quot;5.3.0&quot;, canary =3D &quot;sphinx-build&quot; }<br>
<br>
I further guess &quot;accepted&quot; means &quot;reject anything older&quot=
;, and<br>
&quot;installed&quot; means &quot;preferred version&quot;.<br></blockquote>=
<div><br></div><div>Yes. Accepted is what we&#39;ll tolerate if it&#39;s al=
ready installed, &quot;installed&quot; is what we will prefer to install.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; This lets all supported distros build documentation if they use the de=
fault Python runtime.=C2=A0 It would still require a couple hacks in compat=
.py: SOURCE_LOCATION_FIX and nested_parse_with_titles().<br>
&gt;<br>
&gt; I am not sure however whether to count the latter, for two reasons. Fi=
rst, it has this:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0# necessary so that the child nodes get the right s=
ource/line set<br>
&gt;=C2=A0 =C2=A0 =C2=A0content_node.document =3D directive.state.document<=
br>
&gt;<br>
&gt; so it is not a pure compatibility hack.=C2=A0 Second, and opposite, cu=
rrently none of the uses of nested_parse_with_titles() go through compat.py=
&#39;s version, therefore it probably can be removed altogether.<br>
&gt;<br>
&gt; That leaves only SOURCE_LOCATION_FIX.<br>
&gt;<br>
&gt; As an aside, if the compat.py hacks survive, I would add comments to d=
ocument which distros need the hacks.<br>
&gt;<br>
&gt;&gt; What I&#39;d like to know is: what precisely are our options in th=
is scenario? Do we consider it acceptable for some platforms to be unable t=
o build docs offline?<br>
&gt;<br>
&gt; Certainly for platforms not using the default Python runtime, which ri=
ght now is only SLES.=C2=A0 For others...<br>
&gt;<br>
&gt;&gt; How highly do we value the ability to locally build docs for any g=
iven release?<br>
<br>
Purely offline, or not?</blockquote><div><br></div><div>Purely offline is m=
y concern as it is the requirement I least understand.</div><div><br></div>=
<div>For developer builds from the git tree, it doesn&#39;t matter: you hav=
e PyPI, and we have mkvenv.py to set up an environment we are confident wil=
l work for the purposes of building QEMU and running tests.</div><div><br><=
/div><div>For package builds in foreign lands, I grow less certain ...</div=
><div><br></div><div>I know Fedora and RHEL et al build in a strictly isola=
ted environment where we *cannot* pull PyPI packages. For Fedora this is ge=
nerally less of a problem as the distro repository usually has bleeding edg=
e packages for us to use. mkvenv.py still runs in RPM builds, it just happe=
ns to not need anything it doesn&#39;t already have, so it succeeds.</div><=
div><br></div><div>For RHEL it&#39;s slightly less of a concern as the vers=
ion of QEMU packaged tends to also be old, so the dependencies needed by th=
at version should be matched well by what&#39;s available in that distro re=
po.</div><div><br></div><div>Where I am less certain is for various &quot;s=
treams&quot; or &quot;modules&quot; or whatever for e.g. RHEL that may pack=
age newer versions of QEMU but may not have other bleeding edge requirement=
s. I am also entirely unfamiliar with the release cadence of Debian, Ubuntu=
, OpenSUSE, etc. I am concerned (hypothetically) about cases where Python3.=
9 is available as an optional package, but newer versions of e.g. Sphinx ar=
e not.</div><div><br></div><div>Is that a problem? Do we care?</div><div><b=
r></div><div>In theory, it could affect not just documentation building but=
 unit tests as well, depending on where and how we &quot;break&quot; our pr=
omise.</div><div><br></div><div>I suspect I won&#39;t really be able to fig=
ure out if it&#39;s an issue or not until I just &quot;yeehaw!&quot; and do=
 it and see who chirps, but I don&#39;t actually like operating in such a c=
avalier manner as a maintainer ...</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; ... I think I value this a bit higher than Markus, but not really beca=
use of offline builds.=C2=A0 Rather, keeping the &quot;accepted&quot; key l=
ower (i.e. supporting the packaged sphinx on a wide range of distros) makes=
 it easier to bump the &quot;installed&quot; key when needed, as in this fa=
ilure to run 5.3.0 under Python 3.13.<br>
<br>
Showing my ignorance again...=C2=A0 I don&#39;t understand how keeping &quo=
t;accepted&quot;<br>
lower helps.<br>
<br>
&gt; This time there was a version that works on both the oldest and newest=
 Python that we support, but there may not always be one because sphinx is =
all too happy at dropping support for EOL&#39;d versions of Python.<br>
<br>
Pretty strong hint we shouldn&#39;t try to support EOL&#39;d versions of Py=
thon<br>
either.<br></blockquote><div><br></div><div>This is the problem I keep runn=
ing into, generally. Our build platform promise generally includes platform=
s that use EOL versions of Python by default - which is not a problem in an=
d of itself, however when combined with our support for bleeding edge platf=
orms, it becomes difficult to support both an EOL&#39;d version of Python *=
and* the latest releases, as they are quite aggressive in dropping support =
for deprecated features and libraries on the newer end.</div><div><br></div=
><div>Add to that the difficulty of keeping the linters and type checkers h=
appy across such a wide matrix, and it becomes burdensome to keep things hu=
mming. In general my impression is that linters, doc systems, type systems =
etc are designed to be run under strictly pinned versions, not &quot;whatev=
er the user happens to have available&quot;, which is at stark odds with ho=
w we manage our build, doc and test system environment today.</div><div><br=
></div><div>I do not know what the &quot;solution&quot; to that contrast is=
, but I do get the &quot;we are doing something wrong&quot; feeling a lot w=
hen managing our stack. I am proud it works as well as it does and across s=
uch a diverse host of platforms, but I get the sense we&#39;re one of the f=
ew or only projects out there doing it like this.</div><div><br></div><div>=
I would be as content as anyone else if Python didn&#39;t have such an aggr=
essive deprecation window and didn&#39;t *frequently* break the packaging e=
nvironment.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt; Paolo<br>
&gt;<br>
&gt;&gt; Before I throw my weight behind any given option, I just want to k=
now what we consider our non-negotiable obligations to be.<br>
&gt;&gt; Thanks,<br>
&gt;&gt; --js<br>
<br>
</blockquote></div></div>

--000000000000478d3606386b7c94--



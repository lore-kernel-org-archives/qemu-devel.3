Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6957BC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 01:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZJBk-0003Nf-Ho; Tue, 08 Jul 2025 21:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uZJBj-0003NL-2Z
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 21:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uZJBg-0005qz-0E
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 21:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752022884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s2HT2CMwr9ck2Qpu8bk1gSrFWCbdR25Vl5IFG/h5HRc=;
 b=duuxCR5wWFDXO07EM9C6IwmfQdzHlLk3Zxj5gpdQX7pigzZPHo21SXNSIPXf9YzqhmWBeF
 3pNNp8O99Ehz6A39ABoMQr6hLCcYfVaOyE7IdxTY7zbtCUz3OVzPJIKah30kHLVgLoioxL
 d31E2VE8ETsyJd6R0ynsOg3qZcc2LYA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-8iMnrV2QMduowDu0ZMdzcg-1; Tue, 08 Jul 2025 21:01:22 -0400
X-MC-Unique: 8iMnrV2QMduowDu0ZMdzcg-1
X-Mimecast-MFC-AGG-ID: 8iMnrV2QMduowDu0ZMdzcg_1752022881
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3138e671316so345878a91.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 18:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752022881; x=1752627681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2HT2CMwr9ck2Qpu8bk1gSrFWCbdR25Vl5IFG/h5HRc=;
 b=vuUOWYj8RbAxY+uicVQqXucfXWtr/mSCC5XMB6t5I+qgckaYu1UVPuma4pM2EuI8Bg
 y1wwBnhPLPtbE3d881cSzYg5UUpdJ27AiBdHIuFjp/4lgYcGqWsVdskpyti2AjbEfgd2
 oJLLxQrXTXPCNXS9974b3XgZJhyXS1N+Jat/xJzmVLYDffyYmy35W6T4FDSuu8d6JAS4
 qTuANMlG7ynLJVlUoFA1dAc1BUQpJXGyvthHp+5fTl8eSCZCp0lPuaccybcxeJQDg1AA
 rZibE2YOGttqV5OZkrlW3gRSDZrwakRtJomYHCy3QtinQMXmTN23bJjbD8P/+zoKYqum
 l+8w==
X-Gm-Message-State: AOJu0Yw6E14xhN6Hm3x7r4UHutiK39HqsYKGV1zlYYbdzXm+LReB78Mv
 Wcg0I4Ecdl2j6aSqCRP2xiBASgaZsU7WR17uim/E2b7bsNj4QaMcMMOHBA8qM/1Qg/hAOzQIsuO
 kU0J4Vfa3qOonTlOFnx/LjMMypKiV27vwK5cUkfPIa/zKgTM48J0/boikPa6Bqzh1fciTVTm99p
 lL7GPuhK7SiYbCqSPD8nPmnML9mg3pEyo=
X-Gm-Gg: ASbGncsReNE2FOPEXyjalceue8mLxx0yCrB2Ey9QgU3yk5CQArnrRVb40ljyc8dVQY8
 /HMUxjZf0A146GSe/iiKaAbd6sJECu4fKSlYx+D4l3JKCiI5KGPHJn9nUfHPCGUmqLhpz7gZdl8
 7X3+Y/RpCOZd0IfSi2cxBOQ+W2r0YEcpND4dk=
X-Received: by 2002:a17:90b:2b8e:b0:30e:9b31:9495 with SMTP id
 98e67ed59e1d1-31c2274c9d3mr6190588a91.9.1752022881163; 
 Tue, 08 Jul 2025 18:01:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyGG6TESCZaxEg2YPJOopO7Em3nm2Gm+U4Crcs919ObSDTc4c/xsBREJfBXIkQHfn137x/qKwC/rub803Lg1o=
X-Received: by 2002:a17:90b:2b8e:b0:30e:9b31:9495 with SMTP id
 98e67ed59e1d1-31c2274c9d3mr6190549a91.9.1752022880667; Tue, 08 Jul 2025
 18:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-bp_hFTu7yDGuQa-Eoctnpb_dd4_fgfhrC3umpX1EuvCA@mail.gmail.com>
 <d1c33e1e-8b26-4a75-8b1d-2ec6c54d72d0@redhat.com>
In-Reply-To: <d1c33e1e-8b26-4a75-8b1d-2ec6c54d72d0@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 8 Jul 2025 21:01:07 -0400
X-Gm-Features: Ac12FXzYC9xMOQzCo26ZdRez-QY2bDTpPXtxIekedQXTZBGDXRRSdEFicC58UL4
Message-ID: <CAFn=p-bee25L9Zqyv=LjpCw4WMHqCUAcMaBg0Lbu3gUU6cuakQ@mail.gmail.com>
Subject: Re: Python ecosystem versions overview
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000070ece10639749d0a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000070ece10639749d0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025, 7:23=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> wr=
ote:

> On 7/8/25 22:36, John Snow wrote:
> > centos_stream_9     3.9.23   21.3.1  53.0.0      3.4.3   BaseOS, CRB
>
> Ok, so the lowest version of Sphinx (3.4.3) is currently used for CentOS
> Stream 9.  It's supported for roughly 2 more years, until 12.0.
>

Yep. I am thinking however that because 3.9 is soon to be EOL this autumn,
it may become reasonable to start requiring newer Python interpreters for
this platform as well. They *are* available.

I won't do it without a reason, but I think this may be a reasonable policy
moving forward- If your platform is otherwise supported by our policy but
ships a version of Python from more than five years ago (aka is EOL
upstream), you *may* be required to install a newer, optional version (if
and only if one is reasonably available from official distro repositories.)

In general, this should have little to no impact except that isolated,
offline builds (a la rpmbuild) may fail to produce documentation unless
special considerations are taken for the build environment (namely, sphinx
needs to be loaded for the newer interpreter).

I think this is a reasonable compromise. If distributions want to package
bleeding edge QEMU with five-years-old dependencies, they can expect to
face *some* hurdles, and figuring out how to get sphinx as a builddep to
build an optional component is not entirely unreasonable.

TLDR - I pledge to support any platform covered by our promise for
building, but testing and documentation *requires* a non-EOL interpreter.
This should have little to no effect for developers or users building from
source or git, but has minor drawbacks for downstream maintainers of
enterprise distributions that may attempt to backport bleeding edge QEMU
versions.


> > opensuse_leap_15_6  3.6.15   20.0.2  44.1.1      2.3.1   updates/sle,
>
> We use the 3.11 runtime in the dockerfile, see
> tests/lcitool/mappings.yml.  That is a bare minimum install, so
> configure won't use the distro sphinx and instead use 5.3.0 from
> pythondeps.toml.
>

Yep, this tool was made to show the platform defaults only for now. Maybe
I'll add a "show first party backports" flag in the future, if anyone more
than just my own personal self would find that useful. (Speak up if so.)


> > main/oss
> > pkgsrc_current      3.12.11  25.1.1  80.9.0      8.2.3   ---
> > ubuntu_22_04        3.10.12  22.0.2  59.6.0      4.3.2
> > jammy-updates/main, jammy/universe, jammy/main
>
> This is the second oldest version of Sphinx.
>

With us until 26.04, in about 0.75 years. This seems like a reasonable new
minimum if we wanted to increase it, though that does artificially drop
support for RHEL9/CentOS stream building documentation from source under
rpmbuild.

(FWIW I probably can continue to support sphinx 3.x for a little while, the
code is gross but it does appear functional. The only thing we *need* to do
is bump the preferred version, I think. This support generally comes at the
expense of type checking support for the docs code, as it's so gross I
couldn't get it to work from 3.x to 8.x inclusive.)


> > ubuntu_24_04        3.12.3   24.0    68.1.2      7.2.6   noble/main,
> > noble/universe
> > ubuntu_24_10        3.12.7   24.2    74.1.2      7.4.7
> > oracular/main, oracular/universe
> > ubuntu_25_04        3.13.3   25.0    75.8.0      8.1.3   plucky/main,
> > plucky/universe
> >
> > (3) CentOS stream does not ship "sphinx" except via "CRB", which I
> > think may not be enabled by default.
>
> It's not, but it's intended to be enabled when developing against the
> Red Hat packages.  We enable it in the dockerfile:
>
>      dnf config-manager --set-enabled -y crb
>

Sounds good! I was just taking care to be diligent about which repositories
this tool compiled info from in order to give a very honest snapshot. I
made careful note of any "weird" ones that may or may not be considered
platform standards.


> > (4) OpenSUSE Leap 15.6 is egregiously old. 16.x is promised for later
> > this year, but we are past the promised "five year" support window for
> > this platform in some sense -- 15.0 released in 2018 -- so I believe
> > it can actually be ignored.
>
> As far as Python is concerned, OpenSUSE 15 doesn't cause trouble anyway,
> because we do not use the 3.6 interpreter and its very old distro package=
s.
>
> So that's two reasons to ignore OpenSUSE.
>

Yep, just formally stating that not only do we have a workaround, but we
may have run afoul of the five year window regardless.

Hopefully a non-issue once 16 ships.

(I am of course glad it works anyway!)

Just interesting to note that OpenSUSE would already have the same problems
CentOS 9 might in the near future: optional Python upgrade is available,
but distro-packaged Sphinx upgrade may not be.


> > (5) Ubuntu only ships pip in "universe", but also ships some Python
> > 3.x interpreter updates to that repository as well. I have filtered
> > this list to only use Universe for pip packages, leaving Python the
> > base version that ships with the platform in x/main or x-updates/main.
>
> Yes, fair enough.  Ubuntu 22.04 came out more recently than CentOS
> Stream 9, after all, and its base distribution is more up to date than
> CS9 with respect to the Python ecosystem.  Rust is where Ubuntu (both
> 22.04 and 24.04) is considerably less updated.
>
> Paolo
>
> > (6) "ports" collections (FreeBSD, NetBSD, OpenBSD/pkgsrc_current,
> > Homebrew and MacPorts) do not necessarily have the concept of a
> > platform default Python interpreter version, but other packages in the
> > collection can be used as a heuristic to determine which one is best
> > suited.
> >
> > For instance, FreeBSD and NetBSD only ship pip et al for a single
> > interpreter version.
> > OpenBSD has a symbolic "python3" package that installs a specific
> > version. Homebrew has a "python3" alias that chooses a specific Python
> > interpreter version. MacPorts similarly has a symbolic "py-setuptools"
> > package that will choose a specific interpreter version.
> >
> > These are used as heuristics to determine a "de-facto" default for the
> > ports collection platforms.
> >
> > -
> >
> > That's all for now. I will publish the script to the list later,
> > though I have no intention of cleaning it up for inclusion in our
> > tree. When I send it, bookmark the email if you'd like to try using
> > this for other purposes or running it for yourself. Maybe I will throw
> > it up on my personal GitLab in case it is useful to other subsystem
> > maintainers in the future. The filtering code is a little messy, but
> > it got the job done and should be reasonably straightforward to make
> > sense of at a glance. It uses only the 'requests' library as a third
> > party dependency.
> >
> > Your humble Python sin-eater,
> > --js
> >
> >
> >
>
>

--00000000000070ece10639749d0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Jul 8, 2025, 7:23=E2=80=AFPM Paolo Bonzini &lt=
;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer=
">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">On 7/8/25 22:36, John Snow wrote:<br>
&gt; centos_stream_9=C2=A0 =C2=A0 =C2=A03.9.23=C2=A0 =C2=A021.3.1=C2=A0 53.=
0.0=C2=A0 =C2=A0 =C2=A0 3.4.3=C2=A0 =C2=A0BaseOS, CRB<br>
<br>
Ok, so the lowest version of Sphinx (3.4.3) is currently used for CentOS <b=
r>
Stream 9.=C2=A0 It&#39;s supported for roughly 2 more years, until 12.0.<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yep=
. I am thinking however that because 3.9 is soon to be EOL this autumn, it =
may become reasonable to start requiring newer Python interpreters for this=
 platform as well. They *are* available.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">I won&#39;t do it without a reason, but I think this may b=
e a reasonable policy moving forward- If your platform is otherwise support=
ed by our policy but ships a version of Python from more than five years ag=
o (aka is EOL upstream), you *may* be required to install a newer, optional=
 version (if and only if one is reasonably available from official distro r=
epositories.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">In general=
, this should have little to no impact except that isolated, offline builds=
 (a la rpmbuild) may fail to produce documentation unless special considera=
tions are taken for the build environment (namely, sphinx needs to be loade=
d for the newer interpreter).</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">I think this is a reasonable compromise. If distributions want to pac=
kage bleeding edge QEMU with five-years-old dependencies, they can expect t=
o face *some* hurdles, and figuring out how to get sphinx as a builddep to =
build an optional component is not entirely unreasonable.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">TLDR - I pledge to support any platform c=
overed by our promise for building, but testing and documentation *requires=
* a non-EOL interpreter. This should have little to no effect for developer=
s or users building from source or git, but has minor drawbacks for downstr=
eam maintainers of enterprise distributions that may attempt to backport bl=
eeding edge QEMU versions.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; opensuse_leap_15_6=C2=A0 3.6.15=C2=A0 =C2=A020.0.2=C2=A0 44.1.1=C2=A0 =
=C2=A0 =C2=A0 2.3.1=C2=A0 =C2=A0updates/sle,<br>
<br>
We use the 3.11 runtime in the dockerfile, see <br>
tests/lcitool/mappings.yml.=C2=A0 That is a bare minimum install, so <br>
configure won&#39;t use the distro sphinx and instead use 5.3.0 from <br>
pythondeps.toml.<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Yep, this tool was made to show the platform defaults only =
for now. Maybe I&#39;ll add a &quot;show first party backports&quot; flag i=
n the future, if anyone more than just my own personal self would find that=
 useful. (Speak up if so.)</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; main/oss<br>
&gt; pkgsrc_current=C2=A0 =C2=A0 =C2=A0 3.12.11=C2=A0 25.1.1=C2=A0 80.9.0=
=C2=A0 =C2=A0 =C2=A0 8.2.3=C2=A0 =C2=A0---<br>
&gt; ubuntu_22_04=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.10.12=C2=A0 22.0.2=C2=A0 59.=
6.0=C2=A0 =C2=A0 =C2=A0 4.3.2<br>
&gt; jammy-updates/main, jammy/universe, jammy/main<br>
<br>
This is the second oldest version of Sphinx.<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">With us until 26.04, in about 0=
.75 years. This seems like a reasonable new minimum if we wanted to increas=
e it, though that does artificially drop support for RHEL9/CentOS stream bu=
ilding documentation from source under rpmbuild.</div><div dir=3D"auto"></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">(FWIW I probably can conti=
nue to support sphinx 3.x for a little while, the code is gross but it does=
 appear functional. The only thing we *need* to do is bump the preferred ve=
rsion, I think. This support generally comes at the expense of type checkin=
g support for the docs code, as it&#39;s so gross I couldn&#39;t get it to =
work from 3.x to 8.x inclusive.)</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; ubuntu_24_04=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.12.3=C2=A0 =C2=A024.0=C2=A0 =
=C2=A0 68.1.2=C2=A0 =C2=A0 =C2=A0 7.2.6=C2=A0 =C2=A0noble/main,<br>
&gt; noble/universe<br>
&gt; ubuntu_24_10=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.12.7=C2=A0 =C2=A024.2=C2=A0 =
=C2=A0 74.1.2=C2=A0 =C2=A0 =C2=A0 7.4.7<br>
&gt; oracular/main, oracular/universe<br>
&gt; ubuntu_25_04=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.13.3=C2=A0 =C2=A025.0=C2=A0 =
=C2=A0 75.8.0=C2=A0 =C2=A0 =C2=A0 8.1.3=C2=A0 =C2=A0plucky/main,<br>
&gt; plucky/universe<br>
&gt; <br>
&gt; (3) CentOS stream does not ship &quot;sphinx&quot; except via &quot;CR=
B&quot;, which I<br>
&gt; think may not be enabled by default.<br>
<br>
It&#39;s not, but it&#39;s intended to be enabled when developing against t=
he <br>
Red Hat packages.=C2=A0 We enable it in the dockerfile:<br>
<br>
=C2=A0 =C2=A0 =C2=A0dnf config-manager --set-enabled -y crb<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sounds good! I w=
as just taking care to be diligent about which repositories this tool compi=
led info from in order to give a very honest snapshot. I made careful note =
of any &quot;weird&quot; ones that may or may not be considered platform st=
andards.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><br>
&gt; (4) OpenSUSE Leap 15.6 is egregiously old. 16.x is promised for later<=
br>
&gt; this year, but we are past the promised &quot;five year&quot; support =
window for<br>
&gt; this platform in some sense -- 15.0 released in 2018 -- so I believe<b=
r>
&gt; it can actually be ignored.<br>
<br>
As far as Python is concerned, OpenSUSE 15 doesn&#39;t cause trouble anyway=
, <br>
because we do not use the 3.6 interpreter and its very old distro packages.=
<br>
<br>
So that&#39;s two reasons to ignore OpenSUSE.<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Yep, just formally stating tha=
t not only do we have a workaround, but we may have run afoul of the five y=
ear window regardless.</div><div dir=3D"auto"><br></div><div dir=3D"auto">H=
opefully a non-issue once 16 ships.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">(I am of course glad it works anyway!)</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Just interesting to note that OpenSUSE would alr=
eady have the same problems CentOS 9 might in the near future: optional Pyt=
hon upgrade is available, but distro-packaged Sphinx upgrade may not be.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<br>
&gt; (5) Ubuntu only ships pip in &quot;universe&quot;, but also ships some=
 Python<br>
&gt; 3.x interpreter updates to that repository as well. I have filtered<br=
>
&gt; this list to only use Universe for pip packages, leaving Python the<br=
>
&gt; base version that ships with the platform in x/main or x-updates/main.=
<br>
<br>
Yes, fair enough.=C2=A0 Ubuntu 22.04 came out more recently than CentOS <br=
>
Stream 9, after all, and its base distribution is more up to date than <br>
CS9 with respect to the Python ecosystem.=C2=A0 Rust is where Ubuntu (both =
<br>
22.04 and 24.04) is considerably less updated.<br>
<br>
Paolo<br>
<br>
&gt; (6) &quot;ports&quot; collections (FreeBSD, NetBSD, OpenBSD/pkgsrc_cur=
rent,<br>
&gt; Homebrew and MacPorts) do not necessarily have the concept of a<br>
&gt; platform default Python interpreter version, but other packages in the=
<br>
&gt; collection can be used as a heuristic to determine which one is best<b=
r>
&gt; suited.<br>
&gt; <br>
&gt; For instance, FreeBSD and NetBSD only ship pip et al for a single<br>
&gt; interpreter version.<br>
&gt; OpenBSD has a symbolic &quot;python3&quot; package that installs a spe=
cific<br>
&gt; version. Homebrew has a &quot;python3&quot; alias that chooses a speci=
fic Python<br>
&gt; interpreter version. MacPorts similarly has a symbolic &quot;py-setupt=
ools&quot;<br>
&gt; package that will choose a specific interpreter version.<br>
&gt; <br>
&gt; These are used as heuristics to determine a &quot;de-facto&quot; defau=
lt for the<br>
&gt; ports collection platforms.<br>
&gt; <br>
&gt; -<br>
&gt; <br>
&gt; That&#39;s all for now. I will publish the script to the list later,<b=
r>
&gt; though I have no intention of cleaning it up for inclusion in our<br>
&gt; tree. When I send it, bookmark the email if you&#39;d like to try usin=
g<br>
&gt; this for other purposes or running it for yourself. Maybe I will throw=
<br>
&gt; it up on my personal GitLab in case it is useful to other subsystem<br=
>
&gt; maintainers in the future. The filtering code is a little messy, but<b=
r>
&gt; it got the job done and should be reasonably straightforward to make<b=
r>
&gt; sense of at a glance. It uses only the &#39;requests&#39; library as a=
 third<br>
&gt; party dependency.<br>
&gt; <br>
&gt; Your humble Python sin-eater,<br>
&gt; --js<br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000070ece10639749d0a--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F22C83F15
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 20:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZbNk-0005Mn-0h; Wed, 09 Jul 2025 16:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uZbNc-0005M3-Uc
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uZbNZ-0007py-1G
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752092811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NIUyGu3KuOYwDFQCSDqo8o8M6VOzebLneLaiWxyWdGM=;
 b=VENTl1Y3xDf0U35eoKGmIvsh9dEunmwmyrW6kXjMKsqYc+nRr4Wr6HS8L9TEVJRmfBoV8/
 RRJlt5he39WFRbxFjV4pXkxquVErMBXeFoof9qNVYOKQjmDYbVN/n2CeucMKnXIWh4YjWt
 AkdU+Xkfzn5vr3oawfTCyB74hoCjMxM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-H-jowVRSOey5k_RJaYL7Fw-1; Wed, 09 Jul 2025 16:26:50 -0400
X-MC-Unique: H-jowVRSOey5k_RJaYL7Fw-1
X-Mimecast-MFC-AGG-ID: H-jowVRSOey5k_RJaYL7Fw_1752092809
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3138e65efe2so250410a91.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 13:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752092809; x=1752697609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NIUyGu3KuOYwDFQCSDqo8o8M6VOzebLneLaiWxyWdGM=;
 b=KHalWRaw4HtayHyjq5fD05w3xAnVlBf6eumZnmwlGR/I06wkj2F4T1np/n4bVR/ckF
 VRGowFHO2gxUcHrP/OyzjupkTCRWxgfimfbXbuLYnPHS0uWb4J5FWhXz2WGAxGKg1Q6r
 WLKjr1AdUZz1OvAG+/wx9hfOa3ncCpVERNNaek5mURf00f5BMsWsodJNVzUM3af+rCPk
 xhsEAe7mwFkAlLiiDuKUIpn8lrQepSbu2XIRRMB+JZJRvCZ7c2UIFmcnkR7jjhw+v8Or
 rmmirVhdc3jU3iQJktrazbk2g2qo8zTza9p95h5+pCvBPdlJnKi9Dbphyxl5OH/heHg+
 J2Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJsbi6Q5Blp/WSkDjZBOO+F4lOLeJU3R5CUdpAoRc6lL9Epdz5njYOPnSNBGW10Wv/UVKwGj/p//L0@nongnu.org
X-Gm-Message-State: AOJu0Yz55aEKuF2rc48sYjb0rpHu9SmF8zPHqMuisRD36L6/GvZwSwJN
 gzpYAzok+jVUr5r3vVQoEOyBWuOTXeCnUE8b9lnMIutgN4mu+lMLnE79htF7tTMT9O68Z5KLOFN
 eA18nMfxiSDhTU/hW3h8QMm8uJ/EFYba7rbYR+rMnfcw8SfYXwTTQJscp07tivOLcgKYuhBqRx4
 g8akjC1twPBPiI3ZgYIYbl+REWn7IZSSo=
X-Gm-Gg: ASbGncv11F+9/crAu2Uu3LrwKqzHxYUhgHGErOL0nJ4F8ZmqkauHFOq1PJt55j1LeEV
 BfSQoAu/B/PfKtmz6aOZBE9Sjgw7tTEO2Z5JUycN6nfpiLmtVbfE6EmKqUWWTHu5hdOpbz63TFu
 9AbRbz9eUPo8JBskWVcyXQ8mn/D4Eel5IqExM=
X-Received: by 2002:a17:90b:33ce:b0:313:2206:adf1 with SMTP id
 98e67ed59e1d1-31c3c269b66mr1849729a91.4.1752092808735; 
 Wed, 09 Jul 2025 13:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEM8c0UAWKDrhI4C80i5qHw2oPjdhxXH2EHa2ab1NLsa7QlIxnvkRQI5QDWtYX3mw39hMAlRtiqrnzYzlfSMI=
X-Received: by 2002:a17:90b:33ce:b0:313:2206:adf1 with SMTP id
 98e67ed59e1d1-31c3c269b66mr1849679a91.4.1752092808123; Wed, 09 Jul 2025
 13:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
 <87qzz9myd0.fsf@pond.sub.org>
 <CABgObfaqauR5SDe67ueAg9-VvJBxM5+LqrYTF3CYjjzzmY8d+w@mail.gmail.com>
 <aGuPI4w505EoScGK@redhat.com>
 <CAFn=p-ZoBPsM9UGJiog6684+jrCy61tGauF-osskMACXV9Nfpg@mail.gmail.com>
 <CABgObfaBe0qA0ewy4jo01o1H+uysk-82Gv=tX5hHZ01vxTfdmQ@mail.gmail.com>
In-Reply-To: <CABgObfaBe0qA0ewy4jo01o1H+uysk-82Gv=tX5hHZ01vxTfdmQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 9 Jul 2025 16:26:35 -0400
X-Gm-Features: Ac12FXy_Kq8O2Ok12jh1HfHxKm3-VVlTQw95IND9B6x4pzMchpZ3sn1GZczO7o4
Message-ID: <CAFn=p-b_epB7eRK_=5L2_m5a7oEQ1b+b=3mcSq0OLjaMB+UJUw@mail.gmail.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000713d09063984e5c0"
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

--000000000000713d09063984e5c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025, 3:40=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> wr=
ote:

>
>
> Il mer 9 lug 2025, 20:39 John Snow <jsnow@redhat.com> ha scritto:
>
>> You are right. However, the mkvenv configuration tool we pioneered has
>> been largely un-noticed by contributors and appears to "just work" for
>> the last several years. I believe that cost has been *largely*
>> amortized by yours truly, and I have spared almost every other
>> contributor from paying it.
>>
>
> Especially for sphinx.
>
> mkvenv/pythondeps.toml has been very stable, perhaps beyond expectations,
> so at least it was a one time cost.
>
> So, more or less: your concern is something I share, but I think I
>> have it satisfactorily addressed - hence my seeming overfocus on
>> distro packagers.
>>
>
> I agree, and I should thank you for hearing me out on the somewhat crazy
> idea that's mkvenv.
>

I knew it was possible, I was not so sure it'd be as stable as it has been.
What a delight!


> > In terms of 3rd party vendors, they can have similar roles to a distro
>> > vendor, but are more likely to package up newer QEMU versions to run
>> > on pre-existing distros.
>>
>> Yes. I think they are also usually more willing and able to bend the
>> rules of the base platform, though.
>
>
> Willing, I am not sure. Able yes, which is what matters even if they're
> not really willing. :)
>
> And they probably care much less about docs to be honest.
>
> I seek to develop and codify a suitable compromise for these
>> situations as they continue to arise and, in all likelihood, will not
>> stop cropping up once per year or so. [...]  In my case, it's only Pytho=
n
>> packages from over five years
>
> ago that present a difficulty - which is not exactly bleeding edge
>> stuff.
>>
>> I would like to codify something like this for our support policy:
>>
>> "On otherwise supported build platforms, QEMU *may* require a Python
>> interpreter that is considered actively maintained, which is usually a
>> version released within the last five years. When platforms that ship,
>> by default, an EOL Python interpreter also offer an optional package
>> for a newer, actively maintained Python interpreter, QEMU may require
>> this repository package for configuring and building QEMU."
>>
>
> That's basically an extension and clarification of what already exists at
> https://www.qemu.org/docs/master/about/build-platforms.html ("Python
> runtime").
>
> Piggybacking on Python EOL as a necessary but not sufficient condition is
> at the same time conservative and useful.
>
> (Simpler language: I am trying to say that Platforms like OpenSUSE
>> that have an ancient Python by default but also ship newer optional
>> versions may require one of those newer, optional versions to build
>> QEMU
>
>
> OpenSUSE is not a problem since their base Python is not even supported b=
y
> QEMU. CentOS Stream is the more sticky one, unless you have a good reason
> to require 3.10 (personally I don't, other than nicer type annotations I
> have no love for e.g. match expressions).
>

Just an example for a distro we've already bent the rules for. Their base
Python is still technically 3.6 and they don't technically package Sphinx
for the newer interpreter, so it's a useful example case even if it is
arguably beyond our support window now.

>
> On platforms that do NOT offer a newer Python version, I am
>> suggesting that I will be shit-out-of-luck. I think this is a pretty
>> mild compromise, all told.)
>>
>
> Yeah, their problem. Both Red Hat and SUSE have figured it out.
>

I meant to suggest it's *my* problem, but I think distributions are aware
that not providing an (optional) non-EOL Python is not a viable option
these days.

Basically affirming: you will be able to build QEMU on a supported platform
with just your distro's repositories, and that's a promise.


> "On these platforms, unit tests and documentation may possibly require
>> non-distribution packaged versions of Python dependencies such as
>> Sphinx in order to run using the more modern Python interpreter."
>>
>
> That's the cop out for Red Hat, where you accept 3.9 for building and
> require 3.10 for docs and tests? Not sure about it, especially tests. I
> would either restrict the limitation to docs, or just declare 3.10 the
> minimum once 3.9 is EOL (say January 2026).
>

I mean to say that I don't consider loading a newer Python provided by your
distribution as a violation of our platform promise: in many ways it is
"just another dep".

I wouldn't raise the minimum Python version unless affected distributions
had an alternate interpreter in their repository. OpenSUSE and CentOS both
offer this, so the option is viable.

However, this solution does not account for other Python dependencies like
Sphinx, which are very likely *not* repackaged by the distro for the newer
interpreter.

A normal end user can run configure and get the new deps automatically and
invisibly, no problem. Offline/isolated builds are slightly trickier.

So I mean to clarify: QEMU will always be able to be built with your distro
packages (sometimes with newer, alternative Python versions) but in this
specific case, some "optional" features where Python is concerned may
require side-loading Python dependencies from outside of your system
repository.

I.e. there may be degradation, but only for unit tests and docs, and only
when your base platform Python is EOL (five years old. It can be fixed by
using PyPI, allowing internet during configure, disabling tests and docs,
or doing the labor of adding a new package to your builddep environment.

So I pledge the core build will only need the newer Python from your system
repo, but tests and docs I only pledge support for if your Python is not
EOL (approx 5 years old or less.)

That's my proposal.

(Unless... haha. The idea is so stupid I don't even want to write it on
list. Ping me on matrix/IRC...)


> I'd like to re-iterate that my motivation here is not to stop
>> supporting EOL python versions "just because they are EOL", but rather
>> instead because the tooling and libraries surrounding Python
>> aggressively drop support for those versions once they become EOL.
>> That is, 3.9 is not difficult to support until e.g. Python 3.14 comes
>> out and setuptools, pip, and sphinx begin targeting 3.14 at the
>> expense of 3.9 and there is an increased burden of hacks and
>> workarounds required to target 3.9-3.14 inclusive.
>>
>
> Yes, this is the real problem. And it's better to have a plan ahead of
> time.
>
> (As an aside, Meson is the good guy here. It supports old versions of
> Python just fine The only reason to push Meson versions past 1.2 was to
> support Rust-adjacent features and bugfixes that especially after 1.5 we'=
re
> mostly written by yours truly, specifically to evolve Rust support in the
> direction that QEMU is interested in).
>

I love Meson. Pure Python, zero deps. Trivial to vendor. It's a delight and
I'm glad they have such reasonable policies. It's a rare treat that never
causes problems for me <3


> Paolo
>

--000000000000713d09063984e5c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 9, 2025, 3:40=E2=80=
=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">Il mer 9 lug 2025, 20:39 John Snow &lt;<a href=3D"mailto:jsnow@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; ha s=
critto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">You are =
right. However, the mkvenv configuration tool we pioneered has<br>
been largely un-noticed by contributors and appears to &quot;just work&quot=
; for<br>
the last several years. I believe that cost has been *largely*<br>
amortized by yours truly, and I have spared almost every other<br>
contributor from paying it.<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Especially for sphinx.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">mkvenv/pythondeps.toml has been very stable, perh=
aps beyond expectations, so at least it was a one time cost.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">So, more or less: your concern is s=
omething I share, but I think I<br>
have it satisfactorily addressed - hence my seeming overfocus on<br>
distro packagers.<br></blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">I agree, and I should thank you for hearing me out on the =
somewhat crazy idea that&#39;s mkvenv.</div></div></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">I knew it was possible, I was=
 not so sure it&#39;d be as stable as it has been. What a delight!</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">&gt; In terms of 3rd party vendors,=
 they can have similar roles to a distro<br>
&gt; vendor, but are more likely to package up newer QEMU versions to run<b=
r>
&gt; on pre-existing distros.<br>
<br>
Yes. I think they are also usually more willing and able to bend the<br>
rules of the base platform, though.</blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Willing, I am not sure. Able yes, which is w=
hat matters even if they&#39;re not really willing. :)</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">And they probably care much less about docs =
to be honest.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I seek t=
o develop and codify a suitable compromise for these<br>
situations as they continue to arise and, in all likelihood, will not<br>
stop cropping up once per year or so. [...]=C2=A0 In my case, it&#39;s only=
 Python packages from over five years</blockquote></div></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
ago that present a difficulty - which is not exactly bleeding edge<br>
stuff.<br>
<br>I would like to codify something like this for our support policy:<br>
<br>
&quot;On otherwise supported build platforms, QEMU *may* require a Python<b=
r>
interpreter that is considered actively maintained, which is usually a<br>
version released within the last five years. When platforms that ship,<br>
by default, an EOL Python interpreter also offer an optional package<br>
for a newer, actively maintained Python interpreter, QEMU may require<br>
this repository package for configuring and building QEMU.&quot;<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That&#39;s =
basically an extension and clarification of what already exists at <a href=
=3D"https://www.qemu.org/docs/master/about/build-platforms.html" target=3D"=
_blank" rel=3D"noreferrer">https://www.qemu.org/docs/master/about/build-pla=
tforms.html</a> (&quot;Python runtime&quot;).</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Piggybacking on Python EOL as a necessary but not suf=
ficient condition is at the same time conservative and useful.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">(Simpler language: I am trying to =
say that Platforms like OpenSUSE<br>
that have an ancient Python by default but also ship newer optional<br>
versions may require one of those newer, optional versions to build<br>
QEMU</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
OpenSUSE is not a problem since their base Python is not even supported by =
QEMU. CentOS Stream is the more sticky one, unless you have a good reason t=
o require 3.10 (personally I don&#39;t, other than nicer type annotations I=
 have no love for e.g. match expressions).</div></div></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Just an example for a dis=
tro we&#39;ve already bent the rules for. Their base Python is still techni=
cally 3.6 and they don&#39;t technically package Sphinx for the newer inter=
preter, so it&#39;s a useful example case even if it is arguably beyond our=
 support window now.</div><div dir=3D"auto"><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On platforms that do NOT offer a ne=
wer Python version, I am<br>
suggesting that I will be shit-out-of-luck. I think this is a pretty<br>
mild compromise, all told.)<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Yeah, their problem. Both Red Hat and SUSE have =
figured it out.</div></div></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">I meant to suggest it&#39;s *my* problem, but I thin=
k distributions are aware that not providing an (optional) non-EOL Python i=
s not a viable option these days.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Basically affirming: you will be able to build QEMU on a supporte=
d platform with just your distro&#39;s repositories, and that&#39;s a promi=
se.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"aut=
o"><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">&quot;On these platforms=
, unit tests and documentation may possibly require<br>
non-distribution packaged versions of Python dependencies such as<br>
Sphinx in order to run using the more modern Python interpreter.&quot;<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That&=
#39;s the cop out for Red Hat, where you accept 3.9 for building and requir=
e 3.10 for docs and tests? Not sure about it, especially tests. I would eit=
her restrict the limitation to docs, or just declare 3.10 the minimum once =
3.9 is EOL (say January 2026).</div></div></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I mean to say that I don&#39;t consid=
er loading a newer Python provided by your distribution as a violation of o=
ur platform promise: in many ways it is &quot;just another dep&quot;.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">I wouldn&#39;t raise the mini=
mum Python version unless affected distributions had an alternate interpret=
er in their repository. OpenSUSE and CentOS both offer this, so the option =
is viable.</div><div dir=3D"auto"><br></div><div dir=3D"auto">However, this=
 solution does not account for other Python dependencies like Sphinx, which=
 are very likely *not* repackaged by the distro for the newer interpreter.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">A normal end user can ru=
n configure and get the new deps automatically and invisibly, no problem. O=
ffline/isolated builds are slightly trickier.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">So I mean to clarify: QEMU will always be able to be =
built with your distro packages (sometimes with newer, alternative Python v=
ersions) but in this specific case, some &quot;optional&quot; features wher=
e Python is concerned may require side-loading Python dependencies from out=
side of your system repository.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I.e. there may be degradation, but only for unit tests and docs, =
and only when your base platform Python is EOL (five years old. It can be f=
ixed by using PyPI, allowing internet during configure, disabling tests and=
 docs, or doing the labor of adding a new package to your builddep environm=
ent.</div><div dir=3D"auto"><br></div><div dir=3D"auto">So I pledge the cor=
e build will only need the newer Python from your system repo, but tests an=
d docs I only pledge support for if your Python is not EOL (approx 5 years =
old or less.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">That&#39;s=
 my proposal.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">(Unl=
ess... haha. The idea is so stupid I don&#39;t even want to write it on lis=
t. Ping me on matrix/IRC...)</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>I&#39;d like to re-iterate that my motivation here is not to stop<br>
supporting EOL python versions &quot;just because they are EOL&quot;, but r=
ather<br>
instead because the tooling and libraries surrounding Python<br>
aggressively drop support for those versions once they become EOL.<br>
That is, 3.9 is not difficult to support until e.g. Python 3.14 comes<br>
out and setuptools, pip, and sphinx begin targeting 3.14 at the<br>
expense of 3.9 and there is an increased burden of hacks and<br>
workarounds required to target 3.9-3.14 inclusive.<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, this is the real pro=
blem. And it&#39;s better to have a plan ahead of time.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">(As an aside, Meson is the good guy here. I=
t supports old versions of Python just fine The only reason to push Meson v=
ersions past 1.2 was to support Rust-adjacent features and bugfixes that es=
pecially after 1.5 we&#39;re mostly written by yours truly, specifically to=
 evolve Rust support in the direction that QEMU is interested in).</div></d=
iv></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I=
 love Meson. Pure Python, zero deps. Trivial to vendor. It&#39;s a delight =
and I&#39;m glad they have such reasonable policies. It&#39;s a rare treat =
that never causes problems for me &lt;3</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div></div>
</blockquote></div></div></div>

--000000000000713d09063984e5c0--



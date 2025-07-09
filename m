Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726CAC83F14
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 19:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZaeb-00065e-KS; Wed, 09 Jul 2025 15:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZaea-00065H-9i
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 15:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZaeX-0001ag-Fa
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 15:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752090022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B65STSHE8btl6vvezd+bPg/gQVW3XoYhCiWjKQxYNWQ=;
 b=idlmvnkrb3vsFIylJ6oTRJtvfZYN20Q0DpaB1HwsQpiQJMpcIxEk6HHD1+BfXrtUVB9H9k
 INfJhCb7XuDraEcBCId9QvP0ovdaEdmBKPUEfe3dw3vTVDBIW37TsgFazonv6pl/u2DhEo
 UrphM1PxoItDlNazhYwvRBsqXBaMJWA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-EtO0ef2APE6wxMJs2SMtRQ-1; Wed, 09 Jul 2025 15:40:20 -0400
X-MC-Unique: EtO0ef2APE6wxMJs2SMtRQ-1
X-Mimecast-MFC-AGG-ID: EtO0ef2APE6wxMJs2SMtRQ_1752090019
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453691d0a1dso1727905e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 12:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752090019; x=1752694819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B65STSHE8btl6vvezd+bPg/gQVW3XoYhCiWjKQxYNWQ=;
 b=kyXpYOV8e2BT1hTH+dGrGTlxpK5SxXoUFGXpNbBgrkzqkFkhRrhGaWLkPz6r5FDH44
 DfYAUrDMWlXUoPdkZF6HFAn/GrXND7IG/h4nI+algENeW0HS0QRbApUC00xJYIWbRHQB
 rEaRDOt9jYlzYJu+6TCLbUQqW6B2++B4Z+pApAdLA+RA6is/gJHLE+1mIdn4gJjzfEbf
 yBk6gK0UnNQCOJTdrm96OWxZbNv7LTQkC4bKr3R91hdkY5bxl2/knIPIasxUnGh2kTk/
 J6ZeUTP5aO7sHYFA+E8lyJxYeRI8M8xAvMQsllJ21CALwIre+k9oV5sFVMn1M6H8Hzoy
 OoOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJRzCtaSUjBh1xCdhzVo7s5bnNWzawAzkh9pY1DVGO8BvMY5LyL/PANX0m5zTgZ0aG5gAFcykeDcGi@nongnu.org
X-Gm-Message-State: AOJu0Yx/xqgIBY63ShkYuqz+vFnomln0282BRNupvQbTiKHld8HfsU1S
 U6L3ImgKSlXNq/nDqQm7QF/E6wMGBPkclUsfv5YBfYgEVItpOEWaoHAHQgZ+PSicv8j2Uh65ix4
 H/LqKEjVEIfJnflU8CGctqCYXCyTUdWRtcT2i1xcYCQzEqNw/5NlcnDP/kXt0DvJq8xRVI4nqhq
 lB2u7xOlZnWC/oTi5C98QCSN5WwU4RZsg=
X-Gm-Gg: ASbGncvScl8DMq25No5rMWMWrLrsmsX/Btim7koftgG6RvXRQ3uCkqzQynZxMbIRO91
 NdqqB2wA+roB3GJ8myX1HD16hfY/f53j0WMOSbiEbg9wubhHyRCyDErhqczJj9D5dwWlPwOehtT
 Dhwf6M
X-Received: by 2002:a05:600c:8b63:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-454d53ae798mr39061035e9.18.1752090019391; 
 Wed, 09 Jul 2025 12:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/fI01z2AF6dNNn67byn6x3jQJj+2w+jmeMZB4FP++9mgZnf9r2wg1/M1w29JWt3XDVbY3V+o1Kw46zW/afVg=
X-Received: by 2002:a05:600c:8b63:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-454d53ae798mr39060815e9.18.1752090018854; Wed, 09 Jul 2025
 12:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
 <87qzz9myd0.fsf@pond.sub.org>
 <CABgObfaqauR5SDe67ueAg9-VvJBxM5+LqrYTF3CYjjzzmY8d+w@mail.gmail.com>
 <aGuPI4w505EoScGK@redhat.com>
 <CAFn=p-ZoBPsM9UGJiog6684+jrCy61tGauF-osskMACXV9Nfpg@mail.gmail.com>
In-Reply-To: <CAFn=p-ZoBPsM9UGJiog6684+jrCy61tGauF-osskMACXV9Nfpg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 9 Jul 2025 21:40:07 +0200
X-Gm-Features: Ac12FXxNmioW3sJW4wa57GNTJv3rJio1NMXm_6Csy9aE-ho2Hmev9n235_ZZDnU
Message-ID: <CABgObfaBe0qA0ewy4jo01o1H+uysk-82Gv=tX5hHZ01vxTfdmQ@mail.gmail.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
To: John Snow <jsnow@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000304c5b0639843fad"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

--000000000000304c5b0639843fad
Content-Type: text/plain; charset="UTF-8"

Il mer 9 lug 2025, 20:39 John Snow <jsnow@redhat.com> ha scritto:

> You are right. However, the mkvenv configuration tool we pioneered has
> been largely un-noticed by contributors and appears to "just work" for
> the last several years. I believe that cost has been *largely*
> amortized by yours truly, and I have spared almost every other
> contributor from paying it.
>

Especially for sphinx.

mkvenv/pythondeps.toml has been very stable, perhaps beyond expectations,
so at least it was a one time cost.

So, more or less: your concern is something I share, but I think I
> have it satisfactorily addressed - hence my seeming overfocus on
> distro packagers.
>

I agree, and I should thank you for hearing me out on the somewhat crazy
idea that's mkvenv.

> In terms of 3rd party vendors, they can have similar roles to a distro
> > vendor, but are more likely to package up newer QEMU versions to run
> > on pre-existing distros.
>
> Yes. I think they are also usually more willing and able to bend the
> rules of the base platform, though.


Willing, I am not sure. Able yes, which is what matters even if they're not
really willing. :)

And they probably care much less about docs to be honest.

I seek to develop and codify a suitable compromise for these
> situations as they continue to arise and, in all likelihood, will not
> stop cropping up once per year or so. [...]  In my case, it's only Python
> packages from over five years

ago that present a difficulty - which is not exactly bleeding edge
> stuff.
>
> I would like to codify something like this for our support policy:
>
> "On otherwise supported build platforms, QEMU *may* require a Python
> interpreter that is considered actively maintained, which is usually a
> version released within the last five years. When platforms that ship,
> by default, an EOL Python interpreter also offer an optional package
> for a newer, actively maintained Python interpreter, QEMU may require
> this repository package for configuring and building QEMU."
>

That's basically an extension and clarification of what already exists at
https://www.qemu.org/docs/master/about/build-platforms.html ("Python
runtime").

Piggybacking on Python EOL as a necessary but not sufficient condition is
at the same time conservative and useful.

(Simpler language: I am trying to say that Platforms like OpenSUSE
> that have an ancient Python by default but also ship newer optional
> versions may require one of those newer, optional versions to build
> QEMU


OpenSUSE is not a problem since their base Python is not even supported by
QEMU. CentOS Stream is the more sticky one, unless you have a good reason
to require 3.10 (personally I don't, other than nicer type annotations I
have no love for e.g. match expressions).

On platforms that do NOT offer a newer Python version, I am
> suggesting that I will be shit-out-of-luck. I think this is a pretty
> mild compromise, all told.)
>

Yeah, their problem. Both Red Hat and SUSE have figured it out.

"On these platforms, unit tests and documentation may possibly require
> non-distribution packaged versions of Python dependencies such as
> Sphinx in order to run using the more modern Python interpreter."
>

That's the cop out for Red Hat, where you accept 3.9 for building and
require 3.10 for docs and tests? Not sure about it, especially tests. I
would either restrict the limitation to docs, or just declare 3.10 the
minimum once 3.9 is EOL (say January 2026).

I'd like to re-iterate that my motivation here is not to stop
> supporting EOL python versions "just because they are EOL", but rather
> instead because the tooling and libraries surrounding Python
> aggressively drop support for those versions once they become EOL.
> That is, 3.9 is not difficult to support until e.g. Python 3.14 comes
> out and setuptools, pip, and sphinx begin targeting 3.14 at the
> expense of 3.9 and there is an increased burden of hacks and
> workarounds required to target 3.9-3.14 inclusive.
>

Yes, this is the real problem. And it's better to have a plan ahead of time.

(As an aside, Meson is the good guy here. It supports old versions of
Python just fine The only reason to push Meson versions past 1.2 was to
support Rust-adjacent features and bugfixes that especially after 1.5 we're
mostly written by yours truly, specifically to evolve Rust support in the
direction that QEMU is interested in).

Paolo

--000000000000304c5b0639843fad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 9 lug 2025, 20:39 John Sn=
ow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; ha scri=
tto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">You are rig=
ht. However, the mkvenv configuration tool we pioneered has<br>
been largely un-noticed by contributors and appears to &quot;just work&quot=
; for<br>
the last several years. I believe that cost has been *largely*<br>
amortized by yours truly, and I have spared almost every other<br>
contributor from paying it.<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Especially for sphinx.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">mkvenv/pythondeps.toml has been very stable, perh=
aps beyond expectations, so at least it was a one time cost.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">So, more or l=
ess: your concern is something I share, but I think I<br>
have it satisfactorily addressed - hence my seeming overfocus on<br>
distro packagers.<br></blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">I agree, and I should thank you for hearing me out on the =
somewhat crazy idea that&#39;s mkvenv.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">&gt; In terms of 3rd party vendors, =
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
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">I seek to develop and codify a suitable compromise for these<=
br>
situations as they continue to arise and, in all likelihood, will not<br>
stop cropping up once per year or so. [...]=C2=A0 In my case, it&#39;s only=
 Python packages from over five years</blockquote></div></div><div dir=3D"a=
uto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
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
=3D"https://www.qemu.org/docs/master/about/build-platforms.html">https://ww=
w.qemu.org/docs/master/about/build-platforms.html</a> (&quot;Python runtime=
&quot;).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Piggybacking on=
 Python EOL as a necessary but not sufficient condition is at the same time=
 conservative and useful.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">(Simpler language: I am trying to say that Platfo=
rms like OpenSUSE<br>
that have an ancient Python by default but also ship newer optional<br>
versions may require one of those newer, optional versions to build<br>
QEMU</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
OpenSUSE is not a problem since their base Python is not even supported by =
QEMU. CentOS Stream is the more sticky one, unless you have a good reason t=
o require 3.10 (personally I don&#39;t, other than nicer type annotations I=
 have no love for e.g. match expressions).</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On platforms that do NOT offer a=
 newer Python version, I am<br>
suggesting that I will be shit-out-of-luck. I think this is a pretty<br>
mild compromise, all told.)<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Yeah, their problem. Both Red Hat and SUSE have =
figured it out.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">&quot;On these platforms, unit tests and documentation may =
possibly require<br>
non-distribution packaged versions of Python dependencies such as<br>
Sphinx in order to run using the more modern Python interpreter.&quot;<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That&=
#39;s the cop out for Red Hat, where you accept 3.9 for building and requir=
e 3.10 for docs and tests? Not sure about it, especially tests. I would eit=
her restrict the limitation to docs, or just declare 3.10 the minimum once =
3.9 is EOL (say January 2026).</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">I&#39;d like to re-iterate that my motivat=
ion here is not to stop<br>
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
 evolve Rust support in the direction that QEMU is interested in).</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--000000000000304c5b0639843fad--



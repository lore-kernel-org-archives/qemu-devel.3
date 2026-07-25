Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB68C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 12:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnbMr-0003YU-NY; Sat, 25 Jul 2026 08:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnbMq-0003X9-1l
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnbMn-00085S-7U
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 08:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784982031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wmAF5n9IzGMCEfy3T1NWV8r9gR4diDLPt8jvQ7GqiJw=;
 b=DJvxMzgLw5O6QUGOaov+vcoOMA8wQaN3cSDjF/m/fy1/rMqoGSOQ9RJW2GffuolfslxVGJ
 SupKwxF4ivodc2HdDi5ait/zTTzqQwJBR10/Jv0mHi6aOrDsS0YhXOEbBO8iUK5snbdfJ/
 +Ix6EOdDz4BMhTZVcxuc56+aymS3kV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-kRg30T9VMoWzQEhZJeLmLw-1; Sat, 25 Jul 2026 08:20:29 -0400
X-MC-Unique: kRg30T9VMoWzQEhZJeLmLw-1
X-Mimecast-MFC-AGG-ID: kRg30T9VMoWzQEhZJeLmLw_1784982028
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4954c2d4081so10191185e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 05:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784982028; cv=none;
 d=google.com; s=arc-20260327;
 b=OUyvqvFWTwm42ILKpYDnH661D93qAB3mlHCqlwSDp5pMbrRN0y3qS90HNlqGu2DnIj
 0KmWgHd3MH9s7IVnFB2lp1C3kAUURoui2z7kTrK3bqI4ol7tw01SEwSDYtJAf9skXoep
 bUIf9Dab7UrCeIcTcmd7uV/wUfA8rDsEr4vwXQvJ/nBx5wmvpm7tBfKCJmDiIEldI3Lx
 XM2nw9MvyIixUzyYxkRId7pWDFsMijEiIM3CwaxwL7yw/wiWvteDOHK3tJT3+aL88zGv
 iRPnIwTicHbaUWZLVsF6LDJY6Lb/tYFVAzOpNQggTtzgxPLAADLONIVhAr7JDdVryzXx
 kNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wmAF5n9IzGMCEfy3T1NWV8r9gR4diDLPt8jvQ7GqiJw=;
 fh=Xm1ao//qklFdOPp89/6xUzCVv6E/EI6O1lKNAzhngcE=;
 b=Ag8ZYQRcIpTZM52ZkejURlk8JiPcRq2qW1clEFKgZcFUB/j6S1uJO6VGl4E6hygACB
 /9vRQrafz0g1MaPWUPa/0MZ6nLwAyuVJn+7KwZbLUWIVD103gsx7mRGnS5obAU3pPakP
 dOKfb5l0UMk6xV2j/XRjamxMawoqIp1NPtrwg5avILGsrj7EXL1LTZpNCovOuTO9Ts5W
 +gMFjXabB2+MNB7GQvl//LLmudFqt1fkRwDK/YrUNFJbw8momRxoNLhgxVgrN7iCISSh
 xnCjqdx1zpqCbiU3Yq//TNCaQ1bNSJsYJD1+CbbuzpXuF1ruUYqHgZ0ggHbS8FpX0Y1t
 UEEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784982028; x=1785586828; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wmAF5n9IzGMCEfy3T1NWV8r9gR4diDLPt8jvQ7GqiJw=;
 b=UCRTYoBOxG51ntPQCi+l6JlbeLXKTRpmXer+o+JaoJmoJZdrTy6U8uWcZ7PXVRdh2J
 T0JBmSYeHyJeXmyGDql/FpqF3NM6mjPZHXtjTrExidFIrTt1Nq0legBoZXGXVfPJ7lf0
 cexos0A4mmxccgYkmGSyA6U2J/N+m5/HDkxVnCnEOnhvS0joCA3xgVVsc5OHO3x6L9VI
 cKW1l19GGxNBbPSGbDEqVe6y2yZC9CkvUtawJt8vTwRjAsky7vs8jqNWfGskTcjBWRpK
 x1MyHlsEyvR9UkwKXEtZzCyaHCzXg/tvmKhrbLzZ7qZUcU1PsCtIqJwMvaJNNdifj44N
 qayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784982028; x=1785586828;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wmAF5n9IzGMCEfy3T1NWV8r9gR4diDLPt8jvQ7GqiJw=;
 b=oE5HAU+Ttr5AjtYhEbkcxvBGHRJZf1wEgPSk38M3lLSyT6irEEqh9I98381Z+d4NMe
 kMdWXo11ugUvoutnCSP3X/1Cx4jQqH7DlidNdFZDMppD6ltwmeaCopcipNRsbq/D6QGA
 bvjnD6GP8oe5xwca+Y+O1tYM56fYAT5ZL/ilQv8uqO3LoU+tMNlCg3aR78khLD1qr+7p
 +Fi1E7gcVno6AUwLWOSsAo2BGd0amPJEQ964UP8drNg7Tae36yDaAefFLzNKRa7xRqTP
 JvvkLoIm0T0Fh+JFbmdwIpCmKesyC9Lh7Uf67l1d1vhMsW6R4o4zAzbXh+MXb/diuDJN
 mx0Q==
X-Gm-Message-State: AOJu0YwW56WaAWcWaiLopKkfjgtv+PQMsdSyz9vARtWYExKKTa+9VOTt
 6nOo9b//xq1Bgih35JSXaw7che5thlY04HpBrQ4f4DLuu61msKClK6G8NsvxQ0rqgswMWw8AcXn
 JHSSOntAgk/r2XI6Z0O8iHbsDGT1xGUcxg4OM9EWAo7ZNLAI4PgBeGxVtyH8pgtvxjMBh+YxFzl
 TSs2O0QUzRyidMAS/Yi/k7Yiyhrv+teEgLEJxSY+4=
X-Gm-Gg: AR+sD10VUcc9CzvTjwkxXSslEoNZwrpIVdvZZC9nf1zktLFANB3ahHWrK9Dtp4JnFvC
 EDBHPZoeeHlnAMpXx2k7D1xCCkwjxo8k5UWuQhu30QVgf6i+yRc0KVtq648lddpVv+XxLrbsf7Y
 R6R9GHnMkxzcrlqpD364iEL9GQytYrGXo2/XnBf9+xkUMvSzt06B6OjxauI7umMwgyQmhYd5kmz
 wqrdIcwv0YZfTFoGYNiG26wgXQpgu3NS3M1U7sfXeKmWgclwB/5LkciMFoC
X-Received: by 2002:a05:600c:8b32:b0:495:6a2a:951f with SMTP id
 5b1f17b1804b1-496b56dacc8mr27796425e9.17.1784982028245; 
 Sat, 25 Jul 2026 05:20:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8b32:b0:495:6a2a:951f with SMTP id
 5b1f17b1804b1-496b56dacc8mr27796085e9.17.1784982027873; Sat, 25 Jul 2026
 05:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260724130044.1369843-1-pbonzini@redhat.com>
 <20260724130044.1369843-2-pbonzini@redhat.com>
 <87a4rf61e9.fsf@pond.sub.org>
In-Reply-To: <87a4rf61e9.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 25 Jul 2026 14:20:16 +0200
X-Gm-Features: AUfX_mx2fKrP0XvNxFUQTv_i0Ewp8TyENYbAAXhXLmsr5cAo6KSw0zmMVFD-vX8
Message-ID: <CABgObfaAnbH6eV3Gu305KjNBN9MCJN0TwPbbrE2ZkMWO4Mcxcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] scripts/qapi: enum with conditional first item must
 be optional
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b3c12806576e8313"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000b3c12806576e8313
Content-Type: text/plain; charset="UTF-8"

Il sab 25 lug 2026, 08:15 Markus Armbruster <armbru@redhat.com> ha scritto:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Prevent an all-zero struct from having different meanings with
> > different configurations or builds of QEMU.
>
> This is a bit terse.  What *exactly* is broken?  Spelling this out
> matters, because it can expose holes in the argument, if any.


Nothing is broken; it's just something that can have unexpected
consequences...

The numeric encoding of enum values is irrelevant except for zero,
> because we actually use numeric zero via zero initialization.  If the
> enum's first value is conditional, the meaning of zero depends on build
> configuration.  We don't want such a default at the external interface.
> It could conceivably lead to purely internal bugs, too.
>

... like these.

However, I'm not sure your solution fixes this problem completely.
>
> Consider type Arg with a mandatory member @mand and an optional enum
> member @opt, both of enum type ENUM_TYPE.
>
> QMP input gets converted to native C like this:
>
>     if (!visit_type_Arg(v, NULL, &arg, errp)) {
>         return;
>     }
>
> If @opt is absent, then arg.has_opt and arg.opt are both zero.
>
> Code providing an explicit default then is still fine:
>
>     if (!arg.has_opt) {
>         arg.opt = ENUM_TYPE_MUMBLE;
>     }
>
> But we often use arg.opt without checking arg.has_opt for brevity.  This
> is an implicit default to zero, whatever zero may mean.
>
> If the the optional enum's first member is conditional, this default
> depends on build configuration.
>
> Stupidest solution that could possibly work: an enum's first member
> cannot be conditional.
>

That would prevent an enum that is entirely compiled out, which seems like
a plausibly desirable feature.

Honestly I think this is a C problem, not a QAPI problem. Skipping has_xx
for bools that default to false is already borderline; doing it for enums
is well into "you shouldn't do it" territory. Whereas "unless you have
mandatory pointer fields, g_malloc0(...) returns a valid *and portable*
QAPI struct" is in my opinion supporting a desirable idiom.

Rust would spell it "Default::default()"; the language can help rejecting
it if you have mandatory string fields (it would recursively default boxed
structs, unlike C) but it cannot do anything about portability; this patch
closes the gap completely for Rust, and does what it can for C.

Paolo

Thoughts?


> > This needs some changes to doc-good.json, which used unwittingly
> > such an enum.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  scripts/qapi/schema.py                        |  8 ++++++++
> >  tests/qapi-schema/doc-good.json               | 16 ++++++++--------
> >  tests/qapi-schema/doc-good.out                | 12 ++++++------
> >  tests/qapi-schema/doc-good.txt                |  8 ++++----
> >  tests/qapi-schema/enum-if-first-required.err  |  2 ++
> >  tests/qapi-schema/enum-if-first-required.json |  6 ++++++
> >  tests/qapi-schema/enum-if-first-required.out  |  0
> >  tests/qapi-schema/meson.build                 |  1 +
> >  8 files changed, 35 insertions(+), 18 deletions(-)
> >  create mode 100644 tests/qapi-schema/enum-if-first-required.err
> >  create mode 100644 tests/qapi-schema/enum-if-first-required.json
> >  create mode 100644 tests/qapi-schema/enum-if-first-required.out
>
> Thanks for the negative test.
>
> docs/devel/qapi-code-gen.rst section "Enumeration types" could perhaps
> use an update.
>
> It's less than clear even before the patch:
>
>     The generated C enumeration constants have values 0, 1, ..., N-1 (in
>     QAPI schema order), where N is the number of values.  There is an
>     additional enumeration constant PREFIX__MAX with value N.
>
>     Do not use string or an integer type when an enumeration type can do
>     the job satisfactorily.
>
>     The optional 'if' member specifies a conditional.  See `Configuring the
>     schema`_ below for more on this.
>
> The first paragraph can lead readers to assume we generate something
> like
>
>     typedef enum Example {
>         EXAMPLE_FOO = 0,
>     #if defined(COND)
>         EXAMPLE_BAR = 1,
>     #endif
>         EXAMPLE__MAX = 2,
>     } Example;
>
> We don't, because we'd have to deal with a "hole" in the value range
> when COND is not defined.
>
> Instead, we do
>
>     typedef enum Example {
>         EXAMPLE_FOO,
>     #if defined(COND)
>         EXAMPLE_BAR,
>     #endif
>         EXAMPLE__MAX,
>     } Example;
>
>

--000000000000b3c12806576e8313
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 25 lug 2026, 08:15 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; Prevent an all-zero struct from having different meanings with<br>
&gt; different configurations or builds of QEMU.<br>
<br>
This is a bit terse.=C2=A0 What *exactly* is broken?=C2=A0 Spelling this ou=
t<br>
matters, because it can expose holes in the argument, if any.</blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Nothing is broken;=
 it&#39;s just something that can have unexpected consequences...</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The numer=
ic encoding of enum values is irrelevant except for zero,<br>
because we actually use numeric zero via zero initialization.=C2=A0 If the<=
br>
enum&#39;s first value is conditional, the meaning of zero depends on build=
<br>
configuration.=C2=A0 We don&#39;t want such a default at the external inter=
face.<br>
It could conceivably lead to purely internal bugs, too.<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">... like these.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gm=
ail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Howe=
ver, I&#39;m not sure your solution fixes this problem completely.<br>
<br>
Consider type Arg with a mandatory member @mand and an optional enum<br>
member @opt, both of enum type ENUM_TYPE.<br>
<br>
QMP input gets converted to native C like this:<br>
<br>
=C2=A0 =C2=A0 if (!visit_type_Arg(v, NULL, &amp;arg, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 }<br>
<br>If @opt is absent, then arg.has_opt and arg.opt are both zero.<br>
<br>
Code providing an explicit default then is still fine:<br>
<br>
=C2=A0 =C2=A0 if (!arg.has_opt) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 arg.opt =3D ENUM_TYPE_MUMBLE;<br>
=C2=A0 =C2=A0 }<br>
<br>
But we often use arg.opt without checking arg.has_opt for brevity.=C2=A0 Th=
is<br>
is an implicit default to zero, whatever zero may mean.<br>
<br>
If the the optional enum&#39;s first member is conditional, this default<br=
>
depends on build configuration.<br>
<br>
Stupidest solution that could possibly work: an enum&#39;s first member<br>
cannot be conditional.<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">That would prevent an enum that is entirely compiled =
out, which seems like a plausibly desirable feature.=C2=A0</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Honestly I think this is a C problem, no=
t a QAPI problem. Skipping has_xx for bools that default to false is alread=
y borderline; doing it for enums is well into &quot;you shouldn&#39;t do it=
&quot; territory. Whereas &quot;unless you have mandatory pointer fields, g=
_malloc0(...) returns a valid *and portable* QAPI struct&quot; is in my opi=
nion supporting a desirable idiom.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Rust would spell it &quot;Default::default()&quot;; the language=
 can help rejecting it if you have mandatory string fields (it would recurs=
ively default boxed structs, unlike C) but it cannot do anything about port=
ability; this patch closes the gap completely for Rust, and does what it ca=
n for C.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Thoughts?</blockquote></div></div><div dir=3D"auto"><div class=3D"gmail_quo=
te gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt; This needs some changes to doc-good.json, which used unwittingly<br>
&gt; such an enum.<br>
&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/schema.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++++++<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 16 ++++++++--------<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 12 ++++++------<br>
&gt;=C2=A0 tests/qapi-schema/doc-good.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++----<br>
&gt;=C2=A0 tests/qapi-schema/enum-if-first-required.err=C2=A0 |=C2=A0 2 ++<=
br>
&gt;=C2=A0 tests/qapi-schema/enum-if-first-required.json |=C2=A0 6 ++++++<b=
r>
&gt;=C2=A0 tests/qapi-schema/enum-if-first-required.out=C2=A0 |=C2=A0 0<br>
&gt;=C2=A0 tests/qapi-schema/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 8 files changed, 35 insertions(+), 18 deletions(-)<br>
&gt;=C2=A0 create mode 100644 tests/qapi-schema/enum-if-first-required.err<=
br>
&gt;=C2=A0 create mode 100644 tests/qapi-schema/enum-if-first-required.json=
<br>
&gt;=C2=A0 create mode 100644 tests/qapi-schema/enum-if-first-required.out<=
br>
<br>
Thanks for the negative test.<br>
<br>
docs/devel/qapi-code-gen.rst section &quot;Enumeration types&quot; could pe=
rhaps<br>
use an update.<br>
<br>
It&#39;s less than clear even before the patch:<br>
<br>
=C2=A0 =C2=A0 The generated C enumeration constants have values 0, 1, ..., =
N-1 (in<br>
=C2=A0 =C2=A0 QAPI schema order), where N is the number of values.=C2=A0 Th=
ere is an<br>
=C2=A0 =C2=A0 additional enumeration constant PREFIX__MAX with value N.<br>
<br>
=C2=A0 =C2=A0 Do not use string or an integer type when an enumeration type=
 can do<br>
=C2=A0 =C2=A0 the job satisfactorily.<br>
<br>
=C2=A0 =C2=A0 The optional &#39;if&#39; member specifies a conditional.=C2=
=A0 See `Configuring the<br>
=C2=A0 =C2=A0 schema`_ below for more on this.<br>
<br>
The first paragraph can lead readers to assume we generate something<br>
like<br>
<br>
=C2=A0 =C2=A0 typedef enum Example {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXAMPLE_FOO =3D 0,<br>
=C2=A0 =C2=A0 #if defined(COND)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXAMPLE_BAR =3D 1,<br>
=C2=A0 =C2=A0 #endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXAMPLE__MAX =3D 2,<br>
=C2=A0 =C2=A0 } Example;<br>
<br>
We don&#39;t, because we&#39;d have to deal with a &quot;hole&quot; in the =
value range<br>
when COND is not defined.<br>
<br>
Instead, we do<br>
<br>
=C2=A0 =C2=A0 typedef enum Example {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXAMPLE_FOO,<br>
=C2=A0 =C2=A0 #if defined(COND)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXAMPLE_BAR,<br>
=C2=A0 =C2=A0 #endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXAMPLE__MAX,<br>
=C2=A0 =C2=A0 } Example;<br>
<br>
</blockquote></div></div></div>

--000000000000b3c12806576e8313--



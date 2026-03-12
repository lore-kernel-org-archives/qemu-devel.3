Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC21A106ACF4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 23:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0pHw-0007oQ-Cm; Thu, 12 Mar 2026 19:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w0pHv-0007oE-3a
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 19:17:55 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w0pHs-0002cY-4m
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 19:17:54 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82976220e97so921084b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 16:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773357470; cv=none;
 d=google.com; s=arc-20240605;
 b=UjfXw1kd61XkcPtz3wbJRSRtXcZSlZ2Wz0tIXS51VXCth8pk/mBrreKEGFs31mNOjA
 xLyiCxG+dWMmPar8lEq6EBTGsAIn07+5p7GA2lj0qRgT7+uKjZPK75kWCSzUlpMCn2Cr
 61ZtiQCautzblpsH9U2PjQcUW7bSSdxWCYR1Zws5RcjuM06TqcYz8whII3wL2wA3kYLT
 rjc8i77Ma7sgHTb3OPSjuv53TeLgrvxD8M/3MOdrAlzbS9PfT4SzY2OrmRuHn55YtLHd
 IFqdvU4jmoF7F0iA5w0hnGZJBDU4RFTwtV8EqVG9H/h3n5jJHQGAL29kSCYEpR8sL7Fl
 1AVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ck4cI1SQCDa/QU0vZ+Q5ACj2MXM/vnUowBy6AqJcwSQ=;
 fh=uZjA6eME2UYXWQGU+EK8sRcWyZEOpV51D9lL83dayHw=;
 b=f1CPgFqhM7G5JrcoSGij8jRk7BR1f/nNE80AM3fvvM2oCRGlDKPvBI3fI/madDtELa
 FnucRVnp8gwiZtgMTs+kt+mCj9FV0rXkmBpdaui5XLbeJG6AUX850rrrs95KybniQ6ag
 lSh1PO8pYMMBkfVeF4EgmPJ6awX6v/dV1+XQpLlrTkgs8i7KHquYZ50Z3+eCxCjCtQgs
 2TqXsrUy4R7XFyAfkCL46hlCo8wfUFkyqTm8fpNWG7b6b6dBTRy4S6JueU5NIycPqgWr
 J/cdUT1g+K4tpaNg+CiHiT1oF3QvhI1QihaN75/R3i4pDK+MsplAfYCRHWekyyCzcUUr
 L0qQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1773357470; x=1773962270;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ck4cI1SQCDa/QU0vZ+Q5ACj2MXM/vnUowBy6AqJcwSQ=;
 b=AXMKYSPM5vvTUfM546HLKIUvea8aATzTx0t4wZDTPlobwWyRsonhZ3n/5Y0Zl4RL/N
 7d8ATa12cEZmoj+elDlfY/pDai9+yXpc4Tq8jJ6AgcUhKFVWAKwqd4np6PaxR0Xyu5sI
 jA5QttOIMjzOOcoiSyCnZC5oILT8jE53yH335vFWN+ysFuer65NGHV93fkwtYDQkry3i
 Br0dHEv762MobEig0vqn/vpVgN/fLiAAVCfzhvyJzRZj1M0RqL51EqP5kvbDlUx0rP0J
 2mJ5GNgtC+5Cb1dl+U5AZnPVg4GnvEBduSzaLdAFq8+DYTgx1La2LyPF0byv6bNrrmSY
 c1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773357470; x=1773962270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ck4cI1SQCDa/QU0vZ+Q5ACj2MXM/vnUowBy6AqJcwSQ=;
 b=mNCX+0vzEc7/7CoG7zfLyYBUP4yS3h3e+Y/pOBWW1yJhpA+EpErSeSwHTQ4papRs/c
 AhOcP7HsSXIYxRm44hMtoNsuWN6SaEtmLz/77pUuD9Y92+5QPHUVANZV+E5/Veczg96O
 lE+NlTn2TSTRIJRwA7JTUcq12Ybyd0O+GzYx1pR58Btmrl4a9EebXFPL+Yv/8kpLXdbv
 a8mpehepJbT+B1bIfWsqKK+0NOIIuNBX+xufg5ZSdl3bubSJvVZ6SUNtS6iJ+Apt22UL
 vWlPdqJNe92QjafqBA7/f6aXEK3xLVuOXzpoC2yP3juzeDWnN3Ap4lMA18UyPnLwqDyG
 WrAQ==
X-Gm-Message-State: AOJu0YwPjduIFfG3e9LZeMizXI3P4Jg5r/itwgKX3EGjH5GEx73Axq8M
 pzRitmrlDbpaPVDjmL5tcsZntBoNNCjWbL8wlTSKBTt8DBDjZGPxj4IBEQHC4cHw5wr4kJFtVmp
 Y6h3PcubL8198bkakiDIhnKoX6k1qp66yWOdbPQWm+A==
X-Gm-Gg: ATEYQzyyNo2HmMb5uRnpQ93y13nbl0I1CUcaGO8M8bsw6XN9Ad2DNC9a2XBUZxGlGvg
 7OjwKrg9Xq+c+8rGGBDo4fiE+nc2FbcQTtBeZhFnxuoG/gWAaTxZDsDP7RQtg5Yzxvbl0+58otd
 vyPIfmLqY3CAIx7icnzTZC319BnOvO8ig2kM7EHHWW2R8sV1iv5Cqp7SE7ebqk7/3kYFXd7cAWH
 pS1EFK+SU0ePihrwanKk+1SXDUeDUyHMhL3W0MsZfrNgzRmWcqY/6mFv/xbZ3qyFAzzCd0H5s4N
 p3qN2aI=
X-Received: by 2002:a05:6a00:1585:b0:81f:4046:1490 with SMTP id
 d2e1a72fcca58-82a198c8b10mr704418b3a.44.1773357470195; Thu, 12 Mar 2026
 16:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260312-share-thunk-v1-1-2f36003a1913@bsdimp.com>
 <ffc224cc-72ed-49ee-93ea-8a28d220ae55@linaro.org>
 <CANCZdfo8cEp8_078o4bEwCo63vL+W5NW9ukeQR0nMACJBQXysw@mail.gmail.com>
 <68903178-92ef-4956-b815-dc4c4533507d@linaro.org>
In-Reply-To: <68903178-92ef-4956-b815-dc4c4533507d@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 12 Mar 2026 17:17:39 -0600
X-Gm-Features: AaiRm50ZDX7wUS-hNTUv2hOPSPJ1bbsgWF3EbX71ejCq823LVbfxj6hz_0es-w0
Message-ID: <CANCZdfqCu13nJysw3Rwhe7GJWzdSkstKCKkQAR7u0cJFOJaY-g@mail.gmail.com>
Subject: Re: [PATCH RFC] common-user: Share thunk.c between bsd-user and
 linux-user
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000123304064cdbf6fa"
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000123304064cdbf6fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:36=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> On 3/12/26 1:19 PM, Warner Losh wrote:
> >
> >
> > On Thu, Mar 12, 2026 at 11:52=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>>
> wrote:
> >
> >     On 3/12/26 6:10 AM, Warner Losh wrote:
> >      > thunk.c is the same between linux-user and bsd-user (out of tree=
),
> >      > so share it between the two.
> >      >
> >      > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.co=
m
> >>
> >      > ---
> >      > As part of upstream blitz bsd-user, I've discovered that bsd-use=
r
> and
> >      > linux-user have the same thunk.c file. Rather than copy it, put
> >     it into
> >      > the common-user directory and share it. It has to be compiled
> >      > per-target, unlike the rest of common-user, so modify linux-user
> and
> >      > bsd-user to grab it from there.
> >      > ---
> >      >   bsd-user/meson.build                | 1 +
> >      >   {linux-user =3D> common-user}/thunk.c | 0
> >      >   linux-user/meson.build              | 2 +-
> >      >   3 files changed, 2 insertions(+), 1 deletion(-)
> >      >
> >
> >     Indeed, thunk.c seems to be highly target specific.
> >     A good solution would be to move common functions to common-user/
> >     thunk.c
> >     and the rest in include/user/thunk.h. It may be cleaner than doing
> the
> >     meson hack. Or leave it duplicated for now, except if you plan on
> >     modifying it.
> >
> >
> > My concern with leaving it duplicated is the process. I create a patch
> > to create
> > bsd-user/thunk.c that's a verbatim copy of linux-user/thunk.c. Despite
> > putting in
> > my cover that this is copied code, if past is prologue, then I'll be
> > asked to fix the
> > copyright and style, plus lots of suggestions to improve the code. But
> > it's just a
> > verbatim copy, so that's a lot of hassle just to copy it.
> >
>
> I understand, and it's a good intention to want to remove this
> duplication. However, I'm not convinced a build system hack is better
> than a duplication.
>

Yup, if it were frictionless to duplicated, I'd just do that. But there's
always
some hassle or another that comes from it. And it's a dependency on doing
the ioctl round of upstreaming.


> > Moving like this, though, is almost 0 friction. A small tweak to meson
> > is all that's
> > needed. I suppose I could do the #include "../linux-user/trunk.c" trick
> > to make it
> > less ugly in the build system, but then it's not clear it's shared, etc
> > and more ugly
> > in the code, imho.
> >
>
> Yes, it's a hack, that's what it's for, "quick and that works but not a
> proper solution".
>
> > I tried to move this stuff into thunk.h as much as possible so we could
> > have one
> > compilation, and that didn't work. It really assumes that it can includ=
e
> > qemu.h for
> > the tswap, etc macros. So it's impossible to just build once.
> >
>
> Yes, not all functions can be compiled once because they have target
> dependencies. That's why I invited you to simply extract common
> functions to common-user/thunk.c and leave the target specific bits in
> thunk.h (with static inline functions), or in a thunk-target.h header if
> you really want to do it cleanly. That's the proper solution here.
>
> Build systems and preprocessor are not a shortcut to proper software
> architecture, even though QEMU abused both of them to this end.
>

Yea. I'm looking for a reasonable tradeoff. I'm open to suggestions, and am
even willing to split things up: "now the hack, I'll remove it within a
year" sort
of thing just to get this years-long process of upstreaming done.


> > Now looking at the code, a lot of it would be a lot simpler with
> > 'Generic', but that's
> > a battle for another day. As is the notion of just generating this data
> > from the .h files
> > rather than hard-coding it here, but that too is a battle for another
> > day. I'd like to
> > get this upstreamed so I'm spending my time on these sorts of battle.s
> >
>
> I totally get it, and we have been dealing with a lot of things like
> this for the single-binary topic, trying to find the good compromises
> between refactoring APIs and doing limited changes.
>
> If extracting the common and target part looks like too much work, just
> leave it and simply change the copyright header, it's not a big thing to
> do, and you can modify both in the same series, no one will yell at you
> for changing comments in one file in linux-user.
>

Yea. You should have seen the pushback I got from changing the copyright
header when I had the permissions to do it....  If I copy the file, it's a
full copy, verbatim, no changes. It's not my code, so I can't change
things.  I have a similar issue from some code I plan on copying from
FreeBSD to avoid having to chase the strace.list stuff. Since I can easily
hack upstream FreeBSD to be what I need for qemu, I'll evolve things there
(ideally, just making it a private library I can hook into the bsd-user
build for tracing so qemu gets whatever FreeBSD does in truss for free...

But maybe the next round is all but the ioclts and see if some other
solution can be found in the interim.

Or maybe I'll find the right people that can sign off on 'just copy it' so
I can get on with things :)


> As you said, pick up the right battles and ignore the rest.
>

Yea. Maybe the next round will just be the simple stuff w/o battles....


> > Warner
>
> Regards,
> Pierrick
>

--000000000000123304064cdbf6fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12,=
 2026 at 4:36=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bo=
uvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 3/12/26 1:19 PM, Warner Los=
h wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Mar 12, 2026 at 11:52=E2=80=AFAM Pierrick Bouvier <br>
&gt; &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org" target=3D"_blank">p=
ierrick.bouvier@linaro.org</a> &lt;mailto:<a href=3D"mailto:pierrick.bouvie=
r@linaro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;&gt; wro=
te:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 3/12/26 6:10 AM, Warner Losh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; thunk.c is the same between linux-user and bs=
d-user (out of tree),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; so share it between the two.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Warner Losh &lt;<a href=3D"mai=
lto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a> &lt;mailto:<a href=
=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; As part of upstream blitz bsd-user, I&#39;ve =
discovered that bsd-user and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; linux-user have the same thunk.c file. Rather=
 than copy it, put<br>
&gt;=C2=A0 =C2=A0 =C2=A0it into<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the common-user directory and share it. It ha=
s to be compiled<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; per-target, unlike the rest of common-user, s=
o modify linux-user and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; bsd-user to grab it from there.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0bsd-user/meson.build=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0{linux-user =3D&gt; common-user}/=
thunk.c | 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0linux-user/meson.build=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A03 files changed, 2 insertions(+),=
 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Indeed, thunk.c seems to be highly target specific.=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0A good solution would be to move common functions t=
o common-user/<br>
&gt;=C2=A0 =C2=A0 =C2=A0thunk.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0and the rest in include/user/thunk.h. It may be cle=
aner than doing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0meson hack. Or leave it duplicated for now, except =
if you plan on<br>
&gt;=C2=A0 =C2=A0 =C2=A0modifying it.<br>
&gt; <br>
&gt; <br>
&gt; My concern with leaving it duplicated is the process. I create a patch=
 <br>
&gt; to create<br>
&gt; bsd-user/thunk.c that&#39;s a verbatim copy of linux-user/thunk.c. Des=
pite <br>
&gt; putting in<br>
&gt; my cover that this is copied code, if past is prologue, then I&#39;ll =
be <br>
&gt; asked to fix the<br>
&gt; copyright and style, plus lots of suggestions to improve the code. But=
 <br>
&gt; it&#39;s just a<br>
&gt; verbatim copy, so that&#39;s a lot of hassle just to copy it.<br>
&gt;<br>
<br>
I understand, and it&#39;s a good intention to want to remove this <br>
duplication. However, I&#39;m not convinced a build system hack is better <=
br>
than a duplication.<br></blockquote><div><br></div><div>Yup, if it were fri=
ctionless to duplicated, I&#39;d just do that. But there&#39;s always</div>=
<div>some hassle or another that comes from it. And it&#39;s a dependency o=
n doing</div><div>the ioctl round of upstreaming.</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Moving like this, though, is almost 0 friction. A small tweak to meson=
 <br>
&gt; is all that&#39;s<br>
&gt; needed.=C2=A0I suppose I could do the #include &quot;../linux-user/tru=
nk.c&quot; trick <br>
&gt; to make it<br>
&gt; less ugly in the build system, but=C2=A0then it&#39;s not clear it&#39=
;s shared, etc <br>
&gt; and more ugly<br>
&gt; in the code, imho.<br>
&gt;<br>
<br>
Yes, it&#39;s a hack, that&#39;s what it&#39;s for, &quot;quick and that wo=
rks but not a <br>
proper solution&quot;.<br>
<br>
&gt; I tried to move this stuff into thunk.h as much as possible so we coul=
d <br>
&gt; have one<br>
&gt; compilation, and that didn&#39;t work. It really assumes that it can i=
nclude <br>
&gt; qemu.h for<br>
&gt; the tswap, etc macros. So it&#39;s impossible to just build once.<br>
&gt;<br>
<br>
Yes, not all functions can be compiled once because they have target <br>
dependencies. That&#39;s why I invited you to simply extract common <br>
functions to common-user/thunk.c and leave the target specific bits in <br>
thunk.h (with static inline functions), or in a thunk-target.h header if <b=
r>
you really want to do it cleanly. That&#39;s the proper solution here.<br>
<br>
Build systems and preprocessor are not a shortcut to proper software <br>
architecture, even though QEMU abused both of them to this end.<br></blockq=
uote><div><br></div><div>Yea. I&#39;m looking for a reasonable tradeoff. I&=
#39;m open to suggestions, and am</div><div>even willing to split things up=
: &quot;now the hack, I&#39;ll remove it within a year&quot; sort</div><div=
>of thing just to get this years-long process of upstreaming done.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Now looking at the code, a lot of it would be a lot simpler with <br>
&gt; &#39;Generic&#39;, but that&#39;s<br>
&gt; a battle for another day. As is the notion of just generating this dat=
a <br>
&gt; from the .h files<br>
&gt; rather than hard-coding it here, but that too is a battle for another =
<br>
&gt; day. I&#39;d like to<br>
&gt; get this upstreamed so I&#39;m spending my time on these sorts of batt=
le.s<br>
&gt;<br>
<br>
I totally get it, and we have been dealing with a lot of things like <br>
this for the single-binary topic, trying to find the good compromises <br>
between refactoring APIs and doing limited changes.<br>
<br>
If extracting the common and target part looks like too much work, just <br=
>
leave it and simply change the copyright header, it&#39;s not a big thing t=
o <br>
do, and you can modify both in the same series, no one will yell at you <br=
>
for changing comments in one file in linux-user.<br></blockquote><div><br><=
/div><div>Yea. You should have seen the pushback I got from changing the co=
pyright header when I had the permissions to do it....=C2=A0 If I copy the =
file, it&#39;s a full copy, verbatim, no changes. It&#39;s not my code, so =
I can&#39;t change things.=C2=A0 I have a similar issue from some code I pl=
an on copying from FreeBSD to avoid having to chase the strace.list stuff.=
=C2=A0Since I can easily hack upstream FreeBSD to be what I need for qemu, =
I&#39;ll evolve things there (ideally, just making it a private library I c=
an hook into the bsd-user build for tracing so qemu gets whatever FreeBSD d=
oes in truss for free...</div><div><br></div><div>But maybe the next round =
is all but the ioclts and see if some other solution can be found in the in=
terim.</div><div><br></div><div>Or maybe I&#39;ll find the right people tha=
t can sign off on &#39;just copy it&#39; so I can get on with things :)</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
As you said, pick up the right battles and ignore the rest.<br></blockquote=
><div><br></div><div>Yea. Maybe the next round will just be the simple stuf=
f w/o battles....=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
&gt; Warner<br>
<br>
Regards,<br>
Pierrick<br>
</blockquote></div></div>

--000000000000123304064cdbf6fa--


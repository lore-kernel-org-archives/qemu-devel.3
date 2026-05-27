Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19281CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSF8f-0000eo-0H; Wed, 27 May 2026 10:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSF8a-0000eR-Uc
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:21:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSF8X-0001BY-F7
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:21:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-83ec36a13e9so5947045b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 07:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779891691; cv=none;
 d=google.com; s=arc-20240605;
 b=QP7ifdXbUYaEpAe4Lvx/+O7g/Lk1DSjHXz9G0sCIE8pGoGVObxtOhC4fugiBLyWQC/
 cM5W6e2Nw1h4MhRYWYFGtoUR2ujakrDwqzpEL7qmUCd8nq91WeaiPz9l8nwT+HNzzAIg
 btXGZcC64JHuDERiheCxc4Ac+OgzIOgOxkKcrkLBUeXMjRd/OjevzSJyiMbhT6/XNXRv
 XYol7G+O5Ix3Vf9sNR0HKoBMKslwIVaZ1OgXUcsRzUe8t3vggyz2mJMmBznJu1omoqyX
 H4/DBeX2pnvjkR9MNzckN2Tim15xPNOAyYuB9qBVvKlB6xh4KyQ2ti1DJBoQn8TAMVc6
 5Dyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aNgjCUsPEUjV73k3KZBhBGwp0bvjxfz/rzbca0WF5Mw=;
 fh=isQdjMRPZp8F/r7qXmLvAoobbWQEpdTf53DkMXQaERA=;
 b=Vi7ctxoZDA4Lwd+2qf1OAZnTRI9yxD/UkGvpbNUja7DCnAyHfw4cLV9B7bndYf4j37
 N2MWIVL8PZZ63rrFOH6HWWjXXsp2bCEm0RPoAWLtrqL+nJ9DU8NVIAoJSW0M40UJHoDJ
 r+JTttABtJaoFtyyqM4qjxxjnU7/ickPWIuKSorstK3Ic9l3jfrtvUIwK67/pq+4IIlp
 jYa0lwgCrY1LCgJxC++o+AgBCpqTMeJy2sUc/Ks5RgXm0xMJov/5Yw+VWVSPahA9wl1p
 wA6uN0fA4eCqsLx6X/8rEHQfaUq5oQhQC/qoITb+/qRhZkEZ6FWU9SQQkKnwEXsqq2YL
 FkFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779891691; x=1780496491;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aNgjCUsPEUjV73k3KZBhBGwp0bvjxfz/rzbca0WF5Mw=;
 b=Lvz8lM3dKqspHwh1N8Ymps4RluWgXzKODeiHjc6sYG57ZvQwcJPgOSwFIVUF2muc2O
 dtLafvcDaWENeWRGWqPytwCqqjp0TOAFqHLt49piClJ4ALqoXTO1u9ms1IDD4WHt73cX
 q6LzfJwqA1slBZVU8Fa6ew5iKmuF9FIR8zpPq0i+6ByDbH0GIwbdsSZsNkwCWG3gGFed
 WE5FzMG697xJVB/fyibIrpYTzSbx9AvYr7DE8EqXRKNVCwrwI0//iDUNHS+WvVKzijwF
 ULFyrGzgeMF9aj2JqySEQfG7QTlvacBmCJE7UoOBIKSzOkgn1JfpufbWpkl1WuOIss0S
 OIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779891691; x=1780496491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNgjCUsPEUjV73k3KZBhBGwp0bvjxfz/rzbca0WF5Mw=;
 b=Ep/DNiJezGFOLSQT7QGW05NZ8ooAwAAzkw2+dGz5kSy1JbVQ/s3GVrVuFrtNhLRTkw
 ZdZTY9juuOrhmpTXCgTUOOT6uoyAETYVzX38YAUB+yV7Vh6SVH659o09mHXABuV4q7i2
 yc079mTvxKiQFktrWxyClgOCbyAZZS+peWN5DvfElf3dRbSrOYuTpmK3F3uEPNlgQTQ1
 x2NhiKukdWTR5KUdJwlbRR+BmsXdli4kFKrugOyHbMAN79x3PdYIbRdN/iizCfgmRt5N
 03m7KFjakKn7aLvQrm9Dc8R3wiMgyIetVL5bDvNFeNbaqryQTSTMjZM1j/Z7Npr+hxJB
 bu2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TEv+Z6gsPzKAoAbiJYdE2yEPlEN+Vr2DuMgMIfT5bc1kDGqyFGSB53iwZ5BHzySlqgQOKMQkheR5v@nongnu.org
X-Gm-Message-State: AOJu0YzuZIpfHxpy57R8xwtsPf0fXhcDnFqxnleq9RTeG2AeoY5t3EsN
 wHBz7xl2qE9RKPW730+ya8uJWf/NrfSclDW8yliVrr+GL/vguh6askzTPktghY5xg5MOdTG2BNw
 CVbJiIyUxx4GSiqSivvs8kWZ+WsEHgAIYMPLisd1YOQ==
X-Gm-Gg: Acq92OHZlFkUs26wm2LE0DbsEoSbMTYwOAwq//Ksn/zrWttNnEOw5WEYFlvCU20wbCG
 NkPZypYPPt0T1P2utTu1ZR/I6Kk8wBRwu07GcklTjLKwQUCVKmNs1C6pYpSTSOwYv+OQepEVPA4
 72izPgJv6U1l5gl5NadmCj862AAO69hIrtyBniNuHJNKIubdkffzksLv9o5tMWhbFkgT1e0ESWN
 M+QkDpBF/TCx/Lo/b3U6N+K0XSqiXQ7R1/4aJrmnrLqo3GF6/sJ+r96dBHkmgJTHHdPAlILwIl7
 9dWGAq19CnhSTqMJGQ==
X-Received: by 2002:a05:6a00:a29:b0:838:1c02:2763 with SMTP id
 d2e1a72fcca58-8415f1db6f1mr23327988b3a.9.1779891691098; Wed, 27 May 2026
 07:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com> <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CAKmqyKOsdJYbh8SAvzpv3rpF7TUE68sHR34rDy8sc+d=j1L9vw@mail.gmail.com>
In-Reply-To: <CAKmqyKOsdJYbh8SAvzpv3rpF7TUE68sHR34rDy8sc+d=j1L9vw@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 27 May 2026 08:21:19 -0600
X-Gm-Features: AVHnY4LsdLNxPpi1f1SxjzH_sANZNdpGHlmTitiZK0XJPPmV36lmnCj0iRuaDDs
Message-ID: <CANCZdfp4OQEoOQk5v0B+n8GaOb1a=FiLjLy9jGG9G_AWY79xNA@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Alistair Francis <alistair23@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000fca84f0652cd5360"
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42b.google.com
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

--000000000000fca84f0652cd5360
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 4:54=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Wed, May 27, 2026 at 8:02=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On 5/27/26 10:41, Kevin Wolf wrote:
> > > Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:
> > >> The QEMU Project currently may accept limited uses of AI that produc=
e
> > >> high quality patches that are limited in the creative content added.
> > >> While maintainers will ultimately decide, changes like the following
> > >> fall within this policy
> > >> 1. Fixing obvious warnings in the obvious ways suggested by the tool
> > >> 2. Tree wide API changes, and other similar mechanical changes done
> > >>     today with perl/python/sed/coccinelle
> > >
> > > As I said in the paragraph you quoted below, I don't think we should
> > > encourage using AI for tasks that a deterministic tool could do.
> >
> > In some cases such a tool does not exist.  Much to my surprise, there i=
s
> > no tool to do static type inference on Python code, but AI is very good
> > at doing it.
> >
> > > Letting AI perform the change directly instead may be an acceptable
> > > shortcut for a one-man hobby project that nobody else will ever look
> at,
> > > but in the context of a community project like QEMU in which your
> > > changes have to be reviewed and understood by others, it matters a lo=
t
> > > that the output of the tool is reproducible. Otherwise, you're creati=
ng
> > > unnecessary work for others, and that isn't acceptable.
> >
> > When applicable, going through coccinelle (with the aid of AI if needed=
!
> > is indeed a good middle ground as it helps reviewers for large changes.
> > If you have many slightly different but easily separated changes (e.g.
> > you can split the patch by struct field), it may make things worse.
> >
> > Its also worth noting that in other cases even sed or coccinelle, while
> > deterministic, cannot produce 100% of the patch.
> >
> > > So maybe we should even explicitly mention a recommendation like the
> > > following:
> > >
> > >      If you can use a deterministic tool, don't use AI instead. If yo=
u
> > >      don't know how to use the deterministic tool, use the AI to tell
> you
> > >      how to use it instead of trying to replace it.
> >
> > I like it.
> >
> > >> 3. Limited, small changes to fix bugs or add a small new feature who=
se
> > >>     scope is less than about 100 lines and the originator can explai=
n
> > >>     them all or the meta issues about the patch.
> > >
> > > Not sure if mentioning a number of lines is wise. 100 lines can be
> > > mostly boilerplate and simple sequential code or they can be a deeply
> > > nested complex algorithm.
> >
> > I'd put the threshold at 20-50 at most.
> >
> > > I think I would see more use in a tag like (better name welcome):
> > >
> > >     AI-used-for: [code|tests|docs|commit message]...
> >
> > I like this *a lot*.  No need for free advertisement, but some
> > traceability is useful.
> >
> > For tools such as sed or coccinelle, having the exact script in the
> > patch or commit message useful.  Plus, the execution of the script more
> > or lesss delimits the commit by itself (or 90%+ of it).  For LLMs it's =
a
> > bit less clear cut because separating docs makes little sense.  And the
> > exact model is pointless, it will be obsolete in 6 months and provide n=
o
> > useful information.
> >
> > So, something like:
> >
> > ------------------- 8< -------------------
> > Use of AI-generated content
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > The QEMU project currently allows using AI/LLM tools to produce patches
> > in scenarios with limited creative content:
> >
> > Mechanical changes
> >    If you can use a deterministic tool or a script, don't use AI instea=
d.
> >    If you don't know how to do the change deterministically, you may
> >    ask the AI for help, rather than having it stand in for the tools.
> >
> > Small bug fixes
> >    These should be limited to 20 lines of code or less, not including
> >    tests.  You are still expected to understand and explain your change=
s
> >    and the rationale behind them.
>
> Coming back to Peter's earlier comments and the Zig policy, one thing
> we have in RISC-V is people are running AI tools against QEMU and the
> RISC-V spec to identify places where we don't meet the spec. They then
> write patches and submit them upstream. The patches appear human
> written, so have been accepted.
>

I have a checklist for bsd-user changes that checks the common mistakes
around the lock_user family of interfaces. I've generated patches from
what claude found, but claude's patches were generally identical to
what I produced.


> A lot of the bugs found are corner cases that people aren't actually
> hitting. From my use of AI review systems in the past, they do tend to
> be very nit-picky. So it's not too hard to catch issues that users
> won't actually hit and fix them. It's a valid fix, but easy to
> inundate reviewers. If this process was entirely run by an LLM it
> could be way too much.
>

My experience is that claude found 150 or so "bugs". All were "legit" in
the sense the APIs were used wrong, but maybe 10 were actual critical
bugs that explained some, but not all, of the mysterious hangs we see.
My worry has been one of testing: how do I test it all? Or do I continue
to use the 'just build thousands of packages' as the acid test?


> So maybe we should add something here about don't send large numbers
> of "small bug fix" patches. So someone doesn't point an AI at QEMU and
> a spec and generate huge numbers of patches, all of which are just
> small bug fixes.
>

Wouldn't this concern fall under the general requirement to not send more
than a manageable number of patches at a time (like 50)? Or do you think
a lower number is warranted?

Warner


> Alistair
>
> >
> > These boundaries do not apply to other uses of AI, such as researching
> > APIs or algorithms, static analysis, or debugging, provided their outpu=
t
> > is not included in contributions.  Larger uses of AI are allowed as an
> > experiment, but they should be agreed upon with the maintainer prior to
> > submission.
> >
> > Use of AI does not remove the need for authors to comply with all other
> > requirements for contribution.  In particular, the "Signed-off-by"
> > label in a patch submission is a statement that the author takes
> > responsibility for the entire contents of the patch, certifying that
> > their patch submission is made in accordance with the rules of the
> > `Developer's Certificate of Origin (DCO) <dco>`.
> >
> > Commit messages for AI-assisted changes
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > When AI/LLM tools produce or substantively shape your patch, add an
> > ``AI-used-for:`` trailer.  The text of the trailer could be one or more
> > of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> > explanation in parentheses::
> >
> >      AI-used-for: tests, docs
> >      AI-used-for: code
> >      AI-used-for: code (refactoring)
> >      AI-used-for: code (prototype)
> >      AI-used-for: research
> >
> > The trailer is intended as a clarification of your DCO obligations as
> > well as to guide reviewers.  It is not intended for minimal presence
> > such as autocomplete or asking for a pre-review of the patch, and it
> > does not remove your responsibility to understand the changes that you
> > are submitting.
> >
> > Include the prompt in the commit message if it helps a reviewer judge
> > the result:
> >
> > * yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> > function already has a local variable or parameter of type ``struct
> > bb``, use it instead of accessing ``aa.bb``."
> >
> > * yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``,
> > forwarding the member functions to ``T`` while taking the lock around
> > the calls".
> >
> > * no: "write user-facing documentation for the new tool"
> >
> > * no: "write testcases for the new functions"
> >
> > Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> > the trailer, but should be mentioned in the commit message.
> >
> >
>

--000000000000fca84f0652cd5360
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 27,=
 2026 at 4:54=E2=80=AFAM Alistair Francis &lt;<a href=3D"mailto:alistair23@=
gmail.com">alistair23@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Wed, May 27, 2026 at 8:02=E2=80=AFPM Pa=
olo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pb=
onzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 5/27/26 10:41, Kevin Wolf wrote:<br>
&gt; &gt; Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:<br>
&gt; &gt;&gt; The QEMU Project currently may accept limited uses of AI that=
 produce<br>
&gt; &gt;&gt; high quality patches that are limited in the creative content=
 added.<br>
&gt; &gt;&gt; While maintainers will ultimately decide, changes like the fo=
llowing<br>
&gt; &gt;&gt; fall within this policy<br>
&gt; &gt;&gt; 1. Fixing obvious warnings in the obvious ways suggested by t=
he tool<br>
&gt; &gt;&gt; 2. Tree wide API changes, and other similar mechanical change=
s done<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0today with perl/python/sed/coccinelle<br>
&gt; &gt;<br>
&gt; &gt; As I said in the paragraph you quoted below, I don&#39;t think we=
 should<br>
&gt; &gt; encourage using AI for tasks that a deterministic tool could do.<=
br>
&gt;<br>
&gt; In some cases such a tool does not exist.=C2=A0 Much to my surprise, t=
here is<br>
&gt; no tool to do static type inference on Python code, but AI is very goo=
d<br>
&gt; at doing it.<br>
&gt;<br>
&gt; &gt; Letting AI perform the change directly instead may be an acceptab=
le<br>
&gt; &gt; shortcut for a one-man hobby project that nobody else will ever l=
ook at,<br>
&gt; &gt; but in the context of a community project like QEMU in which your=
<br>
&gt; &gt; changes have to be reviewed and understood by others, it matters =
a lot<br>
&gt; &gt; that the output of the tool is reproducible. Otherwise, you&#39;r=
e creating<br>
&gt; &gt; unnecessary work for others, and that isn&#39;t acceptable.<br>
&gt;<br>
&gt; When applicable, going through coccinelle (with the aid of AI if neede=
d!<br>
&gt; is indeed a good middle ground as it helps reviewers for large changes=
.<br>
&gt; If you have many slightly different but easily separated changes (e.g.=
<br>
&gt; you can split the patch by struct field), it may make things worse.<br=
>
&gt;<br>
&gt; Its also worth noting that in other cases even sed or coccinelle, whil=
e<br>
&gt; deterministic, cannot produce 100% of the patch.<br>
&gt;<br>
&gt; &gt; So maybe we should even explicitly mention a recommendation like =
the<br>
&gt; &gt; following:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 If you can use a deterministic tool, don&#39;=
t use AI instead. If you<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 don&#39;t know how to use the deterministic t=
ool, use the AI to tell you<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 how to use it instead of trying to replace it=
.<br>
&gt;<br>
&gt; I like it.<br>
&gt;<br>
&gt; &gt;&gt; 3. Limited, small changes to fix bugs or add a small new feat=
ure whose<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0scope is less than about 100 lines and the=
 originator can explain<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0them all or the meta issues about the patc=
h.<br>
&gt; &gt;<br>
&gt; &gt; Not sure if mentioning a number of lines is wise. 100 lines can b=
e<br>
&gt; &gt; mostly boilerplate and simple sequential code or they can be a de=
eply<br>
&gt; &gt; nested complex algorithm.<br>
&gt;<br>
&gt; I&#39;d put the threshold at 20-50 at most.<br>
&gt;<br>
&gt; &gt; I think I would see more use in a tag like (better name welcome):=
<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0AI-used-for: [code|tests|docs|commit message].=
..<br>
&gt;<br>
&gt; I like this *a lot*.=C2=A0 No need for free advertisement, but some<br=
>
&gt; traceability is useful.<br>
&gt;<br>
&gt; For tools such as sed or coccinelle, having the exact script in the<br=
>
&gt; patch or commit message useful.=C2=A0 Plus, the execution of the scrip=
t more<br>
&gt; or lesss delimits the commit by itself (or 90%+ of it).=C2=A0 For LLMs=
 it&#39;s a<br>
&gt; bit less clear cut because separating docs makes little sense.=C2=A0 A=
nd the<br>
&gt; exact model is pointless, it will be obsolete in 6 months and provide =
no<br>
&gt; useful information.<br>
&gt;<br>
&gt; So, something like:<br>
&gt;<br>
&gt; ------------------- 8&lt; -------------------<br>
&gt; Use of AI-generated content<br>
&gt; ~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
&gt;<br>
&gt; The QEMU project currently allows using AI/LLM tools to produce patche=
s<br>
&gt; in scenarios with limited creative content:<br>
&gt;<br>
&gt; Mechanical changes<br>
&gt;=C2=A0 =C2=A0 If you can use a deterministic tool or a script, don&#39;=
t use AI instead.<br>
&gt;=C2=A0 =C2=A0 If you don&#39;t know how to do the change deterministica=
lly, you may<br>
&gt;=C2=A0 =C2=A0 ask the AI for help, rather than having it stand in for t=
he tools.<br>
&gt;<br>
&gt; Small bug fixes<br>
&gt;=C2=A0 =C2=A0 These should be limited to 20 lines of code or less, not =
including<br>
&gt;=C2=A0 =C2=A0 tests.=C2=A0 You are still expected to understand and exp=
lain your changes<br>
&gt;=C2=A0 =C2=A0 and the rationale behind them.<br>
<br>
Coming back to Peter&#39;s earlier comments and the Zig policy, one thing<b=
r>
we have in RISC-V is people are running AI tools against QEMU and the<br>
RISC-V spec to identify places where we don&#39;t meet the spec. They then<=
br>
write patches and submit them upstream. The patches appear human<br>
written, so have been accepted.<br></blockquote><div><br></div><div>I have =
a checklist for bsd-user changes that checks the common mistakes</div><div>=
around the lock_user family of interfaces. I&#39;ve generated patches from<=
/div><div>what claude found, but claude&#39;s patches were generally identi=
cal to</div><div>what I produced.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
A lot of the bugs found are corner cases that people aren&#39;t actually<br=
>
hitting. From my use of AI review systems in the past, they do tend to<br>
be very nit-picky. So it&#39;s not too hard to catch issues that users<br>
won&#39;t actually hit and fix them. It&#39;s a valid fix, but easy to<br>
inundate reviewers. If this process was entirely run by an LLM it<br>
could be way too much.<br></blockquote><div><br></div><div>My experience is=
 that claude found 150 or so &quot;bugs&quot;. All were &quot;legit&quot; i=
n</div><div>the sense the APIs were used wrong, but maybe 10 were actual cr=
itical</div><div>bugs that explained some, but not all, of the mysterious h=
angs we see.</div><div>My worry has been one of testing: how do I test it a=
ll? Or do I continue</div><div>to use the &#39;just build thousands of pack=
ages&#39; as the acid test?</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
So maybe we should add something here about don&#39;t send large numbers<br=
>
of &quot;small bug fix&quot; patches. So someone doesn&#39;t point an AI at=
 QEMU and<br>
a spec and generate huge numbers of patches, all of which are just<br>
small bug fixes.<br></blockquote><div><br></div><div>Wouldn&#39;t this conc=
ern fall under the general requirement to not send more</div><div>than a ma=
nageable number of patches at a time (like 50)? Or do you think</div><div>a=
 lower number is warranted?</div><div><br></div><div>Warner</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Alistair<br>
<br>
&gt;<br>
&gt; These boundaries do not apply to other uses of AI, such as researching=
<br>
&gt; APIs or algorithms, static analysis, or debugging, provided their outp=
ut<br>
&gt; is not included in contributions.=C2=A0 Larger uses of AI are allowed =
as an<br>
&gt; experiment, but they should be agreed upon with the maintainer prior t=
o<br>
&gt; submission.<br>
&gt;<br>
&gt; Use of AI does not remove the need for authors to comply with all othe=
r<br>
&gt; requirements for contribution.=C2=A0 In particular, the &quot;Signed-o=
ff-by&quot;<br>
&gt; label in a patch submission is a statement that the author takes<br>
&gt; responsibility for the entire contents of the patch, certifying that<b=
r>
&gt; their patch submission is made in accordance with the rules of the<br>
&gt; `Developer&#39;s Certificate of Origin (DCO) &lt;dco&gt;`.<br>
&gt;<br>
&gt; Commit messages for AI-assisted changes<br>
&gt; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
&gt;<br>
&gt; When AI/LLM tools produce or substantively shape your patch, add an<br=
>
&gt; ``AI-used-for:`` trailer.=C2=A0 The text of the trailer could be one o=
r more<br>
&gt; of ``code``, ``tests``, ``docs``, ``research``, possibly followed by a=
n<br>
&gt; explanation in parentheses::<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: tests, docs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: code<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: code (refactoring)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: code (prototype)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AI-used-for: research<br>
&gt;<br>
&gt; The trailer is intended as a clarification of your DCO obligations as<=
br>
&gt; well as to guide reviewers.=C2=A0 It is not intended for minimal prese=
nce<br>
&gt; such as autocomplete or asking for a pre-review of the patch, and it<b=
r>
&gt; does not remove your responsibility to understand the changes that you=
<br>
&gt; are submitting.<br>
&gt;<br>
&gt; Include the prompt in the commit message if it helps a reviewer judge<=
br>
&gt; the result:<br>
&gt;<br>
&gt; * yes: &quot;move field ``foo`` from ``struct aa`` to ``struct bb``.=
=C2=A0 If a<br>
&gt; function already has a local variable or parameter of type ``struct<br=
>
&gt; bb``, use it instead of accessing ``<a href=3D"http://aa.bb" rel=3D"no=
referrer" target=3D"_blank">aa.bb</a>``.&quot;<br>
&gt;<br>
&gt; * yes: &quot;add an implementation of the trait for ``Mutex&lt;T: MyTr=
ait&gt;``,<br>
&gt; forwarding the member functions to ``T`` while taking the lock around<=
br>
&gt; the calls&quot;.<br>
&gt;<br>
&gt; * no: &quot;write user-facing documentation for the new tool&quot;<br>
&gt;<br>
&gt; * no: &quot;write testcases for the new functions&quot;<br>
&gt;<br>
&gt; Deterministic tooling (sed, coccinelle, formatters) is out of scope fo=
r<br>
&gt; the trailer, but should be mentioned in the commit message.<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--000000000000fca84f0652cd5360--


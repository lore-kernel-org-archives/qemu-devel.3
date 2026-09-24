Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC78CC98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9qo7-0005sn-BQ; Thu, 24 Sep 2026 17:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x9qo5-0005sf-2U
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:16:41 -0400
Received: from mail-pj2-x17.google.com ([2607:f8b0:4864:39::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1x9qo1-0007ZT-32
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:16:40 -0400
Received: by mail-pj2-x17.google.com with SMTP id
 d9443c01a7336-2db18fe433fso756545ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 14:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790284595; cv=none;
 d=google.com; s=arc-20260327;
 b=Ec+fYiBjZbEYcapWUAXq4KYnBi83616gjaFp3aWEWDoFXsH1sYVN3ljytlqFCsy1Lh
 DBcF6VaVARzHxP4UiRzxkq8W4299i5z4o9JLs9EzkHw+/ME3agNoaYSsCleQMjNEdWkb
 FXm1XCNlLp6K4fhGxONaZ7kfZTvykj7NUG902BMuPownaZ6qLjrobuyB+D9MVcmDRn99
 qIwIh9oNWFmfPtiF5GlKQSoRPIljzf6svHvCPd4/vMqEdBwM9zSsklWTH7YLdN6C7VgT
 yEja0OsNEJgiphpnoGllvR/SjFGAVR52TJzzbr3/Px82xnCgUG5B84/bKxTb8ABr1Hsm
 07zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=15q7FxrYHoMQ/LCE8/v0pkhlE/NPN3ts7ELJKrKTZoQ=;
 fh=d949tRkHWDkl6mPwfyDsZh1H8MEyzts+d9rZIDigeu0=;
 b=KMkfPCJ1d7ZXHd/V2FwzvrZYpwYvvBRUi4IJkZgwS9XPmD+hZkKhFFM5gQF5iCuscQ
 PRmVv0mYJ434Z1fHaa3yrLUhUzPI8rF+pdzowZXoouYWoaLkbt4G9zicUMhhVgDpSQH/
 3/oNou2+5pX0H/cQvpru5i8loRY9z+lgfMdVYrr9aW6T9kaDVk9WdMD88nmHtu5dWH1B
 beYVGnPrOQT8m02qXw+aGwTvr2A5rHDdydTsmELOH2R2cJtPxDjv681FxOpBUVgpjWYa
 Kd+Mtmt+qx8266HodS3cMJ1EgzVtQA4YadgFDvXP2cO66N+fyTEqGhVa0b9h6t2mEnMp
 9E1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790284595; x=1790889395;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=15q7FxrYHoMQ/LCE8/v0pkhlE/NPN3ts7ELJKrKTZoQ=;
 b=nR9Ws9JOKG9XGb0P66g3K/tCHvmG1OqISoMv2wBFLR6o9x+/RT+up8FkG3A+QMfDfV
 eUCTMdFTGuhgQnk5Mv52GT2yW71luiiNmiLgr60oXJreUz7ug5Jzs7GerHX2GAhgTY7u
 KX5Y/pOhgttfAIl5xpXkY2m1imt0oRXIoEjZu1t8HK9M1/mx9STU+U9udC/2YDvzX0kB
 TPzTuab08Zzh95zQiEQlO4r51G/y0FnmwkKZaohbTbjh4h5QFF5CzT8OhVbWP2qc+rkr
 siZP5jZnZhUb3ZluwFXX60dtWmzDJESIK/CJ4BqYgBYadcwOEymSuPELN7g/OJN2BRkb
 e8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790284595; x=1790889395;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=15q7FxrYHoMQ/LCE8/v0pkhlE/NPN3ts7ELJKrKTZoQ=;
 b=Cld21RZRf/WxLZ5K3hVu94AWb1d06hcMerWOAetwGzyUGY13xOD3V13FlK/zSqt8gK
 yl3wmA0wsTMAWGJEYvrGiJMNs3rvRlOUz6Rl1NjU6lXVGaE5n6BuI/+7BrvBhbms+45+
 3R221a3JifThwxhECEQCvTEuQSfVxmD8YkU6E2QjgvTkh0gYEZrfdZYljpXRIQLb9+3K
 01Bb60RqIhV8eZkMKpfq4vzv6StfszWSImz3co8O8PjAyvozn9G5V8roj8k21a7uVQfM
 YBtVXmMwCaGtz6v2FR99HZZvm6U2CFBuZ1iVtAW2aiHnBG0Vzjf+2IgOWdIEz6x+Vh4I
 DveA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSNlyTToK7wJ/IaKwMCQCfAofARxVl5TpV+YZIyrNPRSWpk/OWf+xtafTdaCUt+UkC2G4PWOZkoxhT@nongnu.org
X-Gm-Message-State: AFuF++n4RMuCO5/RjvEhFuFtiTyFfurCc4OkXhnUBPsVYiNOlXFyE+lL
 A01d7erRQx+rsCtdGBrYbLbaNKwHB8YQhyhdbdyzBoo1FtBV/sI6qSe34Ko33B91zfwu2EU4sHg
 VMbcI8qx4KtRiZgQKPDwF+nzbtOO9A4bCP1S4+sidNA==
X-Gm-Gg: AYBFou0g+s3eblT3H1Uv1MBgqTCqGMiic5ABa/TTe8S9YKZBya26DL0eF7Lsk6dX4qB
 1VbWIivVkRoDzDJiIXeUPvrLy6Vo0zr5lHIBAqwZ/rNwgC8PnpuLI0cpSwLiRgHn0cNLGQxuZX1
 yKIKM9hQqQ+tqnNvcGUIDndtXXzLERIwnX64KD5WIBnubA+T6GJS9Spq9H1ii3W+kNL0eki8vRH
 VcnRe4JUrE8YclAK2KVZ+onQfSUCztShD3TIzjUYZnGfuGA6C9ggWbi6Q2oZx5VD928HEtFEepr
 ZwyHvaAmvA13xUQSCuPf2BV3mmyk1X56qnQtpdNwUk3oxgRwnNSwZrE=
X-Received: by 2002:a17:903:3c6b:b0:2dd:ad74:6d16 with SMTP id
 d9443c01a7336-2df7dc1e71fmr30345445ad.28.1790284594794; Thu, 24 Sep 2026
 14:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
 <arUJxE0F7Q3Cw5sk@redhat.com>
In-Reply-To: <arUJxE0F7Q3Cw5sk@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 24 Sep 2026 15:16:21 -0600
X-Gm-Features: AclHuK-gdyaAz1lgttpZKV1M3y10QKTMwOu5MMnx8wVpxk0L1Z_h1h1dZNjXgu8
Message-ID: <CANCZdfrTwfrK0wnuL2cPVF_9W2-8PXtJeHkgkTP+Uv2sT8s0Ng@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000051e2dc065c411d2e"
Received-SPF: none client-ip=2607:f8b0:4864:39::17;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj2-x17.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--00000000000051e2dc065c411d2e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:30=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Thu, Sep 24, 2026 at 12:46:41PM +0200, Kevin Wolf wrote:
> > Am 24.09.2026 um 11:29 hat Alex Benn=C3=A9e geschrieben:
> > > Kevin Wolf <kwolf@redhat.com> writes:
> > >
> > > > Am 21.09.2026 um 15:20 hat Daniel P. Berrang=C3=A9 geschrieben:
> > > >> On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini wrote:
> > > >> > +.. note:: **Use of AI does not remove the need for authors to
> comply
> > > >> > +          with all other requirements for contribution.**  In
> particular,
> > > >> > +          the ``Signed-off-by`` label in a patch submission is =
a
> statement
> > > >> > +          that the author takes responsibility for the entire
> contents of
> > > >> > +          the patch, certifying that their patch submission is
> made in
> > > >> > +          accordance with the rules of the :ref:`Developer's
> Certificate of
> > > >> > +          Origin (DCO) <dco>`.
> > > >> > +
> > > >> > +          Since a submitter cannot audit LLM output against its
> training
> > > >> > +          data, the DCO is paired with :ref:`metadata in the
> commit message
> > > >> > +          <ai-used-for>` about AI-generated parts.  The DCO
> still certifies
> > > >> > +          that the contributor has the legal right to submit
> code in general.
> > > >>
> > > >> I'm not a fan of this second paragraph, as that feels like it is
> undermining
> > > >> the DCO. That first sentence in particular is somewhat saying that
> the
> > > >> contributor does not have to think about plagarism and thed projec=
t
> is ok
> > > >> with that, and also implying that the DCO doesn't apply to the LLM
> output.
> > > >> This is both not OK in its implication of the project accepting so=
me
> > > >> liability, and then also contradicted by the next sentence.
> > > >>
> > > >> IMHO this paragraph should just be removed.  The first paragraph
> clearly
> > > >> states the DCO applies to the submission as a whole, and leaves al=
l
> liability
> > > >> for infringement on the contributor.
> > > >
> > > > I don't think making this the individual contributor's problem is
> great.
> > > > It's rather unfriendly towards contributors to expect them to certi=
fy
> > > > something that we all know they can't honestly certify.
> > >
> > > This is the current position with the DCO anyway. If the contributor
> has
> > > copy and pasted (and maybe adapted) from Stack Overflow they are stil=
l
> > > realistically the only person that can make that judgement.
> >
> > Yes, that's the current position with the DCO and the reasoning why we
> > said LLM output is unacceptable in submissions.
> >
> > The big difference is if I copy and pasted from Stack Overflow, I _know=
_
> > that I did that. If the LLM effectively does it for me, I don't know
> > that. The best I can do is check if I can find similar code elsewhere.
> >
> > So while I can certify with 100% confidence that I didn't manually copy
> > things for code that I wrote myself, I can't certify that code from
> > other sources, including LLMs, isn't copied from elsewhere. I can only
> > say that I didn't find any reason to suspect it's copied.
>
> > > > Our current AI policy was built on the assertion that it's
> impossible to
> > > > sign the DCO for AI output, and I think that's still right. A
> developer
> > > > can't certify the origin of something when they don't really know
> where
> > > > it comes from.
> > >
> > > It's certainly possible for LLMs to replicate copyright material but =
by
> > > far the biggest influence is the code *in the project* that shapes th=
e
> > > output. It is basically pattern matching and predicting after all.
> >
> > If there is one chunk of code that violates the copyright of someone,
> > you can't heal that just by having 1000 more chunks that are clean.
> >
> > > What level of reassurance the submitter needs to be able to certify
> with
> > > their DCO is up to them. We can't police it, like every other
> submission
> > > we rely in the submitters good faith representation of what they have
> > > done.
> >
> > The DCO doesn't talk about levels of reassurance. It talks about hard
> > facts, 100% confidence.
> >
> > And that I can't give you with LLM generated content. I can maybe give
> > you 99%, but never 100%.
>
> I appreciate you're speaking about licensing/copyright here, but more
> generally I think we're probably wrong in asserting that a human
> authored contribution can ever be said to be 100% safe to QEMU with
> a DCO signoff. It is risk mitigation, but not absolute.
>

Risk mititagion is the best you can hope for. People lie, people
accidentally
copy, etc. Maybe they infringe on a patent. You can never be 100%
sure.


> From a copyright POV, if we write the code ourselves we can have
> confidence we didn't copy it and thus licensing is likely OK (unless
> you inadvertantly memorized some previous code you saw and reproduced
> it too closely), but there are other legal aspects. Trademarks are
> one risk, since we reference lots of vendor's hardware features, but
> in practice this very rarely arises as a problem for projects, beyond
> the obvious areas like project name, logo, and other visible branding
> aspects. Software patents are the really big hidden trap that anyone
> could unintentionally fall foul of at any time and have caused high
> profile problems for projects periodically.
>

Even the memorized stuff is likely OK. It all depends. I have memorized
bubble sorts, but there's only so many ways to implement a bubble sort
so most bubble sorts don't enjoy much copyright protection.  Big tables of
numbers don't generally enjoy copyright protection, so are usually 100%
OK to copy.

Plus, LLMs generally don't copy code from random places. Some early
ones were subject to injection attacks, but newer ones tend to look at
surrounding code to adopt the repository's conventions. Is that copying?
Is that a risk? Probably not because it's likely "scenes a faire" which
is the doctrine sometimes the genre dictates that things be a certain
way (eg all murder mysteries have a victim and someone trying to
solve the crime).

If someone knows their employer has a patent that is likely to be
> restrictive for possible use in QEMU, then they shouldn't sign off
> or contribute code implementing something covered by the patent
> without the employer granting unrestricted use. We're certainly
> not expecting people to do searches for 3rd party patents though,
> so the DCO is not a 100% guarantee of risk elimination to QEMU.
>

In fact most companies, at least in the US, instruct their engineers
to not even bother with a patent search because if you look for it,
even if you don't find it, you can be held liable for triple damages
because it can become willful.


> We tolerate that risk because there is no practical action that a
> contributor can take to mitigate. Further many large tech companies
> have thus formed defensive pacts to de-fang the risk.
>

Yes. The actual legal landscape is such that it's hard to know for
sure what the level of risk is for any given action. While usually the
court will rule in a specific way, there are times it just doesn't, even
for what seem like similar facts. Unlike programming, there's an
element of randomness that you can't drive to 0.


> With this in mind, it is perhaps not that different to accept a little
> bit of uncertainty in risks of LLM unknowingly copying from training
> material or 3rd party incompatibly licensed code it happened to find
> while walking the web ?  The key is that users need to be diligent
> in their use of the tools, not reckless. Norms for what that means
> are still be established - the so called "clean room" or license
> laundering, re-impls of projects are a massively risky activity
> but are the exception.
>

And "clean room" procedures are no different whether a human
or an LLM performs them. They both produce a new work because
the abstraction to the idea (which isn't copyrightable) loses details,
creative choices, etc. And the implementation from that spec also makes
different creative choices, leaving little in common with the original.


> > > > If we decide that we don't care as much about the legal risks any
> more
> > > > and that we're willing to accept them to some extent, that should b=
e
> > > > explicitly reflected in the policy.
> > > >
> > > > It seems to me that the cleanest way to do it is to exempt correctl=
y
> > > > advertised (with 'AI-used-for:') AI output from the DCO requirement
> and
> > > > instead add to the 'AI-used-for:' definition some relaxed version o=
f
> it,
> > > > e.g. "I have reviewed the contribution for potential licensing issu=
es
> > > > and haven't found a reason to doubt that I have the rights to submi=
t
> > > > this AI generated content under the open source license indicated i=
n
> the
> > > > file". This is something that could realistically be certified by
> > > > contributors in good faith and also isn't just "anything goes", but
> of
> > > > course it still is weaker than the DCO.
>
> I like the idea of associating "AI-used-for" with an explicit
> statement like:
>
>   "By using 'AI-used-for', a contributor both identifies areas of
>    the patch that involved use of AI/LLM, and also attests that
>    their usage of AI/LLMs was in compliance with the policies
>    outlined in this document"
>
>
> Then we can add whatever guidance we want in the AI policy that
> steers people away from LLM usage patterns that we know would
> expose us to undesirable risk. Explicitly stating that we do
> not want LLMs used to "clean room" / "license launder" re-impl
> existing code is something we could include. Or guide that
> agents should not be given free access to live git repos to
> reduce change of direct copying ?
>

FreeBSD is struggling with these issues as well. There's a huge difference
in risk of someone one-shotting the process and sending the results off
w/o any critical thought and someone doing a series of a hundred or two
hundred prompts with careful thought, arguments about the design
trade offs, etc. Even leaving aside the copyright issues, the former has
a huge risk, most of it from technical debt, while the latter has a much
lower
risk: there's less risk of copying (and any copying may fall to de minimis)=
,
and the result is much better designed and put together. FreeBSD doesn't
yet have any good answers to share.

Honestly, the real risk here is that there's a new kind of 'free' software:
free as in free puppy, and you want to be careful which ones you accept.
The bigger liability to the project is accepting the wrong ones which
increase
technical debt over the finer points of copyright law that will really only
matter
if something is actually litigated, and then the thousands of contributors
randomly permuting different aspects of the code every few years also
launders the code, both in terms of technical debt, and in terms of
copyright
risk.

It's all about mitigating the risks that matter in the end.

Warner

--00000000000051e2dc065c411d2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 24,=
 2026 at 5:30=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Thu, Sep 24, 2026 at 12:46:41PM +020=
0, Kevin Wolf wrote:<br>
&gt; Am 24.09.2026 um 11:29 hat Alex Benn=C3=A9e geschrieben:<br>
&gt; &gt; Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D"_bla=
nk">kwolf@redhat.com</a>&gt; writes:<br>
&gt; &gt; <br>
&gt; &gt; &gt; Am 21.09.2026 um 15:20 hat Daniel P. Berrang=C3=A9 geschrieb=
en:<br>
&gt; &gt; &gt;&gt; On Mon, Sep 21, 2026 at 09:52:48AM +0200, Paolo Bonzini =
wrote:<br>
&gt; &gt; &gt;&gt; &gt; +.. note:: **Use of AI does not remove the need for=
 authors to comply<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with all other =
requirements for contribution.**=C2=A0 In particular,<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the ``Signed-of=
f-by`` label in a patch submission is a statement<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that the author=
 takes responsibility for the entire contents of<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the patch, cert=
ifying that their patch submission is made in<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 accordance with=
 the rules of the :ref:`Developer&#39;s Certificate of<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Origin (DCO) &l=
t;dco&gt;`.<br>
&gt; &gt; &gt;&gt; &gt; +<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Since a submitt=
er cannot audit LLM output against its training<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data, the DCO i=
s paired with :ref:`metadata in the commit message<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;ai-used-for=
&gt;` about AI-generated parts.=C2=A0 The DCO still certifies<br>
&gt; &gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 that the contri=
butor has the legal right to submit code in general.<br>
&gt; &gt; &gt;&gt; <br>
&gt; &gt; &gt;&gt; I&#39;m not a fan of this second paragraph, as that feel=
s like it is undermining<br>
&gt; &gt; &gt;&gt; the DCO. That first sentence in particular is somewhat s=
aying that the<br>
&gt; &gt; &gt;&gt; contributor does not have to think about plagarism and t=
hed project is ok<br>
&gt; &gt; &gt;&gt; with that, and also implying that the DCO doesn&#39;t ap=
ply to the LLM output.<br>
&gt; &gt; &gt;&gt; This is both not OK in its implication of the project ac=
cepting some<br>
&gt; &gt; &gt;&gt; liability, and then also contradicted by the next senten=
ce.<br>
&gt; &gt; &gt;&gt; <br>
&gt; &gt; &gt;&gt; IMHO this paragraph should just be removed.=C2=A0 The fi=
rst paragraph clearly<br>
&gt; &gt; &gt;&gt; states the DCO applies to the submission as a whole, and=
 leaves all liability<br>
&gt; &gt; &gt;&gt; for infringement on the contributor.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I don&#39;t think making this the individual contributor&#39=
;s problem is great.<br>
&gt; &gt; &gt; It&#39;s rather unfriendly towards contributors to expect th=
em to certify<br>
&gt; &gt; &gt; something that we all know they can&#39;t honestly certify.<=
br>
&gt; &gt; <br>
&gt; &gt; This is the current position with the DCO anyway. If the contribu=
tor has<br>
&gt; &gt; copy and pasted (and maybe adapted) from Stack Overflow they are =
still<br>
&gt; &gt; realistically the only person that can make that judgement.<br>
&gt; <br>
&gt; Yes, that&#39;s the current position with the DCO and the reasoning wh=
y we<br>
&gt; said LLM output is unacceptable in submissions.<br>
&gt; <br>
&gt; The big difference is if I copy and pasted from Stack Overflow, I _kno=
w_<br>
&gt; that I did that. If the LLM effectively does it for me, I don&#39;t kn=
ow<br>
&gt; that. The best I can do is check if I can find similar code elsewhere.=
<br>
&gt; <br>
&gt; So while I can certify with 100% confidence that I didn&#39;t manually=
 copy<br>
&gt; things for code that I wrote myself, I can&#39;t certify that code fro=
m<br>
&gt; other sources, including LLMs, isn&#39;t copied from elsewhere. I can =
only<br>
&gt; say that I didn&#39;t find any reason to suspect it&#39;s copied.<br>
<br>
&gt; &gt; &gt; Our current AI policy was built on the assertion that it&#39=
;s impossible to<br>
&gt; &gt; &gt; sign the DCO for AI output, and I think that&#39;s still rig=
ht. A developer<br>
&gt; &gt; &gt; can&#39;t certify the origin of something when they don&#39;=
t really know where<br>
&gt; &gt; &gt; it comes from.<br>
&gt; &gt; <br>
&gt; &gt; It&#39;s certainly possible for LLMs to replicate copyright mater=
ial but by<br>
&gt; &gt; far the biggest influence is the code *in the project* that shape=
s the<br>
&gt; &gt; output. It is basically pattern matching and predicting after all=
.<br>
&gt; <br>
&gt; If there is one chunk of code that violates the copyright of someone,<=
br>
&gt; you can&#39;t heal that just by having 1000 more chunks that are clean=
.<br>
&gt; <br>
&gt; &gt; What level of reassurance the submitter needs to be able to certi=
fy with<br>
&gt; &gt; their DCO is up to them. We can&#39;t police it, like every other=
 submission<br>
&gt; &gt; we rely in the submitters good faith representation of what they =
have<br>
&gt; &gt; done.<br>
&gt; <br>
&gt; The DCO doesn&#39;t talk about levels of reassurance. It talks about h=
ard<br>
&gt; facts, 100% confidence.<br>
&gt; <br>
&gt; And that I can&#39;t give you with LLM generated content. I can maybe =
give<br>
&gt; you 99%, but never 100%.<br>
<br>
I appreciate you&#39;re speaking about licensing/copyright here, but more<b=
r>
generally I think we&#39;re probably wrong in asserting that a human<br>
authored contribution can ever be said to be 100% safe to QEMU with<br>
a DCO signoff. It is risk mitigation, but not absolute.<br></blockquote><di=
v><br></div><div>Risk mititagion is the best you can hope for. People lie, =
people accidentally</div><div>copy, etc. Maybe they infringe on a patent. Y=
ou can never be 100%</div><div>sure.</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
From a copyright POV, if we write the code ourselves we can have<br>
confidence we didn&#39;t copy it and thus licensing is likely OK (unless<br=
>
you inadvertantly memorized some previous code you saw and reproduced<br>
it too closely), but there are other legal aspects. Trademarks are<br>
one risk, since we reference lots of vendor&#39;s hardware features, but<br=
>
in practice this very rarely arises as a problem for projects, beyond<br>
the obvious areas like project name, logo, and other visible branding<br>
aspects. Software patents are the really big hidden trap that anyone<br>
could unintentionally fall foul of at any time and have caused high<br>
profile problems for projects periodically.<br></blockquote><div><br></div>=
<div>Even the memorized stuff is likely OK. It all depends. I have memorize=
d</div><div>bubble sorts, but there&#39;s only so many ways to implement a =
bubble sort</div><div>so most=C2=A0<span style=3D"background-color:transpar=
ent">bubble sorts don&#39;t enjoy much copyright protection.=C2=A0 Big tabl=
es of</span></div><div><span style=3D"background-color:transparent">numbers=
 don&#39;t generally enjoy copyright protection, so are usually 100%</span>=
</div><div><span style=3D"background-color:transparent">OK to copy.</span><=
/div><div><span style=3D"background-color:transparent"><br></span></div><di=
v>Plus, LLMs generally don&#39;t copy code from random places. Some early</=
div><div>ones were subject to injection attacks, but newer ones tend to loo=
k at</div><div>surrounding code to adopt the repository&#39;s conventions. =
Is that copying?</div><div>Is that a risk? Probably not because it&#39;s li=
kely &quot;scenes a faire&quot; which</div><div>is the doctrine sometimes t=
he genre dictates that things be a certain</div><div>way (eg=C2=A0all murde=
r mysteries have a victim and someone trying to</div><div>solve the crime).=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">If s=
omeone knows their employer has a patent that is likely to be<br>
restrictive for possible use in QEMU, then they shouldn&#39;t sign off<br>
or contribute code implementing something covered by the patent<br>
without the employer granting unrestricted use. We&#39;re certainly<br>
not expecting people to do searches for 3rd party patents though,<br>
so the DCO is not a 100% guarantee of risk elimination to QEMU.<br></blockq=
uote><div><br></div><div>In fact most companies, at least in the US, instru=
ct their engineers</div><div>to not even bother with a patent search becaus=
e if you look for it,</div><div>even if you don&#39;t find it, you can be h=
eld liable for triple damages</div><div>because it can become willful.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
We tolerate that risk because there is no practical action that a<br>
contributor can take to mitigate. Further many large tech companies<br>
have thus formed defensive pacts to de-fang the risk.<br></blockquote><div>=
<br></div><div>Yes. The actual legal landscape is such that it&#39;s hard t=
o know for</div><div>sure what the level of risk is for any given action. W=
hile usually the</div><div>court will rule in a specific way, there are tim=
es it just doesn&#39;t, even</div><div>for what seem like similar facts. Un=
like programming, there&#39;s an</div><div>element of randomness that you c=
an&#39;t drive to 0.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
With this in mind, it is perhaps not that different to accept a little<br>
bit of uncertainty in risks of LLM unknowingly copying from training<br>
material or 3rd party incompatibly licensed code it happened to find<br>
while walking the web ?=C2=A0 The key is that users need to be diligent<br>
in their use of the tools, not reckless. Norms for what that means<br>
are still be established - the so called &quot;clean room&quot; or license<=
br>
laundering, re-impls of projects are a massively risky activity<br>
but are the exception.<br></blockquote><div><br></div><div>And &quot;clean =
room&quot; procedures are no different whether a human</div><div>or an LLM =
performs them. They=C2=A0<span style=3D"background-color:transparent">both =
produce a new work because</span></div><div><span style=3D"background-color=
:transparent">the abstraction to the idea (which isn&#39;t copyrightable) l=
oses details,</span></div><div><span style=3D"background-color:transparent"=
>creative choices, etc. And the implementation from that spec also makes</s=
pan></div><div><span style=3D"background-color:transparent">different creat=
ive choices, leaving little in common with the original.</span></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; &gt; &gt; If we decide that we don&#39;t care as much about the legal =
risks any more<br>
&gt; &gt; &gt; and that we&#39;re willing to accept them to some extent, th=
at should be<br>
&gt; &gt; &gt; explicitly reflected in the policy.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; It seems to me that the cleanest way to do it is to exempt c=
orrectly<br>
&gt; &gt; &gt; advertised (with &#39;AI-used-for:&#39;) AI output from the =
DCO requirement and<br>
&gt; &gt; &gt; instead add to the &#39;AI-used-for:&#39; definition some re=
laxed version of it,<br>
&gt; &gt; &gt; e.g. &quot;I have reviewed the contribution for potential li=
censing issues<br>
&gt; &gt; &gt; and haven&#39;t found a reason to doubt that I have the righ=
ts to submit<br>
&gt; &gt; &gt; this AI generated content under the open source license indi=
cated in the<br>
&gt; &gt; &gt; file&quot;. This is something that could realistically be ce=
rtified by<br>
&gt; &gt; &gt; contributors in good faith and also isn&#39;t just &quot;any=
thing goes&quot;, but of<br>
&gt; &gt; &gt; course it still is weaker than the DCO.<br>
<br>
I like the idea of associating &quot;AI-used-for&quot; with an explicit<br>
statement like:<br>
<br>
=C2=A0 &quot;By using &#39;AI-used-for&#39;, a contributor both identifies =
areas of<br>
=C2=A0 =C2=A0the patch that involved use of AI/LLM, and also attests that<b=
r>
=C2=A0 =C2=A0their usage of AI/LLMs was in compliance with the policies<br>
=C2=A0 =C2=A0outlined in this document&quot;<br>
<br>
<br>
Then we can add whatever guidance we want in the AI policy that<br>
steers people away from LLM usage patterns that we know would<br>
expose us to undesirable risk. Explicitly stating that we do<br>
not want LLMs used to &quot;clean room&quot; / &quot;license launder&quot; =
re-impl<br>
existing code is something we could include. Or guide that <br>
agents should not be given free access to live git repos to<br>
reduce change of direct copying ?<br></blockquote><div><br></div><div>FreeB=
SD is struggling with these issues as well. There&#39;s a huge difference</=
div><div>in risk of someone one-shotting the process and sending the result=
s off</div><div>w/o any critical thought and someone doing a series of a hu=
ndred or two</div><div><span style=3D"background-color:transparent">hundred=
 prompts with careful thought, arguments about the design</span></div><div>=
<span style=3D"background-color:transparent">trade offs, etc. Even leaving =
aside the copyright issues, the former has</span></div><div><span style=3D"=
background-color:transparent">a huge risk, most of it from technical debt, =
while the latter has a much lower</span></div><div><span style=3D"backgroun=
d-color:transparent">risk: there&#39;s less risk of copying (and any copyin=
g may fall to de minimis),</span></div><div><span style=3D"background-color=
:transparent">and the result is much better designed and put together. Free=
BSD doesn&#39;t</span></div><div><span style=3D"background-color:transparen=
t">yet have any good answers to share.</span></div><div><span style=3D"back=
ground-color:transparent"><br></span></div><div>Honestly, the real risk her=
e is that there&#39;s a new kind of &#39;free&#39; software:</div><div>free=
 as in free puppy, and you want to be careful which ones you accept.</div><=
div>The bigger liability to the project is accepting the wrong ones which i=
ncrease</div><div>technical debt over the finer points of copyright law tha=
t will really only matter</div><div>if something is actually litigated, and=
 then the thousands of contributors</div><div>randomly permuting different =
aspects of the code every few years also</div><div>launders the code, both =
in terms of technical debt, and in terms of copyright</div><div>risk.</div>=
<div><br></div><div>It&#39;s all about mitigating the risks that matter in =
the end.</div><div><br></div><div>Warner</div></div></div>

--00000000000051e2dc065c411d2e--


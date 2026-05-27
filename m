Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF82CCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSF1Z-0006SJ-H3; Wed, 27 May 2026 10:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSF1X-0006Ri-2d
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:14:19 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wSF1T-0005Ef-IZ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:14:18 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so5719635b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 07:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779891253; cv=none;
 d=google.com; s=arc-20240605;
 b=D+5MFXxdroSvpl7Q+Sm1iWjTfZKrjInRQbLWUx7mYk/IxdN3mSDuhTHSKnFt+aeGO9
 VCVdLmBnjZlCAq5TXYwj14dlVenYmtmtUCfJwe2jpPJOqXyFQ+7bSol7CvhyPiMdoCPv
 +CJMEQzh2mm6/HMyoIlFLHsj0rjS7uonQMDF+AWtNbvcqzl0oNHW+XG5mSSHWG4FMjr1
 sY4wlbXiA+gS8AxYpDgysAU6cPVTQV28uZ3rrp+2YZtvnEepFUXI+90wtq5uV+FU81uF
 InLrvixbl71DeeU+OH5hlDXersmR5Dux+XRc/Sj3dtQ9ErvQEqBnCBlsybI1Ni/X25FQ
 sYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O4CnTHIF7oz914seqJflJgWG+QTFnN5bOTJhjrM2L6U=;
 fh=E45pZs82o7pjZRbRLYwRq+S0mWGfBc0DzCUIKbEXMZE=;
 b=k32Z28Ear4KSZsTeQnpj9JexJ/T453mfP1WWONfm8nqkSYsS7350n4KqONPWHtyL1M
 7oMIViZyryFL5YBeEaGWSu1eL3BL4AA0XsoIY2thhcZHTX5SLuQuGzTVSoETlp8fHNjx
 /Tlje/aC6JtOaFYFR1I4J5DL50RUtOC4z8Yi8tPqOJG1X9Co+jUtfhafAg2+bNFTejcn
 1GYmpumhIOdld4c1HZJYimwC0yBY8hx/dMocFpWkP1t3VcIax8OS8Kg76ffC9x9Uxhi7
 6ENk68XPiAwp0+OGykZCl6Fh3NCWoGqG1MS66QUZF0cC07ks5Gj3bSJQ4snEl+/NnvB+
 KCnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779891253; x=1780496053;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O4CnTHIF7oz914seqJflJgWG+QTFnN5bOTJhjrM2L6U=;
 b=A4buupjCefSbO4aC95fouZU/cSdXcjpksiboljN5I2x+twTze9eW24WDXQOs3HVjX3
 vbWKfgdiqiNOIsr5mnkyBsK8Aq9DHedRdIqZyuwt/YIvjevAO7hcjyr48hP3t0JfOk26
 gwdu/SVYnqxfr/KMUe8aJZP/zhEVTUWvdETk8YHw8yT6MC40mpEtfwF+3Et8pQ+7xTRo
 Lt/m4HLMSU2ftJGIC84Oelx4JcXOeEQ+OyO6KhpDLwKXVNHBjSVYMhPO7CJJrTZ931tF
 sa1M3zgtnjUggZTi1EFx1ytuRoAt6rrfGzx5MmM5hvjtmZzH9hT/2IgqBvUSRaDwq45S
 xQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779891253; x=1780496053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4CnTHIF7oz914seqJflJgWG+QTFnN5bOTJhjrM2L6U=;
 b=f4L8D8v80ljgbD6t3DQWBPrKPZ1RYmTPzSyCYgK5u5eURNh7dZ498UZfol4BxXuHe3
 T4YbKD+y7hAgEhDbRP2Lq/7EqaKYdj/fhiJQ0KXJuzuD8TYNOh1ZVA2izoE1WZNrmKlj
 Fh5RBAnKxuz2fjBR3u8D6LFNRWuU/zmBZf8Z6MkKfmFeECWm4Ms9UUIIWZnDGMzIHCYw
 2G9lLl8M1D7Wj7YLPwmXbtQIRLC1QoeUWmmi2encBTO/T8FGfOMacj6uAOmATrvPytv0
 qY8kMPVO8/DaCH08ryzPXe9G2BoUYcR45Ty3cuACLh3VnGBzUPTSwNEuWv/kRJrij5ug
 hPng==
X-Forwarded-Encrypted: i=1;
 AFNElJ8i0UTydqYN1akvfQ78TqTAyhrYxlw9U1AUTgEs7knw1w12zWeO3OY5AYSu37LZiR1yjr2cbU+ir1nN@nongnu.org
X-Gm-Message-State: AOJu0YyLc+CSrJihfx91JEOK9OKivPvPpBqyKzwYjUu7f2rNrKcIyh38
 eghrW4fJFSMTu/eNlcpKmzRsUxUKpQeUOk8fNqxyR/LHV0REdmN8SdbgVJvVRRnXklWCLhB8Q/E
 Bh7Nt9gfH0F69/jzKPI0UaluuykZn7E6T7MVcj0tAPQ==
X-Gm-Gg: Acq92OFW4dp9OPTC52ADOEmBrP+s25dxrkhHUSgmEiJCljm/cc/vvgvwL1qum/W9PGb
 huv9iBhn0BqUTx2lc+FOrg2RZtja5bmyd84fMt/lm3IvJjL1DliDFWkaMkAs5+T8Nc75iyq0IDn
 D49pRUCPwpy6g5x9+v1LZ5xcfzjqi/G3lpm1kMopMpYF1W1JHGGWZrKfSCTPcgvdUbcExX5tr0Q
 fSoHLWVM0YLynzPwA8dPMG5/hzI25tax7YWTKC0yXsnitF2Gwl5y2IvBSinslrpJVJc2Mq52Fo9
 yauEwkq660RUhRQYaQ==
X-Received: by 2002:a05:6a00:2448:b0:82f:5a77:10e8 with SMTP id
 d2e1a72fcca58-8415f18f137mr22255585b3a.20.1779891253485; Wed, 27 May 2026
 07:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com> <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com> <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
In-Reply-To: <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 27 May 2026 08:14:02 -0600
X-Gm-Features: AVHnY4LNBM3DQ_gIaMnfbsoYNgzRoa3JpyagpjgfO6OQF3pf4eeC6TE7AHIH2iY
Message-ID: <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000e72fd30652cd3939"
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x432.google.com
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

--000000000000e72fd30652cd3939
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 4:01=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:

> On 5/27/26 10:41, Kevin Wolf wrote:
> > Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:
> >> The QEMU Project currently may accept limited uses of AI that produce
> >> high quality patches that are limited in the creative content added.
> >> While maintainers will ultimately decide, changes like the following
> >> fall within this policy
> >> 1. Fixing obvious warnings in the obvious ways suggested by the tool
> >> 2. Tree wide API changes, and other similar mechanical changes done
> >>     today with perl/python/sed/coccinelle
> >
> > As I said in the paragraph you quoted below, I don't think we should
> > encourage using AI for tasks that a deterministic tool could do.
>
> In some cases such a tool does not exist.  Much to my surprise, there is
> no tool to do static type inference on Python code, but AI is very good
> at doing it.
>
> > Letting AI perform the change directly instead may be an acceptable
> > shortcut for a one-man hobby project that nobody else will ever look at=
,
> > but in the context of a community project like QEMU in which your
> > changes have to be reviewed and understood by others, it matters a lot
> > that the output of the tool is reproducible. Otherwise, you're creating
> > unnecessary work for others, and that isn't acceptable.
>
> When applicable, going through coccinelle (with the aid of AI if needed!
> is indeed a good middle ground as it helps reviewers for large changes.
> If you have many slightly different but easily separated changes (e.g.
> you can split the patch by struct field), it may make things worse.
>
> Its also worth noting that in other cases even sed or coccinelle, while
> deterministic, cannot produce 100% of the patch.
>
> > So maybe we should even explicitly mention a recommendation like the
> > following:
> >
> >      If you can use a deterministic tool, don't use AI instead. If you
> >      don't know how to use the deterministic tool, use the AI to tell y=
ou
> >      how to use it instead of trying to replace it.
>
> I like it.
>
> >> 3. Limited, small changes to fix bugs or add a small new feature whose
> >>     scope is less than about 100 lines and the originator can explain
> >>     them all or the meta issues about the patch.
> >
> > Not sure if mentioning a number of lines is wise. 100 lines can be
> > mostly boilerplate and simple sequential code or they can be a deeply
> > nested complex algorithm.
>
> I'd put the threshold at 20-50 at most.
>
> > I think I would see more use in a tag like (better name welcome):
> >
> >     AI-used-for: [code|tests|docs|commit message]...
>
> I like this *a lot*.  No need for free advertisement, but some
> traceability is useful.
>
> For tools such as sed or coccinelle, having the exact script in the
> patch or commit message useful.  Plus, the execution of the script more
> or lesss delimits the commit by itself (or 90%+ of it).  For LLMs it's a
> bit less clear cut because separating docs makes little sense.  And the
> exact model is pointless, it will be obsolete in 6 months and provide no
> useful information.
>
> So, something like:
>
> ------------------- 8< -------------------
> Use of AI-generated content
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The QEMU project currently allows using AI/LLM tools to produce patches
> in scenarios with limited creative content:
>
> Mechanical changes
>    If you can use a deterministic tool or a script, don't use AI instead.
>    If you don't know how to do the change deterministically, you may
>    ask the AI for help, rather than having it stand in for the tools.
>
> Small bug fixes
>    These should be limited to 20 lines of code or less, not including
>    tests.  You are still expected to understand and explain your changes
>    and the rationale behind them.
>
> These boundaries do not apply to other uses of AI, such as researching
> APIs or algorithms, static analysis, or debugging, provided their output
> is not included in contributions.  Larger uses of AI are allowed as an
> experiment, but they should be agreed upon with the maintainer prior to
> submission.
>
> Use of AI does not remove the need for authors to comply with all other
> requirements for contribution.  In particular, the "Signed-off-by"
> label in a patch submission is a statement that the author takes
> responsibility for the entire contents of the patch, certifying that
> their patch submission is made in accordance with the rules of the
> `Developer's Certificate of Origin (DCO) <dco>`.
>
> Commit messages for AI-assisted changes
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> When AI/LLM tools produce or substantively shape your patch, add an
> ``AI-used-for:`` trailer.  The text of the trailer could be one or more
> of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> explanation in parentheses::
>
>      AI-used-for: tests, docs
>      AI-used-for: code
>      AI-used-for: code (refactoring)
>      AI-used-for: code (prototype)
>      AI-used-for: research
>
> The trailer is intended as a clarification of your DCO obligations as
> well as to guide reviewers.  It is not intended for minimal presence
> such as autocomplete or asking for a pre-review of the patch, and it
> does not remove your responsibility to understand the changes that you
> are submitting.
>

Why invent something new here when Assisted-by: is used elsewhere
and is likely more familiar to other users.


> Include the prompt in the commit message if it helps a reviewer judge
> the result:
>
> * yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> function already has a local variable or parameter of type ``struct
> bb``, use it instead of accessing ``aa.bb``."
>
> * yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``,
> forwarding the member functions to ``T`` while taking the lock around
> the calls".
>
> * no: "write user-facing documentation for the new tool"
>
> * no: "write testcases for the new functions"
>

I think this fundamentally misunderstands how AI tends to be use. It
usually is a long, iterative process that's become impossible to capture
"THE" prompt. The bsd-user changes under review now are the result
of months of memories, hundreds of interactions with claude, including
one argument about how things worked. It's OK for people trying to
"one shot" things, but it's been my experience having worked with
these tools extensively that "one shot" is cool for demos, but not
cool for code you have to use in anger.


> Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> the trailer, but should be mentioned in the commit message.
>
>

--000000000000e72fd30652cd3939
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 27,=
 2026 at 4:01=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redha=
t.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 5/27/26 10:41, Kevin Wolf wrote:<br>
&gt; Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:<br>
&gt;&gt; The QEMU Project currently may accept limited uses of AI that prod=
uce<br>
&gt;&gt; high quality patches that are limited in the creative content adde=
d.<br>
&gt;&gt; While maintainers will ultimately decide, changes like the followi=
ng<br>
&gt;&gt; fall within this policy<br>
&gt;&gt; 1. Fixing obvious warnings in the obvious ways suggested by the to=
ol<br>
&gt;&gt; 2. Tree wide API changes, and other similar mechanical changes don=
e<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0today with perl/python/sed/coccinelle<br>
&gt; <br>
&gt; As I said in the paragraph you quoted below, I don&#39;t think we shou=
ld<br>
&gt; encourage using AI for tasks that a deterministic tool could do.<br>
<br>
In some cases such a tool does not exist.=C2=A0 Much to my surprise, there =
is <br>
no tool to do static type inference on Python code, but AI is very good <br=
>
at doing it.<br>
<br>
&gt; Letting AI perform the change directly instead may be an acceptable<br=
>
&gt; shortcut for a one-man hobby project that nobody else will ever look a=
t,<br>
&gt; but in the context of a community project like QEMU in which your<br>
&gt; changes have to be reviewed and understood by others, it matters a lot=
<br>
&gt; that the output of the tool is reproducible. Otherwise, you&#39;re cre=
ating<br>
&gt; unnecessary work for others, and that isn&#39;t acceptable.<br>
<br>
When applicable, going through coccinelle (with the aid of AI if needed! <b=
r>
is indeed a good middle ground as it helps reviewers for large changes. <br=
>
If you have many slightly different but easily separated changes (e.g. <br>
you can split the patch by struct field), it may make things worse.<br>
<br>
Its also worth noting that in other cases even sed or coccinelle, while <br=
>
deterministic, cannot produce 100% of the patch.<br>
<br>
&gt; So maybe we should even explicitly mention a recommendation like the<b=
r>
&gt; following:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 If you can use a deterministic tool, don&#39;t use=
 AI instead. If you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 don&#39;t know how to use the deterministic tool, =
use the AI to tell you<br>
&gt;=C2=A0 =C2=A0 =C2=A0 how to use it instead of trying to replace it.<br>
<br>
I like it.<br>
<br>
&gt;&gt; 3. Limited, small changes to fix bugs or add a small new feature w=
hose<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0scope is less than about 100 lines and the orig=
inator can explain<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0them all or the meta issues about the patch.<br=
>
&gt; <br>
&gt; Not sure if mentioning a number of lines is wise. 100 lines can be<br>
&gt; mostly boilerplate and simple sequential code or they can be a deeply<=
br>
&gt; nested complex algorithm.<br>
<br>
I&#39;d put the threshold at 20-50 at most.<br>
<br>
&gt; I think I would see more use in a tag like (better name welcome):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0AI-used-for: [code|tests|docs|commit message]...<br=
>
<br>
I like this *a lot*.=C2=A0 No need for free advertisement, but some <br>
traceability is useful.<br>
<br>
For tools such as sed or coccinelle, having the exact script in the <br>
patch or commit message useful.=C2=A0 Plus, the execution of the script mor=
e <br>
or lesss delimits the commit by itself (or 90%+ of it).=C2=A0 For LLMs it&#=
39;s a <br>
bit less clear cut because separating docs makes little sense.=C2=A0 And th=
e <br>
exact model is pointless, it will be obsolete in 6 months and provide no <b=
r>
useful information.<br>
<br>
So, something like:<br>
<br>
------------------- 8&lt; -------------------<br>
Use of AI-generated content<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
The QEMU project currently allows using AI/LLM tools to produce patches <br=
>
in scenarios with limited creative content:<br>
<br>
Mechanical changes<br>
=C2=A0 =C2=A0If you can use a deterministic tool or a script, don&#39;t use=
 AI instead.<br>
=C2=A0 =C2=A0If you don&#39;t know how to do the change deterministically, =
you may<br>
=C2=A0 =C2=A0ask the AI for help, rather than having it stand in for the to=
ols.<br>
<br>
Small bug fixes<br>
=C2=A0 =C2=A0These should be limited to 20 lines of code or less, not inclu=
ding<br>
=C2=A0 =C2=A0tests.=C2=A0 You are still expected to understand and explain =
your changes<br>
=C2=A0 =C2=A0and the rationale behind them.<br>
<br>
These boundaries do not apply to other uses of AI, such as researching<br>
APIs or algorithms, static analysis, or debugging, provided their output<br=
>
is not included in contributions.=C2=A0 Larger uses of AI are allowed as an=
 <br>
experiment, but they should be agreed upon with the maintainer prior to <br=
>
submission.<br>
<br>
Use of AI does not remove the need for authors to comply with all other<br>
requirements for contribution.=C2=A0 In particular, the &quot;Signed-off-by=
&quot;<br>
label in a patch submission is a statement that the author takes<br>
responsibility for the entire contents of the patch, certifying that<br>
their patch submission is made in accordance with the rules of the<br>
`Developer&#39;s Certificate of Origin (DCO) &lt;dco&gt;`.<br>
<br>
Commit messages for AI-assisted changes<br>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
<br>
When AI/LLM tools produce or substantively shape your patch, add an <br>
``AI-used-for:`` trailer.=C2=A0 The text of the trailer could be one or mor=
e <br>
of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an <br=
>
explanation in parentheses::<br>
<br>
=C2=A0 =C2=A0 =C2=A0AI-used-for: tests, docs<br>
=C2=A0 =C2=A0 =C2=A0AI-used-for: code<br>
=C2=A0 =C2=A0 =C2=A0AI-used-for: code (refactoring)<br>
=C2=A0 =C2=A0 =C2=A0AI-used-for: code (prototype)<br>
=C2=A0 =C2=A0 =C2=A0AI-used-for: research<br>
<br>
The trailer is intended as a clarification of your DCO obligations as <br>
well as to guide reviewers.=C2=A0 It is not intended for minimal presence <=
br>
such as autocomplete or asking for a pre-review of the patch, and it <br>
does not remove your responsibility to understand the changes that you <br>
are submitting.<br></blockquote><div><br></div><div>Why invent something ne=
w here when Assisted-by: is used elsewhere</div><div>and is likely more fam=
iliar to other users.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Include the prompt in the commit message if it helps a reviewer judge <br>
the result:<br>
<br>
* yes: &quot;move field ``foo`` from ``struct aa`` to ``struct bb``.=C2=A0 =
If a <br>
function already has a local variable or parameter of type ``struct <br>
bb``, use it instead of accessing ``<a href=3D"http://aa.bb" rel=3D"norefer=
rer" target=3D"_blank">aa.bb</a>``.&quot;<br>
<br>
* yes: &quot;add an implementation of the trait for ``Mutex&lt;T: MyTrait&g=
t;``, <br>
forwarding the member functions to ``T`` while taking the lock around <br>
the calls&quot;.<br>
<br>
* no: &quot;write user-facing documentation for the new tool&quot;<br>
<br>
* no: &quot;write testcases for the new functions&quot;<br></blockquote><di=
v><br></div><div>I think this fundamentally misunderstands how AI tends to =
be use. It</div><div>usually is a long, iterative process that&#39;s become=
 impossible to capture</div><div>&quot;THE&quot; prompt. The bsd-user chang=
es under review now are the result</div><div>of months of memories, hundred=
s of interactions with claude, including</div><div>one argument about how t=
hings worked. It&#39;s OK for people trying to</div><div>&quot;one shot&quo=
t; things, but it&#39;s been my experience having worked with</div><div>the=
se tools extensively that &quot;one shot&quot; is cool for demos, but not</=
div><div>cool for code you have to use in anger.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
Deterministic tooling (sed, coccinelle, formatters) is out of scope for <br=
>
the trailer, but should be mentioned in the commit message.<br>
<br>
</blockquote></div></div>

--000000000000e72fd30652cd3939--


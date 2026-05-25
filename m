Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFAACD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 17:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRYu0-00072l-7H; Mon, 25 May 2026 13:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRYty-00072U-PQ
 for qemu-devel@nongnu.org; Mon, 25 May 2026 13:15:42 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRYtv-0006eg-It
 for qemu-devel@nongnu.org; Mon, 25 May 2026 13:15:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so85994885ad.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 10:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779729337; cv=none;
 d=google.com; s=arc-20240605;
 b=Zsakhqb19XF+V/3857bizVvN677XiqA24+7wbXTLl6sWpoeaxoZ1czr0VRrWYb5pXI
 GKFPvMHB0dhNMnCAc+S+90ejW5y/0dP6AWrrIDCyzo9c13I/52vHOzdua+YPUonaO+Ll
 aRVueyUbBEbxUxYVUhh0hHc/dq9xxJQeNhaVDRhqC3UBvL5t+i1gEWh5hxitzV70fDwn
 jislawuozfjbuMwTrU1UuUWyZUX8J9rv8dO26kGQd+T6FObuyNVNPPSATQh5TDWDbfk8
 xPrDzPOtjOsOdjM3pUlOend6ubXkpGrBXjzVSSe5FL1/TM1RHn/3aaf1kqBpZnvfR7eI
 14Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FHtO+WCEjyic4zAykprbW8LQJBtJn3jvzIRBDvEtCPs=;
 fh=0MGl+ytFZVvFwhPb9lwgw5FCdKjSz6X/JXXEfYSIH/g=;
 b=NWDRNVW/9cpjJ5j26/x1z48fKg5K/+2b3oawEMU0Db3wue59LYADDaGOEKJaNHLWAn
 2LEEVKugc21zg9IerhsxE4yD6jtbQgTIcEBwgN15kzVBjIudTzDg0b6YhaQNYTRFAYo6
 fdlpPQM3B9kODYHtoro6Ft1P6APngW8ABXrzqxmNLpYozx7gNDbkghpdT8gadD/sjZH1
 miq1IPzQ5I39NrxtaL3ag8RhCe4HAtsE2eamcqvgCR/nIDZxm0r/hHY2A7hzHXEz3Y53
 AhhyZOxFFrskFWOfTkAdwf/A+kBQRKM0UUgl7hk4c+FHoBWE2ozOEzhrYUgKItqn3cqH
 qI4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779729337; x=1780334137;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FHtO+WCEjyic4zAykprbW8LQJBtJn3jvzIRBDvEtCPs=;
 b=ruebAvlM99CfSyL+yeFKwKyJXyblPpViFRzAqg1MU0P/vAt7UNmQKX5xs+o9Ld/jjf
 bSYTsboqY9dpdonMs2Bz+ZEQ1ehfL81FH/TnXqshXOvCqEb4EIPs9jNfM7h1gSvHmA8l
 4mtAl82mYvvecRDZTZFrlrMJq1JZGZ6Ajjo82TzpCXr9fj0uiJMtMogT6SUqZuhHgE63
 WQ8dxzS9MJJZ63RBXPkTJkR+CJnrXd4LhWpsGzBABFFKqlMyGwlSxTmpe5y5HtTgkp9+
 jAK6ZS4+8jwUpTLjjg2NLgPtlkl+l7NemTDtcdo9ly0gQ+SZqRXg6NsUZUk8IW7KWBRw
 1POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779729337; x=1780334137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHtO+WCEjyic4zAykprbW8LQJBtJn3jvzIRBDvEtCPs=;
 b=ShB8lY2Lvp71m3emPa7qROGe1jr6lPCB/3oUFBM8dTmA4nCuooYM1DoqszB5/M7soG
 f/NXF5BhsypBZx56P6XJXNtEZXJ+ZcvS0bJIKGFty18VvZliuWyGykBqVSNHmGQRpMGm
 NZEaNPxgyNPcGlqt07D1Up/u8i0+qtNMWLrvZ5Nz30H15+aP+VOGPG2yDU+Qwu8Aze0R
 GJ3xux9impxr5RnVUfPXuF3oMGuL8S8BFXhwoyWxw94DoEhJOYH4HPY0kO1/qlTx9BQZ
 AfYUkHcLERJtzGjISZCUu1Loc+G7nRAV7LH5niHL1l/YCzj5aUnEI52IG+23yFemuNIO
 XvlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dvGyQRFhbC8WmP6HndAOWqydX7XEGk6VB3sNEagVcop/l4WqEDhvpJRhHElEyEU718FENBta1oAQi@nongnu.org
X-Gm-Message-State: AOJu0Yza8G2hunToqUFekBiLGE4z9U49GLwE6yhHvi4laOZBjSdmKQgV
 Q3ba7vYNwNN1HrfC5WuXyHPrHa5hrVzdxiqN71DNoJGZwR27F8MS5I88vECXompHkLw3wHC5BRc
 mSvXyLhmaPK9tgfG8pi77+//y2/6Tf5dHUCJ8UEUvYGrJOYfZX84Kx30=
X-Gm-Gg: Acq92OHqUGAWQx4NDWEf4obGZmz6RKsipa77TrkRUuywXDPzKn0mxKsyzI6n6IYDz/4
 t+zz02EcNyD+86gOlbfiROu1CB7P3jJQNKVbWOwKwTq1SbSEv5UN1IWf2GNY2F25urAjqT43S6U
 q5M1hCcCB8n7/ZwOVoY531/m3jucoZvtQvHlZHxZpZyelpISBjBBc0u0pyspjST00u6Cvs7E1Ui
 tmz/Ysf2Ouy/Z1ISaw+yOcSniECSJHr+sFDTuVa7Kdz+65BFIGwU5CwD6yZym/qlHFPrigTy/Ni
 IgepVIaxyg+kTT2K0oaiQUD1h+rkIdUGs3cT6w==
X-Received: by 2002:a17:903:2284:b0:2bd:412:21fb with SMTP id
 d9443c01a7336-2beb033eeeamr174409735ad.8.1779729336711; Mon, 25 May 2026
 10:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
In-Reply-To: <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 25 May 2026 11:15:25 -0600
X-Gm-Features: AVHnY4IqT4F4UYwdzqSH7meHc72Ggy6O35mRFiIot5WFMh79FV_wwlccjnEehjg
Message-ID: <CANCZdfrn61yr5k=3=E_zE11dw3j2vVsg0PPn0PZ7RAa2agM8kQ@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000e94c690652a78685"
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x635.google.com
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

--000000000000e94c690652a78685
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 10:34=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:

> On 5/24/26 14:42, Michael S. Tsirkin wrote:
> >       How contributors could comply with DCO terms (b) or (c) for the
> output of AI
> >       content generators commonly available today is unclear.  The QEMU
> project is
> >       not willing or able to accept the legal risks of non-compliance.
> >
> > But, since this was written, Red Hat's Richard Fontana and Chris Wright
> > published this piece:
> >
> https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-na=
vigating-legal-issues
> >
> > Saying, in particular
> >       We understand this concern, but the DCO has never
> >       been interpreted to require that every line of a contribution mus=
t
> be
> >       the personal creative expression of the contributor or another
> human
> >       developer.
> This is not the objection or the worry; rather the question is, what if
> the contribution is a creative expression of someone that could claim
> copyright in it.  In fact, looking at the Linux policy...
>
>    Signed-off-by and Developer Certificate of Origin
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
>    AI agents MUST NOT add Signed-off-by tags. Only humans can legally
>    certify the Developer Certificate of Origin (DCO). The human submitter
>    is responsible for:
>
>    * Reviewing all AI-generated code
>    * Ensuring compliance with licensing requirements
>    * Adding their own Signed-off-by tag to certify the DCO
>    * Taking full responsibility for the contribution
>
> ... the question is how humans can actually do the second step.  The
> piece you posted above says: "with disclosure and human attentiveness =E2=
=80=93
> and oversight =E2=80=93 aided where possible by tools that check for code
> similarity, AI-assisted contributions can be entirely compatible with
> the spirit of the DCO".
>

The code produced by AI agents has no copyright. You can incorporate
public domain code into your work and have the absolute right to license
it (see all the Diseny movies). The notion that LLMs wholesale copy
originates
from the earliest days of Copilot and turned out were contrived. No recent
evidence shows that plagiarism is a concern. To the extent that I modify
public domain code, I have a copyright that I can choose to license
however I want (and the SOB says it's compatible).

So I'm struggling to understand the hesitation here. Is it the uncertainty
around the copyright? Around the copying issue? Something else?
We already have some level of risk around these issues with human
coders: We have to take their word for it that they didn't copy, and if
they did, the project is still on the hook to remedy the situation if the
real rights holders show up.... There's always risk when submissions
are accepted from the general public. Also, I've softened this paragraph
several times, and it still comes across as more confrontational than I
intend.
I'm trying to understand.


> This is not encouraging, in my opinion, because it leaves a lot of the
> mechanics undefined.  A while ago I suggested that in some scenarios
> this could actually be done[1][2]; another possible case is localized
> bugfixes (say, below 20 lines of code).  For more general contributions
> however, the role of maintainers is not clear.  Would we require to
> "check for code similarity"?  I sure don't want to open that can of worms=
.
>
> > I propose adopting linux's rules instead:
> > https://docs.kernel.org/process/coding-assistants.html
>
> Replacing QEMU's policy with Linux's would be orthogonal to the topic of
> the DCO.  Maintainers would still have the option of rejecting
> AI-assisted patches if they don't believe they can apply their own
> sign-off.
>
> Other projects have taken similar "no AI" policies for different
> reasons.  Zig has one because they believe AI code would make it harder
> to retain contributors[3][4]; Rust is working on one that is fairly
> restrictive[5] (discussion at [6]) and requires previous communications
> with reviewers about *any* generated PRs[7].  Personally I think QEMU's
> policy is fine but we should start introducing exceptions, possibly
> including large contributions with pre-authorization (but not
> pre-approval) from the maintainer.
>

I agree with the thrust of the proposals you've submitted: AI is a tool, an=
d
there are many ways to use it safely.

AI's primary issue is verification. The folks being flooded can't verify th=
e
good from the bad in the flood and tend to have a knee jerk reaction to
protect themselves: ban it.

Unstated issue: How do we help people that want to contribute grow their
skills using AI so they make submissions whose quality if good enough to
be worth our time to verify and review. It's an industry wide problem, alon=
g
with how do junior engineers become senior in a world of AI doing the grunt
work they used to learn from.

Warner


> Paolo
>
> [1]
>
> https://lore.kernel.org/qemu-devel/20250925075630.352720-1-pbonzini@redha=
t.com
> [2]
>
> https://lore.kernel.org/qemu-devel/20251008063546.376603-1-pbonzini@redha=
t.com/raw
> [3] https://ziglang.org/code-of-conduct/
> [4]
>
> https://ziggit.dev/t/bun-s-zig-fork-got-4x-faster-compilation-times/15183=
/19
> [5]
>
> https://github.com/jyn514/rust-forge/blob/llm-policy/src/policies/llm-usa=
ge.md
> [6] https://github.com/rust-lang/rust-forge/pull/1040
> [7]
>
> https://github.com/jyn514/rust-forge/blob/llm-policy/src/policies/llm-usa=
ge.md#experiment-llm-created-code-changes
>
>
>

--000000000000e94c690652a78685
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 25,=
 2026 at 10:34=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redh=
at.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On 5/24/26 14:42, Michael S. Tsirkin wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0How contributors could comply with DCO terms=
 (b) or (c) for the output of AI<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0content generators commonly available today =
is unclear.=C2=A0 The QEMU project is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0not willing or able to accept the legal risk=
s of non-compliance.<br>
&gt; <br>
&gt; But, since this was written, Red Hat&#39;s Richard Fontana and Chris W=
right<br>
&gt; published this piece:<br>
&gt; <a href=3D"https://www.redhat.com/en/blog/ai-assisted-development-and-=
open-source-navigating-legal-issues" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navig=
ating-legal-issues</a><br>
&gt; <br>
&gt; Saying, in particular<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0We understand this concern, but the DCO has =
never<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0been interpreted to require that every line =
of a contribution must be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the personal creative expression of the cont=
ributor or another human<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0developer.<br>
This is not the objection or the worry; rather the question is, what if <br=
>
the contribution is a creative expression of someone that could claim <br>
copyright in it.=C2=A0 In fact, looking at the Linux policy...<br>
<br>
=C2=A0 =C2=A0Signed-off-by and Developer Certificate of Origin<br>
=C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
<br>
=C2=A0 =C2=A0AI agents MUST NOT add Signed-off-by tags. Only humans can leg=
ally<br>
=C2=A0 =C2=A0certify the Developer Certificate of Origin (DCO). The human s=
ubmitter<br>
=C2=A0 =C2=A0is responsible for:<br>
<br>
=C2=A0 =C2=A0* Reviewing all AI-generated code<br>
=C2=A0 =C2=A0* Ensuring compliance with licensing requirements<br>
=C2=A0 =C2=A0* Adding their own Signed-off-by tag to certify the DCO<br>
=C2=A0 =C2=A0* Taking full responsibility for the contribution<br>
<br>
... the question is how humans can actually do the second step.=C2=A0 The <=
br>
piece you posted above says: &quot;with disclosure and human attentiveness =
=E2=80=93 <br>
and oversight =E2=80=93 aided where possible by tools that check for code <=
br>
similarity, AI-assisted contributions can be entirely compatible with <br>
the spirit of the DCO&quot;.<br></blockquote><div><br></div><div>The code p=
roduced by AI agents has no copyright. You can incorporate</div><div>public=
 domain code into your work and have the absolute right to license</div><di=
v>it (see all the Diseny movies).=C2=A0The notion that LLMs wholesale copy =
originates</div><div>from the earliest days of Copilot and turned out were =
contrived. No recent</div><div>evidence shows that plagiarism is a concern.=
 To the extent that I modify</div><div>public domain code, I have a copyrig=
ht that I can choose to license</div><div>however I want (and the SOB says =
it&#39;s compatible).</div><div><br></div><div>So I&#39;m struggling to und=
erstand the hesitation here. Is it the uncertainty</div><div>around the cop=
yright? Around the copying issue? Something else?</div><div>We already have=
 some level of risk around these issues with human</div><div>coders: We hav=
e to take their word for it that they didn&#39;t copy, and if</div><div>the=
y did, the project is still on the hook to remedy the situation if the</div=
><div>real rights holders show up.... There&#39;s always risk when submissi=
ons</div><div>are accepted from the general public. Also, I&#39;ve softened=
 this paragraph</div><div>several times, and it still comes across as more =
confrontational than I intend.</div><div>I&#39;m trying to understand.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
This is not encouraging, in my opinion, because it leaves a lot of the <br>
mechanics undefined.=C2=A0 A while ago I suggested that in some scenarios <=
br>
this could actually be done[1][2]; another possible case is localized <br>
bugfixes (say, below 20 lines of code).=C2=A0 For more general contribution=
s <br>
however, the role of maintainers is not clear.=C2=A0 Would we require to <b=
r>
&quot;check for code similarity&quot;?=C2=A0 I sure don&#39;t want to open =
that can of worms.<br>
<br>
&gt; I propose adopting linux&#39;s rules instead:<br>
&gt; <a href=3D"https://docs.kernel.org/process/coding-assistants.html" rel=
=3D"noreferrer" target=3D"_blank">https://docs.kernel.org/process/coding-as=
sistants.html</a><br>
<br>
Replacing QEMU&#39;s policy with Linux&#39;s would be orthogonal to the top=
ic of <br>
the DCO.=C2=A0 Maintainers would still have the option of rejecting <br>
AI-assisted patches if they don&#39;t believe they can apply their own sign=
-off.<br>
<br>
Other projects have taken similar &quot;no AI&quot; policies for different =
<br>
reasons.=C2=A0 Zig has one because they believe AI code would make it harde=
r <br>
to retain contributors[3][4]; Rust is working on one that is fairly <br>
restrictive[5] (discussion at [6]) and requires previous communications <br=
>
with reviewers about *any* generated PRs[7].=C2=A0 Personally I think QEMU&=
#39;s <br>
policy is fine but we should start introducing exceptions, possibly <br>
including large contributions with pre-authorization (but not <br>
pre-approval) from the maintainer.<br></blockquote><div><br></div><div>I ag=
ree with the thrust of the proposals you&#39;ve submitted: AI is a tool, an=
d</div><div>there are many ways to use it safely.</div><div><br></div><div>=
AI&#39;s primary issue is verification. The folks being flooded can&#39;t v=
erify the</div><div>good from the bad in the flood and tend to have a knee =
jerk reaction to</div><div>protect themselves: ban it.</div><div><br></div>=
<div>Unstated issue: How do we help people that want to contribute grow the=
ir</div><div>skills using AI so they make submissions whose quality if good=
 enough to</div><div>be worth our time to verify and review. It&#39;s an in=
dustry wide problem, along</div><div>with how do junior engineers become se=
nior in a world of AI doing the grunt</div><div>work they used to learn fro=
m.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Paolo<br>
<br>
[1] <br>
<a href=3D"https://lore.kernel.org/qemu-devel/20250925075630.352720-1-pbonz=
ini@redhat.com" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/qemu-devel/20250925075630.352720-1-pbonzini@redhat.com</a><br>
[2] <br>
<a href=3D"https://lore.kernel.org/qemu-devel/20251008063546.376603-1-pbonz=
ini@redhat.com/raw" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/qemu-devel/20251008063546.376603-1-pbonzini@redhat.com/raw</a><br>
[3] <a href=3D"https://ziglang.org/code-of-conduct/" rel=3D"noreferrer" tar=
get=3D"_blank">https://ziglang.org/code-of-conduct/</a><br>
[4] <br>
<a href=3D"https://ziggit.dev/t/bun-s-zig-fork-got-4x-faster-compilation-ti=
mes/15183/19" rel=3D"noreferrer" target=3D"_blank">https://ziggit.dev/t/bun=
-s-zig-fork-got-4x-faster-compilation-times/15183/19</a><br>
[5] <br>
<a href=3D"https://github.com/jyn514/rust-forge/blob/llm-policy/src/policie=
s/llm-usage.md" rel=3D"noreferrer" target=3D"_blank">https://github.com/jyn=
514/rust-forge/blob/llm-policy/src/policies/llm-usage.md</a><br>
[6] <a href=3D"https://github.com/rust-lang/rust-forge/pull/1040" rel=3D"no=
referrer" target=3D"_blank">https://github.com/rust-lang/rust-forge/pull/10=
40</a><br>
[7] <br>
<a href=3D"https://github.com/jyn514/rust-forge/blob/llm-policy/src/policie=
s/llm-usage.md#experiment-llm-created-code-changes" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/jyn514/rust-forge/blob/llm-policy/src/poli=
cies/llm-usage.md#experiment-llm-created-code-changes</a><br>
<br>
<br>
</blockquote></div></div>

--000000000000e94c690652a78685--


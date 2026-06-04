Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204DFCD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5Sq-0002lt-VI; Thu, 04 Jun 2026 06:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1wV5Sp-0002li-J5
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:38:15 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1wV5Sm-0004oq-P6
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:38:15 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6fdfc8cc6so211807a34.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780569491; cv=none;
 d=google.com; s=arc-20240605;
 b=SX4DpNv0vDd8VdTBCTmPa/XBBIEd9U5mBDMCm7FBqeFJtLriH1tMFJrKWsS1sOGr5j
 tjaefntHGaO9RSnpKRh6qLJZYiWs7Zu10Bwt0dYuF3+ATZFeTqdALxaCmeisgEbZDQ9D
 bk2iuLj21vLm3Zi78Gc3YagmQzNzcPVaf5/5Nd3ls9gfC4o1QhyUL65OST0JSf1v20NA
 Hes9jM8Eipsa2Ey3VDMC3xdul6vDO7reibPuBp+WmmIecfOSd0pFzW3l1zugS5Hv9ucX
 ExVWgBi+w4GAJu4kb8uGdaWCCHJOL7YLgj/8A2b8dTbosq8la9bVr6/qEuTgbWNY29+h
 Mjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/FXTxwovTltrDgjafBREoReIwaUQ7/TGSVuSWl9OXyw=;
 fh=bqjH7BNLc76+e6+cQ5/n9pYBhqLA50Xx9/zmk0S6xJI=;
 b=j+TkBtPpwd6Z16n7vYLTj8rnLAr43QE/lTdDlf7Ekogy8lCHVlAd5slhTgdN7YznRo
 fQJAnZG73PA3c+/GqpxoBSMDolt3gOtld1LP82LYGg3ivAV+9ZXecEjK69cmK9MD2+/y
 V44aIWbqCoYHcWv8NNcBQZLusxvZlTv/vT32jD51b5UduDWhrpp2BvY610eS3VroDD9s
 l2PLGUGWtWPD2hwtDzZB/XiZnGNDUKDfGo4MQmCdsJjMVXk9R26yUfpqFPWuAJPoWeNE
 nrkbDq+Fko3CMLvzL0bULXRw4HEeK7GugmZe/olA68y+7/3rxv2UrTKepi0LnVZQljX+
 65oA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780569491; x=1781174291; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/FXTxwovTltrDgjafBREoReIwaUQ7/TGSVuSWl9OXyw=;
 b=ZBNInohSK2wsC2xWSOCfTVT28AboIPsSoDJEN12v7huWu2QFHNArFvjc49qBODFi7s
 1u+X07ray/mDO2+1BTbKrta5nKAchthLFp7EgBiCie+DubHiuSBhZ6vCncAwqm3JPHRj
 CbZq3MeojkGVGU3yFyCGrl8beqrPchhYEdROMD9ntHo2E8ozcq5NyZ+/Nojc63NxHmRo
 wVqKY6V9kyFXgiQzxt8BRC93g3CJ7LP3L3QwGPT/BJb68U4LUKFXl/bCc/yHN6HnDLk0
 9iJiKQQ2bDwuUDjQoxRIjUAzXA400nOFYZ7qBi1EROO9dkY/HEfWdw1v260EYGT9rhpW
 DbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569491; x=1781174291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FXTxwovTltrDgjafBREoReIwaUQ7/TGSVuSWl9OXyw=;
 b=GO01Zjxj9FUxzdN119Jlxd1bKqIVp5xE24E46rodOMK8+dZpajgtKcmbZyYOa2YSDQ
 23OfX8usXbB8I1dadSppgm2HAcXz1V4LtxO1exmC973gkcYnUBIceLWoh8xSkQzfLyHi
 0SlGcLQe5WGGe8cAAOoWNd63ZMVyv/ocExD+IAzcxzN3BrZvG6mgOUREhWncvFxkgd3d
 lBWguERQqN5wTIpl8gkFXlHL3uRALON+yQIQezaQ8iJMXka9rqkzFAxzUilTRl1Y19fj
 X/0nRtuS2lFo7PIpweq6xRZ6cyzPnzRue7zdJOF7USbq2zbVMTDFHQRyfkay5+IenzPN
 +GYg==
X-Gm-Message-State: AOJu0YxwgCN62AfOwRIrNsew9yQU0q46mMU8ROd0YIwO/zJFV4dzg1CX
 lsOEQtPIK0XV3ryUjMiPxuNnDjGwEcWZrxveSq1OGjdFYBGkWriALDLy2T/rBOmjXvXPnkzACJT
 UqoMtWOQY5Wmh/nvRY9Ixe+yb9/s3zk4=
X-Gm-Gg: Acq92OE3vqbeI6ErTK4yrVuuimbPXK5vQ7djSgiRPcadqP/6v9SrPvoLgSAi3WjZijS
 eRQ2yT4NLiUhg4IHUf49BMStZM1uA/FpAXsJNl2Di08mpTjHuuUsAseK9R77br+FDxsnut/LkGy
 hemcOOBV6cJdvTiK48TE4Mbn89mIyPagCUyTduLhyyvZN5zoPXAQl2HTRPCx9MZtv749eyXG9II
 VY2RXKJJy9kazninFzxMkVfVdgrrqrhusvTAdj6fTa2V/NCHA5c9jquwc39nc+Olb082lrdxOyN
 qN+d0J/D0/quMF0+OAI=
X-Received: by 2002:a9d:6a8b:0:b0:7e6:f450:2925 with SMTP id
 46e09a7af769-7e6f4502bd3mr2316550a34.18.1780569491012; Thu, 04 Jun 2026
 03:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <aiBqT1KfI-qowr4L@redhat.com>
In-Reply-To: <aiBqT1KfI-qowr4L@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 4 Jun 2026 12:37:58 +0200
X-Gm-Features: AVHnY4I7DXKpFWKauzK9HzNMmMrBNjD6_UoV8DuMKbAdIo3LLcP7mqlpcYvMlb0
Message-ID: <CAHFMJ7veDE+i89Kh-SaQOL3019W2YC9_o7DeQtDL-YKGxGGHVQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000027f4106536b2466"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000027f4106536b2466
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 3 giu 2026, 19:54 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> The AI policy should just
> make a point that we expect to be communicating with people not
> bots pretending to be people.
>

Yes, it's better to have that stated clearly.

> True but we also need a rule. The spirit is better explained elsewhere
> > (and also, building consensus on spirit vs. a rule are two different
> > things).
>
> Do we have a better elsewhere in this case ?  It is a point specifically
> about intent of the AI policy rule.


The rule in this draft says 20 lines, tests, mechanical changes and docs.
The spirit is what is in the commit message, basically to maximize the
benefit and limit the possible damage?

> > Docs is an area I'm more wary of from the social expectation side rathe=
r
> > > than the technical or legal side.  I don't feeel like "pay attention =
to
> > > the organization and flow" really mitigates to the tendancy to
> production
> > > of vast reams of convincing sounding slop.
>

> Can we do this more incrementally and have a more tightly constrained
> guide for docs initially and review it again at a later date if we feel i=
t
> is worth relaxing further.
>

Sure.

Maybe the same can be done for boilerplate changes like the one I suggest
below?

> See my reply to Peter elsewhere in the thread. I agree with your
> > concerns for both docs and discretion, but I had specific uses in mind
> > that I'd like to allow.
> >
> > For docs:
> > - create tutorials and/or feature documentation based on functional tes=
ts
>
> That doesn't sound too appealing to me. Reverse engineering docs or
> tutorials from our functional tests is exactly the kind of thing that fee=
ls
> likely to result in volumous text of marginal value which will have a lar=
ge
> burden on reviewers.
>

At the same time this can be helpful for maintainers themselves? Let's also
look at this from the point of view of producing better output, not just
from that of being on the receiving end of slop. Especially for docs I have
a hard time imagining people sending out whole new "manuals"... The
bugfixes rule ironically seems the most dangerous to me from the
Dunning-Krueger point of view.

My question is: do we want disclosure for anything is created with the help
of LLMs, even if only small parts survive untouched? I think so, because a
lot more, even if edited, would still be originally from AI. But then it's
important to have rules allowing it and a way to track it.

> - create function comments (including Rust doctests) based on a
> > high-level, human-written description of the module
>
> This feels interesting to trial.
>
> The key difference with function comments is that you don't really have
> any of the trouble with document structure & coherence. The API docs shou=
ld
> be comparatively smaller & easier to read & digest and give feedback on
> accuracy of.


True.

> For maintainer discretion:
> > - updating patches for changes to kernel APIs, before the kernel side
> > is ready for inclusion
> > - creation of parsing code for Rust procedural macros based on code
> > examples and/or a human-written description of the macro
> > - creation of boilerplate code similar to hw/core/hotplug.c
> >
> > I think all of these are potentially compelling and I would like
> > people to be allowed to experiment with them or similar cases.
>
> Those are largely in direct conflict with the intent behind only allowing
> "small bug fixes" Either we accept broad contributions like this as a
> project, or we don't - I don't see that as something that is suitable for
> per-maintainer discretion. If it will not be intended for merge, then the
> policy is irrelevant and people can just experiment out of tree at will.


It would definitely be intended for merge. There's a lot of boilerplate
code in the Rust bindings, for example, that is voluminous but *mostly*
lacks creativity---the creative part basically can be described by the
spec/docs and should already clear the low bar required for originality,
even if the code is automatically generated. I included a couple examples
in my reply to Peter.

I have no preference for writing English or a programming language, but
writing both sucks and LLMs are much better at coding than writing specs
(plus, code can be tested). This is exactly the opposite of small bug fixes
which are themselves the product of a creative process (debugging) but
small enough that, once you've debugged them, there's basically only one
way to write them.

> The idea of contacting maintainers beforehand comes from the policy
> > currently under discussion in the Rust project.
>
> I presume you're looking at
>
>   https://github.com/rust-lang/rust-forge/pull/1040/changes


Yes.

What I find interesting there is that their rule that is comparable to your
> "small bug fixes" rule, emphasizes it is about allowing "trivial" chances
> and specifically references the idea of a threshold for originality /
> copyrightability. I find that more satisfying than talking about lines of
> code and bug fixes.


It's also more abstract though; and doesn't touch on what happens if you
stumble on someone else's threshold of originality. We're not lawyers, and
our contributors probably have thought even less about these issues. That's
why both Rust's policy and this proposal have (different) concrete ways to
stay within the spirit.

The talk about experimenting with LLMS for larger changes emphasizes
> experimentation  and use of PRs in order to trigger the run of tools from
> their review pipeline.
>
> That doesn't explicitly say whether such "experiments" are permissible to
> be merged though


There is a part that mentions "pre-arranged, non-critical, high-quality,
well-tested, and well-reviewed code changes that are originally created by
an LLM", "to experiment with LLMs to inform future policies".

They mention a private channel where maintainers can discuss whether the
PRs pass the standards required of LLM changes. The mention of a higher
standard strongly suggests that they intend to accept them, otherwise why
would you have people do the work for nothing.

Likewise, they say that for CI runs no disclosure is needed while "if a PR
is no longer marked as clearly experimental, at that point disclosure is
required". The no-longer-experimental PRs fall under the previous rule, and
IMO this sentence also supports my reading that they are intended for
merging.

This is what I would like to have in QEMU as well, so that people are able
to learn. We need to trust maintainers to understand the spirit---which
does mean we need to write it down, though. :)

Paolo

I don't know if the Rust project has specific terminology here, but my
> reading of that was that people can agree to collaborate publically on LL=
M
> work, but that does not appear to give individual maintainers permission =
to
> waive the LLM policy rules to merge arbitrary LLM code in the way this QE=
MU
> proposal suggests.

--000000000000027f4106536b2466
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 3 giu 2026, 19:54 Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
berrange@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">The AI policy should just<br>
make a point that we expect to be communicating with people not<br>
bots pretending to be people.<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Yes, it&#39;s better to have that stated clear=
ly.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">&gt; True but we also need a rule. Th=
e spirit is better explained elsewhere<br>
&gt; (and also, building consensus on spirit vs. a rule are two different<b=
r>
&gt; things).<br>
<br>
Do we have a better elsewhere in this case ?=C2=A0 It is a point specifical=
ly about intent of the AI policy rule.</blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">The rule in this draft says 20 lines, tes=
ts, mechanical changes and docs. The spirit is what is in the commit messag=
e, basically to maximize the benefit and limit the possible damage?</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">&gt; &gt; Docs is an area I&#39;m more wary of f=
rom the social expectation side rather<br>
&gt; &gt; than the technical or legal side.=C2=A0 I don&#39;t feeel like &q=
uot;pay attention to<br>
&gt; &gt; the organization and flow&quot; really mitigates to the tendancy =
to production<br>
&gt; &gt; of vast reams of convincing sounding slop.<br></blockquote></div>=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
<br>
Can we do this more incrementally and have a more tightly constrained guide=
 for docs initially and review it again at a later date if we feel it is wo=
rth relaxing further.<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Sure.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Maybe the same can be done for boilerplate changes like the one I sugges=
t below?</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
&gt; See my reply to Peter elsewhere in the thread. I agree with your<br>
&gt; concerns for both docs and discretion, but I had specific uses in mind=
<br>
&gt; that I&#39;d like to allow.<br>
&gt; <br>
&gt; For docs:<br>
&gt; - create tutorials and/or feature documentation based on functional te=
sts<br>
<br>
That doesn&#39;t sound too appealing to me. Reverse engineering docs or tut=
orials from our functional tests is exactly the kind of thing that feels li=
kely to result in volumous text of marginal value which will have a large b=
urden on reviewers.<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">At the same time this can be helpful for maintainers the=
mselves? Let&#39;s also look at this from the point of view of producing be=
tter output, not just from that of being on the receiving end of slop. Espe=
cially for docs I have a hard time imagining people sending out whole new &=
quot;manuals&quot;... The bugfixes rule ironically seems the most dangerous=
 to me from the Dunning-Krueger point of view.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">My question is: do we want disclosure for anything i=
s created with the help of LLMs, even if only small parts survive untouched=
? I think so, because a lot more, even if edited, would still be originally=
 from AI. But then it&#39;s important to have rules allowing it and a way t=
o track it.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">&gt; - create function comm=
ents (including Rust doctests) based on a<br>
&gt; high-level, human-written description of the module<br>
<br>
This feels interesting to trial.<br>
<br>
The key difference with function comments is that you don&#39;t really have=
 any of the trouble with document structure &amp; coherence. The API docs s=
hould be comparatively smaller &amp; easier to read &amp; digest and give f=
eedback on accuracy of.</blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">True.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">&gt; For maintainer discretion:<br>
&gt; - updating patches for changes to kernel APIs, before the kernel side<=
br>
&gt; is ready for inclusion<br>
&gt; - creation of parsing code for Rust procedural macros based on code<br=
>
&gt; examples and/or a human-written description of the macro<br>
&gt; - creation of boilerplate code similar to hw/core/hotplug.c<br>
&gt; <br>
&gt; I think all of these are potentially compelling and I would like<br>
&gt; people to be allowed to experiment with them or similar cases.<br>
<br>
Those are largely in direct conflict with the intent behind only allowing &=
quot;small bug fixes&quot; Either we accept broad contributions like this a=
s a project, or we don&#39;t - I don&#39;t see that as something that is su=
itable for per-maintainer discretion. If it will not be intended for merge,=
 then the policy is irrelevant and people can just experiment out of tree a=
t will.</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">It would definitely be intended for merge. There&#39;s a lot of boilerpl=
ate code in the Rust bindings, for example, that is voluminous but *mostly*=
 lacks creativity---the creative part basically can be described by the spe=
c/docs and should already clear the low bar required for originality, even =
if the code is automatically generated. I included a couple examples in my =
reply to Peter.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I have n=
o preference for writing English or a programming language, but writing bot=
h sucks and LLMs are much better at coding than writing specs (plus, code c=
an be tested). This is exactly the opposite of small bug fixes which are th=
emselves the product of a creative process (debugging) but small enough tha=
t, once you&#39;ve debugged them, there&#39;s basically only one way to wri=
te them.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">&gt; The idea of contacting main=
tainers beforehand comes from the policy<br>
&gt; currently under discussion in the Rust project.<br>
<br>
I presume you&#39;re looking at<br>
<br>
=C2=A0 <a href=3D"https://github.com/rust-lang/rust-forge/pull/1040/changes=
" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://github=
.com/rust-lang/rust-forge/pull/1040/changes</a></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Yes.=C2=A0</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">What I find interesting there is that their rule that is comp=
arable to your &quot;small bug fixes&quot; rule, emphasizes it is about all=
owing &quot;trivial&quot; chances and specifically references the idea of a=
 threshold for originality / copyrightability. I find that more satisfying =
than talking about lines of code and bug fixes.</blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s also more abstract thou=
gh; and doesn&#39;t touch on what happens if you stumble on someone else&#3=
9;s threshold of originality. We&#39;re not lawyers, and our contributors p=
robably have thought even less about these issues. That&#39;s why both Rust=
&#39;s policy and this proposal have (different) concrete ways to stay with=
in the spirit.</div><div dir=3D"auto"><br></div><div dir=3D"auto"></div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
The talk about experimenting with LLMS for larger changes emphasizes experi=
mentation=C2=A0 and use of PRs in order to trigger the run of tools from th=
eir review pipeline.=C2=A0 =C2=A0<br>
<br>
That doesn&#39;t explicitly say whether such &quot;experiments&quot; are pe=
rmissible to be merged though</blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">There is a part that mentions &quot;pre-arranged, =
non-critical, high-quality, well-tested, and well-reviewed code changes tha=
t are originally created by an LLM&quot;, &quot;to experiment with LLMs to =
inform future policies&quot;.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">They mention a private channel where maintainers can discuss whether =
the PRs pass the standards required of LLM changes. The mention of a higher=
 standard strongly suggests that they intend to accept them, otherwise why =
would you have people do the work for nothing.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Likewise, they say that for CI runs no disclosure is=
 needed while &quot;if a PR is no longer marked as clearly experimental, at=
 that point disclosure is required&quot;. The no-longer-experimental PRs fa=
ll under the previous rule, and IMO this sentence also supports my reading =
that they are intended for merging.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">This is what I would like to have in QEMU as well, so that peop=
le are able to learn. We need to trust maintainers to understand the spirit=
---which does mean we need to write it down, though. :)</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I d=
on&#39;t know if the Rust project has specific terminology here, but my rea=
ding of that was that people can agree to collaborate publically on LLM wor=
k, but that does not appear to give individual maintainers permission to wa=
ive the LLM policy rules to merge arbitrary LLM code in the way this QEMU p=
roposal suggests.</blockquote></div></div></div>

--000000000000027f4106536b2466--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F00C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jew-0001JI-On; Wed, 02 Sep 2026 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1jer-0001GY-Uz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:01:41 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1jeo-0006y4-2s
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:01:37 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8565d77c277so13334927b3.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 05:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788350493; cv=none;
 d=google.com; s=arc-20260327;
 b=pLc58Yzdhl8+qhBSdKoXZhJrQA6HKHgnFQ2ebTbQ5GIoClCI/7RQy00Hl8/8lyYwA9
 8pMbToAFD38f/XhkemOZQ2EdvYxW2wu5HlnDP9uJ+zN8ykuV9wjXuJbsbcpyIQmUa96o
 4XhlPnw6bmRwqdvZ9+xHUdiLzGpdEXdYGADCzDR20hOEhbchv70yGk78gEz02o8I+psv
 oiWhAlJN137o4bTVXcAxSzDqGRa0edxdsXrqob3vqecsdw4uZF2n1xGCPGz0cM2GN9t6
 /XZtz38M3dD0IzNUDuZfe7JSQ+Zv69EB0b4TP7b/004QMuL4x0WqmLFD3smr9+G6yd/+
 Jx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gJGho1kDz08P7fpU6MTb55uL4CgwP91c8P6KByXkmyc=;
 fh=6U3EuTcRI558ur8aI3k9oN1w70US02nJDPsGjU5qkdc=;
 b=TOCImuCMzPA4Vv/XhLEHQOqXSlLNFCx3p20nrWlYbnE/Q9ZpP7VLw8M/jc5/CMbH+g
 oV7Q8z+wqC8zYo/GxokisGGILrKNFjQXhoT6sJ7jpcRbpdtKgfzgK545r7jtUn1nm77N
 KayiWp56uQxIRyDWkAVIwUurFETF4OFKC6+NhmqjUX91kocWmuWzXaN7Dyw0W7OTknaq
 EsTRqXh3DEgDuYKH1VNfjt80dlkKd3NXgh64dehSTL2s7Sw263WShHq61MazZrJ0n3EL
 YFOLx0Vf21fJi/5Md4m1aJgSLmXR5MEi3O1f0KwOLJpHzwqjL+UtngVAi1UUiREFC+hK
 pUCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788350493; x=1788955293; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gJGho1kDz08P7fpU6MTb55uL4CgwP91c8P6KByXkmyc=;
 b=ljxindUdAAP2IEeW4MCaJL22n4J5touVWQ+ISTTcfRkGC/Ha0szD9H3uZ3xovtaRNM
 +ehvXoe7N0YF4hSLH2k3G9+3yyBk+pbtQn04ztaGovVs7Jxj+GnVEl8r+jtGESC7usLo
 G6q8s3vccMz/1+detcnrJC+8oBSN8lHwb1gvffj5IWFi8q1Lkr2VcxLAu3rVRFVYqDhD
 p/qYsbI2uBGJn9rUdDTiZBzNpFyzf8bzjy1w1W3XyUHPYdqLorrVkeqi3bjC+aWz2oIK
 1bkvfTt/pLBitiVrxIGzXLRInftRFpz9jctIyckHQSYm7SsqnW54T5yC7xdojeco+vbb
 x68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350493; x=1788955293;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gJGho1kDz08P7fpU6MTb55uL4CgwP91c8P6KByXkmyc=;
 b=QnpIXrdPrsBUHX9tOeMOUd/jFLhddu0Mxt4V4jhXjO1UdjaVsNVUDFOlImQfySYKb+
 MQiiFWIODv6hywomDBx2La0919dyCJn8c4BrdtlEMKH3Nm7X7sENBpq7SmtFa93C590b
 bNwfn22jwJNflWH74FpHa1Q14LtQih4Not5Le/IT2wmAJM830l5Q4WDhpJhAPHi5XMNi
 Myzw/tyHadNrAPD+BLkehbdy8/1DW+y5L0FT/oowZyv0l2DKOKnrzag+6ZaW8D+xA5LP
 26sIljPBTLolHbrvDS/MsEaJlGNLXHFToYPZ6xpR2M1biWMHMQlBaxHTr6jKObmbfoQm
 VLNQ==
X-Gm-Message-State: AFuF++k5whzdKjSWyZEckyjBS5ylF4Ncc/n1Iz/uGRuJXBUB0cls3Lvp
 4sHwz0+ATmutMTZEKb87AvPJ3SFVRaJoVEKBbgdHyWVjS/HOh7btVlPiAcgRNF8htJJsssQmr67
 oYswfA0OR358R4CvV/90fOBcRcIFQh+V7nb8UIZOOHw==
X-Gm-Gg: AYBFou0zx8+giD4Z4pGNb0I0P05roz54Dhs2QmBmPD6+qNsxesoCUzMEWYxIvvokZKk
 m/kqikW5e6F9iaoiVlnCXTrpYLqoEd7axH/AMk/QwZtMJ8l0Umd+8j6FhTxt28BDTPx9zRPBWZG
 tWfC7O13hVQr+gqLFVKzrVFwb5LVKEHmzNDegPN/2MUKvERSJg+Y930X94QzlJCX6nErjV86fs5
 +TbaEPygGjobl4wuf0jpBLmQL4VFkDEjj/LSUJCwtPM5RyTxxht87gPrkzL1zjX6hEGkMdzcpwu
 BkJb474JujLVMKiIOx6eEIxBtBc4RPrNWp2XEiA7PFB2h+dcSbVDagu1nFoRq65xAEX95RjC8/6
 jEbiL5J1NlKv5FpmFyobIiyPolUuy
X-Received: by 2002:a05:690c:c4e9:b0:85a:634:169d with SMTP id
 00721157ae682-86c54b24a86mr20605797b3.33.1788350492440; Wed, 02 Sep 2026
 05:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-2-pbonzini@redhat.com>
In-Reply-To: <20260901161422.314581-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2026 13:01:20 +0100
X-Gm-Features: AcwNN1WKYTbTfxp-1PMTBpA8QyIl17Rw-71kDt1-UN8Q23U7yRckXkGNR0NeNtQ
Message-ID: <CAFEAcA8Scb5DzNANczkrg72z8maWy+hAAkNEv-d0c=V2rOLK6Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: introduce a new policy on AI-generated
 contributions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 1 Sept 2026 at 17:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify and enforce.

Yes, but the "enforcement" part is just as hard to deal with for
any AI policy short of "we don't care whether AI was used or not
and don't care if it's labelled that way or not". A contributor
who was unaware of or chose to deliberately ignore our existing
AI policy is just as likely to be unaware of or to ignore an updated
policy that says "yes, but only with limitations and must be
pre-arranged for larger amounts of generated code". (A contributor
who deliberately ignores the policy is I hope going to be rare;
contributors who are simply unaware of it are something that we can
hopefully improve on by (a) having an AGENTS.md that will tell their
LLM about it and (b) asking in case of doubt on the maintainer side.)

I think fundamentally my issue here is that to me it doesn't seem
like the project has problems with "we aren't writing code fast
enough"; the problems are more "we don't have enough code review",
"our existing code is getting holes poked in it by automated
bug finding" and "we have too much old code that's barely used and
unmaintained". So an AI policy update whose major move is "allow
more generated code" feels bad to me, because it's inevitably
going to increase the workload on reviewers and maintainers.
I would be much happier seeing more use of AI in the project to
help us where we're struggling.

> This proposed policy seeks to implement the cautious experimentation
> approach, inspired mostly by the Rust project's policy and by Software
> Freedom Conservancy's own recommendations on LLMs and generative AI.

The question I had with the Rust policy was to what extent their
"experimentation" is actually going to be cautious experimentation,
and how much it turns out to be "this is a back door that lets the
people who want to write and review LLM-generated code do that anyway
as long as the people who don't want to can mostly ignore it".

If this is really experimental then we should have some clear
boundaries and criteria for our experimentation, covering for
instance
(a) when do we assess the success or failure of the experiment?
(b) what are we looking at to decide success/failure?
(c) what are our boundaries for what kinds of change we're willing
    to make under this experiment and what we are not?
(d) what is our plan for rolling back or otherwise recovering if
    the experiment seems to have failed?

The Rust policy makes some attempts at some of these e.g. with its
"circuit breaker" provision and the requirement that LLM changes are
"non-critical" ones.

> +LLM-assisted and LLM-created contributions
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Use of generative AI tools for code contributions generally falls into
> +four buckets:
> +
> +- "background" assistance, such as completion and code review.  This does
> +  not need disclosure, however you are expected to examine and understand
> +  any code or any changes produced by the tool.
> +
> +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
> +  are allowed with disclosure.  Splitting a submission in multiple parts
> +  is **not** a valid way to bypass this rule; repeated, frequent posting
> +  of such fixes must follow the rule for full contributions.
> +
> +- use of LLMs to help generating parts of a larger patch---a test case, a
> +  parser, boilerplate code for a new API, a tool to help performing
> +  mechanical changes, etc. These are generally allowed, but disclosure
> +  is recommended.

I guess I'm generally OK with these (though I might add an "If in doubt
about whether your use here is too extensive, ask" to the last one:
"a parser" is potentially a pretty big thing to be delegating to the LLM,
for instance, and might either be "mostly boilerplate" or to shade over
into the "writing large parts of functional code" category).

I do note that even for "small bugfixes below 10 lines of code" the
code review effort can still be pretty huge where it's touching something
like a device model, where you have to go and find the right datasheet
or spec and confirm whether the proposed change is really the right one
or if it just fixes whatever the assert/crash was but in the wrong way.
(Handwritten example from me: I tried to fix an IDE divide-by-zero
https://patchew.org/QEMU/20260630104249.2533126-1-peter.maydell@linaro.org/
and even though I had read the IDE spec and the fix is pretty small and
it does fix the bug's test case, it turns out that it's a lot more
complicated than that and the proper fix is something entirely different.)

Having a hundred "fix minor bug in old code" patches on the list that
are unreviewed isn't a lot better than having a hundred issues in the
bug tracker (indeed, it's arguably worse, since we have no tracking
system for patches on the mailing list; at least the issues won't just
get lost in the deluge...)

> +- large, heavily LLM-assisted contributions where LLMs write large parts
> +  of functional code.  These are only allowed if *pre-arranged*,
> +  *high-quality* and *well-tested*.
> +
> +The last case (*"LLM-created contribution"*) is the one that requires
> +a more careful approach.  In particular:
> +
> +- "Pre-arranged" means that a maintainer has communicated ahead of time,
> +  for example on `IRC or the QEMU mailing
> +  list <https://www.qemu.org/contribute/>`__, that they are willing
> +  to review an LLM-created contribution.
> +
> +- "High-quality" means that the contributor must apply the same judgment
> +  that would be applied to other code changes.  Contributors must invest
> +  substantial time reviewing their contributions, curating them, and
> +  understanding them in depth; in particular, you are still expected to
> +  :ref:`understand and explain your changes
> +  <write_a_meaningful_commit_message>` and the rationale behind them.
> +
> +- "Well-tested" means the LLM-created contributions will be held to a
> +  higher standard than human-created ones, because LLMs make it easier
> +  to write tests.  There are no exceptions for "writing the tests seems
> +  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>`__.

This last part is the one that I am much less certain about, and where
I'm not sure we have sufficiently bounded and defined our experiment
(as noted above).

I'm also more willing to allow leeway and to trust the judgement on
LLM use for somebody who is already a regular contributor to the
project (and so has some idea of how the codebase works and better
ability to spot when generated code has gone off in the wrong
direction), versus patches from somebody who hasn't contributed
before. Is that something we want to try to encode in policy
(e.g. with limitations on the "pre-arranged larger contribution"
case) ?

-- PMM


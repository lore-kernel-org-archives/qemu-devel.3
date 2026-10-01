Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F22CA5FCC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 12:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCFnU-0006Rm-N0; Thu, 01 Oct 2026 08:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCFnT-0006RY-J6
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 08:21:59 -0400
Received: from mail-yx2-x0d.google.com ([2607:f8b0:4864:41::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCFnR-0005uh-8s
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 08:21:59 -0400
Received: by mail-yx2-x0d.google.com with SMTP id
 956f58d0204a3-675bcac8ceeso2158541d50.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 05:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790857315; cv=none;
 d=google.com; s=arc-20260327;
 b=jkPY+AjeFZFyZdHfk38jCxSXdxI2b0bIxl8qe/c//2aDHQDjRcGSMiSuDccUYCdq5I
 Gcju352ToOJRp+FlIMcQIvB3p21yf/8R2TLxiuJgnBxMAOCyQFPLsqcwXJIfsSopt+lB
 tJ232Wf5K/dRx3IxpTYqS4DSo8+DdwPbwsZz6VOnWMnsakRA7aEqJ3cAejVyqFEgz6lq
 sEbPu5EvdhMTPd5tPhvwHURtCLpQ0OEtlVgToC14Xy08BvrHSdO+zsMW6tfjuOFF3qcg
 LGquxWSlPp4B4FhFk8LSllhCANfqYBJIgHHlLD1BJ2DoGv54X8odiCrZWYiIWf/wa6sq
 KpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+gDC3XXdEGw7QVBv8q9gnA46y6HGblmdDQbU31VYunE=;
 fh=YUyQhuKKaM8zIiKq6wqIM6WRKP7NtW7B8IhW8S+ydRU=;
 b=lch1iwcWzUVTQgUHjNmeiv5rwAVnUWVi8LKJOqsUOaVsqU5SEqW5WgQ+uOLPdY5MIw
 ZIb8fr5IIRXmSHcfLrVHyCSM2e7VG274q1jxofMA+b5CCJiXcapheQQFCqr9922SpZB3
 lByMCs/zU46nHaYxGU35EFN508MWCN9u42ZOudxoIQyDxgENdGWav44j+Qio7YAsi3zj
 /qgMlOjfrsgoLKNWVEHZwgGtgWzx71af6lJxtP6lsNNa1fa+8JzQ9jlFXkFBRdHjr/F1
 5DSLq0AMoZPSYwxJyBn5Dy7qAUS9lZUDofewRXZI+lNlksU0wCAoR1Zt2Iw31B5H59Iz
 PyzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790857315; x=1791462115; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+gDC3XXdEGw7QVBv8q9gnA46y6HGblmdDQbU31VYunE=;
 b=mIhivnrCD+K1orzFhXuWThWComXSCQZB8DbogAZdiYnzTxJXtOUShzgwr5KFhvDGfP
 ECbSSKOXnIS4uA6RRu6+KZjy9u304CDir+ih8VIzIV/g4sVZIHtpe9K1PUdyhqXIGEG2
 sPU3XEgJn3FjdaiqVtL7zDT0pVaPKSrYyKcQpgppZj1/4wmIq0YPbDD5Cs+J73ClLmk7
 bRZSw47Do3QVzWSnfOObDGLLXmpGysYooDU/6U8JkpqiPj7f0V2Jht6iSJlOg7eTPaKD
 XLf3HmIfearbJm5p7ikwbf/SYbjGoedyViFbf2CFfA0yURtQ7b1ettgeTPRJvuPI9c49
 nU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790857315; x=1791462115;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+gDC3XXdEGw7QVBv8q9gnA46y6HGblmdDQbU31VYunE=;
 b=kwUlsGoXGjb7kJvICIg7uf+ZYqqils1hymfxdAkzP2OfkK/PSmuGrC0qwdkOmJ+e6Z
 SqQmJbkVFxw4SdDOeOAWTy5bH52l31dhDk9px4rQYg4ZaNpOoWNufYRjIWkuiqkNvJST
 YrPF5UrGbwORsW/N7zwXAmP/TOQ3NGKmVN6KIv8MJp5jgKKJMymmQ8JMiXmc4LyqCBIT
 SAzWr8A+Vn2aPWTVPWImdPAuagyzel9+KVbA8v4DnnRzJHQqxnLZQ8ruO7rAk0hLv66D
 T4i67NN/Ham4uCiLff7Wu9TDouKRFhvFp/Y4sabaiIa5wMCivKCzErT3JoKCoT8h0uuV
 b8og==
X-Gm-Message-State: AFq9FYJU0gjnluaTGOMzj4Rc2AzqiRqrXyunEMJMG9bkTNLr8EDC5BIz
 94p5oEADXCL4uYABUBB8MHtW3904CmNb+AG/CYv5hts+kh8Za4G2bplrjMw0dSVBuNyqBOiGx5Y
 kXuYFqbRxKa8SzucgTXrZ7Z5I7R0D9Y7SF2eTCUSRnA==
X-Gm-Gg: AYBFou1VS2OTyQKt/CfiSZcVT2Y/bWy75uSQaDPhqan8FteQli6JzwUNvpwNN0V0DBS
 iDtHyXaogMO4FOzxQdvxgqghBrXEBb4MyKhOVbsXJ/sUquozz5E7K13KuwpH8jo3nckVGiZ2+RP
 VfOGw8uVlwNxkZ7kc8IfnSDeMWdJtDBsry453ufhBaDUcUiouz0tOYkaiDbGo4kJv1xKqmUXwML
 M8mjC253nHYvL0xdN7GIjWKqqzzAyi9duohGzOErNYx8T9wh3P5jowYlTRi7xW9TyWXfPKd0dED
 vttB/1V+uQsr9mE09aIpopoCazApEmFFVoFYER526TEarxczrpWRoDhy1E8dG/MbQtTScJpJzBV
 zJgHOqjt1f0G2jYY+1zcO7/jw5JBcYidznO05hRw=
X-Received: by 2002:a05:690c:c625:b0:8a9:43b1:bbec with SMTP id
 00721157ae682-8ac920920e6mr15149497b3.37.1790857315242; Thu, 01 Oct 2026
 05:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
In-Reply-To: <20260930085433.830743-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2026 13:21:43 +0100
X-Gm-Features: AclHuK-Qsw2E9Aci5Eyp8arrVajgjfeds1eh92kho_Y2PmGDwYDXGARd0rLPUHw
Message-ID: <CAFEAcA91XU=_hS3iB+0p7hXQ_nvf0YpgNZaKsd=b=fSVaTJDxw@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 30 Sept 2026 at 09:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
> +LLM-assisted and LLM-created contributions
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Use of generative AI can be classified in the following four buckets:
> +
> +- "background" assistance, such as completion and code review.  This does
> +  not need disclosure.
> +
> +- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
> +  are allowed with disclosure.  Splitting a submission in multiple parts
> +  is **not** a valid way to bypass this rule; repeated, frequent posting
> +  of such fixes must follow the rule for full contributions.
> +
> +- use of LLMs to help generating parts of a larger patch---test cases,
> +  adaptations of existing code, boilerplate code for a new API, a tool to
> +  help performing mechanical changes, etc.  These are generally allowed;
> +  disclosure is highly recommended for non-trivial, functional code.

I think we can get or have consensus on these first three buckets...

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
> +  understanding them in depth.
> +
> +- "Well-tested" means the LLM-created contributions will be held to a
> +  higher standard than human-created ones, because LLMs make it easier
> +  to write tests.  There are no exceptions for "writing the tests seems
> +  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>`__.

...but I think fundamentally I am not in favour of having this
fourth category of permitted uses. It seems even to have lost the
idea of it being an "experimental" approach in this revision of the
series. The first three categories are fine, and I have no particular
problem with our relaxing our current policy to explicitly permit them.

Our problem as a project does not seem to be on the "writing
code" side of things, but has always been on the "code review"
side. This policy relaxation makes it much easier to write more
code. Even when there's a "pre-arranged reviewer" that isn't
necessarily helpful -- if you're one of the primary maintainers
for an area of QEMU then the fact that somebody else is reviewing
it doesn't make a big AI-generated code infusion any more palatable.

Allowing large heavily LLM-assisted contributions seems to me:
 * the biggest risk legally speaking (though I think this is
   in practice not all that big a risk at this point)
 * the biggest risk of the codebase degenerating into
   unmaintainability
 * the biggest risk of finding ourselves reviewing contributions
   that are in practice much more vibe-coded than the policy text
   above is asking for

I look at our issue tracker where we see AI assisted contributions
that run the whole range from "an human making intelligent use of
the tool to provide high-quality bug reports with good analysis"
through to "absolute slop dumped on us with no apparent human
thought or intervention". I don't really want to expand that
from our issue tracker to our code review and codebase, please.

I would be much happier seeing the advocates of AI putting
effort into making the process of QEMU code review better and
less work, rather than in applying it to the code writing process.

thanks
-- PMM


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97722606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M4YcYjJZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVTM-0007LJ-6w; Mon, 23 Nov 2026 09:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVVSp-0007Jp-AO
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:56:16 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVVSn-0006bH-78
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:56:15 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6767d92cde6so3594077d50.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 06:56:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795445771; cv=none;
 d=google.com; s=arc-20260327;
 b=kAdmFIjbFlcxaWObACOqrFXTwwuZ6Z+rV+7LJGrZXZWuHPIO9yPR5fdj4I1xwNm88I
 NOHxv3v4i/1faX++kt5EQ+9ufWRLb1y1W9KcigTPASHjfMS7uA9KjRnHkIrMr4lBhtqG
 WD4mcMqIAj2wLKHRxZWvK+0Rk4zkRM1dHQXy79e9JAUrUFeyXc0t5CDY7t0L9ib2IrHY
 xddB9xw0V7zkZrRfPM/M7hRxcGw8Z4J30ZI0QMcDu6mDXqjOiS5gn+uBXYL7AYO41cVw
 BKhzxHFfhi3Mwd1mGtbTo3z6T4JwXNhPyxJitENaJ0kYKqvVtGipQGiT5KJCKmMsHxt3
 UiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a2d0Y/CshTXFAygrb/k/7gQMPUQyVJwEVlqJZloD/N8=;
 fh=YUyQhuKKaM8zIiKq6wqIM6WRKP7NtW7B8IhW8S+ydRU=;
 b=nngrpSmp7N1hteJ78M6zj7CRyRPp11Qm0UX2g1JaoIU1mr+9zcO/Y/tn4wzJTTCOqA
 UWnAbaWnYqHQh1VRrloLRG6jdtmZlwAfN6V1Tr4BGCrHx+yvQipLJfVsGMQkSvVJGwH2
 LbQg2vqzL92IKe5ZmBsfF/x68uTE/A3Bd3XblZ4b7RRK5+HlltsF4c2GVUJR/V5/Q9qs
 xND7W9h5e3uQgpYvpWJIDI5PvGPVbn6oCaz7a207LY4A3ZjDyI+fk2m7kKoYZUwdS57s
 UIBVVHgKzQaArXoY2FBTMRWATjtoWTmHiICH6uvc7xc2DNDnCijRb+cw9s0eA0+JzO+H
 Erhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795445771; x=1796050571; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a2d0Y/CshTXFAygrb/k/7gQMPUQyVJwEVlqJZloD/N8=;
 b=M4YcYjJZ6hfFP2WPQ517JIKW2114XRsigAz2WC/YZr/3/SaEF7o7hcWWZUSyAYhh4H
 6jm/yboENkxkzGGr+3v0PbjR4OzAryC8ePM04v/rcw+uWEZDQQvEwpmxjcHK3tCkoqHg
 Ffaq8Z/EGBM09zweCgqJKTKmTf+kbJQJ1rDdtGuDlii6J5Mmbo0PGdTFKign98QRw/ua
 ljEMVFlwvssprlYW8ELNNJF1oBLDkpxbUKq0dIyCCz1NBa7W2mClNUR5R2BMCCCs8Tdq
 Rzhw5ij24FqZ2yOHysJdXsQHu7xEAM0bK8kiCPx8IFwyDBIVZ6WfIcZuXo6Mvrx7oB6f
 1Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795445771; x=1796050571;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a2d0Y/CshTXFAygrb/k/7gQMPUQyVJwEVlqJZloD/N8=;
 b=UKYlPPUDbeXbJszBMePZoY4UXM10aGXQiUBXjWJftNmnTFOi8UaX7zWGgdz6WUeO35
 5fDyUWuLFb6K54OHJzbyS90veY1fdYbt4SgJTEFLCCcZPONXrP26nyaKTTAoAFmAR/GU
 nIGQxC7xuEQbqFYHPYsQfKVyvjrV/rjoiL3lNf65fyFy2t0pcMIGaE0FG4NWYtkDCUTc
 SbySnxbjVU2a3xTwUo4IgSs5L/w5KgnDsYmQdBQcpfCa+9Y8GL467cDuQpk/+1pgnSEM
 ag6NKdsymlUQD8Li+5x7rTlLzVMpga+had2RdgLZu4/Ml4xmI2ZcKTpmBouj820WlUq9
 //vQ==
X-Gm-Message-State: APuU4Z/gFci/PejwD1k/Ru0uQ8rF7PkqLPyqkKB91903WZ+ucfy10VQX
 4ppQ+9xjwnCrYhm5MLlbHedorJaILwwxPK0Vtj7ucGBiD/4hTN8sD0xIRZgLVqNY9xFsLmMbEf2
 GZsIUajBz3tfu4WidHc+6+NCuTDnrCl2xmkhh5p38LQ==
X-Gm-Gg: AZFdTZdmtQOzhB99FO38PKZv93e57QVPOHGOa5EZl+mG5O8FOJdDWAhNTffeN3okS3h
 88Dr93pZ43uEqQye3wgs8+2w6drsEnX2pD2MlKr3OUvjEOvAeHigGI0u4qQi90gq3yznO5g7DHi
 HJ0Mc4UjMxgXXFgzdMw6OlZe5WXjl8DYEB9mtLm07wtnXdo48P2sqPkyN9+a6riJaQIsizZKfC9
 05BjabcM1EZAL5SEYt9IHi02A+XlNMJoqWgUqj6QlP3S6tobjBSxc4SzwLqK4SFirbhqx5jGl1s
 nP/cJ13vWWLAfOiSLbcp5Xh7BlwMlw9A+/LRJPUS1v/5HWflecz+AjBBTlYMjlI+y35uJgRg3rz
 Z5hXJpPkOTVIaAQhFEcHqLFfAYa2sBXhQKXL7ah3IkRnccEu/M+1bZP45qJQEG3jVwC512jMtQI
 XGdBchp+F6vm9x35Kb8f+8
X-Received: by 2002:a05:690e:130c:b0:67d:d775:3307 with SMTP id
 956f58d0204a3-67df4493c44mr5115764d50.100.1795445770899; Mon, 23 Nov 2026
 06:56:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118104150.599535-1-pbonzini@redhat.com>
 <20261118104150.599535-2-pbonzini@redhat.com>
In-Reply-To: <20261118104150.599535-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 14:55:59 +0000
X-Gm-Features: Aa3M54oQWuQnhJz-fJgYQSotcBQt_w6gGYwscQ7SfY3X5QKJPFt7T_-JHLVw5Ec
Message-ID: <CAFEAcA_XYrr9E6YGkyJumnUyJ-4Zr_6c30jMhtDZe=fLkgtphg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 10:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify and enforce.
>
> Even a simple code review task these days may result in the agent
> suggesting code changes, or producing a useful test case to verify the
> presence or absence of a bug.  A hardline interpretation of the policy
> makes it hard to use AI even for tasks that are explicitly allowed.
>
> On top of this, several maintainers have pointed out that contributions
> that can be reasonably suspected to be AI-assisted or more have been
> posted and included.  Some of these contributions are actually of very
> high quality; it seems that the mailing list-based contribution process
> has mostly protected QEMU from low quality patches.  A prohibition on
> AI puts maintainers in a difficult position: on one hand the DCO process
> lets them rely on the submitter's certification of origin, on the other
> hand maintainers are supposed to know and implement the process policies.
>
> Since the policy has been written, other projects have discussed and
> taken their stance on AI contributions.  These vary from full prohibition
> (though typically motivated by social reasons rather than legal, e.g.
> for Zig) to limited use (e.g. GCC, allowing small contributions and
> tests to use AI), to cautious experimentation.

This seems to be missing out the more pro-AI end of the spectrum,
which extends further in that direction through approaches like
"no particular restrictions provided there is a human in the loop
and contributions are labelled" (e.g. LLVM) up to "we don't care at
all, go ahead and use AI in whatever way you like" (no example
springs to mind but I assume some projects have landed here).

> This proposed policy seeks to implement the cautious experimentation
> approach, inspired mostly by the Rust project's policy and by Software
> Freedom Conservancy's own recommendations on LLMs and generative AI.

I don't think this is true any more now point 4 has been removed;
this patch is more in the "limited use" category.

> Relying on Conservancy's legal guidance allows us to focus on the
> interaction between contributors and maintainers.  Conservancy in
> particular provides this point to alleviate the concern that motivated
> the policy, about whether the submitter has the legal right to contribute
> the code and about unintentional reproduction of copyrighted code:
>
>    "Copyleft Everything" remains the best viable and safest approach
>    Certainly those who want to release FOSS under non-copyleft licenses
>    have more to worry about when using these tools.
>
> While we shouldn't treat copyleft as a silver bullet, it is effective
> as part of a defense in depth strategy that includes, for example,
> "de minimis" thresholds and `AGENTS.md` instructions that encourage user
> participation in the design.
>
> Therefore, the revised policy considers QEMU's copyleft to be a viable
> approach to any unanswered legal questions about AI-generated
> contributions and their copyright status.  This lets the policy
> focus on the topic of what AI-assisted contributions require of
> maintainers.
>
> Going full circle to the reason why we might need to review the
> policy, there is the question of how to make sure policy is applied.
> QEMU maintainers have already experimented with using AGENTS.md files;
> subsequent patches will also try to embody the "work better, not faster"
> mantra into an AGENTS.md file.  Nevertheless, some explicit prohibitions
> should be included in the policy, and they are indeed.  The list is short
> and based on the Rust policy and the GStreamer AGENTS.md file.
>
> Revise the policy according to the above considerations, and introduce th=
e
> "AI-used-for:" trailer as a record of where AI was used.  The standard is
> slightly different from the more usual "Assisted-by"; the intention is fo=
r
> the metadata to provide more information for reviewers to judge the resul=
t,
> and to scope areas for which Signed-off-by cannot guarantee full control
> of provenance.
>
> For now, community consensus was to delay a decision on larger
> contributions that are mostly or entirely AI-generated.  The feasibility
> of rejecting such contributions remains to be seen, since some suspected
> AI-assisted contributions would still be disallowed.
>
> In any case, use of AI does not relax any other contribution requirement:
> authors still need to comply with the DCO (declaring that they have
> corporate authorization to contribute, for example) and take technical
> responsibility for their work.
>
> [Commit message largely based on discussions with Daniel Berrang=C3=A9,
>  Alistair Francis, Peter Maydell, Kevin Wolf and others. - Paolo]
>
> Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-m=
st@kernel.org/T/
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/code-provenance.rst |  71 ++----------
>  docs/devel/index-process.rst   |   1 +
>  docs/devel/llm-usage.rst       | 191 +++++++++++++++++++++++++++++++++
>  AGENTS.md                      |  37 ++++---
>  scripts/checkpatch.pl          |   5 +-
>  5 files changed, 225 insertions(+), 80 deletions(-)
>  create mode 100644 docs/devel/llm-usage.rst

I generally agree with a lot of Daniel's comments, but I think
this patch is basically in the right place so I'm happy to
give it my

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


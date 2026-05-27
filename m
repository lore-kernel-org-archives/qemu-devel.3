Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD18CCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBjw-0007mi-Sp; Wed, 27 May 2026 06:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSBjr-0007jh-UW
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:43:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSBjg-0005gU-Gw
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:43:44 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso98843895e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779878618; x=1780483418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoN7XqTOPy9x0TS1tqLwqrv0ll8w3xbiqy6e58MeGLk=;
 b=gxt7UGjNhPibLhF3GyCSBJ9jHYxX48EehjjBAEIPW5TTyn/l6f40zO0GVO/nNzA15c
 8V9Ly2THktP7hv6FeDQ/kCx3r2t0GHNvFaROHrlCYfPolljgy3hrbcyVQQO8CQw2+NjP
 bTKdPobpfyXpNyUMuXN9LRchLvyVLbh9bB3LGF7zo++G8P6RZCxbB8rX6ZjjzPF/WCFb
 gkhAL9ULDEh594beVhpKX5irjDWoREvHenTK8/Q5vXw+ZStsYkP3Do0qtVeJzMAWMIWA
 Wjvl2y71/3LYaQ7w11cGKsJn2IUQ3xuFXLdUcVuRXI5FtGXenJMqj1LF4nhLP4XRkrZO
 Dziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878618; x=1780483418;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FoN7XqTOPy9x0TS1tqLwqrv0ll8w3xbiqy6e58MeGLk=;
 b=YfrjJ8YJ5cm6Qv5lfidCuou/vrmIb+Nf02mPkU7Umav0uB0ONW4O/b/TJH824NvAda
 JDmPwFgMPBeHQUdTwgdAp1YGX4OQSmqM0+QaSXzwtmPR7oyvLnoBUQuk6qqH83I9vg0I
 KYuziQwWq+uKjmuQW5I597niD+pxqb9sVHynfa2AwuOob+/cJ8Iq/YvfaCkVaux1PXUt
 gD7DsWR5vBrGk197rA2iJQTv3Qj7PrMbsUB3/rHXuC/A1YbdcpMDstCiqd9f0r5m6QmH
 IylKVHKmFr5qGB4/3M3ccSuh0Q2IYoGADPZTcXobaIAD+BJhvgpW4cuqJ+rYvsxguzof
 7aPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zXuieWi5hC/uU4wmq93K81NJSbIKIJsnaksbOkY8Dw6cZor/Ens0xJ9RbSdb4Ohaxn2gz+PwGJ+k4@nongnu.org
X-Gm-Message-State: AOJu0YxgUmATBeohHNz7E7wqVhp1mAl9TYJ7TXR+gQprFF9uCEeWECgE
 Cj6EYOfjhmS9q5GyYFmONl9DHa1K3svZitb3AxTTq3E4TvUQPjj7CBYaKRwFzCQSFcpdHhH2neT
 7Ezqv
X-Gm-Gg: Acq92OH4NCQ8xxSursXxQ/gPMfvv7tXvX/HB430LIXhEUNG5jNtGuJ1z285SW7hLl/b
 L6GOmvX7Xvga9p8bD51fgAN3ljzh77SrRoRLbTJaCxJx26H/typiIQsuNMp2gPAW/XS+AOUB4Xo
 sF4PiDDetYQtRY2nocm5BAUJRH14s7X3lI1r+YTNCuCUhi9jvxZgDnG/ZHFjHLxrYDn6eNnnX3G
 wzz0WMUSGrWKzuvxq6GlHGFq/yIyA6lCFinSPHFqACZhpgn5vipQRD4M3ZAFhsveDZTfi7oFMJG
 JwsAAHyELAIz7hc79I+CPRdwq4pBEFJRXS2I+lqV3FLsnthLaPyIh4kKresHq6en0o9budEJPXt
 9DqQgNgvrCn10/Oq29JuWQmrALTsqMJY4Bjz4gU8KW4UvNZHcmkR57wD1N2h3J8W8GDbiuf4UXw
 AP2RrbBmUFOXGjdBFe1lU8NKk=
X-Received: by 2002:a05:600c:4fcd:b0:490:81cb:d67 with SMTP id
 5b1f17b1804b1-49081cb0d90mr37781705e9.32.1779878617560; 
 Wed, 27 May 2026 03:43:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4907e69dc39sm15733735e9.4.2026.05.27.03.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 03:43:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C80625F7F0;
 Wed, 27 May 2026 11:43:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,  Warner Losh <imp@bsdimp.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,  stefanha@redhat.com
Subject: Re: on ai generated and code provenance
In-Reply-To: <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com> (Paolo
 Bonzini's message of "Wed, 27 May 2026 12:01:10 +0200")
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Wed, 27 May 2026 11:43:35 +0100
Message-ID: <87se7dxhd4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 5/27/26 10:41, Kevin Wolf wrote:
>> Am 26.05.2026 um 21:52 hat Warner Losh geschrieben:
>>> The QEMU Project currently may accept limited uses of AI that produce
>>> high quality patches that are limited in the creative content added.
>>> While maintainers will ultimately decide, changes like the following
>>> fall within this policy
>>> 1. Fixing obvious warnings in the obvious ways suggested by the tool
>>> 2. Tree wide API changes, and other similar mechanical changes done
>>>     today with perl/python/sed/coccinelle
>> As I said in the paragraph you quoted below, I don't think we should
>> encourage using AI for tasks that a deterministic tool could do.
>
> In some cases such a tool does not exist.  Much to my surprise, there
> is no tool to do static type inference on Python code, but AI is very
> good at doing it.
>
>> Letting AI perform the change directly instead may be an acceptable
>> shortcut for a one-man hobby project that nobody else will ever look at,
>> but in the context of a community project like QEMU in which your
>> changes have to be reviewed and understood by others, it matters a lot
>> that the output of the tool is reproducible. Otherwise, you're creating
>> unnecessary work for others, and that isn't acceptable.
>
> When applicable, going through coccinelle (with the aid of AI if
> needed! is indeed a good middle ground as it helps reviewers for large
> changes. If you have many slightly different but easily separated
> changes (e.g. you can split the patch by struct field), it may make
> things worse.
>
> Its also worth noting that in other cases even sed or coccinelle,
> while deterministic, cannot produce 100% of the patch.
>
>> So maybe we should even explicitly mention a recommendation like the
>> following:
>>      If you can use a deterministic tool, don't use AI instead. If
>> you
>>      don't know how to use the deterministic tool, use the AI to tell you
>>      how to use it instead of trying to replace it.
>
> I like it.
>
>>> 3. Limited, small changes to fix bugs or add a small new feature whose
>>>     scope is less than about 100 lines and the originator can explain
>>>     them all or the meta issues about the patch.
>> Not sure if mentioning a number of lines is wise. 100 lines can be
>> mostly boilerplate and simple sequential code or they can be a deeply
>> nested complex algorithm.
>
> I'd put the threshold at 20-50 at most.
>
>> I think I would see more use in a tag like (better name welcome):
>>     AI-used-for: [code|tests|docs|commit message]...
>
> I like this *a lot*.  No need for free advertisement, but some
> traceability is useful.
>
> For tools such as sed or coccinelle, having the exact script in the
> patch or commit message useful.  Plus, the execution of the script
> more or lesss delimits the commit by itself (or 90%+ of it).  For LLMs
> it's a bit less clear cut because separating docs makes little sense.
> And the exact model is pointless, it will be obsolete in 6 months and
> provide no useful information.
>
> So, something like:
>
> ------------------- 8< -------------------
> Use of AI-generated content
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The QEMU project currently allows using AI/LLM tools to produce
> patches in scenarios with limited creative content:
>
> Mechanical changes
>   If you can use a deterministic tool or a script, don't use AI instead.
>   If you don't know how to do the change deterministically, you may
>   ask the AI for help, rather than having it stand in for the tools.

I like the idea of pointing people towards tools but I wouldn't be quite
so prescriptive. The series MST referred to was easily eyeball-able and
I suspect the extra steps would generate friction for contributions.
That said the wider the change to the code base the more likely a random
hallucination can get lost in the noise.

Maybe:

  Mechanical changes
    Using AI tools to make simple mechanical changes is allowed. For larger
    tree-wide changes it is strongly recommended to use a deterministic
    tool like `sed` or `coccinelle`. You can use AI to help you craft the
    invocation for you.

?

> Small bug fixes
>   These should be limited to 20 lines of code or less, not including
>   tests.  You are still expected to understand and explain your changes
>   and the rationale behind them.
>
> These boundaries do not apply to other uses of AI, such as researching
> APIs or algorithms, static analysis, or debugging, provided their output
> is not included in contributions.  Larger uses of AI are allowed as an
> experiment, but they should be agreed upon with the maintainer prior
> to submission.
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
> ``AI-used-for:`` trailer.  The text of the trailer could be one or
> more of ``code``, ``tests``, ``docs``, ``research``, possibly followed
> by an explanation in parentheses::
>
>     AI-used-for: tests, docs
>     AI-used-for: code
>     AI-used-for: code (refactoring)
>     AI-used-for: code (prototype)
>     AI-used-for: research
>
> The trailer is intended as a clarification of your DCO obligations as
> well as to guide reviewers.  It is not intended for minimal presence
> such as autocomplete or asking for a pre-review of the patch, and it
> does not remove your responsibility to understand the changes that you
> are submitting.
>
> Include the prompt in the commit message if it helps a reviewer judge
> the result:
>
> * yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
>   function already has a local variable or parameter of type ``struct
>   bb``, use it instead of accessing ``aa.bb``."
>
> * yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``,
>   forwarding the member functions to ``T`` while taking the lock
>   around the calls".
>
> * no: "write user-facing documentation for the new tool"
>
> * no: "write testcases for the new functions"
>
> Deterministic tooling (sed, coccinelle, formatters) is out of scope
> for the trailer, but should be mentioned in the commit message.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


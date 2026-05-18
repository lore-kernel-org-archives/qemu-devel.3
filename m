Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBA4CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOukz-0005xJ-A6; Mon, 18 May 2026 05:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wOukv-0005wX-UB
 for qemu-devel@nongnu.org; Mon, 18 May 2026 05:59:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wOukt-0008GQ-72
 for qemu-devel@nongnu.org; Mon, 18 May 2026 05:59:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso25918275e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 02:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779098361; x=1779703161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTAQxcb6GKhkaPSmrT7rijbWGY6+GokqsgmfOSegRXM=;
 b=OvucIPm66bpyHKgK9SHDjwZe+UDZ0xblnIMumDlB9poRpxoIi8tUU1YJK1keMHchaS
 Nr0Zx0PyyHs1bgkujQwP2LgwNd1FV1XQucVOZf14XR7yB8FsVRISsgBPrXQA+z2uVB5v
 NU1jn1GE1rTo5b7lAyWejFqHoi54lhEGHaSWJk7/DlqYq4hBu2OwnLftMLjiAGE3VikI
 og2BOkX+vscIe3lhx7uFAV9Z67lWqC9lxZZ6rtG1n5TuAio5VsTSVV4gE1qenKobkvXc
 cVKxQtCu35CGjtLK16YvE/J4Th7KM7ahGu8SWwC9Rp9DCDRUH9VeeJzKCGTx863vpGSU
 +ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779098361; x=1779703161;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zTAQxcb6GKhkaPSmrT7rijbWGY6+GokqsgmfOSegRXM=;
 b=oPOxMbr1VbKX3nkRWMxh/llr2hi2loxfOxLOVPbL33xl9UdFg3PXiW0AybR6nMGbTe
 U8Nr+MLlDIvzXFHTO2Hw3hehPcV8WYrTSm2fZGsec6P2dXqDlBTRxY3zoR6vWRnP68wT
 NR+iEF/fdJzfkML7BMkgRHL79sBuCUvVFsD+T7zeQOfaCyvfOA1uZN5M0ceI5SSXwUDu
 V4VgMLjZYpWQ36QYdgFsAu/XqK7ET09r+4u3NtH/AYrYaF9x0GmiuAl/35XqKC2QBhoQ
 VkaS5u3ec2r2Uxmriwm95AxPJglS4dG9pxidvsXGuq+kC97/dX7V/V9UWOVHfHBmiE1n
 Mr7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UpyiQ7LHWpRhJAQq+PsVgWmLeVjZaISuOkb6aVBXFR8UKnvP/n830o3h1JYzT2jy5ZVge26pWLRoO@nongnu.org
X-Gm-Message-State: AOJu0YxJCdKiZGzAWtynryy2huVNcokxAUn2ECMpjjn6up4vh4Nik8to
 Cj0mv7Avb1Jm8BCB5AX6oZx8nChBHPYKoP8JfTxQwW7x6W41mhySHE8NX9OEqhVbqQU=
X-Gm-Gg: Acq92OHri6GMAuyAxoNobT9nGdZIT1iWtbSqCLGid/dYHy5ZDfcQK38pSHhUCZ0UhNX
 L7i4kEYnE0rWfkf8KhWyqw+UafHLkoWW0qMCCKdDtEWVKjdSVTmcGjLOV6lkZDowfXflShpiOC7
 C5yNAD2lHKHgluZYoHR2TXXHbo/+eY00lMXFjJanRI4yTghl6/oWs4vtv+IxFabk8xULnCdPuvT
 ZKggw2MELkpL9Ptvv32X7BQJx0+pjkluNa1mqJAzbKKxFdyjRv5MKrlV5IpgCYssW8aGOXsz+Su
 PlrxV69y3kou3miXDJzpHRoIi6WqHHebki0zE7NEu3R55wR7bqLKFgWEIC1XO2Elv4Eu+w7Lvvz
 +8llWpoCVEVjx+C0V7BPj9qjLB3sJ444e3u4p9azGoXiSmDhc6SquoZW3lSqxsNL7p47/ygbIV1
 OAaLjNtalIv9kZfGnU5DvCuJcCpzZZCVchXg==
X-Received: by 2002:a05:600c:885:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-48fe6517fdfmr135852875e9.27.1779098361158; 
 Mon, 18 May 2026 02:59:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fed253f93sm76497145e9.16.2026.05.18.02.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:59:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5D56A5F8C1;
 Mon, 18 May 2026 10:59:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,  John Snow <jsnow@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alexander Graf
 <graf@amazon.com>,  Pedro
 Barbuda <pbarbuda@microsoft.com>,  Mohamed Mediouni
 <mohamed@unpredictable.fr>,  Reinoud Zandijk <reinoud@netbsd.org>,  Magnus
 Kulke <magnuskulke@linux.microsoft.com>,  Doru =?utf-8?Q?Bl=C3=A2nzeanu?=
 <dblanzeanu@linux.microsoft.com>,  Wei Liu <wei.liu@kernel.org>,  Paul
 Durrant <paul@xen.org>,  Anthony PERARD <anthony@xenproject.org>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Roman Bolshakov
 <rbolshakov@ddn.com>,  Phil Dennis-Jordan <phil@philjordan.eu>
Subject: Re: [RFC PATCH v3 01/11] AGENTS.md: introduce a very basic guide
 for AI agents
In-Reply-To: <CAFEAcA-DS3k-7SEFMASa4ncpuZmX07A2n66quSEG4R_VYq+AHg@mail.gmail.com>
 (Peter Maydell's message of "Mon, 18 May 2026 09:47:48 +0100")
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
 <20260515163055.1792262-2-alex.bennee@linaro.org>
 <a6b904bb-6ddc-4c39-84f9-3b7c91f7e611@linaro.org>
 <CAFEAcA-DS3k-7SEFMASa4ncpuZmX07A2n66quSEG4R_VYq+AHg@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 18 May 2026 10:59:19 +0100
Message-ID: <87v7cl6nt4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sat, 16 May 2026 at 11:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
>>
>> On 15/5/26 18:30, Alex Benn=C3=A9e wrote:
>> > AGENTS.md is the agent agnostic place for placing instructions for
>> > agents. This introduces a very minimal agent guide which outlines the
>> > code provenance policy and provides some basic guidance on reporting
>> > security bugs.
>> >
>> > As Gemini doesn't look at AGENTS.md even as a fallback option I've
>> > included a symlink.
>> >
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>> > +## Security Policy (see `docs/system/security.rst`)
>> > +
>> > +You MUST NOT report potential security vulnerabilities to the public
>> > +GitLab issue tracker. They should be reported privately to
>> > +`qemu-security@nongnu.org`.
>> > +
>> > +**Crucial for AI Triage**: Not every crash, assertion failure, or
>> > +buffer overrun is a security vulnerability. Only bugs that can be
>> > +exploited in the **virtualization use case** to break guest isolation
>> > +are treated as security vulnerabilities. In brief these are:
>> > +- **Hardware Accelerators**: e.g. KVM, HVF and others, TCG is explici=
tly excluded.
>>
>> HVF isn't withing security boundary:
>> https://lore.kernel.org/qemu-devel/abAcaahy_FsBonZ7@redhat.com/
>>
>> For the "other accelerators" we should ask confirmation for respective
>> maintainers. AFAICT only KVM and Xen are expected to be secure;
>> MSHV, WHPX, nvmm and nitro didn't opted in yet (Cc'ing respective
>> maintainers).
>>
>> Wouldn't it be better to have a document describing the security code
>> boundary and have the AGENT.md refer to it?
>
> We do have such a document:
> https://qemu-project.gitlab.io/qemu/system/security.html
> and the AGENTS.md does tell the LLM about it.
>
> It puts all the virtualization accelerators within the
> security use case boundary. Personally I think this is
> reasonable -- the main reasons for having TCG outside it are
> (1) the TCG emulation itself is a lot of code and
> (2) it is a convenient way to rule out an enormous amount
> of old board and device model code in one go.
> This applies much less to the hvf, whpx, etc cases as they are
> using almost exactly the same board/device/core code as KVM.
>
> The idea as I understand it here is that by giving a very
> brief summary of the other document you make sure that the
> important parts we want to emphasize are in the agent's context
> and clearly stated. But I'm no expert on how to craft these
> files...

Yeah compared to normal programming its a bit imprecise - almost like
natural language is full of ambiguity and ad-hoc grammar ;-)

There is essentially a trade off about how many tokens you commit to the
permanent context (system prompt + agents.md + list of skills/rules) so the
agent will load stuff when needed but you don't pay an excessive token
cost for every query. Also while the frontier models have quite large
context windows (200K to 1M tokens) the local open weight models often
have much smaller windows so you need some free for the actual query and
response.

I did "test" this by asking the model how it would route a bunch of
theoretical vulnerabilities and it generally reasoned and "did" the
right thing.

Some of the TUI tools (Claude Code for example) have skill creators that
include evaluations which are then run with and without the additional
context. Another LLM then evaluates the response and scores the response
to give some sort of qualitative indication on if the additional context
is useful. However the workflow for these evaluations is currently tied
to specific providers and I don't think we want to favour one over
another.

However going through this process was one reason I didn't include a git
skill because it doesn't add much, the base models generally already
know how to drive git pretty well. In the end I've just added (to my
local config):

  When applying patches you should assume the user is happy building on top=
 of the current branch.=20
  You MUST always ask the user (using the eca__ask_user tool) before changi=
ng branches or resetting the git tree state.

to encode my local workflow in the agent and not bothered with any more
details on how to drive git. The same is true for the code explorer
which drops all the gtags and git-grep stuff as having the semcode MCP
provides a much richer set of tools for exploring the code. Instead it
now just focuses on the QEMU specific idiosyncrasies of how our code is
organised.


>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


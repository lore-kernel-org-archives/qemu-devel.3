Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A603C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8aXf-0002yp-5F; Mon, 21 Sep 2026 05:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8aXb-0002yR-CF
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:42:27 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x8aXZ-00062s-4N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:42:27 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so16358435e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789983743; x=1790588543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2z2fsCy4ol+QUSAH+jQK1rtGlJ25rDHcG8ShXTTLC9k=;
 b=P29shZ2Ku6Kdb7EF9fpF1U2FkANSrwEkHEU2++qTVeql0PdISVP6r/cQ2EYl+Or5Fz
 qhsOjBKrZV4mDiGEY0jRY4VoafP9p1XO7bGYMD9T1qrdVhOwjoH8ap1xhf4FceGqoa24
 mYPCG8LWVpYT6TfEvTtVmsBRUbJmDc4S0Wg8qd0yvjFXIP3xplpspU0UtP2yUOaODCFB
 Q/CMYVzeAB7smm161tXe93kEq8XudeA5ThtgUoPNr3jFc6OYWioVfyCls5lWugX1NiLn
 BMRFQuxKF7LUBge5rSSZUemj2AEdXuqtlUv4QFEtOOS+O32tMGZlJLgWuo7o/EHNbzea
 JepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789983743; x=1790588543;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2z2fsCy4ol+QUSAH+jQK1rtGlJ25rDHcG8ShXTTLC9k=;
 b=zrXo+5OJLAlekXEGk5MDr/h7RXwpHcbXI1T+txoexP1A8K21dmvzAAeJNoUQx/UEhc
 g4SbStO1kZKxtPCMBnYUAbuCHgFJxGgm7dtetRGyFnFKeDwHLu/L0t0F8eSH6jQe63K+
 Nw3unMPh5rmN7sFIGCp7MnztzmgUIo6YiK+gKzZReCJlX7WZT0gyNKZNvMLbzaiVM07u
 +ak8k2R7TMEx6312rxuCE0tlnZ/zx3e7MA8Vi2v6pDJNcYrYcrgo52f/Qqu1qR7Syuf4
 QH5LA8V70ELStTYQtaXR0alIEQHTAjxYo79Rd7wwuxfkZBefnPbOxU2GkpPN0/z420Ws
 e+0A==
X-Gm-Message-State: AFuF++ldVzMVlJjrJUmHVI8uAVHj1o7II4BfBPvpz9y5mzquWjRqYNiz
 W6eGR7oPbqu/HMwzEdUg9V6EqVHvCIF+97YN6W2g5ouXaSa1AHe9sETsHZ10IY49n9k=
X-Gm-Gg: AYBFou25WckpkZKkOaW7aV9oMBliB5CXIh9k140YC+sygSW+uHFQ0NkmQ0Zjgk4svCE
 k2S3SxaJ+BjSIU2E+w130x7ii8uu6KAkgC1gD1q5omVLgfW26DnzddB0Cl/frhPUiNnJnVkSEGQ
 CwN2a45h/dHC8flUKHJCSz6jpYH12VHSM9MWeRQnnfD22lSxjizKO9rzCdSssVBecISZriwqcYX
 r/qIMaaGI5ZHQ3YYPG01kC2WflnKSrnWrE7aqrywDkpjRCaxgt0tIMJtfPwItBdAoZiE/U3YIQ4
 pvJunezOsApsq0a8MldtP7REz0eSKjYHNSAYdgkAP58M3YvnW7c9xkItY3i6NuPKZcCsJpiUZ5V
 MGE8zXG2KozenqQu4IdQ8WHzc6xkcKAPtOMwgWsQre6o60BCieIm8bWkss/KU1XHmUv0bFVwoo+
 weZBJEB8GPo5ZBeBAxMyoSZgYJc0y//KM51LMiX/e390+orUeLIFSggWBIL292n/OMMMMo5DY=
X-Received: by 2002:a05:600c:3493:b0:49f:bd3c:bc21 with SMTP id
 5b1f17b1804b1-49fc573b55emr137283095e9.28.1789983743125; 
 Mon, 21 Sep 2026 02:42:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd03fe55sm253746375e9.2.2026.09.21.02.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 02:42:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 456A45F8A9;
 Mon, 21 Sep 2026 10:42:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/4] AGENTS.md: let agents know what the participation
 rules are
In-Reply-To: <20260921075251.12831-4-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 21 Sep 2026 09:52:50 +0200")
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-4-pbonzini@redhat.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Mon, 21 Sep 2026 10:42:21 +0100
Message-ID: <878q4v0wle.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Humans seem to be extremely unreliable in following rules around this,
> even after being told directly and repeatedly. Telling agents what to
> do seems to yield better results.
>
> The starting point for this document is GStreamer's AGENTS.md file, as
> of commit d08375499c279a56c0e77c928fbeae0d80cdf937.  I used GStreamer's
> agent instructions in the context of Meson, which uses a very similar
> file, and it's both annoying and too willing to take the lead once the
> model decides that it likes you.
>
> To avoid this, the text tries to favor cooperation between agent and user.
> It suggests that the agent includes the state of the work when committing,
> so that contributors have the material they need to review the agent's
> work.
>
> To test it I tried the following prompt:
>
>   Hi, i am doing my first AI assisted contribution to QEMU. i am familiar
>   with the project, but would nevertheless like to experiment. please
>   generate a sample implementation of a pressure sensor, of any model,
>   of a kind that is commonly used with Arduino or ESP32 microcontrollers.
>
> The agent did read llm-usage.rst and after doing the work (implementing
> a BMP280 pressure/temperature sensor) it noticed:
>
>   Policy, before this goes anywhere near the list. A new device model plus
>   qtest is the fourth bucket in docs/devel/llm-usage.rst: large, heavily
>   LLM-assisted, allowed only if pre-arranged =E2=80=94 a maintainer has t=
o say on
>   IRC or the list beforehand that they'll review it. hw/sensor is Philippe
>   Mathieu-Daud=C3=A9 (Odd Fixes), with Corey Minyard on I2C. I should have
>   flagged this before writing rather than after; that's on me. Disclosure
>   would be AI-used-for: code, tests above your Signed-off-by, and the
>   commit message and any list replies have to be yours, not edited from m=
ine.
>
> I then asked "Can you provide a draft of the commit message with all the
> sources (datasheet, etc.)?" The agent complied but noticed:
>
>   AGENTS.md and docs/devel/llm-usage.rst state that commit messages MUST
>   be written by humans =E2=80=94 an AI-drafted one must not reach the list
>   even lightly edited. So treat the below as scaffolding for facts and
>   sources, and write the final text yourself.
>
> After some editing I asked "ok, will you please commit for me?" and
> it did so with basically my text, while also reminding me about the need
> for maintainer pre-arrangement.
>
> I asked "assuming pre-arrangement is this ok according to the policy?"
> and this was the assessment:
>
>   "Well-tested" =E2=80=94 held to a higher standard, and here's what's ac=
tually
>   missing: [...] the vmstate (no migration test), reading past 0xFC and
>   reserved registers, the pointer_valid error path, oversampling/filter
>   fields beyond one readback, and behavior against a real driver =E2=80=
=94 Linux
>   bmp280 was never run against this. None of those is hard; whether the
>   current set clears the higher bar is a judgment call I'd rather hand
>   you than make.
>
>   "High-quality" is the open one. The doc asks that you have reviewed and
>   curated the contribution and can explain the changes and the rationale
>   in depth. In this session you engaged with the commit message and the
>   sources =E2=80=94 and caught my datasheet error, which I got wrong =E2=
=80=94 but the
>   design decisions were mine and unexamined by you [...]
>
> Overall, the files do affect the behavior of the agent.  The agent
> however made too many design decisions on its own.  This will be fixed
> in a separate step.

For skills there is the concept of evaluations which can be used to fire
a set of pre-canned queries at an agent with and without the skill and
then mark their responses to evaluate if the skill is adding anything
useful.

Unfortunately I couldn't find something similar for AGENT.md although
there has been some study of the effects:

  Evaluating AGENTS.md: Are Repository-Level Context Files Helpful for Codi=
ng Agents?
  https://arxiv.org/html/2602.11988v2

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  AGENTS.md | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/AGENTS.md b/AGENTS.md
> index 478748ab72e..816ba7646c1 100644
> --- a/AGENTS.md
> +++ b/AGENTS.md
> @@ -8,12 +8,73 @@ is **a scarce resource**.
>  There are strictly-enforced rules for you, the agent, to participate in =
the
>  project.
>=20=20
> +## Interactions with maintainers must be human-human
> +
> +The QEMU project has strict rules on what AI-generated material can
> +reach the maintainers.
> +
> +### No automated posting
> +
> +Agents **must not** use any API, CLI, or web UI automation to:
> +
> +- Interact on the QEMU mailing lists
> +- Create, edit, or close **issues ("work items")**
> +- Post **comments** on merge requests, issues or commits
> +- Open or update **merge requests (MRs)**.  QEMU does not use merge requ=
ests anyway.
> +

Are we considering project agents (such as the stsquad-bot) exempt from
this policy? I'm not sure what a normal agent can do via the API as it
wouldn't have the project level access the stsquad-bot needs.

> +### No AI-written text must reach maintainers
> +
> +These rules apply when publishing AI-assisted work to GitLab or the mail=
ing list:
> +
> +- **AI-written cover letters and commit messages are banned**.  These are
> +  easy to recognize and waste reviewers' time.
> +- **AI-generated responses to reviewer comments are banned**. This under=
mines
> +  the human-to-human interaction fundamental to code review.
> +- **AI-written issue ("work item") descriptions or comments are banned**=
. These
> +  are verbose and waste triagers' time.
> +  - An exception is made for issues for defects detected by automated or
> +    semi-automated tooling, including fuzzers and LLM-assisted defect
> +    detection.  Such issues must be reviewed by a human before creation,
> +    must be created by a human and communication with maintainers must
> +    be done by a human, but including the verbatim tool output in the
> +    issue description is explicitly allowed.

The triage bot will occasionally add comments asking for more
information or saying a human needs to make the determination about if a
CVE should be assigned.

> +
> +Copy editing of human-written text, for example to help non-native speak=
ers,
> +is allowed. Keep such edits small and precise.
> +
> +The human's workflow may require you to perform commits or request you to
> +produce private drafts of maintainer-facing text.  These are allowed, bu=
t must
> +be marked as requiring rewrite by a human before publication.
> +
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


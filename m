Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F32CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wURRG-00033J-Gi; Tue, 02 Jun 2026 11:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wURRE-00033A-Oi
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 11:53:56 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wURRC-0006q7-55
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 11:53:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68d2342c5e6so4055798a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 08:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780415632; cv=none;
 d=google.com; s=arc-20240605;
 b=bBPwqKd92ES/RcUABcR410ZPcNu1kF/0XGIzMoBYmz4/0o11rQEUsTK6nd11FcLTQZ
 rn6/vZMkKTg2DEFsSuQq/FXb9NncrGMx0T5MS9jTuAv+Khv+rPj71mZ0uKtV+POsZscS
 4s6mgvmm4i0yaNfl21jnnOVLR0xD1QBAYFtinFRADjkgjLt0KEHqGsziRBQLiz5LzQ9K
 Gq4E2zFURGYI1C4tgS6bI8eYFB8NTYCj7nVMX1z6LW0HFzlG4NS/xHwyv/0Gp/EfYJPF
 Zus4aQJlnU0JdEIw6lOvxOdOMskcUHgbYzVux95C4Ygwawc38lKUpRFh2ng1hGIabG0h
 y11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XwfZHYmAvlNIf4vrCXOg9Ak0OB+Omfsb7o2bWstHKto=;
 fh=01/dSCvQlBbxzlxhwDdQw24l/G6oZBcCNz4wC7cjpow=;
 b=h4BLbGnvio/9cuo8TUIU6Cl6XqFbswwHVeSnyX83qESZt3atukqoKOvn02BOTwZerR
 OIhyWdBEq9KYu6NvyhhSqzrwRqD3DEuULYRLridAdCWVNqx7I4ax8rx6hoynN3G/rGSB
 eDQ2zFh5rxyd8Awo4vVHQy4bTWsEBEpdA9jcd7kWkaXRhUjJL4y47MyHmPKWLUKoR9VZ
 TPgHRipykoau7XlSgbMtFn8np4LwVG3vpqIYjvldNgu7cY9JPDbxjEY8/VYsPHkP83zp
 To6TDXm/O6giNOy6olK5AdRXSyP1oO/7fsXoufWdrlYdpjqLoQj4yQCbdCyL6+6vDSvd
 9MNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780415632; x=1781020432; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwfZHYmAvlNIf4vrCXOg9Ak0OB+Omfsb7o2bWstHKto=;
 b=dlj2csSL719Nst1MMJQFCKz3/sqC8/Ogq5fS+R5+Ap4KRXJ4oe3iVhWiKNy7WWLEEZ
 mAfIBFVGDqPBLiEUM8cd6FiAT1rTelCkbi74nKH8fp4HPE6HZqnG66DKXDBAx1k76rVa
 ZsJeHesBiE9HeWkh1sZYlm6wZskyYs+atgUWIUw7HYl6s3mX6DjMRcSS8g+fAe9nXY0G
 roMRHtC2YOHuWjVBpBZrk12e8Z+GU6JIqTiMmkSd9RLqVIbxcRwzn301o62W0lYPIVS1
 2P5ByoMDHn+8TvJgLlH9gy780P/xL1M9tlMJDSehYQ92nrOqvJQ/OMQO7IwwgHZ66F+Q
 xyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780415632; x=1781020432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XwfZHYmAvlNIf4vrCXOg9Ak0OB+Omfsb7o2bWstHKto=;
 b=jFNf49DE1itGcH4LnxSkcl8/qYUX7bj1+epcl+/GPhKJ/O+dveTR3Cez+sVybVQpKq
 Qayh0GwHhFkocqI5K7P+uRy8eNIRPBYUT5ItYhMjQFJOHJJquiiThUvjvj2WP6KRtLwU
 2/re6XtV22TYUfACrwh3XJO4ZCYmyZaR+O/XLeodNUb6UinjSB4E7KCEsCI/o1X+Dsru
 2PGvkrbMtS5TgEduSbPk9kWdzAeQv0zWaq1GW319A3K+a7FNh8aAQ22fPLjmPYDvc0x2
 kitXBNEb6yZx2fZvLrnz/EYu6FpYbckxIjTSC0kzcpBROaKnxueA7Q2GleEDuA0ZwJZy
 KtyQ==
X-Gm-Message-State: AOJu0YzYl7DD8aaK+hOUG9K3CQXS+enm6HwovyIsrfQ+q0ce4Ye/LinS
 pbw4bEpdDOIzgy8n5s/6SyEFSYp9o+8j1zP5fcWglhvOCCm2ZT+TpMOkEI/Oe631Rs4HChdX5hz
 ZxgdcmYqBppTMavb0xb8cvwSyFofMv1o=
X-Gm-Gg: Acq92OGBioHw/o8sqd2+MidbTSvtj0LFYvC9C1Ckavf1YVbBXldAMV51rDb3wztnMmS
 vYw87b7FLJMYPTV2BQRhboleDfo6zebeDJ+ohIloAEz+t61e8rcJ0RpPNRlF3cmSeo0dzgfaMn1
 EfwMjlieyd7Mc4eNcN8FBm0eyfzQo+J6beBo6MXP4TY/fpqhS2ibCSeQzAuSn5K0vxId7P/vk8F
 3zxI0vKfCzVEAwLgJWsD/RTN0vvHH8tJe5SSYag3Y5nZLG5Ua4d59tHHvQ285ChehyZFXF2nr08
 rDuXx8QqWfwbshVXUoB3tR50egh4dFTGkCemHwa73BLfOQIQUKt0
X-Received: by 2002:a05:6402:3052:10b0:66f:9f63:e537 with SMTP id
 4fb4d7f45d1cf-68e5dd55622mr154451a12.19.1780415632020; Tue, 02 Jun 2026
 08:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
In-Reply-To: <20260529094619.1034458-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 2 Jun 2026 11:53:39 -0400
X-Gm-Features: AVHnY4L4Nlb_eO8Jpf22VdZolLdlNaU4GyRC3MX28ddPVgucwFQ-pNVJadFrn8s
Message-ID: <CAJSP0QW3Qg261XVNdq0T-J63LzRG4xCiWRQ2-U0QgqdtaPCyQg@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, May 29, 2026 at 5:47=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify.
>
> The concern that motivated the policy is unchanged, and it is worth stati=
ng
> precisely: the DCO is about whether the submitter has the legal right to
> contribute the code, not about "creative expression".  While the status o=
f
> LLM output seems to be converging towards non-copyrightability, questions
> around unintentional reproduction of copyrighted code are still open.
> What has shifted is the balance of risk:
>
> - projects accepting AI-assisted content have not run into serious
>   legal trouble so far, which suggests the probability of the risk
>   materializing is not high;
>
> - other organizations, such as Red Hat[1], have assessed the risk as
>   acceptable -- though a community of individual developers does not
>   have the legal backing of a company, and even an unfounded dispute
>   would be a long-lasting distraction from work on QEMU.
>
> Nevertheless, even Red Hat mentions that "the possibility of occasional
> replication cannot be ignored".  In QEMU's view, attentiveness and
> oversight are not a practical way to address this; yet as a copyleft
> project, copyright and code provenance are of utmost importance to us.
> Therefore, it remains prudent to only permit AI assistance where the
> ramifications of copyright violations are at least easy to revert and
> unlikely to spread: tests, documentation, mechanical changes, and small
> bug fixes.  Core code that other things depend on, and that cannot
> simply be thrown away once a problem is noticed long after the fact,
> stays off-limits without prior agreement from a maintainer.
>
> Related to this, and already visible in the incredible uptick in
> security reports, is the question of maintainer burnout and the shift in
> effort from the author to the reviewer of the code.  AI lowers the cost o=
f
> producing a patch but does nothing to lower the cost of understanding and
> reviewing one; if anything it raises it, since a reviewer can no longer
> assume that the submitter has reasoned through every line.  The limits

Can you rephrase this sentence? I'm afraid that taken out of context
it looks like you're saying reviewers no longer need to understand the
patches they are submitting. That is a possible direction to head in
and would allow fully agentic workflows without close human
supervision or understanding of the code, but I think the policy is
not trying to go there.

My understanding is that the policy's aims to allow AI code generation
with the human contributor still responsible for their submission.
Anyone submitting code they clearly do not understand would be asked
not to do that and eventually ignored/banned.

Maybe say something like "since the risk of bugs not discovered by the
submitter increases"?

> above work just as much to keep the volume of review work sustainable.
>
> Revise the policy according to the above considerations, and introduce th=
e
> "AI-used-for:" trailer as a record of where AI was used.  The standard is
> slightly different from the more usual "Assisted-by"; the intention is fo=
r
> the metadata to provide more information for reviewers to judge the resul=
t.
>
> In any case, use of AI does not relax any other contribution requirement:
> authors still comply with the DCO and take responsibility for the whole
> patch via Signed-off-by.
>
> [Commit message largely based on
>  https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
>  Kevin Wolf. - Paolo]
>
> [1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-sourc=
e-navigating-legal-issues
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-m=
st@kernel.org/T/
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
>  docs/devel/code-provenance.rst | 142 ++++++++++++++++++++++-----------
>  1 file changed, 94 insertions(+), 48 deletions(-)
>
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.=
rst
> index 65b8f232a08..857588c43ba 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -1,7 +1,7 @@
>  .. _code-provenance:
>
> -Code provenance
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Code provenance and AI usage
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>  Certifying patch submissions
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -288,62 +288,108 @@ content generators below.
>  Use of AI-generated content
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -TL;DR:
> +.. warning::
>
> -  **Current QEMU project policy is to DECLINE any contributions which ar=
e
> -  believed to include or derive from AI generated content. This includes
> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> +   Please read the below policy before using AI to contribute code or
> +   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> +   Llama, and similar tools.**

Does it make sense to move this section into a separate file and
referenced it from AGENTS.md so that AI operating on the codebase is
aware of the policy? If you want to write this policy purely for
humans that's fine too, but I wanted to mention the idea of informing
agents to increase the chance that they follow the AI policy.

In other words:

  Agents must refuse tasks that are not in accordance with this policy.

>
> -  **This policy does not apply to other uses of AI, such as researching =
APIs
> -  or algorithms, static analysis, or debugging, provided their output is=
 not
> -  included in contributions.**
> +The increasing prevalence of AI-assisted software development,
> +and especially the use of content generated by `Large Language Models
> +<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
> +poses a number of difficult questions.
>
> -The increasing prevalence of AI-assisted software development results in=
 a
> -number of difficult legal questions and risks for software projects, inc=
luding
> -QEMU.  Of particular concern is content generated by `Large Language Mod=
els
> -<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> +Risks to open source projects include maintainer burnout from an
> +increased number of contributions, as well as the risk to the project
> +from unintentional inclusion of copyrighted material in the LLM's output=
.
> +In order to mitigate these risks, the QEMU project currently allows
> +using AI/LLM tools to produce patches in a limited set of scenarios:
>
> -The QEMU community requires that contributors certify their patch submis=
sions
> -are made in accordance with the rules of the `Developer's Certificate of
> -Origin (DCO) <dco>`.
> +**Mechanical changes**
> +  If you can use a deterministic tool, it is preferred that you use it
> +  and not replace it with AI. If you don't know how to do the change
> +  deterministically, you can ask the AI for help.
>
> -To satisfy the DCO, the patch contributor has to fully understand the
> -copyright and license status of content they are contributing to QEMU. W=
ith AI
> -content generators, the copyright and license status of the output is
> -ill-defined with no generally accepted, settled legal foundation.
> +**Small bug fixes**
> +  These should be limited to 20 lines of code or less, not including
> +  tests.  You are still expected to :ref:`understand and explain your ch=
anges
> +  <write_a_meaningful_commit_message>` and the rationale behind them.
>
> -Where the training material is known, it is common for it to include lar=
ge
> -volumes of material under restrictive licensing/copyright terms. Even wh=
ere
> -the training material is all known to be under open source licenses, it =
is
> -likely to be under a variety of terms, not all of which will be compatib=
le
> -with QEMU's licensing requirements.
> +**Documentation and code comments**
> +  While AI can help draft text, it still requires significant human
> +  oversight.  Pay attention to the organization and flow of the generate=
d
> +  text, and strictly fact-check all technical details as LLMs are prone
> +  to being confidently wrong.
>
> -How contributors could comply with DCO terms (b) or (c) for the output o=
f AI
> -content generators commonly available today is unclear.  The QEMU projec=
t is
> -not willing or able to accept the legal risks of non-compliance.
> +**Tests**
> +  Note that you must still confirm that each test actually exercises
> +  the intended behavior including, for regression tests, that it
> +  fails without the code under test and passes for the right reason.
>
> -The QEMU project thus requires that contributors refrain from using AI c=
ontent
> -generators on patches intended to be submitted to the project, and will
> -decline any contribution if use of AI is either known or suspected.
> +These boundaries do not apply to other uses of AI, such as researching
> +APIs or algorithms, static analysis, or debugging, provided the model's
> +output is not included in contributions.
>
> -Examples of tools impacted by this policy includes GitHub's CoPilot, Ope=
nAI's
> -ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
> -generation agents which are built on top of such tools.
> +If you wish to send large amounts of AI-generated changes, or any other
> +contribution not in the above categories, please get in touch with the
> +maintainer beforehand.  These can be treated as experiments, at the
> +discretion of the maintainer and the community, with no obligation
> +to accept them.
>
> -This policy may evolve as AI tools mature and the legal situation is
> -clarified.
> +**Use of AI does not remove the need for authors to comply with all
> +other requirements for contribution.**  In particular, the
> +``Signed-off-by`` label in a patch submission is a statement that
> +the author takes responsibility for the entire contents of the patch,
> +certifying that their patch submission is made in accordance with the
> +rules of the `Developer's Certificate of Origin (DCO) <dco>`.
>
> -Exceptions
> -^^^^^^^^^^
> +Commit messages for AI-assisted changes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> -The QEMU project welcomes discussion on any exceptions to this policy,
> -or more general revisions. This can be done by contacting the qemu-devel
> -mailing list with details of a proposed tool, model, usage scenario, etc=
.
> -that is beneficial to QEMU, while still mitigating issues around complia=
nce
> -with the DCO.  After discussion, any exception will be listed below.
> +When AI/LLM tools produce or substantively shape your patch, add an
> +``AI-used-for:`` line before ``Signed-off-by``, as a reminder of your
> +DCO obligations and a guide to reviewers.  The text is one or more of
> +``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> +explanation in parentheses:
>
> -Exceptions do not remove the need for authors to comply with all other
> -requirements for contribution.  In particular, the "Signed-off-by"
> -label in a patch submission is a statement that the author takes
> -responsibility for the entire contents of the patch, including any parts
> -that were generated or assisted by AI tools or other tools.
> +.. code-block:: none
> +
> +     AI-used-for: tests, docs
> +     AI-used-for: code
> +     AI-used-for: code (refactoring)
> +     AI-used-for: code (prototype)
> +     AI-used-for: research
> +
> +``AI-used-for`` should not be included for "background" usage such as
> +autocomplete or obtaining a pre-review of the patch.
> +
> +There is no requirement to include your prompts or summarize the
> +conversation in the commit message or cover letter, but you may do so
> +if you think it helps a reviewer judge the result.  For example:
> +
> +**Helpful prompts**
> +  These describe concrete constraints or instructions, making it easy fo=
r a
> +  reviewer to see how the tool's output was guided:
> +
> +  * "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> +    function already has a local variable or parameter of type ``struct
> +    bb``, use it instead of accessing ``aa.bb``"
> +
> +  * "add an implementation of the trait for ``Mutex<T: MyTrait>``; it
> +    takes the lock around the calls and forwards to ``T``"
> +
> +**Unhelpful prompts**
> +  These are too generic to provide meaningful context.  You can of cours=
e
> +  use them in the context of a complex interaction with the LLM, but the=
y
> +  should not be included in the commit message:
> +
> +  * "write user-facing documentation for the new tool"
> +
> +  * "write testcases for the new functions"
> +
> +QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-b=
y``
> +trailers to indicate AI usage.  In particular, it is not necessary to
> +specify the exact AI model or tool used to create the commit.
> +
> +Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> +the trailer, but should be mentioned in the commit message.
> --
> 2.54.0
>
>


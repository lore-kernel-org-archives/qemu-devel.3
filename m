Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D91BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvl6-0001Wu-9a; Fri, 29 May 2026 07:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSvl3-0001Tw-TE
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:52:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSvl1-0000oO-9i
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:52:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so65166925e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055525; x=1780660325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6isQmhl8AByeG3vxaNRFlNTwmktQzXl/oedk76YT5Ng=;
 b=aLAG/sIgQBjW4xTjzHLqUr1h1BrnJ8WZ4dhtfjpsA/l7sMMdM0ndfdFO5kfogGR6ga
 uoSUx5gFOlmne1ov6ZYkxieThlnnm1Mc8x/jkL+eKkJ65d7ylsOY69Zt9hCQ87uVscHD
 bFmCQvqoeaeToroZ496s5iY7fOc6PDhbKLhh8wGpZ396mQ2vm+2n/Btx4BCVyqZOL3Ux
 5MfmIQ3/UqQm/eqbqgH4lCQfTHPMUF4B0pXtctlDrfMo6Sgg8MTyNXdW38M8CfUbbQFC
 KyOpa4pe0gXMg2RAeMaMe4Le32/dBLDC/4ew4oszt6XBO6zsxS4S7KX+WepBepfPEATa
 fDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055525; x=1780660325;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6isQmhl8AByeG3vxaNRFlNTwmktQzXl/oedk76YT5Ng=;
 b=Z1PYPOwB/TkY9WHziOxneE2jPPra/Hvz3OyDgNGvaOr29tQ6Ebtr836uJMRitanIjh
 rk3b0d0iZUadXlFxa+FQsfPXE7sgDSm//dR+mIqXnNaY6pF/fICw6wIANHPIBU4iaW7t
 K7uNFAoL858c4OEPqHKfRH+6d1RynZizH6EfOaEhx5CwjqqYEcowkkG7GZwlyawmNB9c
 LLn1SfzTQA59FDmgDJNTV++sKyDzlupoXScSEtwzHzizvzXeH6btCyMAVX27nxYOu2RV
 RFDqvpPtJf4vTY5TTmqH4OreRKlI7if1cseXigOc1SKCfZkD6MwySFnYY5BCfhRot9uw
 rshQ==
X-Gm-Message-State: AOJu0YyU2q0nohY1D4GK7mPN58DhRc+WMzyaShfdlbGjd1BNf2Jq64Cx
 1LCFrHiw6igR8VpyTtN+c0mdjEKtUhykkTTNIFGj95aijsL+KgTxcfWsKpw/awowgkY=
X-Gm-Gg: Acq92OGIvpcTgele3TCPsTSouY3EMdg9DnIyC1xAe1fPZu2MXAnB0Of4k5XGTEwQhlQ
 FDNzWy3/e5cT9S8e282zhT1bcNxZHNFoYg46QKo/bZu6KpEvXdGu3OF0JxdJpnPMs2oCBbt78FG
 FjYFvW1uoGo19/eRYgD74mhRRbhFIEsqDG04igoc0Od4N+5+Et908sVoJaaE0w1Mebc706KjmQp
 OSfvupuaifaGz/sRmBUtakqIJf9TQ7MjhgdEvBnwehtartPyUJ6vJ4TXo6xgxVomKLt7ADOr701
 I/NG3XigrUtHFGTrIC1LkM7FZk47gT9S9AQbE4jmCbhXj/kl9ChXfjl9v2ZO5n4dJx+lODJvXAz
 JOgZci7ebxIHOkdYjrrcIfc14CdMarGy7deGdCGMpF+ns4QCRdhiv3EKhUkcJFYL5XjHqvN8pj+
 dxBRWyHNmY/X9ATfbGoch3Slm2ir6T1z8hsA==
X-Received: by 2002:a05:600c:a012:b0:490:9d5b:d721 with SMTP id
 5b1f17b1804b1-4909d5bd98emr40492835e9.16.1780055525413; 
 Fri, 29 May 2026 04:52:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0e42sm34826665e9.8.2026.05.29.04.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:52:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC16D5FA5C;
 Fri, 29 May 2026 12:52:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
In-Reply-To: <20260529094619.1034458-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 29 May 2026 11:46:19 +0200")
References: <20260529094619.1034458-1-pbonzini@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 29 May 2026 12:52:03 +0100
Message-ID: <87eciuph5o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify.
>
<snip>
>=20=20
> -TL;DR:
> +.. warning::
>=20=20
> -  **Current QEMU project policy is to DECLINE any contributions which are
> -  believed to include or derive from AI generated content. This includes
> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> +   Please read the below policy before using AI to contribute code or
> +   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> +   Llama, and similar tools.**
>

Stray **, also extra space after QEMU.

> -  **This policy does not apply to other uses of AI, such as researching =
APIs
> -  or algorithms, static analysis, or debugging, provided their output is=
 not
> -  included in contributions.**
> +The increasing prevalence of AI-assisted software development,
> +and especially the use of content generated by `Large Language Models
> +<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
> +poses a number of difficult questions.
>=20=20
> -The increasing prevalence of AI-assisted software development results in=
 a
> -number of difficult legal questions and risks for software projects, inc=
luding
> -QEMU.  Of particular concern is content generated by `Large Language Mod=
els
> -<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> +Risks to open source projects include maintainer burnout from an
> +increased number of contributions, as well as the risk to the project
> +from unintentional inclusion of copyrighted material in the LLM's output.
> +In order to mitigate these risks, the QEMU project currently allows
> +using AI/LLM tools to produce patches in a limited set of scenarios:
>=20=20
> -The QEMU community requires that contributors certify their patch submis=
sions
> -are made in accordance with the rules of the `Developer's Certificate of
> -Origin (DCO) <dco>`.
> +**Mechanical changes**
> +  If you can use a deterministic tool, it is preferred that you use
> it

deterministic tool or script,?

> +  and not replace it with AI. If you don't know how to do the change
> +  deterministically, you can ask the AI for help.
>=20=20
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
>=20=20
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
> +  oversight.  Pay attention to the organization and flow of the generated
> +  text, and strictly fact-check all technical details as LLMs are prone
> +  to being confidently wrong.
>=20=20
> -How contributors could comply with DCO terms (b) or (c) for the output o=
f AI
> -content generators commonly available today is unclear.  The QEMU projec=
t is
> -not willing or able to accept the legal risks of non-compliance.
> +**Tests**
> +  Note that you must still confirm that each test actually exercises
> +  the intended behavior including, for regression tests, that it
> +  fails without the code under test and passes for the right reason.
>=20=20
> -The QEMU project thus requires that contributors refrain from using AI c=
ontent
> -generators on patches intended to be submitted to the project, and will
> -decline any contribution if use of AI is either known or suspected.
> +These boundaries do not apply to other uses of AI, such as researching
> +APIs or algorithms, static analysis, or debugging, provided the model's
> +output is not included in contributions.
>=20=20
> -Examples of tools impacted by this policy includes GitHub's CoPilot, Ope=
nAI's
> -ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
> -generation agents which are built on top of such tools.
> +If you wish to send large amounts of AI-generated changes, or any other
> +contribution not in the above categories, please get in touch with the
> +maintainer beforehand.  These can be treated as experiments, at the
> +discretion of the maintainer and the community, with no obligation
> +to accept them.
>=20=20
> -This policy may evolve as AI tools mature and the legal situation is
> -clarified.
> +**Use of AI does not remove the need for authors to comply with all
> +other requirements for contribution.**  In particular, the
> +``Signed-off-by`` label in a patch submission is a statement that
> +the author takes responsibility for the entire contents of the patch,
> +certifying that their patch submission is made in accordance with the
> +rules of the `Developer's Certificate of Origin (DCO) <dco>`.
>=20=20
> -Exceptions
> -^^^^^^^^^^
> +Commit messages for AI-assisted changes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>

In my v2 I added:

  AI tools **should not be used to write commit messages**. The act of
  summarising and explaining the reasoning for the changes is an
  important demonstration of the human authors understanding of the
  commit.


> -The QEMU project welcomes discussion on any exceptions to this policy,
> -or more general revisions. This can be done by contacting the qemu-devel
> -mailing list with details of a proposed tool, model, usage scenario, etc.
> -that is beneficial to QEMU, while still mitigating issues around complia=
nce
> -with the DCO.  After discussion, any exception will be listed below.
> +When AI/LLM tools produce or substantively shape your patch, add an
> +``AI-used-for:`` line before ``Signed-off-by``, as a reminder of your
> +DCO obligations and a guide to reviewers.  The text is one or more of
> +``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> +explanation in parentheses:
>=20=20
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
> +  These are too generic to provide meaningful context.  You can of course
> +  use them in the context of a complex interaction with the LLM, but they
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

The other changes in my v2 where just different wordings for the same conce=
pt.

With those have a:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


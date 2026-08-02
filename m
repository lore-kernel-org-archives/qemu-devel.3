Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E09FC55162
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 19:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqcDL-0000k3-NO; Sun, 02 Aug 2026 15:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqcDK-0000jT-5H
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 15:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wqcDH-00043A-Bc
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 15:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785700269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yi8phIHzoQKcFpYtA8ucQzawmyX4YiPBDBn1JKKqQQg=;
 b=HXBS1wOeaSkOFoCN90oJfNk1utuKGCPygw83YBUGpNv9RnVUll4NgS+j9fwHBxARJ8O1Us
 SxogHBHnQ6GruqFjd5r/Cx3guD0BB/bhAnwFq4nl9/AW4aoWsh1Ml9VKLY9fjc6Ry2BY1Y
 ymPdxaNqHfqX86Kp8lMRgmQM0rQ1ZQU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-3s9vOKyDMliHVEoeC3CjSg-1; Sun, 02 Aug 2026 15:51:08 -0400
X-MC-Unique: 3s9vOKyDMliHVEoeC3CjSg-1
X-Mimecast-MFC-AGG-ID: 3s9vOKyDMliHVEoeC3CjSg_1785700267
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955ecd8a10so12003485e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785700267; x=1786305067; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yi8phIHzoQKcFpYtA8ucQzawmyX4YiPBDBn1JKKqQQg=;
 b=YG12/ht7fVNJ5sHm9clePHdBq9VAzyRJSLYfUvyTvCIaSgNaajWUb/4+nzqEmNK1Oi
 xzL6GeGs4fUAzH+kECJEddTdgxvlarh/1D8WxsOlpvmWX3BdVZdvxYuyYBVfYOV84agK
 sJNK4SRD8D18Eqra2MKifqOYPpAJs+g+TlVOFiJxPy4YUD7yK+hwDyTkY82FMX3Uh2Gz
 APWyFZvSB1+ldD5vh1IOOs6eSlj/tcpDAtPcw95QyLCcdqsKrOB+DYIJxawojxs7by81
 p6GmUY/sgnRDkSvloS8GgQa0/BmmtiNJ3+bcsnrmx6B5aH9XO7eV/dvaARomBmMq5HL8
 LPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785700267; x=1786305067;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yi8phIHzoQKcFpYtA8ucQzawmyX4YiPBDBn1JKKqQQg=;
 b=hCw73V30fHKNQ4/C5YZ20bRPUwkeOCyzQP5gysihkLcR8kCgKeaAc5YAkUwtCuFV6m
 D9x+JOSYPQh1jfiUeTQpTmQE8TJ/CX3XEK0gGl07hZm4lC2oNoefSkyy6qSqMFFi56Pl
 mI+z32YgCZ9aAQUu3wXahUe0IZA7ev/5WOTw7vZcUuY9TByqEDTOpBQmgBOfdeOcADBr
 KkahsOOCE2uXOkONuCS1Fx6+UOi6bVFYvovzPCXu/lPuGMPZvRPzw6DpLBa34zHvY0l4
 vMv73MSzF7UevYbSEr8EYEKWt/LLU348K4b25mNsZzRCSSOWfGRJ9XVbDxtmks+oxOBW
 82jg==
X-Gm-Message-State: AOJu0YwK+Y/LsJ/lnRpT3q3RJcToDPY9/+pXT1RuNYurcq2gI+CGZUvC
 x8/hya/b4TY55YYhpQFxjpZxWZgEo05jO7XnzA0WkNXFj/CfPXtWiDNsf5/vHbLUIMPQKLG8Wsc
 DBirgEMoL/VfoC+pGG+3/FtFsihLlexzXK0IDiTA5vtkX+dSvKn0sFJ1c
X-Gm-Gg: AR+sD13dYdIxkFqkIv9vI3ZGYPSMM8Pq9EC0IqgvYNU5GSRvTF2Au8TRSAvWo+uvEli
 8xXx2VI1XaTzoCJpNw6ykad4RdpR/0lpRIMu5P5ETuMfn+tzRFyiO/EUXyRTOnwU5NxNVXTaAEW
 9JiAY+t8og/QCUJ23ssgLCrbJlNSeNynrAQDJ1depofhnRNS+PsK13qZJ6zMhrnAfmFuqZfhA1x
 YH/ZOYGuEODdGBHyZPGrUcw12MyfKHknqb2SzxaNahadO1oFqpDrPBqZ6pH1bMovHo8Lo5Fykuh
 t676pjKyx6GBba3Uz3XMFXea47pJ6054/8IVa8AABFDUqJfjn+84AQWYbT6cCC2+kmTAVZg2dTI
 LVkbSMGkJyGGi9xcu7hnFrg==
X-Received: by 2002:a05:600c:4fc5:b0:495:4e1d:82df with SMTP id
 5b1f17b1804b1-4980f233e12mr159387005e9.10.1785700266497; 
 Sun, 02 Aug 2026 12:51:06 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:495:4e1d:82df with SMTP id
 5b1f17b1804b1-4980f233e12mr159386565e9.10.1785700265996; 
 Sun, 02 Aug 2026 12:51:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458bf7csm26532661f8f.32.2026.08.02.12.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 12:51:05 -0700 (PDT)
Date: Sun, 2 Aug 2026 15:51:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260802154350-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529094619.1034458-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Fri, May 29, 2026 at 11:46:19AM +0200, Paolo Bonzini wrote:
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify.
> 
> The concern that motivated the policy is unchanged, and it is worth stating
> precisely: the DCO is about whether the submitter has the legal right to
> contribute the code, not about "creative expression".  While the status of
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
> effort from the author to the reviewer of the code.  AI lowers the cost of
> producing a patch but does nothing to lower the cost of understanding and
> reviewing one; if anything it raises it, since a reviewer can no longer
> assume that the submitter has reasoned through every line.  The limits
> above work just as much to keep the volume of review work sustainable.
> 
> Revise the policy according to the above considerations, and introduce the
> "AI-used-for:" trailer as a record of where AI was used.  The standard is
> slightly different from the more usual "Assisted-by"; the intention is for
> the metadata to provide more information for reviewers to judge the result.
> 
> In any case, use of AI does not relax any other contribution requirement:
> authors still comply with the DCO and take responsibility for the whole
> patch via Signed-off-by.
> 
> [Commit message largely based on
>  https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
>  Kevin Wolf. - Paolo]

So GCC has now decided that 15 lines or so is ok, if a maintainer
decides so, and that one
should only count significantly different changes, what they call,
following the gnu maintainer guidelines "legally significant contributions":

	A change of just a few lines (less than 15 or so) is not legally
	significant for copyright. A regular series of repeated changes, such as
	renaming a symbol, is not legally significant even if the symbol has to
	be renamed in many places. 


I note that the gnu project maintainer guidelines follow this with
" Keep in mind, however, that a series of minor changes by the same
person can add up to a significant contribution. What counts is the
total contribution of the person; it is irrelevant which parts of it
were contributed when."

which I guess would be hard to apply to AI generated code, so they don't
try.


GCC also makes an exception for tests and I guess we could make
an exception for internal developer docs?



> [1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
>  docs/devel/code-provenance.rst | 142 ++++++++++++++++++++++-----------
>  1 file changed, 94 insertions(+), 48 deletions(-)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 65b8f232a08..857588c43ba 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -1,7 +1,7 @@
>  .. _code-provenance:
>  
> -Code provenance
> -===============
> +Code provenance and AI usage
> +============================
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
> -  **Current QEMU project policy is to DECLINE any contributions which are
> -  believed to include or derive from AI generated content. This includes
> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> +   Please read the below policy before using AI to contribute code or
> +   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> +   Llama, and similar tools.**
>  
> -  **This policy does not apply to other uses of AI, such as researching APIs
> -  or algorithms, static analysis, or debugging, provided their output is not
> -  included in contributions.**
> +The increasing prevalence of AI-assisted software development,
> +and especially the use of content generated by `Large Language Models
> +<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
> +poses a number of difficult questions.
>  
> -The increasing prevalence of AI-assisted software development results in a
> -number of difficult legal questions and risks for software projects, including
> -QEMU.  Of particular concern is content generated by `Large Language Models
> -<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> +Risks to open source projects include maintainer burnout from an
> +increased number of contributions, as well as the risk to the project
> +from unintentional inclusion of copyrighted material in the LLM's output.
> +In order to mitigate these risks, the QEMU project currently allows
> +using AI/LLM tools to produce patches in a limited set of scenarios:
>  
> -The QEMU community requires that contributors certify their patch submissions
> -are made in accordance with the rules of the `Developer's Certificate of
> -Origin (DCO) <dco>`.
> +**Mechanical changes**
> +  If you can use a deterministic tool, it is preferred that you use it
> +  and not replace it with AI. If you don't know how to do the change
> +  deterministically, you can ask the AI for help.
>  
> -To satisfy the DCO, the patch contributor has to fully understand the
> -copyright and license status of content they are contributing to QEMU. With AI
> -content generators, the copyright and license status of the output is
> -ill-defined with no generally accepted, settled legal foundation.
> +**Small bug fixes**
> +  These should be limited to 20 lines of code or less, not including
> +  tests.  You are still expected to :ref:`understand and explain your changes
> +  <write_a_meaningful_commit_message>` and the rationale behind them.
>  
> -Where the training material is known, it is common for it to include large
> -volumes of material under restrictive licensing/copyright terms. Even where
> -the training material is all known to be under open source licenses, it is
> -likely to be under a variety of terms, not all of which will be compatible
> -with QEMU's licensing requirements.
> +**Documentation and code comments**
> +  While AI can help draft text, it still requires significant human
> +  oversight.  Pay attention to the organization and flow of the generated
> +  text, and strictly fact-check all technical details as LLMs are prone
> +  to being confidently wrong.
>  
> -How contributors could comply with DCO terms (b) or (c) for the output of AI
> -content generators commonly available today is unclear.  The QEMU project is
> -not willing or able to accept the legal risks of non-compliance.
> +**Tests**
> +  Note that you must still confirm that each test actually exercises
> +  the intended behavior including, for regression tests, that it
> +  fails without the code under test and passes for the right reason.
>  
> -The QEMU project thus requires that contributors refrain from using AI content
> -generators on patches intended to be submitted to the project, and will
> -decline any contribution if use of AI is either known or suspected.
> +These boundaries do not apply to other uses of AI, such as researching
> +APIs or algorithms, static analysis, or debugging, provided the model's
> +output is not included in contributions.
>  
> -Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
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
> -mailing list with details of a proposed tool, model, usage scenario, etc.
> -that is beneficial to QEMU, while still mitigating issues around compliance
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
> +  These describe concrete constraints or instructions, making it easy for a
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
> +QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
> +trailers to indicate AI usage.  In particular, it is not necessary to
> +specify the exact AI model or tool used to create the commit.
> +
> +Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> +the trailer, but should be mentioned in the commit message.
> -- 
> 2.54.0



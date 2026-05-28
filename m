Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25279CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVU1-0005BE-W4; Thu, 28 May 2026 03:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSVU0-0005B2-7q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSVTw-0006hV-Kn
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779954521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PuQIAJleZfkuHbEbTND5ZaeFZaspdqm93Fn/mYx93Ho=;
 b=frJLs9sezlBmgWVS+GRab3Kbq/BitJi/6zfPNkxdhl0RvOdY8CEVf5lVvBPrs+EfqgLMlJ
 aZAqOAFH9FRBLH6qJD0k8sNzmZJL8b57FOJvU7LIBOk2qLOV3pWfEt/u+R372IPHMEE4k1
 GaNpfsZFZ/WazMJYW9PI1GOEg6YBqFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-MBJfcPBWPpCked0wLhlMjw-1; Thu, 28 May 2026 03:48:34 -0400
X-MC-Unique: MBJfcPBWPpCked0wLhlMjw-1
X-Mimecast-MFC-AGG-ID: MBJfcPBWPpCked0wLhlMjw_1779954513
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490261c79fcso46927605e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779954513; x=1780559313; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PuQIAJleZfkuHbEbTND5ZaeFZaspdqm93Fn/mYx93Ho=;
 b=pgF554Jfjk2fHeG/C/nus6umBeT17rzivNcBlpy358bze5UA0Zu2Kjo30yMUwgMZnG
 3AomlcuDbtGulN6+tUrjJnqoRHXqdBRjkXpLtccDZEFdnEA6b8dLY3iMoM5OA11tDnsD
 UZ4FnA9rbY++LGWgly2TMGFU+SVzsn0vDHqBQ0L77gn5YwdEr8LmfEiQmPhcT8Dx/3ry
 O8wzzuUcqTufbmOZlmTncLalPzQFsbuOTCJgyx8kv6u3zbp6QuAP7wBzxBLONMfbCKsK
 ugCIk/RyOIY+CpTOl39NMyFhG0ifpr9/nbTyX/+AxTTd1Ji7T5l6MkMrwd6oBVrZAOjW
 ewJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779954513; x=1780559313;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PuQIAJleZfkuHbEbTND5ZaeFZaspdqm93Fn/mYx93Ho=;
 b=hv4Ev+E9Qf0ZRQSpzSsF2DkffrB3RoSlPkv5y2DbRXVYE8xqAPHt5/bOnNzB1qeZ2e
 cd/uvrbTh6twAO8vBSHa68MeYrVblFOHgIOX4WinotIm1cdshH/fLnTrMdNYXu0iWMBK
 j/5R0fEEHlv7JKoauTLqJcY9LnLuWxhWU4mRv8EY5HXI71KuA+zGbzi+gekWQolXQirJ
 XYZ4Trnpj+lCFmZIdJ2rPGsLqwR3wAzse1NF15lzlhVWEiq9bj7gd7NIEfmq/fICWfs2
 HVRApkjszcaifmB6gz8LWpvLrHveGs5PSQid0xExSSbaSO9zDoddtWri6uCIqGzxBH31
 xJgA==
X-Gm-Message-State: AOJu0Yz4DfW0/5sC+wXs8MciUx6SOkVZHZJGZ76VUqmDzWu8dbr5hF7u
 NSUCD8JP89R5VP5cg+NJck+ZPe5YxlUOg0NA3YJ9hxD74Pf//sZjN5IBI1bGOUKGSIoVVpCVOzP
 sp5nQ/kkpuDVlDA2exKKJGYmVuNnW5NzR8ittMatX4lUaHcB3B65MweSp
X-Gm-Gg: Acq92OEEZ906ewMRR/Q0sDUGX5vMl9CY6nE7udrAIgGlRlmrGHirKbt16BP+2DKW/gC
 wd5MOewz1Z+CCu9JHnPfilJYM4dERyQwVEsQO+ra6q7w/kPGXS0hnWwIyy3opGgWWLkhfFRKswa
 T7Kw1Rr+2e8wAARIoOMwep0CQ+BOf9Xs6OG/tW4JLc31oQfny4Ue3O1WMEqe4ZwedUqANvMnNPm
 8H05BAvQVKQu9Ejv77WMjuqn3t9J5u7o6ZNfguKquafeyhiXdAws3lSvTmDC+re8Sp4KJCe3srV
 U1biGkYnPPWay0vdyM+DziQ7GXygjuvaR81lCJ6DHZXWyWpoLf5/huHJfjOx1ad0wce20PstHAZ
 djSU6r08YTHd59I8CUvoIoek=
X-Received: by 2002:a05:600c:3f19:b0:490:5443:620e with SMTP id
 5b1f17b1804b1-490947bfb8bmr9674675e9.15.1779954513192; 
 Thu, 28 May 2026 00:48:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3f19:b0:490:5443:620e with SMTP id
 5b1f17b1804b1-490947bfb8bmr9674155e9.15.1779954512668; 
 Thu, 28 May 2026 00:48:32 -0700 (PDT)
Received: from redhat.com ([46.210.234.60]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557679sm20424651f8f.10.2026.05.28.00.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:48:32 -0700 (PDT)
Date: Thu, 28 May 2026 03:48:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260528034301-mutt-send-email-mst@kernel.org>
References: <20260528073412.551117-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528073412.551117-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 28, 2026 at 09:34:12AM +0200, Paolo Bonzini wrote:
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify.
> 
> The concern that motivated the policy is unchanged, and it is worth
> stating precisely: the DCO is about whether the submitter has the legal
> right to contribute the code, not about "creative expression".  The
> copyright and license status of LLM output remains unsettled, so that
> question is still open.  What has shifted is the balance of risk:
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
> Revise the policy to permit AI assistance where the ramifications of
> copyright violations are at least easy to revert and unlikely to spread:
> tests, documentation, mechanical changes, and small bug fixes.  Core code
> that other things depend on, and that cannot simply be thrown away once
> a problem is noticed long after the fact, stays off-limits without prior
> agreement from a maintainer.
> 
> Related to this, and already visible in the incredible uptick in
> security requirements, is the question of maintainer burnout and the
> shift in effort from the author to the reviewer of the code.  AI lowers
> the cost of producing a patch but does nothing to lower the cost of
> understanding and reviewing one; if anything it raises it, since a
> reviewer can no longer assume that the submitter has reasoned through
> every line.  The limits above work just as much to keep the volume of
> review work sustainable.
> 
> Furthermore, introduce "AI-used-for:" as a trailer to record where AI
> was used, and include other suggestions that help reviewers judge
> the result.  The standard is slightly different from the more usual
> "Assisted-by", which doubles as a check that the author has read the
> policy.
> 
> In any case, use of AI does not relax any other contribution requirement:
> authors still comply with the DCO and take responsibility for the whole
> patch via Signed-off-by.
> 
> [Commit message largely based on
>  https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
>  Kevin Wolf. - Paolo]
> 
> [1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Warner Losh <imp@bsdimp.com>
> Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>

Thanks, looks good to me. Two small questions below.

Minor so anyway:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  docs/devel/code-provenance.rst | 123 ++++++++++++++++++++-------------
>  1 file changed, 75 insertions(+), 48 deletions(-)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index 65b8f232a08..84f9f4a70fb 100644
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
> @@ -288,62 +288,89 @@ content generators below.
>  Use of AI-generated content
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -TL;DR:
> +**Please read the below policy before using AI to contribute code or
> +documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> +Llama, and similar tools.**
>  
> -  **Current QEMU project policy is to DECLINE any contributions which are
> -  believed to include or derive from AI generated content. This includes
> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> +The increasing prevalence of AI-assisted software development,
> +and especially the use of content generated by `Large Language Models
> +<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
> +poses a number of difficult questions.
>  
> -  **This policy does not apply to other uses of AI, such as researching APIs
> -  or algorithms, static analysis, or debugging, provided their output is not
> -  included in contributions.**
> +Risks to open source projects include maintainer burnout from an
> +increased number of contributions, as well as the risk to the project
> +from unintentional inclusion of copyrighted material in the LLM's output.
> +In order to mitigate these risks, the QEMU project currently allows
> +using AI/LLM tools to produce patches in a limited set of scenarios:
>  
> -The increasing prevalence of AI-assisted software development results in a
> -number of difficult legal questions and risks for software projects, including
> -QEMU.  Of particular concern is content generated by `Large Language Models
> -<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> +**Mechanical changes**
> +  If you can use a deterministic tool or a script, it is preferred
> +  that you use it and not replace it with AI. If you don't know how
> +  to do the change deterministically, you can ask the AI for help.
>  
> -The QEMU community requires that contributors certify their patch submissions
> -are made in accordance with the rules of the `Developer's Certificate of
> -Origin (DCO) <dco>`.
> +**Small bug fixes**
> +  These should be limited to 20 lines of code or less, not including
> +  tests.  You are still expected to understand and explain your changes
> +  and the rationale behind them.
>  
> -To satisfy the DCO, the patch contributor has to fully understand the
> -copyright and license status of content they are contributing to QEMU. With AI
> -content generators, the copyright and license status of the output is
> -ill-defined with no generally accepted, settled legal foundation.
> +**Tests**
> +  Note that you must still confirm that each test actually exercises
> +  the intended behavior including, for regression tests, that it
> +  fails without the code under test and passes for the right reason.
>  
> -Where the training material is known, it is common for it to include large
> -volumes of material under restrictive licensing/copyright terms. Even where
> -the training material is all known to be under open source licenses, it is
> -likely to be under a variety of terms, not all of which will be compatible
> -with QEMU's licensing requirements.
> +These boundaries do not apply to other uses of AI, such as researching
> +APIs or algorithms, static analysis, or debugging, provided the model's
> +output is not included in contributions.
>  
> -How contributors could comply with DCO terms (b) or (c) for the output of AI
> -content generators commonly available today is unclear.  The QEMU project is
> -not willing or able to accept the legal risks of non-compliance.
> +If you wish to send large amounts of AI-generated changes, or any other
> +contribution not in the above categories, please get in touch with the
> +maintainer beforehand.

To be clear, the implication is that
	These can be accepted at the discretion of the maintainer
?

Maybe make it explicit.

>  
> -The QEMU project thus requires that contributors refrain from using AI content
> -generators on patches intended to be submitted to the project, and will
> -decline any contribution if use of AI is either known or suspected.
> +**Use of AI does not remove the need for authors to comply with all
> +other requirements for contribution.**  In particular, the
> +``Signed-off-by`` label in a patch submission is a statement that
> +the author takes responsibility for the entire contents of the patch,
> +certifying that their patch submission is made in accordance with the
> +rules of the `Developer's Certificate of Origin (DCO) <dco>`.
>  
> -Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
> -ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
> -generation agents which are built on top of such tools.
> +Commit messages for AI-assisted changes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> -This policy may evolve as AI tools mature and the legal situation is
> -clarified.
> +When AI/LLM tools produce or substantively shape your patch, add an
> +``AI-used-for:`` trailer.  The text of the trailer could be one or more
> +of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> +explanation in parentheses::
>  
> -Exceptions
> -^^^^^^^^^^
> +     AI-used-for: tests, docs
> +     AI-used-for: code
> +     AI-used-for: code (refactoring)
> +     AI-used-for: code (prototype)
> +     AI-used-for: research

Why include research here when we also explicitly say:

	> +These boundaries do not apply to other uses of AI, such as researching
	> +APIs or algorithms, static analysis, or debugging, provided the model's
	> +output is not included in contributions.

?

>  
> -The QEMU project welcomes discussion on any exceptions to this policy,
> -or more general revisions. This can be done by contacting the qemu-devel
> -mailing list with details of a proposed tool, model, usage scenario, etc.
> -that is beneficial to QEMU, while still mitigating issues around compliance
> -with the DCO.  After discussion, any exception will be listed below.
> +The trailer is intended as a clarification of your DCO obligations as
> +well as to guide reviewers.  It is not intended for minimal presence
> +such as autocomplete or asking for a pre-review of the patch, and it
> +does not remove your responsibility to understand the changes that you
> +are submitting.
>  
> -Exceptions do not remove the need for authors to comply with all other
> -requirements for contribution.  In particular, the "Signed-off-by"
> -label in a patch submission is a statement that the author takes
> -responsibility for the entire contents of the patch, including any parts
> -that were generated or assisted by AI tools or other tools.
> +There is no requirement to include your prompts or summarize the
> +conversation in the commit message or cover letter, but you may do so
> +if you think it helps a reviewer judge the result.  For example:
> +
> +* yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> +  function already has a local variable or parameter of type ``struct
> +  bb``, use it instead of accessing ``aa.bb``";
> +
> +* yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``; for
> +  the implementation, take the lock around the calls and forward to ``T``";
> +
> +* no: "write user-facing documentation for the new tool"
> +
> +* no: "write testcases for the new functions"
> +
> +QEMU does *not* use ``Assisted-by`` or ``Generated-by`` trailers.  In
> +particular, it is not necessary to specify the exact AI model or tool
> +used to create the commit.
> +
> +Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> +the trailer, but should be mentioned in the commit message.
> -- 
> 2.54.0



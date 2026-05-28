Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ACBCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVG3-0001KE-1g; Thu, 28 May 2026 03:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVG1-0001Cs-SY
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVFz-0007Hl-9p
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779953658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ffWPY9LOCz8IklgLv26GD4+NJhmtN3NneBptjsSVy14=;
 b=R9+KHmMCr9Uoo5DggpvV5OxsmWKR2qMfmad08XdyboZsTqP9M1zQrNngbu6JR9HnVvrmni
 zM2kLHARvmHj/L71Ppdr1kTBhhBIWcj6lXtvIoqMYoQM5I1vk1/5fLvRTl1NuGwwX6pTrw
 oXtEN3ewPHh0jeBaUs0+ASD2OY9U7+k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-El8xuFnSOrCiWUUZQxzGZQ-1; Thu, 28 May 2026 03:34:16 -0400
X-MC-Unique: El8xuFnSOrCiWUUZQxzGZQ-1
X-Mimecast-MFC-AGG-ID: El8xuFnSOrCiWUUZQxzGZQ_1779953655
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490261c79fcso46849115e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779953655; x=1780558455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ffWPY9LOCz8IklgLv26GD4+NJhmtN3NneBptjsSVy14=;
 b=RwYSOhIC6Emuqmu9Fxr50jTd8rgpJBJvdE3kPvkpvzWYgM+WsW8gXZesHk/G1+ocVz
 KJZmfS4DS07+folrnv6ECEUnM4PqlcCO9e7eMthm1l1FQlo4MvzGDvz6KWGZpbY/bPpl
 sVLOzHh2gMDKylr2+9MpM4veubqG3zfKV10Xr4jOEvAD8nzkOWt4qFOEZCoYTGk6p8nv
 GlebubozJ1ZAg3GgtttSd5V8EfoAXaYN0WfBolJwdlR1tOuIPa8IjUYOEpJfQ2uE0t/x
 kRu3kN76r9tvs6c6+e0O9u0wcRNwRld/L0tB49WN6/Z20cC68l4bWCW2mUZHBOvAB1f1
 W1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779953655; x=1780558455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffWPY9LOCz8IklgLv26GD4+NJhmtN3NneBptjsSVy14=;
 b=T02a6CTTu8/iiUP+SIdN/VjSPMjJ1X7BhsqQ9GWT0Bj1H8DLnp8YS4o1LjIMu9J67A
 D09akJ1FUZhu4H50CifsylIsQBVNUGKpklVpG8s4GFfLGUdfWADP1C8SNSzX3R7RdZiV
 SsKgb//x/Y3hq8pmj/WGUvWAoaPRTSxTZo1g91FNufIIsGZnkDoUSQqwHDBU8l3DUXb3
 yMdOmZVTf746eebeSkmR4INJnmc3sSfc0Z5sMKEP81CBo8cARgljeXgErA5idiJmU2yw
 gIrHkleo/sXtgzt8g+F72Ms4lf7gt7S8OrQWAQ73EADB7RJyylm01hUstbMpJE+qPB9y
 qXgA==
X-Gm-Message-State: AOJu0YwaHzAKnbnl6C7/UGGNBWFbkVs8VX1xLNRfGJRojzbjQoOUMNnr
 QO+6uQ/8zcF030C0PGbbFhIYRDsIZtD6ZkrmWRL3PJTNGJfVhpbukatmi42ny4VEGwEqLU7cbM+
 3nK8wbWlZwkKKeULrT13gBdjTdKQsde21h9k5vpSxqq7KjPVZuF48q2xYgbsuItWYfaH1BqajFa
 6SM97aVD3zxEBupr4vCS4hs05cuHpmW3e6Jo7JjuAy
X-Gm-Gg: Acq92OEKAFTH8+8n1UUIRQ87qCBVO3k1Xug81mxTOWpAOP3Op04SGNjGWdG3RS66RP+
 Z/gUPoWuxHkMKYxuDlkQ3LECUIHEsYEipiuFSpR+cN8To3B8meOPk+9EXBDjYYPsFYXHs2RI6D1
 luWwtmM+gHeF9B8WL1ciIkRL2axfE9QkPQGTlIdZvoDD7YG6hj5fSdyj56I/wzqq8j11AaHIsIL
 vFRyLvUPPt7Gk94I6apOMTwC/X/b/vpdH09p1OjYZDtydExXhnDaamH6LBCBKm9SrFjAL33zFLA
 4/hXYKYR0QB7IXRQSgvyFVFQILRB82ntyg5Gu5w6EWuRtDO4L98DL/URY7sYXl6fLP4c+KsP282
 2fbVlv7Gker8q4ypxmYzDi3YOT9sB9Fhq2zr7J0tW71jivg1rhMDGw6sgVOVxcAJtdqk6BtZni+
 GH4GxmRts04LO3nHZuFz9xUGTfSC5SpcnDrW8fRg==
X-Received: by 2002:a05:600c:3b28:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-49094785a28mr7228465e9.2.1779953655086; 
 Thu, 28 May 2026 00:34:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3b28:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-49094785a28mr7227745e9.2.1779953654514; 
 Thu, 28 May 2026 00:34:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908e9b0c57sm13704825e9.7.2026.05.28.00.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:34:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] docs/devel: relax policy on AI-generated contributions
Date: Thu, 28 May 2026 09:34:12 +0200
Message-ID: <20260528073412.551117-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Until now QEMU's code provenance policy declined any contribution
believed to include or derive from AI-generated content.  A blanket ban
was easy to maintain while LLM output was rarely usable on its own, but
as the tools improved an absolute prohibition has become harder to
justify.

The concern that motivated the policy is unchanged, and it is worth
stating precisely: the DCO is about whether the submitter has the legal
right to contribute the code, not about "creative expression".  The
copyright and license status of LLM output remains unsettled, so that
question is still open.  What has shifted is the balance of risk:

- projects accepting AI-assisted content have not run into serious
  legal trouble so far, which suggests the probability of the risk
  materializing is not high;

- other organizations, such as Red Hat[1], have assessed the risk as
  acceptable -- though a community of individual developers does not
  have the legal backing of a company, and even an unfounded dispute
  would be a long-lasting distraction from work on QEMU.

Revise the policy to permit AI assistance where the ramifications of
copyright violations are at least easy to revert and unlikely to spread:
tests, documentation, mechanical changes, and small bug fixes.  Core code
that other things depend on, and that cannot simply be thrown away once
a problem is noticed long after the fact, stays off-limits without prior
agreement from a maintainer.

Related to this, and already visible in the incredible uptick in
security requirements, is the question of maintainer burnout and the
shift in effort from the author to the reviewer of the code.  AI lowers
the cost of producing a patch but does nothing to lower the cost of
understanding and reviewing one; if anything it raises it, since a
reviewer can no longer assume that the submitter has reasoned through
every line.  The limits above work just as much to keep the volume of
review work sustainable.

Furthermore, introduce "AI-used-for:" as a trailer to record where AI
was used, and include other suggestions that help reviewers judge
the result.  The standard is slightly different from the more usual
"Assisted-by", which doubles as a check that the author has read the
policy.

In any case, use of AI does not relax any other contribution requirement:
authors still comply with the DCO and take responsibility for the whole
patch via Signed-off-by.

[Commit message largely based on
 https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
 Kevin Wolf. - Paolo]

[1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Warner Losh <imp@bsdimp.com>
Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 docs/devel/code-provenance.rst | 123 ++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 48 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 65b8f232a08..84f9f4a70fb 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -1,7 +1,7 @@
 .. _code-provenance:
 
-Code provenance
-===============
+Code provenance and AI usage
+============================
 
 Certifying patch submissions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -288,62 +288,89 @@ content generators below.
 Use of AI-generated content
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-TL;DR:
+**Please read the below policy before using AI to contribute code or
+documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
+Llama, and similar tools.**
 
-  **Current QEMU project policy is to DECLINE any contributions which are
-  believed to include or derive from AI generated content. This includes
-  ChatGPT, Claude, Copilot, Llama and similar tools.**
+The increasing prevalence of AI-assisted software development,
+and especially the use of content generated by `Large Language Models
+<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
+poses a number of difficult questions.
 
-  **This policy does not apply to other uses of AI, such as researching APIs
-  or algorithms, static analysis, or debugging, provided their output is not
-  included in contributions.**
+Risks to open source projects include maintainer burnout from an
+increased number of contributions, as well as the risk to the project
+from unintentional inclusion of copyrighted material in the LLM's output.
+In order to mitigate these risks, the QEMU project currently allows
+using AI/LLM tools to produce patches in a limited set of scenarios:
 
-The increasing prevalence of AI-assisted software development results in a
-number of difficult legal questions and risks for software projects, including
-QEMU.  Of particular concern is content generated by `Large Language Models
-<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
+**Mechanical changes**
+  If you can use a deterministic tool or a script, it is preferred
+  that you use it and not replace it with AI. If you don't know how
+  to do the change deterministically, you can ask the AI for help.
 
-The QEMU community requires that contributors certify their patch submissions
-are made in accordance with the rules of the `Developer's Certificate of
-Origin (DCO) <dco>`.
+**Small bug fixes**
+  These should be limited to 20 lines of code or less, not including
+  tests.  You are still expected to understand and explain your changes
+  and the rationale behind them.
 
-To satisfy the DCO, the patch contributor has to fully understand the
-copyright and license status of content they are contributing to QEMU. With AI
-content generators, the copyright and license status of the output is
-ill-defined with no generally accepted, settled legal foundation.
+**Tests**
+  Note that you must still confirm that each test actually exercises
+  the intended behavior including, for regression tests, that it
+  fails without the code under test and passes for the right reason.
 
-Where the training material is known, it is common for it to include large
-volumes of material under restrictive licensing/copyright terms. Even where
-the training material is all known to be under open source licenses, it is
-likely to be under a variety of terms, not all of which will be compatible
-with QEMU's licensing requirements.
+These boundaries do not apply to other uses of AI, such as researching
+APIs or algorithms, static analysis, or debugging, provided the model's
+output is not included in contributions.
 
-How contributors could comply with DCO terms (b) or (c) for the output of AI
-content generators commonly available today is unclear.  The QEMU project is
-not willing or able to accept the legal risks of non-compliance.
+If you wish to send large amounts of AI-generated changes, or any other
+contribution not in the above categories, please get in touch with the
+maintainer beforehand.
 
-The QEMU project thus requires that contributors refrain from using AI content
-generators on patches intended to be submitted to the project, and will
-decline any contribution if use of AI is either known or suspected.
+**Use of AI does not remove the need for authors to comply with all
+other requirements for contribution.**  In particular, the
+``Signed-off-by`` label in a patch submission is a statement that
+the author takes responsibility for the entire contents of the patch,
+certifying that their patch submission is made in accordance with the
+rules of the `Developer's Certificate of Origin (DCO) <dco>`.
 
-Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
-ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
-generation agents which are built on top of such tools.
+Commit messages for AI-assisted changes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-This policy may evolve as AI tools mature and the legal situation is
-clarified.
+When AI/LLM tools produce or substantively shape your patch, add an
+``AI-used-for:`` trailer.  The text of the trailer could be one or more
+of ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
+explanation in parentheses::
 
-Exceptions
-^^^^^^^^^^
+     AI-used-for: tests, docs
+     AI-used-for: code
+     AI-used-for: code (refactoring)
+     AI-used-for: code (prototype)
+     AI-used-for: research
 
-The QEMU project welcomes discussion on any exceptions to this policy,
-or more general revisions. This can be done by contacting the qemu-devel
-mailing list with details of a proposed tool, model, usage scenario, etc.
-that is beneficial to QEMU, while still mitigating issues around compliance
-with the DCO.  After discussion, any exception will be listed below.
+The trailer is intended as a clarification of your DCO obligations as
+well as to guide reviewers.  It is not intended for minimal presence
+such as autocomplete or asking for a pre-review of the patch, and it
+does not remove your responsibility to understand the changes that you
+are submitting.
 
-Exceptions do not remove the need for authors to comply with all other
-requirements for contribution.  In particular, the "Signed-off-by"
-label in a patch submission is a statement that the author takes
-responsibility for the entire contents of the patch, including any parts
-that were generated or assisted by AI tools or other tools.
+There is no requirement to include your prompts or summarize the
+conversation in the commit message or cover letter, but you may do so
+if you think it helps a reviewer judge the result.  For example:
+
+* yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
+  function already has a local variable or parameter of type ``struct
+  bb``, use it instead of accessing ``aa.bb``";
+
+* yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``; for
+  the implementation, take the lock around the calls and forward to ``T``";
+
+* no: "write user-facing documentation for the new tool"
+
+* no: "write testcases for the new functions"
+
+QEMU does *not* use ``Assisted-by`` or ``Generated-by`` trailers.  In
+particular, it is not necessary to specify the exact AI model or tool
+used to create the commit.
+
+Deterministic tooling (sed, coccinelle, formatters) is out of scope for
+the trailer, but should be mentioned in the commit message.
-- 
2.54.0



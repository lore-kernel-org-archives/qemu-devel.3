Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67384CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 09:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wStnT-0005Ja-DI; Fri, 29 May 2026 05:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wStnR-0005JP-WB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 05:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wStnP-0002hJ-70
 for qemu-devel@nongnu.org; Fri, 29 May 2026 05:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780047985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kzqInxwxXJ1cwZ6r3yGa98ZFsQnezNuI3cjD2WwrZhg=;
 b=iV3YXp354y7YSbWIcmaHW1INyja2jj7kkBNXuu3LPZoGgbcw3nAwETnKvaL2mDdZyMlwLV
 lVSOrytByCQ/tO33FFB5jkEsgkjvYImFFnjDmDnlOEULepAHBgtFZwI/FC8lKwe3E3j0fe
 Dic5Nx0v/mB1W+EZeK0B+XV5elC+iKM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-ja5kKR40M_eTKe5kPQGJOw-1; Fri, 29 May 2026 05:46:23 -0400
X-MC-Unique: ja5kKR40M_eTKe5kPQGJOw-1
X-Mimecast-MFC-AGG-ID: ja5kKR40M_eTKe5kPQGJOw_1780047982
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4909e29e78fso2794525e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780047982; x=1780652782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kzqInxwxXJ1cwZ6r3yGa98ZFsQnezNuI3cjD2WwrZhg=;
 b=FJaDsSc3nVlfVhKCKIgEDHHQLdZGKqvz2Q8S/Q5o5F6ZB3bWLYeZp1vxr6pV0nXByY
 ++ZC4zuDS51ZrIbT4vuGjmdS192SOtm8ktJ02FfGDsTVAW64p9Zshc6dNI4ZbkmK3cpQ
 Cof02FncF5jNQ4ZwIrjmODs1TknwshcljFeBtvTbtg4USkkyLhsZwvKJqf6LwzH/JjTD
 n1Xv5TFzkibwULlCgXeqRvxdHOCIOfLO7kkjWV0tpPMfAWAP2w0dgmaHnLJBWQ4V2WDN
 SbKM7oiXplL04uAAas3wkeVdOEcV82A7M/QrnBcsVffP7EwIA2sEDHwsq/AVJ4Br8Ztw
 OixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780047982; x=1780652782;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzqInxwxXJ1cwZ6r3yGa98ZFsQnezNuI3cjD2WwrZhg=;
 b=GF4nOU0v8DHKj2ODTFSuJDFLKKQdPHeiiohdc/8yKdq1d4V/17QXL0oKzGs017rg37
 ZWrPrn1sIXOCjRy+6swQhzEEQ+1wAwPy3wLkrD3ZPYugrvRpWOmUP3khTGQ+aNpczpLC
 vKuI22skozr979GdhdWBF+Yv1h+BqT9VZ9uCEjd0aW7h5BLHkRiY/EsAhDNfhKHxWcwy
 wDnjzCd+pLgrTvJPOrU6DyIWCxMGHOQnGkwGplvjOMmQvTHXKxEQyhYSj/JjVF5dQeyK
 dH+lrtxEziQ3dSzZ6tFwRKSRQMV2BlpjTyxdCzJl6hHC2NBaowNaDRRv/oAt8a8yQ9Fm
 XsDA==
X-Gm-Message-State: AOJu0Ywx4Bf1LhW1PtKn113En5cjUkzLd+uZFsaC0Xd5tkloqIvMN3IX
 TxK9lfI4Mz8r3h6WU8fEboFMfT1Ebcf/c8rzCQyZCHdg54pewiDcR+PNuh6hBznaVtbPZYR0Q7z
 GlTCbqKyFl9WGeGMku3soEJkC0EJekURprBO0T4xSD4NYpsDdQswVEVDLvM88jKw3tjhvt5wI6F
 E2U2NY777ZQzp6aCK/DPbOVcnf+cn8JNYBRyjMXUZJ
X-Gm-Gg: Acq92OGUHRP5oxR9sgBylQqsNntLHPSYL+J1sAFJNwhWWZs74gUaeMFZYugfieo3u79
 cZ48J/mvp99Ml2mqH+1K2rruBdhmwg0cPCYHDLjRQBhFIHEqMbdFlrV0Y0T0RefeNqR/yhpF99F
 WNuxoJzhHwGJmgmNsIGyUIEVn5QJXDkzMHCcyke2pMR0C5k1rNd8B+M0doVkzTJeu76euEwoewq
 bl7PROmW8nW/IBbPlVkAK4thFU/xbg9mOG6A0KZJ5KALef6IDqdKVIRVAV2zou5+rSrFwD1Z+ou
 YenKiDMB1wRrfDKrWgirkITQDCFcDDb8zoMQKltNUpUV7WorfEJ2WPBFW1cKrxthxDQSBAxCQ0C
 iJOf/C7NDFve3RajZ79uAHnlDRpwkv+Ds1ZkM90kHVEsXWblDCPYcrPkCpnMkpEdi2JiNwQiSgB
 B2BY4glTqTdzsIjQoWogy+BUF3BJ7we/gpg2kPgA==
X-Received: by 2002:a05:600c:1994:b0:490:48df:2793 with SMTP id
 5b1f17b1804b1-4909c0e77d6mr38576655e9.26.1780047982145; 
 Fri, 29 May 2026 02:46:22 -0700 (PDT)
X-Received: by 2002:a05:600c:1994:b0:490:48df:2793 with SMTP id
 5b1f17b1804b1-4909c0e77d6mr38576075e9.26.1780047981516; 
 Fri, 29 May 2026 02:46:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c09acd3sm10798205e9.4.2026.05.29.02.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 02:46:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Date: Fri, 29 May 2026 11:46:19 +0200
Message-ID: <20260529094619.1034458-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Until now QEMU's code provenance policy declined any contribution
believed to include or derive from AI-generated content.  A blanket ban
was easy to maintain while LLM output was rarely usable on its own, but
as the tools improved an absolute prohibition has become harder to
justify.

The concern that motivated the policy is unchanged, and it is worth stating
precisely: the DCO is about whether the submitter has the legal right to
contribute the code, not about "creative expression".  While the status of
LLM output seems to be converging towards non-copyrightability, questions
around unintentional reproduction of copyrighted code are still open.
What has shifted is the balance of risk:

- projects accepting AI-assisted content have not run into serious
  legal trouble so far, which suggests the probability of the risk
  materializing is not high;

- other organizations, such as Red Hat[1], have assessed the risk as
  acceptable -- though a community of individual developers does not
  have the legal backing of a company, and even an unfounded dispute
  would be a long-lasting distraction from work on QEMU.

Nevertheless, even Red Hat mentions that "the possibility of occasional
replication cannot be ignored".  In QEMU's view, attentiveness and
oversight are not a practical way to address this; yet as a copyleft
project, copyright and code provenance are of utmost importance to us.
Therefore, it remains prudent to only permit AI assistance where the
ramifications of copyright violations are at least easy to revert and
unlikely to spread: tests, documentation, mechanical changes, and small
bug fixes.  Core code that other things depend on, and that cannot
simply be thrown away once a problem is noticed long after the fact,
stays off-limits without prior agreement from a maintainer.

Related to this, and already visible in the incredible uptick in
security reports, is the question of maintainer burnout and the shift in
effort from the author to the reviewer of the code.  AI lowers the cost of
producing a patch but does nothing to lower the cost of understanding and
reviewing one; if anything it raises it, since a reviewer can no longer
assume that the submitter has reasoned through every line.  The limits
above work just as much to keep the volume of review work sustainable.

Revise the policy according to the above considerations, and introduce the
"AI-used-for:" trailer as a record of where AI was used.  The standard is
slightly different from the more usual "Assisted-by"; the intention is for
the metadata to provide more information for reviewers to judge the result.

In any case, use of AI does not relax any other contribution requirement:
authors still comply with the DCO and take responsibility for the whole
patch via Signed-off-by.

[Commit message largely based on
 https://lore.kernel.org/qemu-devel/ahXbxzB4C_lr6b0N@redhat.com/, by
 Kevin Wolf. - Paolo]

[1] https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 docs/devel/code-provenance.rst | 142 ++++++++++++++++++++++-----------
 1 file changed, 94 insertions(+), 48 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 65b8f232a08..857588c43ba 100644
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
@@ -288,62 +288,108 @@ content generators below.
 Use of AI-generated content
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-TL;DR:
+.. warning::
 
-  **Current QEMU project policy is to DECLINE any contributions which are
-  believed to include or derive from AI generated content. This includes
-  ChatGPT, Claude, Copilot, Llama and similar tools.**
+   Please read the below policy before using AI to contribute code or
+   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
+   Llama, and similar tools.**
 
-  **This policy does not apply to other uses of AI, such as researching APIs
-  or algorithms, static analysis, or debugging, provided their output is not
-  included in contributions.**
+The increasing prevalence of AI-assisted software development,
+and especially the use of content generated by `Large Language Models
+<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
+poses a number of difficult questions.
 
-The increasing prevalence of AI-assisted software development results in a
-number of difficult legal questions and risks for software projects, including
-QEMU.  Of particular concern is content generated by `Large Language Models
-<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
+Risks to open source projects include maintainer burnout from an
+increased number of contributions, as well as the risk to the project
+from unintentional inclusion of copyrighted material in the LLM's output.
+In order to mitigate these risks, the QEMU project currently allows
+using AI/LLM tools to produce patches in a limited set of scenarios:
 
-The QEMU community requires that contributors certify their patch submissions
-are made in accordance with the rules of the `Developer's Certificate of
-Origin (DCO) <dco>`.
+**Mechanical changes**
+  If you can use a deterministic tool, it is preferred that you use it
+  and not replace it with AI. If you don't know how to do the change
+  deterministically, you can ask the AI for help.
 
-To satisfy the DCO, the patch contributor has to fully understand the
-copyright and license status of content they are contributing to QEMU. With AI
-content generators, the copyright and license status of the output is
-ill-defined with no generally accepted, settled legal foundation.
+**Small bug fixes**
+  These should be limited to 20 lines of code or less, not including
+  tests.  You are still expected to :ref:`understand and explain your changes
+  <write_a_meaningful_commit_message>` and the rationale behind them.
 
-Where the training material is known, it is common for it to include large
-volumes of material under restrictive licensing/copyright terms. Even where
-the training material is all known to be under open source licenses, it is
-likely to be under a variety of terms, not all of which will be compatible
-with QEMU's licensing requirements.
+**Documentation and code comments**
+  While AI can help draft text, it still requires significant human
+  oversight.  Pay attention to the organization and flow of the generated
+  text, and strictly fact-check all technical details as LLMs are prone
+  to being confidently wrong.
 
-How contributors could comply with DCO terms (b) or (c) for the output of AI
-content generators commonly available today is unclear.  The QEMU project is
-not willing or able to accept the legal risks of non-compliance.
+**Tests**
+  Note that you must still confirm that each test actually exercises
+  the intended behavior including, for regression tests, that it
+  fails without the code under test and passes for the right reason.
 
-The QEMU project thus requires that contributors refrain from using AI content
-generators on patches intended to be submitted to the project, and will
-decline any contribution if use of AI is either known or suspected.
+These boundaries do not apply to other uses of AI, such as researching
+APIs or algorithms, static analysis, or debugging, provided the model's
+output is not included in contributions.
 
-Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
-ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
-generation agents which are built on top of such tools.
+If you wish to send large amounts of AI-generated changes, or any other
+contribution not in the above categories, please get in touch with the
+maintainer beforehand.  These can be treated as experiments, at the
+discretion of the maintainer and the community, with no obligation
+to accept them.
 
-This policy may evolve as AI tools mature and the legal situation is
-clarified.
+**Use of AI does not remove the need for authors to comply with all
+other requirements for contribution.**  In particular, the
+``Signed-off-by`` label in a patch submission is a statement that
+the author takes responsibility for the entire contents of the patch,
+certifying that their patch submission is made in accordance with the
+rules of the `Developer's Certificate of Origin (DCO) <dco>`.
 
-Exceptions
-^^^^^^^^^^
+Commit messages for AI-assisted changes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-The QEMU project welcomes discussion on any exceptions to this policy,
-or more general revisions. This can be done by contacting the qemu-devel
-mailing list with details of a proposed tool, model, usage scenario, etc.
-that is beneficial to QEMU, while still mitigating issues around compliance
-with the DCO.  After discussion, any exception will be listed below.
+When AI/LLM tools produce or substantively shape your patch, add an
+``AI-used-for:`` line before ``Signed-off-by``, as a reminder of your
+DCO obligations and a guide to reviewers.  The text is one or more of
+``code``, ``tests``, ``docs``, ``research``, possibly followed by an
+explanation in parentheses:
 
-Exceptions do not remove the need for authors to comply with all other
-requirements for contribution.  In particular, the "Signed-off-by"
-label in a patch submission is a statement that the author takes
-responsibility for the entire contents of the patch, including any parts
-that were generated or assisted by AI tools or other tools.
+.. code-block:: none
+
+     AI-used-for: tests, docs
+     AI-used-for: code
+     AI-used-for: code (refactoring)
+     AI-used-for: code (prototype)
+     AI-used-for: research
+
+``AI-used-for`` should not be included for "background" usage such as
+autocomplete or obtaining a pre-review of the patch.
+
+There is no requirement to include your prompts or summarize the
+conversation in the commit message or cover letter, but you may do so
+if you think it helps a reviewer judge the result.  For example:
+
+**Helpful prompts**
+  These describe concrete constraints or instructions, making it easy for a
+  reviewer to see how the tool's output was guided:
+
+  * "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
+    function already has a local variable or parameter of type ``struct
+    bb``, use it instead of accessing ``aa.bb``"
+
+  * "add an implementation of the trait for ``Mutex<T: MyTrait>``; it
+    takes the lock around the calls and forwards to ``T``"
+
+**Unhelpful prompts**
+  These are too generic to provide meaningful context.  You can of course
+  use them in the context of a complex interaction with the LLM, but they
+  should not be included in the commit message:
+
+  * "write user-facing documentation for the new tool"
+
+  * "write testcases for the new functions"
+
+QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
+trailers to indicate AI usage.  In particular, it is not necessary to
+specify the exact AI model or tool used to create the commit.
+
+Deterministic tooling (sed, coccinelle, formatters) is out of scope for
+the trailer, but should be mentioned in the commit message.
-- 
2.54.0



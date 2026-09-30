Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBC0CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBq5Q-0001og-1d; Wed, 30 Sep 2026 04:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5O-0001oQ-1j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBq5K-0002lS-M6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790758481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hEHeuDU4XBQGvskatAEqBkl1mEJDjYRgS+ijQhuABk=;
 b=XDuBVSydY+X7E+/eLBBilOtf4UGnwIG2loWeZVTWFaY367Ip/BTjxSp4GGqQ/9RVPw6u6+
 FVTTf6sW6fq75YAKpV8nxZpqOmkHGo57+yRouU6CU9Vx/9PgCtHGZ216MQavGBydEyRYfs
 E7fl9WNX3WAbZsnlrgck93HfHDdvFgE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-yOZYzC_iODWbdGcSqhA3vw-1; Wed, 30 Sep 2026 04:54:39 -0400
X-MC-Unique: yOZYzC_iODWbdGcSqhA3vw-1
X-Mimecast-MFC-AGG-ID: yOZYzC_iODWbdGcSqhA3vw_1790758478
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e6ba4abdfso51265805e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790758478; x=1791363278; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2hEHeuDU4XBQGvskatAEqBkl1mEJDjYRgS+ijQhuABk=;
 b=q7QOZjaotsGn/anw/+pVmmUm696a5h9AK1MBMApnc8WNkfLXCZaMTIavXJ0bZ784be
 I4LKhJ6eUtUmSeLs+RVHy6FJutrQ7T7Md1PM4vU/h9cJO8ivujXCN8PqawebI03aA4tr
 mSVtg4hBIRqkyyccb2xfUnpFhUm+Po44x+1EblzZ6msGvwMkqRo0UxmWfySK5cUDw5Ws
 MQjcT5pmxoQ4iA8Cufq2If5V3+xl4NjKx0pNXFVTxGGQu2xOrkP2pvzSYzfpbn3Q3MLy
 2Vvi8hkqFVfTEGTZRWNUH3rCMlak91TlYUXRZ8YCWf0Bghupo8q1riSqdVEjMJ4yE+lx
 TNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758478; x=1791363278;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2hEHeuDU4XBQGvskatAEqBkl1mEJDjYRgS+ijQhuABk=;
 b=YL3Si32V5+h5pd+koQr0NxY7FyGMqmT6Rfqnekyq0leGfCQeDeyyGHs5d+IqQtKHXr
 D72PuFegejfeTCAYK44V7cahfelK3iIaWi0t1Cd96+ApUO+n36V6a6oFjs46F8D1EPCc
 F3E6QKHvRPgna689ipHk+VYmfdoRaU5jUUv22PLaVBNpkP1K3IJT3/yluYOSQApcuO9r
 yHKrBcPYPtOP7ZPUwTKpp9fAdJU6IS3xIOb9K+566IB4B78OaEJwAplqZ7FctMkJlQE8
 nxrd2eblY88NtzIkNyvUnokmV95Q7i/vasm6tYpI1TDqXZc4LJe1PvxTcT3BqYo9YYe7
 Dzyw==
X-Gm-Message-State: AFuF++n6gxlvfpvcBvi+kNNPEHeIgUpicyPgOTeDdAWGqfVGQ2lSOIvH
 AYz/WPFpRLcl42mIwWMWb75hgMbZjK6b7eGhmb2TFgRUnKgn/uhOsl5j8pNS05Qq3a8Ort1Lksu
 HI0N6Yv0ioxcBmhRaTcZMFC21/Zti5k+m2gJzpGdNH8E3d2LARC47MbGqKakNeRiChM0Xi0Fnyg
 uTUOvf0ta6cji66qA3YXkIUoJR72fWuJQfe3wz5hi1
X-Gm-Gg: AYBFou0CUaS423S9ya9EA7mE/H+47cu+5c7MCllkRSdNkOtXeobH6lpSrfC+u09UHzF
 o4iIU5S489nSAJW6FJM3eFM9Sw2LiUCEx3TgKxPPY+6YfcG9xQ3YvPN+HIiDXpwtokBD0A3I8nG
 VhWVBiVL3l+GSKmzs/XA7EKRq8RH8OcxKXylKUS6KxMxAoOpiJx1jaLQHQtko42ctvS++WGbgL0
 kzErJIKbX/W1GXvowmIjarwnweEVUjG+e3c5Ms+rtNbk9KrbOmhlHoc5X6moUKXjvyuEUTduV3u
 mzSV2xhniCZJ0HA1YbWamKdyA9rCyfFnPqVf2IWzbYFf9zvRSbW+EOzYdAUPVfBh9t8IVf6g/+F
 qVMsT8ESoEJLPCGAxYSd7D39Akj1wfZBCS0DqFZGBiR+Ymdxhk2WfcBNaPG8WYDQqdFqr66s+Nv
 9nNFv/
X-Received: by 2002:a05:600c:3145:b0:49f:bd3c:bc1a with SMTP id
 5b1f17b1804b1-4a01b00d9bamr11093915e9.21.1790758478261; 
 Wed, 30 Sep 2026 01:54:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3145:b0:49f:bd3c:bc1a with SMTP id
 5b1f17b1804b1-4a01b00d9bamr11093535e9.21.1790758477726; 
 Wed, 30 Sep 2026 01:54:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174e161bsm62191345e9.5.2026.09.30.01.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:54:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Date: Wed, 30 Sep 2026 10:54:30 +0200
Message-ID: <20260930085433.830743-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930085433.830743-1-pbonzini@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Until now QEMU's code provenance policy declined any contribution
believed to include or derive from AI-generated content.  A blanket ban
was easy to maintain while LLM output was rarely usable on its own, but
as the tools improved an absolute prohibition has become harder to
justify and enforce.

Even a simple code review task these days may result in the agent
suggesting code changes, or producing a useful test case to verify the
presence or absence of a bug.  A hardline interpretation of the policy
makes it hard to use AI even for tasks that are explicitly allowed.

On top of this, several maintainers have pointed out that contributions
that can be reasonably suspected to be AI-assisted or more have been
posted and included.  Some of these contributions are actually of very
high quality; it seems that the mailing list-based contribution process
has mostly protected QEMU from low quality patches.  A prohibition on
AI puts maintainers in a difficult position: on one hand the DCO process
lets them rely on the submitter's certification of origin, on the other
hand maintainers are supposed to know and implement the process policies.

Since the policy has been written, other projects have discussed and
taken their stance on AI contributions.  These vary from full prohibition
(though typically motivated by social reasons rather than legal, e.g.
for Zig) to limited use (e.g. GCC, allowing small contributions and
tests to use AI), to cautious experimentation.

This proposed policy seeks to implement the cautious experimentation
approach, inspired mostly by the Rust project's policy and by Software
Freedom Conservancy's own recommendations on LLMs and generative AI.

Relying on Conservancy's legal guidance allows us to focus on the
interaction between contributors and maintainers.  Conservancy in
particular provides this point to alleviate the concern that motivated
the policy, about whether the submitter has the legal right to contribute
the code and about unintentional reproduction of copyrighted code:

   "Copyleft Everything" remains the best viable and safest approach
   Certainly those who want to release FOSS under non-copyleft licenses
   have more to worry about when using these tools.

While we shouldn't treat copyleft as a silver bullet, it is effective
as part of a defense in depth strategy that includes, for example,
"de minimis" thresholds and `AGENTS.md` instructions that encourage user
participation in the design.

Therefore, the revised policy considers QEMU's copyleft to be a viable
approach to any unanswered legal questions about AI-generated
contributions and their copyright status.  This lets the policy
focus on the topic of what AI-assisted contributions require of
maintainers.

In that respect, the Rust project's policy combines two unusual ideas.
One is to hold them to a higher standard, in the spirit of using AI to
work "better, not faster"; the other is to require "pre-arrangement" for
"changes that are originally created by an LLM".  AI lowers the cost of
producing a patch but does nothing to lower the cost of understanding
and reviewing one; if anything it raises it, since a reviewer can
no longer assume that the submitter has reasoned through every line.
Pre-arrangement is an attempt to balance the shift of effort from the
developer to the maintainer, and the QEMU policy includes the same
provision.

Going full circle to the reason why we might need to review the
policy, there is the question of how to make sure policy is applied.
QEMU maintainers have already experimented with using AGENTS.md files;
subsequent patches will also try to embody the "work better, not faster"
mantra into an AGENTS.md file.  Nevertheless, some explicit prohibitions
should be included in the policy, and they are indeed.  The list is short
and based on the Rust policy and the GStreamer AGENTS.md file.

Revise the policy according to the above considerations, and introduce the
"AI-used-for:" trailer as a record of where AI was used.  The standard is
slightly different from the more usual "Assisted-by"; the intention is for
the metadata to provide more information for reviewers to judge the result,
and to scope areas for which Signed-off-by cannot guarantee full control
of provenance.

In any case, use of AI does not relax any other contribution requirement:
authors still need to comply with the DCO (declaring that they have
corporate authorization to contribute, for example) and take technical
responsibility for their work.

[Commit message largely based on discussions with Daniel Berrangé,
 Alistair Francis, Peter Maydell, Kevin Wolf and others. - Paolo]

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Warner Losh <imp@bsdimp.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst |  71 +----------
 docs/devel/index-process.rst   |   1 +
 docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
 AGENTS.md                      |  42 +++++--
 scripts/checkpatch.pl          |   5 +-
 5 files changed, 252 insertions(+), 80 deletions(-)
 create mode 100644 docs/devel/llm-usage.rst

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 65b8f232a08..7403961378e 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -128,6 +128,10 @@ that are commonly used during QEMU development:
    suggestions for how to change a patch, it is good practice to credit them
    by including a ``Suggested-by`` tag.
 
+ * **AI-used-for**: when AI/LLM tools were used to produce the patch, this tag
+   discloses what they were used for.  See :ref:`llm-usage` for the cases in
+   which it is required.
+
 Subsystem maintainer requirements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -282,68 +286,5 @@ boilerplate code template which is then filled in to produce the final patch.
 The output of such a tool would still be considered the "preferred format",
 since it is intended to be a foundation for further human authored changes.
 Such tools are acceptable to use, provided there is clearly defined copyright
-and licensing for their output. Note in particular the caveats applying to AI
-content generators below.
-
-Use of AI-generated content
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-TL;DR:
-
-  **Current QEMU project policy is to DECLINE any contributions which are
-  believed to include or derive from AI generated content. This includes
-  ChatGPT, Claude, Copilot, Llama and similar tools.**
-
-  **This policy does not apply to other uses of AI, such as researching APIs
-  or algorithms, static analysis, or debugging, provided their output is not
-  included in contributions.**
-
-The increasing prevalence of AI-assisted software development results in a
-number of difficult legal questions and risks for software projects, including
-QEMU.  Of particular concern is content generated by `Large Language Models
-<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
-
-The QEMU community requires that contributors certify their patch submissions
-are made in accordance with the rules of the `Developer's Certificate of
-Origin (DCO) <dco>`.
-
-To satisfy the DCO, the patch contributor has to fully understand the
-copyright and license status of content they are contributing to QEMU. With AI
-content generators, the copyright and license status of the output is
-ill-defined with no generally accepted, settled legal foundation.
-
-Where the training material is known, it is common for it to include large
-volumes of material under restrictive licensing/copyright terms. Even where
-the training material is all known to be under open source licenses, it is
-likely to be under a variety of terms, not all of which will be compatible
-with QEMU's licensing requirements.
-
-How contributors could comply with DCO terms (b) or (c) for the output of AI
-content generators commonly available today is unclear.  The QEMU project is
-not willing or able to accept the legal risks of non-compliance.
-
-The QEMU project thus requires that contributors refrain from using AI content
-generators on patches intended to be submitted to the project, and will
-decline any contribution if use of AI is either known or suspected.
-
-Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
-ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
-generation agents which are built on top of such tools.
-
-This policy may evolve as AI tools mature and the legal situation is
-clarified.
-
-Exceptions
-^^^^^^^^^^
-
-The QEMU project welcomes discussion on any exceptions to this policy,
-or more general revisions. This can be done by contacting the qemu-devel
-mailing list with details of a proposed tool, model, usage scenario, etc.
-that is beneficial to QEMU, while still mitigating issues around compliance
-with the DCO.  After discussion, any exception will be listed below.
-
-Exceptions do not remove the need for authors to comply with all other
-requirements for contribution.  In particular, the "Signed-off-by"
-label in a patch submission is a statement that the author takes
-responsibility for the entire contents of the patch, including any parts
-that were generated or assisted by AI tools or other tools.
+and licensing for their output. Note in particular the caveats applying to
+:ref:`AI content generators <llm-usage>`.
diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
index 5807752d704..ce0f4e73197 100644
--- a/docs/devel/index-process.rst
+++ b/docs/devel/index-process.rst
@@ -13,6 +13,7 @@ Notes about how to interact with the community and how and where to submit patch
    maintainers
    style
    submitting-a-patch
+   llm-usage
    code-provenance
    trivial-patches
    stable-process
diff --git a/docs/devel/llm-usage.rst b/docs/devel/llm-usage.rst
new file mode 100644
index 00000000000..0b54f5dd383
--- /dev/null
+++ b/docs/devel/llm-usage.rst
@@ -0,0 +1,213 @@
+.. _llm-usage:
+
+Use of AI-generated content
+===========================
+
+.. warning::
+
+   Please read the below policy before using AI to contribute code or
+   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
+   Llama, and similar tools.
+
+This document provides guidance around acceptable practices
+for using `Large Language Models
+<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs)
+when contributing to QEMU.
+
+The QEMU project does not want to dictate what tools contributors
+use for their work on the project.  However, the increasing
+prevalence of AI-assisted software development and of LLMs specifically
+poses a number of difficult questions.  Risks to open source projects
+include maintainer burnout from an increased number of contributions, as
+well as the risk to the project from unintentional inclusion of copyrighted
+material in the LLM's output.
+
+In order to mitigate these risks, the QEMU project limits the way
+in which use of the output of generative AI can be included in
+contributions to QEMU.  The main guidelines for use of generative AI
+tools are as follows:
+
+- It's fine to use LLMs to answer questions, analyze, distill,
+  refine, check, suggest, review. Use of LLMs to *create* is limited.
+
+- If in doubt, disclose any use of AI tools other than simple code
+  completion and code review.
+
+- LLMs are allowed as a tool to write *better*, not *faster*.
+
+**For any kind of LLM usage, the expectation is that the human contributor
+shall be able to :ref:`understand and explain the changes
+  <write_a_meaningful_commit_message>`, the design choices, and the
+rationale behind them.**
+
+.. note:: **Use of AI does not remove the need for authors to comply
+          with all other requirements for contribution.**  In particular,
+          the ``Signed-off-by`` label in a patch submission is a statement
+          that the author takes responsibility for the entire contents of
+          the patch, certifying that their patch submission is made in
+          accordance with the rules of the :ref:`Developer's Certificate of
+          Origin (DCO) <dco>`.
+
+Prohibited use of AI
+''''''''''''''''''''
+
+The QEMU community is a collaboration between humans, not AI agent
+façades. The following items MUST be written by humans [1]_:
+
+- cover letters and commit messages
+
+- responses to reviewer comments
+
+- issue descriptions or comments
+
+Light copy editing of human-written text with an AI is allowed.
+
+Repeated violations of this rule may be treated as a :ref:`code_of_conduct`
+violation.
+
+An exception is made for defects detected by specialized tooling,
+including fuzzers and LLM-assisted defect detection. Such issues must
+be reviewed by a human before creation, must be created by a human and
+communication with maintainers must be done by a human, but including
+the verbatim tool output in the issue description is explicitly allowed.
+
+.. [1] Official project agents may be exempted from one or more of these
+       rules, at the discretion of the QEMU project maintainer(s).
+
+LLM-assisted and LLM-created contributions
+''''''''''''''''''''''''''''''''''''''''''
+
+Use of generative AI can be classified in the following four buckets:
+
+- "background" assistance, such as completion and code review.  This does
+  not need disclosure.
+
+- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
+  are allowed with disclosure.  Splitting a submission in multiple parts
+  is **not** a valid way to bypass this rule; repeated, frequent posting
+  of such fixes must follow the rule for full contributions.
+
+- use of LLMs to help generating parts of a larger patch---test cases,
+  adaptations of existing code, boilerplate code for a new API, a tool to
+  help performing mechanical changes, etc.  These are generally allowed;
+  disclosure is highly recommended for non-trivial, functional code.
+
+- large, heavily LLM-assisted contributions where LLMs write large parts
+  of functional code.  These are only allowed if *pre-arranged*,
+  *high-quality* and *well-tested*.
+
+The last case (*"LLM-created contribution"*) is the one that requires
+a more careful approach.  In particular:
+
+- "Pre-arranged" means that a maintainer has communicated ahead of time,
+  for example on `IRC or the QEMU mailing
+  list <https://www.qemu.org/contribute/>`__, that they are willing
+  to review an LLM-created contribution.
+
+- "High-quality" means that the contributor must apply the same judgment
+  that would be applied to other code changes.  Contributors must invest
+  substantial time reviewing their contributions, curating them, and
+  understanding them in depth.
+
+- "Well-tested" means the LLM-created contributions will be held to a
+  higher standard than human-created ones, because LLMs make it easier
+  to write tests.  There are no exceptions for "writing the tests seems
+  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>`__.
+
+.. note::
+    Pre-arrangement ensures maintainers have bandwidth for review before a
+    contributor invests effort in creating a large change.  This is not
+    a new concept in QEMU: maintainers have always encouraged early
+    alignment on mailing lists or IRC prior to major architecture or
+    subsystem refactoring.
+
+    Maintainers have freedom to determine what constitutes "high quality".
+    Because LLMs lower the cost of patch generation, maintainers may demand
+    significantly larger revisions than for purely human-written code.
+
+The QEMU project explicitly forbids using LLMs to do "clean room"
+reimplementation of existing code whose license is not compatible
+with the GNU General Public License, version 2 **or later**.
+
+.. _ai-used-for:
+
+Commit messages for AI-assisted changes
+'''''''''''''''''''''''''''''''''''''''
+
+In order to disclose your usage of AI/LLM tools, add an ``AI-used-for:``
+line before the :ref:`Signed-off-by <code-provenance>` line.  The trailer
+is both a reminder of your DCO obligations and a guide to reviewers.  The
+text is one or more of ``code``, ``tests``, ``docs``, ``research``, possibly
+followed by an explanation in parentheses:
+
+To be able to certify the provenance of AI/LLM-generated code that you submit
+to QEMU, you must follow the policies outlined in this document and in
+QEMU's ``AGENTS.md``.  **By using 'AI-used-for', a contributor both
+identifies areas of the patch that involved use of AI/LLM, and also
+attests that their usage of AI/LLMs was in compliance with the policies
+outlined in this document.**
+
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
+Do not include your prompts or summarize the conversation in the commit
+message or cover letter.  Extract any information that is relevant to the
+reviewer and include it in commit messages, cover letters or code comments.
+
+QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
+trailers to indicate AI usage.  In particular, do not specify the exact
+AI model or tool used to create the commit.
+
+Deterministic tooling (sed, coccinelle, formatters) is out of scope for
+the trailer, but should be mentioned in the commit message.
+
+Motivation
+''''''''''
+
+There is not a consensus within the QEMU project---and likely never will
+be---about when/how/where it is acceptable to use AI-based tools.  Many
+members of the QEMU project and community find value in AI; many others
+feel that its negative impact on society and the climate are severe enough
+that no use is acceptable.  Still others are working out their opinion.
+
+In accordance with Software Freedom Conservancy's recommendations:
+
+- the project seeks to both support those contributors who outright reject
+  generative AI systems, and to not shun those who choose to use them;
+
+- we consider QEMU's copyleft to be a viable approach to the unanswered
+  legal questions about AI-generated contributions and their copyright
+  status;
+
+- we encourage contributors not to overuse LLMs, and to *add* them to
+  their existing skills and tools instead of replacing them.
+
+A common source of grief for maintainers is the (often valid) impression
+that AI enables contributions without understanding the effort they take
+for those who process them.  Effectively, this shifts a major part of the
+burden from the contributors to the maintainers---the scarcest resource
+in any free software project, not just QEMU.  Pre-arrangement and the
+size limit for small contributions try to avoid putting extra demand
+on maintainers due to LLM-assisted work.
+
+
+Sources
+'''''''
+
+This policy was informed by:
+
+- `Recommendations When Using LLM-backed Generative AI Systems for
+  FOSS Contributions <https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html>`__
+
+- `Rust project LLM Usage Policy <https://forge.rust-lang.org/policies/llm-usage.html>`__
+
+- `GStreamer AGENTS.md file <https://gitlab.freedesktop.org/gstreamer/gstreamer/-/blob/d08375499c279/AGENTS.md>`__
+
diff --git a/AGENTS.md b/AGENTS.md
index 5e3fc071420..8f494ea8ae5 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -1,21 +1,37 @@
 # Agent Guidelines for the QEMU Project
 
-As an agent you MUST abide by the "Use of AI-generated content" policy
-in `docs/devel/code-provenance.rst` at all times.
+QEMU is a cross-platform emulator and virtualizer. Due to the complexity
+of the domain and codebase, and the interactions therein, the QEMU
+project relies extensively on the effort of **human reviewers**, which
+is **a scarce resource**.
 
-You are permitted to assist users only in the following scenarios:
+There are strictly-enforced rules for you, the agent, to participate in the
+project.
 
-- researching APIs or algorithms
-- static analysis
-- debugging
-- local experiments not intended to be upstreamed
-- trivial non-copyrightable changes
+## Helping the human to respect project policy
 
-However agent output can not be included in any upstream
-contributions. If a request falls outside these permitted categories
-(e.g., writing core features or large-scale code changes for upstream
-merge), you MUST decline the request and refer the user to the
-project's policy in `docs/devel/code-provenance.rst`.
+QEMU's policy for AI-assisted work requires the human to develop in-depth
+familiarity with contributions and disclose use of agents to write parts
+of the code.
+
+Background assistance such as review or explanation does not require disclosure.
+Read `docs/devel/llm-usage.rst` before generating code, tests, or documentation
+intended for contribution; committing agent-generated material; or advising on
+disclosure or pre-arrangement. It is not required for review, explanation, or
+other background assistance that produces no contribution content.
+
+When agent-generated content is included in a contribution, remind the human
+to determine the appropriate disclosure under `docs/devel/llm-usage.rst`.
+In particular, contributions where you write large parts of the functional
+code may only be submitted if a maintainer has agreed **beforehand** to review
+them.  Tell the human about this as soon as the work looks likely to grow to
+that size, well before the patches are written.
+
+If you commit agent-generated material, include an `AI-used-for:` trailer
+before `Signed-off-by`. Do not omit it by folding the material into a larger
+commit.  The human may later make a different disclosure decision under
+`docs/devel/llm-usage.rst`, after independently reworking and integrating
+the material.
 
 ## Security Policy
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9838a641785..d881cf29375 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1829,8 +1829,9 @@ sub process {
 		      $1 =~ /\bcopilot\b | \bchatgpt\b | \bcodex\b | \bcursor\b |
 			     \bgemini\b | \bllama\b | \bnoreply\b | \[bot\] |
 			     \bclaude\b.*(?:opus|sonnet|fable|haiku|anthropic\.com)/xi))) {
-			ERROR("QEMU does not allow using AI for contributions, " .
-				"see docs/devel/code-provenance.rst\n" . $herecurr);
+			ERROR("do not use \"$line\" to credit an AI agent, " .
+				"use the \"AI-used-for\" trailer instead; " .
+				"see docs/devel/llm-usage.rst\n" . $herecurr);
 		}
 
 # Check for duplicate trailers and self-review
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92096C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1R8U-0002fb-MP; Tue, 01 Sep 2026 12:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1R8T-0002fO-LV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1R8P-0004IT-UR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788279289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPrJGP9pfx0y1hwJvOt4RAFyX5IMNHSQvpfMevVPjAk=;
 b=VO6PTj55b867hMZjI6IjJyMKmZGFA3WMh1KjBmMnltNLdHgmwhA4ly74ToyCf0k6zdwXje
 fFoK3jKJIRhgwe0qwzX0okTxqlc22fsXjgT4O+RlQR8MjW/Uay7VDSbDZA3v8cERwIWYQV
 uBQzlaa3RoabFk+jGisbH8xzBuoGHn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-N1KHnPacM2SflrPEoLoH5A-1; Tue, 01 Sept 2026 12:14:34 -0400
X-MC-Unique: N1KHnPacM2SflrPEoLoH5A-1
X-Mimecast-MFC-AGG-ID: N1KHnPacM2SflrPEoLoH5A_1788279270
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49991beee7aso46006045e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788279270; x=1788884070; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HPrJGP9pfx0y1hwJvOt4RAFyX5IMNHSQvpfMevVPjAk=;
 b=YYfcGdQ8dkbJ/eZfW1sf23DHTT6u3bajhPq4Lpr4okEQiw+4TbSkV6cdVmKcWaks7p
 rNDDqa6AcuYiSVXFAr2MaIoWtrcTQ0ggguOY7irhnWW6oyShQW7uRyncXRKSJCtZj0ap
 Ml5JrCT8lfZVjgwrHrRJFIO5a+EDTTxxWdVzJ2nFsDW6Ueo+majaATeUC059roiVpsmy
 d0TLT5af20r45SiPxht9EW9nGkZtjD/t4sVD6M8ICa+JgGqv2vho23v4ohD8P2DDD2nC
 eFpBX/EETcUYpGJeFkBNeiBB/Yw0o7cNXdsvQSUI0XS0hLggKHVNgRitXYG1XzXI7v9l
 IEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788279270; x=1788884070;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HPrJGP9pfx0y1hwJvOt4RAFyX5IMNHSQvpfMevVPjAk=;
 b=B5FeNLd2LeVz+Ftba5TwwTdgVpXQxT/C4UHIOLKj9xDMctQmlBAVQtx+YeBIwcmjBL
 lnj5GwXWUAFYqp5a+eYr/RBB5YisA35RwCt4xmnw3uDCy8cvnzUhQthzUVOnyOPk6yLW
 dQeKEAy3MLX6SYfnSypkZohclk+mSRI53hBZYx/2q7pyB33KD/BPFIyDIJzeQU1f+yn/
 nUSdS7zbNWrOFCnZT7KpfvKE0faFliuLsK65y+Mdr2XME9iTcAnB4974noCJ5pGoNLYu
 zDorWmdkW+OBWEjFuNWVxoDDICt9opmrDv53KNmlif73M9nE4Bq/v51+7VLWqrCjaI3W
 lmnQ==
X-Gm-Message-State: AFuF++mika3mwEZlTrqmfn0uNJ+4ukTcsFXcUmefG30tJwdUpTjxMHpl
 gI7tNAKYVkcL8glcUxdzvRBpgNeLpT3WScW+IiYqUE5Zz0RVopemG6v/5jSOrGSJuxOorTCRF6w
 z2PrjvjPhI6RA1Il6k+W0yEjFOGdrrImy6nExyO49Qz/KOWyznAaKGDRxCmoMXzF2GHmrgc2B5g
 QZgb7mGJ4DYkXbKGjxb8CBBcr9bxqJEbHnmvU2J4tu
X-Gm-Gg: AYBFou1XFQBzYuDx9882vcVfsMszioWynCknZbOofhr8xt0X7jiWFL0nedg7wrbyvjE
 QeDwRtZtZi4ir9zlwweH7UqlTtago3SrhLg5bJxkm0wRniicRe5xe2r9+Y3wX1dKpGNY26fWPkq
 TD3brXN3JK96BuM2T+kHTLra/0w6v2+Tcpob9E7b7Sq7drmclXg9M1BBeXrihWHn1KOb4mPpAXx
 mtTPXNn+MwTOxdkVa64ELPDdsl90BXrslCxmcpYpQF5vqGnL1cz7dUYPFAS05myz1BzPZsecFoq
 6UndoqqXgj6UosQFlxLu/N096HQ+UozN7QszZ4SITKN/4p2AmhwyqoUdYCWHQdfqZwlgtqWrBoG
 Rxx/H5sJGHhrprOITjZOVJSCTjADakp/uI+e8PiZiQ8qlEYCC6SQuNQF92IOzUNvJL3Y+tYcoKm
 qA4u4=
X-Received: by 2002:a05:6000:2284:b0:482:eabd:642c with SMTP id
 ffacd0b85a97d-48440fcd986mr16885822f8f.1.1788279269634; 
 Tue, 01 Sep 2026 09:14:29 -0700 (PDT)
X-Received: by 2002:a05:6000:2284:b0:482:eabd:642c with SMTP id
 ffacd0b85a97d-48440fcd986mr16885681f8f.1.1788279269071; 
 Tue, 01 Sep 2026 09:14:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3716sm20178f8f.22.2026.09.01.09.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:14:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/4] docs/devel: introduce a new policy on AI-generated
 contributions
Date: Tue,  1 Sep 2026 18:14:19 +0200
Message-ID: <20260901161422.314581-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901161422.314581-1-pbonzini@redhat.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Conservancy in particular provides this point to alleviate the concern
that motivated the policy, about whether the submitter has the legal
right to contribute the code and about unintentional reproduction of
copyrighted code:

   "Copyleft Everything" remains the best viable and safest approach
   Certainly those who want to release FOSS under non-copyleft licenses
   have more to worry about when using these tools.

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
the metadata to provide more information for reviewers to judge the result.

In any case, use of AI does not relax any other contribution requirement:
authors still comply with the DCO and take responsibility for the whole
patch via Signed-off-by.

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
Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst |  71 ++-----------
 docs/devel/index-process.rst   |   1 +
 docs/devel/llm-usage.rst       | 183 +++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 65 deletions(-)
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
index 00000000000..a62b24d0292
--- /dev/null
+++ b/docs/devel/llm-usage.rst
@@ -0,0 +1,183 @@
+.. _llm-usage:
+
+AI-generated content
+====================
+
+.. warning::
+
+   Please read the below policy before using AI to contribute code or
+   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
+   Llama, and similar tools.
+
+The QEMU project does not want to introduce restrictions on the tools
+that contributors use for their work on the project.  However,
+the increasing prevalence of AI-assisted software development,
+and especially the use of content generated by `Large Language Models
+<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs),
+poses a number of difficult questions.
+
+Risks to open source projects include maintainer burnout from an
+increased number of contributions, as well as the risk to the project
+from unintentional inclusion of copyrighted material in the LLM's output.
+In order to mitigate these risks, the QEMU project limits the way
+in which use of the output of generative AI can be included
+in contributions to QEMU.
+
+The main guidelines for use of generative AI tools are roughly
+as follows:
+
+- It's fine to use LLMs to answer questions, analyze, distill,
+  refine, check, suggest, review. Use of LLMs to *create* is limited.
+
+- If in doubt, disclose any use of AI tools other than simple code
+  completion and code review.
+
+- LLMs are allowed as a tool to write *better*, not *faster*.
+
+.. note:: **Use of AI does not remove the need for authors to comply
+          with all other requirements for contribution.**  In particular,
+          the ``Signed-off-by`` label in a patch submission is a statement
+          that the author takes responsibility for the entire contents of
+          the patch, certifying that their patch submission is made in
+          accordance with the rules of the `Developer's Certificate of
+          Origin (DCO) <dco>`.
+
+Prohibited use of AI
+''''''''''''''''''''
+
+The following items **MUST** be written by humans:
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
+An exception is made for issues for defects detected by specialized
+tooling, including fuzzers and LLM-assisted defect detection. Such issues
+must be reviewed by a human before creation, must be created by a human
+and communication with maintainers must be done by a human, but including
+the verbatim tool output in the issue description is explicitly allowed.
+
+LLM-assisted and LLM-created contributions
+''''''''''''''''''''''''''''''''''''''''''
+
+Use of generative AI tools for code contributions generally falls into
+four buckets:
+
+- "background" assistance, such as completion and code review.  This does
+  not need disclosure, however you are expected to examine and understand
+  any code or any changes produced by the tool.
+
+- small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
+  are allowed with disclosure.  Splitting a submission in multiple parts
+  is **not** a valid way to bypass this rule; repeated, frequent posting
+  of such fixes must follow the rule for full contributions.
+
+- use of LLMs to help generating parts of a larger patch---a test case, a
+  parser, boilerplate code for a new API, a tool to help performing
+  mechanical changes, etc. These are generally allowed, but disclosure
+  is recommended.
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
+  understanding them in depth; in particular, you are still expected to
+  :ref:`understand and explain your changes
+  <write_a_meaningful_commit_message>` and the rationale behind them.
+
+- "Well-tested" means the LLM-created contributions will be held to a
+  higher standard than human-created ones, because LLMs make it easier
+  to write tests.  There are no exceptions for "writing the tests seems
+  hard" or for `yak shaving <https://en.wiktionary.org/wiki/yak_shaving>`__.
+
+Commit messages for AI-assisted changes
+'''''''''''''''''''''''''''''''''''''''
+
+In order to disclose your usage of AI/LLM tools, add an ``AI-used-for:``
+line before the :ref:`Signed-off-by <code-provenance>` line.  The trailer
+satisfies your disclosure obligations and is also a guide to reviewers.  The
+text is one or more of ``code``, ``tests``, ``docs``, ``analysis``, possibly
+followed by an explanation in parentheses:
+
+.. code-block:: none
+
+     AI-used-for: tests, docs
+     AI-used-for: code
+     AI-used-for: code (refactoring)
+     AI-used-for: code (prototype)
+     AI-used-for: analysis
+
+``AI-used-for`` should not be included for "background" usage such as
+autocomplete or obtaining a pre-review of the patch.  It can be included
+however even if not required by the policy.
+
+There is no requirement to include your prompts or summarize the
+conversation in the commit message or cover letter.
+
+QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
+trailers to indicate AI usage.  In particular, it is not necessary to
+specify the exact AI model or tool used to create the commit.
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
+- we encourage contributors not to overuse AI, and to *add* LLMs to
+  their existing skills and tools instead of replacing them.
+
+A common source of grief for maintainers is the (often valid) impression
+that AI enables contributions without understanding the effort they take
+for those who process them.  Effectively, this shifts a major part of the
+burden from the contributors to the maintainers---the scarcest resource
+in any free software project, not just QEMU.  Pre-arrangement, and the
+size limit for small contributions, try to avoid putting extra demand
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
-- 
2.55.0



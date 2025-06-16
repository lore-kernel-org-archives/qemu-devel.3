Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253D1C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR64B-0001W8-Sl; Mon, 16 Jun 2025 05:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR63N-0000P1-Am
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR63J-0005Je-LO
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750065772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/57mASegoW8S7VeTMnJN+Cb99ND64Q2D44UkawBVIvY=;
 b=DhR1HIXaFPxcXHW9YdYgVi/dpfyRzYbeGyw8ryUhJNdAvJsndhEiqNPyBmBUEf8Hc4fP+F
 0hNysyCXLlb+hnHcnkZJS5v+n0pMXTXU2wB9z/1hlyqyAad/X984jCz4xUUYDcN99qxMsC
 s8dcRutqGNOMSJwgtbkOLxTAQ270Lbs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-nyvLT8HWNpupm0VGxNkk_Q-1; Mon,
 16 Jun 2025 05:22:49 -0400
X-MC-Unique: nyvLT8HWNpupm0VGxNkk_Q-1
X-Mimecast-MFC-AGG-ID: nyvLT8HWNpupm0VGxNkk_Q_1750065767
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B05818011CD; Mon, 16 Jun 2025 09:22:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7686C195608D; Mon, 16 Jun 2025 09:22:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D3BA921E6935; Mon, 16 Jun 2025 11:22:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
Date: Mon, 16 Jun 2025 11:22:41 +0200
Message-ID: <20250616092241.212898-4-armbru@redhat.com>
In-Reply-To: <20250616092241.212898-1-armbru@redhat.com>
References: <20250616092241.212898-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

There has been an explosion of interest in so called AI code
generators. Thus far though, this is has not been matched by a broadly
accepted legal interpretation of the licensing implications for code
generator outputs. While the vendors may claim there is no problem and
a free choice of license is possible, they have an inherent conflict
of interest in promoting this interpretation. More broadly there is,
as yet, no broad consensus on the licensing implications of code
generators trained on inputs under a wide variety of licenses

The DCO requires contributors to assert they have the right to
contribute under the designated project license. Given the lack of
consensus on the licensing of AI code generator output, it is not
considered credible to assert compliance with the DCO clause (b) or (c)
where a patch includes such generated code.

This patch thus defines a policy that the QEMU project will currently
not accept contributions where use of AI code generators is either
known, or suspected.

These are early days of AI-assisted software development. The legal
questions will be resolved eventually. The tools will mature, and we
can expect some to become safely usable in free software projects.
The policy we set now must be for today, and be open to revision. It's
best to start strict and safe, then relax.

Meanwhile requests for exceptions can also be considered on a case by
case basis.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/code-provenance.rst | 55 +++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index c25afed98d..b5aae2e253 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -282,4 +282,57 @@ boilerplate code template which is then filled in to produce the final patch.
 The output of such a tool would still be considered the "preferred format",
 since it is intended to be a foundation for further human authored changes.
 Such tools are acceptable to use, provided there is clearly defined copyright
-and licensing for their output.
+and licensing for their output. Note in particular the caveats applying to AI
+content generators below.
+
+Use of AI content generators
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+TL;DR:
+
+  **Current QEMU project policy is to DECLINE any contributions which are
+  believed to include or derive from AI generated content. This includes
+  ChatGPT, Claude, Copilot, Llama and similar tools.**
+
+The increasing prevalence of AI-assisted software development results in a
+number of difficult legal questions and risks for software projects, including
+QEMU.  Of particular concern is content generated by `Large Language Models
+<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
+
+The QEMU community requires that contributors certify their patch submissions
+are made in accordance with the rules of the `Developer's Certificate of
+Origin (DCO) <dco>`.
+
+To satisfy the DCO, the patch contributor has to fully understand the
+copyright and license status of content they are contributing to QEMU. With AI
+content generators, the copyright and license status of the output is
+ill-defined with no generally accepted, settled legal foundation.
+
+Where the training material is known, it is common for it to include large
+volumes of material under restrictive licensing/copyright terms. Even where
+the training material is all known to be under open source licenses, it is
+likely to be under a variety of terms, not all of which will be compatible
+with QEMU's licensing requirements.
+
+How contributors could comply with DCO terms (b) or (c) for the output of AI
+content generators commonly available today is unclear.  The QEMU project is
+not willing or able to accept the legal risks of non-compliance.
+
+The QEMU project thus requires that contributors refrain from using AI content
+generators on patches intended to be submitted to the project, and will
+decline any contribution if use of AI is either known or suspected.
+
+This policy does not apply to other uses of AI, such as researching APIs or
+algorithms, static analysis, or debugging, provided their output is not to be
+included in contributions.
+
+Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
+ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
+generation agents which are built on top of such tools.
+
+This policy may evolve as AI tools mature and the legal situation is
+clarifed. In the meanwhile, requests for exceptions to this policy will be
+evaluated by the QEMU project on a case by case basis. To be granted an
+exception, a contributor will need to demonstrate clarity of the license and
+copyright status for the tool's output in relation to its training model and
+code, to the satisfaction of the project maintainers.
-- 
2.49.0



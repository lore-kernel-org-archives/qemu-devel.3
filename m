Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46050C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 16:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dsX-0006jM-W6; Thu, 16 May 2024 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7dsX-0006hv-2I
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7dsV-0003Sw-3x
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715876566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1C+gYHY5xRdM1uOHBiUTpGYQJD1JzjbNMz0faHcDRw=;
 b=hvDjeGiDZVpzv3h/0l81frKULnFVNuOyGC0UjGZTHoZxDE5u69LoRDwb2K4adq5+hgP9Ii
 z7eQNC6Q76TPBP7a9wJ16+kF+paolPeYm2AG44gdc5LGQ5dFwe3QbVK4t/UGRvzKlWGkvj
 PeQUmA2LfL78qLAKlCKy7dnUW3Eg3qg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-bqbi--ZkM2e9rxpcFGKAnw-1; Thu, 16 May 2024 12:22:44 -0400
X-MC-Unique: bqbi--ZkM2e9rxpcFGKAnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C40AA8025F9;
 Thu, 16 May 2024 16:22:43 +0000 (UTC)
Received: from toolbox.default.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EBC7C15BB9;
 Thu, 16 May 2024 16:22:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 3/3] docs: define policy forbidding use of AI code
 generators
Date: Thu, 16 May 2024 17:22:30 +0100
Message-ID: <20240516162230.937047-4-berrange@redhat.com>
In-Reply-To: <20240516162230.937047-1-berrange@redhat.com>
References: <20240516162230.937047-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There has been an explosion of interest in so called AI code generators
in the past year or two. Thus far though, this is has not been matched
by a broadly accepted legal interpretation of the licensing implications
for code generator outputs. While the vendors may claim there is no
problem and a free choice of license is possible, they have an inherent
conflict of interest in promoting this interpretation. More broadly
there is, as yet, no broad consensus on the licensing implications of
code generators trained on inputs under a wide variety of licenses

The DCO requires contributors to assert they have the right to
contribute under the designated project license. Given the lack of
consensus on the licensing of AI code generator output, it is not
considered credible to assert compliance with the DCO clause (b) or (c)
where a patch includes such generated code.

This patch thus defines a policy that the QEMU project will currently
not accept contributions where use of AI code generators is either
known, or suspected.

This merely reflects the current uncertainty of the field, and should
this situation change, the policy is of course subject to future
relaxation. Meanwhile requests for exceptions can also be considered on
a case by case basis.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/code-provenance.rst | 50 +++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index eabb3e7c08..846dda9a35 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -264,4 +264,52 @@ boilerplate code template which is then filled in to produce the final patch.
 The output of such a tool would still be considered the "preferred format",
 since it is intended to be a foundation for further human authored changes.
 Such tools are acceptable to use, provided they follow a deterministic process
-and there is clearly defined copyright and licensing for their output.
+and there is clearly defined copyright and licensing for their output. Note
+in particular the caveats applying to AI code generators below.
+
+Use of AI code generators
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+TL;DR:
+
+  **Current QEMU project policy is to DECLINE any contributions which are
+  believed to include or derive from AI generated code. This includes ChatGPT,
+  CoPilot, Llama and similar tools**
+
+The increasing prevalence of AI code generators, most notably but not limited
+to, `Large Language Models <https://en.wikipedia.org/wiki/Large_language_model>`__
+(LLMs) results in a number of difficult legal questions and risks for software
+projects, including QEMU.
+
+The QEMU community requires that contributors certify their patch submissions
+are made in accordance with the rules of the :ref:`dco` (DCO).
+
+To satisfy the DCO, the patch contributor has to fully understand the
+copyright and license status of code they are contributing to QEMU. With AI
+code generators, the copyright and license status of the output is ill-defined
+with no generally accepted, settled legal foundation.
+
+Where the training material is known, it is common for it to include large
+volumes of material under restrictive licensing/copyright terms. Even where
+the training material is all known to be under open source licenses, it is
+likely to be under a variety of terms, not all of which will be compatible
+with QEMU's licensing requirements.
+
+With this in mind, the QEMU project does not consider it is currently possible
+for contributors to comply with DCO terms (b) or (c) for the output of commonly
+available AI code generators.
+
+The QEMU maintainers thus require that contributors refrain from using AI code
+generators on patches intended to be submitted to the project, and will
+decline any contribution if use of AI is either known or suspected.
+
+Examples of tools impacted by this policy includes both GitHub's CoPilot,
+OpenAI's ChatGPT, and Meta's Code Llama, amongst many others which are less
+well known.
+
+This policy may evolve as the legal situation is clarifed. In the meanwhile,
+requests for exceptions to this policy will be evaluated by the QEMU project
+on a case by case basis. To be granted an exception, a contributor will need
+to demonstrate clarity of the license and copyright status for the tool's
+output in relation to its training model and code, to the satisfaction of the
+project maintainers.
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D452C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 16:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dsQ-0006ax-De; Thu, 16 May 2024 12:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7dsO-0006aa-3i
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7dsL-0003S7-TE
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715876556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=L5J0C1ThYfOtcYO7q6CQwkSmdanhwy1mpqOgsPsFukg=;
 b=MyRgzM70xA6D55h/4Nrx2rTSXdvGKRfydq1eymfmbe/LHT+hRL6DJMn1yTLdspr7rz/Wu3
 apdevYcqGJlYJz4tIYdEuuHTCOM3VQ6UQvhlRVr3vHMr/LScWK0inGDu1oHbQ3BEPetC3R
 6GjgZwlxWL9/ng0JQteW91HGTjBsnyQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-OPLUFGU6OrKe7lsjdk8XBQ-1; Thu,
 16 May 2024 12:22:34 -0400
X-MC-Unique: OPLUFGU6OrKe7lsjdk8XBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CB8229ABA14;
 Thu, 16 May 2024 16:22:34 +0000 (UTC)
Received: from toolbox.default.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13666C15BB1;
 Thu, 16 May 2024 16:22:30 +0000 (UTC)
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
Subject: [PATCH v2 0/3] docs: define policy forbidding use of "AI" / LLM code
 generators
Date: Thu, 16 May 2024 17:22:27 +0100
Message-ID: <20240516162230.937047-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

This patch kicks the hornet's nest of AI / LLM code generators.

With the increasing interest in code generators in recent times,
it is inevitable that QEMU contributions will include AI generated
code. Thus far we have remained silent on the matter. Given that
everyone knows these tools exist, our current position has to be
considered tacit acceptance of the use of AI generated code in QEMU.

The question for the project is whether that is a good position for
QEMU to take or not ?

IANAL, but I like to think I'm reasonably proficient at understanding
open source licensing. I am not inherantly against the use of AI tools,
rather I am anti-risk. I also want to see OSS licenses respected and
complied with.

AFAICT at its current state of (im)maturity the question of licensing
of AI code generator output does not have a broadly accepted / settled
legal position. This is an inherant bias/self-interest from the vendors
promoting their usage, who tend to minimize/dismiss the legal questions.
From my POV, this puts such tools in a position of elevated legal risk.

Given the fuzziness over the legal position of generated code from
such tools, I don't consider it credible (today) for a contributor
to assert compliance with the DCO terms (b) or (c) (which is a stated
pre-requisite for QEMU accepting patches) when a patch includes (or is
derived from) AI generated code.

By implication, I think that QEMU must (for now) explicitly decline
to (knowingly) accept AI generated code.

Perhaps a few years down the line the legal uncertainty will have
reduced and we can re-evaluate this policy.

Discuss...

Changes in v2:

 * Fix a huge number of typos in docs
 * Clarify that maintainers should still add R-b where relevant, even
   if they are already adding their own S-oB.
 * Clarify situation when contributor re-starts previously abandoned
   work from another contributor.
 * Add info about Suggested-by tag
 * Add new docs section dealing with the broad topic of "generated
   files" (whether code generators or compilers)
 * Simplify the section related to prohibition of AI generated files
   and give further examples of tools considered covered
 * Remove repeated references to "LLM" as a specific technology, just
   use the broad "AI" term, except for one use of LLM as an example.
 * Add note that the policy may evolve if the legal clarity improves
 * Add note that exceptions can be requested on case-by-case basis
   if contributor thinks they can demonstrate a credible copyright
   and licensing status

Daniel P. Berrangé (3):
  docs: introduce dedicated page about code provenance / sign-off
  docs: define policy limiting the inclusion of generated files
  docs: define policy forbidding use of AI code generators

 docs/devel/code-provenance.rst    | 315 ++++++++++++++++++++++++++++++
 docs/devel/index-process.rst      |   1 +
 docs/devel/submitting-a-patch.rst |  19 +-
 3 files changed, 318 insertions(+), 17 deletions(-)
 create mode 100644 docs/devel/code-provenance.rst

-- 
2.43.0



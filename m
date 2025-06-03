Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E15C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSaQ-0003ZN-6o; Tue, 03 Jun 2025 10:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMSaF-0003XC-9H
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMSa7-0000Ny-Ej
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748960732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=llgVyl0Kx5EPUna3puzFFBYP4y3N/MXdcf5rcXVuf0Y=;
 b=VJO3FWXfewwT3UFNpWxy60MftJIf/mkhidOoxXPJusEtJg2nL+EI0xwPeJkXjrJb0zucnb
 yuwKjZcSItKRTlB4Dj8CKs1YjEF+KPSx5LZscBfq79ing4ROP2iG0USb+hQz33RWkmPxpD
 b9SNUgjC18ZlS6hxEaLeVbjQ4C3qHao=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-3NyI4WX1N3qozw7ubQ8-NA-1; Tue,
 03 Jun 2025 10:25:29 -0400
X-MC-Unique: 3NyI4WX1N3qozw7ubQ8-NA-1
X-Mimecast-MFC-AGG-ID: 3NyI4WX1N3qozw7ubQ8-NA_1748960728
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 120171956089; Tue,  3 Jun 2025 14:25:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55F0118008E0; Tue,  3 Jun 2025 14:25:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3810721E6766; Tue, 03 Jun 2025 16:25:24 +0200 (CEST)
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
Subject: [PATCH v3 0/3] docs: define policy forbidding use of "AI" / LLM code
 generators
Date: Tue,  3 Jun 2025 16:25:21 +0200
Message-ID: <20250603142524.4043193-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

More than a year ago, Daniel posted patches to put an AI policy in
writing.  Reception was mostly positive.  A v2 to address feedback
followed with some delay.  But no pull request.

I asked Daniel why, and he told me he was concerned it might go too
far in its interpretation of the DCO requirements.  After a bit of
discussion, I think Daniel's text is basically fine.  The policy it
describes is simple and strict.  Relaxing policy is easier than
tightening it.  I softened the phrasing slightly, addressed open
review comments, and fixed a few minor things I found myself.

Here's Daniel's cover letter for v2:

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
>From my POV, this puts such tools in a position of elevated legal risk.

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

Changes in v3 [Markus Armbruster]:

 * PATCH 1:
   - Require "known identify" (phrasing stolen from Linux kernel docs)
     [Peter]
   - Clarify use of multiple addresses [Michael]
   - Improve markup
   - Fix a few misspellings
   - Left for later: explain our use of Message-Id: [Alex]
 * PATCH 2:
   - Minor phrasing tweaks and spelling fixes
 * PATCH 3:
   - Don't claim DCO compliance is currently impossible, do point out
     it's unclear how, and that we consider the legal risk not
     acceptable.
   - Stress that the policy is open to revision some more by adding
     "as AI tools mature".  Also rephrase the commit message.
   - Improve markup

Changes in v2 [Daniel Berrangé]:

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

 docs/devel/code-provenance.rst    | 321 ++++++++++++++++++++++++++++++
 docs/devel/index-process.rst      |   1 +
 docs/devel/submitting-a-patch.rst |  18 +-
 3 files changed, 324 insertions(+), 16 deletions(-)
 create mode 100644 docs/devel/code-provenance.rst

-- 
2.48.1



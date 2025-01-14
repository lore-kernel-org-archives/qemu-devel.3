Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF04E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm8a-0005l3-61; Tue, 14 Jan 2025 13:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm7w-0005fB-3x
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm7s-0002kz-0s
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LjkcALWsmwNZ+t7yShQ1IgXLlfUBifJ92w5M4rLPriE=;
 b=XzsSVmTe7ZivfkOlBORfLAdK7IH0RTohL8xXqJ3zZzsTepiAVS0Ppz/C12zmPpm+2zpumA
 d1HPFSQlGbHs5bTdUQLjlZf9Ll1fv06aIzfMc6XxYM4y1K1CquCjRB34vr5j2L9EHATKDN
 k0RlAQlpjjsPzjB5qrNBa1SLX7XUP9k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-8xcd9HopNbql87BfOEESoQ-1; Tue,
 14 Jan 2025 13:58:45 -0500
X-MC-Unique: 8xcd9HopNbql87BfOEESoQ-1
X-Mimecast-MFC-AGG-ID: 8xcd9HopNbql87BfOEESoQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A0D119560B2; Tue, 14 Jan 2025 18:58:43 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC20C19560A3; Tue, 14 Jan 2025 18:58:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 00/23] docs: add basic sphinx-domain rST generator to
 qapidoc
Date: Tue, 14 Jan 2025 13:58:17 -0500
Message-ID: <20250114185840.3058525-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

based-on: https://patchew.org/QEMU/20241213011307.2942030-1-jsnow@redhat.co=
m/=0D
=0D
Hi!=0D
=0D
This series is a very, very barebones implementation for the new QAPI=0D
doc generator. It does not have many features that I presented on at KVM=0D
Forum; the point of this patch set is instead to present a stripped down=0D
basis for ongoing work so we can discuss on-list with full context of=0D
the code available to do so.=0D
=0D
The documentation this series generates is *not suitable* for replacing=0D
the current document generator, it has a few glaring omissions - on=0D
purpose - those features have been factored out intentionally so they=0D
can be reviewed with fuller context and more careful review.=0D
=0D
What this series does:=0D
=0D
- Adds the new "Transmogrifier" rST generator to qapidoc.py, which=0D
  generates an in-memory rST document using qapi-domain directives.  -=0D
  Adds a test document that showcases this new transmogrifier. (located=0D
  at build/docs/manual/qapi/index.html; also visible at the bottom of=0D
  the left column TOC on generated docs.)=0D
=0D
What this series currently *regresses* /if/ it were to replace the=0D
current doc generator:=0D
=0D
- "ifcond" data for anything other than top-level entities is not=0D
  considered or rendered. This means "if" statements for features and=0D
  members are entirely absent. This includes "special features" that=0D
  have been hoisted into the preamble as well, such as :unstable: or=0D
  :deprecated:. This issue is largely unaddressed in my WIP so far,=0D
  I need to solve this in future patch discussion.=0D
=0D
- *branches* are themselves not considered at all; they're skipped=0D
   entirely for now. They will be included alongside the inliner later.=0D
=0D
- "inherited" members (Markus hates that I use this term, I'm sorry, I=0D
  know it isn't 1:1 with OO inheritance I just don't have a nicer word=0D
  that my brain remembers, forgive me) are skipped; "The members of ..."=0D
  messages are not rendered either. This is addressed by the inliner.=0D
=0D
- Undocumented members are not auto-generated.=0D
=0D
Other things unhandled, but are not regressions per se:=0D
=0D
- The inliner is not present at all. This series renders only=0D
  documentation exactly as it is exists in the source files.=0D
=0D
- Undocumented return types are not autogenerated.=0D
=0D
- Pseudofeatures (Things like allow-oob) are not generated as documented=0D
  features.=0D
=0D
- Documentation culling: all entities are documented whether or not=0D
  they're relevant to the wire format.=0D
=0D
Everything else *should* be no worse off than it was, and in many cases=0D
better.=0D
=0D
My current goal is to tentatively agree that these patches look good=0D
(save for some minor nits like terminology/comments/docs/commit nits),=0D
then to send an updated version of this series with additional commits=0D
that start addressing the regressions and adding the new features like=0D
the inliner.=0D
=0D
Once the new generator as a whole looks good, I will shift focus back to=0D
review on the qapi-domain extension itself. The reason for doing the=0D
review in reverse order is because the design of the generator informs=0D
the design of the domain, but reviewers are currently more familiar with=0D
the generator - so we're doing the review backwards. Treat it as a=0D
magical black box for now that somehow magically transforms rST into=0D
pretty docs.=0D
=0D
V2:=0D
 - Mostly adjusted commit messages and comments per list feedback=0D
 - Changed "tag" to "kind" and adjusted code, comments and commits=0D
   accordingly=0D
 - removed assertion around special features + conditionals, for now=0D
=0D
John Snow (23):=0D
  docs/qapidoc: support header-less freeform sections=0D
  qapi/parser: adjust info location for doc body section=0D
  docs/qapidoc: remove example section support=0D
  qapi: expand tags to all doc sections=0D
  qapi/schema: add __repr__ to QAPIDoc.Section=0D
  docs/qapidoc: add transmogrifier stub=0D
  docs/qapidoc: add transmogrifier class stub=0D
  docs/qapidoc: add visit_module() method=0D
  qapi/source: allow multi-line QAPISourceInfo advancing=0D
  docs/qapidoc: add visit_freeform() method=0D
  docs/qapidoc: add preamble() method=0D
  docs/qapidoc: add visit_paragraph() method=0D
  docs/qapidoc: add visit_errors() method=0D
  docs/qapidoc: add format_type() method=0D
  docs/qapidoc: add add_field() and generate_field() helper methods=0D
  docs/qapidoc: add visit_feature() method=0D
  docs/qapidoc: prepare to record entity being transmogrified=0D
  docs/qapidoc: add visit_returns() method=0D
  docs/qapidoc: add visit_member() method=0D
  docs/qapidoc: add visit_sections() method=0D
  docs/qapidoc: add visit_entity()=0D
  docs/qapidoc: implement transmogrify() method=0D
  docs/qapidoc: add transmogrifier test document=0D
=0D
 docs/index.rst                 |   1 +=0D
 docs/qapi/index.rst            |  53 +++++=0D
 docs/sphinx/qapidoc.py         | 418 ++++++++++++++++++++++++++++++---=0D
 scripts/qapi/parser.py         | 118 +++++++---=0D
 scripts/qapi/source.py         |   4 +-=0D
 tests/qapi-schema/doc-good.out |  10 +-=0D
 tests/qapi-schema/test-qapi.py |   2 +-=0D
 7 files changed, 541 insertions(+), 65 deletions(-)=0D
 create mode 100644 docs/qapi/index.rst=0D
=0D
-- =0D
2.47.1=0D
=0D



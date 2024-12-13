Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4A4E77182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 02:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLvGm-0006SN-T1; Thu, 12 Dec 2024 21:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvGk-0006Qx-Cm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvGd-0007sS-JI
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734056337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=usIhsdTlnYV78OFK2JxoJV0XhuDWm4nGuA4M+ywKzec=;
 b=TnfCf9QYwJu3CHeAR1T1YjGzAvac52vs9FOMJUqGNxWBogbri5fkoexc319A+VoSLdZjJL
 wQcM5O+pNFVCVjCi9LHaAzKxb+QyrIbi7h3hkohJF6T7/zDCGm+WPCXmyvgjL6GpXZnWTR
 8Ai3jUiuzTvG4QYfUmLg9EpXDW74lto=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-VRbnmKdwOvCssuXgduLZrA-1; Thu,
 12 Dec 2024 21:18:51 -0500
X-MC-Unique: VRbnmKdwOvCssuXgduLZrA-1
X-Mimecast-MFC-AGG-ID: VRbnmKdwOvCssuXgduLZrA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67CCA19560A3; Fri, 13 Dec 2024 02:18:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD8AC195605A; Fri, 13 Dec 2024 02:18:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 00/23] docs: add basic sphinx-domain rST generator to qapidoc
Date: Thu, 12 Dec 2024 21:18:03 -0500
Message-ID: <20241213021827.2956769-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
  generates an in-memory rST document using qapi-domain directives.=0D
- Adds a test document that showcases this new transmogrifier.=0D
=0D
What this series very notably does not do (yet):=0D
=0D
- "ifcond" data for anything other than top-level entities is not=0D
  considered or rendered. This means "if" statements for features and=0D
  members are entirely absent.=0D
=0D
- The inliner is not present at all. This series renders only=0D
  documentation exactly as it is exists in the source files.=0D
=0D
- *branches* are themselves not considered at all; they're skipped=0D
   entirely for now. They will be included alongside the inliner in=0D
   either a subsequent series or a followup to this series.=0D
=0D
- Undocumented members and return statements are not autogenerated.=0D
=0D
- Pseudofeatures (Things like allow-oob) are not generated as documented=0D
  features.=0D
=0D
- Documentation culling: all entities are documented whether or not=0D
  they're relevant to the wire format.=0D
=0D
My goal in doing it this way is to save the "fancy" features for later=0D
so we can focus on reviewing and tightening up the core functionality of=0D
the transmogrifier. Once we're on steadier ground, I will re-add the=0D
fanciful features while adjusting the qapi-domain mechanisms. Once=0D
everything looks "roughly right, give or take some minor nits", I will=0D
switch back to the qapi-domain series itself for review before we merge=0D
everything together.=0D
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
  docs/qapidoc: record current documented entity in transmogrifier=0D
  docs/qapidoc: add visit_returns() method=0D
  docs/qapidoc: add visit_member() method=0D
  docs/qapidoc: add visit_sections() method=0D
  docs/qapidoc: add visit_entity()=0D
  docs/qapidoc: implement transmogrify() method=0D
  docs/qapidoc: add transmogrifier test document=0D
=0D
 docs/index.rst         |   1 +=0D
 docs/qapi/index.rst    |  53 ++++++=0D
 docs/sphinx/qapidoc.py | 419 ++++++++++++++++++++++++++++++++++++++---=0D
 scripts/qapi/parser.py |  97 +++++++---=0D
 scripts/qapi/source.py |   4 +-=0D
 5 files changed, 524 insertions(+), 50 deletions(-)=0D
 create mode 100644 docs/qapi/index.rst=0D
=0D
-- =0D
2.47.0=0D
=0D



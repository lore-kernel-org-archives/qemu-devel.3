Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35507C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfoZN-0001FM-G6; Wed, 05 Feb 2025 18:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfoZK-0001Ey-5H
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:12:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfoZG-0005ae-TD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yAmmG7l3qu6h6I5cJ/VHSxEbL4AyzQnT22w/Z2JplrM=;
 b=W3I1YvmrLSAo2RKUNeeJRbza7Fozvu+y1atZ4mgO00iKjHyy5oKAnlhsDt2dPKACRM/HnS
 HUl6ZV0W1ImW9spUq74ZuJUg4+Wwo6wMBscqQtsDCcCCQ/CF6ReQ7ZPkXsV+Z+d68ubC2j
 Q7Ru6cxB5jIhFVPILg4rNnjJo5tDW3c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-kiTKx8_fNNS3t-OFZcemmA-1; Wed,
 05 Feb 2025 18:12:20 -0500
X-MC-Unique: kiTKx8_fNNS3t-OFZcemmA-1
X-Mimecast-MFC-AGG-ID: kiTKx8_fNNS3t-OFZcemmA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D769A1956086; Wed,  5 Feb 2025 23:12:15 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0B671800570; Wed,  5 Feb 2025 23:12:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 00/42] docs: add sphinx-domain rST generator to qapidoc
Date: Wed,  5 Feb 2025 18:11:26 -0500
Message-ID: <20250205231208.1480762-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

based-on: https://patchew.org/QEMU/20241213011307.2942030-1-jsnow@redhat.co=
m/=0D
=0D
Hiya! This series is based on a rebased version of the above=0D
series. Apply the above patches to origin/master and then apply this=0D
series and you should be good to go. Or just snitch the patches from my=0D
GitLab branch:=0D
=0D
https://gitlab.com/jsnow/qemu/-/commits/sphinx-domain-blergh2=0D
=0D
(... ignore the branch name. I ran into some problems with stacked git=0D
corrupting my branches ...)=0D
=0D
If you're just tuning in, this series adds a new sphinx documentation=0D
generator for QAPI as presented on at KVM Forum; the big win here is=0D
cross-references and indices for QMP commands and events. It depends on=0D
the qapi-domain plugin for sphinx which is posted in the pre-requisite=0D
series; it's not polished for review and should be considered=0D
POC-quality. I felt it was easier to review this series backwards,=0D
because the design of the rST generator informs the design of the domain=0D
plugin. (Which makes sense: the rST is generated first, and then it's=0D
parsed. Our review follows the flow of data through the generator.)=0D
=0D
Overview:=0D
=0D
Patches 1-24: Mostly the same as in v2; implements the very basics of=0D
    the new qapidoc generator. "type" was changed to "kind" for the doc=0D
    section metadata, and "untagged" changed to "plain". Some small=0D
    phrasing tweaks here and there.=0D
=0D
Patches 25-26: Add auto-generated stub docs for undocumented members.=0D
=0D
Patches 27-29: Restrict the source QAPIDoc syntax slightly and=0D
    differentiate "plain" sections as either intro or details. Necessary=0D
    for the inliner.=0D
=0D
Patch 30: Add the "inliner", the component that squishes "inherited"=0D
    arguments/members into a single reference for commands/events.=0D
=0D
Patches 31-32: Add auto-generated documentation for commands that return=0D
    a value that is not documented.=0D
=0D
Patches 33-35: Document the "out-of-band" property on QMP commands.=0D
=0D
Patches 36-38: Add branch support to the inliner. Ish. See below.=0D
=0D
Patches 39-40: Cull unused definitions from the generated QMP docs; cull=0D
    anything that has been inlined and no longer needs to be documented=0D
    separately.=0D
=0D
Patches 41-42: Add intermediate representation rST document writing in=0D
    DEBUG mode=0D
=0D
Things notably still not perfect:=0D
=0D
  (ignoring aesthetics; we care only about the rST generator itself in=0D
  this series.)=0D
=0D
- ifcond for anything other than root level entires is still ignored=0D
- branch inliner ignores all sections except members (ifcond, details,=0D
  features)=0D
- intro/details separation enforces no plain paragraphs to appear in the=0D
  "middle" of the documentation section; new markup may be desired if we=0D
  want to add annotations to categories/regions instead of to specific=0D
  members/features.=0D
=0D
If you want to give this a whirl yourself, build QEMU with documentation=0D
support enabled and look at docs/manual/qapi/index.html for a sample=0D
generation of the QMP manual using the new system. You probably need=0D
sphinx >=3D 4.0 for the time being to do so.=0D
=0D
John Snow (42):=0D
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
  docs: disambiguate cross-references=0D
  docs/qapidoc: add transmogrifier test document=0D
  docs/qapidoc: generate entries for undocumented members=0D
  qapi/parser: add undocumented stub members to all_sections=0D
  qapi: differentiate "intro" and "detail" sections=0D
  qapi/parser: prohibit untagged sections between tagged sections=0D
  qapi: Add "Details:" disambiguation marker=0D
  docs/qapidoc: add minimalistic inliner=0D
  docs/qapidoc: autogenerate undocumented return docs=0D
  docs/qapidoc: Add generated returns documentation to inliner=0D
  docs/qmp: add target to Out-of-band execution section=0D
  docs/qapidoc: document the "out-of-band" pseudofeature=0D
  docs/qapidoc: generate out-of-band pseudofeature sections=0D
  qapi/parser: add "meta" kind to QAPIDoc.Kind=0D
  qapi/schema: add __iter__ method to QAPISchemaVariants=0D
  docs/qapi: add branch support to inliner=0D
  qapi/schema: add doc_visible property to QAPISchemaDefinition=0D
  docs/qapidoc: cull (most) un-named entities from docs=0D
  qapi: resolve filenames in info structures=0D
  docs/qapidoc: add intermediate output debugger=0D
=0D
 docs/devel/codebase.rst         |   6 +-=0D
 docs/glossary.rst               |  10 +-=0D
 docs/index.rst                  |   1 +=0D
 docs/interop/qmp-spec.rst       |   2 +=0D
 docs/qapi/index.rst             |  53 +++=0D
 docs/sphinx/qapidoc.py          | 716 ++++++++++++++++++++++++++++++--=0D
 qapi/machine.json               |   2 +=0D
 qapi/migration.json             |   4 +=0D
 qapi/net.json                   |   4 +-=0D
 qapi/qom.json                   |   8 +-=0D
 qapi/yank.json                  |   2 +=0D
 scripts/qapi/introspect.py      |   4 +-=0D
 scripts/qapi/parser.py          | 178 ++++++--=0D
 scripts/qapi/schema.py          |  48 ++-=0D
 scripts/qapi/source.py          |   4 +-=0D
 scripts/qapi/types.py           |   4 +-=0D
 scripts/qapi/visit.py           |   4 +-=0D
 tests/qapi-schema/doc-good.json |   4 +-=0D
 tests/qapi-schema/doc-good.out  |  12 +-=0D
 tests/qapi-schema/doc-good.txt  |   8 +-=0D
 tests/qapi-schema/test-qapi.py  |   4 +-=0D
 21 files changed, 975 insertions(+), 103 deletions(-)=0D
 create mode 100644 docs/qapi/index.rst=0D
=0D
-- =0D
2.48.1=0D
=0D



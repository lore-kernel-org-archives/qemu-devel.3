Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F29C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 00:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJjDq-0005qC-RJ; Tue, 18 Jun 2024 20:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjDq-0005p9-1T
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjDo-0001Gt-2V
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718757042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4gl0+5pfkZW2ghJc+QLiSsyQdXIc10W0zM/jWJDDcKY=;
 b=R54IGBz2YNiLM/hR/bT2+zpRrCKh8XwrgBT0+1zyAba5gPbJzowcJVT1qsdTX6N6G9asdA
 hJ3DHpvN5dZtAYVGx5qt6/gb+NkaeCt2flfzcIpKW0stRHGoDJIP2p9JYOO+UUludPmPOJ
 MmwzYqjLxHooY6AoAiD+YhyUwVmBoHo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-yeHTznzPNsC90jjuxjNpeQ-1; Tue,
 18 Jun 2024 20:30:34 -0400
X-MC-Unique: yeHTznzPNsC90jjuxjNpeQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47E5A1956051; Wed, 19 Jun 2024 00:30:31 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.16.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFE2D1955E80; Wed, 19 Jun 2024 00:30:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Jiri Pirko <jiri@resnulli.us>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 00/13] qapi: convert "Note" and "Example" sections to rST
Date: Tue, 18 Jun 2024 20:29:59 -0400
Message-ID: <20240619003012.1753577-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This series focuses primarily on converting our existing QAPI/QMP=0D
documentation to remove special "Note" and "Example" sections in favor=0D
of rST markup for the same.=0D
=0D
This is being done primarily to reduce the number of specially parsed=0D
QAPI sections we have in favor of allowing fully arbitrary rST markup=0D
for greater flexibility and freedom in styling the rendered HTML=0D
documentation.=0D
=0D
(A tangible side benefit is that the new qapidoc generator has fewer=0D
sections to reason about when it splices inherited documentation=0D
together for the QMP reference manual; docs largely preserve the order=0D
of documentation "as written" instead of needing to splice multiple=0D
separate sections together. A goal of the new generator is to eventually=0D
remove all tagged sections except for "members" and "features".)=0D
=0D
Known issues:=0D
=0D
- The caption syntax for QMP examples is a little ugly in rendered HTML=0D
  output; My CSS intern wasn't available before publication time to fix=0D
  it ;) -- Will fix with an amendment patch at next opportunity.=0D
=0D
Any feedback not implemented should be interpreted as evidence of a=0D
forgetful (rather than a spiteful) mind. Please remind me where=0D
appropriate.=0D
=0D
--js=0D
=0D
John Snow (13):=0D
  [DO-NOT-MERGE]: Add some ad-hoc linting helpers.=0D
  qapi: linter fixups=0D
  docs/qapidoc: delint a tiny portion of the module=0D
  qapi/parser: preserve indentation in QAPIDoc sections=0D
  qapi/parser: fix comment parsing immediately following a doc block=0D
  docs/qapidoc: fix nested parsing under untagged sections=0D
  qapi: fix non-compliant JSON examples=0D
  qapi: ensure all errors sections are uniformly typset=0D
  qapi: convert "Note" sections to plain rST=0D
  qapi: update prose in note blocks=0D
  qapi: add markup to note blocks=0D
  qapi/parser: don't parse rST markup as section headers=0D
  qapi: convert "Example" sections to rST=0D
=0D
 docs/devel/qapi-code-gen.rst                  |  25 +--=0D
 docs/sphinx/qapidoc.py                        | 103 ++++++++----=0D
 qapi/acpi.json                                |   6 +-=0D
 qapi/block-core.json                          | 148 +++++++++-------=0D
 qapi/block.json                               |  62 ++++---=0D
 qapi/char.json                                |  48 ++++--=0D
 qapi/control.json                             |  32 ++--=0D
 qapi/dump.json                                |  14 +-=0D
 qapi/introspect.json                          |   6 +-=0D
 qapi/machine-target.json                      |  29 ++--=0D
 qapi/machine.json                             | 125 ++++++++------=0D
 qapi/migration.json                           | 159 ++++++++++++------=0D
 qapi/misc-target.json                         |  33 ++--=0D
 qapi/misc.json                                | 139 ++++++++-------=0D
 qapi/net.json                                 |  42 +++--=0D
 qapi/pci.json                                 |  11 +-=0D
 qapi/qapi-schema.json                         |   6 +-=0D
 qapi/qdev.json                                |  45 ++---=0D
 qapi/qom.json                                 |  39 +++--=0D
 qapi/replay.json                              |  12 +-=0D
 qapi/rocker.json                              |  30 ++--=0D
 qapi/run-state.json                           |  63 ++++---=0D
 qapi/sockets.json                             |  10 +-=0D
 qapi/stats.json                               |  22 +--=0D
 qapi/tpm.json                                 |   9 +-=0D
 qapi/trace.json                               |   6 +-=0D
 qapi/transaction.json                         |  13 +-=0D
 qapi/ui.json                                  |  93 +++++-----=0D
 qapi/vfio.json                                |   3 +-=0D
 qapi/virtio.json                              |  50 +++---=0D
 qapi/yank.json                                |   6 +-=0D
 qga/qapi-schema.json                          |  48 +++---=0D
 scripts/qapi-lint.sh                          |  59 +++++++=0D
 scripts/qapi/Makefile                         |   5 +=0D
 scripts/qapi/introspect.py                    |   8 +-=0D
 scripts/qapi/parser.py                        |  40 ++++-=0D
 scripts/qapi/schema.py                        |   6 +-=0D
 scripts/qapi/visit.py                         |   5 +-=0D
 tests/qapi-schema/doc-empty-section.err       |   2 +-=0D
 tests/qapi-schema/doc-empty-section.json      |   2 +-=0D
 tests/qapi-schema/doc-good.json               |  21 ++-=0D
 tests/qapi-schema/doc-good.out                |  62 ++++---=0D
 tests/qapi-schema/doc-good.txt                |  31 ++--=0D
 .../qapi-schema/doc-interleaved-section.json  |   2 +-=0D
 44 files changed, 1036 insertions(+), 644 deletions(-)=0D
 create mode 100755 scripts/qapi-lint.sh=0D
 create mode 100644 scripts/qapi/Makefile=0D
=0D
-- =0D
2.44.0=0D
=0D



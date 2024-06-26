Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C956EC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 22:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMb1i-00056O-Bx; Wed, 26 Jun 2024 18:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb1V-00051I-5L
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb1Q-0002BU-Ns
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719440506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3ppBhmEFfudZ224+zKt2e2juuCee+bLNx3yjzAK3WEs=;
 b=UWAS5IF+e5VNDqbDe87oYMEhQKN5c/t0gke98Lgd+QhngwqUnbg9iYIqocnJGQoTRMAPek
 pd5uEXeGR1uJ1uHWsiBfIUK+uwrQnvEKb0PHAlFkaSm0N0eRbICiToW6wrzkHyE8Id6v8S
 O0UG2KnbinaVXMn0u3QFPvNfxM2Ybqc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-SUskzvo0OdeKRIcoRGLXZg-1; Wed,
 26 Jun 2024 18:21:45 -0400
X-MC-Unique: SUskzvo0OdeKRIcoRGLXZg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FB7619560B5; Wed, 26 Jun 2024 22:21:41 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50BA819560BF; Wed, 26 Jun 2024 22:21:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 00/21] qapi: convert "Note" and "Example" sections to rST
Date: Wed, 26 Jun 2024 18:21:06 -0400
Message-ID: <20240626222128.406106-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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
V2:=0D
 - Lotsa stuff :{=0D
 - Added new example box styling and sphinx directive macro=0D
 - Addressed... most? list feedback. (But not the indent split.)=0D
=0D
Known issues:=0D
=0D
- The Example boxes are styled a little wonkily if prose follows the=0D
  code-block instead of precedes it, fixup will be tomorrow.=0D
=0D
--js=0D
=0D
Harmonie Snow (1):=0D
  docs/sphinx: add CSS styling for qmp-example directive=0D
=0D
John Snow (20):=0D
  [DO-NOT-MERGE]: Add some ad-hoc linting helpers.=0D
  qapi: linter fixups=0D
  docs/qapidoc: remove unused intersperse function=0D
  docs/qapidoc: delint a tiny portion of the module=0D
  qapi/parser: preserve indentation in QAPIDoc sections=0D
  qapi/parser: fix comment parsing immediately following a doc block=0D
  docs/qapidoc: fix nested parsing under untagged sections=0D
  qapi: fix non-compliant JSON examples=0D
  qapi: nail down convention that Errors sections are lists=0D
  qapi: convert "Note" sections to plain rST=0D
  qapi: update prose in note blocks=0D
  qapi: add markup to note blocks=0D
  qapi/parser: don't parse rST markup as section headers=0D
  docs/qapidoc: factor out do_parse()=0D
  docs/qapidoc: create qmp-example directive=0D
  docs/qapidoc: add QMP highlighting to annotated qmp-example blocks=0D
  qapi: convert "Example" sections without titles=0D
  qapi: convert "Example" sections with titles=0D
  qapi: convert "Example" sections with longer prose=0D
  qapi: remove "Example" doc section=0D
=0D
 docs/devel/qapi-code-gen.rst                  |  25 +-=0D
 docs/sphinx-static/theme_overrides.css        |  46 ++++=0D
 docs/sphinx/qapidoc.py                        | 258 +++++++++++++-----=0D
 qapi/acpi.json                                |   4 +-=0D
 qapi/block-core.json                          | 116 ++++----=0D
 qapi/block.json                               |  59 ++--=0D
 qapi/char.json                                |  36 ++-=0D
 qapi/control.json                             |  28 +-=0D
 qapi/dump.json                                |  10 +-=0D
 qapi/introspect.json                          |   6 +-=0D
 qapi/machine-target.json                      |  28 +-=0D
 qapi/machine.json                             | 117 ++++----=0D
 qapi/migration.json                           | 104 +++----=0D
 qapi/misc-target.json                         |  22 +-=0D
 qapi/misc.json                                | 123 +++++----=0D
 qapi/net.json                                 |  32 ++-=0D
 qapi/pci.json                                 |  10 +-=0D
 qapi/qdev.json                                |  40 +--=0D
 qapi/qom.json                                 |  33 ++-=0D
 qapi/replay.json                              |   8 +-=0D
 qapi/rocker.json                              |  26 +-=0D
 qapi/run-state.json                           |  48 ++--=0D
 qapi/sockets.json                             |  10 +-=0D
 qapi/stats.json                               |  22 +-=0D
 qapi/tpm.json                                 |   6 +-=0D
 qapi/trace.json                               |   4 +-=0D
 qapi/transaction.json                         |  12 +-=0D
 qapi/ui.json                                  |  76 +++---=0D
 qapi/vfio.json                                |   2 +-=0D
 qapi/virtio.json                              |  57 ++--=0D
 qapi/yank.json                                |   4 +-=0D
 qga/qapi-schema.json                          |  48 ++--=0D
 scripts/qapi-lint.sh                          |  61 +++++=0D
 scripts/qapi/Makefile                         |   5 +=0D
 scripts/qapi/introspect.py                    |   8 +-=0D
 scripts/qapi/parser.py                        |  38 ++-=0D
 scripts/qapi/schema.py                        |   6 +-=0D
 scripts/qapi/visit.py                         |   5 +-=0D
 tests/qapi-schema/doc-empty-section.err       |   2 +-=0D
 tests/qapi-schema/doc-empty-section.json      |   2 +-=0D
 tests/qapi-schema/doc-good.json               |  28 +-=0D
 tests/qapi-schema/doc-good.out                |  61 +++--=0D
 tests/qapi-schema/doc-good.txt                |  36 ++-=0D
 .../qapi-schema/doc-interleaved-section.json  |   2 +-=0D
 44 files changed, 1010 insertions(+), 664 deletions(-)=0D
 create mode 100755 scripts/qapi-lint.sh=0D
 create mode 100644 scripts/qapi/Makefile=0D
=0D
-- =0D
2.45.0=0D
=0D



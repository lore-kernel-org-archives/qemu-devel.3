Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F82C3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 02:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTuAp-0007vD-5K; Tue, 16 Jul 2024 22:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuAj-0007uI-QX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuAg-0003Ok-E3
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721182412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fpRV929kmfNC8JJGtecvN9j+uR69f4Qs7o0Dmezllb8=;
 b=VRjeezgxPAdJpJ/FAlMcmLYr/oTq+Pk0xswzx/ODJ1jMUuNHuVQcj8TNmhGA2m4J3Pky55
 7xXQemcVFey8mrvY6dvwIMyjRTWmuEmQGkISPDDkcDZILKP1UEzbpj0wZxYutOr/SdaXyK
 dcN25hal2Zh06w8JYrAMBJiHrJp4Vvo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-EILglWi4M9m7-vapnmKiIQ-1; Tue,
 16 Jul 2024 22:13:25 -0400
X-MC-Unique: EILglWi4M9m7-vapnmKiIQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92C241956046; Wed, 17 Jul 2024 02:13:21 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.65.127])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F99D1955F40; Wed, 17 Jul 2024 02:13:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 0/9] qapi: convert example sections to qmp-example rST
 directives
Date: Tue, 16 Jul 2024 22:13:02 -0400
Message-ID: <20240717021312.606116-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patchset focuses on converting example sections to rST directives=0D
using a new `.. qmp-example::` directive.=0D
=0D
V2:=0D
 - Rebased on origin/master; converted one more example=0D
 - Fixed (most?) minor nits from last review=0D
 - Didn't address lack of newline in text mode or enhanced lexer (yet)=0D
=0D
Changes since this was split out from the prior series:=0D
=0D
- Harmonie updated the CSS for the example block section.=0D
  I think it's really tidy now! Thanks Harmonie!=0D
- Dependence on SphinxDirective was removed, but it will likely=0D
  re-appear in the next series anyway.=0D
- qapi-code-gen.rst was updated with a section on how to write examples.=0D
- Various minor tweaks to comments, commit messages, docs, etc.=0D
=0D
Harmonie Snow (1):=0D
  docs/sphinx: add CSS styling for qmp-example directive=0D
=0D
John Snow (8):=0D
  [DO-NOT-MERGE]: Add some ad-hoc linting helpers.=0D
  docs/qapidoc: factor out do_parse()=0D
  docs/qapidoc: create qmp-example directive=0D
  docs/qapidoc: add QMP highlighting to annotated qmp-example blocks=0D
  qapi: convert "Example" sections without titles=0D
  qapi: convert "Example" sections with titles=0D
  qapi: convert "Example" sections with longer prose=0D
  qapi: remove "Example" doc section=0D
=0D
 docs/devel/qapi-code-gen.rst           |  58 +++++++++--=0D
 docs/sphinx-static/theme_overrides.css |  49 ++++++++++=0D
 docs/sphinx/qapidoc.py                 | 130 ++++++++++++++++++++++---=0D
 qapi/acpi.json                         |   4 +-=0D
 qapi/block-core.json                   |  88 +++++++++--------=0D
 qapi/block.json                        |  57 ++++++-----=0D
 qapi/char.json                         |  24 +++--=0D
 qapi/control.json                      |   8 +-=0D
 qapi/dump.json                         |   8 +-=0D
 qapi/machine-target.json               |   2 +-=0D
 qapi/machine.json                      |  68 +++++++------=0D
 qapi/migration.json                    |  90 +++++++++--------=0D
 qapi/misc-target.json                  |  22 ++---=0D
 qapi/misc.json                         |  32 +++---=0D
 qapi/net.json                          |  22 +++--=0D
 qapi/pci.json                          |   2 +-=0D
 qapi/qdev.json                         |  10 +-=0D
 qapi/qom.json                          |  16 +--=0D
 qapi/replay.json                       |   8 +-=0D
 qapi/rocker.json                       |   8 +-=0D
 qapi/run-state.json                    |  32 +++---=0D
 qapi/tpm.json                          |   6 +-=0D
 qapi/trace.json                        |   4 +-=0D
 qapi/transaction.json                  |   2 +-=0D
 qapi/ui.json                           |  45 ++++-----=0D
 qapi/vfio.json                         |   2 +-=0D
 qapi/virtio.json                       |  45 ++++++---=0D
 qapi/yank.json                         |   4 +-=0D
 scripts/qapi-lint.sh                   |  61 ++++++++++++=0D
 scripts/qapi/Makefile                  |   5 +=0D
 scripts/qapi/parser.py                 |  10 +-=0D
 tests/qapi-schema/doc-good.json        |  19 ++--=0D
 tests/qapi-schema/doc-good.out         |  26 +++--=0D
 tests/qapi-schema/doc-good.txt         |  23 ++---=0D
 34 files changed, 662 insertions(+), 328 deletions(-)=0D
 create mode 100755 scripts/qapi-lint.sh=0D
 create mode 100644 scripts/qapi/Makefile=0D
=0D
-- =0D
2.45.0=0D
=0D



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5CDC25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 21:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s709t-0005Vw-GW; Tue, 14 May 2024 17:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s709g-0005UD-FF
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s709e-0008NC-N0
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FJOBMqwSz+ordkEkEAblk9Y+ji04ZdGGoN9S5pz9MsA=;
 b=YTrqW40PlQzPuTVoc/swmI5ggOY2snVwuvU9tadM1fZf+3JmlwQvBO6oS6CBp+4kF8ZNp4
 HBv9i1um/qceete1B/sc3ytXy/p2U5jRIMogkY5SkRhjN+WEiNRnz0OQ1wpjfN8ZL2lOV9
 NE3sRqfL1PVm4Fz2+LWJtfv3v6mcoUo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-fEAlGaXaMk6my9Hagm1b6g-1; Tue,
 14 May 2024 17:57:46 -0400
X-MC-Unique: fEAlGaXaMk6my9Hagm1b6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 514053806704;
 Tue, 14 May 2024 21:57:45 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79FFD6BC0;
 Tue, 14 May 2024 21:57:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Mads Ynddal <mads@ynddal.dk>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 00/20] qapi: new sphinx qapi domain pre-requisites
Date: Tue, 14 May 2024 17:57:19 -0400
Message-ID: <20240514215740.940155-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

Howdy - this patch series is the first batch of patches meant to prepare=0D
the QAPI documentation for a new Sphinx module that adds=0D
cross-references, an index, improved inlining, elision of types unseen=0D
on the wire, and other goodies.=0D
=0D
This series addresses just existing code and documentation that needs to=0D
be changed and doesn't introduce anything new just yet - except the rST=0D
conversion of Notes and Examples sections, which DOES impact the=0D
existing QAPI documentation generation.=0D
=0D
If you're CC'd on this series, it's *probably* because I've adjusted=0D
some QAPI documentation that you're the maintainer of - In most cases,=0D
these changes are purely mechanical (converting QAPI sections into pure=0D
rST) and probably nothing too interesting. In a small handful of cases=0D
(patches 15-17), I've been a bit more invasive and you may want to take=0D
a quick peek.=0D
=0D
Overview:=0D
=0D
Patches 1-3: linter/typing cleanup=0D
Patches 4-12: QAPI generator fixes/miscellany=0D
Patch 13: qapidoc.py fix (to prepare for rST conversion)=0D
Patches 14-20: QAPI documentation modifications, rST conversion=0D
=0D
Sorry,=0D
--js=0D
=0D
John Snow (20):=0D
  [DO-NOT-MERGE]: Add some ad-hoc linting helpers.=0D
  qapi: linter fixups=0D
  docs/qapidoc: delint a tiny portion of the module=0D
  qapi/parser: preserve indentation in QAPIDoc sections=0D
  qapi/parser: adjust info location for doc body section=0D
  qapi/parser: fix comment parsing immediately following a doc block=0D
  qapi/parser: add semantic 'kind' parameter to QAPIDoc.Section=0D
  qapi/parser: differentiate intro and outro paragraphs=0D
  qapi/parser: add undocumented stub members to all_sections=0D
  qapi/schema: add __iter__ method to QAPISchemaVariants=0D
  qapi/schema: add doc_visible property to QAPISchemaDefinition=0D
  qapi/source: allow multi-line QAPISourceInfo advancing=0D
  docs/qapidoc: fix nested parsing under untagged sections=0D
  qapi: fix non-compliant JSON examples=0D
  qapi: remove developer factoring comments from QAPI doc blocks=0D
  qapi: rewrite StatsFilter comment=0D
  qapi: rewrite BlockExportOptions doc block=0D
  qapi: ensure all errors sections are uniformly typset=0D
  qapi: convert "Note" sections to plain rST=0D
  qapi: convert "Example" sections to rST=0D
=0D
 docs/sphinx/qapidoc.py                        |  62 ++++--=0D
 qapi/acpi.json                                |   6 +-=0D
 qapi/audio.json                               |   5 +-=0D
 qapi/block-core.json                          | 195 ++++++++++--------=0D
 qapi/block-export.json                        |  16 +-=0D
 qapi/block.json                               |  62 +++---=0D
 qapi/char.json                                |  53 +++--=0D
 qapi/control.json                             |  32 +--=0D
 qapi/crypto.json                              |  33 ++-=0D
 qapi/dump.json                                |  14 +-=0D
 qapi/introspect.json                          |   6 +-=0D
 qapi/machine-target.json                      |  29 +--=0D
 qapi/machine.json                             | 138 +++++++------=0D
 qapi/migration.json                           | 159 +++++++++-----=0D
 qapi/misc-target.json                         |  33 ++-=0D
 qapi/misc.json                                | 139 +++++++------=0D
 qapi/net.json                                 |  49 +++--=0D
 qapi/pci.json                                 |  11 +-=0D
 qapi/qapi-schema.json                         |   6 +-=0D
 qapi/qdev.json                                |  45 ++--=0D
 qapi/qom.json                                 |  69 +++----=0D
 qapi/replay.json                              |  12 +-=0D
 qapi/rocker.json                              |  30 +--=0D
 qapi/run-state.json                           |  63 +++---=0D
 qapi/sockets.json                             |  10 +-=0D
 qapi/stats.json                               |  30 ++-=0D
 qapi/tpm.json                                 |   9 +-=0D
 qapi/trace.json                               |   6 +-=0D
 qapi/transaction.json                         |  13 +-=0D
 qapi/ui.json                                  | 107 +++++-----=0D
 qapi/virtio.json                              |  50 ++---=0D
 qapi/yank.json                                |   6 +-=0D
 qga/qapi-schema.json                          |  48 ++---=0D
 scripts/qapi-lint.sh                          |  51 +++++=0D
 scripts/qapi/Makefile                         |   5 +=0D
 scripts/qapi/introspect.py                    |  12 +-=0D
 scripts/qapi/parser.py                        | 104 ++++++++--=0D
 scripts/qapi/schema.py                        |  54 ++++-=0D
 scripts/qapi/source.py                        |   4 +-=0D
 scripts/qapi/types.py                         |   4 +-=0D
 scripts/qapi/visit.py                         |   9 +-=0D
 tests/qapi-schema/doc-empty-section.err       |   2 +-=0D
 tests/qapi-schema/doc-empty-section.json      |   2 +-=0D
 tests/qapi-schema/doc-good.json               |  18 +-=0D
 tests/qapi-schema/doc-good.out                |  61 +++---=0D
 tests/qapi-schema/doc-good.txt                |  31 +--=0D
 .../qapi-schema/doc-interleaved-section.json  |   2 +-=0D
 47 files changed, 1152 insertions(+), 753 deletions(-)=0D
 create mode 100755 scripts/qapi-lint.sh=0D
 create mode 100644 scripts/qapi/Makefile=0D
=0D
-- =0D
2.44.0=0D
=0D



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E33C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKqk-0007Kb-CH; Mon, 14 Jul 2025 11:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUT-0000FK-8Z
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUQ-0003az-AR
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bVgpdgF+JzRvjgtFTp2O/WnI3R1Vzaf2Ry49puKHDS8=;
 b=TL91Wwgtqp0E12EK08b9rWD8AslQuvE7POMrk/PzzcmOUQBQMTn4v8m6NU1hlgJFhpL9a6
 uf9LRjKv6oBnNAZOu+yYCBvzWdiYFLXPQ+IubPwO8XGspunbhve79syZCZZ8KIMTMvuhsm
 u4YRLQPdcEwcZmXD/1popXEdnZaYTiA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-ezRATIzgNFa-Ip7EKeme8Q-1; Mon,
 14 Jul 2025 09:45:03 -0400
X-MC-Unique: ezRATIzgNFa-Ip7EKeme8Q-1
X-Mimecast-MFC-AGG-ID: ezRATIzgNFa-Ip7EKeme8Q_1752500702
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80B781809C80
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D231218002B2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B7B9A21E6A27; Mon, 14 Jul 2025 15:44:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/32] QAPI patches patches for 2025-07-14
Date: Mon, 14 Jul 2025 15:44:26 +0200
Message-ID: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-07-14

for you to fetch changes up to 07273ca0ce3af397071f7a6c11abdab649ff25e1:

  tests/qtest/qom-test: unit test for qom-list-get (2025-07-14 15:25:12 +0200)

----------------------------------------------------------------
QAPI patches patches for 2025-07-14

----------------------------------------------------------------
John Snow (27):
      docs/sphinx: adjust qapidoc to cope with same-line error sections
      docs/sphinx: parse @references in freeform text
      docs/sphinx: remove legacy QAPI manual generator
      docs/sphinx: remove special parsing for freeform sections
      qapi: lift restriction on using '=' in doc blocks
      docs/qapi-domain: add return-nodesc
      qapi: Fix undocumented return values by generating something
      qapi: remove trivial "Returns:" sections
      qapi: rephrase return docs to avoid type name
      qapi: add cross-references to acpi.json
      qapi: add cross-references to authz.json
      qapi: add cross-references to block layer
      qapi: add cross-references to crypto.json
      qapi: add cross-references to dump.json
      qapi: add cross-references to job.json
      qapi: add cross-references to Machine core
      qapi: add cross-references to migration.json
      qapi: add cross-references to net.json
      qapi: add cross-references to pci.json
      qapi: add cross-references to QOM
      qapi: add cross-references to replay.json
      qapi: add cross-references to run-state.json
      qapi: add cross-references to sockets.json
      qapi: add cross-references to ui.json
      qapi: add cross-references to virtio.json
      qapi: add cross-references to yank.json
      qapi: add cross-references to misc modules

Markus Armbruster (2):
      qapi: Clean up "This command will do ..." command descriptions
      qapi: Clean up a few Errors: sections

Steve Sistare (3):
      qom: qom-list-get
      python: use qom-list-get
      tests/qtest/qom-test: unit test for qom-list-get

 docs/devel/qapi-code-gen.rst                 |  28 +-
 docs/devel/qapi-domain.rst                   |  31 ++
 docs/interop/firmware.json                   |   4 +-
 docs/interop/qemu-ga-ref.rst                 |   1 -
 docs/interop/qemu-qmp-ref.rst                |   1 -
 docs/interop/qemu-storage-daemon-qmp-ref.rst |   1 -
 docs/interop/vhost-user.json                 |   4 +-
 docs/sphinx/qapi_domain.py                   |   8 +
 docs/sphinx/qapidoc.py                       |  96 ++----
 docs/sphinx/qapidoc_legacy.py                | 440 ---------------------------
 qapi/acpi.json                               |   6 +-
 qapi/audio.json                              |   6 +-
 qapi/authz.json                              |   6 +-
 qapi/block-core.json                         | 201 ++++++------
 qapi/block-export.json                       |  41 +--
 qapi/block.json                              |  23 +-
 qapi/char.json                               |  12 +-
 qapi/common.json                             |   4 +-
 qapi/compat.json                             |   4 +-
 qapi/control.json                            |  20 +-
 qapi/crypto.json                             |   8 +-
 qapi/cryptodev.json                          |   6 +-
 qapi/cxl.json                                |   4 +-
 qapi/dump.json                               |  19 +-
 qapi/ebpf.json                               |   6 +-
 qapi/error.json                              |   4 +-
 qapi/introspect.json                         |  34 ++-
 qapi/job.json                                |  62 ++--
 qapi/machine-common.json                     |  24 +-
 qapi/machine.json                            | 110 +++----
 qapi/migration.json                          |  84 +++--
 qapi/misc-arm.json                           |   4 +-
 qapi/misc-i386.json                          |  32 +-
 qapi/misc.json                               |  28 +-
 qapi/net.json                                |  12 +-
 qapi/pci.json                                |   8 +-
 qapi/qapi-schema.json                        |   4 +-
 qapi/qdev.json                               |  11 +-
 qapi/qom.json                                |  89 ++++--
 qapi/replay.json                             |  14 +-
 qapi/rocker.json                             |   8 +-
 qapi/run-state.json                          |  52 ++--
 qapi/sockets.json                            |  10 +-
 qapi/stats.json                              |  14 +-
 qapi/tpm.json                                |   8 +-
 qapi/trace.json                              |   6 +-
 qapi/transaction.json                        |  16 +-
 qapi/uefi.json                               |   4 +-
 qapi/ui.json                                 |  58 ++--
 qapi/vfio.json                               |   4 +-
 qapi/virtio.json                             |  20 +-
 qapi/yank.json                               |  22 +-
 qom/qom-qmp-cmds.c                           |  53 ++++
 tests/qtest/qom-test.c                       | 116 ++++++-
 python/qemu/utils/qom.py                     |  43 +--
 python/qemu/utils/qom_common.py              |  53 ++++
 python/tests/qapi-isort.sh                   |   2 +-
 scripts/qapi/parser.py                       |  48 ++-
 scripts/qapi/schema.py                       |   3 +
 storage-daemon/qapi/qapi-schema.json         |   8 +-
 tests/qapi-schema/doc-bad-section.err        |   1 -
 tests/qapi-schema/doc-bad-section.json       |  10 -
 tests/qapi-schema/doc-bad-section.out        |   0
 tests/qapi-schema/doc-good.json              |  10 +-
 tests/qapi-schema/doc-good.out               |  10 +-
 tests/qapi-schema/doc-good.txt               | 274 ++++++-----------
 tests/qapi-schema/meson.build                |   1 -
 67 files changed, 1053 insertions(+), 1301 deletions(-)
 delete mode 100644 docs/sphinx/qapidoc_legacy.py
 delete mode 100644 tests/qapi-schema/doc-bad-section.err
 delete mode 100644 tests/qapi-schema/doc-bad-section.json
 delete mode 100644 tests/qapi-schema/doc-bad-section.out

-- 
2.49.0



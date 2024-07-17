Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E766C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Dl-0003iu-F1; Wed, 17 Jul 2024 06:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dj-0003aq-C6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dh-0001TY-Ms
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721213353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XcSBLiicQLh4KTctzI/5BColXVyyqxHy86ubrHNw/MI=;
 b=TmlffdamoqkGPfa7VbqpoG9K1ChpIIe+6YHLrgsj+sdv31k+5z0oP7bBk8rfygjUm6U1nK
 0AhOD9csjwkezvH4eeqMatVnXP09/oWwh4PTeCJOtXk9MLrQJ153CSD3UjkHZl36hQgpHx
 BPDKKVkldAGvBrY7pOdrMGSKxDvCpFc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-P_Yx4zJ3PBOzXszZiTLkqw-1; Wed,
 17 Jul 2024 06:49:11 -0400
X-MC-Unique: P_Yx4zJ3PBOzXszZiTLkqw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 835591955D48; Wed, 17 Jul 2024 10:49:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3B621955F40; Wed, 17 Jul 2024 10:49:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBBF421E668B; Wed, 17 Jul 2024 12:49:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 00/14] QAPI patches patches for 2024-07-17
Date: Wed, 17 Jul 2024 12:48:53 +0200
Message-ID: <20240717104907.2962784-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

The following changes since commit e2f346aa98646e84eabe0256f89d08e89b1837cf:

  Merge tag 'sdmmc-20240716' of https://github.com/philmd/qemu into staging (2024-07-17 07:59:31 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-07-17

for you to fetch changes up to 3c5f6114d9ffc70bc9b1a7cc0dddd72a911f966d:

  qapi: remove "Example" doc section (2024-07-17 10:20:54 +0200)

----------------------------------------------------------------
QAPI patches patches for 2024-07-17

----------------------------------------------------------------
Harmonie Snow (1):
      docs/sphinx: add CSS styling for qmp-example directive

John Snow (7):
      docs/qapidoc: factor out do_parse()
      docs/qapidoc: create qmp-example directive
      docs/qapidoc: add QMP highlighting to annotated qmp-example blocks
      qapi: convert "Example" sections without titles
      qapi: convert "Example" sections with titles
      qapi: convert "Example" sections with longer prose
      qapi: remove "Example" doc section

Markus Armbruster (6):
      qapi/qom: Document feature unstable of @x-vfio-user-server
      qapi/pci: Clean up documentation around PciDeviceClass
      qapi/machine: Clean up documentation around CpuInstanceProperties
      qapi/machine: Clarify query-uuid value when none has been specified
      qapi/sockets: Move deprecation note out of SocketAddress doc comment
      qapi/ui: Drop note on naming of SpiceQueryMouseMode

 docs/devel/qapi-code-gen.rst           |  58 ++++++++++++---
 docs/sphinx-static/theme_overrides.css |  49 +++++++++++++
 docs/sphinx/qapidoc.py                 | 128 ++++++++++++++++++++++++++++++---
 qapi/acpi.json                         |   4 +-
 qapi/block-core.json                   |  88 ++++++++++++-----------
 qapi/block.json                        |  57 ++++++++-------
 qapi/char.json                         |  24 ++++---
 qapi/control.json                      |   8 +--
 qapi/dump.json                         |   8 +--
 qapi/machine-target.json               |   2 +-
 qapi/machine.json                      |  86 ++++++++++++----------
 qapi/migration.json                    |  90 ++++++++++++-----------
 qapi/misc-target.json                  |  22 +++---
 qapi/misc.json                         |  32 ++++-----
 qapi/net.json                          |  22 +++---
 qapi/pci.json                          |   8 +--
 qapi/qdev.json                         |  10 +--
 qapi/qom.json                          |  19 ++---
 qapi/replay.json                       |   8 +--
 qapi/rocker.json                       |   8 +--
 qapi/run-state.json                    |  32 ++++-----
 qapi/sockets.json                      |   7 +-
 qapi/tpm.json                          |   6 +-
 qapi/trace.json                        |   4 +-
 qapi/transaction.json                  |   2 +-
 qapi/ui.json                           |  47 ++++++------
 qapi/vfio.json                         |   2 +-
 qapi/virtio.json                       |  45 +++++++-----
 qapi/yank.json                         |   4 +-
 scripts/qapi/parser.py                 |  10 ++-
 tests/qapi-schema/doc-good.json        |  19 +++--
 tests/qapi-schema/doc-good.out         |  26 ++++---
 tests/qapi-schema/doc-good.txt         |  23 +++---
 33 files changed, 610 insertions(+), 348 deletions(-)

-- 
2.45.0



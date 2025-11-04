Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C613BCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGyf-0000CO-NY; Tue, 04 Nov 2025 08:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyc-0000BB-Gw
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGya-0001Jd-8z
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j8f9zGxiVGDFwkCWNk1S07O9Q/1xVz8EkJtSkQjN23c=;
 b=IK9FryRqd4NpDscwD4DsgUcRN1Fv+e5wUUqMYwHePh1gjRtKEVgn+LIBdIjAUOXEiudhst
 yqk3btoV6qQKOjggzJOuRMNIsjmhVtjAjK5rIsXMd0jtkc2Cs0iUN1KgzxxaG9t8dkOcmM
 YnmUyNd2r8EjpeA0GWNqJhNIcUOAPNs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-1CtzUidDOrmuZyQGyF0mjw-1; Tue,
 04 Nov 2025 08:21:29 -0500
X-MC-Unique: 1CtzUidDOrmuZyQGyF0mjw-1
X-Mimecast-MFC-AGG-ID: 1CtzUidDOrmuZyQGyF0mjw_1762262488
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57AEB195609F; Tue,  4 Nov 2025 13:21:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E73730001A1; Tue,  4 Nov 2025 13:21:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5D5D621E6A27; Tue, 04 Nov 2025 14:21:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 00/12] QAPI patches for 2025-11-04
Date: Tue,  4 Nov 2025 14:21:13 +0100
Message-ID: <20251104132125.4134730-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:

  Merge tag 'igvm-20251103--pull-request' of https://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-11-04

for you to fetch changes up to 8107ba47fd78bcf8c3206de42dbfb5ba8184d706:

  qapi: Add documentation format validation (2025-11-04 13:55:27 +0100)

----------------------------------------------------------------
QAPI patches for 2025-11-04

----------------------------------------------------------------
Markus Armbruster (11):
      qapi/command: Avoid generating unused qmp_marshal_output_T()
      meson: Add missing backends.py to qapi_gen_depends
      qapi/audio: Fix description markup of AudiodevDBusOptions @nsamples
      qapi: Refill doc comments to conform to conventions
      qapi: Clean up whitespace between definitions
      qga/qapi-schema: Refill doc comments to conform to conventions
      qga/qapi-schema: Clean up whitespace between definitions
      docs/interop: Refill QAPI doc comments to conform to conventions
      docs/interop/vhost-user: Belatedly convert "Example" section
      docs/interop/firmware: Literal block markup
      docs/interop: Add test to keep vhost-user.json sane

Vladimir Sementsov-Ogievskiy (1):
      qapi: Add documentation format validation

 docs/devel/qapi-code-gen.rst                       |  25 +-
 docs/interop/firmware.json                         | 454 ++++++++++-----------
 docs/interop/vhost-user.json                       |  59 ++-
 docs/meson.build                                   |   9 +-
 meson.build                                        |   3 +-
 qapi/accelerator.json                              |   3 +-
 qapi/acpi-hest.json                                |   5 +-
 qapi/audio.json                                    |   4 +-
 qapi/block-core.json                               | 158 +++----
 qapi/block-export.json                             |  26 +-
 qapi/char.json                                     |   1 -
 qapi/crypto.json                                   |   8 +-
 qapi/cxl.json                                      |   1 -
 qapi/introspect.json                               |   8 +-
 qapi/job.json                                      |  30 +-
 qapi/machine-common.json                           |   4 +-
 qapi/machine-s390x.json                            |   4 +-
 qapi/machine.json                                  |  49 +--
 qapi/migration.json                                | 126 +++---
 qapi/misc-i386.json                                |   2 -
 qapi/net.json                                      |  26 +-
 qapi/qdev.json                                     |   4 +-
 qapi/qom.json                                      |  47 +--
 qapi/run-state.json                                |  20 +-
 qapi/sockets.json                                  |  30 +-
 qapi/stats.json                                    |   4 +-
 qapi/ui.json                                       |  17 +-
 qapi/virtio.json                                   |   6 +-
 qga/qapi-schema.json                               |  96 ++---
 scripts/qapi/commands.py                           |  44 +-
 scripts/qapi/parser.py                             |  50 ++-
 .../doc-bad-space-between-sentences.err            |   2 +
 .../doc-bad-space-between-sentences.json           |   6 +
 .../doc-bad-space-between-sentences.out            |   0
 tests/qapi-schema/doc-long-line.err                |   1 +
 tests/qapi-schema/doc-long-line.json               |   6 +
 tests/qapi-schema/doc-long-line.out                |   0
 tests/qapi-schema/meson.build                      |   2 +
 38 files changed, 710 insertions(+), 630 deletions(-)
 create mode 100644 tests/qapi-schema/doc-bad-space-between-sentences.err
 create mode 100644 tests/qapi-schema/doc-bad-space-between-sentences.json
 create mode 100644 tests/qapi-schema/doc-bad-space-between-sentences.out
 create mode 100644 tests/qapi-schema/doc-long-line.err
 create mode 100644 tests/qapi-schema/doc-long-line.json
 create mode 100644 tests/qapi-schema/doc-long-line.out

-- 
2.49.0



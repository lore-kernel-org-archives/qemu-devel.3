Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEAECA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrib-0001EH-9F; Wed, 30 Sep 2026 06:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriZ-0001DB-P3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriX-0006gK-GG
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=prdKHBNihSSfRbo3eEBBDW38a+mWY7Hm6K74OdmUKCM=;
 b=FiRL3W0RpagFSLsuo1A3C3JGZoV3tjFCpYnX5WnMQtKff/cft+BIGLbdjJqPbuoRK8lgg7
 2Ng8BfotQSWyXXyg/qZ+Hx1N0FBg7ktSTwSrWGWzOzwo7wgETeop6i0iGScEdSm+NqW6km
 ZJINM8sNKieLpAqXvprmzu63QblPgCw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-uEXxoflFOdyDamsusAH4SQ-1; Wed,
 30 Sep 2026 06:39:14 -0400
X-MC-Unique: uEXxoflFOdyDamsusAH4SQ-1
X-Mimecast-MFC-AGG-ID: uEXxoflFOdyDamsusAH4SQ_1790764754
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9F1E195396E; Wed, 30 Sep 2026 10:39:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CD17180035F; Wed, 30 Sep 2026 10:39:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F3B221E6A04; Wed, 30 Sep 2026 12:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 000/105] QAPI patches for 2026-09-30
Date: Wed, 30 Sep 2026 12:37:25 +0200
Message-ID: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 81ce3a87737aa50716c42db8886082d12783e0a1:

  Merge tag 'hw-misc-20260927' of https://github.com/philmd/qemu into staging (2026-09-27 02:02:29 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-09-30

for you to fetch changes up to 55ee0bd2f50f7ad52840ec8942fc128a3822f917:

  qapi: split intro sections for inlinable structs (2026-09-30 07:51:00 +0200)

----------------------------------------------------------------
QAPI patches for 2026-09-30

----------------------------------------------------------------
John Snow (105):
      qapi: convert trivial intro sections for error.json
      qapi: convert trivial intro sections for acpi-hest.json
      qapi: convert trivial intro sections for ebpf.json
      qapi: convert trivial intro sections for compat.json
      qapi: convert trivial intro sections for vfio.json
      qapi: convert trivial intro sections for trace.json
      qapi: convert trivial intro sections for misc-arm.json
      qapi: convert trivial intro sections for cryptodev.json
      qapi: convert trivial intro sections for machine-common.json
      qapi: convert trivial intro sections for accelerator.json
      qapi: convert trivial intro sections for authz.json
      qapi: convert trivial intro sections for yank.json
      qapi: convert trivial intro sections for replay.json
      qapi: convert trivial intro sections for machine-s390x.json
      qapi: convert trivial intro sections for acpi.json
      qapi: convert trivial intro sections for tpm.json
      qapi: convert trivial intro sections for qdev.json
      qapi: convert trivial intro sections for control.json
      qapi: convert trivial intro sections for dump.json
      qapi: convert trivial intro sections for common.json
      qapi: convert trivial intro sections for sockets.json
      qapi: convert trivial intro sections for transaction.json
      qapi: convert trivial intro sections for stats.json
      qapi: convert trivial intro sections for job.json
      qapi: convert trivial intro sections for pci.json
      qapi: convert trivial intro sections for introspect.json
      qapi: convert trivial intro sections for rocker.json
      qapi: convert trivial intro sections for misc-i386.json
      qapi: convert trivial intro sections for block-export.json
      qapi: convert trivial intro sections for audio.json
      qapi: convert trivial intro sections for block.json
      qapi: convert trivial intro sections for misc.json
      qapi: convert trivial intro sections for crypto.json
      qapi: convert trivial intro sections for cxl.json
      qapi: convert trivial intro sections for run-state.json
      qapi: convert trivial intro sections for char.json
      qapi: convert trivial intro sections for virtio.json
      qapi: convert trivial intro sections for net.json
      qapi: convert trivial intro sections for qom.json
      qapi: convert trivial intro sections for ui.json
      qapi: convert trivial intro sections for migration.json
      qapi: convert trivial intro sections for machine.json
      qapi: convert trivial intro sections for block-core.json
      qapi: convert simple command intros for ebpf.json
      qapi: convert simple command intros for yank.json
      qapi: convert simple command intros for replay.json
      qapi: convert simple command intros for machine-s390x.json
      qapi: convert simple command intros for dump.json
      qapi: convert simple command intros for block-export.json
      qapi: convert simple command intros for block.json
      qapi: convert simple command intros for cxl.json
      qapi: convert simple command intros for ui.json
      qapi: convert simple command intros for migration.json
      qapi: convert simple command intros for machine.json
      qapi: convert simple command intros for block-core.json
      qapi: convert simple event intros for qdev.json
      qapi: convert simple event intros for net.json
      qapi: convert simple event intros for migration.json
      qapi: convert simple event intros for machine.json
      qapi: convert simple event intros for block-core.json
      qapi: convert simple enum intros for vfio.json
      qapi: convert simple enum intros for machine-common.json
      qapi: convert simple enum intros for introspect.json
      qapi: convert simple enum intros for block.json
      qapi: convert simple enum intros for cypto.json
      qapi: convert simple enum intros for cxl.json
      qapi: convert simple enum intros for yank.json
      qapi: convert simple enum intros for migration.json
      qapi: convert simple enum intros for machine.json
      qapi: convert simple enum intros for block-core.json
      qapi: convert simple data struct intros for uefi.json
      qapi: convert simple data struct intros for misc-arm.json
      qapi: convert simple data struct intros for acpi.json
      qapi: convert simple data struct intros for run-state.json
      qapi: convert simple data struct intros for yank.json
      qapi: convert simple data struct intros for cxl.json
      qapi: convert simple data struct intros for virtio.json
      qapi: convert simple data struct intros for machine.json
      qapi: convert simple data struct intros for block-core.json
      qapi: convert simple alternate intros for common.json
      qapi: convert remaining simple intros for block-export.json
      qapi: convert remaining simple intros for cxl.json
      qapi: convert remaining simple intros for machine.json
      qapi: convert remaining simple intros for block-core.json
      qapi/parser: fix intermediate "intro" detection
      qapi: convert intro sections with "TODO" markers
      qapi: convert intro sections followed by notes/examples
      qapi: convert/split remaining qapi/qmp intro sections
      qapi: convert intro sections for unit tests
      qapi: convert trivial intros for qga/qapi-schema.json
      qapi: convert simple intros for qga/qapi-schema.json
      qapi: split intros at natural cutoff points for qga/qapi-schema.json
      qapi: split intros for qga/qapi-schema.json
      qapi: convert intro sections for docs/interop/firmware.json
      qapi: convert intro sections for docs/interop/vhost-user.json
      qapi: split intro for HV_BALLOON_STATUS_REPORT
      qapi: convert/split intros for block-core.json commands
      qapi: convert/split intros for block commands
      qapi: convert/split intros for job.json commands
      qapi: convert/split intros for misc-i386.json commands
      qapi: convert/split intros for commands
      qapi: convert/split intros for enums
      qapi: split intro sections for events
      qapi: split intro sections for data structs
      qapi: split intro sections for inlinable structs

 docs/interop/firmware.json                     |  76 +--
 docs/interop/vhost-user.json                   |  27 +-
 qapi/accelerator.json                          |  18 +-
 qapi/acpi-hest.json                            |   4 +-
 qapi/acpi.json                                 |  18 +-
 qapi/audio.json                                |  88 +--
 qapi/authz.json                                |  21 +-
 qapi/block-core.json                           | 780 ++++++++++---------------
 qapi/block-export.json                         |  95 ++-
 qapi/block.json                                |  96 ++-
 qapi/char.json                                 |  90 +--
 qapi/common.json                               |  36 +-
 qapi/compat.json                               |  16 +-
 qapi/control.json                              |  33 +-
 qapi/crypto.json                               | 127 ++--
 qapi/cryptodev.json                            |  18 +-
 qapi/cxl.json                                  | 128 ++--
 qapi/dump.json                                 |  24 +-
 qapi/ebpf.json                                 |  14 +-
 qapi/error.json                                |   3 +-
 qapi/introspect.json                           |  61 +-
 qapi/job.json                                  |  60 +-
 qapi/machine-common.json                       |  19 +-
 qapi/machine-s390x.json                        |  26 +-
 qapi/machine.json                              | 351 +++++------
 qapi/migration.json                            | 238 +++-----
 qapi/misc-arm.json                             |  20 +-
 qapi/misc-i386.json                            |  74 +--
 qapi/misc.json                                 |  85 +--
 qapi/net.json                                  | 171 ++----
 qapi/pci.json                                  |  27 +-
 qapi/qdev.json                                 |  32 +-
 qapi/qom.json                                  | 159 ++---
 qapi/replay.json                               |  45 +-
 qapi/rocker.json                               |  39 +-
 qapi/run-state.json                            | 127 ++--
 qapi/sockets.json                              |  34 +-
 qapi/stats.json                                |  39 +-
 qapi/tpm.json                                  |  29 +-
 qapi/trace.json                                |  12 +-
 qapi/transaction.json                          |  21 +-
 qapi/uefi.json                                 |   5 +-
 qapi/ui.json                                   | 218 +++----
 qapi/vfio.json                                 |  19 +-
 qapi/virtio.json                               |  91 ++-
 qapi/yank.json                                 |  30 +-
 qga/qapi-schema.json                           | 249 +++-----
 scripts/qapi/parser.py                         |   8 +
 tests/qapi-schema/doc-good.json                |   8 +-
 tests/qapi-schema/doc-good.out                 |  15 +-
 tests/qapi-schema/doc-good.txt                 |   4 +-
 tests/qapi-schema/doc-interleaved-section.err  |   2 +-
 tests/qapi-schema/doc-interleaved-section.json |   3 +-
 53 files changed, 1557 insertions(+), 2476 deletions(-)

-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C644EC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolka-0007UB-WA; Tue, 28 Jul 2026 13:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkV-0007P1-St
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkT-0005tL-Ml
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6ZPBUvZ672ny3DhYsD8itIvpc0LwQTP1ypMcFObprtg=;
 b=OTrNuALEYKwwB6pPWhA922XUycuyIOyD6ZrKQPtow7i8TxSsmFRVHfpToLp/qRFnQEuM3a
 RAUCfEusZzrpabGbhawNEKylsO1vhvLeCOcCq3rMNfi41aEtqjj/A4pHDoTG+IAnUm5FKI
 4vqQxR4th/13SUm3fKWvH1bAoD0rK9k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-LmMct0D8Puet_UWdwUpOQw-1; Tue,
 28 Jul 2026 13:37:45 -0400
X-MC-Unique: LmMct0D8Puet_UWdwUpOQw-1
X-Mimecast-MFC-AGG-ID: LmMct0D8Puet_UWdwUpOQw_1785260264
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E54919560B8; Tue, 28 Jul 2026 17:37:44 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD4EE19560AB; Tue, 28 Jul 2026 17:37:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/17] Block layer patches
Date: Tue, 28 Jul 2026 19:37:22 +0200
Message-ID: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

The following changes since commit 299e7557ed15a9a325620698add379a3ce2d1d95:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-07-27 16:51:28 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 2896bf07932af5f114ad9c507cb5a45b2983d446:

  iotests: increase timeouts for tests to 5 minutes (2026-07-28 17:55:55 +0200)

----------------------------------------------------------------
Block layer patches

- Fix missing locking in latency histogram setters
- coroutine: fix lost wakeup in qemu_co_sleep_wake()
- floppy: Fix READ/WRITE/FORMAT/READ ID behaviour with missing medium
- qcow2: Fix crash on closing a read-only image with dirty bit set
- cloop: fix integer overflow in total_sectors calculation
- dmg: Fix out of bounds accesses (CVE-2026-65929, CVE-2026-65928)
- FUSE export: fix regression with O_TRUNC when export is not growable
- iotests: Various small fixes

----------------------------------------------------------------
Christian Quante (2):
      hw/block/fdc: select the drive named by the READ ID command
      hw/block/fdc: report a missing address mark on an empty drive

Daniel P. Berrangé (1):
      iotests: increase timeouts for tests to 5 minutes

Denis V. Lunev (8):
      block/accounting: take stats->lock in latency histogram setters
      block/qapi: take stats->lock when reading BlockAcctStats for query-blockstats
      tests/unit: add reproducer for BlockAcctStats histogram locking race
      qcow2: do not try to clear the dirty bit on a read-only node
      iotests: run the test pool with the 'fork' start method
      iotests: skip FUSE tests when FUSE is not usable
      iotests/migrate-bitmaps-postcopy-test: replace the timing assertion with a content check
      coroutine: fix lost wakeup in qemu_co_sleep_wake()

Fiona Ebner (2):
      block/export/fuse: fix regression with O_TRUNC when export is not growable
      iotests: test O_TRUNC behavior for fuse exports

Stefan Hajnoczi (3):
      dmg: fix out-of-bounds load in search_chunk() (CVE-2026-65929)
      dmg: refuse to open files with no chunks
      dmg: reject inconsistent UDRW chunk sector count and length (CVE-2026-65928)

malike (1):
      block/cloop: fix integer overflow in total_sectors calculation

 include/block/accounting.h                         |   1 +
 include/qemu/coroutine.h                           |  17 +-
 block/accounting.c                                 |  11 +-
 block/cloop.c                                      |   3 +-
 block/dmg.c                                        |  36 ++++-
 block/export/fuse.c                                |  12 ++
 block/qapi.c                                       |   3 +
 block/qcow2.c                                      |   6 +-
 hw/block/fdc.c                                     |  55 ++++++-
 tests/qtest/fdc-test.c                             |  70 ++++++++-
 tests/unit/test-block-accounting.c                 | 115 ++++++++++++++
 tests/unit/test-coroutine.c                        |  53 +++++++
 util/qemu-coroutine-sleep.c                        |  53 +++++--
 tests/qemu-iotests/testrunner.py                   |   4 +-
 tests/qemu-iotests/039                             |  11 ++
 tests/qemu-iotests/039.out                         |   3 +
 tests/qemu-iotests/common.rc                       |  14 ++
 tests/qemu-iotests/meson.build                     |  15 +-
 tests/qemu-iotests/tests/file-io-error             |   4 +-
 tests/qemu-iotests/tests/fuse-allow-other          |   2 +
 tests/qemu-iotests/tests/fuse-mmap-shared          |   9 +-
 tests/qemu-iotests/tests/fuse-truncate             | 171 +++++++++++++++++++++
 tests/qemu-iotests/tests/fuse-truncate.out         |   5 +
 .../tests/migrate-bitmaps-postcopy-test            |  15 +-
 tests/unit/meson.build                             |   1 +
 25 files changed, 633 insertions(+), 56 deletions(-)
 create mode 100644 tests/unit/test-block-accounting.c
 create mode 100755 tests/qemu-iotests/tests/fuse-truncate
 create mode 100644 tests/qemu-iotests/tests/fuse-truncate.out



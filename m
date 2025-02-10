Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC30BC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWNW-0006Yz-Ry; Mon, 10 Feb 2025 11:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNE-0006TL-9b
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWN6-0000x6-MB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/qF8kczndsR8MasChgaJjH5/4k4bUkIZ09TVHks5a1w=;
 b=ciBcn/GccHNkvIUfPR2S+pOs0LaKhJ8FRdYr2j0c9UvmwhcgkS4+vT/9zaWl0RU5VFdfJA
 WxIBSx5Nb6uxqh9oSKRMVxD54tUWh401LVocaWWbUFaRVQl52GPmQ1lMz+TUkSpl7xETbD
 vwOeFNttgfNO0vzvlBo2uSLPM6Dy0Ac=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-miTvW7vsNZmV5c5PqJyXpQ-1; Mon,
 10 Feb 2025 11:10:51 -0500
X-MC-Unique: miTvW7vsNZmV5c5PqJyXpQ-1
X-Mimecast-MFC-AGG-ID: miTvW7vsNZmV5c5PqJyXpQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 049731800268; Mon, 10 Feb 2025 16:10:51 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CB041956048; Mon, 10 Feb 2025 16:10:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/25] Block layer patches
Date: Mon, 10 Feb 2025 17:10:09 +0100
Message-ID: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit d922088eb4ba6bc31a99f17b32cf75e59dd306cd:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-02-03 13:42:02 -0500)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to fc4e394b2887e15d5f83994e4fc7b26c895c627a:

  block: remove unused BLOCK_OP_TYPE_DATAPLANE (2025-02-06 14:51:10 +0100)

----------------------------------------------------------------
Block layer patches

- Managing inactive nodes (enables QSD migration with shared storage)
- Fix swapped values for BLOCK_IO_ERROR 'device' and 'qom-path'
- vpc: Read images exported from Azure correctly
- scripts/qemu-gdb: Support coroutine dumps in coredumps
- Minor cleanups

----------------------------------------------------------------
Fabiano Rosas (1):
      block: Fix leak in send_qmp_error_event

Kevin Wolf (16):
      block: Add 'active' field to BlockDeviceInfo
      block: Allow inactivating already inactive nodes
      block: Inactivate external snapshot overlays when necessary
      migration/block-active: Remove global active flag
      block: Don't attach inactive child to active node
      block: Fix crash on block_resize on inactive node
      block: Add option to create inactive nodes
      block: Add blockdev-set-active QMP command
      block: Support inactive nodes in blk_insert_bs()
      block/export: Don't ignore image activation error in blk_exp_add()
      block: Drain nodes before inactivating them
      block/export: Add option to allow export of inactive nodes
      nbd/server: Support inactive nodes
      iotests: Add filter_qtest()
      iotests: Add qsd-migrate case
      iotests: Add (NBD-based) tests for inactive nodes

Peter Krempa (1):
      block-backend: Fix argument order when calling 'qapi_event_send_block_io_error()'

Peter Xu (3):
      scripts/qemu-gdb: Always do full stack dump for python errors
      scripts/qemu-gdb: Simplify fs_base fetching for coroutines
      scripts/qemu-gdb: Support coroutine dumps in coredumps

Philippe Mathieu-Daudé (1):
      block: Improve blk_get_attached_dev_id() docstring

Stefan Hajnoczi (1):
      block: remove unused BLOCK_OP_TYPE_DATAPLANE

Vitaly Kuznetsov (2):
      vpc: Split off vpc_ignore_current_size() helper
      vpc: Read images exported from Azure correctly

 qapi/block-core.json                           |  44 +++-
 qapi/block-export.json                         |  10 +-
 include/block/block-common.h                   |   2 +-
 include/block/block-global-state.h             |   6 +
 include/block/export.h                         |   3 +
 include/system/block-backend-io.h              |   7 +
 migration/migration.h                          |   3 -
 block.c                                        |  64 +++++-
 block/block-backend.c                          |  32 ++-
 block/export/export.c                          |  29 ++-
 block/monitor/block-hmp-cmds.c                 |   5 +-
 block/qapi.c                                   |   1 +
 block/replication.c                            |   1 -
 block/vpc.c                                    |  65 +++---
 blockdev.c                                     |  48 ++++
 blockjob.c                                     |   2 -
 hw/block/virtio-blk.c                          |   9 -
 hw/scsi/virtio-scsi.c                          |   3 -
 migration/block-active.c                       |  46 ----
 migration/migration.c                          |   8 -
 nbd/server.c                                   |  17 ++
 scripts/qemu-gdb.py                            |   2 +
 scripts/qemugdb/coroutine.py                   | 102 ++++++---
 tests/qemu-iotests/iotests.py                  |   8 +
 tests/qemu-iotests/041                         |   4 +-
 tests/qemu-iotests/165                         |   4 +-
 tests/qemu-iotests/184.out                     |   2 +
 tests/qemu-iotests/191.out                     |  16 ++
 tests/qemu-iotests/273.out                     |   5 +
 tests/qemu-iotests/tests/copy-before-write     |   3 +-
 tests/qemu-iotests/tests/inactive-node-nbd     | 303 +++++++++++++++++++++++++
 tests/qemu-iotests/tests/inactive-node-nbd.out | 239 +++++++++++++++++++
 tests/qemu-iotests/tests/migrate-bitmaps-test  |   7 +-
 tests/qemu-iotests/tests/qsd-migrate           | 140 ++++++++++++
 tests/qemu-iotests/tests/qsd-migrate.out       |  59 +++++
 35 files changed, 1133 insertions(+), 166 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/inactive-node-nbd
 create mode 100644 tests/qemu-iotests/tests/inactive-node-nbd.out
 create mode 100755 tests/qemu-iotests/tests/qsd-migrate
 create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB25C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 17:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdY6C-0000ZB-7S; Thu, 30 Jan 2025 12:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY6A-0000YO-TK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY65-00039A-GZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738257174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=usGPd3+ctEkVEQKIEtGtMNksxKLOXRfe9j74lWsbylQ=;
 b=KIFJPtg2Lqo7K3u3PdTlniRSMdqnGWzH3YrqACNxCRMGE/W+oZbqKWe1271Q49hswfLI86
 lXfszc3wderik3qUIl1zMpGqRKFGhVeJsw1NmvHVSh2m7jg2X/W7UEywrbA66k6nZczPf5
 6XkMhyMCJBij5+676gMAjZnPUSsyTTU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-u9kRERZROZWuf9bVC-X85g-1; Thu,
 30 Jan 2025 12:12:50 -0500
X-MC-Unique: u9kRERZROZWuf9bVC-X85g-1
X-Mimecast-MFC-AGG-ID: u9kRERZROZWuf9bVC-X85g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40CD719560B2; Thu, 30 Jan 2025 17:12:49 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD8F730001BE; Thu, 30 Jan 2025 17:12:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v2 00/15] block: Managing inactive nodes (QSD migration)
Date: Thu, 30 Jan 2025 18:12:31 +0100
Message-ID: <20250130171240.286878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This series adds a mechanism that allows the user or management tool to
manually activate and inactivate block nodes instead of fully relying on
the automatic management in the migration code.

One case where this is needed is for migration with shared storage and
devices backed by qemu-storage-daemon, which as an external process is
not involved in the VM migration. Management tools can manually
orchestrate the handover in this scenario. The new qemu-iotests case
qsd-migrate demonstrates this.

There are other cases without qemu-storage-daemon where manual
management is necessary. For example, after migration, the destination
VM only activates images on 'cont', but after migrating a paused VM, the
user may want to perform operations on a block node while the VM is
still paused.

This series adds support for block exports on an inactive node (needed
for shared storage migration with qemu-storage-daemon) only to NBD.
Adding it to other export types will be done in a future series.

v2:
- Added a comprehensive test case that tests how inactive nodes
  interoperate with many operations
- Added a couple of fixes for bugs uncovered by the tests (that would
  usually lead to crashes when an unsupported operation is performed on
  inactive nodes)
- Added 'active' status to query-block information

Kevin Wolf (15):
  block: Add 'active' field to BlockDeviceInfo
  block: Inactivate external snapshot overlays when necessary
  migration/block-active: Remove global active flag
  block: Don't attach inactive child to active node
  block: Allow inactivating already inactive nodes
  block: Fix crash on block_resize on inactive node
  block: Add option to create inactive nodes
  block: Add blockdev-set-active QMP command
  block: Support inactive nodes in blk_insert_bs()
  block/export: Don't ignore image activation error in blk_exp_add()
  block/export: Add option to allow export of inactive nodes
  nbd/server: Support inactive nodes
  iotests: Add filter_qtest()
  iotests: Add qsd-migrate case
  iotests: Add (NBD-based) tests for inactive nodes

 qapi/block-core.json                          |  44 ++-
 qapi/block-export.json                        |  10 +-
 include/block/block-common.h                  |   1 +
 include/block/block-global-state.h            |   6 +
 include/block/export.h                        |   3 +
 migration/migration.h                         |   3 -
 block.c                                       |  62 +++-
 block/block-backend.c                         |  16 +-
 block/export/export.c                         |  29 +-
 block/monitor/block-hmp-cmds.c                |   5 +-
 block/qapi.c                                  |   1 +
 blockdev.c                                    |  48 +++
 migration/block-active.c                      |  46 ---
 migration/migration.c                         |   8 -
 nbd/server.c                                  |  17 +
 tests/qemu-iotests/iotests.py                 |   8 +
 tests/qemu-iotests/041                        |   4 +-
 tests/qemu-iotests/165                        |   4 +-
 tests/qemu-iotests/184.out                    |   2 +
 tests/qemu-iotests/191.out                    |  16 +
 tests/qemu-iotests/273.out                    |   5 +
 tests/qemu-iotests/tests/copy-before-write    |   3 +-
 tests/qemu-iotests/tests/inactive-node-nbd    | 303 ++++++++++++++++++
 .../qemu-iotests/tests/inactive-node-nbd.out  | 239 ++++++++++++++
 tests/qemu-iotests/tests/migrate-bitmaps-test |   7 +-
 tests/qemu-iotests/tests/qsd-migrate          | 132 ++++++++
 tests/qemu-iotests/tests/qsd-migrate.out      |  51 +++
 27 files changed, 986 insertions(+), 87 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/inactive-node-nbd
 create mode 100644 tests/qemu-iotests/tests/inactive-node-nbd.out
 create mode 100755 tests/qemu-iotests/tests/qsd-migrate
 create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out

-- 
2.48.1



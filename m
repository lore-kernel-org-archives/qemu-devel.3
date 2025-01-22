Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270B4C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 11:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZGY-0002WU-Np; Wed, 22 Jan 2025 06:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZGV-0002Tz-8p
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:51:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taZGR-00084Z-FO
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 06:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737546677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XxJdYSqB1OrxPSS/sqz/Tl+I9kros+QMSq9QNTHNmlw=;
 b=D5sGyvQ5Botmjayz8hP1p4CNfMuCeZdcY+R3kSCdFuokWf97UoOpWlvG+7P3lWjZgflDPY
 udZ/nmStl+ae80XZVIQQMQ+R78ror15t/alZVNthnTEFDjf7NzhX/D2ri0ZwdDpqnqO7QO
 7Heic7QXJnAYIkDh/ma/efaNMnlP0Uw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-sAXbIUI1Neuz_X1-ZcejCw-1; Wed,
 22 Jan 2025 06:51:15 -0500
X-MC-Unique: sAXbIUI1Neuz_X1-ZcejCw-1
X-Mimecast-MFC-AGG-ID: sAXbIUI1Neuz_X1-ZcejCw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE3AC19560B1; Wed, 22 Jan 2025 11:51:14 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.195])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9952619560AA; Wed, 22 Jan 2025 11:51:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pkrempa@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/9] block: Managing inactive nodes (QSD migration)
Date: Wed, 22 Jan 2025 12:50:37 +0100
Message-ID: <20250122115046.51216-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Kevin Wolf (9):
  block: Allow inactivating already inactive nodes
  block: Add option to create inactive nodes
  block: Support inactive nodes in blk_insert_bs()
  block/export: Don't ignore image activation error in blk_exp_add()
  block/export: Add option to allow export of inactive nodes
  nbd/server: Support inactive nodes
  block: Add blockdev-set-active QMP command
  iotests: Add filter_qtest()
  iotests: Add qsd-migrate case

 qapi/block-core.json                          |  38 +++++
 qapi/block-export.json                        |  10 +-
 include/block/block-common.h                  |   1 +
 include/block/block-global-state.h            |   6 +
 include/block/export.h                        |   3 +
 block.c                                       |  50 ++++++-
 block/block-backend.c                         |  14 +-
 block/export/export.c                         |  29 +++-
 blockdev.c                                    |  32 +++++
 nbd/server.c                                  |  17 +++
 tests/qemu-iotests/iotests.py                 |   4 +
 tests/qemu-iotests/041                        |   4 +-
 tests/qemu-iotests/165                        |   4 +-
 tests/qemu-iotests/tests/copy-before-write    |   3 +-
 tests/qemu-iotests/tests/migrate-bitmaps-test |   7 +-
 tests/qemu-iotests/tests/qsd-migrate          | 132 ++++++++++++++++++
 tests/qemu-iotests/tests/qsd-migrate.out      |  51 +++++++
 17 files changed, 379 insertions(+), 26 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/qsd-migrate
 create mode 100644 tests/qemu-iotests/tests/qsd-migrate.out

-- 
2.48.1



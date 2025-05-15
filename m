Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2F0C3ABD8
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 02:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOLg-0007CB-3z; Wed, 14 May 2025 22:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLU-0007Bm-JZ
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLS-00044B-M3
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747276152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CSjtLjdmg2pljM7Z0norGwciOvLC/a5/5WDbKA1Qjoo=;
 b=JD4I7xKXgLG/57iz6tjLbwUd5l1jdwUJVV9nV8M7nM94c6WDuRHgqG1SOHz9T6syjLIcAm
 JB0IFspJ3CFKP41oaSW8iPTWoEAb5Yy9w7OuuiOpYVPPIqsLuJso2vVsCn0FGlXUbrNAK3
 ZHVoups9tG0iCmzAt+Wc/MbfnDw3C8U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-GrfV4xYjMP-1hfXcHnMmIg-1; Wed,
 14 May 2025 22:29:10 -0400
X-MC-Unique: GrfV4xYjMP-1hfXcHnMmIg-1
X-Mimecast-MFC-AGG-ID: GrfV4xYjMP-1hfXcHnMmIg_1747276150
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4F6B1800360
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 02:29:09 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AA2A1955F24
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 02:29:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] NBD patches for 2025-05-14
Date: Wed, 14 May 2025 21:28:43 -0500
Message-ID: <20250515022904.575509-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

The following changes since commit 864813878951b44e964eb4c012d832fd21f8cc0c:

  Merge tag 'pull-loongarch-20250514' of https://github.com/gaosong715/qemu into staging (2025-05-14 07:16:57 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2025-05-14

for you to fetch changes up to aff46b4bf556430dd3c12fa39a457f0487bb0053:

  mirror: Reduce I/O when destination is detect-zeroes:unmap (2025-05-14 21:27:04 -0500)

----------------------------------------------------------------
NBD patches for 2025-05-14

- Eric Blake: fix blockdev-mirror to no longer inflate sparse destination
  that already reads as zero

----------------------------------------------------------------
Andrey Drobyshev (1):
      iotests/common.rc: add disk_usage function

Eric Blake (13):
      block: Expand block status mode from bool to flags
      file-posix, gluster: Handle zero block status hint better
      block: Let bdrv_co_is_zero_fast consolidate adjacent extents
      block: Add new bdrv_co_is_all_zeroes() function
      iotests: Improve iotest 194 to mirror data
      mirror: Minor refactoring
      mirror: Pass full sync mode rather than bool to internals
      mirror: Allow QMP override to declare target already zero
      mirror: Drop redundant zero_target parameter
      mirror: Skip pre-zeroing destination if it is already zero
      mirror: Skip writing zeroes when target is already zero
      tests: Add iotest mirror-sparse for recent patches
      mirror: Reduce I/O when destination is detect-zeroes:unmap

 qapi/block-core.json                       |   8 +-
 block/coroutines.h                         |   4 +-
 include/block/block-common.h               |  11 +
 include/block/block-io.h                   |   2 +
 include/block/block_int-common.h           |  27 ++-
 include/block/block_int-global-state.h     |   4 +-
 include/block/block_int-io.h               |   4 +-
 block/io.c                                 | 126 +++++++---
 block/blkdebug.c                           |   6 +-
 block/copy-before-write.c                  |   4 +-
 block/file-posix.c                         |   5 +-
 block/gluster.c                            |   4 +-
 block/iscsi.c                              |   6 +-
 block/mirror.c                             | 190 +++++++++++----
 block/nbd.c                                |   4 +-
 block/null.c                               |   6 +-
 block/parallels.c                          |   6 +-
 block/qcow.c                               |   2 +-
 block/qcow2.c                              |   6 +-
 block/qed.c                                |   6 +-
 block/quorum.c                             |   4 +-
 block/raw-format.c                         |   4 +-
 block/rbd.c                                |   6 +-
 block/snapshot-access.c                    |   4 +-
 block/vdi.c                                |   4 +-
 block/vmdk.c                               |   2 +-
 block/vpc.c                                |   2 +-
 block/vvfat.c                              |   6 +-
 blockdev.c                                 |  31 +--
 tests/unit/test-block-iothread.c           |   2 +-
 tests/qemu-iotests/common.rc               |   6 +
 tests/qemu-iotests/194                     |   7 +-
 tests/qemu-iotests/194.out                 |   4 +-
 tests/qemu-iotests/250                     |   5 -
 tests/qemu-iotests/iotests.py              |  12 +-
 tests/qemu-iotests/tests/mirror-sparse     | 125 ++++++++++
 tests/qemu-iotests/tests/mirror-sparse.out | 365 +++++++++++++++++++++++++++++
 37 files changed, 856 insertions(+), 164 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/mirror-sparse
 create mode 100644 tests/qemu-iotests/tests/mirror-sparse.out

-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54528CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXG0G-0000PS-0T; Wed, 10 Jun 2026 06:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wXG0D-0000OQ-RC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wXG0C-0005vh-BU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781086659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v+NZz8eWkum+on6Kkpc3UjroCaRCxVTFw49Ij05hB0Y=;
 b=U2wn4urIaZGFBirAbzgB9Q4JC80x3RV/j68aSmfy00m3jqdoWSC9EPguVcRa5glz9J7imw
 TOf5xq1do2JuLPw1uQb7ugkBTUtBlkqf8P2y2ccvc3O0kf3c1TKPZfeHbScOTHJFCBpSUP
 tpRFQduJQF4YVtGrO1p+7M/C0AaGmbY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-YzUCTcTnOUGVXT-_ydedIg-1; Wed,
 10 Jun 2026 06:17:36 -0400
X-MC-Unique: YzUCTcTnOUGVXT-_ydedIg-1
X-Mimecast-MFC-AGG-ID: YzUCTcTnOUGVXT-_ydedIg_1781086655
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 580761955F12; Wed, 10 Jun 2026 10:17:35 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.216])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71DF618005B3; Wed, 10 Jun 2026 10:17:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL v2 0/8] Block layer patches
Date: Wed, 10 Jun 2026 12:17:30 +0200
Message-ID: <20260610101730.42427-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The following changes since commit cc329c491768b2d91eb0b0984f3baa0bf805776d:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-06-08 09:30:30 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 7e573b660fefdebd21cb755d0d34bb5942fd3af3:

  qed: Don't try to flush during incoming migration (2026-06-10 12:12:48 +0200)

v2:
- Fixed up test case fuse-mmap-shared to declare luks unsupported

----------------------------------------------------------------
Block layer patches

- qcow2: Fix data loss on zero write with detect-zeroes=unmap
- qemu-img bitmap: add sub-command --remove-all
- export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression
- virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-48914)
- qed: Don't try to flush during incoming migration
- iotests/136: Test stats-intervals with -blockdev/-device

----------------------------------------------------------------
Denis V. Lunev (1):
      qemu-img: add sub-command --remove-all to 'qemu-img bitmap'

Fabiano Rosas (1):
      qed: Don't try to flush during incoming migration

Fiona Ebner (3):
      block/export/fuse: use struct fuse_init_in
      block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression
      iotests: test shared mmap for fuse export

Kevin Wolf (1):
      iotests/136: Test stats-intervals with -blockdev/-device

Stefan Hajnoczi (1):
      virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check (CVE-2026-48914)

Thomas Lamprecht (1):
      qcow2: Fix data loss on zero write with detect-zeroes=unmap

 docs/tools/qemu-img.rst                       |  10 ++-
 block/qcow2.h                                 |   4 +
 block/export/fuse.c                           |  69 +++++++++++++----
 block/qcow2-cluster.c                         |  10 +--
 block/qcow2.c                                 |   8 +-
 block/qed.c                                   |  16 ++--
 hw/block/virtio-blk.c                         |   8 +-
 qemu-img.c                                    |  55 ++++++++++++--
 tests/qemu-iotests/046                        |  23 ++++++
 tests/qemu-iotests/046.out                    |  10 +++
 tests/qemu-iotests/136                        |  87 ++++++++++++++++++---
 tests/qemu-iotests/136.out                    |   4 +-
 tests/qemu-iotests/tests/fuse-mmap-shared     | 105 ++++++++++++++++++++++++++
 tests/qemu-iotests/tests/fuse-mmap-shared.out |   5 ++
 tests/qemu-iotests/tests/qemu-img-bitmaps     |  24 ++++++
 tests/qemu-iotests/tests/qemu-img-bitmaps.out |  46 +++++++++++
 16 files changed, 432 insertions(+), 52 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/fuse-mmap-shared
 create mode 100644 tests/qemu-iotests/tests/fuse-mmap-shared.out



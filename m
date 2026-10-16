Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6609DCCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHn0w-0006XN-I0; Fri, 16 Oct 2026 14:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xHn0v-0006X5-07
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xHn0s-0005ok-OG
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792176641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6qcVYB6Rn5J5Z05c+gv0oAHugOFX8YogPh4p6DX4dek=;
 b=J3ztV+r2rowhDq7iGwpvqm5vr/kQcIr9pHgtQIiWOYq4bjUPXUU0EKizMP5mZwuwkNMvry
 hCQh8puA7GdwP/53sBkEitFxdU5zOJiyEDI9tTDRHAyrDkva/juDkklKDtt2q4zekN6qzx
 YlCHAt8sML1DhI9zuXwQqo20CO/2/HE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-nJcPH4M-OtmBGOzdy5U9cw-1; Fri,
 16 Oct 2026 18:50:39 +0000
X-MC-Unique: nJcPH4M-OtmBGOzdy5U9cw-1
X-Mimecast-MFC-AGG-ID: nJcPH4M-OtmBGOzdy5U9cw_1792176638
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7671F18004AD
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:50:38 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 035391956089
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:50:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 00/13] NBD patches through 2026-10-08
Date: Fri, 16 Oct 2026 13:48:24 -0500
Message-ID: <20261016185029.1275855-15-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit a19f59a72d96056d9a8f48cf6c77f5787491e414:

  Merge tag 'pull-hex-20261015' of https://github.com/qualcomm/qemu into staging (2026-10-16 07:50:02 +0200)

are available in the Git repository at:

  https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-10-08-v4

for you to fetch changes up to 137374d861a3507e18d9154c5266e20c92371e20:

  iotests/iothreads-nbd-export: Skip on s390 (2026-10-16 10:23:05 -0500)

[v4: Drop 2 patches from Guillaume Vinke while we sort out testsuite issues]

----------------------------------------------------------------
NBD patches through 2026-10-08

Several fixes, including:
- Eric Blake: Update MAINTAINERS, support qemu-nbd -s -l
- Fiona Ebner: Report flush error on qemu-img convert
- Denis V. Lunev: Fix postcopy dirty bitmap migration
- Eric Farman: Several iotest improvements

----------------------------------------------------------------
Denis V. Lunev (3):
      migration: add QEMU_COUNTED_STRING_SIZE for counted string buffers
      migration/block-dirty-bitmap: fix postcopy abort with bitmaps on several nodes
      iotests/migrate-bitmaps-postcopy-test: add a bitmap on a second node

Eric Blake (2):
      maint: Update eblake's staging repo
      qemu-nbd: Support -s and -l at the same time

Eric Farman (4):
      iotests/nbd-in-qcow2-chain: use default machine
      iotests/nbd-tls-iothread: skip on non-x86 hardware
      iotests/fuse-truncate: skip if FUSE is not usable
      iotests/iothreads-nbd-export: Skip on s390

Fiona Ebner (4):
      iotests: add test cases for failing flush after qemu-img convert
      iotests.py: add filter_qemu()
      block: report flush error during bdrv_close()
      qemu-img: convert: flush target image after copying

 docs/tools/qemu-nbd.rst                            |  7 +-
 include/migration/qemu-file-types.h                |  6 +-
 block.c                                            | 13 +++-
 migration/block-dirty-bitmap.c                     | 62 ++++++++++++++--
 migration/qemu-file.c                              |  5 +-
 qemu-img.c                                         |  8 ++-
 qemu-nbd.c                                         | 22 +++++-
 MAINTAINERS                                        |  4 +-
 tests/qemu-iotests/026                             | 10 +--
 tests/qemu-iotests/026.out                         | 84 ++++++++++++++++++++++
 tests/qemu-iotests/071                             |  2 +-
 tests/qemu-iotests/071.out                         |  2 +
 tests/qemu-iotests/080.out                         |  2 +
 tests/qemu-iotests/098.out                         |  4 ++
 tests/qemu-iotests/122                             | 33 +++++++++
 tests/qemu-iotests/122.out                         | 17 +++++
 tests/qemu-iotests/244                             |  2 +-
 tests/qemu-iotests/244.out                         |  1 +
 tests/qemu-iotests/iotests.py                      |  4 ++
 tests/qemu-iotests/tests/file-io-error             |  2 +-
 tests/qemu-iotests/tests/file-io-error.out         |  2 +
 tests/qemu-iotests/tests/fuse-truncate             |  9 ++-
 tests/qemu-iotests/tests/iothreads-nbd-export      |  5 ++
 .../tests/migrate-bitmaps-postcopy-test            | 22 ++++++
 tests/qemu-iotests/tests/nbd-in-qcow2-chain        |  2 +-
 tests/qemu-iotests/tests/nbd-tls-iothread          |  4 ++
 tests/qemu-iotests/tests/qemu-nbd-snapshots        | 81 +++++++++++++++++++++
 tests/qemu-iotests/tests/qemu-nbd-snapshots.out    | 39 ++++++++++
 tests/qemu-iotests/tests/qsd-migrate               |  5 +-
 tests/qemu-iotests/tests/qsd-migrate.out           |  1 +
 30 files changed, 427 insertions(+), 33 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/qemu-nbd-snapshots
 create mode 100644 tests/qemu-iotests/tests/qemu-nbd-snapshots.out

-- 
2.56.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00A2CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrA-00080G-Dq; Tue, 19 May 2026 13:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNr3-0007xk-84
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNqw-000450-L4
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GyuLb4b27pyYkovXVszFJ4DvVAecnzghmIVxmdOWP+A=;
 b=LStJB94wH8vKD5LTjWqsbqdgg02KmOPcanlyjxouIfOE/8X7dOC5AbJ9e2I7o5u3raYXVo
 iX1ScWQuwX08FuaJT1DKfu+wlvgX6IVw5y23HTmbRU4EqDeslfnIwAo7+GVxpDwu7f2kRI
 HaPm0411Zc6dA+l5ty629AjZeoXSyNo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-92GJd4CXPaW6xCfOxiCc-g-1; Tue,
 19 May 2026 13:03:28 -0400
X-MC-Unique: 92GJd4CXPaW6xCfOxiCc-g-1
X-Mimecast-MFC-AGG-ID: 92GJd4CXPaW6xCfOxiCc-g_1779210208
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E67F31956058; Tue, 19 May 2026 17:03:27 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D54A1681; Tue, 19 May 2026 17:03:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/18] Block layer patches
Date: Tue, 19 May 2026 19:02:59 +0200
Message-ID: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 6d17fd91f6cf88df5cb2205e578640d72605cc43:

  Merge tag 'pull-nvme-20260518' of https://gitlab.com/birkelund/qemu into staging (2026-05-18 08:33:20 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 8b663f7d0d96d915d0e0fc5923dc6cc36133f19f:

  block: Improve readability in HMP 'info blockstats' output (2026-05-19 17:34:13 +0200)

----------------------------------------------------------------
Block layer patches

- qcow2: Fix corruption on discard during write with COW
- Remove the deprecated glusterfs block driver
- graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()
- ide: Fix deadlock between TRIM and drain
- scsi: Fix discard_granularity for -drive if=scsi
- blkdebug: Add 'delay-ns' option
- qemu-io: Add 'aio_discard' command
- Improve readability in HMP 'info blockstats' output
- MAINTAINERS: Lukas Straub will maintain COLO block replication

----------------------------------------------------------------
Denis V. Lunev (1):
      block/graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()

Kevin Wolf (14):
      blkdebug: Add 'delay-ns' option
      block: Add blk_co_start/end_request() and BDRV_REQ_NO_QUEUE
      block: Add flags parameter to blk_*_pdiscard()
      ide: Minimal fix for deadlock between TRIM and drain
      ide: Clean up ide_trim_co_entry() to be idiomatic coroutine code
      ide-test: Factor out wait_dma_completion()
      ide-test: Test reset during TRIM
      block: Create DEFAULT_BLOCK_CONF macro
      block: Add more defaults to DEFAULT_BLOCK_CONF
      commit: Drain nodes across all of bdrv_commit()
      qemu-io: Add 'aio_discard' command
      qcow2: Fix corruption on discard during write with COW
      iotests/046: Test that discard/write_zeroes wait for dependencies
      block: Improve readability in HMP 'info blockstats' output

Lukas Straub (2):
      MAINTAINERS: Add myself as maintainer for replication
      MAINTAINERS: Rename Replication -> COLO block replication

Thomas Huth (1):
      Remove the deprecated glusterfs block driver

 qapi/block-core.json                               |   56 +-
 docs/about/deprecated.rst                          |    8 -
 docs/about/removed-features.rst                    |    7 +
 docs/system/device-url-syntax.rst.inc              |   39 -
 docs/system/qemu-block-drivers.rst.inc             |   84 -
 meson_options.txt                                  |    2 -
 include/block/block-common.h                       |   11 +-
 include/hw/block/block.h                           |   12 +
 include/system/block-backend-io.h                  |    6 +-
 block/blkdebug.c                                   |   15 +-
 block/block-backend.c                              |   47 +-
 block/commit.c                                     |   10 +-
 block/export/virtio-blk-handler.c                  |    2 +-
 block/gluster.c                                    | 1644 --------------------
 block/graph-lock.c                                 |   12 +-
 block/mirror.c                                     |    4 +-
 block/monitor/block-hmp-cmds.c                     |   38 +-
 block/qcow2-cluster.c                              |   52 +-
 hw/ide/core.c                                      |  110 +-
 hw/scsi/scsi-bus.c                                 |    7 +-
 nbd/server.c                                       |    2 +-
 qemu-io-cmds.c                                     |  117 +-
 tests/qtest/ide-test.c                             |  137 +-
 tests/qtest/modules-test.c                         |    3 -
 tests/unit/test-block-iothread.c                   |    4 +-
 MAINTAINERS                                        |   11 +-
 block/meson.build                                  |    1 -
 meson.build                                        |   47 -
 scripts/ci/setup/debian/debian-13-ppc64le.yaml     |    1 -
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml   |    1 -
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml     |    1 -
 scripts/coverity-scan/coverity-scan.docker         |    1 -
 scripts/coverity-scan/run-coverity-scan            |    2 +-
 scripts/meson-buildoptions.sh                      |    3 -
 tests/docker/dockerfiles/debian-amd64-cross.docker |    1 -
 tests/docker/dockerfiles/debian-arm64-cross.docker |    1 -
 .../dockerfiles/debian-mips64el-cross.docker       |    1 -
 .../docker/dockerfiles/debian-mipsel-cross.docker  |    1 -
 .../docker/dockerfiles/debian-ppc64el-cross.docker |    1 -
 .../docker/dockerfiles/debian-riscv64-cross.docker |    1 -
 tests/docker/dockerfiles/debian-s390x-cross.docker |    1 -
 tests/docker/dockerfiles/debian.docker             |    1 -
 .../docker/dockerfiles/fedora-rust-nightly.docker  |    1 -
 tests/docker/dockerfiles/fedora.docker             |    1 -
 tests/docker/dockerfiles/opensuse-leap.docker      |    1 -
 tests/docker/dockerfiles/ubuntu2204.docker         |    1 -
 tests/lcitool/projects/qemu.yml                    |    1 -
 tests/qemu-iotests/046                             |   46 +
 tests/qemu-iotests/046.out                         |   36 +
 49 files changed, 537 insertions(+), 2055 deletions(-)
 delete mode 100644 block/gluster.c



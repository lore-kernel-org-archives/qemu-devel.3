Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71392C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 12:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTLJg-0004I5-Lz; Fri, 26 Jan 2024 07:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rTLIv-0004F0-HC
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:27:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rTLIq-0007vU-Tg
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706272043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7NLPlPPy0eADiZ8x6/oAdIl7VtdYPmKJZ8r4XucyrWM=;
 b=EAzNHjsFF/3AyB45B+uADLAQ4ECttqnuJgmRz5dFBkuDGQ27l6ExndTAbO7dwcZDTLxTDi
 jG745lbilgc9iMf33ki4Ip+FeIc9uSnLmwM2DeJMUXi20jeqiZ19pNcfzA987yZvVaKZbb
 opNb0Pfokz27CQxUePbrnry58Osv9YQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-RtPTRc6KNYCUaQFBAJz26g-1; Fri, 26 Jan 2024 07:27:20 -0500
X-MC-Unique: RtPTRc6KNYCUaQFBAJz26g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 678FE884341;
 Fri, 26 Jan 2024 12:27:20 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D26D01C060AF;
 Fri, 26 Jan 2024 12:27:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL v3 00/18] Block layer patches
Date: Fri, 26 Jan 2024 13:27:17 +0100
Message-ID: <20240126122717.221575-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit 5bab95dc74d43bbb28c6a96d24c810a664432057:

  Merge tag 'pull-request-2024-01-24' of https://gitlab.com/thuth/qemu into staging (2024-01-25 12:33:42 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to acf2b9fce9f402b070a65bea584582df0378da9e:

  iotests/277: Use iotests.sock_dir for socket creation (2024-01-26 12:27:41 +0100)

----------------------------------------------------------------
Block layer patches

- virtio-blk: Multiqueue fixes and cleanups
- blklogwrites: Fixes for write_zeroes and superblock update races
- commit/stream: Allow users to request only format driver names in
  backing file format
- monitor: only run coroutine commands in qemu_aio_context
- Some iotest fixes

----------------------------------------------------------------
Andrey Drobyshev (2):
      iotests/264: Use iotests.sock_dir for socket creation
      iotests/277: Use iotests.sock_dir for socket creation

Ari Sundholm (2):
      block/blklogwrites: Fix a bug when logging "write zeroes" operations.
      block/blklogwrites: Protect mutable driver state with a mutex.

Kevin Wolf (3):
      string-output-visitor: Fix (pseudo) struct handling
      tests/unit: Bump test-replication timeout to 60 seconds
      iotests/iothreads-stream: Use the right TimeoutError

Peter Krempa (2):
      commit: Allow users to request only format driver names in backing file format
      stream: Allow users to request only format driver names in backing file format

Stefan Hajnoczi (9):
      iotests: add filter_qmp_generated_node_ids()
      iotests: port 141 to Python for reliable QMP testing
      monitor: only run coroutine commands in qemu_aio_context
      virtio-blk: move dataplane code into virtio-blk.c
      virtio-blk: rename dataplane create/destroy functions
      virtio-blk: rename dataplane to ioeventfd
      virtio-blk: restart s->rq reqs in vq AioContexts
      virtio-blk: tolerate failure to set BlockBackend AioContext
      virtio-blk: always set ioeventfd during startup

 qapi/block-core.json                          |  17 +-
 hw/block/dataplane/trace.h                    |   1 -
 hw/block/dataplane/virtio-blk.h               |  34 ---
 include/block/block-global-state.h            |   3 +-
 include/block/block_int-common.h              |   4 +-
 include/block/block_int-global-state.h        |   6 +
 include/hw/virtio/virtio-blk.h                |  16 +-
 block.c                                       |  37 ++-
 block/blklogwrites.c                          | 120 ++++++--
 block/commit.c                                |   6 +-
 block/monitor/block-hmp-cmds.c                |   2 +-
 block/stream.c                                |  10 +-
 blockdev.c                                    |  13 +
 hw/block/dataplane/virtio-blk.c               | 404 -------------------------
 hw/block/virtio-blk.c                         | 412 ++++++++++++++++++++++++--
 monitor/qmp.c                                 |  17 --
 qapi/qmp-dispatch.c                           |  24 +-
 qapi/string-output-visitor.c                  |  46 +++
 tests/unit/test-bdrv-drain.c                  |   3 +-
 tests/qemu-iotests/iotests.py                 |   7 +
 hw/block/dataplane/meson.build                |   1 -
 hw/block/dataplane/trace-events               |   5 -
 meson.build                                   |   1 -
 tests/qemu-iotests/060.out                    |   4 +-
 tests/qemu-iotests/071.out                    |   4 +-
 tests/qemu-iotests/081.out                    |  16 +-
 tests/qemu-iotests/087.out                    |  12 +-
 tests/qemu-iotests/108.out                    |   2 +-
 tests/qemu-iotests/109                        |   4 +-
 tests/qemu-iotests/109.out                    |  78 +++--
 tests/qemu-iotests/117.out                    |   2 +-
 tests/qemu-iotests/120.out                    |   2 +-
 tests/qemu-iotests/127.out                    |   2 +-
 tests/qemu-iotests/140.out                    |   2 +-
 tests/qemu-iotests/141                        | 307 ++++++++-----------
 tests/qemu-iotests/141.out                    | 200 +++----------
 tests/qemu-iotests/143.out                    |   2 +-
 tests/qemu-iotests/156.out                    |   2 +-
 tests/qemu-iotests/176.out                    |  16 +-
 tests/qemu-iotests/182.out                    |   2 +-
 tests/qemu-iotests/183.out                    |   4 +-
 tests/qemu-iotests/184.out                    |  32 +-
 tests/qemu-iotests/185                        |   6 +-
 tests/qemu-iotests/185.out                    |  45 ++-
 tests/qemu-iotests/191.out                    |  16 +-
 tests/qemu-iotests/195.out                    |  16 +-
 tests/qemu-iotests/223.out                    |  12 +-
 tests/qemu-iotests/227.out                    |  32 +-
 tests/qemu-iotests/247.out                    |   2 +-
 tests/qemu-iotests/264                        |   3 +-
 tests/qemu-iotests/273.out                    |   8 +-
 tests/qemu-iotests/277                        |   3 +-
 tests/qemu-iotests/308                        |   4 +-
 tests/qemu-iotests/308.out                    |   4 +-
 tests/qemu-iotests/tests/file-io-error        |   5 +-
 tests/qemu-iotests/tests/iothreads-resize.out |   2 +-
 tests/qemu-iotests/tests/iothreads-stream     |   3 +-
 tests/qemu-iotests/tests/qsd-jobs.out         |   4 +-
 tests/unit/meson.build                        |   3 +-
 59 files changed, 1022 insertions(+), 1028 deletions(-)
 delete mode 100644 hw/block/dataplane/trace.h
 delete mode 100644 hw/block/dataplane/virtio-blk.h
 delete mode 100644 hw/block/dataplane/virtio-blk.c
 delete mode 100644 hw/block/dataplane/trace-events



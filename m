Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05EAC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublMT-0001qJ-KJ; Tue, 15 Jul 2025 15:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwK-0003Y4-EU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwH-0001Dl-Cs
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Urutln6uU6GSKicJF92YAVHqmQfdARA23tu2+184jzk=;
 b=VMXNT1vpJhgz2RMZKQPEQTvWJQmnF4SKj2Md+dvSfEP8bY3g/pmCG9W1H7tsvhZevA6ynS
 9p46sOeyL0ZGwQfHUDkRQ0HkIr+EbDfZqMwiJpL6FJQajui/oxnKwSAgQI3MVMhuFG5rK2
 JhwmiBh4ozlMNW/vWFQB3L4t2MJXNec=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-Ho-4HRyxN7SShr5SMkwcnQ-1; Tue,
 15 Jul 2025 15:03:37 -0400
X-MC-Unique: Ho-4HRyxN7SShr5SMkwcnQ-1
X-Mimecast-MFC-AGG-ID: Ho-4HRyxN7SShr5SMkwcnQ_1752606216
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A966118002EC; Tue, 15 Jul 2025 19:03:36 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B51FE197702B; Tue, 15 Jul 2025 19:03:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/57] Block layer patches
Date: Tue, 15 Jul 2025 21:02:33 +0200
Message-ID: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b543336:

  Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into staging (2025-07-13 01:46:04 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to d7bd47bf84707d21324ad079c5aa8cca16fd138f:

  qemu-img: extend cvtnum() and use it in more places (2025-07-15 20:49:01 +0200)

----------------------------------------------------------------
Block layer patches

- file-posix: Fix aio=threads performance regression after enablign FUA
- QMP query-block/query-named-block-nodes: Include child references
- Graph locking cleanups and fixes around making drain GRAPH_UNLOCKED
- qemu-img: Overhaul option handling and --help
- iotests: add test for changing the 'drive' property via 'qom-set'

----------------------------------------------------------------
Fiona Ebner (28):
      block: never use atomics to access bs->quiesce_counter
      block: add bdrv_graph_wrlock_drained() convenience wrapper
      block/mirror: switch to bdrv_set_backing_hd_drained() variant
      block/commit: switch to bdrv_set_backing_hd_drained() variant
      block: call bdrv_set_backing_hd() while unlocked in bdrv_open_backing_file()
      block: mark bdrv_set_backing_hd() as GRAPH_UNLOCKED
      blockdev: avoid locking and draining multiple times in external_snapshot_abort()
      block: drop wrapper for bdrv_set_backing_hd_drained()
      block-backend: mark blk_drain_all() as GRAPH_UNLOCKED
      block/snapshot: mark bdrv_all_delete_snapshot() as GRAPH_UNLOCKED
      block/stream: mark stream_prepare() as GRAPH_UNLOCKED
      block: mark bdrv_reopen_queue() and bdrv_reopen_multiple() as GRAPH_UNLOCKED
      block: mark bdrv_inactivate() as GRAPH_RDLOCK and move drain to callers
      block: mark bdrv_inactivate_all() as GRAPH_UNLOCKED
      block: mark blk_remove_bs() as GRAPH_UNLOCKED
      block: mark blk_drain() as GRAPH_UNLOCKED
      block-backend: mark blk_io_limits_disable() as GRAPH_UNLOCKED
      block/commit: mark commit_abort() as GRAPH_UNLOCKED
      block: mark bdrv_replace_child_bs() as GRAPH_UNLOCKED
      block: mark bdrv_insert_node() as GRAPH_UNLOCKED
      block: mark bdrv_drop_intermediate() as GRAPH_UNLOCKED
      block: mark bdrv_close_all() as GRAPH_UNLOCKED
      block: mark bdrv_close() as GRAPH_UNLOCKED
      block: mark bdrv_open_child_common() and its callers GRAPH_UNLOCKED
      blockjob: mark block_job_remove_all_bdrv() as GRAPH_UNLOCKED
      block/qapi: include child references in block device info
      block/qapi: make @node-name in @BlockDeviceInfo non-optional
      iotests: add test for changing the 'drive' property via 'qom-set'

Kevin Wolf (2):
      block: Allow bdrv_new() with and without graph lock
      file-posix: Fix aio=threads performance regression after enablign FUA

Michael Tokarev (27):
      qemu-img: measure: convert img_size to signed, simplify handling
      qemu-img: create: convert img_size to signed, simplify handling
      qemu-img: global option processing and error printing
      qemu-img: pass current cmd info into command handlers
      qemu-img: create: refresh options/--help (short option change)
      qemu-img: factor out parse_output_format() and use it in the code
      qemu-img: check: refresh options/--help
      qemu-img: simplify --repair error message
      qemu-img: commit: refresh options/--help
      qemu-img: compare: use helper function for --object
      qemu-img: compare: refresh options/--help
      qemu-img: convert: refresh options/--help (short option change)
      qemu-img: info: refresh options/--help
      qemu-img: map: refresh options/--help
      qemu-img: snapshot: allow specifying -f fmt
      qemu-img: snapshot: make -l (list) the default, simplify option handling
      qemu-img: snapshot: refresh options/--help
      qemu-img: rebase: refresh options/--help (short option change)
      qemu-img: resize: do not always eat last argument
      qemu-img: resize: refresh options/--help
      qemu-img: amend: refresh options/--help
      qemu-img: bench: refresh options/--help
      qemu-img: bitmap: refresh options/--help
      qemu-img: dd: refresh options/--help
      qemu-img: measure: refresh options/--help
      qemu-img: implement short --help, remove global help() function
      qemu-img: extend cvtnum() and use it in more places

 qapi/block-core.json                        |   18 +-
 docs/tools/qemu-img.rst                     |   18 +-
 include/block/block-global-state.h          |   46 +-
 include/block/block_int-common.h            |    4 +-
 include/block/blockjob.h                    |    2 +-
 include/block/graph-lock.h                  |   11 +
 include/block/snapshot.h                    |    6 +-
 include/qemu/job.h                          |    4 +-
 include/system/block-backend-global-state.h |    8 +-
 block.c                                     |   75 +-
 block/backup.c                              |    4 +-
 block/blklogwrites.c                        |    8 +-
 block/blkverify.c                           |    4 +-
 block/block-backend.c                       |    8 +-
 block/commit.c                              |   34 +-
 block/file-posix.c                          |   29 +-
 block/graph-lock.c                          |   40 +-
 block/io.c                                  |    7 +-
 block/mirror.c                              |   17 +-
 block/monitor/block-hmp-cmds.c              |   15 +-
 block/qapi.c                                |   12 +-
 block/qcow2.c                               |    4 +-
 block/quorum.c                              |    8 +-
 block/replication.c                         |   14 +-
 block/snapshot.c                            |    4 +-
 block/stream.c                              |   21 +-
 block/vmdk.c                                |   26 +-
 blockdev.c                                  |  102 +-
 blockjob.c                                  |   10 +-
 qemu-img.c                                  | 1779 ++++++++++++++++-----------
 tests/unit/test-bdrv-drain.c                |   46 +-
 tests/unit/test-bdrv-graph-mod.c            |   20 +-
 qemu-img-cmds.hx                            |    4 +-
 tests/qemu-iotests/049.out                  |    9 +-
 tests/qemu-iotests/153                      |    2 +-
 tests/qemu-iotests/153.out                  |   36 +-
 tests/qemu-iotests/178                      |    2 +-
 tests/qemu-iotests/178.out.qcow2            |    3 +-
 tests/qemu-iotests/178.out.raw              |    3 +-
 tests/qemu-iotests/184.out                  |    8 +
 tests/qemu-iotests/common.filter            |    6 +
 tests/qemu-iotests/tests/qom-set-drive      |   75 ++
 tests/qemu-iotests/tests/qom-set-drive.out  |   11 +
 43 files changed, 1521 insertions(+), 1042 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/qom-set-drive
 create mode 100644 tests/qemu-iotests/tests/qom-set-drive.out



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B82CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lD-0000tX-QI; Mon, 03 Nov 2025 16:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lC-0000tP-SL
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1l7-00058m-Af
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762203991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sPVGaOzjLfyXGUOLv0Q6i7VmYX8ifCPwCX6pUQAaLtg=;
 b=Jq8sIWGOoXaUoVeX+6ik6wgm4EZi2SCN+7CQPXKm28KvMk8OMiiANsIU6LL2Hp1D2QMrrQ
 EAkM8FGjBJIXYb1ntabycup+Rx/xUhn/GQp0i1lzE5EiX2IBnlGRtWEitUEi41CnLuhJR3
 KVu5gSDYoarp32VGjpBOl9zprzVwArw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-XdEC4ZQSM2CmZ3aZ-bdlmw-1; Mon, 03 Nov 2025 16:06:30 -0500
X-MC-Unique: XdEC4ZQSM2CmZ3aZ-bdlmw-1
X-Mimecast-MFC-AGG-ID: XdEC4ZQSM2CmZ3aZ-bdlmw_1762203989
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ecf5d3b758so103836641cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762203989; x=1762808789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sPVGaOzjLfyXGUOLv0Q6i7VmYX8ifCPwCX6pUQAaLtg=;
 b=Vc5Nz5WHN5THIjFu+Ujaienb2eQY9Tu0oagnlSl3rKPZHiWJ87387Dc4gjvfYFxqtl
 fLmj9xmZl8w+NQE/91uaIuzNrwf9RwxNm80VCZgbWBYW0M8k5LRJ+gpHEkpbIWA4iagh
 WhcSkHN2DheDIli0quU9oLRNrTKp3XFOQ4lT12+36Ao7w3cdFDcjWRcYy7hie/pGx0iZ
 JGQJ8VIC9If/hIQZLGpqFCx3DVEcV04ut6c5wqLtgCWFV1rN+1ecP628NdFo9sSIjq+H
 u8Bn5r+XGdLJtczvbR5RzH6tquy4k1PgGR5qnxKLB6Euc+ULInkjbDD6iV+hdA+14k1O
 aomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203989; x=1762808789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sPVGaOzjLfyXGUOLv0Q6i7VmYX8ifCPwCX6pUQAaLtg=;
 b=uJunJdWKfM3ls3qButuQ42gRgBwXwFIVJvMCKhlgm6nenOfD/Hm1dnpd7/byqS1wUw
 kCBqy22GTzPC1xeKLeQeOpU/UyByCQXynyVHjFJ1MGntlgmOw7Xd58vPszBzrUnUoH9L
 8uudspMmH0JL567m9aGJMI1M1QuKZ+lQ4+WG+qtVxyF97Q+IlR551WJGX8KmNBfvNZS1
 +s2zYN20Gz/9/TMXYweAgAjaLtjXW1RrN/cSf6YzYnzFmjpd2Ga3HGv/Np16b0lYbaJr
 3/sa+8Gn7b3JC/3enfbN4WvhRq7LSpeniFAOlN0oOPuybYC+tjva1mtt+E/mhKJwDCuU
 n+rQ==
X-Gm-Message-State: AOJu0YxQoToVHExaRwOj/q8dYwdv8fK8AYlBRXjAmz0Y1DQ6Z0gcKhIA
 bYHetsB1dSgERiwsYGUYiKfD5GpqH1tHZq/IdwO/ZpWCsezjN0qdryAATD+6fuZy4uMBsfSdiWq
 +UkMAe+GxdoNBMkxk/bWABTn4tT/+dlMv6m4kjGmuwdXd01h6PF3eSRHUFuBX1yiERXm7hsQd1i
 77B1VOO6C4Wq3AaNGAP0tYywuCmDObNsYu93cv6g==
X-Gm-Gg: ASbGncvRP0KVpykDLeUFtS3wg+Sw7Iyjp6z0Kd8ksFCvPFLFjSPx1EtqYQ+pen/XDHJ
 QHmULbc3e77wNbHoK1kKQ1B/4wQYk+XmBWJnHYzcM13wxVw04B0xkwZtxL+FoWwuSjRZbFncrdg
 rrA/jdq5bu5ip8qnMHtT+l6nI7hQiQBWqzrr8VO6Jn5xBBojpCUqiMlXPfgAR621QFuQWWCuDxa
 NGbNDukGajP5NkqG2wo3FhHfJhVvhObISUr/HRhSyQ15YN5MfB9fifT4K52kOzTe+Tful8t1cSP
 K2gWJElbmrgKoO24CtPrGFuk1XRHuBjJAY7JLDUsXRJ+FsChe5Qx+SY2mufxLEit
X-Received: by 2002:a05:622a:44e:b0:4e8:9140:f3d3 with SMTP id
 d75a77b69052e-4ed30f8fa24mr171821931cf.50.1762203988873; 
 Mon, 03 Nov 2025 13:06:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqaPLpTHIu4FiNylKdtU4c9ZpZsvyPS8tZuUMtRAo6gaAonFc+9+UWo7hQFIebUsl/uLWk8Q==
X-Received: by 2002:a05:622a:44e:b0:4e8:9140:f3d3 with SMTP id
 d75a77b69052e-4ed30f8fa24mr171821321cf.50.1762203988216; 
 Mon, 03 Nov 2025 13:06:28 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:27 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/36] Staging patches
Date: Mon,  3 Nov 2025 16:05:49 -0500
Message-ID: <20251103210625.3689448-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:

  Merge tag 'igvm-20251103--pull-request' of https://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/staging-pull-request

for you to fetch changes up to 7b842fe354c63feaffc63c850b28c3610a0c90d2:

  migration: Introduce POSTCOPY_DEVICE state (2025-11-03 16:04:10 -0500)

----------------------------------------------------------------
mem + migration pull for 10.2

- Fabiano's patch to fix snapshot crash by rejecting some caps
- Marco's mapped-ram support on snapshot save/load
- Steve's cpr maintainers entry update on retirement
- Peter's coverity fixes
- Chenyi's tdx fix on hugetlbfs regression
- Peter's doc update on migrate resume flag
- Peter's doc update on HMP set parameter for cpr-exec-command's char** parsing
- Xiaoyao's guest-memfd fix for enabling shmem
- Arun's fix on error_fatal regression for migration errors
- Bin's fix on redundant error free for add block failures
- Markus's cleanup around MigMode sets
- Peter's two patches (out of loadvm threadify) to cleanup qio read peek process
- Thomas's vmstate-static-checker update for possible deprecation of argparse use
- Stefan's fix on windows deadlock by making unassigned MMIOs lockless

----------------------------------------------------------------

Arun Menon (1):
  migration: Fix regression of passing error_fatal into
    vmstate_load_state()

Bin Guo (1):
  migration: Don't free the reason after calling migrate_add_blocker

Chenyi Qiang (2):
  ram-block-attributes: fix interaction with hugetlb memory backends
  ram-block-attributes: Unify the retrieval of the block size

Fabiano Rosas (1):
  migration/savevm: Add a compatibility check for capabilities

Juraj Marcin (7):
  migration: Flush migration channel after sending data of CMD_PACKAGED
  migration: Move postcopy_ram_listen_thread() to postcopy-ram.c
  migration: Introduce postcopy incoming setup and cleanup functions
  migration: Refactor all incoming cleanup info
    migration_incoming_destroy()
  migration: Respect exit-on-error when migration fails before resuming
  migration: Make postcopy listen thread joinable
  migration: Introduce POSTCOPY_DEVICE state

Marco Cavenati (3):
  migration/ram: fix docs of ram_handle_zero
  migration: add FEATURE_SEEKABLE to QIOChannelBlock
  migration: mapped-ram: handle zero pages

Markus Armbruster (3):
  migration: Use unsigned instead of int for bit set of MigMode
  migration: Use bitset of MigMode instead of variable arguments
  migration: Put Error **errp parameter last

Peter Xu (9):
  migration: Fix error leak in postcopy_ram_listen_thread()
  migration/cpr: Fix coverity report in cpr_exec_persist_state()
  migration/cpr: Fix UAF in cpr_exec_cb() when execvp() fails
  migration/cpr: Avoid crashing QEMU when cpr-exec runs with no args
  migration/qmp: Update "resume" flag doc in "migrate" command
  migration/cpr: Document obscure usage of g_autofree when parse str
  io: Add qio_channel_wait_cond() helper
  migration: Properly wait on G_IO_IN when peeking messages
  migration: Do not try to start VM if disk activation fails

Philippe Mathieu-Daudé (1):
  migration: Remove unused VMSTATE_UINTTL_EQUAL[_V]() macros

Stefan Hajnoczi (1):
  system/physmem: mark io_mem_unassigned lockless

Steve Sistare (1):
  MAINTAINERS: update cpr reviewers

Thomas Huth (1):
  scripts/vmstate-static-checker: Fix deprecation warnings with latest
    argparse

Vladimir Sementsov-Ogievskiy (4):
  migration: vmstate_save_state_v(): fix error path
  tmp_emulator: improve and fix use of errp
  migration/vmstate: stop reporting error number for new _errp APIs
  migration: vmsd errp handlers: return bool

Xiaoyao Li (1):
  hostmem/shm: Allow shm memory backend serve as shared memory for
    coco-VMs

 MAINTAINERS                           |   3 +-
 docs/devel/migration/main.rst         |   6 +-
 qapi/migration.json                   |  15 +-
 include/io/channel.h                  |  15 ++
 include/migration/blocker.h           |   9 +-
 include/migration/cpr.h               |   4 +-
 include/migration/cpu.h               |   6 -
 include/migration/misc.h              |  10 +-
 include/migration/vmstate.h           |   6 +-
 migration/migration.h                 |   4 +
 migration/options.h                   |   1 +
 migration/postcopy-ram.h              |   3 +
 migration/savevm.h                    |   2 +
 backends/hostmem-shm.c                |   1 +
 backends/tpm/tpm_emulator.c           |  73 ++++++----
 hw/display/virtio-gpu.c               |  21 ++-
 hw/intc/arm_gicv3_kvm.c               |   1 -
 hw/pci/pci.c                          |  15 +-
 hw/s390x/virtio-ccw.c                 |  17 ++-
 hw/scsi/spapr_vscsi.c                 |  10 +-
 hw/vfio/container-legacy.c            |   6 +-
 hw/vfio/cpr-iommufd.c                 |   6 +-
 hw/vfio/cpr-legacy.c                  |   8 +-
 hw/vfio/cpr.c                         |   5 +-
 hw/vfio/device.c                      |   4 +-
 hw/virtio/virtio-mmio.c               |  15 +-
 hw/virtio/virtio-pci.c                |  15 +-
 hw/virtio/virtio.c                    |  10 +-
 io/channel.c                          |  21 +--
 migration/channel-block.c             |  44 ++++++
 migration/channel.c                   |   7 +-
 migration/cpr-exec.c                  |  14 +-
 migration/cpr.c                       |  15 +-
 migration/migration-hmp-cmds.c        |   6 +
 migration/migration.c                 | 188 ++++++++++++++------------
 migration/options.c                   |  26 ++++
 migration/postcopy-ram.c              | 161 ++++++++++++++++++++++
 migration/qemu-file.c                 |   6 +-
 migration/ram.c                       |  60 +++++++-
 migration/savevm.c                    | 145 +++-----------------
 migration/vmstate.c                   |  25 ++--
 stubs/migr-blocker.c                  |   2 +-
 system/physmem.c                      |  11 +-
 system/ram-block-attributes.c         |  20 ++-
 target/i386/sev.c                     |   1 -
 tests/qtest/migration/precopy-tests.c |   3 +-
 migration/trace-events                |   3 +-
 scripts/vmstate-static-checker.py     |  13 +-
 tests/qemu-iotests/194                |   2 +-
 49 files changed, 684 insertions(+), 380 deletions(-)

-- 
2.50.1



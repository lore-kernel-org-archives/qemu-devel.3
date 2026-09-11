Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993C2C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yAJ-0006HJ-9d; Fri, 11 Sep 2026 06:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAH-0006HB-Fh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:25 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAF-0007Cy-9o
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:25 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so925824a91.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121241; x=1789726041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GFMhYxHNVt+u2rjIQ90q6Oyb604L58Q+/Lkv4iWWxzI=;
 b=lq0M5LpkBaBW8KcQ4kcx4laLwp844qlHyL1nDSOYmjQb9t6vTflNp3zTbneCz0XK/R
 aDPgOArcR4rs79cIcJTntcwmjCf57Ipi/qZ9ZGtRIlbUGrlRfKLju0raNzNX94D5jjja
 vWmVl5Q5ysQ9JfWg66p7U8AE6aefmehwP9Gq6TGPBuelaAUH/Tvujb2NhRjS29HWj0g9
 vCtVuokeL/u1euKIyP7sbjncYKD6gGDUgZ40f1/X14Wx7l1Pz2iarAIdLIHu/WbK0zGw
 yiKmkZ1DKnumQb+WmDhWEU509JI9mg3N2M0cndqRPvPNh71H7l0EVEk2Qe440a+RrFcE
 hKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121241; x=1789726041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GFMhYxHNVt+u2rjIQ90q6Oyb604L58Q+/Lkv4iWWxzI=;
 b=LfFsFDXqDIQc0A8aX/v8dgbZ0S5CgrDA0kFg5sRnzhSfRuoJ/aiEpmTUnxNpfCOWeN
 /txng7I27efBu1AqvKwJH+WiIDoEFz8QV9r3yAL01KVs3+fxhR/AMqwfTX6/PNjJXUle
 FrAEfeJAS/o85op+0ZAOgJ+58Q3EAiKa/n4qpjbxCkDry7E5xqTcO5qfZMkehM1CadDA
 cDavUi3kUq6oEpK15wjJ3VAczID4cSC99sSnEWfvtWQDhHwN1k+SWaGjB4ynBhUILDTQ
 9KldhOUpYOPU2Ksvh9uTep22dhu7xwBgoFeEmkLoOtBFtEIPUJ6Gb1DbZ232aR/aGBp5
 yt1w==
X-Gm-Message-State: AFuF++lyNgOmwJmJEdca40r/Gr+coc529iEl3d38PkfHIsBogc5Wzfds
 /IiGFrO7Tg4tqstBT1uJtGAinn4BI3QANLj++WhhHZQN4BCvXyKS9xRypRaDKKh0Pmo=
X-Gm-Gg: AYBFou1S1A+65mjgRwsaCgSDCz3R2pjTWGgRt8gQwSNytzjPAu01cgqraLUMGUFQbKS
 E6GeacQp1jBsEXlVByQUVAwC/+8xbFqV5otnU/e0pM4wvioS/VHAnzk4Gnhzf4HLajI7qMWwhPi
 mQF//usX14T0ca3wCiUU/rAfjVCZNokpTFr9Cve69OCxQ8l/cn/QkoOQy90pHh2tZMpCysoFgFb
 dcvjonniK+gLNB3vZUD7INsjyUSurG1NBocxUwrduERJUHPsJr0Ymtt5P3/Y9H59cRpEDhYDF31
 Ji1IKYy80ZxZ12fUnaHDy4+DoSWj7a16gF0xgNMaf3zMwWXGeIKd1dBDVCAfgRmm2MQQ0m7ClHQ
 n1Xs3FaGQfs/M7Vm1lGG9c20/nyrwXO/52lOiMjXVfuCIOVoPjeZjMZEndEZdYW4skG3RkD03JW
 ulE93tHGtT/vWuZJHeuJLaUwGyMNm5l/ZMvvPNAzy+ZamYkrrJ0RIPAi3UVTUYZguObKXLJ5dcM
 ttcgRSS+JZj/jos7hZpdNz2RZc=
X-Received: by 2002:a17:90b:35d0:b0:398:c724:1bb1 with SMTP id
 98e67ed59e1d1-39d9bd91016mr5841130a91.8.1789121240583; 
 Fri, 11 Sep 2026 03:07:20 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:07:20 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 00/13] iothread: Support tracking and querying IOThread
 holder
Date: Fri, 11 Sep 2026 18:06:56 +0800
Message-ID: <20260911100709.726366-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

### Motivation
Currently, the relationship between IOThreads and the resources using them is
opaque. From a management perspective, it is difficult to determine which
devices or block exports are currently associated with a specific IOThread
via QMP or HMP.

This series introduces a "holder" tracking mechanism based on QOM paths or
block exports to significantly improve IOThread observability.
In high-performance virtualization environments, users often pre-allocate
a set of IOThreads to serve as a persistent thread pool. During device
hotplug/unplug cycles, while IOThread objects remain persistent,
their attachment state changes dynamically.

By tracking these "holders," administrators can use `query-iothreads` to
monitor the real-time load distribution of the thread pool and identify which
specific devices (e.g., virtio-blk, BlockExport) are attached to which thread.

### Technical Overview
* Holder tracking

  Add a QAPI holder list to each IOThread.  A holder identifies either
  a QOM object by its canonical path or a block export by its unique
  BlockExportOptions ID.

* Explicit reference lifecycle

  Add iothread_ref_and_get_aio_context() and the matching
  iothread_unref_and_put_aio_context().  Acquiring an AioContext registers a
  holder and keeps the IOThread alive until the matching put.

  Legacy callers without a matching lifecycle use the explicitly named
  iothread_unsafe_get_aio_context().  The ambiguous legacy
  iothread_get_aio_context() is removed after all production callers
  are migrated.

* Subsystem integration

  Track holders for block exports, monitors, virtio-blk, virtio-scsi,
  virtio queue mappings, virtio balloon thread pinning, COLO compare,
  vfio-user proxy, and xen-block.

* Introspection

  Extend IOThreadInfo with a holders array returned by
  query-iothreads.  Display the same information with info iothreads.



### V16 -> V15 Changelog
  - Unified per-monitor IOThread checks and accesses through
    mon->iothread after initialization.
  - Simplified PATCH 13's commit message and clarified why blockdev
    cannot use the holder-aware get/put APIs.
  - Dropped the v15 Patch 1 in this series, It will be taken away
    independently by trivial-patches tree.

### V15 -> V14 Changelog
  - Moved monitor IOThread cleanup from unparent() to monitor_finalize(),
    pairing complete() with instance finalization.
  - Squashed V14 PATCH 04 and PATCH 14 into PATCH 13 and clarified the
    blockdev lifetime assumption. Since the additional changes are minimal,
    PATCH 13 retains Stefan's Reviewed-by from V14 PATCH 04.
  - Rebased and adapted info iothreads to the MonitorHMP interface.

### V14 -> V13 Changelog
  - Renamed patch 3 and clarified that it introduces holder-tracking
    infrastructure, with users converted in subsequent patches.
  - Documented that monitor holders are not visible to management
    applications, while retaining the tracking for a consistent holder
    and IOThread reference lifecycle.
  - Rebased on the latest upstream.

### V13 -> V12 Changelog
  - Refactored block export IOThread reference handling with shared
    init/cleanup helpers and preserved the existing single-IOThread
    driver arguments.
  - Moved monitor IOThread cleanup to the QOM unparent callback,
    where the canonical path is still available.
  - Kept internal IOThreads hidden from query-iothreads.
  - Made virtio queue-mapping holder arguments const.
  - Improved some detail comments.

### V12 -> V11 Changelog
  - Change the function name from the "iothread_put_aio_context()"
    to "iothread_unref_and_put_aio_context()" match the
    "iothread_unref_and_put_aio_context".
  - Fix unnecessary char * cast since the holder variable is
    declared const.
  - Add detailed commit msg in patch 06/15.
  - Optimize the HMP print in patch 13/15.
  - Rebase code on upstream.

### V11 -> V10 Changelog
  - Keep iothread_ref_and_get_aio_context() as an explicit acquiring API
    instead of merging it into iothread_get_aio_context().
  - Retain iothread_get_aio_context() during the caller migration so
    every intermediate patch builds, then remove it in patch 14.
  - Update patch 15 to use the holder-aware get/put API in unit-test
    stubs and callers.
  - Rework patch 2 documentation to describe holders as QOM objects or
    block exports, simplify the ref/unref descriptions, and use
    imperative function comments.
  - Identify block export holders with BlockExportOptions member id and
    rename the QAPI field to export-id.
  - Fix monitor cleanup so it only releases an AioContext acquired by
    that monitor, preventing an iothread_unref() assertion at shutdown.
  - Rebase the series onto the current upstream tree.


Zhang Chen (13):
  iothread: introduce holder tracking
  iothread: add holder-aware AioContext accessors
  block/export: track IOThread references
  monitor: track IOThread users with QOM paths
  virtio-vq-mapping: track iothread-vq-mapping references using device
    path
  virtio: track IOThread references for thread pinning
  net/colo: track IOThread references using path-based holder
  virtio-balloon: Update tracking iothread users with holder
  vfio-user/proxy: Update tracking iothread users with holder name
  xen-block: Update tracking iothread users with holder name
  monitor/hmp: display IOThread holders
  iothread: make legacy AioContext getter explicitly unsafe
  tests/unit/iothread: update AioContext ref/put helpers

 block/export/export.c                   | 62 +++++++++++++---
 blockdev.c                              |  9 ++-
 hw/block/dataplane/xen-block.c          | 19 ++++-
 hw/block/virtio-blk.c                   | 21 ++++--
 hw/scsi/virtio-scsi-dataplane.c         | 22 ++++--
 hw/vfio-user/proxy.c                    | 16 ++++-
 hw/virtio/iothread-vq-mapping.c         | 20 ++++--
 hw/virtio/virtio-balloon.c              | 22 ++++--
 include/block/export.h                  |  5 ++
 include/hw/virtio/iothread-vq-mapping.h |  6 +-
 include/system/iothread.h               | 38 +++++++++-
 iothread.c                              | 89 ++++++++++++++++++++++-
 monitor/hmp-cmds.c                      | 20 ++++++
 monitor/monitor-internal.h              |  7 +-
 monitor/monitor.c                       | 36 +++++++---
 monitor/qmp.c                           | 14 ++--
 net/colo-compare.c                      | 29 +++++---
 qapi/misc.json                          | 94 +++++++++++++++++++++----
 tests/unit/iothread.c                   | 18 +++--
 tests/unit/iothread.h                   |  7 +-
 tests/unit/test-aio-multithread.c       |  5 +-
 tests/unit/test-bdrv-drain.c            | 18 +++--
 tests/unit/test-block-iothread.c        | 21 ++++--
 23 files changed, 496 insertions(+), 102 deletions(-)

-- 
2.43.0



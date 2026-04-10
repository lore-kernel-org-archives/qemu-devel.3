Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B376EF459EE
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQ8-0006Nf-4k; Fri, 10 Apr 2026 11:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQ2-0006Io-2N
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:14 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQ0-0001ro-4f
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:13 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d9827661bso1300847a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833509; x=1776438309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kJV6wco7dT6ayqoAQ+JWGsbBtHVP2OC/wvM7YZ2inOw=;
 b=ZbECj9txgkN4yUAlCD7Z4bj2DUIg4A6XExGmmvE9m4teqgPh2SZV2Wz9HCGy9cEOVa
 53BoBGki5cy/wEqyYHO6E+JRY+KGlgO8DgdyIUL1nQaLZ1FZ09xj2z3wwzZe4sPYKxWk
 kJ1og3COruSw2hQLsSg756oM4Ke3+gti3WD7LH+uhJyXxB0ozAR2m026nmWtHJivxpWI
 xuntT/uoVVxFJCxNUfow3uboC8v5G6p5ZzCKb9AMrgSSkliWXxFH5KwmadACGbmIgQzb
 Tdis1orndTN94xIEGAJQ0W/RnJx6qJgwYC9d1QcjVeUxgYYeZaUNJjMU1b5Z8AbPgGI3
 F7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833509; x=1776438309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJV6wco7dT6ayqoAQ+JWGsbBtHVP2OC/wvM7YZ2inOw=;
 b=Z6xWVDaZ33JyN9+Cta9AMwyul31TZfjDYwBxXo3Qhx6VX8xxhP19MGjC95LnbqNAtI
 yEJK6UGNmT6y431yBPCC92O9n3CDymWxUVj+wkPplO3NWRT+i5+hySiB1cbr7NXKxMRP
 W7Xy0zx5aT5mzeju8cLddCdqwxCHGsxX9woXBIYK1PJey/0dcQI5+CbaWE6DZIxWiWDz
 ZHdkQ1wqrC7HWU0mgciCSnhMKoQ+5T7Bwo/vFGyjaRP8YvAdTh1whSGX/uscjrkrQflC
 8ZDYuoe/puGtPQuIL3Pt44+JgA6SQi+UCuniWVJ42O2msXHnrUm4pY3UngyJQ9ErBIrg
 cuyg==
X-Gm-Message-State: AOJu0YztNFvztuF7S5iI5UFG6YRqDfc819JFNXCw3hpMd/U5NybCl9x0
 bnnZV+ZaT8i6l2AnEQPrIx7YnZ4yzcXh2Vm5VuAmI8/rkACWMPemwLW0MpkuZsbB
X-Gm-Gg: AeBDietaxQ78IYCX0O1jXk57EGr5r3FEaxK8nMLFCvRf1cFrraZKl84L2STmemU4tvN
 LZhNGu7SP7TSSammvEWFL85qhjmafLoEbMpdUdRB0IK8GIRxO6iBODqyNEEyV9kzzyl7jscQE26
 yaTwtkoUyGDT7Ii5NQ+8WnApZKXIeMHQ6FuBZnE0vCyZG1295bpW3VB8SoIVhwwuYCNMEXGzClQ
 HWOnL6Xj8MFEePntQefIMRiq78Qtb6sw7F0oQF/9MAwbv01shLR1uR8NyiUuRsH5/sIgWG7JFEO
 g5m8//AbphJ0YslgKNcntNuOi+sSKHRBCRG9YeWGYYdsN0hRhC7GEGgKMTWSUo1CfP2iCxSEUxi
 DZdsYpvg7zS+B8PeAS+zjQ1ppNKCD6kj0xER0XL+z3N8CJllo0YKzKsm5dq2ro740eZjfLZRs9C
 HmRvkNdCUBl2sLTXO+gWSsCQWme5jUz79ILcu3Ik4cRqSuL4MDY+gZ
X-Received: by 2002:a17:90b:3e84:b0:35d:9bb3:2a31 with SMTP id
 98e67ed59e1d1-35e4287ce53mr3974849a91.25.1775833508639; 
 Fri, 10 Apr 2026 08:05:08 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:08 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 00/14] iothread: Support tracking and querying IOThread
 holders
Date: Fri, 10 Apr 2026 23:04:43 +0800
Message-ID: <20260410150457.85190-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1033.google.com
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

This series introduces a "holder" tracking mechanism based on QOM paths to 
significantly improve IOThread observability. In high-performance 
virtualization environments, users often pre-allocate a set of IOThreads to 
serve as a persistent thread pool. During device hotplug/unplug cycles, while 
IOThread objects remain persistent, their attachment state changes dynamically.

By tracking these "holders," administrators can use `query-iothreads` to 
monitor the real-time load distribution of the thread pool and identify which 
specific devices (e.g., virtio-blk, BlockExport) are attached to which thread.

### Technical Overview
* Atomic API Design: Merged iothread_get_aio_context and 
  iothread_ref_and_get_aio_context into a single unified function. The new 
  API enforces a 'holder' parameter, making "retrieval" and "tracking" an 
  atomic operation to prevent reference tracking leaks.
* Subsystem Integration: Fully migrated and adapted core modules including 
  Virtio (blk, vq-mapping, balloon, scsi), Block Layer (export, xen), 
  Network (COLO), VFIO, and the Monitor subsystem.
* Introspection: Expanded the IOThreadInfo QAPI structure to include a 
  'holders' array (list of QOM paths), accessible via both 
  query-iothreads (QMP) and info iothreads (HMP).

### V5 -> V6 Changelog
* - First of all, I apologize for spending so much time dealing with
    the background details of the code implementation.
* API Refactoring (Breaking Change):
  - Implement the 'union': 'IoThreadHolder' for combine the QOM objects
    and the block-node.
  - Completely merged iothread_get_aio_context variants.
  - The iothread_get_aio_context function now strictly requires a 'holder' 
    argument to ensure every context retrieval is accounted for.
* Expanded Module Coverage:
  - Added holder tracking for the monitor subsystem (tracking threads used 
    by QMP/HMP).
  - Added support for the virtio-scsi dataplane.
* Code Cleanup:
  - Removed redundant and obsolete API declarations.
  - Standardized the use of object_get_canonical_path() across all callers 
    to provide consistent and unique holder names.
* Bug Fixes:
  - Updated qapi/misc.json documentation to fix missing descriptions in 
    query-iothreads items.
* Build System:
  - Improved header inclusion logic to avoid redundant declaration errors 
    in unit tests.
* QAPI part:
  - Sorry to drop the "Acked-by: Markus Armbruster <armbru@redhat.com>",
    because this version have lots of changes in the:
    [PATCH V6 13/14]qapi: examine IOThread attachment status via query-iothreads

Zhang Chen (14):
  qapi/misc: Fix missed query-iothreads items
  iothread: introduce iothread_ref/unref to track attached devices
  iothread: tracking iothread users with holder name
  blockdev: Update tracking iothread users with holder name
  block/export: track IOThread reference in BlockExport
  monitor: Update tracking iothread users with holder name
  virtio-vq-mapping: track iothread-vq-mapping references using device
    path
  virtio: use iothread_get/put_aio_context for thread pinning
  net/colo: track IOThread references using path-based holder
  virtio-balloon: Update tracking iothread users with holder name
  vfio-user/proxy: Update tracking iothread users with holder name
  xen-block: Update tracking iothread users with holder name
  qapi: examine IOThread attachment status via query-iothreads
  iothread: simplify API by merging iothread_get_aio_context variants

 block/export/export.c                   |  44 +++++++---
 blockdev.c                              |   6 +-
 hw/block/dataplane/xen-block.c          |  10 ++-
 hw/block/virtio-blk.c                   |  13 ++-
 hw/scsi/virtio-scsi-dataplane.c         |  13 ++-
 hw/vfio-user/proxy.c                    |   7 +-
 hw/virtio/iothread-vq-mapping.c         |  11 ++-
 hw/virtio/virtio-balloon.c              |  14 ++--
 include/block/block_int-common.h        |   5 ++
 include/block/export.h                  |   6 ++
 include/hw/virtio/iothread-vq-mapping.h |   6 +-
 include/system/iothread.h               |   5 +-
 iothread.c                              | 102 +++++++++++++++++++++++-
 monitor/hmp-cmds.c                      |  22 +++++
 monitor/monitor-internal.h              |   3 +
 monitor/monitor.c                       |  24 +++++-
 monitor/qmp.c                           |   3 +-
 net/colo-compare.c                      |  18 +++--
 qapi/misc.json                          |  72 ++++++++++++++++-
 19 files changed, 328 insertions(+), 56 deletions(-)

-- 
2.49.0



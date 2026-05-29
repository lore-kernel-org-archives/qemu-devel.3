Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5244BCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4q8-0003ID-Hk; Fri, 29 May 2026 17:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4q6-0003HS-7a
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:33:58 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4q3-0002mn-1Z
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:33:57 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-842288702fbso60634b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090429; x=1780695229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qK7PQ1dqqZDZPTR6+CQ+TDbYaSr7gQ/FxsPTwgU/Ddc=;
 b=ENVuu1DWnW6Zm/opVuLU2c9Hi42YNWHHdWfa7rGng+r1x5Ag4V3HO+P7YAWfrIhCa9
 ABzASBNv7jm4XMZ5PxDNkFD1UnBiZAgPZrCI88gjA9jJPZuXt8eVn4jmyAWV8RsCV8R3
 UovNUDXdLHxSMBxg54TxQ+4V5FmeE/FCLlYfFP3UPz6UfIC/qLH3HHtVKLnSE/YnZuxo
 XDMZiR9U8Dm/lOj0wGDwdHJdgQUffxGqSjSFheduGnbrZuOcerwEveVSZfEmWCvZkact
 8p/tbdNHobWodDqGvogV1pKtFxRF9f8Az5MDO1ns4GSbJ8EG3+0yIUw/lfu2jtwAk8S+
 a0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090429; x=1780695229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qK7PQ1dqqZDZPTR6+CQ+TDbYaSr7gQ/FxsPTwgU/Ddc=;
 b=p/23L3Ygeaoxbd1XJ/klfpzRbgqllPgZFhyKo/dl22cvezMJqqyUpWjgJAvni6LGzO
 sGqj8Pk8gyjjdByJiJpu8uXZZxR+9/DDfuH8vsttCB53e3NrqW3loflPOEdR16Ta3JJk
 3sUnWswYRllp6Jozgk3YaNI1skFsCdIyDX+UVQyvDIPFzpwUy0NzYKWk5MCcO6ugL01d
 tHWwSmcqT+A6fKl0KpR4fWidhoYJvJI6akaCMGDTk9kzVhMeo+5e0NamguawNpHTv1g7
 52yuMRT7dPgybVbnqGEQfq8BBnBX9VNHA5byh0xcb6AOOlyfV3otva+MNdegOxTr7iL6
 NYGg==
X-Gm-Message-State: AOJu0YyaRKE+PlEAojIvve5hX8/P+G9UoDBBM32n34nu3FWygURnEVs/
 e3F8/3Bqp7Hv5Q96R0vkmSOLCui1UVz+xs/NN/BcmazMIXsV480yzfRfodoIx2wsb4c=
X-Gm-Gg: Acq92OFPJZJv4tzDbOSlGQ0jm/BC1anTnt5Bgh0cgnmEaHIU+6ObvwrxyalTIF1Gs4o
 i8GKBN6+lYfZUXpdAQznghbtf2N0jbxJuQOePycyrEJZYVFDV2VYU2tIjFyB99zZ2v4WrqkAO/X
 v5cCNOcXOII+4H5uS8YY3EHkw54Cj3XA8d8DSImPviLahFiEMmdFg5HrIf4ID+bfrqHNLBPw0Gv
 4VvqXgp6+cIUWCEV9BFOZEsbavZhx5G0z76bAE7yPldsJbfKzN6J2clx0OrqzjcmZoZTJNl4MQG
 uIKX6PYnY3qvPunjWVysmJpxRIas/ziVcLMv5DUkmsUZHyGakoDzEbCgg6oBlYwcp6Jey6n8MpO
 ALSebVpwAc0W8MqvSFBl7rbUtj6kiOKIHzyIapH0iGV2oz3oFa+72FAyp650FMpaw+j809d/xCC
 PjTUjUrtaeJaHHj5v3kYcsotwLbalg1TvpqkF+l1q4BkUyPwKC+MmV2Em1x85BtNA=
X-Received: by 2002:a05:6a00:a88c:b0:83a:35b2:2bf with SMTP id
 d2e1a72fcca58-8422579c5e4mr1129670b3a.41.1780090429322; 
 Fri, 29 May 2026 14:33:49 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.33.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:33:48 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 00/15] iothread: Support tracking and querying IOThread
 holders
Date: Sat, 30 May 2026 05:33:06 +0800
Message-ID: <20260529213321.96271-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42e.google.com
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

### V7 -> V8 Changelog
  - Drop the assumption of the Monitor QOM, add the new type
    IO_THREAD_HOLDER_KIND_MONITOR_NAME.
  - Drop the assumption of the string '/' as QOM path.
  - Introduce new patch for Monitor:
    [PATCH 06/15] assign unique default ID to anonymous monitors
  - Fixed Monitor ID for the IOThread.
  - Refactorcode according comments.
  - Update QMP example.
  - Rebased patches on upstream code.
  - Fixed comments issues.
  - Removed redundant code.

### V6 -> V7 Changelog
  - Fixed comments issues in patch 02/14 (Thanks Markus).
  - Removed redundant code.
  - Rebased patches on upstream code.
  - Fixed code conflict with latest patches.
  - Added detailed description in git log and code.
  - Added comments for patch 06/14 assuming the monitor is a QOM object,
    Depends on Daniel Berrange's RFC patch:
    [PATCH RFC 00/17] monitor: turn QMP and HMP into QOM objects

### V5 -> V6 Changelog
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
 


Zhang Chen (15):
  qapi/misc: Fix missed query-iothreads items
  iothread: introduce iothread_ref/unref to track attached devices
  iothread: tracking iothread users with holder name
  iothread: introduce iothread_unsafe_get_aio_context()
  block/export: track IOThread reference in BlockExport
  monitor: assign unique default ID to anonymous monitors
  monitor: Update tracking iothread users with holder
  virtio-vq-mapping: track iothread-vq-mapping references using device
    path
  virtio: use iothread_get/put_aio_context for thread pinning
  net/colo: track IOThread references using path-based holder
  virtio-balloon: Update tracking iothread users with holder
  vfio-user/proxy: Update tracking iothread users with holder name
  xen-block: Update tracking iothread users with holder name
  qapi: examine IOThread attachment status via query-iothreads
  iothread: simplify API by merging iothread_get_aio_context variants

 block/export/export.c                   |  62 +++++++++--
 blockdev.c                              |   2 +-
 chardev/char.c                          |   2 +-
 gdbstub/system.c                        |   3 +-
 hw/block/dataplane/xen-block.c          |  19 +++-
 hw/block/virtio-blk.c                   |  22 ++--
 hw/scsi/virtio-scsi-dataplane.c         |  22 ++--
 hw/vfio-user/proxy.c                    |  15 ++-
 hw/virtio/iothread-vq-mapping.c         |  19 +++-
 hw/virtio/virtio-balloon.c              |  22 +++-
 include/block/export.h                  |   6 ++
 include/hw/virtio/iothread-vq-mapping.h |   6 +-
 include/monitor/monitor.h               |   6 +-
 include/system/iothread.h               |  17 ++-
 iothread.c                              | 136 +++++++++++++++++++++++-
 monitor/hmp-cmds.c                      |  26 +++++
 monitor/hmp.c                           |  20 +++-
 monitor/monitor-internal.h              |   5 +
 monitor/monitor.c                       |  24 ++++-
 monitor/qmp.c                           |  21 +++-
 net/colo-compare.c                      |  29 +++--
 qapi/misc.json                          |  84 ++++++++++++++-
 stubs/monitor-internal.c                |   3 +-
 23 files changed, 505 insertions(+), 66 deletions(-)

-- 
2.49.0



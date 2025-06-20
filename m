Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED426C73C66
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 00:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSPLN-0000cq-DW; Thu, 19 Jun 2025 20:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uSPLJ-0000bn-1Q
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 20:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uSPLH-0004pJ-8Z
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 20:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750378249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pYpNakpd/aCiEW7d1LZXQH/fJeShelw18jNWP5cJFt0=;
 b=ATyIW+PZyrenAjk/qstOjL832byzLJPKsqSnTQgemzd+V8jiXaVb0eRrA/tS/n+f9g98Jg
 af4GHlaRxeR4nkQJGtD4BDLONynmY/JyKxzJjHKTqAkEdGjDC0Jxyl3rD2zAYli3mnx+Bk
 kNkV147pCx5U4IXMqJXJrEza0/5Ygis=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-46vNxYzUPgujR1d_Ud3RmQ-1; Thu,
 19 Jun 2025 20:10:45 -0400
X-MC-Unique: 46vNxYzUPgujR1d_Ud3RmQ-1
X-Mimecast-MFC-AGG-ID: 46vNxYzUPgujR1d_Ud3RmQ_1750378244
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57E8F1956089; Fri, 20 Jun 2025 00:10:44 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 740681956094; Fri, 20 Jun 2025 00:10:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, eblake@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, hibriansong@gmail.com
Subject: [PATCH v2 00/12] aio: add the aio_add_sqe() io_uring API
Date: Thu, 19 Jun 2025 20:08:16 -0400
Message-ID: <20250620000829.1426291-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

v2:
- Performance improvements
- Fix pre_sqe -> prep_sqe typo [Eric]
- Add #endif terminator comment [Eric]
- Fix spacing in aio_ctx_finalize() argument list [Eric]
- Add new "block/io_uring: use non-vectored read/write when possible" patch [Eric]
- Drop Patch 1 because multi-shot POLL_ADD has edge-triggered semantics instead
  of level-triggered semantics required by QEMU's AioContext APIs. The
  qemu-iotests 308 test case was hanging because block/export/fuse.c relies on
  level-triggered semantics. Luckily the performance reason for switching from
  one-shot to multi-shot has been solved by Patch 2 ("aio-posix: keep polling
  enabled with fdmon-io_uring.c"), so it's okay to use single-shot.
- Add a new Patch 1. It's a bug fix for a user-after-free in fdmon-io_uring.c
  triggered by qemu-iotests iothreads-nbd-export.

This patch series contains io_uring improvements:

1. Support the glib event loop in fdmon-io_uring.
   - aio-posix: fix race between io_uring CQE and AioHandler deletion
   - aio-posix: keep polling enabled with fdmon-io_uring.c
   - tests/unit: skip test-nested-aio-poll with io_uring
   - aio-posix: integrate fdmon into glib event loop

2. Enable fdmon-io_uring on hosts where io_uring is available at runtime.
   Otherwise continue using ppoll(2) or epoll(7).
   - aio: remove aio_context_use_g_source()

3. Add the new aio_add_sqe() API for submitting io_uring requests in the QEMU
   event loop.
   - aio: free AioContext when aio_context_new() fails
   - aio: add errp argument to aio_context_setup()
   - aio-posix: gracefully handle io_uring_queue_init() failure
   - aio-posix: add aio_add_sqe() API for user-defined io_uring requests
   - aio-posix: avoid EventNotifier for cqe_handler_bh

4. Use aio_add_sqe() in block/io_uring.c instead of creating a dedicated
   io_uring context for --blockdev aio=io_uring. This simplifies the code,
   reduces the number of file descriptors, and demonstrates the aio_add_sqe()
   API.
   - block/io_uring: use aio_add_sqe()
   - block/io_uring: use non-vectored read/write when possible

The highlight is aio_add_sqe(), which is needed for the FUSE-over-io_uring
Google Summer of Code project and other future QEMU features that natively use
Linux io_uring functionality.

rw        bs iodepth aio    iothread before after  diff
randread  4k       1 native        0  78353  84860 +8.3%
randread  4k      64 native        0 262370 269823 +2.8%
randwrite 4k       1 native        0 142703 144348 +1.2%
randwrite 4k      64 native        0 259947 263895 +1.5%
randread  4k       1 io_uring      0  76883  78270 +1.8%
randread  4k      64 io_uring      0 269712 250513 -7.1%
randwrite 4k       1 io_uring      0 143657 131481 -8.5%
randwrite 4k      64 io_uring      0 274461 264785 -3.5%
randread  4k       1 native        1  84080  84097 0.0%
randread  4k      64 native        1 314650 311193 -1.1%
randwrite 4k       1 native        1 172463 159993 -7.2%
randwrite 4k      64 native        1 303091 299726 -1.1%
randread  4k       1 io_uring      1  83415  84081 +0.8%
randread  4k      64 io_uring      1 324797 318429 -2.0%
randwrite 4k       1 io_uring      1 174421 172809 -0.9%
randwrite 4k      64 io_uring      1 323394 312286 -3.4%

Performance is in the same ballpark as without fdmon-io_uring. Results vary
from run to run due to the timing/batching of requests (even with iodepth=1 due
to 8 vCPUs using a single IOThread).

Here is the performance from v1 for reference:
rw        bs iodepth aio    iothread before after  diff
randread  4k       1 native        0  76281 79707  +4.5%
randread  4k      64 native        0 255078 247293 -3.1%
randwrite 4k       1 native        0 132706 123337 -7.1%
randwrite 4k      64 native        0 275589 245192 -11%
randread  4k       1 io_uring      0  75284 78023  +3.5%
randread  4k      64 io_uring      0 254637 248222 -2.5%
randwrite 4k       1 io_uring      0 126519 128641 +1.7%
randwrite 4k      64 io_uring      0 258967 249266 -3.7%
randread  4k       1 native        1  90557 88436  -2.3%
randread  4k      64 native        1 290673 280456 -3.5%
randwrite 4k       1 native        1 183015 169106 -7.6%
randwrite 4k      64 native        1 281316 280078 -0.4%
randread  4k       1 io_uring      1  92479 86983  -5.9%
randread  4k      64 io_uring      1 304229 257730 -15.3%
randwrite 4k       1 io_uring      1 183983 157425 -14.4%
randwrite 4k      64 io_uring      1 299979 264156 -11.9%

This series replaces the following older series that were held off from merging
until the QEMU 10.1 development window opened and the performance results were
collected:
- "[PATCH 0/3] [RESEND] block: unify block and fdmon io_uring"
- "[PATCH 0/4] aio-posix: integrate fdmon into glib event loop"

Stefan Hajnoczi (12):
  aio-posix: fix race between io_uring CQE and AioHandler deletion
  aio-posix: keep polling enabled with fdmon-io_uring.c
  tests/unit: skip test-nested-aio-poll with io_uring
  aio-posix: integrate fdmon into glib event loop
  aio: remove aio_context_use_g_source()
  aio: free AioContext when aio_context_new() fails
  aio: add errp argument to aio_context_setup()
  aio-posix: gracefully handle io_uring_queue_init() failure
  aio-posix: add aio_add_sqe() API for user-defined io_uring requests
  aio-posix: avoid EventNotifier for cqe_handler_bh
  block/io_uring: use aio_add_sqe()
  block/io_uring: use non-vectored read/write when possible

 include/block/aio.h               | 136 +++++++-
 include/block/raw-aio.h           |   5 -
 util/aio-posix.h                  |  18 +-
 block/file-posix.c                |  40 +--
 block/io_uring.c                  | 508 ++++++++----------------------
 stubs/io_uring.c                  |  32 --
 tests/unit/test-aio.c             |   7 +-
 tests/unit/test-nested-aio-poll.c |  13 +-
 util/aio-posix.c                  | 143 +++++----
 util/aio-win32.c                  |   6 +-
 util/async.c                      |  55 +---
 util/fdmon-epoll.c                |  52 ++-
 util/fdmon-io_uring.c             | 219 ++++++++++---
 util/fdmon-poll.c                 |  88 +++++-
 block/trace-events                |  12 +-
 stubs/meson.build                 |   3 -
 util/trace-events                 |   4 +
 17 files changed, 703 insertions(+), 638 deletions(-)
 delete mode 100644 stubs/io_uring.c

-- 
2.49.0



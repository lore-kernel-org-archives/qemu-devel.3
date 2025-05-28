Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4625EC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 19:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKM9a-0006xc-91; Wed, 28 May 2025 15:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKM9V-0006wO-M9
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uKM9T-0004DS-5C
 for qemu-devel@nongnu.org; Wed, 28 May 2025 15:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748459361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iD8wBt9WieeMEs9yrEtl+kC+UcMchGOWI0bzzK8AXEw=;
 b=N36/3Pggnn5IERGpR2HR/H3WK0N3tzBLhuG+9EvrP2b6EKjrgUEIbnwZs3R2kIYYEGJ6VH
 VE+SfN2FRNhyG3g0JI/X63ztbzmLjRyfWanVH4NhkYhq3GXbjtLumxasQk49niTvXXgYQr
 +zg3ycXYcmdQ7/GdeB23JIhOoXkB9u4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-weVGtFUsMtGcRxS3tHTZxQ-1; Wed,
 28 May 2025 15:09:19 -0400
X-MC-Unique: weVGtFUsMtGcRxS3tHTZxQ-1
X-Mimecast-MFC-AGG-ID: weVGtFUsMtGcRxS3tHTZxQ_1748459359
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC27F1955E79; Wed, 28 May 2025 19:09:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.178])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF3CF180049D; Wed, 28 May 2025 19:09:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 hibriansong@gmail.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [RFC 00/11] aio: add the aio_add_sqe() io_uring API
Date: Wed, 28 May 2025 15:09:05 -0400
Message-ID: <20250528190916.35864-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch series contains io_uring improvements:

1. Support the glib event loop in fdmon-io_uring.
   - aio-posix: fix polling mode with fdmon-io_uring
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

The highlight is aio_add_sqe(), which is needed for the FUSE-over-io_uring
Google Summer of Code project and other future QEMU features that natively use
Linux io_uring functionality.

I'm not happy with performance yet. This is why I've marked the series as
Request For Comments:
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

Overall the performance decreases, so I need to continue profiling the
iodepth=64 cases with aio=native and aio=io_uring.

This series replaces the following older series that were held off from merging
until the QEMU 10.1 development window opened and the performance results were
collected:
- "[PATCH 0/3] [RESEND] block: unify block and fdmon io_uring"
- "[PATCH 0/4] aio-posix: integrate fdmon into glib event loop"

Stefan Hajnoczi (11):
  aio-posix: fix polling mode with fdmon-io_uring
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

 meson.build                       |   2 +-
 include/block/aio.h               | 134 +++++++-
 include/block/raw-aio.h           |   5 -
 util/aio-posix.h                  |  18 +-
 block/file-posix.c                |  38 +--
 block/io_uring.c                  | 489 +++++++-----------------------
 stubs/io_uring.c                  |  32 --
 tests/unit/test-aio.c             |   7 +-
 tests/unit/test-nested-aio-poll.c |  13 +-
 util/aio-posix.c                  | 134 ++++----
 util/aio-win32.c                  |   6 +-
 util/async.c                      |  53 +---
 util/fdmon-epoll.c                |  52 +++-
 util/fdmon-io_uring.c             | 218 ++++++++++---
 util/fdmon-poll.c                 |  88 +++++-
 block/trace-events                |  12 +-
 stubs/meson.build                 |   3 -
 util/trace-events                 |   4 +
 18 files changed, 668 insertions(+), 640 deletions(-)
 delete mode 100644 stubs/io_uring.c

-- 
2.49.0



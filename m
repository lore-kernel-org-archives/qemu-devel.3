Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D45D1BDCC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrx0-0007X9-Qr; Wed, 03 Dec 2025 13:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrwz-0007Wd-Pe
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrwy-00011b-8y
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764787899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f+SF4ZAeOJ4gCiPUBMo4kwOzQ6fI215fsVKxys3/XV0=;
 b=HrMmRGVMvqW17SIAfW5m6NZBnRMWLEPSY/l7k85qzJXvUkNS+8vO/stNi6aNY95bZTSVgk
 VYuRIMRvsDAX6katucmZGVW2BOIW+KAQ0PUnFsQeY6fA47waorAvWBYXeOmBs9LcRhzMlw
 U22OUTjXClFEtQXftJyVTWs1gImNjG0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-1raaqTdsOaCCzp7_FOfimA-1; Wed, 03 Dec 2025 13:51:38 -0500
X-MC-Unique: 1raaqTdsOaCCzp7_FOfimA-1
X-Mimecast-MFC-AGG-ID: 1raaqTdsOaCCzp7_FOfimA_1764787897
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b2f79759bso65705f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 10:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764787895; x=1765392695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f+SF4ZAeOJ4gCiPUBMo4kwOzQ6fI215fsVKxys3/XV0=;
 b=O/zgee9deo+weW5I42GeWy72KnnPsVOB4q8QuORaYcVXR3Jj36R0qXw3RxPSFQkawc
 FJYtjnxpRPWhlxg6iaALRi/qE/oktYvW7MjfH2RlBE5z0ZK0o4iFk8FPIKBWLD2Gh+TC
 MXyCaFfa69IGyAslbBoDHyCGuid15ihRfM2S8JmidWQlAWzXeMfnJLi7fvejNTDfj5XI
 fSNHlmDzHuJ248bet8GDoODuHFL4qUQOxe6QpmcDWJs/hdd1SQikC/x3HoyvfQn6YD5t
 keBjetdHru/p9Fh2bEXnkWMpxyWxlRYyJOw7refSoRKiQ6t+55tY5/7jWpgi1CxTgRgD
 0zEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764787895; x=1765392695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+SF4ZAeOJ4gCiPUBMo4kwOzQ6fI215fsVKxys3/XV0=;
 b=YyxI6oGyLiQK9jFehjxTcFWvxkq5iYNP8IyaRxwiWrg8jk1aS9MHX6vtp4dJjRyZJK
 a8MDnA2ZZktyTOIwzDBhxspThpAng6CutG+SfhUBpNSWiY9Q3/tu6qcqAMm/OI17LSFb
 8uCW+gaLsaDXEG0oCjqIiNxckym+MmR9uImL3UYm61TBZL+OsJnfgqItcZFuwu8HJynR
 QouOQNK+gVLijH6szrBD4n/E2n/ItcW1UZxL4sMwZsFBgGP6zjNBV2vpq1+nnGDOHaoE
 cHxJUMGFlP8cYmviqnvNwgKYoUSeqU7xAbEfEvE8s5OeP6Tidb7a2td3jATQ2mgl9St9
 WtpA==
X-Gm-Message-State: AOJu0YzJ+fdXND+3litPVSXHTBvWVqzw0+fKSrBcwgijG0+Ldq3PU6XP
 4QbGN43l75T8vswf6odKze5MXrXNMBGQWOfrjTzLkA0P84TtozArAQdKTdkQ/efK8fZo46Vhb9P
 tbGaTz8DksHh5rPnmmlouyN3pSfSDNgraqu/oUpBROAeqsT6chvBBP6SAA52gh0HprBjpHmVs45
 jquMO4U8jDk5U0/88qDWf3UZHUKqO+lOTB0RvAJzF4
X-Gm-Gg: ASbGnctlNH1EXH81uLLz00l5rmExSR1gKO/JVTPV+qtPKF3AhX92rBjDwi7l9K4dd6n
 dsdfw/RLGl7rRh2ZESJ3CBiZexUkqtbBk6QukRRE88HRuTHZKJwILhcP63yO3DUc33LJITudzLe
 Pn5Vh+2E6B6ORM2dRyLIcHJyjQaXlEyNtHioJKvlUMj/m6TnMxdO3nvva/R/94i1ksQLZ7+4VLJ
 vHa8wL9Yo8aDvZ+VNz7pmMrjfr0x+/7GeJT7YZ7Z2TMSjrzkEEXigD6q3dmRssAt6h57FDtdCEu
 JJvXBkBcXbTz48dm+rrCifvPyX48zMAZpStf8BGPaUr33udupQajwYJqXAnrplUorrrI/dqYp4R
 2qDnC2ZaL8PIsSXqyKwArSpnbmTq1xrPDGAfK15ktU/7B1wNYjklTccX5upYuyuGgX0QV9um8cJ
 vXXHNS5sz3dOmMc/8=
X-Received: by 2002:a05:6000:288a:b0:429:d4e1:cb9d with SMTP id
 ffacd0b85a97d-42f73167517mr3904660f8f.8.1764787895567; 
 Wed, 03 Dec 2025 10:51:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2pNDYjfOvaOr4HFlg/19O2R4hjBVD2a7pcnsfaO1HNfvCek0A6ZUGEy1PwEqWnOidBZ0Seg==
X-Received: by 2002:a05:6000:288a:b0:429:d4e1:cb9d with SMTP id
 ffacd0b85a97d-42f73167517mr3904635f8f.8.1764787895120; 
 Wed, 03 Dec 2025 10:51:35 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca7880asm41281076f8f.31.2025.12.03.10.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 10:51:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	kwolf@redhat.omc
Subject: [PATCH 0/5] block: move AioContext and AIOCB out of include/block/
Date: Wed,  3 Dec 2025 19:51:28 +0100
Message-ID: <20251203185133.2458207-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Split include/block/aio.h into qemu/aiocb.h and qemu/aio.h,
and reduce the amount of included files from outside include/qemu/
for consistency with the implementation's placement in util/.

While Kevin originally suggested moving AIOCB declarations to
block-common.h, the functions are implemented in util/aiocb.c
and outside the block layer too, for example in the thread pool
(see thread_pool_submit_aio which is used in places such as 9pfs,
TPM backends or hw/virtio/virtio-pmem.c).  So, do keep a separate
small header but call it util/aiocb.h---not block/aio.h.

Compared to the previous attempt, this introduces another teeny tiny
header qemu/mem-reentrancy.h, which is used to avoid including
hw/core/qdev.h

Also for consistency, move block/aio-wait.h to qemu/aio-wait.h;
it is effectively part of the main event loop implementation, not
the block layer.

Paolo

Based-on: <20251127131516.80807-1-pbonzini@redhat.com>
Supersedes: <20251128101555.227630-1-pbonzini@redhat.com>

Paolo Bonzini (5):
  hw: add missing includes hidden by block/aio.h
  block: extract include/qemu/aiocb.h out of include/block/aio.h
  block: reduce files included by block/aio.h
  block: rename block/aio.h to qemu/aio.h
  block: rename block/aio-wait.h to qemu/aio-wait.h

 MAINTAINERS                        |  4 ++--
 docs/devel/multiple-iothreads.rst  |  4 ++--
 fsdev/qemu-fsdev-throttle.h        |  1 -
 include/block/block-copy.h         |  1 +
 include/block/block-global-state.h |  2 ++
 include/block/block-io.h           |  4 +++-
 include/block/block_int-common.h   |  2 +-
 include/block/dirty-bitmap.h       |  1 +
 include/block/raw-aio.h            |  3 ++-
 include/block/thread-pool.h        |  3 ++-
 include/hw/char/serial.h           |  1 +
 include/hw/core/qdev.h             |  6 +----
 include/hw/ide/ide-dma.h           |  2 +-
 include/hw/scsi/scsi.h             |  3 ++-
 include/hw/virtio/virtio.h         |  2 +-
 include/io/channel.h               |  2 +-
 include/{block => qemu}/aio-wait.h |  2 +-
 include/{block => qemu}/aio.h      | 28 +++-------------------
 include/qemu/aiocb.h               | 38 ++++++++++++++++++++++++++++++
 include/qemu/job.h                 |  4 +++-
 include/qemu/main-loop.h           |  4 ++--
 include/qemu/mem-reentrancy.h      | 10 ++++++++
 include/qemu/throttle.h            |  1 +
 include/scsi/pr-manager.h          |  2 +-
 include/system/event-loop-base.h   |  2 +-
 include/system/iothread.h          |  2 +-
 include/system/replay.h            |  2 +-
 tests/unit/iothread.h              |  2 +-
 util/aio-posix.h                   |  2 +-
 block/aio_task.c                   |  2 +-
 block/export/fuse.c                |  2 +-
 block/io.c                         |  2 +-
 block/io_uring.c                   |  2 +-
 block/linux-aio.c                  |  2 +-
 block/win32-aio.c                  |  3 ++-
 blockjob.c                         |  2 +-
 hw/core/ptimer.c                   |  1 -
 hw/misc/i2c-echo.c                 |  1 -
 hw/virtio/iothread-vq-mapping.c    |  1 +
 hw/virtio/virtio-pmem.c            |  1 -
 io/channel.c                       |  2 +-
 iothread.c                         |  2 +-
 job.c                              |  2 +-
 net/colo-compare.c                 |  2 +-
 net/filter-mirror.c                |  2 +-
 net/net.c                          |  1 +
 qapi/qmp-dispatch.c                |  2 +-
 replay/replay-events.c             |  2 +-
 scsi/pr-manager.c                  |  2 +-
 scsi/qemu-pr-helper.c              |  1 -
 stubs/linux-aio.c                  |  2 +-
 stubs/replay-tools.c               |  2 +-
 tests/unit/iothread.c              |  2 +-
 tests/unit/test-aio-multithread.c  |  2 +-
 tests/unit/test-aio.c              |  2 +-
 tests/unit/test-nested-aio-poll.c  |  2 +-
 tests/unit/test-thread-pool.c      |  3 ++-
 tests/unit/test-throttle.c         |  2 +-
 ui/input-linux.c                   |  1 -
 ui/vnc-jobs.c                      |  1 -
 util/aio-wait.c                    |  2 +-
 util/aiocb.c                       |  2 +-
 util/async.c                       |  3 ++-
 util/main-loop.c                   |  2 +-
 util/qemu-co-timeout.c             |  2 +-
 util/qemu-coroutine-lock.c         |  2 +-
 util/qemu-coroutine-sleep.c        |  2 +-
 util/qemu-coroutine.c              |  2 +-
 util/throttle.c                    |  2 +-
 util/vhost-user-server.c           |  2 +-
 hw/display/apple-gfx-mmio.m        |  2 +-
 hw/display/apple-gfx.m             |  2 +-
 scripts/analyze-inclusions         |  2 +-
 73 files changed, 128 insertions(+), 95 deletions(-)
 rename include/{block => qemu}/aio-wait.h (99%)
 rename include/{block => qemu}/aio.h (97%)
 create mode 100644 include/qemu/aiocb.h
 create mode 100644 include/qemu/mem-reentrancy.h

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4356EE0ADA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voh8Q-00077X-3A; Sat, 07 Feb 2026 07:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh7x-00073K-Rr
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:09:34 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh7r-0002qH-Mb
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:09:27 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so510409a12.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 04:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770466158; x=1771070958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=btvEaztmCH+wb7+Uy7FvTR6ih4vYcYGyRc0yBVVgLZY=;
 b=FL+cj1Y0AMbHeBYFgUbP1xxY8SkHR9c7X3+c+4vmGXbImUkaXVmkvdenKdlK61//mp
 m4pwMMhD1KusczinlqYdRJaWWjamz8MIFvyVld41+qKwA2nYIAKfUfc3LDtiaKI0nt1F
 jXNWdhhzZOVcK6m2TS3IpbqXj07tPQpEd7abpC5BH5F/OlNaYhX2W+5+500oyfLtHXjV
 WNQHHDYLeK7fmMSB6JDVC8JDbSTLd6csVKT3o7lZQoVKpHFCWsUASCHoljMl7lazIKjI
 67uewoNPpdjQc5wt1rJF9ZUo4v0KtjG02ngLJi1kaChgGCybzX7nGaovLcP+b2xHy45W
 mV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770466158; x=1771070958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btvEaztmCH+wb7+Uy7FvTR6ih4vYcYGyRc0yBVVgLZY=;
 b=kLxJ7vY5O34eYc+FFHFrmVaSjQaQhXYh8Rc+ZVwRW8IxrmpoE3meIF/fufMlIfoeIJ
 SaM9R9Tnx+m5t8sOI8vmn6JQxnNwWT0poy/menP2CBMMkQ66dzCC3d45lEUwrI7zWgQ7
 YnJau53JWod9K+72+m8Z7tczHieArbhLtMfJ1ysu28z6JH/LtLjmfxzcDYZgFUE5hlLW
 xRF+SAfzP3m4SW8NW8zOqz1fWOqoDjxxPExTdVodqk9RJCf74KkWYy6Owa8uQwVWP7k5
 kxy6NcJnZvf5E7WmR8mwioiNLnmEbx1+HZ8zgkdZ9cRTEFIw+6346PpzBjz8+oQtPVvh
 b+ig==
X-Gm-Message-State: AOJu0YzI5N2EpBJUqB/NgywT28TIQJKJ+vzLFeQQ+Qj6O6sGjqvTfdEG
 ekGMkngEiaQhJ+uS53xk7U5rW3m8Z7YZUmcpbs4Dsy5kB8jmvTU3ZTMV
X-Gm-Gg: AZuq6aL+aLwhU/6LF2a47wBGkpnKwmnEZalCOnaEu9zkjbjSfRf07eW4zS2p9qj8DWv
 RjU3Zv0I5BUJ7t0jpFcjXs8Rza7a3SV3o8vWaU7vtdRnupvMviyG77Dn9crYh/eHr2gu7s8NJGD
 E/8Nq9/w2ev3ZFiFGD7eYY/mpajK/M/pFUJqbOFd48gFQBRbHkwSgEgOHhlWCdUn+XN9R1DOf0N
 SFWcCxO4+pL8l2A52RgAjYY2mRYCKSqBFi6bgH2WYt+y3QVUVI/RR2lfb+MaqrPRZFBFJuQQ1yb
 l53Ki9K3GUZWaGEG5r2IopDrQWSyFqiJSb7OYAz9b6uHe0yUvp3q6QKQUumKTXq5kIsOKZL8je7
 oJeaxVgjByQHYFHHi9wsi+uDlXPX3Pt9wg0D54f5y6IrZv98NRpYFy0NAErcfy19oxIYB7uoqGa
 Sui6p8nzzXSoDGpzNWBVgwzHSKjtIRA/qtAYDj
X-Received: by 2002:a17:902:e802:b0:29e:9387:f2b9 with SMTP id
 d9443c01a7336-2a95165cb27mr52251595ad.24.1770466158427; 
 Sat, 07 Feb 2026 04:09:18 -0800 (PST)
Received: from brian.. (n058152022104.netvigator.com. [58.152.22.104])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b30f899csm2178530a91.3.2026.02.07.04.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 04:09:17 -0800 (PST)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hibriansong@gmail.com, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, fam@euphon.net, bernd@bsbernd.com
Subject: [PATCH v4 0/7] add fuse-over-io_uring support
Date: Sat,  7 Feb 2026 20:08:54 +0800
Message-ID: <20260207120901.17222-1-hibriansong@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=hibriansong@gmail.com; helo=mail-pg1-x530.google.com
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

Hello everyone,

This patch series introduces native io_uring support for FUSE storage
export to overcome the scalability limits of the /dev/fuse interface.
By utilizing shared memory ring buffers and per-core queues, this
feature drastically reduces context switch overhead and lock contention.
This allows FUSE export daemons to achieve much higher throughput and
lower latency by minimizing the userspace-kernel switch penalty.

More details on Fuse-over-io_uring:
https://docs.kernel.org/filesystems/fuse/fuse-io-uring.html


Changes in this version:

- Reorganized patch structure.
- Unified naming of Uring data structures (e.g. FuseRing -> FuseUring)
- Refactored FUSE_IN/OUT_OP_STRUCT_LEGACY
- Code cleanup and logic simplification:
	- Used the io_uring flag to indicate the intention to enable
	  Fuse-over-io_uring.
	- Used uring_started to track the active state.
	- Removed unnecessary #ifdef CONFIG_LINUX_IO_URING guards.
- Moved fuse_fd closing to BH in uring mode to prevent data races.
- Updated tests: now using mount to verify if the test image mount is
  fully gone.

More detail in the v3 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-08/msg00325.html

V2 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-08/msg00140.html

V1 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-07/msg00280.html

We used fio to test a 1GB file under both legacy FUSE and
FUSE-over-io_uring modes. The experiments were conducted with the
following iodepth and numjobs configurations: 1-1, 64-1, 1-4, and 64-4,
with 70% read and 30% write mix. This resulted in a total of 8 test
cases, measuring both latency and throughput.

Performance Results:

[Bandwidth (MiB/s)]
| Config (Job/QD)  | Read (Leg -> Uring) | Write (Leg -> Uring)|
|------------------|---------------------|---------------------|
| 1 Job, QD=1      | 72.2 -> 104         | 30.9 -> 44.7        |
| 1 Job, QD=64     | 114  -> 181         | 48.8 -> 77.7        |
| 4 Jobs, QD=1     | 109  -> 159         | 47.0 -> 68.5        |
| 4 Jobs, QD=64    | 106  -> 160         | 45.7 -> 68.9        |

[Latency (usec)]
| Config (Job/QD)  | Read (Leg -> Uring) | Write (Leg -> Uring)|
|------------------|---------------------|---------------------|
| 1 Job, QD=1      | 37.0 -> 23.7        | 36.9 -> 29.5        |
| 1 Job, QD=64     | 1537 -> 964         | 1535 -> 967         |
| 4 Jobs, QD=1     | 96.6 -> 66.4        | 114.2 -> 71.9       |
| 4 Jobs, QD=64    | 6560 -> 4234        | 6600 -> 4280        |

Brian Song (7):
  [Patch v4 1/7] aio-posix: enable 128-byte SQEs
  [Patch v4 2/7] fuse: io_uring mode init
  [Patch v4 3/7] fuse: uring support for write ops
  [Patch v4 4/7] fuse: refactor FUSE request handler
  [Patch v4 5/6] fuse: safe termination for io_uring
  [Patch v4 6/7] fuse: add 'io-uring' option
  [Patch v4 7/7] fuse: add io_uring test support

 block/export/fuse.c                  | 958 +++++++++++++++++++++++----
 docs/tools/qemu-storage-daemon.rst   |   7 +-
 qapi/block-export.json               |   5 +-
 storage-daemon/qemu-storage-daemon.c |   1 +
 tests/qemu-iotests/check             |   2 +
 tests/qemu-iotests/common.rc         |  47 +-
 util/fdmon-io_uring.c                |   7 +-
 7 files changed, 879 insertions(+), 148 deletions(-)

--
2.43.0



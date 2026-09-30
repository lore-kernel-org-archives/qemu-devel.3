Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB14CA5FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxVm-0006Zb-BL; Wed, 30 Sep 2026 12:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVP-0006M2-8D
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:07 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVN-0003S6-Ai
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:06 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so35466095e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787003; x=1791391803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oR3B9Mgx7cfh4Jf0hDk2J3MqNkN6++QnkyP15plQyY8=;
 b=eboFzwmB3jAtyq/CXsNVxIGdDKckkUarT/YyKIQ1ztmGY8vsE4pIoykqjHigAiNl2T
 7KGNDpupKPViwlNPmDskpGWeJwQk+IkRYqQZ0u9qQS711Iw0bdavBwSA4k1krcYRzO7v
 saPCBmBSzKMOFc0ktrFX1D2LGQNCoQXdF55wTRk5Te4N0kLRyFsyubW5DMfPjXXZYDZ6
 6Xn+A5bYNG0SVaWICLr1qT1Avpzm/hh4GGJkeOzcV+6jTIOYm3Lv2q4yspf/Ue42it54
 +PeKiFOZ0I5jalGUDZx6ydhDlN+6b/NYH2BGlkWH2/l8d/snts7b7hIvgL6bJex5PwWD
 O2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787003; x=1791391803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oR3B9Mgx7cfh4Jf0hDk2J3MqNkN6++QnkyP15plQyY8=;
 b=zo0+wIgUagAeeQ8LXuRbFcFKCfZrM36y1gNJnw7u/L2HAVmdQlDgj1E1TksZOs8GuI
 TNjeOtdKrRZ2ZVz8FWhcxgNHZYd345CR3zLlun/+373KH2tHISevb+MFHicSoR9vnbNE
 kOMcmhj3hsaoLbx0D+Hk9t3Cnd5/HKvXkwJXmdUIkWpAnvHTIvf2YT4nMsPkCU9+ksnY
 oDY0SJGmtytE6kaqjBHaUAIOZgmfJcn9yQPTzibtFHNQT3uri3Cui/1R1qsxAz2j8ZAd
 1WhR/3ENDek/udQVnvCLtLxrabkCO4k2sHMXhtJHHyjT9fgsOwlV/XVvZ7PrHe9i5vKz
 aFtg==
X-Gm-Message-State: AFuF++m2mHyxnBISDjub+DkgjMh5BH/Qnm44KjqgvWjoDrS0E/9jdVAH
 jsavub5255Haq29Ku5Sepn46HdBXK4cVbwCGXnpnZMM4AGRy7aXP4fMADudyfK3FclWKfpd2/nj
 tD3GT
X-Gm-Gg: AYBFou2GBDheOgdW/EcYYssW9lWHxItubiZWNwnw/xdvdMSvFyYTUpdPIbsuVFkwo9a
 j/jIAM/SDEkauTiT3vro80NKJ2H7k9ASk8L4xWKfTnaaj4t8O71Hgiw8ZDNDBLxjiXOwcK8khxP
 r1MRbPsRoZir4Do5dnTt8tZH5+HKzhCL7ECOC5KCR7jYesuazsB7f42VWKzIfdI6rS+lvUny8rA
 8S0Emy5DvXc60zKt00y3bN8ATylq7/NoCFraCVU28CJ85LR+PvpEXhFtiiPqfgNLSSq+/MIW4GY
 1wdsH5xWdO1piDrleB8Ri4VUjjbOvoXQsdJX2Y/2ySRDQFQZ2LaFANeW5DTalP/mSBudYPJurtF
 9einus+ke5pLz+M4pQf/FSiw/RGjBh6kqpns4RG+3CS9ZXhgl4ltI3gETBN/jWJ2avMWIYakMrq
 WzEi3s0EyDUj9XgmHa0C6tG90CivCKOFyK4WgYaRB0baVS2Jm9QGxC4Ae+fn6xqjOSVzc=
X-Received: by 2002:a05:600d:82f0:b0:4a0:1e64:4238 with SMTP id
 5b1f17b1804b1-4a01e644325mr11562205e9.24.1790787003398; 
 Wed, 30 Sep 2026 09:50:03 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:02 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 00/13] block: fix data loss in the preallocate filter
Date: Wed, 30 Sep 2026 18:49:46 +0200
Message-ID: <20260930165000.303236-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

A guest running a container workload came up with 164 files of an image
layer hollowed out, 45 MiB in all, reading back as zeroes where it had
written data and been told the writes were on disk. The damage was
scattered in guest offsets but contiguous in image file offsets: a
qcow2 over something that zeroed a range of the file.

The storage underneath records every change to the file's length. Over
a tenth of a second the file grew thirteen times in unaligned steps,
one per guest write past its end, then once by 82 MiB. A preallocation
sets the length to the triggering write's end rounded up plus 128 MiB,
so 82 cannot come from the length the file then had; it can only come
from a zeroing that started where the burst began, 49 MiB lower, which
is exactly the range that came back as zeroes. The fallocate ran over
thirteen acknowledged writes.

So the filter worked from a length the file no longer had. There are
two ways to get there. Neither is proven, the record cannot decide
between them, and both are fixed here.

The first is that the filter meant to let those writes in. It raises
data_end before issuing the preallocation, so that writes below it
pass straight through into the range the fallocate is about to zero,
trusting the block layer to order them after it. That trust is
misplaced, and it needs no race to go wrong: two things meet. The
file-posix widening that patch 1 removes parks the preallocation
despite BDRV_REQ_NO_WAIT, and bdrv_find_conflicting_request() skips
any overlapping request whose waiting_for is set without looking at
what it points at, so a parked serialising request excludes nothing.

The second is that the length was simply stale. The filter's lengths
are plain fields, read, decided on and written back with nothing in
between, and the guest that broke was a virtio-blk with its queues on
two iothreads. A lost update on the reserved length gives a start 49
MiB low with no ordering subtlety at all.

For the first, the straight fix is in bdrv_find_conflicting_request(),
and it regresses iotests/077, whose "Overlapping multiple requests"
case then verifies wrong data. Patch 1 takes away the other half
instead: the XFS bug the workaround guards was fixed by 249bd9087a52
in v5.5, three days before the workaround went in, and predates every
stable series still maintained. Without the widening NO_WAIT works as
designed, so it is the one patch here I would not drop.

For the second, the same state turns out to lose data three ways:

- a write into the range the filter records as zero leaves the mark
  behind it, so a later write zeroes over that range is skipped and
  the guest reads the old data back;

- two writers extending the file both pass the compare on data_end and
  the smaller end lands last, so closing the image truncates the file
  below acknowledged data;

- two writers both preallocate over the same range, the older
  fallocate lands last, and the first writer's data is zeroed. Fixing
  this also stops the filter leaning on the ordering above.

Two of the three have tests in iotests/298. The data_end race has
none: there is no hook between the compare and the store to hang one
on.

Six patches are tooling, because none of this could be tested: every
qemu-io request ran in the main loop, blkdebug could neither wake nor
wait for a request on another AioContext, and nothing could hold a
request before the block layer tracks it, which is the window the
filter opens. None changes the output of an existing command.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Andrey Drobyshev (1):
  iotests/298: add testcase for async writes with preallocation filter

Denis V. Lunev (12):
  block/file-posix: drop the XFS workaround for post-EOF fallocate
  block/preallocate: keep zero_start above written data
  block/preallocate: collect the state assignments in one place
  block/preallocate: serialise the filter state
  block/preallocate: hold back writes into a preallocation in flight
  tests/unit: prefix the iothread test helper
  qemu-io: accept --object iothread
  qemu-io: add -t to run an aio request in a named iothread
  qemu-io: add -g to write past the end of the image
  block/blkdebug: make a breakpoint work across AioContexts
  block: add blkdebug events for a write before it is tracked
  iotests/298: cover the preallocation races

 block/blkdebug.c                  |   3 +-
 block/file-posix.c                |  34 --------
 block/io.c                        |   3 +
 block/preallocate.c               | 139 ++++++++++++++++++++++++------
 meson.build                       |   2 +-
 qapi/block-core.json              |  10 ++-
 qemu-io-cmds.c                    | 116 ++++++++++++++++++++++---
 qemu-io.c                         |  41 ++++++++-
 tests/qemu-iotests/298            | 113 ++++++++++++++++++++++++
 tests/qemu-iotests/298.out        |   4 +-
 tests/unit/iothread.c             |  28 +++---
 tests/unit/iothread.h             |   8 +-
 tests/unit/test-aio-multithread.c |   8 +-
 tests/unit/test-bdrv-drain.c      |  32 +++----
 tests/unit/test-block-iothread.c  |  28 +++---
 15 files changed, 435 insertions(+), 134 deletions(-)

-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28E8C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x683K-0002ci-J3; Mon, 14 Sep 2026 10:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683F-0002bX-AC
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:52:57 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683D-0005jw-ED
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:52:57 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso16311155e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789397573; x=1790002373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2RQnyXFGRUuI9hkTWGmkBpredWSzDoc8HPj5yVNIXrs=;
 b=FOWoaXePhESWDkbAJCoc1wM8YGcXr83qVC3OfPDpbgGHjep+QUTI0Xpd0kocANdEJH
 rmTyKDCJv/6Fq8rKz5wLw0Cm2+8c3Nr9TzsW+bs8O0d4+WsMo15JXEukcC0c1mREWYV8
 8qy/agSWuSm59ctKAAqWl1VfWH7Z7pqGD3/vmcRzZiBTad4xPLq5gknv+tAtMcfaTFfc
 qSyKKt5YWHig3s6NG6xmc3EdtvFYG1EUMVwxxENU+vTL85m08Qu3oMDUa6yGWv9gx/n/
 SIFwaMg/NRgbUvFlY2O8BKadyeJ5CJnWpm8PCK0aL65jOT7NuyDc5l2sifYQnBx1g5iR
 nqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397573; x=1790002373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2RQnyXFGRUuI9hkTWGmkBpredWSzDoc8HPj5yVNIXrs=;
 b=MwOyS7wO3cqV/EihNp/POIMfXdSGzKjBmtr+iMsjdRYyq/kBBQrVW+y9VCR0grvCFx
 Z2Ni9pLs9efubJLmSgZFJO7FZ+4IVM0fxi6gB7Ru3OVrBlia31sRZ/njCBknESt82Emv
 r9DoCEQi9tjAOzeu0ZJC9uT/smHMIdREHpMJB40lq236fx3udKRJAUyQRVf7SY/ftPgE
 TzvDzoVWLy5c3utr6JiBoqpKFnRMIZI9puwA5tPYU6B5AC3qez17+IeCaSA9atzTqGsg
 7tZIRj/9poTn2dii933rMJ9fdgwGUN457Sz8zAyhMiuDKUfOGTMz9iCC5KwOv4Mlh9zU
 VXrw==
X-Gm-Message-State: AFuF++kPG1oTNfdP/D6xDLoj33JKPK1YIFzJRnTZSPZECBqDilOTc+UQ
 a1IlDF1dYBa1g6Wg7hyxTe4mZtX6PzdUD83kHTwsuijVjHFuULNRll/Iq70BPAkQfj5gk3p9t51
 VTumD
X-Gm-Gg: AYBFou2hgPzf+TS3YVGt4eSNmx81YM6Ivt9FopxS+sVGgfcOEMdJUNbyG4yGZ2Z0Bmp
 iuL3Uh4oxaQ9Hb+bl6nyOulYR7nn/ubqBlWo5HY3msb78+fg6UMDBgrBjzLbpFGoTRxXtFs+EIR
 B6FAjhi9oecrRpWIgLR4OVcIZmGIzlX/Uw9lDBMjoScjl7StvKjjyynXmqAkaH25XDnPsrfYF+n
 kdsa3X7nKSogcRc6T+/IN25hUBey7mnjys1Dp1FEmHqxVxJ3iA1SHAudY4xuMcazVg6RQMfbKw6
 eVngxDQAbgke4bcBvIQI8ZM52M3HTZpClYTWSiMMOL76WatH3oV0ejLgjuaT826BBTklRv0Gflo
 0VbSSNPcuurid3mnHtpxSoBA1bMQ31lN3Rod0bCC/ygVnVFATgn8jMXxytTPmkSVihozh8ksZzU
 DiyaqOmrGGFmry2r/GQ2f1KW+xn1HsroBAWCl2TRJGcFHz1210e4dB09xLJdKV9xD1GJS1
X-Received: by 2002:a05:600c:6089:b0:49d:16dc:e721 with SMTP id
 5b1f17b1804b1-49e7a677a88mr40344095e9.24.1789397573353; 
 Mon, 14 Sep 2026 07:52:53 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:aec6:5a37:bc54:89b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm540230595e9.13.2026.09.14.07.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:52:52 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 0/9] block: cheaper zero handling in backup and commit
Date: Mon, 14 Sep 2026 16:52:41 +0200
Message-ID: <20260914145250.2792879-1-den@openvz.org>
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

Backup and commit re-query the source block status for every task and
size a task by the copy buffer, so a long run of zeroes turns into a
crowd of small write-zeroes requests. This series reuses what the
up-front scan already learned and lets one write-zeroes task cover a
whole run.

Backup of a 16G qcow2 image holding 1G of data, the rest never
allocated, sync=full to a raw target on ext4:

               tasks    time
    before     16384    1.6s
    after       1088    1.0s

Such an image is the normal case rather than a corner one: a guest with
discard enabled on a disk which is mostly free leaves exactly this
shape behind.

v2, all from Andrey's review:
- 2/9: holes spelled out in both layouts, and zero runs added, so the
  write-zeroes path of 3/9 is covered too
- 3/9: COMMIT_ZERO_CHUNK has a comment of its own saying what bounds it;
  the cache check drops its dead half and asserts instead
- 4/9: a Case namedtuple pairs each size with its layout, and
  create_image(), write_layout(), dirty_layout() and backup_and_check()
  take out the duplication
- 8/9: g_assert_not_reached() for the sync mode which cannot reach there
- 9/9: a widened write-zeroes request only pays off where the target
  zeroes by metadata. supported_zero_flags rules out the targets which
  cannot, and the first widened request asks for BDRV_REQ_NO_FALLBACK to
  settle the rest, since a driver may advertise it and only learn better
  from a failing call. A target which would write the zeroes out fails
  that request without writing, and the run keeps its requests at the
  buffer chunk size from there on. With the size question settled that
  way the cap became BDRV_REQUEST_MAX_BYTES rather than 256M.
- rebased on master

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Denis V. Lunev (9):
  block/commit: pass BDRV_WANT_PRECISE to block-status
  iotests/040: cover large and fragmented commit runs
  block/commit: batch block-status queries
  iotests/124: cover backup of zero clusters and holes
  block/block-copy: don't reserve memory for zero tasks
  block/block-copy: extract block_copy_set_task_method()
  block/block-copy: track known-zero source clusters
  block/backup: pre-fill zero_bitmap for full/bitmap
  block/block-copy: coalesce write-zeroes tasks

 block/backup.c             |  93 ++++++----
 block/block-copy.c         | 305 ++++++++++++++++++++++++++++----
 block/commit.c             |  58 +++++--
 include/block/block-copy.h |   5 +
 tests/qemu-iotests/040     | 102 ++++++++++-
 tests/qemu-iotests/040.out |   4 +-
 tests/qemu-iotests/124     | 344 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/124.out |   4 +-
 8 files changed, 827 insertions(+), 88 deletions(-)


base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
-- 
2.53.0



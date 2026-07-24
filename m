Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEC0C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDqC-0001T5-0y; Fri, 24 Jul 2026 07:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wnDqA-0001S1-DG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:13:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wnDq8-0001lA-Q6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:13:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so3715595e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784891595; x=1785496395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zDkwLaUsoy4J0tN32SXTZrDUDaqDRxbDXAFu4Dcrgrs=;
 b=UXJEOHsVoEqmLzan3DEhYqyxF6Dxe7ccrJF4xLEexCgYGQNfUFsECVa1b2L68WkrrO
 nMR2Qkcv1jDtqsTLxnJiQKE6ykdiFWWi5W5irIgpPVSwFWekNqip29kS9BrWTm4vYnwg
 4A1EuvhLZhH4vWfM1wk0aa79FlwPFl7biG42X/fECmIeH0O7VA9SIMAeIueYH6fHTklT
 wggQD8Xi7tx8hFGKaueXogjmQk0UNog/gXyeavXcMSQKDIhYYWFeC1+obYMQbdIJcFWq
 oreKUMbzs8xjJt5Xm/zsOxe7zmNzOmZedp58dY1pi3+AEUWFYZHtytr0ONf24s9/DiW8
 2Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784891595; x=1785496395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zDkwLaUsoy4J0tN32SXTZrDUDaqDRxbDXAFu4Dcrgrs=;
 b=P2uCacfSt/VXihIWz37b1dsQgo76DhjDvlEEqTnV6x1x2Pq2IGDzVIdWnUPX9X4gbk
 57nzvn2uExsECx7DwELcOcHFmze0IfMxlONdtA0oE1z5d/cK3ckf9L5+k9auRwyPf97G
 /QdkV25zLzWYcFQXO4/68ALDLgDOuvnf7V3rUQW1TkQptlqT64lJu0u8STxPueqHJ4eU
 zI9CJhpLImIKp3YJsktkfxLb7cjxb/QAbpsQ72TzZ16aiLOzK0g3+x0FmSlN3fcV6SpS
 IuYcD1+0R8FnXrPWXlB6wpjsM0bGFhshy4C2hawzMBPLmws8jrzwAYqR12OHOlZKzAZy
 bpLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RocY52g453azEe9j4kCw1zmj6LwjYoObwip67jTUrE4ciTYhaRWiqfOMG2kL4lsnTRYBLLCmlO4vTrq@nongnu.org
X-Gm-Message-State: AOJu0Yw537AFBhLwM1j42EoLmhXF6rE3mV7PkaunZ7uiNi15m98IkiEm
 RlUeaJZokTO68cWhUWVkyrXFwJ3pb+zW8KH/RzVyfVQC6acDUywXoFdmONDXv4ySO9U=
X-Gm-Gg: AR+sD12V6ihDA228Fytn4+SJihmT1bY8Dt1rpQgMDGp6SAsMLhfX4uREk6p9ES2pmD9
 dgnbFVUH6fnFgyWLD087/jsTKyO17pMCeQgh2zmh7LuBrpa63b97NTczh09vsXKPbIaUn1ZUFxS
 ODK4g/6lKsmUrlST+obq0i5aBfEvo7DYFM0zqcaIsVTsMjsVjUlPqGOGAllB9vz50iVKoGRf5ve
 YNMHSZHaNO70BdurXbe3gTeLb8CaHcWMu5jM8RGsjJswsH1lpKh9oy1/KVxBA8qzYw7/D/VtUPm
 NLEf89doJEpQ/Jy16QsCKf+/JjD7x0Uw0NTTTuiDM2taVL/IZp2JTLcamkO42nx8YfJOB++/QDY
 L8RoSOSqhfDQJyiFALVAxBf0j36rVYeANcu9uiajrMFiMd4KQVihm+AW/u52vwYlNeBrphMfles
 s=
X-Received: by 2002:a05:600c:c05a:b0:495:63f5:7a4f with SMTP id
 5b1f17b1804b1-49573d03068mr84249475e9.33.1784891594661; 
 Fri, 24 Jul 2026 04:13:14 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f7d:7b60:9d07:3a1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531basm23792473f8f.19.2026.07.24.04.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:13:14 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 0/3] block/accounting: fix unlocked latency histogram
 reconfiguration races
Date: Fri, 24 Jul 2026 13:13:08 +0200
Message-ID: <20260724111311.4086859-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

block_latency_histogram_set() and block_latency_histograms_clear()
replace BlockLatencyHistogram's nbins/boundaries/bins without taking
stats->lock, while block_account_one_io() reads those same fields
under that lock from whatever iothread completes the I/O. A histogram
reconfiguration (block-latency-histogram-set QMP command, monitor
thread) racing an in-flight completion can therefore observe those
fields torn, hitting assert(pos != NULL) in
block_latency_histogram_account(), or corrupting the heap outright.
This showed up as a qemu-kvm SIGABRT on a customer's virtio-blk guest.

Regression test is added for illustrative purpose but I am unsure that
it is viable long term. Feel free to drop.

v1 -> v2
* patch 1, 2: WITH_QEMU_LOCK_GUARD -> plain lock()/unlock(), pure
  additions, nothing reindented or moved
* patch 3: writer thread now also calls
  block_latency_histograms_clear(), the other function patch 1 fixes
* patch 2: take stats->lock for bdrv_query_blk_stats()'s whole call
  instead of per-section, since the interval loop's
  timed_average_min/max/avg() calls race timed_average_account() the
  same way the already-locked fields did; block_acct_queue_depth()
  now requires the caller to hold the lock instead of taking it
  itself, since bdrv_query_blk_stats() is its only caller

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Denis V. Lunev (3):
  block/accounting: take stats->lock in latency histogram setters
  block/qapi: take stats->lock when reading BlockAcctStats for
    query-blockstats
  tests/unit: add reproducer for BlockAcctStats histogram locking race

 block/accounting.c                 |  11 ++-
 block/qapi.c                       |   3 +
 include/block/accounting.h         |   1 +
 tests/unit/meson.build             |   1 +
 tests/unit/test-block-accounting.c | 115 +++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+), 2 deletions(-)
 create mode 100644 tests/unit/test-block-accounting.c

-- 
2.53.0



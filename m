Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C51C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqRc-0004aC-GR; Tue, 11 Aug 2026 13:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRV-0004X5-Dc
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:14 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRT-0000SW-TP
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:13 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a36982a875so162947a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786469950; x=1787074750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/FLrBFGnc3sdlHbz+yFP8aIfw/LA8xDvV8QDl90J8e8=;
 b=mT3oabxFNdsky6+qWD3+ISnToOZmXtNbL1bw+KcoSFjD+RHuzO8W0zbtz4s+Bs/QeN
 2a5qGbHIX9fCapQzqLcLGUINymQsErZ3aCbm6WSn2KnGP2qxKu/6epjlaMqwgoaisE8C
 TKceTniHeDp+6bHTq9VHxXsRCCVUvtKq+5MhpVGPQ4rNpA03r748IQQEgwW4nmqGMxN/
 SpoaTxyeTbKbPie7zZ9TPUTX2EmyeQ1RDpWIU9V6ceYAE2pkqTl3z1qHi69FKRRPh8MH
 +x9/ljqJWL2skHE0KcenEn/pMJeo5wQzWYYDPbogoZa7Ut8IG/OoUjMRRCuAz7DBB+Qv
 nEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469950; x=1787074750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/FLrBFGnc3sdlHbz+yFP8aIfw/LA8xDvV8QDl90J8e8=;
 b=KNucnsnhi51X6uG9JD4kaB1I6viwdfIIFZXwcerN1oEdB1RoO9l5Dw1i9iFjMAB6HV
 uYnAbTetZXgVDfMOTfzH4615v7nzu/qWfCQKdTnugN1nNsXmieUrsR2TM584Hrk+N4YM
 Tvvq/8GTqYWVtX6ayUUzPgFJseENyHxtw9uBVmUMBHHwHKqrC/I3oZ7yZLcKdAgxSmKV
 LV6I/927QKdkvFiJfOfM5cF9QiIlameApNxu5rTehkZjJY3cymJKMlDhqVXNPBNodowB
 Vjss2MrFJ++R1oHZVrzH6MWZWA5AXRPoJ7hbfgyTCFs0yYnvcSb2myMu7fRjHf5vPRZj
 ZXTQ==
X-Gm-Message-State: AOJu0Yxv3HcOf46/j6fhlU+ffSb3wZtC87qt8jm94NNrxfX8zfW6HZtV
 LK7tI4RLj+eVAgwd+qu3hB4aRIcY/VR391GyFPZhQ0Bk5DLsswOigC9mTbhpkgeSTQgXMv6TXSH
 PI2b1
X-Gm-Gg: AR+sD12VS1/OPJRBH7HEZzZtjX+fob+aw1Sr0rVrTgm81IAU49wbyjhfPEtJhRm4MIo
 f0fAzlbpqGPjpHYJGvNLgipB5+5F1LZjLTREqAU5LW2477G8m8BPmtjuaOkh7uAngRBVd6ELQZS
 pIBPNxolSMV9H9ZKVXLTh5yyfxFq1WK8aTcvLSaBUycBlyaqroJSrSP9o1WpUHEYsOGeRAgXMtT
 RlycjXCD2VmURDtPw5upIAJe+ja+SvdwYC9I/uAEoiRfb6LySQVRYRcp0EzFMUw9Rd3HqKeoON3
 yrPLNhEmrSdq3m43Q+rH+KoeZI6batF5RTnO9Ag4XV1bmdan0ZjVxWSOpOOymLjdFc8973+zT4j
 W1mM2hqXn92B8wy9yk2irlH3HjnJ8gJgVV+lqOB8WNeoFoteVNO9CQVQEeOXPHr+0GLl0VUfZOz
 auvLKwTB7hSTBW6K86cTtpBv3EppgrZbFXcWvB2vRlbPLWMGKK92PXiFuI
X-Received: by 2002:a17:907:fd89:b0:c20:acfb:72ef with SMTP id
 a640c23a62f3a-c20ecbb755amr99656066b.30.1786469950160; 
 Tue, 11 Aug 2026 10:39:10 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ef7525sm880945a12.29.2026.08.11.10.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:39:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/8] dirty-bitmap: fix integer overflow in serialization
 coverage
Date: Tue, 11 Aug 2026 19:38:52 +0200
Message-ID: <20260811173857.396571-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811173857.396571-1-den@openvz.org>
References: <20260811173857.396571-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=den@openvz.org; helo=mail-ed1-x52b.google.com
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

The chunk size is an int and is shifted left by 3 before the result is
widened, so a chunk size of 1 << 28 or above overflows.

parallels passes s->cluster_size, which parallels_open() lets reach
2 GiB. With a bitmap needing two L1 entries the bogus limit makes the
"bm_size - offset" in parallels_load_bitmap_data() underflow; both
wrong values slip past the assertions in serialization_chunk() and the
resulting index lands outside the hbitmap, so a 128 KiB image memsets
unrelated memory through hbitmap_deserialize_ones().

Widen the shift. qcow2, the only other caller, never exceeds a 2 MiB
cluster.

Fixes: 35f428ba3971 ("qcow2-bitmap: make bytes_covered_by_bitmap_cluster() public")
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/dirty-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 13a1979755..9fda3a4b98 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -612,7 +612,7 @@ uint64_t bdrv_dirty_bitmap_serialization_coverage(int serialized_chunk_size,
                                                   const BdrvDirtyBitmap *bitmap)
 {
     uint64_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
-    uint64_t limit = granularity * (serialized_chunk_size << 3);
+    uint64_t limit = granularity * ((uint64_t)serialized_chunk_size << 3);
 
     assert(QEMU_IS_ALIGNED(limit,
                            bdrv_dirty_bitmap_serialization_align(bitmap)));
-- 
2.53.0



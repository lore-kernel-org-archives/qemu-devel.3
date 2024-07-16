Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B76C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjN6-00037I-K1; Tue, 16 Jul 2024 10:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTjN2-0002tB-8V; Tue, 16 Jul 2024 10:41:36 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTjMx-0002gm-S6; Tue, 16 Jul 2024 10:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=SxnnQcf/vCqlj8mFGAhTZWtk/V3Dt/KLf3GRTXyVbiM=; b=ch3rNlgak6l6
 heijFXZhRiAs414CD05guJzUmXTCYHcnB1rIks2kM0FvqGfcyxCzCPs6/ylryHWn1wMAoDP9cdyQ+
 XYeMvkLHS1+N4BJ/hyBG61S2YlFuR+qoXI34mhMPu0QgbsBVKT+PDCVRFnUUn6igghyX36KSbUCSk
 y88w9n/rpwEBVUmvzDf+lyAowA3KATEFb+cDP4xjGblBOsOnB3FYCXWPUiQvocegVMDASs8ofegKl
 OsE/oQuzyJ6vpYLPinArSrQIgS+BCGtQWpiW8dEhCUfZzZk5CFn1M+VCF7lcDdypUWM44Vv8Kyf1G
 eu8i8MDpmdBg++fhT9V0xg==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sTjM1-00D0sH-36;
 Tue, 16 Jul 2024 16:41:14 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 1/3] block: zero data data corruption using prealloc-filter
Date: Tue, 16 Jul 2024 17:41:21 +0300
Message-Id: <20240716144123.651476-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

We have observed that some clusters in the QCOW2 files are zeroed
while preallocation filter is used.

We are able to trace down the following sequence when prealloc-filter
is used:
    co=0x55e7cbed7680 qcow2_co_pwritev_task()
    co=0x55e7cbed7680 preallocate_co_pwritev_part()
    co=0x55e7cbed7680 handle_write()
    co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
    co=0x55e7cbed7680 raw_do_pwrite_zeroes()
    co=0x7f9edb7fe500 do_fallocate()

Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
time to handle next coroutine, which
    co=0x55e7cbee91b0 qcow2_co_pwritev_task()
    co=0x55e7cbee91b0 preallocate_co_pwritev_part()
    co=0x55e7cbee91b0 handle_write()
    co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
    co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
    co=0x7f9edb7deb00 do_fallocate()

The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
the same area. This means that if (once fallocate is started inside
0x7f9edb7deb00) original fallocate could end and the real write will
be executed. In that case write() request is handled at the same time
as fallocate().

The patch moves s->file_lock assignment before fallocate and that is
crucial. The idea is that all subsequent requests into the area
being preallocation will be issued as just writes without fallocate
to this area and they will not proceed thanks to overlapping
requests mechanics. If preallocation will fail, we will just switch
to the normal expand-by-write behavior and that is not a problem
except performance.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/preallocate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index d215bc5d6d..ecf0aa4baa 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
     want_merge_zero = want_merge_zero && (prealloc_start <= offset);
 
+    /*
+     * Assign file_end before making actual preallocation. This will ensure
+     * that next request performed while preallocation is in progress will
+     * be passed without preallocation.
+     */
+    s->file_end = prealloc_end;
+
     ret = bdrv_co_pwrite_zeroes(
             bs->file, prealloc_start, prealloc_end - prealloc_start,
             BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
@@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
         return false;
     }
 
-    s->file_end = prealloc_end;
     return want_merge_zero;
 }
 
-- 
2.39.3



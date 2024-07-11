Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F210C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtuq-0004kp-Bt; Thu, 11 Jul 2024 09:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sRtuo-0004dy-Dy; Thu, 11 Jul 2024 09:32:54 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sRtul-00034L-9F; Thu, 11 Jul 2024 09:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=bUAAIaIwATSVVMEabqm9IcIMBFrz7eMWutd1t1Bw3uc=; b=aIoUQa6zZwOq
 xJvvw+txVAaX+gUPQgGp2gjTCyEJIPEgKisdkIUC6ZPwlg95I4KVhu2KZLsm65lY/P4WXjlblIefM
 l76InnrZTCtHmFv3OXlZpfmKhZqxPZ7djlg4xw2u9ux4lTRF8HCPST0MlUevIVsCHB8WLxVW9uqRu
 jzJqGb58jE7dF755C6nJGcOwFqbWcC6UHyr5AfDz06FNnGu0vg1ckHiCKzr0ksBqwcVYSXAORDGuw
 VlTmoZXRVTBvKwfsX19L82FmpgBrKlJUQqzrnhlMISORGJweMZXvSRO/fItDc68+JsJpuKmHrM6Wb
 g134rzCowX7m+uaDP7Q32g==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sRtty-00CZ6M-0t;
 Thu, 11 Jul 2024 15:32:42 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 1/2] block: zero data data corruption using prealloc-filter
Date: Thu, 11 Jul 2024 16:32:41 +0300
Message-Id: <20240711133242.251061-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240711133242.251061-1-andrey.drobyshev@virtuozzo.com>
References: <20240711133242.251061-1-andrey.drobyshev@virtuozzo.com>
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

Normally we should protect s->file_end while it is detected that
preallocation is need. The patch introduces file_end_lock for it to be
protected when run in the coroutine context.

Note: the lock is taken only once it is detected that the preallocation
is really required. This is not a frequent case due to the preallocation
nature thus the patch should not have performance impact.

Originally-by: Denis V. Lunev <den@openvz.org>
Co-authored-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/preallocate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/preallocate.c b/block/preallocate.c
index d215bc5d6d..9cb2c97635 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -78,6 +78,8 @@ typedef struct BDRVPreallocateState {
 
     /* Gives up the resize permission on children when parents don't need it */
     QEMUBH *drop_resize_bh;
+
+    CoMutex file_end_lock;
 } BDRVPreallocateState;
 
 static int preallocate_drop_resize(BlockDriverState *bs, Error **errp);
@@ -170,6 +172,8 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
         ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
             bs->file->bs->supported_zero_flags);
 
+    qemu_co_mutex_init(&s->file_end_lock);
+
     return 0;
 }
 
@@ -342,6 +346,7 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
             return false;
         }
 
+        QEMU_LOCK_GUARD(&s->file_end_lock);
         if (s->file_end < 0) {
             s->file_end = s->data_end;
         }
@@ -353,6 +358,8 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
     /* We have valid s->data_end, and request writes beyond it. */
 
+    QEMU_LOCK_GUARD(&s->file_end_lock);
+
     s->data_end = end;
     if (s->zero_start < 0 || !want_merge_zero) {
         s->zero_start = end;
@@ -428,6 +435,8 @@ preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
     BDRVPreallocateState *s = bs->opaque;
     int ret;
 
+    QEMU_LOCK_GUARD(&s->file_end_lock);
+
     if (s->data_end >= 0 && offset > s->data_end) {
         if (s->file_end < 0) {
             s->file_end = bdrv_co_getlength(bs->file->bs);
@@ -501,6 +510,8 @@ preallocate_co_getlength(BlockDriverState *bs)
         return s->data_end;
     }
 
+    QEMU_LOCK_GUARD(&s->file_end_lock);
+
     ret = bdrv_co_getlength(bs->file->bs);
 
     if (has_prealloc_perms(bs)) {
-- 
2.39.3



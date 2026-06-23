Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1F2CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzD8-0004NK-Bv; Tue, 23 Jun 2026 07:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbzD7-0004N3-9C
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbzD4-0002Eb-H3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782213748;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=X0T6VopPiWt78/JJhprz1gfTKdqBVekND7Dihi7hluY=;
 b=ifMexwydZKIt5U0c2lXGzZ8sIbQx23PYCP2kwQXt2fSXNNlSVU4j4W5+23xVmpH0swn6mM
 GiPqKDa3yDkkQGnDln8k0U54S6wYIrKe7Dtb/mJR1YONhYxhynmloy208NdBhc+OUgzo+S
 AFaDy2HOoE1RloCCDhE3JQw1Z2vZiMA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-viTeXk5dNhir2sm6p3b3JA-1; Tue,
 23 Jun 2026 07:22:26 -0400
X-MC-Unique: viTeXk5dNhir2sm6p3b3JA-1
X-Mimecast-MFC-AGG-ID: viTeXk5dNhir2sm6p3b3JA_1782213745
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25BF218001F6; Tue, 23 Jun 2026 11:22:25 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.133])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DB6E1800591; Tue, 23 Jun 2026 11:22:22 +0000 (UTC)
Date: Tue, 23 Jun 2026 12:22:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Hergert <christian@sourceandstack.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/1] block/vvfat: defer write commits to half-second timer
Message-ID: <ajpsa3rLDAxCc3qu@redhat.com>
References: <20260531103437.2896462-1-christian@sourceandstack.com>
 <20260531103437.2896462-2-christian@sourceandstack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260531103437.2896462-2-christian@sourceandstack.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, May 31, 2026 at 12:34:37PM +0200, Christian Hergert wrote:
> This keeps consistent reads but defers writes to a half-second timer by
> implementing the suggested TODO in block/vvfat.c.
> 
> I noticed slow boot performance when testing a UKI image. It was roughly
> 18 seconds to a login prompt with a simple userspace. I profiled quickly
> with Sysprof which showed an overwhelming amount of time spent in
> check_directory_consistency().
> 
> The -drive in question here is the following:
> 
>  file=fat:rw:/tmp/machines-uki-esp-HVCXP3,format=raw,media=disk
> 
> which has a temporary NvVars in it for quick throwaway VM testing which
> I use in conjunction with mkosi.

By NvVars are you referring to a NVRAM backing store for use
with EDK2 ?

If so, then newer EDK2 supports a JSON backing store which would
be a better bet for quick & easy VM testing IMHO.

Not an objection to this patch, but we tend to recommend that any
use of vvfat is best avoided where any other alternative is available.

> 
> With this commit in place, boot to login reduces from 18 seconds to 6.
> 
> Signed-off-by: Christian Hergert <christian@sourceandstack.com>
> ---
>  block/vvfat.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 125 insertions(+), 5 deletions(-)

FYI, applying this patch appears to break the I/O tests for vvfat:

$ ./build/run ./build/tests/qemu-iotests/check -vvfat  vvfat
QEMU          -- "/home/berrange/src/virt/qemu/build/qemu-system-x86_64" -nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/berrange/src/virt/qemu/build/qemu-img" 
QEMU_IO       -- "/home/berrange/src/virt/qemu/build/qemu-io" --cache writeback --aio threads -f vvfat
QEMU_NBD      -- "/home/berrange/src/virt/qemu/build/qemu-nbd" 
IMGFMT        -- vvfat
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 berrange.csb 7.0.9-205.fc44.x86_64
TEST_DIR      -- /home/berrange/src/virt/qemu/scratch
SOCK_DIR      -- /tmp/qemu-iotests-4_wjh3ml
GDB_OPTIONS   -- 
VALGRIND_QEMU -- 
PRINT_QEMU_OUTPUT -- 

vvfat   fail       [12:16:35] [12:16:39]   3.3s   (last: 3.2s)  failed, exit status 1
--- /home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat.out
+++ /home/berrange/src/virt/qemu/scratch/vvfat-file-vvfat/vvfat.out.bad
@@ -1,5 +1,105 @@
-................
+E..F..FFFFFFF..F
+======================================================================
+ERROR: test_create_file (__main__.TestVVFatDriver.test_create_file)
+Test creating a new file
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 477, in test_create_file
+    with open(os.path.join(filesystem, "newfile.txt"), "rb") as f:
+         ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+FileNotFoundError: [Errno 2] No such file or directory: '/home/berrange/src/virt/qemu/scratch/vvfat-file-vvfat/filesystem/newfile.txt'
+
+======================================================================
+FAIL: test_modify_content_same_clusters (__main__.TestVVFatDriver.test_modify_content_same_clusters)
+Test modifying the content of the file without changing the number of
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 300, in test_modify_content_same_clusters
+    self.assertEqual(f.read(), new_content)
+    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
+AssertionError: b'Hello, world! 0\n' != b'Hello, world! Modified\n'
+
+======================================================================
+FAIL: test_truncate_file_change_clusters_less (__main__.TestVVFatDriver.test_truncate_file_change_clusters_less)
+Test truncating a file by reducing the number of clusters
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 377, in test_truncate_file_change_clusters_less
+    self.assertEqual(f.read(), b"A")
+    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
+AssertionError: b'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA[16338 chars]PPPP' != b'A'
+
+======================================================================
+FAIL: test_truncate_file_same_clusters_less (__main__.TestVVFatDriver.test_truncate_file_same_clusters_less)
+Test truncating the file without changing number of clusters
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 319, in test_truncate_file_same_clusters_less
+    self.assertEqual(f.read(), new_content)
+    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
+AssertionError: b'Hello, world! 0\n' != b'Hello'
+
+======================================================================
+FAIL: test_truncate_file_same_clusters_more (__main__.TestVVFatDriver.test_truncate_file_same_clusters_more)
+Test truncating the file without changing number of clusters
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 343, in test_truncate_file_same_clusters_more
+    self.assertEqual(f.read(), new_content)
+    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
+AssertionError: b'Hello, world! 0\n' != b'Hello, world! 0\n(((('
+
+======================================================================
+FAIL: test_write_file_change_clusters_less (__main__.TestVVFatDriver.test_write_file_change_clusters_less)
+Test truncating a file by reducing the number of clusters
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 393, in test_write_file_change_clusters_less
+    self.assertEqual(f.read(), new_content)
+    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
+AssertionError: b'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA[24531 chars]XXXX' != b'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX[16339 chars]YYYY'
+
+======================================================================
+FAIL: test_write_file_change_clusters_more (__main__.TestVVFatDriver.test_write_file_change_clusters_more)
+Test truncating a file by increasing the number of clusters
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 415, in test_write_file_change_clusters_more
+    self.assertEqual(f.read(), new_content)
+    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
+AssertionError: b'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA[24531 chars]XXXX' != b'WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW[32723 chars]ZZZZ'
+
+======================================================================
+FAIL: test_write_file_change_clusters_more_non_contiguous_2_mappings (__main__.TestVVFatDriver.test_write_file_change_clusters_more_non_contiguous_2_mappings)
+Test truncating a file by increasing the number of clusters Here we
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 435, in test_write_file_change_clusters_more_non_contiguous_2_mappings
+    self.assertEqual(f.read(), new_content)
+    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
+AssertionError: b'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA[16339 chars]PPPP' != b'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX[24531 chars]ZZZZ'
+
+======================================================================
+FAIL: test_write_file_change_clusters_more_non_contiguous_3_mappings (__main__.TestVVFatDriver.test_write_file_change_clusters_more_non_contiguous_3_mappings)
+Test truncating a file by increasing the number of clusters Here we
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 460, in test_write_file_change_clusters_more_non_contiguous_3_mappings
+    self.assertEqual(f.read(), new_content)
+    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
+AssertionError: b'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA[16339 chars]PPPP' != b'WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW[32723 chars]ZZZZ'
+
+======================================================================
+FAIL: test_write_large_file (__main__.TestVVFatDriver.test_write_large_file)
+Test writing a large file
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/berrange/src/virt/qemu/tests/qemu-iotests/tests/vvfat", line 362, in test_write_large_file
+    self.assertEqual(f.read(), new_content)
+    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^
+AssertionError: b'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA[16339 chars]PPPP' != b'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ[16339 chars]KKKK'
+
 ----------------------------------------------------------------------
 Ran 16 tests

-OK
+FAILED (failures=9, errors=1)
Failures: vvfat
Failed 1 of 1 iotests


I didn't investigate whether this is a real functional bug, or whether
the tests are making bad assumptions that need fixing, or whether this
is just inherant behaviour from delaying writes.

> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index e334b9febb..49756ac5e0 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -32,6 +32,7 @@
>  #include "block/qdict.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> +#include "qemu/timer.h"
>  #include "qemu/bswap.h"
>  #include "migration/blocker.h"
>  #include "qobject/qdict.h"
> @@ -53,8 +54,6 @@
>      Note that DOS assumes the system files to be the first files in the
>      file system (test if the boot sector still relies on that fact)! */
>  /* MAYBE TODO: write block-visofs.c */
> -/* TODO: call try_commit() only after a timeout */
> -
>  /* #define DEBUG */
>  
>  #ifdef DEBUG
> @@ -80,6 +79,8 @@ static void checkpoint(void);
>  #define DIR_KANJI_FAKE 0x05
>  #define DIR_FREE 0x00
>  
> +#define VVFAT_COMMIT_DELAY_NS (NANOSECONDS_PER_SECOND / 2)
> +
>  /* dynamic array functions */
>  typedef struct array_t {
>      char* pointer;
> @@ -332,6 +333,8 @@ typedef struct BDRVVVFATState {
>      void* fat2;
>      char* used_clusters;
>      array_t commits;
> +    QEMUTimer *commit_timer;
> +    bool commit_pending;
>      const char* path;
>      int downcase_short_names;
>  
> @@ -1052,6 +1055,8 @@ static BDRVVVFATState *vvv = NULL;
>  
>  static int enable_write_target(BlockDriverState *bs, Error **errp);
>  static int coroutine_fn is_consistent(BDRVVVFATState *s);
> +static void vvfat_attach_aio_context(BlockDriverState *bs,
> +                                     AioContext *new_context);
>  
>  static QemuOptsList runtime_opts = {
>      .name = "vvfat",
> @@ -1278,6 +1283,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
>      }
>  
>      qemu_co_mutex_init(&s->lock);
> +    vvfat_attach_aio_context(bs, bdrv_get_aio_context(bs));
>  
>      qemu_opts_del(opts);
>  
> @@ -2973,6 +2979,60 @@ DLOG(checkpoint());
>      return do_commit(s);
>  }
>  
> +static int coroutine_fn GRAPH_RDLOCK
> +vvfat_commit_now(BDRVVVFATState *s)
> +{
> +    int ret;
> +
> +    if (s->commit_timer) {
> +        timer_del(s->commit_timer);
> +    }
> +    if (!s->commit_pending) {
> +        return 0;
> +    }
> +
> +    qemu_co_mutex_lock(&s->lock);
> +    ret = try_commit(s);
> +    qemu_co_mutex_unlock(&s->lock);
> +
> +    if (ret == 0) {
> +        s->commit_pending = false;
> +    }
> +
> +    return ret;
> +}
> +
> +static void coroutine_fn vvfat_commit_timer_entry(void *opaque)
> +{
> +    BlockDriverState *bs = opaque;
> +    BDRVVVFATState *s = bs->opaque;
> +    GRAPH_RDLOCK_GUARD();
> +
> +    vvfat_commit_now(s);
> +    bdrv_dec_in_flight(bs);
> +}
> +
> +static void vvfat_commit_timer_cb(void *opaque)
> +{
> +    BlockDriverState *bs = opaque;
> +    Coroutine *co;
> +
> +    co = qemu_coroutine_create(vvfat_commit_timer_entry, bs);
> +    bdrv_inc_in_flight(bs);
> +    qemu_coroutine_enter(co);
> +}
> +
> +static void vvfat_schedule_commit(BDRVVVFATState *s)
> +{
> +    s->commit_pending = true;
> +
> +    if (s->commit_timer) {
> +        timer_mod_ns(s->commit_timer,
> +                     qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                     VVFAT_COMMIT_DELAY_NS);
> +    }
> +}
> +
>  static int coroutine_fn GRAPH_RDLOCK
>  vvfat_write(BlockDriverState *bs, int64_t sector_num,
>              const uint8_t *buf, int nb_sectors)
> @@ -3098,8 +3158,7 @@ DLOG(fprintf(stderr, "Write to qcow backend: %d + %d\n", (int)sector_num, nb_sec
>      }
>  
>  DLOG(checkpoint());
> -    /* TODO: add timeout */
> -    try_commit(s);
> +    vvfat_schedule_commit(s);
>  
>  DLOG(checkpoint());
>      return 0;
> @@ -3133,6 +3192,34 @@ vvfat_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
>      return ret;
>  }
>  
> +static int coroutine_fn GRAPH_RDLOCK
> +vvfat_co_flush(BlockDriverState *bs)
> +{
> +    BDRVVVFATState *s = bs->opaque;
> +
> +    if (s->qcow == NULL) {
> +        return 0;
> +    }
> +
> +    return vvfat_commit_now(s);
> +}
> +
> +static void vvfat_drain_begin(BlockDriverState *bs)
> +{
> +    BDRVVVFATState *s = bs->opaque;
> +    Coroutine *co;
> +
> +    if (!s->commit_timer || !timer_pending(s->commit_timer)) {
> +        return;
> +    }
> +
> +    timer_del(s->commit_timer);
> +
> +    co = qemu_coroutine_create(vvfat_commit_timer_entry, bs);
> +    bdrv_inc_in_flight(bs);
> +    aio_co_enter(bdrv_get_aio_context(bs), co);
> +}
> +
>  static int coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
>                                                unsigned int mode,
>                                                int64_t offset, int64_t bytes,
> @@ -3229,6 +3316,11 @@ static void vvfat_close(BlockDriverState *bs)
>  {
>      BDRVVVFATState *s = bs->opaque;
>  
> +    if (s->commit_timer) {
> +        timer_free(s->commit_timer);
> +        s->commit_timer = NULL;
> +    }
> +
>      vvfat_close_current_file(s);
>      array_free(&(s->fat));
>      array_free(&(s->directory));
> @@ -3240,6 +3332,30 @@ static void vvfat_close(BlockDriverState *bs)
>      }
>  }
>  
> +static void vvfat_detach_aio_context(BlockDriverState *bs)
> +{
> +    BDRVVVFATState *s = bs->opaque;
> +
> +    if (s->commit_timer) {
> +        timer_free(s->commit_timer);
> +        s->commit_timer = NULL;
> +    }
> +}
> +
> +static void vvfat_attach_aio_context(BlockDriverState *bs,
> +                                     AioContext *new_context)
> +{
> +    BDRVVVFATState *s = bs->opaque;
> +
> +    if (s->qcow) {
> +        s->commit_timer = aio_timer_new(new_context, QEMU_CLOCK_VIRTUAL,
> +                                        SCALE_NS, vvfat_commit_timer_cb, bs);
> +        if (s->commit_pending) {
> +            vvfat_schedule_commit(s);
> +        }
> +    }
> +}
> +
>  static const char *const vvfat_strong_runtime_opts[] = {
>      "dir",
>      "fat-type",
> @@ -3263,7 +3379,11 @@ static BlockDriver bdrv_vvfat = {
>  
>      .bdrv_co_preadv         = vvfat_co_preadv,
>      .bdrv_co_pwritev        = vvfat_co_pwritev,
> -    .bdrv_co_block_status   = vvfat_co_block_status,
> +    .bdrv_co_flush          = vvfat_co_flush,
> +    .bdrv_drain_begin       = vvfat_drain_begin,
> +    .bdrv_co_block_status    = vvfat_co_block_status,
> +    .bdrv_detach_aio_context = vvfat_detach_aio_context,
> +    .bdrv_attach_aio_context = vvfat_attach_aio_context,
>  
>      .strong_runtime_opts    = vvfat_strong_runtime_opts,
>  };
> -- 
> 2.54.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



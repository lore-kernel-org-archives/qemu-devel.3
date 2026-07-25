Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC9BC53209
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ0k-0000rF-V2; Sat, 25 Jul 2026 05:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0Y-0000lE-BN
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0W-0004W1-NJ
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784972963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+j1+kKqO3gSZvGipTvwtW8wX1wySBZb9ydRx80MK64=;
 b=NfO4E/NDTMqtRgnL+ukwahBMyLkfdpVF47RlQBtunS9bDq7UWtVmS9LSWRIq3PftC650Fb
 N0xwH0nmgfC7Ct3ND8cqeHuxLVqvHrbSaR1EtOi4uT3tPTuaU1m6MevzdUm0FQBZrdu7cq
 BpTzmdskl/RCJL8fGf+kcOaPiRT0qQw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-1bbY5DcCP9-L3iAAvjj2xQ-1; Sat,
 25 Jul 2026 05:49:20 -0400
X-MC-Unique: 1bbY5DcCP9-L3iAAvjj2xQ-1
X-Mimecast-MFC-AGG-ID: 1bbY5DcCP9-L3iAAvjj2xQ_1784972958
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7F371800593; Sat, 25 Jul 2026 09:49:17 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04112195608A; Sat, 25 Jul 2026 09:49:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 13:48:37 +0400
Subject: [PATCH v2 6/8] block: add missing coroutine_fn annotations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-co-v2-6-d3552ddb3931@redhat.com>
References: <20260725-co-v2-0-d3552ddb3931@redhat.com>
In-Reply-To: <20260725-co-v2-0-d3552ddb3931@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5471;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yTkTviyyBs2JmImgJurFl/odglaAcF3CvUVYx2ZMvRM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZIZz8TTOO3VDCqBTb3iNQAKge10DpvXXqhXeQ
 nPOCdjvI3uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamSGcwAKCRDa6OEJdZac
 5S/DD/9cjL8R8CyX153qhZrTXbN9AANth97cirMo2+NXG4TV5YLdr6hEhHRI7iGBfvXnfWZXAxW
 W3rPCqqWF45atRd4qIuWkOh25wNNxPHuUuXvw/yKeZrN5QuvnKPBgjU5fE1TloYOHXx1NaOsBtK
 itFYbZcUffhaWCMUeYyhqFAT0qG54aJZyiOldKaoNYjgwjaRnDgBJQhOHtwNxPrKFT3lAQOVZke
 jsLhGPgY0T7ea3fpy8Jl8QqWziCLZsEfnrSyBLfcNte5kllSJEOyTFmL115UVBXwwcWsGZ90XIg
 W8ct3twLPiFbK7U2ct8hqtAIDvnPzYfToYpb6MKTPrUCEJYnR9InQJgYjzxQ2tsb7EeuU4gEROQ
 B2riKZ5mMVAewG2XXhF3uPpkjU8LrX7sOlLGA5eM3kDRV17zvrwz8jRSZuXiTkRUQgSoehA1MSw
 qEnPlnLTFgQtBt3cPHh36MXbjMxF52u8tVoKraUjnejH8tstHVFgpyJrOXq33edWZvDRGq6iMbO
 yu9rm9p5SWXEDvbUNvWXIo0TuO9wTFrhuC4xQyCZAZ5W6pSP6ZDQNcRWZuXj6EqP5mLkC4o61Ib
 gie+it0H4AXAlRHKx2u6E5xkmjbyfbWOq3wcHhrYEusLNBnIiVCgU+yJHf7RKteRXFQ6+BeWNd0
 W7BEVu/I/8oyZDQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The functions call coroutine functions or are called by coroutine.

Add an assert() in qcow2_do_close() code path which calls a
no_coroutine_fn bdrv_graph_wrlock_drained().

Add an assert() in qcow2_update_options_commit() in the coroutine
path.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/block/blockjob_int.h |  2 +-
 block/crypto.c               | 13 +++++++------
 block/io.c                   |  8 +++++---
 block/parallels.c            |  5 +++--
 block/qcow2.c                | 12 ++++++++----
 blockjob.c                   |  3 ++-
 6 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 4c3d2e25a209..34e172874fa9 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -150,7 +150,7 @@ void block_job_ratelimit_processed_bytes(BlockJob *job, uint64_t n);
  * Put the job to sleep (assuming that it wasn't canceled) to throttle it to the
  * right speed according to its rate limiting.
  */
-void block_job_ratelimit_sleep(BlockJob *job);
+void coroutine_fn block_job_ratelimit_sleep(BlockJob *job);
 
 /**
  * block_job_error_action:
diff --git a/block/crypto.c b/block/crypto.c
index 36abb7af4680..8a34d92fded6 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -56,12 +56,13 @@ static int block_crypto_probe_generic(QCryptoBlockFormat format,
 }
 
 
-static int block_crypto_read_func(QCryptoBlock *block,
-                                  size_t offset,
-                                  uint8_t *buf,
-                                  size_t buflen,
-                                  void *opaque,
-                                  Error **errp)
+static int coroutine_mixed_fn
+block_crypto_read_func(QCryptoBlock *block,
+                       size_t offset,
+                       uint8_t *buf,
+                       size_t buflen,
+                       void *opaque,
+                       Error **errp)
 {
     BlockDriverState *bs = opaque;
     BlockCrypto *crypto = bs->opaque;
diff --git a/block/io.c b/block/io.c
index a916b236c3c8..99dd16864a3d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -346,8 +346,9 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     assert(data.done);
 }
 
-static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
-                                  bool poll)
+static void coroutine_mixed_fn
+bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
+                      bool poll)
 {
     IO_OR_GS_CODE();
 
@@ -397,7 +398,8 @@ bdrv_drained_begin(BlockDriverState *bs)
  * This function does not poll, nor must any of its recursively called
  * functions.
  */
-static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
+static void coroutine_mixed_fn
+bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
 {
     IO_OR_GS_CODE();
 
diff --git a/block/parallels.c b/block/parallels.c
index 7a90fb5220b9..6f96cc4e3045 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -142,8 +142,9 @@ static uint32_t host_cluster_index(BDRVParallelsState *s, int64_t off)
     return off / s->cluster_size;
 }
 
-static int64_t block_status(BDRVParallelsState *s, int64_t sector_num,
-                            int nb_sectors, int *pnum)
+static int64_t
+block_status(BDRVParallelsState *s, int64_t sector_num,
+             int nb_sectors, int *pnum)
 {
     int64_t start_off = -2, prev_end_off = -2;
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 19271b10a49f..409ac362db62 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1287,9 +1287,10 @@ fail:
 }
 
 /* s_locked specifies whether s->lock is held or not */
-static void qcow2_update_options_commit(BlockDriverState *bs,
-                                        Qcow2ReopenState *r,
-                                        bool s_locked)
+static coroutine_mixed_fn void
+qcow2_update_options_commit(BlockDriverState *bs,
+                            Qcow2ReopenState *r,
+                            bool s_locked)
 {
     BDRVQcow2State *s = bs->opaque;
     int i;
@@ -1299,6 +1300,7 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
      * table caches
      */
     if (s_locked) {
+        assert(qemu_in_coroutine());
         cache_clean_timer_co_locked_del_and_wait(bs);
     } else {
         cache_clean_timer_del_and_wait(bs);
@@ -2126,7 +2128,8 @@ fail:
     return ret;
 }
 
-static void qcow2_reopen_commit(BDRVReopenState *state)
+static void
+qcow2_reopen_commit(BDRVReopenState *state)
 {
     BDRVQcow2State *s = state->bs->opaque;
 
@@ -2905,6 +2908,7 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
     g_free(s->image_backing_format);
 
     if (close_data_file && has_data_file(bs)) {
+        assert(!qemu_in_coroutine());
         GLOBAL_STATE_CODE();
         bdrv_graph_rdunlock_main_loop();
         bdrv_graph_wrlock_drained();
diff --git a/blockjob.c b/blockjob.c
index f3b11cc7a194..f3ad6a93125a 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -338,7 +338,8 @@ void block_job_ratelimit_processed_bytes(BlockJob *job, uint64_t n)
     ratelimit_calculate_delay(&job->limit, n);
 }
 
-void block_job_ratelimit_sleep(BlockJob *job)
+void coroutine_fn
+block_job_ratelimit_sleep(BlockJob *job)
 {
     uint64_t delay_ns;
 

-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB48C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpUHf-0002oW-Va; Thu, 30 Jul 2026 13:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wpUHL-0002ns-HK
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 13:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wpUHJ-0005j1-Bd
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 13:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785431439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1Byx+6PIj8v3r8ZThcZLAUtUiaA1rUtsyNE1SNFRHQ=;
 b=SDsYb61MowytL7491gMSQItBN2okRkmBCS8ThlHwkHNZQVN21UDtHF4IWsiYqJKJKYZ5A7
 Zo2vCXRr3uUd/LYxikAtFvXgpWOUah+pacb1CigxVMLocddtp3aQSMNLFaUZuZdPIdh0E/
 dGZyZwDqXpK7jfswrwzV/KNSk68081o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-OidVTywhOH-VF4whvZr1Nw-1; Thu,
 30 Jul 2026 13:10:36 -0400
X-MC-Unique: OidVTywhOH-VF4whvZr1Nw-1
X-Mimecast-MFC-AGG-ID: OidVTywhOH-VF4whvZr1Nw_1785431435
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C815A19560A1; Thu, 30 Jul 2026 17:10:34 +0000 (UTC)
Received: from localhost (unknown [10.44.24.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6A8119560AB; Thu, 30 Jul 2026 17:10:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3] block: add missing coroutine_fn annotations
Date: Thu, 30 Jul 2026 21:10:26 +0400
Message-ID: <20260730171027.1023696-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The functions call coroutine functions or are called by coroutine.

Add an assert() in qcow2_do_close() code path which calls a
no_coroutine_fn bdrv_graph_wrlock_drained().

Add an assert() in qcow2_update_options_commit() in the coroutine
path.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
v3:
 - remove indentiation changes leftovers
---
 include/block/blockjob_int.h |  2 +-
 block/crypto.c               | 13 +++++++------
 block/io.c                   |  8 +++++---
 block/qcow2.c                |  9 ++++++---
 blockjob.c                   |  3 ++-
 5 files changed, 21 insertions(+), 14 deletions(-)

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
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 19271b10a49f..03526c4a131f 100644
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
@@ -2905,6 +2907,7 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
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



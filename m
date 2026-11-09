Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47275606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ut4F4x0J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSX1-00034J-Aa; Mon, 09 Nov 2026 11:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVP-0002BL-Tn
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVI-0000zO-7O
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmGnv3OiC917/+F02I0fz8+IOG4ITVoY/eOoGixKiso=;
 b=Ut4F4x0Joti9+J3jZn+DVagjQdq64miTtDRVdzk2RUWDEC7Cm4tgUla7LosTFUgpfOv8mA
 bokBdo6nnNryCHL7rFRL3GPbwJflh9F9gq/AMfiVuFys11oVylz8a0JcXhaa8kJ7GVB3+o
 X/14RMGEZHkoLwJ18U8vKvraYat/BNw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-hcdrfbFUObazUDoEETS7Qg-1; Mon,
 09 Nov 2026 11:45:51 -0500
X-MC-Unique: hcdrfbFUObazUDoEETS7Qg-1
X-Mimecast-MFC-AGG-ID: hcdrfbFUObazUDoEETS7Qg_1794242750
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A45119774D4; Mon,  9 Nov 2026 16:45:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4795C30001A2; Mon,  9 Nov 2026 16:45:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/11] block: add missing coroutine_fn annotations
Date: Mon,  9 Nov 2026 17:45:29 +0100
Message-ID: <20261109164533.293487-8-kwolf@redhat.com>
In-Reply-To: <20261109164533.293487-1-kwolf@redhat.com>
References: <20261109164533.293487-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The functions call coroutine functions or are called by coroutine.

Add an assert() in qcow2_do_close() code path which calls a
no_coroutine_fn bdrv_graph_wrlock_drained().

Add an assert() in qcow2_update_options_commit() in the coroutine
path.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260730171027.1023696-1-marcandre.lureau@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob_int.h |  2 +-
 block/crypto.c               | 13 +++++++------
 block/io.c                   |  8 +++++---
 block/qcow2.c                |  9 ++++++---
 blockjob.c                   |  3 ++-
 5 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 4c3d2e25a20..34e172874fa 100644
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
index 36abb7af468..8a34d92fded 100644
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
index 06b1fc13b9f..0f81b7e6bb9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -354,8 +354,9 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     assert(data.done);
 }
 
-static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
-                                  bool poll)
+static void coroutine_mixed_fn
+bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
+                      bool poll)
 {
     IO_OR_GS_CODE();
 
@@ -405,7 +406,8 @@ bdrv_drained_begin(BlockDriverState *bs)
  * This function does not poll, nor must any of its recursively called
  * functions.
  */
-static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
+static void coroutine_mixed_fn
+bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
 {
     IO_OR_GS_CODE();
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 0358bc04f33..59cc93ba746 100644
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
@@ -2919,6 +2921,7 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
     g_free(s->image_backing_format);
 
     if (close_data_file && has_data_file(bs)) {
+        assert(!qemu_in_coroutine());
         GLOBAL_STATE_CODE();
         bdrv_graph_rdunlock_main_loop();
         bdrv_graph_wrlock_drained();
diff --git a/blockjob.c b/blockjob.c
index f3b11cc7a19..f3ad6a93125 100644
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
2.56.0



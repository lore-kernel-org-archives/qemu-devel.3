Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E7BCEE33B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP7I-0000bR-KX; Tue, 18 Nov 2025 12:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7G-0000XT-Bs
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP7E-0004pN-LP
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZltpNVCUq0Vf1G9u4xFTTmHy1IMhZM4kfzwvlfz3cI=;
 b=JggbgatO0P7R8Kg6DG1ICV3nFSvZBOjdE2Oh+fMzqTyvXEMNy7YWmcwW1vxVukeK86X2qZ
 9K5lIYvmQp52OZjN2We4QlqA1hiZM6w+rSQbntPhyrNzAIorjSviEDsAV5llA7hw1rpidf
 dBPa9W7/ya7Y0xS8ngVAPEo+Dx5xgvc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-_VYOX4ObPRy5t5elaA0l2Q-1; Tue,
 18 Nov 2025 12:03:35 -0500
X-MC-Unique: _VYOX4ObPRy5t5elaA0l2Q-1
X-Mimecast-MFC-AGG-ID: _VYOX4ObPRy5t5elaA0l2Q_1763485414
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A4C7191B4C2; Tue, 18 Nov 2025 17:03:34 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C727300ABB1; Tue, 18 Nov 2025 17:03:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 14/19] ssh: Run restart_coroutine in current AioContext
Date: Tue, 18 Nov 2025 18:02:51 +0100
Message-ID: <20251118170256.272087-15-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

restart_coroutine() is attached as an FD handler just to wake the
current coroutine after yielding.  It makes most sense to attach it to
the current (request) AioContext instead of the BDS main context.  This
way, the coroutine can be entered directly from the BH instead of having
yet another indirection through AioContext.co_schedule_bh.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-15-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/ssh.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 70fe7cf86e..bdec94e9e9 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -1010,19 +1010,18 @@ static int ssh_has_zero_init(BlockDriverState *bs)
 }
 
 typedef struct BDRVSSHRestart {
-    BlockDriverState *bs;
+    BDRVSSHState *s;
     Coroutine *co;
 } BDRVSSHRestart;
 
 static void restart_coroutine(void *opaque)
 {
     BDRVSSHRestart *restart = opaque;
-    BlockDriverState *bs = restart->bs;
-    BDRVSSHState *s = bs->opaque;
-    AioContext *ctx = bdrv_get_aio_context(bs);
+    BDRVSSHState *s = restart->s;
 
     trace_ssh_restart_coroutine(restart->co);
-    aio_set_fd_handler(ctx, s->sock, NULL, NULL, NULL, NULL, NULL);
+    aio_set_fd_handler(qemu_get_current_aio_context(), s->sock,
+                       NULL, NULL, NULL, NULL, NULL);
 
     aio_co_wake(restart->co);
 }
@@ -1031,12 +1030,13 @@ static void restart_coroutine(void *opaque)
  * handlers are set up so that we'll be rescheduled when there is an
  * interesting event on the socket.
  */
-static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
+static coroutine_fn void co_yield(BDRVSSHState *s)
 {
     int r;
     IOHandler *rd_handler = NULL, *wr_handler = NULL;
+    AioContext *ctx = qemu_get_current_aio_context();
     BDRVSSHRestart restart = {
-        .bs = bs,
+        .s = s,
         .co = qemu_coroutine_self()
     };
 
@@ -1051,7 +1051,7 @@ static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
 
     trace_ssh_co_yield(s->sock, rd_handler, wr_handler);
 
-    aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock,
+    aio_set_fd_handler(ctx, s->sock,
                        rd_handler, wr_handler, NULL, NULL, &restart);
     qemu_coroutine_yield();
     trace_ssh_co_yield_back(s->sock);
@@ -1093,7 +1093,7 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
         trace_ssh_read_return(r, sftp_get_error(s->sftp));
 
         if (r == SSH_AGAIN) {
-            co_yield(s, bs);
+            co_yield(s);
             goto again;
         }
         if (r == SSH_EOF || (r == 0 && sftp_get_error(s->sftp) == SSH_FX_EOF)) {
@@ -1168,7 +1168,7 @@ static coroutine_fn int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
         trace_ssh_write_return(r, sftp_get_error(s->sftp));
 
         if (r == SSH_AGAIN) {
-            co_yield(s, bs);
+            co_yield(s);
             goto again;
         }
         if (r < 0) {
@@ -1233,7 +1233,7 @@ static coroutine_fn int ssh_flush(BDRVSSHState *s, BlockDriverState *bs)
  again:
     r = sftp_fsync(s->sftp_handle);
     if (r == SSH_AGAIN) {
-        co_yield(s, bs);
+        co_yield(s);
         goto again;
     }
     if (r < 0) {
-- 
2.51.1



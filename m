Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2CEC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulM-0000hy-NY; Wed, 07 Feb 2024 22:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukx-0007Q5-3T
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukv-0004T5-CP
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uBhWvVhBBBJH3HTQWIcFvxknxyvfEJFnfNd9n4dZVo=;
 b=RJnKQoVibGrJ1rvevfsIzVPnX5fVCFk+LVlNSEus02mcMAhciuQfQzUuSy+Yr5DAQkc5IJ
 M1QOC7i4JKXEAJ6GJEcVNSgc3ihojBX92wL2DDha+F1loA373StjRwiT4qzCBLPaHzPbr5
 axkGgruLP/wjyW0vtkxbJaiqTj0s3BI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-txyy_h62OTOaqwUCeSD1hw-1; Wed,
 07 Feb 2024 22:07:13 -0500
X-MC-Unique: txyy_h62OTOaqwUCeSD1hw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0FDC3806710;
 Thu,  8 Feb 2024 03:07:12 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFD8D492BC7;
 Thu,  8 Feb 2024 03:07:09 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 31/34] migration/multifd: Add a synchronization point for
 channel creation
Date: Thu,  8 Feb 2024 11:05:25 +0800
Message-ID: <20240208030528.368214-32-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

It is possible that one of the multifd channels fails to be created at
multifd_new_send_channel_async() while the rest of the channel
creation tasks are still in flight.

This could lead to multifd_save_cleanup() executing the
qemu_thread_join() loop too early and not waiting for the threads
which haven't been created yet, leading to the freeing of resources
that the newly created threads will try to access and crash.

Add a synchronization point after which there will be no attempts at
thread creation and therefore calling multifd_save_cleanup() past that
point will ensure it properly waits for the threads.

A note about performance: Prior to this patch, if a channel took too
long to be established, other channels could finish connecting first
and already start taking load. Now we're bounded by the
slowest-connecting channel.

Reported-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240206215118.6171-7-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3db18dc79e..adfe8c9a0a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -62,6 +62,11 @@ struct {
      * Make it easy for now.
      */
     uintptr_t packet_num;
+    /*
+     * Synchronization point past which no more channels will be
+     * created.
+     */
+    QemuSemaphore channels_created;
     /* send channels ready */
     QemuSemaphore channels_ready;
     /*
@@ -622,10 +627,6 @@ static void multifd_send_terminate_threads(void)
 
     /*
      * Finally recycle all the threads.
-     *
-     * TODO: p->running is still buggy, e.g. we can reach here without the
-     * corresponding multifd_new_send_channel_async() get invoked yet,
-     * then a new thread can even be created after this function returns.
      */
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
@@ -670,6 +671,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
 
 static void multifd_send_cleanup_state(void)
 {
+    qemu_sem_destroy(&multifd_send_state->channels_created);
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
     multifd_send_state->params = NULL;
@@ -954,18 +956,26 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         ret = multifd_tls_channel_connect(p, ioc, &local_err);
+        if (ret) {
+            return;
+        }
     } else {
         ret = multifd_channel_connect(p, ioc, &local_err);
     }
 
+out:
+    /*
+     * Here we're not interested whether creation succeeded, only that
+     * it happened at all.
+     */
+    qemu_sem_post(&multifd_send_state->channels_created);
+
     if (ret) {
         return;
     }
 
-out:
     trace_multifd_new_send_channel_async_error(p->id, local_err);
     multifd_send_set_error(local_err);
-    multifd_send_kick_main(p);
     if (!p->c) {
         /*
          * If no channel has been created, drop the initial
@@ -998,6 +1008,7 @@ bool multifd_send_setup(void)
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     multifd_send_state->pages = multifd_pages_init(page_count);
+    qemu_sem_init(&multifd_send_state->channels_created, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
     qatomic_set(&multifd_send_state->exiting, 0);
     multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
@@ -1023,6 +1034,15 @@ bool multifd_send_setup(void)
         multifd_new_send_channel_create(p);
     }
 
+    /*
+     * Wait until channel creation has started for all channels. The
+     * creation can still fail, but no more channels will be created
+     * past this point.
+     */
+    for (i = 0; i < thread_count; i++) {
+        qemu_sem_wait(&multifd_send_state->channels_created);
+    }
+
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-- 
2.43.0



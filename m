Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3055C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTMf-0000ZO-TY; Tue, 06 Feb 2024 16:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXTLt-0008E8-RH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:39 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXTLr-0008AJ-Ts
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1A3A2213C;
 Tue,  6 Feb 2024 21:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUM92dZhwpqLP/f7G6UsbOnXGfoPf638TfZnQ7vtE9Y=;
 b=sxw9goKZVVi5QQw0PzQPqKeZEuhGjKCmV+iIncTmgstD1VNZ1l383hAth221HzbjwwVRj0
 ZbR2YATewsMjmmeWZ2n+Ha5Ag5wak3+Khk7WKKyhdMjdlWa4D7TsnK+QJBTlme/rlsP143
 t2RjGClIwVhccNWz232fYXHCXZO9I4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUM92dZhwpqLP/f7G6UsbOnXGfoPf638TfZnQ7vtE9Y=;
 b=8hscI3XMVuZPCwHaHNsWVedCXxlUWbaadYUVPjtM4OXXYSiCdt4XnbojTZxS5YC3Gtu4Kw
 sIJ5vVbqPajIXGCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUM92dZhwpqLP/f7G6UsbOnXGfoPf638TfZnQ7vtE9Y=;
 b=sxw9goKZVVi5QQw0PzQPqKeZEuhGjKCmV+iIncTmgstD1VNZ1l383hAth221HzbjwwVRj0
 ZbR2YATewsMjmmeWZ2n+Ha5Ag5wak3+Khk7WKKyhdMjdlWa4D7TsnK+QJBTlme/rlsP143
 t2RjGClIwVhccNWz232fYXHCXZO9I4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256294;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUM92dZhwpqLP/f7G6UsbOnXGfoPf638TfZnQ7vtE9Y=;
 b=8hscI3XMVuZPCwHaHNsWVedCXxlUWbaadYUVPjtM4OXXYSiCdt4XnbojTZxS5YC3Gtu4Kw
 sIJ5vVbqPajIXGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43E78132DD;
 Tue,  6 Feb 2024 21:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QDooA+WpwmWzQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 Feb 2024 21:51:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 6/6] migration/multifd: Add a synchronization point for
 channel creation
Date: Tue,  6 Feb 2024 18:51:18 -0300
Message-Id: <20240206215118.6171-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240206215118.6171-1-farosas@suse.de>
References: <20240206215118.6171-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 migration/multifd.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 339f2428f3..ee77047031 100644
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
2.35.3



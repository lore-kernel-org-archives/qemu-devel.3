Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FF4C4829A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVywx-000212-Dq; Fri, 02 Feb 2024 14:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVywv-000206-A7
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:11:41 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVywt-0001vm-Hk
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:11:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D91922134;
 Fri,  2 Feb 2024 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kl5qNQwTxzOz/0av9OOfER+ITJDQQMvx4JeU3LRyQY4=;
 b=eM3aN3lZ74pfl99zGdmIWwtDj764//8ur9FMJl1OLsjbYR2mSx5ESoDdmmL3/7JLDutwxh
 5EiSy+ioY3KPMbP8BG9H+XNMDLV7tmcmfViycDtOfN6R3xCpLHCYIY0QgqOGceKNdJ6Vvt
 hw6BjW0BLvaMb7IJmvI7SCnM4YXnna0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901097;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kl5qNQwTxzOz/0av9OOfER+ITJDQQMvx4JeU3LRyQY4=;
 b=8f9jml4ztmewpJE5b6Gb7l75sSHAZmcNZTwiJuWqwJe4rrQK8IVvz91rNKTzUz/lPfNyk6
 x2EAK5j0VcTy26Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kl5qNQwTxzOz/0av9OOfER+ITJDQQMvx4JeU3LRyQY4=;
 b=ATeJYyMH2/8t+y+1EGGDvPqrhEM9IVQQDOWdMNWFhgsiYoV71QxvhMgERGVM7SSDbU1gaT
 Eyxamc6cIg1MXSqX0M4opIo/qlL+1bsh3Cr5cf5+kczUGYoL0rzpFYM9eV5mtaLMVZu0Yv
 vaNAu5bMbFQFYJvCJSOKgZN9GCl5tko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kl5qNQwTxzOz/0av9OOfER+ITJDQQMvx4JeU3LRyQY4=;
 b=a+tREucW7VQxMuqmAYVP7lUbVxMItqRziXpyH1DKH2I+jHqxyUgvcB4qfakzF6CXg/mLDF
 uJIS81lSyUTf+1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0918139AB;
 Fri,  2 Feb 2024 19:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SKN/IWY+vWWlZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 19:11:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 chenyuhui5@huawei.com
Subject: [PATCH 2/5] migration/multifd: Remove p->running
Date: Fri,  2 Feb 2024 16:11:25 -0300
Message-Id: <20240202191128.1901-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240202191128.1901-1-farosas@suse.de>
References: <20240202191128.1901-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,nvidia.com:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

We currently only need p->running to avoid calling qemu_thread_join()
on a non existent thread if the thread has never been created.

However, there are at least two bugs in this logic:

1) On the sending side, p->running is set too early and
qemu_thread_create() can be skipped due to an error during TLS
handshake, leaving the flag set and leading to a crash when
multifd_save_cleanup() calls qemu_thread_join().

2) During exit, the multifd thread clears the flag while holding the
channel lock. The counterpart at multifd_save_cleanup() reads the flag
outside of the lock and might free the mutex while the multifd thread
still has it locked.

Fix the first issue by setting the flag right before creating the
thread. Rename it from p->running to p->thread_created to clarify its
usage.

Fix the second issue by not clearing the flag at the multifd thread
exit. We don't have any use for that.

Note that these bugs are straight-forward logic issues and not race
conditions. There is still a gap for races to affect this code due to
multifd_save_cleanup() being allowed to run concurrently with the
thread creation loop. This issue is solved in the next patch.

Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
Reported-by: Avihai Horon <avihaih@nvidia.com>
Reported-by: <chenyuhui5@huawei.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 30 ++++++++++++------------------
 migration/multifd.h |  7 ++-----
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b557d046a9..402b7fd776 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -528,7 +528,7 @@ void multifd_save_cleanup(void)
             qemu_thread_join(&p->tls_thread);
         }
 
-        if (p->running) {
+        if (p->thread_created) {
             qemu_thread_join(&p->thread);
         }
     }
@@ -759,10 +759,6 @@ out:
         error_free(local_err);
     }
 
-    qemu_mutex_lock(&p->mutex);
-    p->running = false;
-    qemu_mutex_unlock(&p->mutex);
-
     rcu_unregister_thread();
     migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
@@ -859,6 +855,8 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     migration_ioc_register_yank(ioc);
     p->registered_yank = true;
     p->c = ioc;
+
+    p->thread_created = true;
     qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                        QEMU_THREAD_JOINABLE);
     return true;
@@ -890,7 +888,6 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     trace_multifd_new_send_channel_async(p->id);
     if (!qio_task_propagate_error(task, &local_err)) {
         qio_channel_set_delay(ioc, false);
-        p->running = true;
         if (multifd_channel_connect(p, ioc, &local_err)) {
             return;
         }
@@ -1030,15 +1027,15 @@ void multifd_load_cleanup(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        if (p->running) {
-            /*
-             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
-             * however try to wakeup it without harm in cleanup phase.
-             */
-            qemu_sem_post(&p->sem_sync);
-        }
+        /*
+         * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
+         * however try to wakeup it without harm in cleanup phase.
+         */
+        qemu_sem_post(&p->sem_sync);
 
-        qemu_thread_join(&p->thread);
+        if (p->thread_created) {
+            qemu_thread_join(&p->thread);
+        }
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
@@ -1148,9 +1145,6 @@ static void *multifd_recv_thread(void *opaque)
         multifd_recv_terminate_threads(local_err);
         error_free(local_err);
     }
-    qemu_mutex_lock(&p->mutex);
-    p->running = false;
-    qemu_mutex_unlock(&p->mutex);
 
     rcu_unregister_thread();
     trace_multifd_recv_thread_end(p->id, p->num_packets, p->total_normal_pages);
@@ -1258,7 +1252,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     /* initial packet */
     p->num_packets = 1;
 
-    p->running = true;
+    p->thread_created = true;
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     qatomic_inc(&multifd_recv_state->count);
diff --git a/migration/multifd.h b/migration/multifd.h
index 5a69ef40e2..917833c309 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -73,6 +73,7 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    bool thread_created;
     QemuThread tls_thread;
     bool tls_thread_created;
     /* communication channel */
@@ -95,8 +96,6 @@ typedef struct {
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
-    /* is this channel thread running */
-    bool running;
     /* should this thread finish */
     bool quit;
     /* multifd flags for each packet */
@@ -144,6 +143,7 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    bool thread_created;
     /* communication channel */
     QIOChannel *c;
     /* packet allocated len */
@@ -158,8 +158,6 @@ typedef struct {
 
     /* this mutex protects the following parameters */
     QemuMutex mutex;
-    /* is this channel thread running */
-    bool running;
     /* should this thread finish */
     bool quit;
     /* multifd flags for each packet */
@@ -209,4 +207,3 @@ typedef struct {
 void multifd_register_ops(int method, MultiFDMethods *ops);
 
 #endif
-
-- 
2.35.3



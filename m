Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B33C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZnf-00008O-Ql; Thu, 01 Aug 2024 13:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sZZnc-0008OJ-Cc; Thu, 01 Aug 2024 13:41:13 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sZZna-0006y3-LL; Thu, 01 Aug 2024 13:41:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 908281FB65;
 Thu,  1 Aug 2024 17:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722534068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mq2Zj/WChyurbuLfP7yHleS3Cabr5H9oZGAzrepfXNs=;
 b=Y4fq+Jgkt+BgKlIcU76ZCMcMLHc3QI0HD9H/M0H9ZZUbNCvB3Y6o8/rfOLvwCUz6iuM7DC
 AuXRa4nrfw+nJTIzqdSJVKcKi/bEsRk0cTT5EoMACBfk/O5be/R7LhkeFT2HXMVbbhIemt
 s0+VFYHTBvhR8ya0BiFs6iG9s5+N9Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722534068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mq2Zj/WChyurbuLfP7yHleS3Cabr5H9oZGAzrepfXNs=;
 b=T2Wgz/zj4Zz6WNC11o0dktUUB9sPYhlQSUjQEePG2eBJXE0AQNkdzKB49NJd+gvCy61+Ly
 DOXO1tof4pR8ucDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722534068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mq2Zj/WChyurbuLfP7yHleS3Cabr5H9oZGAzrepfXNs=;
 b=Y4fq+Jgkt+BgKlIcU76ZCMcMLHc3QI0HD9H/M0H9ZZUbNCvB3Y6o8/rfOLvwCUz6iuM7DC
 AuXRa4nrfw+nJTIzqdSJVKcKi/bEsRk0cTT5EoMACBfk/O5be/R7LhkeFT2HXMVbbhIemt
 s0+VFYHTBvhR8ya0BiFs6iG9s5+N9Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722534068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mq2Zj/WChyurbuLfP7yHleS3Cabr5H9oZGAzrepfXNs=;
 b=T2Wgz/zj4Zz6WNC11o0dktUUB9sPYhlQSUjQEePG2eBJXE0AQNkdzKB49NJd+gvCy61+Ly
 DOXO1tof4pR8ucDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E69D136CF;
 Thu,  1 Aug 2024 17:41:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cGooObLIq2brOQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 17:41:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-stable@nongnu.org,
 Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH 2/2] migration/multifd: Fix multifd_send_setup cleanup when
 channel creation fails
Date: Thu,  1 Aug 2024 14:41:01 -0300
Message-Id: <20240801174101.31806-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240801174101.31806-1-farosas@suse.de>
References: <20240801174101.31806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When a channel fails to create, the code currently just returns. This
is wrong for two reasons:

1) Channel n+1 will not get to initialize it's semaphores, leading to
   an assert when terminate_threads tries to post to it:

 qemu-system-x86_64: ../util/qemu-thread-posix.c:92:
 qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.

2) (theoretical) If channel n-1 already started creation it will
   defeat the purpose of the channels_created logic which is in place
   to avoid migrate_fd_cleanup() to run while channels are still being
   created.

   This cannot really happen today because the current failure cases
   for multifd_new_send_channel_create() are all synchronous,
   resulting from qio_channel_file_new_path() getting a bad
   filename. This would hit all channels equally.

   But I don't want to set a trap for future people, so have all
   channels try to create (even if failing), and only fail after the
   channels_created semaphore has been posted.

While here, remove the error_report_err call. There's one already at
migrate_fd_cleanup later on.

Cc: qemu-stable@nongnu.org
Reported-by: Jim Fehlig <jfehlig@suse.com>
Fixes: bd8b0a8f82 ("migration/multifd: Move multifd_send_setup error handling in to the function")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0b4cbaddfe..552f9723c8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1156,7 +1156,6 @@ static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
 bool multifd_send_setup(void)
 {
     MigrationState *s = migrate_get_current();
-    Error *local_err = NULL;
     int thread_count, ret = 0;
     uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
     bool use_packets = multifd_use_packets();
@@ -1177,6 +1176,7 @@ bool multifd_send_setup(void)
 
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
+        Error *local_err = NULL;
 
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
@@ -1196,7 +1196,8 @@ bool multifd_send_setup(void)
         p->write_flags = 0;
 
         if (!multifd_new_send_channel_create(p, &local_err)) {
-            return false;
+            migrate_set_error(s, local_err);
+            ret = -1;
         }
     }
 
@@ -1209,24 +1210,27 @@ bool multifd_send_setup(void)
         qemu_sem_wait(&multifd_send_state->channels_created);
     }
 
+    if (ret) {
+        goto err;
+    }
+
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
+        Error *local_err = NULL;
 
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
-            break;
+            migrate_set_error(s, local_err);
+            goto err;
         }
     }
 
-    if (ret) {
-        migrate_set_error(s, local_err);
-        error_report_err(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
-        return false;
-    }
-
     return true;
+
+err:
+    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                      MIGRATION_STATUS_FAILED);
+    return false;
 }
 
 bool multifd_recv(void)
-- 
2.35.3


